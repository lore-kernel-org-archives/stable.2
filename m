Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576850C28C;
	Thu, 15 Oct 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058333; cv=fail; b=Pn9/cscjenTRPwyMwiC6MrMEYLVnvkgLhKGCKCYAz7g8drVj5s8T6OavHi21icoi848Wwj6gZxjbcBtVcZzIgUW/rj7UR1SN2J90PceDajeG8gLw2efLMFoyIr5L6vgcAUvV/crxj9eh//A8CT6Psh3qSCu5l8YAiVx6+btaYdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058333; c=relaxed/simple;
	bh=A/H+4S4k+ziIgUTQ2Jpdw9BBuH9YGFczaG9jMN6Mz6g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IcveyqvXmprauj3gEmbU9U0rtEjpbOvUvucyV4zXNaBuMEEVgBWdhkE3lM6CNrkLwc1zDQw/mxNu0V0gujDJ6hLOaADExH3Tb4L549mNgdN72FnHEE7qBbQqH2w5XgwqxoHIIo8gi4w7pE9RrvYAnYxru68od9n3noEgP1sfWpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlrVbHGo; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlrVbHGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/eytPymZ4aikldPaDw19o5jjSIbVtZWZlUXOkZ5riLpj798VCRN2RslG0isu+SiaLoMJ8m24xtMQn3aEUp4ajuINOehUf/ZtwFBlUV1FW9H0YYfEEzpFApwl9szLLJTtPxoQqbqJY4TIixkpTewoFsmK6eyX1oAM4YKQnM7D866malj4kMCpznkNYrgMB7U0X4I9pKcqCJ1zIcoEMmuYHvSiWAIOYPSL53y4a0w2bvd4dORd3drXh3wqO+sgdXHGLKs4I9z+YzRiqw6/sNj+1oou8+ND3Qb+NvHiKYmyKPj7rLX++JJR6VVGsXZ/SflDGPAHOUFOq2bgL9mloGDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8sJUlY5P7DltSfa3K6rbbygR/Id7mbri5lILm3Aicc=;
 b=es7sHTHStlEBw1Y/dRIdTlciOcdAF3XBrKLUB9OUO2x+MejbZlo0Z+AIeVNSjDf2Ce7whi0GSpwGbUuEue2q8uQh68Tm/73TqDFt/4Q+lJYHMpvREr4ooP00ECXHtXjvIimB1LiDmClCPUZpUjNI1L6CYLsWi9Fijp5Irxp6mGWcyIojcbojUrO3vM8gB3EFNHQcL1il+VVgvGZnh+tCO2YXdimWOlx5GCHEEH71LLnQ3Ed32+COlZ0Y8cOXjX86lc+JAUirp4a8bJsg8QwqcLQTr/ovScUIKslP6ojHKZdp8wtuNrRKr3xnNBZDTu8AHNQjUZ/NKTbs7/cTOp3VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8sJUlY5P7DltSfa3K6rbbygR/Id7mbri5lILm3Aicc=;
 b=hlrVbHGonIqBh64tQpxv3FT4KMP/rBJBUma6FXnucRSUE2PT67pe0HTXrIxYmTD8ROkXl43UcE6Eq62TSQDGWyi2x8cAxs1gBTgEdqPmIlQ0ihTbDQHLVQVFVKXJM+4+XwQVt8WRzWOFW9XiCKS6oEclWsiJJlXYywUmtgfzPokULFTiRKAaNsAYKxO/828q33Lg7PgkMiq2tuB41BPJ35++Esm4lUYLXG+T3NrXu4DVebSleug//1QsZ79cYZ7dsFcddH3tpIbGO7LU8ArDFfDSDAsGdXvQ+vRlsQ17mZnYrPOrQ8qkYdrrpt++WOPBHmXDZxs/c2WDRxT3hImgsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:58:48 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:58:48 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 15 Oct 2026 18:58:03 +0900
