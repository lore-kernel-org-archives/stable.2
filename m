Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793881993;
	b=ZixjYLjUQBU4vk/8iHKUNurDH9UIxl2qYRy7hexkGCFzlIT722GaMLs4YBG8Faq6Jy2/
	 K6fr6qL5MWov1Tsl5X0cQ1WYLDDcLGjXBWbnh+3QpFDPZmJtNOnroA8IjImBgSm/evZ2j
	 jKtf+tMh1lm6F+b1g73SgE3c+OiYakrLm5/C28EIZq7xKajil0f+al8i9dOURWR0nxBZi
	 +DwDIHy+ZUtbQ4rq9N0kXN7IDS1amcigC/jmrD5/N2ANWO5vryFk5qBtH+VPW/+xI4MV2
	 VD3zCX2bx1Zuo3D0wYW7s9vhGZP8nK0WZLr+TPBqTFg1hZlZu6AG3pj1q7MJPeQ+sAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881993;
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
	bh=QteImdn9gQpltcHT+UEJHJpMBNG9Tc5bVE9nFyAop/A=;
	b=XmHjDjI25qjKHBUWUdr501DSqu0Rn/RgPPoWtwD6jU0oMQXm+x4MMhagTsufLjhTbuJb
	 oisCnAI4mVgT0SDnMZSHw7Un+ySsG+uSOXdW/s3Pt1iiSQcR0XxmZvqtza/o5UlWB8+XI
	 83rcYeE7AHb9RFFd/I8e7TAjB8nK9j5IRgzrBs4sIVd5wOE/XIAS6BLaNTtr21uVVpq0K
	 PxrTGlHrhpz3nW+diAukn3MUQ+JENwyV1E19Y4FlTmk9NVTywXt+mYPjUMTdd6jR3o/Tc
	 mAUFz9ptyzCeNNJZAjTq0TJOmX5KqBpoaCV98UViwxV6M1nw5a4egALcgF/gysqp0sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n19CJGmM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C678606A328;
	Thu,  5 Nov 2026 12:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C678606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n19CJGmM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSVQrAX4DS2koTSXQ9Ck/+ncqeiGW8GjCbcXZYzDufNf9c7bLHuzzUgCOlHLSOJfFtyDyqQvPXWvi+B3S112RBL9wWBELt+WySlEBDSVhSnqLSrpRu9WzfhY91NpwCoV/vT0OxFbghohUBWarmq5OYeRikDVvoiCjeZCEhrX7ebeP34f+Bc6eYw32Gs9OauUzk0Xqz0Gsx8CUwxk3VD6dxtaeBwIgOio1lFPkcoL/yVB/ALdZ45r0Ekn92pwjcsxMDtfRaOLWbmOvk+X+qllIsFRvIjdfinlIS3F0rD9RcTV6M/ujc0RJFm1cp1VeJ6leONCTR+AyTwQoo81A3Ggzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QteImdn9gQpltcHT+UEJHJpMBNG9Tc5bVE9nFyAop/A=;
 b=CcJsdsw6f5lxbwSuxbkegG5RcXw73IMAEXwO1JJp5cAkXli2VNODlqtH7xDDCibG14pT0okwek3jkdq8iHiyiEA+5dVTnCpnVdd7I0WEKSP1coOZA51LA2eGz9e9D/Mm6qFlsWNtYB9sfHEPS2Vt8bpO85lRwomNuyXPo2lwv3yPmyMk8RMyAVZbUhFRuacX0iae+XjuJKEZV8dnX2jvgaUPB+bgUirQzuw7wVpZjoGPOJD6GzGndSUeL7PezXaC2QPV5Ji/Whgv8t0wn00WGZrU9m74N2v53XEUWpu5cxgqN1q1x6pEf4tOBIdF9ELR1C/09oK1jaRxYSHlmSWzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QteImdn9gQpltcHT+UEJHJpMBNG9Tc5bVE9nFyAop/A=;
 b=n19CJGmM2/aITbRqn90a/G3azItUWQy/nHrGfHR7trWUWNlIib7L+jw/K5wnSONFDE+kFxKXq9gEm3Ldw7vvXnvz19Qk/ioQ1G5MNnJyTagn2ZzjpMH62G+0FtqFt7nxkQz863E2jpryN319kG9fYvVqh7Vn+h1FQfGMfIiHIH5RahUA1pgJZxwXrbPhPJA14xVf+Zj1aHKIEB8HUBJtImAZcx5SipifTO/at5pI2Q44m6GErykx3nUAh9occdGluEZI4dHPAyEd77lhJGbP6KmVjTDFxqr59Rmwx+J0AFenQCAViLTkilUA2faJdffY69NMcadpeaP1/GxVZBhlbg==
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 12:33:07 +0000
Received: from PH4PEPF0000B60A.namprd21.prod.outlook.com
 (2603:10b6:510:34a:cafe::15) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 12:33:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 PH4PEPF0000B60A.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 12:33:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 04:32:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 04:32:51 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 04:32:47 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <christian.loehle@arm.com>, <benc@redhat.com>,
	<linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] cpufreq: CPPC: Set CPPC Enable register in cpu_init
