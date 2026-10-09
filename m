Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E95448BAA
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527690; cv=none; b=LxU6wcoaIFqqicoMkG88flXR9qtu1uZj7gyFxnyeEUm2u10+k50qzjRRPnWfHOoXXGRaw8HlRPO0YGXnOlrUMgY4Anf3GaJrny0aAqhNIo2DAluCYoCATztfKcgyeOoOOkkl0U/QKvbOD+yICAPAn+5WPwkyt+mp/I1RSv2OKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527690; c=relaxed/simple;
	bh=ro/ic/vsKCEpCz/T2m2SZHX3DPlyK7OVbpXKy10IK+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WTjv9S8+XdAYaLnUI5IHIblU+dBoLWZ9lD/zV05EiC9+72Yad8SCm7Z5088+LkHcPs82NY0VR3KczlsqqQU/mg6Vfb/NTxhmFx350WFgSHUYzUlICRrg7i3LKfLfs68Y4u88bAXNhQBqxRp8GHeEJWU0WtnDatIoYeVAh3VCEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNok3SbP; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNok3SbP"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3115c4451c8so5211279eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791527687; x=1792132487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iUpYYLLItdOrvPTmFBwuTL2yJS4jOONcdBareKtSIxE=;
        b=mNok3SbPp3ormoDDiRS9hnpMA7mssCyREiYLPCWFi6rmn4nYx/I+rkkiyK3nFpTT3L
         bZEhOc1Td0zdF4BaG7i8O01P362rKCEINM2MPmyOjn9SQ1W8mWTHM2xHq3+Nt7ZzqdBo
         zEsGO6KP2lGOHx/9AIdz8jHHxOS0EYYlS9ACNRI9n61CrHS7Js6wDSMjzZrxgnr+rgH9
         y4tZaT57HpIIeP3heunkg+07DJJXBL+mrq+mwYtQ38//bSkb++9mI+NaLK6favQolMMJ
         HrCsYfoE4VlL36bG8nhawZlH3YnUYLCNHqISQGgEF0F2vrv8sQjJ3P/TIFrQFrYz1H2J
         VsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527687; x=1792132487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUpYYLLItdOrvPTmFBwuTL2yJS4jOONcdBareKtSIxE=;
        b=Ug3rUCUgMNPa0pJAMN1AJzVR4c3ya+BzAwGjIGDzEggWBUsAVil8CznmGD+CATNkhB
         /KCzeVGRqGcg5iPFKMqbTIl2BN8ST8QI5cF7G3ed1GJ1B/kFN8aIEI7D61NmbRNYLOwL
         fXa/DaGwTtBn7QNOd6pj+n2m2i5P6+abiHh2HOY6f1OWP3tERUTfa74l3LU6uqjs6N5u
         hDs58GBaAb5P0Knlm67J9xgQN7Y9olB5ESb3SXHhdqvK5LbSdnOoLLftwUCusKMabup1
         23CloJV5UH7z61O7M1pPsyEyK8ob/cSq2xlkum6vY6uUYtthZB4QgV1WvXdM9tQV7tmT
         2j9g==
X-Forwarded-Encrypted: i=1; AKwUvBx7Wqo/Ubi8JylEyijNrzr7HC2tMtq7S5E3C101Z0zXdj8fdsbSgl4G965wf4NNUyEDCOp2E0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEHrIBDHA1hWTmOyXHulyoMPUPerMul6YZqtcx1nDxfYiR/YVQ
	4BEWtptUb9iTsJoE6RojGF8GLj+sHw2nfQyTD3FcVQg0tleofBZtHjPB
X-Gm-Gg: AYBFou3jU7rHkeVfg/D/ZLz1PWebj8B92bOd6532gGNYaa+sbO3mTIUCd/QiQn1Ccnp
	U+8RbBUgrHygCTT1sh19ke2OPJinpOUZ8kR4BasUZcYusEE4/lfyt0ZQ31EejXP4rV3/NeSjV0+
	UHrhOef2/llteoU9PdRC89m5ftCuohK5XLKnVUf+a2XZFrR0zQC5bH5/LWTqXG3YT7QslVp1y1y
	QYzV+eET5wT6FxxAp2TMvOoc96ZOCcXe4K/8SzVpAL2H9H0Di09hg7Po4pXqTZZ6u9J9HSrIgbe
	4bR28kv7m+IxKhW9b2BV7dWvyzLLEUFRBzFpbWsJvNNbGh+AgUrKioA8g5NitmQoj2SMfErb/VF
	+eaG2hRPYHXdJuvvowbAQ6hWel8yd537MxIyg0FOKJBSEWVTNdi60Ke9kVDxM0cfgkgpxQG1u3W
	4LtQkaXbZVOsJlJvj0Ns5pE4Z53eCQv99pvn4MU1Q42+fGMlWT0WjypUAXspYYlk9NSAJRAj8m0
	lJeuxH5XFO6jgF9esO8emg=
