Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048304;
	b=1BnfwIk4M2RgZRTG2bbk/Cksfo7lEzG7W3IOsd6MuRtYRAxilXXUgFjNGIpHqNsv1f9R
	 ELHLpkau22LPDyvgnCY0hW82SNmd49/NG+WVpTVaG9YUpN2TDIdnnP2PrX3EKCftGMHKc
	 AAOeJAu4hPJ8s1UYYT7XidlVmP1SxPwTWehHNkpOid/k6NTpUia4OG0j995xzKMdNBo14
	 Zx6mdcI+xwi+IUAuMayP9881TMdjH9xlNgOdePxpb1RTDuYMEpZomA0rYnX4tfd67TRiJ
	 98xvQdodQZ9M2jSmucqdfoP/3Muf6el5NMA6JIqT9x5DfKhfZuzVG5/7VmJttVhMkqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048304;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=seJ1+xGyQ8btrV0uRhS237N0N70DmRM1RFBkDMLrZGM=;
	b=JJ2+Uw1HXu7GoFWWfc9fAhSGD/TXq23eBRr4/G1Muo6dsuQlxKQr9xMccgBkK493BOT6
	 w2QJNdcyqnBI+8Ow6LC3TnYh3y+FS16BWMW5FdoiBWpvDCqdbSZruTkhDpjcQSso7nOpp
	 u7aarb3a0ajfeGjjtU1ma0vakAN7KF6K48dwGlj08xKQUHC9+ejWK3Nck6R1OgmdzCvTt
	 dsnLt/cMujfmH2JXy9k1BxT1qhbvjPKLpVidpraC4XotFwniMIMDMgJF1VWpPLbfRf9al
	 +xiABU2Mo/8MLavyW1x9Re4HhNgTMKqFXrEOs5rvWC2rFGkTlwOSgntw2HM2aw6lZZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lZ/aXE9d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZ/aXE9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA041F008A1;
	Sat,  7 Nov 2026 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048304;
	bh=seJ1+xGyQ8btrV0uRhS237N0N70DmRM1RFBkDMLrZGM=;
	h=From:To:Cc:Subject:Date;
	b=lZ/aXE9dHWLFNKHdzgwJVfNRAEmZkriruCTLqKJ2HIWNSENekAtBH4hBktKKXvc7g
	 Qinwn15c3/GC533J8zAQgqk9DZNOXTGbwcgFSBAOir3cECoo1SiN/o/ItrtklxCuYa
	 F6U8gJJc3ZE2QYOU0sVS4StwWZ1BQBhvWJvCfiLevAF2BBcA/YrH7krhE/aqhXirAF
	 cA9z8qIU0dSDLd2dXcTLHUInAEG2lEl1x6Fz6+cOttDZB1FJefE9CAfrodCr1qM1EV
	 T6DRbFiBRQV4poAOom1aR9jNPjP/0kSBgMKwClQpBpciA79X6B9F0SnSz6JcsZnLHU
	 /oV3KXMc4DqPQ==
From: Sasha Levin <sashal@kernel.org>
To: khorenko@virtuozzo.com,
	eva.kurchatova@virtuozzo.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] selftests/core: fix unshare_test with large fs.nr_open" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:02 -0500
Message-ID: <20261107054501-failed-6.1-df0b7e0ea59c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x df0b7e0ea59c43708cff8c7e34da5e2f8d430e5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054501-failed-6.1-df0b7e0ea59c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




