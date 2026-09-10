Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A158FD39
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067334; cv=none; b=OJws6xdn7Hio7+lyoxxupUPaRj+sy4eExbrGdTta4jrlrAblzs158KwHCaUwTWCa5ccwC+2tqAZP3HtvY5wWE/d5jZySARd0GctNrdlascjkAagQGOcazkjGSS5q5jbxbMRbuPgwa8FaILLNocchPLheh1nkOLUstXI6SI0KMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067334; c=relaxed/simple;
	bh=m5umePxBvUSksu5lPptAOaXJUv2XTax7MPaN0cM9C/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7w7vJYWdSyCZ9/bBwAaewW1HfUBX1GQxJR4dH+KMIsIURZfzEYKNztYW+DMzEeRuNnYNNhQ1tGD3MDWhGlMpQCu9jmPeHgyodLpVpzX3G2FAYwEtxKIzmo5xhGqhYhcgYNnSgfN6cd03bQqpigHzVMGFR1liwMM5J8+cVsJS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI3q6LEP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI3q6LEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF211F00899;
	Thu, 10 Sep 2026 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067333;
	bh=xFzqmCUJK9e6KBPZc8T3Zw6Ma+e306VVkvvPeAT9xis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nI3q6LEP8m45rwRi6s79V6xE2Qp/4tnDeSUincHxnXHHtKSguZ3mvUgQI+CJEtAnI
	 O5uA23MLhdGJUGy0enqaK/y5GKoeCGQfo/Whr4852YzqapZskNxDNkOVrQV+Gc9eKt
	 xvJTunCVMU2YvoXiUrAA5f4U8wpRl1BoYGAH3Wike/Xe3Ix3tDK35UvUSBuZOg0wan
	 jc2RoLuePUCI/fI3uJTdtPYsQcaY+vItsUaJOVd5F6GBv8FRJeioGjuCSXCcAxD58D
	 5nIL3btJ1y1HhHzJ7q3REFxjGgUBai0UtnVwMmys5odaPxE45BxQbV74d7vXlNXlRF
	 sFk19GK+iSnAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] block: don't set GENHD_FL_NO_PART for hidden gendisks
Date: Thu, 10 Sep 2026 15:08:45 -0400
Message-ID: <20260910190846.1453814-6-sashal@kernel.org>
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

[ Upstream commit 9f18db572c97bc327b63528d195fdb252f47e9de ]

Hidden gendisks can't be opened using blkdev_get_*, so we can't really
reach any of the partition scanning paths or partitioning ioctls except
for the initial partition scan from add_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-13-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Adapt the dependency to the 5.10 disk-registration layout.  Keep the void
disk_scan_partitions() interface and its capacity and partition-scan
checks, adding a direct GENHD_FL_HIDDEN check before requesting a scan.

Remove the implicit GENHD_FL_NO_PART assignment from __device_add_disk(),
where this branch handles hidden disks.  Preserve its existing BDI and
region registration, and keep register_disk()'s hidden-disk early return,
uevents and sysfs links intact.  No functions are added.

Verified that target 3f9c7a108c0e applies cleanly with a three-way merge,
placing its zoned-disk check in __device_add_disk() before partition
scanning.  The existing GENHD_FL_NO_PART ext_range handling is retained.

Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4ecab2f503719..ea81203f6a036 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -680,7 +680,8 @@ static void disk_scan_partitions(struct gendisk *disk)
 {
 	struct block_device *bdev;
 
-	if (!get_capacity(disk) || !disk_part_scan_enabled(disk))
+	if (!get_capacity(disk) || !disk_part_scan_enabled(disk) ||
+	    (disk->flags & GENHD_FL_HIDDEN))
 		return;
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
@@ -745,12 +746,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_alloc_events(disk);
 
-	if (disk->flags & GENHD_FL_HIDDEN) {
-		/*
-		 * Don't bother scanning for partitions.
-		 */
-		disk->flags |= GENHD_FL_NO_PART;
-	} else {
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
 		struct device *dev = disk_to_dev(disk);
 		int ret;
-- 
2.53.0

