Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468074A5C4C;
	Thu,  8 Oct 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466468; cv=fail; b=j3XFcAB8GkdE5DjPOxPz1u/Ylb7wogiq6+nnPXeYjMNjhGoatsq9rkUTDsJr+no+HxO3cUiP0ikNdfXPyBfvDgNaSWJnR7+GLokbZSkTbnQlb5d5toEZ+PcsAC9SCx+tTUPi4LNZt9m/3zGSbDaO0JP91ovmRMno/tmGOkmvKFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466468; c=relaxed/simple;
	bh=1d/QmRQllT9fEgJhrLLpMS4XrNZ232BvwEmIvdMkel4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fXVNZ+KTPH1GAnOEL6/TtzB0jy9JsO/PM10E7j3R/XQCzg+T/YNBUng8v1MOtrhTcidCmuoI1OSfDxnXnUWSs+J/YyaZQLALpLxk8+4+Xzs3m8bASY2gHb+Z8Btw+okHyTJDFj9QS+D/P/niL2z54797qTjtwkwiyEk+MEHEDf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Re031p/a; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Re031p/a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WflrPL6s01cMXANCmNtFXeKztMF7Dx/ltvbFjHHmu+CK75v5tt4NWvPxhmFxUtYmYHupzt5jBzRb9PfM9ERUh5iuudl9/AVIiOkqhX3scoToWiMdwRNeATy1g1ak0lHlVd8h+xCNliJpEz2QEp4Ki8zLZDz3vgMAclKqLvALuM0aKD9GGJzNDMnKwSF+MEooHyl5oqlXyjythzSif+xsxPyHiyHJZpfD69SplZcI+DZgzRz9DOpI6mtQdryOyCyg4BowM9cxaChU9MOjjcQJtHURP3KO7u3h3Ol0IFk8PtqFQnI7VY4vOZg1/Y0FttYkWoBjhXPJDqZPpb83I0Jmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGWymQg8FZZ2pr1ga/o2A64a2oR8x6TLMJp+c8c5kvc=;
 b=vVD7TQnx9cMSRfbXTwqJGdsg0qLlF6T0eaSJVvcKhbICrAOqoNaiENT9YwLTYHJSHgYzUVvxf87shZmXH2dTNTdBq8BnvwahG+DgRDg94OxqZqpkxz2wZbJIHYuWyvbXkzS8yabi0mDpZ6LfvagXr2UAhFt/JGmg/r2wvTcKP9FbeLQYwFLcBgmQ161b98Adl2uFgzPqAUqk3CrkHCbejHo0R4H8aNJXnip8yd6oGf0JLt+cDdHOFXOj/B3+fotwp62o+MfSsxUxALchoJVhSEC0oHbo5WS0oawf+eYZ2JZ9sGOJkW2H/3GG7+dxymxJhF+ybJJj6LDlgH+EFus/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGWymQg8FZZ2pr1ga/o2A64a2oR8x6TLMJp+c8c5kvc=;
 b=Re031p/aRltzZbyCgekNuEGlyre+6BPn4g0wqIeUHC/VEAIpYioESwPUfsG9AK1w1MhAC2JDxe8YTvQDcGbzUbqg3mvXfaFTcp72iGDuJ+KyRufos/I7KLDZOm4kgTzZfcUw1ufJNG1NWY1SI4B5GGutllEc5pbfufTvGxWKejFyXepxkuSpyq6WUfI5U8AiohqBvLCHDyNATqfHd2HdrFNKzcycwYX714FmkMJTFzuTSSdM+DCzrsE723nPxtejvJv3Gi1hfHJj2Qj9sN+Na2UYRKoerUS70DSfW8oE9wM2UtvcIWeoiHgqIb4/xG/nHMi5pio9FohTHrC+CYWXoQ==
