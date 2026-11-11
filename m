Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794438937;
	b=cHLn6kC++7v1tkVjxi2qx1+Kwpfji7x+exmYJIxgFSH1PwfH+gqSQOoncSjsUeaKMPHU
	 WvVgneQUca5aE+LwsWo1GUrwUO0KmCX1ZFbds33Bgg1+ABsE9xijPO1fE+W8YE4R1+aeU
	 DGnKxuVcf0NvWStFG5SsVfHFjlWbMXDba6DTWSpyqk6xzAT52+UZolnHJJeoQeC9DuIox
	 IVqWOLCWNHwReu3uzIeuB8QOMe1qlhjHwEmDtNOFmNeG6D6axxP9mFIi7XkS2qc8WJWt9
	 5HIo8sYliVRVQW/OYN+wkXiEpZO/RkYO+b9I33H/Xt4gtS/O1JsaB2QDsUj17w9eBfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=l24hbdstZoU8pT+qLZIzM9ey6mHPSs8iHMnFzfzHnlM=;
	b=GDi4u5q8Jyes1vaXMKV4WKhcEvl27BpFu+pYI87TuglslWNfg+d4l+vGtvOMLc4NUHhc
	 IRkjGsqksotwRcyOJEM6cvjaZj7Nqd8AO4x87/kbK7G3X8qs+J/c8uqv+8aORpvzfMFrj
	 O8wCJdK5CFItbI3CxlQd8FfZBtxOEG/e3aJQYAywmjcA5ESF8K10o9mmvdVD+Z4qS919c
	 U6YAvlDJ5pZy4pZlsdGQhiPvvRJwF5mKu917Ad0AtlgGV/lG2KUaUElMUkdLYI/1th8xy
	 c2HXssmRk57xJIapZN3r33PrQX8/QgdIn2JcMBpU8U/hxs1n8pwHofzY9Ocp9Zpemuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EU3wBpIy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.38
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9C606A321;
	Wed, 11 Nov 2026 23:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EU3wBpIy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQk1OSIi4RMTsfy9h1AhemrAoI4TV7Zgnmaqwck7w8urDIAprbe5Cwqcm/wlZsVPamoRf3WwlgLJyl7F8ifiMlOeud0XyWE3zXRW4NxYyeWudfR/IOKHbUHlPOryZco3fff8dka17SAX8K03htCUmMNL6d/HrhKZx52HiAqoR0XYLSOf7GTurTxurVZuf17vX3PS6hXHWx92LLzm+DMUHMPq6bojmsaNZzCwB6Dpptg3nhnvE8iPKOLiSscWJIFgmX9Kc8vi2UGrvFrPmcHlTpKEXAMVtWFcZEvKPhqxYMx7BulMLKv5bmBNO75kPh4XozUjcuWjwXkbkufCrEj7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l24hbdstZoU8pT+qLZIzM9ey6mHPSs8iHMnFzfzHnlM=;
 b=FwU54WGWJR2u0ys71T9Pm5eIWUqanTBEpFPxYfrZlMn17jyXaBOWusN9sFCXj27y752jwTvw+4/58hcGlmQsyjZ1pH4B/LErxD6mncbK+rxJUB8GfMdtqLzojr0XDjwV6eyTLwJBrVXin7N5jaeaT1gceawAkt9kV3eHzUyJKSChIe4ttC0YT1MU0+I9e95ClcS9TWOE0xvCG6MPPJdlPr6t7a9LjB1n8ae8lrsAmDy3Vam9Gjr038N6B35kkWvaD7Y3v4nc4wzZRUVtsDmLjdXKr/vZ3SsSagry1HhOmeEMVaUFKC/rUWKM65hx35sH3P/Acla0jUog1eHnV1sxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l24hbdstZoU8pT+qLZIzM9ey6mHPSs8iHMnFzfzHnlM=;
 b=EU3wBpIywsakbpPoR1k6d3Uhfc4Y1BfomcoFcTSoPq4aXW6grTWNOON27KACmDJgNZgmUkRDWjaRVLWBQHmvy0kQe8tCB7Hx3vDLRDY0VVfKOaSY+rB/BXVkE5bq4WJzyCp672YMvQ4JOOnBrbJ2z3u9311kDadN4aDd+HvtvplfjvYBdXdn1lTg3asQtfjMdwcjnYRImals2HXd4Z3cp8Zp5/Gp1tr67gd/CeTX9HipgjbSHR1JRY+H0o3wQZeCHF+u2WZqv2h1TsoA0skj6hmZ78Ss9NHiAXuCS/3L5u659bjBMt4jM0hX8bwQicknSFQqwHAKdi+g0ye4wjp9wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:15:28 +0000
