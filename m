Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F52DB795
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560591; cv=none; b=gVfRk55637FeCf+bqiZR/yroTychKnHSp1P53Ra6IJJSqfC2Uq9+uhWmVwQYfVRNLnfoBAmtowmvqv+7PzrNbqIl8YZ1imgJV7Fg5kwmH336c7EgRWLi5YhHzkahRI5kv6JUXZ5ij09tW389mqtFXZMqwbj4xCSCNuvHFmwuD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560591; c=relaxed/simple;
	bh=qIv4k6F0/0oLotgWuRYgFbqVbh2iuRUo5icETvniTMw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tt+UtjqaccmFf9eFS6IcB723zB4B7Nmg9zMdPJ0gccqXstt2vm9qsmIreC6OSUxutwElmbQgnq0vSB+2Vw+PGpPjAIjnrttN1O7sG5lS7DnORZks6+fT0O2Zaoy5sfdwEgCe+Otps/X9wpgaiQquSWLwIvJl2Z3cZWt+KHnwIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bz8HzKRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bz8HzKRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BE1F000E9;
	Mon, 20 Jul 2026 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560590;
	bh=9gWK2sS9y3EoFjTHdBWm2fNF55RK5m5ZgKsfktVLIOw=;
	h=Subject:To:Cc:From:Date;
	b=bz8HzKRZ6jdxdCtQdyhxLibFpUPv8qoGgdzZ+OOdK+k4kx3Gp9HOyGAqZF+A0mAY0
	 M0+UlJiU/QIMEn8EHKWn3ze1sfS85d0SGx1XTz0AUmGncXdXmQ/HvPmCBBUTpqmn2x
	 2I+NOdqH/n871QQRPeE42wEcl831IHnr2t8FUqWU=
Subject: FAILED: patch "[PATCH] block: remove redundant GD_NEED_PART_SCAN in add_disk_final()" failed to apply to 6.12-stable tree
To: connordw@amazon.com,axboe@kernel.dk,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:16:21 +0200
Message-ID: <2026072021-refurnish-abdomen-0f40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 181bb9c9eae4f69fe510a62a42c2932d0314a800
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072021-refurnish-abdomen-0f40@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

