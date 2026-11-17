Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915934;
	b=sCkNAzApnpQaQ8vmnAaQE3W9y6wsSzgA4xSJBphxd/gVBNGerldX6RBeFsBo+Bg9oB5v
	 qo8hcll414Y+bOxGbHyBpcPCKwLZWq7imTns3NRVc5COQvutTMEK9CVIX/b+wwhsjNheO
	 B5ZvqAvsZcOKTZdBKO4Q5+mhX5I2fgNkxYGypY8xM0B4AQb5jF2YdegwgJQtctcb69K0q
	 dvPbj3kYqlAX/Dv2DBOdlX2APtp/GRisVF5/44VFYCoHJrgvBm5suG8M9eZB5qrXMXVba
	 AocPLRMkqZ2owne/6pFl5Wi5e7JzuFTYxXXPGAunO5/Gy4PrSeaFnH4O3sXdGAy+xdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=TAYmdl/66vF4RcVM8uARuF8SUlYU6Q2ZVCQpJ4fXX8M=;
	b=oTWtPfbGuwaZkuTG6ZpUXmjD4hUuttsF/vJqtb/r2ClqAYmped6EAzFgd0eS2KgCkHJu
	 Z8nHpCgO/GBo8KS4kJ1fFxauzHgzYyOlR3cOpheMZcpWfViZo9UQwMXTOk6vmMyEPmOq6
	 CoS6+Q3/kiajhH05ifM56F1elxPsC1IaQ0nq3j8tgYbGjUflqd5tIGK9I2MPWWmY+2xCK
	 yQ7MExVilKcgZ82pzNSypqwublljaMCDkXEvXKnqBQRi7lb1iA2ZlxAhwrL3wpXqGw7ap
	 QmO1i7tR6LsqZIPYdCMvy7QWajhIGTO+dsKc+W4vvu32hZKOHjU7C8yQRJsSqFi5Trg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WsqOSfIV;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903B606A882
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1903B606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WsqOSfIV
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be47aa555cso4888643e87.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794915932; x=1795520732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAYmdl/66vF4RcVM8uARuF8SUlYU6Q2ZVCQpJ4fXX8M=;
        b=WsqOSfIVK25F9p93Brwyq5FUsh06s2akhOotHBD76D3QqA0aAGgDo3nhbPfHQWpteI
         2VsdK9H01btnbfZZY2X/kQOEjVBJftHFgs63gbzTMAf9X3QKTj6k6qzKs8k58Yw7fxGm
         7ASWZq4F1S4bivuZu64rDBZU4oUb5Wq6jIOIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915932; x=1795520732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAYmdl/66vF4RcVM8uARuF8SUlYU6Q2ZVCQpJ4fXX8M=;
        b=pmPMDdaIMD3mjeFD1BqfNMJYzwsmtwdy6FPN8tI4mN4igSo9L0Xko3imJ5NfPqQefY
         0bHb2Pa2CDjtcSYUrOof3yvMAhO10thEFOZzQOsGnW+/icHQ6u/NJrSVQoh/Hv1FYlST
         YrvGEQCqvT+MDdnXlo0C7gugF+74Stt4r6i5Cmn7OMWuX9JN4B1j8B/Aa29EhRKNjGoZ
         pngnzqNMkWDwWdOZxRAnp85UdbCu8QpM/mNhw396tUbqOvffVl/zTa0i4awB0E3I6LSV
         AG9uc10e9QAv0fLTnkhNY6nsAi8SLvUMmmZCIeoDkjGsmmSDev6jFpadfFd6EyEi9bcp
         nZJQ==
X-Forwarded-Encrypted: i=1; AL+hErGNlEVtE/fW8gkpq6ZJApTJd3aCCnRN735tAe1mBVv/feG50rELNqrLvf4vXe4uv/FEuJUxiWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+plQmZZ2ACXgQR/RPlK74xmE8Rprj5W1Ktwom2T3cBEKUhKwkb
	KFa0gmdYwv1R1nFAPxB5lUZZd6u8ipKDxTjPKOuOAb/3EQSh+cV9ejlVIy2wiroAQxW8YSvfjDa
	QpwLDC093
