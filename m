Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C54A5EAF;
	Thu,  8 Oct 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466469; cv=fail; b=MPBMZPSw7BIxS9NSE8nnkDdUxmf1K9IjQ9WSk9mYc/68KH4wELn6zPTVUanQxbg2JicYOvy+Yc1HA9r5PNs1GkKq7IJVeqnIpRrn7XFG0oAJRuYEJcKPY/qzE053Hk5n8sU6tEzPYrpbJHHzWnzeo91X6f21mzLieUsIS5pEiJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466469; c=relaxed/simple;
	bh=RjfEu3ro56zCjq62RdxNxL0UfiKRZPKFvyjkPUHFgR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SgjIX3O2VRSIws1KIqhEgNGtZdwJrs8Zqnqi+fyKnpMr0aImcmxULxmVnHkfjoqqES3AkgU8/apFYdC1M/EMAaddpCZVs7LBXsGwpaqUPCqkaDmPba3Fe3UyU1HhfDY21P6FTaGGC8BH3pwkncTkBWmOCmRqNN7slbsomCQ9zdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CtjH8cvG; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CtjH8cvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+DwnID993U7swiX46tRqyat5In41cq06z+Ee7ETbMY4XqR2RtcGP5ZHF8SyYx0yIVU5e0Eo0F5iuIRH/xEKumq1VR9qryToDQN5c7QLPmyQcZF6s9lTsuHnGudRKbC6un9CLEXqxathI4GYdE4kwoAxrmZDC0/i3NtEt9wdJYPInXzUYFrlsanuyVmPB2OgUWCR4UYsukO22121NTELDNYk9TQau/peo3guKYPjkVE3emD2JHX3lMCp4sGpjzm4PyTw8nncOO9K6N7tpAegh/IVmVaKT492WGPWXF7q69YhtundQonu/XLnm9cws/efLIUZYxCwRsDCm06qZ06R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khu6txl6oLWuvF2nU7MvuiY4G682La88OGmSXwQRsUA=;
 b=G09MHds2RKq5/q06g7TRqjp3+qyhSjhzKkC3FyvW+PRclHyNXC6ZWMQQd62flThQHY0hBSHwY02FzNqObKa6d06dyNyazph0W4bwX3MGbYwogUKVNw5IVFZTuGn5sJOlTy1UTskHvPMG13EKMrvtipbVXpzNbuPmT9/QjIG+kiHpPQCqH1Dt63ZGkey8CxQWSvfiW/ztUuCpXg+R27BFBHaPraV/8cxOr5m4ATzMVMLXJEp8WL+enAwgYO5qceFcT7SJCt6XlKR+57IQwhSWZlMhffC7fe9ZsXW1PCzOe+hreHqYeXHCPm7Z77leUChwC8DkiCdL04n7iIAjpx9gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khu6txl6oLWuvF2nU7MvuiY4G682La88OGmSXwQRsUA=;
 b=CtjH8cvGhm2RHl5KnU2Oqz3CJP9Jo9DYpZNSkpgC+yXc1MwK1uuocY0ccHMDK8vJKmbNFPZANac9x8a9T4EY6CECLsb98G93SFwGRBmwv2wzi+EWzTlTt67CytAtV+enGBTOCxi7iyy+1g4HxbmdCLSBbdTc5tbe5vOj9UWdWM4xYjA4r+bpL3pCxlJBckXU9+ErkF5dgnwJ0dLqTjSR1SrmNDTIXs13xmSlMCv437HINfCyNK28JRxN8f9R2g1IUoTx0rF/KPP0e5b18srTwwAgi2UdwfhgTeDdYA9bSCB7raLGB6EHJjl/fW7db+RU4dqLwcHMUmRf6stNSWXqwA==
