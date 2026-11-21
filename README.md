# 월말 목욕탕

디지털마케팅 기획 시안 · 금융앱 연계 인터페이스 (○○뱅크는 가상 앱)

- `index.html` — 인터페이스 전체 (한 파일)
- `supabase/setup.sql` — 방문자 수 카운터용 테이블·함수
- `.github/workflows/pages.yml` — main에 push하면 GitHub Pages로 자동 배포

## 방문자 수 설정
1. Supabase 프로젝트 → SQL Editor에서 `supabase/setup.sql` 실행
2. Settings → API의 **Project URL**, **anon public key**를 `index.html` 맨 위 `SUPABASE_URL`, `SUPABASE_ANON_KEY`에 붙여넣기
3. 같은 브라우저 탭에서 새로고침하면 숫자는 유지되고, 새로 방문할 때만 +1
