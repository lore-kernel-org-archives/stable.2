Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25049BD96;
	Mon, 28 Sep 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596868; cv=fail; b=VGM/ZEpUrP7vktBRAyb5zMW4Uc5PwKZ7E/c07EO+HFIFlJXG7p29vWRzgcXmEaHrKfWCGQ6gzcryMsqDnUvNzSZz/pnqgsr+HvIWdwXf0LhR6CQFkdHKLTwUURIDB3oxt3Qv75rZXzHusUXC/4/dt5YPsMZKlq6UIt12/wDayFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596868; c=relaxed/simple;
	bh=CA0xZlVpWpLlI/QQI/RJEb+wEkjteqcrLZ2WEu2OwyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzBlRZG3ALVysceu0ZelTLNlMJ/vudkuYlq9I1yqoU75eC5e0Y5+rhcK+LwW1pVG/HfyYaacF69/VqohHVxpzEg/pMg6mgG68/XwYX20K7e0P89OQ767vSV/HjW+YL60FBh9lX47Cf7U4DAz+XVdxaY1aH+++dq0QzUMhK8bSw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BGovHxur; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BGovHxur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwP+zS4A6BRKdKMgYIiPzgOuQTH5DM1IjKMNUBhCXYNn4m0QmtKsUxOeuDgGx8AlJpSWpy5wNrW1KrMXyg8Jp3gm7521J/R7eX07RWzcJm7qHRswiEZYgCl0aCfB034t974zddgVL7L+9NpnYmgTDqli3yxp02fHJATe38C9U30RTtLugpnKdk3uDPoZdP0G9mmYFQxPm/trUg542xfYttnTaXru/UfRKCF7fR5+pFBI01SNv1cYRLhKOy6UA1YYN7PZAAHdLRGz/0tXjwN/VGAp+et4H23jfTECGMSwYqFY6m5DewNj2luV58Afif1h5UEbJ3w2JzUBT6kyJWRFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pChefNnHWemAHbDPfzopCXHZYlJm3baBykqr949Vgp4=;
 b=JFfWz5i+zSJY3XSP9oGJ9K5D+rRnHXPMARc8t4HHPemQsuj6Lrld7zNAMkwdh3JqTuzDTPu+wJqamApwK3lbKms0vjtQMiTZooCL0nHkPVFSpX6ZDJ6Xjra/QgSJ3R6p7rqZV9qtK3WpIO90i/UUtJbJlI4PBEh8OOg3vqBc6F6b/fZaY8fR/ChaKB+HK/nPziySr5FE0RxGvVnqA1VAMLlIBGxxvRprxFt/ns03YmNTivBcNJ9OSUwqMZRcM07OJnbPqS6icyvfQxoa6efGMXfGUY5gh7MBv7QjbTtxlTpfVxGnd5eOzyWyezSR8DbsOcq1BiHdA1V0wN/xmfCMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pChefNnHWemAHbDPfzopCXHZYlJm3baBykqr949Vgp4=;
 b=BGovHxurHeTle4SHTKPczvwYd3EFFARrfW0YQgvhLOtRuqUTPzd3zRoU9eBZvr09qO7JswGieP//JxEKzLngCm21uAxTqUlO2Cqe5czHDChkqHkQG9ps9LyN5DgYM1LNOUkO62ccvR72t6Ojv3wvlVcO59Gy7vk5xRgobmXHwVs=
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:01:02 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::71) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 12:01:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 12:01:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 07:01:00 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 07:00:58 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths
Date: Mon, 28 Sep 2026 17:30:14 +0530
Message-ID: <20260928120015.3152461-3-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d71fff0-278c-4604-2ae8-08df1d582aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|11063799006|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uhLQS9kmMEqly+Q9jQKx4HjCE82deAkNtmngTLHtfdSbFRMyTlW1vGcdoq568SNqKE19YsrKJRpmwKVX9bxJk5DApn5xwwQnLXVf/bBVz7Eyw1u3IILXgFF9X2PG6YQEwNLp0TuLHM7Dm+I6FJdzZTXT7UQ9Fmh32lyI6sk+tGh+23z0jrIsvVE6fqORg46nRl8QlQ/E50qstsMLXIQmO7ehw3QNESZHsFE1bL3mMO8QDRFCi9wCS06t1KrVtioHtaBrEjn8csNKchKeBiSVtDsbwPZUhd1QdtoFEMgh8pHV+vjZug0f8HFxlPaNTRDJYXrTaFRqeNF1ccv9lCt1RJlcQ3KokHfQulb381bALQ+nLfbolh5xyhYOnyKEW+xcLXEAxHEuacipMgSMM8B9viyb3W/hVzHO8MemSR9YNd30FFDHQurwzsTMcNiouLgiCFR9fmrBi1t8mEC2rfhSkdLSNK/p56QBeWXWv/mHzQ09laUrEOnxftB14bEtpgMG0GhDQ7eWN8W7szTQYdlPPgBty/3fNVQTu/QBPRPHQf19WD2ffoFv5OrrC/eWlcyLhWYksDeVIn4IZLQKdZtf2L3FjEs5eU0rHs1pqGZ0qphbpt/9Vl8EaZqdY1uCszqzC3SkrA3T4USLDCJqnFYYwYwzpGg99EG7TLXnFFQp3yr6NhGTEH+tlbQxjKtwZ5ZDlVdWzySyjrnavh+x4b9R8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4gH++EANkSB+Xb66jtr4hkGlU8mZpTfNwlHoAm7XZjVzrgAUhXXFD50Cyosbn+KwsWcjvvrhxekprDG+0bDi7xuKhHRJHp9iLHnwIHfRcAwcYEfUXvhVEBgGuSC+loZrvDbJRF6IyrfridOJLpmToCdFaA5HZ81BnIuliFhPMZ0T/OhRy4xeQjWPj1S+04EwFGl3+JgbFIgT0ZnklVZ/NnZeiyAIy+5trVIXh/PjbpwO+w4vsnBHH4RecN0f2mpeuv9+TTmWXvbB7MvODsYAndsevkzlNBdVUf26v/bi4H0CqhG4dp+Z2Q67uWMT1qfceSXlvXsCtVeNAUQ7M63/rYP4egwFswUeLLCKNskNuAVxfUsLymaaTE65FncSRyhTk4EtEGrHAQUi3k2zS6P8mlRfqDSWGwEktqWE4Su/lR/iF6gK2Tu3ts43fmbLfkFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:01:02.0786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d71fff0-278c-4604-2ae8-08df1d582aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

