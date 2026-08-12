Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319F425CC6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530792; cv=none; b=Nf3OsSisxQhT5MyaMUqrixzZxVKXH5+K9Omz0QiJyXc6o+jWvGJTSuOonG6J+8iwqrwxhx1szKrsIbww7zlGbAwYqB8QTKLdeI5rQfyv7f0ckq1VAV6toegM/hq9j2yTyRBU1dhPeXPrNBJnpsGu+gDiqZ4/WDUdawHZ+1uOCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530792; c=relaxed/simple;
	bh=B8ueUhG5tBGvwqhk81omzoqC2jILrshowUdeHW5IBPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwdhCKLnW1NJHRLAjsqupMC0gd4uOjhMUQnrno99Zl25MmraRdRzbnNkaGhX0CwWFj3Yn8K7Jyr0UNfWFUBcxsjt9xHY8XxCGqel2JD5aW6cGdLwBDBFX5pSy3SAxQd8XPc2Z0guvjGgt401lYTwgFgAIL8zS1WJVmBCkzTOs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeznSG6m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeznSG6m"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so8860645e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786530788; x=1787135588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wfIp5NDU7PWeyYmfA4vACcCezJB2SbD/Br0L9G6eGm0=;
        b=DeznSG6mv9jKSk4rglFXT9baXJaPccQQoF298H1rMi9eKRZaQLeis2ANhZILTpUubA
         YrRQA1iY798aj8ds5VR6exSISLPjwmYqP+DG+tz94tcYPkT6mAZUB7kbssHFCdpJrbrS
         MCUTdS09XJPdK+KBcpxuseoGRZfp6WyADNlhzThMLO6LDm6rgCyk4W8ea05X6tiTbQJT
         /20IhicXqva+UNL9+RrbCub1KgLYeDadBctjxu5vsBdfR/Hh10fbPnYQDWXd32NatudW
         45tce91CO2JKm8bGCPhxwnrZsjbYL5l7db0+QSGVTIj8/8NGwCuK9849LZi7LL1r7ljF
         LXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786530788; x=1787135588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wfIp5NDU7PWeyYmfA4vACcCezJB2SbD/Br0L9G6eGm0=;
        b=ZVcckqRE3SPrGtfIXXVAegXDan+e6cVCXlJ8yJPJWsWfP7UsLAF6R6xesaopx/tFGV
         nGzKe1I2svTcFF+LW7u7IEW/7jAA1GueZVwT53cR806PnCfr4fhyaA9A08HQxHYiU8K0
         fAM+D96wai/Kgh4sU6wX4XGh4RXkVyY8Me8w5JlCNn+PgJL++jmFbozdKFXxvluzEV5J
         lEQtYSyS9oeC3HzB/FWgioUVsjleOIjQB73vLN9cPErzeQZOUESBuqDiLsBlhs/G2piT
         NzJo2TyGF4QuoU6jTBYGO2Ai5cVmMiRKQPyLeSITXpuAbIcdRQo7OKpB0xfu+lsCmfPc
         XlEA==
X-Forwarded-Encrypted: i=1; AHgh+RrfyLoaaIBxld4DOpCWd+ZV5BcnBLQmsWJ/ukInUvwZuB1LcGCiQ2tE+duBTsszWW9UDR1CTjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbuv8F+lDZAxzKY9xq1jQ44i75itHjz6ZafhM6lUrNT8WW3i3N
	wOau1NJVxxjmYpjNuHQq2gVHqjBByGFvwn2D/0apME62rD5zV5eXm6ck
X-Gm-Gg: AR+sD13+qlM75hyulwLJX2DQZJLzvZ/dDvPlCryISu/DOu+75FdadKE2l607M7TpW9h
	PZnICpdBZX2y7tZiygQ1eTsR7e+DOLNbq2/iNXJ+CTKH3Yrn5duwWdBXLeSHggJQvsLkHiohOlw
	VWEO9ye+DMlbla0AZfGXrSkMwmCriIlAWKS9UT5JDW466qoejTizg/KTJDZOXmB8k+URZR6OKmM
	u73uORCOK/CLaG1VVtV7lQMwpmYZDD0M1Ug0t6PRP3VZRrOdmukfxwRy3mtQt9Fml7e2qY6mcLR
	jWh1Qt0ODUcuvhNwLVTA94OZyiZAt3/ilUggRCDsKh2PMTvIk8Juoq2P9oWrcTRSIBwZfts4nPx
	d96cU1F7/rwlA0OpUZ2UimdCK7AwFY8n5q8s6Q63uGBl50U0uPmJfC9ersStYoijYuVIzC7u39M
	+f4OEcf9SOG7941aiQp5GA+MixCkpGD5u/p1sgSH1J4Xr6t4JCdmpK1rl7C1lG0u77dTdJf15XU
	JyPBA5rG1cb7kgkWW0MMD4rUiJE0Gn+SrdYLH0Sglc=
