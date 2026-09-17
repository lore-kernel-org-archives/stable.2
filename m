Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EB4F85B4;
	Thu, 17 Sep 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667365; cv=fail; b=IYlEwaKZ1wLKYiWCHliVEM82HTHNhrhiG0Tco1rOscnyPmwKxtqTf9wf8AnsaBh/DgPmZOZDNID1S+9ZZP9FKmrJ8C7P3xO5ALrtkv0HXfegNk9Zee2srVsKmt8BRwlSx3aRUj/D8/W3W9wZ35aIC1lBczoCBX4QjAnByBJ0+Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667365; c=relaxed/simple;
	bh=JbWE3jcyH4Ukmx8DB7Mw/60LIAPl6nCibBT7qG53OKY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=sVXVyFvXbACwQWGOLSZeWg5KljXSZrhg3ffovsv7rnN9JMcsnLZr5VH0tuWbsjekujd+ZCEkEzK6FLl7fYPRUq2HC88HIgmViU/Gf+CjvpnQOLoGQRdY061Nj/4H50+ziSiaG7I8hMWThtJ5WwDMBtx6zz2F4cfJ7mYOwyBPHd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uH2kgrbD; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uH2kgrbD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4SO/Wb9B7gaPRazQZuKBzfOUcz4DUeEkx3UJWOac3g167vZrtvd3uP12eHl/Cydw2CkEkoqQ7aAg9PojfZBVqmUYLtDis8GcKkmde0Rh0YeddDUnAlyPiIbORTo6ZpZuUX7l7dXwBi5n3P1KjaXcyQZ80BmjV605icvqNE64HuPjRNq6FcugvprkHsOj8hHaai2G31bLsUybqAFYeAkVzVRm75Rrze8H7yovNgdIkuNzxWa2RoXLVYGW061CECDsD/5LIzIfDN5D0x0cElFFbxtTH6B8oLGUcalYt3iQK/F49pKHDOIrWuZ/fgJX/PeEyd0asVXW++QTP1pfADPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyKBzB7EXBQhz1eW5bQ7J+ZiLg6/sI2nMu8MiGCsZeM=;
 b=Ny7/HpB3wO9f6T5Kqy8cp4dwybHBlomfo+VWgXf2MSt1LQG2PXxmMTIoSgEIJJfGsl+rdtNsQhpOJQGufbYNotS/8cI99LeX/FQGtKboF4uM1cB/C8VFxE1F60OXiMcXQ5U0O6Q3R1h41yeQdaFP4PqTkt8UtSXFvEVZQwWNVJOOsNJhMSOAHX28CmlyeOr4jTKFcl29EclY0EhxmLDmsrWDrXPCsrkPigOYwQ2+Iw66Hzr/oWXTdxGBRr74fZiXkVJdtUj0i17MBb3XZaoaCDgDMYHx/CioX00SkD3INZe4UigztySqiFFPpXk6rF4kkzhLVK8Dv3n+c+SwDRVjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyKBzB7EXBQhz1eW5bQ7J+ZiLg6/sI2nMu8MiGCsZeM=;
 b=uH2kgrbDmps5imGN3tbzhY+hjHFu4/Vqi9l61RroURjHlhs4Dnk5Oqy84ECgEBm0Wu7sAeW4OU3n9saHw1UW2Kwctw0lUMEnZCDCUK/XCDkeoBhRgp9PFHflVDtdvUau7unobFVHAu260zRAztK9YJhIF75i/1wUUuKEq8P32w3r26Z1sGHQe0KUE3gp4Ysc+6ytHKR+6tNmUMY53hjXQhOBTBK6kRP/GKcoffPN/MOnuZp50PIomCdiWZiA/bE/Zk2FhP9fnjaaCwcaAAGFYH+t3gu6ieFtFmAE+RLKpAY2PV9xmhgxRxE5tKhL+UKYurUsi//k8WKBA3eHmFs+qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 17:49:13 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 17:49:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:49:05 -0400
