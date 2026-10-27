-- Supabase Dashboard > SQL Editor me ye poora paste karke RUN karo

create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  title text not null,
  file_path text not null,
  file_name text not null,
  otp text,
  otp_expires timestamptz,
  attempts int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.documents enable row level security;

-- Sirf login kiya hua admin table dekh/badal sakta hai
drop policy if exists "admin all" on public.documents;
create policy "admin all" on public.documents
  for all to authenticated using (true) with check (true);

-- Client ko sirf title dikhta hai (link valid hai ya nahi check karne ke liye)
create or replace function public.doc_title(p_code text)
returns text language sql security definer set search_path = public as $$
  select title from documents where code = p_code
$$;

-- OTP check: sahi hone par hi file ka path milta hai. 5 galat try ke baad OTP band.
create or replace function public.verify_otp(p_code text, p_otp text)
returns table(f_path text, f_name text, f_title text)
language plpgsql security definer set search_path = public as $$
declare d documents%rowtype;
begin
  select * into d from documents where code = p_code for update;
  if not found then return; end if;
  if d.otp is null or d.otp_expires is null or d.otp_expires < now() or d.attempts >= 5 then
    return;
  end if;
  if d.otp <> trim(p_otp) then
    update documents set attempts = attempts + 1 where id = d.id;
    return;
  end if;
  update documents set otp = null, otp_expires = null, attempts = 0 where id = d.id;
  return query select d.file_path, d.file_name, d.title;
end $$;

revoke all on function public.doc_title(text) from public;
revoke all on function public.verify_otp(text, text) from public;
grant execute on function public.doc_title(text) to anon, authenticated;
grant execute on function public.verify_otp(text, text) to anon, authenticated;

-- Files ka storage
insert into storage.buckets (id, name, public)
values ('docs', 'docs', true)
on conflict (id) do nothing;

drop policy if exists "admin select" on storage.objects;
drop policy if exists "admin insert" on storage.objects;
drop policy if exists "admin update" on storage.objects;
drop policy if exists "admin delete" on storage.objects;
create policy "admin select" on storage.objects for select to authenticated using (bucket_id = 'docs');
create policy "admin insert" on storage.objects for insert to authenticated with check (bucket_id = 'docs');
create policy "admin update" on storage.objects for update to authenticated using (bucket_id = 'docs');
create policy "admin delete" on storage.objects for delete to authenticated using (bucket_id = 'docs');
