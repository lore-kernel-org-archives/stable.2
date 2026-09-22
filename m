Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5748F03D;
	Tue, 22 Sep 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101326; cv=fail; b=eTsIVvCiILQOtkP4y8VsKE4G0g9ARjzNtBiI50lBFnnAZhyUGZLReDJAmAxNbUfEnhUErEQB9p9NnmWgWmbRPUb66e0ALZJ+5htGdhRB5bIXE3AelIgK1Vc9QkC1/OYeCHEwmZvgnOXuBnYM9hcvDusIF1CH0UkdIFGDHmCmv8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101326; c=relaxed/simple;
	bh=oOAkgwof80FUFNhj0qASUWzuxO7TfGW8oCW4X1rf4r8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klg+U9CIa8LGBxBl4vOWNWtRzvECG6bW3QkwvH1+lKM3nF1EWPzgs+tCZ5SLywMaVDGHqPovXtACCSFa0qlGGbpkZDVZqZDSKWSqjckKfJYmPidjfFi1TZzolM3WXAyDUQphaZ+Nfgk724c1ayJ5GQDzr7R1jeymGgbDh2+mcUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNMp4uwa; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNMp4uwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIsIc0MAgPzT62GkJjNwRntx21MK5kRdQXntxeMW1Df//tsB4obdJ3gfmaaQyKYxUB/DmfmHnn/GUAbLC5XQ9jw14pHBJrLUuePbvuUgThK2h/IBZSyCOtB/WOUXqip/jENWGERB0rDWZWhC80TJBji5oAoxNsSTDi4wAg6BifVEkXUWNhhuK7OgHK2b5Uj10NJ1pWu4T9fKiV/oFTH2rV3eJICFJ7z4H+JiC+at9kPyytZpOB7m3aEP6OudD6Khc/antma6tOzinW1Gmu/lRqlBFZEeOatIsJSgXBupUMa9OxqqVbljZ+Sd+0VzgA7BejjPUlQS5/hUUQnHq99XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbTpVqSdLfiImzM60AVTajEWpu2PRiqcYfs1wecYkGI=;
 b=xn6+E5jpVhSemTOYProYe0BfoO73/23Ubgb8raUnpwJMFIweBrV6loOpxP2cIpMecG1MzlfvFH7UsDaJwFHGtmIVqbUPGrV493ZxPKRZ6mtzWvfF98FSSzA4bL0x9Xc3ps1PRNN6aljXDrwVDZccAYtlcsLUk739zOx/nk3qAZTZoNp0tYJ6U6pz6Mxf5VN1cvpal7lfUwC2zETwfkGRfQT6IdobxgWmo4qpMU2zak9p4l9yjryJdIZLIKlZpymR93PV2pPAAGiituDc7z25i4OywPg2Hen1mzPOsSbd1Z9IAn6KBVlY87GZNB9ZQh/mAdZaqh7ajXfFBkuvz1UhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbTpVqSdLfiImzM60AVTajEWpu2PRiqcYfs1wecYkGI=;
 b=hNMp4uwazHxkg/l7c167zqcFFDMBlvCNjxz1q71LPie1egZav+0IRDIzlgvHY0faZdx/IzPDY6Gn9QYsZ57Dai4GHuPlsAgfrOOF1SXxdL7SOlWfrBZ+anlIf1GkNYVJFVRGkBFw4t7swfPCai0K2jevxdG69b4/k8WpbkzHJdE=
