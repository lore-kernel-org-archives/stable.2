Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050354;
	b=omuPund797VmbH/8QMLxwtYwX819jmLkuWfGa+ZKV7a9FiIyGX1ncjD4AJiED/OADjSU
	 4RpWXINO/qlJQgXeGlyajwjmzpH3xtpi/Kv04dbukML6Mo5WLCUcKR3K99CK19AU2I3IW
	 PUoJHq8CnUlptIdO8ASepGxmKKrm2eAgxMAb+vVa0VRtVUoEMidddYXgQFg4eyBmJWio4
	 tz7NNJuBicmEJO3/Br6KCTAiD+lxDsy/Ss05Y7kM1X9nBFtrOqS4RrOqQCQkDcHnXveSW
	 18kDIoPR/Kakgp4NLnOGvscyUINx2cm0twQScnPuj5a9oMa5XS0lHI1XssXbpo6kqJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050354;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5LRpYhu37HMyiu716izPI0tuTgSa8mgPI6qL0wggylo=;
	b=er+3QIPYhUJ34iHnuIOLEGez7V3A6uy2yv4EtrmL8C5tDOEnqOVXeyC4oLxG8VLCdkcQ
	 QWHDqNMcf4VdHuYOkwGdG5grVw73F40FSw2t0TOfR7AGl8tJnzgUDh6FTABKzdw5C4aoK
	 XTkkcA/CW8npaTAqEI8cW+7tZa4q1+CgeHLpBnBXYMPwwk0FIoYXpsvZX8Tn3HWryL1wj
	 +HSGkvgLU+m6bCBUlHBwKAW9V8gvHAkosiB9uN7fSLvkd0VbSDeg8DI7DSV05m70FNmuH
	 DQeQWug5UlhBNOdNfE9+nKGK0pHbCCV1k6iVfXcOGF4N0XqvsQ9Ywad1hTNeY9BlfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZVLMpda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D814606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZVLMpda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403121F0089F;
	Sat,  7 Nov 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050353;
	bh=5LRpYhu37HMyiu716izPI0tuTgSa8mgPI6qL0wggylo=;
	h=From:To:Cc:Subject:Date;
	b=XZVLMpdaMBtcRhKnI0cojBtg90Xr8OShf6DPja3rgY7oexBK1KjeNdhBc99RZ4rZP
	 l9CZGM8+zuGfJNVNwPC5yjYRI/KQwKxhrcI6L4bM6zAwpZZFngfSr+sILLz+QYX1ko
	 cqgrinOQLFuEwkzMiQXyHUYRxJd0HMGUwfGPXaaHKJe0pPhfeQVDFnQN6cG+VHJAhc
	 OuS+qEVu4zSAYII3Q5lqVdmI9lNGz0Zx0U9CcqlsX8vs9ayq6SkAkAY20LkJTTPZ9H
	 jsLvSTEmoW4mc/woVQMaQEroHtocKSCtBsElEBK44r24gyGex9XaGajhxWlnyKHJM7
	 ViSFEknOF42OQ==
From: Sasha Levin <sashal@kernel.org>
To: khorenko@virtuozzo.com,
	eva.kurchatova@virtuozzo.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] selftests/core: fix unshare_test with large fs.nr_open" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:12 -0500
Message-ID: <20261107061911-failed-5.10-df0b7e0ea59c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x df0b7e0ea59c43708cff8c7e34da5e2f8d430e5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061911-failed-5.10-df0b7e0ea59c@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From df0b7e0ea59c43708cff8c7e34da5e2f8d430e5e Mon Sep 17 00:00:00 2001
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Fri, 14 Aug 2026 18:57:09 +0200
Subject: [PATCH] selftests/core: fix unshare_test with large fs.nr_open

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
---
 tools/testing/selftests/core/unshare_test.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index ffce75a6c228f..d40e963dd5205 100644
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




