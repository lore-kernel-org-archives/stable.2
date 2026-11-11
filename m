Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434452;
	b=yLuv/E/FFL72EGjLtAeQCIr/LoG252VK6jhn964It3gTEPZXpB3xR6Mfh1swxcoa4fDN
	 4Frk6LwUB5vC7bGrrRd0iHj3EBTaKpU0gXsScbgaUnOlPdm/KWxDQ3uwxXgCZNWx6++bN
	 QVXVOaQxMiAHfT/dUANv6Z1p8up5viYNZUN10QU6TcSaxGVkaYed3Eu47qFN9aiuiKFQU
	 FCDS0biio3GlgZD6HVR/F+fOE9e9gU003lE/EUl7FX9+QXAbV9KxbRfXwkLVP9Ju+gpz0
	 OJ20b4m2lWk5Kw1XAIdfv3nO3KU+BuIP0lIGc+W6cMtGBCii8Ujd0NzSeUIHoHUJXrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	b=2bBEPHccwWd8BRmSSSrJmHmScUiuvsSpGV6xRp2g+rXstiN7gQtZuemaudoqWMPPsqfh
	 eN8HsjFlWacD4uWj4mj5M9JSe+ZtbupP5nmdiH31hA/d7QmRMaQfD1XpTsKA6pDMUirYu
	 HMt/DeY+kgYL484WOy3uPmTPcqi+ThJSxq2U56PK4jzet1Pt3f7EVi3eCvLzqjZ1B8Ru1
	 WhxGscxk8/ItM4r8M4DmOJQoEiefbvNKmAfDP681XnbHufxtIS20fdj6rRhqthOYIV2gJ
	 fiRlsWDC0O11QciwLvU/SXILPbsOra11hsn0d1XuOitBROoRXErifLCbZKU10SMWIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyslKK+H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBB606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyslKK+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D8A1F00A06;
	Wed, 11 Nov 2026 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434452;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VyslKK+Hk5US9hvP0YICsZp/v7G2+69MV/zrnMy4czM4Zac1XX18o9Ymax63VGAEO
	 c1kyAZfzL5y2/wUz77kq1tKm69FxSPDNMymQsjICeDRxPz49oQNKsUeaZFcAq7CtFi
	 /TIvTj4Dtj+vB+ibNHmwu57semjnJknVn8g5u9zVdMiDj8Tb19oVsbIuZMmgOeO6rK
	 udM3zXL6sJEsVcvTTRa5gzKAlB5PvaX03jay27o6V2ex5FUulWmZ0zI4Z+CIoyFem+
	 PkOnqpdxBv2k4NUUdM83w06ZdiddEsy8FiE6FoPu0V5PT4pcu/vqSsBYSPQX37y07J
	 c4JGRsxhcbvTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] selftests/core: fix unshare_test with large fs.nr_open
Date: Wed, 11 Nov 2026 17:00:49 -0500
Message-ID: <20261111220033.4083453-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220033.4083453-1-sashal@kernel.org>
References: <20261107053213-failed-6.6-df0b7e0ea59c@kernel.org>
 <20261111220033.4083453-1-sashal@kernel.org>
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

