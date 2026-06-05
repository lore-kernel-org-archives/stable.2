Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AB26D4E5
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621218; cv=none; b=lQXeEi2aJ0I+D5qo2YxaPRve116b8OhU9UcN43vyv7Q5BL0T6FkdOvAzD+nklu+zhAW4Zq9UZY7UfaYW0q7X+6NDS0agPXbof2OmdChSlDoi9NBBVvJoGWIY+8t3q2OvdiBJDvtVi3TKZfHX6SS3R7jtQKxg8sFdClQlm+hJvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621218; c=relaxed/simple;
	bh=u0/w00vlK6fi8yvn+h86TeNOxWHIji6kmAtn8Yr+LtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrjZ6WB3D1hbMh6j5Bm1u41JhJ0jxTlm6TMhzKwdARMCSYC3r/QXL9aCQsdUFaL6KcsRKIxjoIJ0/TUwqkxnR8dKJjR8jHBs6h9El9NN21jrxsjmj9U1D8ZPdmbrjdAMre/mtapuS9zzv638ga61/paX9V/2g7anTf/KlquKgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOI0GMNJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOI0GMNJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842338c18e0so979499b3a.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 17:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780621198; x=1781225998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2yNPrajpmUjXUxkDV8KTQdIiGB5qpjbVC2V+xxbVWk=;
        b=gOI0GMNJIveWfc4p5kpW6qQu87tDfxWijmyP1iIe3U6z+FvKifDOKWhTkcxsJL8cRR
         VV/r0iDy5qUBCCBiS44/0NgaKKEA05kDdJPEke8ZZXUIOj5VAKk0L73MRgLatvMoL03e
         mahDxre9j/fRw91JPo55JnlQxl1kZP+D0oizZonj1+FMp36bFEMcb27JJofg6g+lFMn0
         GcMfQ30KYCORC/EriKIUm+NGeZtgwsZLcZVZ4SLC9nCx4ymF7rYoyI52gb2CDK476/Pi
         kTqTakXjglIRn+JxXozM57Q4eRoqrtB74LJp0bh78B9WEHTh0YddmHv5R16Tfgzdk26j
         YjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621198; x=1781225998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2yNPrajpmUjXUxkDV8KTQdIiGB5qpjbVC2V+xxbVWk=;
        b=HIYIN9nKba168XGXPTVLtxelNQKbNiiSkWdEdJaySkPrm2rhyafYwp3ZcDL3snt+Je
         UvwY+rxnRWKygceI7xW7SLDYPjTINhwbmhZs0frvHNe0F3cu3fMjv33igtT61Zqf3B3f
         RVkAn5ukIsukEZWtfgBlAXJ4tSu4y2yiA8czL3WSBaXs+TRS/nzYLziGrsNI7elLwD8J
         QVD0fcam6ChK/7VMA7U/M3Bkaq2z2ve8yFu/GSb5pyOAl30Z51ejbTdJy4eViQsoMZa3
         hAnV3SH7VycXYCKk2yx4zHygIH7MJFM2C2/4jkmywsnPYS+wTlFaR+7dyO8bZzp/Esat
         C/OA==
X-Forwarded-Encrypted: i=1; AFNElJ/0PtaPYvlHBYivRcy9FFyeqbwwobB7aKYsJr3H28gk+3EEHIBJcNbBjtsUWBwiub46YuigRN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh747JGIQWjI4btqgNl6jC5E9Q1CZzytGv0/929u5e4AcfaPPG
	Qip0TSU32hvg/hcFCFgT6JhwMcm0B3QtjC12N2ssIKbBO7DrY+ju6Gr7
X-Gm-Gg: Acq92OHpfATiZt8/LAGyW4et/SYo5MLkS/B/4xtJG36oaFo2/MLs0RP4n+oQfWKqdia
	ktb+bY2mTsHZXN77DbwyS+ndlVyDRe+UXz2w+52yg83ZK6bdt62jCu/BGv9Ds+8m6uLU/QQjAFj
	YZtN0LVko0kr/Mt4O6jiepbJtswEhwoG6t8I5ySQiHGbW+DCAK52PhM+KFviwIh7tFFp+Lwwhnu
	L/n1JKceuGGDOtILlt6UQDoP1zZiKulfe8AWLu+/4rBw+EqDXiGNtfMcnLFLiMPkPNJ7Zlx+aYH
	kifEIJg8SFXbJwQDipDxqub7NbH+II1Qu5jGAByMwBQBIz9+CbDS695vLtgXNiZ/woF9qjgrF7w
	BPhMGJWgSI1e22BR06PRBpL2Tz+enXVoN1aRpweN6E/u4BNGEhEjJLTUNcNIKAXIOqwYc60q+Ty
	EBu3pq2TFi5NKFzjXDuGwMie0/jr+qlxRUflqE+/EC3i0aMTDv6j+MPY2M
X-Received: by 2002:a05:6a00:908e:b0:842:459b:d61b with SMTP id d2e1a72fcca58-842b0f90d88mr1002312b3a.32.1780621198003;
        Thu, 04 Jun 2026 17:59:58 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428235006dsm7730884b3a.13.2026.06.04.17.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 17:59:57 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 7F6284163B72;
	Fri,  5 Jun 2026 08:59:55 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D
Date: Fri,  5 Jun 2026 08:57:20 +0800
Message-Id: <20260605005720.1857413-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260605005720.1857413-1-linchengming884@gmail.com>
References: <20260605005720.1857413-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

In a previous effort to drop flash_info fields and rely on SFDP, the
static size and no_sfdp_flags were removed from the MX25L12805D entry
(JEDEC ID 0xc22018).

At that time, the legacy MX25L12805D was already EOL and unavailable
for physical testing. Verification was inadvertently performed using
the newer MX25L12833F, which shares the same JEDEC ID but supports
SFDP. As a result, the probe succeeded during testing, leading to
the mistaken removal of the fallback parameters.

Since the actual MX25L12805D lacks SFDP support entirely, it strictly
requires these static parameters.

Restore .size = SZ_16M and .no_sfdp_flags = SECT_4K to this entry
to fix the probe failure for the legacy part.

Fixes: 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash info fields")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index febcef6a1..4cb7c1e98 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -155,7 +155,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	}, {
 		/* MX25L12805D, MX25L12833F, MX25L12845G */
 		.id = SNOR_ID(0xc2, 0x20, 0x18),
+		.size = SZ_16M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+		.no_sfdp_flags = SECT_4K,
 		.fixups = &mx25l12805d_4pp3b_fixups,
 	}, {
 		/* MX25L25635E, MX25L25645G */
-- 
2.25.1

