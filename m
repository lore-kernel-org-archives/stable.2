Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039131C701F
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423313; cv=none; b=X2GBQUniIVVg+iJUyYE/VLcz7nlSCy3dZneRhWOnvC8xFUqvvzCWdin6Zc6E3XqTgal5WSWon7gv++Wlleo/PfTN4blMr5toTnfVGPkyQrRCYm7V6kcEC7PDWu/qHP/hyone2DB8RtugN0LnMhVXHRGHyb2QqTDe4gxe6Kv9aBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423313; c=relaxed/simple;
	bh=UGxSHi8cOn0uNpx7MEVqo9nMzemyx/MeWuc94D281qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYMS6K18aDJOth1rkkQB/H/3y3Suv8WRXKRq0deZGhyR+/9vn9C67dsjP7Sunqe40X11535nO6oWdRE0Pqv4ZMrAaTw20WDRMMerX+7VQU+t0iTevhAh5gpd2FD/hBMnJYq2dxpw4LZNQGmuac9dU4ZG+vArYYczXRih5zyyhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8ZYl+E8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8ZYl+E8"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so10635964b3a.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784423311; x=1785028111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NuToQr39obqpD4VdspvFEgg8d1UCcxlVMRw6FO2YI44=;
        b=C8ZYl+E8h+7+BKdQ25kSk8Mj9ylRiGk3acY7GSxZivkTvCElDcxmIzaicfsZneDxtm
         kGnHu6EgjjbNv4UtFycmSeQaG6Z+RrJgE1hpR9L/38WfS760BoOACfme5ry1ZOCBq97y
         SV234RoD81Yx0byLQcUlGHiJ7JarfWSAz1ci4g9RCnvw/ZY6x5ZvVI/+ceA/Yy6cICCE
         Mhs3mCW9NQ03sedeyFxRgbYIweX/lwgkv0fpCs85BIz2iWXiBE3vFQElahBGjN5rDlHR
         5iy3XI6rogCQTU/gIgmCYNjgMLb78xK8DIPkAJD2ZGNpu2H7RWTpOyauT088UKlp7byE
         70wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784423311; x=1785028111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NuToQr39obqpD4VdspvFEgg8d1UCcxlVMRw6FO2YI44=;
        b=LNxTRZRTn3qxnXx+gbRTVVECOOlZqeoa4260m9yDrSnFFds/+KkUTsKiZgvDD4BbfV
         qCRSRtXkguDWBSQ7Xv1xdPlJUyCOR5ees8IJcAzBT+xymg2yWO78KKy8RPulS5y4g++r
         OKoxe/5ysH+APaBu5s/4gL53H59L38o/nATeCR3yMvkaNpR6/1t5UpJoW6HJMo7t+6/Z
         GB2EpEj6cbAQSyJFgky4+hI6DaCXnqbTBCBNkA3NtEOpGf3AYj3dKA2xqrnRd/D9P8dK
         0aqhvlJCjyOBWyL9MmcnuQpk/aWIhUA9O8Y0weAAtqrx3FYqL1Y++rOE+BawsqSPSQrg
         SNfg==
X-Forwarded-Encrypted: i=1; AHgh+Roh+WMNeCuSmB8LK6GA0TdwB+OFEZrT+BHXUUrR+aPONlQcwsI2gPfPSQFe7FakYugW+sbCH1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiTMZrr/Rm0Aqymvp72W7ZUfu0M53OwwxzaDkqVyNSSIOcQck
	XYpBIVVzprMzwTTx0icpUiGmqSf6E2ylrwk0eP6r9FerLIicp7wKTi1c
