Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3A4A33F8
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649455; cv=none; b=Nt9XOfV5L+6ApQOMMfYYt7urVr3URqBi63Pn/at11pheJ4VPlWR4TzdqJ8BiGkri/ICgLrioKq5+rVwDIBP3hnwkOTes+wYp0SKoyTNYIA3JbgGtBTfF7Ek+kDiKA11yRZARoNY17PyI4K6RcVDkWCvCdaDMK+vHkJD/fRjb3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649455; c=relaxed/simple;
	bh=rwpz8oRKT2EHd6rvYnp/8VrSAUtSAqZ55UfOX89Ibts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gg4rSHEQv4JrGS1yJ6+tPowGPps30py6tEscRYBf9EkH+GqA+2iinkPdO3EdfDAqZavxCO0RZnHNd6/PdGN1M9k7o6W892yFSilUTk4+A7b1eJ1yviJbGGtSSINWwHjZkbYkozrTZZra2ox8NR2AAmwssUjkryDdPCY2rDUz6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7bmhe+5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7bmhe+5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3315c5dso17512535ad.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780649453; x=1781254253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3OkoXbhs5kLS7ezOvy8weCw2fewKlEBiuSMFva/mlQ=;
        b=I7bmhe+5tjMagUOc7mwfY1+9qFbJArFILkpZ5O5SCH+dUB6jwxxokJxnAbZAZS5Q8l
         lPWp52p7200jDaaVfLStjWRaxhPfWDvYPuaTLUfzq20rTPUYKpnAOIbcWR4bd3tQ/Ewb
         SKHUe/yPdirO7zx1C+O0qIw2qwmE8GphknLXMgrHAVmTtdPF0e813aIEyZplt6Tj2Zo2
         VHCxp4y/7nx8Y3whF8W0ZJSkKSQ7/pCsao7ORU4FQqMxXzVBhH9fT1ih84pt50zCZD9N
         bHfi7N8n9G+A9OuSP7GdTEe49+qxWtYIXv6JX/3JE71Wb5I3/5pFkXmofGAvljg7CsS8
         hs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780649453; x=1781254253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k3OkoXbhs5kLS7ezOvy8weCw2fewKlEBiuSMFva/mlQ=;
        b=nrETdIQO6aermJ9+qrgmWwwUAp2mbJs31SUhHQsFJPcN8IxabfvP34qMptzKdI6xyE
         mz60Zfp2Kj/pwhA1g0fIjDMssD1m4bHKfbcE5r81vEYTuGe6KpsUHtlc0ofJ8obijj6p
         YETdtnztGzAS2XyM8DR5mqMKGxHuYsN0Q6109+Y3vlaTRj7oejuc+jIcpzHRyZY0s32w
         EY/phW4dya1qQjGV+8v4SFJXufdwrIZFulE6NBGGCgrS0GJVdOWzVTh3CqeQXWmMlb3k
         T9iCeVzeTBmGbsilqBRBLaY2aa4QDtPOZbmhWZeEjy+InVNWD0NY05zbLVAaSToQotHf
         6ySA==
X-Forwarded-Encrypted: i=1; AFNElJ/O7q71Be2Pkwx9UBxjv791D3I+WqYyHCprz5AnoiQ8RygwdntGfKXjPqlep+3MdRhHfesd1NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7DQ7kU4kRWsEXUrsvwzTaRhFXuzA0qJ2y+nexyUDi3DYnJrv
	UsQXHXaO9Dg9WVVGwAit44u2GO6OIL3xrW2b6830xKCdc3XAsntNZRnN
X-Gm-Gg: Acq92OF3Vcrt3FHIWlNEKfvdCVrC55e6jDKKL9QyonkPq13Xykg6J2RfyIvVJ9ztf+T
	WhBmW49DQIUgI4AOIxPyNZHottcsew+WtLiur1p4qhJ+dlQ8IaiIQ4elmghFjWIUXqRWST7cpwU
	AxYBfHNKRaX1kbMQyEiSXGs936fAspugbJXc17RYXR0osR2fjYUCn/3cBv54j9wf/9NG0EGCx8O
	EapF17BOUGZNXyxLFAXIEwWCvQynv45+MMLUTF3qkW1y8v/LPRbBHtwlBNFgb5wlcHS7d1r9/B0
	RWgCrFKEs6JIuWd7jX466LrTTbOKW5DGbcsskc6AMXlT22LEH3euCWcSGm/a4jE5gD/RazEGNYn
	1MdmR7rzsXFdoVvc7GNiNWtfkdz6VTwoLJEs7Lp+LieR17h7kEsaulV0u15Q4BLR1NTt7XcAwGb
	7fMuC7JqY/nTtIiJNJn4iQXtlYXEV5LDPiFUYRsC3SS+1CLQazoPltCGAIAFNFvMAPf9k=
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id d9443c01a7336-2c1e85e04bbmr27080835ad.37.1780649452732;
        Fri, 05 Jun 2026 01:50:52 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fcdfsm108703915ad.78.2026.06.05.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:50:51 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B99234163B74;
	Fri,  5 Jun 2026 16:50:49 +0800 (CST)
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
Subject: [PATCH v3 2/2] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D
Date: Fri,  5 Jun 2026 16:48:37 +0800
Message-Id: <20260605084837.1875896-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260605084837.1875896-1-linchengming884@gmail.com>
References: <20260605084837.1875896-1-linchengming884@gmail.com>
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
index 1adb79832..d13ea93b0 100644
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