Date: Thu, 5 Nov 2026 18:02:44 +0530
Message-ID: <20261105123244.3132560-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60A:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e603ef-3b23-4e3e-4676-08df3b38f202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|261026140227099003|11063799006|56012099006|261028144727099003|261009223027099003|261021121427099003|261022105027099003|10067099003|18002099003|261102123227099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	BhCY0TmN6oraw0tcu+8Z2YpZx2yQrv/h4u9OLMTq+kRWK367z08dl8lUcUQg65Y3Fji+JcSbm6jVhb2yBkS0JqXHPIgyUaMWqm/OL5DL9mSbIa+bu7uBit+MdANy+NREIgO9IM+yMqXbbfRURL+2LT0HW1rrWWgaANXmBZWODm1TeQ36sV6pifCry/KXkqDbpOTRdyagtPvgDIa3JjP4Za39CzMVaP8UvYuK9c+BZOgJNo5QQoLRlYr4A9848Tpap/3PYah7dT0j+N5F7eaUqR2cis69PEJZstGfQRQjaViOTCp0hcXjdojokgx66BPUjKy4m5Y7IY8ihgVEf07XjkbGw57di9YPWvpk3pw63k/FSsjRY0GmBIdD4Gp5bnSZiPZeBeq6tPN6Zl3eIQLA/8ITzGdzbOoEbn+96UrNIw0SVEjTLcWCfQpRFXtuNX5aQ9o+Z+iUJKv8SPvDlolAbNy/3SIyRrfxqpXeE0vlVlDTU08N8IgaN+Ebho6fqXWP7sjBVOyV5GLHvgWEqTDsqTG4QA00QUgBAKpUxLslKRPj0kMXWpCUQce886/Smqdtlr3KZgRUc/DSM+vfxPf8FeBe78ocY9jJxIoDCzlwalmUGQq14ElBRtuDQdwmzTYF/puwdXqNPN7EXv0QymeBLwLHMgiE2Y3XhaFUT7hAVI0NC7cbHRKjlpfYLz5/duVuhEtkvhkWcic8Du/rjIf5og==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(261026140227099003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	orti8AEFVg1gX7ZvbBoZ84256WTLmvuX0iCzT4jMzI8yvkvJl5OoitYWcN3FNwJUKDl9wPGZ4ZWcjF6sVN2ROXBF8okWb0NzxjZQShPljlq5f/uYB1g5amVoJkh/EZWzX4Jqg/CU75UwhGu0GwaniY40WYRhB+LRMGPwf1r0WCkZAO/Whm3199hVXRVY5noSubMIYmApZ6xehu6qTmYL9TT2jpfo1j8ulR/8AvjcDniYjvxflNXoazMrPlU3l7Yk70eOOY7fTPqd6f3q0g6S8x4rjM3Wn9QtfU7yC0CxbhnfcV/K/qExnMzVXCrFAB9/H2rf0Wf4qSC5MXC82ysr30K0Ad1VZnkddS/IEAI//cuS2tJ3XY1c66Azro9v4YhmkONGyob3XJV1fZpc5Tk7Qvjo/mnpNtUBGl/pFHPOUmz7jAakbvbH6V+h5TW2p98S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:33:07.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e603ef-3b23-4e3e-4676-08df3b38f202
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993

As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
  "If supported by the platform, OSPM writes a one to this register
   to enable CPPC on this processor. If not implemented, OSPM assumes
   the platform always has CPPC enabled."

The driver never writes this register. Call cppc_set_enable() at the
start of cppc_cpufreq_cpu_init(). Errors are logged but not fatal, as
the register is optional.

Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
Sending this separately from the autonomous mode boot parameter series
where it was patch 1/2, as it is an independent bug fix.
v5 of the series:
 https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/

 drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 957fa7775260..b8f4399b6e0b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -679,6 +679,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
+	/*
+	 * Enable CPPC. The Enable register is optional - some platforms
+	 * may not support it.
+	 */
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret);
+
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
-- 
2.34.1

