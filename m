Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5828471253;
	Sun, 11 Oct 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758073; cv=none; b=CJ78EimROyDBzT/RaRx8NU6Ohz8q4WAqx9tS1rjyi6nFgh5tMQ9ivqWETPGPYt6Q4lIbwXu4uGkc1R90XDTzHuifI5tHy4j/I7csXr556AqPRs0VHDYR6u7ncxIbJhvwj7A4FDBNfeDs16baO6uZLdOF9NE+eV2v/sIEJbVcU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758073; c=relaxed/simple;
	bh=HjbhNZKTNEfry6nFZuw8yjg4ZUSYdhYCfR1s7GACbzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt7Pmygre8QLUwXUbiMX+eugwiPBHCLrWRuLaCopuDh+rtnppcXKVJDhzWfFF6FlewhIfnDts5tF49sAbMgzXDT5Nd9QFFw1O6w6uqDCkbxu7ySYYCj3VA0cP8Xsnb/9OP08LdxDJYfKGRu+8kALtLpNinCXGmbsB4VeOiyEyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+iU+v9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+iU+v9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41031F0089C;
	Sun, 11 Oct 2026 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758072;
	bh=I32UsrHMclp8kkpr05gv4XiqeAMPX5cpmoo54oWzWug=;
	h=From:To:Cc:Subject:Date;
	b=F+iU+v9yW3FYic0hzLq0lFmKTdceC2mYMhSgnUXAnkb4NtyfCXdtEz3Zx7/Um2C7z
	 /HHXFGbAtVc7vM3bmeQQ+1K/Tvp2vLH0AoIEhN/Fva4Sr2HCKkEaltzw58CQQBClf/
	 ox7Y5UMhnPZe013Begdemn0Dq18GNaK9TlDwOdbhvhVeL1piVWMZ5jIxdeehhDBSIo
	 4CkWScXdc3nYq3mbEwB7k3gjMiuMi8A0+hupz0buPT+gfSRv2r7P4HGiMZN/dj/HYc
	 DBuR5RQbl3jwVzgXtlpq/EsbJtMwdPXi/fIVUJvWPsBqMowdK8WVISCH73oFkxYmDO
	 Rk0ES0k1goTDQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: prctl: don't fail to build when cross compiling
Date: Sun, 11 Oct 2026 18:33:44 -0400
Message-ID: <20261011223358.2327625-16-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prctl Makefile includes lib.mk only for native x86 builds. With
CROSS_COMPILE set, or for other architectures, it defines no targets at
all, and since prctl is in the default selftests TARGETS, the build
fails:

  make: *** No targets.  Stop.

Include lib.mk unconditionally, so that those builds have nothing to do
instead of failing. Native x86 builds are unchanged.

Fixes: 5290586186d24 ("selftests: prctl: Add new prctl test for PR_SET_VMA action")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/prctl/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index e770e86fad9ac..c321bd60740cb 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -7,8 +7,7 @@ ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
 		disable-tsc-test set-anon-vma-name-test set-process-name
 all: $(TEST_PROGS)
-
-include ../lib.mk
-
 endif
 endif
+
+include ../lib.mk
-- 
2.53.0

