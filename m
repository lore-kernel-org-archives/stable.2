Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BB32B132
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754307; cv=none; b=Uttki+9w5u+jy83G3j8JEuuCBfacaXe+thBDCp1UlS4Ga3U1UZwNUagyNQ9vVm2w1zPlNxuyazzJ2r1Vi6BnWUItG2Q5tQy4Yq09v6bHa5+GqLEZNWJU2n7SvkeFHn4SeXee05YCdpZtJxuoJoG4voImPcAwVYTuUOyzGOb1UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754307; c=relaxed/simple;
	bh=hV6yRbK2467vGWi8u/kz/QELon4l9EmKSX+FP3y6X7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R60tzKY4lxgR3Nx6rCNPqFe2pGmEUulMx9TIIAQ/wV4HInWwf25jMGEf2pBhU8AlzcgmxSjITgBdks1v+5pux6TtZ/UzeYqa20WUHbHvSODZHs9kWoX8tCantJ/xIF5I00UHoXcsGA9Rb3FZRErV3ahOF+VSF4mxBqlvy+i/Og4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHuvkSWb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHuvkSWb"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39979f72d0cso17594551fa.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782754304; x=1783359104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zAVInwpKbrIbwGCCm712zoSGUq4vsfLClxgHW2en+4=;
        b=WHuvkSWbrWVLsO1/9O9t++4zNt3inUhU0ZUqtriLXLTe/UoakjwWoxBlNOxRqgjSdX
         KF4lynT/xrSDz1obnCbDW/wv+6w9SvS5QUzXgRBQUkHn216q/Zn8YaoejGdUprXQEwSW
         edQzqh6uC2xMWaxEtYyLk5vFYgAtbJ3hqtUB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754304; x=1783359104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zAVInwpKbrIbwGCCm712zoSGUq4vsfLClxgHW2en+4=;
        b=BbRgc2MYk21bZiLxb6qMvrx66qOXbJCM30vvIcxFhYpK/EJjKy/FogiNaFObXUmwja
         iyrzJB7CSxrZ60mWOdg/An0vwTuZWHcJh0ZUsjd5KBiQPvC/qfPeLNbPgQL1tiBBMKll
         s/Ro8JUtH0/94vWwVVqZmefYLWymU+3KywK8XRpWayENZfiVc4jmCUXwuF5D+T4IPMpN
         DXdLNBo99114t0xWoHPIse6qpdEGsBKQ9OP3Kpk0eAg2E5SnMGV0aO/Ix43tKuJKf1Fk
         Gagtq93xmLuyZ+E85jNBVvaZzELfwv72H9vtuc++m1wdc8a/Nfx6GEZjQfJVGyrM8/Sc
         M7jg==
X-Forwarded-Encrypted: i=1; AHgh+RpumyXNm2F/nn2Is+1sWefyGG7qC1h5zndm1OHyqjZutpSrTOfJ5UQGDweNZFVZqnI/n6VsN2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhlkFYv9rcClwO2gbr94FYa8BSjjtCbwnz4xIAZ8CN9bRCxnl
	pYq8z7AFmI/4BERhhK14wgyriPIHeJcykjFhy3zj/hSPKmIPomv9oa5ZBuxeES38xkB3WMd8w8T
	BrB6A8YkI
