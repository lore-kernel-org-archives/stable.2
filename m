Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795800749;
	b=wW93MfectSvX5+ErUMLicAPoex6o5zgKeSynFfp3+MPYxXSDYhLEtVr+X1s0bvjFvRwB
	 lb0x6t5bpFNpHGlcalm6Ah1RExBjT6HJ5UQIJvy4oRKllYUGaXVmsPpd38CmRa/NaWhh/
	 un8+vdsF1j1lnlkH5kcSnYcBM9g099axT/TKLb/qx4uip34/lLXwsf2hef4E+Fi499Uik
	 +xull8QKZWznab3JnBjI/1VJUeY/aNL3NCDKbJ6IlW6KF9MuS/Oku7JGjql438l1aeujv
	 vCsIgCrLqcyPue9s5eCQHcskRrJxjznnEEDE0Qv5G5jQVO7qvEXA0QRO+USQ9ehZ/mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800749;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=iCpoocpVVqHMVz2hK59wluLtdtwP7vh8yiHdoFG/Fds=;
	b=h60vYygK/ZKZxgrJg8KbaxvPvQjsNPMVSNykvDpDbCdLA+CYrj+TNwuP1jhB357MI9uI
	 0Nr9txyRaotVRKQsWPHywJU91QB0monaxAR5qxvoV5NiQks/U1h8pE2sEBivPIgqUfLtV
	 2j+KQ3z4ADDQBK13RHbsagyOmSsBoVgQzjlh5xmpnB06IFFgn3CIBODWsd3TvW+KEuNta
	 OrTguy/JNfuOMUhna4KcnL8LSOjaa4qgIup0kA2VgSPPZvjVLX+PjqDkI/bDrFHpujrwg
	 t8XZY3uH1uzne8pWbH3hWdZ3P/anl5c/iSI0S4rNqIIwB9ZeiR/rymFCGdk89xq3j8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GjkBa/6v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0297606A31C;
	Fri, 27 Nov 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjkBa/6v
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795800749;
	b=L42qsUQJ1y/j+KFWFlvOIJapCvbWmGQxfUEKyWviVbed32uABgy+wvpBDdXuN5AY9czp
	 j/kONHHN+HOgEPKLAeiw7JVRCRJD5DgkSS1bShHFKkhAG3bPpRZt4eY+Dr8oLPssBB02I
	 0+KfHQXCBqdq4jEk/AlfuxqPVlTEJ6/+W7JwLLfPG0Ou4ixPzIl5RMFTjeCS0vGm2txKr
	 jaEr5MiVbKKecOq8Bp3DdjHCAuZNLAn0M0lVDeO2ysSg9bB3wm/Q4StCr4opkK6EXZcNe
	 dbAwe4ENquqAjrua0Cqu5jklvGdHAERNCRYm1BReCC1qOIlT50HDYYWPKxu+u7jDUtA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795800749;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=iCpoocpVVqHMVz2hK59wluLtdtwP7vh8yiHdoFG/Fds=;
	b=a4dt85LiYjJAnAnHGR/nq4d3GkMKYoBkNHsro2O6nJDDc7D/QMG8pyqEnCBR9SPBT3t8
	 MsyEWPrwWCguepvmv06WrlONV0mHAUKg3h1ADNsCopYupraAGDHb2Z1QymA5r+zgKv555
	 jRRCtPrXOw4MVv2goMPvo7jYJtNfjEUP8MUHnHmPb+aOeOv1D8mbjT+LgfOmV992wsZTc
	 E1x6yHLNJxHXQGG0BFuop7haXtIINTIJl5tn+Va909XHuNU4CdfBOjj7+TizRJZxcVZu2
	 rFrlsDgKjaNDD6s0sXvq0mVr229XT/IqFNYRWLMXIoIQ/VAsh/N33edCNYy9t4+SaYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 511511F00897;
	Fri, 27 Nov 2026 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800749;
	bh=iCpoocpVVqHMVz2hK59wluLtdtwP7vh8yiHdoFG/Fds=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=GjkBa/6vt0/Im7dUHIU8vorcGu/CcEaHM9ynokdjSzy8EATwO6R9idpfTXfai/+AK
	 Z5DFobh/F6KwsqouezCIRyMUQC2ThR0OwE8sYjBm0PQjrh8fQRqo6xUqnfkF2wipQL
	 WqYdaCGT2p9CRH6iPH+4nknk1I7UfRRc2Mg2fiHrSccIGgRFMp2UYfT3qnbI8+ZV8g
	 8H3IAHJqO5wZFhWa5jEzOzwz1plV3/elSrKhQh0tb9oSPhjtCo2uzx24gY3ZBQJjp5
	 tOQMRQ+c7aL1gzmF4cVrxP0gJ/7UuXnnbvwrQIioz/oITjkdl8G3yVWaKqRdSnvkb9
	 zZcgwr5r7TGgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D3EDC4DCE3;
	Fri, 27 Nov 2026 17:32:23 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 17:26:44 +0000
