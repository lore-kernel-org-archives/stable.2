Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108EB36F8E6;
	Sun, 31 May 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270790; cv=fail; b=DewSBWldfSmaBerJa7MaDyimA2gq2Hyo+5XDVdoM7gscrIWOq0L8Z1C7M6ByDKxMssLEmiaVV7QddXmIzT3INEll8p2QGdyL3G8h8IQyX/Budx5QJVeEAMekebyJHdUZK7gzzpNlUoHeO+S1rwp1wlgBJeVy6xYWTKasSB4qros=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270790; c=relaxed/simple;
	bh=cU7B+ZIYNvsG5HAdyWrHH//7jSAkRfITk3Gd3PQyPi8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0mP0zrvKIwHwx5y9nRmz6+g6XxWbC7y6kSOZamnwnAuB+Y6/iu51cI7vLaPtpFuTRKu3qvjjqckuQRvsJQk/aeUnxcFDJa4HvMoLBHScVWnMVAcuPrb9efsD4jhb6P+wmLfYb8S5k7F7FSnuCP9kng006XGjlbR43iB7QSx08o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z20ixkij; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z20ixkij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg7Y9g7NUmhpVBmygnk1LGqxz0Qv3szfYtDYEKG16sBrKKchpvdwNNMYGFmgM+HHsUxYo3pXDn884T1ptPYp2m/Mh3G07AaUG5mcjWn27RIZNzk3Aj4SDFQogsfkjCTwriWl64ypTtkTNuK/GPuisXuzp5AomkZhsEqzpL8YwwOcU96F93XMv04MeEMKDkvpfQT60WZxPUnlmEIDSzXXMXiu0FWInWpqH2H6zUam+E8fGhrEQbz/ugZw/nMRuKg78OPHTVX6hz9ncf/yp65zKJVpL8Y4Q4gjAF+oOLlBxXChsM++zM7v5GDToob1dl5fPOQfjyo/wte59ytIR997rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+2EW1yhmA33VTKCHYjQrZ3nT3mShHB5chBfB00Z6cs=;
 b=Zrg981ka/S2aZ1bU+cCQqIEFfOwBIzFRWqBiKpBC/an7RL/wVNGezRtd/gIuPKlh4ADISU0+8Uhgr8XxSue03QujsFJuYURFNDTphOIBY0aVULbgCKpoWmomxkuul2+y9adgQHeg6woK+j6tIXwVVLa95nnm8Vi5y+7063YpB08mNsxPs2LO+5FX3su9itc9i9a/kw4GGvBc/5F+iSqooANwJqkK0r1Jri2u0g3qVEI/pa1OuUslcA9QW3MvKJz1L5cDKXoPRbfQNnIiHNx88mqtu0mL3pms1dJwiSjxbh6c0vOO0WEoQDx7IjjhWkZHtlSp9mZXMgqaXIvdjKQOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+2EW1yhmA33VTKCHYjQrZ3nT3mShHB5chBfB00Z6cs=;
 b=Z20ixkijxV26QFVYiqo3QTELDOtCWmrUTJhrLytw12uVRbmnPxL5jftTtyiX7YpVKiEY3chtYQFTLJJ7Bm6H8RnXcnEn3V5Xcfk1PDPkgg9g+d1x46rC6M9qN8BZLOFzkxDEIWa+RS4t0gCLAysgJ2jAkM+578p9Di4zXX2lqAzi766tkztfjgF7JPT1tWwTZys33Ujfikvh7qvltvZGv8W4EpczkuHPVZJEIs8sGHABiflZDRbHaBUupnBm+MA4PwmXdp46ZVFKl8I2+v8sifj94OxDPSzcmp0Jc+xpp9fqbrtRlFwOiFicnX5Hj+QoHXD4bYGjyQOUE+FRfh0k1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 23:39:45 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 23:39:45 +0000
