Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1A2F531B;
	Thu, 13 Aug 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644223; cv=fail; b=SfkSnh+VG7rbwAnsaIe6ztP7OqtI5S1dd1Jln9rs779Kfe9uP4pn8FTqblCfk4Lfyc3Q1zWBQ1Dl9fi7VT3feYbP3XI7EQIAXanS8LQ0WTJA8n8PKeEplI34A4Nsca2jkBBTM5yWqxQkZlSRY7r3JHDua5/L/vXC/uM+kfsRGTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644223; c=relaxed/simple;
	bh=PSj+EISbL8JTHsKq9dLQkY/HyB36/5jLF+vyAHVFvzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=hjUfhHbLwrhyy537KBst0/iDBkDd9H34ORHH+SAXRjtLzqQlSCBb2qr85FWctN8PFusOAwOiHdihbTkG1TJCw1XssSSustIUs2q0AorjkkVoY5IfldP5XpozzkjB4odSQUNfSzdiCmesXZtKVMqv3N8Bbf4RC3ABHRZxZqCFiS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBBR0qw2; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBBR0qw2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUHVcbYoo+0hEURFQ2M/B7ALg9wD9MqCwIKwgkfmNAV8MUslBRmDLf8nmJHd19mZTcirAUkcJmfP1o84MEqJq7tzMqLHXJV1DCfCW60GUa6RDCuvXYWrd97cimoc2qiCS8O0U+HeA7hrRjxhd7SBBcooAFDtDQ7LfBfFlaB+dkNa8uOt9sUIQQmj9qtWMuZ4bMDGmksBB0FoyGKClH7g1JK5s2aY0Jr56sRcUOgzjLjaVqtMLiEJJkS5CcC/uo6C5sDX3qXnuf5615fucXsZAMmwI/L4idf5KrEy56GjBmYRT6h9NkxopFsfNMGMX2wNRD4jxqxn1L52t5lwGdLdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohQQK8HUTdxvY7wALBmC09rGxpovbVCuIFVWqFX7Vpg=;
 b=KJiMvP8osMxDAjZpuQDohvcr7NtIMifs2hZWSdzB0Vj9hIV9YxisMl/kd1x+EDCLNN9IxGUKKlgh6Hjwr7p5dOzWAK96ARgdZgAKsn4dbAUb+rqdJyUEOOSLKv77Jvdi3AUTOglwM2UCoo2pcReyZ4kfmWmylfHEneqMPZ4vA3bkyOAQdAyJJ37PqA380rGyNyy+F8m49AyfIbU7IKoIxbGLq/iwCLYX/v45FQ/VAZHRladUfk7Kqq03CoWDBubYpNN2JyqZHSieSTfprR0zY2RSeEehEOydpkG5XxbxXQeTYoDPaP0hKSHOrQQis4XbDROCsH/tQFSWVYTPXMZKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohQQK8HUTdxvY7wALBmC09rGxpovbVCuIFVWqFX7Vpg=;
 b=VBBR0qw2hBimSoY1WniC4P6lcLddSmh5oHCFd9c5SzxQdhVA7YHg7AzoOf2JWXnm/45Ek6V4iwcl+KwWtUrpCrTRUWjKYxFwP+nWONe5a24LZ7IV1OdPJGQF51+t9sfYs+rJRSTPKL4TgwEe9QoTqhnTcnlbYfEWc6MfdwxElS2XPzXgvH1bVO0gXqEDnIiYCq0onBnHbvbkk82TfH7fxi9/Gxc87FYxiNpmQO12K3LY0gD2ndhAOGBcx3baf87kDwbZ0Psm5LXrvfvjuV6vcBiqPrKcfrOsXj98VPqXDgW2OufKJ9pIs2KjO1rsi6ZsXEco3q8REJnanY0ruWcikQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 18:03:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 18:03:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: jgg@ziepe.ca, kevin.tian@intel.com, 
 Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 stable@vger.kernel.org, iommu@lists.linux.dev, baolu.lu@linux.intel.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <38C8DF0A118B7176+20260811095551.2756745-1-peiyang_he@smail.nju.edu.cn>
