Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E254CF74
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875028; cv=none; b=O/vY9Ho3BWi7LD9y2AeJx+uaiQVC+oCss1uZKBMDdvQZ0rAPBVFzFgzlNLnyJlpg2kqs+HJ9Mr2vW9/y3wLmcrKqeoL4NGZbKEOTcPPTqhHwRSaODewXCrHplzWXcqGbROyjYFdGzhQJFR/NiNEIZbGQmvGmz9wBh25v1N7nTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875028; c=relaxed/simple;
	bh=1k7ahrlLM68f5IDRj6NwNUtLtmQojvoo0M5llcCsh4w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BrI/K5khs1xUYoC0HCvCbYP9yntu2mZhvvZOZ2Hr2Xk1dsGqT0zyD9qXVVpmSv7TqL3LcQbQ/zmk1gG9gcfT0K2Z77FEMZBSR9oHt5b6hdAg1dc/p1nCMlqGIpHL7i/Wr8pIRohg4HZalqGCGXNlIW3yjGXWKyKDaunizkHIJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnCjYiw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnCjYiw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28201F00A3A;
	Tue,  8 Sep 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788875023;
	bh=EDbqIt0Rx9QxkBMT1oZT2rxmPFzT+zYq2F9dxGAl8Wk=;
	h=Subject:To:Cc:From:Date;
	b=NnCjYiw8tFEtCZHn6gG9ui74XMnqMAgnqinZawAsi4eikobMwog4uGvnZL5CzOvnx
	 0DNyilnSKfNQC/AVFDXIbdUEFAUZXswjyLppUO0x5gE7X4Evx4Pm1/rn/A5kECqDxk
	 qLZfeMWHM/Sfk9J9Q1sYc8syn3kIOS01ZrlZJoDc=
Subject: FAILED: patch "[PATCH] block: flag zoned disks with GENHD_FL_NO_PART" failed to apply to 5.10-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,bvanassche@acm.org,hare@kernel.org,hare@suse.de,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:38:35 +0200
Message-ID: <2026090834-voyage-donut-60bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3f9c7a108c0e8f14425384912017071b71341e3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090834-voyage-donut-60bd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f9c7a108c0e8f14425384912017071b71341e3b Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Mon, 31 Aug 2026 11:50:50 +0900
Subject: [PATCH] block: flag zoned disks with GENHD_FL_NO_PART

Zoned block devices do not support partitions. However, the partition
table is nevertheless still inspected, and any partition found ignored
with a warning in add_partition(). While this is generally not a problem,
and in fact beneficial to the user as it indicates an invalid use of a
zoned block device, scanning for a partition table on the device may
result in issuing read operations to offline zones (e.g. after a disk head
is depopulated for disks that support head management operations).

Since partitions are ignored anyway, completely disable partition scanning
for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
The existing check in add_partition() is left as-is to ensure that we
still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
still endup trying to add partitions.

Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
through sysfs the ext_range attribute with the value of 1 instead of the
default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
disks do not support partitions.

Fixes: 5eac3eb30c9a ("block: Remove partition support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://patch.msgid.link/20260831025050.667758-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/genhd.c b/block/genhd.c
index f1990c7cdfb9..10ca8b4d6eea 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -447,6 +447,13 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
 		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
 	}
 
+	/*
+	 * We do not support partitions with zoned block devices, so do not try
+	 * to scan the partitions table.
+	 */
+	if (blk_queue_is_zoned(disk->queue))
+		disk->flags |= GENHD_FL_NO_PART;
+
 	/*
 	 * If the driver provides an explicit major number it also must provide
 	 * the number of minors numbers supported, and those will be used to

