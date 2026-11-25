Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624374;
	b=Z6fdoYNHtqzdO4EYqWH0IqRH7uTzRRVv0bDwHo5k6wXgb8vxxFaYu10Mcki9fGOfLqp8
	 5bNwXgkW1EzWXzJE/TRMUVIO/ksGSJm+m58h0f84CcKopLrpZn5xAJqPamLZkuOkWGKAl
	 9v+x2cUD/hFOpo/ZGIjDL0+xhIoXbESnXYpnQ2N8Y8DBFlPjZ26pxBGyGh+SsICzGzUmu
	 EWR2A0XVkSToG/HYrAvHe19cpnuj0Bvaf6eEe/85t77zvlCv8Yt8/HY9WpRyER7DW9ibX
	 NAYorGVowVnVxZ9Q1v5JSQpzBhAd6b/r+sxeeel/htUEjVB4fPeUJ/GevllkiHHG3RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624374;
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
	bh=KYutawCpzkVhtZ0aWBvYB4MGJXEzxRjJAJ9CxvXCmdU=;
	b=GR+7TYAaxB7QInE3U8OBitXlC5NdqopqPgdAFE/XVg10lsuLf+CKkmAfPVhbNdT70vOC
	 MBMORNX3RYSBJdTuNtJFjxuJEiviP4CBsT+otE+zU5MkrsoIBHDPHVcT8ITIWoWb/Co1i
	 /WEKIsDXwqSi6kQEZ4JnuSy7c4k8a81ElIYcn3pbNVMRNPGAStwB5Gv5IohKL8YJdDw0a
	 oA8YX2tdTiHScPyprfZ0NFJOTnPLAhWZsbxV09yhGeVh5Vug6QQ+0q0sXNv1L6gj9HSB+
	 DnZNlIIsuoex3e1c11ObQRz/nz06bxcceubYf6iI+7jo78k45X0rEvr//Z8Guo3eVlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oPtRlj4h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211F606A682;
	Wed, 25 Nov 2026 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2211F606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oPtRlj4h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrCEr3jdkmF/x3f9fMwAuXO0dKKknjz1npe+a2q8TNL2l3hfSoowUBnlpHyeqCwT30o2V2OgK0okIRYbLefqDUo/kpWXDtjIu4ck0oe5cZ312xjrm7axFKrIMVD8W36WVYFnWK6+9FuSuf4BxZcxwKbwXFBwkVsSPmfvuqCN0zbUyZ0h2j3Ca3bIxPvzQkF6wjhPvxeRIJ1G8f8//hdZ3ymVzTTYPCLiE9HYm933KI7/AuRL6ooZz9w8HQKEx1Pi3V9IYvhwvopTHOqTT+5xv+PorU7LI5JQEc13bFwOP0prUuViSYDw4hC5uiu+XPSCHbhAx5hs6Y1ehxbuAlXyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYutawCpzkVhtZ0aWBvYB4MGJXEzxRjJAJ9CxvXCmdU=;
 b=Y94VwNiAOKKKuDC8dHygAhYpWy0lEzdyaQqqGwS+RoPHk3ADBWSJRQ8BUV99xKXfOkDCCa2LkYlVWtp/OpztT0pzHZzZUviHzAYOqayJl6pvlRZoqUGaLqJ2/BX08lboXLhF+T8abFydoDqW9ftnIkgAdM/Uu5DNHJ414VOdQFrLFkWh5NIkXXxhfgS+nXfDgoUOnXDM/fQfGUJk71DNpPdheFri4GSRXAUkeaewqNzzI0ejbhS2mlfFpAxoErnawS70CFJnbrFWfBoOlNXD3jH8A8KQujCSphXRgcc7tbGHwSjePrZ8VdsLGRgKCuCqN5SSGOkHK7LgUHaSkxhWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYutawCpzkVhtZ0aWBvYB4MGJXEzxRjJAJ9CxvXCmdU=;
 b=oPtRlj4h0+IOgcvgzXIu7aZe9YEREs+MMimPG1zltg/NaGIU3V1iVoAN4FwKxP2kHncGVvtWX3eazpt9blNb7Pnc8wvJQ4iVX7q8Zv8+0zLUCQl1eOdlpMv+tkiBA3VVutxDEp5fyKj/yiVffag10W5PU6LgvWP1oPzN4tKOrT9PgNbCjIM7BeKfgbF2ZHNea2FoaveapAdmkgzR4wl8DdgtF0ZhYHk9+lGxGNt+TV2JrpvMYR/TbP/car5EIXAO4/5UzvblOekBFnsQvzUEx824hez4lrkPBXQEUOoeJ3wbZWhAAEgnJIfNhLDS2BxbHD2ZQ7kNBawe50iI6sICSQ==
