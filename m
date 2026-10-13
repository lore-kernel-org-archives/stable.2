Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA50B8AC;
	Tue, 13 Oct 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897363; cv=fail; b=XfLstYiFt7VyuxyRBbizj3LesCmJPtlMx16AQh8w2EhdPApdGirXydilP5OCshJyxaKsKKMrXdTpxgpVzVUoqmttirCuxG0584mfXFrM9cC+XtxWO8zVFjArfGuUPx9Qp5khxYgHkfg5zHhiB+nep0Sl6uRBQFXXfBCl1mhDboA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897363; c=relaxed/simple;
	bh=Zxzfk9cRUqU3X1h3tA3+BssCisplEg1+yXs59hxihp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Oq5ymKmWeX1c6qR7XRk+klRaia6xtUUw9Hf+YK9Qp9AuP0V7c8OHIuwQcapkiMpV06aBSlWJ56N5e/R7MHfQV2hhnSExr+6Ybwq7MlGf8j+U9xagWU250O9au8+WoFzfkmfIfXkckD4MV8JJ/eiBCn5vP8wZjkGsbDe6DuRdu4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dMMm31QN; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dMMm31QN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui0pZfPBuYfaw/OmGpYptYbfGlrFwDBQdg0QmcpD6UzEEmlLGGR2KwLRmAua2K5PLv2GjiHX3F33TelBahwEp0LKBeY+TKEdiIXkDE3hwFEt938dDoAlehfnRHihi+cLo+20MDP+QnRVrThGRivlD25+1PhQWN1/49jjD6rW6RHrToS73fpYW99UziMHOJZf1KZMg86ki8yBhb4rRfh/tVo+o27c4RNQchaH2ORxfmJ0M3BzwgU45zN015KzWzrrdgI1GSFbcKGTuY38LpWWV6QUQJQrrdhflAIbYKTl/zk6enTp9JgiDjW0s5H5xPxwSNZPTEo1RJLpKojSo0Tuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHkOW0UXj9mIjyQuHKHTIKaIN0SrAcs+qdffvilkksM=;
 b=pPujUbZKP3aNKwrJpZ3jxkOKOa0Uk2VfHhXIFj/6IIkXTSvU7CuyVGFK1BXumnRVjgdAfz667Qr0+Bf++SI0aVyoHuvTIJn2xRG4amis8rTBSV5BJudjbNWMHzXo/DD7+8JgrcxSwmegXA075Cs+StTtfmipbfP5C2AHpz3q3bdJZsA7HRFJ1j/9PBGs+L2iLibBz5Z8ITiRdnY7SCvoVYKI3zsZLZq2l2+TF+ffdGKK6Jfl7G1v6IK0vNqa/f0Exo2rp2DCrAaZh0LP1I9ie0U7jxmS2QXf2ENI4Iq+RbmxMp9eE06uj206fy9TvvsSM7WXfX1pxOFual67Y1F2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHkOW0UXj9mIjyQuHKHTIKaIN0SrAcs+qdffvilkksM=;
 b=dMMm31QN/YD0eUbN9quyo4viNcUb84NfgyYmVEYyhAYaAgLva4DuLXmPkm4FZKOCCQD699xJsLBD5tKdiMxpPg54cu2P8Ol3+ox2VMmPo43eXqcEzht8Jv21fw+HHlWXX2FPHpETIsMQS5lqrzsMxmlsKgiN5f1xHrH86dFcS27LPq8bwflcK/iyNDvsabG6WhPoZhFev7IdSpMRPuuz9b8b63dh7qXF5CO8SFMdfibQq+KWHXWJ1pUWrV3Sk9icUjdKcgA4npvfH2EbOjsA6zdDE/VBkyqfEKZvxk7edtalJ+sbozinxNPMYUzyttu/2TA/fPTajTNt/g3vQZxpyQ==
