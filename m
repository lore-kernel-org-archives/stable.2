Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986734;
	b=osUNxCQx+ZPtnGNJ8xtr8rNB7QTHtIUWBZoYc8xaPWdffMNt6dHwe1GqxsGjBuvIfg1P
	 K6pEXPBAXaKz+Q3XcgREXlDEfjxSsxo26Kju0Np0xunBQOVC5hOBeVFcmvA/4UQKOvC7H
	 HFAH9TjxlzqiZq/jOsRyU21OJy7/dZrPMh4bll0frGltghIOH1N+mWLjWR9ziJVOJq5LU
	 ggXR5EPNprdK6hPCH466kHHIni2HIykygLJHIALUjedtYwcKe61DQc0pzVNmHdgWi8sTl
	 ufyv/9M0fecP2G3ds4knkFEfBlp8JXG32pGsJZIXGlsSyc6zwWpo/UNWqrnRSNKtc7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986734;
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
	bh=RqVEZ8kKGFu9GkFEHXbaDujRdDV0uNHuxcql8OGca9c=;
	b=q4HeKruZdMXNy9/wCuN1u9t2VArbDyP7buj12nXn7DiGvzijUDyfyhwESY7tEPCo495q
	 z/d1kN2dqOv7oqCXMSHeW8tUMbWQ4fhy86c9FjuU/AUg6RBX6dDaxM8/IL5wIHTw6do/q
	 TLMWuEumziVWrKKluY6klh1ccRbKIm1mQbhg5ajYCw0C+YvDhyqORWaV2FU8EV3KmC1ks
	 oOCC7XBojSYeG7NFMtzHC4qFSm++8ViblfekNiWK8eRdXchlPZNnrBvTM0/TCYuS4tZC0
	 gGavASfY5hWZIc1YkNh7toG9ppGm/qsbscwEX/f7Lu37mgCk2KU7gNLp9iiK20zUGlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RCYgFBGh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.2
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D20606D816;
	Fri,  6 Nov 2026 17:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D20606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RCYgFBGh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reLB1pvLm2XY1Cy8rJG2L5230/dh+8sg/Kg2On2jroS+NGi426u+Ju0k46ei7DH2uoNSEaQF6MnRTcOsdiC4VCwnNw8hKHC8mzoB1bxgfokU8/d+yIjDxn+9EyBFITBEkAtNV42oEfOaHue515o0jT3W0Nsp74MNQDJExsfgmDce1NbDmgAXy4Jc6AjeN/nqYGjSc9WLdvy+inzIQrivqtMChResl1NfA6Bte62uaZ5S9GeSzjrMji1KrA5ExUEfQVDcxws0uY3RFZZI9TZjcPaag5qaACC0bFD7BnYEMwvnB8tRQVY5LrBE5etzPIMcZXO+QbUrehdluVrEgeQLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqVEZ8kKGFu9GkFEHXbaDujRdDV0uNHuxcql8OGca9c=;
 b=nwf5xlT84rVPbMVZBjHQBJMXCHO76YDpvkjRFFaJGy6sf7AO7fGUMuloZ1txQXNdQBHCWrCUfO8+eSju12CDn5SvjR6w+TqVdm5UVrQXpNFsBDKcg8YnfziWbS4Yx+PhVpbOoKtukTxBdjwyrLfbvIlieYiZ4GgtFrWyHob00NbqCt3/+JWpYWlnPhgxazP/gaLlCp2YXzzMQVR5j6KccUeFelC2ism310BkB0szuxleqbcuVftTkdLXlek137eAfQzVvot5z2l72YShEAHo4F7pEK0doDsw7QMERDj28tbuVyKSmND7bNn3kRbfuv6lS4Ni3WHdCr2GqRAL/99bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqVEZ8kKGFu9GkFEHXbaDujRdDV0uNHuxcql8OGca9c=;
 b=RCYgFBGhR6TYt7pJDda7TxZ3ucxPQI39SteLDre79Tz2og0D0X/q6yqSczn2mAYN+OdvfJ/1AHv817YbIbhKfAN8yRvEIGcLIBzN29g+WxXroIexVKg1kS3xjMaaZmWMLYwIHrbAildL5PcOrL7nBKp+xcRbiRrcdVrAxEjZBdcXZO6G3i/QYDSaPrPoVFk7nV7tQswSvVjun5TW3es58UhsvVDrFAbcQ9eO9wZ3Jrd6jjRaZgYK4951S9o0vd/mmxW45ZqOJl8Ci9/Pa2Jv0eAr0Uk2Isj/tIDtyvjWk9gjqurHaVNXQV023Yo8xRPDkT8jnJ35ORMm0Z3ebZd1mA==
Received: from PA7P264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::11)
 by GV1PR10MB8535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 17:38:50 +0000
