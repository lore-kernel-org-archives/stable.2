Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624376;
	b=dpVJPstrUnoPVixhoN5CtqnmMYes+Db3Bwnm+yVtTdyYuTi3oqRZ2ivaMb9ERg5dHM3k
	 +MIdUm7KGJjp6srDLPT7UVRlQYfjIg6d35TqWsMAylXo2ysq3G4SI2bvmlmW9C7zlsJLY
	 hJnLt47y+bBYWnpLBjHCftU22MVXsM/OBX6LNHWw1hE0mVlFHXNc2NPSY+wggiu4azgY/
	 X2L0E8wxOpI2CB/VX8p7vNqUSwL7RDX+L7t5IubaVILq8glUHbK1gOnwmyE+xctJnTMcL
	 9g7aA9tdWzqM8fVYK4hTkFfiFiGAKq2jUW79GPPLLN89H5HqAuf+rbc0xXlCE0O4VVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624376;
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
	bh=z/YAwRhaWeYjpdZBQvuzhL8OqmCGghyjlzAFGXwAr4A=;
	b=LAsIXbBXOxS0jS057VwmudprKVLR3a0x4poaf0czBNlYElWGddwlUxHltBVxT/8eeQOg
	 KQzGeZxNIaeahEk9Ngm9FllZtiI0+3+2XQQWRkDuNfyO1IEo8vPUQmIIGZQUfAMyQbZ7O
	 B+2c26yu3ox7W5pCDubVoV3f5DMsZdHvQvcuUbkNM5qlF0rqTQv9IEyXEgtEfiCyGJEVt
	 I7v7vXsLam//RbyI/kGBzP2U/fXpIirtPmKVasQVdZLjOrOsXLkRQmLe8jJ0eMB+N1n/B
	 Xj7dbi02LgJozdZe3Fzu02dH0SfMPqHxvPKk2xJCnMeLGgsxywKHlXbdO5ITJ0llH+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="E11/wMDk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.46
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FD606A33C;
	Wed, 25 Nov 2026 16:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 216FD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=E11/wMDk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idr/V38gYGMF2lHBd8W9aB1GtwcjK4XOmXsd9rmIN5KONqb5Rj5TZLI4PIMRaMZoSkeXPd5aUBw4PF3Kn9OrZF3XWvbjh3k/PjJWGF4z0r+eyAttKzsGBrqkJLh35QoceHddNzdU7L7vmy/lgGvleSkUwg4NTG+a8V2026h96nnVsPpkF54zVUXVWuntklwWkbkLekbdZES9dr61SV+zZqiXF57sZXkiHYnUmoUc2+RNHM96ptNZDhrR92sLhEjD3kCoFGT8p4/t48ok2jFeueXOOBQQdhvyBKvvWDOcnSqiyZM4Hte+ID9zvwdM7e+oITGXpf29ahd7tqw3eFUOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/YAwRhaWeYjpdZBQvuzhL8OqmCGghyjlzAFGXwAr4A=;
 b=RXuNIgHIe+XRXsOEcU1BEmq2RORurYHtaMQGIHRXVV/imaAeMTftWymRMb91yqThERbvDQpf9WEJif75Fx7wSRndEn2UnaZiiPbAMVI0Z4TPJNe84GodmnZJffXYeSSlJeZYje83dXpyhuJ9sbc+emQIbKEYp+nspRGWoMYx+E3EwhkUCA70EXOqjgEDFEGj0EsU6lv6TGvKDu8AJ2lpfmq40uuXngvOyYsrofwfyJGtdtxMoBwPMjC4G4NvZIqda4V2wsUZbmhi5lqtRM+Ve8A2zj8DbN0YbhUU/f72TYG0JAre7bZDv4sG3FdDSyS8xn5kkIhJAf76kMqE6VE/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/YAwRhaWeYjpdZBQvuzhL8OqmCGghyjlzAFGXwAr4A=;
 b=E11/wMDkGP5ymqKqQeeB+9nqNi55dLyxKbILsOyENbRZCKqy+lyUNLilh+B6Niv/BN29tK3WTYJqlvrSG9ik+kQvKly8YJHinwaHCPQgK5ka4hbBnpl4tqMwAo7X7C0jtTPTPGi5smuJ8jXVGop9L6sYF3/UkD96G7gkHP43fIFwLSuvj4oZ5Aleto2VXfTIO4GfEQgKb80ThftYkS2k8X0J+Y2O8XaytOZCqbUruYPOYztF1mqdCwaGx26x6YUQtNBzzltinqo2Q+CaHPW63AosD5+4a9VcwQt5dHh3sRfkiopXfaT8jIHgBdzuPYOpQEOXdeAfYuoyaXownDikWQ==
Received: from GV2PEPF00048123.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1f7) by DB8PR10MB3957.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:165::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:32:46 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com (2603:10a6:1d8::118)
 by GV2PEPF00048123.outlook.office365.com (2603:10a6:158:400::1f7) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Wed, 25 Nov 2026 16:32:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:32 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:43 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v6 00/11] usb: dwc2: fix low power issues found on stm32mp1
