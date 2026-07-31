Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3D3BFAFA
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494623; cv=none; b=RucFTXksI20nGhx69mKnGn5YUKjjSp2GsTMyTkMBv9TBM2wMCCL+sq+BdrGPiaPEZHJ4BFrFTuLSSnbdF7eWldNzrsuRQYuxI4B4I9zccyAICnuuuoBT3VJKN+Ol5uFoIkyAvF+lcgFDVuiDv4tcWil1zTFYPox5PN5OeycNOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494623; c=relaxed/simple;
	bh=5f6AUh2jCMFdhBBV19QubmQCZ4ySuOtpIl++FMFICaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCSqiT4OIBioH+JUQsu03PyGgEuJwH7J/erWIDAb4zVwLFTLvT/WXWw50LTlXVokpmjaZ2iM78V96ABVBuZfj+uoiBcRhNoshfodRMeA2ojiw67RZ8tt8gOIFTTy0jtM2AbLAsdZfL4FFdm9+YOIznQGCzI9mxTp8p4i1e0vHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yc0ocqXf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yc0ocqXf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so865025e87.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785494604; x=1786099404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxUxXCGVYlrYlnYqtJo+uIXz7SwoZs3qVPFhMISuEEE=;
        b=Yc0ocqXfpciCTWc8nCnYamHz8L3Ql3UFWAQiGZqLop3f39IZUc2hW4nhzq4PzlqPME
         RZbaN89RBF7fy3jCpOGz6FhrIu5UwugS2HYMqaP1ksu+hg++/touS1/tOT9YfZzQ9gEU
         RhuYFvRlh+6nKcoc/OQ3jOZWdIRUCC8XEFkso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494604; x=1786099404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxUxXCGVYlrYlnYqtJo+uIXz7SwoZs3qVPFhMISuEEE=;
        b=qMCvY38gEwDhG8Lg8hlqbjLhNXZMYZdPWEvXqYNdmmz73pc1kRx0yCmBRpB1ltIGbT
         Jbmr8CoDjG4/c7lVtw8eVsB6IS5YztB8pMvDNSEhAjl+eYVuyu+d/EyolSY3aDZSqLfv
         sAw9nN7bUz3SkocG6UCyHsxH/vsHUwxWFEvlBb8n2dQlywN9rJxhVJUJll6jPGKHbqgJ
         j6eD6MQNWlB506tWJ39/pA2eeLOGt/7csK9bwljMwzKOoLM7yY96bliaaBckSp7egoxQ
         qFE9Xzl2Y3yfPYDyDn5c4al9lxFT981t8XGPbbzWRN4Nro6Q9O29/ZYQ+t+prEnf9vSg
         HIMg==
X-Gm-Message-State: AOJu0Yyc4yOyDbTyilRTD9BHFqtg5cIrvMMZ0jteVXbqC29HeD6QhLgA
	qPJ2RJV77KMOpIUoN6dtl3+b1OZ/Vp/Pp/BmQINk7AsQLf90rPTUZWA62wO358WE7yfJPMqs19/
	oiZHk/nLJ
X-Gm-Gg: AR+sD102+UjZUrVv9HB6fT0qAn6oBKUZ6cV3u3jNVWGcekdFI0qx0cAtoPioJuRNA1O
	wtqsYWd/MPFLKHljG7M6wmHSXgprvOmI+oxeZouaIzV1vlt0HljuzaX9O4PV8xldsFvrPUhY+vG
	2FQXM7KcvSOmXIYg1tAbWynYWM8Yvpmqn7xMQvalgKJt46PPHjYcqE3CoDgB/ErYxwTbDp1vnMt
	xw8QO2NYpaqwiMFxALkiU7T2k7nO5HdQc8dDxY3nt07Tbbgufef4037EzsilSkbPpED4FpQO5Y6
	2BVyZfVOsQLcqroE35QOqFZhBc2cC7hhj2WEV+VnLLdJ7xMmYyY4BAQTK1LeZs6DZ0VIa8V5d5X
	uX9ZJKSm5YYHfERGzGqoxmA9WguY3T0JcghOW3OLkPmiw5PO1d48AyujRuBSDlPeC5BdLWDrhoP
	Ve2KhaE6mo9OcBbbZrns5eUeXEpQ2b44PY1aW20V7wgyNhaiZaAgKsvwP2JslMShzHNNZjuGudW
	CenEMHIeW5LAmXfHR3i/FyEuhUGc7/uyOG+0/dC9ogjzTfajg==
X-Received: by 2002:a05:6512:68a:b0:5ad:5c4a:8221 with SMTP id 2adb3069b0e04-5b2e1f85ac9mr454102e87.0.1785494604394;
        Fri, 31 Jul 2026 03:43:24 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23c54b2sm231690e87.8.2026.07.31.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:43:23 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 10:43:19 +0000
Message-ID: <20260731104320.690415-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <2026072042-handgun-nature-b630@gregkh>
References: <2026072042-handgun-nature-b630@gregkh>
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
index 1a8a89aa0c5c..7d462e346abd 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -21,6 +21,8 @@
 
 #include "uvcvideo.h"
 
+#define JPEG_MARKER_SOI                0xd8
+
 /* ------------------------------------------------------------------------
  * UVC Controls
  */
@@ -1075,6 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 				  struct uvc_buffer *meta_buf,
 				  const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/* Sanity checks:
@@ -1087,6 +1090,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/* Increase the sequence number regardless of any buffer states, so
@@ -1175,9 +1179,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
index a83995276170..4a1ff08453d7 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -204,6 +204,10 @@
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

