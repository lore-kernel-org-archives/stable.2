Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935186;
	b=Xz5u+/z1TOLyQp/i1K//NpNd79cl1YnBnWZOrvj7TWq7q0nd2uZlSG9dptqQ/a8ive3t
	 iUeMzR8EPHwL6gP+pAEvApTH9mSCLz7rKUFkqoUNcKGdnLONjRJJAhxeTfqNGDwifQmc9
	 +QSLhu/vef0bj9AzRugc9QS7vCiHZZWq6SrmcCn4SmTVEHGHPzuORUfJHg931cpYk45EV
	 kx0tAfgYSnNl+NR8gBBo9Fkl2eZxvJyqrEr2Bp6WTb8gAGQq10tns+HpRTnEVPANUZ8Oa
	 I8vR/yIUaTbk+T9svD8YOH0fzW2QTcuuJ6yOfpiPZVeLF7Q2Ky38KGMh2up1FqO52Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935186;
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
	bh=+8835VRJDkUJhdwJ1QgiPtDL3sPUGl2YeuhU0KSf4KI=;
	b=cqQBvwegmz2epmYBz0mV0Ajwv8lt2OmsH3VBHS+rm+66fUwZ4heEGzBy2q0N8KiDs4XE
	 2dlt6kXBCtCIYtqZNz8vWM7nh/pT4zPl2Pw9WsiV3FF8BfOlYgJGlthz0ryEWEnOLxz8B
	 yH54qMlhohBTn/VE4OptCvho+koaROxtFW+OqEixLrSdCiV+97AEAiYROP5pDSLd7Yn4v
	 tVeoh3MSTc25yJoNSuaSsKD4sirCtJYRiPmGgMHDs05yndSiv0Bcam9PNFdaP2sshNoC6
	 X+y8A6racPUf53ViHC1gy59Q4RV5FaduB2AjUtAJXT2uomj8LIMYc6fgbPtUPt2xQVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Qpo2+jGk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F5606A31C;
	Tue, 17 Nov 2026 17:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Qpo2+jGk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpHnkU/t04k/hOcOjI5/pU2prfA0m6Qe+8eOAZi7ntpIc/8Ut2MFJPkOAzy5Q+HaP/ZOfXkK01qiCY+1e6WrA8H2/8kuvhtH47i1UQbER6A0HHN+AZIN5N1jagY+EhXZxMa0STdWiHKxkhV0wGi2ABI77J1T0lnVwrGtqh5SbqP5zMntw7RqSwHTgRM7wBlRCaupt/Bd6M7e9Q32dIAb2k3IivND91Nu57EMbf4P7lzeE+h3ykVROsTWL+V/QVi2raDgOZcBK5gMSFK+OB9++lVf3XSW6n51QOOX0fM+E7wDtSiEelY2ljk94Uk1TNmsrY0yZPj7fCKPB3CH8t1ngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8835VRJDkUJhdwJ1QgiPtDL3sPUGl2YeuhU0KSf4KI=;
 b=dE/fYbGETscjtj3VhpamAdd2q4Iy6Pnhedi4i8CtEh8t0XY2EOOh1lJkVwRCDCIu1WZxVdtag4JUU+nzYiXKvPR9Hbdojbf0a6XTX31PD7yOYEbVQFpApd8frq+RI0iTry5hqB9FiuwBNH1MbtAHFcFxMx177GyrknHir9+oWrq7eR3hAGaukQTNEkF0u52rT1lBECwIykKLp91f4E7Cgid7XJbxkwd+QpYxbXsXac/6O822odl3QkK4hnND91TnvZPozpzgPtjJol53wE/AL9x5NbVOIhj/vt7RoJRG91nOsSVCys2WIvjziuiXrefdV4osjRbM1XDb66MUDZdiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8835VRJDkUJhdwJ1QgiPtDL3sPUGl2YeuhU0KSf4KI=;
 b=Qpo2+jGkbFVVzELw4GYeooW+ouswKlwGwHVnI+MNpOkXxotNT79psfGSGEFSFHmNSr2gmhiT6iUAs6L1y42pEwtmOB7p4rlJfQuM82PQzJlVln8Nuu/Zf04b0DWWNHfaBeJSta09QB7TlxzienSoltJ+xB0ERe6hBdW/U567ILqEu+pIakpvw6t5+TPZqb/TFsZW0Tt/J9N1qzIlgWp7P7AhPwFrpONGOE1/gtrjZTH2/lRMEXlLLwvrgSpbcUEUtszTj7OSn+TGZVp9PIItOiAgGrq/b0VlyFsk0VG+blKOHyXzhn/LIPtR//xi/UbV1TwXDztPAR8MCt8+Xa38vg==
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by PA1PR10MB9004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 17:06:20 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::26) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:06:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:21 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:19 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:05 +0100
Subject: [PATCH v5 1/7] usb: dwc2: fix recovery after PM domain off
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-1-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|PA1PR10MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c2b41d-4d48-4ca7-749c-08df44cd1a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|22082099003|18002099003|6133799003|261009223027099003|11063799006|5023799004|56012099006|10067099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	M6QPRvtm0itZOUgaNETqz0VwClnJUIeB3jyFkgjNV35bPzLP6o+y5zGbXYQmGfI6HnBfd0U4zouSCHvBTJ1ItRh9DMco+sGHKauR5iOeCRx5k8Gk8ob73wlnK7cjwTc0+e1j+bDR4UFNxMrXZ1nMBNjrJcD+0eIPpUJHK0z6+pH0x5mOVhFCE2T7uuyOkMdnyS6R4wiymNVHSArlSggjDC9nGffhViSuVDOb/MwG0P6aIMPrabifD/Im/xfrpUzDggpX2YYKGTmIULS/eV0cC+iuDBwa2bh7+WykT4VmHvnrLyfEMAehBH6ifldLqXjyafLe2TWR2FtjNynGDtbf+PBbMJAS70rHpU/ADya+fljS+sIkUwOGzncvGsPHJGPkHxr4Vm8gbvdcWFyLUjCG/4CuYWnXt42nYUTTQj5NrhIyv2KUijos+l0B0oAaVzHkHmKDwfTNYLSyudY4h2BuwYR0320fTXul/dHnUl9iFdkJyEJrhz6jygc+CPXO7UYWsuA5q37mtVTIvWeFp/IxOw2CrnF7gbdkkjFPIUDUnw9cX0Hh6KpKLLTx9psjdJfQUa2IUGelLm0jHDA+rWL5QwIeocrcUuiGuaRX+kvbRF86gJQWdYT0n0q2C+z23Ofw8N/Zj0DYZo80gJpEjvofuFYGpcIaHdDV/E6lfsemqpStaoypNIPiG65mhsVDtPzp
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(5023799004)(56012099006)(10067099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AXrBwFmVIvYcJFlQg5+dOHemebvvOAyWg2CMD86EYSQzFVUwy5qo6EsX+B74JkfRLrMXqEHoxELlPVSZSPuHc8iLeYWLbHcKXvuo8IU1KaPk1IgKGRXn7kELOB8nVC1ZO/ES7Ep45QcCl4JMVVHPBIeVHKhPMFNV8rkaCBdG4re7n9/iV+ZLi6+LEipxgmZSPWz83NgJSk0xxFLCvBq8ltd4Ei1FRoem9FF76eZSLYXdQ8tZI5EQudRim4MxcLISLZ8ZWuL2KwvntJMlOjvG3xeFFP/5p8I+x78EMX97PRoWuc+RxabcIrIppJuwB2CHTI7WxS8F8muMkwuT5iwJGxtq/xFRrj1/uhYfCP0vbsyiNcHDRkFB62pT1vOeGwL+9WEq2ACfcv1wP9MTXiZuKW+6dxrdTH+bZ/f6PjFu754F2duWBPBlE8y2FbgL/Yl6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:20.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c2b41d-4d48-4ca7-749c-08df44cd1a1b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9004

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

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- Sashiko comments: stale variables in device mode, possible race caused
  by early call to dwc2_enable_global_interrupts during dwc2_resume(),
  drop outdated note from the commit message.

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
 drivers/usb/dwc2/gadget.c   | 37 ++++++++++++++++++++++----
 drivers/usb/dwc2/hcd.c      | 47 +++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/platform.c | 63 +++++++++++++++++----------------------------
 5 files changed, 108 insertions(+), 49 deletions(-)

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
index 6c8a9f05fff0..6a12f00e31ba 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5200,26 +5200,53 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
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
 
-	if (hsotg->driver) {
+	if (hsotg->driver)
 		dev_info(hsotg->dev, "resuming usb gadget %s\n",
 			 hsotg->driver->driver.name);
 
-		spin_lock_irqsave(&hsotg->lock, flags);
+	spin_lock_irqsave(&hsotg->lock, flags);
+	if (need_restore) {
+		/* Clear stale software state left behind by register loss. */
+		hsotg->hibernated = 0;
+		hsotg->in_ppd = 0;
+		hsotg->bus_suspended = false;
+		hsotg->gr_backup.valid = false;
+		hsotg->dr_backup.valid = false;
+		hsotg->hr_backup.valid = false;
+		dwc2_hsotg_disconnect(hsotg);
+		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
+			if (hsotg->eps_in[ep])
+				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			if (hsotg->eps_out[ep])
+				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+		}
+		hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+		hsotg->lx_state = DWC2_L0;
+	}
+	if (hsotg->driver) {
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		if (hsotg->enabled) {
 			/* Enable ACG feature in device mode,if supported */
 			dwc2_enable_acg(hsotg);
 			dwc2_hsotg_core_connect(hsotg);
 		}
-		spin_unlock_irqrestore(&hsotg->lock, flags);
+	} else if (need_restore &&
+		   hsotg->dr_mode != USB_DR_MODE_PERIPHERAL) {
+		/*
+		 * The gadget core init enables global interrupts when a
+		 * driver is bound. Keep them enabled for driverless dual-role.
+		 */
+		dwc2_enable_global_interrupts(hsotg);
 	}
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 
 	return 0;
 }
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
index ef0d73077034..7dec3842ba2c 100644
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
@@ -786,8 +749,30 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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

