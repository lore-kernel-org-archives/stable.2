Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D73C5857;
	Tue, 18 Aug 2026 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041651; cv=fail; b=mjDTguwc1SG8DOimDaOJTVj8v9NqmomFM7HCi5Nt3MvWQPJ3KMXWeyfhTHeqmY7kbaRosJzvKS5iQkwl6pyA4S3ZQmhEYIK/aV+vtLiZHxoSi2TY41hGD09L8s0bSw16IBYMvKozGfd/IYUi9WmrGnLeuRdSENsImoowKfhD+8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041651; c=relaxed/simple;
	bh=A2wQmX5Mbm13l1v0snrHJssehMzOd0O5tELvTlzm/V0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1z+nsPEAum46OIHUvsw+3mhaV9cPXkAfFA3AAH24ihjYTmC/Mkb25319R6PdfVqyzABRjUmNO42RLA1h7eESVy8MhyUc8/wJ1qN7LhpEaZRcyC8tSRsPokfUCS52xLBohmKI+n30oOy/O1DzA+JeDlqhUoWMc9peLmlErRDuDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7zeKwcd; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7zeKwcd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJN6eu+Jm5oaXVwkeIko9PW/m7vvTWjWEg6iW0kxMpCiVG/AY6xylKm55YtP/VM8jFy6Mlw2bHI4uz0wumVCob3NoiYbMg6CzQJW6afHLmwF+vCCmon0nc7zQjW0K8wjM+fc2/WZzOzEidwSpQFOOGZfUQ1GSViEikG8OZY/KT1V040nyNp5HeaC8TSv/4lADEAklUe4DVaKr+0GPa+ez+mIj/Sy8E9S62jGPa0y/sAUPoADzs0nyeiZX7Kc5cjolBpp5Ju/4OwS5W4/GY+PSFrreIvai/Mtjg0P6eLhHNDZkuBXg62U29xXvaHLio8uzizxTOgz7ROrG6eKoKHQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz89ouq29X402go7f1hUYbk7LSm04nZDDNUUCzD1oiA=;
 b=YR0Xlhpt2EEMNtxJgF9zZR++huJQbTuvHcWHPQ6Lu/TYSosWZrHPBR6s2jCC32nzNQaDX2qnAlTXoruVh8IwW999+k0CrVixFkYkPI321E2cjjufJkIHqnvf+QCo9c+mMzXDVyiXlD/fUVJxsF1cYCTPwSIEVPHxn//Kl0iY4G0VqtjAW+uQfNQ1D7XXXv8jCZxS0ABpW/sKSXQkgYe40ZvTSZ94qS0awRoQJj3TvMrdKlrodDa7CUNe3FET+Rqha1DPGBMwqjv1m7o9XvwnafOTbmMO/DW2hGwg4T3J2lwV1OYK8tefxnn9BacT6iGOvHEr6JdrgWN0KTd9jlN/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz89ouq29X402go7f1hUYbk7LSm04nZDDNUUCzD1oiA=;
 b=O7zeKwcd2tRTLu+u8rQ7HsRmL6I0rGA8q18iX1T03LwMid/ij1MQAuEyiAQo/EJffxDT9wvGKf22ZHbwLecolWKBkQ8cncEaQtzZLDcxEiHccgqg2hk216wc8hfEU8dpgCjVaJ0zJQVGn7SnGS4mtXAzxbpc3vxPAcKjXLKFPXX6rnqOGEKnnDmIk2MeCLrM0vpyQYUbM3XclpseeWmSQoTOYTapzKhB68ID0dd2VypvIHOFd0Vy2vVReRVhFeCEmwHAEtmUPyXZOxYJN4lEgCJIGdkp1bVuEourIpar43nfZaJzw6CSXx4psp1Hu4owd6gPCbj60bT02ouDHRfxsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 08:27:23 +0000
