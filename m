Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601036;
	b=Z0JK+dHiz7XjMZcPwv+0JelDKeTi1CxpjU5wFGfi5HOYpVyCsOHac1e4HAdIAaPi/HIQ
	 cb3c3s3h+ivnc5kJocYNFLxr91OhYwVANFOSAzFGX5pQJscx+fq+QJhc8z6JP2qtD2gC2
	 i2ld6Y8QwnClSGdttOnhKHiQKUaJN1id+/IudSLSr4f7JBTlpksuEV3HZ/mT+x5JZfJmY
	 RU5EQm1/fJPu0uWQMwsnDxUOA6ZEm2TXE61xFmQYblWIUPf8Cq/jMm8Dheg44RWUDH9we
	 ZZPUkoMvBC7bNdXENwzMU6yT+Ol0shX7FzC9ZI1j2MR14NTMLVNeyuqEVIEMFPqUj8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601036;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bG7Lv1aF9DL5QyrXho2P4rHtkOFEH0HKGIrzdBjIpp8=;
	b=J6lUzVaNemLaNN9jBUBYbMp1bOBEohA+0m1G2vFLBgoibfl9CPHQh8+K2+MGtxLWTXYC
	 71auHsphNWFBDYNnijVPp8XuA+vfn6RYsP8RgLcKI9FVbT/rYAUE241PfkmFBwjBN6Wur
	 8ndviDqK6N/y3l/Up2fs3jyG9jG/ADzWLdshxcNZo0JI2NL7P8/5y3xnrSffMlApHYCup
	 G7JdlYe3CSvSfa2YZfZq0e4BIAa+Xd96gdiJNaimRPhimXQtTV0lJCqa+qmxFmjEg/jqd
	 wuEg8WmC40CWUDHySoRd9lR9LoTLF7tlbWTzZxmmPRnHeDejVErHks5h8SF15IDuB+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EHZgQwLJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.61
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AD606A88B;
	Fri, 13 Nov 2026 20:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 580AD606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EHZgQwLJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vylUrNcwLxbPkQZjrbiy2mMjymeU780DFl8YycezE2sSf4uZ3oIQ7cVKFpKsPYnSnD1nwYWWJK7/rLAWip9MiLQigtrGVJZ9ZN3Rq5k6ZTcz10YcZ0hbmDvgbnORm4EpUlFOnMcWqRV6shhrnnLInDXYBEksGT9GLHrN7zTz69+B6qMJGkCE1MTV9r/kXI88wk1n3F9Zk5FLU6NZwoXPOPc9Kl9WIpkyg6fBSNBEPJXywYnOuM5qxT73FL3wKjnqddzrTEN0TdDN3dWDcTdrVmSZIjRM+j5gORUAZJ68dJ+Tbc26lVmh4qdUAWv0fr4NSu3vDRqL1qvAcAbC2acPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG7Lv1aF9DL5QyrXho2P4rHtkOFEH0HKGIrzdBjIpp8=;
 b=VBTvJDzpDtdp2QyJNzltfhZW3JUw2KQLyM1XtU2//iKxtAfYCYl8ZN5hafMJFYzH99+bRJgzjc8cZhF7CQx5ZnTQ54fMOIZXGfBpGvJmU2N7X2gDLVVS6ANHP9KgpuWUtbQ3cVQ7LL3yNs4K5wXqXFvLGha8uYjwwTKMzqMZDUrZgxWRpxzhMfmEo1PJl8UkpoMDKUWimFsFHjU62bnodBJyudKp/uCq8YpKzCOtN4ct+I+CXLDL/b5sbcEe63D7KSnrGYov3GIFayAldCdIdS3iqyoUeFIsLnzvFo4nvwl10qTwG93EB2nzakiWlnSi8ZROc6uast6/AokV2fARwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG7Lv1aF9DL5QyrXho2P4rHtkOFEH0HKGIrzdBjIpp8=;
 b=EHZgQwLJXE9eqMOOgaISf6aLNh46Pw87uQKDy+HywFp9juZVBvfYJunmMcuY06leHxFBOGzmnvldK35nwzOeKvvt0LGXtGPpUP5/Xmbw4danAtulwPbCci3ZOsBV5vQdGhpMLYl4WjOauFE+1FaLRR8BMHOvoGRG+OD4+0LKiQesDtA5fsy7n9XChpRzGsB3VLWuIz3NpA+yX+SggMRtbRPk/8fIrdu2Ym5kDHY8Tu9gFvBrErfe+MHS+6Cssr1Zrx7RF+JTiMfripGyiDMkGEpyStgSVEP+u0u2eDiayZO5gcFmGp+m4z9M0iFdvconnE7JJ21LatYRkEVJ2I74GA==
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 FT1PR12MB035643.namprd12.prod.outlook.com (2603:10b6:170:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:15:13 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::8f) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 20:15:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 20:15:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 10:45:01 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:45:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 13 Nov 2026 10:45:00 -0800
From: David Thompson <davthompson@nvidia.com>
To: <linusw@kernel.org>, <brgl@kernel.org>, <davem@davemloft.net>,
	<asmaa@nvidia.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1] gpio: mlxbf2: Disable interrupts around the chip lock in direction ops