References: <38C8DF0A118B7176+20260811095551.2756745-1-peiyang_he@smail.nju.edu.cn>
Subject: Re: [PATCH] iommufd: Fix UAF in selftest IOPF reporting
Message-Id: <178664226485.282103.8211602717805460519.b4-ty@b4>
Date: Thu, 13 Aug 2026 14:31:04 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: cb08454b-9a54-46be-a7db-08def965328d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YnZiVMjC5yZ53AQeVHcXXeasrIRI/s9v4kpX4MxuWIfeMeCW5pYjv5CAyHd0s2ZoOgtbVzjls9kvMlj/hy7CeQedsKS7w76eUQaKcRXciajB6xjyHPzLMDgPu22jPK5gm4cUIqvHGf6fgj+GZIrPTuSkgE6eoqcxwCkXX2KOjlC2ELZDB7S6d592tBQgRNUKyPc6NFAplIrsg4EtQ++TdrAjKVTAz1s8krP2TeHC/GxutzfxTXWLzsC4Vo+lrd9Jd1AMQy4rnTgjP7GTUNg/dA6KvCinKy8YUmscz9+zl9+IAi+zzHG+Re7X7PP4prJVeXfV5quTvRlgb2sdcY+XnrV9D9rCmZHFWlhIuTqGNOlT8NUTSGkNWjuPGANpn4G1VP8QoNsrrY4SOwZjYpsM8UMmRH9fySSrNm+1k87zHg+5P0PpZ6LxGoNRm3YByGt1oK1IazM3IjquBxJlr2FFRX1W0bT8NCBHDEzg823nGOYT4YmTTq8+XXr3gdPZ14ranx9vNgYUK8oYlDzT0je6uBo/rc/WvF6x4+JU+JX2CrmTlwlytl5bZUVKR4qi6wRDJr9mYZKl2mtQ+xtpavukhNB9EIzIzZzYi0frFSG6LQBZUt/OX+8IQpisjKWn9JexZVsUzsfhtZ8WzEMYMkgphBopGdX/ML/AFGTJAy2dJgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWtjNVZMUnVqSzdycTFkTlZ2cVZOVmhYMkd1YmR6eWJXdVlqb3F5NVA5V1Zi?=
 =?utf-8?B?dVVRazBzOWkxcjQ1WWx1NDNFdFpvSFVwb0U0ZFp5MTlIM0Z0Q1ZROHJZQnNL?=
 =?utf-8?B?ZXJJYzBMeTdYNVR5OFVneUZSdGtocG5yWjZWNTZZcGRiOEhhdnZLMG9lcWlz?=
 =?utf-8?B?eXdBRUJyWW1UNXFIa3podVlET21rcTBseHlsdmV4bHpNOUJBV2pNUjd0WUlx?=
 =?utf-8?B?ZGdKUmVzVVlEWngrQ3V5dk9UQkR0R2luMUZIUXJaMWM2SWpoVElFQ0R5dWRH?=
 =?utf-8?B?S0JlWlhQN0RaVGtSYkRZT25XMy9IT0NDaVBYbFZmS1VLOTNraHVrVWJrMWRL?=
 =?utf-8?B?MnRZTVZEOFhGaCsyQ2FyNWpOTjRrbkpSYkdza1A2cmdLRjh2WmZoNnFHTEYr?=
 =?utf-8?B?T29rUjc2Zm0xNXJBUlJvekdZQUUvRitDUHZ2QzZkRVk2b1p6N2lxZFg0TzBF?=
 =?utf-8?B?TUt3SWR4MVBkRkkyRHY3MWhPTDF3M2pnOHl4djhVZjkzUTJ4YSttcDE0Q3Zn?=
 =?utf-8?B?dDNFTEhud2lia2h0aFJZNy9UZ2tiWEpkY2lWZHVjQS9yRFp1aEhNdzRRdFZS?=
 =?utf-8?B?dFh5TkZMcGdhVmRHSStUSTNwSzFSUDZFMlBQY21OOUlraldkMWFuTDA3Z01u?=
 =?utf-8?B?ejh1WlVPRkIrejdsdTBVclk1eEFTMnhkdGtLdG1kUGFtSWxGM0hzOS9EamZz?=
 =?utf-8?B?RTd0R1ZOUCtxaEsxRjVPK25yZDFyVmNZNll5L29ZU3Q3M2prMk5VV3AwZVZ0?=
 =?utf-8?B?djJWZ0NnMGdqdi9XY3dFK2prbVNEMEZHWjZQeVl2ck50dWRrT0lTOWZPR3B2?=
 =?utf-8?B?a1ViZFNzRjFwYXFWOHIrdmhXeml4NkoweC90VlF4akJKVmhWZFFUNk9vaG9F?=
 =?utf-8?B?ZzNGUGtqQnJhWE52dk82MVFhaWtZWUhNend6VzlnUkZHNDY3d2hIa3V4YlAx?=
 =?utf-8?B?VTBNT1RjSU4zN3ZPcUlTR2RRTTFBWFRZRDY1dTFPOVF5dkhIWkVYN3B6WTIv?=
 =?utf-8?B?Y3dBOHFqektGTzBqc2NkRmd1b01GV1czdVFsTHVvMnNXS1NUdmVlbFhhcFI4?=
 =?utf-8?B?ZEEzSCtUYTRpaVNCajFyM1Y1VUg3Y0t2ZjZPVUJiazJsOG0xV2ZqWkFJeE85?=
 =?utf-8?B?T2RPYlNyWU51MFVtZWVLYW1TMVNDSDRoSWU2UlNmY0FQcVdQdkVxRmxOczhK?=
 =?utf-8?B?Mk1TVEJ1UTNzOFRFZmlmN0YxTXBDTTNSeGdvc2dOZjBMNDFvbHQ5NVovdnJQ?=
 =?utf-8?B?YzZMVXNTdDNZeGthYk5UZS9hc1F2ZnB2ZE1oOWdyVU0rMTZ2NG5Mc0s1WFpw?=
 =?utf-8?B?YytYTDR5UlhkNy9Uc05Vc1BwMklvdzNrOGExSldFK3MyQldYb0NEWm5mTkhv?=
 =?utf-8?B?UUs0eXI2T2wrOEVROXpQNkphVzlROUJCYlNkU3E1bVZCUFNDaEVSbFRYRmM4?=
 =?utf-8?B?WnBYdnJWbmN0dkdCNzV1UnRObC8ySVhqWWlzSWExWFE3QlFsbFEzSnlDUkhY?=
 =?utf-8?B?N0VzYVNtWWh3aC9iVFUwb00zZnljT1hyMGRxQUNsNnA3eXZ4MXBSV0x6L09M?=
 =?utf-8?B?bk5PdDhWYXJCRmdGQlZ1RFhxMFc2MjdUVmlualV0c1RucENNUkJDejd5bEUw?=
 =?utf-8?B?YUp1UWZ0aXVlTVZ5SDlVR3lBT2JKMHp5QmMyam9NSnc0Q3lYWGRKOXA5L2oz?=
 =?utf-8?B?ODZlK0dHT25NYXNPSXVPdFBoek14MTEwbmpxdVo0VWhSb0VkUmVBbEREbjdn?=
 =?utf-8?B?Y05aN0M3MHNjbXIwcU0wWm9oV1JhSnJhVmQyZG8wRCtiOTFkSk9RWmZLdjNW?=
 =?utf-8?B?SENhemMweDIxUG1kUlpDMUVQcWJPYXNBQmVSK1BjdjVtOGZVcitIZjlTVTZ6?=
 =?utf-8?B?NWQ0b1RFc3NQUWdNSlNZMEsrN3FNUEhUMTR5TzN1LzVENWZ5Zmd1SWVVZmkv?=
 =?utf-8?B?U3BUbCswU0dQOWV3WGthY2ttVW96dVNjcjJlZ1p3UFJ0ekpZRlFzOWVrZjM2?=
 =?utf-8?B?cTNnMmdpczFHMXk2bkMwUEFKVHBvbG0zV1djK2VaZnh3dVA1T3Z5YnduOHpG?=
 =?utf-8?B?Q01Ic3p5Q0NKYkNRN3lWemxRRVRIT2FoVGpLQlhHSGE3dEE1Qk1mNnp3YnpM?=
 =?utf-8?B?dEJzWGF1UWJyM2hmSkRKVkU1Zms4TEczUGVDSmZzWVZ1eVE0TXQ3ckNrV01H?=
 =?utf-8?B?SmRPOVRQNHFpT2xYZlpWbnFUaWpOaDU2cTBwRnVMcThqcHIwUDNPU1NKVW1z?=
 =?utf-8?B?bytWd3JDUUtZbUFZWDFCaFdWM2VId1dOSko0ZjVmcWJmR3MvdXJjeklYMWty?=
 =?utf-8?B?ZUV3Vnd5dmg1YVIrOHovTTFUN1VMTlZEaHpWRlBTSHUycTdKdlBtdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb08454b-9a54-46be-a7db-08def965328d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:03:37.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lYtDu3NKH3puyMQKVzLrPtnxsu0DiOJNOA8YRL3BPUF7BmiAh4ITaYWFYIxpNwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033


On Tue, 11 Aug 2026 17:55:51 +0800, Peiyang He wrote:
> iommufd: Fix UAF in selftest IOPF reporting

Applied, thanks!

[1/1] iommufd: Fix UAF in selftest IOPF reporting
      commit: 8c07df7cdfcf52f1ff276c588612aabc6c6b8399

Best regards,
-- 
Jason

