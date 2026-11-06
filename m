Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986726;
	b=zeTc/mtu1qRK/iURXDPJeyxIdS8ckT0mcAkieOTTcfLSJMQMaNiTJXeSEcKcYf3dw1cF
	 UoO1jzu7usCVUCn3+A3REgbqJy0DgwgwP5C6o+6I5gRkPhWbWj4sbPzgmup4Wzk46xh8s
	 MIFqFXqXmN6RISW49wA8usbCK+8BV2/9Nf9nqD0qTYFGnD/YJ1vbhRC3jkmCrgrpChFJI
	 YHNN7H9RCJLAe+1fjJlIeDl+nE2pi8I/qK0SHQGpU8u2iI/AhyId9E2gbUDNVok998rNh
	 E2o5ENXOcEEuRaIq9KPhgs1UtLh0co8cmt3LK7nWRyGK4HD/VR+Y2UStTaeZnVfs6YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986726;
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
	bh=GFgOHjpIEKsSYxu06udqHKvuySKrAsLBnYnSf3P9ro0=;
	b=XQu4DEjnYdcYfjnb4Np/XeE8vJYAjVdYTgO1NBCGWkvikDH1PAJ9RpMovVI7ffR9m2+C
	 Xl9Hj/GKcswZ1oC/Lzqqpaq+vL+hrOZ0HxXSH/1ud0/SzG8e1PScdotFWBJX/RuA+r5ol
	 nGiaCtmxc6ROB7I5OFtynrznsTX9MChf+HDzN76L2sJBGTLzNeHLWTZfqXqzszmxRsHKn
	 XDOyBQOuK/jxoGdKS0gMv0qFu88msKtVW0IKqWEM5YP41Box7uh6Dy+GB1J7W+5EEOpqR
	 EZXNWXLdbmhnZIMMMth6DJODwOswnXn13nQUymuG5CUcdsrPgkbPG7nhHb50j3LvJSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hB0CRh8u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.15
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D7606A332;
	Fri,  6 Nov 2026 17:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403D7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hB0CRh8u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMKmXslIuJdhD7IXa9Ry0CyS74Q61LvHtiqZnoOn86t/RkwGNt/tsjqcxdsN7tGYjGO+zoZCKqHihYhunjWnMW3N52BO/XyOPsRTJaM8h+lthSP2AWUCUwNp8BpDGXDYRYr/HxXbVMLQ+xUaumXK8DswBTuQScYbhaEs6/y897k6MRDqMUrVVicr50PSlFndj6LjkTtGlRqIHsRqYYkh3RWDGq4+Zp7KmAft4JgYLrtHMJFUjq3HApYBLJWO85P/qGN5z5WGH6HLdHl8Z+jqoL+prF4adc9yOe+ZtQrmPMPZKleJ/qElYxRa4muiBPNaWVl7ut/x82GyVJ3ozNJhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFgOHjpIEKsSYxu06udqHKvuySKrAsLBnYnSf3P9ro0=;
 b=RzkbYAmvR2Kc01DE3aWG70fKKmyVAfqyyuYWf9k5sdTLxdS3Nb252UiCuhI93QegEod01Ar90KeC7Egw9TEQoPL696yKl1rvCQaDaWdCGqRX1+mAHeXCd6ADERhnW5SS8wp8M3JpBKaBfo75n+4XVpq9xvpXdLY+e0f8SlMQ1TiCd60AaSoqSOsBoCGeMKkZvLX4cSN+NmmqpSbzdfgzqh6US0WjD2fooH4Qwp9r/fi6REA8W7ghPJg9K7jyKmMm66u2q8EOU+7kGXLnMk+W9Gck6aOUw6XI3YQKpG3swjQ4lLGXcPm9ENcfesEH+sJ7EAePdWEXQEmOW+ytzoHUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFgOHjpIEKsSYxu06udqHKvuySKrAsLBnYnSf3P9ro0=;
 b=hB0CRh8uc+zKiLJfTPOmvIa+1t7GB9MrHyjbK0u7DR7xV6x1X2wO6C9lS90I/W4+xDpv/Ysa1HyCTYWcupzwbE+PPBauND1Z3vOuJPSE+OufXJ3580oRKibpuB38Tk6wO5s6XZ49Ip1HFhm9a8cGtLBp5IYkdc5Ip/M3squOzM80mOdyb/7bw6NRqkIFiNN+4O5RnV47WKZgVeTeGTOWXXzTDb7z0QT3FzwW3OXt4jLr1DUYMP/AnIMW/KZHYNJSMAzwnK77nIOyCm0we8SWUPyZNRAcwaw78hgnXDS98w4Xc7WVARr0dsQ1L6akIZ1/tZGPmln3hoAr/1MpWr6r6w==
