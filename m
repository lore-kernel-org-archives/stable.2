Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572193C4174
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494615; cv=none; b=P0M10GdFnxwn0h2lo6JBRvIyrvgDSL/vA8XZui5Jrw1Ev2p4Z6UJfsaEaolomJ5Clfota0B1daXxHrrMHLXxWznA2cXvf/0ChIri6USefEyV4GyOZULcX+rHU55J2YZqTUWI1f6NOhbSV4CTQdVrkmP0J4PnlM2SX4IQF6P+Hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494615; c=relaxed/simple;
	bh=deKGpIMHZSXP0cKrEfuaAthTia92S/6kiIEJZnCVubY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnnQb3Cghq0rhz3pCuIF+5pmW6uWTxuMloQTzyxh9CF0NLiFPPrlwoCcp8wH9iNqPCEc20j6GvZuFIbRHg4iXIWg8zXb2lskabuYHEG29ZCntG+0u0JuSpumN3Phtzg7j6hFSkNO6SCsdPOpp022p49waxJi9L3UcpQwVmt4IoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J6HK3Nyu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6HK3Nyu"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so827568e87.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785494605; x=1786099405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2vKocm+P0aWsPaJZWv1sqw+QxfJjVKKQ2dPRUMXtPo=;
        b=J6HK3NyuvGdnlPNqtar8FOsiliAKELvhBSBvBurMJWxa/TxYSUkfuvAfmBNaB6RM75
         2KFtyvPHrmT1jET+Q5P/PUvI6RCDJVf8XTJVPP7sX6tw7lqTs10rF/+5HR/F4IljNodo
         RCXFgXruVQLspDAUGiWa16y2vcJXfXsgPP/z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494605; x=1786099405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2vKocm+P0aWsPaJZWv1sqw+QxfJjVKKQ2dPRUMXtPo=;
        b=lJoemBZmWS78JLQGGSSDhAZX+8O+YCffDKjzZRe4B0E+aT6cXU19bNDLz1pdkYgon+
         BgyVLOeRde3J8l+08TtnUy6QCPd/jmoiNz5GhW4N338kONmKwi5egiwNP3jm8dlM4TgZ
         O/fcBcKaCzMV+SgKIsKN54b6iIA4V+ZJ97iCM9Khku5wM6ea9L6b2BItubQyEEABJmHo
         LZpEAgLnHhEG1Kmk5WGth4af4MoFusvSIHo0WeMCx2XByIq/Yx23QnrNU3UV5nXFDX9h
         3KnJJ9phgkkY7xCzmvKNfXhZpgt/XJmPf76nrR8ONhqbmCPfhvak/BD0YIZ4MBj9rp10
         HaSg==
X-Gm-Message-State: AOJu0YxtCoI/p9j7SkCDHMPSui9SxX9hCAuWu6lEpjql40YwVMtmXZBv
	k0AKUQqJZU0rSVkaqu8zFyunm7pW3Un4No5TBMbM8Wxhgol3s3L0m6W6o2nCMH7+K/g/FoAXbO4
	Da+dBwaW9
X-Gm-Gg: AR+sD11lCEZQzCGADx5+rj84YSBdG9yQBGpO3OCpb83tTr6GrpL+A1LK5wpJ9iCmhvC
	YtOgdNHMf2OmUGvGw24nLW7el/50DevSjK5tnKxMlBLVXl2gDi6DeFxo7jvW4gfmoyk1MWrTcN/
	AxgX8V4Cr1vfutPrs/1O5ODvX0BUmjiuzT4xTTiIplclYSdbZUCNI7ftqHJnWKAb9fF4ELRI0Pm
	R7aCIhFZbNdUCH54zAxyuMoXbfS+c1hMpFv3Lwauk0w0+S2zGHj/LDNH+bdyumFoWtiSe7bgV0V
	Ec1clfEVNAzNqaod1FdZkX29lcOFXQdviOXsS/tjIioQmRHlNgU50TEP2rj/hY0v2UgYy/zdJDm
	0xb0nYj7ov/5GwRAutayFUNoomsBJyBhWY6mJTcSgsUo+y7rzRH/Ktl8XNJ5uqAIbnbVwNamqTo
	JpRCiXCXXqSsbbYYuMeJlDeHvgvDiMjATCjgI2JNBdzC9leglMZOqSf6onYLdUU7SwBu9e/Dn18
	L9oItOSpdBQIGodjnkNusqmMmXdqfzd1f0VBx0a68c4PX6HmOUpOrTBdOIt5cxmaXHDSdPG
X-Received: by 2002:a05:6512:318d:b0:5ae:bf3b:c96 with SMTP id 2adb3069b0e04-5b2e2406967mr255127e87.19.1785494605344;
        Fri, 31 Jul 2026 03:43:25 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23c54b2sm231690e87.8.2026.07.31.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:43:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: uvcvideo: Fix sequence number when no EOF
Date: Fri, 31 Jul 2026 10:43:20 +0000
Message-ID: <20260731104320.690415-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260731104320.690415-1-ribalda@chromium.org>
References: <2026072042-handgun-nature-b630@gregkh>
 <20260731104320.690415-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_video.c | 94 ++++++++++++++++---------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 7d462e346abd..909e158a017a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1093,7 +1093,55 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
-	/* Increase the sequence number regardless of any buffer states, so
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
+		uvc_trace(UVC_TRACE_FRAME,
+			  "Frame complete (FID bit toggled)\n");
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
+	/*
+	 * Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
 	 */
 	if (stream->last_fid != fid) {
@@ -1157,50 +1205,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			meta_buf->state = UVC_BUF_STATE_ACTIVE;
 	}
 
-	/* Mark the buffer as done if we're at the beginning of a new frame.
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
-		uvc_trace(UVC_TRACE_FRAME, "Frame complete (FID bit "
-				"toggled).\n");
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

