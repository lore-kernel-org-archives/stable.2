Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6033B6F8;
	Fri,  9 Oct 2026 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577119; cv=fail; b=bcPOcaIjGrB5Lzc5Y7YvElI/Cd0liKLb0bo68LBBAUO6pjLjZfyxCovhBUTxGVgbMXjqVBleqGjchjcGt6dYbXJ8soqQmqN/IS9l7lI32J1rihm2SgPoQO6L8LjtL1VXZyVj/i1Pt/buaM1cqAhunZKKrJmQCiE5kozutlTAEh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577119; c=relaxed/simple;
	bh=x2PuiB7KeLp96umL/mHmNY/1Jm8wLq2SW5foIcMUz3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ksN908Hgwqw46X3ZM4ifxMPOie2aQaV8SjGnXmHluRG2NdO3240EFH0lueYczt9u/ap8UiWIMJhVlNVNEHquutvSS/L/WN/Yq//HVqPgvsQPE0j/Fn+QVoz3329YOmaZ7fxEZ3HH/vYT5VGaiPsh4qOjjQrsUwwW4fLSWtbo17A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/sAgbk9; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/sAgbk9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHlZ+BApDXVwHJzAMJ31rPKX8WZXad8uPMXPmkayG5XGO/SvmiM7dOHmXuA43I0tEMhm+PRwNxIdYpketTQJ9T4YE8h3zU2vEjveb7/xYsLP84hjq2wSclIBztIsg0eslqtwzQ9imTu0XRVUeikIroZTDC/m5bEAgbhQSEpCU2bsBymA4KH7SHbLBeolwcQgtgBSFyPzvA/hLBtENQrFzqGT0a4iTY0Z0vLRu456ItMcumvTeiA42tHC+rU3qIr9C+YRmJYk9eGFH9YEjPibhPaZ9ZSMWkFjtQ2tvOGtWkqLstyO5LPV0dKKD4TwopUflvP1SjA+gpyw57A5EOS6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS+hDUHWAdTpUKE1uW1owcCuDhCVMIbDKt2hMQlqrsQ=;
 b=dOnnWt3fAMIUiDuaUwqRC5KscQC0Hml3eKrHfpR1crJWIGoWdHeG8PK7cXU/ocn5SyhE22rFHLQ9j1VoHrCkXvezz0YcyePCDx4lGZFG9NBi9XV+97R6d+yAzwh6N9WseSqJbTtOoxTzd/4uFB7rEv+mKX8NFX2yXwefHwN90rQ84GWkrvIbYGDHaVU9ce7Tvh0SGt+q+WH542Pm2WVA069Mxaqy2O6zNEQJTATgc43lHIp0OfKXm4cbZ/sFGlttwUyvYK4E8AYmK1XtHSgNp/pRwNVXiGB/R3lrdTmBOEaEk3qnW2UiINtV2KUT/Cli0GdBqzHh5QCC42l+eIBb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS+hDUHWAdTpUKE1uW1owcCuDhCVMIbDKt2hMQlqrsQ=;
 b=a/sAgbk9CEZracYVNkkNCeMJn9YFFWlZE6Wt/7XwS1QFvX4byQhiTv35Na5b4Jpzcsf5Pn47tFFqdJzCRYZOlQrtAbbq50BnxNyai2/pJV+3b3vVsPpa6qLqsAGHQPJHq0i5PZ/1TWB0XyLdxXJ62zJxRsXV7v2/vzIEiUJQ7+k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 20:18:32 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::f71e:4264:146c:b356]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::f71e:4264:146c:b356%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:18:31 +0000
Message-ID: <cef945c4-fa06-4d2d-b1ff-085d8b6fa497@amd.com>
Date: Fri, 9 Oct 2026 15:18:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Program device table when kdump reuse
 fails
To: Matt Fleming <matt@readmodwrite.com>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 Baoquan He <bhe@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
 <20261002133143.3628181-2-matt@readmodwrite.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
Autocrypt: addr=ashish.kalra@amd.com; keydata=
 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