Received: from IA1P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::11)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 18:22:00 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::78) by IA1P220CA0006.outlook.office365.com
 (2603:10b6:208:461::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 18:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 18:21:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:21:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 13:21:51 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 13:21:48 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths
Date: Tue, 22 Sep 2026 23:51:24 +0530
Message-ID: <20260922182125.11067-3-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1491e538-207a-4ca6-922f-08df18d66453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6wCKFotcGKQCQkuOWGb4aNA2WKBiDaoINgmntx43rKJ+4VVfjnfOAiiwBP0CAvsnINtNT1gsJOqk6E5d/oGIo2HFTEPFMF7Kg23+u9GXKqOmeV7uzfLvnnIFAF1lgDnPoHxJDjQpVfgQ75hNSKhItNAtC5cQBLsPuWYMiFWmsSxHo5DmoP/zH8Qkgnh87ktbe5IbbSYHvvPWMQPvliu6pnsL6kinUC9Lg5e3yhhdGa6daihu3Yb/vUQDTtyc7gT6uZprTtna8Vl0GDuQZwQqkjZKoJ3WZ6ys4aMH66jFhLrI7HJgg1GI1E8kuGJgzZd0gl80IAxul1+9RVoflu6JUMhkE7OM+WK896p0f4uo861TKO9p+t153pzpCf46UB+8/lTSFF+jUscHzz7vPZqz2pmiWeuwKVqMNezAszuzuD4AaE7KYHj7YD6IOxq/dK9cBTUxOS56W1i7hV1CZry8swRtfNhV483U7W7AhK5yaZFcsNqsb03aneaaNAekPWstSmpt/zbgB8rLad4G2XlgW0apMOcyIXRu1K5sBqvq/2n8YexOvwZPE2hIV5of2Or0K1a7h41mkI7AENsOTcVmcFu1RlHyWabfSgJy92yIfsCc1DlCUGI52U+is7BxC02knHF6I52Bhu0oCD2shBEoHmStL1OMqHqEjfzFQV8EASwBS49iVdcn42xF9TFgTCjdKfi7YKjBuVUwLmyZeJhLeg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5aC24urWkeSgsxOZ1EM17cAwu+SoFrx5IJGya4CmugwD5YNPeEefGSYSQty34XbwcMJs50i91AwwsBbsrO3e3Anjlq2bORs/2t+Xldusshj1I8F6VlcYgFkuTDrPVvdhzJwH4Sx9XO0nzd+83RIoeI/Fs2nGbyKP+30WTRW6B7QjjP50Jsop189IOqgOx2MubcyFo8uUY3a1sJ1EDT/TiWH68Ej5ImSvj4QMUORAmOpw/ZhlWFsWhKjBRdh5N9qxJPEnnTjXhH8b3YBho6eVioPKwDzdD3A1c88mucOaHl/OBsoNxLW5NEDe/mG1ifYRigCwSx7Dm/Qzfm6tpvRiWAoqK/Bu0FmPtZ+UT2c+aIdJ85CLup6D8fwzkxtLf7u9QlPENZ1GM7afrJEQc3noAjXBaSe3o+pIE0zI2cmoqNRl9HLUCoNNtbb0h5IxnsiB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:21:59.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491e538-207a-4ca6-922f-08df18d66453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

If reset deassert or PHY setup fails partway through
dwc3_xlnx_init_zynqmp(), re-assert any resets that were already
released before unwinding the PHY. Use fall-through error labels so
unwind matches how far init progressed, for both USB2 and USB3 paths.

Save the ZynqMP reset handles in driver private data so later probe
teardown can re-assert released resets.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v2:
- Split out of the combined five patch series; see patch 1.
- Reordered ahead of the platform-data cleanups.
- Added Cc: stable.
- No functional change to the patch itself.

 drivers/usb/dwc3/dwc3-xilinx.c | 49 +++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 8c63e02575f1..d18d3e364381 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -48,6 +48,10 @@ struct dwc3_xlnx {
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
 	struct phy			*usb3_phy;
+	struct reset_control		*usb_crst;
+	struct reset_control		*usb_hibrst;
+	struct reset_control		*usb_apbrst;
+	bool				usb_resets_released;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -112,7 +116,6 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
-	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
 	int			ret = 0;
 
@@ -124,25 +127,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -156,19 +159,19 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -179,7 +182,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	if (ret < 0)
 		goto err;
 
-	ret = reset_control_deassert(apbrst);
+	ret = reset_control_deassert(priv_data->usb_apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
 		goto err_phy_exit;
@@ -195,21 +198,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 	}
 
-	ret = reset_control_deassert(crst);
+	ret = reset_control_deassert(priv_data->usb_crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err_phy_exit;
+		goto err_apbrst_assert;
 	}
 
-	ret = reset_control_deassert(hibrst);
+	ret = reset_control_deassert(priv_data->usb_hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err_phy_exit;
+		goto err_crst_assert;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0)
-		goto err_phy_exit;
+		goto err_hibrst_assert;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
@@ -226,10 +229,18 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 
+	priv_data->usb_resets_released = true;
+
 	return 0;
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
+err_hibrst_assert:
+	reset_control_assert(priv_data->usb_hibrst);
+err_crst_assert:
+	reset_control_assert(priv_data->usb_crst);
+err_apbrst_assert:
+	reset_control_assert(priv_data->usb_apbrst);
 err_phy_exit:
 	phy_exit(priv_data->usb3_phy);
 err:
-- 
2.43.0

