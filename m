Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5584A841B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440756; cv=none; b=XuffgDK3hkMpT4/aapHbAAqq/V/1EFVc9nmfZrzTruZ7I8kFqGQi/NVcYkwCpALOKPY3Frne71EZ7bpcdAHh/zVspP62pprnjL+3iiKFdbW+zbviJ/lpCxd6nhCa4Gw/8a0SbhXaTW2SfUqozhKsot9jnesIn8B0vb8g92sUqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440756; c=relaxed/simple;
	bh=6PpOaDvG7B4yvqN1w+kxiA04SVsuNsaPu4+LJMpskEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIEx4qUt1JnOAvDnGWf6OwAzLzQAvC3MK6H3VMdeJ98UB+Fgi9MbYXP6v25m0LYIsUEs9q0OLM/QGrQSKKlaZ7FwZId54y9qbiKUhA3JHbPoPI6+PwI3AdlI2OMNrn0ZFAj6jWvxOY/7oaYXUVHht5VTkd3BR0PdEGRo+Nbbth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDXGMQaR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDXGMQaR"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca80d708489so751217a12.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440744; x=1789045544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=emV5n6JyzwHHJDAPrwbCGMimUu0hxMHFjSvszb+s2d8=;
        b=gDXGMQaRpCFxETI1E3aU6lRswqrzvQTXw3s11hX3P+srbtrN9AyHceWs+JoZaEkWBQ
         J/D9acb44w9hqcY7cuvDop0dr7DCFVpq1qnzGLQLm/vIYamMs+TCsIwyPcWdj84DG3PZ
         eVspaRPIRUvGx+UPsERG56tHbFC58R2i3tuWUTuuKD2dhEPcDBCAFw6y5l1kr8OTvo3X
         tpII9Pc63rgnbAWxhbBRq6zUNAIw4TLHvE1TSQpixqxLuTu9JZFgNKR92uai77MMHvCb
         HLyMeVe1grCfGjfxJPsYNsHtfqpKetyUWsoZqsBmuc64jhGFS7iay/yOLYR5VhTTk/+C
         dTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440744; x=1789045544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emV5n6JyzwHHJDAPrwbCGMimUu0hxMHFjSvszb+s2d8=;
        b=ZXaMdIy5GHN26kI2v8SOuZLlUpAE6TYqv4PolqY0dBK+qk+E3z7JoURfZUMMXB6fPS
         K7B8gy25PvzQp/4wLBPoiVf09M61YPSSYXQDAhIYnhKBf4E4lW8OJ+9jKHxMdv4LtrzZ
         f3wwZl7rb4ua2UgTjcy19INggwaLHxqZJsMEDpTt9/dmFfsLgiLeIlP+1rEVYc7GtOrD
         Qg7OC47ltjGWtbaLwKK97dLRDQglbluLQAIC65eZojrx50vtZfr9TuV+TAknwWxkhE4N
         iJWjKipPFVfwA54yAdeRS2FNO4xk1rJd6Lqw5CBPV7yvJYqdO1n0Sm2zi7FZcBO5GH0d
         LQ0g==
X-Forwarded-Encrypted: i=1; AKwUvBwN6JrdCADmcrjoqsm97jGOKwur4RKfNPQjRmta1cN0LAImFRuvMTRncX97/l7mvK5Qn/7pAvI=@vger.kernel.org
X-Gm-Message-State: AFuF++mRL2HkewqFN2il/GLNny5WGwiO5w5Oaw2EditheqPUpsJYLlUU
	VZljRiQ2Y17+ZxFqPPGhjJ4xVS3ITfbr5QCrHbvclwLmG1DbYMJe34rnQtrKArtSrWE=
X-Gm-Gg: AYBFou05DBoOQMS45o9/o0fpOvT7idB+53sMUiOOCbZ8VJ1vrYDw6Vc32AWGptJoDtO
	0mk3fmYrVXO6R789s/Dz2QYodn5aCBI2iGel43cm+Ftlw5YJHjO3JGap3V8yL9e4Rl1u56i6kV8
	/4vHH3GnWa90Xw2xefHASmZnNUvjl2dPA1HBt981RRyQfjMzNPuHJJdTxi42DStrpOVdyWPE0iF
	V238kYaWz3hpxnIRV2dSOgCrJl3QpKQW5l4xNRbWbc7WVmAX63PFKLNp23R7j68Y4m6LnndsF7G
	FDv1gF+qzzSh2m6UhYWj+kwN4/UvT8zep/C7NnEXnOFyxNHir3HEU3vvwREKOznvSt/6+b4GAfv
	/zbYdSEUIWwg1jvNCDG0Tpu7p4l2e684sgtMygKiRb5zY/ef8Hb7KNwUavYB9LuXrDYL4JWvQqH
	BmpTXPsehWH+Q3Kyd982C2o3K2jMgFM+CouTkX4s4D1FG4w217kYQ5+puIOxhAxzurP6OHS0baN
	uXaIxLPFLZlNn0=
X-Received: by 2002:a17:90a:e7cc:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39b1329649emr2677952a91.10.1788440743516;
        Thu, 03 Sep 2026 06:05:43 -0700 (PDT)
Received: from XP-PC-huhb1.xiaopeng.local ([98.98.122.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm5383581a91.6.2026.09.03.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:05:42 -0700 (PDT)
From: huhb1 <huhb04@gmail.com>
X-Google-Original-From: huhb1 <huhb1@xiaopeng.com>
To: huhb1@xiaopeng.com
Cc: huhb04 <huhb04@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: uvcvideo: defer cancelled buffer completion until copies finish
Date: Thu,  3 Sep 2026 21:05:34 +0800
Message-Id: <20260903130534.6339-1-huhb1@xiaopeng.com>
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