Subject: [PATCH 6.12.y] block: Remove queue freezing from several sysfs
 store callbacks
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-blk-612b-v1-1-07924ada0464@certik.com>
X-B4-Tracking: v=1; b=H4sIAFO9CWsC/zWMQQ7CIBAAv9Ls2a1CIxq/YjywsFq0AcPWpqbp3
 wWNx5lMZgHhHFjg1CyQeQoSUiygNg243sYbY/CFQe+0UUofkIYHGqUJ993RkKHOe2Io+TPzNcz
 f1RlMq3T7hsvPy4vu7Mb6qSVZYaRso+urEo5+TGnA6rf/P6zrB8f3bl6dAAAA
X-Change-ID: 20261127-blk-612b-5386b6b3ddbe
In-Reply-To: <2025122946-opt-excuse-6662@gregkh>
References: <2025122946-opt-excuse-6662@gregkh>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
 Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795800404; l=6857;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=mgnMvUxtXsZfwZhNhKxk6V5OQWLXLPv1gwtIFRV02AY=;
 b=BOZkfvmk6IMO9zxRsiKOPeDmGEcsKS45Y8VNn/vRc8ugIKC/zti8+kw/lfwb05go1xEEtkruh
 tsRCLCyoEr4BNde9nuR/HOdMDpJbQ8DFVdEORBslFfJrZRU9w5NKM+e
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Bart Van Assche <bvanassche@acm.org>

commit 935a20d1bebf6236076785fac3ff81e3931834e9 upstream.

Freezing the request queue from inside sysfs store callbacks may cause a
deadlock in combination with the dm-multipath driver and the
queue_if_no_path option. Additionally, freezing the request queue slows
down system boot on systems where sysfs attributes are set synchronously.

Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
calls from the store callbacks that do not strictly need these callbacks.
Add the __data_racy annotation to request_queue.rq_timeout to suppress
KCSAN data race reports about the rq_timeout reads.

This patch may cause a small delay in applying the new settings.

For all the attributes affected by this patch, I/O will complete
correctly whether the old or the new value of the attribute is used.

This patch affects the following sysfs attributes:
* io_poll_delay
* io_timeout
* nomerges
* read_ahead_kb
* rq_affinity

Here is an example of a deadlock triggered by running test srp/002
if this patch is not applied:

task:multipathd
Call Trace:
 <TASK>
 __schedule+0x8c1/0x1bf0
 schedule+0xdd/0x270
 schedule_preempt_disabled+0x1c/0x30
 __mutex_lock+0xb89/0x1650
 mutex_lock_nested+0x1f/0x30
 dm_table_set_restrictions+0x823/0xdf0
 __bind+0x166/0x590
 dm_swap_table+0x2a7/0x490
 do_resume+0x1b1/0x610
 dev_suspend+0x55/0x1a0
 ctl_ioctl+0x3a5/0x7e0
 dm_ctl_ioctl+0x12/0x20
 __x64_sys_ioctl+0x127/0x1a0
 x64_sys_call+0xe2b/0x17d0
 do_syscall_64+0x96/0x3a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>
