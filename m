Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830207;
	b=guKn2oBhEu5ZFJLAQ3qzNbPeBeVoIj0i+gx0iw+90PUEMe9OlhE7P0hCxMEEfLAf7v0K
	 EuPfUxAOgnDsPaztw1lOfaAKb552v4IgH7z51/4anFJSmujc4f8G/ePsrRDLVtgBIeV2J
	 5fbo0b8zI+FjKAZKD+WqDhJIvH17+svsbVTCOpnuRbdw2aev6HfQTtNDvjnTEZpoHVv1W
	 aHELXdpwGIfeJ3kvBD4+kO0qw77ii9Ccj/NKkdn3pQqkLG+ahN0aCS8gm400kMnFUEpgL
	 gFUV+8DEepTfmF5p4dFTYGOw+WmrkWR8ZtrKV8aEqxfrqW3x3vfoEV7YWlBttsC0pNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jSBrXKq0EnuHM2QzrZ5bmia2mjHZUO+yHmfmjk5qeGg=;
	b=0LiGbX3c0Ze5p3UCrh/+Z/gFznAHV4nMUsUfMdiWPJx4eHOZt+IQmQ/X8gubvWOJ29B6
	 vDFoAks/EJb87ibkdMAmIqls8e8Od5yhc5jrQdUgYPFjE16T0eE/X3XAKCWMaG4JfrNC8
	 TM4BdZi/nmNZqacmFXO8R/EtFfrks7KSkfbEYdgmsbreWyUTcMwP8KaxBV6e0InU9d+zp
	 7FUf9yI6HfXNgnMM3pqKaYn+4fwR7AzlXjr167+c5fbjO+lPnMErjcNToZzcHc0991ii2
	 wMBHcNekYG27hoHxmqLMO9V0enSsFAjd2uWUt5Kd/cO4S5ja/stpr70hRlS/EbEnGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mRh1AYSc;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED1606A88A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBED1606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mRh1AYSc
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c10dc41270so3490430e87.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794830205; x=1795435005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jSBrXKq0EnuHM2QzrZ5bmia2mjHZUO+yHmfmjk5qeGg=;
        b=mRh1AYScEGf3D/c9eYuqNCIYkBP5lw38Q4dKqtNZVW4VN/wdjSr1zqvbsC3WAXBzvu
         48VgeS6Bl5WhIcYYpBF8EaTz5+2QOYbDC/Wr12BLbrx3evKxiqBNLy2vrTdCXAGlId4/
         hHZZZFAbjXpkwLtdZTCYTHT9Z7qDIhwswq5m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830205; x=1795435005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSBrXKq0EnuHM2QzrZ5bmia2mjHZUO+yHmfmjk5qeGg=;
        b=I1DyI8RmqWbyuQ7kT+MGPPa1Xowpxg+iuifW0hHbTXP/ntMD1dnEFsPZn3eyzYWAGd
         IsOP+Od17BHvyFubAwEGUPtY2M4Nd7KD22iHIp7/b5iIxmlkgDo9UjoQ40cxHLM5d2vC
         XWIekv/tZhtC1nc4pNGlTsXg8lNZ47xkuCUh0uiMycORiHi43JCEZeadF5Gj7mdHAIw6
         Yv8zNQLlZUit95cU1GNvIWOeX0k1JHw5T9IQnosLql0dWOuJH8KQQWLHSON/PUtVv4k3
         uaQXW8pPkWVvcNJn+S6dLN9YDaH68Moy2b2xsIuOpbnBNcqc3WGyWEGDSBC5rHjSNnvq
         wB2g==
X-Forwarded-Encrypted: i=1; AL+hErEVCkjmjZW5Vmj2f1BFUt/mEcJOzdJwmOGs/AmKiiWdlRO5J7vwwggOtDvxpvo1hj/mLv6jrGg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IygYyNsouTbyRMhSunZR1s6bT6427gI+YTiTtZ+yTgeaWJAMl
	CUJzLFVMl9GJj+Ke9Y8UqKnBL2AMwyqKw5fqUKgOSUmoXqsCIjI3VZQ+L+k1uVO8ag==
X-Gm-Gg: AYBFou3VxBOHsm2S7hTJz8ae5d5kqCmEWs53VfmW2DrZoCWH168lDHf9Cdh5uaNDsMq
	pMLuy1FsaBLS0yR35To9jZbg0pnpU5qaIEwP2eXOUTYbUvpS/SLI0O7oNFG+g+VwmQnXGKH4FjO
	2x8Bg+JLxcPqsbd4Hq1dM+/lgxWmAdoL40eBqj38ZOG2jY4fZBBonjv2j1286LI7a781uyC5TKI
	cLZbJY0BpuHXL50V/wcal8kZnNq4dnMByXrznkmLl8u59CzYr6tjLURqX3J+PC77m0TK7ZOVzAC
	kT4Xb7LU6Ig7BFK+TJCnu4aheElplSMWFH6ZdBeitqXvngSBOvd5QTyr7lVvF9liRlIBLZSN8rC
	wlJGsKDLsA8/t+kpDydwsjLS+oQb3Zc0G4PkA+WwWvlseKIi7xtDsgC16+bEiOwb4dsqMQOLiy4
	JzuEhmskSSC3qproBfhYyPuEHbNVKCBQbZJtoy7B7xJ9V9FkxR5PC2xy7F4rUYNzhEBztBF0DyL
	usrXbuApsi15kN6N3Mk7r1xLFTOp9PPf+cIeEIoCUQLPvnt/ixGsbP3uUOXkAnznRbapzA3WPvU
	E7n6z/dJZiP3eOPaqgrrEXpsxzeWHIDHuqh7RMS17ZXj14qnVcLwwxLM1SEjqW6504mo1xlhg5Z
	cFmCDrSdvCQ==
X-Received: by 2002:a05:6512:b06:b0:5bf:dc6d:3153 with SMTP id 2adb3069b0e04-5c170b46db9mr3813859e87.67.1794830205068;
        Mon, 16 Nov 2026 03:56:45 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad7dsm3183754e87.9.2026.11.16.03.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:56:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 11:56:38 +0000
Subject: [PATCH 2/3] media: uvcvideo: Check header length in
 uvc_video_clock_decode()
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
Message-Id: <20261116-uvc-shortmeta-v1-2-487cfe42fa89@chromium.org>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

In UVC, the header size is defined in data[0]; all the bytes beyond that
length are pixels.

Currently, uvc_video_clock_decode() could parse pixels as PTS/SCR
because it checks the bounds against the USB packet size, not the header
size.

Fix it.

Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 9cc5d83acbc2..e9be0a627033 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -582,8 +582,12 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	}
 
 	/* Check for invalid headers. */
-	if (len < header_size)
+	if (len < header_size || data[0] < header_size) {
+		uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
+			      "UVC non compliance: payload header length %u is shorter than expected %u (flags 0x%02x).\n",
+			      data[0], header_size, data[1]);
 		return;
+	}
 
 	/*
 	 * Extract the timestamps:

-- 
2.56.0.679.gc527c65306-goog

