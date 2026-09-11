Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E538E12B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130038; cv=fail; b=sZuqYq8VBuJjk4CHX0u3luHs7cgBXe9EimE4aiBbjfUozUHV+uFpyLzi008TjTU5KOaAk2lfzI6FcT5oa3EMgJNzAycZQV33CQ62atlaCx1VWJsvtI+k9yOU3e4t7uP1h7TOqS6fW6XIRgh8sgwlrJsL4wwuTe9q7D8BpbtQJQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130038; c=relaxed/simple;
	bh=k61khf/z42kXb2YwFOP+Xpb8aqWLOoGFO90jvEb8sVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B9eoH6Fb/CcJPBNxBYdjrkN03kqW37GSIY9usuAJogtZhLeJHpW/uwc1HGoXBB8rQhrkl/r9Q/djEEo4c0lx+3V1AYMEoYcdZlZdM58Tg8qMYmgZit9hZIuLW4+mlYcM1ffKXM6qqSX2YpRTcZlpQYzVrw4UcKWu2BRuE5cU3Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GPgBxSr2; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=sPfFHeaV; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GPgBxSr2";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="sPfFHeaV"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B4tDLu1417309;
	Fri, 11 Sep 2026 07:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=F6/lmdN8IBoheF+u
	ADOpqFZy5Kv73XEjq1KkdNZ7Sjo=; b=GPgBxSr2UiccS96YyGgz9EbfdgikJggD
	ZpwGQr0GAFKzT5GOrEjis1toemo+NNsqoRF0b1sEz0CZaNZ1hMCOzLrLMLORgDTh
	KFRQLcoU07tEgQg+Sp57QzDAsrAZ3ZPq+tSf/iVqRvcIKDkbs+4qdy5COJR/HNVQ
	82A84d538Z60Rlz+zbThVlZsiEyILQgLjp4yMl/keILonSCNssJg9gEMfnK2URMj
	jztYFdDnqTAQBHFWl1sAgKADGVnTW2quPAIeezBcv/MNwcqdRSjVIypUki1m3XhZ
	y6HEslf66RrKRBAh9xCjsJbhfyWFa90DgqGTq2sT7lgsB1I6yh3iLw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020093.outbound.protection.outlook.com [52.101.193.93])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gkcymtm7s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 07:33:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgZ+EH5jYH15/kQ7Md0Z1vFb3DcEadR6Sd8yiTC4dtDxTnKkcSitqT9ZyOx07+AxF2FrbNnp6z8hnsacewzGTQqPkCmmYIgFzOXCnYY7FEZP2+xG2DYY8mlPpH9Ahe1vFm/F8IGiHbopon212Q8ivpTiajuWPFNBgTfeZtCYcInijh9GHXvGQGeeDg5ItzU0vHp1OWsBOD9LGO3jLsxlbg1Uxw27BIndUNCQbVfzoxgVghDkguNGNoOjU/fC0e0/1e9yPyvU189fEX+T7ywXsk5gue4NzIk8DM4JqRLA4isexRMiTXocetiFeH6JncXZab/HLDlc7Vcb46JwDt4SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6/lmdN8IBoheF+uADOpqFZy5Kv73XEjq1KkdNZ7Sjo=;
 b=ebtdxNXwG/YIxeLnNB9HJf6TYUVGOv+JX+l1B9W4tKUNg3gSuZjIOV0rVF7m+Mkoik30Dj0PkbXz0EdLZRN73mjav3M80ebYevXDMvPdGm6MoMooHMkwPW/qxk74xFaItWIpJQU/amN9MeuzSYJEbhp3yuryfzjgSFLLz6W6lAqqoiMywnVWeknNWLN2p4sLKuLsz2Gd3iP8GNHU2M75T899U85sW/68gSeje44C4xXRgsbTZo7Wt59HwYNWO3ChwM9qgdkn4TFc0RcVNiVKtMManOb2CYLXa/ANRG9R4ue4OI9w+IhiPpqeXYJuiJk5wmV70B+GZ8mDO3vWmM8VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6/lmdN8IBoheF+uADOpqFZy5Kv73XEjq1KkdNZ7Sjo=;
 b=sPfFHeaVavEMjkvKa/s2mlxd+OGPehzedjvnUe8dJSc72XkIp+duBzo6i0tY06XR3XWNm7bMK3JuAaBvcUepmtzvE0x2dKsHeDOHtDGnVYwx2sHIBg3GTweHdr4wJCffV3yFy7VhM6ckeFiMR/R4I/O0FjJsX19Dw7RRLadXktw=
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by PH7PR19MB8216.namprd19.prod.outlook.com (2603:10b6:510:2e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:33:37 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::62) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 12:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 12:33:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D15D840655E;
	Fri, 11 Sep 2026 12:33:35 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.12])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BF26A820244;
	Fri, 11 Sep 2026 12:33:35 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: vkoul@kernel.org, broonie@kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] soundwire: bus_type: Create IRQ mapping before calling driver probe()
