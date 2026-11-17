Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935196;
	b=0rYw5FcqOPvQAsEYmMe0tuDoRCdDcQfND04X1BLj7svkDLyxw+1yTSy8H3OPRh5znoev
	 jR9T5PrytW0U4TvjTMGzbtJZfc3P7fgde0J+4FgHyfU+AlWD7s3yRdsLuxyrplQjaM/WT
	 OWd+66XEmQQDfBxtQ42v8E6NCw1f+yQqjF6Lm4YflqumWWeonT4bTL/7VVoPnyIYshVZr
	 22F8+LDU0GSTy1ZTBUmJbL3EBZhWeNS4WscXgcOwy3B5cqwqUuj9eMRhgyhCwukbiUm4R
	 SMZAdwJdeCXWDT9K0DdNAkVODy/BkCn/z7155xJ+gen3grHBJvDI5FNpoL1fgG6/kfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935196;
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
	bh=LkHG6F8HoUECsw+KAdKe/ShxtV0kGeKUOEc2HWRopy8=;
	b=FnobzjXCwvataU6YUEIXx/FdaKI9u0VpHwJNxcS10IcWOp3e3qiFjbHqfs+gIxq1vmIt
	 7AnyplTxX9iL+RpW1P7R9j0j6GxhMxcwn8rPjohzN/CgZar5V6hhXtXLs9XZiVdSfZZRe
	 Os8ApwPdzX/Meb0nQTwFFlmjEtCCQ1c4ZDe3pvcPRyh7UPxxUtQds0g58n2V8L7GhfOnP
	 MMD+Q7mj+K5tYcSUTZkVbf8klQhAysySCSg7+hn7sjBJi5uzS+qbhlcvQ8qRHa6hcYH9k
	 RrTOiYdcW1FL7K2PiGF0k0e9SrBvNID2YO0AqjfnDX8NbZp62lfJ59yJuUAZVGOxrgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="O/+iTUZn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.7
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217A606A880;
	Tue, 17 Nov 2026 17:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B217A606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=O/+iTUZn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s50QnHpSh4dLTTy26C1Gs326XyHdkzzPr8W7rS5imJJ33X+csgeTuA28PEWaghwGJJf69vE/pJ38p1/ppZ8fGQ9XA3pARmajOiDUiYc9CUh8lyumGYmnU16rf8cduFbZslP9rH9W1kBxRPrvezROKUzZIl40EIUY3kfvPxFISYhxlgMEF6Y4HmaXqqJdk+I4le5/pFhdh4tzwOaAlabh7ScbOfnfyPmV9RHwWbXgwFBM1QIDmTqgToE1T4J+kNESMKIQxt6p1wW0CgZxLYC217QXKX0Ht8afGJLbSDuNU1u3F6iT5sUEnIjbhII8A4KkSaebrhXyycWe5U+rtJXeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkHG6F8HoUECsw+KAdKe/ShxtV0kGeKUOEc2HWRopy8=;
 b=rkLnDmoGhZJ6WcgZahsl2UcKm4wjPcztkDkWU0CpaST6Lowl+RCbHfAcsAFuHAqxZu/06hyqqHJ3pmglaQ1ev5hOsmAGu2BCQ/6oC2TQzkiwKDFHxucWGXXXYlSLv9fcFsqkRGvGcZBxRPNcZN6ED5rxlyN47eTNEHqTJWF6l0nVtDHK5e4/hE/R6Hb+2I+pVtkzHylTmMkAGMsFzgbYhEDjU6QD6nsALYWG7TeqNYb0SL5Gi0Qy/r2K5kEOfoAXaAROT4sI/4zkWkgGA0dKS4kidtvh/NuCxbpHpVh7uWdgg7HE/emZJNy6tL63OASLDzKK8oXNHnHUe0Xbg5hA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkHG6F8HoUECsw+KAdKe/ShxtV0kGeKUOEc2HWRopy8=;
 b=O/+iTUZn+F8UGA6R6Ndqq45cJvIZJiIJMV98jnygYOio/YrZWkLi1cFUdwE9mBo7AkG2mUXqJa6x9QjljRVA0kMRP+ujtgmi3qhX8ZUQoaiYNaWjJIwPev7BED0/9lSB+qzFKiYcocamp+aYjIda9421aI4fbDkw4XI+ZZIhfUEikGHiSSap13bRVJdtRoKVy1YZUuHxCWFH+X5ubLyEMLr15pbbEGiTK0Tczkaa2mos9m8KHXqLdnYRv+exYsLmPGM686biDuCoWNByV1iyTL0k4B0TV9TwAg0BoMcUAPMUUmsj56LzKFI3L1EObfkQXUQuoVbEdHlL8+kEfWDpxA==
