Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399C3F4118;
	Mon, 17 Aug 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009703; cv=fail; b=neAooLJiXzW/yDmWKkccspF/fPGQcRvdS3ly3uvEbHAtbofltNWe5d1j/sNPO1mZnogDObawMhLzaGTDic3qnNweGKnUY4KO4xK7vlD675FQs1kHwjiVnMSZAtYEqZLWNawZhz7bLkK6jV0uDTF9xm8T8o9QX1/V7TmgPac0CvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009703; c=relaxed/simple;
	bh=r8nGO3c7CLDLRQWykI7LXDUoxqgOmbpDGn08RXFbiiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Et2esbxwbmua01eA8TPCIL3HTkuHBAqmrzF1Z3SHChzp6avsJlzxlsQ9jXn2Iu3mlvhYUfB9x/V3jcnjSEacbdk7pj4GgSj9CpF1RODlMOQYyPe9u3qo0apCamGfGzmzQMl+cE0ZpDnJUC/MrbwtFu6kpKs9KL57EW2akfqNlnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bPQ1Codh; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bPQ1Codh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpwwkE59ioncvhRKzVPgDNBRsIZjQ/IJXIaGbPD/xJY0V5OqiDirHoohs9GtJa2uACKWQomO+hAmzRYaxufUg22WjyOigOMuftpbW0/qOqA0BvpTOeiyVTT+J3E1w1ELwxLlg4ikCsgImaP99mPRcfCU1gXu4SNNCMGqodDLD4ZE9jFCyGEx5egulYfME6RhBsPhy9MWpyJviwVyjbsP5dcrRME6Dbhqwb4eZLcdx3Ezoh4Vr4fqLzhfnApEFMkH8MT2JSKmJtRugd4Hno6gn1tueNI3X89uVkMwf5rQW12w7IdOnE5lE00J0XT/kiOR4xB3BKyMZkbvoQonFmfczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZEs8zeiLAUCxdjzlh+YZVtVQCe/BmDpBvPhAo/av1o=;
 b=xGMBlfDSJZa8ElFRdtYP3HGPXLK6Y0tZVqrnMvuhzNYpNkK4CyRxL4M8hp9sIwywZWaYbNv+hkcP/eMIlxGoPMVjg3B4Wrd5M1OP2I4AalMjD/aO3/6lvL51lPiKqpS3qgbPHPoz2bqYaJp4KUEM0YLZ0EXPNfgr/cqtyOe5sRx82ch9aTD5VSej2b8ATxMK0p16gJWGO78af+YLJlouNeic3LDQ4OeHcVuTVne1eO8J0WuXIXhtOkadc+WJDX4tzU4mbgkFu/nqX9VrxL4UWjWAOlBvehNDB6oTNHw35MceBs4eMbAUpPotxkaQtxRQ9/iFXsVBtq0a6MfMW4xZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZEs8zeiLAUCxdjzlh+YZVtVQCe/BmDpBvPhAo/av1o=;
 b=bPQ1CodhNkIhdYdYQ0eVucw/Fq370ieR3LKon4mLNuJU5uzQdl7swPE5LBjicaCwBdcJYKA3Mk0Hz4tvGFHq/Qh/aEdR4hFTYWEfu/nhmWAoi5TCQCCZTvYYC7zxl+p/jzZbiuT7bUcAHgTme8Roilrl5CFlIHyn7ngfVqpGdWGRaTQPu1AH1qRXTuV0TKX19IB8nW2NPWW/NH/oDWPdt+qa1fv1345Ow4BxUzQTZF93O3O+BqnGzf0DPVb/ICj7hqc0+dXcjhSmaluSl4NqOpVrWzW+WykcDAe9F9GxjuXVAcDdBb5wgL6sbqE2vCm247/Wz1Rt8obqsufHh85OhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 23:34:54 +0000
