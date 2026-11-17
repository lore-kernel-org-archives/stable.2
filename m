Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935186;
	b=YBNgsGTlLFxD2l1Ka33pdO4CLMyaHr1Lgiu9SYg9AZSLTlmWYD748sJjC1lvHlOU7PV8
	 be187Adz+yCSWKNS+loajQe2ufh99A4fgb2hrWbMT4YDw/uZqGnBPsfVKrJTu5r+URdcH
	 R7Hhzq2aOLj4A1b6Lzv3u57vm8Yu+LyPBnFh4ysWBfMY8m/TmZy1wjjCFwfNAosKDUOuO
	 zpLLJ44UXPAwv918K9aQGdA74uS/ex+2/DVcFgMDcQ5bURMwegOe5km5NWMuMGPnxNmE7
	 sW/gJn3u0ggkWw09wUaCV+idJ7RxpOcAs520cjxKvnFr5YIJB94tIECfE3/wY5IdP8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935186;
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
	bh=4Rx0t3Xg/Iysk9w8dcTl7ioXkD3nKlp8TfSDqD0GNic=;
	b=m3Ka5xvH6rkzi0r1C7n9x2444f7NPdmJyy5O27QEixch+wX0iypcBlrV3RZFjxbIAw1D
	 ekW8g0+Eg38tzt1sK9M3WWfMMza2c0WoyDAV5+FLoT4YMhSmo6pZqpfvLmvWlEWQmbtfI
	 ptVQmnkCYp+/+I5UnFW0E1JsAhnqv3HsChniuqZR4e3pQVWhsLcERAh2bTqLgDX+l96tm
	 Y9GXVriiMcf6064933dUq367tStFNcoziHZxTEubijbSFA75NNPLbTEElgbeCmfe2232j
	 K8A7YovwIfTkl/Gy4O6lVBp9LFCEYUIv5gg1tKaXJ3gyMel5rzN+gBmETmlyQAyU92A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hIKKTwWH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.12
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE57606A330;
	Tue, 17 Nov 2026 17:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE57606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hIKKTwWH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMFqRY18FYa462IOdqVs4jflJAu4t30UyDQ5rnNYbGYsN85nMmr325RzfgIHZQxbBGy19ZvdFF971Ki2lXRQYO3OQj9FLLK3lv7Jvy3FwGwKpWLzGh48DX8xpJBtXtb6lCRu0mQxkesnzZ9YM9Bo1lQ7pfJjrjJd8scEp2fYD2L6/VEMzoUApyIEZK4QYIV3pxL+rSZaW+g6z4EeE09UxB+4pk+h7wpp0y1nheNIZyrEc9F7vBuslnhygt9d0DA4eE2V4lrSbaXuwcj2XLrjIP+TeqM2OWJgMW9zB4MunSC484wGuXN2Mz1I7RxjeDhcRpV3J8E0KC6Yd8/uE8+9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rx0t3Xg/Iysk9w8dcTl7ioXkD3nKlp8TfSDqD0GNic=;
 b=cTuPLwJcTWLez5xG4lUKFwr8ITk4soWwHFQ+5xsVe8sKbMzjWftOsmmuGwmgqOwav2kl0P9skWy98WOBEXOBPRrOsxUwSeTHpjF8AdvYHO14zVrEtGgnaL88OJC6ZX+Vb6gBfYQ6M48mmtI+PLkrS/dxWP8bgVTrOkj4OJaTvQPdF4d+9fEKfvp7FbKjXDwPBX9o6SxxoE7FObo/tThPEDATUIevl+QphVc4N9NVaVrXiOAjy9rWWGIF8ioPTKJ+9SYICKHuv19SN1dAXU+gB+nChkvA0XkndrEK4K3SNHgcOl5EyGU0wzAtY+F2LE72wnZpZqLmVLZKaqZVAZOLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rx0t3Xg/Iysk9w8dcTl7ioXkD3nKlp8TfSDqD0GNic=;
 b=hIKKTwWH/ykQIKy5R66KKR3fquYmW2F7hQbM3GAkt+dwX+kn85KdlDbYaVrhrArOOptC6ooO/CuxLzB3BqDvRj1mcb4I2H/3dbZPIkOPrB3Ae9GV2X99bggSyYeSvZh7lal6BLD03ipcF4z7/wrsiku18jOsjhPmZ+Ei8Gat1EZ8gRMpuRw/8684OYt2IgC6VuOaTs5wgk4TtlNXIJqgpgpEpcdTDaIDYKtpcfsdBjznvIN1mtoUzKgF5AhoF0XNGUJ0HhRHWALY7S3nQB+ocCbq54D6OnGu+W5/kB72adh1zIx/n2rVUgSWMMLzL7dsIE976VgI08uyDsmIf0/kWw==
Received: from ZR2P278CA0064.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:52::18)
 by AS1PR10MB5215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 17:06:20 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:910:52:cafe::e) by ZR2P278CA0064.outlook.office365.com
 (2603:10a6:910:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:06:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:04 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:19 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v5 0/7] usb: dwc2: fix low power issues found on stm32mp1
