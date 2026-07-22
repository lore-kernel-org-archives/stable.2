Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C263546EB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728506; cv=none; b=gOiqRGpL0vrRJbUF2E1XqqlW+nmMneiC2Vv58aVrLAoWixxO3px2exH8TZPdMt3Z+GQYAaLbr83h/lilmK8KtKlwu5jiojMzN9RghrQcrck2crmfoZN9L5Fwns80eDCH4PQ7mBZpV9Mkt79fWxNlUmShGJo72BJ9J3wsllFl9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728506; c=relaxed/simple;
	bh=f4cqe26P95MgC9WMYn5SF3FOJdpSg6FnmzKjKJqJGGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAys4iNchApSoblNa0TTymnjALPMcJg6ClLO4dF1kkohDsNC4pvQY2gz31pNMz51NlZwKMCZxT7nx4mXKZ4JWJVw9cke5QL2E5H2ZI6oJGOGB73kun9BDwDACvdg6zaIHQjMTpjOCXu7aCkcKiIN6x//AKd1uObc1bn6I4x5YR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3caQYK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3caQYK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877AB1F00A3A;
	Wed, 22 Jul 2026 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728505;
	bh=8vyyBp6nltduCpFEsW7SPdyl8dhfuv9LML0YDoJ8UZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3caQYK7LOZ4Vl+Udg19xAH5xmnJnRZsRUwTZLGNEvWJ8Rf+rWQfXpjVqkl0LIWOy
	 S0uPW3xbNoMMlia5krc8oC3ZR0CQAHPPSKdU86OFzbL6vVXgbhCc5hxpG867yQuewT
	 Tiz9iscHwrC/XCLf60LxAOvGPmou74fijfX7I57BIv33oUQKFjosJLN3OpkGfFzLJI
	 SKGYjIQOh2qnT4mU88FZQc/OknUx+5YfwU8DHJo1ANzdpSqWy9bzjvA649NwRyXYPk
	 RxRyhd1CV8Os/RHxQNJFnWV+RRtisILwmM4/ttAFGlfFGfpqlwnu0xvKxYj5rgAjcO
	 TDQBy+y+F9rEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] media: uvcvideo: Fix sequence number when no EOF
Date: Wed, 22 Jul 2026 09:54:57 -0400
Message-ID: <20260722135457.1366301-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722135457.1366301-1-sashal@kernel.org>
References: <2026072041-maverick-blooper-4a13@gregkh>
 <20260722135457.1366301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit f078966ca1fb1b3865d8e6bbe2705cfd277fc637 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_video.c | 92 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1a92cbe728ce87..3a056738c04e6e 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1116,6 +1116,53 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
@@ -1172,51 +1219,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		buf->state = UVC_BUF_STATE_ACTIVE;
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
2.53.0

