Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11834364E88;
	Fri, 28 Aug 2026 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885553; cv=fail; b=pFTHImFSvuIhzdTCD9UQ+ej8ZOWBF3RNhVhiaeqhWVVFKfSSxwRoBzF+qDxzVrUaBW5DA+A/KR07QxioP3J7EWCc263OnmAsA5ZL9g27DftNMaMn+jb5q9OCuuo0J07TCIgb0ib2lZaYbxOrrSv2PV3A8qGgn4xsy6A7asgAE5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885553; c=relaxed/simple;
	bh=ln2Gh8CEAYI0PPyATRfWQlt/TIQbdS+1ryEfWc6BTnc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=KPk7FoYQIiXw614Ux7p6R7Esq/gyB+MlAJAbyPETXfy0yz/a7L0JzmTsU3bXMpI6njCv/hxGE3WOC40iMESnLbsSNHiOPmOFY608OeC3adSM/xX4epLsLW10ts8mk/5+hXL2U6lQSkqcISn2lQqMNhhWhp+z1L6hAKEs+gCO8Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POIDojJo; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POIDojJo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw/JwfEzd33v+9/LR+JGNujLyc/VT/5ZdhBxP8cQGuWLlnwTjtReW3AKZREv6PSjkGofxy6i+uT0HiDhW7bUplxV4bWOcxtFM8cg41ICFNlKlw7UB6JrsxhGhT39vlmsFvDlkZ7fgmMVRKoS+ZpP4R8JHK+AeUTIW1IC6DEVAU07A8o1eYSjOVT01JCfL5A+MuNi2T5PmYZXyczbcLAvYCCoh5+5NFrtW14veVXB8WyNLMBYbW8v8H6JmwL65aGeXz2wFvHel0vcUyGcQgMZaAFH2XFjCa9hsMekdyj2NVNGrvN8iJRv6D/y6CX9Rir5iv+t+MTNLnJkhObM/5KSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp5WHoG3uEJPtKIiU5mnKIoCXY922c0kgk6eaU5h6yI=;
 b=IFS2ZEABan4w/LWjnJ4T1O3OsIgLyZck2NVNMqvuwaUghgYPZ549Lmy947wK/wjUv/dDNkGHHyMIgRNurflvjnIZjTDBx8h+w/i2U+Ihv4yQ5IinEnsUb7nGn6r0W9PxJ6qLLDzvOjXzAacE012d2iigbG89c0ZbuLFajkjFfdMX1iqRo4Fr4R8eB0q4ZT8S+xVkkf2Sd4ndq4aaF5w98AP0r6oH4ltIUazuCfCoNnSLIbdw7a2n1aUNOdIv7ilRVMLee1ODdZO2supTbkrTCkhxNE8Vur+Q3A7qX+IsGnSko5N/r0QVlKq2NwYlpBqLrTNzPbChgNQ+NDj0GqmFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp5WHoG3uEJPtKIiU5mnKIoCXY922c0kgk6eaU5h6yI=;
 b=POIDojJohRRrP8ScQ5zyDNoO1d5n1seMRSE8TvXAkE5lu5VQMbWm8fFTplj6kKd1uKaI65Xc6QUSdbpwjxmUUfsXxPrnXw3bfog9oHDyZ7BB9FU98xScAUwoxtaopZeTeWiZ3yBRjMYVW7bUxfuDuF6gfdEvGPi6Zjm1/ioQSEGcO3inuLlNc0iGZpus7XWO4aHGNfWrozDhwv1b5y0sgBceuWdxVlRIlYUTSyth0siA6AIS++5n1q+FezCr1FzXNwdr8/zXM9QdXObONYtEmW7eTYiqn1RNhXwp6hpZe/oCuzRv0lUWKddHbpdqHsN1SNmYfu5ao1XzSouF30icvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:52:27 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:52:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 22:52:24 -0400