X-Gm-Gg: AYBFou0iT3sdpgzVdz4ag7CHJcDCxCEdnJVRZDtJVxC5hno1JUEuNkxdk0NCFYGge7A
	ZoxL6aOI4xYun8oAGBUBPdFIQbaQTe3zArlf0N1CCr4My1OeSWXE0r80hf5SggiDl+2nZ3LYBI1
	2sSJCXj7rLWXArCp7ne353sASwyH5oM+77WIimYoruLBvMmbTC+1K5Z18XEvzACiILOxvMXBZdx
	Gg2hSaN92ePlUm0UA8O5HZiK1ukeIP9BEvEMcTd7HTWJFmGczaWoVfpx0mcoHVmfKjlSZPDy0G5
	xMdwf7YDhSxr9gluQSdf4tqZIFZA/AKfwl6puF1V5CWR6OTRhkqS85kpZaO3BxR9aDADkvBZ3xi
	Aes8vL4Q3X921h36T0UWoyudoBhARIQw9PZsTpkHJ+61O+/1CElkhB4RhhUEMKF2R+RGlZsuQmi
	qCFwW8MXjTJkun9P1aspG/0PeRJkYanKMdE0Df0em5IPTH6SD5OjhAZLJjQ6qONCicoDwavyl8S
	lvkIo+YmQoaKWfUklSd0wLK/YmLB6j6X2hRg0r0af9EF+AP+0uf1LBlCC1XWxCezvpC7Kxe/YWw
	IxWJjLQZBxsxKcAsdWj6QUXEuCbGAlit9TesfdpUR2wteyPlhBV8Tc7PGgpmXjAjSYoSSs2NBdi
	zUnijp9lEyw==
X-Received: by 2002:a05:6512:2305:b0:5c0:13f:8fe5 with SMTP id 2adb3069b0e04-5c170a07f28mr5117026e87.51.1794915932409;
        Tue, 17 Nov 2026 03:45:32 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712d9dd4sm3955141e87.7.2026.11.17.03.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:45:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Nov 2026 11:45:26 +0000
Subject: [PATCH 2/2] media: uvcvideo: Force the COMPRESSED flag for
 compressed formats
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
Message-Id: <20261117-uvc-dji-v1-2-7cb3cf3b4b5a@chromium.org>
References: <20261117-uvc-dji-v1-0-7cb3cf3b4b5a@chromium.org>
In-Reply-To: <20261117-uvc-dji-v1-0-7cb3cf3b4b5a@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Jordan Moormann <service@jordan-systems.de>
X-Mailer: b4 0.14.3

Some devices, namely the DJI Osmo Pocket 4P (2ca3:0023), set
bVariableSize to 0 which fails to identify the HEVC format as compressed.
Due to this, the driver sets the buffer size to 0, making the format
unusable.

Add a new heuristic that automatically sets the
UVC_FMT_FLAG_COMPRESSED flag for compressed formats and publicly warns
about the non-compliant devices.

Fixes: 40b222b56ea8 ("media: uvcvideo: Add mapping for HEVC payloads")
Cc: stable@vger.kernel.org
Reported-by: Jordan Moormann <service@jordan-systems.de>
Closes: https://lore.kernel.org/linux-media/c2c00ad1-b21c-42f9-b3a1-e03a0ad49651@jordan-systems.de
Link: https://lore.kernel.org/linux-media/c2c00ad1-b21c-42f9-b3a1-e03a0ad49651@jordan-systems.de # USB descriptor for DJI cam
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index cbc14569716b..f5446fc8100d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -332,6 +332,18 @@ static int uvc_parse_frame(struct uvc_device *dev,
 	return buffer[0];
 }
 
+static bool uvc_format_is_compressed(u32 fcc)
+{
+	switch (fcc) {
+	case V4L2_PIX_FMT_H264:
+	case V4L2_PIX_FMT_HEVC:
+	case V4L2_PIX_FMT_MJPEG:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int uvc_parse_format(struct uvc_device *dev,
 	struct uvc_streaming *streaming, struct uvc_format *format,
 	struct uvc_frame *frames, u32 **intervals, const unsigned char *buffer,
@@ -413,8 +425,14 @@ static int uvc_parse_format(struct uvc_device *dev,
 			ftype = UVC_VS_FRAME_UNCOMPRESSED;
 		} else {
 			ftype = UVC_VS_FRAME_FRAME_BASED;
-			if (buffer[27])
+			if (buffer[27]) {
+				format->flags = UVC_FMT_FLAG_COMPRESSED;
+			} else if (uvc_format_is_compressed(format->fcc)) {
+				dev_warn(&streaming->intf->dev,
+					 "UVC non compliance: forcing format %p4cc as compressed\n",
+					 &format->fcc);
 				format->flags = UVC_FMT_FLAG_COMPRESSED;
+			}
 		}
 		break;
 

-- 
2.56.1.708.g77570a6a1d-goog

