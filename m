Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595703;
	b=TptUzLeECryBKpMX5zPFxBbLDA8Uja05evKX7B9/onh2BvtvBUNFqGbceTeoMhqibfrC
	 MvOcvuoXXGnjnUBRQKuqlvK5YXU7GPXdHnvIi88afX4rspyx/7XqRdzUP3zyCaEgt0Sh9
	 Xjo7j9QXb/mvDYUO/aoe5f3s/JQZuzKsgw/O0P/ybjfB2AX9MBduXaihRQJMXCBKmQRzL
	 GonEg5zIExnyo6CWTc/LzhwmmHx+6I3hMIAK5AnwEKRvy8J7MgmE3+MzNeIBhCjzNpcb6
	 HCwzpFX2NIpoAahYEO6pvFU3GYAivCZgJvBnO84Snh8n8AxOrtnXRzERIoJIcXLlSuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595703;
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
	bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
	b=Qt8LOiXscvNGCO+6g0WlzI+EOwrx+GjIws37b2X52EnunM6sxPNfuoLRNna8MKmLasMn
	 j20Uk9yz//uGxNBM+uvGeQ1C9tyO4aaBf/8tLV57LG0FT7XTH8MXRfUG39eV7VZbmCsHe
	 nhmj9hvcraOywpzoDl8TXCws1xbLNoC4jGtIwLnItMW8NrYKKOLUAAYCMlqrObxK5DD54
	 wxwt1umWpX41+H1cu711B/gvzTMKJh9XjwDE9tHnnFXBDLCQzF/YKGCMvhpEx1KX2XA7I
	 KqDx4lzZZG2K9uOp+SB/GDuOa+f7PYJ1ZJ9IZ10yJcEcn4xcTikoO6ihpI4RCkEYosw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QpvZFZ5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C16606A886;
	Fri, 13 Nov 2026 18:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C16606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QpvZFZ5y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb9ZVqjUBqPaW0qYw2wwNXMRZjvgGEhhqzbbq6N5sWpsvFxhJlzW49phTKiX1EaMjYs19zTK46fae5dsvnSJOxlrGSQ68ui+mtEj+gdZfn0heAGDNee0WctykXQHONsUe0z5nhaJAS7nen9Ev7bmOOrmfD1J1fX2eV4WlWf0OJglYOiVdjEVmjsJin9oid7AeEYV1HJyFCKY4BGtIP0VzJbaPyX57sMMJ1AkaCMOQtbcLamDWzsNRiZ6XaqIjdrlThlwHh4zINn9bXW5ri1Y68fgLV/gleBBR7bx/RgF3WvfsSo/eQa7RIQ6GvQymD0KIoJbmBIFl0bpCxIkQ5iYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
 b=o+hnT0FYPbQC4OisdeUF59vZXZu5btw71uY3ZxeIOigCUq1vupvB2uPjdkUKjR8j1Ls1HlecO5fAaModNWSfX68bNJQeH9ji/EhSeMH0Plbnxer+YpeMEvP5GyrXDFY1F58ZehQoeXboLOzLRNjrCAXtGJYFyz/RMEoaJRZws5S02vmVhzYsOZB8sfRP+YLMF1Rz3VFyQJxoNl9PIBoPDfi3PQRPpZ53VDCRT7ddPei1VEK31Ldw1VMkgfRkwQ3v5XEkV7aLYiqErwaTJeSXcnCNlWIaF9yjRUS0LeGgmWuEdWEt9kUpTAkod3p742zfCKRgpzQuho+M3UrO9qw4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
 b=QpvZFZ5yt2zfsjCsA5lm994PAR7GBM/aQeBOKQmsJzQ0gcuBLsBKRFkTaMjfsa5y1rs6eo1qqCZMB6tvjYlKPW6ZRc9Nm4upGszQbvBMF6XBFOD5XDK0jSsOP2lco1krvs9tinjirUXVXxbl9tqdtQ7QhXEp/OqmA1KusErDn5LVlVOIrBvIcqFJet6c6I0+y/qPHCF9MB6fxtAzBCfzQ2jX7/LSwRa6FeRnBpWsNnRR3+9b+D8uDp3+AKyzIomPxeH5tA6GCroLXW+kS4aoRX+wj86U/sPcWaL6Ur1xR8WClHyS4YpYlfXoZQJCbr+OQoU0FoBT9tJc8yGhWLyMNg==
Received: from VI5PEPF00000979.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::807)
 by AS4PR10MB6184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:48:18 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com (2603:10a6:298:1::6a)
 by VI5PEPF00000979.outlook.office365.com (2603:10a6:808:1::807) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Fri, 13 Nov 2026 18:48:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:15 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:16 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:47:59 +0100
