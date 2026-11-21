-- 월말 목욕탕 방문자 수 카운터 (Supabase에 적용 완료된 내용과 동일)
create table if not exists public.site_visits (
  id   text primary key,
  count bigint not null default 0
);
insert into public.site_visits (id, count) values ('wolmal-bath', 0)
on conflict (id) do nothing;

-- 테이블은 직접 읽기/쓰기 막고, 아래 두 함수로만 접근
alter table public.site_visits enable row level security;
revoke select, insert, update, delete on public.site_visits from anon, authenticated;

-- +1 하고 새 숫자 돌려주기 (이 페이지 한 줄만 올릴 수 있음)
create or replace function public.increment_visits(page text default 'wolmal-bath')
returns bigint language sql security definer set search_path = public as $$
  update site_visits set count = count + 1 where id = 'wolmal-bath' and page = 'wolmal-bath'
  returning count;
$$;

-- 현재 숫자만 읽기
create or replace function public.get_visits(page text default 'wolmal-bath')
returns bigint language sql security definer set search_path = public as $$
  select coalesce((select count from site_visits where id = page), 0);
$$;

revoke all on function public.increment_visits(text) from public;
revoke all on function public.get_visits(text) from public;
grant execute on function public.increment_visits(text) to anon, authenticated;
grant execute on function public.get_visits(text) to anon, authenticated;
