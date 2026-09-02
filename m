Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A74A49B0;
	Wed,  2 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360872; cv=fail; b=RMj0JHt8tTM9QyfNpTtY8y3dwwmCk2+nwETDZihukkbVej43MTt2he8T64EXoTzvtUn7KyUc7mocAcTMIkXLfxXLdZmsMdBaD4CzZw2xo4NMXrfR1FHmJjHs870X21gmNq5SQkX+87we/fI0370B8ZfCRqDthdP9iwyhHks3Tyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360872; c=relaxed/simple;
	bh=GFBiO9A3R1DdSQtw3Zj61Y8Z4ujEmPa5EryOVQrbfV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ghUlQ+v8o9K+gTgXFyL4bpsZcPEhdZhhsuooEglTqZA7BAjJg3HmfFOePPXVLUBE8tPUxkAk1DtCQXgmx/Bf84eOKXi7W2NDsf8+tUqll4FRH36Uq9owiUsqAZjYzh1k3J5siKz5rJCcJhQfoiXmwHV/kx93YtawBmK9GzHWH/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gv+l0vHC; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gv+l0vHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvTmb/HDoGzEdP9mLeQaVO9ASSchu7zqQpNC+yAzVwj+YqBf2Zm9npcggsN1XelFynszHWjTmrX89wYEs7x7CjRTsJXZPR5pEHoz+dXDGSXHqtsypMoWPSdz7aLeVmagoW1h5xk4ZN+a1IH/DJOZauLY8iyzm1DR7NfZKqvZILjOryZ1zjxz8wg+AvuQhqG8L1tAcqJ530N4w2nXUCZCvAEIaYKFwcy7MHRgtHD2mvC2AhKlz1jyHnhm+SkAHAtj1mcgSrF4UsyckNVGaIC2JncYlMLQFzQfiQ04rT5TFhlWns/I/GXjvssBPRaIHRyPAp0cYWt9KeVN+9NK6rgvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/ZS7X3ggK43tAW7W+G/Y30MCYOfltg3DxH2mnj1k9g=;
 b=lSjBvwoYO5/TsNC7d4v7WxE5pinJyObkuP6rfwoTwZFTIzjQtcAWVKvgJEw/fH8sNhCf6/Z/emIh1+6nbxBe+1HvERtgrGE3i3Mg8/tTGCIFssSl3S3h5kWqVuuARYGAsV6aDy/IcdW97nuUnbCkJxa/PH0GyFZZWRljVVpNbVgTGEDiQdAwDdNlwi6osLAV+j61JV+K2eCD2Rmlpk/sUNAHY346i+tzAB64HiB5j+Dovk1bnDS8lpvUOZiosDdoqpfrRqhMYVnMOVRNFDh0SdWd7EdBjDRHtxDZimKJ2MtQ+oaGSKMEtGlv/u1QnAeLZTz4RL1T6LUYKHPSWvM3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/ZS7X3ggK43tAW7W+G/Y30MCYOfltg3DxH2mnj1k9g=;
 b=Gv+l0vHC4+k9vhEB5AL7KkBF6x3Kqu8Gcncz9syuNa7hrEZ4d3rWPHCwKbfnXgZlj+6SjyYD6pKw9+hxS1+VY9KXMGwZyRecRmiwD5ASjkavcYYpPVc1Bzyaf8dUcy+KUFEFFKRvlK7MgtviStaX0uFKCYYwGySyCmBiBIO2MGM=