Message-Id: <DLHS4KFPQ86I.1J4LN3352RI71@nvidia.com>
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast
 tier
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
 <akpm@linux-foundation.org>, <david@kernel.org>, <ljs@kernel.org>,
 <liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
 <surenb@google.com>, <mhocko@suse.com>, <mingo@redhat.com>,
 <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <kprateek.nayak@amd.com>,
 <baolin.wang@linux.alibaba.com>, <nico.pache@linux.dev>,
 <ryan.roberts@arm.com>, <dev.jain@arm.com>, <baohua@kernel.org>,
 <lance.yang@linux.dev>, <usama.arif@linux.dev>, <kas@kernel.org>,
 <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
 <jannh@google.com>, <pfalcato@suse.de>, <osalvador@suse.de>,
 <hannes@cmpxchg.org>, <raghavendra.kt@amd.com>, <stable@vger.kernel.org>
To: "Gregory Price" <gourry@gourry.net>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-3-gourry@gourry.net>
In-Reply-To: <20260911001826.2109390-3-gourry@gourry.net>
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 413f4f1c-4cb9-4576-641a-08df14e3fbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|6133799003|3023799007|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	QBwW7OoWt4ix/OWkXzbLNEihAfxjhHiHjEnpgxHZHnEjnfOzm8RCWaaLlV4nan62Bfjt/cMx9Hy3Kz0CEiSU0k2pLOoGLJhgWvzbUMR7hmfgMAeG972Ad1gB+V6VLWKblZvzRO/Zd7ghy9yMsZ+SNH2exU2mzyId60/aqUR3Y9PCFLft2C4/KTiVq3180AEc42D/Y9yLt228IqV6k5dT/zSR8VL8ZAeEIaVUGKYoErx+q0ahILt2z62TVOO/PpiqAliM+LNTHKGAPMxFOHbIMJqnQ7vKaN+lVu9Y5/ajXOSWKbobDl0a0MLjyylP5jSa8pfV5gZug2MmegFjhEGg0qEF4CAFSI9wUMRVbZI0uW4Ym7lNMYpIuCvh7ju27GcY5AEj42YmFSMjxE8Jj8fKoXHh94TBlBzniD4DDMSCXItXzPtjveyvX3sNa8hA0QFeGdIgV7gcol3FQtWzgpznDIRrz8UeUrjZU2pRQKSUG9mzUwCGWMgWVrIzFgIiRr2wiM+rVCHs+9UBKq4UWtMqS1rNy09GVIE03fqaw8TWMYz54r0HTR//I/spC0LJQxGmXO4EvkQ+6Fje0+/deZ1nrG2RUcxiUB8ytkzAAxQ0g//YV/ChrscfklUfQH1+gCs+AjRkr5wFq+/XTk8m7uva0PT/ghQDdbf9Xi+HU+lWP2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmVoendiMFVHTElpWDlVZHFoMEsyb05tVDF1Wll1em5BY2pPajRBZzJJQmM4?=
 =?utf-8?B?VldzOFNnVlVpRVFqbTFHS3lpSGswUy8vblFKMEY5Mm12VE9GRG95dmt0eG1W?=
 =?utf-8?B?L2lRcTdHdFdrRFlSbktHNDVNYlZTSzNmV3JpdHdxUkpNNHk2dnZXbkN2S1Rj?=
 =?utf-8?B?aHdQK0ZrOEg0SnVyK21nRklpT0JmVHZPeVFWaU90dHZkNlRzSkgzeEpnVzg0?=
 =?utf-8?B?clRpZFIzMzBVM3YyVGdRbXdQNkV1ckM4Q1M3am5NWDBVWmozTEVSMktyOEhr?=
 =?utf-8?B?VzJ6YU11Z2ZEL08rNVlJSTl3Z00zQlhZazlRNHRFVHg4UUpEcG00RmhHbUE1?=
 =?utf-8?B?YTZHVHBOSmo0UmxRTWlraHYvNGRIRHdEajdSb2xSQTVQbko4WGR6RXE3UWYw?=
 =?utf-8?B?UTRyTW1idVI1UmtwY3VwTTJtazlldnFPVFhFYXlFYmRZdnpOc1J0NVB3cW1l?=
 =?utf-8?B?ck1HbDhzMk1kMG81aVFJc1hza053SkNvZW5jSG44WjE5aW1QeFNudWdJbHlq?=
 =?utf-8?B?ZjdXNnltWU9zcEw4TVFOdHlYa0hsU3JMVWpZenZkRFRDQ1dzQXNXaCtiOEhF?=
 =?utf-8?B?YWwwMElhQ2NidEtrSFBvTThJYmE1M3hIVlJrblEreVNXN25TR0tLS0gzQ000?=
 =?utf-8?B?bVpwS0UyR0pMNHRnZG96SWVCcE95QlNiT3JBQTNML1NEVXltNHhRdlM5SmRE?=
 =?utf-8?B?QjFRRXNURmZiV0ZnOXpmT1d3VUhTRm5DWWpvK0VBZ0lsRzgvMnMra2JJaXp3?=
 =?utf-8?B?cVdDRWkzbUFqQ1dRTW5UQ2x2R1hlMll3dS8zMTM2b3l2MHdFbzhzL1ExQy8v?=
 =?utf-8?B?eWFHVmtSa29Wd3ZOVWdMc1RwbXdmRS9aend2M1F2UWVZMkRReEs1dUJ1ZGQ5?=
 =?utf-8?B?Vk1tR1J2aFJFNVdtUEt3aHQ5Uk1xbi9uNGJWK1c3UCtvMks5TThHbHdsYTJQ?=
 =?utf-8?B?NExBM3NpRjdSM3AxRmRFSkxQazcrOHBUVGpXMHVrK21TeGwweVBxN251dy81?=
 =?utf-8?B?V0ZsTUZXS2x0OURuTHoyTm9VOEdKUXhiN3BJRTl5SzhZYnB6TVM2OTlZTElq?=
 =?utf-8?B?a1BkaUtOUk01d0ZvYWs4QTN2WVhJUVo5L0UrZ3UrZSt6TUZPMGlOY2F2UTJT?=
 =?utf-8?B?NVd0VlRQaDZDRktaU1JYZDgzTjRXU1VnYUJYM2hqemE4UnBwWlVJZXVPWXpN?=
 =?utf-8?B?L3lUUVV5MTVsZUkvTm5GSzVzdTFrT1ZrMmV0WEZDQ3htbmpRMTN4VUNoblVD?=
 =?utf-8?B?V3lCczI5enpaQk1sb04xQXFkOVkwVXZqWmw5ZEJOYno1enJiUnE0Snc4NkZV?=
 =?utf-8?B?NGxKK2Z2a0wxdFAxbWtHNnNnUUVvaU1ScFVwSk05RmxTemdsZlJ3Qk83SFN5?=
 =?utf-8?B?NEJqaHpnZ0kzSWZucWRZREJlVVFxNzNiM2k5aktRaGdUVVliK1RZdlJCMzBI?=
 =?utf-8?B?a3R1VVNLY3lXQjk5TlV2UUsxZ0JiWC9Ddm9pcWZHSlRZU0N2Y0lCWFk3cHRo?=
 =?utf-8?B?RERRakNOLzRwQW5OTTlEQldEY0dud214ckx1U3VKS1JJOFpnVitPN1prdzUw?=
 =?utf-8?B?U1YvS2hPUTFUQ0cybS9MYW5hbk04MjZ2M3pGY0hyRElHYkdnTnA4YWtmMzRQ?=
 =?utf-8?B?RjB6ZlFxSjExUndoODA2ZVIyUTRNNWVjaTRVRFNFb01PeEJGZTJiTHZyY1hM?=
 =?utf-8?B?VnAzL21WZWMzTFVpT3UySzBOV3BNVlJ3c3NMVFRNdzEybzRibldBSHFTY1Jr?=
 =?utf-8?B?bjI0bnlCL2lLKzBnd0lSNlFTaXcxYzNDVEZKSjNNemNwRUFmK0tVTUtMZllx?=
 =?utf-8?B?Z0xtZUFvWmhidE54SUMwcTB0cFRyVVFuZ25XM3JJdWJmMytpRGg5R0ZRQ3F0?=
 =?utf-8?B?QVovZW5BUTVBS1ZsOEg4QXQzSmF4Q1dHSVZ0SFV5WXNHanV0Y2lNQU5mSmRE?=
 =?utf-8?B?ZU1vMnNTUUIrajF0bFBIRDgyL2R0SE1hUWtCeENsY3g1RjZ0QklWVGdBRjFl?=
 =?utf-8?B?RjhKaGJRZ3NoMGdzNERWUVpFUGdkN2NjKzkzT1ZmUTlnSHYyL0d3dHkzTmFY?=
 =?utf-8?B?Q0JhK01DWjIxMUlKcVFsV296c1E0UWR5MlRpVmlZSWdVZ2xObDdkQ2owODFY?=
 =?utf-8?B?YlhncmVWZEN3MlhzdDBHZEtWWEJTU1BCb1dBN3I5L3VIR0xrZXNUZHNVYXY3?=
 =?utf-8?B?NkJ6aHowR2tMbC96WlYwWWVqekZxTHZUMmEyVWhCQmhZUk15U21oSHEvZ0FO?=
 =?utf-8?B?T1BrazJGSGJYRnN2bHZ0azlSZlhQZ1hKWGMvdTVNTHAxdXJNM0tTNWFIV1B3?=
 =?utf-8?Q?uAuikg5x7gynuEXsie?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413f4f1c-4cb9-4576-641a-08df14e3fbbb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:49:12.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKRopGlJThsABZOuaynq1N2xcR4ly3Vy8AqjWtVyRRu8Zdrcx3qpsz5H3rvCRPcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

