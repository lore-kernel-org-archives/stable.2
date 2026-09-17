Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9259E353
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656436; cv=none; b=hpIHDUaeLg7ssSlVHwysTi4tqnMVywBybDkETrcU6mfYHKUE1tQej2AN6lSW28vOjnR+n3CmKQ+u02kVuIRb6XxHLO3dJoLg0QL0Y52yachzYz+UwHWjjATn4C07vO9WWb5giYvNKH9y/Q2ux/G8icTX1wVoY/98rra6/XoprBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656436; c=relaxed/simple;
	bh=JTVOOqBLxjQeWLPSh9xRNLuLQ6DPdJMZGlzu92p69p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiF9jMH72l0ZRhr2l0DM3psWq/8MEBjb7TAjJu5EcFDskzOp0q+mI3PfySzoEQbhRvYP/LYCgZXZuLmV8fK5M7/fTlYh4OinQ+4kAhLyN1O2PEozhjObcIflKonTIzsZA+gBSAfrmqHYCUkrCZa8kKQoyCIETM3tZQSccXWGyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0JBOogQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0JBOogQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39647184c73so722412a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656419; x=1790261219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujNOkUzuREKqEPDzBdRIyHN6iqZeIKccbajh8FSPByA=;
        b=Z0JBOogQxRw1gezvTApRdtVbTrkJRWsl9XEuS2allRheecKtWYqfb3b33YXFTRw86f
         ZF7aXPH8xIRksvjk/1XGqY3qAS3Dno8rGyfddtne4A8RVFzT3fqwJ0OdDDB457ChCM13
         bGfCSkd0Yci5GireE14feRpFCUPSwtTpD4bRkST+m5Q/j/eEv3uv3mtaqlEvxph18dVw
         HS2t4oqUEqOed0Dud9uMtPyuGLzGDVduuB69cNbfAgcA8WCujXPqFd+9AVLIFu2zQ9LD
         KNpIkxmlYRg+UIW7aOmf0cmANIJNIMMIhCkAQc3zxlRFyP8v5sd6xpH89FHch3khxpYX
         Oswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656419; x=1790261219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujNOkUzuREKqEPDzBdRIyHN6iqZeIKccbajh8FSPByA=;
        b=XSuOybBrDfH2w5V3ZcoNhRvpCxXQS3F3vx3pvbEO8LHQTlSTK0GsgsTJ6DrwwYVAIj
         NuQSUq252OfSwdprOPkeB9evYzGmkvq2761uyh4ArwHWFrBrPMFeLgAp5s9hjc9E5DOe
         fh71lCmu81E3TExdOJjROwOKskgfYbAMa/5DwWwEu9YU+9OMtfk2OCqK5DhCXMaU7sND
         oWL9AD3gKY3PU0LH0rK4CJQkfszYFgVU31FDjBGXncFtEssHsOlGT9N0y3QM1c+BUliq
         gEYcqdaQ7CpPI2rSsvlfN21YWm1iWh18fvPQJfvfPbO1vmYrTrw5nC04fj35Gqj3j7zv
         aP9Q==
X-Forwarded-Encrypted: i=1; AKwUvBznnDiFaGSyRu5NcrOM1g9epgbXfFYWWVkro1Swano49+RzMAPtg+SvJNrzHd0ZjYlMMnGgyMc=@vger.kernel.org
X-Gm-Message-State: AFuF++n75uxsVzWprYKgLkDIFhBuTzgEumHLzoMHPlfK2etF7Eu5UHgb
	NSejEbBwzrXw3orx7NT4D4Z7J0ha//ZtmkRukcVVKNz+b6FlqHdCVPq2
X-Gm-Gg: AYBFou2oBljdz2n9BDfMKAc73hpMoCdv4dUv53e9gwXQ38EgWrd6Xu3WuT4DI6XcPfE
	KebHch0g0PoPcq0pQrB/afXvdkdEsT50S24PjRs4nqGJf+t7ngKjNIuA0cj9a2SzpqOcSlCagdI
	3BvIL0hgyltoX24manR0ZAnU8McKRGsl1mekCMO9nfOkmnDEqlWhWKXCQdNrT0t8pUibJSX7al6
	LJDTSZAzZ7ORPbXkWEed+24jpa+QFnljE0tKdNsclWN3oa66XtfACnKCVNsx8zrtgjrpZpepl2R
	Rkh0cVnnUCYque8PEA6aX2vDvWGbyo3Bfzwd5bPIjK+mo6vd1lGQj7wSeAvUdHkqy0Z2cdGiaYQ
	sVf+vysyQkQF7Pjura4d3adC3gKYmUsNWNMG5hTcVkq1Il7hz0HMg11z05NDK9XAdja6KDvVjUF
	9oFLLZVaj0LD05u67HsT5gqVTuyGxha5SmNlRu+M7OGIJaPQ5KeJW2SPdPJdGR0EjIroCMWYnzg
	b1kejE4RBqtcwd8xG/vnzw=
X-Received: by 2002:a17:90a:1188:b0:39e:39a0:b5b3 with SMTP id 98e67ed59e1d1-39e39a0c33emr2951779a91.1.1789656418637;
        Thu, 17 Sep 2026 07:46:58 -0700 (PDT)
Received: from XP-PC-huhb1.xiaopeng.local ([98.98.122.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360ddfc2sm5481434a91.16.2026.09.17.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:46:57 -0700 (PDT)
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
Subject: [PATCH v3] media: uvcvideo: defer cancelled buffer completion until copies finish
Date: Thu, 17 Sep 2026 22:46:30 +0800
Message-Id: <20260917144630.16923-1-huhb04@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903131141.6368-1-huhb1@xiaopeng.com>
References: <20260903131141.6368-1-huhb1@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uvc_queue_cancel() returns queued buffers to videobuf2 directly via
vb2_buffer_done(). This is unsafe because asynchronous memcpy workers may
still hold a reference on the same uvc_buffer. Once vb2_buffer_done() has
run, userspace can dequeue and requeue the buffer while the old worker is
still running, leading to the same list_head being inserted into irqqueue
twice and corrupting the list.

The crash manifests in two ways depending on the drop-corrupted-frames
module parameter:

1. With the default (drop corrupted frames enabled), the old worker's
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

Introduce a dedicated bool cancelled flag in struct uvc_buffer,this keeps
the cancellation semantics explicit regardless of any later state updates
from the packet decoder.
Cancelled buffers are forced to complete as errors; normal malformed frames
continue to be requeued or dropped as before.

Fixes: 01e90464e42e ("media: uvcvideo: queue: Support asynchronous buffer handling")
Cc: stable@vger.kernel.org
Signed-off-by: Hongbing Hu <huhb04@gmail.com>
---
v3:
- invoke uvc_queue_buffer_release() while holding the spinlock to keep it simple
- Set/clear the new cancelled flag in uvc_queue_cancel() and
  uvc_buffer_prepare() instead of overloading buf->state. 
- Force cancelled buffers to complete as errors,
  so the returned buff->state is UVC_BUF_STATE_ERROR.

 drivers/media/usb/uvc/uvc_queue.c | 17 +++++++++++++++--
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f44..1026d7def3 100644
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
@@ -356,7 +364,12 @@ static void uvc_queue_buffer_complete(struct kref *ref)
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

