Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986741;
	b=rlZPLnPqGBvIpCQ3qaWmo2CqMKGXw+jALEH0UGFvRul1tt1nCo+WAh0GWGIvTQHYTuKa
	 NYEYRC7Su1E6YLgT9zmuIzW8BkxcByTCkTFu4RY4kG5kpdM2IMTzRT9boVcOqJzr3iKcS
	 7PqFNlhVh2SLC6g4QZuXcYwTgF6D5yZiCjLb337XQ3OSdeFGCMaJEhcHAoMdLXJHT0vld
	 ems2+ySOnr8TyI2s/JHewPp/RK8RQBMgrVM4R19MadGAf1InYPBbO0b/nGfvjOzWQqxBu
	 ZgDtSbLoi4SSg3p0DJGUlcyH+FXAwi6IsOEnJ741N4oFoeEG5KMA3Az8rtcH7/s689g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pPPiV8rmukVOqDfxpLe8jMNdEId8bNe2sueJpvJUqOE=;
	b=cw/CWBYD5r9rwwBGRUD3AICYSn1fdG4pNpKWIHHGn0vhrbYPH5PP/FTy8fbV2BgQYKwl
	 2qI8r+Ja2rQO4l8JsXAmu5vgjHPKnmZ0AuXE+VrBAbsIGbLNnfHpAhDmgollNdp9DDysL
	 /+6xUeLrMPeV2leGVCFZDZdFwvuP6RgQav8KL8JkqpUskod+7ezHT5qrvwrmHF4Olw93U
	 /JbJdIRx4991bma4hNKOyVTEWtL66iaxXZeH96+RzB9TqyDYyRWo7CEtlBY9kTByjNwPM
	 iQiXsQY5BI/JSKav3VLN5fl006ZbHrjnu3jHq0C4J1mD9gXRx1KC70ic6WSAptYRqqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ih2H6KWt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55931606EE8F;
	Fri,  6 Nov 2026 17:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55931606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ih2H6KWt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrVr3Ap0WDzWCkvpUGNSmHtWpcrv8ERiGppvKJxuJ9jrkmX6X9PQkccUMbOV8KMQYKHYdGhzbawcV82oXYaD8qLH/GmfDQQmkKBkWsOBPE6etzkQxPttHktw9X+4ash8x1xPCOopW4e8HFQJ1VJgXn27mWK0AQrKDb/IabG3/og/IhccBPTa4G+ykdKxbjVd4gor/gjD/XI7WXV3NyfulJ6MC6rN77sqWTyZ2YY/XNys4fgUURUZR33WJHB9UFsegpLNasqcCPiC9sQ7XeiFZZZAplAjP0vGQsstqugQyJo6172FcrAQeLmpr0Eh4CqHhU70l4c1hMlWOQ/xdQNXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPPiV8rmukVOqDfxpLe8jMNdEId8bNe2sueJpvJUqOE=;
 b=G/ojCb+nk/DGSu9OLGAS6uA+1HAAcPuUmzi+n221aPBaVWmFXYGp46U5CRELMcc9YvpwF+sf8m4Bwm3w/4rc/X6Tgt/io+/efZs2xUP9gwHhVk5azkEhH1ZNF3+G9KTznUWIDShW6Hvnm76R0IAdOBDzNIlOtnxCaSKdE96ChpusKMesIggYt5qWMTAt+2iDvKJDWT2E77h7Yg7mRytsfsHV4SgjtCKiGTBVQfEpzPp5/h7JuDwhTY/Jqu65EiLozgiDHYHzq09UjMXbmv4D+Mp+n5yPRlLLaPq1gtvO8vnEmiogfFjIIjx6ZhWwulcwBTnr7iCNejzvMK0TOXqzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPPiV8rmukVOqDfxpLe8jMNdEId8bNe2sueJpvJUqOE=;
 b=ih2H6KWtdNNhPn4YCOw7YAJyQMgZQ/K7F5a4PW2bO593wPafPOELaPQOM/KnArXc8MuwCqQDeFu7PcEPbTPphXR62nYQlZsxDtu9O6qWBd8tdw8dnu8rEhrgFmjBR3K4OISsieu6cvuK3TCVrHZ7hO1NgwGzV76LzZ4WgtpPi0iGAxIh4K2aPDon54FrJRl4+5glXLnMm5OwrFXcmhhBvsDl3smho+K4evshyjCaosUzwbEt44jRXXMjxSsslrmuRwGC8qU25A+mhJU3TILCxRo+MaXwcH79/wJZZ766aLasTJkGIzP9iv0o87k+d5FKPEtfnCMlXIcPfUvMROV60g==
