Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434806;
	b=NKCmftBF4yUCUl9lEBsgmD5yPku8S/pKNqJHr6t3hbpgyKJbBwtywZa/HJTLuynQUVmq
	 HKF4k/He6IOoBQuXo+JOdts0lmLKl/IXgDlhFLpmcNJr2oBwZ2pKRe4BEAOw49tDvY7vN
	 caDaOrAa5pkek+3ioe3NUsqcMjNiWP/AUzFB/pYrtbP3BhmulMCZXzkgisLILoOrOkaD0
	 myqoKY/ouq9seKEGjow+i5Pt77Cl+YxQWgM6ZefK3E3xK2MqJQHI6/FWq8FPP+0lp+U2r
	 XeELqByAxbQCzX6KJeOEUej5Kt1mU2+Uw4XSt75WbaKfkEuqvQ8Plp3mzX5sQNx3YXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	b=dP4N+YxrORUzAAErdl5SI3IS9ucvGAQQgGmi16GW0iQ6lf30GhKJLed5EgKMyOVhaOT7
	 v84g+50WIqR/qK/d0YFrEtteAZAz+3WCmk+B+zXUtN9sGqCFQwfXPp4nDJBT9ZFxyD4iy
	 bIL44Qy87k6J7kKLgLZKaL7dyP3GxefSApFlHvnv4g1l0PEIhg2e2dI5PsqMVw3BJjATG
	 C0zlg45e7hRxoo7fv7neHbmAhz5UweHFV01DXsCGQY7Ex63qMPdahhEsL4CPLcyzUTVmf
	 Atm1oAk3PHQpTTVmttnmfd/WS2uZpO3sIUYvGzBqMJiGGUdvL47GQ/LCPrgu4CNbAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th3NVFqJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C47606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th3NVFqJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F141F00A08;
	Wed, 11 Nov 2026 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434806;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Th3NVFqJrOjvo/+vsEMje7t1IqOaWSM46wpjpIT8Ml8qK/g1y3KVAQR3noXTokQJ0
	 0N/vT+vJC+EFdNe2MYvgaY2KlEQb/Be/Cp1LR8oFrf6rhtJ3bTlMPfVaeAA1Qa/GZ0
	 orbnUxEDOq4wT81g7TTccSYKiTLma749nzrhdHXh3HbMJzvUJE3f1qSK2VBnPzqsC9
	 SXzEWO3NNYsv7kqUWVrZPp7oqATI7kOcvAE1CGENFCdL5P4I69UlpludJo0Ci4xn4c
	 DoBUQp+p9KkMjBOEKf7pATL0hldhwX7wSU2f8JFhFHfRLIBO7Gw63aGMfpVLM+T5yQ
	 WXqQx/2QbEjnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] selftests/core: fix unshare_test with large fs.nr_open
Date: Wed, 11 Nov 2026 17:06:44 -0500
Message-ID: <20261111220634.4105723-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220634.4105723-1-sashal@kernel.org>
References: <20261107054501-failed-6.1-df0b7e0ea59c@kernel.org>
 <20261111220634.4105723-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Khorenko <khorenko@virtuozzo.com>

[ Upstream commit df0b7e0ea59c43708cff8c7e34da5e2f8d430e5e ]

The test assumes fs.nr_open is close to the default 1048576, but some
systems set it much higher (e.g.  1073741816).  This is systemd's doing:
since systemd v240 (2018), PID 1 bumps fs.nr_open and fs.file-max to their
largest possible values on boot, as file descriptors are already accounted
for by memcg [1].

In that case, dup2() to nr_open + 64 requires the kernel to allocate a
file descriptor table with ~1 billion entries, which fails with ENOMEM.

On a kernel that already carries 04a2c4b4511d1, dup2() no longer fails
with ENOMEM.  The allocation is now rejected up front and the caller
gets EMFILE instead, without the WARNING, but the test still fails.

Cap the nr_open value used for the test's own arithmetic to a known
reasonable base value (1048576) and restore the true original value once
the test has completed.

Link: https://lore.kernel.org/20260814165709.513263-1-khorenko@virtuozzo.com
Link: https://github.com/systemd/systemd/commit/a8b627aaed409a15260c25988970c795bf963812 [1]
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/core/unshare_test.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index 7fec9dfb1b0e3..6716e0f74d7da 100644
--- a/tools/testing/selftests/core/unshare_test.c
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -40,6 +40,14 @@ TEST(unshare_EMFILE)
 
 	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
 
+	/*
+	 * Cap nr_open for the duration of the test to avoid ENOMEM from a
+	 * huge fd table allocation; buf/n keep the real original value so
+	 * fs.nr_open can be restored to it once the test is done.
+	 */
+	if (nr_open > 1024 * 1024)
+		nr_open = 1024 * 1024;
+
 	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
 
 	/* bump fs.nr_open */
@@ -73,10 +81,13 @@ TEST(unshare_EMFILE)
 
 	if (pid == 0) {
 		int err;
+		char buf3[32];
+		ssize_t n3;
 
-		/* restore fs.nr_open */
+		/* restore fs.nr_open to the (possibly capped) test baseline */
+		n3 = sprintf(buf3, "%d\n", nr_open);
 		lseek(fd, 0, SEEK_SET);
-		write(fd, buf, n);
+		write(fd, buf3, n3);
 		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
 		err = unshare(CLONE_FILES);
 		EXPECT_EQ(err, -1)
@@ -89,6 +100,10 @@ TEST(unshare_EMFILE)
 	EXPECT_EQ(waitpid(pid, &status, 0), pid);
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* restore the real fs.nr_open value */
+	lseek(fd, 0, SEEK_SET);
+	write(fd, buf, n);
 }
 
 TEST_HARNESS_MAIN
-- 
2.53.0

