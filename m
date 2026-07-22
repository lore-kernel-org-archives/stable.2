Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746A353A8A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728505; cv=none; b=ECMickgaOxG0K4BA6BLmZIv5XWNPiuiWP6bwwBUalu1KPUMCyq/ZurKwsMCD98nvqDm2bYKHfrVvHAw5qCzrVDOmwiuF8HxVgQGESKnn4ElKdoZtj32OAgbG+P/+4Yx2U1yoDbaQu1c2F6qavPFFVdk8Ln+clhTz5w4WBHtprc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728505; c=relaxed/simple;
	bh=+xCyblLDUw17eOj4sqw8/34fJP69RgXKSbmEqwWYCjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmc4A+5389mRfWR3WsYIs7DhPMvyD7xDp22NB2/yMD+oFv9Gn+zAfPLTZntJFDz6TbTC7Qb3bgAz4bKqwwj5cXu9yqolDVenPL8qRXMCD7WwvJaOmXO1X7XHQAeAuEFIFEY6r9EwD6Lvxlos2w89Gh1rS4g1uOgIcgO+ocpAH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmNeDLq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmNeDLq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B21F00A3F;
	Wed, 22 Jul 2026 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728504;
	bh=FA65Z3pQ0HbcXq8e9Y1GNSmoLP05D/5oIlB4uaZrr4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UmNeDLq26S38WsHZ5cFe4a0RLgMjQorTJnoUl3NY8ya1HW+xwEcmKGaO5cibhsdSL
	 j6wIW4TyBUlW/5JVvCf0rXiOYpPp4hLqGLNweSpRZNVAEmH59tZTW9o8sKr1/pmu22
	 kf2yKfrj1d1KbWZMMxi9gPUtefw5weRQhNvUfzcbqf6CtoMboKV32t52FfoOOMORr/
	 NBpcqeY8BPTOs1RxU6dNBDc1qlatKQfiBcN/566tClfNR+w9DEimy30W5+NRlN6HnR
	 GiCc3yPA3oK+YAd5Ts+vWCdmAxNy/9NKuPhIoICscAxlyRR/tGsgmWmyq8lciwiE1P
	 +tBv5pq5Yl4WQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Wed, 22 Jul 2026 09:54:56 -0400
Message-ID: <20260722135457.1366301-6-sashal@kernel.org>
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

From: Isaac Scott <isaac.scott@ideasonboard.com>

[ Upstream commit c2eda35e675b6ea4a0a21a4b1167b121571a9036 ]

Some cameras, such as the Sonix Technology Co. 292A, exhibit issues when
running two parallel streams, causing USB packets to be dropped when an
H.264 stream posts a keyframe while an MJPEG stream is running
simultaneously. This occasionally causes the driver to erroneously
output two consecutive JPEG images as a single frame.

To fix this, we inspect the buffer, and trigger a new frame when we
find an SOI.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20241128145144.61475-2-isaac.scott@ideasonboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: f078966ca1fb ("media: uvcvideo: Fix sequence number when no EOF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_video.c | 27 ++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 9960ad7d2a1ebc..1a92cbe728ce87 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <asm/unaligned.h>
 
+#include <media/jpeg.h>
 #include <media/v4l2-common.h>
 
 #include "uvcvideo.h"
@@ -1098,6 +1099,7 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
 static int uvc_video_decode_start(struct uvc_streaming *stream,
 		struct uvc_buffer *buf, const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/*
@@ -1111,6 +1113,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/*
@@ -1192,9 +1195,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EAGAIN;
 	}
 
+	/*
+	 * Some cameras, when running two parallel streams (one MJPEG alongside
+	 * another non-MJPEG stream), are known to lose the EOF packet for a frame.
+	 * We can detect the end of a frame by checking for a new SOI marker, as
+	 * the SOI always lies on the packet boundary between two frames for
+	 * these devices.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_MJPEG_NO_EOF &&
+	    (stream->cur_format->fcc == V4L2_PIX_FMT_MJPEG ||
+	    stream->cur_format->fcc == V4L2_PIX_FMT_JPEG)) {
+		const u8 *packet = data + header_len;
+
+		if (len >= header_len + 2 &&
+		    packet[0] == 0xff && packet[1] == JPEG_MARKER_SOI &&
+		    buf->bytesused != 0) {
+			buf->state = UVC_BUF_STATE_READY;
+			buf->error = 1;
+			stream->last_fid ^= UVC_STREAM_FID;
+			return -EAGAIN;
+		}
+	}
+
 	stream->last_fid = fid;
 
-	return data[0];
+	return header_len;
 }
 
 static inline enum dma_data_direction uvc_stream_dir(
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 89fdb50138406b..d6a7ed7e9601c9 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -80,6 +80,7 @@
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

