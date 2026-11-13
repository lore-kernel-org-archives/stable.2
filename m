Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595705;
	b=mGEw9vzcECKtDHRUK6KbuQ9u+8xTaprZDNcsoP4hTEVwJnPmH+fIyKJrH/5VbrBjysaM
	 eLaClZa0Vh6btGuY/njR58aV34zR60RWqih3NQPTOtHXilS3tjCeWJClhNWzuWNfmH+Ju
	 Bc53SryUmmDTGT49qSc9eDiAABlP7lxPHkmlUHrYXcyiHJjF1VZUuMbom5woTN6dKug3N
	 bR0YiOF4Qs8QLTfWTcG7UqUaZGstPOnoC7D+L3tiVBd6l6w+NoYQgW7CFY3zByvC6E82a
	 r21243/2ExnS6oT8NtlT5js3xX1hOOGaIVaQAH1wlkoj9BaMHzUb+aicUWb3rHk1udw==
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
	bh=Tjb2SDJ4c3MFXsBPYGdp8hdKSWJ8j6Lz7LExoj8i2w4=;
	b=nGC9GXybecp5eWO7RM56wCfKkcL3Jds644aCpYMyqz1wdykK9IgQ9dH1dHA0QeCIJQWi
	 eJa+TNWC5X0E/g1Yact2Foyt5cazo1GmMYQtMaFS+FG1mHno3qgMbp0vn2pregzgPHNZD
	 x1qmDwhkJpFRU/+kNR3dwQDpIsyf4dTzZ75VOY35++AFWGlXhK6vWk86tSHoUq98jpNn0
	 MsXSvJRrUQUtB0k3SvEB+42dSdZnPSLlTJ972H3LOBn7iN/XSIDurA4Y03RJcnmu9XJ4I
	 rgGBn8N+O01tg7H9BMdR8wu1ZqnrI9F8SOEc/HH/UHYseFgnawA1+PYLUzO5wxbuPag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=U7ELOnMb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB5606A88E;
	Fri, 13 Nov 2026 18:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCB5606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=U7ELOnMb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNa4q/CcgNCEcwAc3W+ZaAPq+/X4SezYn1xwTK+G4nOWI+IKoqNkRCSVYQ9HjVk7WDGaBjC75XLbReCMqz9YvBwTm/WAxUcHkQRblxVilzCEQXfvzkLOp2htfLFM2SoX2L5xa3X7fSTH5wCmFEq1aKeIJ4X57CEmCHsknVLjnOumo5cVNawJWgOgj92ObqSEA62J7PaQbBKv8YuPth2m+dUb35lncueXYBP1rfJomui7jRvNkVwySzv4LW6jEZ2P3AA7ewbt5WiAryH1CxgUCvozgFbXCgf9WdijeOrbDhypMfe2u5dVQDFy4WATMH/gHIF0970ENIZ/zvhwa/MKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjb2SDJ4c3MFXsBPYGdp8hdKSWJ8j6Lz7LExoj8i2w4=;
 b=x1Wsiq4eKtrAMaUxkDc9RI4vzSmN5olGmvGkjCeiHEQXhOwwIaeZDgYXTQ8Cq4S9nPpzTEtr6E0aVTzBQpYk5xJiUIejv+4d1a7s2S+jIOWNkBHIpYodxdtc3XQpvze/Gr0PBx1m4rgOrSl1QpdlcI6zJTVtcizaPoj1NHqUmk/yrFK2WuyLL1G3/MZQRHVVAyKUCIy1NcjFbB3pfIwAZikzhOzQs8b2yVRR+ed4qaJFxbvjn4INUn1cnVu/l09Dd5ULGDJy7A7JgMY1/hxBmZy4vKaFLatSwHJg2fX9DUzkOdPZCuo+cq2Kj3/Er9ZP6vjGqeQqwuMqDwqwtXSkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjb2SDJ4c3MFXsBPYGdp8hdKSWJ8j6Lz7LExoj8i2w4=;
 b=U7ELOnMbdBTqJdwmyEcK9nUFwA8le78VblD2QjjjdysCaZhYa3vvNb7pLBOqVZnJP6+S456yTV5fYe8R0jQCfy7EIVxHfVfQ3/4ab2u0v7PFqgZoYrT0jIFVRmWFZBjJfou69dvrPmu+Na8331EC+ShtUuS4x4WCSZ7hhDxLnW3vTKWAgxXiCuBFEi8KMiUanRwJUgr8rkpZgRM41M5nTomKyG36Fu8i4HfP+hCsXuJRagYiaz0uraGgClwBC41u2qo/g/08q8SE9YAmJAAN5ZI5a7I8A7eAqoIbNtFDFPxz3xQWE+8seWpseDQ+J+abV+O9n4OXAmPPezhxqPI77g==