Received: from AS4P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::9)
 by DB4PR10MB7469.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 17:06:26 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::a9) by AS4P192CA0023.outlook.office365.com
 (2603:10a6:20b:5e1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:25 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:24 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:10 +0100
Subject: [PATCH v5 6/7] usb: dwc2: restore peripheral mode on low-level
 enable
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-6-0f197e0e6362@foss.st.com>
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
In-Reply-To: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|DB4PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: d391d788-befe-4477-6287-08df44cd1da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|36860700016|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	MUtI6afrgjdDevvogRa+A78svd92/8Wia1IF4FWtE+fUaN/uhg+ZoVzBDcg86+InZlNiHYJUDziB4rLVLic/YvWjhqEIP6XmtaUvnV6/UoWkAadalc7aRq3kLenfv7ShnFUsjLqOrb9kHZppq+63DhrQJtdMXZR9i1RLnWU8GgGgVzlAtYoVQVwKrBhvyVKg5N7kV0B3FlUMsSDpoZFZ12bTVwPfLxy6BebHPWlMhgDUlgXegm/ZHh0X/TuwR1nW+LEjUcQA40uwav8XT8aONQBfU3tF/klsoFSRx32cGF0EYNAvt+5uidUCWTDQuK0Jsoj5ID1qmWW8ik9CkBf4Y4hR/G8ixUwfGOWYlQJSFIoyZ7o/0HoITZhq/q1kfoPhABCoM2CDpfX1dalCd6slnnsKxB5CkbRXpLXQ6mkW54L1or+98yAcMOy4n2xNIEZy0SQ+bUKLG0xFUXlVwi0J7Wc4FFHFZqm/fA+GGUWtSGC56Quah3OwuVqLE2cYkcOKuDFHObTj2D9fz2rJjg9FMA1x6vfaKIZ6reNvRBEpAn2tfoJrwhtnPfoealNzuX8BsRn+Fm1X0pe0L7HqqOCM3yAfyma70OPVsPTrU6YseQDVouBCxPj5lQVhpMut+pjxZnlWGeDDUde4somrvt1s1XwqYv7xlg4aoR1y/jkd/Xj8TDxVcvQA2B1WEccZ5gfxJaSncTQaJqu1GwbnkWOzBQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RXSoUuPaqi4PI0dEY1MthGqjxq9IrzYq6kMEuDCLlIItyfFIH+28cHKngiNjpMirti6OG7UI7cu8Pgqe8ez1HJRfHmCxz7UQZZR5GIUgJIkfMIBCImB4JQjAsPvaCRKu0kFmVunQ888xRgelmkWE97/kcRXqe5TBI+2/IFqgifWvCR8cqT1yEIAewSIVIJ93xNsD3LceHSOKN/fn1oAb7ozP01yaKr4FUnooGO4kz1QvT+BFpJ/jmoWYYUlZMTQ1p715VsUsyr8E5v1RDu7dcXkOy3iuChBNbX/abhcwqKq8r+RKwTgAG004aPt+JO3iLCdZKNWxyDhTqFvUNYF5zc1Gv+FjUbSbuxuQboh5j/68Xm+pUM60B7GEEesHJSn+RHpw06tClK4XRLvD1TCSI0Zv7BRXlgtz3q0q0RdzVysSvwOFxpZJDOUQWbGAbtup
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:26.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d391d788-befe-4477-6287-08df44cd1da6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7469

When peripheral-only mode has no gadget driver bound, gadget code manages
low-level hardware on its own. If standby loses the DWC2 registers,
dwc2_resume() returns early because ll_hw_enabled is false. When a
gadget driver is later bound, low-level hardware is re-enabled, but
FORCEDEVMODE has not been restored.

Restore the configured mode after enabling low-level hardware for fixed
peripheral mode. The dr_mode check leaves the initial probe-time enable
unchanged, as the mode is parsed later. Skip the duplicate peripheral
restore in dwc2_resume(), while retaining its restore for other fixed
modes and the role-switch resume path.

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- New separate patch added since issue raised by Sashiko on next patch
  pre-exists, e.g. missing forced mode restore in peripheral-only mode.
---
 drivers/usb/dwc2/platform.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3bdb88902811..5fd005e72173 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -129,6 +129,14 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		goto err_dis_clk;
 
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL && !hsotg->role_sw) {
+		/*
+		 * Gadget code manages low-level hardware on its own. Restore
+		 * peripheral mode after register loss while it was disabled.
+		 */
+		dwc2_force_dr_mode(hsotg);
+	}
+
 	return 0;
 
 err_dis_clk:
@@ -743,10 +751,10 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 		spin_unlock_irqrestore(&dwc2->lock, flags);
 	}
 
-	if (!dwc2->role_sw) {
+	if (!dwc2->role_sw && dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
 		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 		dwc2_force_dr_mode(dwc2);
-	} else {
+	} else if (dwc2->role_sw) {
 		dwc2_drd_resume(dwc2);
 	}
 

-- 
2.43.0

