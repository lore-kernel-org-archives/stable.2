Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45874A5C41;
	Thu,  8 Oct 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466471; cv=fail; b=AqLuI4bsZTdVPD+4s4SDp25TncAuhBo41608NmcFQ192vnrg8GRBw1n7sR/gOH3vQ0QwUpPcr24vN0ZeSq8tn8N4Jd8ML4pPvuSWzXbNnCIR2kRB4VDLIufE+NdjaECTHZo3jnMziAyKL4FavXiB7MXvDD7negZ2oTHsvLeeV84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466471; c=relaxed/simple;
	bh=kxV/5ndkcGOCPPy8m/neHjTpvhHqpeyq3H6LcnwVMzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NLDehRzxsxu1k6p9+Sg2A4Qp5nWhA5nHLvCO+rZkoKMGJFuaKB/OzOGrb4NpTJr4pemLCFc2Bys6OFOeK9yVu1/VveAhMd9ixP06NME8RMtqDA8xLtnPzOV8FgtLcIen6EzlmOQRm5TcbDrb4lyE05SDQEV+GXZu1VbKrcNtqyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eD8zI3DX; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eD8zI3DX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcWxFoiWEdftJ97Sa2Y+aZDPcOwfpOoStsn+iH7NzyuX+XfgiVkLzeakjS8DTEuL/vmaxNS55w1YPKmxdFYPvuteu9lEwkhZCRyCI3dDvoLWMz3lwSQ/4NMRKDiOGV3UU8RZHEUMepPHrHNribVS5dHe/aLzwSN+CwDO/LwuYJsVNA1lEMWQVQ0gyOiA1JIUOXT1HQYanNbEG7OohvH+l7GlwQ8PDR4/0ak9o22qeM1p1Ae7qSoe1MyHvmIPUXCOh6O/RZY2QfNowZUbNouk5dJNie+IiePYpV9x0JTbLe+vSkgKubT6QRdR+vHJawaLAUkdE7KzkvhWEzIgUC3kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPj/X0qzdQDnsd2z7unmLuAoTkq8VfPD9cTzNHB3+dU=;
 b=bcuMi/zZ6BcBXDTbHE1i5lQeF3HwSPPyTpzD33/o2BxvyswDaajQFfxWYkyru0WtqwbOo1GW5jIg0wMUAdF9gmEuOo/0F8M7UaFYWIhYruM6e2VrgJ/67SGnbjiGjvREo6hJ/95ocSWPJp4tObpJNBPopwKRB/e2Aey7/n5jnNLemudp4kiZn7pmCP/9qxXKVViLiLD4jte5UvgcyTvA/1rvAv5QBUEr8Qtzqq5lX+ko5G/2OMWJg99CuvyXoPpQ1tDSZYkdBdhLwZ+w7mPCoHgV8Zqz2aBwOpGsd9EdJORKvpFZXHfiP/BWXnAiEXOst1U4FxfJjjuYX22bp+HNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPj/X0qzdQDnsd2z7unmLuAoTkq8VfPD9cTzNHB3+dU=;
 b=eD8zI3DXWly0a2hnkaYxo42DW/Gwt0r7WJQKIbISgfiE9th5Oj1pAmND/QHqmDEvDnZNjsTAAM21ld5CwF+xjd2E7k3DSh4yKP7d0wVOnkrZrMknRphDEFA33gZqC4Vw8ktO3fPVec73xxZp2KyYxnJxBgnVk7FcqIiDqnJtC6BdUVV1HiLiAQ28m8bDhhkGJptEaqjDFEd04YnTe4++zRD3Pw+6C+8phaHIWCiAseJyGIIjUodqb1R20O7P1PfMZBIkzkAlW6qhSfKnh3UcQTzTknB3Ba2Yuy+WT8c6pq/h3jiU4UeZy0d+yjTg3VdrPT4RAD/wa2AWeRdTtq06pQ==
Received: from OS6P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::14)
 by AM7PR10MB3735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:34:22 +0000
