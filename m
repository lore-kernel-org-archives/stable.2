Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938D51617A;
	Thu, 15 Oct 2026 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058332; cv=fail; b=GJgJZ5/y+GowRZ1i+KGjdw9ZM75Bf9h367RcB5CBxEpOwEgdamcZduEfGIxxzY50egbQ4d2Hv0l3Hg+QIO8zQGNS4bwrpD1WOVzSZV3g6GG4+REd8ReMRcTf/KWjq2T35NbFILKaOlgj2/ZfW1QVsbDr+kNVt+IKcrnpTVl8gCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058332; c=relaxed/simple;
	bh=4wKQFUqrYdiTDaO3M0WWXe3fF5sezQnJXBPKcAKi5Cw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uVV1JHjD9BWWftKOW7/179lPcpGK9sr+RUnprr8Z22enBI2TGRVVoDsuvIAq1Krp3zmt+H1ePbyK7B1Q7Mrqfy/OMtNWM4Azna+O2FKKIE7z18jnd3m2O62/t5TP0yMSqGb+L7urni2Jug8wD1XmbmXp6qojCxmlyqZ6rcs8RwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ergdoe4x; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ergdoe4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py7HsX3UOrsASEv3T5VwGuEhbuTSK3w+Qw2A+17LNwY2JB6XS6GTmjSGRzeHR5kDUgZnjS7435DYcYeRX+nzB/LC/v3Dz+xoyJE3CEnLFA8SoeAE8dg87pCFFPES3WCUvb4KPpJU+2X/XgQSnZoR9a/Q44xTvwbmxV6BrCne2S/Kots+fhuEbs0HytdVxGgcDjUEitRC9gsC+kOLPRis0nKD0nQ5NEePzZcm1XUNKJseveL67SCVpjD1J+u22Oxb8kHGteYFL4JA5IgjSn6HQ79wrElh7WoaFRVyZqKb4JdBZ3UNv6NCs04XMUnunbYqduaCVuO6YFdyUOXUizRn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJnMeP02ZjsZMJev5mfJq2GwKV3jwoDyVigMdUt2CSs=;
 b=xa9ewvAY9X4k7KXLvgK7bKXbsNwtS8/0Gwwp5ruv7K9hsGgmj8YyKxDOrw0h31YibrzR/+/ONnNOV1Ohz6DVrH9/uTHvjzYBKcEJT6NL889ALbS7P3aoz6PB6cxhdB49ZfYCm9MYzyheOLW51yrIdjWScQ4wcdK9SN7gIWE78F6qkGBAe3h7DYKDj/MszIv2D42nXCjPFGWjniIT8i/gw434p1oS395JWA3iGy1FDjA8GCTB16mDc75WVK7K29rtkGk7kteKTQGxPAxmIIhap64PIZl1KuPXOv0Otc0Q5XxbjRNiaVJw+Vhn2QXauj8Hl3dFxy7MD9ofXy6o8juBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJnMeP02ZjsZMJev5mfJq2GwKV3jwoDyVigMdUt2CSs=;
 b=Ergdoe4xIM4zUCE3+JHEFAWPnIJEPT30VB3ZHha1LsT+4GQZiphVzv9UP+vZetlEIaoukn0XlM4Xvee8CfbgrorJAiP5oTtU7xWczbiNOwy0Rgeisp8xUFPOK8FdlarqDQym5ta8u1Lljjuzhxp3XX8Y9oGi0E8TQEVEdvrDxxuvNHVFkp2W3ijO4w2u776kiFYKcHGgsZLxSGFZwjtFWANF1gA9K5tUOVEbbrKC4nyUm5aWh9XQxbIAIKuSEXdOwa5QovDQFnIo2UaHgW2WhweIPKxKtEdGNfNTrJ7d7pmz1EI+FEe6VxZTpVMuPxyYEB5zxqWnz7DbEfeKJqT2tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:58:44 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:58:44 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 15 Oct 2026 18:58:02 +0900
