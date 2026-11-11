Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435751;
	b=OGRamlEEAQTCPLU/tg68zhb95bhzKXFulhALudFqc1VJzsPImTyVAM3HD8DAWtRctPpz
	 Vad+exsUDLe6j1fXhhXl8Xydw9D6JIcqETy7wpVhv55BFixnqxo5Wj0mKfUvM+iBd+qrx
	 ut+Z50GAHnCPyV6j/JxpERPe2DcyQwhN1N18lzclmc2zu9DDJbJrhZL0OToR79QPciqIS
	 l44fV8QnOuibkCYVLzTuiyHopHC3YEDIAv7hn+7stv3lqY+0BG/zfAed0eKQU0elyzAN5
	 H9+oa29ipZwBLKRnLmgeAhJwRJV+a9GhEWVffCWgDoiu2SfIhHqsDeLxOfW0ZHmjgVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	b=HuiICjkrt8ygzgUnOPXmk5Ok5JucDD3fH1mf5/N58OgLBzdjtR9jbO49OUjWYQ78D461
	 BUDMq99lu1WESuHlsuQM+cGitKkso7Xl7oSBgi7rj+4Yt6Z84o0PO+F6wcr3yP/eAQU3M
	 zH6kbtubA3YKUquDAp0af2KXCNgA7X7F24rC6zLxytxVEAkkUMcnfKyu1vZ8/gYh4lvqt
	 EUzksRg5ZGjPY/GpxBueSTSC6GY8lLV9rlj0qyXh8sAVjpzD3Dm3wMprQEgTjUxH53Thq
	 SZ5ShVMdzt9oPDmfGIu5NGqu2NcvA1nFoaudF/POS3+qGG98s+94sIEi2ZzKHrpEzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkr8x5Hw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC17606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkr8x5Hw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BD1F00A07;
	Wed, 11 Nov 2026 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435751;
	bh=HoWw2LtXhaLTvRjoyzf/GLGky1XfPZvo/+Hksni2ztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bkr8x5HwNLVta6MCUrj22cAvj6z2pJQJnN70cwfqYCvUWXIqg7JwJ2jY9t6QGqNmV
	 E6MljOviKR0ij11hTh+I7d8489OpVR/T3AnS+q6Wc/ZJqJNdUTqCG3NArkYiPEzkbH
	 9mvdSNNa+ZRM8nPvA5Vi/z5qlJDz14AzxoO9KGWsJplFkmaV8pD6ZfJk2wkoqFvNCn
	 DA0tmdlO2yVa/oIfW9kKMcKRRAVE65wStHxv4F7KziFViUKsDYLkY/YTQdEAa2kzbR
	 CnhddcbvnX6fzIt9VGxnmwM/2GbnRNfzqgBHCf/vi3I3q3D8tbDDA+NoqJ06XsxJd7
	 qKJ7xfk/V1fcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] selftests/core: fix unshare_test with large fs.nr_open
Date: Wed, 11 Nov 2026 17:22:28 -0500
Message-ID: <20261111222221.4165903-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111222221.4165903-1-sashal@kernel.org>
References: <20261107061911-failed-5.10-df0b7e0ea59c@kernel.org>
 <20261111222221.4165903-1-sashal@kernel.org>
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

