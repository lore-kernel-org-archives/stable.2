Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5758E2D4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067333; cv=none; b=jmLzNZpGetmERIRTrQQIxx1RxfGW8N/nsku3SORqEi9zoN5maCK9YwWLPiZPiW/Fs2FzzrVWb2Gvfq5RBAtAjvfGS+Odgiha70XdCZ/1krOC2+kljUqRWneQA+Q6abzG2Vbfk6u53zpKypLDHwnVH89hpVbbmLY5gFjY8dPTcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067333; c=relaxed/simple;
	bh=ULoQzirNmzfRXp6ITSGHzQq+SHEW5t61gnFi10zV/uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVxI+qeR4VLQwWF6a2GqWG2i50Zr4MAOjUU5QdemMlQTS3ukGBn2YUa9hrTS5hE0nztHzljQPUq7Iz/b9/breSGoMRSQGZaG+/OyZIAsN276u5LBkOi7v3uZ5goFrW9swlBSvxDjLuOU0zmz0osiOE3YryF/AdkB0smj0+5eIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0t80B+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0t80B+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9721F00898;
	Thu, 10 Sep 2026 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067332;
	bh=J1mihEib44fSOWb3vaJiy0AcfC6vh7761VQdtiZyj4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0t80B+JPeSc2Y4mAqRBne53R3+/5i9jtKjG3MVIrkc+MnRU5VwNdret4t7kHSBLw
	 k3m4T6x8UOUCjp6ad5Eo7u/5udRECyH7Kp3lnv6fcWmSZe0wkZUyYMH2cQZYp46rzC
	 PWG1VFmBUCZRuFtfHdE4JbNzIIg98RKohO7n/H1qmZ91Q8VxRm5oig5NZal5I++1/t
	 X0k/rwYdDUhCIMm0yi/0S7fMTwbHMCeZWlhWFZmUKUOtAmj/HRfy2ObWjcWAOBYRQi
	 Iy1n1xaAOP8A3qceJviMyM7nKHEdaHTpKYKmCOyVEb6x0NB/TblJkUG1qMZ4sOSNQc
	 zEJ7K7VR699Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] block: remove GENHD_FL_SUPPRESS_PARTITION_INFO
Date: Thu, 10 Sep 2026 15:08:44 -0400
Message-ID: <20260910190846.1453814-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190846.1453814-1-sashal@kernel.org>
References: <2026090834-voyage-donut-60bd@gregkh>
 <20260910190846.1453814-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3b5149ac50970669ee0ddb9629ec77ffd5c0622d ]

This flag is not set directly anywhere and only inherited from
GENHD_FL_HIDDEN.  Just check for GENHD_FL_HIDDEN instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-11-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Adapt the dependency to the 5.10 disk-registration layout.  Remove the
hidden-disk suppression assignment from __device_add_disk(), where this
branch sets GENHD_FL_NO_PART, and keep register_disk() and its existing
uevent and backing-device registration flow intact.

Preserve GENHD_FL_CD, GENHD_FL_UP, GENHD_FL_NATIVE_CAPACITY and
GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE, which are still used on this branch.
Only remove GENHD_FL_SUPPRESS_PARTITION_INFO and check GENHD_FL_HIDDEN
in both partition-listing paths.  No functions are added.

The preceding dependencies already removed the MMC and null_blk users.
Verified that target 3f9c7a108c0e applies cleanly with a three-way merge,
inserting its zoned-disk check in __device_add_disk() before partition
scanning.  The existing GENHD_FL_NO_PART ext_range handling is retained.

Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c         | 11 +++--------
 include/linux/genhd.h |  9 +--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fef31a2f50a80..4ecab2f503719 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -747,10 +747,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
-		 * Don't let hidden disks show up in /proc/partitions,
-		 * and don't bother scanning for partitions either.
+		 * Don't bother scanning for partitions.
 		 */
-		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART;
 	} else {
 		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
@@ -1086,8 +1084,7 @@ void __init printk_all_partitions(void)
 		 * Don't show empty devices or things that have been
 		 * suppressed
 		 */
-		if (get_capacity(disk) == 0 ||
-		    (disk->flags & GENHD_FL_SUPPRESS_PARTITION_INFO))
+		if (get_capacity(disk) == 0 || (disk->flags & GENHD_FL_HIDDEN))
 			continue;
 
 		/*
@@ -1182,9 +1179,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 	struct hd_struct *part;
 	char buf[BDEVNAME_SIZE];
 
-	if (!get_capacity(sgp))
-		return 0;
-	if (sgp->flags & GENHD_FL_SUPPRESS_PARTITION_INFO)
+	if (!get_capacity(sgp) || (sgp->flags & GENHD_FL_HIDDEN))
 		return 0;
 
 	/* show the full disk and all non-0 size partitions of it */
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 30e1841630b1f..d6892e2f31c37 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -92,11 +92,6 @@ struct hd_struct {
  * ``GENHD_FL_UP`` (0x0010): indicates that the block device is "up",
  * with a similar meaning to network interfaces.
  *
- * ``GENHD_FL_SUPPRESS_PARTITION_INFO`` (0x0020): don't include
- * partition information in ``/proc/partitions`` or in the output of
- * printk_all_partitions().
- * Used for the null block device and some MMC devices.
- *
  * ``GENHD_FL_EXT_DEVT`` (0x0040): the driver supports extended
  * dynamic ``dev_t``, i.e. it wants extended device numbers
  * (``BLOCK_EXT_MAJOR``).
@@ -118,8 +113,7 @@ struct hd_struct {
  * ``GENHD_FL_HIDDEN`` (0x0400): the block device is hidden; it
  * doesn't produce events, doesn't appear in sysfs, and doesn't have
  * an associated ``bdev``.
- * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
- * ``GENHD_FL_NO_PART``.
+ * Implies ``GENHD_FL_NO_PART``.
  * Used for multipath devices.
  */
 #define GENHD_FL_REMOVABLE			0x0001
@@ -127,7 +121,6 @@ struct hd_struct {
 /* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_UP				0x0010
-#define GENHD_FL_SUPPRESS_PARTITION_INFO	0x0020
 #define GENHD_FL_EXT_DEVT			0x0040
 #define GENHD_FL_NATIVE_CAPACITY		0x0080
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
-- 
2.53.0

