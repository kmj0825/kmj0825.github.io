# 블로그 워크플로우 가이드

> 여러 기기(윈도우, 회사 맥, 개인 맥)에서 블로그 글을 작성하고 동기화하는 방법

## 🎯 최종 워크플로우 요약

1. **글 작성**: Obsidian에서 작성 (모든 기기에서 자동 동기화)
2. **Claude 활용**: 로컬 Obsidian Vault 폴더를 Claude Code로 열어서 편집/검토
3. **배포**: Git으로 자동 push (계정 자동 전환)

**비용**: 완전 무료! (Obsidian Sync 불필요)

---

## 📦 필요한 도구

- ✅ **Obsidian** (무료) - 마크다운 에디터
- ✅ **Git** - 버전 관리 및 배포
- ✅ **Claude Code** - AI 편집 도우미

---

## 🔧 초기 설정 (각 기기에서 한 번만)

### 1️⃣ Git 계정 자동 전환 설정

**회사 맥, 개인 맥, 윈도우 모두에서 실행:**

```bash
cd ~/kmj0825.github.io
bash setup-personal-git.sh
```

이제 이 repo에서는 **자동으로 개인 계정**을 사용합니다!
다른 회사 프로젝트는 회사 계정을 그대로 사용합니다.

### 2️⃣ SSH Key 설정 (선택사항, 더 편하게 하려면)

**개인/회사 SSH Key 자동 전환:**

`~/.ssh/config` 파일에 추가:

```
# 개인 GitHub
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_personal

# 회사 GitHub
Host github.com-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_work
```

그리고 이 repo의 remote URL 변경:

```bash
cd ~/kmj0825.github.io
git remote set-url origin git@github.com-personal:kmj0825/kmj0825.github.io.git
```

### 3️⃣ Obsidian 설정

**모든 기기에서:**

1. [Obsidian 다운로드](https://obsidian.md/) 및 설치

2. 이 Git repo 폴더를 Obsidian Vault로 열기:
   - Obsidian 실행 → "Open folder as vault"
   - `~/kmj0825.github.io` 선택

3. **Obsidian Git 플러그인 설치** (무료):
   - Settings → Community plugins → Browse
   - "Obsidian Git" 검색 및 설치
   - Enable 활성화

4. **Obsidian Git 설정**:
   - Settings → Obsidian Git
   - `Vault backup interval (minutes)`: `5` (5분마다 자동 백업)
   - `Auto pull on startup`: `ON` (시작 시 자동 pull)
   - `Auto push on backup`: `ON` (백업 시 자동 push)

---

## 🚀 일상적인 사용법

### 글 작성하기

1. **어떤 기기에서든** Obsidian 열기
2. 자동으로 최신 내용 pull됨
3. `_posts/` 폴더에서 새 파일 생성:
   ```
   2025-01-23-my-new-post.md
   ```

4. Jekyll frontmatter와 함께 작성:
   ```markdown
   ---
   layout: post
   title: "내 새로운 글"
   date: 2025-01-23 10:00:00 +0900
   categories: tech
   ---

   # 본문 내용
   ```

5. 저장하면 **5분 후 자동으로 commit & push**
   (또는 Ctrl/Cmd + P → "Obsidian Git: Commit and push" 즉시 실행)

6. GitHub Pages 자동 빌드!

### Claude Code 활용하기

```bash
# 로컬에서
cd ~/kmj0825.github.io
claude
```

Claude에게 요청:
- "이 글 퇴고해줘"
- "SEO를 위한 메타 설명 추가해줘"
- "코드 예시를 더 명확하게 수정해줘"

Claude가 `_posts/` 폴더의 마크다운 파일을 직접 편집합니다.

---

## 🔄 동기화 과정

```
회사 맥에서 글 작성
    ↓
Obsidian Git이 자동 push
    ↓
GitHub repo 업데이트
    ↓
집에서 Obsidian 열면 자동 pull
    ↓
동일한 내용!
```

**실시간 동기화는 아니지만**:
- 5분마다 자동 백업
- 열 때마다 자동 pull
- 수동으로 즉시 동기화 가능

---

## 💡 팁

### 충돌 방지

- 한 기기에서 작업 완료 후 다른 기기로 넘어가기
- 또는 수동으로 "Commit and push" 실행 후 이동

### 초안 관리

`_drafts/` 폴더 사용:
```
_drafts/
  └── work-in-progress.md  (아직 배포 안 됨)

_posts/
  └── 2025-01-23-published.md  (배포됨)
```

### Claude와 협업

1. Obsidian에서 초안 작성
2. Claude Code로 퇴고/수정
3. Obsidian Git으로 자동 배포

---

## 🆚 Obsidian Sync와 비교

| 기능 | Obsidian + Git (무료) | Obsidian Sync ($10/월) |
|------|----------------------|----------------------|
| 여러 기기 동기화 | ✅ (Git) | ✅ (실시간) |
| Claude Code 접근 | ✅ | ✅ |
| GitHub Pages 배포 | ✅ (자동) | ❌ (별도 Git 필요) |
| 버전 관리 | ✅ (Git) | ✅ (Sync) |
| 비용 | **무료** | $10/월 |
| 동기화 속도 | 5분 (설정 가능) | 즉시 |

**결론**: GitHub Pages 블로그 용도로는 **Git이 더 나음** (어차피 배포에 필요)

---

## ❓ 문제 해결

### "Permission denied" 에러

→ SSH Key 설정 확인 또는 HTTPS 사용:
```bash
git remote set-url origin https://github.com/kmj0825/kmj0825.github.io.git
```

### "Author identity unknown" 에러

→ `setup-personal-git.sh` 다시 실행

### Obsidian Git이 동작 안 함

→ Settings → Obsidian Git → "Disable on this device" OFF 확인

---

## 🎓 참고 자료

- [Obsidian Git 플러그인 문서](https://github.com/denolehov/obsidian-git)
- [Jekyll 문서](https://jekyllrb.com/docs/)
- [Git 계정 여러 개 사용하기](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)
