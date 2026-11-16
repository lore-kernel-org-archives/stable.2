Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851537;
	b=f/o7ls0rdLY5T/AajRC/50MbwSp+d6STTs3hZRIs0+O0Y1H2uZKHp6WBfW2fyY0E+TXZ
	 rN1HUHd7ognMGLs6xJtUcnUcyuc8HAeTPyRTh0VEUjcp1+063gTs32JWykVbReX/1s6ID
	 tZkEMSBqbDgxrXw+iVxqFG1fDFebZ8YYBelVmZqsDPCgr2/PEZ5WFSdLo3F/4YWY80Ymj
	 97u0XlUSTKLlfTiRQHGCfWbJh7AfJJKtQpvbpcRR7VqrFhV54eTO+odHQ6uzv+PhuC5Lz
	 zCy3Ea3+QsfxjjVt1Q0Se9FRawqf/LJoGPvM1gaCtGG03+yeXgiXgFcKeKCAT8iqiQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Mybi2FfPRDyfDeC5velKUxV2mvI+QkF0VK4ji6bNsAQ=;
	b=2QkRsK3p3eRDBo223rxV9tXLjbytdfA15YwH+UPGCP0Iu70ok6wbS7V/tfbiiPhNKtj6
	 aEQggd7fii31sxG+JVidRI6/4ZQ4SSmTjgNfy3dBq99NRZX6ayiGZgVnBbj36+R8mCa4g
	 9I3v4f4Vp+JSYmyhZiT6DJ+oX6xRESHjHvTW5+xL793O5YrJROmg34g+DrNyC6ixlsRUj
	 s7fRg+2CsvVvYuqpmHxrbaHnm6b77o/MAvvjMlUh+JbEGOZQWI9IXuCH0FiAXeF9XCe14
	 uQHkD/PtuTEiT6kJ2A5jHMeaTSzRzWpVsa7OFlORoV9twkeBQwucxtxfzLLwX4trrmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Cw2Q5Gvc;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73393606A8AD
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73393606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Cw2Q5Gvc
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14e307f29so4359603e87.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794851536; x=1795456336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mybi2FfPRDyfDeC5velKUxV2mvI+QkF0VK4ji6bNsAQ=;
        b=Cw2Q5GvcXZUXyFxbX6kvaiwwK598oEfKRBEXZdMVZC0iMeCjklHqbLQPD3+pMYTQS6
         Hh2Ggh7R5gORayLRumN3cY7exJhza/VEiwSlhV94RgzqRibrpAgxYNXigvif9NOrqJih
         AVNFxlvvgqv3wzcmG7RHAmKjPgMzR58vwx60E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851536; x=1795456336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mybi2FfPRDyfDeC5velKUxV2mvI+QkF0VK4ji6bNsAQ=;
        b=ipLGYBbBPWNKCRXyPyYLQDsWXwE+NvJQCVfwScEzy/+fW27fxMHZCzLHWV20nRgYAO
         DPiOywNviZ08Hgs9XxOe2pFoUAQssejHxZOs9XTpvR/FWMQZ5ND9QA1UUu05Ai4971lo
         pnvUlE4dX/nDeji+P3QO+9b4ze3XbEwDXTH7gizBfMeUgYUBB+O14a/3KvvP3iBDbKA8
         uxAB1CVnHkY8fuTFn1KeQX7n9dfSpqAPLOyGgWFG//Km0anuntOKrtdW1oh/WpmmHYaw
         zB2GB2oG72TbDVSvFX0FIa7TVsbTSqBkQhaOFwQrqt7VSQyyll8OezgXOz8Ny9SEmilF
         iPnQ==
X-Forwarded-Encrypted: i=1; AL+hErEn3emmz2ytYheLx0mLY3/O6a2pfL++GKBm+s1IQ6YeQLtB983iqeZyQIx3aC0liaWIkXPeksg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t0WarZIvFi4zrGAOXpZePHFTcPy9rQkFRyg3365V7LGWf520K
	NDcVjHxNMlopkK/mvTFshzWQo22hX+ICJ0yno2oEo+lm0uwhcFNjtOiUCggZuAfeWQ==
X-Gm-Gg: AYBFou2Zbvts/6pc5qcEZavAWrc1xmIMDXsuotpGf+256k2nGTu/mUHk90uZWpY8X+t
	zfQyaQ3ckhESbOoxUTEPIh34A1zo53+rB4K5FAVXJ1h89AFsWb6LqG5noc+NkiInDgMPhh9br5K
	pRGwrzlAAjD/xHoAkRmKSLyIR9XTB392x3wFquK8Y0BTlv6YgGMMfkiWI/Ex5Hxqm2aSU+TsnRE
	uQEz1FsoqHHmHe/vGQgcMHSWIZ/NXIA51gLtZhmjOAKJCSEtF+We9mvs1mm/RHdMOlsz5f6ztzF
	4C5XZn+GbpXHpzZsK/D3s6E6FntsPfBkkDxqXdX56WjT1IExfsgNHtpY3EabtGUZRk45bjuJ6mm
	HVKqbO8tL5MHr8o3xUZupayqkhdg/RQuwWFqRKLwydUxFVhznHOf3iEuXQUkxQvIuA7fiyiHPop
	FNDkrH+NfuGEHZaPulxn20F6GfNigdVVVlxcl9OnZ/gWYwLMyr6c3YzLsfwlu7sEUEdiv0dcfQN
	Vgvpvt5+J1eBbZ/k2h8zhZhr8VimSBPfcZMFGivp3IANa0DeAC6wO8mqv1NC6qj2MSqYn/zv5Az
	X7msqDgcIKcK6VOzatVGu8Q96aHTLhiDfnMU+5dRVr163/oTFsgXX5wb1nSmNDPXiN8/OWfW+ZR
	YO8caC3HIwg==
X-Received: by 2002:a05:6512:3345:b0:5bf:b603:365d with SMTP id 2adb3069b0e04-5c1709d6b21mr4184157e87.10.1794851535707;
        Mon, 16 Nov 2026 09:52:15 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171333630sm3391252e87.19.2026.11.16.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:52:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 17:52:09 +0000
Subject: [PATCH v2 2/6] media: uvcvideo: Fix unaligned and OOB access in
 uvc_video_decode_meta()
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
Message-Id: <20261116-uvc-shortmeta-v2-2-62d4a8176fb8@chromium.org>
References: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v2-0-62d4a8176fb8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

meta->buf and scr point to packed metadata and USB packet memory that do
not need to be aligned to anything, and store little-endian values.

Also, scr + 4 is a 16-bit field, so reading it as a u32 could
potentially read 2 bytes beyond the packet.

Last but not least, the old code printed wrong values on big-endian
arches.

Fix this.

Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e801874e272e..8bae91af03ba 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1542,9 +1542,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 		"%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
 		__func__, ktime_to_ns(time), meta->sof, meta->length,
 		meta->flags,
-		has_pts ? *(u32 *)meta->buf : 0,
-		has_scr ? *(u32 *)scr : 0,
-		has_scr ? *(u32 *)(scr + 4) & 0x7ff : 0);
+		has_pts ? get_unaligned_le32(meta->buf) : 0,
+		has_scr ? get_unaligned_le32(scr) : 0,
+		has_scr ? get_unaligned_le16(scr + 4) & 0x7ff : 0);
 }
 
 /* ------------------------------------------------------------------------

-- 
2.56.0.679.gc527c65306-goog

