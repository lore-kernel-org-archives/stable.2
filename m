Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29050C2BD;
	Tue, 13 Oct 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897367; cv=fail; b=Yvn0RJ5fhODp0+H3gBtepSBHRbYHT+jYTPERTHApyfiLpNnbb2Oo+7b3AsRssvoDC7B+0luYbEbK0CLEMAsn5A9NkqJBCVYHDyFrT6UFEDBElsTVZn9hX1djQiRtqXon15cHPjwpPHTbAWpqA5rHMkgiD2EUq5qWCxFo5fU6vkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897367; c=relaxed/simple;
	bh=NAtAW14O69y0j8LrUSCujYI9HUa5mgEAzD13NLwXZjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gdbcuUaELDRG5rolSH6YHztwOKQ3sH0ty5knWQmc1IkZKqVQoEybLGK8dUnabGF+vE5nCEjPTlAZQgdpI+USYbC1bHswaptN1tXtoGr5uz4vO2UC9Dx8Y4Uk4vLQsitoU8jveloono+VeRCY+p1Oz84EZdn3eH5FErZqK52PpMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SQFNWX92; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SQFNWX92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9Hc6h1E4PS5nh+OiWKfxG0Z233lL4XdvLYYqkOIg7bYJb6MN/IJgkJLGkpm/KhnGJcSpr5aBgae4nmzVeQPaOjMyo+UtxJZTMo7roMjZqDmMgO4M/rC6jt+2uFmGPsMRLWZW9FyrM5XH3ZLkarxXz6LyqfcXvvu881JRMWAciFOcq8i3IVk1IBNORggt7HvPSXAbgXt97EEySWm/NeR85yvfKuNXbcMzsHGysXa4KkCczDaA71CvnnKU2XTsxbmvCPstNx2IpfZm2KApZ/9rqeAwabhWN8XxR2Gw0e0a4EiFg4KSSxAfumTqSGPQC4vq71f8oj4E3mUn5xoFEdemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB0irqo7dS90qf9lFVDuA34GGjyGmq2VYzOBAmc8+Kk=;
 b=iuESPZa3r4OIUjheedcbjJVCzBvo+KFF0cskgn5QmDB3mhwG+z2FSzOHmi4Ah2e4qiEtUUeK3iS8azjDpL6qABX4OLLneUHLRPQ6mwCCDvmiL6OOzBkEQXB2lkx91hG2dCMD3qMwDfgktsG2uAWTekx30HlYpjjsCOPdZLi4pF9VrMO/jPVZsrIN5meefAUW1fyDIIoHFvhx5nRI6h61YJ4bbR01x2s9SSk5YOQIssD1ZVggPkr/zGcJMnC+G1XYslPF9LXOlZZc4S2Lsuou9zJXkfbWtXd0lTiIHHXMm2k12R5jKDdWaTGA35ko4+wORwJ9/IyrKPiv3hFisW6jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB0irqo7dS90qf9lFVDuA34GGjyGmq2VYzOBAmc8+Kk=;
 b=SQFNWX92mKj3Om9MpRO9q6JaJbxbz6/2/f2iXlymv/8jtysfLseTevJOiIaMzbdNwyQepAbL1k8tkfe+xv1Afz+u7/TFr1t00RB9tgxfzDQrzaFQoMFIJE+3KXKG8eyxYSLuJkceE4mjXY8mpACuyT23ZDlTSfolsuvmBPavm3ZPjkLOdetah5drWBwXfSZ0RYMiJ9F/F0hdJvMLexojN0ZKdfROTYWKIO0UhEGpfXs990N0G1xM5SsRxGF+GhTKoEkcOevC4MJI0HyTWTAY+DxoyXIipGD+NqW59n0r23PfrWo1s0hmOCFxCiwjXnU8pmYmPz2dgJkOqO+oSvWf/w==
Received: from AS9P250CA0022.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::28)
 by PAWPR10MB8092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:390::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:15:59 +0000
