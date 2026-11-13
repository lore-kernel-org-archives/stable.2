Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595705;
	b=FuLUERxWb0GxXBqZVGfJnOHeZxEVtp+9ZKPEpmpQZb8AHxFVqJfStTYk+yn6ovWtQtbs
	 mdRzhYHWea6kwaBxWdjNi/bIv7AZFUMCCaEaHtfU3pTl7OCwn67SMxF0OOifa6uRhI3UF
	 9Ri7zdIxvBgTdJcQksvR4FMIPf1QLK1/3PyCY3ZZrRDSZlGqf0Ae73dd66nwsZUY0W2G3
	 8L2pqEgTYX4rNv9ruxCCcjoEIbny0M85eLN8VNT2GNATucf4lVwhoEP+zpRQQRQfP4TBv
	 fky+KxuoPt6X8PR7X7xa+jQsuqp7AiD7+UZ8sA+bNvbK+EGLgUL9S/KUNKVDb31By9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595705;
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
	bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
	b=ny3eDUNmlnDGPe3fpjzdfE04sUjAPAXHmn5ArWmybtv18uU2jxknzZ9hKc4LcPQkI5bc
	 wP4h5hePNp96MvwZ/o5nkU3SWm/DrWybQA2LY5spjO/fdsmFPOzWBXcAGwbnStb7ObRhl
	 hpidhpkPgtXaNuySFfkdE78GINS4/KsdChPKPYac+1VbraBrn3WC3Euzbxuvf9p1C2zfY
	 NerVovug6OoGBc0ujA8px168G/+nZrb3g8DLMK/oWbQPPhHzuOaL/0su33nLsOnNqIyVU
	 QTIFhLfCoZPLlZy1RWZCJNNTSGnXdUaKk5ocRmMy9BswsuSKaIWwnd3eg1XPq9cFkuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ExHMeLpL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.0
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEB606BDD8;
	Fri, 13 Nov 2026 18:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BEB606BDD8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ExHMeLpL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/oEyFZRBGzHPNOfcB0kWjfIRoDIwDZjMr1vFvgUFxszbyK6De4HiZQVZl7J3dieh3sutK2+JnmfCPrfXrRiXd1pk52SrYZ3bDMqC5VbbjtDRMZYUZEexiIegn63xt7qyW2O1ADH1Qug45yAgvJ7C//DQmosPpZJEz4qPFQJCLvsKueLe/LT5EgQOoGS1ipnsGHLs4WO5xWnuLRfd32rjhV6oBxVy3APFW2wlxtVlD6GzKg/8BVstYfnxHQxhuk0IjlDGcsJMuF1Fdw2dr1zLHl47L82KVYz/jWbeRICtptGZ9L3JLfjUVIiKasD1TQj1DiwuafxIHyWIXgWxS8rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
 b=JwLAq/dy9rzHcgT/3LxLaQC9m4wZL0k5xfkW9Il5kXJdkEvC1fVj/ILsultCDMnTj4b5oRojG2gddpY/RCfOdtRzpNL/hHoVir99uBIw4v2qfF5fnSTaXEbjtkZsPpuPLLNMw2HQ3cZt4vKsNiKM+7AoPefwMcfKzIhrnuqDV+ykzs0mszsLI4DgD7bFs597zbBbsAAi3zNM8LqgoEq/07lYPRir4whLTq9vN9cjVO1B71pYr5Qcb96ZDodLVVZlKTlKKR13cVv2xgor/HYdgo5Vko0I+3iMFTSJAr8jms9Kk0tQ8CZKLK5SRZveSfy9fPqlffdZbClcohpCth0ybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
 b=ExHMeLpLq3UY3/ASL9aWFnkF8N8m64ULBN35aiA+emKdnkHLUsaJrR36tcDrA8+Q4IQAKSXQlTmqxsUBkW+It5/cFrFejuA8Igt7/dVwZp4qaO8TrvIQoFBmmcb69J9T1BuSMTO6jPrE37kB5pH4HOm0hl/by4Tg5tQl9ZnGycqetDRAhcb0e6XlY8ZBH5MGaBJQJOnwpsMoFvPXWoAgZMk+vZ/U3Or/Zfe0mw2z5zRYWE//QDsaK9ZgoO9cHpt2DEjHR6BSRWk9ehjl+R14sYgaFGc6+6nCnRjWQVpqkqhvpVw9BZsBsj5sZWBdzzSH4GY2uGmGO63/FDUfsdD1vw==