Received: from VI1PR09CA0158.eurprd09.prod.outlook.com (2603:10a6:800:120::12)
 by AS8PR10MB7019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:48:17 +0000
Received: from MI3PEPF0000847D.eurprd02.prod.outlook.com
 (2603:10a6:800:120:cafe::75) by VI1PR09CA0158.outlook.office365.com
 (2603:10a6:800:120::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 18:48:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000847D.mail.protection.outlook.com (10.167.240.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:48:58 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:15 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:47:58 +0100
Subject: [PATCH v4 1/6] usb: dwc2: fix recovery after PM domain off
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-1-08a8c962a09e@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847D:EE_|AS8PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 6864ee22-8569-41df-2530-08df41b6add4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|7416014|22082099003|18002099003|6133799003|10067099003|261028144727099003|261021123027099003|5023799004|11063799006|261022075727099003|261026121527099003|261009223027099003|261026140227099003|261021121427099003|56012099006|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	5JC3qprsOZ+Dm3FDjwjF6cC4puZrbXFYVus9T3/bZ1O/Q3FmDUJIhQ147t3DiqSJJashfWNXzikmewyWmYDWQDF9R40dSphlna4/CjRtfc8gr623CgPttBwSPzCRpGyvw+bgZTgizm5a63GKp6OiM/uN+zVP16qmA2f6mQc9OVBo4Syym33oSMin/fCxM6cRu0LTmSrtUw+x4s0nAmK9W5XPWwb8M0K8PjFP47pvq86KDQ804qJQ8la/LAMjXWAmhqmmWDzFD1sVgC6fWxMtdp5Ht1PIXyBaCfopc7WrIMLF/ETp+9YAto53l2en0aMpUZAHHlgKiX99EO++H1L2F8aqKD1DKs8OlK7thH2bqRKR7V+4mptCiUKF/QNU50dJwLTCeJthPqNqnB1ImNF2R8ruHLN6kMEFtOJnDDR9+d/mXtYbCmr0agc0LDK0HYXmgH//+xumKYildFxMbJxO/GayzTmyieOt0fSQ/mG1pv4LVqxeO+YupcW7ULl166RC7dsWRrmZPOt0w8woccSWxNS/vzJHOhc4ZXx0E5PSEuAl6qRrxP6WlkP0jX/t/M50p6xhd21su4Wkc9jGmtUBldWzqzrSjbY0S9SI4VCZxl1QFNDgWc6dLMmaxQuXCYnHM2u+i+TvVwVSABOh3j0Qvxf2+CFdzY5FklAWHMi506lXcvz+CdOLjTXwF0RRAuzW
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(261028144727099003)(261021123027099003)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261009223027099003)(261026140227099003)(261021121427099003)(56012099006)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	caSNAXcsfgrgopNRwFKv+KYWp3XRnx5D6pCuj+8/VVkxwNRpunhWRSozieNNLfI+94AInX5Dy+f2UqdoCwae7xxIFnp0VdmFlDi0KWe8uiPlyfvwi2kcrYBrm4DXsQJsvvkXzkQcB8eYA34YHi7MlRJWbIdo6LqKapm73zTMS6P5ryk1SqbOgb1yCmhnxQBAnpycqfI/OMWJ7jdQsXX1sQhg47MvwzA7hwPXI4ovK+ZnbJ4HzD0rrDtdwQa6uNvcv8sCjosbbYtIWLUlOGnGvscrUjnmmpkpIbgX8waXK0hqqFO6jdbxIfdbuPpz1Xq/KTVtL+xraFjBVryJ9glkKuVBFIhZNtAwiYz56UdC1Yc8mdrjoiiYmogKsQqpOcN66mcC4RjdY7OERvXMbfq8mPMzIRiB+Bl6vxsr+nGj0e8nzllXLDu0Vf47aTbBvz2V
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:16.5428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6864ee22-8569-41df-2530-08df41b6add4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7019

When the power domain containing the DWC2 controller is disabled during
suspend, its registers are lost. Reading registers to back them up from
dwc2_suspend() after clock gating can hang STM32MP1 in both host and
device mode. Host suspend enters clock gating directly; in device mode,
this can happen if the host suspended the USB bus before system suspend.

Check GUSBCFG.TOUTCAL after restoring the controller's mode to detect
register loss, then reinitialize the controller and role-specific state.
For host mode, reinitialize the HCD, discard stale register backups, and
restore HCD accessibility after setup. For gadget mode, force a
disconnect, disable non-EP0 endpoints, clear stale low-power state, and
mark gadget speed unknown. Pass the register-loss state to gadget resume
so recovery also runs when the host had suspended the bus.

Host resume observes HPRT0_CONNSTS cleared after register loss, so it
does not skip the recovery path. Ordinary resume and USB-reset behavior
remain unchanged.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Disconnect the gadget and clear stale endpoint and low-power state.
  Sashiko comment "usb: dwc2: incomplete gadget state cleanup in
  dwc2_hsotg_resume()"
- Reinitialize host state and clear stale backups after register loss.
  Sashiko comment "usb: dwc2: incomplete host mode recovery in
  dwc2_resume() after PM domain off"
- Revisit commit message

Changes in v3:
- Add a note in the commit message since Sashiko comment on
  _dwc2_hcd_resume() check on HPRT0_CONNSTS bit.
- Add need_restore flag and pass it to dwc2_hsotg_resume() to avoid
  possible interrupt race with lx_state update as raised by Sashiko,
  instead of updating lx_state to DWC2_L0.

Changes in v2:
- In case registers have been lost, ensure the device mode resume takes
  place by updating the lx_state to DWC2_L0, as reported by Sashiko. Note
  in case of error in dwc2_core_init() choice is made to leave the low
  level HW init, as it is the expected state out of the resume routine.
---
 drivers/usb/dwc2/core.c     |  1 -
 drivers/usb/dwc2/core.h     |  9 ++++---
 drivers/usb/dwc2/gadget.c   | 18 +++++++++++--
 drivers/usb/dwc2/hcd.c      | 47 +++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/platform.c | 64 ++++++++++++++++++---------------------------
 5 files changed, 93 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 6a0135e06b00..50627c2baf1d 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -43,7 +43,6 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg)
 	/* Backup global regs */
 	gr = &hsotg->gr_backup;
 