Date: Wed, 25 Nov 2026 17:32:01 +0100
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAIINB2sC/4XR3U7EIBAF4FfZcC0bfsqUeuV7GC+ADi7GXTZQq
 WbTdxfWGGvW1MsThu9MMheSMQXM5H53IQlLyCGeaoC7HXEHc3pGGsaaiWACOGM9HWcn6Guc6Tn
 OmKgP75hpno5SUOY4KgRthRKkAueE1+f6//HpK+c3+4JuamKbOIQ8xfRxbS+8zX0X6a2iwimjy
 komR9+DQHjwMed9nvYuHkmrKmKFcbmJ1cVpP2hQpvPcgrzF5A/GGWxismKgR2EYDtbYPzbrVtg
 /m3UVY9poN0AFB7zF1BrbPE5RDfN86JEhSBC/sWVZPgHi0U5wDAIAAA==
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3A:EE_|DB8PR10MB3957:EE_
X-MS-Office365-Filtering-Correlation-Id: f918ab41-fbce-47f2-b138-08df4b11bc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|23010399003|82310400026|261022105027099003|10067099003|11063799006|261028144727099003|56012099006|261102124527099003|261021121427099003|261022075727099003|261026121527099003|261021123027099003|261009223027099003|261026140227099003|261102123227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	uXRVXqTNR9ToKmnojl+1rJB4Tc9+Ef6hqD6xD3p+TdHl+lunombpKxv4KaZG09WRehdgqwSISHr7LAWvMo3YyMWOlbbNbIpKVK/y3k0fHz16lU6iSdmW1K6AAKqW6qLj9v99o31/kqY3578Vqb6czDmDWBNBu5T6v35wliV+cv5qohTqGCYuYG1PUmmEzSlymATKGhaEomPdHOG+aTBaxclzBVX+KTCzLHxB0APOjhsZ9ORgu8Zk5rHqm5R9hpmyk1q5eElvu97VqDE15x+x768bsQeBG/jk5yUawapy5oh9LwJMK0cQD6ctzNSXzqDp3lu3R/HS2s0D6RZJ43pwm3rYZa/MSDEBQac/IVHnoplBAovsFW4R8mOXeorlQVGjVyCzBY4V63aGfLwP7q+l5yhk2dAtTDZkUrhWAFAzFB7MvnpDm4Sgadn5xkfmhVTgFvei2u00uqTWxdYnpJAFmvabcURJVp3LYz3w4dPhVSdXh6n0yY90ezVJzwDMc1mUiqra7ydBBqljJcgW+YphIlHyfFWUC8GYHkC3tBjOrfOGoDkS2NkpwU/8wsh3WCEE46xTUJ/I72J/LCaGxCrZt3ZWIjsMHLjc0WNWKTFgkjZlQ47hNzwAnDD9fJkP73sVqMUpICe4iT+lQwmQx1BCtA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(23010399003)(82310400026)(261022105027099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261102124527099003)(261021121427099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223027099003)(261026140227099003)(261102123227099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J7XTxJiUnQJQCN6r9vbVwN2C+IiN/wChBVkkclPeB0ck0PuxT3Gi6kFCQYwXMolRNf3goMMFxKbvkw7cyV9BiC5bIx6dOglU/4QZNwmmwBNE+UAuhpnIGHOpR0JrWN/XM2MM+q3pPBL6gExiQVmj8/ZhBd+qenbtKZCtGtOI8YCcQ/dPc4fTQ5KidhpNKsLGVmIDbuKdJS2pFwSTQPwMOfV5SpsUr3a4AZJDoerZGlaL689BjusIesXU7gYsiXKClKOhI0PI18wsYIeBnxzERaVlX+czFMEIMX0Bs+P5sy45vTfDWUX51AGSze2dyUxAJ6ILenPUNbbQX1j4UFjY0czT9Pr9xzFNiKmhotROEtbWp4a73WwH3U4QlZBg1EezN2B/Hia7Ljm4Dhyt/TQj6OU1V72Q6p6Zn/Epb4bq1ijLXAZfZ1ngxV5v764sG8Gf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:45.9380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f918ab41-fbce-47f2-b138-08df4b11bc97
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3957

This series addresses several hang, bad_irq or re-initialisation issues
found on stm32mp1 when going to system low power (stop mode):
- First fixes can be reproduced on stm32mp13 DK board, stm32mp15 DK
  and EVAL boards.
- Subsequent fixes can be reproduced on stm32mp15 EVAL board that uses
  an external Vbus regulator and stm32 dedicated detection logic.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- Instead of reworking the PM off recovery, rather add registers backup
  when in clock gating mode, and rely on already bakc'ed up registers
  upon recovery, as discussed with Stefan.
- Split PM off recovery fix into several patchs to ease the review.
- Address Sashiko findings seen in v5.
- Link to v5: https://patch.msgid.link/20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com

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
Fabrice Gasnier (11):
      usb: dwc2: fix recovery after PM domain off
      usb: dwc2: keep TOUTCAL canary valid after PHY init
      usb: dwc2: drop stale state after register restore on resume
      usb: dwc2: clean up old role on mode change during suspend
      usb: dwc2: fix a possible interrupt storm in hcd resume
      usb: dwc2: fix a possible interrupt storm on stm32mp1
      usb: dwc2: hcd: fix possible successive vbus supply enables
      usb: dwc2: hcd: don't disable external vbus in system suspend
      usb: dwc2: restore peripheral mode on low-level enable
      usb: dwc2: platform: fix stm32mp15 detection logic power management
      usb: dwc2: drop redundant ll_hw_enabled checks in suspend/resume

 drivers/usb/dwc2/core.c      |  17 +++
 drivers/usb/dwc2/core.h      |  25 +++-
 drivers/usb/dwc2/core_intr.c |   9 +-
 drivers/usb/dwc2/gadget.c    |  61 ++++++++--
 drivers/usb/dwc2/hcd.c       | 150 +++++++++++++++++++-----
 drivers/usb/dwc2/platform.c  | 269 +++++++++++++++++++++++++++++--------------
 6 files changed, 405 insertions(+), 126 deletions(-)
---
base-commit: b0baaf6cbb16bc773d0c76916aac17c44a6cd557
change-id: 20261007-dwc2-low-power-fixes-stm32-0c1e5e68b252

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