Received: from DU6P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::10)
 by DB9PR10MB5570.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Fri, 13 Nov
 2026 18:48:20 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::75) by DU6P191CA0031.outlook.office365.com
 (2603:10a6:10:53f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:48:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:02 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:19 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:48:02 +0100
Subject: [PATCH v4 5/6] usb: dwc2: hcd: don't disable external vbus in
 system suspend
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-5-08a8c962a09e@foss.st.com>
References: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
In-Reply-To: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008482:EE_|DB9PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 99822ca3-3591-40ed-4a58-08df41b6afca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261022075727099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wXV8kDpytmrUT6vtj7RyzwVqgASkCwGuFbMa72JXIyTQMfNKiqgY5qmNT90Nyq8CwpQz0rrhYX4xd576rAporjDp5+ntv2Vh7phOWI+wt90nAebujLvogKCRdZSJaVx572FgsmNEVP4qVqsq8vWWmQ9jHRU7I9PJDx7/I4OKLwOjkRSJlWyeCTMiEnynBtFqpI1aYUOfsmKpP34HhDUOYjD4TGw5sFn4ZbWISINiNb0b9VVBEoKfGMyC4op9jvjiwYBl3N4a34ProW3k3av7gosdEZUjJovWGcfxPbhtQrwrEMFL+A/WClujvWoWOlb3XAfnmOIgWpK8Y0pZ9FxsK6yfGPPzFjw7PfY7LJNQ0xlKPP8yrieGcFVAG73MsROwuoLL0TiskjG7e8eiaocuVExsi71mqMzaGmiYkZWDeY8rWd9qND42abqqJZciRayxjRlno7RBGaZG439kFld9UZRaRWKx0ZdKZFh6sEXH66UitR598O0N5HDz0D0jR8GAb8PYMlDmcoL3n/ux/0Z8fSlKwBo2immDZe8mopfuRfVVWD+461dCjjB98wB/Pgmwxv3aMqHxzIE7099WiTdK/+2//o20k6c2yrAkLD+ea6NqaU+OaLXQIhPMs5XfbEq+A9fnTgLIr7KpiS3whrlM4gkrr2mpnXXL+vwwRAyNeaplxQnBtYZODkx8wq7ECl5KANebVl+jpNVHZPjYfzojVg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mjg4Nf5Ig4yFHunF/zl3IqwcKhbjaHQUF3NatGhoZSZeHwrVaxKhdPgUBl0cB304VVKaukrnJdgqxhKEu4KauE2jozeAsySCRZQVnykqCwUb+CFCmg7o/8+C1cdFGgEDn7xz3ymakmjG1DjolDvJWXzE2p5OWCRaRJgjIRwA12YBjpA822SVRD8IOuNuoYqZ+ETtpUj5B5akAG6gnL5ihqOEN3AOhy3pnOQYL0LvMKXOygxxgKUylUI5CS/NVO9bYZwz0LWBPwuTdfig/nSGAp5v6q+WHiLcgQyeU7NVrkijJLfl87lOtn/5K4KxvcS32XUwTMPm6jN9PQ2Ho9pe6EX0zpdMgwL8fWC+o+/szdIcn0sixymCnAdyOFpVfamLhp5NIKJ25PC+mm2EUgTLTPhg1iFkv2Xoziu/3hTl5RBaReNJ4+hq+h8KaIgp6IpY
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:19.8620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99822ca3-3591-40ed-4a58-08df41b6afca
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5570

It's not required to remove port power upon system suspend, as explained
in commit 113f86d0c302 ("usb: dwc2: Update partial power down entering by
system suspend"). It can be addressed with hub ctrl (USB_PORT_FEAT_POWER).

When PM suspend flow disables Vbus while in host mode by
calling dwc2_vbus_supply_exit()) in _dwc2_hcd_suspend() and the core has
been put into clock gating mode, it triggers a disconnect and a resume
IRQ (during suspend):
  ++Disconnect Detected Interrupt++ (Host) a_host
  ++Resume or Remote Wakeup Detected Interrupt++

That starts the wkp_timer in dwc2_host_exit_clock_gating() that will
finally resume the port, e.g. call dwc2_wakeup_detected() and set
lx_state = DWC2_L0 after ~70ms.

It races with PM suspend/resume flow. During _dwc2_hcd_resume() the port
may already be in DWC2_L0 state skipping the dwc2_vbus_supply_init(),
leaving the Vbus disabled.

So remove the disable of external Vbus in bus suspend to avoid this.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Rename the commit title and re-visit the commit message.
- Drop dwc2_vbus_supply_restore() but keep dwc2_vbus_supply_init() to
  enforce vbus is present when setting PWR bit.

Changes in v3:
- Sashiko comment (state desync leaves VBUS regulator permanently off)
  Add a dwc2_vbus_supply_restore() to check regulator enable state
  during hcd resume, if it has been turned off earlier, enable it,
  so it is kept sync'ed with PWR bit that gets set.

Changes in v2:
- rephrase commit message since Sashiko review. Hopefully it better
  explains the issue, and why HPRT0_PWR is kept synchronized with
  external vbus supply.
---
 drivers/usb/dwc2/hcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 053d1234884b..40450b0a565d 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4435,10 +4435,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		goto skip_power_saving;
 	}
 
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_exit(hsotg);
-	spin_lock_irqsave(&hsotg->lock, flags);
-
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);

-- 
2.43.0

