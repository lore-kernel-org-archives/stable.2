Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624372;
	b=z/MNtxTmC25PkTNMaI4h1v5eiJ+ILONwZk6VvOXsbNXDE2gll0MEX1dPtGAxtv1S/n66
	 PfUqySKgNlvbvKMPvPQvjE5c85757dwzS6/9I1+c/1xg5LfC1QnTU6/dnHxd7jxYS7CG0
	 YUZHf3TNSGcopu2qK9pGo2LxSPkkcq4l1BOTr5VYhKQWiehsGuBOGXDP+MxoXCt2HWRRY
	 xXFCc1BrbRfSxxbajguKpbuDg7V+dmharrBenaPXecOtw6v6vNeFZcqD2eVNBcg/9eDrr
	 /UIn7NGfsiqnjZWo27bEoVhJ84ibXVnuRNzlFxdyXw1Phj5z4lt1j8X2JMYbWwZet0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624372;
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
	bh=WTT5uAKxCp1y51P4lhR+sRkq309dyXeCTveWZSftt9s=;
	b=1m6fEgc689DCiZsMccqQY82zopdfaO7gnWh4TvUAPrgoCu9VR/awxTPZJIBe39mPj3n2
	 +V5pM0DsE01dU1/f3kl+QkVFxf5vLPDAMdBQFS1ZrlAmAbaiEo+9KTMTSgA2vydGIVUev
	 CkZrfEjXdicN0oL8yDnGgNncsyQ23mKEFfHAZpLH2pAZqe0Ch0NnVSTxNxdTGT4LDkuFs
	 fjJ35niMlpFFLCZ257LsB7qxgAJmGictwRO3EdrXxxFP6wRJ/oPkn127w8ekBOyQF7Dqm
	 ro0Lf6ttNgyOgBNPBEYetWz0cYTiPUBdbr/BSqLFx23DSNCU899i76pBQd1Xwf3YZdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MkdDwyoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.70
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D9606A68B;
	Wed, 25 Nov 2026 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C87D9606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MkdDwyoH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl/NdJRHcbkZi6ttumYLx9v2ABHPzL0CGqKH9mU80dJ1rGvLUPXe4vNMPwxfX8RcCkCqw3/hQrpISNLS+J6+GC7542HFssnM8nozy1+v9asd7pt36FeMX2uVds+d0fc/OjKdZ6gj+m8vHgC8bHzDsz4T6nwNaSsBwRJN65j5hi1rUn3irUTmgx2O2chTQeX5XMmqJ4aXVANRxmZsAap4T++Jhe7oTiow0lGHo9JAoaDeiVe/zNOcXAP80flhsJ34q/1O29pqOsKXe+nR3Yrr2jGd9vNCBJqQrJwa7T1oKdx6Spl7yhKuqSscYiE7bDmgPuJAg2j3AXGD0ONuWjLNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTT5uAKxCp1y51P4lhR+sRkq309dyXeCTveWZSftt9s=;
 b=m50csLDCD0RflExMVNyBuJ6g730M3Jra0jcVpzG7Gp+qvmvQbO+YQaArjOQ2HN1UOzrTDSsb0Kg1Za1Wq0e0FOvcTXciGiyzX/zyKkvGY9TZlfK5ALDchOsb914qaW2sYSBsYAVgzrxlAE7Jb7R+AsjSeZR7+kmIhvkqLyuyYoiEMIngE1H8mKuBJPZ16+x6sw/+8nWwKuRrNVXKNbM+f0h+6cprofFTZmThdLXmpW8y/hjr4WklhD0ZVgw6cf07bia+kbQ9b2tgeYNigKfjrgYj7DdKi38QGXrBPsm2PATi8G8kOtEP1fr0zWA7zo16pi2l8Yf6mZqocNi1dHXbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTT5uAKxCp1y51P4lhR+sRkq309dyXeCTveWZSftt9s=;
 b=MkdDwyoHBWVFE4IqhYnB1W4oo7m1vaVmoebywxNRlysCZGf3XUCta/N5Pa5N/vFwXGxtWtfSpWY8VDO1ASRMJBbVXHle74NaDAaCXSKAb1x+GkL+jXe0fgWcTkdlNe2eTPYpCQcTkcALLOuMxiaBPWPVDQY4vrq93nWTwfeabB/jnhxZj3svCxUkkSV9yhiHrFQgATSNCvK3PEnxrNzXtEbUgOqXEjPwT0yVTeoa2gKYtk9HT/Yx/GUtWhGyATfAmHL9NdcQXYM0gemZ7oH6Fln8bFTQ63hd2Yu2hDJjboxt02iKzfsbwCw5CfQPOp2YrQwUPV61hvazg1mWOd2Iag==