Subject: [PATCH v4 2/6] usb: dwc2: fix a possible interrupt storm in hcd
 resume
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-2-08a8c962a09e@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008483:EE_|AS4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: cbeb1f5f-1ad3-49e5-54e6-08df41b6ae5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Y7QDv3hfIJqfb1Z3zcxpfIbkyMhglIdW6iDelJRx+qqffHpKUekSch421Dt2Lp9YAV99Zl3GY75WF+Ze5XOECSVeG/H1vkUUPrOu5T+d1CBWMJA/nXML9C8fNK0dCMM4iiinivatKQey/7hd6HfZC8levoW0b2O7ZK8H4yYQnJ4hxc1ODvLMuqmWOGrV0aTt2XOL/WeIPWFcH+mFNhn0sfcQ0a/utEKGvAqaKZT5rgh0KD2p2Mm0bt0goo6OATGvpwIB6w+kT4IDdM41b29y/NbZql41peu2c5WA17w7yC4xJXcLcOHRsytG70J+PT1aJ+g86zJcGRBKk0JaUQUL5cAsKKky2E0wF/79pzoO8kWCTQr5MvkEYTWKXWqXxu75IcBoMq0w89/ocFTd5S9DhIjOEe/mFpoRMt8fzd7Cc/oBTNCuCa7DatDZHI5e4+suMI5FJyfS1JSTQmt6i3ZZMEImTKwNWoXJe29QarIbm+AvUzt5l8pX8lp/xv45sgbW5lgRLeTMytt1z19QBZqMDomAzQECJmQMYhGKpMlMqa9A/aPwO0JwOGj9l1VXcQJ5PI+lLzKVnsdQ8bnbsloHBjHvVqyL+XqxBez+nQalOdEnIJRMWte55GmZNUlscUtPRxwE8VcNRnndcerGEivh/e92tV54gDaJBBWKhzbDxqBBzCsgAmYBou4/8vWS9k/S42Pz4NvaHCc4JLomLSUZ/w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	64TYNbmgR7ePObxI1KVKseIzpB12DHlIktSZ6eX7typ734AT6MR6Vwdeh6OAWJCaLA3ezrgKtPC7KZfCrTQEPNeac65Wii40bKwHFhGm5axOXiEleXdMEwX0jbyEPgPGTEXMAhQa4j/Ynycjasp9eNJR3Xh1p8FBaoy+c1amrWCs2XO2AfKxhduMr4JvHJuW15FP/E2E7BQomv0Sl4tzzn5nt6l3bvrcpzc62f6/OiGLWNO1ko0Q4Hhx4DuogROjyjS7jGGvLcjTvkm7TGhUzrG0xqiLeoScFqqvwQTZBsS+4XTJ4bqnn4qHgKAX+BAdn7dB5+ud/eWXJDDEwZF1dxkhy6CnEw5QrWGlwbbejadUOyGDeOtoPSBX9ghr8KSrtcKQyl/rnk1rGV8DOzqB0u3gBz2wA6clxlMDnxVu6XYS4bXufAPZcftlm4H5JUSt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:17.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbeb1f5f-1ad3-49e5-54e6-08df41b6ae5c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6184

The host interrupts are re-enabled in dwc2_hcd_reinit(). So there is a
race during resume between a possible hcd IRQ, and the HW accessible bit
to be set. This can result in a bad_irq to be reported (nobody cared).

Note dwc2_hcd_reinit() "Must be called with interrupt disabled and
spinlock held." So, move dwc2_hcd_reinit() and the glocal irq enabling
inside the critical section, after HCD_FLAG_HW_ACCESSIBLE has been set.

Fixes: ef5e0eec4764 ("usb: dwc2: Add clock gating exiting flow by system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Note it's been found while debugging with additional mdelay after
dwc2_hcd_reinit() call.
---
Changes in v4:
- Address Sashiko comment "usb: dwc2: unlocked dwc2_hcd_reinit() call in
  _dwc2_hcd_resume()": rather move the dwc2_hcd_reinit() and irq enabling
  under the critical section, after HCD_FLAG_HW_ACCESSIBLE has been set.
- Update commit msg.

Changes in v3:
- Introduce this patch since debug session (since sashiko comment on
  patch 1)
---
 drivers/usb/dwc2/hcd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3f9adfa7c630..7e4202c145f2 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4515,15 +4515,14 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		 * the global interrupts are disabled.
 		 */
 		dwc2_core_init(hsotg, false);
-		dwc2_enable_global_interrupts(hsotg);
-		dwc2_hcd_reinit(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
-
 		/*
 		 * Set HW accessible bit before powering on the controller
 		 * since an interrupt may rise.
 		 */
 		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		dwc2_enable_global_interrupts(hsotg);
+		dwc2_hcd_reinit(hsotg);
 		break;
 	default:
 		hsotg->lx_state = DWC2_L0;

-- 
2.43.0

