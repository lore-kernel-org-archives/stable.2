Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A932DB791
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560602; cv=none; b=uxHEKfV15ryzFZc3PeC6ILd2XHNjzeh4muBntpoR5uPpBigwGnwzY7RWA96sVnZVh6dveWTR61DYpWAfF85q1QQJR+PnLJsbceyaSZqGk+78Y4UKoHt7npR5bQnOwoB9+kVJuMqPng/+Dno5igSGmRUKwkO+oHyDoX0Fr96R+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560602; c=relaxed/simple;
	bh=usoTsO1+ZHjH3dAT7Jt50/GECtHh9mo8oz7RGFq5qGA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oMQHPaUof344hkozcbmHLjkkwM0f6klfBLSLa67weY/8ahMf5c1kNVA0PVFbVGXbkhspDGBy02XRKnSvlgrEwwYsVx4UWfR6h5cUkq0cXAaptOBgdMS/1JRdLGb60Rv4u57meEoorhXR/i2/p6V7y8OmEdSwpC+Ujn7k+xsbGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+AGbVfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+AGbVfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8C41F000E9;
	Mon, 20 Jul 2026 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560601;
	bh=WhO1qwNjQ3Pyzmx6D6ByFA39xp/UTHwidS/oeqeSPzo=;
	h=Subject:To:Cc:From:Date;
	b=Z+AGbVfip8IcshAAmWmZujTi2nwhi8Q80fcc0ENvudKYTLKK0zgoiJdcqY64Zyc4+
	 qmP8jLGb8x7j4K2wQj/BOQOGdJD3UbJI1ZgQu+zwPkO00OxlR3ZQs95f/wR0WWOYoh
	 qWp8CJkvUxFwvg79f/byJRQ764O3cSNi7c7Pl674=
Subject: FAILED: patch "[PATCH] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()" failed to apply to 6.1-stable tree
To: connordw@amazon.com,axboe@kernel.dk,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:16:22 +0200
Message-ID: <2026072022-unwitting-balance-62ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 181bb9c9eae4f69fe510a62a42c2932d0314a800
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072022-unwitting-balance-62ce@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 181bb9c9eae4f69fe510a62a42c2932d0314a800 Mon Sep 17 00:00:00 2001
From: Connor Williamson <connordw@amazon.com>
Date: Mon, 15 Jun 2026 13:07:15 +0000
Subject: [PATCH] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()

add_disk_final() sets GD_NEED_PART_SCAN before calling bdev_add(),
then calls disk_scan_partitions() which sets the flag itself. The
early set is redundant and introduces a race.

Between bdev_add() and disk_scan_partitions(), concurrent openers
(multipathd, blkid, LVM) see the flag in blkdev_get_whole() and
trigger bdev_disk_changed(). When disk_scan_partitions() then runs,
it calls bdev_disk_changed() again, dropping the partitions the
concurrent opener already created before re-adding them, which can
result in transient partition disappearances.

The race is observable by inserting an msleep() between bdev_add()
and disk_scan_partitions() while running concurrent open() calls
during device bind. Without artificial delay, it manifests under
scheduling pressure during boot on systems with aggressive device
scanners (multipathd, systemd-udevd).

Therefore, do not set GD_NEED_PART_SCAN in add_disk_final(). Other
GD_NEED_PART_SCAN consumers (blkdev_get_whole(),
sd_need_revalidate()) should not be affected as the flag
is set internally by disk_scan_partitions().

The retry-on-next-open intention from commit e5cfefa97bcc
("block: fix scan partition for exclusively open device again")
should also not be affected as the early return paths in
disk_scan_partitions() should be unreachable at device registration
time (bd_holder is NULL and open_partitions is zero).

Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
Cc: stable@vger.kernel.org
Signed-off-by: Connor Williamson <connordw@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260615130715.53693-1-connordw@amazon.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/genhd.c b/block/genhd.c
index 30ac0ffe6517..df2c3c69b467 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -407,10 +407,6 @@ static void add_disk_final(struct gendisk *disk)
 	struct device *ddev = disk_to_dev(disk);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && disk_has_partscan(disk))
-			set_bit(GD_NEED_PART_SCAN, &disk->state);
-
 		bdev_add(disk->part0, ddev->devt);
 		if (get_capacity(disk))
 			disk_scan_partitions(disk, BLK_OPEN_READ);