X-Gm-Gg: AfdE7clVcEMQ4UAdNZfR392Ur5zJu6CwPCGTp90GFx7rrxoAXEjFU8hnnKeTE+zItPS
	mbmt/B1o+MHFVRzmZXermmX3uYtcmRPbJVDv+C5MLK7j22IEgiagUqA7tuAXag2hnVrOVqStbdl
	N+kszqsluPioRdOx9MZco5sp7Hwx7NdtmSjbqkoLHnO7WY4aASc29fccxNABDuu0J5eIIbDasSz
	o37GKsDhz/4RvwGQ0ZXQ5Jl7/CsNgm7amzdmk4415lMdvqgDTEorDWS6DMwImv5CSFoi1SrB93h
	Dlo9dKpXPptbbbwdEkjuQ1nrCkpd0ap3fy1h4N9jYaARjIQHPeUIuB8TlVhHbJjuZeOuYYOnUPT
	r7XJdg/j+7bMEJ1m0SW2TjWars0rCnMfeumhU6wGZl9KtXz0KlFhnsqjG8iHE0KAug9Pxl+4TPK
	qUY1VxDaHIcCjxmDKb0xKzdqphN8fgVeXwZ4Ht8xeqsL2vlSSiXGd733M3N7kUp6aLVl+a
X-Received: by 2002:ac2:51c9:0:b0:5ae:bd53:70f8 with SMTP id 2adb3069b0e04-5aebdbd0f47mr49607e87.47.1782754303842;
        Mon, 29 Jun 2026 10:31:43 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aea237d2e7sm3973868e87.28.2026.06.29.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:31:43 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Jun 2026 17:31:40 +0000
Subject: [PATCH v2 1/2] media: uvcvideo: Fix race condition for meta buffer
 list
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-uvc-racemeta-v2-1-10e91d2afba0@chromium.org>
References: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
In-Reply-To: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

queue->irqueue contains a list of the buffers owned by the driver. The
list is protected by queue->irqlock. uvc_queue_get_current_buffer()
returns a pointer to the current buffer in that list, but does not
remove the buffer from it. This can lead to race conditions.

Inspecting the code, it seems that the candidate for such race is
uvc_queue_return_buffers(). For the capture queue, that function is
called with the device streamoff, so no race can occur. On the other
hand, the metadata queue, could trigger a race condition, because
stop_streaming can be called with the device in any streaming state.

We can solve this issue introducing a flag, stream->meta.in_flight,
protected with a spinlock. When there is a buffer in flight that can
write into metadata the flag is raised, notifying the stop streaming
that it needs to wait.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 14 ++++++++++++++
 drivers/media/usb/uvc/uvc_video.c | 30 +++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  2 ++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442f..af9dbfcf6f53 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -209,10 +209,24 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
 static void uvc_stop_streaming_meta(struct vb2_queue *vq)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
+	struct uvc_streaming *stream = queue->stream;
 
 	lockdep_assert_irqs_enabled();
 
+	spin_lock_irq(&stream->meta.irqlock);
+	while (stream->meta.in_flight) {
+		spin_unlock_irq(&stream->meta.irqlock);
+		schedule();
+		spin_lock_irq(&stream->meta.irqlock);
+	}
+	stream->meta.in_flight = true;
+	spin_unlock_irq(&stream->meta.irqlock);
+
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
+
+	scoped_guard(spinlock_irq, &stream->meta.irqlock) {
+		stream->meta.in_flight = false;
+	}
 }
 
 static const struct vb2_ops uvc_queue_qops = {
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index fc3536a4399f..f6b55b3a3308 100644
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
+	buf = uvc_queue_get_current_buffer(queue);
+	if (!buf)
+		return NULL;
+
+	guard(spinlock_irqsave)(&stream->meta.irqlock);
+
+	if (stream->meta.in_flight)
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
@@ -2330,6 +2356,8 @@ int uvc_video_init(struct uvc_streaming *stream)
 	for_each_uvc_urb(uvc_urb, stream)
 		INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
 
+	spin_lock_init(&stream->meta.irqlock);
+
 	return 0;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b6bcee4a222f..6f1a3381d392 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -484,6 +484,8 @@ struct uvc_streaming {
 		struct uvc_video_queue queue;
 		u32 format;
 		u32 buffersize;
+		bool in_flight;
+		spinlock_t irqlock; /* Protects in_flight. */
 	} meta;
 
 	/* Context data used by the bulk completion handler. */

-- 
2.55.0.rc0.799.gd6f94ed593-goog

