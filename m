Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6A4F4024;
	Thu, 15 Oct 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058327; cv=fail; b=pQ1GMaYTU6Vco66gvrQCpyJWv/8zuOLPTybakfmqfto1tNw8clPOe5ozFMyQeyxWl1OXp6EyJ0zTb0gU+H+2YKlYCN5M6NiER/HGbRBQPSBq4i9XjzzwwzZUSpDWgn7KxVs5CZciipGqum+wKu/h8x4lyE0RUk8oeKuw8k4hLRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058327; c=relaxed/simple;
	bh=M1sxwHffMyVQxo2AH+E7YiLi/5YQzVPvlnU7CyTgnN8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oSgl+mnfSi+1K2NcXbmlfV/drXthi4biTD2C6uZ1L9j5CtfG4aY2eGBe4ig65agj4aQnKgfWfKH20rCDgTM9/OAPECcIeYLxN8hUq6dKi0YFMlCpnQTClgOAoOyQPbToK2u2uSkhagPawNJ7vCzHUVXKysbGgW95kVPQf28nkdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4o5kI8m; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4o5kI8m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt55c61FAHj9/V9IhIGuAsNBj1fn6zoiA+882rhu1MlI3bKLIgYyMFH7dMy7FAJhs5F/G2oNlVhkPb0ioYPtJ8FRbYsto9M9wpCmBjEim+NY7fpJgTbSAnzDEXLv6env0O1sywsRYml79ddgrdT0DLGfb7V885arrkbXjjbzdQDe3uJJhh70IIvHDCMxXnl1wbug3jfbOVLj250B7IfU//vHm8grqCifKDPGZXPc2sOmo64oru/+L/Mn4aULGb8RcXLM/e9vAAge3VMMpWkWmG0IHxuj4jOmbszgMS66zeaho8Z9Rnq/ot5EM+itX+vm9Sy7ssDcxVJAh7qlH7v9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMSOLclpWydRlldwy6GMZc114/+qXttfYt63oAb+CEA=;
 b=gg7gW0RSSi3gxJ/tgLrUdI76ZVLDPSz6ZNhk9rhcL3W/1VGZJfkaRr6lVsjahdLcky53v2Wj4P/Un1ZlCEZRNS0JNJxko+BQ3J40DwHJI8Cukh+RD5daTbdYRRi203JkAoN7Qy0+pQgVVRDjo177gJYa9m6RHJr/1y3jUDQPonKAB4v7TvQnR914zn3oCyYJMxgI/ZNlsBpdhrgy3VKS36NARX8zJ8Xxzy1TP1Jru3bu6oxx3hEotNAJohJYpp+yqLUnDVq1EyPCe70boIKIUcudlAYXx+YZFHIM+lTu7m1KfoEkYj3L1mjNT1SwU8IeLs3I5v7pRfQ9+mriCTdTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMSOLclpWydRlldwy6GMZc114/+qXttfYt63oAb+CEA=;
 b=T4o5kI8mRKj9Q4bZASReGeeHvIJJXSLRwSlU4iuYQvunfLVBEYnYDgNf5edphS6iJSVKieoOsxTYKntpSRvNk/sppaa8Ju5sQm0o0G1owE4H9b+ld6fXv8CFRAl7AeVSCFU1M3lJhn71qRtIrtEtNjNgQMcWcluamKNBcgky1dkOhdhG44UOuyf9g+tsXRSMMEZHRc/iJMdrCJtF5rbBmzVcTt0a9kR2MDHaw75p6cht3wdeFGVbf0MPUaFli8aN4w4L3FMqXksTpIgt5A5cupFli4QZDXBPNBAzy1t2tgrV8O/9Tz1EVbcaWC8EZYQWDLNXUxz88cCeervfTfo9Cg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:58:40 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:58:40 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/2] Fix NVDEC boot on Tegra210
Date: Thu, 15 Oct 2026 18:58:01 +0900
Message-Id: <20261015-b4-t210-pd_nvdec-nesting-v1-0-39a36b622eac@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQhGqkVymlmGS008VUMlEK4
 t0b7fIt/t9AKTMp3JoNMq2s/JEKe2kgvgaZCDlVgzOus8a2GK5YnDU4p6esiSIKaWGZcPSDDz7
 Evu16qPmcaeTvub4//tYlvCmW4wf7/gO8sHOEfAAAAA==
