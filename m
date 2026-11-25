Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624381;
	b=jeEEnuKk4IY7AjdZnS5Fm1mVTEVb6oqmESgubI1RSwXhprn7oxKn+Kzz9SxjYLJcsW/n
	 c6sJQFTqb+NhFnHZwH8TzNqCz1s9Eelo6gdIdPgPX2Ll2CY/02TuMgJ6Gu6MjFC8l8Rfe
	 MJsLGOA4tu+UtLU+IuD+yd04VLH7iuT+ugiY2xVeMV/0hy0oAoPhqK7EmdIx5wWATaFAe
	 n7kEksGttf4lPbyVyFQnr+CvaY+VWneM2hfXRfSEHcjP8TnKRa9hT8VGLDNTNbYVqfOK7
	 b4x7t6YoXLg5FzphRufJcPJEMm/fB3XR5flRZ3kgzVXjf8Jx1oxkQwjJJsF3hUgDp0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624381;
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
	bh=x83gnRExLo5mA8Icuk/MAcOlEsttoRf793T7alLvGkI=;
	b=LiIcxoEwbuYKKcfK/OTtbfiV2CRXSrKn01mLWmT6N2iYT+dpTYB7rgFFaQFA42P4nwd9
	 dk1krCzX2sQY7ZAkNkjIVSPmge/LVSW46pZKvzzizjsALFfDsc535DA6BXqPTH7X8snFo
	 RFki5t1YqOcwEogEqTH2OWZYTfOizHuNwFF5kFg8PTlC0wFLCr3wbQpxXQ7uobBxBzmtS
	 aS3ZS56L/ijxGCE6DOIwBW47eOcXQIWZvNHemQb7fcap9hO5wpvAYq2gJeDmKV9OdfqNQ
	 YJgBd2v+LFGusozHzAQptY4VSxFhTnnkNgy5I6VrwKjT9iCPyk1UrZ1/A8/AUt08KTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NXTVkluz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.26
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8889606A68E;
	Wed, 25 Nov 2026 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8889606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NXTVkluz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcLNprDc3RvFFCl3zlyXrh3UliCaFL0nlobxmdWs5qTXzm1Bq50srNRbOaeHOQhxmngPq/VFtHLCMRfBeFQmJR6GaZWAFMmzaSs8xnd9/KBU6giXIxkocJCS7+fEy2WbjiG1AIJ9ZWdvq26BtrxnyjYSNOPkipLoaUK1fyYTr6CZoyycBX+K88dGjrMsAWxl/mvwLBepkiCUk54GAcKiYabPnCOzJ8670Pj3jZJwHNJENM4+pxwL1vPrY//dlspwujb+0DfArWkYwwARzKISUWqk4GctT4lQPGdufQ0BgLAJhGb6EP5jNDnJ9nTFeJanVdfeSLwUd6bCTAYnHV3HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x83gnRExLo5mA8Icuk/MAcOlEsttoRf793T7alLvGkI=;
 b=Xa5zIO7SMxqPOnr2O0VCbEqWP73AUkRO36/Dk5KM8z+72NJ0Y+d6YM5x64NU80HDX3hhOmdvCFeCwRrAxDc3tZwEFHVDtCzEeGqxOIlZJEMtcAJdnb0ID98SA20djB5e0+xH267bl0l2YveG8kB7T49PuxsoiomRKJ+N5Vy+y29vCtSfTwlc9igFaX9JpaFzX2xEQOThEb0rsJNZR8sVJ4phzEgqNkpPL1XPLDr/8FfSX6fAIH4KvWpAHUYyV+F7lPlEyZtZSePsqRqKTTtBhK1Eq7As69GRGeJJ0ulj61XRYYPRqD7KfYfog8sG8bZ2E2klSeh5qKjvc7nHA2G/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x83gnRExLo5mA8Icuk/MAcOlEsttoRf793T7alLvGkI=;
 b=NXTVkluzBggQkjSRjf6+HEkGUi1y8Kdv5sB7qE6ZFzweXY10XbzEZIp62KiXPpWmP/COQDyWJu9bWqRUywxFfBMhk9DvyU0KAEgB7vsqpoUURNVmhavLao2a4YfAKESeH4QWxU3TnMGsKdY+sGt1OH3n8rzOhtpM6lJrWqlcktrM0CMh2H0DUweXNZlfNqJfsfI30PATdLH82v030rqyKh+Fwqs0H5xbd8LqHdDaPUvxjQXpEPki9hCaWnzBEIkBYOciVbuOXv+vxC5PtQZ3WLhRqmEMXdlJ9lpjfuOUYDUlfWL3Xn3mP8LyYZ96N3I+jILoKxTkyqVjV8CbNjvK8Q==
Received: from GV2PEPF0004811E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1ef) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:479::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:32:47 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com (2603:10a6:1d8::118)
 by GV2PEPF0004811E.outlook.office365.com (2603:10a6:158:400::1ef) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Wed, 25 Nov 2026 16:32:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:46 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:34 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:44 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:03 +0100
