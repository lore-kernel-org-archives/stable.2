Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409333F8C2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495152; cv=none; b=DbZ6YSkbP6yK2QfU1iaUT4X9dUq38mbmiLp235lbD3zlJ9uDNi4MW+sPZwo8TFenBa0YFoHlgGLPPmect2w2spyvj96/1L+Hk5uAVF7/VCKy2RXcSjwopR4RfGeajmUFEt2BC5DWxQPfZT4RlzPkSfa0SNtlhzE6VvcPsAJANgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495152; c=relaxed/simple;
	bh=7U171UFAM/JqnKBaO3I0kCiU2z7wI/nKj/lFPddfncY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAAKh16Va/4WafUAu2qbWrVVgD2UwgPJ+jiwcEFZ1S/LQvN/HxCkFSgLuOCBJ9bwHlUA7+T8pPK6cgNSxYz+kfCfu+PjIfHjuURQLHaKRvxyjcjdr5IwrNVT5hetLmrArB/poyelzRMPzMj6+eDUQCZG71vWlva/ggnywc0ipYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TBIA1DL0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TBIA1DL0"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39f1ac13687so5907851fa.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785495146; x=1786099946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qP8lSfTVDVTLxsptweeRZq6mvy+d77VoFVw4712k+U=;
        b=TBIA1DL0YIZ//ZvojeqqtLz+GM9zYTJrU4Dlllfy9kXilD6/eYsqmYhNMZi2cXUWj2
         pipTFWYLDwyfQg00PmtxMcW5pZEyEkHBz634qSRjzVJNraIMuDXqCwto+S/xNkwFPNYz
         NX9he0bhitjeweg0QugV/Ztn0Yix0SF775U0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785495146; x=1786099946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qP8lSfTVDVTLxsptweeRZq6mvy+d77VoFVw4712k+U=;
        b=oCd9ycZmoEabN313FHPl4vJMjaJFEat0r0G1Ur6fG1BewqNSr53mrnBnLp0ybTXDyB
         yygIbqcxOXo7mh9FSCGjGCZcIfi9CciA0hLY/z0z2tdKiGWHXgzW3AsvLLDTpsfBFzJW
         JFuaMoE+/uzLjFdV8ooG/54GVQpjIxYqbcpuuc1EkXBSW9JW90q1WOYndNIOeS/C7+n0
         Y29HN16URhnxGQEerK2sZfNI5j2323m0Y0YBxfwxZQXf9SoE8fad3vPWEzYOKFamEQaK
         lBgaEr18LXZNesrNLHnwmSQP/56VC2kla4pxBk3Vl9CITXm8XjWKlh4/c4PvYoG74J0a
         3jZg==
X-Gm-Message-State: AOJu0YzoAafcKMlxMd44egO9WHutPHlxo2xXe9wAS9RpTxE22CADI4PP
	V0LzrBBaLQCnPxjA6k1xph3zeC6VRw6+6I3AIGF0H0imYmHqG7yYoNG51cwiGespTXRaownQMh8
	3aY3HbTHx
X-Gm-Gg: AR+sD13EBGsqT1dRZINaR89AdEbJ6vF9yxMYCB/Z8RYqnHbHGj565e5lmWyX3/9HjAh
	fk8FiQ7mat92eX2COH5lnbp+tLvQ1X3KmyEVmRk1/u3uA3E4gBVtMnudjD9t+kQbIS+SFIpO1y6
	bAX96i0L8HaT+QcWDeFh7BLKY728kDTz/RsHtv+JiGtSz+I26TANX1SQ0pqs4EG+6HbPoLZo1a8
	Y5V+yhihle2blDV80Uqz/HVZFOaj0NPH79k0ogrGOqGxU57E9NjzqpHZuRxvUKKV8BBvSnzxFQq
	5MRfK5pP6S6cCBZ61uk2RDIur7l/YCzBeKTHkmyvH3qca0XCNG0uh/CZRRq8H8yEWdjxanK549+
	7l3ouVXw1lVdT22ZWyvYZgKDgQbvhlL9nV4XtzNs6aL+NZkEtRJF3uFejbhoH+tnrUlddQYqO4V
	dvq/3T2B1FAhhCwKAEpJu9CzPWv8aWiAeolZYwdjAoF38omk+BkL69MwlptFPGbAl8zkF3fGKJJ
	fU7kkzUGeBAcPEg+ExN3F00OIBiMNHE5IqmjM+2ayKYmmaztw==
X-Received: by 2002:a05:651c:1989:b0:39f:75e1:9c49 with SMTP id 38308e7fff4ca-39f7e46a86fmr3272401fa.40.1785495146107;
        Fri, 31 Jul 2026 03:52:26 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f812aed4asm661781fa.22.2026.07.31.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:52:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 10:52:22 +0000
Message-ID: <20260731105223.732829-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <2026072041-maverick-blooper-4a13@gregkh>
References: <2026072041-maverick-blooper-4a13@gregkh>
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
index e33b9bedddda..408be24fceea 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -24,6 +24,8 @@
 
 #include "uvcvideo.h"
 
+#define JPEG_MARKER_SOI                0xd8
+
 /* ------------------------------------------------------------------------
  * UVC Controls
  */
@@ -1089,6 +1091,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 				  struct uvc_buffer *meta_buf,
 				  const u8 *data, int len)
 {
+	u8 header_len;
 	u8 fid;
 
 	/*
@@ -1102,6 +1105,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 		return -EINVAL;
 	}
 
+	header_len = data[0];
 	fid = data[1] & UVC_STREAM_FID;
 
 	/*
@@ -1194,9 +1198,31 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
index a7182305390b..8404814fa899 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -77,6 +77,10 @@
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

