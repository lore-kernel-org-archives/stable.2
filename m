Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986723;
	b=oCYuYoV5500E/3O0bxUatmhfOdEcxL0l5BXg3mPJILDyrUPMJdC6r1P15JU72sLxPtKg
	 pQMr2NBwUwhuuj2kI94a9mPHWZWWNm5qJOO3Cz2sJXwwqUjBuzYjHjFhto+Dw9BH1iikG
	 oBVxD+82qXcBe+cekUixATxpv38xjre3ePoW0gbihd2iCOJVD/yaNGfl2ldTRjkX0DDyt
	 IrK1FdD5ROqazMhPc00uS6/eHegQHA3+TqIQqW/WV7eydspPyQoX1sGCITaidlpU0RcwM
	 FUHn4yqpI4hBS+M9fkXcrKGjSzdHXKIYkVTGVcVlEaUefFhRYPXIjLa9thO4pRIrFyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986723;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=sauk2jgncTFUlQw9lWyHPoUUw7UB2Y95wGIvyKCeTOw=;
	b=siFYlX6uCYD/2R5Kyb6aSgtXqOgNYR+/VGqIz0ggVa3rf7baWr6kk2Ae6sMrvgt21DwI
	 Rf/LuSr4TIDhyUd0RmJRB7igIL2YUHaxW6o8wEuTIkBoEe358rq7VEt/FKA0NNG9TEq5+
	 DIsG/xXux/N6wxns16FL1293HPGhbQ/Bfhxp0daMExDSDeL5tfQyFChaL5c3lhv9WKk0m
	 L+Tm3EF6yBPfupCHDCRd+h9g7n/3WXZ4bc1GGflZdKUt80cHsQA189Rp/URF8y2N9AxvR
	 gzluWq7cqNbvtfC2ozUQ6xbgezSIIF01MRgq4w34NOAFM7F3Qknx4kcDlxdtV9oJidA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=iTJXd1k1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.12
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB62606A326;
	Fri,  6 Nov 2026 17:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB62606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=iTJXd1k1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP0MoWiSC7hoofLZr22k3LyD7t9AI6U6ACKOkpREILAB78zOwdcOckXOegJ9WcHHGIs45ZqTfRcSHbdQZuOwhAs8XlLhkDaWc3T+kel2GE/zyykY1b4fvDdANtH5KdEG83pZLxH0x+IJn/q/FCso/mCOxiO7b7K6ErNNKF2hc78qcHBjNFcvCOL26LcVOMbpWZokCNeknkAjDxumKGURguaX9q3P8UpOYaS3mD93eWcKYRBLYyE3oa3CHs5DVqlmVscjMl868Py+yrhqEdsBnsUZoy4F6g20MWCRfk0cZd8B7IUy734S/nS+Tgs0g2mmOJnwvlQya1AyErK4wF8DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sauk2jgncTFUlQw9lWyHPoUUw7UB2Y95wGIvyKCeTOw=;
 b=EqMXepWFiYAqV+MQVR0qrXNj0yCTvLPNGHkZ48nKGs8SllMfw7++vQmTrznmv45LjfEb7gOZhu8OPLwsJv0fuNDH6ds7U4Bm0R4OcHfWiJB3B+DloAvlGguz5D7z1yfSt/USAQiDxpRsO9CuYsOhrEX5GF6chMNr5kaV/xtF8pbbLdpb3RrDXC3hEwfUtdzEky+wP1salduM/Dk4giQJrPgFehqMyhqK96Fl3s0j1fXVpCendpxTXH+3ZTOLxXsCLOO6ntoEawd6gy1XqxQ1Ty+H3kDvekPaYRiZP7ezyPSrwUyK/HiCaKqFZpDnKh9RYyvDw+PG8lkHc9kF7hgJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sauk2jgncTFUlQw9lWyHPoUUw7UB2Y95wGIvyKCeTOw=;
 b=iTJXd1k1ptPtGOvma82H+u01+H24/euAspECThQ/3RDQTc2nu7+eIhxQox2HmUJOhCsN0S3xQm2zRpfPCcvo3daze1lpe+RkKVYG4XBX2CLQ4RfEvKM2Y/LFVwX3dh0fm6h6UTL/CdwE64c/P06WynsAOIAdv0WsFgsMqOQPZNfXYp9fYF6un3rpRYxTNiKe/THVAvb17kzB2ufwV7P1dabpVoo1CIYphS870yUu5XcZO5NIxuNLWE06Pr9bmx2lhBPl+dTk9YCub6gRHcuWrBrWdZRLTarmDnIDUXYxOi+hdYdUB93u1uGIjwAu4fE898VyhFfjYaY132EaeB4E+A==
Received: from DU6P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::25)
 by AM0PR10MB3699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 17:38:38 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::90) by DU6P191CA0011.outlook.office365.com
 (2603:10a6:10:540::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:04 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:34 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 0/6] usb: dwc2: fix low power issues found on stm32mp1
