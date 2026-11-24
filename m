Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490854;
	b=iWI7bQg+roEmiyr2r1WDd5B4vxhEtImh61SknU1tox9A7gtWfonSmP67iVjGk7xhy+TX
	 WbSWcbf6e1rmdEJT5t5FKiMa/qCWoLy9pyycIHu4nuVf0dExch0V6UDmy9PUexgPNE2wV
	 MuWhRreBeL/Numja6WxqhvmWcbOXbwHizD6TcZifNNdh/Ri3LuMfN3xazNkP7Q3rKnbUA
	 Gwc5N3lSKZ7hHbCCvTWLuonMgjmRaclnWhDlgc559P0qnsZpfHNF56yZvm2723v+3C08f
	 XlUt1JP5Skt/dbez+qj7FjMlUroz/4QU8E5+BfuSTL0up1FAH122HJdJa6HH5L/52lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CRsPULxn0TVgyaRnH2WeqzWMxmvl+M8D4wkPXB0EWCU=;
	b=bl2CUfYPRg6smpyFJqXmbke9R4y/gcJ+GrJs7pPD2uqMVYjbqT3cuZIipjdv4l1W7cDP
	 8+XOqVgAcGLdNH7XJJue7dPgRCAxUZVyLuG1zecQa772lF++o7m7LYOVSfD0Z5c5brV7N
	 CecloW/QGTPlP05E61tUUztJEYzWCuFxKqZHDzxccdaopIsYqeGduQQQ7mto4lEfTH1pa
	 +WiI9lbTDKNmVL60kVEDTFw0JA2mW3ESsOZSWvlKBxDxM7sp7M895FYYwp3tJfbwzAnMi
	 r9dX/0HGeA3paU3HYu8qtTlzURNdyFEMCWGz4JqoO+7Fs7pYqo1lQndMtDbhCz1mSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXdAkJvT;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41527606A330
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41527606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXdAkJvT
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso4088743a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490853; x=1796095653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRsPULxn0TVgyaRnH2WeqzWMxmvl+M8D4wkPXB0EWCU=;
        b=eXdAkJvT4HW+jc931UYjjdH6dPF4RFWQBbXA4uaq3q/BAPTEl9yR+7/86kxvDEVVmT
         KeNrdZHr+Y/JgEHwWXLiN6ydYDR2vSU9IecWEf/ZB2KUqxBdJQK4dca4aGRj5G9iYTgR
         LKJ1u2VUgsk0oNT9iwr/fkWZzm962CeOu1caeVgQeTsh/yGb1tNG6d2CCpEXfNNTKjEM
         7bejhVTmWiQIt8M0zY3IVFaBAs6MPVk683WxL/FrQ14eCo8CZqx75Y8sPZu8OKqSs0FU
         5EjTztpW4h9vbxb+oIWx+3LySZPq+oPNmJdr5ng7fnHFbt2NLwTErf665G5C0pgqPswf
         g2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490853; x=1796095653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRsPULxn0TVgyaRnH2WeqzWMxmvl+M8D4wkPXB0EWCU=;
        b=JAInEJcztDg1aKnIpxj60uq8/vrpFaifR4DRHxyD+fJKL9mkWhSq2CGNz/i5hlEeNX
         1Hm8UXgmebk1Yyfl5CvMaP3ITSHBmBPKZGYlhGhorvLt6bnXzfxAv7h1LkVA+J1LAF2/
         BHpFZOBDcV9lBxFSZp02b5iCebURGvXrsQ+BRuuMd0LnVHl9UsypdxqO/rZjUv6s/X0+
         0RJhCbtK9ZhaqSo4BiMXn0iOixUoIHnofhP7fJ43yYC16T1UPsK4c9HmW6o5yN33wbAC
         ZtfXgXWWo3bKROQshsCr9O8o+0gj820aspxDEH1rqaRfQSXI8AzxpuIpVxH0HhuZ+wDc
         Csfg==
X-Gm-Message-State: APuU4Z9/MUBt/xubXIquImzIr/kfHVjW3I6gogkrocgFUYxUoD/Jn9AN
	/xMBl+cjalyFkiTO/UQ57bhIF/ub21HbV+P+09Spki1DlqyI+A/RUjnrnz7vTA==
X-Gm-Gg: AZFdTZc+Pl+Vmli2rZEBo6L81LMIRMl44SzQjmIznkmXuFV7N2UvZldDaG6C4eQRPGR
	os4k/9LKCwFPHJz10zFzEdVeRAmXa3S4DCPJ92qijbbzNUHuncru6vTWRSOtcbx9vjy2bGKzIld
	9XrqA8bJUl7AoRoUvlk0qb7CaMnfPmNK87Eg2SN8Ibra36A/mZFbwtMiX2qkUQcFSKQghmfSDTk
	UG50BjYdlGhYfxAGxN8QxcF2GToLGq6mMfP2fv/zfWT/iMm+AaxOHlWgep9kGz2AOQcM29rUejq
	Sgs3V/FKsOGyiXAcGwuIu5qwj6Hk34VqaII1EgFIkUVAePYPS6qMoDmYSXYtGH5t2BO87qExbJM
	is/0qO8hN5+uNftd3DmRLSWd1MQlyT/AWEKlKpoEgHDBviJjCaJKo9hGtuGunlR/szJ0LWs6L92
	bVCR8Fvi4hGLgPojWBPA8y2AYgEn5Cg4tb0EPgVGg6tBlZdikGS0hyGtHEbQbF2kWZjsMSCGdh6
	m3KBw2VJ7htaCwYjUC06CATA7TrSAB5dkMvIjdXz4pI505dm2WUuCsjKsaULhy4sq6HnKkjbfXC
	biMc+x8dU7r7JcH8EnRTXoKL2ew3mw==
X-Received: by 2002:a17:90b:3e81:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3b41c7bc57cmr8264511a91.6.1795490853461;
        Mon, 23 Nov 2026 19:27:33 -0800 (PST)
Received: from ubuntu2204.. ([2408:84e2:440:fab2:5934:daa:c53e:abbe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b21e19fsm7360273a91.0.2026.11.23.19.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:27:33 -0800 (PST)
From: Yi Xu <xuyi0562@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	bvanassche@acm.org,
	hulianqin@vivo.com
Subject: [PATCH 5.10.y] scsi: sd: Mark the disk dead if runtime resume fails in sd_remove()
Date: Tue, 24 Nov 2026 11:27:22 +0800
Message-Id: <20261124032722.102378-1-xuyi0562@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112304-aids-poplar-61f6@gregkh>
References: <2026112304-aids-poplar-61f6@gregkh>
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

[ Upstream commit 085bb18a0b91007f04ddca13af30277c78040157 ]

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

[The upstream fix calls blk_mark_disk_dead(), introduced by
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
path is unchanged.]

Reported-by: Lianqin Hu <hulianqin@vivo.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Signed-off-by: Yi Xu <xuyi0562@gmail.com>
---
Hi stable team,

Per Greg's feedback, this resend fixes the message layout: the subject
line now matches the upstream title, and the upstream anchor line is in
the expected format and position. The code change and the equivalence
argument are unchanged from the previous submission.

Manual backport of upstream commit 085bb18 to v5.10.y. The automated
cherry-pick does not apply to this series: the upstream fix calls
blk_mark_disk_dead(), which does not exist here, and the sd_remove()
context differs. This patch assembles the identical effect from
primitives available in 5.10.y -- see the bracketed section in the
commit message for the equivalence argument and function-name mapping.
The fix builds cleanly on v5.10.274.

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

