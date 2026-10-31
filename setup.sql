-- SMA ART GALLERY DATABASE SETUP
-- Run once in Supabase SQL Editor. Then create your admin user in Authentication.
create table if not exists public.artworks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Metal Art',
  description text not null default '',
  image_urls text[] not null default '{}',
  created_at timestamptz not null default now()
);
create table if not exists public.sma_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
create or replace function public.is_sma_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.sma_admins where user_id = auth.uid()); $$;
alter table public.artworks enable row level security;
alter table public.sma_admins enable row level security;
drop policy if exists "Public can read artworks" on public.artworks;
create policy "Public can read artworks" on public.artworks for select using (true);
drop policy if exists "SMA admins can insert artworks" on public.artworks;
create policy "SMA admins can insert artworks" on public.artworks for insert with check (public.is_sma_admin());
drop policy if exists "SMA admins can update artworks" on public.artworks;
create policy "SMA admins can update artworks" on public.artworks for update using (public.is_sma_admin()) with check (public.is_sma_admin());
drop policy if exists "SMA admins can delete artworks" on public.artworks;
create policy "SMA admins can delete artworks" on public.artworks for delete using (public.is_sma_admin());
-- Admin users can read only their own allowlist row.
drop policy if exists "Admins can read own admin row" on public.sma_admins;
create policy "Admins can read own admin row" on public.sma_admins for select using (auth.uid() = user_id);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('sma-artworks','sma-artworks',true,5242880,array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true, file_size_limit = 5242880, allowed_mime_types = array['image/jpeg','image/png','image/webp','image/gif'];
drop policy if exists "Public can view SMA artwork photos" on storage.objects;
create policy "Public can view SMA artwork photos" on storage.objects for select using (bucket_id = 'sma-artworks');
drop policy if exists "SMA admins can upload artwork photos" on storage.objects;
create policy "SMA admins can upload artwork photos" on storage.objects for insert with check (bucket_id = 'sma-artworks' and public.is_sma_admin());
drop policy if exists "SMA admins can update artwork photos" on storage.objects;
create policy "SMA admins can update artwork photos" on storage.objects for update using (bucket_id = 'sma-artworks' and public.is_sma_admin()) with check (bucket_id = 'sma-artworks' and public.is_sma_admin());
drop policy if exists "SMA admins can delete artwork photos" on storage.objects;
create policy "SMA admins can delete artwork photos" on storage.objects for delete using (bucket_id = 'sma-artworks' and public.is_sma_admin());
-- After creating your Supabase Auth user, replace UUID below with that user's ID and run:
-- insert into public.sma_admins (user_id) values ('YOUR-AUTH-USER-UUID');
