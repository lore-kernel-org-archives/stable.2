Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624378;
	b=ATxFvmbAyEUj37IJNAEIWnxLxYv7Bc6AEaVKJA5XfTn8jdBMFbX7zA2ke6Lo7P/T0Sd/
	 9JFS9XtxritUdRifj/q83gqsEw/fM0Il/Ig3/H3OZQdy14B6rGSt7os5zmlkV7SjDQisz
	 B3g/kHx548JJG2pod7Mh0LzpOxA7CXKJpCx+G4Yr4necoUbaQlckVAsnHPcWO12cI8Y3L
	 J22FdqsLdJ4kdQp1If3UoGqVdhkx+sg4R5lt00GleYr8gOZBvnf8ABh1Di2jaWE4EiOy7
	 bNttNib58Z1stGKvec6QP0AeY398rtljXbBeQLls118uVDtjGEepeadAaiBjktTzj1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624378;
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
	bh=1TpJ6tl6aKWfY87mkDQVgw+co7QobZNUZTTVZZFqj/o=;
	b=PSYyaGkruMIOPrjtGjAvpax2JSz5Yu6rUCB8mXz7ccO8GzTHG2hPWKMx606H2OaYT9Cc
	 4zms3gxWm6yzCs8PvvVHs+O2l0UPTHjRH/dr4pi1Lnu8lov1qn21vbQa6frjcOa6BB7Nq
	 dcULT9fiX2u+b0rC8o9xkSjHqSaGPtMzromq+wc/3JxvQJCEGylS0IQ6BDmpOvCG6aBsF
	 PVraoKjQfBrRkFLHW56+659zzwWoRk94XjG4UxfcbqmYSQ/ug/4U9V6Lk2FSX9MVYkkVl
	 JRMtv4gSR5cF8x5G0IiGzKJOJFumn/QNoysu6RIoCSKLEqt9xg4MU2jpVqloSv6C7Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gcuqUuoo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.34
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398C60A2600;
	Wed, 25 Nov 2026 16:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5398C60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gcuqUuoo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOph9CVtD/aDTvRIMFCt9DA8lj0PEeiMFhcp5oX14K4+oLkCXM89m7zQxpDR9PKtPx2dLjKr5HOhrL3jl1b5tzNrwwKphv5gYPKCuvUPfqstVpj29vX1SYB/BrQZnyHgwjIrFq+ixaCbhg+POIwpMln0UnvEY+0u/jlYEhOmIudCykuz5yTUv4Ql2YEPALLBtEsyNa5viTfC7iX+FjIt27ruy7SM6PZBx3XxWN+KZS1Iua/ttkn0LdaRDwJeN4f/f5GADX6rfT81T2O2oTd2TIG5oCnN+xFl7B++oAiElvDWZNiwlWDKJwg6/XvTUZpDAaFuz1K+YES57tN5okIkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TpJ6tl6aKWfY87mkDQVgw+co7QobZNUZTTVZZFqj/o=;
 b=hdYxY+9hjCVuGEclZfMibZsfmv97hnz8FXUPlDoAUrF5dTrRdcYpC0TkRNKQOJrIuUvkppzVavEU6Ca0K6V6oWlOVUXaJTwfIkmsOSdYUjflHiBkHt5T+ZXug4dNHYPxLW7BZXpWAJ5x8x9GSd3lg4J5E+s/YkleESPYJi/PjiAH07NNFK93p26PBQ6tIws7padGLZOkRRLYKI9QvzxvV7A6z1Bo6yQ34dt0RZHG9oD+A8Gq6b5hzDFJu59gukgfivvS1y8B92OyN7VKTNMSPJrWw2CHij2z82QxHmYlU1dU3jba8kAGbXNWpaV8pM7472liF58bn+NEfkB4R9IkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TpJ6tl6aKWfY87mkDQVgw+co7QobZNUZTTVZZFqj/o=;
 b=gcuqUuoolSAP348XFTEW64j7PcVyTtDaXn7jdctEliGaudk5kZIikc+b2OiXEWnEtDR4lJ9c/Y1dKIKmTHjQyCtMY0WVPxiA3HuGq76UaE0/+FSJnIQM5LAYt3Cm4mCpNozZ6DXbGzhZqbGT7mdDA/l8GZR5hPmgcK7nzK3QQ/z6fNZ1dwLZmA6Ll0ufI9SVkPRdv6NCYM7VJwBVZvs/jNn671V3myhNi3X4jhrjoWSKKgVdHqrglYa/A2dq2qMbYk3lY3ulJ6vAR2CnDIeMxeBHadP0b3OCHP7uMqsXEJibZ5lG/DJBHv1FkvNC2G9EKT52q/hkwsp5t0kCz0te7Q==
