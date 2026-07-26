Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CE3BB12C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072931; cv=none; b=kFfoKiGLO1qbVxgfvHtE2K5eq0I9hmgype7dcEiGr1YKoL1n0XO9qoJJIyhY0vSBgZMy7lsdzXzUMuZAjhlb4WDGxWlf5UFHUgidSc9oaPXbVIMf9waqIPA9WhHEFc+YBzVb5cfTcWw38npLttitX5MjD0snoneuvneaKOn6b5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072931; c=relaxed/simple;
	bh=luTvluiHzxBxJSr9Z5cDQvEsOXj6d+ib2OKYOC47Eyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSdWQCHOOxUjm2mSwauHvsWsugUErv3V8LELg9D4Q+hQl30aKlnKfYadblxMs6HovJHSoaa7FB9/XDZ2rm/n0QHWLopM/jKULpAG6qgCbSWH6+XNjIsKag8qAjUWVfuEltnuka7GQsYUuqP6s+hNL2As1+WB8kZPYoYYqS02hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcY9xYqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcY9xYqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E511F00A3D;
	Sun, 26 Jul 2026 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072930;
	bh=SJd9Bz/j/Z7jDdRfaWB8sltvUnoDvvdur6wNsmvhes0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcY9xYqZqPhZ4/wMDEZ10g1ndNNpCmJ1A3+xDnVK34wfWx6bD04bM3GrDdU/zqSfq
	 obAjhb4x6t2bYw9/Qk79+5Fxy5hwN+4SSm/UIvBOYxa+t2yGjmdFbOHugIWmGLmKeZ
	 9aUop9ua3tS0JhGTqo2UG6VevBW0B3dUGle4+JmHKTI+x/fDfxkDrKvlMli8g4oQAs
	 xoXcmQByzBtza+5ckqZs60Q+jhttAQFbAE9DDU2Bhy8EGRmV4wqg9L2oUr/wChlp5l
	 IJilMUP/75+rJ1sjPBT4unFJ1p6kvm8wEvL9snPoj2QZcDSlxLsEZOm4IZO5wKTBdi
	 rg1wUvACz6CgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Walle <michael@walle.cc>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] mtd: spi-nor: intel: remove global protection flag
Date: Sun, 26 Jul 2026 09:35:24 -0400
Message-ID: <20260726133527.364488-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726133527.364488-1-sashal@kernel.org>
References: <2026072003-borrowing-opium-38cc@gregkh>
 <20260726133527.364488-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Walle <michael@walle.cc>

[ Upstream commit afcf93e9d63fc1e15935a2df9457f803394e4f20 ]

For the Atmel and SST parts this flag was already moved to individual
flash parts because it is considered bad esp. because newer flash chips
will automatically inherit the "has locking" support. While this won't
likely be the case for the Intel parts, we do it for consistency
reasons.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20201203162959.29589-6-michael@walle.cc
Stable-dep-of: e1d456b26bf2 ("mtd: spi-nor: swp: Improve locking user experience")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/intel.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index d8196f101368fd..6c31bef3fc60d1 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -10,23 +10,13 @@
 
 static const struct flash_info intel_parts[] = {
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-};
-
-static void intel_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
-static const struct spi_nor_fixups intel_fixups = {
-	.default_init = intel_default_init,
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_HAS_LOCK) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_HAS_LOCK) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_HAS_LOCK) },
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {
 	.name = "intel",
 	.parts = intel_parts,
 	.nparts = ARRAY_SIZE(intel_parts),
-	.fixups = &intel_fixups,
 };
-- 
2.53.0

