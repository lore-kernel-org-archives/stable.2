Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427113;
	b=q5/22Eir1qH2d9ShOouKeYb4dRG2JaGM5d9iFWql0aZo1AI8SbFXa7H+VedpiUhdhkSW
	 qrb92t821Jcuj1Aa0IXafmaGex4xhynP7S7pdMXVLTGQnzkFJMvfThILhma9ZH8P7HO/K
	 3UtmvcctHS0o6SrCIMqKjA7XFCmrENUs7B/BWEWjJjPBzx9ITVC3QGC6lVm8UZaIfKZUk
	 Fa+Hc/KtOKiM0tau59lzSqCqhf+0FnzIB7BmZcBMFuSuYeV4rJqEC6ep9KaN+mY9Ab3+D
	 yxZ/wyzuEF6jWGOYCyLPZKFxOWdJ6C9g9bLTLcZ/k0exCaav8rK9788LwB0hqaRCE0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0zL8XviejO9xBr0TL41CqDnE+RdbwujCPFmxaJiXRTA=;
	b=towPyfbtOED5K0YCMJ4BsaXMM9NNZIKovKs2mdSiipZorZGc7Qqty1xeZqk4h/e/bAi6
	 i/OMZBQcPikzvz7ZYK6hzuozwvIFwXWgQiYX9kUXIne525BQ5TqAK947ZMqr0xGWz1DPz
	 m+I+aqxxY7MqPnWovnDX9EbQ5KJOFRsJlONfkTwFODENubKQPeflxmdyQ1/STYy1asKQx
	 ea8fnMfyFle2r/M3Sd+rGVICZG6SlqFyQF+lYLku1hf3Gu363JX3O1Psb5T7eRlJWSMM7
	 opUw93c5sht+fiiZOp1dSVyDL8/Pgs7Jg98Jlpn1rcGTa4tqEXjPnmoIRKYZRYYwxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGTBjQC7;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BE606A32D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71BE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGTBjQC7
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso1207279a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795427112; x=1796031912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zL8XviejO9xBr0TL41CqDnE+RdbwujCPFmxaJiXRTA=;
        b=ZGTBjQC75kQPE1nTLjGjXlcS1I9MSEKoOQoVWLPn2mnceok0//8h8bnL8YRTi7mT5k
         lgzodzFX1u7rdTSOXYv+F4cbrlg9jSv21wD7Cdv+yrtCNDJsXF0RIDbKif3a4ukJcsfX
         xKLAGxJd0z4L5MxjEZBWCb6pw3t32rLDe8bnZdFPISxb0hY+0oNVUAC9WVR3Jh15QMbG
         Dm3JifndLkYNYUB2pK8gv4ivpVxDRlxrq8pICYROX1niPLV9FFRETy47noGHmMhQYZXW
         sDXlLXq994GPenb2Mi1CyQrYfmuGLLNncpXZpS03MAzUo299wZ6581pokQNOaw2GAhSM
         5mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795427112; x=1796031912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zL8XviejO9xBr0TL41CqDnE+RdbwujCPFmxaJiXRTA=;
        b=ZDxE7vesvviTeCYgSbYN1r4cwMBtpINCxeH6/AtB9J7gZbKezk0KOdGrHoFyDQpyMO
         CtxSDN3sDUsEL6RV2VoCR8uZKq8W4NU+cPY1KbE2t0GcPJK/BI3Z1jn7rOnVzOXyj2gf
         UnW5DGOosjuJy/KKxVrQKiaumyYVcp05zWT4z1HzczuP2FKAj1JaSqq9FwUZ4nSfbxxC
         QgK9OW+1Q/4hBasmJgrlAhy1r+pijFtgdyhu2QM7AqET5VPwfJhWyFjkQQdzDO0Y9+vx
         XP1RJMu9EghHmCQaFxFemHUFI3ObCU6jGyKPBWDeq3Q1/RhbqL0fGegfLXOYcVeLGP0O
         VETw==