Received: from DS4PR12MB634945.namprd12.prod.outlook.com
 ([fe80::24ec:530f:4816:dc]) by DS4PR12MB634945.namprd12.prod.outlook.com
 ([fe80::24ec:530f:4816:dc%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 23:15:27 +0000
Date: Thu, 12 Nov 2026 10:15:22 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 10/13] mm/migrate_device: refuse to migrate shadow stacks
Message-ID: <avT2FNTZoEuijEZP@nvdebian.thelocal>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org>
X-ClientProxiedBy: SY5PR01CA0105.ausprd01.prod.outlook.com
 (2603:10c6:10:207::13) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB634945:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: d58076cd-9631-423c-a33d-08df4049ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4GYQ+jiDImRHARbt9k9zD1dhK/V6n83PM0KTbSlyWk18y7VLnysnXake+a9pFJ9CJMtXQYwKJhrd/ppw3Yz64WTFo0VbvrwFEWQFIdr4+Xk8aGsIhSJYY+OwQ4Yh2jIV7HF2YruH5L+uYNbpNg5zqGCdbWf1/Y4yvHDYLN5JfR90ejoGNqyBkd/EL6WXrVQ1KV23XYNYFm2V5bCbE6kJR/NTxeETZDNHBnhU8Udjv5dlksqBTagVLtaK643uTPJzS0jkVLQuKlwhYQkWSrIpWK5IFAba+8N1IswB72s4GT3XxaHQ7hYbCPu8+7iLCAAfH8xlNzbyetGc6OcIfmhfcwYr6+wYiwWKDtHtH7/SOWOeQVCstlc08rh6OpFVzkwOpq3Vdl+ucahAoQNCDS/2fsmJyCYLSxIDwaMcYwG9WLwQ0apdvU4BXmPwhu33XpSksj9QZxNC3uIcSszeRbCgTOXqb3ciac2CXjxELlrdzQMRVs6c00E+aCayvAfSpceFUxRtVpPTUjEMLrFi8XZZJ7fg3F/OVLWV0FORnshpatlsuFeESI4RGR8DLZk9DLJJ9P4AqQ29NcD1fZt0CI5XbM9l3Sahy/INkqR1GGVyBX14VrmgQ3C5KZrwMyBM3C2YJ3uVYcWKrncUCYXkG1EiLagt3Bo82s+BegbhFTGoBWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB634945.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0ZQorIlwpecL3itzRhy+8iDyALUz9OaDSuNlzAI6RWjJzuQe7aLtcWaAINc?=
 =?us-ascii?Q?U8lyqU8/DrvldDSThntQY3FHHblgGUvuB7LZbzdDvTUtau4Bt1+TH3GfOsSw?=
 =?us-ascii?Q?LoP4T6A/viKD3lfMG3i1heNdwmznM9jZE0DCes6E6CvDpAdDPh91QcAXidAt?=
 =?us-ascii?Q?LkQSDb6m/JrzbugynQd+zcssJ6s19XsCT0BGqSYcFtqSSc+tEyXCqtutD3Y9?=
 =?us-ascii?Q?YFrzyEpVo9eE0YpmbUjxTkpdCcLDmqIRoixvzA2MvT91lMaU2Wc54YGcrvHS?=
 =?us-ascii?Q?czKzEg2YfURSqzx09/ZdASndHM7bKYdaXzQZ5Ysgs9i52kgmoYpaW4GSGLpQ?=
 =?us-ascii?Q?F0l29qLfI7eMSMVPekjELhZXB5BMY9KPHfHBXf/NITMTcHYiSatxsVq7lG7z?=
 =?us-ascii?Q?ynt/cXTPUPhmnl/Hi72IxZhR7lpAzu9NzqJgJ0JefPqF5AcQxpzA/zLpha88?=
 =?us-ascii?Q?6BYS8wjJGmwX0iPGf+jA1raMRzvZU8ZIYaiWygTV/H0R7vmZGy306OolpxHw?=
 =?us-ascii?Q?UcutIYkFTBotXObtQrFS2VOxZJzfYF5g7RrCm9j9uYDgGxk0SDJU/73+0LeH?=
 =?us-ascii?Q?tQc+UUdor7p4MfCnCGroo7vIxMMjjrTWj4/lPrkZTnTSlJglRpgLl82I18de?=
 =?us-ascii?Q?sgIpI4Txmj+RNY3ixQcAUe5cBde1vVgAcCzzdOb7j7SDb31syxciBeo1rOvR?=
 =?us-ascii?Q?zQ5HLGh7k7Pbe04xJ8PW0Mtiahubu9Hh4+ALVRGDmNVWOqriHJs3ER6nYISv?=
 =?us-ascii?Q?tA6DMikjMOmz46IMwJrSo84sWIL3nguH02Dxv6K9EADd1u1jz1/PciMUJvX4?=
 =?us-ascii?Q?hVOrBXn1bXLzAJdUJP9xfmF70d8YyMzzOjWY8sdkeVpwNBxomWZXq1pNC/61?=
 =?us-ascii?Q?7GYyuMtalZNfOWjmaPBTofyvBoSeq0+D9c5s/QwBYrpppcY3KKTvc7ID9NX4?=
 =?us-ascii?Q?0HDR6B/q7n/HtYEjKITEXTa+7IgnzJ/QPEo/oqp18aTPQ1w81cnOMbmGzbBO?=
 =?us-ascii?Q?Qcve4k0FQXLqQEHwEqTm2Sgtgxj3Hanbxd0O39SAOYJoByCyR7PDyxudBMBT?=
 =?us-ascii?Q?a8PdNq3qI6ol+IDgbuya/Urc+IoAzwXyjIbhpXDsJfQWABZLFzYyTzQkUOjO?=
 =?us-ascii?Q?R/d8/2YOwaKZy/rM65FNJfn+kMsBK9cz+jGXB9fbmFtVTqb/d1RM8QMPj5Wm?=
 =?us-ascii?Q?1ltZOEt+15eCuujJZ4+kA0oECVE2Va8p5TckIX83tbG5+jhFooRVqsbINbuT?=
 =?us-ascii?Q?5aU72DlWyY/67kTN923b/Z0dfj3KnSBRRrjLc5dYTmfH1nXVDwIrGrGiPp9x?=
 =?us-ascii?Q?KdstMiAlMLAOIEt5r5eoBJBB8g+r//y0lr7JWbp0n/8l++ae+dD0k/jC+skt?=
 =?us-ascii?Q?8nrCNxJlBppcOMAsWOa1h+E79brQwslEy+KqrFYDwLhICZ7TpMewylZy7im0?=
 =?us-ascii?Q?+7ocshtedfafpGn3IVGkIH+46NeM6dTma98HXjNgMFibFs9Rj0PMkylz7qTZ?=
 =?us-ascii?Q?AFecsKqaD8ngPWa5YcbsqckbdNPBhQknRfcNWeNlQjZXWFEolWYfqim/oiG/?=
 =?us-ascii?Q?7Bxt16F9x2AK7tGBIVIg+M8pN2tY7ujdqlr3zneX8De90RV8i7gNpmbPsxnj?=
 =?us-ascii?Q?PM35gheHo9k3P4qYOkhluto+GoKqh7ABHRb/pfvr3S1J3SLCuut/9k5aVp+V?=
 =?us-ascii?Q?KeZL9MODo11t9P2iSEc6evyaM+A4dvj08hteF/r9EC33utsfvR3L9wnwyPEn?=
 =?us-ascii?Q?URBdssSY8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58076cd-9631-423c-a33d-08df4049ac23
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:15:27.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSKwXduKy99LYwG6sdRex8m/vShAhyoE8L1FrrMO05FxRvdm1jofrFCaN5ZKd6qz7QDRaSetRxI+jigzuFBYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328

On 2026-11-12 at 05:13 +1100, "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote...
> From: Chris Mason <mason@kernel.org>
> 
> The kernel blocks ordinary writes to a shadow stack. But pte_write() is
> true for a shadow stack entry, and migrate_vma_setup() sets
> MIGRATE_PFN_WRITE for each page where pte_write() is true.

Does hmm_range_fault() have a similar problem? It allows devices to mirror PTEs
into their own page tables, and AFAICT it doesn't check for shadow stack VMAs
and would see the PTEs as writeable. Thus devices would mirror the PTE into
their page tables as writeable.

This change looks good though, so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Notably, the nouveau GPU driver takes that flag as permission to map its
> copy of the page writable for the GPU, meaning that the next CPU access
> migrates the page back into the shadow stack, and the page then holds what
> the GPU wrote.
> 
> Be consistent and disallow this for migration.
> 
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: removed unnecessary comment, refined commit msg ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 5fe11dd01291..a59864f2e9a6 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -759,6 +759,8 @@ int migrate_vma_setup(struct migrate_vma *args)
>  	/* The migrate_vma page walk has no hugetlb support. */
>  	if (!vma_is_mm_backed(vma) || vma_is_hugetlb(vma) || vma_is_dax(vma))
>  		return -EINVAL;
> +	if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
> +		return -EINVAL;
>  	if (nr_pages <= 0)
>  		return -EINVAL;
>  	if (args->start < vma->vm_start || args->start >= vma->vm_end)
> 
> -- 
> 2.56.0
> 
