Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497394A8FFC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441166; cv=none; b=nhBzeykQuMQZu9/Z8Hz3iBV+aENz31C6ag9gCN6rVFnBTu92D5b6FxDalJSjGvSS0quOPKsUmCOPsuq3beK39ecLSMPAtQVqY7Ws6j4U+SwgW0yCUq0UAFP8H46/36zgeKMCg71Wj4mjlN8opuaYKFuAI5dk18rkNDiTn8WJCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441166; c=relaxed/simple;
	bh=6PpOaDvG7B4yvqN1w+kxiA04SVsuNsaPu4+LJMpskEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2hioXnnUj2bESCX+iO31AJy5NvZInWD7gh0tS69k4XAKIQSvmAG9UWgRWw3dHRbyPz6eY7KOo14xuqawI17HGdit3pZydmGNcXSH/xp6/1iftAEu1rpz/BBdZdAJkGOnXOlVsSkrlNG1Xy0F/Bc9CanY8mPmWS7w5HZYLvdIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8s9A9xv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8s9A9xv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so3788747a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441145; x=1789045945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=emV5n6JyzwHHJDAPrwbCGMimUu0hxMHFjSvszb+s2d8=;
        b=G8s9A9xviegaRJ1PT8In18usvKg6pbJd0MfCSZiMPT/2NnsJ1cEcxgXvuCeAS+NWcg
         fPsXczn9AEtPOeEHL6YzuMH/eftJHUcF+rNIgpoaow7D0VQ3ysf2sMDA7hug+lStG3Im
         x3pRq+/Mx74F05QU5RLW/iQyXQ+qnc62SfwbAcLsEKdzbR5Rv/xWbWkR3vZzer8P9Lg8
         jT3/beCzSwq62YNpsZzLhYKti/YOzW4v1klTMeiJfJtKBgp0SGq93hSLtIhJCHvQ2SSk
         M+baGQmiNXFEZh03+tiV5pUOnpVyeO+Uuo0UYaeKUlvgmvEmhGBgW0i+d+vDaOTGHzDW
         EvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441145; x=1789045945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emV5n6JyzwHHJDAPrwbCGMimUu0hxMHFjSvszb+s2d8=;
        b=F6mtBI8l0KkkoV5KvUUDoKKoYojMIDQZ/MzxJ77kjE+9krYFyGgJ7SsT4pj2yranwB
         YVCC43Om8N91oFisNruwBMIHldFOjF7UMUc4Lx8Ju9dOB4TfLYOvugnC2PI2PRK0Zy0M
         UHrob6Sp0smFv7YYY4p1jtxvfDtES0/FXZ5XQCUEoA3kA+CHf5dVpwUqoe1ugRUC2LVH
         BRuqzM4mwHmXdbNwmMGkzO04vihKii6KckbnNm9KOymRKDW/NW03ShTUQ6gT6djrXY7W
         2SudB1UqqDWW6HpeKrvYt64STmkmRrcKLvJE8jrKqI7K/RummcDD2vMEGBcMrRIUNd8O
         X/8g==
X-Forwarded-Encrypted: i=1; AKwUvBxXWtLFIq6KnpCF3OTYHgw6biW+BvyhwwCOxl1m3/8HaXOp2/ekRlORwuXHZnafgq6TXKDJGhw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2ihbjGHK7noi5TKZqjAL8ElDADzuz/IjYvMEdr3/EgD0znqjf
	eMoOTZj00CLn1IuSSQ9hzJB01gK8jaom8w7X+4aFz7xSpPaH4Z/WESq8
X-Gm-Gg: AYBFou32euA5voWelYANLS7PvRjGqsoF3QhisxpfmOLw6kOW0MC2K3+0pcterPA1xqv
	sDFMdECprqgOs1BBvgVxmfYOUTE5u9ggv6DrQJzZ8nDCaV4IC8GAiaWWGsr9BOm+3szdaKqEvYN
	65GtVn1BqgXQaxXcYWdsYaC69D3KP7Cnah2NnziEBukVaQJUT75JVZJrrW46MSXY4uYrgAFGkGf
	Ca/tGLx3c58HyEV/v8MBY5+p3LtuVvAKNZkRBSdRKjl9ZO51JaJXHIkP7IqMOljxAaJylgCJGqY
	GnLgbZT/+P5GBe6i8DUpp+qIqvtDsUmIDFoEHsNikYt7iktLx87WIqDiczUIHMrYY+IMcO50tWm
	aR0hQEec3Dmeryhlxyju/p4m/lXGczhSZWEdjqlaYJlAGWbq0dntkdPYIiMwsx59fu4jnb7kJU8
	k2+miKXLm/SMk2uyqzvc0xGhs9J6o5ViMRGMealpyD2Raxyxp9jylkEjq07r7Z66sBVc4OjqWUn
	gRsf7Rg/oLYrps=
