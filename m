Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851537;
	b=DKBniAY9NXZF5ia6H3fGs87exl/dx7+xqngh+dPCQDQzHhI90cdJ0JM+hiyAaKpZpdIT
	 olYKnH1i83KV4/A+wJEGVkZuzvOkz2r8fJpLac7PQ+tq0bEd9EEMsDfBCLTUhnpu5OWLz
	 RBUlRxpLxoOYVY9TYfHoqJdy1i2yfgeTVMaTD8vsirWvc8L+SQN1ojvfi0hFu9eeCOO26
	 VXjxnUQdefphyi+stc6y1quyxrgJ1S/QhPJYzGf9gdtONR8OZXmO1pnUNpD+WytUiXa58
	 SzVPfrV+2jVe86fRfBm7rg4ozBuofOvCBKcG9W4Tf9U+OXEiGycc00EdcfRQEnsWqZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mLXA5MYZQzhnIjUN4es5XUBRMGwezqL22aWBvXkcOLc=;
	b=oq53dgLt8OFKO4497wNMOn60dMhrBwZJ45qs0CQ08+x0fwNeGoGkAJ3HTJgDPql+5IiY
	 ZCiabcvh65Dx3FCLME2SjhIyh/K1bTKI91kcV0ViOdU1j1QUHpFK/rEd7ZUuLtGgQliVh
	 qgy8ALy3n7hKX5dvZEfBRq78erkzVJSlZHpAyyE4qY2G5aCIZxzybAjBnquFnmia0xgPm
	 slH4ux+DYA6FdLCWaDg0RWBc7MO38zBnwRr0flVZzi4fbKf2Cx07uxWk4dUSOddxosCen
	 ctQg3tgqgWHTMviDT1kmP0ZSfI8kIrSplLHIygxTj1TAKSzBhXHIvtn5ZtTekChVgZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Clfk5jH8;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6999606A8A4
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6999606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Clfk5jH8
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso3374072e87.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794851535; x=1795456335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLXA5MYZQzhnIjUN4es5XUBRMGwezqL22aWBvXkcOLc=;
        b=Clfk5jH8durmCpYxgXWONWZnvGvbgI3g7xEo51hDcgnjL8gE+wlgNoDySxVR+CfOqB
         v5e3U21vbHUsh7d31kO+GQBco2jwfY0vpjNUm3GppwvpIVEZajTOpAbK7mHZ9qn9k9Pw
         EGBcuFmTnL/f5KUsdfrD5IYVeS2r0/U6VmBnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851535; x=1795456335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLXA5MYZQzhnIjUN4es5XUBRMGwezqL22aWBvXkcOLc=;
        b=neU2+L3L34JFquX/WC6DaB23OB2VtJHrIltakI2NC4+Nz60yhnMuOz48iIwOq0ZgP7
         ykksad35A7pNXr43fZaMG9JYVL5mOUIj9UqbnS1Q3T/iNewwGx8sgBs5Ly8zpqlorc2M
         xaOFkgbqmXNdYzOXyygSRBsQC1EU1NsEfIDQIPqqPU8XAwb2NjqXgua0K+bhvsU7MeUf
         ybMDbJ+ZBGIkOuCA/7pPL+BvXsH2Qj72Di0daK+NGzWZoou0ZOap0tclblBCqSVPrd5b
         CHxPBctBsarTVzwlPppNjwpEjj78jeBG11VWt1s/drVoTq2/6G+uL8YcXC331+yfihg1
         kHWg==
X-Forwarded-Encrypted: i=1; AL+hErF7y7+HrPXbXl/lrnM/pGde0/LvhuEhp91Bp8n9qShvBc5qcZqq/3x4RK4rCzuceb7BWnnkH/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z99wOQBNhxDeNJ2NLSz/FQz2UYY+qydgNDRcPDMmhL7wKS1b0fI
	WwWA6kM+y25EFr07Qa969n4JZwxYLTnWD/P7aGjpMvpqDPwW+YWidbB3CelpnN3lPg==
