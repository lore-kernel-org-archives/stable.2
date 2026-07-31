Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABC3B14B8
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494930; cv=none; b=NKQMbpJyTTx3CYbb7OD1Q+ZLoBn9Ps7fxMlwjKfMP3E+wnZAQ7AkpCYgEGrf1QZ69q3z6zJrri5cVp1ORTj3xdDkv6hQL5vgDF24zIoCNu4YrHJeBqruj0u9tF0Yc8zUavnkPXbx9p883/zswbcQtIbDwlpcWqRzpHFTJjCJGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494930; c=relaxed/simple;
	bh=bAt8qRp4ODDUAhegzq0y26s/ugXQTDHjWIdnLgAHOaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVbK+TvuiUp4col+ZCyx2R492ueoE0jiMWuaGKyBuHjEFT90CXanT/NPqXiD7umiytAfY02xm1vRVVKG+dS3rXBIweFRP1FMbeQFYbBuOb4Hlek7qO7ym8FyfcLKbTp+B/ZvxngtW6CMqfcP6aN7893S76RU1v4As6vX8n3VkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7oi4ZiT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7oi4ZiT"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39ca0a30148so7724501fa.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785494917; x=1786099717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=997XI2kF0i3GjS5yY5R7tofIVLwImfPevok1zPToQ2I=;
        b=H7oi4ZiTf1HHhtnI91RP8YXj0WEdXjgoB6sIenVJyPt8R+DIGQyAxwEM6zKJ//bbcB
         0rcYpG9g308UcCJMNsFfjq4/zOg+vdpn10v1ViRLw1BU0yaYPqpRunPrxTI0jzFt9HpE
         dFWjMrILWKbq043xdAocOHxyE8ked6po8lpDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494917; x=1786099717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=997XI2kF0i3GjS5yY5R7tofIVLwImfPevok1zPToQ2I=;
        b=tR5yvGhCkBZE6LPt4UXPPx+QvGnqIT3wSKpaLnVHZfPukOglHXtT1gFAr50QDXoVl9
         V1ymoIcuD7OXuiKYDdpvEk9pWZRYnN559w9lu7bBAyBGhNCHGBRNhVrH6mMcM6GqIfj3
         glB87xNyYuTI7XV3NMuDx1kCrVLZcPen1RLnTw5RjTUl4QHC2QNlxRNEpsx3Nn1WCxJ2
         cp+VEUBhr0ND/P8W0hXRkwgECXXMsRP/W2J7GB/mgqiD5OM4jz/w7raBHWCTTOlp6BNb
         iw2KmihcJjSb8oTL6M5W9w1ZONrMuXa0X9rlH6i46y+RDBbGZhAzsou1YiEVXMKPH3Xj
         nzTQ==
X-Gm-Message-State: AOJu0YxZ8H+4WG6yj88xxya2wuOYUP3ddwc04R75d4x4M7Vzxiqj70DD
	AzafaYPgS6aqcPXkz+2Zuxw7p/ZFwuxyZb8EkuYmd42MkFKkCAYF2B2qEuHF2rDr3FDyziSgjp1
	DJIFvoZI3
X-Gm-Gg: AR+sD11VZkNVMFCSH2U0lG98c+cDtZ1jQ9grcbdxWxDK0pXqVCXfeto2ZMHdl9DHKjG
	3lkFwVcdQHdlz/vgLBrwg+5LXCiaTb1k5tzASa9Hie+uyE2PbcA1jjynP2D7zI/5NXG1BkacpHR
	WeUYwY2cjbDoLSsVkkfaQnx3WpJxT9LnfFZV/WE4zVfnovB9my/nEDuNqHQCgD3Z25JtWjh1m32
	0Vr7BxLA8qje1JDgEPWu2FbglNG6PfKh9pe2MeH/xXHZJ5a/kGJMu3Tphhvx7k0ptVPa8M8tvI9
	3lC4oBeN7A5NFkltifctAtmrxem0iAXy3BwPcfdys/pw70Xq3WWPMGxRL6f5ZhZeqjaMHPB4xfH
	L/PFXAY2WTQ+DvxgFnUxb44U7mi89114iXPMAOfrBD58hxYsNP3tXpCHW2VQFSnQL0PkhoW5Sax
	VmV2UD5ywAwQMcNccoE/3viPHBNADF04WojIpuZQzhd5baRzrNGdsoSjotvxjoB6pq3awkfulPd
	tGsopGm0ULZ7rK7UZK9+YZ1m9rns9W6mK1itzUgYDtjWQ7Xow==
X-Received: by 2002:a2e:bc1d:0:b0:39c:7859:a2d8 with SMTP id 38308e7fff4ca-39f7e4bfc21mr3138851fa.27.1785494917032;
        Fri, 31 Jul 2026 03:48:37 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f812b4f5asm663761fa.24.2026.07.31.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:48:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 10:48:32 +0000
Message-ID: <20260731104833.709405-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <2026072041-shame-chaplain-6dce@gregkh>
References: <2026072041-shame-chaplain-6dce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaac Scott <isaac.scott@ideasonboard.com>

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
(cherry picked from commit c2eda35e675b6ea4a0a21a4b1167b121571a9036)
[Added JPEG_MARKER_SOI definition, jpeg header does not exist yet]
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 28 +++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  4 ++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 3184308e6896..2a2c10daa07a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -24,6 +24,8 @@
 
 #include "uvcvideo.h"
 
+#define JPEG_MARKER_SOI                0xd8
+
 /* ------------------------------------------------------------------------
  * UVC Controls
  */
@@ -1077,6 +1079,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 				  struct uvc_buffer *meta_buf,
 				  const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/* Sanity checks:
@@ -1089,6 +1092,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/* Increase the sequence number regardless of any buffer states, so
@@ -1177,9 +1181,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
index be4b746d902c..2dd8d04589ab 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -212,6 +212,10 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_NO_RESET_RESUME	0x00004000
+#define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
+#define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.55.0.571.g244d577d93-goog

