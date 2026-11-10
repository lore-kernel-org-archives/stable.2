Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794305595;
	b=2Cy7bba3h39D7iSMZlVWmY2fZET5lM4bUxrMUXPCMHRoe25veo2pKs8ehHe2ZdbITUOL
	 VL4Wzthw5JdIGBHn0IOxNaPXyFsvBtLYb09v8257KcAWYSNd6cww1GtEn4QQ87s+/e2+Y
	 KQrxhpsDuRbljjdIeITxi+t8pT5B/6cXjGd2rLoPXLpD5FbjzQ/kBBBfKUqJWHPd5PTc8
	 WPzzzZPkzhS8zb6E3cKeHITgf95k0C9EOzMapvQQL4B8NKNPx5DrG9fK5An3xoa/m053x
	 xDCdWWIUsNAHfC7gH+3BRa2pALg9UFCpeMqEwFgO+nth19STVdWnlwfCuHTHd8RfXjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305595;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
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
	bh=9/nG/58UggFfe2uO9QMMBeLWjpJu8dLuVbabhL8V1DY=;
	b=AvIlX+VsmTHfZxPxIKjbFcrdBWErknjj94X/Dqw4Ra9pnvf/Z+2iNChzXzlWHGftdavT
	 vJstYWFT1KrO7chmz3VponVmo+aWvLOqK3myvDOvponbQeZT349JZ1y3MP3/m20Rd1UNa
	 S1m6XAA0mUHz9tZ5LLSkWZgircw85qxVU+cQ3csdAucCLnHCae2QRv/5z/UOGfBfQhFI5
	 MUtSBxWmWtu6z4+DYo4oPVPLoZoBWSuB6ARwnqqDQgH+p6HHWo/JbYdt9nakLxQVQTSn4
	 2XfYz1UYE0drFBGJeE/zunn6AQwpkOP43N1alOpifds6y6VyQ8WaMHmaa4Ew2ovi1sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cRZud1BA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.63
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE822606A337;
	Tue, 10 Nov 2026 10:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE822606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cRZud1BA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcMNP3FdOpv92RGR+6OkdOVs5LkaPslXototz8oRsHMls9hH4uAJc6xyx6idOEKl2zYpKIOnMsbZgHvZGI1Unf0JcZrRdV78y/QDlwM84dnTyGqrwmbuP8ybzEbmoPa0SZev37IKzjAwZfoATbGtpTDh2ZwBTgrjJcp8b3zzocPPD2ZY5NJf4GrbY0A7FtXH8GkgSuC5m+IrZJVDIy/NHic0xg2A79gOJkbwlhNHzldLbVMRf2NO7BqXoGb2JZ9OcccAKa9LsB60vV+ITHCiYgnbDjU9o8dChogZMnC64oukMIQw2Pt9KoY0BVTExqOJsiKGNk6Oqv2QOukZuAqwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/nG/58UggFfe2uO9QMMBeLWjpJu8dLuVbabhL8V1DY=;
 b=HuFtp0f+ciE+gIdJHrztpEtOUiB2Rla31HbtWd8FmISV5KamFYXOsKJSqWTQMp4Hrqn/QuaMQ605N/+bicOAUrmO+/uHPy9MlQXvee+QJe8E40IYV1Fj3hP4rWX+7Om1HsIKrCW9x+rv5rCFlZXwPQIc9bWkKU3OTuqXC9Y1i6BzEn2YblmE+RSwnLvMYRbv/jcqN6SjIIDYHEk75th2W7gwq0lsbl3Pt/hUrLApmPjO3PLtqY+Z1DxWbXRQGHN4NqujrNdyrj34STdHmMCSClxjPUr9sMPhqQg/iVJInzOxklofRc9R3dc8rAaBLOrwf06bypP81Kt25WaqZbq+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/nG/58UggFfe2uO9QMMBeLWjpJu8dLuVbabhL8V1DY=;
 b=cRZud1BAvnLC2tjxrl9GJttK2hwq9qimf3NOKqu/VGL/0WS4R6flS72+oi3c1AvKk4LaTRkeJ/LOCBN/X/ukB0XgJB1TxYv0vl7Xu/Pz2jBGNLUhuujKxwXg1VHCe6a18fgAT+m+dIm4qqxuimxqx6+PArkOrKbz2uOBCiEp+ltDAeLW9ItKtb2QRlg42VGXpwTHJe1+1QN6Fg8UeWXEp3r2AGt80+FPDehYAoCzNca0FdDeAZUKiONLOaseYyGFMjIwgPgaGJQQkEQPx34dnMsWGCFPOhw9l7zSTck7yp8Zg9g580rmNO90TpYLMswrYehGFjV8pO1iu09gGSLvCg==
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by DS2PR12MB108293.namprd12.prod.outlook.com (2603:10b6:8:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 10:13:10 +0000
Received: from MN1PEPF00079401.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::5c) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 10:13:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF00079401.mail.protection.outlook.com (10.167.249.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 10:13:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 02:12:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:12:54 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 02:12:50 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>, <jbenc@redhat.com>,
	<linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
Date: Tue, 10 Nov 2026 15:42:46 +0530
Message-ID: <20261110101246.3665797-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF00079401:EE_|DS2PR12MB108293:EE_
X-MS-Office365-Filtering-Correlation-Id: 74185d4b-1629-4f20-316e-08df3f1338fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|56012099006|11063799006|18002099003|10067099003|261009223027099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261028144727099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	8CgwY4Aq9WC1nd043MKjiqEdyA4ZamCFA5QL7INnqyY6BJNH/AXDcifX2c66RYckkNcHlVTAeC6OmRtvN5WmbidBGfJndxpSmekj+V6YR+S0u50+ffyVYyxFqQaQCbJ+HEw2EC+vbKZFI3UpQWGOBBbJfBYcEyvRj8M7oV3UiBkF1FOUhcxJdqey0HpvYVyxEm3e1uv8cbUozEb4Jk3eJhbqvwogCPq10rJ1sgmXpg8yRuMoiSws5vLHoyMEX5uy6EEQBJcSmcHc1rC4ilCkqh3QADGocldY2g5ZJbeAkbruqAPO+MNHr/464r4dQ4rpVWY6U2SIP9QH33qNTiUCSRxxHyHs1xcaZsYFmW12Vme1JOr+zAwP1pMkoavALDQKIAUxONzIvm/1x2lLw+OeUHeuN/J54L11ibIL9Z+zuIlOyxClvOpp6Bf88p2Zt7L2mEjLn4h9tPBCInsCqoDqCRHunzSGAE20dPBLOzITuLb226Yx+hJJz6QPBON739tMwgj6yD4rl7QuLr3z+U1+d2TboASszHz7L4iUTu3tIScQz2R10cZSyWt9TTz2adugBSH+xnh9hjPkBzmB0Llqvjp9F0AVFDvnJalQMvnzXniznBQ88F7gK4kj+M6OdHoTiunoKEoPGWYYFFPL6fur1uoWkk88Adv6v0cLGRQ66ngzZ0u44w2WspGAcjMfPC+jkAJGkElA1z+Y/ns3777ZMQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(56012099006)(11063799006)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fw2V6ZyeRXumNIYwUbsbApZq2v7MJlS4n2/Q/NZh7ZgBTrqsDiDpXA1O0cvu8etncrhOno5W3vU6S6MGWe7UXWVLRjxSeUvutzHXHR5nsWFPfR5Pp7M5f+IsbXY+kQbUBrWWdaKrc/huP+nYG4vFlSQ4Ufw8fazS3+awkPrdun5YjYkubqcG+x6g+rxtCjhnDkUBUK8HJ5wqWCQ89/FqhROI9iqhbwKtnESVHsUZ2EidCeUCWn15eq2v8KGxf7Ki5XmulJo5dtIaNxDbXDSfiRJ3ZbU+MRUlfWH7e7Tk+ZGRcHdk/ywJiz9wGLpMpSV/I86kVWxdP+EGSkjMqj8zoTOgiaclUJBAcqUN6H7Bx+IbAjCnCJ60ORz4cVu8EMBK+1cyMmOO5dghzjUfpnanqrMU83rWd60SkowWtvwho7IWUP4+3yKaU6ql7oMd1m32
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:13:10.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74185d4b-1629-4f20-316e-08df3f1338fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF00079401.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB108293

As per ACPI 6.x s8.4.6.1.4 (CPPC Enable Register):
  "If supported by the platform, OSPM writes a one to this register
   to enable CPPC on this processor. If not implemented, OSPM assumes
   the platform always has CPPC enabled."

The driver never writes this register. CPPC therefore stays disabled
on platforms such as NVIDIA GB10 that wait for OSPM to enable it.

Call cppc_set_enable() in cppc_cpufreq_cpu_init(). Fail init if
enabling CPPC fails. If init fails after CPPC is enabled, disable it
again. The register is optional, so -EOPNOTSUPP is not an error.

This relies on commit ab482f1bac6b ("ACPI: CPPC: Refactor register
value get and set ABIs") from v6.16. Before it, cppc_set_enable()
returned -EFAULT instead of -EOPNOTSUPP when the Enable register is
not implemented. On an older kernel this change would make init fail
on every platform without the register, so the stable range starts
at v6.16.

Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
v1 -> v2:
- Fail init if enabling CPPC fails and disable CPPC again if init
  fails after enabling it (Christian).
- Move enable after the policy->shared_type check, so cppc_set_perf()
  is the only failure after it.
- Mention NVIDIA GB10 in the commit message (Christian).

v1: https://lore.kernel.org/lkml/20261105123244.3132560-1-sumitg@nvidia.com/

 drivers/cpufreq/cppc_cpufreq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 957fa7775260..b2af24ae5008 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -714,7 +714,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		pr_debug("Unsupported CPU co-ord type: %d\n",
 			 policy->shared_type);
 		ret = -EFAULT;
-		goto out;
+		goto out_put;
+	}
+
+	/*
+	 * Enable CPPC. The Enable register is optional - some platforms
+	 * may not support it.
+	 */
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP) {
+		pr_err("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret);
+		goto out_put;
 	}
 
 	policy->fast_switch_possible = cppc_allow_fast_switch(policy->cpus);
@@ -742,6 +752,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 out:
+	cppc_set_enable(cpu, false);
+out_put:
 	cppc_cpufreq_put_cpu_data(policy);
 	return ret;
 }
-- 
2.34.1