X-Received: by 2002:a05:7301:144a:b0:351:7cfd:21d4 with SMTP id 5a478bee46e88-3537dfb8620mr1449268eec.8.1791527687198;
        Thu, 08 Oct 2026 23:34:47 -0700 (PDT)
Received: from XP-PC-huhb1.xiaopeng.local ([98.98.112.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca67b21sm4127080eec.11.2026.10.08.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:34:46 -0700 (PDT)
From: Hongbing Hu <huhb04@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org
Cc: mchehab@kernel.org,
	kieran.bingham@ideasonboard.com,
	ribalda@chromium.org,
	linux-media@vger.kernel.org,
	linux5-kernel@vger.kernel.org,
	Hongbing Hu <huhb04@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] media: uvcvideo: defer cancelled buffer completion until copies finish
Date: Fri,  9 Oct 2026 14:34:32 +0800
Message-Id: <20261009063432.1781-1-huhb04@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UVC driver processes frames in URBs. A frame usually is divided
into multiple URBs. The URB handler parses the header and the
metadata, but leaves the expensive memcpy to a workqueue.

At any given moment, while streaming we will have:
- the current frame with (0-N) async memcpys waiting to happen. The
  current frame is in queue->irqqueue. It has a refcnt of 1 + N memcpys
- Previous frames with (N) async memcpys waiting to happen. They are
  not in queue->irqqueue. They have a refcnt of N memcpys

With the current behaviour, when a URB completes with an error we flush
the queue->irqqueue irrespective of whether the buffers have any
pending memcpys.

There can be situations where the memcpy occurs after we have flushed
the frames and they are returned to the user. Instead, we should
exploit the refcnt mechanism to return the frames only after the memcpys
have been completed.

Fixes: 01e90464e42e ("media: uvcvideo: queue: Support asynchronous buffer handling")
Cc: stable@vger.kernel.org
Signed-off-by: Hongbing Hu <huhb04@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
---
v4:
- Reworded the commit message as suggested during review.
- Documented in uvc_queue_buffer_complete() that it may be called with
  queue->irqlock held when buf->cancelled is true.

 drivers/media/usb/uvc/uvc_queue.c | 24 ++++++++++++++++++++++--
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f44..c491735cfe 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -122,6 +122,7 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 
 	buf->state = UVC_BUF_STATE_QUEUED;
 	buf->error = 0;
+	buf->cancelled = false;
 	buf->mem = vb2_plane_vaddr(vb, 0);
 	buf->length = vb2_plane_size(vb, 0);
 	if (vb->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -289,10 +290,17 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
  */
 void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
 {
+	struct uvc_buffer *buf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->irqlock, flags);
-	__uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
+	while (!list_empty(&queue->irqqueue)) {
+		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer, queue);
+		list_del(&buf->queue);
+		buf->error = 1;
+		buf->cancelled = true;
+		uvc_queue_buffer_release(buf);
+	}
 	/*
 	 * This must be protected by the irqlock spinlock to avoid race
 	 * conditions between uvc_buffer_queue and the disconnection event that
@@ -350,13 +358,25 @@ static void uvc_queue_buffer_requeue(struct uvc_video_queue *queue,
 	uvc_buffer_queue(&buf->buf.vb2_buf);
 }
 
+/*
+ * kref release callback for uvc_buffer.
+ *
+ * If buf->cancelled is true, this function may be called with
+ * queue->irqlock held, as uvc_queue_cancel() releases the queue's
+ * reference on cancelled buffers while holding the lock.
+ */
 static void uvc_queue_buffer_complete(struct kref *ref)
 {
 	struct uvc_buffer *buf = container_of(ref, struct uvc_buffer, ref);
 	struct vb2_buffer *vb = &buf->buf.vb2_buf;
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
 
-	if (buf->error && !uvc_no_drop_param) {
+	/*
+	 * Buffers cancelled from uvc_queue_cancel() are forced to complete as
+	 * errors. They must not be requeued by the corrupted-frame policy even
+	 * when buf->error is set.
+	 */
+	if (!buf->cancelled && buf->error && !uvc_no_drop_param) {
 		uvc_queue_buffer_requeue(queue, buf);
 		return;
 	}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b6bcee4a22..1b611715fa 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -317,6 +317,7 @@ struct uvc_buffer {
 
 	enum uvc_buffer_state state;
 	unsigned int error;
+	bool cancelled;
 
 	void *mem;
 	unsigned int length;
-- 
2.34.1