Received: from PA7P264CA0132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::13)
 by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 17:38:55 +0000
Received: from MI3PEPF00008551.eurprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::9a) by PA7P264CA0132.outlook.office365.com
 (2603:10a6:102:36e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008551.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:55 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:24 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:38 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:26 +0100
Subject: [PATCH v3 6/6] usb: dwc2: platform: fix stm32mp15 detection logic
 power management
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-6-68d2a0e9bab6@foss.st.com>
References: <20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com>
In-Reply-To: <20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008551:EE_|AS1PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: b5258042-181a-497c-d0f2-08df3c2cd4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|261009223027099003|261021123027099003|261022075727099003|56012099006|5023799004|11063799006|261028144727099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261102123227099003|18002099003|22082099003|6133799003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	fFO8zw0qO/FRaDNyzmT+L1OI/vQ3zYoQqbn4ULBpbkIdgSIj7RUsvR8mk8YXeyQA3yfbNPERks13nIoXH9FZQBxooWwVINcEEs6h12E6FZvUhPDAX9maVKLXxexgqsKit/d4NQEvRPah36wjlRliG5BzLAy2fv13rHocbtr9GphaHwMjwV/qDCgnhXh4mOflvkp5EfhWjyLcgD18Z0CpnVlL7uaCqVv3p+4iHKNZJr+UeSYjtPVyz3+g6v5UcuTJUmqW8vyJq8EJJZQtpo9eZ1B//2EYhm54ax9eDnSNqSkBdkg3O2nGZTz4Gs203oTyESb1ZVX9q3fb7bIPiwF4zpIRNCXfCFhvCPd1lIhPZVTq3ZRVoGTfqY8tZWTZ5qfCBxZ6YyslpdBhCdGn9y9nUfCfV3FlVN9nbfG109pbccw5X7APlguddX5e9nkiqkwSl+1aodaIFTjNqtD7QI347MnXTKN6OdJEguktmjePPBam9F5UyChuWe/VXXk+tJcggAv1k0xEZb7wro6JEDwj2Rl+MwuAHAgxoSWBtx3ryyGwELU8arPfFk6M2l8i6j2M5erf6c5jNP2BIEc5B59hbkRIi71QH2LyWw1/y5Y1mkDVBKpJ3WqS3jugumCYlnCbmKeqe2fQ8KGNuP0H2NDSuHZ1iUWB61JvwbIJNTj5XboyDoR2638m8+Gv+HCY70NtlDoU5kfke8etquNLxEU4Dw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261022075727099003)(56012099006)(5023799004)(11063799006)(261028144727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CQJa/TvcDiYBhcRJF7W5VZsCDmYws1yKcPStacgviFV4S1+gMefLM6/y0GTQuCx7mWzMq9yQRo9k2keE1VH5Xl7/VhgJ7BvFWjgO0UsYEQCiYrWkvNxti7BdaAKB51uDFnqKceYsTxaUWi9i18a01eHiATtCeMZgGQFxXuJFlG9Oo7V3BTJ0CEw+yI5OGKo3UV9/sZ688cWDZA1z2rURIjiEb1nE2kAT0NLcSyxRZI9LDq7t9XJ2QseK01lVtDYDtqMXxmaRXI9y2IJGbBW1wmHuJj6vbxplVCEPzj3lytxOGop6stiikAKf3P8LQUWcPuo97z+hB88vxHw6n6fNAAnruyTHGuFGJGgiXXlDq6JXmcInM8rtyItQfLz0xpPrZTxAtkB1kndzZPGCG4Ui81jP2ZifR8DRFI7XQypj38WbzkDjwlDTZM0Jp1irqPsO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:55.4709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5258042-181a-497c-d0f2-08df3c2cd4bd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5697

On stm32mp15, the stm detection logic can be left enabled even though the
other hw resources gets disabled from the probe (peripheral mode only):
	/* Gadget code manages lowlevel hw on its own */
	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
		dwc2_lowlevel_hw_disable(hsotg);

Then when going to system low power, stm detection logic resources now
remains enabled since dwc2_suspend() checks:
	if (!dwc2->ll_hw_enabled)
		return 0;

In case the stm32mp15 goes standby, the registers contents gets lost
and may not be restored so dwc2 becomes unusable. This is the case when
no gadget driver has been bound until that point.

So move the stm detection logic enable/disable procedures to dedicated
dwc2_stm32_hw_[enable/disable] routines. Call these routines
from the __dwc2_lowlevel_hw_[enable/disable] routines.

Factorize some of the probing code. Replace regulator_enable() and
GGPIO register poking by direct call to dwc2_stm32_hw_enable().
The dwc2_lowlevel_hw_enable() call done earlier during probing isn't
able to do it: the activate_stm_id_vb_detection is only known after
the dwc2_init_params() has run (and probe the usb33d-supply).

In __dwc2_lowlevel_hw_disable() in case the dwc2_stm32_hw_disable() fails,
return the error, without disabling other HW resources to avoid possible
inconsistent state (e.g. usb33d supply not disabled, so other resources
are kept in the same state).

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Notes:
- In case dwc2_stm32_hw_disable() fails in __dwc2_lowlevel_hw_disable()
  there's nothing to roll back, so return with directly. Alternatively
  the error could be ignored, to continue disablement of other resources.
  Same behavior pre-exists already with phy shutdown/exit/power_off calls
  in case of error. This could be addressed in another patch if needed.
- In host mode with remote wakeup enabled (and a descendant has been
  enabled to wakeup), e.g. phy_off_for_suspend = false the power domain
  isn't expected to be turned off on stm32, so registers shouldn't be lost.
---
Changes in v3:
- roll back in case regulator_disable() fails in dwc2_stm32_hw_disable(),
  as commented by Sashiko.
- Add note since Sashiko review on v2.

Changes in v2:
- fix probe error path in case devm_regulator_get or dwc2_stm32_hw_enable
  fails as raised by Sashiko. Clear activate_stm_id_vb_detection flag so
  the dwc2_stm32_hw_disable() routine won't call regulator_disable()
  respectively with the ERR_PTR returned or unbalanced.
- update commit message to describe error handling on HW disable.
---
 drivers/usb/dwc2/platform.c | 182 ++++++++++++++++++++++++++------------------
 1 file changed, 107 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index b65b9898bac0..d61b088cbc26 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -91,6 +91,89 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static void dwc2_stm32_hw_activate_id_vb_detection(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	/* ID/VBUS detection startup time */
+	usleep_range(5000, 7000);
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	/* Remove overrides when resuming from the disable */
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
+		     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+}
+
+static int dwc2_stm32_hw_enable(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* params are only known, once dwc2_init_params() has been probed */
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	ret = regulator_enable(hsotg->usb33d);
+	if (ret)
+		return ret;
+
+	dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+
+	return 0;
+}
+
+static int dwc2_stm32_hw_disable(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+	int ret;
+
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	/*
+	 * Need to force the mode to the current mode to avoid Mode
+	 * Mismatch Interrupt when ID detection will be disabled.
+	 */
+	dwc2_force_mode(hsotg, !dwc2_is_device_mode(hsotg));
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	/* bypass debounce filter, enable overrides */
+	gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
+	/* Force A / B session if needed */
+	if (gotgctl & GOTGCTL_ASESVLD)
+		gotgctl |= GOTGCTL_AVALOVAL;
+	if (gotgctl & GOTGCTL_BSESVLD)
+		gotgctl |= GOTGCTL_BVALOVAL;
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	ret = regulator_disable(hsotg->usb33d);
+	if (ret) {
+		dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+		dwc2_force_dr_mode(hsotg);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -129,8 +212,22 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		goto err_dis_clk;
 
+	ret = dwc2_stm32_hw_enable(hsotg);
+	if (ret)
+		goto err_dis_phy;
+
 	return 0;
 
+err_dis_phy:
+	if (hsotg->uphy) {
+		usb_phy_shutdown(hsotg->uphy);
+	} else if (hsotg->plat && hsotg->plat->phy_exit) {
+		hsotg->plat->phy_exit(pdev, hsotg->plat->phy_type);
+	} else {
+		phy_power_off(hsotg->phy);
+		phy_exit(hsotg->phy);
+	}
+
 err_dis_clk:
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
@@ -166,6 +263,10 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret = 0;
 
+	ret = dwc2_stm32_hw_disable(hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->uphy) {
 		usb_phy_shutdown(hsotg->uphy);
 	} else if (hsotg->plat && hsotg->plat->phy_exit) {
@@ -346,9 +447,6 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	dwc2_drd_exit(hsotg);
 
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
-
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 }
@@ -541,33 +639,26 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		goto error;
 
 	if (hsotg->params.activate_stm_id_vb_detection) {
-		u32 ggpio;
-
 		hsotg->usb33d = devm_regulator_get(hsotg->dev, "usb33d");
 		if (IS_ERR(hsotg->usb33d)) {
 			retval = PTR_ERR(hsotg->usb33d);
+			/* skips low level dwc2_stm32_hw_disable() in case of error */
+			hsotg->params.activate_stm_id_vb_detection = 0;
 			dev_err_probe(hsotg->dev, retval, "failed to request usb33d supply\n");
 			goto error;
 		}
-		retval = regulator_enable(hsotg->usb33d);
+		retval = dwc2_stm32_hw_enable(hsotg);
 		if (retval) {
-			dev_err_probe(hsotg->dev, retval, "failed to enable usb33d supply\n");
+			hsotg->params.activate_stm_id_vb_detection = 0;
+			dev_err_probe(hsotg->dev, retval, "dwc2_stm32_hw_enable failed\n");
 			goto error;
 		}
-
-		ggpio = dwc2_readl(hsotg, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(hsotg, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
 	}
 
 	retval = dwc2_drd_init(hsotg);
 	if (retval) {
 		dev_err_probe(hsotg->dev, retval, "failed to initialize dual-role\n");
-		goto error_init;
+		goto error;
 	}
 
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
@@ -637,9 +728,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -661,37 +749,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
 	dwc2_drd_suspend(dwc2);
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		/*
-		 * Need to force the mode to the current mode to avoid Mode
-		 * Mismatch Interrupt when ID detection will be disabled.
-		 */
-		dwc2_force_mode(dwc2, !is_device_mode);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		/* bypass debounce filter, enable overrides */
-		gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
-		/* Force A / B session if needed */
-		if (gotgctl & GOTGCTL_ASESVLD)
-			gotgctl |= GOTGCTL_AVALOVAL;
-		if (gotgctl & GOTGCTL_BSESVLD)
-			gotgctl |= GOTGCTL_BVALOVAL;
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		regulator_disable(dwc2->usb33d);
-	}
-
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
@@ -717,31 +774,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	}
 	dwc2->phy_off_for_suspend = false;
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		ret = regulator_enable(dwc2->usb33d);
-		if (ret)
-			return ret;
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
-			     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-	}
-
 	if (!dwc2->role_sw) {
 		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 		dwc2_force_dr_mode(dwc2);

-- 
2.43.0

