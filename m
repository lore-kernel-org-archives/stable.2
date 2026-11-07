Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048848;
	b=DDNnMS5H4GVVf8nHKyh5l9M+mylyeqX85HYIITNxOF6CGmMJKG3W7sKvuOwaPq3QssWU
	 zJtr/dm4aw+z4vXqjmdU+w4syXJbQMwYsFs2otfeQ3kAYEjUVm6+kPjEJdwuP/ajTFECs
	 W0WhEU+KMwKjIwOZ03eCPA+BVtQ//LKwBwf0s5WEqWCmI5kfBh0R/rEjXnSA/C6lQrPP+
	 fw0KUsxpYOfjqaGCtgZa2OWCkTxQrtCz8oi641B+tAtLAXepGNxFWj9b/CsGWpryB1T2f
	 LtaX0GmCXI73Lp4ithZ4assJmbSRzFF9L9biaiqXOk/npTpyDNF7ytJkw4dUa4/Z4ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UOQi+zTg2EuTkFg2ahYqEHsllqRXz2DFRoGJ8akW7nk=;
	b=L7aEooGMllAOl5yyrDZCv/SbTg1LOQQKtxp9HxVUJQiRrOyhHX7Uo8mq4sDcGKmSugo5
	 9Vb9m+myMKlUlWTMifqp3N5fJJeNWexHe70bT0vO+wijcEHWZsEzNrHEHThEaLis8fZMs
	 ONvED1pDz+FGskOfEvJLU/8dtdyU8G6sId40mw9vQuRo00glO+NCL1YArqP1dzqnG7fVZ
	 tMd/iJaFppjPsu7jmKJIBAhbx3uTTGprJavM1Wlplu3BqPB5QGJRRR/8XQMn8tBajwNk3
	 Yq0LcGQnGas3oPR531UGAT4/WxEMI1xdgclAq/MpxLa2BmVgTDMIa8JNYxjBPLfUrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pl/kLujI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C40606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl/kLujI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A39B1F008A1;
	Sat,  7 Nov 2026 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048848;
	bh=UOQi+zTg2EuTkFg2ahYqEHsllqRXz2DFRoGJ8akW7nk=;
	h=From:To:Cc:Subject:Date;
	b=Pl/kLujI9MTsZuUE7okvPMvupa/diVSpcL4xmzldeC4eWK9+bTfIrtB5wyJhuUklV
	 5dQIf1duflEKNq4GWChqF4JPtkhfQHiCNyHsUqhLdFdVMBKkAWArVjyn4fJXj5dMHS
	 UGqEgxM820MJttp3C7sn7Xa8eQLR9jOiX1iBBlHxDAUGZhk+ZVnhJM96GZwOoW23Ak
	 kpPJITbILm0MbrsGAfYWkHxjXAMmV+8trJNvpEJJ8wQvvUcyLu2Et2b//IDzi3KdSS
	 Znq83vpdBwUXm3BlI8GYa3jXf5+2LCmaprdkja2DBeQG2LnxW3MJqUkyV6+C1cYIxs
	 gsPCxEPoJ5VRg==
From: Sasha Levin <sashal@kernel.org>
To: bvanassche@acm.org,
	hch@lst.de,
	hulianqin@vivo.com,
	john.garry@linux.dev,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: sd: Mark the disk dead if runtime resume fails in sd_remove()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:06 -0500
Message-ID: <20261107055406-failed-6.1-085bb18a0b91@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 085bb18a0b91007f04ddca13af30277c78040157
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055406-failed-6.1-085bb18a0b91@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 085bb18a0b91007f04ddca13af30277c78040157 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 19 Oct 2026 14:55:32 -0700
Subject: [PATCH] scsi: sd: Mark the disk dead if runtime resume fails in
 sd_remove()

If a SCSI disk is unplugged while runtime suspended, its request queue is
still in the pm-only state when sd_remove() is called. The runtime resume
attempted by scsi_autopm_get_device() fails because the parent device,
e.g. a USB device in the USB_STATE_NOTATTACHED state, cannot be
resumed. Hence, sdev_runtime_resume() is not called and the pm-only state
is not cleared. Next, del_gendisk() calls blk_report_disk_dead(disk,
false), which calls sync_filesystem(). Any bio submitted by the filesystem
waits forever in __bio_queue_enter() because the queue will never leave the
pm-only state and because GD_DEAD has not yet been set:

 __bio_queue_enter+0xb8/0x174
 blk_mq_submit_bio+0x640/0x7e4
 [ ... ]
 exfat_sync_fs+0xa4/0xe0
 sync_filesystem+0xa8/0xdc
 fs_bdev_mark_dead+0x30/0x88
 bdev_mark_dead+0x54/0xc4
 blk_report_disk_dead+0x8c/0xd4
 del_gendisk+0xa0/0x2f8
 sd_remove+0x30/0x60
 [ ... ]
 scsi_remove_host+0x88/0x18c
 usb_stor_disconnect+0x68/0xf4

Fix this hang by calling blk_mark_disk_dead() if runtime resume fails.
This sets GD_DEAD, tells the filesystem that the disk has been removed
without attempting to sync it, and wakes up any bios that are waiting in
__bio_queue_enter(). Syncing the filesystem is not possible anyway if
runtime resume failed, so no data is lost that could otherwise have been
written. If runtime resume succeeds, behavior is not changed.

Please note that this patch converts temporary runtime resume failures into
permanent failures. Before this patch, if runtime resume fails temporarily,
a filesytem sync would be postponed until a later resume succeeds.

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Lianqin Hu <hulianqin@vivo.com>
Reported-by: Lianqin Hu <hulianqin@vivo.com>
Closes: https://lore.kernel.org/all/TYUPR06MB6217DD31B1B3CD09E431CC12D2922@TYUPR06MB6217.apcprd06.prod.outlook.com/
Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: John Garry <john.garry@linux.dev>
Link: https://patch.msgid.link/2c0c76d70f0fe197932836b9bcf8496095135d1b.1792446921.git.bvanassche@acm.org
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 drivers/scsi/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b0d2542fd3172..dc45df819c426 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4268,7 +4268,15 @@ static void sd_remove(struct scsi_device *sdp)
 	struct device *dev = &sdp->sdev_gendev;
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
-	scsi_autopm_get_device(sdkp->device);
+	/*
+	 * If runtime resume fails, e.g. because the device was unplugged
+	 * while runtime suspended, the request queue stays in the pm-only
+	 * state and any I/O submitted by del_gendisk(), e.g. from
+	 * sync_filesystem(), would wait forever in __bio_queue_enter().
+	 * Prevent this by marking the disk dead.
+	 */
+	if (scsi_autopm_get_device(sdkp->device) < 0)
+		blk_mark_disk_dead(sdkp->disk);
 
 	device_del(&sdkp->disk_dev);
 	del_gendisk(sdkp->disk);
-- 
2.53.0