X-Gm-Message-State: APuU4Z9pHEQ7VzpoiyDyw2ma7/N3rLnXgOQkq5uJ3FQvFFfrZBHH29z6
	SwcVm7epLb29HTh3OmbgosWgFAaAfUwF6VCCtumLqCaqzQQBnga6PZHZ7eDEDYmqb1k=
X-Gm-Gg: AZFdTZfCeyXmsDyjEoIo8pkQnWkom/5xEcx4MMXX+Lj5elWImVmcxwdjze6+mrCGoBe
	1wn5rVsI4eiCc9L8lSzez+BnINym6mvxNw+e/vSJACZ5pEWPtvkQxRpaHGDPiXX4E6pi0yPJDqq
	aeMBMnEnngjbhGYODtLUcRP5bGV9cobnGydKRrt+lVwjY8NywtE5AaFPeZ2yZ15HLFIbLQ7XaFK
	1NXsMXP/X90cu+/GMu2xjNtcA7cDAF4Q6q76UPwx5U1A2M6pyg+pAdfdfOeG6YvlZg5u/TQkp+F
	dYIARYZnXYCOU/iD2AkzVariuFUFYKC91D+iNdRXkG/V1Eezb7Kq4uu8ZwXUYIaOG0Jkl72IHsf
	LttypqymSCd1I7ydVrDZzM53B57oovfprYhhXqklv6TiwOTPvl0G6eGIqSlQO5E51Ci10ZPwQq7
	zroCAHdIti57JFUcO5T9qkD4zD3E8sSskr/d25LRzkFVlnmD3XeCX+PVVDFo7kBqjouuKMoStxC
	0sjk72pYCFaJqLiIwt001Kxkl8vXGFNNsgHdNT4C71yaqmqHYP0LJKgCdU/dwUD/BEC55k47J9+
	nvY8uJeY3dL9oixU3e59RwMeai4oQQ==
X-Received: by 2002:a17:90b:3e81:b0:3b0:a9de:9884 with SMTP id 98e67ed59e1d1-3b41c92a389mr8446106a91.40.1795427112081;
        Mon, 23 Nov 2026 01:45:12 -0800 (PST)