Date: Fri, 11 Sep 2026 13:33:32 +0100
Message-ID: <20260911123332.4035153-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|PH7PR19MB8216:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2af3ebe-7663-4035-222f-08df1000e721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|23010399003|376014|10067099003|16102099003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	kxyRoDRBcHcyyQ7gu5YUyKpmiBoAAK835RNvoDsMJtHHu3ZE6NpJjtUS5qGeKqBCOGPddegf96njz9LXn+UE9wVqUz7LyQGPwuSY5moP0+8M6UcwGFJIse8dgAxvy0/hANypJcF6bSB/Soi+eZxVm4Odh8mOLcQRHIoQwv1iV5pIKEl2Kl3rrgjo1bRY+YXMDYj0MqxzWE50HJDJRF4V9umT3HArSu4IMg/1V7c9LqQjIc9zTb5zMWx9S2b6jVnrqXJkK8dVczFdutMqZSGcIH9xT3vkKg8X+TtU3ersTJOtv+48l2U+CfUOyCE9lVVNQBuvWL02fNeGOzl4+I160moxXlNNHLm8hHpPjnslIPDEyNuoOYr3yPNq2s5wNhTK8BGkbW7Jv/2bU3PzuRuaUXu3+v52Wp6xh4QX4qayvTo09mEdp8KKEvjcse9fQByTSSK31i/BNluhiAURsHjDrYS6ly+ajQVrMH2qhmYFL0BDHnBZl/wRHWnY4GhDn08ZDx9yIeV94C0fyGkMt9DX7JotgVhzhD/sTAutlIl2APfVAhg1FPIRRtCo6peyNz99wv4ST3tipL+wLGOZ9NE/c/t6zzuCBMkEDYN/6FNHDerXEO7/ggCA6dvNigOl7OjxbvRQ4Lw8pfWVrxVwyR5BC+W+sQ+HSow+orSjf3oJX9k=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(23010399003)(376014)(10067099003)(16102099003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QTbdTWksSCdC1J+wk8BlpHFpW0VNROoeEflFD5E7GL2+XYqoWq+quZU6fHGnK4uR44s+xfskywYjMJ2LTmumrA702FjYtZkXrSgcYOi4uh2SV0ihnW9ueNBGrpmiqA6Ra0lNd5xil14xYDtlI73ua8b2gPPmdljSSHkHbjYWHOFrz9KZF+8h1DoWy9EclsmJeFjd2KV9x7I1wZtwRdPid03YisaRE0gXXtJflnxJV2+izSdRXp7p1bmuPdf0EzQwdhQfKt1RLjn6pBPKrin8XIi6W3L85ulh0XzmHW41WNfS2GI8P8qUnk0ypq60s2jOO6VcVDQ6jzIkhduYgCGN7lz+UGi1K8TDV37fHQ428sT6HnsVbLqpYEvOIl4g9aRnwd75G+Ncu5McStnV17lSPcskr45ztMHa+13rInaUF95WRJgv89pD3BOv6WSSvihC
X-Exchange-RoutingPolicyChecked:
	WLRozr+TjB+vVfVTtiaDtMRRki6E60QcZXe1i2fjis704tksEnT6/02QN6hN0dh0ABNP1dxhpHkgCCmi8Y3JnOSBDdxgVSxKOt9KBFw3mJbuiRRYX90PhvfHQ04q7ZKiYph25SReBHsNi7Dn2UjyMcxIcBsJWL5Z7ntKpWEkVmG8NugZYVbIlw2l/TEFLQ7B+6vD1tlIxYZljN5bKtStEBIdhTTvKQq169Tx+VRhFqCxi3CzdUxpuEnUdREccPuuxgzLrJZnQqIELBALHtAH67Z+Vg4OFlG7XjvllMQUmjagq1XjtrTHksOQbpLSGjrBQD0JaWUqqloEyzC5DfA3IA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:33:37.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af3ebe-7663-4035-222f-08df1000e721
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8216
X-Proofpoint-ORIG-GUID: SCkjRF_g3Wd4up6kTeI3ypcBEySaHZtl
X-Proofpoint-GUID: SCkjRF_g3Wd4up6kTeI3ypcBEySaHZtl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfXzwQkamS/RJ0A
 WBqz5EHHB+l31bz9dwDcJ7Y95QMZjOIlmGiltHuf0sDRiZwcBlQK2K8+OZM0KEEL1sA/i7CwB2d
 YVI6AAWqwLcqY5QaDvaKGEhSWuBszsg=
X-Authority-Analysis: v=2.4 cv=OKiyTiaB c=1 sm=1 tr=0 ts=6aa3f526 cx=c_pps
 a=XmpCLDa7gY5zTWVzJon4ng==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=bC-a23v3AAAA:8 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=lJT6-VWALbPN8-qIYjgA:9
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfX99EAnbNkzeZU
 X8kpF7LBES77a9eRrUgm8HpCMtJXFbb8Ui4hI+30/EuX9Ik49BDr+CFIqiqj3mV9tZQk+DIfHdJ
 uiNdnZrSgmlGc5uJ3t9IiPlniZx9IWyMclfcMhU56jIkPh7VmndIdUigdRNMfEhGHlhbOBKNoJx
 r87DzpTJmqoP8Ua0HcxOjA7hxq1m+jhpRDcc4BzAGRel0x8JB1SXph7P0oMatV5wefjceitn7OL
 jBg9OxU0mezAIVW06b/hDteqFkxG3p5DwrUy141JvojL5NtRRFD0VmTICyOSxeSlbcC7321SWN8
 wTWNMrHe5noLWIdChHtJR0LDsRxABWuFmlqeru46TkhaQbKPv75+cnoW2TK0M2dwzGIXrmoiWz0
 SQVMxELuLqyuXUIk9WqMe6cBDiin4widq3J+yC3Jds6ohNejo0OGmC6mblxUx6jm/UOJDuQ3h0N
 bmVke464U3Wyez2EO3A==
X-Proofpoint-Spam-Reason: safe

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit ee1811eacdbba15a374957c2bcc6ba7102e2b781 ]