task:(udev-worker)
Call Trace:
 <TASK>
 __schedule+0x8c1/0x1bf0
 schedule+0xdd/0x270
 blk_mq_freeze_queue_wait+0xf2/0x140
 blk_mq_freeze_queue_nomemsave+0x23/0x30
 queue_ra_store+0x14e/0x290
 queue_attr_store+0x23e/0x2c0
 sysfs_kf_write+0xde/0x140
 kernfs_fop_write_iter+0x3b2/0x630
 vfs_write+0x4fd/0x1390
 ksys_write+0xfd/0x230
 __x64_sys_write+0x76/0xc0
 x64_sys_call+0x276/0x17d0
 do_syscall_64+0x96/0x3a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: stable@vger.kernel.org
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adapted to 6.12.y: skip the freeze in queue_attr_store() instead ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This failed to apply to 6.12.y. 6.12 still freezes the queue in
queue_attr_store() for every attribute, so instead of dropping the
freeze from each callback, this skips it in the dispatcher for the same
six stores the 6.18.y copy covers (read_ahead_kb, nomerges, rq_affinity,
io_poll, io_poll_delay, io_timeout), keeping sysfs_lock and the NOIO
scope. io_poll writes are ignored on 6.12 anyway. It also carries the
WRITE_ONCE()/READ_ONCE() rq_timeout accesses from d23977fee1ee, since a
request can now read the timeout while it's being written.

Tested on 6.12.119: allmodconfig W=1 of the touched objects, base vs
patched, no new warnings. Both kernels booted under QEMU/KVM, and on
each I wrote valid and invalid values to every queue attribute of 11
block devices during NVMe I/O (461 checks passed on both), plus NVMe
polling and rejected poll writes on a RAM disk. I didn't reproduce the
dm-multipath deadlock itself.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 block/blk-settings.c   |  2 +-
 block/blk-sysfs.c      | 26 ++++++++++++++++++++++++--
 include/linux/blkdev.h |  2 +-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d72a283401c3..1a173d443750 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -21,7 +21,7 @@
 
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
-	q->rq_timeout = timeout;
+	WRITE_ONCE(q->rq_timeout, timeout);
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d53ffff112ff..2b0dbbe45f20 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -88,11 +88,22 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
+	struct request_queue *q = disk->queue;
 
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	/*
+	 * The ->ra_pages change below is protected by ->limits_lock because it
+	 * is usually calculated from the queue limits by
+	 * queue_limits_commit_update().
+	 *
+	 * bdi->ra_pages reads are not serialized against bdi->ra_pages writes.
+	 * Use WRITE_ONCE() to write bdi->ra_pages once.
+	 */
+	mutex_lock(&q->limits_lock);
+	WRITE_ONCE(disk->bdi->ra_pages, ra_kb >> (PAGE_SHIFT - 10));
+	mutex_unlock(&q->limits_lock);
 	return ret;
 }
 
@@ -342,7 +353,8 @@ static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 
 static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	return sprintf(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
+	return sysfs_emit(page, "%u\n",
+			jiffies_to_msecs(READ_ONCE(disk->queue->rq_timeout)));
 }
 
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
@@ -701,11 +713,21 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	}
 
 	mutex_lock(&q->sysfs_lock);
+	if (entry == &queue_ra_entry || entry == &queue_nomerges_entry ||
+	    entry == &queue_rq_affinity_entry || entry == &queue_poll_entry ||
+	    entry == &queue_poll_delay_entry || entry == &queue_io_timeout_entry) {
+		noio_flag = memalloc_noio_save();
+		res = entry->store(disk, page, length);
+		memalloc_noio_restore(noio_flag);
+		goto unlock;
+	}
+
 	blk_mq_freeze_queue(q);
 	noio_flag = memalloc_noio_save();
 	res = entry->store(disk, page, length);
 	memalloc_noio_restore(noio_flag);
 	blk_mq_unfreeze_queue(q);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 33f5b16c0fd9..eb60179e3b36 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -460,7 +460,7 @@ struct request_queue {
 	 */
 	unsigned long		queue_flags;
 
-	unsigned int		rq_timeout;
+	unsigned int __data_racy rq_timeout;
 
 	unsigned int		queue_depth;
 

---
base-commit: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
change-id: 20261127-blk-612b-5386b6b3ddbe

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