Received: from DU6P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::8) by
 AM7PR10MB3336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 17:38:40 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::13) by DU6P191CA0006.outlook.office365.com
 (2603:10a6:10:540::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:05 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:34 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:21 +0100
Subject: [PATCH v3 1/6] usb: dwc2: fix recovery after PM domain off
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
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-1-68d2a0e9bab6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|AM7PR10MB3336:EE_
X-MS-Office365-Filtering-Correlation-Id: b6887023-7eda-4c92-778b-08df3c2ccbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|22082099003|6133799003|18002099003|10067099003|11063799006|5023799004|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	1fk10LHz7O21X4PEP/obIfBC/Urx1NpMswQHVEjCsrgxe6F3yq/yMqZhDsBos6BDLt8E4+8nDttgiXjA68SgBPLbBKWiwZFo5t4vboj5iMpObRQ38CRlaSFJ8W6Zg4v8VpgUggQB9u9P+8Hdn7c+lre1sJzGiAlcFKfd5v8yc1wIZFtUkK454qFnYBY3pyRrIxib/UZH+GBCnEQS3+/ekOFnrU4x9JPspyRSemlk6iNehMUUmINrcdNt6Dr0KLpnKP9Rs5M6RpyvpQzvkXR+9DyQEkR2DPRE19iapNLdngMcqbe3c/U7JmBiOaPL2WOlzKj68g8R/jVXzLclugy/3alKSL5yYN7SZgyW4tBPTUB13ytEMaSXahXKh13OXhqtEyg0RD73QNfyP4d8kaZ11M2MDf5xpBAHFcDQ0tMCWFH52nunfartG1W2hzzU7RxM7BCgO8FWjj38KrxEDxA0G92qsUR8iDvhbKBEmEO8r2BnC5sdm3QUeWPyJfRHH8YY5H7rDYS/TTPVtAHJYRSnqGgFHQYHVo/wmck/PS/XXIU3nwjgRG1aRyam0n4ZftNfBElSjPbwGKksj4c6+bxKxXtcyu4YLGM5gSbtuj6WZmr63SuVpxWTrVk4i1iwNm/ySmNDntiMVhKcpA80kiVGDhTriZcKkUIUyUAhuKdAJgSM1hwsA5gthh/4vZpO89iL
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(22082099003)(6133799003)(18002099003)(10067099003)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LFD9i29iuTW9sq1sC3bASfx9/ET66cbgAwR7w1sCNZ2tEky0P+0o3rdpw/APLYpBM3RTrn/0UZtoa3b7ToyN4MKMWOwWa6W+1bVgMF/Ho+Lc6QgQADDfDqNYsGFXUtR40swo0FU8hsW/PzrSYxor/iWRTLbHCsp0YTXjkAxgMPItpdoKcb0SEqgexX6HiwnJ6kEd/sugxcrR1iyFzTNs9dUsqDNfSDFdI86Fuur/ZhGZnKkaRL3v3lECHZJcLrtIC/bUkjNApkAJxdP7KaUxc+Tso614dMiPk7dG2LHCHoHhth6PpZgrT+OUvWHyCs5Qcj8hvFuSPNFD3pvZz6a52fcEnCY343/WPFKudUHwugRElkPO48kl11962/326i9f/my5IpTJOSuTUjXF96EGfAJoLZhMaa8HKy4ojKXbxNsLsAxmtxUYvchsUiy4g/g4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:40.6845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6887023-7eda-4c92-778b-08df3c2ccbf5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3336

The commit ba6e518d136b ("usb: dwc2: Implement recovery after PM domain
off") introduces a regression on stm32mp1x, which freeze the platform
when going to low power.

When the controller has been put into clock gating, reading some of
the registers to backup them from the suspend() routine in platform.c
lead to platform hang.
On stm32, the issue is systematic in host mode:
- _dwc2_hcd_suspend() calls dwc2_host_enter_clock_gating() every time.
- dwc2_suspend() calls dwc2_host_backup_critical_registers() that freezes.
This may happen in device mode too, if the host has suspended the bus.
Then clock gating has been entered, before calling dwc2_suspend().

So rather than backing-up registers that can lead to freeze when in
clock gating mode upon suspend (to restore then later):
- keep the canary detection logic (GUSBCFG TOUCAL)
- move it after the host/device mode has been restored, e.g.
  after dwc2_force_dr_mode() or drd resume code
- re-initialize the core as done during probe, when calling
  dwc2_hcd_init()
- re-enable the global interrupts.
- add a need_restore parameter to dwc2_hsotg_resume(), to re-initialize
  the gadget in case the host has suspended the bus before going to
  low power (in such case dwc2_hsotg_resume was a no-op).

Note that when in host mode, and the registers have been lost, the
HPRT0_CONNSTS bit remains cleared, until the controller gets resumed
in _dwc2_hcd_resume(). So the resume code isn't skipped and the
registers will be restored.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
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
 drivers/usb/dwc2/core.h     |  6 ++---
 drivers/usb/dwc2/gadget.c   |  4 ++--
 drivers/usb/dwc2/platform.c | 58 +++++++++++++++------------------------------
 4 files changed, 23 insertions(+), 46 deletions(-)

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
index 015a5fb7842d..1fa872817aa3 100644
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
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 6c8a9f05fff0..99463e65d5b4 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5200,11 +5200,11 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
-int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg)
+int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg, bool need_restore)
 {
 	unsigned long flags;
 
-	if (hsotg->lx_state == DWC2_L2)
+	if (!need_restore && hsotg->lx_state == DWC2_L2)
 		return 0;
 
 	if (hsotg->driver) {
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ef0d73077034..b65b9898bac0 100644
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
@@ -786,8 +749,25 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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
+			ret = dwc2_core_init(dwc2, true);
+			if (ret)
+				return ret;
+			dwc2_enable_global_interrupts(dwc2);
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