X-Change-ID: 20261015-b4-t210-pd_nvdec-nesting-f7a7b7bc8568
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS3P301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21c::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c49603c-984c-43b5-f5ef-08df2aa2e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|11063799006|18002099003|261009223027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	SPaZzOxpNNhblbPs0JftOXOdJTQh43hVrpAjP4EFukR63/qJMdcsM7+kska58iXGMZc4x3zT/fMTNp2jLCnJmuhR5KgmPKq1qdNo4CcWIWm4DFM6E1krlXA3YRLDH0Z2x72RubVfIEVNp+wHJynPuYr4b6hYLNIsxdIQJylXn0CrXyBadE2nfPx1X524VttjIo3XoY6tkZkp2A9u+41C4007okn4tKuw29pQruAppCYfht5bR3LcrzC443EKeLab98lZE8WPBScEIzyq+npLFjtI7OHqWCUuuum1lpLd86T22Fje4/0v1Zi1P5giHuirRBRZVo3JyvVtLB2lgPIyECpZyVck3zs/DvK2n7J+HcZ0GXWNjq4OnZjbftkFxg8Y2dosXEdDmsQTxLGW8nVwyQQksOktZfto7+pxOv7+l89sSdO88lkWvKPqNR3g63oOJXptKp/BHpc85Qr/uR1ADzePUk6MTIVRcLiM9lGfjnI7CkQc3YGByulBT2KbifAh2roSpnwOXlcqZ6z0K2qTwXpeBc5auGTDmkFRnHP36pmoKaZJBAZYmualWxEi+M9fiyfthYuNQjMgPEErM7kJpjKbyKTrN4zTyquwryKsrJmurZqlkZ6Rmj1lOf/SBaMZTCTJbE34tv5eQ8kADV8OnfXWxO9Cib6eNHvdW6DeRx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(11063799006)(18002099003)(261009223027099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFLS2FmdTQvWVBlTWU2Sm1lNHJlK1BkOTlITFJwdzVQc1JTcWE4cklFbm1P?=
 =?utf-8?B?U3VMRjZIeThpcTIxdG9uOGg5WStuWW9yVDViNG9JdUxVdmRIMEw5UGNrMUdH?=
 =?utf-8?B?ZlM4TFRUTDhGZk9SRmpzMkt2TmFGL1NpMUNPWmNtQklpRjM2QmhVSTFBRUYz?=
 =?utf-8?B?VWJKNU41RXNOQlZZNEdtRitmbjV3bDNvZm83dHMwUVRVWDQ0VW9GbXJyNllp?=
 =?utf-8?B?cWd5WHU4T28ySlBPUVZVcU5NejJLQzk0dlk3Rlh1dXdRc2pjRDZnQ2UzSWpH?=
 =?utf-8?B?VGZGOVVRaWVjWEdQSDh3L0xrZzJSSVUxOTNia0NpNVZqaTJPcC82Y20xMjN3?=
 =?utf-8?B?ZUFWTEFjcnlPNlo3NlNDZGpLLzZ2WUJDZm9WZ3ZOalZ1cjd4Rk9NTTlhVFZG?=
 =?utf-8?B?dDZHQm5uYlNrcnduSEhwSko0TEhIRFVMYThyblpBU1VqSkV4c2VkczFFaERh?=
 =?utf-8?B?L1JZam4yWE1ueXRFRStxb1l4aUdHT1R5NUhqaUJYOGJhZyszeW1maW5ndmxG?=
 =?utf-8?B?TzJiZWVVK0IwMG4yeTdablpYTTJIdHQzSFhCUEkyanhzZytFckdaMng4cUU4?=
 =?utf-8?B?dmlvOGg2emkwQ3NPOGhwYkljVmIzeUsyMlI5M0JyODVjUVJHcU9hWnZWTGVN?=
 =?utf-8?B?VjcyN0NNWXVjUVlINCtud2FUS1NicWhBdDhKeWFkRDhIK1ptYURmOTIyVmpX?=
 =?utf-8?B?eUVXQ2pHY3NYZjBaSWNPTkRWTTlxSkgxcVVkeTFOenJkam93akhnSWtyWGZt?=
 =?utf-8?B?V2ozd2ZvZ21TTnBzV3drK1BXRnowdC83bEFWeXpWMGYrNGZrMVJmenVKSmJV?=
 =?utf-8?B?RmQ4dU1oYkhrdXJjamVWbEh3QmJlY2tLUHNKSm9tMHp2clhUWDNCdnYyUDA1?=
 =?utf-8?B?KzNDZWZ5L2NBSEUwanhaNXVHYmNxZVFrWkUydXUwMDlKTzF3aFZ2MnRrSVBy?=
 =?utf-8?B?K3dxVFkvV21ockpkci9MUUdiMTE5T1Y0ZGF5VlJNZGJocWUrNE5tRjV0ajNt?=
 =?utf-8?B?UEVzcWJiSWxsSTVnTHY3Sk9JRkpnUHhDRkI5djlsU052NEVRYjdSMFVUVkZ3?=
 =?utf-8?B?S1ZqUW1QMnY2UEd6OFZpc1dTOGQwejU2WVpvN0sxT1ZJTFlNaVljZTRhUzc5?=
 =?utf-8?B?Q1JsOXJJcFc3TmxLUmZtRm45ZzZrUlU0emMzMG0zSlV2anh6YWpzWEJEeGsv?=
 =?utf-8?B?TnkyeEUyT1dBS1hIMW5YaldBQi8yVnpuNGdDVEg3RGtWa3dpREV5c3FvZW9M?=
 =?utf-8?B?UWVjMStWektrVGFDUWlLMDY3d3dLaENLWlFEOXJtZDlXemdhd3FTNjRvSnM0?=
 =?utf-8?B?WHBNY0lTUW50U1NkdnpzWWdXcElWbGR5TGk3Ykswd014YUFwcWdvb3JhaUEw?=
 =?utf-8?B?V3RZV2IrOStzb0FSVnFSdnRFQVVrMEFTMWNjSDZpdjViM0wxV3p4T2t6Nloy?=
 =?utf-8?B?a3FxRklyNVFVNmREOXkzcGVtYks1T0phKzlGZU81QjdmTDN6b3E4NVdVSGVD?=
 =?utf-8?B?bWpjdm5PdWdpS2o0Z0xEeUI2eTQ4K3Y5dDNGUDRnTUZEZkZSdE9sTk8xVEhP?=
 =?utf-8?B?M0Y4Wm5jdXhMSlJ5QmVjdHRmNU53Y3hOdFYxWk4yL29PRzFOWWFxczdYakxv?=
 =?utf-8?B?WFVBazE3ZG5ZeDIvbEtNTjdmc1BOa0xiNEFHQ3c3VFVabU9rU1JkbkduQjl5?=
 =?utf-8?B?WHFoZmhRUy8zb0hPeVpFT1ZrdHlmaTdxTXY4TE1GM3RUUk9TREFaTUpFakx6?=
 =?utf-8?B?cmNsdEtaeE4waXNqTjZtNGtHdGFHbnV4NUNPcUIwRHowZEhNVCt2RkVtUSsy?=
 =?utf-8?B?VlBRQ1VSR1ZUaG0vTFpUbk5seWhOaU5iZkR2Tlh5RzJsWjJjQTZvajRibldS?=
 =?utf-8?B?ZGNWRmRVQmV2SGY0cGhxdEV3R3BCV1VDalJSYm5sZnNDeDc0V1JpcGUrb2Yv?=
 =?utf-8?B?cHcyVlRZcVVaaFc0YnEzQ1N2aUQ2UTNPVFo4b3pJaWdRZDFMaFZWSkxWaFdv?=
 =?utf-8?B?WEFyaWozM2psT2d4K08yTG1FM1VacnlvZFVnY2czcUxmdGpBMjBwVVpmMDdK?=
 =?utf-8?B?QnVMVmNMYkxjRFFyU251THlDUUJ3VnJJVnVJcFBBMk9GcXR1MFdEeHdubnRW?=
 =?utf-8?B?SzRUZk9yY3Fkb2pwRk5JMEZSQVlWSDZhbnNKV3hLYW1OalVPRjVxa3RSQXdl?=
 =?utf-8?B?S2N2N2plakQ3V3ZNQUlxSkhvSGZzM0taMGxrby95UHI5eGR5MURnT1VXYU9K?=
 =?utf-8?B?bmE0WHVqL2NkNW1RTzBQVFZYVFRyVEhVS1Y4L3JncVlEMzEyZi9wcVRYZ2Uv?=
 =?utf-8?B?NS9zNU5lejRrQWRVTmNNQ21ZeXVNcEwzNWVQa3R6UWhvWG9WSXlNWS9FOTY2?=
 =?utf-8?Q?1OidrSWHmqzrgau3gxVMs4q4ruiWzhDQeaZrwdBIsYf42?=
X-MS-Exchange-AntiSpam-MessageData-1: gJeZ5FmAYEoJrw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c49603c-984c-43b5-f5ef-08df2aa2e3a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:58:40.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWX3O4WpQHysjJfs4zKGOA2rZ7vP7VgwaGB6nlYUOca7Ty1OgHTUahW+uI1eVyYo/NM5DzM0UHtGz/2PJN2CHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668

On Tegra210, parts of the NVDEC hardware unit are in the NVJPG power 
domain. According to the TRM, the NVJPG power domains must always be 
ungated while the NVDEC power domain is ungated. Model the dependency in 
device tree.

The first PMC patch updates the PMC driver to handle cases where a PMC 
power domain depends on another PMC power domain (other than the core 
domain). The second device tree patch adds the dependency in the device 
tree.

The PMC patch must be applied before the device tree patch or PMC probe 
can break.

Cheers
Mikko

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Mikko Perttunen (2):
      soc/tegra: pmc: Support nested PMC power domains
      arm64: tegra: Make the NVDEC power domain a subdomain of NVJPG on Tegra210

 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  1 +
 drivers/soc/tegra/pmc.c                  | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261015-b4-t210-pd_nvdec-nesting-f7a7b7bc8568