Date: Tue, 17 Nov 2026 18:06:04 +0100
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAH2J/GoC/4XOTW7CMBAF4KsgrzvIP7HjsOo9Kha2MwFXBSNPS
 Fqh3B0HVBXUKl0+efy9d2GEOSKxzerCMg6RYjqWoF9WLOzdcYcQ25KZ5NIIzmtoxyDhI41wSiN
 m6OInElB/UBJ4EKjRWC+1ZAU4Zbw9l/9v23ums3/H0M/ifLGP1Kf8dWsfxHz3XWSXigYBHLRXX
 LVdbSSa1y4Rralfh3Rgc9UgHzChFrEyHOrGGu2qTnijfmPqBxPcLGKqYMa20nFsvPN/LKsesH+
 WVQXj1tnQmAI2+IxN03QFXVVBvb8BAAA=
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|AS1PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b648e98-8d69-410c-f041-08df44cd1980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261102123227099003|261102124527099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|11063799006|56012099006|10067099003|18002099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	V4nbZQ7mEMuCtsGNmKd+8UjE6cNMkuVbJYtbeJ4vrVz9cBU7BKv8HUl00G4QSyLuERaLSBBQqDDm/7mg5n8LyMxpNEQ6qFu8+lygSqs0RqDj3j7+qHUSXabBUJ8fz56ESDLGx1GQU3Mjv8lQpQ5zW68LMPRrJgVMNHXIwFBTlMF7NfnsZ8/MFJBd1JxhPTgMYoXiz1adbKETrG0h+zzl/7tcF0cbIkR6g/0H7bI4G8TpB+0DEsKB+tMyegx9jXVg+erWhHIyYXcyBR1diLP7+uZp5+eyuIPZt7SO+pC6GtX0cLP1SsC8hHuuD1nzj+nDiHLBEm7Kh/r0LQx0qHCuz5+bYRmNR1+KdUFogCAm5DNJbL/H+6i3GGMen862QMr0kYOc21LJ6pa/4rXe3wj2vIehzztWQifibr1oRYXCGu1PvdFjzHg0eFlr6DB0+kW2FvHqw9Q28mK+RNEgKs7cazG53pAd0C4sgkP93TvUGsMvF5Ocfvwc9pS3Cl8QedY9Y/LsNewZANSfSKHdX4QFIOnbFNtkEJnt9Q9uI/mmSVxESESsBrb5heGTbHC174+tGtn/T2tl8qrbouM5bBrMBiwHAOPSoIXBgdTP+5z1vJF416g520XRLufU/q5u6tRBYGh1YhqbVpkaVn+RnN8dag==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261102123227099003)(261102124527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SGXmp56UPjJnXPSYqvVbtek6BgaBBVSj6Ab5WsFDcXx9GAclZT20k1n/BGva0BzyEwpg7y5KmDiuQczWky6D40IrdtZSThStoD0QHQ3zdWwh/TKLMd9/OpOYbSgy7Dmi5LBJtXEVI27NSsf1gQDseFUEf1H8p/cM0EepnpDk69RAieG4PLuUOR3Pv7Kdcxf2AUBi4gJKKTyosigMWiBz/brtASwgK95rcxstuyVvixV/cawVIEwdTVLXe/s1mRpv8pqvdgYkecYPSu3eyvOHzG8HxbKRBW1eqjJIHJjDgBKX6TCqQPX6Rx2aRkL9vWlyuhygIHN8XUC0tXG8hCzLOaFYr8Qt6N+RnDE7NSR1MhUnDcOP3rX5SEGAgEpDs/e0NkJfoblTq/q9vbtgagfi+GiYFzsKykU6MsYPgPQru357zkefV7oqOjvJdKCi1fIL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:19.6533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b648e98-8d69-410c-f041-08df44cd1980
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5215

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First three fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- Address Sashiko comments on first and last patch
- Added one separate patch as last issue raised by Sashiko appears in
  current patchset but pre-exists.
- Link to v4: https://patch.msgid.link/20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com

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
- Link to v3: https://patch.msgid.link/20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com

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
Fabrice Gasnier (7):
      usb: dwc2: fix recovery after PM domain off
      usb: dwc2: fix a possible interrupt storm in hcd resume
      usb: dwc2: fix a possible interrupt storm on stm32mp1
      usb: dwc2: hcd: fix possible successive vbus supply enables
      usb: dwc2: hcd: don't disable external vbus in system suspend
      usb: dwc2: restore peripheral mode on low-level enable
      usb: dwc2: platform: fix stm32mp15 detection logic power management

 drivers/usb/dwc2/core.c      |   1 -
 drivers/usb/dwc2/core.h      |  17 ++-
 drivers/usb/dwc2/core_intr.c |   9 +-
 drivers/usb/dwc2/gadget.c    |  37 ++++++-
 drivers/usb/dwc2/hcd.c       | 101 ++++++++++++-----
 drivers/usb/dwc2/platform.c  | 257 ++++++++++++++++++++++++-------------------
 6 files changed, 269 insertions(+), 153 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

