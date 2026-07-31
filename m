Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575338DC57
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494931; cv=none; b=V1k7TGtJHVM7INqJwBxqxX98l4tGx6cswtyN9UkA8QbNrhogdSaA8rVlC2U2KmscLh40s2DAUIU5ggY7idqLc9PH7Hha/gLxJLtyOdmQwbSDzOMC36ZQmzyQOb+dfdEuxe0d5LQrStfWWPVmeF44cTJqHD4ta5TI2uKDRy1LgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494931; c=relaxed/simple;
	bh=Namu5ji+ZOFjJ1JLEKmZIoKQSL8pieAUgP9X0seWyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czYjkbDGzZFGhuZQMzwhecmhb8XsC4jL8iTT5s6LUpPI6WazWdIqMQoFCETkVJXvAImzRL6EBSM0N28dFDS8YLbvNOwfHv0no4JcctGLkncSMimsLxOKp/hNsZswgeo5slvnlUl4omCJL43sWY7T02pivqhYnm44V7nq64hh6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f4tSX5Nm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4tSX5Nm"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9452244aso7941051fa.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785494918; x=1786099718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+S8djePbFipQ/bHcZeCAtcf3JeuKLOi4QEVmO+y1MUc=;
        b=f4tSX5Nm7YSN6p2ruiam7ADfmyhnPKKMH0t22J3hVHVDYO2qMLo6EwwBgdO9/jpA09
         Baa/WV7HAWDM1reg+vJzkDMZwM2RyqVIvWLmrL0ECk/iris8RHEnSkqeM9yatV+VXl5r
         mwamMD4yR4cm8wQayQIuHM2ulN//5lwocQU3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494918; x=1786099718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+S8djePbFipQ/bHcZeCAtcf3JeuKLOi4QEVmO+y1MUc=;
        b=Mhxs7+uXJD8pAgkJnFuaJSmtbNUjOzhywEz1TqMP7WoxNO6k+4zYz+LsgQZHNKQ7hG
         A+pevho27m14XPP2agarzgDT8xdMc57HH0gEg1MJ1nTiIewfhcIykgWG57WNrekhXhE6
         SPyXeuA1Ov++xp1YJxm7SIK7UKpORWZyxgX1qOH5Q1vStqDfQeaPzudQ651MLPD1nc9j
         FkOJppqoo8oifDbEyPV63c2h9h+0J18WLJeWOLoRS3tITyqKIFW1K84usDlPINnUSOd4
         fyu9RlCbHY3XZRxsmX/g5DB7qra1ErW0gS3Gr0anbBpnoFr2p3RFKuH9sEpZsf8jQKb5
         tLlQ==
X-Gm-Message-State: AOJu0YzExoVCPRK5vkLoBDbQhYbAyCOM5/9jnXJK6niyMItrOG1/yDkE
	4J/empSkt0njQSLQnjcFIwekfN+Dek7Ev/jDB3ZuaV/3TKGZmvHjxByZqth+xgjDOaXPVxRiDuh
	WizPN5rUc
X-Gm-Gg: AR+sD12S+/ytp09YtU9AmSx+dtWw34kF7AtgUEyDsOYgWhKGCHyIj/0oJbTVPJpVCLF
	gRVqvNewN8jvRjaal877proUqk0GP/Iz79it85DwVlizv03YchtmNj1iyeONPON/WNJMpINDhSX
	cccH3RTOBP9UCfot1x9FjQassJDchqKWxCE5a50Z8yhMwvQJZUgIaojDSUypw09L+M3ousTM9Oi
	VyD8l+fWkUfbW47+0qiOYMp+qsuJZpQiBxHzb6A0+MEIG1zZn8+IpgO2U8ODODb2NlQOWfKcYqF
	QYkEpLw4gMpbQ2MK4l5fJ/WuCAVRUSoh7IZh67xoGADenIT0Iy0robzeLqwUvB0cOVuxVckr8WS
	z9LsPIzg8EFVR1lzvT0gixuBp7sbRElOQCQGx1rW9BqjNxnUvOqZSRS+Ut7GKrbjnYGsLdM+QOK
	GFwHYNznOXyDjb5Fz2rxI6fgpUiQKhlVKNauV7BICs+BSm/2b1xdkJJF/vLdsTARF05CT/heJhi
	oB8rPdR7q+5sPSAZro6KePPT2vtLRRK/W+cOuES5DR3uJW14Q==
X-Received: by 2002:a2e:be87:0:b0:39c:9241:af75 with SMTP id 38308e7fff4ca-39f7e348720mr3244421fa.5.1785494917998;
        Fri, 31 Jul 2026 03:48:37 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f812b4f5asm663761fa.24.2026.07.31.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:48:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: uvcvideo: Fix sequence number when no EOF
Date: Fri, 31 Jul 2026 10:48:33 +0000
Message-ID: <20260731104833.709405-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260731104833.709405-1-ribalda@chromium.org>
References: <2026072041-shame-chaplain-6dce@gregkh>
 <20260731104833.709405-1-ribalda@chromium.org>
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
index 2a2c10daa07a..d0415ebe54d0 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1095,7 +1095,55 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
+	/*
+	 * Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
 	 */
 	if (stream->last_fid != fid) {
@@ -1159,50 +1207,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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

