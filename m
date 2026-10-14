Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2133A9DB2;
	Wed, 14 Oct 2026 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953629; cv=fail; b=LmzebwCwVjD8awFSyYKvfXEyppJ5c3PeSpPLgwcDhlkSLkzKnLQxqubXVv36cAsG2bPxj/COxU/M0Iplc1kSYhJWRYTiGXPRt/cLNF2mEjo80U/KZ0p8PVOwBVQ7FAkixgAq4uyJIWfRtnsXdv9SbJXyhPu+Rin/hooYLbm/o9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953629; c=relaxed/simple;
	bh=2sVHavMjlXJz/ESN/9IXO6dQNt/z1BPMIt+RwptNEc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=me55kSRC6WS5gkxZRMOT6CBLf3ioy3AcmHa9ubJZ4T313S/yY4STBBBmQH/FhO+Xbl7MyCnrWIo6QhkzD5AN8TbNIItNwJZ9KNHoVZhLQs31zs+2UoM3bZVCTk6obOrNX4rEoQPXsTs3Wrvr5vZWKjZA2tVk6cGWOYhvr1JT1Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lNXQ710y; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lNXQ710y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqYchYNK7bXpGzGIGrljFlqDf7ukVtxEQhYCyqg2q3JwQ4Dm0d9gT0ms3foDqzA7IVWmUsZzmIc39qzEvqUVbZAiDUuI9U/k/v5tWETVIlEWUj2Q2wpIAiX3UACQA/DcEcZM3xlCD87ewIYa3M7w0RsCpGQzTw+lNNfLvxrHS01yGD3C8JwZj8W/7Z/As17u/YCxDKKsZaNI8B8oXFHgcCMq1TxJuuxa1UHoc4SjYIiAk7qJKD6Yh6gPAKfYDRCbHsvvRdSk3rBMI3JlBJ2bxZpOyRcRVSeruhHHfuqmdymP8/xEFJoTTHFleeWmX0UTMC7vnfXTJhkVPev42ytFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECTtEfeG6t+RqCD6DpI1ioZJCa/323BEF24WKyyOKFA=;
 b=Vc+NbVBaSvSdJ4UFUtilXDmn4xHKKwu4Zp4cYgZeItZSfMvAWZJoO/4R7qNSzt9+U2+kx0EzRTsUHLzt4rHRRfVku++7dOtKlDBJSTDPnSNgnsjIVAaQrFKwhgcEyTVk9Z67Araa1yUtWvNyS3PtV2Sw21K9XCM+evZZbEEk4fllsqdk88Gz8VNckVfv6Z/xfPPmfdNnrHW6RrwVYnp0WADxY9TH3OIXDiV8z7OyVRABcOKhAqjXTEPa0r6FlDjfvw2+rDB8i00xbsYPjmt1sDdVEYGMHzDSwJVDwZBf52hUDVp8PmMYhb8+15on8AfWjI9Pb1uva3fZEVo+kTzWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECTtEfeG6t+RqCD6DpI1ioZJCa/323BEF24WKyyOKFA=;
 b=lNXQ710yoQFsoMZV3Pe0hhxBarKC6nobCczUy3MYAVOD7mA1WmuZj6PtiOd6CspZt0Jg+Fe9ZLxYLFuSDh33ZNxhd47i6u57ochBzulX5OXJAK09mCaAZ5bs3NId47i+0i6jJlgiJpfji+N6Gl2Il0ASam+erKnPpcxqo+XoBe8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:53:45 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 04:53:45 +0000
Message-ID: <84a84584-404d-4e76-a2fd-65bb4aafab47@amd.com>
Date: Wed, 14 Oct 2026 10:23:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/amd: Don't allocate kdump device table from
 DMA32
