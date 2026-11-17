Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935193;
	b=PXy10Dt7Oek98elSql5+hfGcswgBOqbXcOt4qS8x69WhPYR1kSjrJltfWq48vywhbaRq
	 XvFudDp64S4BPy/qaCNmWg8ofLVZYc68piNV4pfH6lS/bcEuS2PZpXvfVzkojZJeWi/nO
	 /G4eOI0PqcEwPXaCbydkRns1X9oK5BTAAt4Tfjror18hBXQpKpEahTVVW51VnVqn8OUy+
	 jQY7YmPmeGMyetRArxQ2v7fRb9P3/qnSe2VvFyDVOtsviGyYg6P6AeYqC89/YYReamIAA
	 LXMwzY6QM94E/OJ8PWVRVMeiLjRz2rlRWk/dOPKi00P3kkklkmGaiY9sa1UXuYvaIKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935193;
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
	bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
	b=ievVjSe205YUTa21hcHJ0W6nrKGQXwRG4EYFoRKKdbwMs4OmRqXaRW9Tl3clSzJmgxsx
	 27BbhCkLMpLgJaSMOK7/aAy8rkVA3eWHH2CHlgXQYZpv8CGC1zwglVgtnrN2hhjSTPQ43
	 Wl3wUDQJnwmzfCcC4aRzjIJlzMm1UioESc1/aTrJwTXL2EzurAtnZBq2gXVwsJgNLqlXP
	 kV2gOU24SB7vt0tsp/PGA3Oz0hyJvxROC/akkh5d3z/l4xYnt7qVTtcmnn25IX/dDdzoi
	 4Wc7oj76FAr1MvBK9ylXAs7WJy3qMOJ1nc33k036vjmcdlvzhk+5jjHzaPC4kAijgzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kH7oAK3c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.31
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32E606A89C;
	Tue, 17 Nov 2026 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB32E606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kH7oAK3c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfbhPcxJI0xnXJ3vgXlDOyATxCHCqFeq0fzZEH+Yb0DFMpT4sYZq6xZH1DihMav7HC+kGKmA6Sd0MOZBy5645A6uSYQ8Cze4E2p9O/Sl69ssWFOFSrk7fR/F/ze4dRGbBGFzm/IPZE938nb1dH/J9FZ97yFjm+cYp1qwCXzm/C4l9aB1ejFnzWmOBZrNp5KNOg4oO3sqT2tkMvDQuciw2moPJI7urMOpoxezPdK2iyZYok1J2/mFGVtCtsOZFfmp45rTin6emuHlScL0HRR3aZ/DqrhytwpzejbYKOz4K6ah19xU0Oms+pEb2Pr2tV4d7USd99zenU1XgZsDJ9e/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
 b=QRl4py9UrghpYNVROMHtfCJ2mLdlIzzvyd8YXZ3m8qhQP4wwPB/jqLcfZYFdr/j0m/BTQbxocZlMELJIBg4gvGBLUif3kOSO2b6b7Df33PyfbKDwVFfUxWfwQCeLZXIHdZ/yVT/jZNL8cSJNeSuSgX+hKKvAwkt+V8Icg7YErU7uLKzsx9PK+oAxtrKQLeEZRYavDxrsiflND9/+riOUUupURtELES+r+LafQ0FD41TDg9kCHPJWgZ0qStnDZF/jECHhO005lZAx0PLy8QRt6fwV4G2IfJbjS7rSTr8zPDXrk7+QUfo9KRpNyfAIwrz4nL9I5elGI5fYOGVmOqZKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kClAKwtb/qEr+B7xAWt/YbleAe5eKX6HCYjif4LUtY=;
 b=kH7oAK3c9f2pBxeuH1jlGj1XoGTH41OJrWlQjEiWjo3+GRDe72Fm1llwnCwWF2uVf7yn8IL7U2ejd7w+K20ys40tcfS5IlFm/gONCbz95J7K+bG2Su/T4/jvLIXJh2R7MfUcBnkrNYT+3aLPkR/ydhh3R5S7RuM6wTpM0tMMlmJ2XjB79S8S9Y7FdFimJD18nkgPS1K8uQyozaO9+ibnAiCpXPTDjqfiDTjjYH5wEeA/S92vvd7f9jsgUz6OV1wE0blUkgHxYQhsAZHsK2ke75+fBHsuKWOzRH7OayiQ2VZbapYQ7zm2wYwWAX1mVtMz5G060xF88Xmnm71etf0JWw==