Subject: [PATCH 2/2] arm64: tegra: Make the NVDEC power domain a subdomain
 of NVJPG on Tegra210
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-b4-t210-pd_nvdec-nesting-v1-2-39a36b622eac@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0240.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bef65d-ff82-44d9-9684-08df2aa2e832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|11063799006|22082099003|18002099003|261009223027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	OT2+XULeLCb1Dk8cUtzJqYNmNGeE1q8dGjO6WJ+uyaIiKpZEgXKEfOFJmcb6QblvW+DkJGciLSpRnUf6lQKLkoXfhzy2xmtK3DM4XYOtoWKNt6vx3FosRqoYwqqOA6+h9h4KxL1q8LCZexir+h4Ozeks/RNzLStb72C2n0pWJRYn1IomKXcQaWr4DfFcT7ex4anuVlu4+HUZHkPTwYtyY+9lybOoZJFB7P/NZE9zeBKkHUoUKzVTsGGvWqP5U+FAb6i9u2PxDDDC1PBNUENEzJZRK+D7+1o8N4wuzpWdyLTcznFgwNLD2IbsaItUtf8oamQ7FgKP3QHxQ+IUyUHBBjeP/WwtJR0sf6x9jaQELouIbFHXxT/QuDA6zJwVptHriAzdTcD+c5NE5h3oPYplWK4Y7eoESSHDOf5z+YFDABkfqQFeYlg5TXIEgfFRclK6n1aAHJsX2aKgHXS+AmoYjhrjRwVu+ubTf3/gNaSteYKUMurKBK47F55N1OJWct3ilszNBeujPKDkvygaHR5IvUYupD6p7VGtlWARpMGCd6ouD2x2brYOlGE3ma5N9ZSidgY9vfT6tSnOWep1WEbYjRN3nASds98js+Fgrc4emOaElDvz9M59uXQVfzAZECrj73ymp9oG/LdtzylbEiWq+8s9iK41NU5gVvVo5othd08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(11063799006)(22082099003)(18002099003)(261009223027099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzgvVlZwdVg5OWFWZnN0Y3lHQ3FDQ0J3NzZtODFaeXlLODRweWo4ckJINDZa?=
 =?utf-8?B?RDZhSDkvekpWUXMxLy95dkhEMHBDSlBGcUZPYmpNUzhhNHJxSGh1SUJFQlpB?=
 =?utf-8?B?eURkN0hoS3RCM3p5TFg1U3pFZGFTalVDL2wwbjlYb0ZGSVJ5NmEvWnQwQ05M?=
 =?utf-8?B?MVpaSk9jZzVZR1NrRzBDM3NQMWI2SVJVSTN1R05sWlZxKzF2YVBhWm5mQm94?=
 =?utf-8?B?Sm5DUUZzLy9hRURPRnFsSDBGbVpIVFRtSzV4NkJmY1RyM01vekRpTitYc2tP?=
 =?utf-8?B?UTg2N2UzV28yakNiK3pMU0crTmtUWi81ZkxLY1NiL1R5VDlHVVAySVdIekRO?=
 =?utf-8?B?c0JrVE1NUVlLQTUza2M1ZTNlbU1IVDk0Mlo0UnBVeDZaQkZmS1FseWZpb2l3?=
 =?utf-8?B?bjdhSml0OWN1M0U5Nyt2UlNFY1R6T2ZXU1pIWWVpWXh6TXYrOVhsaklMOTk3?=
 =?utf-8?B?MmZUOVozb0QxcHZneDdST2doSHJRRXRRZERXZ2p2SlRIVTlSb2R1THNZb3FS?=
 =?utf-8?B?cFB3VFpRbGNOQ2JsSC9WU3lqUC9scTM5a3RORVAzZ1BBOVZQTWVTWHIwdUUy?=
 =?utf-8?B?aXAvbDd5NXh4UkpZejVtUmRLaXV1U0xCSURMUUhWTWVHU2FJaXIxbXRrR0hu?=
 =?utf-8?B?QWo1RmlLWHRtRGFOZzd0OFBTcW1oaDMxQnVSNGozWkRseUQ2K3FyS1dXT3dm?=
 =?utf-8?B?K3YzQ1BTUHRJQkQrNDNsMytpN2IyWHc3akhjbk1RV0lzdDB3d1k4TnJucUxw?=
 =?utf-8?B?dC9Yc2VpdmZyN0ZQc0hqZFZVbWZHcWlVUjR4QzhFYnFTZGFFdjhYWEFEMXZG?=
 =?utf-8?B?NWFBVkVYTGpjbnp1TkZ1MDhqOTQ3c0JFL3NnbEZFSmZsV01MYjRHUVhTSzc1?=
 =?utf-8?B?YStTRHBFZUV5dmdEelVZcGxvczAzOVNyNmJmY2RCcUFONDFwRWhaK25qMHRx?=
 =?utf-8?B?MmFFb0p5L3lBQlVvb09XelYzREFTOEoya01NN3k5TUkvTXB6MnQ5QVNZMkVL?=
 =?utf-8?B?dUYrcW1jTVpQZ01RVnQ0eWx4VlZYYktXQUN0alpqazd5L2hieGkxdTNaYkVj?=
 =?utf-8?B?RUxtUzFscksrbUFuNlZzZ2tRYUFETFI2TEZVZGhvcHBOcU4ybzN5Uk02cUgz?=
 =?utf-8?B?YWNFeWk4eE9mZXA5Sm5MNTlMb3RCNmRTdTlFVnRhVkxPVlZlZHRoWFI3WDBP?=
 =?utf-8?B?RFdyK2pBOVAxVzNnYjV3ZDVVcG96V0I4Y21SaERjY3NEMTFsNnB3UC9GcEFS?=
 =?utf-8?B?d2dxK1hMczdqcGp4SU0rUzBwV29UcnpONkdzWmlCUGdYK1c0RERhMm8reS9h?=
 =?utf-8?B?bFNZWXhiNnZqTVpFMTlQK1R6ektHY3lIck85VzQ5R3hmV1hNSzI1OHlEb0hJ?=
 =?utf-8?B?K0h0QlV4ZllTZE53MzRPUWkwZG9yYU5Tb2hTc1BydkdOOVhmQXJKbzJkLzRJ?=
 =?utf-8?B?OW9lZnNLNTlPRXh4NzF4MUc4Q0ttQ0o4aGZhSU5iWlUxL3p3SzVINk9TQmI0?=
 =?utf-8?B?S3RvWWJ2VVR5Mmc5RDBXVjlDN3pMR3UrM3hoR1FRSS9wYWpxZHVpM3hJTG1y?=
 =?utf-8?B?ZmV2dlRyR0RKaXUzcitEOGZsZDVZT1F6U1VHeEw3QzBYOVZqZVZPSDdHeTVp?=
 =?utf-8?B?U3pud2Y4ajNUUVJkRm1kN2piSjRzQ0dBS1RUenRDT2NSNlpjRStWeUMrYUMv?=
 =?utf-8?B?WFhTSTYvcFg5RlgrRjI1aHoxaGxXdHVybFZ6N3VibnVLQnFOWjRITlZ2ZjNs?=
 =?utf-8?B?anp6eGErUjQ3NndCYkIvYkpCZEFHZnVLSk5ub0lvVTZtSHg3OFlGNjRPUzhu?=
 =?utf-8?B?a1c4MXVyM3pGSlBQKy9QNlB0L2xVQUxQL3RnTVZQekUyUnFRWUF3MjByaTgv?=
 =?utf-8?B?NGd4L0haMXhUd1FpcmtzUFdObTlUNElEWkt2M0tEdEJya080YkZkdkZ3Rzcz?=
 =?utf-8?B?SUFSUGFzWVVRay9RbndOMmxTcmNWR0U2Nmt1emxkVGZFSG9McC9hN3gyQ0M4?=
 =?utf-8?B?RmVKQlBWbTBnRmk0MThZY2VQcXB3eC9YVmxid3R4QWZhcGZGcUtxaGhOL3Nj?=
 =?utf-8?B?RlI4MWI0NmpMQmtSUXpoWEl0dTlBVHAxU1JPeWJFcGVhZ053ZFgyd2YxUE9E?=
 =?utf-8?B?UmNGWVdacXdTWTFMS3J5WDhxb3FtdEMvKzhFcXpBeWd2RGtxV284aHJySzIz?=
 =?utf-8?B?eVZEZjR1ZG9tMlRZYmp4b0NsenhnYUcvMzZpdU1WNm9EVWVFOXZlc0k1czVn?=
 =?utf-8?B?OHNJR3BULzgxWlNjdXdkeSsxeG5aWTRaUExLcElGcTNNSVZRQm5TTmdQaEVq?=
 =?utf-8?B?V2Y0TThWVEo4clpUdkplVlo0SFFoM0hBZ1VqVXNNOGYrdjhrbWY0ZEZZWlJy?=
 =?utf-8?Q?fuwF5iej5bUtbx4eh257JxKeYtncPrP+tl1h86S7CrEKX?=
X-MS-Exchange-AntiSpam-MessageData-1: fyvhzOKu5t279A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bef65d-ff82-44d9-9684-08df2aa2e832
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:58:47.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyUIGnIWpx6y+Sg73IhzO5TiZn/ryIesid1fZ0XqCDAKFb1wx2zXTxRQpBB/urghGeU39Ns6SztDbALM17yzNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668

According to the TRM, on Tegra210 the NVDEC unit is split into the NVJPG
and NVDEC power domains, and the NVJPG domain has to be powered on
whenever the NVDEC domain is powered on.

Fix this by modeling the NVDEC domain as a subdomain of NVJPG. This
fixes the system resetting when attempting to boot NVDEC.

This commit also requires a change to the PMC driver:

  "soc/tegra: pmc: Support nested PMC power domains".

Without it, the PMC driver fails to find the parent while still
registering powergates and defers its probe indefinitely.

Fixes: 961e69a5dc78 ("arm64: tegra: Enable NVDEC and NVENC on Tegra210")
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 49d22506b7b7..08e14bcc9367 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -935,6 +935,7 @@ pd_nvenc: mpe {
 			pd_nvdec: nvdec {
 				clocks = <&tegra_car TEGRA210_CLK_NVDEC>;
 				resets = <&tegra_car 194>;
+				power-domains = <&pd_nvjpg>;
 				#power-domain-cells = <0>;
 			};
 

-- 
2.55.0

