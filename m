Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C907207DF7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991791; cv=none; b=pwloEGwWydlvoBcXE5SIn2AJsueQajA4QNZtptukVVnNcvR9uiljEzqoCOr1E2XZe/vAuwxO+OwnwNKPJF4IbfSzBPsRdLlsdXFr0x2Xi9AuHBDwYbm6FZwBl7d9C4QUjqMHx9xIw8K29L5zVGOKWAGum0yuGkec/MBxfpVrzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991791; c=relaxed/simple;
	bh=Ld6H3w3XWYSwMwbwNBzkAjNiO0iCTHIKQ7HzSzW3Muc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnRgdse6r5VSrpw/omxTadhElHnQJOIZezAHS/fKNoRBHNTBM/g7+n6xrTWljpwz95mnfyaDgFWH0phPyCCoT+Wuo+bYxSOeeppdfx4MxxnG7m2YVwzMMTis+Wb6mM3DuzvmJ4ww9k2dNLlZlgX94W81yk4l3tl432ox0yaKwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmPOjs8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmPOjs8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2F71F000E9;
	Tue, 14 Jul 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991790;
	bh=FpEdli64lCknD4tRrV1a2HpFh8jLFyGh+cNeePqcbNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmPOjs8j8S2z58/o/ryMVNeGl7S/QhhhYRYRlFSPQrpXTqI91NIJHfHTfEFo/qNQ0
	 N5n6YSL6T7h5ZjbDPkz+ShE8XQCwMbM6eNU2IMAamzdfFbnFI1WV5BcqbSx/QQFVOB
	 UBBZERf/rRxv2CMcq64sG4f5hINb1BEjV5V+HCBfqp63Dza7cREZG5akKU5xlQCccd
	 YDAx1J/jJYvZE/wbWPcgZmGIOPhCir34gwVAd4KsqjEzgEfGt8TUASh3ZakWwnR5Cs
	 WWX6XF/P/nxORDcT2QTfc5yNR/KhEnZMBA7BFG9MP5dBIhPlYpyThgW7VkSVNGSq+c
	 DwgXgabkS3gpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/8] iio: imu: inv_icm42600: make timestamp module chip independent
Date: Mon, 13 Jul 2026 21:16:20 -0400
Message-ID: <20260714011627.2188779-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071317-refill-huntress-d0e2@gregkh>
References: <2026071317-refill-huntress-d0e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit 6e9f2d8375cb24ba75e02e0272e9164d06a1522e ]

Move icm42600 dependent function inside the core module.
Do some headers cleanup at the same time.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230606162147.79667-2-inv.git-commit@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 11 +++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  | 14 +-------------
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |  6 ------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 0833dece8f9e7d..0369cfd990ca01 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -522,6 +522,17 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 					 "inv_icm42600", st);
 }
 
+static int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
+{
+	unsigned int val;
+
+	/* enable timestamp register */
+	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
+	      INV_ICM42600_TMST_CONFIG_TMST_EN;
+	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
+				  INV_ICM42600_TMST_CONFIG_MASK, val);
+}
+
 static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 {
 	int ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
index 7f2dc41f807bbe..d3d560eaa7d8ed 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
@@ -3,11 +3,10 @@
  * Copyright (C) 2020 Invensense, Inc.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/regmap.h>
 #include <linux/math64.h>
 
-#include "inv_icm42600.h"
 #include "inv_icm42600_timestamp.h"
 
 /* internal chip period is 32kHz, 31250ns */
@@ -56,17 +55,6 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 	inv_update_acc(&ts->chip_period, INV_ICM42600_TIMESTAMP_PERIOD);
 }
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st)
-{
-	unsigned int val;
-
-	/* enable timestamp register */
-	val = INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN |
-	      INV_ICM42600_TMST_CONFIG_TMST_EN;
-	return regmap_update_bits(st->map, INV_ICM42600_REG_TMST_CONFIG,
-				  INV_ICM42600_TMST_CONFIG_MASK, val);
-}
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo)
 {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
index 4e4f331d4fe4b8..b808a6da15e585 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
@@ -6,10 +6,6 @@
 #ifndef INV_ICM42600_TIMESTAMP_H_
 #define INV_ICM42600_TIMESTAMP_H_
 
-#include <linux/kernel.h>
-
-struct inv_icm42600_state;
-
 /**
  * struct inv_icm42600_timestamp_interval - timestamps interval
  * @lo:	interval lower bound
@@ -53,8 +49,6 @@ struct inv_icm42600_timestamp {
 void inv_icm42600_timestamp_init(struct inv_icm42600_timestamp *ts,
 				 uint32_t period);
 
-int inv_icm42600_timestamp_setup(struct inv_icm42600_state *st);
-
 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timestamp *ts,
 				      uint32_t period, bool fifo);
 
-- 
2.53.0