Message-Id: <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com>
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Cedric Le Goater"
 <clg@redhat.com>, "Saravanan D" <saravanand@crusoe.ai>,
 <stable@vger.kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts"
 <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry Song"
 <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama Arif"
 <usama.arif@linux.dev>, "Peter Xu" <peterx@redhat.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
In-Reply-To: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
X-ClientProxiedBy: DS7PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:5:3af::24) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ce76a8-950d-425b-d7a9-08df04af6531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kGRu2hNMCL68oN5nH3SGhf5ixzNEo2Wl6XHZRVB/E3mMVWoU0vDtp5/6IL2KkS2XvSYnJb1Xiia64OPYsvOQgVRRgkg/RkqfX6t54pEuVlMZu+uNj3HeFgxsYkPu3bOX0R/NoAgI+Uh5h0fptgr7au+KMqdwjyGZhdQOPwEt0jPm3okLBjhRfLtCII4vEjQf7aHjaupAI6rnyItUdNqAlrmXJ7vDkHBjLMuoaWoEHCcJiFCZ6EFoa6rs+uoK7IXBXz0WoIkJ5hOxwtj4Jkyr8k7wp6izu95bAID+3nKlt2lZ+E8HjZYQVFDeOhLg2HBA4EKncT30p339f6av0Gwi2krlBaokq0Q1J7H4oSCHC5oQ8vdCdyN7HnPTGGrAmd+brNLnKTpqPhhlrkKqOvzZ8XW7IM7oyZgsCP0ODVxSRIAzE32U5MVUktbt15yxJHZYYmRTPMUFqwnQCN3OqT+w6oIZuBkSquo8353cw1KbhHZ4uWK8CrVGrDijyIY3E52O6YvwlMot/VlVbjceE4zElVByq4+WO9EdHTnGeI9qJ1vApLxCXIxagJlWlhx+Jm1LoB6WCb74Ez35w+zpKMPh/7okgkgZjfc2M0ALtuWoe2JWTBZh79QCbLyQy9i+IywEjri+tGa5C3ONza/hdiClEg8d91pnnjop+9Y2KtVyAMlBK0IjPTngMpxZNv7iIrTr2gB1KQptNKhMqchLKhJxjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhucnhGeTV6aEZDcGNLT2tQbmNEWGhrZjhxdDFCUWNtYWZiSHFOTTdheXFq?=
 =?utf-8?B?U0ZoRHFncXg3WmhYcTFtTnFWN3BKZGhFRDhxbHc5dENoZC9NTzB6bXpIaWFr?=
 =?utf-8?B?ek16aXRWZFpLbytXMytQd0dJazhOZWU1TGRhcGU2ejNTLzErbnplU3FyK2xj?=
 =?utf-8?B?MUpVWkhJenBzT3EyNzV2MGlsNzRrVXlVdmcrcmluUytEdERZYlhsZWQ0Vldw?=
 =?utf-8?B?LzR1TmVFVFVteW94MHcyS1JNK3p5QUhsc09hOHFKRy9vbTBkckxCeCt5VkIr?=
 =?utf-8?B?VWdsanREaGJmSDVobWFWOFMwaUdVK0c0WnlranRLS2VCSVlLMVNJSnBYdG0z?=
 =?utf-8?B?VTZJeGFmcmgweHZaUGM0QXNPR1pXNG1DMkp0UFN3UnlqVTJjYTdOTTAxdDZO?=
 =?utf-8?B?aGVZaVVYTVB2L0FaTXB4eGZ1Ty93ZWV4djZsUU13Ti9nS2lOczFsN1Arb1dD?=
 =?utf-8?B?bEpDUHExTEF4RGdEbXAyZFNvQk9QMHpuM2pobXhNVlV6TDNpVzlBbUVjNFVH?=
 =?utf-8?B?ZzFmKzVjUlN2K0k4dXJ3VFMyVWdEZ1NxWEFiRThaT0NUOW9aSDdLcUQ1Vm5v?=
 =?utf-8?B?WXF1OGJlSU1hVEF2QmJNWVg5SEUxRTlPSER6VS9SeTV3RG52YWVvdHFuRXZa?=
 =?utf-8?B?dmZFZGtWZTZUV0hhVWluQmM3U01pdU1DUE9OUjZkL3g4by80VDF5Q1NQaUw2?=
 =?utf-8?B?NTcrYm1SclpGMDZTcU4yVFllamJQMTJNUlpWTEJJNXJvMVR0NnJPWk5aL1V1?=
 =?utf-8?B?bmlWWjZOOEVNVkgxdXpuR1c0cmFpYzJtbzZZVS9TVnpyVmlZbisyWGwzU212?=
 =?utf-8?B?NHJpaHdVekU5TERUaVZaS2FEcmpsSUNwajBzS2wzeG1zWDEydXJPYldUbjNO?=
 =?utf-8?B?M1Z5NDA1L0J0ZUVjTEtpemNsL0xhTm56elZYWlFJL3dFdnR1eUh2ZmF1bkFs?=
 =?utf-8?B?UldaS2dqUktpQlNVZGJ0MFQ2RXRmSitvUnduQktVN1VpSm41c1BKUlhaYVNm?=
 =?utf-8?B?MHdkamtuNDRLL1BMTlBMV0JKWDhSMUhaM3RjUm5NUXVsODZWYVR5UHp0cXp4?=
 =?utf-8?B?QWxETDY4N0dNbXVieG1kOVYzNkdhbGNYN3U0bjVJS0ZLaHJJY2libm0zU2Z3?=
 =?utf-8?B?aEtBYTFGVzZtbFl3N0dGQy9pdFFETjZSaHoxOEFUNW5mazZxYWlPeVZPbHBT?=
 =?utf-8?B?bGhwbFhSOEpva1hSTjZsM2JvdkVJTmZTcVhKQlpqZ3VIbzd0MFl3bHFEU0lS?=
 =?utf-8?B?WG5MM3pXTEkxV1lLWk9SQVFhanBYR3hNU2JHeXFTdUlOMHBiRElVL3ZTS0Jt?=
 =?utf-8?B?aDZIVmZYMlBBOTd2OG5Ed0cxZ2FHdGQvNmpwYmV5cmlhbFZKNWVIZ012Nncy?=
 =?utf-8?B?MXZ0ZFNjcE9lak5WNURrd1hWd3UyK0x6TzFBclFPQklTT3FnRkFIL3dpR000?=
 =?utf-8?B?WmRPNndlemFjWTgrQzd2VzNpbFF6aVpydnhRMU5BMDEvdkFZc2pheTR0SzFm?=
 =?utf-8?B?NVF3TzgzV0F6Q2lwVnlvMHJCYlM1c0kzcEFaU1ZYWlBoc1pIQ2lGSE9qeVJY?=
 =?utf-8?B?YTBxOVU0cDZacUJCTFdkV244andqOXgvdEtFMm11Vi9FN1JrUVRLZVpFQ3NL?=
 =?utf-8?B?bTlFNk5EZ0RFYjBRVk9oOEh4SG9FUzVYSGRjY1NIVWptUWs5MEFBNjkzK2wy?=
 =?utf-8?B?a0NnZWk3RGlTQy83NWE5YUhmYVlxZ2YxSURvcURsM1ZsRnJIUStNZGpBdEZF?=
 =?utf-8?B?aWhIZ2wrK2cxSmZCR2tBNmQ0dzNLR3Z2NCtrUXlPTGpYaDlZeDlrOE1WT0hR?=
 =?utf-8?B?amplZi9lMTRYczlidVhMZHRJc2Z0Y3drYVh0RjVOdTAyVGtRa3ZpczQ1bEor?=
 =?utf-8?B?MXoyYnNvakg0OU81UURLWWU5aERZVHBDWENkYUZkKzBUamtMSTE4NkZqMDFs?=
 =?utf-8?B?dVB3cGFqcU51RzIxdFlSSXRKNzBIZkxUOTZkWFgrVHVNTDZvZFZzS2J4UVFu?=
 =?utf-8?B?R2w2UlVGaGlncDVlZWxRTGpnWlNIbjdZNkVyZGNTQ1hjaGM1WE83ampDS1c4?=
 =?utf-8?B?ZTI2TnN6MG5mMkxybWtlSU80Y3dHWkdtVk52Z3hyUUd2L0xtckgvcDBSWVRs?=
 =?utf-8?B?QXhqOWdRTzhEcUJYaUZubWllQTdQSjhWQngydXdXTVAvY2FiSTdzUnltRHdw?=
 =?utf-8?B?YThVdmpvcE1rVVRNcHFsK1lLZEtnYWRkOXl5ZE11Vk9tODlpSEhoUDNQSm56?=
 =?utf-8?B?STFUT2lYaFJIUDlUTE5LNDg3U2hyRW0rcHhzbXorRjk3ZEp4bmVPbm8vT2xL?=
 =?utf-8?Q?JGoW54QCX7Y+T+DGz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ce76a8-950d-425b-d7a9-08df04af6531
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:52:27.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GNP1OTYh5B4fpjdXqVz9FOiLRTNtfLwk39NIwk88CPZ6RUTrvp92Krbj3ZmcK9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235

