Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5193644C5
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873907; cv=none; b=EHDHqniKTN4gfzvwcsMc9EgX87sckUrvzqlqVGNv9L3BQRq1pqoR7zFSOUcwriYizLrOOHI4cazHgVkPslK7ghYXQ1n7rksIBC9KeFz3YiJk3T2SDenngY4v4mU2yb2kHagBdRxNnofSukkfofOxSStHu8E4/t8YuMlnNZrVkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873907; c=relaxed/simple;
	bh=zF7LEpAl1TlGogqI/nguiy9uCHqliGxv7yw1OsiyGFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rA98RxyEUllQVjjKaI8UA+l2n73S2FFjFiydz1s2ap52Iz8/QHAO7vsXCYRCB1JmMqxkJ3i3m8jLbmAMrNQafZogpuwEk5Bkx9YkngpYWsqPbJPqyj9MSiaKD1UZiQ5PrD0Itz7RzubYzrP1iL67rn1naCS59NVQJVsL4OZK2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny7lv/Ah; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny7lv/Ah"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so65903b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782873905; x=1783478705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhdK0h9qN098ZBlBAGds8RFxtjxiKXaQo70sxkxPcBk=;
        b=Ny7lv/AhXKbE+J8eaedOm7ftGo9ZpYRbCx7M3ZaZhp8zIjQfb07ckiGtJB3WcW86A9
         BxXRFAZp8r/7br0QjiT05BDvfQUkACCPbiPw7LCkGoxhmrwwUGCluUvExN11fLNt6ohv
         +zVBJhTG3gfj7hYTyiTeYJ8I+ILKQw3RwI90Y6o40Sae1kHKkXsqZFnweCoMb+tmJ7jX
         13eO8kEgBJJZPfANjVQjuvvCogf+K6zp5OAJlb7hgVi8iHB+yss8J02nbw32gPSvuwP+
         MLiTACMrU1wwOk3g82f/o11f6sKYJJj9VJ8Uxwct8MljNjXDEX5sdUGo+xiKZYyNSQ6u
         N3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782873905; x=1783478705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhdK0h9qN098ZBlBAGds8RFxtjxiKXaQo70sxkxPcBk=;
        b=n4nDYfZVKlUmKD+uzSgs+JCbiYu7dE9lD4qtczSxm/V/8hX2SPPGv3PP669KZ3OWJo
         5tymi3cwes3fxcDuupM9BZjeVCaPovFmeA63CedsRiHtsT4CZSYf1URuyDN91KyKlwP9
         bPt24xTaVICLuBPrpLHmejV6a6fC0k3ti2N5XvR/XfeFhZdlvg5ouJ2cYEx9moJo3xhF
         v7qmELUH5FK3XMR/W6zxZ2abTM5AIVxbOrbsFXeAqjEprElmDXx7GMHnyrFAKSwc5NGe
         +aMxwa0ZiJdmP3/fxunCn7nnWo+8l9QoWZrIrUWociscFO1+vOqixinXm0JXyI77pmh/
         G3Qg==
X-Gm-Message-State: AOJu0Yye1JiA5ZKoe1JoU0pJrchbm9W57ktsgiAwciclFmtIosbyVxvt
	xh6SpTsqO5nlJKJ1TBjNM27k6QPPAvDxWRjy7cQCffRLvB2Y+dPFSb+n
X-Gm-Gg: AfdE7cmnONJovczy/AlC+iHvTIApV3nq0cC37Fhy52kFS2gryeyzVLc0cUTZt9bc9ux
	RN9eWNu5GdZHZGVDdO6FnLnoKIwscUZbGQvP2AKcKvKxMAMszKB92ntRm4SkGhMgkK1E8+W5u+d
	bg0Amusm/9TJE25+TD4H0fdTIUA58WIJ/K4xZM2pH5S8p5LCVqIV07gnR+vU560ikA1kkT4kr+x
	8CxS7S2P4ELaX2y4H+ikq79JJQoFyHO55sgni2EEfsIhCk8r6h6ki5uFDNkyXux/tPe3ma5y2Xz
	YLVRT0Oqx7YQ3AiOd6gkAKppBsJScJtBf8uLa7D1X/zSqWYK5V7kJV4pIX5kpeX+FG4fXCjs5cY
	RaDTdIWKa/+DW2QPd8EWq+NpWv6p2AZnHflraeC/UccKyWaYwnz0zdYTh42LmakGhqGMEQaASl2
	7ZCw0UX3FnN0f3a52O70aId6yolPHBHkYrXzU=
X-Received: by 2002:a05:6a00:3487:b0:845:df4a:2a2c with SMTP id d2e1a72fcca58-847a81c1ea7mr3414947b3a.8.1782873904807;
        Tue, 30 Jun 2026 19:45:04 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d41c0sm2993631b3a.33.2026.06.30.19.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:45:04 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 99FE2416A066;
	Wed,  1 Jul 2026 10:45:02 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.12.y 2/2] mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g
Date: Wed,  1 Jul 2026 10:42:04 +0800
Message-Id: <20260701024204.2730472-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701024204.2730472-1-linchengming884@gmail.com>
References: <20260701024204.2730472-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit 797bbaa7531f75985b199e484451fa3f954382b3 upstream.

Due to incorrect values in the 4-BAIT table for these two flash IDs,
it is necessary to add these two flash IDs with fixups.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Link: https://lore.kernel.org/r/20250211063028.382169-3-linchengming884@gmail.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/macronix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 678ebaa220ca..6127565372c5 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -110,6 +110,10 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_128M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixups = &macronix_qpp4b_fixups,
+	}, {
+		/* MX66L2G45G */
+		.id = SNOR_ID(0xc2, 0x20, 0x1c),
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x23, 0x14),
 		.name = "mx25v8035f",
@@ -165,6 +169,10 @@ static const struct flash_info macronix_nor_parts[] = {
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.fixups = &macronix_qpp4b_fixups,
+	}, {
+		/* MX66U1G45G */
+		.id = SNOR_ID(0xc2, 0x25, 0x3b),
+		.fixups = &macronix_qpp4b_fixups,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3c),
 		.name = "mx66u2g45g",
-- 
2.25.1

