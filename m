Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF83546D3;
	Fri,  9 Oct 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579087; cv=fail; b=DVXeZ1tsTUzdplILYUwDnERBGbEkaWYB4z8s/1KQLn56LYvwRVGVM0DwrzSDn+OybVPExKPCX318AQ0Hi7wZPur2oHpDfxb/Xssvd48v3hq9VvxybERNeoydN7zqY0hP/rkToPUeU1Nq5pybK5r0GeNHQ1ZpCBKlBEx5WH8+XCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579087; c=relaxed/simple;
	bh=ASNjIN/xSJz3VzZG65y12Ej+A6/lzkIEE/j7QwOOmF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtT7l9ltXXAe/Z7QA+6Q4mvNV3FiBJYZ7Wbemn3eM06fjrc5zIzEPtw2CZkx9Yw5/CYHWLnVtnf8kYU0mEZnN7fIHCzTSNbEdw6tYLDVc3rEO52KNC1vOeDG7IQ/VPqRXBziqc+EZO7OJvjo6CcGDi6lDN1tnRZDrlJ1sbd4bKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zo53zRqy; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zo53zRqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsVSsi6txkgCfRln6PQduORyhW47t3ov2uDUrrYhq55NQi3oteGlyO1TuC4/1cYhzKwy4Qdk3+FgDepbLefsFTYO4I9QGYh/Nt+w1rYssR+BRVkPq8+XqpE0NHGkA42mbQxLH62vGtGsihNGSQ1gZRGj793WTJvzseedeS4unTPKtRUpQoItvtKhlPabp9ExJ4sBycC91+oKSNMGumDSwvTCqWc9+/58bfnlCwmVEyNCEYcTQ+19sAeN6GC/H9Hjn3H05rNocVzqF1nQ98M+2uGg2xsXOedqybuzyxKc7xlJhV5TagnFZBHgq7YZt0fnK1H/5DOKYtgYWfgUNzhpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qelfgp7joX40/kCGoHulfErJzhD7bsgwxWpDUvbWyTs=;
 b=MQ7UYowWWrB0m/pMUROR3FKoS7coAKQVI9YY13DlpWfgzXaeh8Uu8NxefVjkzwshL+j3q+BU9nuKG3gfSgwQotQ6QvxUiooH0D0A50kMmerTxKijx7p5BT5I3vSO61ZgxSTBFpZmObIOHVSXLOqylV0pG0vs7f/m5qCKxXnXtbCZohZXJh2ErLaOXW3a557lfhYvup+i1fe/faRzhUDpY0SGm1BywaCRzdsJjGABVAFUeHWNxpxuXkTMJQ+U2u4m22g4am6jm2hb/aKsXVKQQ1hGBi4ZZ/mXEfH8RadtTC0cuiA35b9xvaA70bG4Yk2m3ylN22E5wUo4mQV9pIu+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qelfgp7joX40/kCGoHulfErJzhD7bsgwxWpDUvbWyTs=;
 b=zo53zRqyKXX1xGk8iU7l6q+1u0A9c4A4ACmgFBubO8dNrtvaD3jX5F5yUYPBpLECbZVknwTD142O+wKZOMR5Mn6sw93VmHF/oeGl493iaAAdPHU5/QBPq6zd213yUGBSm0sLuD73+0WjNeQgvBprvREnuzbyyBkse49YaUdfYyM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by DS8PR12MB333896.namprd12.prod.outlook.com (2603:10b6:8:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 20:51:23 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::f71e:4264:146c:b356]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::f71e:4264:146c:b356%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:51:23 +0000
Message-ID: <28d92715-0977-4d6f-a5e1-aaad140f7fc7@amd.com>
Date: Fri, 9 Oct 2026 15:51:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Don't allocate kdump device table from
 DMA32
