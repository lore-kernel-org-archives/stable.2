Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792675900;
	b=nlOYyEKKqXEcB2SKtHZYf3YcMAa5OIcxzeTN5/KSHghJoGmjNVZ2Uk5mxA+7+B9eg6G+
	 2jYVWnNLc1+4gVZEeIToJUWMUTnhfe1EPNXmZFMXpZO97+TItYJ8GaQv3LnnN5mw2pHGT
	 aAPE3GMrqI6gSggnONvPiI7UpCbelEqdSwpQ+2DHClmpdS1+S9qXk8mBeZbG2jSx13CAW
	 o6C995f0fciPvv9JvD/3sBWXKPLXvQU7D0FRqyQSaCElpFP3dv2pUM/9F3tIECGbbzglC
	 1ut+tJNrYryQJbKME57jb7hHyv08p6nm+LFapdiP76PtqJ3U8Zcfhi2UnetHOMlbkGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675900;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	b=Tiy0OBMSpxCwwpq0UOO9Wdb93uPBZdkCT9YMR09QwNsOh4zPS5msi98zwzD2bvvB6DKp
	 88eTY8gz8GRysEfVkO/Cp7ItAPebqHzgZS5h80ffZmDFLsVShCRh7Q40pFgB35ZwpxaPq
	 X424fRJXx7USzoTz14TJZOj+AaMdZJC5BwlsfH/z/xqV4Y1zla8vKd5Et+390i2VWNMUU
	 cz5rdNH0qfAqr7hdqt9V5f4hvMSTItyk8IM0AJblFeWVSV0XvBlKr7bT1Pth86LPKj0yN
	 WQnh0JtUngO2Xfb1PY9M7edXvnHOlQr1Fl5r8/t4xqvOCZBAVd+2paZ8GWaMABPLYJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfBqS0r6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32246606A31A;
	Thu, 22 Oct 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfBqS0r6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792675899;
	b=Bb5zvK6dWrBjfIgtuX6mI8uctf9QyxE9a0xyx4/la/t32xqOihZOWZ65n9PRjG2bD3es
	 606Chzyr5slcdF6SDQ144C+nylKHbzQ9pFLaJAR8kF+WBFOXguwQKRSCocNmIityMTJYT
	 XbB8UdIT8hrzD0jON0WXMGlpOz0wa+cWJCQR7+ogRtPUlwLRq1Yi6rUnxPemB63IadH5f
	 eHqMT2+FQQaOA7KnXh0WoD9pIdL2khhsRLyvrVN/xnoXNDg2YwYEdd0c8AkjBw1aoG5tM
	 0/Ogy1QgLvbEgNlbxvXO2LL/utXCuIBJA3yrIll2GhEhlftgr/Q6wYj4wgnsVm1SGlA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675899;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	b=oNo4iHBLMs/hizjbXhNtCLpZgd/P8q3ifoI3CxnjK+SlNkWdPF83e9IADWzWD8vHfL+D
	 C7Nywl4soD4aKf0NAVhm4k3dic4P+BItN12HQtroIfNnMCH7WHzDn8xKC2A+UxzgSujSp
	 xgbMy8hp4PtALsXDedU5GxCiGn0xTAKa+QNq8Muf5r6X15lcVO8+hBQH6DFUikYxEMtL0
	 iVcmCJDi0nDjR+vvlPCPCsQIn0wFvqlRG9jTfnZ7MwgPdJDk9qbSpWFCYM+gGP0o8/NR8
	 QpPXVKX+GWP9wtvQXHHioqkaiLpt3OIqiYjIfRIFfaSvBU9zR1O8iXGpI0j+F0H2qYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D7A41F000C2;
	Thu, 22 Oct 2026 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792675899;
	bh=9yH6lCZJs4jQqhq5RKT/kA7z15frEt+8pQmmPZcgKoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hfBqS0r6yLyPm/TpGe8+2J407uBxMRyMpqim1bvrQP3ClrXWhudHspbovMuKk7pDa
	 qESHLg51UIFJgJA5xpdwkh13CQCUHSsc0VW0NAE/x6K/jzuNo8ID8c9I0ug3yuV2zO
	 lQu37pWHPpdq+G9rjVnBH6vBLk+xs0SQPUu2kdt65UREPPIqPyDkfLGwEyybuMY3aQ
	 v11p6Mc2Pv8UoIhKU6gXNFfpNaEAbllsNVmjiATmsEIx38FcUr/r2ga3q1q3FonNbv
	 ym6GUqcFKzV9nQPh7rYTEdoq1daRO8E7Z89NJu58TRbGLqFNmOLgakGrxmyOG1GsGX
	 HQCH5SKn87CKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D303F4358E;
	Thu, 22 Oct 2026 13:31:38 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Thu, 22 Oct 2026 15:31:11 +0200
Subject: [PATCH v3 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-b4-loop-nbd-stale-partitions-v3-1-7c58ecab69c8@amutable.com>
References: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
In-Reply-To: <20261022-b4-loop-nbd-stale-partitions-v3-0-7c58ecab69c8@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792675886; l=2855;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=puuj6cW8tTVT3rlBQ4+twjIwX6td3ITnz1udGWzqXoE=;
 b=bm9JYcaLmrTZGd65sbO3DwpOUBlC4Vat94LKUpfk8mBWpc0fo0plUO/65DilomxGB2AsSbCoO
 QR5WuNuKixMCDnwJCExAo7glZyI0ZuD+GJp8S4VhDFRzt/SWbaNIDW9
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com
Content-Transfer-Encoding: 7bit

From: Daan De Meyer <daan@amutable.com>

Commit 267ec4d7223a ("loop: fix partition scan race between udev and
loop_reread_partitions()") stopped disk_force_media_change() from
setting GD_NEED_PART_SCAN. That bit did more than request a rescan:
bdev_disk_changed() drops every partition before it consults
disk_has_partscan(), so the lazy scan on the next open was also what
removed partitions from a loop device without LO_FLAGS_PARTSCAN.

Such devices are not unusual. bdev_add_partition() only rejects
GENHD_FL_NO_PART disks, so BLKPG_ADD_PARTITION works while
GD_SUPPRESS_PART_SCAN is set, and parted, libfdisk and systemd all fall
back to BLKPG when BLKRRPART fails with -EINVAL, which is what a loop
device without LO_FLAGS_PARTSCAN returns.

loop_change_fd() only rescans when LO_FLAGS_PARTSCAN is set, so those
partitions now survive the backing file swap and keep describing the old
file. The new backing file must have the same size, but its partition
table can be completely different, leaving the partition devices mapping
the wrong ranges.

Call loop_reread_partitions() unconditionally. Without LO_FLAGS_PARTSCAN,
blk_add_partitions() returns early, so this drops the stale partitions
without scanning the new backing file.

Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/loop.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..378163fdf957 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -552,7 +552,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file *old_file;
 	unsigned int memflags;
 	int error;
-	bool partscan;
 	bool is_loop;
 
 	if (!file)
@@ -606,7 +605,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
 	/*
@@ -624,8 +622,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	if (partscan)
-		loop_reread_partitions(lo);
+	/*
+	 * Rescan or, without LO_FLAGS_PARTSCAN, just drop the partitions of
+	 * the old backing file. They can exist without LO_FLAGS_PARTSCAN as
+	 * they may have been added manually with BLKPG.
+	 */
+	loop_reread_partitions(lo);
 
 	error = 0;
 done:

-- 
2.54.0