Received: from CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811]) by CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 08:27:23 +0000
Message-ID: <163188a7-5ae4-43ab-ba00-b97431ebbab3@nvidia.com>
Date: Tue, 18 Aug 2026 18:27:12 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/madvise: skip zone device folios in
 cold/pageout PMD range
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, stable@vger.kernel.org
References: <20260817220810.1175596-1-gourry@gourry.net>
 <20260817220810.1175596-3-gourry@gourry.net>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260817220810.1175596-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e2::13) To CH1PR12MB9670.namprd12.prod.outlook.com
 (2603:10b6:610:2af::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9670:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: a105e9cc-1ba9-410a-44d5-08defd028707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GOSnN22smh5kzIXLsgT1iH4GllBBe7p1JRaFjub+ABsRIEdTixCOyEgCNTiEXdUZN+19ov9Fqia2yIz/260YWthZ1gZTcbOdJZAQpeCKop//A6J/3fzinBjFbnBxA5vtcvbLAuhhneSxqXCgl0hrHBNCrDB40TySUwJlp8+Wk0bEMfziXO694OD1GdaDEdCojtWlLg+6cjgCdbt78rE6v75iPl3eMqzbd6R31vtE36azulbrm298spQ1jg58RDWt9BJcIFY1uXua+wJO5sp8q7VGDMyeeVclV9b2yNUGSlSZYYdepY31C0BY5PnXNxQDvk01O24lIKQRewK6mF1loXFpKdCldHN+6R6nSBXyMH1KJClyC9tg1EDcDL6/QwxulljlaIsbFOkmqWzH8ExIRItGERNOwI/Cs2hR2fIDZW/e4JwREubuTc3GH0937CjBQfhIUeBE27NKiTmmoLKrLL4n3/mpIhIQduJHsVlk6LyMp5DtgG9moCwWbec/SUrRibh/H/DKSwWh/CiT2mtDw7JVe1wQQ3IgR6HT6MyRGQlQyrdsQxtOdb2LHYfNE6TebqxzqMd4YXACwVKhNJ1B+ZKy6Lw2OZeZWRwpQdQ664XQQZaGCBvnI+hFYmGuc/C0QDYn82YaNauaiTydyjy3kLC0X+ur3bDNlMkjgj42eKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9670.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Q3N1FYZnczUUZ1SmdBV21qSVhEVnJ0R3picTFkckRWcWJaUkswQ1JQWStn?=
 =?utf-8?B?Vi93cUdnQlRZWHFuTmlmdUw1aXBzbnlRMnhPYnVjb0IrQ2hNVHNEQ0dYMUV4?=
 =?utf-8?B?azVlR0V0ZWprN2xFbmkxN3pWbFJGZE9sUVIzdVU0NldZaVRTdytuM01YWU12?=
 =?utf-8?B?QmhHb0MzdzRHaFZhei9XZzJ4YlYvN3pCZnZWbzNhUUkxOGNzdWVKN2ZHeGdr?=
 =?utf-8?B?ZVNKNnpNVW9MMk00NEZYeW05Qk1YUktMME1XVE5VZDZrR0lTNWwwWXFIaHc4?=
 =?utf-8?B?YTdCWkFpZHBwOXFjL0J5NDcyQWlDQmVhN2RQbFJDYWw4K3IvTTdqbVlVYzhX?=
 =?utf-8?B?RStiNTliOElGNm9tYm9iMEIzTDN5ZjRnYkNvYXc0WWlQU1FLWENuYkpzYjJ2?=
 =?utf-8?B?TEk5Q1ArSWNzcHdLMWZhdmxRcHFOcGZYa0xkdUYxSlB4TGtyb2VtcjlpaDNl?=
 =?utf-8?B?NGY5dmRyUFNLa0ZFVjBVclNJU1M3dXlFSUUzenFWVGMzelhyZTFHdXZYRGhT?=
 =?utf-8?B?TDUraVVNdVkwZ3dhb0QxWHVzT2FPREY5N0Z2SkVVNlFQTy9NbmwrS20vY0N6?=
 =?utf-8?B?UXFEYWM2SklYUlVSa25yWklyRUxLTTI0ckhVRWgycmtWb2dPTFZIdG1BaE5k?=
 =?utf-8?B?djF5aGpYZDFCY2Y0bVFCcVB6NU13cnAxQVBabk14ZDN4RjJDYzE0c3QvVVdB?=
 =?utf-8?B?MlBsNGZEbjN4ZlBkVzE5dzNUbTVxbjNmV0JzR3hxczJBRTB1bXd6ZW1taTZn?=
 =?utf-8?B?YzZ1N253ZnBpekRianVQMnNvdXVwTzZCQjJRZHMvTG1CUkp2Ym56T3R5bDRS?=
 =?utf-8?B?RkJUQ1V0eVNjdSthbmwxUDNiR2c5b09HUVZRU0ZUUTlxb01EaHkwaTNaTFVk?=
 =?utf-8?B?UVZGMXAxTmZIVlBoSHNSeDh6SWN0a1NJZlhwWlpacEdzQ3dkcFQ4OHpnY0xW?=
 =?utf-8?B?RU1NNWJFUnpnZFNhVkMwVStnN08wNS9yTW1HcTRsY1IybU9RaTl2RDZ2VmU1?=
 =?utf-8?B?SE1sSlFmczJuR1lsdE5lTFpKdjhRakJ0aEpvRWxxWi85T1lEMElVK25jRjYr?=
 =?utf-8?B?SCtiRHRLUVp0aE82ZnMxWEEwZDJNZmlSMjArQi9HZTNjc0daK0JRN0c4S0xX?=
 =?utf-8?B?Vi9tYUh3RFhjbHFmSUlrS3lJMlBUUGxOcGtKWUxQdFJHbGhKYTlHUjR3NlFP?=
 =?utf-8?B?YXVwbkJBZmZ6TXJqWklaYmI5czZBeW5ocUhIN0V1MkUvc1hYMGV0eXFhcGZZ?=
 =?utf-8?B?VDNyRVRHYlZ3Szg5b2plVEJpK2I5T1lYNEw2SHBCSmNLYUp5ejRyQmlZMUxH?=
 =?utf-8?B?b2RlM2lJSVJtWHh3WWVFNVFmM1RsQ2VjbnErRTFCWnUzeVlXRVJWV2E2dG5s?=
 =?utf-8?B?VkZPY0xMUUVTMGV5Mkc2WndhL2ExTTh2amZzK256UnIyZUR1WHVZL0RpZ1JN?=
 =?utf-8?B?SWpxVHhndW1vR3VoUWZpNXpPYktkRU5tRHFXR3RRQTNCaGl2aUk0WmxpWElu?=
 =?utf-8?B?ZlVQb21qVUdOemQ2cmcyemZOUFdqUXd3RU5udTFieTVkMDM3aVYvdUhRQUpI?=
 =?utf-8?B?cHRHc1lMNlNIbHZOcU9VM0RmVEZmbDZUQUFuK0ZaekxVZUZaOFFLeXdHcVg1?=
 =?utf-8?B?dWJsY1NNVURBU0RDMy9JeXZKbklVY1FubXUxODVSd2VpaDFGNkR4TnNmWExV?=
 =?utf-8?B?VWRJTk11akluQWdMSFdib0pxSk1Rb1R2RnJxUEgybnBUTXZ0Ym9NcEVTakZ3?=
 =?utf-8?B?N2lycFViRWpTWVlyNDZ2MGFHejd3N3Vld3hVdHBzWVFGaytJM2J3azY0SU1D?=
 =?utf-8?B?N2RRZnZsbW9jTWV0TlBDZXZGVGZpUFhFeG9EU2IyZVpESm82RisyUkMwaUgz?=
 =?utf-8?B?NE5Xc3hqOFlVSi9hK0FibzFzM0JmY3RWcXNnQ1hMaE1tRHc0bTZ3dGFNaGts?=
 =?utf-8?B?RXIvRFJDOURDeStoNG5PTDM0SW9KYUhia3RCQi8rWEgxZjdDbUpjSXdHUy9a?=
 =?utf-8?B?eVgzNEFZV2IrL1JwbWQzWTk3ZkJKMmpscG1qYkhBeStFeUI0amFtM0NqNXlr?=
 =?utf-8?B?VVAvd2Z3akhBa1NONlFFRzJwSkpVUklwcDRGNXQzM2t3WXFVSnNEdy9Eblky?=
 =?utf-8?B?ZG1zM21ZdkVwZmh3cXZPT1YxVkJ4Q09ldnpBcDI3akZjZmprS0pPNm9pd2w2?=
 =?utf-8?B?bzloTk1sSHZCS3BnQkNRaDVRRTZMS0dMVWlGMlRNSG10N3cwUkxoK0dxbk9j?=
 =?utf-8?B?T1RRQVNFVmU0Y0FNUi91STRFcVNROWtwU3NudGhpbUd6YkNuRXdsMnY0c1Jp?=
 =?utf-8?B?d1lOeE9DQ0xlVFl6eURjZ1plcWVHbUpPNFZ0TXkwMnRCVTBQSUpOdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a105e9cc-1ba9-410a-44d5-08defd028707
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9670.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 08:27:23.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLq6uYUK1RxAko3RSzXzdQFXm1Pju0Md4FfBzjbwvc45kT/io125R4+eVgG56h4ozQi3jl0FZYet7SPdx20aEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960

On 8/18/26 8:08 AM, Gregory Price wrote:
> madvise_cold_or_pageout_pte_range() resolves the folio backing a PMD
> via pmd_folio() and ages or reclaims it without checking for zone
> device memory.
> 
> The surrounding guards do not cover every zone device case:
> 
>   - can_madv_lru_vma() excludes VM_PFNMAP and VM_HUGETLB VMAs
>     (so device DAX is filtered)
> 
>   - !pmd_present() branch above rejects device-private and
>     migration entries, which are non-present.
> 
>   - A present zone device PMD - e.g. a device-coherent THP - is
>     not filtered by any of these, nor by pmd_folio() (unlike
>     vm_normal_page_pmd(), it performs no special/pfnmap check),
>     and would be aged or paged out here.
> 
> Skip ZONE_DEVICE folios explicitly during MADV_COLD/PAGEOUT.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c179938097bf0..2151bb9468594 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -396,6 +396,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  
>  		folio = pmd_folio(orig_pmd);
>  
> +		if (folio_is_zone_device(folio))
> +			goto huge_unlock;
> +
>  		/* Do not interfere with other mappings of this folio */
>  		if (folio_maybe_mapped_shared(folio))
>  			goto huge_unlock;

Makes sense

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