Call sdw_irq_create_mapping() before calling the peripheral driver
probe() so that it is possible to request the IRQ during probe().

Previously creation of the mapping was conditional on the use_domain_irq
flag in the driver properties. But these are filled in after probe(),
which meant it wasn't possible to request the IRQ during probe(). This
was ok for MFD drivers where only children requested the IRQ. But for
normal drivers it led to the non-standard behavior of having to defer
requesting the IRQ until after probe().

CC: stable@vger.kernel.org # 7.2
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://patch.msgid.link/20260810104045.60701-4-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Backporting this to fix a race in the SDCA class driver. The SDCA class
driver probe kicks off a work item that will request the SDCA IRQ, as
the code here registered the IRQ after the call to probe, there is a
race resulting in the SDCA class driver not getting its IRQ if the work
runs before the core call to sdw_irq_create_mapping().

Thanks,
Charles

 drivers/soundwire/bus_type.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index e73c1bea90593..d61a97c5b41ef 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -105,6 +105,9 @@ static int sdw_bus_probe(struct device *dev)
 	}
 	slave->index = ret;
 
+	/* Create IRQ mapping now so the driver can get it in probe() */
+	sdw_irq_create_mapping(slave);
+
 	ret = drv->probe(slave, id);
 	if (ret) {
 		ida_free(&slave->bus->slave_ida, slave->index);
@@ -117,9 +120,6 @@ static int sdw_bus_probe(struct device *dev)
 	if (drv->ops && drv->ops->read_prop)
 		drv->ops->read_prop(slave);
 
-	if (slave->prop.use_domain_irq)
-		sdw_irq_create_mapping(slave);
-
 	/* init the dynamic sysfs attributes we need */
 	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
-- 
2.47.3