If reset deassert or PHY setup fails partway through
dwc3_xlnx_init_zynqmp(), re-assert the resets that were already
released before unwinding the PHY.

Only undo the reset cycle the function actually performed. The cycle is
skipped when no usb3-phy is present, because asserting the core resets
can break a USB3 configuration that is live but missing from the device
tree, so the error path skips it for the same reason. Asserting an
already asserted reset is harmless, so one block covers however far the
deasserts progressed.

Save the ZynqMP reset handles in driver private data so later probe
teardown can re-assert released resets.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v3:
- Dropped the usb_resets_released field.  Nothing in this patch read it;
  it only existed for the conditional teardown in patch 3, which no
  longer needs it.
- Collapsed the three cascading assert labels into one err_reset_assert
  block guarded on priv_data->usb3_phy.  v2 asserted unconditionally,
  which would have put a no-PHY board into reset that init never
  asserted; the guard now matches the init-time cycle.

Changes in v2:
- Split out of the combined five patch series; see patch 1.
- Reordered ahead of the platform-data cleanups.
- Added Cc: stable.
- No functional change to the patch itself.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 55 ++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 8c63e02575f1..d2315573b3d3 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -48,6 +48,9 @@ struct dwc3_xlnx {
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
+	struct reset_control		*usb_crst;
+	struct reset_control		*usb_hibrst;
+	struct reset_control		*usb_apbrst;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -112,7 +115,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
-	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
 	int			ret = 0;
 
@@ -124,25 +126,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
-	if (IS_ERR(crst)) {
-		ret = PTR_ERR(crst);
+	priv_data->usb_crst = devm_reset_control_get_exclusive(dev, "usb_crst");
+	if (IS_ERR(priv_data->usb_crst)) {
+		ret = PTR_ERR(priv_data->usb_crst);
 		dev_err_probe(dev, ret,
 			      "failed to get core reset signal\n");
 		goto err;
 	}
 
-	hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
-	if (IS_ERR(hibrst)) {
-		ret = PTR_ERR(hibrst);
+	priv_data->usb_hibrst = devm_reset_control_get_exclusive(dev, "usb_hibrst");
+	if (IS_ERR(priv_data->usb_hibrst)) {
+		ret = PTR_ERR(priv_data->usb_hibrst);
 		dev_err_probe(dev, ret,
 			      "failed to get hibernation reset signal\n");
 		goto err;
 	}
 
-	apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
-	if (IS_ERR(apbrst)) {
-		ret = PTR_ERR(apbrst);
+	priv_data->usb_apbrst = devm_reset_control_get_exclusive(dev, "usb_apbrst");
+	if (IS_ERR(priv_data->usb_apbrst)) {
+		ret = PTR_ERR(priv_data->usb_apbrst);
 		dev_err_probe(dev, ret,
 			      "failed to get APB reset signal\n");
 		goto err;
@@ -156,19 +158,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * absent.
 	 */
 	if (priv_data->usb3_phy) {
-		ret = reset_control_assert(crst);
+		ret = reset_control_assert(priv_data->usb_crst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert core reset\n");
 			goto err;
 		}
 
-		ret = reset_control_assert(hibrst);
+		ret = reset_control_assert(priv_data->usb_hibrst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert hibernation reset\n");
 			goto err;
 		}
 
-		ret = reset_control_assert(apbrst);
+		ret = reset_control_assert(priv_data->usb_apbrst);
 		if (ret < 0) {
 			dev_err(dev, "Failed to assert APB reset\n");
 			goto err;
@@ -179,7 +181,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err;
 
-	ret = reset_control_deassert(apbrst);
+	ret = reset_control_deassert(priv_data->usb_apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
 		goto err_phy_exit;
@@ -195,21 +197,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 	}
 
-	ret = reset_control_deassert(crst);
+	ret = reset_control_deassert(priv_data->usb_crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
-	ret = reset_control_deassert(hibrst);
+	ret = reset_control_deassert(priv_data->usb_hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0)
-		goto err_phy_exit;
+		goto err_reset_assert;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
@@ -230,6 +232,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
+err_reset_assert:
+	/*
+	 * Undo only the reset cycle performed above.  That cycle is skipped
+	 * when there is no usb3-phy.  The deasserts stay unconditional so a
+	 * core the bootloader left in reset still comes up, but they are
+	 * deliberately not paired with an assert here: resetting a USB3
+	 * configuration that is live but missing from the device tree could
+	 * break it.  Asserting an already asserted reset is harmless, so one
+	 * block covers however far the cycle's deasserts got.
+	 */
+	if (priv_data->usb3_phy) {
+		reset_control_assert(priv_data->usb_hibrst);
+		reset_control_assert(priv_data->usb_crst);
+		reset_control_assert(priv_data->usb_apbrst);
+	}
 err_phy_exit:
 	phy_exit(priv_data->usb3_phy);
 err:
-- 
2.44.4

