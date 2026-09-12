Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FD357D1D;
	Sat, 12 Sep 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236133; cv=fail; b=QMO58gcERxESDnobhfHj/rwqYKW/H3FEpRkRK/PKRKX7MgpDKaU6kOEjGH5fRU5yKzRgZEXKw4wVAQ3OTWzlbFQNdFKWOhWWdtwUws/8M5yUtOF3Dgmsa5yAIpZLYCN7WiD57rcCjzhxGQJB54Spk+TeM7+Z/moTSQMTskplxgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236133; c=relaxed/simple;
	bh=1tdn+XyQHy3f91owQnmOnzigRZKxQuLgir+AiKtZ8o0=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=IvrtmDo1bX18A0sDZ0lFzqNDSNbbOGIwuVd8jHDntTnL4mriqv/p9rDyqGLxMPENKAwYRUQQQ5n69WVUf1zLpzFnAFMJ7ovYePf5Udw/gP4onYI/x356YDizsKMkzDY6eVSRC8fZ0OhlbWwiiRwX24ajZ/J8qy/fzWE8BxSwQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rGEKclTc; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGEKclTc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwE7XP+sj0KwN7VoiRowb0zyLfNg3yj/PKhWqrQq/P3aIBU24QIriCQIujrUs0J0FHdedx23z3/Qv2ouKFsLlWL20fQEM/xEIl+KO0VoKsyCqRfoXNrTgIcti+jUwCDFEv7uYSqe1g2l6hCAvyJVuzxFiz4UJwXqyGNdV0fTn+zihJqd+WkBCBqleV4+pY/NQ6Cd4z+k235xlxvDaWJwhUQMbruBRRhY9O3vCR5wudTaOoFtGEnF86rbZLTtZDtJpJM0HfnAnTjP5nerMTLizZg7q9H0c7OeQWD7JtY8QeRylcEbdcXKZjIEQNvrmI/jZgNIITANn9zZV0XPZcs4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQHw6h09a9Pq3Ro0Ju4H/VTeR/4oegt+utROR8ZezVM=;
 b=qbkrOSPZibcZxM6p0fsIh1hxlIKYcam5EF7J0t0aHxrArIgjEFf9jiC/4kuPXM479n8mjwVc+Rlv5PmndP6YmVz3JU2SG+2dMIaKRXw0soACDdu03T7mffDWgsJgsf4v/ob0RooDDi22xmQq8d0inal+7DGhJQglmry83oeAqMmpO6+yEzg4pRM9gOHK9FpRyEwAyELv3bCfhA4rxmOf7yhdrttpS6fda2oEg4iQWS1QCDhdsVHxe3bJjDdfmRMH8LSrTK0cH8nlUAUVxQcgD/De81AtqPD19+DRN/W+FXwvnNRaxLh2f+0krS8O8rhhHZ7cl+UrPgeo7w4CiQb+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQHw6h09a9Pq3Ro0Ju4H/VTeR/4oegt+utROR8ZezVM=;
 b=rGEKclTc9MDWt+Be12We13BrGBbOIQaNENVUOANMewKU/un0+UvaRDEfTCOIIWUT++rMIybsOZMc1ZBOXY80IHvoViMcEqSoC+ZfQGk4/23Ch9nRSM6fuZkTF4bNbazUa/xDwhUmLOFYgrZ0enBvIa3KquEJeO4K/81OwaKeDeQa5aKi0SjbFfG32cB19Bs4vvM8NJqYekED2mLnAVhKd6FGzKraO0k4z8Sq8xpS+im737eR3xIOwlxQHMJTeFMLRVik/PXw4KGqtKzbQ0hYVenMC29SB9z8ri1k9AjIfUmVLQy9zeHfqwNpw3C2CUQvEZoO0ffIQBCH5b7FZeAG3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 18:02:07 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:02:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 14:02:06 -0400
Message-Id: <DLDJ9T369W2V.1W56SZ2PVP5FL@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
 <akpm@linux-foundation.org>, <liam@infradead.org>, <ljs@kernel.org>,
 <david@kernel.org>, <vbabka@kernel.org>, <jannh@google.com>,
 <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
 <peterx@redhat.com>, <jgg@ziepe.ca>, "sashiko-bot"
 <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
To: "Gregory Price" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2 2/2] mm/madvise: use vm_normal_folio_pmd() in
 cold/pageout PMD range
X-Mailer: aerc 0.22.0
References: <20260912034833.2952750-1-gourry@gourry.net>
 <20260912034833.2952750-3-gourry@gourry.net>