Received: from DUZPR01CA0329.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::28) by AM7PR10MB3304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:32:46 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::51) by DUZPR01CA0329.outlook.office365.com
 (2603:10a6:10:4ba::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:32:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 25 Nov 2026 16:32:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:49 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:43 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:02 +0100
Subject: [PATCH v6 01/11] usb: dwc2: fix recovery after PM domain off
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-1-d5df33b93eaf@foss.st.com>
References: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
In-Reply-To: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AM7PR10MB3304:EE_
X-MS-Office365-Filtering-Correlation-Id: ee782e58-6b5e-458b-cb4d-08df4b11bbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	YVzpRvT1SBosCiogJAXbBuDXoydpfC0cx0A1n6VG0Hu0se66JjpS5X0AG4oM2bMcmSExFtEw4euB0cOa0bf/RH8NyaIFpf4zNdRLeGOmpNgH1ILDe/KSrNpHyPsNk5dFdi3RJUr0UJhJyA7giHg3QKj/bEEqxi4alRjleFZpeGx9aeKCuKLoO14a902GLc4qu7Vn9/MEEH7hHFnGrN/Eo2SqdkEPiQz1iqYwoLQXHKJwnDVprCKQnBRVFETAd3vg7TV9Vkg4N+4tb3rTt30MCrWLRHSC7xGwqyIIIoKYoqNpWe6THJz00tut0rJUfugZV4Hovp5dgdi0Tbhramp6x+Oj3zns9hMVpHKOdQncR08Mccun6MV/xFKBojlDF0SRBQGMnFP8a7zLEehLwP+bDvTIHU8nmfbE8NMjcipMx7p89LT2UBixbGPZuPYN4NqeYORRKmwNHT5Iz8D3RL7byXebJZVv7RWwzBSfx3G6Q727PpkK+EqWmTaP/p60BPOuvt3/0wyaocIlwHhwlypDw+u1rDWUG44CCiv3K25OI96TH4Qb/O2Q7uf77gyU1OdNNJd/AgftDEmCpk4tpn8TRYy36RlbnXJ663NOpXjNuxejwV0IX/rKOwE1JUhlalR4WITKEeN2dhRx29O/LokfE7K+Uim1z4SSeWSQy4KBXDptR3bNkacy2fCzxTO6sO361TvCQC8/km12/7p9KJtpHg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GHXewGAdDAAezydU8NWNffe7P+WWC3EkowY7ZbMTCo7TwMs2Qk6CUKgVsWeyojXeC85/WldINumuP/NjcbaRyNTOAH6rF2Mxsvx8bRHh6uy3x1YqnDdqrJT/vUylOdqq9+FOV8LIEnE9BD8wi9ViVs2D8sCAZF335yTugTMVLhMbfdKdlOvSFZl1cQ0LIlJrruCwmewU5UiY/iB+jLQNULJV8HygexFgeEkXdbyZ7xuALs4Ji0gRgiwl7TlWwWLXBDnGgDJCkXIdePabu5f5jC+4MubN6/9SmMNsbjEAnMTY0wcZ8gXQ9S3MaT1Y2gjoVe2PIJkIlbQMPeSdYveRdwqyjiT+McF0gpRl+YBX4Q5wNrKOBTrThI/mDzsNvTJjSrWUwldJ/BUnitWQ3tKElMkcf7vwtdLsXiri6TBB4xyMRS5cX1cqcWxXlay0j6Tw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:44.7122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee782e58-6b5e-458b-cb4d-08df4b11bbde
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3304

When the power domain containing the DWC2 controller is disabled during
suspend, its registers are lost. Reading registers to back them up from
dwc2_suspend() after clock gating can hang STM32MP1x in both host and
device mode. Host suspend enters clock gating directly; in device mode,
this can happen if the host suspended the USB bus before system suspend.

Instead of unconditional backup of gadget/host registers, check if these
registers have already been back'ed up (e.g. gr->valid == true). This is
the case when the controller has already been put into one of the low
power modes. This avoid unclocked access.

When entering clock gating, add backup of the gadget/host registers. This
will address the case when the bus has entered suspend state, prior the
PM suspend sequence. Discard the valid flag upon exit from clock gating.
There's no need to restore registers in clock-gating exit routines.

Protect the backup/restore of the registers against interrupt that may
arise during these phases (with a spin_lock).

Move the registers restore after the STM32 vbus/id detection glue has
been restored, as a wrong mode may be temporarily observed, triggering
ID status change IRQs.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- Basically keep original approach instead of reworking it as discussed
  with Stefan.
- Re-visit the way to restore registers: add registers backup in clock
  gating entry routines. When controller is suspended (bus suspend) and
  platform PM suspend is requested, the registers have already been
  back'ed up so the problematic backup phase becomes redundant and can
  be skipped.
- Address sashiko remarks on stale variables in subsequent separate
  patches to ease review.

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
 drivers/usb/dwc2/gadget.c   | 13 +++++++++++++
 drivers/usb/dwc2/hcd.c      | 12 ++++++++++++
 drivers/usb/dwc2/platform.c | 42 ++++++++++++++++++++++++++----------------
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index adc3df0ca7dd..02c93a41043a 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5766,6 +5766,15 @@ void dwc2_gadget_enter_clock_gating(struct dwc2_hsotg *hsotg)
 
 	dev_dbg(hsotg->dev, "Entering device clock gating.\n");
 
+	/*
+	 * Clock gating doesn't need a register backup. Do it here anyway, in
+	 * anticipation of a platform PM suspend: once the USB bus is suspended
+	 * and the clock gated, registers can't be read safely (access may hang
+	 * on some platforms). dwc2_resume() uses this backup to restore the
+	 * registers if the PM domain was turned off.
+	 */
+	dwc2_gadget_backup_critical_registers(hsotg);
+
 	/* Set the Phy Clock bit as suspend is received. */
 	pcgctl = dwc2_readl(hsotg, PCGCTL);
 	pcgctl |= PCGCTL_STOPPCLK;
@@ -5792,6 +5801,7 @@ void dwc2_gadget_enter_clock_gating(struct dwc2_hsotg *hsotg)
  */
 void dwc2_gadget_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
 {
+	struct dwc2_gregs_backup *gr = &hsotg->gr_backup;
 	u32 pcgctl;
 	u32 dctl;
 
@@ -5820,4 +5830,7 @@ void dwc2_gadget_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
 	call_gadget(hsotg, resume);
 	hsotg->lx_state = DWC2_L0;
 	hsotg->bus_suspended = false;
+
+	/* Discard previously stored registers */
+	gr->valid = false;
 }
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 40ab50538334..db6126cd72c8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5935,6 +5935,14 @@ void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg)
 	u32 pcgctl;
 
 	dev_dbg(hsotg->dev, "Entering host clock gating.\n");