Received: from DUZP191CA0048.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::8) by
 AS2PR10MB7371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:34:24 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::73) by DUZP191CA0048.outlook.office365.com
 (2603:10a6:10:4f8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 13:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 13:34:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:41:09 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:21 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 15:33:20 +0200
Subject: [PATCH 4/5] usb: dwc2: hcd: don't disable/enable external vbus by
 system suspend/resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-4-5b303df762e6@foss.st.com>
References: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
In-Reply-To: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
To: Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay <amelie.delaunay@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Felipe Balbi
	<felipe.balbi@linux.intel.com>, Jisheng Zhang <jszhang@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Minas Harutyunyan
	<Minas.Harutyunyan@synopsys.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|AS2PR10MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 098491a0-0674-449a-274f-08df2540de2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|7416014|376014|921020|11063799006|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3FF4uCgj3zawNBk8olLGx7c16lgHUXv/TTjW5jgXkaZRfhIcXrbXx+kZaTqgZYGmKJ88ETylJ3bmEgL2jG9oV5Fl2wbUCJ4abmvM0MhhjZWUj5NbG5jM8sEZq30xdOYFtSuDVKjI+PwJjDEUZ7iIYiqTk7ETEuqNFVqR2AJU2H1LpLUBKoC5i07sh2kdSrcGgyCotXLcdbmkbfQveFF0pPe+2PPqtbJrPpx98z0oJKN/WPrqLmWlHdFVQsu856sS3XgNufBn4xUWwS8TFey3o1nwyQNReZQTFk+hBt1sJkLxrvClubwm0I9kdZEp6acpUgjoDtnJcwwUBLIPUfYTuMEJwb+po8TA9bCUMPm5Ze4j+6ced30CGLzvrqJUp02hEY71MPr78Ms7WfgcM9CIeQUPsk2pgXg44rmdSeaU7W3LkxfwzI/xnCBVB1ZR1ZCMmn15M6IYnETAo1caVSpWrpf4Ih0J1cYXqVLGJE+VHgT9l9+peCNibsZju8PVNt+ZeNTQGGqKuRAHoJUpA3Fz7NWqnABKZTpXk6mH7cf7uk7IqTYq223zBDhKM4oL35i0eHGPo1WxJIgeZXfwi/abduRgJ5CgTqzstyG+uNOoZ/2qrbE2FliRnVe/0Ey/xRd/L1yEGTxXMEqsuFE7TrgnDo7mzfXETeqoWR7/a5shc9M4Ca96yaxFPERNxWpW5ynaaOCE512j23p52b7cnvTb8+LMQr0auc2yWek/MJ9KMNArwfdpzlegsoaz0qTH+b4R
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(376014)(921020)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WYoCoFrSkHu7wMWoVq3ca5CDFYITaq/8CguQEiHh1XU2hdJeI1bT1iNUKTkssWg1nitibR97uTeSwuwkVtPRKGwLaecbKvO3jD2sMoWth/SU8uLdPUZEC1UQWffOcl4tD70QGBwa8cfNEDmz7qtN5Cc/Z74EJygx3Omzx1oe9XGxG3375fdeFYzj11xl6WROudgG5F3G/DYPogf/sWX+6kNYrwJWySvJVhdk3tjZXkelrcheG2AEz3U8YEkLXP+8I6IdYXwFwhXQ4pGl0X765Ib9FLvJnppquB4GjbI5PAEwvZFp6xP8VAp+cYbPw8apD10DvcbJ3fXv27ROIyOD04RaGTQW6UkABPerrlG7QCFn+jefwOpnnPryqMa0AS5uWbZcFViFfQheIh2bJFj3zPLeuwtOdXs5TQA8Qm1+4I5OZQieYikajhfwnopf/P6o
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:24.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098491a0-0674-449a-274f-08df2540de2d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7371

It's not required to remove port power upon system suspend, as explained
in commit 113f86d0c302 ("usb: dwc2: Update partial power down entering by
system suspend"). It can be addressed with hub ctrl (USB_PORT_FEAT_POWER).

Moreover, with current implementation runtime PM calls bus suspend/resume
routines, when no device is present on the port. In this case,
"b.port_connect_status" variable is 0, this makes:
- the _dwc2_hcd_suspend routine to skip power savings, vbus disable.
- the _dwc2_hcd_resume() is fully executed, including vbus enable
So, the vbus regulator enable count constantly increase. As a result, vbus
won't be turned off in case the role changes later to device mode.

So remove the disable/enable of external vbus in bus suspend/resume
routines to avoid this.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/hcd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 4ab058e6ef9a..b5374a4b904f 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4387,10 +4387,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		goto skip_power_saving;
 	}
 
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_exit(hsotg);
-	spin_lock_irqsave(&hsotg->lock, flags);
-
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -4499,10 +4495,7 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
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