On Thu Aug 27, 2026 at 3:55 PM EDT, Lorenzo Stoakes (ARM) wrote:
> The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
> confusingly only control the behaviour of THP in some instances.
>
> They are not applicable to MADV_COLLAPSE operations, nor to DAX mappings.
>
> Long-term, THP is predicated upon compaction being able to obtain large
> folios to populate THP ranges.
>
> However, vm_normal_folio() returns NULL for PFN map mappings, thus their
> reference count is maintained by the driver, not core mm.
>
> As a consequence, the folios are not subject to reclaim nor compaction, s=
o
> are not truly part of the THP mechanism at all.
>
> However, since commit 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> introduced the ability to establish huge PFN maps, they have been subject
> to THP tuneables.
>
> This is incorrect - if a huge PFN map is available (defined by
> vma->vm_ops->huge_fault being non-NULL for a VMA_PFNMAP_BIT VMA), then it
> should be mapped huge upon fault-in.
>
> Correct this by explicitly checking for this while ensuring that smaps
> continues to accurately report THPeligible statistics.
>
> While here, abstract the entire file-backed THP check in
> vma_can_map_huge_file(), with sensible separation of logic into helper
> functions.
>
> Note that drm_gem_shmem_mmap() and panthor_gem_mmap() establish huge PFN
> maps of shmem folios, however they are marked unevictable in
> drm_gem_get_pages(), and in any case would fail the reference check in
> __remove_mapping() even if they weren't.
>
> Failing to map huge PFN maps has resulted in significant real-world
> performance degradation, see links for details.
>
> Reported-by: Cedric Le Goater <clg@redhat.com>
> Closes: https://lore.kernel.org/linux-mm/20260805055544.1568534-1-clg@red=
hat.com/
> Reported-by: Saravanan D <saravanand@crusoe.ai>
> Closes: https://lore.kernel.org/linux-mm/20260821070520.25759-1-saravanan=
d@crusoe.ai/
> Fixes: 5dd40721f147 ("mm: allow THP orders for PFNMAPs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/huge_memory.c | 86 +++++++++++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 64 insertions(+), 22 deletions(-)

I checked the code logic and find everything matches except the intended
pfnmap check for the fix.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Some nits on the function names below, but feel free to ignore.

>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index afbb5974bd22..4bf7b670586d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -92,7 +92,7 @@ unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
>  static bool anon_orders_configured __initdata;
> =20
> -static inline bool file_thp_enabled(struct vm_area_struct *vma)
> +static inline bool file_thp_enabled(const struct vm_area_struct *vma)
>  {
>  	struct inode *inode;
> =20
> @@ -118,6 +118,67 @@ static bool vma_is_special_huge(const struct vm_area=
_struct *vma)
>  	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>  }
> =20
> +static bool vma_bypass_thp_tuneables_file(const struct vm_area_struct *v=
ma,
> +		enum tva_type type)
> +{
> +	const bool has_huge_fault =3D vma->vm_ops->huge_fault;
> +
> +	/* MADV_COLLAPSE ignores tuneables. */
> +	if (type =3D=3D TVA_FORCED_COLLAPSE)
> +		return true;
> +	/* Huge PFN mappings are uncompactable so the policy doesn't apply. */
> +	if (vma_test(vma, VMA_PFNMAP_BIT) && has_huge_fault)
> +		return true;
> +	return false;
> +}
> +
> +static bool vma_thp_tuneables_allow_file(vm_flags_t vm_flags)
> +{
> +	/* THP=3Dalways? */
> +	if (hugepage_global_always())
> +		return true;
> +	/* THP=3Dmadvise and marked MADV_HUGEPAGE? */
> +	if (hugepage_global_enabled() && (vm_flags & VM_HUGEPAGE))
> +		return true;
> +	return false;
> +}
> +
> +static bool vma_check_thp_tuneables_file(const struct vm_area_struct *vm=
a,
> +		vm_flags_t vm_flags, enum tva_type type)
> +{
> +	return vma_bypass_thp_tuneables_file(vma, type) ||
> +		vma_thp_tuneables_allow_file(vm_flags);

Naming is hard, but
1. is vma_allow_thp_tuneables_file() better? Then all three helpers are
vma + a verb + thp_tuneables_file().

2. is vma_file_ a better prefix than putting file at the end?


Another idea is to put all checks in one function and just add some comment=
s
on bypassing ones and allowed ones.

> +}
> +
> +static bool vma_can_map_huge_file(const struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, enum tva_type type)
> +{
> +	const bool has_huge_fault =3D vma->vm_ops->huge_fault;
> +
> +	/*
> +	 * Enforce THP collapse requirements as necessary. Anonymous vmas
> +	 * were already handled in thp_vma_allowable_orders().
> +	 */
> +	if (!vma_check_thp_tuneables_file(vma, vm_flags, type))
> +		return false;
> +
> +	switch (type) {
> +	case TVA_PAGEFAULT:
> +		/*
> +		 * Trust that ->huge_fault() handlers know what they are doing
> +		 * in fault path.
> +		 */
> +		return has_huge_fault;
> +	case TVA_SMAPS:
> +		if (has_huge_fault)
> +			return true;
> +		fallthrough;
> +	default:
> +		/* Only regular file is valid in collapse path. */
> +		return file_thp_enabled(vma);
> +	}
> +}
> +
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
>  					 enum tva_type type,
> @@ -190,27 +251,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
>  						   vma, vma_start_pgoff(vma), 0,
>  						   forced_collapse);
> =20
> -	if (!vma_is_anonymous(vma)) {
> -		/*
> -		 * Enforce THP collapse requirements as necessary. Anonymous vmas
> -		 * were already handled in thp_vma_allowable_orders().
> -		 */
> -		if (!forced_collapse &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> -			return 0;
> -
> -		/*
> -		 * Trust that ->huge_fault() handlers know what they are doing
> -		 * in fault path.
> -		 */
> -		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> -			return orders;
> -		/* Only regular file is valid in collapse path */
> -		if (((!in_pf || smaps)) && file_thp_enabled(vma))
> -			return orders;
> -		return 0;
> -	}
> +	if (!vma_is_anonymous(vma))
> +		return vma_can_map_huge_file(vma, vm_flags, type) ? orders : 0;
> =20
>  	if (vma_is_temporary_stack(vma))
>  		return 0;
>

The rest looks great to me. Thanks.


--=20
Best Regards,
Yan, Zi