+	/*
+	 * Clock gating doesn't need a register backup. Do it here anyway, in
+	 * anticipation of a platform PM suspend: once the USB bus is suspended
+	 * and the clock gated, registers can't be read safely (access may hang
+	 * on some platforms). dwc2_resume() uses this backup to restore the
+	 * registers if the PM domain was turned off.
+	 */
+	dwc2_host_backup_critical_registers(hsotg);
 
 	/* Put this port in suspend mode. */
 	hprt0 = dwc2_read_hprt0(hsotg);
@@ -5967,6 +5975,7 @@ void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg)
  */
 void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
 {
+	struct dwc2_gregs_backup *gr = &hsotg->gr_backup;
 	u32 hprt0;
 	u32 pcgctl;
 
@@ -6006,4 +6015,7 @@ void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup)
 		mod_timer(&hsotg->wkp_timer,
 			  jiffies + msecs_to_jiffies(71));
 	}
+
+	/* Discard previously stored registers */
+	gr->valid = false;
 }
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3df9b198d1b2..7f3436e6a153 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -649,6 +649,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 static int __maybe_unused dwc2_suspend(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
+	struct dwc2_gregs_backup *gr;
+	unsigned long flags;
 	bool is_device_mode;
 	int ret = 0;
 
@@ -692,10 +694,15 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 		regulator_disable(dwc2->usb33d);
 	}
 
-	if (is_device_mode)
-		ret = dwc2_gadget_backup_critical_registers(dwc2);
-	else
-		ret = dwc2_host_backup_critical_registers(dwc2);
+	spin_lock_irqsave(&dwc2->lock, flags);
+	gr = &dwc2->gr_backup;
+	if (!gr->valid) {
+		if (is_device_mode)
+			ret = dwc2_gadget_backup_critical_registers(dwc2);
+		else
+			ret = dwc2_host_backup_critical_registers(dwc2);
+	}
+	spin_unlock_irqrestore(&dwc2->lock, flags);
 
 	if (ret)
 		return ret;
@@ -730,6 +737,7 @@ static int dwc2_restore_critical_registers(struct dwc2_hsotg *hsotg)
 static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
+	unsigned long flags;
 	int ret = 0;
 
 	if (!dwc2->ll_hw_enabled)
@@ -742,18 +750,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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
@@ -786,6 +782,20 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 		dwc2_drd_resume(dwc2);
 	}
 
+	/*
+	 * During suspend it's possible that the power domain for the
+	 * DWC2 controller is disabled and all register values get lost.
+	 * In case the GUSBCFG register is not initialized, it's clear the
+	 * registers must be restored.
+	 */
+	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
+		spin_lock_irqsave(&dwc2->lock, flags);
+		ret = dwc2_restore_critical_registers(dwc2);
+		spin_unlock_irqrestore(&dwc2->lock, flags);
+		if (ret)
+			return ret;
+	}
+
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
 

-- 
2.43.0

