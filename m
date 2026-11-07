Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047535;
	b=W0qsfVsvJ4k108/35XqIutFPzlXkUm/XeoXCUnW2poUK999zXXxRHZIxzJUw+ylG4piU
	 0zrwElXHoKXA6gCtKEGkl5A9eYDEzCGzmwmt0rqAV6F/q4hQ2cs+KaaeNL5fk+gWS3HGV
	 xTDNs0MCbGENGjVAuVVabZq8icKEkq+dD3el/GzPln3CHdfXDZVsNa4X1n82SjBlKQsqA
	 P7ukfyLuiCOvN8b9BWmKQpwF6H1/leHMxMNFWe9rbVfb1hyGVYJKR6vTCijF06e3WPokH
	 TYGr05z3ts5FnR419e6zPc1MWLSmmuJzqvqSB/dBNyilOCm8rj7PFWLssf9E4Lrl0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rPraI3MCRs7OO+eUkx3zQJZ8rurL79NmAvX4N4/Tz5Q=;
	b=fp2/Njnk5XBtK5AQzQWycW3g87gaMJcZsrs2QUz02PXHHckjBfhKRFOFKSEwtNMbi1SN
	 zPx++uUrNBq3apytNI830H+J3qqm2mqA0ViYxSLsvObGzrILgVWxCecgwCQh5T1R8EOT0
	 mBYQnCVjmzb4ztoBP2yPX/f8FkDpWpqzzqemgX8LFAWPVPDcp/inMwq71dGz4tEBt87qE
	 uVp4N+tMqb0vLnR7iGDYyapyoQ1cULSt+GKSnwvEscnPAD4YQVN4c4DknPPC35vSihG9t
	 dIjyNvumwdInNBAj6x5fJh8lgIuwvczwuT66p9ZxfCe5x7isL6uwnRnY83g0lzEqypw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5pEzc9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31505606D809
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5pEzc9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642491F0089F;
	Sat,  7 Nov 2026 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047535;
	bh=rPraI3MCRs7OO+eUkx3zQJZ8rurL79NmAvX4N4/Tz5Q=;
	h=From:To:Cc:Subject:Date;
	b=Gr5pEzc9haqNFbWZt21btPdeNPo4ZeQikrZBICMKjKho9JTVEnATzkTV7syXZTZov
	 3anu4YjZIbadtqmvXMHIAbesfF5hPzCqEkDvWt2htoNYih9WCbWrxWl4uThR7k2kd9
	 SGMiGuWIAywPpPdgnSOcX5xO2NAfYc0C/DgORm2tpdixCPcGVy4dLELtvobbq1tuw+
	 6zAzy19Zv42ivWiG7y9dsSj5az+7Efcka0Y2pDCMefUxeD8zMVpeqycVuU4snjv8yu
	 dNFMya38G6n87ZjtCg6zJDiqp0eL+Ec5UUA/9eYZew1XPd9q4XCCgQ3k/yUZpiN2o9
	 b07ovo6sBC54g==
From: Sasha Levin <sashal@kernel.org>
To: khorenko@virtuozzo.com,
	eva.kurchatova@virtuozzo.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	richard.weiyang@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] selftests/core: fix unshare_test with large fs.nr_open" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:13 -0500
Message-ID: <20261107053213-failed-6.6-df0b7e0ea59c@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x df0b7e0ea59c43708cff8c7e34da5e2f8d430e5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053213-failed-6.6-df0b7e0ea59c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