X-Gm-Gg: AYBFou3Csczfg7QcC9HclUfKMpD/ljAIoBigX3W5FuT2z9HfotE8LjAO2z2yk9AZj/n
	R2O9Kc3xD867pc22N1GStyfL5olYa/6Zkqrd/ToiyH0EDtZyEIosNZ9GdFp0lLZ3jb+OxCY/E2+
	PhBAjD4FgniMfTEWPyDln7Ptg/aITkqYMJ/qBtRsxjOoISDwKg+qt+LuHoitmuBv+cgN/oYQADH
	WwsUs8xmaew6TLI/oI/Wf3dMqTrWhtq7KwKlNuK8uxzuFhEZvkiLV8utHOmY9dq2g1Dr2mJKENU
	EPEVeKDZwVyueksZn6xzuc3+xRR0ylpoqGOn2mrs+hpcO7aWKSvyleYR9ou8mmLp547rAGg02Qc
	88qlJ97KWhwCDvu+WpvhX0ygqWts5ySTCaPJpGf2YV73ZqUjH7/atP94j1J20gIeJO8onUGmNN3
	kxChPAMsogVxYly2KxLgNrXqTvW76fSoe0gqYRMOtF8HCdIlfQ4oplYNj0BOVZGiXIavgAP2a/d
	5dbnMDiebdIBuq3XolCX6pP3yKiu+W6IHwlEcsIuZW/L7KWWd/Bdl9MO8q5RFIBGK2atKHuN4ic
	4OMAwe+4WSZBR0ZMpPN5dWkeZXaoLv9B1bXM6g8PxHLSqtFjb7HqrogK8hSKwNkkA9t/Xw6CNzo
	m0SdU7wiRlQ==
X-Received: by 2002:a05:6512:131c:b0:5bf:ddd7:8896 with SMTP id 2adb3069b0e04-5c1706062aemr3775316e87.7.1794851534902;
        Mon, 16 Nov 2026 09:52:14 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171333630sm3391252e87.19.2026.11.16.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:52:14 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 17:52:08 +0000
Subject: [PATCH v2 1/6] media: uvcvideo: Reject payloads with a short
 header
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-uvc-shortmeta-v2-1-62d4a8176fb8@chromium.org>
References: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Sinan Turunc <enscrpt@pm.me>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

The UVC header starts with a byte containing the length of the header
itself, and then a byte indicating which optional fields are present in
the header.

Currently, uvc_video_stats_decode() checks that the header is big enough
to contain the optional fields, uvc_video_clock_decode() only checks the
packet size (allowing payload data to be read as timestamps), and
uvc_video_decode_meta() fails to check it altogether (leading to
out-of-bounds reads).

Instead of adding the same check again and again, check the header
earlier in uvc_video_decode_start(), dropping non-compliant packets with
a warning.

Note that this changes the behaviour for non-compliant devices: until
now, the payload data of such packets was still copied into the video
buffer, now it is dropped together with the header. On bulk endpoints,
the rest of the payload is skipped as well.

Reported-by: Sinan Turunc <enscrpt@pm.me>
Closes: https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me/
Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 24 +++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a92a986ab714..e801874e272e 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -553,6 +553,18 @@ static inline u16 sof_diff(u16 a, u16 b)
 	return (a - b) & 2047;
 }
 
+static unsigned int uvc_video_min_header_len(u8 header_info)
+{
+	unsigned int min_header_len = 2;
+
+	if (header_info & UVC_STREAM_PTS)
+		min_header_len += 4;
+	if (header_info & UVC_STREAM_SCR)
+		min_header_len += 6;
+
+	return min_header_len;
+}
+
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 		       const u8 *data, int len)
@@ -1192,7 +1204,9 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	 * Sanity checks:
 	 * - packet must be at least 2 bytes long
 	 * - bHeaderLength value must be at least 2 bytes (see above)
-	 * - bHeaderLength value can't be larger than the packet size.
+	 * - bHeaderLength value can't be larger than the packet size
+	 * - bHeaderLength value must be large enough to contain the PTS and
+	 *   SCR fields signalled in bmHeaderInfo.
 	 */
 	if (len < 2 || data[0] < 2 || data[0] > len) {
 		stream->stats.frame.nb_invalid++;
@@ -1200,6 +1214,14 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	}
 
 	header_len = data[0];
+	if (header_len < uvc_video_min_header_len(data[1])) {
+		uvc_warn_once(stream->dev, UVC_WARN_SHORT_HEADER,
+			      "UVC non compliance: payload header length %u is shorter than expected (flags 0x%02x), dropping packet.\n",
+			      header_len, data[1]);
+		stream->stats.frame.nb_invalid++;
+		return -EINVAL;
+	}
+
 	fid = data[1] & UVC_STREAM_FID;
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index af8cef94ffff..278c7b0e535c 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -661,6 +661,7 @@ static inline struct uvc_fh *to_uvc_fh(struct file *filp)
 #define UVC_WARN_PROBE_DEF	1
 #define UVC_WARN_XU_GET_RES	2
 #define UVC_WARN_QUERY_CTRL	3
+#define UVC_WARN_SHORT_HEADER	4
 
 extern unsigned int uvc_clock_param;
 extern unsigned int uvc_no_drop_param;

-- 
2.56.0.679.gc527c65306-goog