To: Matt Fleming <matt@readmodwrite.com>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Baoquan He <bhe@redhat.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
References: <20261013121944.4060097-1-matt@readmodwrite.com>
 <20261013121944.4060097-3-matt@readmodwrite.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261013121944.4060097-3-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0298.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 39355180-0d18-478c-e190-08df29af2030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fDkQZosxFI7pLguEIxxNblET+iQsb/kQDz05xzJr0L6w77MqgDjfDbi2Q1oHuXOIOeCTXuP14Az0flBxGi5toHTO3ODlvOCoLKt60pPvl+xvwwK3IJZCfup4QUC9mVcPDCQxHxK332gHS3Ia8E7zkxLUPr8x7TmaOUb3XIT3XtEXWEVv8aTfN1dEsrPj6hnTkBNNt/oj9uArqwoq7gB+tZ5WqDQ/lEQJdfsPpk1CF2mL6U1R0lIveC0J/vmSQ9o3O+XcyvwTJAQrkUwrARrkKKKwemYw9vj3FHFgySxzsYFn7Y3RECSg/2Rjl8sU+e5j/ebixS+uXdyrTPHkgX7JeU2W+IEniIGCN9ng4Q/7WcfZmAbE+wl89lV3nF/mg6GCEpyqgEZEoKYB/x1aLFXt+q7mvCglSsUy0btW+buVPwHrGOz7bX5Ddr9GMbuyJ0WuLJC3vVxBIY2X2SDFypZtH9wDHpL8aCgRBb/OtxJcvY+Y30ksvSA4LVoWdvj87boF3ZxXE+K2aYU4w20xvDzZ5CXS/1f2TmjoCPDDihh72BipOZ7JYK7reAXHTkGanYRKekgLUtRYM4K4jzFYGSROjyf7cy8oSk+zS3/tUnD4FzGpfIB/X5V/eGhw9iPQJy5XcvsvKjla11RWO2rfA4XyXVJDUiKuoXj/olAw+U7bGKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDRLMVJNcXE0ZkhRb3MzQW9Ea0dKcVgwVEhxWHp5U2dRN2x4ZEwvK1h2NUxY?=
 =?utf-8?B?SFFITzExSG4zTjRTSUhZTnNXMWZvODdJSWgwK0p3RlFMbVlZaU1ScmhBNXEw?=
 =?utf-8?B?VlBKdXVPTnQ0TllubXltZU41ekw2VkNQZmVROVNHdjdaNVNZd1FRUmZxV0Jw?=
 =?utf-8?B?K1p2K0RXQWlFeGloMGJqcmoxQUdyelBlRlluTGZMWm5zRjB4RnhFTG5iTDMy?=
 =?utf-8?B?WHRKaGh6a2RRSnI2eWFQcUNTeTJSbTBITjh4ZzBack1Hd0pYcHlndk45VzFo?=
 =?utf-8?B?eUxRTk5zU2xlcDd6QkJTV1QzbnBNT1QzNTZEQ3owUHR3Mm1Fc0dVRWhpa3NJ?=
 =?utf-8?B?aEx0ajErb1Y1WjEzUkVBaE50ZGZFZjNZNTBmYkhuZXFIMzZpdE1UWGdLVmQz?=
 =?utf-8?B?Mk5PTTV6SDltZSszdlhLMTlxT1NYbXpuUjByeWtsZFA4TENwdVBMNTRJb1Uv?=
 =?utf-8?B?N2dIUmZoSUxtdzB3eHd0azRPTUpLZVhqcXd5UVk2VmhvSGFNdFZHL2VRSWlQ?=
 =?utf-8?B?UGtpRGNnblZDQkI1VFZNekdLdjBxRnV0UG1hSnFLV0dLdGRGR2NJS1dxRDIv?=
 =?utf-8?B?bWZCVDNhYVdDZDkybDJrQWpybjIvbmFDcXJlMFVDZHFUWlB2TVdRRm9kQld3?=
 =?utf-8?B?bFBHWERGY0hURi9lcUpPZzAzVWdsblA4MHg5VWo3MnBGZnkvdUlPUHYzZUJU?=
 =?utf-8?B?OHNBRnJXWHNqT1BBUTZubzZEUEVXWVRxdUE4YVJKK1lVYXFPeEd0dkhpNzVE?=
 =?utf-8?B?Q3RQRWFHc0pMZFFvTkFhYTZCeGNORGlyZFV0MHJjQ1hVYS9RRzAxSm1LcWNj?=
 =?utf-8?B?VnQ0VGwvdnRMYWN0STRyUE1JVGU4Z2poYkNmMTdCdFNTVHJyTjZGU1BvQVhP?=
 =?utf-8?B?QTFRaHMyM2d0OEFhajFXelVtTlhqRXc3aHNKYUg4Njl5c2hSczIxdjlVcGhW?=
 =?utf-8?B?bG1CeFR4SEVBRTBBNE9KL0NPS0N1ZE9NM2w0UmJTWmIwTE9sVHdySkl6OUJx?=
 =?utf-8?B?bVNLQm5IWE1wYWphTzA4OE8wUkh0YytpQTBON0pGTGRuZXFWNUxYZ2cxVU5k?=
 =?utf-8?B?cEtuR2JzTldocTFOd3R3Z2JYRzZKMi9DOHJWUVVoZUNmaXo4NGNIUVhwcWx1?=
 =?utf-8?B?U2IwZllLeXFLZy9kY3N6M1B1QkNCTXhoOE5FS3ZXNU5uVFNLMTc5Vk9aWXBV?=
 =?utf-8?B?Vk1WK0ZlcE43WVJWbEw2UzNDdHZvSmJBaGoxSUxqL2ZKTUFjaHh3RUdPRnJL?=
 =?utf-8?B?TUQ4ZGdpYzZ1ak9iVWhBQW1YNzZmWCtyb0h4c1FrRitiOXI3SmRhci9HVzFP?=
 =?utf-8?B?TVpyeU1IOEpqOFIxc25kUmRBVm1sdWVIYi9zc1BTcmhkT2VmeFdScjVhVkxv?=
 =?utf-8?B?VnJZZ3Y4ZDEwSTVLWmlYemIzY2JQWG5Cb2dPS1pLL2VIakdNMUc4L0VuWWZI?=
 =?utf-8?B?aldkMjFNVFM1eXVaZXZtQUtTNHd1T2FKdE9ZQ1JVaGozNnE1RTd5V1RnVFg4?=
 =?utf-8?B?b3J1cUFOYTBScGJ4b0NnL1R2TXdRZVNvd0tML3RNZ01XbEZRaUJiaDlrQUEz?=
 =?utf-8?B?L2hwRWhOSVlna3pVK0tZSitUSS9POHBCTEFvaVJVMWhzd1NJZDdmTGVsNndX?=
 =?utf-8?B?QVRyZ3ZCaUlSRDlIcVE2T0xvU3NNOHI4RjNFVlJwMUlSVjIvNUk1TUhDdFVo?=
 =?utf-8?B?YkU4bDNET1pEaDBNeXl4TXRFUm1EdDF6bmE5QVUxaWJDNDlYMWlTSnBwZ0o5?=
 =?utf-8?B?R2VlNWR5aXNvRzBCQVRSbFhlZTgzSmVVY0d0MXo2RU52b1hjdFhqaG1NRUpa?=
 =?utf-8?B?UEU1UlFCUGtYeWJGT0hTamUyVUU4MlJNR0E1amNjVWYxNnBNbndveHp0US9z?=
 =?utf-8?B?SnJtT05LZ0dQU0ZpOEQ5RmFQKzc4YUZxNGxJZGx0ZTNvakZJTGplNGlCekJv?=
 =?utf-8?B?aEc3SEpHVVZ2WVgvVmQ5cUJ2aUFyOWluWU44Wi9iazNjaU1lTkFBbm83VzhC?=
 =?utf-8?B?dTNwank2ZW9lOWpHQzh0WW9CQi9OKzJLUTBPMkc1WnNiRnhKOExBM1MrbnpR?=
 =?utf-8?B?bFh4UnRoY01lMGxXbFZwMVNPczhOWmRwaWNDd2hUTS9FUUFSS3VaM3NyZDRi?=
 =?utf-8?B?cHcrWXhDc3QwblphWklrZnFUT1cvSy9TOFBnaHMrTTd3N0Y0WlU3bmNTejRx?=
 =?utf-8?B?RDhiNkZhL3A1N0N6eW5VZkwvSEZuMUU3SkdjQ2E4dGNLaE5KNS9iU0I1U2JX?=
 =?utf-8?B?MVREYUpoL25wSURUZjBLcThZbE5YVWZEUU1qZkR4Y2ZmSldmcXVNSk9ZblY5?=
 =?utf-8?Q?EaRoyYe7uWvTfdIdeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39355180-0d18-478c-e190-08df29af2030
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:53:44.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLkaJEYzU5VxnrAX+aKTFwDiVjnaNU7EFy8LRWahB1qmlvOc7sEpaVTC5z0h7T+ZgYmRI83uUErf0DYn7s/+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224



On 10/13/2026 5:49 PM, Matt Fleming wrote:
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
> register with the IOMMU still enabled. The 64-bit register is updated
> as two 32-bit halves, so the running IOMMU could see a half-written,
> invalid table pointer. Keeping both tables below 4G leaves the upper
> half zero throughout the update, so the pointer stays valid.
> 
> Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> the kdump kernel reuses the previous kernel's table without writing the
> base register, so its newly allocated table is discarded when reuse
> succeeds. If reuse fails, the previous patch programs the new table only
> after disabling the IOMMU. Either way, the kdump kernel's table doesn't
> need to be below 4G.
> 
> The previous kernel still allocates its table from DMA32, so the kdump
> kernel's check that the old table is below 4G still works. Drop
> GFP_DMA32 for kdump kernels only.

This one is OK as its regression fix. But with all the changes went in I am
wondering why we need GFP_DMA32 flag for allocation. There are only two cases
where transactions may be enabled:
  - During boot (BIOS enabled DMA) : kernel will disable IOMMU before
configuring device table base address w/ new value
  - During kdump : We are reusing previous kernels device table. If it fails
then kernel will disable IOMMU and re-configures it with new vlaue.

Anyway, we will look into it in detail and run more experiments. For now this
fix is fine. With that,

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

