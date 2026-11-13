Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595701;
	b=5G2xeMDYgwGmlfcSOhhqVB/tnokwjYVWB+/qtAhfmAJyAL/jQq1J9eTcT//S+5oxwsdj
	 6hdDamfMh7lsbo3nWOV3ZKa1jpQxxZ7jMfU29mRgLsJ3TTJqczM4jV2XkxQspZsdFbzXv
	 EZFIs8NCMTJRh4Bk6grS0cc8E8Do0Mye2l1H2WGQosWD6MfXvQcHAWhs2mJwNxlGKPStA
	 FX3ir0UnTOwU/jCSeyv/KXeznzNMGmmuwQ1HsNcY34WlkMwOxEXv9uFodnpyrmLqCXUE9
	 auT7A3AHNeZjFzOFXH79MDBljQOKlebdqw7fVwVT0mBlojZHZbUIuiAVuR+DUvB7BLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595701;
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
	bh=dDmQTIwba6bdXjZhoRKCz0rLXjsoHmzFVXCJE/cHIeY=;
	b=rspjvyuvYH4GWQsDfaalvJ6ZyKcoa/Q6hcCGaafEOVTeJA9DH68Jcn929fgPe4oMa+at
	 VgKrTXa3FDo8QPfAvWsPrKIhQh1JDon1EiRsH1hQ59zjmjXgfqc2A0iWgjVdbdBZvUVK1
	 Z6bJsmL5rMPegcindp3vmTV34gD8xpZ7uaao9ieqZ+C6NI10lNG5Q677oAOXDdJna0gIg
	 RYYlM/0AVibNjMt/Oqb2Cbx6dflzgNVQEwKxvxkR02F/xUwE/B6XDBMy0dY6EGb80gH+4
	 egvk09hr1El2DahFmPk8SpUwPvD/pgCvDfrTwYi8TSCIMReS50nNcVw5I+7V1Ty7avg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gf7HN4nf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.11
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7C606A32D;
	Fri, 13 Nov 2026 18:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E7C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gf7HN4nf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQK44H8UwAu8P3hJuAxLsyKDOpS86P+t7bJp4hIp+YYKEXHaCtaq2SX0AgvH+w5NFhwAoMf2KEOEH+rId2i/oHxxNK6JJr+wOKkyipw76VmKfVRSGjbmxWSWKMwXcdRUCW2kT0zIKd61rRH0iU2gU9aVa6hf/fDc3AYtRoFzoMhZnm5qDkQtBSnzfPD/rhHJlpdLQPD/svIJRq8vZ4uIPhZoBONGtJF1WpvW2bUPWIEUjEGAiWesyrb1FcFkZDtNoaN7qERctEnUeMPckCZ7CSx6qRV0eWBZrfSgGQNTw3L/8TYbIb3UH1MIuiE7o9UgxITcVceVSv5/qHpIiVymEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDmQTIwba6bdXjZhoRKCz0rLXjsoHmzFVXCJE/cHIeY=;
 b=BLsRM372R/ZxH0kSneAzbBvRj+YuB/+v26Y3N/ZQAfWFVg3TRv2G+hkQSKI2hXTCoT/KlwHxvO27connfUVnj/ObKRwbjDWkkfsINIeHGkfKHsqeQMfEsSVFBDC2GSNYP/PUjcBa6E2l9qmLOjNTwRzJK/KMlYhhcCFHXd9By9akOZ5OI4kaNBodP0oNuugRYnnmlFlMIJoP6BNY3QPa+b3K8quYUL548Oh8vmCSp0oRtY0TwLHXxWiVLbcmbKuC+IuxVzvGEcZkRbOFSjvVUBt+e2J+Of1d6mc9/xaDlXuhjkE/SxRunZcYbVp+lvS6pT4PDN0djyMVVS2rbcv2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDmQTIwba6bdXjZhoRKCz0rLXjsoHmzFVXCJE/cHIeY=;
 b=gf7HN4nfgOcWqmlyf8e+HJaFAoUHHyCs9qFp0JxCqBrPhFR/sFQaEweTouvA9DChyxIAm8ijA3zdfHpYP7mS94TslaOR/YmgWAEuz6aHpYE0HQNo9khaGXaQ/tnRB0vLXp3LxTk5A6zowq3IKSzQHJWXN+4RRuaUES8egk8heXAtshzyN1vg92oC15hz4G4ZHb4tOrbisR9GcTsqTjoLEShhHLR7vikDN4DqR1I3Zdnv2y+ofuQ8DYacweKe4bCYPoyWoyYCTX2f/tLW71iiS6DJzRN+nwhNkacF29jSAqkqMe56z2qfKpO8dpHhGd154mgCMTWOfMhDyMEF16iX3A==
Received: from VI5PEPF00000982.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::814)
 by GVUPR10MB9776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:35e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:48:17 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com (2603:10a6:298:1::6a)
 by VI5PEPF00000982.outlook.office365.com (2603:10a6:808:1::814) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Fri, 13 Nov 2026 18:48:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:14 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:15 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 0/6] usb: dwc2: fix low power issues found on stm32mp1