Subject: [PATCH 1/2] soc/tegra: pmc: Support nested PMC power domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-b4-t210-pd_nvdec-nesting-v1-1-39a36b622eac@nvidia.com>
References: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
In-Reply-To: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OSTP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:226::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ce21b2-a473-496d-4a32-08df2aa2e5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|11063799006|22082099003|18002099003|261009223027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	jzZl9Ilm+R/OTTOKxIJ+IX1rqSlUVSsN0zA8cb7Ae2cRfuiHqcRRZSJmWvH0XOCQWo+pGP0v3ShqAUbBgFQu0UsMPhkEsMKtdpf9HHIKdpopJOXHsYac/ITYJP2qp+CK6iRgjMGEK1S2+psjH7YzSsAOI7rAlysMqdrJXbZf83gT67sVoIcnzCCS+hHtDereJN6Fupn6nXzMeSkGWI87fXU4oHnSp/45ucb5KUKll20bHWLCIBBlkKESn7nFV1n04cG/Me02Z2pTyxB6nT11pi1cKy8ZPh5TZREhriDvWA1x3LhrZqUUu0YsiPHT3oQNkbSC54v6SgOkJjtGVNXbVFT6AF+4LalwsgPLIGPnWzA+USd+asRMg1e7ZVOVkCAtpILq3VOwJJvAc9JV/Yj2eWYgyZ2ypqe2GK4MAd6+cD1r1dTsigVTLnl8F7zDxl+yfQ2XFc7tQnRhwERqmWK/AQ/2xdxdloVfkxro2oOjIoCjLb35GvrmHDeAAn5qPMJuktLAgt2/d4YzVmTLdf5jYURi59/RDh2vPxpGXu3IA/pJxbbb6eFx7tvw5vPXM3aG93a6wu7oGdsbVun8xz7LCKKFyKViFj5mOPEcufvgPimpOn1NwYBxw5Mn3Xp4pEL1ZpBYHJK3c8uiXkgwryxirzHCC1ikpF11hX35VkbLi0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(11063799006)(22082099003)(18002099003)(261009223027099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlUyUDR4akFtQnpMWFVCbTN1Z0VmVUtJZnZjUC9ZVUs1UHFjUlVYbmk1cTBt?=
 =?utf-8?B?SmRsWjdsU284dGZZVU5sUzRMdG5sdGd6cm91N3ljWW9NeUF6cXNLV25KZkVX?=
 =?utf-8?B?Sk9wWUliOThORGI0WFlHbCs5Z3dBN3Roc3krVlpKWlhyT3lVWXN6WVc5RnN0?=
 =?utf-8?B?YVdwZy9GamkyVHQxNERYdlpJc3Npd1ovSzRhaHJqMmFUUTNTWHkxV3U3MGlB?=
 =?utf-8?B?c2xyTzFYT3ZDb1gvVDFGMVhhTmZuSmZUV2hBN0JiQXhZdHhpRUpaaGM4WWRH?=
 =?utf-8?B?YWtGdFFFZjBrVW9YQ0NlNlUxUWRhOGlJVm1QM2xMcjVvakxnQk5CY1RJeDd1?=
 =?utf-8?B?K0gvZmpvUWozZ2h0ZjJwb1ZocU9iVWt5V3BvY1RJYnVzWFNVczNmeEJpcUxJ?=
 =?utf-8?B?ZXY1Y0pvTXROSHZuQnZqaXdIMGRCeTFMc0t3T0x2ejZYQWNMMlJWRDVDWXVv?=
 =?utf-8?B?NW85Y0hVY3BDanM0UmZuWE81bjFuenpHNU5xK3dSNUY3RzQ5OWdqU0Q4MzBl?=
 =?utf-8?B?bHVOV0Y4aE44dGJDdE02QXVFUnlxKzQ5VEszREJic3pCaDNlYlp2QWNoRUtT?=
 =?utf-8?B?bDhBY1dUd01XdFRWWmc5Yzd3YktQOGorTFhhenROcGJ0UDFTb1ZnNDRXRUZK?=
 =?utf-8?B?akdmdEFFUkNtcVVQdEtuRmFMNGZvYjk4WFo5QkpXeUlRN0NqZUM0SnJHREhq?=
 =?utf-8?B?M2RjQ1J6N2lUYzZmcnphcjBvSXdxNzFQM1pWK0dxcWRQSWlTSTVtdEQxd0FB?=
 =?utf-8?B?a3ZONVlpRUJVZUkvY3ZFSllEdjRqa0N2MkdwSEdqdDZMRnpWTE9xU3hrRmVZ?=
 =?utf-8?B?NTUxOGRtWWJNTTdIRXBpdVNYZEswbENHZjIzZDYyU2FNb2pOZnArSDJJOTRD?=
 =?utf-8?B?MmNCUjVxemxIWE56eGtNN25iMVBxSG1WZTJjVjFGMXVVMllxbUZTSDVMb0xS?=
 =?utf-8?B?b0JEbytzNDVkRnZBYWFkWlRya2xKcG10WHgxMkJ0V1ZxS0dETHpNc3RHRHBU?=
 =?utf-8?B?Wk1wTU80TXNqMDJDcEZRQW9oWGxHbURoeXQ4Y1d6RW9pMEVkNkxCL1hZcit5?=
 =?utf-8?B?eHNtQ2NBWkhMaWxtQmJ1L1BHVklKTUhqMVZPUzdDdEFlb3g1TVNjL3k4WWpu?=
 =?utf-8?B?U2hPZmQzWkF2YW1TeFpUSHFBL1FBUXlIQnJWSDA0NjFlaExMeXpYV0x6Q3B4?=
 =?utf-8?B?RkU0UXlISUFiakdUbnpzcE9CaG9TczVGZUxLVmdwblF1RUlSSW15M1E2a0V2?=
 =?utf-8?B?N3JJZyswc3pZa3pFMjlKNllNZmVoa2xrZ1B4ajV3ZmhSUnd2MkI5TkFIcGE2?=
 =?utf-8?B?L2N2bnVxd3Z4QkEzRGN1NS9ZNTkxQ0hydUM3eVJsY2NnYUxtejYrZWlTRVVq?=
 =?utf-8?B?M29NM0FhSE9HeUNPdndPSUVQMkVFUlZwQ2xiVWVXRVlleEFvRW95ZW10YU1Y?=
 =?utf-8?B?emgrUm5RTEVFbDJBZDEwdjAra3JzQVhPcFR6ZUxuZ1dPc2xXTWxVZ0tOZDR3?=
 =?utf-8?B?UWNraUpuRVB2SElNUno4QzBPUWFEbDJKTE94WElVRnpabVE1WGhCSjE3Vmx0?=
 =?utf-8?B?d3FBaGhYWm1kampSYXBmTlNPMDBsVXRuVmYvQVgzd3UwNVI0ZWd5bERoNmVz?=
 =?utf-8?B?ekNmZk9kUmE4RVpHdHl2RUZZanZOd25vN2NFNGFXRXFuRFc1aTNOV29YUWlz?=
 =?utf-8?B?a2l0U3BpWlRHM0Q1dzZydGNDYlVodzhMLy85MEM1d0JqZXppTldNU3FUbUZX?=
 =?utf-8?B?c3JtVmF0c1pScXVkZWpxaTUyMTliS2dDeVQvZDFBQklpM1ZyRjlUeWZ1RFNW?=
 =?utf-8?B?TnhjQ0J2WDNUKzNVVDE3UjBaVHZVNkRWK2kxY2RZUzRsazliQmlDNXZ4dzIw?=
 =?utf-8?B?R0NDRndjb1VBdkcvZnBVdzJTWjlJUS9sTXNOSDcyZTVsNHRNQzBqY2k5OWY3?=
 =?utf-8?B?dDhoV0VwUGZNUWFjbGdtclZ5ekRBNFlGVnN6S3FvSXJ6ZkJ2Rjd4K0s4bXQ4?=
 =?utf-8?B?MjJndXZSUGoxZUE0cnFmOUFFRTdSNUsrdDdjMFRaS1E4enE3SHV2YW5PN1RX?=
 =?utf-8?B?MzE1N0M4T1ZqQ2dvWk5nSGYrODJoOGRQZEcrQnpTYU1RWDhtWUQzWG44Y1Nj?=
 =?utf-8?B?VjhOZWU0R3FrWjh1cWhUeTlMOTJVekdRZytjWDhaVlp0b3NMK2U3WVZXSis1?=
 =?utf-8?B?ZTZ3WGdKSkdoNFRtcmFEYmFDVlNlN1hvU25jQWFoeWI0NlkxR2ZWQ2tDcDM2?=
 =?utf-8?B?Tjk0d1g2WjJjcm1ScklYKzZ2dmZCQWNOYTJaa3RvNDIrOFlQdXlPRU1UaVNj?=
 =?utf-8?B?VWVFMFpsU09vejU1dEVGMTBLSHZZb2FvdklENGFXeWkzVUZWbXVSSzIvR05M?=
 =?utf-8?Q?mAXkmqVMJtqPpSRgmNFeIZWaRrgRiBfZ+sE5Vr/NCNzUr?=
X-MS-Exchange-AntiSpam-MessageData-1: WKHrpnZl/fmvZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ce21b2-a473-496d-4a32-08df2aa2e5ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:58:44.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hyHCH2VXokb6cplGe5dMgP4T9prF/EnSHkLu/JRNTJk8v5TYfnW1w6nntWprGEtxYhOd8q3m/Brc2bTMl44og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668

The PMC power domain provider implementation currently supports having
parent domains for its domains, but only if the parent domain is
registered before any of the PMC power partitions. In practice, this is
the core power domain.

On Tegra210, the TRM documents that part of the NVDEC hardware unit is
in the NVJPG power domain, and that the NVJPG power domain must be kept
powered while the NVDEC domain is powered on. Hence, we should model the
NVDEC power domain as a subdomain of NVJPG.

To enable this, support one level of self-referential subdomains in the
driver, by registering all power domains first before adding subdomain
links, and correspondingly removing all subdomain links before removing
power domains. Without this, a non-topological ordering of power domains
in the device tree would cause a probe deferral that would never be
resolved.

Cc: stable@vger.kernel.org # 6.19.x
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2c70eedf514e..3d820c462829 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1525,8 +1525,11 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
 	for_each_child_of_node_scoped(np, child) {
 		err = tegra_powergate_add(pmc, child);
 		if (err < 0)
-			break;
+			goto put;
+	}
 
+	/* A parent powergate may come after its subdomains in DT order. */
+	for_each_child_of_node_scoped(np, child) {
 		if (of_parse_phandle_with_args(child, "power-domains",
 					       "#power-domain-cells",
 					       0, &parent_args))
@@ -1541,6 +1544,7 @@ static int tegra_powergate_init(struct tegra_pmc *pmc,
 			break;
 	}
 
+put:
 	of_node_put(np);
 
 	return err;
@@ -1564,6 +1568,7 @@ static void tegra_powergate_remove(struct generic_pm_domain *genpd)
 
 static void tegra_powergate_remove_all(struct device_node *parent)
 {
+	struct of_phandle_args child_args, parent_args;
 	struct generic_pm_domain *genpd;
 	struct device_node *np, *child;
 
@@ -1571,6 +1576,20 @@ static void tegra_powergate_remove_all(struct device_node *parent)
 	if (!np)
 		return;
 
+	/* A parent powergate cannot be removed while it has subdomains. */
+	for_each_child_of_node(np, child) {
+		if (of_parse_phandle_with_args(child, "power-domains",
+					       "#power-domain-cells",
+					       0, &parent_args))
+			continue;
+
+		child_args.np = child;
+		child_args.args_count = 0;
+
+		of_genpd_remove_subdomain(&parent_args, &child_args);
+		of_node_put(parent_args.np);
+	}
+
 	for_each_child_of_node(np, child) {
 		of_genpd_del_provider(child);
 

-- 
2.55.0