Received: from GV2PEPF00048121.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1f3) by DU4PR10MB9141.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:56c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:32:51 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com (2603:10a6:1d8::118)
 by GV2PEPF00048121.outlook.office365.com (2603:10a6:158:400::1f3) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Wed, 25 Nov 2026 16:32:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:38 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:48 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:09 +0100
Subject: [PATCH v6 08/11] usb: dwc2: hcd: don't disable external vbus in
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-8-d5df33b93eaf@foss.st.com>
References: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
In-Reply-To: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3A:EE_|DU4PR10MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bd7bd4-13c5-45df-04db-08df4b11bfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|10067099003|11063799006|261021123027099003|56012099006|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	z2mV33lHmPjj5z+Rm5+ANXZBhR6qh46lsElyF6AOtZ/ag9ddCX8V/DZpd465UrQg6qhql9CiocqWy/JST3M/jChhAwkgkPQ5xLyryBOaedhnAjlu+xLu8oTyauGt7j9olzt93S6J3UUBINrxYbvQP0/hKUUKSiHQiFeLpisOvtWxWIb2JnrTvmZ9XMXlGBPfWMDwi9zUpLxVLqGFCmPhwJL1I4vHRRr1CyYNkr+7FV9q1pWenY19ZmN+C01oKzrM1zqsHuYTItsSwPqQ5TNTVE9pJRT5lMNIOljkKLq8t8zHAldfj/UPtoWgUNqgfYJCpMThSMn9TKXFzvxSDd1Hk573ZChOygKcurASse1MQfI/NM5EOv+aPCdgcm1gf4l6ucrZgMSIQ8OJqnkls2c6jsKztq+GrcljbI/jlYowMjdo0lgkJB4Adr1MIkLJR5E4xx+nXeSLxseuAUHqI2rmTt+wvfJSDmmAVibj8+Zrxfl9I6fCvhnadQIsFwGpETkauRpPO18ZtYseYMizFURR2j3GRbpRPw4pAsSZgTQY3e+D1riIwP/e5JeRA5UfQih6aocUcUTtADY9HEhaKEYvZ/e/72nRFTheBfzpiyKvMJEchHmH9HgFyBQKZIissf8XKVEsbKLIvbPD4rTS0oC00Tr+Tj+xHR3bjpnQwErbyJpnBenFq4PzbD+6iiIMY9B8MBOAuClSIGlgTYo1LM+kFw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VF/kWWRmoJ/u5AtDFfBqswMftlBDPq8KbZHUnmfK0yxUFLp82TG3l/krjhNrIF7BWLObDZO3eZbnoF4FJ3hF04TumhIUPKMCbrGFKk7QJen0ToPcPvNgkMxhdYFL6b5To9lxQzR+8iEaonuXlGev1DM8xf+FtHqnKpcqjHrjZ50j0XsGntKaXNekN6B9zzbngalc8aTZgKfsV7NNC5uHcuHnxyjn7spjWaOOE9LX8KI/SlA9p4mm1071n+MQRADinWiGOnanBuE/2k/C11jCqrcne2Xlpj5lYYj6n6oTMIUu1/hGHIWoNUwHEKrtfzcwCnVy+w7UxM2DUhUSE7koGdD8K141zCOmtrP2q0BtftGGmaJ9Z0X4FdceWFWXDhewvMYvhTxB7XReVof9qiyoY4gMk0O9W0WRoCkVTkwXpb3AaM5Ukk0CDY7srHYzBtmB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:51.2022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bd7bd4-13c5-45df-04db-08df4b11bfbb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9141

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
index cfa5d2af60d1..a39dcbddac84 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4488,10 +4488,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
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