Received: from AS4P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::18)
 by DU4PR10MB8711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 17:06:25 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::1a) by AS4P192CA0030.outlook.office365.com
 (2603:10a6:20b:5e1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:06:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:24 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:23 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:09 +0100
Subject: [PATCH v5 5/7] usb: dwc2: hcd: don't disable external vbus in
 system suspend
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-5-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|DU4PR10MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: f5424966-6adb-45b6-5dab-08df44cd1d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wh1Ppj0E/8J4ye1bJCaIg9zmMBI6RHLdCblBLhtZvIxDHHRtp/K0lu+wkY5o0oBqu3HLk0jsn56wzMTJ3qADc5E5ywBjNrS8pvA7rfh3CreteN/D2KngodeB0+cFx10P3atE+LgS88ckELHSa9Bdtb21twkzML54+eYdzub1WUkREd4wgrjJ2KbZJJHZXSW+j+MJHKbNs4kZ+Kzq1Sdxq2Y+ll3oZ5Wi4JhTeYPmT9oe6/1jknrZniPCEbXa7rA6fcu5Lyy21xObEmqNzGdhs9nicrd5fB7gGFiRlZbW6RBLf797XW2eLF7xE9DaN9DyFy8Y98SFL2WY/9iXrrmDBL1mNWmkfbU9lSYi3hrp49gfM1WpjMM94SJNkbSPyJy7K8GFVT0bw7piQSAfo5LK1MKTiZ9J/0FvE5OvwdaZsf19mXNxXlhM/FjyRGfNLG8lWbVPdp1GpTm7DeyO/+0jTK7DMs4kP/ArpjMCON0zphHcAqrg2YI0dVbvMq/6yHVij9+H+pLXyFc3I/w7TgqfyU8UHDRx9MKggFH5Mm4zflw4nM6NdaCaNhOu/JfDlZPwIVQjeE4Zm0gH+QLTSvSxJxm8cILINn9nXXeW4WnEXEzOzPwzGPdf1dCBTq7rLdNRUrwMPdI21HzeXd55mhyda2acG0oFQ+Nr9LlK4y+8+SqevLE2nT4blbv+zdZ7l7kFGf54zDB3KAQYxPgINgz6Ew==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	he/QBijzAhqEGfc9eX1ItbSxH6YOqY+ELm1gm3n0olD6TJ47F4qKlnnJt5G7J1096sKZX4ZQkinG+xs05xl2EC3iRMY7Z32FXAGr6G3ZHaL/5GnagerN1oqPbzXtc2ASN43DIwFujqaQ06x3eqPHDq8ORMifFTCrwzuN4wIiPTGhSNiCdWXIOAK04Z94VkalP77a13u4yo9z7K19buDji9ih0DXm499Op3wbioSlyR+5uvYis2FJG/c1m/qhS2ruZX4VrJMRDHnwd2dbvmlpOW9bVlCFTQiNGaHIdhRL8mB0MZlQ6l1YA22nDeFTN15T0pDnPRbriKMJC2396OdlZw0gLKCzpgOfzWO3i+OquoM5eVZN+lyadvsgp+dPaoC6VGtBE187DgQ62IjPWL0pf2uRK9oGGSINt87QE5n7oahzwy5MnyLSyRXlF+cM4tun
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:25.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5424966-6adb-45b6-5dab-08df44cd1d29
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8711

It's not required to remove port power upon system suspend, as explained
in commit 113f86d0c302 ("usb: dwc2: Update partial power down entering by
system suspend"). It can be addressed with hub ctrl (USB_PORT_FEAT_POWER).

When PM suspend flow disables Vbus while in host mode by
calling dwc2_vbus_supply_exit()) in _dwc2_hcd_suspend() and the core has
been put into clock gating mode, it triggers a disconnect and a resume
IRQ (during suspend):
  ++Disconnect Detected Interrupt++ (Host) a_host
  ++Resume or Remote Wakeup Detected Interrupt++

That starts the wkp_timer in dwc2_host_exit_clock_gating() that will
finally resume the port, e.g. call dwc2_wakeup_detected() and set
lx_state = DWC2_L0 after ~70ms.

It races with PM suspend/resume flow. During _dwc2_hcd_resume() the port
may already be in DWC2_L0 state skipping the dwc2_vbus_supply_init(),
leaving the Vbus disabled.

So remove the disable of external Vbus in bus suspend to avoid this.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Rename the commit title and re-visit the commit message.
- Drop dwc2_vbus_supply_restore() but keep dwc2_vbus_supply_init() to
  enforce vbus is present when setting PWR bit.

Changes in v3:
- Sashiko comment (state desync leaves VBUS regulator permanently off)
  Add a dwc2_vbus_supply_restore() to check regulator enable state
  during hcd resume, if it has been turned off earlier, enable it,
  so it is kept sync'ed with PWR bit that gets set.

Changes in v2:
- rephrase commit message since Sashiko review. Hopefully it better
  explains the issue, and why HPRT0_PWR is kept synchronized with
  external vbus supply.
---
 drivers/usb/dwc2/hcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 053d1234884b..40450b0a565d 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4435,10 +4435,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		goto skip_power_saving;
 	}
 
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_exit(hsotg);
-	spin_lock_irqsave(&hsotg->lock, flags);
-
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);

-- 
2.43.0