X-Received: by 2002:a17:90b:2688:b0:398:bdb0:adb7 with SMTP id 98e67ed59e1d1-39aee162e08mr21243652a91.16.1788441144840;
        Thu, 03 Sep 2026 06:12:24 -0700 (PDT)
Received: from XP-PC-huhb1.xiaopeng.local ([98.98.122.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae902354asm2692820a91.2.2026.09.03.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:12:24 -0700 (PDT)
From: huhb1 <huhb04@gmail.com>
X-Google-Original-From: huhb1 <huhb1@xiaopeng.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhb04 <huhb04@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: uvcvideo: defer cancelled buffer completion until copies finish
Date: Thu,  3 Sep 2026 21:11:41 +0800
Message-Id: <20260903131141.6368-1-huhb1@xiaopeng.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huhb04 <huhb04@gmail.com>

uvc_queue_cancel() returns queued buffers to videobuf2 directly via
vb2_buffer_done(). This is unsafe because asynchronous memcpy workers may
still hold a reference on the same uvc_buffer. Once vb2_buffer_done() has
run, userspace can dequeue and requeue the buffer while the old worker is
still running, leading to the same list_head being inserted into irqqueue
twice and corrupting the list.

The crash manifests in two ways depending on the drop-corrupted-frames
module parameter:

1. With the drop corrupted frames enabled, the old worker's
   final kref_put reaches uvc_queue_buffer_complete(), sees buf->error set,
   and calls uvc_queue_buffer_requeue(). This performs list_add_tail() on
   buf->queue even though userspace has already QBUF'd the same buffer and
   added it to irqqueue.

2. With nodrop=1, uvc_queue_buffer_complete() calls vb2_buffer_done() a
   second time. If userspace has already dequeued and requeued the buffer,
   the second completion exposes it to userspace again, and the next
   DQBUF/QBUF inserts the still-linked list_head into irqqueue a second
   time.

Both cases produce the kind of list_del corruption seen here:

    list_del corruption. next->prev should be ..., but was ...
    kernel BUG at lib/list_debug.c:64!

Fix the cancel path to remove buffers from irqqueue and drop the queue's
reference through uvc_queue_buffer_release() (i.e. kref_put()). The final
VB2 completion then only happens from uvc_queue_buffer_complete() once the
last async reference is released, so userspace cannot reuse the buffer
while an old worker still accesses it.

A buffer whose state is already UVC_BUF_STATE_ERROR is forced to complete
as an error and must not be requeued by the corrupted-frame policy. Normal
malformed frames are still requeued/dropped as before.

Fixes: 01e90464e42e ("media: uvcvideo: queue: Support asynchronous buffer handling")
Cc: stable@vger.kernel.org
Signed-off-by: huhb04 <huhb04@gmail.com>
---
 drivers/media/usb/uvc/uvc_queue.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f44..9206e0a355 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -289,10 +289,19 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
  */
 void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
 {
+	struct uvc_buffer *buf, *next;
+	struct list_head local_list;
 	unsigned long flags;
 
+	INIT_LIST_HEAD(&local_list);
+
 	spin_lock_irqsave(&queue->irqlock, flags);
-	__uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
+	while (!list_empty(&queue->irqqueue)) {
+		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer, queue);
+		list_del(&buf->queue);
+		buf->state = UVC_BUF_STATE_ERROR;
+		list_add_tail(&buf->queue, &local_list);
+	}
 	/*
 	 * This must be protected by the irqlock spinlock to avoid race
 	 * conditions between uvc_buffer_queue and the disconnection event that
@@ -303,6 +312,17 @@ void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
 	if (disconnect)
 		queue->flags |= UVC_QUEUE_DISCONNECTED;
 	spin_unlock_irqrestore(&queue->irqlock, flags);
+
+	/*
+	 * Release the queue-owned kref outside the irqlock. The final VB2
+	 * completion only happens from uvc_queue_buffer_complete() once all
+	 * asynchronous copy references have been released, preventing userspace
+	 * from reusing the buffer while an old worker still accesses it.
+	 */
+	list_for_each_entry_safe(buf, next, &local_list, queue) {
+		list_del(&buf->queue);
+		uvc_queue_buffer_release(buf);
+	}
 }
 
 /*
@@ -356,7 +376,13 @@ static void uvc_queue_buffer_complete(struct kref *ref)
 	struct vb2_buffer *vb = &buf->buf.vb2_buf;
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
 
-	if (buf->error && !uvc_no_drop_param) {
+	/*
+	 * Buffers cancelled from uvc_queue_cancel() are forced to complete as
+	 * errors. They must not be requeued by the corrupted-frame policy even
+	 * when buf->error is set.
+	 */
+	if (buf->state != UVC_BUF_STATE_ERROR &&
+	    buf->error && !uvc_no_drop_param) {
 		uvc_queue_buffer_requeue(queue, buf);
 		return;
 	}
-- 
2.34.1