On Thu Sep 10, 2026 at 8:18 PM EDT, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
>
> NUMA balancing rejects shared copy-on-write folios and executable
> file folios mapped by multiple processes to avoid placement bouncing.
> These checks also block promotion from slow memory.
>
> Allow such folios to participate when moving from a slow tier to a fast
> tier. Keep the existing restrictions for ordinary placement.
>
> Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory =
tiering system")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 8 ++++++--
>  mm/migrate.c   | 6 ++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a082ccfa09ec..19b599bc2dd1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -863,8 +863,12 @@ bool folio_can_map_prot_numa(struct folio *folio, st=
ruct vm_area_struct *vma,
>  	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
>  		return false;
> =20
> -	/* Also skip shared copy-on-write folios */
> -	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
> +	/*
> +	 * Shared copy-on-write folios are poor NUMA placement candidates, but
> +	 * a hot folio on a slow tier still needs a hint fault for promotion.
> +	 */
> +	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
> +	    !folio_use_access_time(folio))
>  		return false;
> =20
>  	/* Folios are pinned and can't be migrated */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a369d0c95c38..afd9c97d2389 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2697,12 +2697,14 @@ int migrate_misplaced_folio_prepare(struct folio =
*folio,
>  		/*
>  		 * Do not migrate file folios that are mapped in multiple
>  		 * processes with execute permissions as they are probably
> -		 * shared libraries.
> +		 * shared libraries, unless this is a promotion from a slow tier.
>  		 *
>  		 * See folio_maybe_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> +		if ((vma->vm_flags & VM_EXEC) &&
> +		    folio_maybe_mapped_shared(folio) &&
> +		    (!folio_use_access_time(folio) || !node_is_toptier(node)))
>  			return -EACCES;
> =20
>  		/*

Should we rename folio_use_access_time() to folio_in_lowtier()?
Otherwise the code is really hard to understand. I admit that I
introduced folio_use_access_time() and it was probably because it
decides the use of folio_xchg_access_time() in
folio_can_map_prot_numa(). But in the other callsites, folio_in_lowtier()
makes more sense.

After the rename, a comment "only record access time of folios in low tier"
above folio_xchg_access_time() should work.

--=20
Best Regards,
Yan, Zi

