Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472017B506
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136112; cv=none; b=ZiK37Tka4EWK6Ih4I9486dfiwWJ9hKQ/BGt96YPndXnswxSLFYPa82QBkA0MEIsOtRh1kBw/IRFCOaKGlIDwhPUkOLIYFpT4CxQgcNoGm0g1hS9DaMtfuAMoGrmWrIcVj4rDQ47ErS3XAIPaZJXUn9dFwN6fF7rr4qUzsCO862c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136112; c=relaxed/simple;
	bh=EDN6m9UbRexYtEIt+xOtSeMajMXy63+AcyGLlLrE32o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiDIhvnilC2nlQ7cvNSVAkUii1Rcq4pPDWZuijV8m1p+HWXbiaE4Rry1e7aypVdVq62Im+OT0+9LHXau1ThgDekZ57jwXsEmv/ovaMLPZJAmy31fl2/lmXEQwz9pPN67uRt/4wVq12bIlVqZFK3WQwoKWuQxZGE9y4OaU34Nlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7/KhlUF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7/KhlUF"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c74722e27so24064401fa.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136108; x=1785740908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzkqreeHngQxOokHF4otaMSkre0ILi8PbO6vbHpwRN8=;
        b=K7/KhlUFRVBOdU97uqOQHckt/Eu1rhkqMSoSWmQDNUEKFYg93b3wyBc4oR/sKUNA3h
         leYiOiyHVhp5b/jZrIUr13W+hVycIbZAu8Uz4NcNxSO9nxQSkJoi1fdcf63mCKjXLDW4
         PanGWLy/uEeGC0XvYkc8jBSHYnkR9b1v6BZVT/ET8q34bno/Ih9WuLizcjeITUolUPnT
         wAGS/fkYO4dx2TS2djY/3M9yWV2Qej69zR58w9DjlROG24G+fKVjbitu9Ic1mB1Wy0eA
         CvjWWhxOGmqFVKIfQnnbWlm7NW8geD95EsaKcMS/VscOnZFv/cwdmBRawkDKyPuX9871
         6eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136108; x=1785740908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzkqreeHngQxOokHF4otaMSkre0ILi8PbO6vbHpwRN8=;
        b=SEUaMafKR7qs8skuX8gHu4I/53xeLesyfSXIeE7mndzGN1n6cCDNkCkayKCAgpihhw
         GVH5GqnqZBP2pT87XeBr/EYB5Gt2DMHZA344iz+955HGjaxlH7+VbzJmMM0JnSpF4D6C
         2pcACpR6Qh4XzSsck4gn5GycnaPsH2n9lIGj/aAkQh6E84g1XhG1V1w2dT999028Q59L
         RthGAzRqi39frpmIko4sITkpanIm21JPrkQnwyLpuoMWMTB0CGxAeHdWYlpS0f3CnXsX
         9Lzo8uS45bPRkDIVPzY1K8QXUQA4PDWzD0nYC7zXvN+QA4c5qFOJZqVEG1y3Y4BS1rY5
         oDGg==
X-Forwarded-Encrypted: i=1; AHgh+RrXP49WZVnTdfVE8gopLY/21HjlbQ+cDu1wKkr5wGDrg1hM7AZpFeDbQbxQ7f8rNf5pFW05dXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVwjLgeX7J7fJ1T9kkgeW2qeYWo/fFmuMt1hAOIdD6lEijcc/
	St0MUSZ29Y6tRYnNmwGmOZ33xz5s7zSkOjRP/Z9UULYcCEmGXmd8pEiiG1OgDbjX
X-Gm-Gg: AR+sD12CTW9BxuIBBaBDyLZ4JfwMK0/Uo63P5m76F5krffmE6NtwI18yarM9z8DuTuu
	0kw247Z5fGvIl3fYm8HXYz1blYVBVyg6nf5vUIhkdg2bAJJGWbpmvwgLHX4XkUAPv18aA6T76zm
	ijfyti8UrnbYhhqcWVA1r1JZC1FBfFZfYOaESHpP6g/7mN3GT6lBklJA7RzK/Dn1mwzJTK5+WSt
	DtYetI7DJFNPZXe0JgprEQKrQ8d/gbxcgTIBRlPZOusKOcC6Av3jxVEYGyQgmwcCtUzEk4iknT6
	m5d73GGejLDApLPpBBYRYRNPEnxJ1xtBWHtgJsbAyrNzhwEZv8Mvc2iDKjnxyNAd5W+WwkbzSqA
	f+J770BZjOmR/MrCVFKTfHxkEngAlaMOQH0I/AhPey1r6R4DxRkCyB35B/dIvMiYO+iqfR3xANr
	iyc5jDBkZ9XL0xgY5t7qJlidgYhtFkTDg5yM8lgvJsl97O7G29LeS/fI3SFj2x4clwDNjZWoodi
	Q==
X-Received: by 2002:a2e:bc84:0:b0:39c:f58e:5c8b with SMTP id 38308e7fff4ca-39f28561e46mr12241151fa.20.1785136108252;
        Mon, 27 Jul 2026 00:08:28 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22173825sm13461301fa.1.2026.07.27.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:08:27 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: dps310: fix pressure result shift bit definition
Date: Mon, 27 Jul 2026 10:05:46 +0300
Message-ID: <20260727070547.649074-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPS310_PRS_SHIFT_EN is defined as BIT(4), but P_SHIFT is bit 2 of
CFG_REG. Bit 4 is INT_PRS, which enables the pressure measurement ready
interrupt on the SDO pin.

The datasheet requires the pressure result bit-shift to be enabled when
the oversampling rate is higher than 8 times, so
dps310_set_pres_precision() sets it for oversampling ratios of 16 and
above. With the wrong definition it leaves P_SHIFT clear and toggles the
pressure ready interrupt instead, so the result register is never shifted
and the pressure values read at those oversampling ratios are wrong.

Define the bit at its documented position. Temperature is not affected,
T_SHIFT is bit 3 and DPS310_TMP_SHIFT_EN already matches it.

Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Found by inspection while working on FIFO support, and checked against the
DPS310 datasheet V1.1 (2019-07-11), section 8.6 "Interrupt and FIFO
configuration (CFG_REG)", where the bit table reads INT_HL, INT_FIFO,
INT_TMP, INT_PRS, T_SHIFT, P_SHIFT, FIFO_EN, SPI_MODE for bits 7 down to 0.

Not tested on hardware yet: the driver probes and reads correctly under
qemu-system-arm -M rainier-bmc, but QEMU's DPS310 model does not implement
the shift bits, so it cannot show the difference. I have a DPS310 breakout
on order and can confirm the raw pressure values at oversampling >= 16 once
it arrives, if you would rather wait for that.

 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f..473973dd0694 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,7 +50,7 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
 #define  DPS310_FIFO_EN		BIT(5)
 #define  DPS310_SPI_EN		BIT(6)
 #define DPS310_RESET		0x0c
-- 
2.43.0

