Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174E17A2EA
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423309; cv=none; b=IsOU9m7RSy0uI8/aT3qQOTy04PnR7dnM6VyzTbMAJ8FAId9lgFLCeX1Xhj6qauBXNQogSclbUzgq1xJ7cCVpmOCwps6P6AuYKVoUKkRQ8S9FcIqoJFn2lQOQJM0FDzPp5kks8Vg5O8HgnZww9AgRGAQkdgHXhK3Io4rGOHWcRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423309; c=relaxed/simple;
	bh=igHWA+Xm8rtA+cYl/AfZubhzqAEmWgNqpRMKzAJh1j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/igS+1NrCgbhaE80Dik/tWIXw90vTIUBQGCwQAKiOUkjp3CN7x6gAaQpeb39g9dGOt3mgLqTQsWqnn02eqZGJZRemwdAdJu2N6O9cU0uJiBrbn/z9wINuNMlDJzHpqJCmsJ+4JU94+fj9+VSilRa2yNYGLaReNCU3hBmixwJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcpAG7ti; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcpAG7ti"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so4639696b3a.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784423307; x=1785028107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DIdLJQoDNc4JYvLBvL2oNFaPJGBiZwdyTA21ZB8ViqM=;
        b=NcpAG7tiTY4asYM/770kd18shqqj/mcVB4MKw2bUOP1PA7L774imrQpOdR/avFOeC8
         8EgiMRKVqvxfertLmJ+SkjjTHpcB51x1tBh3VgrGX20p2c6i427tYE/v0M1zIEHsjaib
         3guDwgiDB+cE9yx9uvOupUnd75Jjm76oRBNxWKpQXKHVfkkO7U2PpzagsAA6YTXqim6u
         SOX0ZBl1lr+WttPlEzx42T5hcNlsm5ePei80iPKL2Vu9JzMufB2JYOwOb1xRILBz5MqP
         NATu9tMd9it+OnEroPUMzM/fBkKHhl4Kt9Opa700LoGKo9ZsIXDC3ol060qUv4Cvk+2y
         r88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784423307; x=1785028107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIdLJQoDNc4JYvLBvL2oNFaPJGBiZwdyTA21ZB8ViqM=;
        b=b90JQVIAcfBNaSyO1ujr9Y3pmovG00enICu6QEaAxPUt6vBhWqseepbfW/4h/s44Hj
         GYPZYjkJZTx2yYIxt5dRMrjz6l5n7H0x4v4+CryICq9bVcJxVJFlw6fiPkyRmTTW5ErN
         DknDYbGAHRfrdLd2KpCXXtPfvWxHFZlGV3GZ/8HXdzJhtcoFKgg0r3DcotXejtm0l0MP
         bbJJeJwMeBFijuPfRyDbmZ/r5jr19cTUapUIbxfEufI3p5RNjmvrK/m9ZY1uVAqJH71Z
         i78+Km6U9jyyHBMTGu1W7LuoiZSLx7gPJurj/SoN+fkI/lNyjz38OeHcYWiMOBHhwRCH
         wsuw==
X-Forwarded-Encrypted: i=1; AHgh+RqKCIamruAuQV2/fqGahKECLfIYfH7eKQ9rLLgFtdz2uoM3Shy4Njoay0Nwb60LkrjSA0GoNrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyamw70fcUGqdj3/ZWZq9wYY0h3X1FCmIp8PH5ZvQdqfxZEf3H4
	yFmSRafrvMbcpU6Oc+d/YtrwA2qH5P9K5H+x1oV7N0sFH1sESNGFyZU6
X-Gm-Gg: AfdE7cmjSjZ2gJOW7Dy8pqeXWlON2RP84XQK5Ornadma25H7BXSTRYQOYXFKOXFh4S3
	Ibn6DqrE06On726ObzqfVI5gcfleZOAcDyJOa/oSZ5au+J9Xff4RiHoPgDzXapgLtkVxbL02E8z
	5FNB93nqicbuJnnFjgqDypEcsTUchdfZDSJFrJIYBYNUPxuv+KrrHnFHYPhOGdW7ubSiT0w4kLl
	EtdwgthUoAtR9/BibSQAA3PLilM4Q5w/ddUx1739NpwVr2UzT0VY7P43I4veCJSGTsFqlJdqjNF
	ggZ5bdmQ8cMDAL7Bm4Qss88ExjoVC09SdCu37O1eYnEa5CAkJq2y4lGHJa8bJ9Wj0afvE1mwBOV
	lNElodJ2y8LqXEeX/IzBSxVU/i9NFZaSinfj6Qt29H0x/upznbaZwhZohN2u6GHBW6VG4uveWAC
	j+bYU7Y2dAxehgLCiK8aeU8jIsX3p9nzbZBOoOHhWfyG4nUhao8pZNcw3D/RgKCj2WQf8=
X-Received: by 2002:a05:6a00:887:b0:847:8d2d:713c with SMTP id d2e1a72fcca58-84c295016f5mr8267340b3a.50.1784423307388;
        Sat, 18 Jul 2026 18:08:27 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9af73sm3446544b3a.53.2026.07.18.18.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:08:26 -0700 (PDT)
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
Subject: [PATCH 0/2] mtd: spi-nor: sfdp: bound two optional parameter tables
Date: Sun, 19 Jul 2026 10:08:18 +0900
Message-ID: <20260719010820.1924739-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of the optional SFDP parameter table parsers allocate a bounce buffer
from the table length the flash reports, then index it at fixed offsets
without checking the table is long enough to hold them.

  spi_nor_parse_profile1()  reads up to DWORD5,  never checks the length
  spi_nor_parse_sccr()      reads up to DWORD22, never checks the length

The length is a u8 supplied by the flash, so a device that advertises
either table with a shorter length makes the read run past the
allocation, and a length of zero makes kmalloc() hand back
ZERO_SIZE_PTR, which the parsers then dereference.

spi_nor_parse_4bait() already guards its table this way with
SFDP_4BAIT_DWORD_MAX, so both patches just apply the same check.
spi_nor_parse_sccr_mc() is left alone: it derives its highest index from
the length it allocated with, so it stays in bounds.

The two parsers were added at different times, so they carry different
Fixes tags and are split into one patch each.

Found by code inspection; I have no xSPI or multi-die part to reproduce
this on, so this is not runtime tested.

HyeongJun An (2):
  mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
  mtd: spi-nor: sfdp: check the length of the SCCR map

 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0