X-Received: by 2002:a05:600c:2e11:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-4997c0e2ba9mr30739545e9.6.1786530787670;
        Wed, 12 Aug 2026 03:33:07 -0700 (PDT)
Received: from USERUSE-R7PLK0L.localdomain (IGLD-84-228-188-63.inter.net.il. [84.228.188.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abf917csm73026875e9.13.2026.08.12.03.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:33:06 -0700 (PDT)
From: Noam Ben Shimon <noambs2999@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	mchehab@kernel.org
Cc: ribalda@chromium.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Noam Ben Shimon <noambs2999@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: uvcvideo: Fix integer overflow in frame buffer size calculation
Date: Wed, 12 Aug 2026 13:32:51 +0300
Message-Id: <20260812103251.18309-1-noambs2999@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807101433.54886-1-noambs2999@gmail.com>
References: <20260807101433.54886-1-noambs2999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function uvc_parse_frame(), it recomputes
dwMaxVideoFrameBufferSize for uncompressed formats. This helps working
around devices that report it wrong:

	frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
					 * frame->wHeight / 8;

These three arguments originate from the device's own descriptors, and
therefore can be decided by it. bpp is a u8 and wWidth and wHeight are
u16. The expression is evaluated in int, and the maximum value is
255 * 65535 * 65535 (which is roughly 510 times INT_MAX).
A device that declares large dimensions therefore overflows a signed
int here.
The kernel is built using -fno-strict-overflow, so this wraps rather
than being miscompiled, but the wrapped value (which is often negative)
is then divided by 8 and stored in a u32 used as a size.

Two examples for this (using legal field values):

  - 32 bpp, 16384x4096: the product is exactly 2^31 and wraps to
    INT_MIN. After division and conversion to u32 the field has the
    value 4026531840 rather than 268435456.

  - 16 bpp, 16384x16384: the product is exactly 2^32 and wraps to 0.
    The field holds 0, rather than the correct 536870912.

I don't think memory corruption is a consequence of this. The value
reaches uvc_queue_setup() as the vb2 buffer size, and every copy on the
decode path is bounded by buf->length, which uvc_buffer_prepare() gets
from vb2_plane_size() rather than this field. What a wrapped value does
instead is make the driver describe the stream inconsistently.
For an uncompressed format uvc_fixup_video_ctrl() copies it into
ctrl->dwMaxVideoFrameSize unconditionally, and that becomes the
sizeimage reported by VIDIOC_G_FMT. This is while width, height and
bytesperline continue to describe the full frame.
This also makes uvc_video_validate_buffer() mark error on all frames,
because it is comparing bytesused against the same number.

Compute the size in 64-bit, and if the result does not fit in the u32
field then reject the frame descriptor. An uncompressed frame this
large is probably not a real device and rejection is consistent with
the other checks over malformed-descriptors in this function.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Signed-off-by: Noam Ben Shimon <noambs2999@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Used a shift instead of division (Ricardo Ribalda) (Thanks!)
- Add Cc: stable@vger.kernel.org (Ricardo Ribalda)

Compile-tested using W=1 and no warnings.

Tested with a UVC gadget over dummy_hcd with WSL. A frame descriptor
declaring 32 bpp at 40000x40000 (computed size = 6400000000, which is
above U32_MAX) is then rejected as expected, and the streaming interface
is not registered:

  uvcvideo 1-1:1.0: Found format YUYV little-endian (0x56595559)
  uvcvideo 1-1:1.0: device 2 videostreaming interface 1 FRAME 1: computed buffer size overflows
  uvcvideo 1-1:1.0: No streaming interface found for terminal 32771.

I was working on a certain device that had a variation of the Linux
kernel. During my work, I had searched for memory mismanagement and
misallocation in media drivers. At some point I stumbled into the
uvc_driver.c and found a flaw that is not a vulnerability, but still a
flaw. I figured that it was worth letting you know rather than shrug it
off.

 drivers/media/usb/uvc/uvc_driver.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e289cc71ba98..29e23f94751c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -296,9 +296,21 @@ static int uvc_parse_frame(struct uvc_device *dev,
 	 * information. For uncompressed formats this can be fixed by computing
 	 * the value from the frame size.
 	 */
-	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED))
-		frame->dwMaxVideoFrameBufferSize = format->bpp * frame->wWidth
-						 * frame->wHeight / 8;
+	if (!(format->flags & UVC_FMT_FLAG_COMPRESSED)) {
+		u64 bufsize;
+
+		bufsize = ((u64)format->bpp * frame->wWidth * frame->wHeight) >> 3;
+		if (bufsize > U32_MAX) {
+			uvc_dbg(dev, DESCR,
+				"device %d videostreaming interface %d FRAME %u: computed buffer size overflows\n",
+				dev->udev->devnum,
+				alts->desc.bInterfaceNumber,
+				frame->bFrameIndex);
+			return -EINVAL;
+		}
+
+		frame->dwMaxVideoFrameBufferSize = bufsize;
+	}
 
 	/*
 	 * Clamp the default frame interval to the boundaries. A zero

base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
-- 
2.34.1

