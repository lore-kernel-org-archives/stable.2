Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776978;
	b=t4zW3oRQlqAsa5Y3lW+yIAa2jkYnK2DceeSQ4FpRjqX6F5Z1vKfBds4G//diHV3q5+VF
	 b/oWPyTJbuISUyPux0TnXClcH7DhArIxsooLLf/CoeM0hPrsMUaqdr+T1TyYbEL3t3jd2
	 DPnYuAz/0xj+rgIC5QUOQvYP5Tx9wTuUWdWx1DdWnb0aEeEiMZbsiFZ3t0Z2JBSryS/S+
	 qpIQqyCxQldnpMOzszPRlyJ9QUdIgNIJZEC0XfD4HNiqA9/WoG8SOHW6xpAYJI+On3jwq
	 APG7C9UIM68Vp0wbJZvOiX+n9KkIKQ1KAKEU3q98o/6JHT4cLdNfO88H7g6YZ3JreKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1Csl98uTqktOParQt31V+Vk9bWjMzRE/Hizj4IlxonY=;
	b=WrhLegmNFO5Csgwa3ipDGpAprnHDgTdGJtWGu/MOU8s4TDCa5BbL2GrKHWDdpSqeP7va
	 7yZdse5EnYzw3VpPKSs57yWz94V91jKlpF6MQIkaftDy4qOrXXv3t18vn//4qh2BgjPeA
	 SJjrjawU/bH0BXJZJoxqa2UklkW+Zroo0+O0dun7FR3yJEznVCcNlAUrB7yUVArSoVj5U
	 bmi+I+S4GiYdxVH78Xk+1mLrZDLprVYNWVGhbTHyvzknCi/uOt83o+IBHC59WPIEws0m0
	 NdC6xuxNTcewdnGJK+Jb70pnKID+LjVQk3Joiks7f+VezJufn55w3VPC0VK3w+MvLaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJXmwguW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0609606A31F;
	Fri, 27 Nov 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJXmwguW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DB11F0089F;
	Fri, 27 Nov 2026 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776978;
	bh=1Csl98uTqktOParQt31V+Vk9bWjMzRE/Hizj4IlxonY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJXmwguWiFNMdKuBrR3+HdSlFRwkKGQvl5Rat++CYNR/qYAj5W29G88XdUu2tuaTy
	 1iotMw86/uYtwMEX1Bvdv7x2tYr2W7HkwGRmRl4OUlAtm2bsBwL/SacFB3us6igum4
	 D6OwROAH/7BGtGSZDfB02FKo1vj4qTqxyQjIM0PJXec0JM16cRvmvve5tiMKx2aukZ
	 uso4uUTiITNLFJCuIaPl4IxxZ6NbYYwEUDG17Yt2sV3LWgr4wmeQk8i4Wu5Wnmy9/B
	 Cwcx73ww9J/FniuB2BS1UU2xqYEg9/dwJOlTeSh5zV/qrbAOsE58/VTw+QOa0ItMx3
	 ZsXMWAjbd7xXw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/7] f2fs: fix to return -EIO from f2fs_write_checkpoint() once cp_error is set
Date: Fri, 27 Nov 2026 10:56:10 +0000
Message-ID: <20261127105608.537148-10-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
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

From: Chao Yu <chao@kernel.org>

f2fs_write_checkpoint() skips a CP_SYNC/CP_FASTBOOT/CP_DISCARD request
w/ err = 0 if the superblock is not dirty, and this check is done before
the f2fs_cp_error() check.

However, do_checkpoint() clears SBI_IS_DIRTY unconditionally, even when
the checkpoint fails due to cp_error (e.g. shutdown), and only returns
-EIO at the end. So a checkpoint request which was queued before cp_error
was set, and waits on cp_global_sem or in the checkpoint merge queue, will
see a clean superblock once the previous checkpoint failed, and returns 0
w/o doing checkpoint.

For a file which relies on checkpoint to persist its fsynced data, e.g. a
compressed file (CP_COMPRESSED), f2fs_do_sync_file() -> f2fs_sync_fs()
then returns 0, and fsync() reports false success, whereas its data was
neither covered by a checkpoint nor by fsync node blocks: after recovery,
the fsynced data is rolled back to an old version.