In-Reply-To: <20261002133143.3628181-2-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 034a87c1-a0d8-4e30-9f82-08df26427d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jyijYTERHYlX2/As7I1BiJhS9iz1tWif+noleolsW08urD8cgwF2fDV0UoAQNhoQwx/Kog3TxcVpM/zxC9thT8pa9MpaZVc5oIfCSwtrtFKiU7sprcw0yNIlRdP6WkUnjUepsPgz2n4SOTI1GKj/hF189oW6pLKVsOdvPJ3mh+mGK4Z/Xm77kE/dcWxzL6F9ZmiiTu7SRXWqhISvXUP743UCV+ngeJbu6W0AwDhkdCznu6J8RiYzCXlOmrUlRmD5QrczF+c3VXXMjaLQomyY9Hnd7A+rybNgMwp/D6bn8aovib8iHJ+UPw+SYfXcod0uFNFNHSC4B2Uj078DtnI8jHRYP3e6iWauIQyNkwLvqQ67LddMIU/G2s/IzOX1d9X1pzMOAhzKdERjTjZWKWwzqgQaSrHQTZkM8juoUi+nFIvmVsSgD1kuDJZTgAUFRAZMTkYjzOg3Q1nN4yWX/S3dU9Ma/9b8DD5Kze+Q4FhHk8stMAenaTpWgAkNJnakxFPcTUkzJjB+clNzQUdg5Eo2zrne8SoNC6sSCajNviITrjMh4QaA/61M8Cf/53KQK9xDQjkLiBgCI3NJCJM72cGMgLG9wvxsFKdw4R+GM7WUBcUVzNEJ4EOtrV7osb+jHu4pSi5DSjc/da/uxITos8ft1Yk/Vnx2DDJQfpMu9xXClAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGZ3N1NIYU9CQjJad0xUQ2ltRkhmSlBNQXloTGcyaHhiVWx6K2xUMFQ0SVRq?=
 =?utf-8?B?djFzQ0sva3U0WGFvbFlHeVp4b0lPNnF6bTlIYjNtTnYvdG03alA2VGtvZVFv?=
 =?utf-8?B?bGt3bEsxYTVIL25ETzhtM0VTVHdhU2V2N2d2QUppZWppTlJwSHpwVDY4YnF5?=
 =?utf-8?B?VGR0TURWNWZleE5LRG9acVpzT1llUVFIL3grTi9NQnJwazU2UVRRcWJEWkNt?=
 =?utf-8?B?SXZCWmdFcFRxZHJoYkRYN2syNGI2TDRiZjJ5RVQxclV2VzJpZ29XaFpPVGx3?=
 =?utf-8?B?RTRpZUhNei81bjU1MFByeDlTVVI5U3g0b0VTS3JObTNETWUrY2Z3VXdKVlpo?=
 =?utf-8?B?YTlEVTZSUkh2WVdYZnpIeFFIOFcwVGxJMkpLTUJndy9Bc0U3ZTcrdUZFTzZi?=
 =?utf-8?B?NnNpOVdBVWhoREYxN0c1OUJhbVJibnNLV21aVHlRdkEyMStBQWZkTGozb1Iz?=
 =?utf-8?B?YUY0NGRyRUVMdVFpN2ZvSXBEaTlpNW00elVUdHFOdzYvVjFKcGlpTzMyN3c3?=
 =?utf-8?B?Rm0vSDRRVWNzN3Q4b0ZjTmtaM1Q2QWd2MTVnL0FjMlB0MXgyZ3VCd2RqUksv?=
 =?utf-8?B?b2NtcmNvVUlKdXhNaGkvQlN3RHF2QVNwNU1LVGc2akJKWlkyVTUyVUw5T1Ru?=
 =?utf-8?B?UGtuS3laNzZna1lqMUZxTTBhRXVtcmtVNlBXNVQxNEVzV1hXSlZjbFpNaktU?=
 =?utf-8?B?VWFIcGs0bklRS09yZXF5TkF3NTlybm9GYit6U3JBU3U5amt0VURoZmp6TCs1?=
 =?utf-8?B?UlduVXdEU1hKalJpOElxZVZ5M01oTzlLTm5kazNncmhkQVdYK3ppc0o1OTRL?=
 =?utf-8?B?SHJuWVZwNkFudVBsdXZ5Q1ZtOG5YYTRlYTVQakN5dW92cG5zb01SOGFsWGwr?=
 =?utf-8?B?dE9Dc0ppV0srUlFaYk5WeXFobEE3L0RSNFRjVGRBV25IUThNZlcxa2t2T3NW?=
 =?utf-8?B?OXdXSWVPUUE2V1ZhNGVtaUt5SytzZHNNWXRSeitDazR1c01hY2ZlbGxoNmVp?=
 =?utf-8?B?ZG5DalBhTHA2NFNxeDMzMm1yTHI3OHpaUHhCOElERmJSbHJ5cGFNcWN0aWFK?=
 =?utf-8?B?bzVpTE5Zc0czeDVOcmUzUWpIQ0VMS1BUMlQyMmJkMW5zVi92YnJDckNZcjUv?=
 =?utf-8?B?VXVNMW51UXJEWitob3B4S25FSFFlc2NseURNV0hKZzlVYk03YTFSNXhyL2ZZ?=
 =?utf-8?B?ZWs0R2dSK0VCcWF5ZTNVeHM4cVZOVGx3TlhPYnV4bDBDY25nd21XTlYyVzlL?=
 =?utf-8?B?MDJSUFY4SEluY20wcEpvWUdqcFlsNWV6cHVXTlVsTklWTGxkZUYremlkUEN2?=
 =?utf-8?B?NGN2cnh5QXNHdlN3MjU0Rkx4YXpQalNoWDc2eDZlYnZuNjhGY2lQU0lWOWlR?=
 =?utf-8?B?bTBKbWZxU0h1Y1RLaUMzdGZZVjYyQ2dHU1VFbWEwa1IrRjJnUzlLVDRCeFVR?=
 =?utf-8?B?amJvcUdVSVFhU3JjWWhHdndVOGhySk94RkYrekxwMFVzd3VZd1lTREdxL080?=
 =?utf-8?B?czNpZUl1WnpOV3Q3UjkvWTZlbXBLV0Vhc21uUE5oQk5JczNoZWNKVzY0WlBF?=
 =?utf-8?B?U2liYW5HVS81MUhMMER3anBUdGNDWENIY210bDRvb0xQYWdVU1VTWWdEQ3RV?=
 =?utf-8?B?RGFUSVA3VnIvalY3MXg3aHB2ampFZHBzTVhhZndHMjVMQ0dBUWFwUjNYUFFZ?=
 =?utf-8?B?cFpPMGR1bW5Wa3ZNQXpTRW1JdFdETGRSOWhhSG94b1NkbjE5c2FRMFBtWjlr?=
 =?utf-8?B?ekRhR2hOd0wyZitDMHliTWd4M09idDQ1MzFPWk8vdjZEZzhaeDJQeE1sT2Nm?=
 =?utf-8?B?eW5ENnQyNUZQbzlkUHhSaTd1ZVdHYnBpd0R1eDVaZG9ld3htajVmZ3pmak8x?=
 =?utf-8?B?R21pTTFCbmRwUWJwRzFoVzhqTVZCUm41R2U3cVlMcmZVaG9IakphVGdFYmtl?=
 =?utf-8?B?QU9NWkxLZGYxMUswcURXbGtRdFEra1dldmRsL294R2Nla05GTnh5UTV6anBp?=
 =?utf-8?B?YWxxMGQ4TytBbGhTdmFIWVVxc0tDT2kwaDZ5MU9GZVFrRklmbi9Gd3RncFNu?=
 =?utf-8?B?QktkU25UQmpSdExhUURRUE1Mb2pseWo3U3ZvSFFuMXVSVkpYN0FRU3FNLzdL?=
 =?utf-8?B?SWtGNWFpWTNnT2NETkxoYWFsUVd3QWVvbUJNaUdNaG90bHZhQ2VPUlZaNlpS?=
 =?utf-8?B?aHE1ekxJcXIvUGtKY1FZbVl1QzhUZFJDR05oR0llTDNnMjB6Y1RHeEpabU9J?=
 =?utf-8?B?aU9zdzFQUkJTdVdGZDJ4cDljOEoybVJuQTdONis5WnhvdTY4R0pMdGd0R2tV?=
 =?utf-8?B?NUFHOWNqd2NwTmc5T3V1eURlV1V6dGc1cE10ZjhxU1dzRW5aVHZYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034a87c1-a0d8-4e30-9f82-08df26427d06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:18:31.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+Y+RAR0CGm3OTsmZVq4lTaqt4/SxXfiiSnCHYXKkCrguEcBB8GUrIF984bpvlDCdNVISfz5m4iykOdaUJposw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424


On 10/2/2026 8:31 AM, Matt Fleming wrote:
> [You don't often get email from matt@readmodwrite.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
> iommu_set_device_table() return early in every kdump kernel. That is
> needed when the previous kernel's device table is reused: the base
> register already points at it, and on SNP-enabled systems the register
> is locked.
> 
> But if reuse isn't possible, early_enable_iommus() falls back to the
> freshly allocated table and calls early_enable_iommu(). Because of the
> early return, that table is never written to the base register. The
> IOMMU keeps using whatever table the register pointed at before, while
> the driver writes entries into the new one.
> 
> Only skip the write when the previous kernel's table was reused.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/iommu/amd/init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c07c3a01b978..0572e1a674f0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
> 
>         BUG_ON(iommu->mmio_base == NULL);
> 
> -       if (is_kdump_kernel())
> +       /*
> +        * A kdump kernel that reuses the previous kernel's device table must
> +        * leave the base register alone. It already points at that table, and
> +        * with SNP enabled the register is locked. If reuse failed, program
> +        * the freshly allocated table like a normal boot.
> +        */
> +       if (iommu->pci_seg->old_dev_tbl_cpy)
>                 return;
> 
>         entry = iommu_virt_to_phys(dev_table);
> --
> 2.43.0
> 

Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