Subject: [PATCH v6 02/11] usb: dwc2: keep TOUTCAL canary valid after PHY
 init
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-2-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3A:EE_|AS1PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cada5c-4bb4-4389-3496-08df4b11bd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|56012099006|10067099003|261102123227099003|11063799006|261022075727099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZlEhOISxMKmp8RtJXGIr6llwG2AyfDFFCT59W2EIBl7PzPzXiO5EEZya7uePlFr2AJNx0JkpVAdJgPJJtyMDx0UdgEmbhLRCxFZf7CWFGS4FW+FTkr4LwWPAz6tWBCMJvpEX20q6OiYRkHYAafFacPTUYyLcyhGqf+pKNzqUjUw6n3TY+6jp5Q0BIwdWJhkco9VrcWDTdUfW44oDeiUtIBKpuER7J9eUUAAbGM0pFqccgZxsqz7a+jh+j6zrfHMh6vTPTji0kNuNGf1cAOwolrKGboYM/voh9C4PG1e7FnsJd3WztTG16oZNuQsJjHg1SfDIwduu50IB9zRR7wyxv66izKH1UZdAanzBEAG47CkoMnllHcJJGvE6ZNHOUlXY2XUAZQeEdZyrAXLszhhiHR++MvKQytwRFZqnl+B/es748FfNepj1Ztk0eF6yVJvSEi6XiBiJ8cZhH/RY5uJNplqvOkV1nmiaKPL3jTaS2BwEABs8Tcnn6AtlpoUah4S7bgqGKvhCE4snOMAOWeWGZ+320OzkNra7j4/jSJUpNlmKNnR8anzhQ1nMEdqPtszIozilifjvcigTAFNYoVkQtEhEhI9/73vEwKy/QgJi+mLHcn2hovnpGDDEzYNTNW9Be+izXPZa4ZG7rbifwqZeXg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(261102123227099003)(11063799006)(261022075727099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TMYr0cB08JrUOS7zEi194lOpXRm0CbkdGpLMQnA5ePOIVbEQV/HfRTA6XyYORSa37wIIdEuT3Oo9dTFT9pHEz7wjr2ForGpL1v1JYl9Ap1iD7n+QPtE82vvNfM1vRFw1FwE3IEE765CNsr86L8dZPcXAFhTUtqrmh14NmNaaJuxsnFRhpTgApqvkGHoMAANcrlFSmXjGWFpe5XJKJmvZuZ6zK1iWluwfCVTQfXFAP821MsCPa/GRsJSIuUb96LXB9on/ap45HSFGk1YZR/Is+dzL5gC8GgDdxuOSiFhG8dZWUli0EQ9jWGO8MF0m37hnkWKWiHJh5OHZuGjhqCj+NqjYafQcLH2JaNljeW8cQXM6Va6oSwfuz2RIgeziTN1KptLpFf/mLh+Ojkn7hm63H31V15cytmcjoWN0TE82mvYugsRFVGuKnXdg4tnmdUZF
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:46.9409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cada5c-4bb4-4389-3496-08df4b11bd30
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5697

dwc2_resume() uses GUSBCFG.TOUTCAL as a canary for register loss during
system resume. PHY initialization can reset the core and clear TOUTCAL.
In dual-role device mode without a gadget driver, TOUTCAL can also remain
at its power-on value of zero. Either case can make resume falsely detect
register loss.

Run PHY initialization before setting TOUTCAL in
dwc2_hsotg_core_init_disconnected(), and initialize TOUTCAL in
dwc2_gusbcfg_init() after PHY setup. This keeps the canary nonzero after
PHY initialization and in driverless dual-role device mode.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/linux-usb/sashiko-outbox-219256@kernel.org/
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- New patch to address 1st finding of the Sashiko review of "usb: dwc2:
  fix recovery after PM domain off".
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 drivers/usb/dwc2/hcd.c    | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 02c93a41043a..5e75d6975baa 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3461,6 +3461,8 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 		}
 	}
 
+	dwc2_phy_init(hsotg, true);
+
 	/*
 	 * we must now enable ep0 ready for host detection and then
 	 * set configuration.
@@ -3484,8 +3486,6 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 		usbcfg |= GUSBCFG_SRPCAP;
 	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
-	dwc2_phy_init(hsotg, true);
-
 	if (!is_usb_reset) {
 		dwc2_set_bit(hsotg, DCTL, DCTL_SFTDISCON);
 		if (hsotg->params.eusb2_disc)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index db6126cd72c8..0d20b9de857a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -128,6 +128,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 		break;
 	}
 
+	/*
+	 * dwc2_resume() uses TOUTCAL to detect register loss. Set it here
+	 * for dual-role device mode before a gadget driver binds.
+	 */
+	usbcfg &= ~GUSBCFG_TOUTCAL_MASK;
+	usbcfg |= GUSBCFG_TOUTCAL(7);
+
 	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 }
 

-- 
2.43.0

