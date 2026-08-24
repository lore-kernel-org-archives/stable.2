Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14B2EA732;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578375; cv=none; b=nyi/H3gb26S7T1WRDB/0iEFy/pKWoKZG3NrQUUTMobOz6RkigXivhhfylqLvFp72hJoPXUwIaqvYJtlbrcF2eJyp7m/AnK1RgsJ9eyrSOdfrDI2JYSTFTT55bHeh4SkQiXbK50s/yiFWN8X8/Ninr8HD6PxsFRGZUroEawgXBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578375; c=relaxed/simple;
	bh=/Es2fSdTwUmy/6IdP4XUR1DrGU7DaaE6PINJhMBwvuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvfajSoo87veubPuUvVLEMrY/Wvy6bIDf4hQYAV1V25H3DSOHwDvTNxDsOlrS+CpH3eEf0thcM8MZBEietJqi1icXTyaJcZj1NpWqoT94+xuaZBaHQrtP+7Po30MIjpjGnDyxka2Rx7Mx6YnFUPWT0GY02JuCamEbewma+7LQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPfjmKuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPfjmKuL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95AEBC2BCF6;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787578375;
	bh=/Es2fSdTwUmy/6IdP4XUR1DrGU7DaaE6PINJhMBwvuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TPfjmKuLrCLVWYQvU9NjRhVbiivSNvxrwAYB+x6PQCrUbD0LoThQxvu7kB555Pb/a
	 yicE8xwGn+3P2R0g3X3bh2NUY9Y3oGwP1zsB6e7JsJGPWzwr5OhfXHJNZeiPPUCXll
	 WatuEKWfLJfwCQm2WaEnZwtqFVMVXaXrOfc/w1C3PzJeVcPqdKyfsHnQtZrsB5suwG
	 X36S9SDJsIhNgN7zuRwxgVEf1ggoUPtrBpPMs31BMVxhK2I1kiE+c0ihyTO9NTp5ka
	 dylUf+niRMG2xeC3Ou/MZjY+fy2E9Dr7UJs1lem9zdtzg1qWp2kOZiXb/8UidT69FU
	 NrJic/1tY+QKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E25C5DF9B;
	Mon, 24 Aug 2026 13:32:55 +0000 (UTC)
From: Daan De Meyer via B4 Relay <devnull+daan.amutable.com@kernel.org>
Date: Mon, 24 Aug 2026 15:32:47 +0200
Subject: [PATCH v2 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-b4-loop-nbd-stale-partitions-v2-1-9815a577cebd@amutable.com>
References: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
In-Reply-To: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nbd@other.debian.org, Christoph Hellwig <hch@infradead.org>, 
 Bart Van Assche <bvanassche@acm.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Daan De Meyer <daan@amutable.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787578374; l=2855;
 i=daan@amutable.com; s=20260712; h=from:subject:message-id;
 bh=WMb3SvdJ8nIuT3XTRHYjCJBoiazU8RPkqLA8H581hVc=;
 b=roJ22zyFQX/Aj5bjWwbYQ1OZriM1r+M8xNrCHVZC76NrO3DAmpoc//cdf8eoGpGjge//Kizny
 AUInBq9U2srA60ZGkwqHnztnuOc22sPBbB2dGpoO8tyqqSiM3OhIShM
X-Developer-Key: i=daan@amutable.com; a=ed25519;
 pk=I1l+WwrtmzRgofA5SQ1wTuJi18fjh91w+f5uRkFeZEA=
X-Endpoint-Received: by B4 Relay for daan@amutable.com/20260712 with
 auth_id=868
X-Original-From: Daan De Meyer <daan@amutable.com>
Reply-To: daan@amutable.com

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
index 6f12976035b0..89935cfc591f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -550,7 +550,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file *old_file;
 	unsigned int memflags;
 	int error;
-	bool partscan;
 	bool is_loop;
 
 	if (!file)
@@ -604,7 +603,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
 	/*
@@ -622,8 +620,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
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