X-Gm-Gg: AfdE7cn6Kevhmg1hqUFsuTwHiTPOQGd7ZDgyi2kijo/mcJW05oHQUtTmXhJ5AXvybmu
	i9iphf0q09f0EXIvvEuNnI8+RU6wv6XlLttFWWI37ITpcfF0R8a+ecKO8wcdMWLvabm39fz9kYw
	nYabhrueOdae0iWWZjd2r+dM0WPNw/W84w+tzx0n8/Bs7Ed/MQ+1Aj/tmJo5qRUdPyaaLOzK6dx
	EkSVDFuDKbae29qdPwPwyomrw2P5h3xe7hlxrg730c82/c/Vn/NteJlF6JJ9fqnKECugXklK2eo
	7McuvsT7ZH5MIfuKpDSrkkunxUedeW5sPzjPEAm6ah/x3MzAa1rAktz6p+xuUzX+IRDjsjRb4Nn
	rb9Zo59BcuFCo1x89iwx9SqVJZNKmificAroxcQWHwgEL2cEPDwxSNYARymePa24ATSRfN/nGB9
	i2vBWcU0WBRvi3TC4d0ce23uMszdj+Gc9fQWis9JHd1L8/NJuJIep7pkR/yORHOCAJ05Q=
X-Received: by 2002:a05:6a00:f8d:b0:847:94bb:30e2 with SMTP id d2e1a72fcca58-84c294d4bd3mr8627469b3a.41.1784423311283;
        Sat, 18 Jul 2026 18:08:31 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9af73sm3446544b3a.53.2026.07.18.18.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:08:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 1/2] mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
Date: Sun, 19 Jul 2026 10:08:19 +0900
Message-ID: <20260719010820.1924739-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719010820.1924739-1-sammiee5311@gmail.com>
References: <20260719010820.1924739-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_nor_parse_profile1() sizes its bounce buffer from the length the
flash reports in the SFDP parameter header, then indexes that buffer at
fixed offsets:

    len = profile1_header->length * sizeof(*dwords);
    dwords = kmalloc(len, GFP_KERNEL);
    ...
    dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_166MHZ, dwords[SFDP_DWORD(5)]);

The parser reads up to DWORD5, but never checks that the table is that
long.  The length is a u8 the flash supplies, so a device advertising
the table with a shorter length makes the read run past the allocation:
with a length of one the buffer is four bytes and dwords[SFDP_DWORD(5)]
reads sixteen bytes beyond it.  A length of zero is worse, as kmalloc()
then returns ZERO_SIZE_PTR rather than an error and the first access
dereferences it.

The bytes read out of bounds are not just discarded either, they end up
as the dummy cycle count programmed for 8D-8D-8D fast reads.

SFDP tables that do not match what the flash actually implements are
common enough that this file already carries fixup hooks for them, and
malformed SFDP has caused memory-safety bugs here before.  See
commit f0f0cfdc3a02 ("mtd: spi-nor: Fix shift-out-of-bounds in
spi_nor_set_erase_type").

Reject a table shorter than the highest DWORD the parser reads, the way
spi_nor_parse_4bait() already does with SFDP_4BAIT_DWORD_MAX.  Failing
an optional parameter table is not fatal: spi_nor_parse_sfdp() warns and
carries on with the data gathered so far.

Fixes: fb27f198971a ("mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 4600983cb579..d3d85b5d1b4a 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1175,6 +1175,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 #define PROFILE1_DWORD5_DUMMY_166MHZ		GENMASK(31, 27)
 #define PROFILE1_DWORD5_DUMMY_133MHZ		GENMASK(21, 17)
 #define PROFILE1_DWORD5_DUMMY_100MHZ		GENMASK(11, 7)
+#define SFDP_PROFILE1_DWORD_MAX			5
 
 /**
  * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
@@ -1192,6 +1193,9 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	int ret;
 	u8 dummy, opcode;
 
+	if (profile1_header->length < SFDP_PROFILE1_DWORD_MAX)
+		return -EINVAL;
+
 	len = profile1_header->length * sizeof(*dwords);
 	dwords = kmalloc(len, GFP_KERNEL);
 	if (!dwords)
-- 
2.43.0