Date: Fri, 13 Nov 2026 13:44:44 -0500
Message-ID: <20261113184444.3431-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|FT1PR12MB035643:EE_
X-MS-Office365-Filtering-Correlation-Id: fe320021-40c4-45d8-2576-08df41c2d37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|3023799007|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	TUfK5yGoymHzAqiHqA+ykLgCRsoSUMzhS0DTaBSIQbvmanMu6RPR2n+OZ+DzPzbev1sk4+kk5FHxGHhKKuMATekJRgsVn2+ijvup2b+sJjTwGKX4H0kqvazUO22yYKRgBdOXxdbtHXjUeJ7YDHz4sgBC/UXWC5gRjFrZU9cYNuiiV/otgNe365L52q1cn516zLxINsmGc+g+jisXD0g/UtZbCoxnI7CU5ErJ/niv4+GylWe3mBCjxoyCfZfRbxMCRqt+jl6aDpIWzTgNgIXznmUNVv8khYefoXcLXSkPRxlgm8hhnq+vTRiY44EavnS0d/AvRboBeyesS+OsiiI01lHp2z1i54HsYuLYyTr/UIXbQWFqs/mBPArbGlH2cQP8kAQJ6b9etiO/7EEOhAKSWnDum22jTZ3tQKS4QWbqPrtS854nEs85lxlGzNxC7hbSEza0qlmTMOHzjlJ5056HtSv1xNV5sTCHg0qeA6PlNVUpnH0+EQj+zlzUD1sqxH8IsFBkYeEMmLtHc+S9yxSNykqx05a8r+hgZUYhCgsa1bXxVXFFJORvkThnddjOeTISNqmLb8buvLkhn1JuP/Auc9bbQ+CEVu9xkq8G6s3txQaEivO496f7RDE0Nvk+tXERTmkY2rJVWebSxMEgYhzRcW4MB/0azzaaUS01uWiSpkmwTfHqy1WEmNyU9PUIIuAcmKQin2Gkt02yR/mEnYnYgg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(3023799007)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VxxNFjCsUMFu6HUNEaBvbeOMOylku5maCbn0GYmDlvXZ5/7wWsVZggQ1vlGPNPiqglagvwb9O0FH7fyYJMFKRRAD2x4MXL5SiwpVteg+hkjmsrB7fjghUotdnCBEmacLSCNJfncvn6xlVYc3wd98UoSC4tmKNAcHgHpDeNao1FZHE0+LW6MekkwCWIV1j0KWI2u7D3XRCt/xjsDOYsfE30nqjiLYMaF7uu1DEPNGdnjTIFTNiNr9IhIkIBUGxMvgUFZCySCHYqdQPB7pbyKFKnD35hRQQSY6PKOzcyEOmrQ4TOlfGgCkUsnkB/dOA3xRAKfTOtH/dd0yOKR1xEtaxG4+dugCLhlopu0xcExWcFl5vWP3YjGmkGeUY3BJwkp2knZZ96qXdU/a9nQyUIXQxGpyjTxeufG3DpXS2td5tbz+3sf0C4G/0eSKH9cca6NW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:15:13.5662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe320021-40c4-45d8-2576-08df41c2d37d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB035643

mlxbf2_gpio_lock_acquire() takes the generic GPIO chip lock with
gpio_generic_chip_lock(), a plain raw_spin_lock() that leaves
interrupts enabled. The same lock is also taken with the irqsave
variant by the IRQ callbacks (irq_set_type, irq_enable, irq_disable),
which run with the IRQ descriptor lock held.

This creates a possible deadlock that lockdep reports as an IRQ lock
inversion:

  CPU0                              CPU1
  ----                              ----
  lock(&chip->lock)                 lock(irq_desc->lock)
  <GPIO interrupt>                  lock(&chip->lock)
    lock(irq_desc->lock)

If a GPIO interrupt arrives on CPU0 while it holds the chip lock during
a direction change, the interrupt handler spins on the descriptor lock
that CPU1 holds, while CPU1 spins on the chip lock held by CPU0.