Received: from AM1PEPF000C1AD6.eurprd02.prod.outlook.com
 (2603:10a6:20b:532:cafe::74) by AS9P250CA0022.outlook.office365.com
 (2603:10a6:20b:532::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 13:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1AD6.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:58 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:12 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:57 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 13 Oct 2026 15:15:08 +0200
Subject: [PATCH v2 4/5] usb: dwc2: hcd: don't disable/enable external vbus
 by system suspend/resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-4-79865a4f1b63@foss.st.com>
References: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
In-Reply-To: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD6:EE_|PAWPR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adaf6ab-130c-48f8-0662-08df292c1ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|34020700016|23010399003|22082099003|10067099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EUsbiDttLzpLeIBicKxN2Pz7UZrm9QjIa8rKO09U3icbPv3OhFnlywb2N2y8zMqOGsEHW91r31Vi3ySwuYJ2gXTmetTSZhLDJb4i2SYJJP58n9ip4NQlmjpXCLJ73gZAAjIYiUwE8myv3eoJU6Nqgt2Vb6GEmvlSnFS1KENnA8puVCQcSNXndZKxJbE8xHegoHJDFxsqJNUaOJICUVvSvmw/z9644K2gHl9CDqurN7EexfDvTOGjEhObjo5CJE6jd9jEF7RQIlwwAEJ+Y+FfZg0Asjggdf0T6aTXb7d3scE/28JiU9DmO9a5gWkwXEKxys4GmtMxHcozTkBmhkYH5OxBp0ZymSP/P6Gx1KO2p6wzXyZfEwJvofFvdCHtV0XiQRAatQYXZswvZcJxZD5taPFh8nL7ROeCZGvdaFO/+8HUym7mPzm1ZSaYEyO6ZSnTwXilE+nyucStz48/DChaYdlNwgWN2Q6KqVvq1ji4F137EviNGmmqUFWUTCRYgGBU+M3p1TnqegpeKHIxSqY7mxPqyAZUeFNmXO6HQR1lQlyYyZG5B8wpcHbCBaRX/vO4xLyMLhOFDlumz63FvSrEtzqIyh9yqKh5uyarmWM8dMtQB2oNn+muInUvb+jc0vuap8tHqM4KNBkPSq9LyO/VPt/JtEUkRGO3QVDwllclGYBv6liMC1Rubrnzy7cJ9FuEEZ+0aq21jOH/W3Dwh+YDFA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(34020700016)(23010399003)(22082099003)(10067099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	exzIsvJzuQAk8XJJYocX6vuhCbxD/OZzaCtG0yzNvfdXtY1yFSdyF2Kbg7CGTQriLzeJN/fFn1i5FdSeog3563HRaBUNFN/bmvFs2BhuzRBcxt8IGifjqeK1jKi9oBP1LO34JubSPyH9hmA7Uq718IZP3icQChUsIpp7le1yd/8nASO/FJzEugm2GNkPouUbQuAv8dEIcW3EU3IoBlDB3mD0v5/M+ZDkID7NbJzGLheHTRXwKDrZqrFvIrB1mFwM6Y9/zIzh30KWoTC74iAyLA4M+lEHyJvbSrfTy1XOGYjL1kbDkr2ZnLoinqd3lRzZZJz+n7jtHDKyF0OVvUDxnGZKZ3XOZWnruSSsUE0YMwdzXqYCfK0CPlhtO3XOoam0EdhckumRBAzNENCWUBCAA7yaxWobpaKXDsKcKukbsuwVcPhCaT5wbV0SxkLpI+Xt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:58.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adaf6ab-130c-48f8-0662-08df292c1ee6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8092

It's not required to remove port power upon system suspend, as explained
in commit 113f86d0c302 ("usb: dwc2: Update partial power down entering by
system suspend"). It can be addressed with hub ctrl (USB_PORT_FEAT_POWER).

PM suspend flow doesn't disable vbus while in host mode (neither by
clearing HPRT0_PWR nor by calling dwc2_vbus_supply_exit()). In sequence:
- dwc2_port_suspend() - enters clock gating (set lx_state to DWC2_L2)
- _dwc2_hcd_suspend() - nothing more to do as already in L2.

PM resume flow after wakeup (two cases as registers may have been lost)
- _dwc2_hcd_resume() - checks HPRT0_CONNSTS
1 - if set (registers not lost) - nothing more to do.
  - followed by dwc2_port_resume() - exits clock gating (sets lx_state to
    DWC2_L0)
2 - if NOT set - exits clock gating, re-initializes the controller,
    restores HPRT0_PWR and calls dwc2_vbus_supply_init() unbalanced.

For the 2nd case, it's unbalanced / enabled each time it happens: the
vbus regulator enable count constantly increase. As a result, vbus
won't be turned off in case the role changes later to device mode.

So remove the disable/enable of external vbus in bus suspend/resume
routines to avoid this. Moreover, setting/restoring HPRT0_PWR for the
2nd case will simply make the vbus regulator enable count to be aligned
with it.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- rephrase commit message since Sashiko review. Hopefully it better
  explains the issue, and why HPRT0_PWR is kept synchronized with
  external vbus supply.
---
 drivers/usb/dwc2/hcd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 05d5d7265e42..bedd1300e62e 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4388,10 +4388,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		goto skip_power_saving;
 	}
 
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_exit(hsotg);
-	spin_lock_irqsave(&hsotg->lock, flags);
-
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -4500,10 +4496,7 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		spin_lock_irqsave(&hsotg->lock, flags);
 	}
 
-	/* Enable external vbus supply after resuming the port. */
 	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_init(hsotg);
-
 	/* Wait for controller to correctly update D+/D- level */
 	usleep_range(3000, 5000);
 	spin_lock_irqsave(&hsotg->lock, flags);

-- 
2.43.0