Received: from MI3PEPF00008551.eurprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::53) by PA7P264CA0128.outlook.office365.com
 (2603:10a6:102:36e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008551.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:23 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:36 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:24 +0100
Subject: [PATCH v3 4/6] usb: dwc2: hcd: fix possible successive vbus supply
 enables
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
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-4-68d2a0e9bab6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008551:EE_|GV1PR10MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be92214-0d59-45e5-bbb6-08df3c2cd144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|18002099003|22082099003|10067099003|5023799004|11063799006|261102123227099003|261021123027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rfCwrKsl7jGHIsHvPVZ/ukLJyjAyOpoif/ZfjaA2P7UGRYFWAnF+mpS1qUV/hmY55o4O4bIn/jBqd+7lTi51MPhWEIZNdsmB+7WFwIsZJPZNLIF9D4LSgpvLXUkl+CHVNzGID3u8nxwkCIzb2Mm1K7yVQVGWoR1Hd0mc0+XPQpucKzgyWIbju6sHGL4YiEJndOtFvW5x5sYUI7yQib79Q7Krng+KhxgMbA3V3GoEtEzHXm0FFQCRVvM+XFiPe/ZSTNcrLJLXivo/DQqTCyZuOQKoABSetqNxn3Wni3d8rLKwY6CK9KZgUPkcKtPs01hPUJf4I2wK/SvD5Pe7w3/PzIvbA/B5xp5cIuMsqBiAMs8eoZTb5jo+HayP91ZxTB4beaDKo/LqMA5ksUJ18Jmm5kpCN/AtBSh2EYpVKk0+Wt0hVSMWGd/Q+CKYGwO1fvDM3RiSF/0PD7xiqvDzahdTncKmcavLMob3uPJ/Fh+nCfZyxuWXal+n2cnFwO8IrR9tW0wr1JsUmGzjLUtIacp2RZ42BEfdwu4a35wh25vv3KL9qp2eTLjBMAUZnstzGD3dJrZYaDGpsRxizLGJ7Kd5i2xNOWo+zHixOcT4C070JyOXfaxlX25P/NIwEu0wE4NoMRyF3z4AnOxiA8ltLImYXkzL/X9Q9yhg/wXwT3VKsEz/9lO+m+AGvB4zXmzxModN5XQ4CWAoBspRjSyIzBWM2Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ietIYLJZndbmt7gtNE368YJ6Iyjoi5D+3hEB5lFbYD45OizdtofBx52fqp6weUMETVw3YR7OMeTKEwajorr9+TGe9VFgjRoEMnVb5y99QNiE6Gg7GHDcda0UADArdi8BdlfSyMD3tl6ZNebqQ2O9QOGpIGXFpex0keeYcyYGhNWmaP4uGUzf13tP9hMFTYOxqujQqxNNASj7Pq8YkUTYD3/TptcL44WDQWVruIa8quAipHkgSQETWniJWcNHmOd4iiyFvgL4qySKMjugFAfEynk0EOCKjEJdtp10dgLCk41g+wU5pZXU88kg1E3t5R2m0bvbWEvCRMK91Jz7uWyh4xIVDHVIrC/NFyDCH7r+TfGycGcHImhkI48G/d/zfARUDghfT8c5SvpgELM1TiN0PA8lIxnAiJedk6XdmrZkeUX6W3e5hIZtJMUiaH5PlDsm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:49.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be92214-0d59-45e5-bbb6-08df3c2cd144
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8535

External VBUS supply may have already been enabled, before entering
dwc2_hcd_reinit (e.g. the controller is in host mode, without any device
plugged).
This results in vbus enable count to increase every time this occurs.
As consequence, dwc2_vbus_supply_exit won't disable vbus upon suspend
request.
Fix this by reading PWR bit before and after dwc2_hcd_reinit() call.

Fixes: cd7cd0e6cedf ("usb: dwc2: fix unbalanced use of external vbus-supply")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Add a vbus_was_off boolean to check explicitly an off-on transition
  on port power, to enable vbus supply, instead of relying an XOR check
  that would be symmetric, e.g. wrongly enable it in case it gets switched
  off (1 to 0) as reported by Sashiko.
---
 drivers/usb/dwc2/hcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 28cde15e0cca..cae9d7e13d47 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4249,6 +4249,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	bool vbus_was_off;
 	u32 hprt0;
 	int ret;
 
@@ -4264,11 +4265,13 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 		return 0;	/* why 0 ?? */
 	}
 
+	vbus_was_off = !(dwc2_read_hprt0(hsotg) & HPRT0_PWR);
+
 	dwc2_hcd_reinit(hsotg);
 
 	hprt0 = dwc2_read_hprt0(hsotg);
 	/* Has vbus power been turned on in dwc2_core_host_init ? */
-	if (hprt0 & HPRT0_PWR) {
+	if (vbus_was_off && (hprt0 & HPRT0_PWR)) {
 		/* Enable external vbus supply before resuming root hub */
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		ret = dwc2_vbus_supply_init(hsotg);

-- 
2.43.0