Received: from BY1P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::6)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:54:22 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::1b) by BY1P220CA0048.outlook.office365.com
 (2603:10b6:a03:59e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 14:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 14:54:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 09:54:20 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 09:54:18 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Wed, 2 Sep 2026 20:24:04 +0530
Subject: [PATCH] usb: dwc3: am62: Fix runtime PM usage count leak on probe
 error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-dwc3-am62-rpm-fix-v1-1-7a2807e33307@amd.com>
X-B4-Tracking: v=1; b=H4sIAIw4mGoC/x2MQQqAIBAAvyJ7bsG0hPpKdBBbaw+aKFQQ/j3pO
 AMzLxTKTAVm8UKmiwufsUHfCXCHjTshb41BSWXkJBVut9Nog1GYU0DPD4794JyXZjJWQ+tSpqb
 /57LW+gEV5rBjYwAAAA==
X-Change-ID: 20260902-dwc3-am62-rpm-fix-514ccf0696a3
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Aswath Govindraju <a-govindraju@ti.com>, "Roger
 Quadros" <rogerq@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691;
 i=radhey.shyam.pandey@amd.com; h=from:subject:message-id;
 bh=GFBiO9A3R1DdSQtw3Zj61Y8Z4ujEmPa5EryOVQrbfV0=;
 b=owEB7QES/pANAwAKAcJReB2ribKGAcsmYgBqmDiZMnrWYhEl1cMliYsXHVJaOHLx5brJom8Pk
 vmAylixfKqJAbMEAAEKAB0WIQSu/zhVY311S11OBhzCUXgdq4myhgUCapg4mQAKCRDCUXgdq4my
 hiwoC/9W2VCqm6cx3gjGbIb1CI0Es1KU6VCDqdkHP8XOlOGV4TTVBmQoOfb4uQ1GJhNEXrpBMY5
 Mt1L/symSRcIWjZRDPy5mNOoEmtM5amCtl17N7L7ED27wNjd+ml+KX77jsW6tG9JzKnw+yUGKAr
 QyefOKTVj546mleR3Oq5jO93DqxHoQC/OLeIiSvO8uAOAIT0kBL+Ld2J0ScttEq1fehbD8axQtq
 tmbQ0Xr2TUd7rQvhZjUpKtwBJxPCWOqlH/gZR2YE23a7HAxpxtnZYGej7zDn87SvXnhG8+qcWEi
 tTQQi3Jl/eMBU1WUj36DDZQTKcPgmD/exw3oEpz9n6d8Q3uCMORU+vQqG1NZmG1nx+3OXze0J/Q
 XtRMAMEkI7XBMeQICfsdNH3XQGDvkpRFIg06fzfWSrH8jd3e75j8oIX3TIt5cpZMsZKcoiOLYjv
 iygYDWlw00tRFwNJCw2eA/9RGX8KFz+DGHNc1mMbe1zlIyWL95etG9/iNbto1fLJebVYU=
X-Developer-Key: i=radhey.shyam.pandey@amd.com; a=openpgp;
 fpr=AEFF3855637D754B5D4E061CC251781DAB89B286
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 895e534e-46c2-4c21-12d6-08df09021290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dwYOaM3FsgJvBH+9ZpFh/sjpyuPGxG5DOq+LRGLfM5tfjiGYZArl7ekmc0DOatDK9a7F9EvwCEhPzZXDPkcPmnW9ZHhXIhGJKxOCu1nTBV+MpBKbEe4aBNL3T299Ag+/DE1X6x1vY2wnQ6tpKwJ5cFWKOgoPumyYmkHfR1zEeMC9/+EnvdAN/8n3PhczPbcVOifpXti7AUl3NDHlYXckVQno2Cj6w80uPlGJZxJIZ6c/aLjbbHIjd3auKZ2uRDvywyZ5wcepbSsY9kWzfUuRih63BHmdqVeK5Xyvd/4+rz2JSChmB02BFWCdWQILOUspIhRa1hJzb5aj+U244GnojOCnxtnK/VjockO6RRaNkKQYMVaLUPTrMq5fwYu91gie6w3grDk82JneTD0J2Ksypyod4ul2vUEp0bZDAIXmSHGWvRxANPXK7ghCwpo+y6MscgqdWT1tsiKtygZAnjB3iWMvjbm5dBRo36IQ/HmvL88tG+KmedCoeZ19ExJ77OLsLX0FlW4xV8sLp6Ol/SS3c6qJ54Dbug7Jye86Z/G8fpXt+IpK/hARHsI9jFI/veicLH+xfnXhcm6WzhIcAZ6yi8gdqVZU06HrcNvoBXNoP03UDd4YuRgBkwHsfcoX/m2Te7oGll0+rXSEf6KF5zCBjRBMn14192Lp0rv2Un+AsYdeQVDvrs/Cbb0HLTO/wgGBZxD8qs+6Hprg6RypTRyxwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fJVDDMq8rZrQNuec/RIFrx4mr66p5ZFWUMeE6E86wgG0wZUNCrF27uficvhal/c3ZIrp/tcrzeo/fZZlXj6JsueO5KHpRvvYcYWKFtDeXT4xwBT+p7uGVolzlmLaatjDhdKPqcV7BqGRNSUV1N1194cBFFYthiLJf1VHLeGVeegZ2dXTZRPGJgig/p6iaofsj4LxmObGafkovCYRdijnqNexNdcyTy9/jk61ajCb2awiFBniP9VPQiMg3XAsDc1qFJfJlk86gJJXVvu4igDbJM5XxERFEjkvX/GLWqbgHTU9wFW4M+BanVF1zBYuobCe30e0iLWvnl0PZQ3qlzdxp1SHPwXyllkuL36X5Ox+2W+Q6FEhAmeivh1W12DKyL0/WZkAi5Y4f/BAKILMtAD05bHw30q5PM9jJLqLX6NRuPAQkp7Nh96Fa9b/Hsnd18vt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:54:21.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e534e-46c2-4c21-12d6-08df09021290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

dwc3_ti_probe() takes a runtime PM reference with pm_runtime_get_noresume()
before creating the dwc3 core child device, and releases it with
pm_runtime_put_autosuspend() once probe has succeeded. The err_pm_disable
error path only disables runtime PM, so the reference taken a few lines
earlier is never dropped.

The usage counter lives in struct device and is not reset when the driver
is unbound, so the leaked reference outlives the failed probe. If the
device is probed again, through a manual rebind or a module reload, the
counter starts at one instead of zero and the pm_runtime_put_autosuspend()
on the success path can no longer bring it back down. The wrapper then
stays runtime resumed for good and autosuspend never kicks in.

Drop the reference before disabling runtime PM, matching the ordering
already used in dwc3_ti_remove().

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/dwc3/dwc3-am62.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 632634d6e81e..d03b3950ce04 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -299,6 +299,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	clk_disable_unprepare(am62->usb2_refclk);
+	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	return ret;

---
base-commit: 8b72f6626dc39b9e7e82b2721d4f7c3b86286012
change-id: 20260902-dwc3-am62-rpm-fix-514ccf0696a3