Date: Fri, 13 Nov 2026 19:47:57 +0100
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAF1b92oC/32OQQrCMBBFryJZO5JMbFpdeQ9x0aRTjaiRTG0V6
 d1NFVEUuvzMn/f+XTBFTyyWk7uI1Hr24ZTCfDoRbleetgS+SlmgRKOkzKHqHMIhdHAOHUWo/ZU
 YuDlqBOkUZWQKixmKBDhHep7T/3rzynyxe3LNQBwaO89NiLenvVVD7y0qxkStAgmZ1VJXdW6Qz
 KoOzDNuZi4cxaBq8Qum9CgsDYd8UZisnNfKGv0P0x+YkmYUphPMFBWWkha2tD/L+r5/AEcddP9
 yAQAA
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008483:EE_|GVUPR10MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7795f255-1b6a-42ba-3ce1-08df41b6ad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|376014|36860700016|1800799024|261102124527099003|10067099003|11063799006|56012099006|261021123027099003|261026140227099003|261021121427099003|261026121527099003|261022075727099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	bUSJA+4l+z1pIGH6QvspCWpezlnSxkb6OlUCtNrvitg1r9jQ6C03vSHERip91nKuvnLYdeN2jMIstVS5GYGUD2KEn1C0cW7oNH16D7NRDtqIB9+WM9hTg5uKCkV64YhizpVFpgVTWOSgqCzN80vgcS5yytNq2u7PPxhdXLn3Q1PX3JqjcjR8Pc1KeHBClr0Yrqcmu5fjDTmnurTLlBW43o+ARBd/zrYhzehzoZxVbUSTDhG9jzP/ZeAxQ+0euSpS3TZESrjWVfmzKTpjzXfvdPPa/mTIZh1ZLJTYo2tRb8676JRa8+onU7JU9OEMW+bCAw9pLo5uHCNyKaPzVucPHyrDx2Eez4JLbAiARzGRyIe85V3KtV7XFL+q/mdRNS7ac0AtGx/D691eeq+PWqzGlJVHOiK91EfX6f663TG4s6GlYWw1d4T1mvGiVZB1BtbaxNOobp8F5T0ZYr6IbBVRO7iCWtBSgVpRvTjn5Padpyauz9xnrhWOVvtE1D/WqFRdtKwHbkx7rtjzEDgyOsKhQuWmHQjZ1qGm9X9KMfbCftrNkVvEQ8x89CcOF3OkB9ReJTTcrx/ySLgfMNv+c0WztkrSgILeec/ObLONiL+yHe3MZvqYRn16HxJjUcVkeo44w7FkCQhCWyHpVB7oOtwPjA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(376014)(36860700016)(1800799024)(261102124527099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022075727099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F9wxnBzp8pYVEQibwdbtD9b1A2Cfmqp3p+YFBJt4vIouotEZy/f7EAs9xU7v2VSyG4Ehr1hp1NNI1LoP50uqCscEAqoBbJ//VBfUn9EHdn64Yuo3R9aRbMvaf9VA0ntxW3fVIxkgA0ruyhekvA6DcdluUlSXPlh+WRPykOAD5lIIFVjfhjpasKtulCVN1vfrtLkwJFxw8VLvY2FYdK9TfqFOn8czf/r5MwQeoezxI8J4oogEE02wZlhG0K/WO0HofDDdlpVisAmInJ30UVHSPbuBXQS2baJCvMPYvJYDgf3tR8vqZEI27wCUzeH6bk8LSxnU8GcQ3tXRKp7GJEW691vjRQaL9lmdyBIS+t/JS5wX3zq8J0QEkAvDXiM1J1ILTu7Dkp07VLiO2/T5oJYNX7GtN+ihsigfbQXNMFOdIkPxUSNSUGNikS3I5g+eldlg
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:15.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7795f255-1b6a-42ba-3ce1-08df41b6ad7c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9776

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First three fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Address Sashiko feedback on register-loss recovery: add
  dwc2_hcd_restore() to reinitialize the host and clear stale state;
  disconnect the gadget and clear stale endpoint and low-power state.
- Fix the HCD resume race by holding hsotg->lock with interrupts disabled
  across global interrupt enable and dwc2_hcd_reinit().
- Rework VBUS handling: track the regulator enable reference with
  vbus_supply_enabled and a mutex, keep external VBUS enabled across
  system suspend, and drop dwc2_vbus_supply_restore().
- Track STM32 ID/VBUS detection enablement with
  stm32_id_vb_detection_enabled.

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
      usb: dwc2: hcd: don't disable external vbus in system suspend
      usb: dwc2: platform: fix stm32mp15 detection logic power management

 drivers/usb/dwc2/core.c      |   1 -
 drivers/usb/dwc2/core.h      |  17 ++-
 drivers/usb/dwc2/core_intr.c |   9 +-
 drivers/usb/dwc2/gadget.c    |  18 +++-
 drivers/usb/dwc2/hcd.c       | 101 ++++++++++++-----
 drivers/usb/dwc2/platform.c  | 250 +++++++++++++++++++++++--------------------
 6 files changed, 246 insertions(+), 150 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