Note that the previous patch "f2fs: fix to return -EIO from f2fs_sync_fs()
if cp_error is set" only covers the case cp_error is set before
f2fs_sync_fs() is called, not the case it is set while the request is
pending.

This was reproduced by the f2fs consistency test (verify_consistency.sh
--init zoned -S 64 --mode consistency, w/ compress_algorithm=lz4 and
default checkpoint_merge, under fault injection): fsync_verify.py randomly
overwrites 4K blocks w/ a generation number and fsyncs them, the test
injects "f2fs_io shutdown 2" in the middle, then verifies the fsynced
generation after fsck and remount:

  FAIL: file 2 block 510: rolled back: gen 17 < durable gen 18
  FAIL: file 2 block 561: rolled back: gen 22 < durable gen 23
  FAIL: file 2 block 955: rolled back: gen 12 < durable gen 13
  FAIL: file 2 block 3986: rolled back: gen 23 < durable gen 24

w/ debug logs (trace_printk) added in f2fs, the ftrace log of the
failing compressed file (ino 438) shows:

  python3-346519  2267.558508: FSV SYNC-BEGIN f=2 fdatasync n=4
  python3-346519  2267.558519: ino=438 FSYNC enter datasync=1 dirty=4 cpver=14c8edcb
  f2fs_ckpt       2267.559876: CP end reason=4 err=0 cpver=14c8edcb
  python3-346519  2267.570549: ino=438 DOWRITE OPU idx=510 old=a21bc1 new=ae4af3 hdr[f=2 b=510 g=18]
  python3-346519  2267.571478: ino=438 WCACHE exit ret=0 nwritten=4 dirty_left=0
  bash            2267.571810: iteration 4: injecting shutdown 2
  f2fs_ckpt       2267.573403: CP start reason=4 cpver=14c8edcb dirty=1
  python3-346519  2267.579576: ino=438 FSYNC wait_range ret=0 dirty_left=0 append=1
  f2fs_ckpt       2267.589393: CP end reason=4 err=-5 cpver=14c8edcc cp_error=1
  f2fs_ckpt       2267.589413: CP start reason=4 cpver=14c8edcc dirty=0
  f2fs_ckpt       2267.589414: CP SKIPPED (sb not dirty) reason=4
  f2fs_ckpt       2267.589415: CP end reason=4 err=0 cpver=14c8edcc cp_error=1
  python3-346516  2267.589431: SYNC_FS sync=1 err=-5
  python3-346519  2267.589503: SYNC_FS sync=1 err=0          <--- false success
  python3-346519  2267.589507: ino=438 FSYNC cp_reason=2 sync_fs ret=0
  python3-346519  2267.589510: ino=438 FSYNC exit ret=0
  python3-346519  2267.589567: FSV SYNC-OK f=2 D=510:18,561:23,955:13,3986:24
  [shutdown -> umount -> fsck -> remount, recovery from cpver 14c8edcb]
  kworker         2370.028185: ino=438 READ-END idx=510 hdr[f=2 b=510 g=17]

- the checkpoint which should cover the data written at 2267.570549
failed w/ -EIO due to shutdown, and cleared SBI_IS_DIRTY.
- the next merged checkpoint request was skipped as the superblock looked
clean, and returned 0, so fdatasync() of ino 438 returned 0.
- after recovery from the last valid checkpoint (14c8edcb), block 510
has gen 17 instead of the fsynced gen 18.

Let's check cp_error before the "superblock is not dirty" check in
f2fs_write_checkpoint(), so that a pending checkpoint request returns
-EIO once cp_error is set.

Cc: stable@vger.kernel.org
Fixes: c34f42e2cb2d ("f2fs: report error of do_checkpoint")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- commit message: refer to the previous patch rather than a commit id
  which is not in upstream.
- rebase to the latest dev-test branch.

 fs/f2fs/checkpoint.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c059022413be..a8c98a2acc53 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1975,14 +1975,19 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	stat_cp_time(cpc, CP_TIME_LOCK);
 
-	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
-		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
-		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
-		goto out;
+	/*
+	 * Check cp_error first: a failed checkpoint has cleared SBI_IS_DIRTY
+	 * in do_checkpoint(), so a following request would be skipped below
+	 * and report false success.
+	 */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto out;
 	}
+	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
+		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
+		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
+		goto out;
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_START_BLOCK_OPS);
 
-- 
2.49.0