-	gr->gintsts = dwc2_readl(hsotg, GINTSTS);
 	gr->gotgctl = dwc2_readl(hsotg, GOTGCTL);
 	gr->gintmsk = dwc2_readl(hsotg, GINTMSK);
 	gr->gahbcfg = dwc2_readl(hsotg, GAHBCFG);
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 015a5fb7842d..32662cb3d3eb 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -668,7 +668,6 @@ struct dwc2_hw_params {
 /**
  * struct dwc2_gregs_backup - Holds global registers state before
  * entering partial power down
- * @gintsts:		Backup of GINTSTS register
  * @gotgctl:		Backup of GOTGCTL register
  * @gintmsk:		Backup of GINTMSK register
  * @gahbcfg:		Backup of GAHBCFG register
@@ -685,7 +684,6 @@ struct dwc2_hw_params {
  * @valid:		True if registers values backuped.
  */
 struct dwc2_gregs_backup {
-	u32 gintsts;
 	u32 gotgctl;
 	u32 gintmsk;
 	u32 gahbcfg;
@@ -1415,7 +1413,7 @@ void dwc2_dump_global_registers(struct dwc2_hsotg *hsotg);
 	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 int dwc2_hsotg_remove(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2);
-int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2);
+int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool need_restore);
 int dwc2_gadget_init(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 				       bool reset);
@@ -1451,7 +1449,7 @@ static inline int dwc2_hsotg_remove(struct dwc2_hsotg *dwc2)
 { return 0; }
 static inline int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2)
 { return 0; }
-static inline int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2)
+static inline int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool need_restore)
 { return 0; }
 static inline int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 { return 0; }
@@ -1502,6 +1500,7 @@ static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg);
 int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg, int us);
+int dwc2_hcd_restore(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
@@ -1529,6 +1528,8 @@ static inline int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 static inline int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg,
 						   int us)
 { return 0; }
+static inline int dwc2_hcd_restore(struct dwc2_hsotg *hsotg)
+{ return 0; }
 static inline void dwc2_hcd_connect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force) {}
 static inline void dwc2_hcd_start(struct dwc2_hsotg *hsotg) {}
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 6c8a9f05fff0..225442471aa9 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5200,11 +5200,12 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
-int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg)
+int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg, bool need_restore)
 {
 	unsigned long flags;
+	int ep;
 
-	if (hsotg->lx_state == DWC2_L2)
+	if (!need_restore && hsotg->lx_state == DWC2_L2)
 		return 0;
 
 	if (hsotg->driver) {
@@ -5212,6 +5213,19 @@ int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg)
 			 hsotg->driver->driver.name);
 
 		spin_lock_irqsave(&hsotg->lock, flags);
+		if (need_restore) {
+			hsotg->hibernated = 0;
+			hsotg->in_ppd = 0;
+			hsotg->bus_suspended = false;
+			dwc2_hsotg_disconnect(hsotg);
+			for (ep = 1; ep < hsotg->num_of_eps; ep++) {
+				if (hsotg->eps_in[ep])
+					dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+				if (hsotg->eps_out[ep])
+					dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			}
+			hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+		}
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		if (hsotg->enabled) {
 			/* Enable ACG feature in device mode,if supported */
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index d5275cd658d4..3f9adfa7c630 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2302,6 +2302,53 @@ static void dwc2_hcd_reinit(struct dwc2_hsotg *hsotg)
 	dwc2_core_host_init(hsotg);
 }
 