Message-ID: <72820821-8934-4235-9f9c-d328c6103091@nvidia.com>
Date: Mon, 1 Jun 2026 09:39:37 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fs/proc/task_mmu: do not warn on seeing
 non-migration pmd entry
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 liam@infradead.org, ljs@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 david@kernel.org, shuah@kernel.org
Cc: vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-kselftest@vger.kernel.org, usama.arif@linux.dev,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20260530085413.1270139-1-dev.jain@arm.com>
 <20260530085413.1270139-2-dev.jain@arm.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260530085413.1270139-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8444bd70-b099-4be2-3b6f-08debf6de506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jfhWKydThrEBQPvqyAgdiVDNyG/fuqKE5xEwHNV4NRJRPY+1BjgUUXDh3X629yTFWM7HXSq+ySfE96CutN3i+PcFXrOIcEOCiuaTwPVuXc/Rwn6f7nwpEpoBDDEwxXLQsyt+Pxj65ToThfs14Ywif5gMD+xSvaroxskeQou7/HNsI9Zn0CiWBrbzKaHCTMqzmZ30X8XptkHPaLD/XDkW3VueiP20vqEq0kNB+AhsL2q8StGp/epmAYrh4oZcOtkAv1j1b+aKo3+wWLKyRe5Ddp5NnbRoGY3SKRL1bJdl/KBRcm9+HABFqSSInFgKah42SOmmfrUE5GEhqqi2PcUQj0hnv0aEMrIlhwvOwlcJ+Yup+pDADNHoILraYjAawjZPrG9SzXBmWYF+F+7Etou4O1qDNfWVPWG1EFUqgW7/JGonvehu4N546cNb2jQQKnP9n67nqFHGV3iYnshzgkIhFuLYj/xtA8puSiTSi4Dx2j1P0POjFkzCIRyhaZxhMNZ4/ZEVIj1AtIKcAN98KXNU/bI0wtHA0fx/u14Sss2g8wAY9rA/EPnu6bAX+BNLA07ko8Me9eVBaO6D2TJS7Oy39YbqO13hckhRmrJ4wYVXDmepXOpmvscasrdbi6hn933TP/0BVz446Nr+dUzQlmt70hp9mTaqWL45kU9bKcTa3CaGViqLddfuZgqNdM/Q6953
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdOVmtGYVlTOFJXeFVGV21QRjRUMVU0UnFjbXN6UjRoRDlqb1Rzb1dvVTJo?=
 =?utf-8?B?QkJaRlc0YThlS3hpeitxcmx1WHUwa2QrKzZ0MmRuWVJ5UlFYWllLODhWbHJn?=
 =?utf-8?B?NmhKZjhSNVIvY1AwaGdub1RWVFRHVVZYK2kzdWI1NjV0RmFEcUdvSlhkRjRk?=
 =?utf-8?B?MkRFeGpEQWdwU3BHUXRMTHBYazVzVkJHbWlWNldnWXI3SUlydllDQlFvUTY1?=
 =?utf-8?B?K0dWbzM3NEVGbld2cUM1akl0MWpGR25Od29QbE1tMWZXQlQyaHN1anZhdGQ5?=
 =?utf-8?B?TWlpQVRJUUNmK2hNU0w5d1I5anJ2NmtyNmFBQ1lFYkdPTzdNNTE5eG9haTJN?=
 =?utf-8?B?WFRrT21vSWhlVmtlQ3drNGJJdE4wZHhvcHZuSmF3dkJWbTBTa0Q5dk5UTkVn?=
 =?utf-8?B?dHVzemlCdXJiaDNsU2RkVjVEUHd0Rlhsd2UzUmJyWTZ6WWJwVmJKTW5TV2Zu?=
 =?utf-8?B?b0NiNlhCOVQzYkM2a1V1Z2ZYOEVqRGZjSFU1MUxMNHNsYU8wSHFFVVdvQjhK?=
 =?utf-8?B?ejY0TFU0Z0VDZU5JenAzK3VIaHFXUytSL2llYXo2eEF1bGVDVzR2ZmNSQ3Ro?=
 =?utf-8?B?ckM0SkNwdU5USW83QUl3ekRwbHowdlFPZUFWQ0FKalpQNkswOUJPbitxSkdC?=
 =?utf-8?B?ZHdtSkk4bEw3NzF1Vi8veVNROHNjYlFVbyswbXhCNFpDODZlQzU5OHZVZlho?=
 =?utf-8?B?T3VLSmNFalM5MFhkTXNKQWNDUXVaL0tIUEJqL1g0Z0RXNHZKeHdKelR4RExB?=
 =?utf-8?B?WXc5SDczSHJaNWZUMUhpSUpUa3YwUFZkdEpRcFZSc1p0SWFMVEF2SWZueHJX?=
 =?utf-8?B?RnN3SUw1L21rWHFheTI0aVlwSzUza3lyeUdQNEw5TGVyQ1RrOEtkYUxKL3NH?=
 =?utf-8?B?U0hhL0dyNms3THNuN3JScFZhUGxDN1BHR3UrdEF6SDhLelBDay9LT0Zjd1VT?=
 =?utf-8?B?SHF1ZnlqYTRPeU9PbEFVTkEyaTNpVEZtVFZua0JvL3o3eW9ycU9BdkRKTmxD?=
 =?utf-8?B?SzFIb2t1bE9IV3BwZGVmU0o4TTduUEpCS3ByVkVqbmJUT1I1T2ttcFQ3YXpk?=
 =?utf-8?B?NGZFbkpHeVNOdVFXMjI5ODRWazQwZEpiRld1UVFkNTh3bzBMU0szK3R4cGs5?=
 =?utf-8?B?VWQzSkpvRnltTzM1dHpFTU1vS0ZmUGNFU2JyUlRPREJSZW92K3FyTW5vMXhM?=
 =?utf-8?B?UmgxT3RLRHc2M1lveE9iS01paFJOalNnUi9UMWcxYk5rbGJlY0thTHlsQVZI?=
 =?utf-8?B?aUl3djJrMGRnOTBGUnhSVTFTMkZlc240TlRYWmlWeUFWZmtpOXJmVFdOVFNo?=
 =?utf-8?B?NUNxeVk3QmpaZ3hJem5qUTlCMHcwc29JVmZsYjFGUm5SOStWT3Z0NUY1T25s?=
 =?utf-8?B?M1duSzZ3TTM1ZzArUVVUVW9WODJhaS9NYTExWnZUaXNMaW9WNVlROTh3WVBB?=
 =?utf-8?B?dVVrOG14WmZrd3cwZnltNkJwZER6N1VCWVVEQWZZWkVnVWFnbmZQNVh0WkpH?=
 =?utf-8?B?WGNIbVhSeWxObGlwQ3VHVllVcy9mNWN3Q25UYnB0OVVqTlFqNFd2SktkY1JO?=
 =?utf-8?B?MkM2VzZrZHphSSsxZDAxZVUxcG5zaElzWlM1WSt2MDU0NTQzb1RtZVRiVzBu?=
 =?utf-8?B?cVVkWlh0bmJaYjh4aVVjNmVzNkFwVllIcHRIWjNwZzVnQjhISkFNNFN3d21L?=
 =?utf-8?B?dFBiWGYwRXBxTVZEOVJzS1pVVWRtNms0NzdPZVVSVTYrblBoSzhnYzFkbG9E?=
 =?utf-8?B?RHU4b2tkTFRmendJQjR5ZC9RQU1GTmk1dFFLODhCOTVLSm54dlF3NTl2ZGpR?=
 =?utf-8?B?OU11WDY3L1FjTk44ZWtOOGdpVXEvQ3g0aE5CSEVlTDdkdE1sczRaKzNLaUNx?=
 =?utf-8?B?aDVpOXhhL2c2MXgxV080WTJmTWR5cy8vZXVIb0wrUVdyam5XYzFXSHg3TmZK?=
 =?utf-8?B?Vm0rUHM3WFNudVB5Y1Brd0FYOEMwWlpsY0JjbExrQ0dFaW03TDVkK29ianRq?=
 =?utf-8?B?VnhCSzhCWEl6M0VueGVMTGQxTGphbzB1YU5NYmJrMVloVWp0WVpIUmU0R2pz?=
 =?utf-8?B?RzZkd0UvU2hZYlE4ci9QR1Z4WUF6ZE1BUUtxWHRZWWtTeSs2ZVJpWjF2Y0hi?=
 =?utf-8?B?TTU3WkN5ZWx5bjltbWxVUHZjRXdiSCtJTWtjSXByVWw5N3l3UHFVS0RKdFRD?=
 =?utf-8?B?SEFEbVRsRTFHOFZYdm1IOFp0dm4rNUtCOHdndWNqSHBnd3JLYURoOG9OUUtN?=
 =?utf-8?B?Y2tqdlEySmtOYW0yOSt1ZzBkU3hKVDZqL0dWTzdheG9Xc3ZiY01GTHZmU0lG?=
 =?utf-8?B?WGwrQk9zdEIxcy9UWG1VYWhLTHJ3eEJhYW01TnN3VFI4LzJ5RXV0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8444bd70-b099-4be2-3b6f-08debf6de506
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 23:39:45.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOPYZTvZB9j19aWnX+4CTj9C6GO5VmjGOBYZ3jPFNGn0iTxeltExILOvkYfOXZLTWJLGfrg1CbT3Rr+dfJY5aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On 5/30/26 18:54, Dev Jain wrote:
> pagemap_pmd_range_thp() warns if a non-present PMD is not a migration
> entry. This became false once device-private entries at the PMD level were
> added.
> 
> Therefore, remove the stale migration-only assertion.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  fs/proc/task_mmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4e..58938e62154d9 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2129,7 +2129,6 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pmd_swp_uffd_wp(pmd))
>  			flags |= PM_UFFD_WP;
> -		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
>  		page = softleaf_to_page(entry);
>  	}
>  

Thanks!
Reviewed-by: Balbir Singh <balbirs@nvidia.com>

Balbir
