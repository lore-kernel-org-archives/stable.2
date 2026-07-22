Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593F411F99
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741395; cv=none; b=EWP9Oyiikvl42vlhnUgi2CJWVN6OQBnwQFACX3WVnhxWsgGUXdaKcHPIb2YpPr0QOp67RTkohjvPoGZyGqf+Mzg31rZfxcwptzR8CMS1708HCJIzLLK1iTuASzDvowoYdEGgrReSdmfZ/y4XMP5icXDkv5blNbopCv30Bc7dOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741395; c=relaxed/simple;
	bh=IFaw2vTgGPKtuqqWeBtqLUWufIPcbYxs2GprlqYDGxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OunntrPnZNyNAH/amwDqODDmuAWIPWuCAGzQk6piWqfA6myYVJuu2NAswm7b7f1qbr1mk7eqvI+hTuoQbzl7R9zjxw++E8slOMZKUnTDZxcKKJg0qJfuRCa+kcL9NhdzLVZk7svG1aJSkflS6b7ahbzK5NsJvieifFYd1mhNnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JllhDxzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JllhDxzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823171F00A3D;
	Wed, 22 Jul 2026 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741394;
	bh=2ec3Z7Td4jg788+MpUH7wCPeIRypjdxRDf0YuwtkeEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JllhDxzcYvLJ8hDjT4RGVs/aiFR3fh8LPA4867UbYEmvsGzpzlLgbQCmVGMHjZGZY
	 ZBop1R9+Zo1Uzp2NDU6+2upt/DmiI8+/oYYLfwWCWRrv6htWr4ijHW3aUVQNLFiy+E
	 rgCFHa9SpEzFZ0lBUd0Fv3W4KY4+XayBHjkHKAgss4yE2An8b0jKQ7tFLNjDCJ1Kf3
	 9TeT9Pxnt+S8hnCzvbv2w0Brrm/tNMlqxvEoS5wzJcd3ZhWAGdYv4ariSXQQO5Pnax
	 kpEddktde5TFXt0TxGKCydQ8J4lAhc7n8sdZYUONzhI/kOlczrb/A+bmdS2uuvcqJN
	 QIiPuDYUobTrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/6] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Wed, 22 Jul 2026 13:29:47 -0400
Message-ID: <20260722172948.2068213-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722172948.2068213-1-sashal@kernel.org>
References: <2026072042-handgun-nature-b630@gregkh>
 <20260722172948.2068213-1-sashal@kernel.org>
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
index b81422ebf9f85f..864c7e65aaa54a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -17,6 +17,7 @@
 #include <linux/atomic.h>
 #include <asm/unaligned.h>
 
+#include <media/jpeg.h>
 #include <media/v4l2-common.h>
 
 #include "uvcvideo.h"
@@ -1084,6 +1085,7 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
 static int uvc_video_decode_start(struct uvc_streaming *stream,
 		struct uvc_buffer *buf, const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/* Sanity checks:
@@ -1096,6 +1098,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/* Increase the sequence number regardless of any buffer states, so
@@ -1173,9 +1176,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
 
 /*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6d24953f489154..4a1ff08453d770 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -207,6 +207,7 @@
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

