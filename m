Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3E3F12F0
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495156; cv=none; b=RcfefBgOJIp9WaROmxkJCw4xaWUb+UDhGkNhH+HgL9rdSfmbyrQN6fjB2G5vMGidiDTiTTonZH89EAFwNuoVzYsMjLxJWh15uCFXyKGPC0gUhMrgJNDG7Y51K17kO+yifhwXmcxcIFTMQZkJ2mc0IXbMmxVDhWNgjo3wH5gPQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495156; c=relaxed/simple;
	bh=yNRmy5hGrB6+uizenxGx66HrsGd7ONTtkjHlttq6iW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBeHVkWR9Pqf91bC4S4P9dZazN/iyWe9eqf0l+UjK2uJOawAqeVzcydSz+L4Uvd/+OW60vL06DXrsAZyuKi/q6HFzwxB1cATCS00V93cSKH1dH1ZD1scxBn768Yj4w14iuJ+pdYFwMrA4LzTv98MlwUnyvDceheYtXXiNnqQEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=melqu046; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="melqu046"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39f1ac13687so5908011fa.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785495148; x=1786099948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O4Vp21sBi8Rgji7X+RqHZk451lrG+B3JpRHt9GMnXXY=;
        b=melqu0466AmcqLEBC/7vJ9dUm2uJsG3K/Y1ED7VKp9PSIP6Qu0ub9IuYVeLNOl1gaQ
         9IOsPuXWzsTjy0gmgPsYBvKpH70meGityl1kzNImyYh5xFq44YmiFgWiOvZgZcaaA9OJ
         X+bRD65pfGQpTN/yulQ0waSf0JAMcfZfTn+hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785495148; x=1786099948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O4Vp21sBi8Rgji7X+RqHZk451lrG+B3JpRHt9GMnXXY=;
        b=bDxJIJL3CgOsLjzZ/C8IEeWYoSh3CwpqUq9b9kO9C9LCUWee/5S5APAIU4m4RCEJwv
         wGrO3mvgfW9uhYVKW85YVt36qrKODQqBk4WDUM3VPhOb+nOXVwJSUOHufj/ags1HLDZt
         LuWYizW1Mh44noU4ZfsfrJcx1jwlCc8iqI0/E3O4tZ5oa56vKrmlN55JK8YlCVxkp4G8
         RdUw7EzqFRGsq07KHyDX3Twklau6dwdxUlN1W5t55eXloSu8EhHtyy/BFIuw+FJZI5q8
         uduhn5qgNU4XIfpTwD0MSITowRSO3Yh09gTFXK4ZlDazUnL9AHygjaj5rPkkxFL0vXhK
         RStA==
X-Gm-Message-State: AOJu0YxoZjLL4riaj698lmN1blHvInonAOIEuAtYlE/QIbW+O0YHnsx3
	tgdN/6CNJAGp7gCsT+C+/ZbvnSoqO6UrLd7dwzpJeErUyHGtpy0DKZxxJqzOZxvCOhMEw6ZXk/c
	eLul5KP1g
X-Gm-Gg: AR+sD137Kki8Pf5oyU+f99CAi2b/Pg15IQV2/lj36n8mT2H9QIBIzwKHtX0gtXH/WUJ
	sFy8+4HW3bQd0cYGLBKKAYHyj9MCUVzaWbedFkyT6zvKdORevnXPODvhvG9GPzto6krBjnX3ckY
	iExQKLVaa9vHfy5c2LNIvH/hwa2t3ssf8ihyKn+mHQZFNihsShRX1n4dCFKODROoe26iQ7FPuUC
	3mpiFKiCg80hVSjRL/Zj6QLwFu6r20UhcwX2panIzxLI/VcoF6F6/LFQ1kErEeQnQHupF9vs+Wv
	KzpkCglBk4ZyexTy/LNjXrR3Nhf8cxUVdCK2z9D4YZu1hYUiJPkOXafcNgRFtp9qviEr98XLZpu
	sThqSljdMl9QuUinDyuis/E1L3mJHU/Zom/YZu4lTKBcdg3Z/EM1Qb4eqaPd5TGRxKRvrbpW7lY
	vgaXTykDqpA82c4zlGbo9jazSzjnJ4vk6+pF0EVkYxSnhJTfX89FVgiYx2TfiujQYb/kLq7ivtg
	lugkzsRKMIrXzK4e7npy4MltcteibnuBN2ReNssq5IFNdlWwA==
X-Received: by 2002:a2e:ad85:0:b0:39c:6d1f:2eff with SMTP id 38308e7fff4ca-39f7e3a98dbmr2964561fa.14.1785495148343;
        Fri, 31 Jul 2026 03:52:28 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f812aed4asm661781fa.22.2026.07.31.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:52:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: uvcvideo: Fix sequence number when no EOF
Date: Fri, 31 Jul 2026 10:52:23 +0000
Message-ID: <20260731105223.732829-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260731105223.732829-1-ribalda@chromium.org>
References: <2026072041-maverick-blooper-4a13@gregkh>
 <20260731105223.732829-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver could not detect the EOF, the sequence number is increased
twice:
 1) When we enter uvc_video_decode_start() with the old buffer and FID has
   flipped => We return -EAGAIN and last_fid is not flipped
 2) When we enter uvc_video_decode_start() with the new buffer.

Fix this issue by moving the new frame detection logic earlier in
uvc_video_decode_start().

This also has some nice side affects:

- The error status from the new packet will no longer get propagated
  to the previous frame-buffer.
- uvc_video_clock_decode() will no longer update the previous frame
  buf->stf with info from the new packet.
- uvc_video_clock_decode() and uvc_video_stats_decode() will no longer
  get called twice for the same packet.

Cc: stable@kernel.org
Fixes: 650b95feee35 ("[media] uvcvideo: Generate discontinuous sequence numbers when frames are lost")
Reported-by: Hans de Goede <hansg@kernel.org>
Closes: https://lore.kernel.org/linux-media/CANiDSCuj4cPuB5_v2xyvAagA5FjoN8V5scXiFFOeD3aKDMqkCg@mail.gmail.com/T/#me39fb134e8c2c085567a31548c3403eb639625e4
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
(cherry picked from commit f078966ca1fb1b3865d8e6bbe2705cfd277fc637)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 92 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 408be24fceea..2cc00f4be793 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1108,6 +1108,53 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
+	/*
+	 * Mark the buffer as done if we're at the beginning of a new frame.
+	 * End of frame detection is better implemented by checking the EOF
+	 * bit (FID bit toggling is delayed by one frame compared to the EOF
+	 * bit), but some devices don't set the bit at end of frame (and the
+	 * last payload can be lost anyway). We thus must check if the FID has
+	 * been toggled.
+	 *
+	 * stream->last_fid is initialized to -1, and buf->bytesused to 0,
+	 * so the first isochronous frame will never trigger an end of frame
+	 * detection.
+	 *
+	 * Empty buffers (bytesused == 0) don't trigger end of frame detection
+	 * as it doesn't make sense to return an empty buffer. This also
+	 * avoids detecting end of frame conditions at FID toggling if the
+	 * previous payload had the EOF bit set.
+	 */
+	if (fid != stream->last_fid && buf && buf->bytesused != 0) {
+		uvc_dbg(stream->dev, FRAME,
+			"Frame complete (FID bit toggled)\n");
+		buf->state = UVC_BUF_STATE_READY;
+
+		return -EAGAIN;
+	}
+
+	/*
+	 * Some cameras, when running two parallel streams (one MJPEG alongside
+	 * another non-MJPEG stream), are known to lose the EOF packet for a frame.
+	 * We can detect the end of a frame by checking for a new SOI marker, as
+	 * the SOI always lies on the packet boundary between two frames for
+	 * these devices.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_MJPEG_NO_EOF &&
+	    (stream->cur_format->fcc == V4L2_PIX_FMT_MJPEG ||
+	     stream->cur_format->fcc == V4L2_PIX_FMT_JPEG) &&
+	    buf && buf->bytesused != 0) {
+		const u8 *packet = data + header_len;
+
+		if (len >= header_len + 2 &&
+		    packet[0] == 0xff && packet[1] == JPEG_MARKER_SOI) {
+			buf->state = UVC_BUF_STATE_READY;
+			buf->error = 1;
+			stream->last_fid ^= UVC_STREAM_FID;
+			return -EAGAIN;
+		}
+	}
+
 	/*
 	 * Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
@@ -1175,51 +1222,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			meta_buf->state = UVC_BUF_STATE_ACTIVE;
 	}
 
-	/*
-	 * Mark the buffer as done if we're at the beginning of a new frame.
-	 * End of frame detection is better implemented by checking the EOF
-	 * bit (FID bit toggling is delayed by one frame compared to the EOF
-	 * bit), but some devices don't set the bit at end of frame (and the
-	 * last payload can be lost anyway). We thus must check if the FID has
-	 * been toggled.
-	 *
-	 * stream->last_fid is initialized to -1, so the first isochronous
-	 * frame will never trigger an end of frame detection.
-	 *
-	 * Empty buffers (bytesused == 0) don't trigger end of frame detection
-	 * as it doesn't make sense to return an empty buffer. This also
-	 * avoids detecting end of frame conditions at FID toggling if the
-	 * previous payload had the EOF bit set.
-	 */
-	if (fid != stream->last_fid && buf->bytesused != 0) {
-		uvc_dbg(stream->dev, FRAME,
-			"Frame complete (FID bit toggled)\n");
-		buf->state = UVC_BUF_STATE_READY;
-		return -EAGAIN;
-	}
-
-	/*
-	 * Some cameras, when running two parallel streams (one MJPEG alongside
-	 * another non-MJPEG stream), are known to lose the EOF packet for a frame.
-	 * We can detect the end of a frame by checking for a new SOI marker, as
-	 * the SOI always lies on the packet boundary between two frames for
-	 * these devices.
-	 */
-	if (stream->dev->quirks & UVC_QUIRK_MJPEG_NO_EOF &&
-	    (stream->cur_format->fcc == V4L2_PIX_FMT_MJPEG ||
-	    stream->cur_format->fcc == V4L2_PIX_FMT_JPEG)) {
-		const u8 *packet = data + header_len;
-
-		if (len >= header_len + 2 &&
-		    packet[0] == 0xff && packet[1] == JPEG_MARKER_SOI &&
-		    buf->bytesused != 0) {
-			buf->state = UVC_BUF_STATE_READY;
-			buf->error = 1;
-			stream->last_fid ^= UVC_STREAM_FID;
-			return -EAGAIN;
-		}
-	}
-
 	stream->last_fid = fid;
 
 	return header_len;
-- 
2.55.0.571.g244d577d93-goog