This was seen during probe of pwr-mlxbf. acpi_dev_gpio_irq_get() sets
the pin to input through mlxbf2_gpio_direction_input(), and then
irq_set_irq_type() runs with the descriptor lock held.

Use the irqsave variant for the chip lock in mlxbf2_gpio_lock_acquire()
and its release counterpart, and pass the saved flags from
mlxbf2_gpio_direction_input() and mlxbf2_gpio_direction_output(). This
matches the IRQ callbacks, so interrupts stay disabled for the whole
ModeX update.

Fixes: 2b725265cb08 ("gpio: mlxbf2: Introduce IRQ support")
Cc: stable@vger.kernel.org
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/gpio/gpio-mlxbf2.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 70c19258a51d..c9e08a7c5eba 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -128,12 +128,20 @@ static int mlxbf2_gpio_get_lock_res(struct platform_device *pdev)
  * Acquire the YU arm_gpio_lock to be able to change the direction
  * mode. If the lock_active bit is already set, return an error.
  */
-static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
+static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs,
+				    unsigned long *flags)
 {
 	u32 arm_gpio_lock_val;
 
 	mutex_lock(yu_arm_gpio_lock_param.lock);
-	gpio_generic_chip_lock(&gs->chip);
+	/*
+	 * Disable interrupts before taking the chip lock. The GPIO irq
+	 * callbacks take this lock while holding the irq descriptor lock,
+	 * and the irq handler takes the descriptor lock in hardirq context.
+	 * A plain spin_lock() here lets lockdep report an inversion, and
+	 * can deadlock if a GPIO interrupt arrives on this CPU.
+	 */
+	gpio_generic_chip_lock_irqsave(&gs->chip, *flags);
 
 	arm_gpio_lock_val = readl(yu_arm_gpio_lock_param.io);
 
@@ -141,7 +149,7 @@ static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
 	 * When lock active bit[31] is set, ModeX is write enabled
 	 */
 	if (YU_LOCK_ACTIVE_BIT(arm_gpio_lock_val)) {
-		gpio_generic_chip_unlock(&gs->chip);
+		gpio_generic_chip_unlock_irqrestore(&gs->chip, *flags);
 		mutex_unlock(yu_arm_gpio_lock_param.lock);
 		return -EINVAL;
 	}
@@ -154,12 +162,13 @@ static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
 /*
  * Release the YU arm_gpio_lock after changing the direction mode.
  */
-static void mlxbf2_gpio_lock_release(struct mlxbf2_gpio_context *gs)
+static void mlxbf2_gpio_lock_release(struct mlxbf2_gpio_context *gs,
+				     unsigned long flags)
 	__releases(&gs->chip.lock)
 	__releases(yu_arm_gpio_lock_param.lock)
 {
 	writel(YU_ARM_GPIO_LOCK_RELEASE, yu_arm_gpio_lock_param.io);
-	gpio_generic_chip_unlock(&gs->chip);
+	gpio_generic_chip_unlock_irqrestore(&gs->chip, flags);
 	mutex_unlock(yu_arm_gpio_lock_param.lock);
 }
 
@@ -185,20 +194,21 @@ static int mlxbf2_gpio_direction_input(struct gpio_chip *chip,
 				       unsigned int offset)
 {
 	struct mlxbf2_gpio_context *gs = gpiochip_get_data(chip);
+	unsigned long flags;
 	int ret;
 
 	/*
 	 * Although the arm_gpio_lock was set in the probe function, check again
 	 * if it is still enabled to be able to write to the ModeX registers.
 	 */
-	ret = mlxbf2_gpio_lock_acquire(gs);
+	ret = mlxbf2_gpio_lock_acquire(gs, &flags);
 	if (ret < 0)
 		return ret;
 
 	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_CLEAR);
 	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
 
-	mlxbf2_gpio_lock_release(gs);
+	mlxbf2_gpio_lock_release(gs, flags);
 
 	return ret;
 }
@@ -212,6 +222,7 @@ static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
 					int value)
 {
 	struct mlxbf2_gpio_context *gs = gpiochip_get_data(chip);
+	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -219,14 +230,14 @@ static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
 	 * check again it is still enabled to be able to write to the
 	 * ModeX registers.
 	 */
-	ret = mlxbf2_gpio_lock_acquire(gs);
+	ret = mlxbf2_gpio_lock_acquire(gs, &flags);
 	if (ret < 0)
 		return ret;
 
 	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
 	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_SET);
 
-	mlxbf2_gpio_lock_release(gs);
+	mlxbf2_gpio_lock_release(gs, flags);
 
 	return ret;
 }
-- 
2.43.2

