Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3038F926
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167972; cv=none; b=k3RTHeKWso5penz6qkNxRs2YZvmdVZvl+44Hc3fWSSaZjbAqBS1lgu2Zwgn+oGkgUP+aCk7+FFZS5XrkNusMwdGi+CLf0KLLyQo6hK6TQVDbpNVxf5ovLeodKyIx8zl532svJzh5/bSPnypqYWBjQi1xA558jJRLL7i7e7389IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167972; c=relaxed/simple;
	bh=taLjfdQ304YxqRlJYKrWS63ydmJpkyCviVVzghgQGL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUL8Jg9Pd6fFtd60cfwxhNSjKQXb02I7Pgmy+gxWJCqbElL2gjNIJybdd7OviZUqFnaRyfxjkFs/YIK/oHnmdyda4/vHolq2EeZfYJCJI1weIkS23i1Xur0dDE2SqFNpF5JJr/VrttyYkYu81NZlZVcnckk2CEcfvNA/MvyppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzNehdKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzNehdKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFCA1F000E9;
	Mon, 27 Jul 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167971;
	bh=c0txfSmEgS7bL9edhHWhgU9iFUMJ5B/QMAfnXbwhyDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzNehdKE5IxB/W43xlWo/vZrrT8yaMEdBZrwbFBxiALjzeWjsA/PcRWVsTek/IJz4
	 saCF4TMIXsUTr1iSAhi6GcwoYULULRJTriUX4SzgjC8fMmdixXinXyjTJkXutZ4vrJ
	 E+4MuhCulDFJ7P8fSyeH3Bzw0A5I3hfvdE1gOeCAJgEwkEBN7xFc5QXfKxSwXBZ3Xf
	 Q2FhiVi+vwuk1QQjUZnmZq3lc+/v+jxOPC2SQ5/i54O50utMK/tSh+vavPjrRcvRY+
	 E985EWIb3BRdw3uxRF81/JFT4NFeB+9nzac+TXmdItQ1JDCBG+czI1TidptNY+88bw
	 IHaH8S6C7Wi2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] block: add helper add_disk_final()
Date: Mon, 27 Jul 2026 11:59:27 -0400
Message-ID: <20260727155928.1732187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072021-refurnish-abdomen-0f40@gregkh>
References: <2026072021-refurnish-abdomen-0f40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 5fad1490ef510e3b70ad8b0a5a1e28a26638a95f ]

Add helper add_disk_final() for scanning partitions, announcing disk and
handling the last thing for adding disk.

No functional change, and prepare for prevent adding disk from happening
when updating nr_hw_queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250505141805.2751237-8-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 181bb9c9eae4 ("block: remove redundant GD_NEED_PART_SCAN in add_disk_final()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 22fea4eb424192..c6cf86d3e182c1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -382,6 +382,32 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	return ret;
 }
 
+static void add_disk_final(struct gendisk *disk)
+{
+	struct device *ddev = disk_to_dev(disk);
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		/* Make sure the first partition scan will be proceed */
+		if (get_capacity(disk) && disk_has_partscan(disk))
+			set_bit(GD_NEED_PART_SCAN, &disk->state);
+
+		bdev_add(disk->part0, ddev->devt);
+		if (get_capacity(disk))
+			disk_scan_partitions(disk, BLK_OPEN_READ);
+
+		/*
+		 * Announce the disk and partitions after all partitions are
+		 * created. (for hidden disks uevents remain suppressed forever)
+		 */
+		dev_set_uevent_suppress(ddev, 0);
+		disk_uevent(disk, KOBJ_ADD);
+	}
+
+	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
+	disk_add_events(disk);
+	set_bit(GD_ADDED, &disk->state);
+}
+
 /**
  * device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
@@ -500,21 +526,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 					&disk->bdi->dev->kobj, "bdi");
 		if (ret)
 			goto out_unregister_bdi;
-
-		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && disk_has_partscan(disk))
-			set_bit(GD_NEED_PART_SCAN, &disk->state);
-
-		bdev_add(disk->part0, ddev->devt);
-		if (get_capacity(disk))
-			disk_scan_partitions(disk, BLK_OPEN_READ);
-
-		/*
-		 * Announce the disk and partitions after all partitions are
-		 * created. (for hidden disks uevents remain suppressed forever)
-		 */
-		dev_set_uevent_suppress(ddev, 0);
-		disk_uevent(disk, KOBJ_ADD);
 	} else {
 		/*
 		 * Even if the block_device for a hidden gendisk is not
@@ -523,10 +534,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
 	}
-
-	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
-	disk_add_events(disk);
-	set_bit(GD_ADDED, &disk->state);
+	add_disk_final(disk);
 	return 0;
 
 out_unregister_bdi:
-- 
2.53.0

