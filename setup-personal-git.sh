#!/bin/bash
# 개인 블로그 repo에서 개인 Git 계정 자동 사용 설정

echo "🔧 개인 Git 계정 설정 중..."

# 이 repo에서만 개인 계정 사용
git config user.name "kmj0825"
git config user.email "raphael825@naver.com"

# 설정 확인
echo ""
echo "✅ 설정 완료!"
echo "📧 이메일: $(git config user.email)"
echo "👤 이름: $(git config user.name)"
echo ""
echo "이제 이 repo에서는 자동으로 개인 계정을 사용합니다."
echo "다른 프로젝트는 회사 계정을 그대로 사용합니다."