+/**
+ * dwc2_hcd_restore - reinitialize host state after register loss
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int dwc2_hcd_restore(struct dwc2_hsotg *hsotg)
+{
+	struct usb_hcd *hcd = dwc2_hsotg_to_hcd(hsotg);
+	unsigned long flags;
+	int ret;
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	dwc2_disable_global_interrupts(hsotg);
+
+	if (!IS_ERR_OR_NULL(hsotg->uphy))
+		usb_phy_set_suspend(hsotg->uphy, false);
+
+	ret = dwc2_vbus_supply_init(hsotg);
+	if (ret)
+		return ret;
+
+	ret = dwc2_core_init(hsotg, true);
+	if (ret) {
+		dwc2_vbus_supply_exit(hsotg);
+		return ret;
+	}
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	dwc2_hcd_reinit(hsotg);
+	hsotg->gr_backup.valid = false;
+	hsotg->hr_backup.valid = false;
+	hsotg->dr_backup.valid = false;
+	hsotg->hibernated = 0;
+	hsotg->in_ppd = 0;
+	hsotg->bus_suspended = false;
+	hsotg->lx_state = DWC2_L0;
+	hsotg->flags.b.port_connect_status_change = 1;
+	hsotg->flags.b.port_suspend_change = 1;
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	dwc2_enable_global_interrupts(hsotg);
+
+	return 0;
+}
+
 static void dwc2_hc_init_split(struct dwc2_hsotg *hsotg,
 			       struct dwc2_host_chan *chan,
 			       struct dwc2_qtd *qtd, struct dwc2_hcd_urb *urb)
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ef0d73077034..72214593f431 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -692,14 +692,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 		regulator_disable(dwc2->usb33d);
 	}
 
-	if (is_device_mode)
-		ret = dwc2_gadget_backup_critical_registers(dwc2);
-	else
-		ret = dwc2_host_backup_critical_registers(dwc2);
-
-	if (ret)
-		return ret;
-
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
@@ -709,27 +701,10 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 	return ret;
 }
 
-static int dwc2_restore_critical_registers(struct dwc2_hsotg *hsotg)
-{
-	struct dwc2_gregs_backup *gr;
-
-	gr = &hsotg->gr_backup;
-
-	if (!gr->valid) {
-		dev_err(hsotg->dev, "No valid register backup, failed to restore\n");
-		return -EINVAL;
-	}
-
-	if (gr->gintsts & GINTSTS_CURMODE_HOST)
-		return dwc2_host_restore_critical_registers(hsotg);
-
-	return dwc2_gadget_restore_critical_registers(hsotg, DWC2_RESTORE_DCTL |
-						      DWC2_RESTORE_DCFG);
-}
-
 static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
+	bool need_restore;
 	int ret = 0;
 
 	if (!dwc2->ll_hw_enabled)
@@ -742,18 +717,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	}
 	dwc2->phy_off_for_suspend = false;
 
-	/*
-	 * During suspend it's possible that the power domain for the
-	 * DWC2 controller is disabled and all register values get lost.
-	 * In case the GUSBCFG register is not initialized, it's clear the
-	 * registers must be restored.
-	 */
-	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
-		ret = dwc2_restore_critical_registers(dwc2);
-		if (ret)
-			return ret;
-	}
-
 	if (dwc2->params.activate_stm_id_vb_detection) {
 		unsigned long flags;
 		u32 ggpio, gotgctl;
@@ -786,8 +749,31 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 		dwc2_drd_resume(dwc2);
 	}
 
+	/*
+	 * During suspend it's possible that the power domain for the
+	 * DWC2 controller is disabled and all register values get lost.
+	 * In case the GUSBCFG register is not initialized, it's clear the
+	 * registers must be restored. So invoke here the necessary init
+	 * as done by dwc2_hcd_init() during probe.
+	 */
+	need_restore = !(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK);
+	if (need_restore) {
+		if (dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
+			if (dwc2_is_device_mode(dwc2)) {
+				ret = dwc2_core_init(dwc2, true);
+				if (ret)
+					return ret;
+				dwc2_enable_global_interrupts(dwc2);
+			} else {
+				ret = dwc2_hcd_restore(dwc2);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
 	if (dwc2_is_device_mode(dwc2))
-		ret = dwc2_hsotg_resume(dwc2);
+		ret = dwc2_hsotg_resume(dwc2, need_restore);
 
 	return ret;
 }

-- 
2.43.0