Date: Fri, 6 Nov 2026 18:38:20 +0100
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAIwQ7moC/32Oyw6CMBBFf4V07ZA+pKAr/8O4gDJIjVDSQdAQ/
 t2CMdENy5u595yZGKG3SOwYTczjYMm6NgS1i5ip8/aKYMuQmeRSC85TKEcj4e5G6NyIHir7RAL
 qGyWBG4EJ6qyQiWQB0Hlcz2F/vnwyPYobmn4hLo3aUu/8a7UPYul9RdmWaBDAISkUV2WVaon6V
 DmimPrYuIYtqkH+wITahIXHIT1kOsn3lSi0+ofN8/wGiH0tkyUBAAA=
X-Change-ID: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|AM0PR10MB3699:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1a8c04-a11a-4051-bb3a-08df3c2cc9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|56012099006|11063799006|261026140227099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261102124527099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	agVI7aRnPxjqZ08havFyQ3vCyBrTcfouNJ9kRtml3nQg7WEINbp7wbND+DInIaYQRxt6aqBt0nSQ7KezVtXzyKZNiDmHUXAqmhfxYPeGj1Dvkt6X+IViEQWPAyIz5TymP2MSMXRQA1SdzhRe5MZTE8w/cWirUbMxS3KO8w9hjuYN3bGQH1/emfc6IDvW4S1fymI+ptywUzcjGkWzsryG4JYLq9gPeL5vPYj2BdjoWfHTapcfUEtqnD8SeRvDEtUEllb6nCGimnoHj9v0gss4JcS50o4fpUBI6vuUMclpmAu0h3wmJJVYlrrXwXBgpL4CHfXeNzkasstSnhdds38RcwZSYAsEq9Y6uRkgOQ8WWJ1W+oNISHxtv/SQHKBxMucWcDWpDjyLC+bvPdKsbCAQHbjvpr1+Xj2z7ij37U2m8lfCZJ5vN4mn+YdWuoVP7oG+J1CSYnsFsS352Ico4dMYQDhNeqQvqnBMHraTfRDTVxyEDK8qZeWo2K5swShAWxBcThmFTdqmBzTsHEwKhGytm2B8lQ31utMEH4nCUP6QPMG+jvX0syNmxmLW7mmc8dvLauJhLvX36T1qKlj1x7HrCiOf0awHDSgMm3fsDdSp/vlZoBE41C7BZezQpnDz4a6/NMGYFxPhGzwai+yF3j6ORg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102124527099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sFmKoIFXmjuEokZjgkEFF0Vq1BA2ciCcIpdilh7Kq8VZ8bWL5hCkiwKIOlb3Z3zzKG88jF11xsy9ayytrCJBpDoMSesfLS8SZ+SOQyghcxVE/C+9hAzjRiU7UCrrlqO1X2LEm54JM9dtOqt0e81/6LH7+tRmrDAT52jGbRCGxgDO8PRQibkU2Et5SJrzczq58JO2QHP9nDx7+WHwgyq0bKrgd7iUeEvyJQ2Nq+qeE6DuxVXq9uBcZjJYxv+Hj70jqlGnHuCsmwmooUizfowFbzKN0k1srmZXJo93RVtBHF9KHTIyXUWpuv3ansVS9wypLcrrY2SYVf5YLQ0pZK234IPKDqQaBduBolBl2WzmyTh8czyLteC62HSNyY8VNtG6tKYM5bvs+9DMZexoNxK8f9CPTQDufSay6wvk37MNX6HA4vOXSIuYkBlvBie7SCFt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:37.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a8c04-a11a-4051-bb3a-08df3c2cc9ce
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3699

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First three fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Update since Sashiko comments
- Add a paramter (need_restore) to gadget resume function based on
  canary detection to avoir possible race on lx_state as raised by
  Sashiko
- Add a dwc2_vbus_supply_restore() to check regulator enable state
  during hcd resume, to enforce it gets restored along with PWR bit
  if it has been turned off earlier.
- Introduced a new patch for a possible race in hcd resume, with
  HCD_FLAG_HW_ACCESSIBLE not being set, but host interrupts are active.
- Refactor stm32 vb/id detection, to rool back in case of regulator
  disable fails.
- Link to v2: https://patch.msgid.link/20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com

Changes in v2:
- Several fixes or commit messages updates since Sashiko review (see
  changelog in each patch).
- Add Thinh instead of Minas to the recipients
- Link to v1: https://patch.msgid.link/20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com

---
Fabrice Gasnier (6):
      usb: dwc2: fix recovery after PM domain off
      usb: dwc2: fix a possible interrupt storm in hcd resume
      usb: dwc2: fix a possible interrupt storm on stm32mp1
      usb: dwc2: hcd: fix possible successive vbus supply enables
      usb: dwc2: hcd: don't disable/enable external vbus by system suspend/resume
      usb: dwc2: platform: fix stm32mp15 detection logic power management

 drivers/usb/dwc2/core.c      |   1 -
 drivers/usb/dwc2/core.h      |   6 +-
 drivers/usb/dwc2/core_intr.c |   9 +-
 drivers/usb/dwc2/gadget.c    |   4 +-
 drivers/usb/dwc2/hcd.c       |  36 +++++--
 drivers/usb/dwc2/platform.c  | 240 +++++++++++++++++++++++--------------------
 6 files changed, 165 insertions(+), 131 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