Received: from CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811]) by CH1PR12MB9670.namprd12.prod.outlook.com
 ([fe80::416:ea1f:d17b:2811%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 23:34:54 +0000
Date: Tue, 18 Aug 2026 09:34:49 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, 
	vbabka@kernel.org, jannh@google.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/mempolicy: skip zone device folios when
 queueing folios
Message-ID: <aoONaAtLLnYAZnmG@parvat>
References: <20260817220810.1175596-1-gourry@gourry.net>
 <20260817220810.1175596-4-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817220810.1175596-4-gourry@gourry.net>
X-ClientProxiedBy: ME0P282CA0084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:213::16) To CH1PR12MB9670.namprd12.prod.outlook.com
 (2603:10b6:610:2af::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9670:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: a6854a17-6bc9-4325-35a0-08defcb82428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JKgC6MXUHRb8jTAhkYrtyWW+9D0cu3AtDn3xPY6UqgHmOnglRousZAahBXpfSkAUflMT1OT1xYVjVJiwga4mshNese72rM3rGHtxUKpxEHrMfhyAe/Q4P1iE+y4po6qFCcYuc/kPegRggk3aC2GoGkFnJERqOHAHjLkZHtyNhC4WGbB5dkhAH9wbjXgJfNwNI2cWnVB0u2A3eQvgsq8yMf2aMeuVO82mwFbpEP+O4CAxBFNQruWBs7CZMbwLit+HrwBr3MY9zmghQiYSdAv9eB/leQ9+lTDzqfSPEIlAEC4R/RogmHWMMw+VFdvcnR5Y+06CG6KCNbAjTFkvRV2wTtg6/KMZGTRP1YdvfUJynRlyVVEkZnMoYYUwwYGwhUMds07q0HZv0j2EWGtkYh+loGAaKid6fr+/R4RVpI908ViQmPa00JY11hSDGTtbvG0YBlpeitidt6wXwhIUmIyWQfH/mmDqVqXn7+FslaWnBlauHQRavLqP/EBLL2XiC/u0sdsNIPr4DUnkYGObUI8OKlXECIZEvp/QUjWBF9JhpXsIQmrQDOfCxuLy8nxfEB/VnuteZoZNbRNU1vKFomRkT3YvEkBuuAtXJ5YGYEOMOWydsJP4DInUrqMh2s8gqni0Hnrz23xZHsI0Nqk7OgG9Zy+vZo5B0VJFWK7NAfOMXSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9670.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rUNrCD+HCSRFabg6mbTCg2C9AXpr9lCwr3OPyDjY1VbRdhpoUk/qUplpktWA?=
 =?us-ascii?Q?Zp8kPRtMlg8ONQT+DqHBRH6hmy8v+6jWCI0Re/Bgtbhn6naIiVEb0EgBqJzk?=
 =?us-ascii?Q?eUZ77x7F1lpRw2fi+Kj6EoEJpf9tu1LUeHhcYmreqp5EcXjj8GFpfCgdI3tr?=
 =?us-ascii?Q?hrI8pObyehA7wOYHw6gBst2oomFkhJwHu/JEJwzT2wPPf371kEBzKbz50Hab?=
 =?us-ascii?Q?SFTFMPvSTHZIRPzeS3vqncTD7VOsGiTp+7mhpmdNOeMIlsQGGhPB0H1tZTjm?=
 =?us-ascii?Q?SkMSs5e1EIdlqqeOQhRVLaq9mEc9iaxs0gITciqHoOItNjyRhbIfgQ2NrGnl?=
 =?us-ascii?Q?WVNBTDUEnPaKOZqxRVO7UjuYlVwpdsW/da7w8eKIyNpYApBe6HoAtgR6tBmJ?=
 =?us-ascii?Q?KYK8MGNv25eKjdh7X72Ztuu/m3jfGx2PaVHCfb9DrruRyiiUkIkOrysMvzIW?=
 =?us-ascii?Q?fzJL579zS9d1jT9QNeFFpDYg3nAz80IxQXL3zVgAHN1vYGHn+U44hUCMH0qK?=
 =?us-ascii?Q?AyEq4Hn2DQrIva6aUpMdEj9kwyQJ1kfAHeU0AdTOs/wFH+iw64Io8rx7HrGV?=
 =?us-ascii?Q?kfPm3V7YP0gbvHGe6mTMrea1BVEmeQmNdTVikV2/0+ec9sg7/vE6NHC9FF3W?=
 =?us-ascii?Q?9EGXv03bMVAnZvEbraLG/IBu8Ev2wab4j4RFvblvjwSXo3Hfua9OvYxmHYMX?=
 =?us-ascii?Q?tlxJkklAmTCyC4CpmKi9MUdMQGqVzIzPVSMjUVO1/OC8b6LRllUekogp+p98?=
 =?us-ascii?Q?ekuBTV+8IQBAymNCgAHuUyCbsQZ7l6j8SxxAMb/q1g40jPlCuMdP0OolNm+1?=
 =?us-ascii?Q?pkZmY6BxduTuSQWrqufop1euw/bK8TTBQcapSQjfQJ8b5G4zA5kpNCXrAj52?=
 =?us-ascii?Q?E6QEkovSVIWDXlDmKJBjAD9GQGE/0gSoR4gz1DiO+LqkFLjvYvO5PAUZjeSD?=
 =?us-ascii?Q?+dhEfAuof5qpf2qTV4kZNzjwXOEGmf3Ley/tlKx7RTU70kHhomhqbaQoFaBb?=
 =?us-ascii?Q?dHNhQHsLOPRJWZVQ9KT6lIXat3RBBntDCL+xCnEdMmzxsifbccagwQddVRAO?=
 =?us-ascii?Q?3jE+Ekfv1c0jXrSGQglnet+oSUVclk6CVYWgtuT0F6aaiHW6QNETb66RcC8f?=
 =?us-ascii?Q?MPjhQrfh/E2VChyBqjo1a/4njuD7Z13uEHR9/kuyQZhwOnHh0cUiQZ8Mg3mv?=
 =?us-ascii?Q?zauuoKGPacHyORt1MxymX1wU7bCOoikg/dDQoYcDjFc+OEOVHWgNFZAgkO1p?=
 =?us-ascii?Q?1FAiXU/OvZGXwqXykiq0rr5sNGGN9ZNZZCHymOT1iGk/bYreEGqXB2YaeiKD?=
 =?us-ascii?Q?v1SvCQoWV8oUsgupzmUo75grlLi/ZzJAabnRUp4wwCzBQqn1aDxkaqDQeHkK?=
 =?us-ascii?Q?l0OSEyA9TC5owfrgN/aZXK1R1dk11LiL/YIsY8l4av0sDMRcgpZ+Fr/tucTu?=
 =?us-ascii?Q?UF7O7f1s1zjINN6ROOM60gBs4GFKKHi7XhGAvSGq+Y1oKuG8CKOG2ZGOpWYb?=
 =?us-ascii?Q?F6oNsgkGEUcOrje5ZuFMT23yupCKFRiG4RPUlwn039jfMp28paN6dDm7ORwH?=
 =?us-ascii?Q?7IfEzpm/ZCstdVt7JTxmpB2wVUuXL/WSqVKjV8PQOc8MHLcvUMu5El5iTQP3?=
 =?us-ascii?Q?lvDQm5HhdIjb/cDud1LjDbVJonlry5Hq/4qy0uvfy6C/oEPmvkx2/O0RVv+k?=
 =?us-ascii?Q?/p1HKVHhiR6W1iQlD7QUS9h/ewhoV8a4WMzcHNgernWSO/aU4orJ8Fjk9Mt7?=
 =?us-ascii?Q?BKadH35Q/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6854a17-6bc9-4325-35a0-08defcb82428
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9670.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 23:34:54.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K94oTOzzXzF5Dd0GQQD7YxaLVJVxmkukWiZvExN1tKC91X6Xb/+DlPg2KOEAE2h7y0vRdXd+bZlg2QX1vzkzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

On Mon, Aug 17, 2026 at 06:08:10PM -0400, Gregory Price wrote:
> queue_folios_pte_range() already pairs vm_normal_folio() with an
> explicit folio_is_zone_device() check before adding folios to the
> migration pagelist.
> 
> vm_normal_folio() alone does not reject zone device memory (a present
> device-coherent page in a normal VMA is returned as "normal").
> 
> Mirror the explicit check in queue_folios_pmd() as well.
> 
> queue_folios_pmd() uses pmd_folio() directly and can encounter a present
> zone device PMD - e.g. a device-coherent THP.
> 
> This is not filtered by existing checks:
>   !pmd_present()   - only rejects non-present device-private and
>                      migration entries
> 
>   vma_migratable() - excludes DAX and VM_PFNMAP.
> 
> The early return also means such a folio is no longer counted in
> qp->nr_failed under MPOL_MF_STRICT.  This is the same pattern used
> by queue_folios_pte_range() (skipping zone device without failing).
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3498a5651d50f..3418b5664dcf8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -662,6 +662,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
>  		return;
>  	}
>  	folio = pmd_folio(pmdval);
> +	if (folio_is_zone_device(folio))
> +		return;
>  	if (is_huge_zero_folio(folio)) {
>  		walk->action = ACTION_CONTINUE;
>  		return;
> -- 
> 2.53.0-Meta
>


A similar patch was sent out earlier, but that was only for zone device
private THP, we don't support migration of device coherent THP today (we
should add support). The patch itself makes sense

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
