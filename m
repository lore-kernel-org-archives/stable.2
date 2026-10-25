Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952377;
	b=2oOKNP4H79YhyASZlzITdHrQkRrXJbrxUEmZ91edezb6TNepxwYUwoFDxgbjddptQsL+
	 hWUntmT6JMUXpgrlSYzM6oW1VmTTh/rbR20ijU9iGfuhRw2ImcOIwRREezXSc6mQ5Yx5q
	 gTfjHZA4NAkMNJ2m9lfL4E1hzkaG1pT5dazslgrCGoBUpGJIPyefo7p9f28fct3+Z/fSv
	 2kH9BPJ03fxbJAf7ccQGderYjtI9Tp5QhPQGTF23KUDHwmOMQ1BesreVz8/w831BHj9f/
	 QN+d1C9rXRXOupUobj4gPcL0D1fS7Efi9ax6z5sroMw5GvBo3Q4dEvf3jgD849/VBTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xHkFulZhzfdcytD8jcm7yE8C0cb0+bXKg5xNAHor0g0=;
	b=TjPWbLQxYbQTqmsD6hftoANwz4gZKMHLMc7clCYBnku85FBwgKQzx4t9c/aAGFtOAZvC
	 WcdMxBN38I2xk1QDrEf9t1NYUdm2ybCXG6ioFeiMelLYfRTBnuzQ+tAhV/3Djs/hcAT7e
	 jrmmJx2nd3M2QZoyFR9ifOBRsEVRYoMqpbXj3bj2D6jqHfJ31GQyzGpmQkrfJ4r/ldl2/
	 RAT4OWojrGcyD5SCGOrbV0HvHMnZfsLmot7xo/x8ulOAD9rleowhPCDVwj9yI/6SNroeJ
	 2+nBp/DHd5UikZ8muOqPRQO6ouO0WrcBGmVKrQlkqwIb8eMHwCbDnsWZHftyI4EYgkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c3D17ued;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF8606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c3D17ued
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so2441695e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952375; x=1793557175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHkFulZhzfdcytD8jcm7yE8C0cb0+bXKg5xNAHor0g0=;
        b=c3D17uedB/11KdUwEGzKp59eVMgf3RY2OyN+Q0UK0ghWGfxp/v3Z8S2trNNM8sTub2
         /rXLNxmQ21QLKtnif7yjDkKDyyEaDBczbapqUnbrhi9nlvocrChT7laHS4wHqoOwEI3g
         Q/EUXL6NTVpWjocnKxsFTGCKX5jb4ko8BRyeB9v3YBSut5ij0P0vINLMywww3mczSmAN
         uSfpjcQWwLr9j9ZfvdoDYtyUua+3cMVu3xVXVshS4VQ/JZvBQcn5fWMBZBreUC4TgwRh
         l+3bRVhId6ErXkmQVD80gjzKfcrb6XQpDcypAQt2TOm4SJ0u+NZ5fzC7ZhOZgUMezeck
         g2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952375; x=1793557175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHkFulZhzfdcytD8jcm7yE8C0cb0+bXKg5xNAHor0g0=;
        b=hYmEVpcWoiNrWIf1YUZ7Bsxu6cnC+1l0QjQfpFf/EdDVEA6RgxQbhkvDE1ihE1WfY+
         XfvB6uNkM4JB/UgK7d8Sp0UrzT3K9HDl9srNDSPlE2AIYO4Kyhb5m5mtYJ15KwaXDYtl
         RHdhTWVLJjJhekIrExM1POjfmSzNc1OAcoTMMSNJLaM3HZ/oxLos0oIMDkqMvmOsiF5j
         EP+mdg2zKXL8okLbVYPNToNo6jQ1bCC6qk2/VGxN6Gcw+9QGfx/6GQho9EhHyZ/ErklY
         N5ldI+Tj0pbsZiw1Iz9m6Owvaa4yLIaqhj+TovV4mKGJz6bridKfsSnDqC/g7Jzd1Bk2
         Xqqw==
X-Forwarded-Encrypted: i=1; AKwUvBw1qHbHo568ONvij77zQcOMkV9w86cQXHS7wj/8L80AhxsCNbAoY5JcqEIQfwK1qVwVUlWI04w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHrBVxPOUlXfFUgaOtdvldnr3YhqmEfeYQxzOyEG6Ko7McdBMS
	USIB+uHO0BVbufAjJauWRo4zFsMoq0xlEkqHrdtoRc5H/RfunZeC+hzCXlzQ
X-Gm-Gg: AYBFou2/jQ0yjGQcg+o/Czk/qb4G6bEkygDQWZgLw1hM65Ght7+cbsw5mKr3RILPl3P
	IgOuqnnsM3BL4c1YUMZk1LRyxtbIZIedSenavzxZd6BXfOfhfj2aG0Aml0+9KkIQSBhj82bcG43
	4m8rj1HCB9g2j0wrqY8AP1dOFrfZrIDrOf5pE7F4vMjOm/OtWOchWDjlCY/pUOBtM13tWcG/QqJ
	C3CZgkljcqGqcG7GYH/ZeSAtdkEM0VvTiefGp5cNHWyOM+PbKMbsUVbHhSZ+AEZHAHwLIaI7nyD
	6YQB18lgx0szBjHFeOOO9p5bCysvBKudbSAycWevob4PLc+CkRomDoM84Bcih6cx/D2cSEPaBpq
	x4JfDD4XrjCoYPKnQxbfid4UQh3805IVj7wVJkDDUeYNHuhYkPPzX4xcS/85YeiB19J3WLgwtHc
	IMkey2CgjJZ7rd/Q91vsH33oAuYKPDhKbPnCPFHrMXmgnv38gD04nP1PiB8Wy5n1s07md2t83RS
	JxKqshVf8+BbA5aY8NSwvdrFBBcHrVP+XT1Yy4=
X-Received: by 2002:a05:600c:8b2c:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4a35acaa6d1mr86565045e9.27.1792952375238;
        Sun, 25 Oct 2026 11:19:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2c0458sm136103515e9.11.2026.10.25.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:19:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH wireless] wifi: wilc1000: zero-pad SDIO write buffer to block-aligned length
Date: Sun, 25 Oct 2026 18:19:33 +0000
Message-ID: <20261025181933.3775301-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wilc_sdio_write() rounds up the transfer size to 4 bytes via
ALIGN(size, 4) before passing the buffer to the SDIO controller. When
the original size is not 4-byte aligned, the trailing bytes after the
payload are whatever data happens to occupy that memory, and they get
transmitted to the wireless device firmware.

Zero-pad the trailing bytes before the alignment so that no stale data
is sent over the SDIO bus.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 67dea1360f0a8..1a8c7ffcba496 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -441,6 +441,8 @@ static int wilc_sdio_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 		cmd.address = WILC_SDIO_F1_DATA_REG;
 	}
 
+	if (size & 3)
+		memset(buf + size, 0, ALIGN(size, 4) - size);
 	size = ALIGN(size, 4);
 	nblk = size / block_size;
 	nleft = size % block_size;
-- 
2.47.3

