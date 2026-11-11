Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435132;
	b=PbunCwM/6qcy0rpN8F+TK+zUKQYu3GjCOqWXkNIpeqXDf1wrCp+9EqyK4n0nM1ybeHU4
	 jy55id9qXXIkBhwsEULeC4siObdjaanWZIQTh3bpYqxWQLfkYZjnVNzTJfdPWvLDffPOk
	 SKCW5UvcDgBFAc2PslcqArwk17ElwtTtdSa7D9v++wrRIi8h2Yl8BlqaxAiI+wmK5AigB
	 jEPgyunoC8sv+nDmFPn0SyMLAvNUskI2NQ6istF3mu5wOgIHDtTBWS9m5RXQQCZdW+tRt
	 kknJGV8Je2FBTEtqaUaPL0r3kQpjkAj94OFhsHXphTxVdToS14VpbPxSFbBdgdrSLiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435132;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	b=akrcSOZ+WdrluTjKLo0D9ofCQrFklC5mITwnRWrkUThkT6HUlN314QV1rGDcTP/1mK57
	 1r7aH75T2RMWewxCAiVuflQpIp+J7s/kjIzcBNlJ2WpIxX3SmBpG/n7iBJRW+pClS8xmB
	 uVe320BCQknpDpvFiJ3Fnjweb4w9jzKuyyu3TL9MZEiPxcc/rmYmwISyjVEWVkPzf1hmv
	 YBk54spkhkKQxLJT/0lAW98wey9XZntrb3wAPnY5DIBguOLyhG6f2wwM3Q1zXSTMOlH8G
	 xw4VupPAw5qcOVk+qxCxzjcZNlK85sFsifVhn+LKHlhv05kb6U83s29pQn/Ei3UxuhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtPj7j4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EB606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtPj7j4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5E51F00A06;
	Wed, 11 Nov 2026 22:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435132;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtPj7j4Psimqti6/xGiGh5TQTkwBE1kSPeObTtnGvVjIy8V9aGraO6wBcClRYXk1C
	 wKifGB3fsxvR9Ho399CWGu6PaHFnAeUbVnPI8Aw8vG0QldmPvxUCUIrCl7rrzLBf0d
	 zxilndnxnGEKr4P47Tymmbxad0bTg7y/Jn/AzjAcMEW9wa8lsXzgXp7cw7V+k5fpGJ
	 BddKIFzp5WtaaSHL4NDCcXNo8GL1OxN/V9t4jTWBjv/K2A4A9gLKcXqyuDAl1B5UnQ
	 /vhx2DpUPjHVdtZ7AnJd562kDpbyZSgCcW0tP/EH+RhwB0hHj5Yq/yQSSQ3cQBPOzA
	 qYzV5LqIb+uXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] selftests/core: fix unshare_test with large fs.nr_open
Date: Wed, 11 Nov 2026 17:12:09 -0500
Message-ID: <20261111221154.4123375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111221154.4123375-1-sashal@kernel.org>
References: <20261107060233-failed-5.15-df0b7e0ea59c@kernel.org>
 <20261111221154.4123375-1-sashal@kernel.org>
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

