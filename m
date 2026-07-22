Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA33AA4E9
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736480; cv=none; b=Lolo6vmC8BC4U83psBM2jdsj/XXxI25/Wb/c/3tDWEXdM+RcjuXLbyiyorWjc/kPdqsIkr/eGGS8p2WkArRSW/vlXAOdu3bI232dGUVsH9LeoUwKwACenVw9gOGnDpfO2sNql+UDVPst3/gBRyIlh+GzGMpgYGQZgTZbATVVWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736480; c=relaxed/simple;
	bh=22OKY2opunlA253/kO48S6OPCWMNS3i+T9LazdvvGUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXUCSnz58bMaOMyJiOs3LGfCmyvJCScFbqdcJvbvpmWBKLd95SNNJFq4YTBJ7Jw4Xt2UuONRM4hf0JwxTz/RDdaqRrDjEBpZFyG1g8vTBZxVr2sexYBq7vKBR2+oq99KwfqhhprWVx/kXXBmDj+ExZPdhnPRoUnsoMFMrbO5N68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb7uT1w9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb7uT1w9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB131F00A3E;
	Wed, 22 Jul 2026 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736479;
	bh=d66xe6qSbqggNROqLy7TQR1QrP+ri+oesAHG8XcPUXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mb7uT1w9VpVtInap33hg65CyfoN9Yj13jL0js09ffr2mBVhLNYoMQAB8Jm2e/egvM
	 syLPmPCIWe50LLEJ7s941UkdSNKl5yDVO1tY4lyELhKltqsZ4Woj6soZY3Pdz6kGdu
	 W9nwWB5bS1ugaH5riM7MDDf9GbU/EuLVavWxkgNmQxgoPd0uF9u134PQB3ytmhZ0M8
	 YIegHe6IRs9dPSvGuoxNf2dCePF51EX0FRaNJWWwd7gWyELUd0Lzq1TbRQIjOJZT9c
	 f1VGpIkKHpSvH59CHwx56cWMBFBpU/z9NBrGwRehSXgla0LNy7bYo5V9Qiqi8JBfJk
	 cnFHNivHu9JnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Wed, 22 Jul 2026 12:07:52 -0400
Message-ID: <20260722160753.1740303-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160753.1740303-1-sashal@kernel.org>
References: <2026072041-shame-chaplain-6dce@gregkh>
 <20260722160753.1740303-1-sashal@kernel.org>
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
index 71aaee5c1c505b..cb6976dcef1eaf 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <asm/unaligned.h>
 
+#include <media/jpeg.h>
 #include <media/v4l2-common.h>
 
 #include "uvcvideo.h"
@@ -1086,6 +1087,7 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
 static int uvc_video_decode_start(struct uvc_streaming *stream,
 		struct uvc_buffer *buf, const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/* Sanity checks:
@@ -1098,6 +1100,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/* Increase the sequence number regardless of any buffer states, so
@@ -1175,9 +1178,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
index d82169f7013288..2dd8d04589abec 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -215,6 +215,7 @@
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.53.0