To: Matt Fleming <matt@readmodwrite.com>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 Baoquan He <bhe@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
 <20261002133143.3628181-3-matt@readmodwrite.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20261002133143.3628181-3-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::29) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|DS8PR12MB333896:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a8d67b-73ec-4232-18fc-08df264713e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|56012099006|11063799006|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ImmF335cyg6SWy1b9HDP2YANOvhEIztkI0y//omcmHa1iNkuZutvQQtw6FkJBAWt0kCK4+6vRCeVtT3aWDQQMyQAn30RNXelwCM2p2fzyzokvo+IbCylTs3gf+Nt5MSuLU4IOR/WgcgayZ0KI/uGAfXcCY6XzpvfqXm7VAPpwff8NekJh38smNPmUC+oSre8r5eT5PDSaMa572iM8vNUwQdV4H/aRACw8FOWyq3TW7INjFLejYTG4iFVEnYmk5fE2yAj8Jn1du0ih0JNEem3s/aoMA/psOrUO0zbf2ZPIjsjHT/LRbbCdodiu3XRWtQHqlDyEZyWMdu8MaeNSYFadZ6XwKBsZ0ik6aTSsuipDpabq4uMZ6BdjKLhOZmU69XYTLxI0VsPXsoLjYMqIvs7YwEO8uSY727Qi9cOwwSIGzJP/lH6HNAUFIZbg3jGo5LSchVWv5nuAP4nL9HD/tP4BJKMdG7I/mpi+rE/bbK8JNlDNYb9JzAPbPRI0BnVV8yJME3BqAjt8TBSlzDs+tsDot30rWkvgMYb8eBmd58furqW2s6PIyfKc0RDXUxx2nHq6c6YBuNsMX+vmoT5Sp2VLK0fau0SBgzpv+8IoZe6CPtw/HHLfUA1j3pCr+ZCFtdUuXLGfIqy2ol7+TgR2kNMFdfIzh9IlHPDi6o/gXF3khM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NWdlJ3OXdtN0gvRkpSa0p4NjRDWmd3TTFDek9OdTJ0bEdIb1FET0VvMWYv?=
 =?utf-8?B?bG0vSi81aGFoVElkalNPMm1UUlYrcUJvVHMrbm9yUHFXaXk2UUFGQUo3U2w4?=
 =?utf-8?B?WFgyU0NFdmNrU1VqRVVTdlJ3bHpKOGVHaUNnZldaUHU4WjZXT2F6djRlTDZF?=
 =?utf-8?B?QWVRRko2UVlWTEVWeE1rdlJCQTZjNjBIdEhxUGdMbE5MYjhlNUIySlQxWkwz?=
 =?utf-8?B?ci8zMnNZVStwWC95eWtpNU5ZL1BDaWpJL1YwRTFWUURCUXJmZUtKNENsdXl2?=
 =?utf-8?B?NHdtdFJNbEQvNEJqaGlmWGFHcXBnQlVTTjd1YUJ1dDlWWTk0U1F3WDZJLy9D?=
 =?utf-8?B?Q3hzYWI0RURZditJZnF2ajZZb1V4anhzSVdCYXlsLzR4alVQMmFZdWtTZ0dp?=
 =?utf-8?B?Y3ZRMzM2SGQ5a0VHcTY2YWx1REtNZ1dpNUIrcTFYS1JwdUNwMFM1UkhpYW1w?=
 =?utf-8?B?c3RWVktRRkNmbnB5eEU3aGZuSm1XQmVXSEF2SUR1YkJMUzVBVjU0WXBrWm1q?=
 =?utf-8?B?bGVKNmUvaTEwTEpiTWN0WGdleC9wNlVUTWdaZTJQOUN2dU15OFNMTHl4enpa?=
 =?utf-8?B?QTFDb0FuaERsTXlUOFBZbDhuOEJhVVAxaktpNHZUR25zcUlhbjZ2VXFWVE9q?=
 =?utf-8?B?OHlDSzRmY2RXVDkvOVFLbWE0NWxpMmsrRzlCNnorUFF1aU4xaytqbXAyV2lB?=
 =?utf-8?B?eXB0R1NrK1hBT2UzdGRTZGZ1Nmp3Nkk1SFp0YVpXbVVYd1dSTnFjWGxENUpx?=
 =?utf-8?B?SzB3YktxNkpIVWlWdUc2RUFUWVFDWDNVeWh3bFQxSU1kdWU2S2VmNGZMd05K?=
 =?utf-8?B?SmhDT3Yyc2FJbm40RXR0d2lndjRJckdDa0VkUHRMUWdBMEE0cC8xbEprZGw3?=
 =?utf-8?B?ZDVCZVVORXpiLzVnbnZyWmkvMGJxVXhDaFBoMmx3U1BtQUJYYktMdlFHMDlQ?=
 =?utf-8?B?aHZHcEdHZVNoRnA0VndtWUpOQjRPd0RBa3lucElFK0JPaW45djFlZjM4K1pm?=
 =?utf-8?B?ZFplVjhuVVhlZ29KZndPNkswayt0ZTNPb0FZb1JtcmNsRTg1MTg5NHo3YWh5?=
 =?utf-8?B?bGgvc1Jva2tiS0tjR1RBaXNmZXBOeTF4WjVTaHpuSGJVV3F6QXhyVDlFdS92?=
 =?utf-8?B?YmpmbUR6RFdhQUE0ZTRCTkc3VHFGUjRYQ05NT1hmUGVTTlp5NzJYaXBpN3lu?=
 =?utf-8?B?MUxZai9pd1VXQUk0ZGJsdHg3TlcreTlZVmgwMTlxeStFQjNSdlQ1d3NwNG5k?=
 =?utf-8?B?TVN2bE1iUmFsekxWL0E0UUVrV2hESmxQZWtIdDVjZWgwZHlKVkh0ZER1VkNZ?=
 =?utf-8?B?NWJaQVNSd0xaZC8yTXZvNjVSSm5zTEZIcXhTSmIzbWJPWlM5RlhGdmhrb3Zl?=
 =?utf-8?B?VzRFRXBSSGVWUVNabG5la0Q2d0cybklLUG0veG5DR01NVm9DeG9XNnREVzR2?=
 =?utf-8?B?dHFWdXBqak5HTkVkOWhaMkRVTUczRzVxRjFUaVJTaHNFVDJtTWRTdWxpV0FL?=
 =?utf-8?B?cXVpTVpoMkRoV2NWMVdrVjF5M2c4U0FsK3ZRV29sOFM3UWM3RGF3a29BUFFq?=
 =?utf-8?B?cWpHdDhoTlJNekswR0ZHTU80d1BvMXY4QitJL2JNRStOTStxbmdHakpJZTcz?=
 =?utf-8?B?K0RTNVFxUE8xZjJaaVpJQmhrN2NvVVltNHBPdS93U0NCVjhuS2o5NlY0dHBT?=
 =?utf-8?B?TzBQYmFiMXM5ZWVTZks2Rnp1a2tVSWZIdGlMZ3VtTWpMUDFsNm1wL0RvbDln?=
 =?utf-8?B?V0RXMUg1UUZiVmRmVURlZWloYmMzWnFWbldmSUdVck1nbW9pdFFmM1VMTmp0?=
 =?utf-8?B?OGNEZnRONjJWaFppeTRYUDdFVzVNcU1JRFpPK2hKNGF6cHVOME4xcmJLcmtS?=
 =?utf-8?B?YW5BK2UwcEN5bzh1S0VWcGNrNzZzMlUwOEo2bGxXVDlvOWlJM3d0UjJPL1FS?=
 =?utf-8?B?eTB5eU5qdndHeENPK3VacVRDYXlZdElmMW02dWszdUt2bUlITjFHTVBic2RJ?=
 =?utf-8?B?R0lpTnIzR2p3SWZFdWpOaXZYV3czMm44eUVyZ0owbFhFYXlHWVJjVWhGMmFw?=
 =?utf-8?B?UU1ZMWVDU1lmWDlMWGNLRFFMWmxZVDdvMGQwRFhsYkdiT1AvMVQrZTQxc1lo?=
 =?utf-8?B?bll5OFhGekxKR3hzRDlrUmdBc01Jb3YyQTRrN2h1bzEvZjQ0R0pDU3lTZUl1?=
 =?utf-8?B?RjlGM09SOFJQVERKRXNPQStUa3Vaam9wVjhpclQxY2k4Zk92SHZTWjNtaUhL?=
 =?utf-8?B?RUpHMmFudDFKQUhzQXI1VVdSUk5OS2IrYmFyOHBBZFp4QUQ3TThKWnowcjlE?=
 =?utf-8?B?eUwyd3hzWmN5YklxZ3VhaGNLcUkyZDBVaGRaTjdxL3BwdlZBeGJLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8d67b-73ec-4232-18fc-08df264713e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:51:23.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8w3ZmXOs4UwvE3LlN2HTS1+Ho9rgYTFjH+XyWFpUGmXlOIOJ8Uea3FfXYYo/ZGyGwySlWnnXLAx1bUxqB4YOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB333896