Received: from DUZP191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::25)
 by PA2PR10MB9080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:34:24 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::79) by DUZP191CA0044.outlook.office365.com
 (2603:10a6:10:4f8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 13:34:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 13:34:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:41:07 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:20 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 15:33:18 +0200
Subject: [PATCH 2/5] usb: dwc2: fix a possible interrupt storm on stm32mp1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-2-5b303df762e6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|PA2PR10MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 85425bd1-c91a-4b94-ead0-08df2540ddd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Cwg5eSOyABmIsuGzdXV8qo73aVF7uMaheoyziiIF6wyDdzjBSh/cCVmeidFB8s6mAAdZWX1+gyL0+h9qOyA6T8LHXPo5bOZFOmMAxIiK92XBssXag1GtxJsqktWbKNH+kojGK1WFzU3YpLDQtYZ7+q4vYDcBYEmaSmGRMwJDxSWYrBwd0P6DuGaA9cCsUyTS54sPTRn6P++s7/nBzP4Nko4ab+Tsh2Vh7UY7UtN1EjabaU+CRuCfWRmosIP7mqbCtm+7Rx8haCOs18AAej2qIDShS3y/+Uq3syTlDz6U96C6cO8yDCDuwwHZL7D0N9lWAdPXZ3lQa3nnnMBGakWyuBbRPdwxQjEApbzMXvjGOoOuES6xV2VuKyEWS5+tY2AeOuFA9rxQOiVzQK7uH/eXITW+Ab883jmth+KX0Vt4IWGjMRsXrrtnCTjrcrDzXAwWqbgt+4XW0itJU8S94CzgYcZViUBANXQjO4j/3Emm3wt6ib9GglzQsYY1A6+09PQMmzd20M+iqmcb9dY44wAMIUxsDrC5Vm0vCUuvZIrCNqS48Tp8bUg9si8cRgZhvnW8HPFvJ1YT/cKHFq2REvCThTVUo4ja7ExrO50G0VcVABcEH+mXDaJte7IiYYa3+l0sqDaYtBMOC/dT9fjkdoTWzLAH0u91gGQLPVDJ3taDaO+xXgfEwb6P12oqYcdD2vNjmwAfYe/zRrU8Ygnv7VDfX33ti7H4yY7ifLg7CI+YWhTDvKXjySEM3CePKw0QYRes
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JOky9MgKkENEqX5BkX/vNTW/rIHVv+PqtKGoKL3FFgzUMnPmjxmCYiZ60rthqPgH3nQPA+jdFklJWaSJJW3B4tpGxvJMAQCtvMNC6CztsWav9MrmvrtUVCQqiLNE7ldcXycmutLgR4H0YItQoPP0FHQIbtq/mBYl61NCjVZbOkKlTFhm48ks8RQSjrhyoOeRpUZl624BbERiSdu8Cvj4Z8d/YDKtJHNqDPgiMDFxurxF7BEcfNqs0vDm8SwkIGK7LpLqApFNbw/I0ApFKtESxEi4p4BZCQGWrCWM1YXWgHOcpEFdBZCr2om+hb7a20ScQ88aOG6bsFZav+aezxSH54izloPtLVHbXYgtsrMr1Lk6iTonBdE9BkuZCOqZZOdMiL4Cin9X4ikFNeGY9yHTdQYTOeZJsluZcmRURH2jH20DlEc8DCKYlTP2Fd5NKkyK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:23.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85425bd1-c91a-4b94-ead0-08df2540ddd4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9080

On stm32mp1, upon resume from low power (stop) mode, in host mode, a
port interrupt storm may be seen before the hardware is accessible.

The core is able to generate interrupts during system resume in
platform.c when calling dwc2_resume()->__dwc2_lowlevel_hw_enable(). As
the PHY and clocks become available, a resume IRQ can be seen with a
Host Port Interrupt (PrtInt).

The wakeup interrupt handler make the controller to exit power down mode,
but the HCD handler returns IRQ_NONE, due to the HW accessible flag has
been cleared in _dwc2_hcd_suspend() earlier. It ends-up with the bad_irq
handler.

So set the HCD_FLAG_HW_ACCESSIBLE flag when the resume IRQ is handled to
exit from power down mode.

Fixes: ef5e0eec4764 ("usb: dwc2: Add clock gating exiting flow by system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/core_intr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 9565e6a52725..8f83c36d002d 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -453,6 +453,8 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 		}
 	} else {
 		if (hsotg->lx_state == DWC2_L2) {
+			struct usb_hcd *hcd = hsotg->priv;
+
 			if (hsotg->in_ppd) {
 				ret = dwc2_exit_partial_power_down(hsotg, 1,
 								   true);
@@ -463,8 +465,10 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 
 			if (hsotg->params.power_down ==
 			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
-			    !hsotg->params.no_clock_gating)
+			    !hsotg->params.no_clock_gating) {
 				dwc2_host_exit_clock_gating(hsotg, 1);
+				set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+			}
 
 			/*
 			 * If we've got this quirk then the PHY is stuck upon

-- 
2.43.0

