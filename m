Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521969;
	b=OXWNY3Vz6agg7u5Oqfmov2upvrgc+BeX7dI1diiNaDCX8NR5IhLktUEKSJveh0q2PFmm
	 oAtOulQrxL94rfubI7uR9lCTpBOsgVGWfEhnHeiyLwvaQMiBVNs4lJl0K100dgQiCLPNn
	 xzcXwEZxi4TwPaLQzT1cyrMYSn1Dv+HBTMM3fgHWQhPArti5LC7LRmy/ZiKzVicRrkada
	 UQXls78PAqqiYo5k6PtKB9dvwRVQsAKNOp0RgahduHmMgMiMVdfVrX4xIOUQHTOgj6fDr
	 jsSatNQUSo19m4w00zlKrKJXXNyHQX5x+FFdPaXwduIOw6+KEMLyHdtsCB357Khs/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FowArMSorhehwd66hZPNEOpPYmolYsFPd3fHPYFoqLg=;
	b=CypAuOiroExOWmv38LM/1vN/shHfJkWIfT8snfOOAMCsMQ/er2hO9uYOysqOrRV0t91x
	 pBKks/BhwhP+NKC21OegrVtlt7Xd+7lXOyujscU7dEGnYZO6CV2I20WMyoAiUnLkYocjC
	 3kK+73og3e3GJs4unJuPhNldEuU6XMa778mZf89Tzk/uvHZ6yxgAcw2ae6XNoUD6ZNDET
	 WkyP9qSm4QqeruxoyxKgZbGtRhmbEyABEDu4DYNzcV0up4rqlTVGXf1ys9i2GMtEM/qLE
	 XVUcs4GNatmGuLDCQ4favmBzKz//6xbUwigY5kGpYJporvMWngwwE3ew2viZtEZzrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="NcUeM/a2";
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C133606A339
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C133606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NcUeM/a2
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso34166291fa.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795521968; x=1796126768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FowArMSorhehwd66hZPNEOpPYmolYsFPd3fHPYFoqLg=;
        b=NcUeM/a2llWn0/CpChtJnRNTF4yDcB1QkwvEu8HXRj2Q1GHRynF4I/P5rBLWGpV27v
         IPKudErBDxhqvlf3xOVaSG2DYfbHDO4kyc88Eds6yYkAEwlNMxqstb96t1HCbuSKaRWM
         ljuGqoKRQaDrP5kFtxKw3A2oQuQWxaY8iOJ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521968; x=1796126768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FowArMSorhehwd66hZPNEOpPYmolYsFPd3fHPYFoqLg=;
        b=ZRo6YqEPoJ30/bcW+a6rwlZeH8d9z8uhoKhmVFx+yif+qK9fUtYu8igq+nuDu9kSuh
         1sFw+/UtMtXj4b0Ts8hxsnN4w0439IEEC7J6ytWiCF+Sg/Beh3NwFzZalUqDDhkogWg9
         PeKF0XB0VZ/RGLtecqymnvownsDgp++J1kTYyANtNvvXRYbAnW2Io3PXncnLBsUHkO/b
         vhRzqct6u4mfb7CyWTWU9mrY6FWUR13brMkm0fCioTjHvO8ZtKrMtOR+58x5XfzUH6sy
         GgQUDxXwXhGKeJdclVAcG/qOWtbJ05JLUvbJZNoP31R70Jek76tIhza0D4VYO8JvHldJ
         /Dow==
X-Forwarded-Encrypted: i=1; AL+hErG/dCqxMH1OFS5cwLx8d7D066FE6dq6IOVEQwfhEfUIOqgX8LZy9nCuO8NNKLavVqBFU7z9vr8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LzkIhEjUIb56b3of4G0cyX5YPmMMQ+t3NgCjg/5Fqw9CY4SnK
	tHNr6T4TwrxeYOHGTEz7WeKiogapAFucoZB3cue56LYh6nJV+qWT2sK0k1mv9RYOlA==
X-Gm-Gg: AZFdTZcxiaMBV2InYs/YCp4kbycXaJ92ltFmgvvVvP19L8Qp53vYebJoZ7pUPEfpYkd
	HZBbaVr6tVV4XLnb5MQNRwGnhgVrMt4v7TPp/nR+dgx7wQ8ScIG4UERR97jBSkOqvWG6v7aG/wx
	RzS42W8P5qO1ilubiX23+CuRAG5biAmgmZIbYVqPfcKnK+biCNJ6ecoyf2hkAV776hEzM+3AQU2
	+HnYfy06YsFlC8Jx25NP7yxogvDzC1f0z+RZe/zvXGOdg/2dJ+GjGZgSHHH6oYqutzzvLsKI+KO
	FQw3y+uGzv9OF7cSNDSR1xeJg5SGLfQbIyGx20yuWaFD3wfXJF4V7Xyge83LTUon7z0TbUfuunG
	GzIOOffnT0PhNwYJnC/i0ThYMfr+hBlvx/T+of8RNjZn/9m00niJNPn3SPhaG65n6NM57ADvEiA
	D02QLWygIprQJWhC6bxCANPoGmspScFMXOUUHQeHpoGLGze5j3psfYmQAO2/YdIJPUTdmMn6Q46
	DV254n/5cYumKC9VPv/tx3ZT5o3oGE/j3MiCzDsYETCOMLs3K59rq6TUkAWn6D2clR+IwfeHeEJ
	fb7/ldxCVI1m53vrlm5kok1v3gc5C00pXUe53ukpqHSrfbFS43mEN+ghd+AX4f2Qo9jHy0yFHkY
	jQ8Dw0vNVGw==