Received: from ubuntu2204.. ([2408:84e2:440:fab2:61fa:77dc:5412:3c2b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm6083192a91.9.2026.11.23.01.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:45:11 -0800 (PST)
From: Yi Xu <xuyi0562@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	bvanassche@acm.org,
	hulianqin@vivo.com
Subject: [PATCH] [ Upstream commit 085bb18a0b91007f04ddca13af30277c78040157 ]
Date: Mon, 23 Nov 2026 17:45:02 +0800
Message-Id: <20261123094502.44729-1-xuyi0562@gmail.com>
X-Mailer: git-send-email 2.34.1
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

scsi: sd: Mark the queue dying if runtime resume fails in sd_remove()

If a SCSI disk is unplugged while runtime suspended, its request queue
is still in the pm-only state when sd_remove() is called. The runtime
resume attempted by scsi_autopm_get_device() fails because the parent
device, e.g. a USB device in the USB_STATE_NOTATTACHED state, cannot be
resumed. Hence, sdev_runtime_resume() is not called and the pm-only
state is not cleared. Next, del_gendisk() calls invalidate_partition(),
which calls fsync_bdev() and thus sync_filesystem(). Any bio submitted
by the filesystem is queued through submit_bio() and waits forever in
blk_queue_enter() because the queue will never leave the pm-only state
and because the queue is not yet marked dying:

 blk_queue_enter  (wait_event on mq_freeze_wq -- HANGS HERE)
 bio_queue_enter
 __submit_bio_noacct_mq
 submit_bio_noacct
 submit_bio
 submit_bio_wait
 blkdev_issue_flush
 ext4_sync_fs  (sb->s_op->sync_fs)
 sync_filesystem
 fsync_bdev
 invalidate_partition
 del_gendisk

Fix this hang by calling blk_set_queue_dying() if runtime resume fails.
The hang point is the wait_event() in blk_queue_enter(), whose exit
condition includes blk_queue_dying(q) (i.e. QUEUE_FLAG_DYING set on
the queue). blk_set_queue_dying() sets that flag, freezes the queue
and wakes up all waiters on mq_freeze_wq, so the wait_event exits and
the pending sync bio fails immediately with -ENODEV; the removal then
completes instead of hanging. Syncing the filesystem is not possible
anyway if runtime resume failed, so no data is lost that could
otherwise have been written. If runtime resume succeeds, behavior is
not changed. Make this change in sd_remove() instead of in a SCSI LLD
such that it works for all SCSI transports.

Please note that this patch converts temporary runtime resume failures
into permanent failures. Before this patch, if runtime resume fails
temporarily, a filesystem sync would be postponed until a later resume
succeeds.

[Deviation from upstream]
    The upstream fix calls blk_mark_disk_dead(), introduced by
    commit 6f8191fdf41d ("block: simplify disk shutdown"). That
    helper and the GD_DEAD flag do not exist in this series. The
    v5.10.y equivalent is blk_set_queue_dying(): in this series
    blk_queue_enter() (the counterpart of the upstream
    __bio_queue_enter()) releases waiters on QUEUE_FLAG_DYING, and
    del_gendisk() itself marks the queue dying later via
    blk_unregister_queue(); this fix only moves that point ahead of
    the hanging invalidate_partition()/fsync_bdev() sync. Function
    name mapping vs. the upstream message: sync_filesystem() call in
    del_gendisk() -> invalidate_partition()/fsync_bdev();
    __bio_queue_enter() -> blk_queue_enter(); blk_mark_disk_dead() ->
    blk_set_queue_dying(). The trigger condition
    (scsi_autopm_get_device() < 0) and the "temporary failures become
    permanent" trade-off are identical to upstream. The normal removal
    path is unchanged.

Reported-by: Lianqin Hu <hulianqin@vivo.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Signed-off-by: Yi Xu <xuyi0562@gmail.com>
---
Hi stable team,

Manual backport of upstream commit 085bb18 ("scsi: sd: Mark the disk
dead if runtime resume fails in sd_remove()") to v5.10.y.

The automated cherry-pick does not apply to this series: the upstream
fix calls blk_mark_disk_dead(), which does not exist here, and the
sd_remove() context differs. This patch assembles the identical effect
from primitives available in 5.10.y -- see the Deviation section in
the commit message for the equivalence argument and function-name
mapping. The fix builds cleanly on v5.10.274.

Background: the problem was reported against USB storage surprise
removal on the linux-scsi list
(https://lore.kernel.org/all/2c0c76d70f0fe197932836b9bcf8496095135d1b.1792446921.git.bvanassche@acm.org/);
Cc'ing the reporter and the author for visibility.

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf

Thanks,
Yi Xu

 drivers/scsi/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index da6df9809b0c..6cf56b936f14 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3545,7 +3545,15 @@ static int sd_remove(struct device *dev)
 
 	sdkp = dev_get_drvdata(dev);
 	devt = disk_devt(sdkp->disk);
-	scsi_autopm_get_device(sdkp->device);
+	/*
+	 * If runtime resume fails, e.g. because the device was unplugged
+	 * while runtime suspended, the request queue stays in the pm-only
+	 * state and any I/O submitted by del_gendisk(), e.g. from
+	 * invalidate_partition(), would wait forever in blk_queue_enter().
+	 * Prevent this by marking the queue dying.
+	 */
+	if (scsi_autopm_get_device(sdkp->device) < 0)
+		blk_set_queue_dying(sdkp->disk->queue);
 
 	async_synchronize_full_domain(&scsi_sd_pm_domain);
 	device_del(&sdkp->dev);
-- 
2.34.1