Received: from AS9PR06CA0708.eurprd06.prod.outlook.com (2603:10a6:20b:49f::35)
 by DUZPR10MB8268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:15:58 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:49f:cafe::1c) by AS9PR06CA0708.outlook.office365.com
 (2603:10a6:20b:49f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:57 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:23 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:56 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 13 Oct 2026 15:15:07 +0200
Subject: [PATCH v2 3/5] usb: dwc2: hcd: fix possible successive vbus supply
 enables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-3-79865a4f1b63@foss.st.com>
References: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
In-Reply-To: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DUZPR10MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edb604f-d72b-49fa-a5f7-08df292c1e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|34020700016|82310400026|7416014|376014|10067099003|11063799006|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	W07FWFDI4M+Fpwoo4hQKw1fspFfYLxkEdsl/wVh38TVw3bFy3BWSg9/yyqx0YfFPfL6HAq2VPEz/0AOcytkbHdGLKrX2i1+3iq/97UFVmy7ckS4uztXwy6otVZU4O190q7raXVVyMKTPq8Bjg76El+eqyzslER1r61odwuoFdNWlbEob+pqc/Wq27I5Q6CXHgh6XuAbMVhY/s9qzvBan/lR56qWzpjiKUfAYEEMileseOnjyjeUs7khyZ807ikIdHOOQQ8cuzizWtcx117826qVFgcb3dDznY16ZecqUPp33ZCfeoNlFiahLvTLe0GYW323Lt6C+sMKFvhdiq89GYAkmTR4m6fBcXcLUy/14S4K1xIBApWAkSfNiliTPuXZl5TBU8IgJAqg9CfvhfyGQpbi9FOqr8SlD3YDcFtDBO4idwcAvdgzA3a6DK7DHOoSQjuprCA1mwCYFIMn9o4spmMJ5YJgnPc59QscwwCQLXexfMY4FjVSt9qS/0uu01TdClA1vy9TyCGx5xtbk9Xmh5JfYZnkE7erAuT5k8/zod2TJ1C7mHIUKeDt0KdI4hMC2KpSGMlXOrSRhCVrK4RO2EYi/ImfwBDq/KWx3hHam4n68JF3JhYXTYvkHn7T6ZsyEDYfxZf1BPYdv9NFW9nfxxIYEqNGepeRSB4Ib9SG7OY8sS8EmsxA3PcxD8gwqytaEwFo7EgIsPxMwv1qyn5ZICQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(34020700016)(82310400026)(7416014)(376014)(10067099003)(11063799006)(5023799004)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v2frTEnzJne5o3pNXx9kU+UDkQ39YBBL1+Boo6z31yaiDBVVemgv6S0KyhCrBFO53rpXb9h6/V2zm5PgSCmCnuMCw/jdcymvnRzFhco0XR/lKnFhZ8ELbKcvfJQ9bGUCjrJiF1tToSas8EQEejhLumnJIOgTIKrwI/7tqdyzHcyonFHt8I6th0fpyUzmS3O1qodiBORIefbLQN/02IB0x3VDm47PamS4inhnc/wIakc0qLo27cGAGQ9OhutBAVJKhPMi3MhAOj6yJPv+wZ0ggPiL7vTyL8EYmYAGJA2gmJqkSB4aQcuoIUuT6SiC/jzUuscVc62/87qFzObD6yYQVWZ8lKLrah1/Y37UwLN/Hxk4fkaIaAu+sKJCv1Kd6m5th9y2AMTQz7UWJsgDsrN8TYRuWceWO5R6RefLDQLj16KBABctxhDKIDdsx5/7NPFY
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:57.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edb604f-d72b-49fa-a5f7-08df292c1e8f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8268

External VBUS supply may have already been enabled, before entering
dwc2_hcd_reinit (e.g. the controller is in host mode, without any device
plugged).
This results in vbus enable count to increase every time this occurs.
As consequence, dwc2_vbus_supply_exit won't disable vbus upon suspend
request.
Fix this by reading PWR bit before and after dwc2_hcd_reinit() call.

Fixes: cd7cd0e6cedf ("usb: dwc2: fix unbalanced use of external vbus-supply")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Add a vbus_was_off boolean to check explicitly an off-on transition
  on port power, to enable vbus supply, instead of relying an XOR check
  that would be symmetric, e.g. wrongly enable it in case it gets switched
  off (1 to 0) as reported by Sashiko.
---
 drivers/usb/dwc2/hcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cd0dc876b421..05d5d7265e42 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4249,6 +4249,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	bool vbus_was_off;
 	u32 hprt0;
 	int ret;
 
@@ -4264,11 +4265,13 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 		return 0;	/* why 0 ?? */
 	}
 
+	vbus_was_off = !(dwc2_read_hprt0(hsotg) & HPRT0_PWR);
+
 	dwc2_hcd_reinit(hsotg);
 
 	hprt0 = dwc2_read_hprt0(hsotg);
 	/* Has vbus power been turned on in dwc2_core_host_init ? */
-	if (hprt0 & HPRT0_PWR) {
+	if (vbus_was_off && (hprt0 & HPRT0_PWR)) {
 		/* Enable external vbus supply before resuming root hub */
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		ret = dwc2_vbus_supply_init(hsotg);

-- 
2.43.0