In-Reply-To: <20260912034833.2952750-3-gourry@gourry.net>
X-ClientProxiedBy: BLAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:335::26) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 98133478-f526-4958-9cdb-08df10f7f574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nE0LbY+08skO0YlP1JlIJF/2HTUdkf+z2kr3QdPec9kxg6i6CjdGc2JKTnC1UxQdJk2GLbuPJRW3OD6Y+wjHeNLBauXK5zh2YHmta0+4m2W4+PrmHV8oGNDDqtRzLsffsIwdi7i8iP7OxMOs12KlNmAjWQwrL3AO8LTSI3bvIPkEOCXA5ikwVXhkJx0SJIQ7uG9hdTkp9x7K9BdkDuf7o8RgugPLQXs4QcVg6/K2sL3Gbpe1cmbnQTrUZfxPE0fdu5R74FcJ8pYvvD21cVejzwusI7l+b86nWvKP1GevC9nzQOXyltU2bABMY0xkTCKKhCQHtkXh8pTbD+qgDVcZD1sRZaFPzdFkE6xQ/PuuaSwnyDYa5QSj+kRnNsDPwXevAQt8gf0s7xqnAk3YKaHiJyu+Pn+foU2YKhJQWd1ZxM+NlznTx60kQlwKm6rO4J6wih3ROFlXMI+yljTgvINjcI6BaiomdzXlcFAhcLLMGT+kGg3cgjZCluh9j0lRpat2uRZ8OtV4mLuunSfiKHTJ4IVBlYIla9h9v8iUL+p/4HsRbKwepzSJU+US0REpFzTQ976rw7LGAFuwv0ydZbvg2YSdRt1AP79f5m0paRgWLvkp7sKk21NDJhQxEI6JDVLmlN7tK/X1x57GPjef3eiSAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJRRnV2Q3ZiejF6dW11MmxKM2tFYTBiSDVsd254ZkhjUDZxajdzcm0yWnlI?=
 =?utf-8?B?anhNU0tJNy9xdEFUZnJxVHZVQnUwRVhNeFc4OXI3ZWkxWFFKQ2lrUUVQM0ZK?=
 =?utf-8?B?LzFqZ3hxU3NOaU9uTGZUQ3lwZm9lT1Fzby9DU1lwcnFWSVFsUnNwUldRZExy?=
 =?utf-8?B?V09KVmxWdE81STZ4cjZxRlExSFBTem1mMmRPK3ZDa3puTEpjTm5qakprNkdQ?=
 =?utf-8?B?bTRXSW5iN2dVbVdWTWNEY3IrN2l3OEVwS0V6bndwbGlWTXFmTXpyMVg1QjRQ?=
 =?utf-8?B?MlBFNDFBQ0xhNGovcEhRSHkreGx4bWF2ZEtXQktDc2grWFVKOThudFArV3NV?=
 =?utf-8?B?cmpWdnNoMXpwMEM3aEFBcUNLZ3RKNE1jOCttaGxOSlg1NGszb1ZDNG9qb0VI?=
 =?utf-8?B?ek55NUFySUNoY3J6a2RmSDFnZVVzNWN6QXpTKzhTVXJBMVM5SVhBMThMUG8r?=
 =?utf-8?B?NGZ0VW1hR2J6YkxLOWxNOXdXSzE4QUdyU2kyMkpRVWk2OCtZaXRWQ1RuazMx?=
 =?utf-8?B?aWJxdEt0QnRvL3VVejlvK0dTNDRoRk5UWmlHbGVIUWd6Zzlpb2Q4MFRvYTA1?=
 =?utf-8?B?aW9zZ0JxRmNGdE1JeWlEU0NKOUJFVitlek0yQlp6YXlhWXBqcnBRVEJHZ0o4?=
 =?utf-8?B?a2gxbDZFU082TWs5cUlRdm12eFF5YWJGbTA4NjUzSkw5YXc1L3I1cEpKNi9V?=
 =?utf-8?B?dXdhd0p3UHZFcnlPWHJqSmpGdUMxc2NvL2JSNmkvYk9qc09OTE5mN1pVWmpa?=
 =?utf-8?B?RVhMVElzRmxuT05ueXEyaG05NG9WUjNXaVE4ZHVsVzFyQjRrYm55MEJJeHMz?=
 =?utf-8?B?N2R5VnRjT21nOWtEMUFSTUY5Z2xzeEhJT0sxeXpSZjhZRlVPL1hwenpPa1Y0?=
 =?utf-8?B?eTlaa3VCZnIzQVNoVEN0S1U4WCszRWM4TXd6eitVZ3pwTXNlc3VxaGNobHNu?=
 =?utf-8?B?TldEK1U5aDU0YzRVZGFXK3lyRjBLekM0VjVROHh2eGZ6YWlwTExGQ2RRWm1I?=
 =?utf-8?B?UDRPQkdPVGltcmE5Ti9qNDF6SHlyMmlsdUUzaC84QjFZTkV0dlhJdW00UWRK?=
 =?utf-8?B?My9UaVY2UTVyMEVSbU5oQWo4Z0FmNkwwTTgxczRqY0hvd2ZaMENoa0NXanF0?=
 =?utf-8?B?WWRTVzBwTndOcGgveVl3d0tKMkk4VWdUZjljQWowd1N4T3pib3NrVmM0TFFy?=
 =?utf-8?B?R241WnNHc0tLSktFUTZXUmMvWDkvV2hRZU5hSU5jSWxwUUp4R3lsT3h2M2t5?=
 =?utf-8?B?bVlUZyt5eXFjcFdlTlpuWnczKzBrWkxLayt2VVNEb0UzNXhEZEFIL2N2aUFy?=
 =?utf-8?B?dXN0Qlg1bEhDQURxNEFXajVkRkJoS3ZCM3Q0U1FSRWZMaytsdHllV1NuV21I?=
 =?utf-8?B?VkJyOFVnUXk4L1VDNkFld1BVN21jWWNpWjNOTlllTlg3MWxxOHBSMmloY0tn?=
 =?utf-8?B?YVRaTDdYM2ZqV1EzQmR0SDJCUGJmWVFtZlhFVFg2RjQ1SjhDWjNGMFg0dm5R?=
 =?utf-8?B?TTByN3Q3M0dCZmx6dmM0VUdoTmxVcXJScDNudHdGbzJET1ZmaUxiak4zeWk3?=
 =?utf-8?B?NDlpT2xVNkZQcnRSalZ4Ym5YYXdjSjJSNUI4SFY4U2drODVoZkMyNkRYa2lI?=
 =?utf-8?B?RUNQNGZDRnRYbnFKQTd5VXg3dERPVmtpWC93SHM5QU84ZGlaTURXakxBdG9F?=
 =?utf-8?B?b3A2ZEl4ZVJRc0ZJOW5oaE1ERVVERHhCRGY1NGNhWFpNOURsOTRpZFR4d09K?=
 =?utf-8?B?dzluM3dqdkZ5TVRmWFB0eTM4Tm1IZTRic3huL0NKNTYxLzg2ejYwMXIwZ051?=
 =?utf-8?B?VVg4ODBKOVlMbU9MWk1WWjFsazZqNDcrdzlSemtlZTNYRWlRZXpma0ZNZWZV?=
 =?utf-8?B?YUZQQWhldFJqTmZFZ3dsWkxIUzRFR1lwdGJuS2g3eDJ4YmpaT1g3NDczSGlS?=
 =?utf-8?B?T3QyamR5Y250aVlwT25xODNLaENHbUpaamxSRTV1UFE2Qm9KU0tNbDZKcld5?=
 =?utf-8?B?a1pWaTN4eTl5NWRiZlJqRkZ3T3J6Ylp0Y1dseVZWZTk5M2FiQWorOFJwYmpD?=
 =?utf-8?B?MFNuZkdmUzdPL09URjZjSm9XRDQwQXB5djl2cDAxMlVQdmh0YjNySFZPVzdS?=
 =?utf-8?B?REZ6SXRqcXRrVWNkNzJJVVp0dzdHNlhPVWwvTmF6UWhFTUZoRDdqUml3MXhy?=
 =?utf-8?B?czdZSEJMc1ZJUjg2bVZMbnNlelFDWUZCc3k2RVo2Sk9uNy9mWDF4MGswQnJq?=
 =?utf-8?B?T0xaRzUrelY4NmQ2RTRaNE1jRzcybW1iSURiNWFuYmthVGZSTFdCS0NiRkE0?=
 =?utf-8?Q?ZpSvjV2uKuRJv7gSjP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98133478-f526-4958-9cdb-08df10f7f574
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:02:07.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0B/dfZxmfrZNHpJcmK/W35uKvMWageFRMSqjmuGGQ9zyW2iH4Q33/hC91CTZHh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