Received: from WA1PEPF00009B38.eurprd05.prod.outlook.com
 (2603:10a6:e10:31:cafe::4c) by OS6P279CA0047.outlook.office365.com
 (2603:10a6:e10:31::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 13:34:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF00009B38.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 13:34:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:40:27 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:21 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 15:33:19 +0200
Subject: [PATCH 3/5] usb: dwc2: hcd: fix possible successive vbus supply
 enables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-3-5b303df762e6@foss.st.com>
References: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
In-Reply-To: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
To: Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay <amelie.delaunay@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Felipe Balbi
	<felipe.balbi@linux.intel.com>, Jisheng Zhang <jszhang@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Minas Harutyunyan
	<Minas.Harutyunyan@synopsys.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B38:EE_|AM7PR10MB3735:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b428c9-5a46-46bd-31ba-08df2540dcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|23010399003|1800799024|376014|36860700016|921020|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ge0OMvJHHOn8hny+Cn2gpIZmiJXIy0l5T0uKIoE3fKd45CmKNQ/1f/oCSJYQ7+ZDpQcWLqcCq4QKOkqa9CONr2OkYCa/vbk1kwkLw9cgQnhNC4UrtZxucrFCty2YD8JV+lCtekbrBkoWxBKA8blzYNXjFi2nAZ7fbMvfa5qM0Qy2Vg7gHfroRdIFgIKfXk2mKXjzgFdi/6mBErpjJDJO9QgL8inJNko6U4ciqUW+qTQKRVt8DHkcVLAGBiD5eJljgfFlcpMjUi/I8q/qhnFXNrAbY/c8cR2Qo7G+UmBfAUQo2SFa27CfzaFzqsnZuQjLqGvvW1Zzg0wySRPENUNB+dmx+Y+8vbVp4yV7yeodH6RIHTk6FH1Yle1PJLd8mCLwmWPMk2rorJTz7xGwTfg84K+B4nMmTPZJufvXoEhOR0hvVrPqimazUAaO32Fs4MPem+dMGa/1fdS6DH78AfRMqesRthxAeb6a7N4mkG3dN7UMfiWwBLvirBgM7ZbfmjuUkXix9lzl8zF8U1WqKy8ScvFYZTaEzhTIxxM78SCiH0DzuQPHUyQ6ibbJyHhCOHoe0qBRvEspGI7NKXaUgPEm7dmLR18uHb8lDBOnjUiJna2apyZXENqEed/+0ScnnWwYHCk46aVamLS09bOnN8/f4nlrJnPmep1R97gVU5XYYSXzAz3C5SsFq8sraJ+/3ROPPJ/5XuJAnAvrKBGduQKzQ+as7HTd04cUPg5fZ72IxpYg68l56DdbfubZyZ7Hhxy0
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(921020)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yP1oBLGozlLycJ5tgQYnBzVZbrM/MKH/nDuMLA90Oyt/wqVFZUXbETkRp9QcUxteWO8u5PNcjmNK7s4MHvA4kKxhYX7PLp5ZH2jrdrkSP30efAuAKhdDBCf+QfY2vAzXOHOfwm1JbFnRu2PhVzYvlace+W3WZVi9ptergTpHwvhTe1/xUxJYb61skRQmgR9MfJiG3/aU3iY5QSLQLJUvgpzbxsxO/TZn8tPAxYJYLQuaErf8EaqlyJnQj9zugQqLCIYiUmc1HxjYC8GkMWwApEjFCoViUwF6A9CCeC89nCx55JOmIw1RhIv3SBsQCPi7ZVg7o34R5yZ3ROc1AMksMlcfn20WKN0HBr4WttNbmnfrJ0cof8eb2KPMGQD2rUHhIO6xAyJ9iIAPZeEEc4pHMSGpIqKPPHmOp+IxHNcNaoPU31FnAHYyDAwwM34O2JzX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:22.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b428c9-5a46-46bd-31ba-08df2540dcd8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3735

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
 drivers/usb/dwc2/hcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cd0dc876b421..4ab058e6ef9a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4264,9 +4264,11 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 		return 0;	/* why 0 ?? */
 	}
 
+	hprt0 = dwc2_read_hprt0(hsotg);
+
 	dwc2_hcd_reinit(hsotg);
 
-	hprt0 = dwc2_read_hprt0(hsotg);
+	hprt0 ^= dwc2_read_hprt0(hsotg);
 	/* Has vbus power been turned on in dwc2_core_host_init ? */
 	if (hprt0 & HPRT0_PWR) {
 		/* Enable external vbus supply before resuming root hub */

-- 
2.43.0