Received: from DUZPR01CA0319.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::18) by DB8PR10MB3878.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:164::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 16:32:47 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::26) by DUZPR01CA0319.outlook.office365.com
 (2603:10a6:10:4ba::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:32:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 25 Nov 2026 16:32:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:52 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:46 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:06 +0100
Subject: [PATCH v6 05/11] usb: dwc2: fix a possible interrupt storm in hcd
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-5-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|DB8PR10MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 09930035-be94-445d-8cdf-08df4b11bd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|261021121427099003|261102123227099003|261021123027099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	A7Svr7pEFRt2OnFD5VMuKDMv1eY/elMkZlBcvts74D3RGTzJlU6FLQE3cLbdjQZhbDayOc/kLcTaQ3Z4VkvvtvO7U9NMZ+AiZaCSSoMU95896yl169FgXJCdcgx+NFaRG1qx0X0OwuNN8tENlE4c74byATLkXSZLUj0nzronsLhr+AnP3rXEU2Pgb9g7sCvVc+GwNaMjbuCCFHqDNnVp4QTflz/YfCDc4gGivL3dGh5JwB+bMENgR5L4eDs8aJmDppgmKTnATR1uZQMsSD9ROfwmq/6QYc53E8bmTXnvIzQxPw2MjH8KcBghl1lMH8OjGTI6tTJwp/dzSoR1DKmpBrIfWSmOhHVs+8uihnoE49NISztGbtp7RwsEk6KCR/N8LcXScGl+je3cFLwQEonhYk45ltoXJVNOBhqsWQ86NBrWOHecohuRAps8Y/L1gyDSpBvNdOqvpXuMGCXhZaJVJ6XBT5N0pXXXiNuGlVFD1W90aSI8rukyZvZdFdO0+8ZHG4G5IFM+l/F/wj8f3l+T/suTUgcgpK5/5TQg6/I+Ci0nAudbs2MmQSqTp1/IB9v/MoQWKg49HgFlcmvfRHKYcz75yfcGw0KSDDL9mEBcT1U2ilFjiOyK+sW+BzH6ekrhfM5DrL4Yzz+FQRQmdhiegX5O5wrSWyh+wK/6a8a0fPzWAsu7iDHCe/SjCQoniwAesTbZNOEMleQoLIgMMcJ1Ig==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/zyWyYEkZlb6of37s/YkhVKCgZS8YPykZMJjtadTc18vHv0rWmBGUd/Fe1mcTbtZOEya02uqQ87v47bqRu5/cqlR+iXohatRQ9OhbA7rgBhdbJRcom9Ox3PBIlVQwlCJ6JNOwWvrWrwVNk0d8sMNmn2/etse12kSruHAvgJTfxqwPFeLbGfMVyi8Ic2ir7WNSq2ou5uTyFpxqESDhvUYUwMIQrhNRm1J6RpRPbJd/hXgq7MO22GA3D6rMQ4+mIYJvTWwm+PANFh+BjP2XQgTkKxClxDmGE3eTzY/CSjrV+APFxWeHXlZ01JTZpv+VprqrkgP9akUuLDFqPWyijcwiimTAHw7ncq7dvdncxVxm/8OU3lRGYjr3c2Rb+VjWCoGdHxxZECfZaTrwWEkPquIDbhstv7Kvn7xgSz+Tv3ohho4aBzR0vijpnEEyqaDYoCt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:47.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09930035-be94-445d-8cdf-08df4b11bd9c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3878

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
 drivers/usb/dwc2/hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 60b39ccd0cad..7729581d1102 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4568,8 +4568,6 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		 * the global interrupts are disabled.
 		 */
 		dwc2_core_init(hsotg, false);
-		dwc2_enable_global_interrupts(hsotg);
-		dwc2_hcd_reinit(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
 
 		/*
@@ -4577,6 +4575,8 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
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