On Fri Sep 11, 2026 at 11:48 PM EDT, Gregory Price wrote:
> mmap a VM_MIXEDMAP region whose ->huge_fault installs a PMD through
> vmf_insert_pfn_pmd() - mshv_vtl_low does this, and needs CAP_SYS_ADMIN
> to open - then:
>
>   madvise(p, PMD_SIZE, MADV_PAGEOUT);
>
> With a stand-in module for the driver:
>
>   BUG: unable to handle page fault for address: fffff587c0000008
>   RIP: 0010:madvise_cold_or_pageout_pte_range+0x410/0x9b0
>    walk_pgd_range+0x52b/0xaf0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_vma_unsafe+0x8e/0x120
>    madvise_pageout+0xb2/0x180
>    madvise_vma_behavior+0x46b/0xa90
>    do_madvise+0x108/0x190
>    __x64_sys_madvise+0x26/0x30
>
> Nothing validates the pfn on the way in:
>
>   can_madv_lru_vma()     rejects VM_PFNMAP, but not VM_MIXEDMAP
>   can_fault()            *pfn =3D vmf->pgoff & ~(mask >> PAGE_SHIFT);
>   vmf_insert_pfn_pmd()   no pfn_valid() check
>   pmd_folio()            pfn_to_page() -> unpopulated vmemmap
>
> Even with a valid pfn the path is wrong.  The mapping carries no rmap, so
> folio_maybe_mapped_shared() sees mapcount 0, and the walker goes on to
> folio_deactivate(), or folio_isolate_lru() plus reclaim_pages(), against =
a
> folio this mapping does not own.
>
> Use vm_normal_folio_pmd() and skip on NULL, as the PTE half of this same
> walker already does with vm_normal_folio().  This also filters the huge
> zero PMD, so its separate check is no longer needed.
>
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when in=
ject")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40=
gourry.net
> Cc: stable@vger.kernel.org # v6.19+
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/madvise.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