X-Received: by 2002:a05:6512:b88:b0:5c1:4cab:2ce4 with SMTP id 2adb3069b0e04-5c1bc84e055mr4936072e87.42.1795521967663;
        Tue, 24 Nov 2026 04:06:07 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd01772esm3654675e87.39.2026.11.24.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:06:07 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 24 Nov 2026 12:06:04 +0000
Subject: [PATCH v3 1/2] media: uvcvideo: Fix race condition for meta buffer
 list
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
Message-Id: <20261124-uvc-racemeta-v3-1-f82822cbadb3@chromium.org>
References: <20261124-uvc-racemeta-v3-0-f82822cbadb3@chromium.org>
In-Reply-To: <20261124-uvc-racemeta-v3-0-f82822cbadb3@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Georg Neis <neis@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

queue->irqqueue contains a list of the buffers owned by the driver. The
list is protected by queue->irqlock. uvc_queue_get_current_buffer()
returns a pointer to the current buffer in that list, but does not
remove the buffer from it. This can lead to race conditions.

Inspecting the code, it seems that the candidate for such race is
uvc_queue_return_buffers(). For the capture queue, that function is
called with the device streamoff, so no race can occur. On the other
hand, the metadata queue could trigger a race condition, because
stop_streaming can be called with the device in any streaming state.

We can solve this issue by introducing two flags, stream->meta.streaming
and stream->meta.in_flight, protected by a spinlock. in_flight tells us
if the buffer is in use by the irq handler and streaming lets the irq
handler know if the metadata queue is streaming.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
Reported-by: Georg Neis <neis@google.com>
Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 30 +++++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_video.c | 30 +++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  3 +++
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442f..844e9baa8066 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -206,12 +206,36 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
 }
 
+static int uvc_start_streaming_meta(struct vb2_queue *vq, unsigned int count)
+{
+	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
+	struct uvc_streaming *stream = queue->stream;
+
+	lockdep_assert_irqs_enabled();
+
+	guard(spinlock_irq)(&stream->meta.irqlock);
+
+	stream->meta.streaming = true;
+
+	return 0;
+}
+
 static void uvc_stop_streaming_meta(struct vb2_queue *vq)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
+	struct uvc_streaming *stream = queue->stream;
 
 	lockdep_assert_irqs_enabled();
 
+	spin_lock_irq(&stream->meta.irqlock);
+	stream->meta.streaming = false;
+	while (stream->meta.in_flight) {
+		spin_unlock_irq(&stream->meta.irqlock);
+		schedule();
+		spin_lock_irq(&stream->meta.irqlock);
+	}
+	spin_unlock_irq(&stream->meta.irqlock);
+
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
 }
 
@@ -229,10 +253,10 @@ static const struct vb2_ops uvc_meta_queue_qops = {
 	.buf_prepare = uvc_buffer_prepare,
 	.buf_queue = uvc_buffer_queue,
 	/*
-	 * .start_streaming is not provided here. Metadata relies on video
-	 * streaming being active. If video isn't streaming, then no metadata
-	 * will arrive either.
+	 * Metadata relies on video streaming being active. If video isn't
+	 * streaming, then no metadata will arrive either.
 	 */
+	.start_streaming = uvc_start_streaming_meta,
 	.stop_streaming = uvc_stop_streaming_meta,
 };
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a92a986ab714..5de7f215ee28 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1732,6 +1732,26 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
 	urb->transfer_buffer_length = stream->urb_size - len;
 }
 
+static struct uvc_buffer *
+uvc_video_get_current_meta_buffer(struct uvc_streaming *stream)
+{
+	struct uvc_video_queue *queue = &stream->meta.queue;
+	struct uvc_buffer *buf;
+
+	guard(spinlock_irqsave)(&stream->meta.irqlock);
+
+	if (!stream->meta.streaming)
+		return NULL;
+
+	buf = uvc_queue_get_current_buffer(queue);
+	if (!buf)
+		return NULL;
+
+	stream->meta.in_flight = true;
+
+	return buf;
+}
+
 static void uvc_video_complete(struct urb *urb)
 {
 	struct uvc_urb *uvc_urb = urb->context;
@@ -1767,7 +1787,7 @@ static void uvc_video_complete(struct urb *urb)
 	buf = uvc_queue_get_current_buffer(queue);
 
 	if (vb2_qmeta)
-		buf_meta = uvc_queue_get_current_buffer(qmeta);
+		buf_meta = uvc_video_get_current_meta_buffer(stream);
 
 	/* Re-initialise the URB async work. */
 	uvc_urb->async_operations = 0;
@@ -1778,6 +1798,12 @@ static void uvc_video_complete(struct urb *urb)
 	 */
 	stream->decode(uvc_urb, buf, buf_meta);
 
+	if (buf_meta) {
+		scoped_guard(spinlock_irqsave, &stream->meta.irqlock) {
+			stream->meta.in_flight = false;
+		}
+	}
+
 	/* If no async work is needed, resubmit the URB immediately. */
 	if (!uvc_urb->async_operations) {
 		ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
@@ -2328,6 +2354,8 @@ int uvc_video_init(struct uvc_streaming *stream)
 	for_each_uvc_urb(uvc_urb, stream)
 		INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
 
+	spin_lock_init(&stream->meta.irqlock);
+
 	return 0;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index af8cef94ffff..26d4461f2774 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -483,6 +483,9 @@ struct uvc_streaming {
 		struct uvc_video_queue queue;
 		u32 format;
 		u32 buffersize;
+		bool in_flight;
+		bool streaming;
+		spinlock_t irqlock; /* Protects in_flight and streaming. */
 	} meta;
 
 	/* Context data used by the bulk completion handler. */

-- 
2.56.1.809.ga0b61035b5-goog