On 10/2/2026 8:31 AM, Matt Fleming wrote:
> [You don't often get email from matt@readmodwrite.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Booting a kdump kernel with crashkernel=X,high crashkernel=0,low on an
> AMD system fails the per-segment device table allocation because there
> is no memory below 4G:
> 
>   swapper/0: page allocation failure: order:9, mode:0x40104(GFP_DMA32|__GFP_ZERO|__GFP_COMP)
>   iommu_alloc_pages_node_sz+0x7f/0x150
>   alloc_pci_segment+0x4bd/0x650
>   iommu_go_to_state+0x213d/0x34e0
>   amd_iommu_prepare+0x39/0xa0
>   irq_remapping_prepare+0x83/0xd0
>   enable_IR_x2apic+0x61/0x370
> 
> On our E810 systems, the kdump kernel booted but ice MSI-X interrupts
> never fired and the TX queues timed out.
> 
> Commit b336781b82cc ("iommu/amd: Allocate memory below 4G for dev table
> if translation pre-enabled") allocated device tables below 4G. At the
> time, the kdump kernel programmed a copy of the old table into the base
> register with the IOMMU still enabled. Keeping the table below 4G means
> it doesn't matter that the hardware splits that write into two 32-bit
> halves.

Probably, expand/explain this a bit:

The 64-bit base register is not updated atomically - the
write lands as two 32-bit halves - so mid-update the live IOMMU can
briefly latch a half-written, invalid table pointer. Allocating the
table below 4G keeps the upper 32 bits zero, so the register stays valid
throughout the update and the running IOMMU never sees a bad pointer.

> 
> Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> the kdump kernel reuses the previous kernel's table without writing the
> base register, so its newly allocated table is discarded when reuse
> succeeds. If reuse fails, the previous patch programs the new table only
> after disabling the IOMMU. Either way, the kdump kernel's table doesn't
> need to be below 4G.

Since dropping GFP_DMA32 is only safe on top of the reuse conversion, i.e.,
on top of 38e5f33ee359, so it should not be backported without it.

Probably, consider added a Cc:stable tag without Fixes: tag, so it doesn't
read as if 38e5f33 was buggy

Cc: stable@vger.kernel.org # depends on 38e5f33ee359
Signed-off-by: Matt Fleming mfleming@cloudflare.com

Reviewed-by: Ashish Kalra ashish.kalra@amd.com

> 
> The previous kernel still allocates its table from DMA32, so the kdump
> kernel's check that the old table is below 4G still works. Drop
> GFP_DMA32 for kdump kernels only.
> 
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/iommu/amd/init.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 0572e1a674f0..16c26d75f46f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -648,8 +648,19 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
>  /* Allocate per PCI segment device table */
>  static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
>  {
> -       pci_seg->dev_table = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
> -                                                 pci_seg->dev_table_size);
> +       gfp_t gfp = GFP_KERNEL;
> +
> +       /*
> +        * Keep normal kernel device tables below 4G because a later kdump
> +        * kernel only trusts and reuses old tables below that limit. A kdump
> +        * kernel's new table is either discarded when reuse succeeds or
> +        * programmed after the IOMMU is disabled, so the table does not
> +        * need DMA32 memory (which the crashkernel may not have).
> +        */
> +       if (!is_kdump_kernel())
> +               gfp |= GFP_DMA32;
> +
> +       pci_seg->dev_table = iommu_alloc_pages_sz(gfp, pci_seg->dev_table_size);
>         if (!pci_seg->dev_table)
>                 return -ENOMEM;
> 
> --
> 2.43.0
> 
