Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAD4F7CA2;
	Fri,  9 Oct 2026 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569840; cv=fail; b=Rq7GF4VvI8pYoTOjocODJ1KPedktHLfUXBxaH6XJILkfqs/A838QaQAjt9hPO1xlOkEFR+mYZaWMnhDrCgBrViySjPQ4BlywwUKDouGGKSpgkYMk9MMah5s+6fQzQeRjodiIq5inr+X1uxAKiO/UTsHN49eK69w6hncRtBMLTrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569840; c=relaxed/simple;
	bh=Ti0L25S/Aa7TMUgdXaLkUjZ6yBb1WoRrv8sOT7uT4cY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=uK4TzOD609GT9LgZcS11u1DB/ga6+Fu0x5r67sOG1Cvdl3WYwjlaPpDb/dbbbxYYAh99+wDu5lVGblz0JYDXbxaLayU7F7A8pjWJL/ZLTmozAh7oz36FZFP0yhJUjxPUbc+r20W2EhX6phqcXS0LTbue/iePo2c16QvjDZjLw60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XnEjklOp; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XnEjklOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQVZ+YudhF78gtyJNbg2qmF+zKinD3lTKHtLEaGyU5xuxT9ZT50oMLBToH0+7y1R9YzzJwgB7F63kkPegPV0P0daud3HKxJRXYnPHz5FYddpT+Y4SrTpv5tkE0VmtxhPrCIfsas2wxiiw1YnGkaFlip9OjpaMJR4OemgRg8kL699ia+zE5XP+ELd00xmQpaL7t04y9PNKNFxQ3p8ZRFkH5Vkah74LnF9/4lYEA5tPv8pWqGLEvgTysRFqhpLW8+ULyAmZXWlPzn8uD5VYbYV1Q5ZdtBaHJFXf9weeXO9sTJYc9cVLUajuWmdjrY/wNKac5RHaApf1s39qiPz5GQ6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f50MZ1btfZoOGD4j8T+v0gcPDDn+3SuSMmqVjWimsKY=;
 b=YAa/UQE/yRwexcakvHI/hF/S3XDvSCuNfm4KYuu2jeQ7usgSAK34KWTE6VGNjJSb9tKAu4YCwBBgIR5Jtmg74g4rqwk3t9MUSXrQJAJqzmLuW5iV7xiAm5EM3O0IVpjzVPlihXxQb0XMLCWSHSjmIo/mRB3+AoZdcD1bb2IM6NzIeBSGzklciWvy5CATTFnif2zjIjaWHC4eZohSLbsW/c81uc6nKhE1Y6tn3se3WFEkQtDFT9mdit51Ev9/o/fzPKjwj24KhRzZj43yftdpyZal5yMPCWay1n+StsadNAOoK2pYWpLX2WIrLbiS2ZsX4NjmHXSIpnR5cF8PkAhHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f50MZ1btfZoOGD4j8T+v0gcPDDn+3SuSMmqVjWimsKY=;
 b=XnEjklOpOZKWaEwYBRP2UKojz7Li4Eb3eluB+vYL8GIAsVi1uVFYRoyfRHZD5B6VQvCDNWwvrOcVZIti6qGA6NJYdokM1WvDV5OU8DOSRfJej9T9GGNcEPg53PadryngyGnGf6n/rx+SXUDeOepGTJ1uyck3U2HpvexXxxo4prIJrhTJW7hC3i1Is3YdLduHDrVueG4IaYsxTPyqIny5KJFxO2tFQ8KbBTZcGjyrhUJojSf29XtjoNuQ3pbNOuVRm2K2v0Cun4O/R52nmReaJM/m+r2lWelwTzhXoBKYn0IqhlJaGw1G9EjkEe++SWq1QGf/VEskuVA0Evj2zStQWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:17:14 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 18:17:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 14:17:12 -0400
Message-Id: <DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com>
Subject: Re: [PATCH] mm/huge_memory: avoid transient none PMDs during
 lazyfree reclaim
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Nico Pache"
 <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain"
 <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance Yang"
 <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, <stable@vger.kernel.org>
To: "Kyle Zeng" <kylebot@openai.com>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261009165214.40212-2-kylebot@openai.com>
In-Reply-To: <20261009165214.40212-2-kylebot@openai.com>
X-ClientProxiedBy: YQZPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: afa5cd0c-30b4-4d5d-944c-08df26318af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Uy2VXGIazbkf27kC4PaM9z8xUsZoj8NqW9tPiBRxut+cQu8SCGPmduuFaA/yoOYytxAlJ03LbIDtQY5mu8CH5z+6RMCUn5Sx7CII8EYOQ8yvsX1mxC4Qqq2DpVS/r58374BMUf1DIvx13cyj3mRsZd+jyZLPRC+kTVvVktKf/e+94nRbfhRPHMj8wlcnTfjSiKfzuJgzD1JEupV6AK02SJJJzaH4qtwOSQAA2VzI+TyRTJhjWV1Pnbwz+ctjjKy+O5+zayz1Q3x7pUppULyzoNY2ZiDuY38E0gn9W3bN4HzqsPnaWA9qF05MWzAwgeIWNbWFJ+aY1+dyUiw83RlQzqUFwW7ZOfzgITcAIJ6qEKE1eOmslUMVpBGfH2bpD3f2P0nlacSAf0qvZJlWhNECPB8pNmLP4jqJUh0GeMeq0Qrpal8U1JJLxstxy+MjxTo1S7xXWhrmHjp71LLWBArhL5rnH7Znqsyquzo5qWzBXzUpvrLkUFPs2scGa/GIEHr1eQfKp8d0UAv5SouEJ5QVNmQj1CpnuyJEIGSKwOkXTpTOBwKSw+0eb1gjV+WWB4HEk97u2T+UAg7+QKldsAPgdBz+rX8CYpz3sEKb0Xo6u7qMRmbzLcB9pMMJYpmtwvFNY1WxI1no3AZCblFO3E3XdzxMamrCtF525MWolIBSNJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVp1Zis5SGpXZWNuQlBibmVWMzZLZG95U1dWSVJlekcyZ05laWN1NXVoaHBl?=
 =?utf-8?B?Q09CbHZSQU1jai8xbERiT2s3bG5ITVhCTWFJU1pKR3I2c0MwbnBsSGlIVXd5?=
 =?utf-8?B?NzNxVnNxaTZFTXBxeEd0UHRsMkZ6eWhCYnJuMUN0SjRuQ2x3NUkwamVHUkxY?=
 =?utf-8?B?MHF2MG9WSnhzVGo5amlzKzVaOXZNczg3b1RlM2JlUEFkREdMU1ZUQmFzRG5m?=
 =?utf-8?B?STlRMjJVK1VQNGFnM3N3QWdsUXVQRWZiakpFbFNxbHBOcHNOdGlraTI1d2ly?=
 =?utf-8?B?U1NpUW5WVWliTmFvOUJET2JUSVRUejMzaWkzbW5qcGs3M0hQMytlWnlpNWVi?=
 =?utf-8?B?WkFyeVJubng3UnJ3VWZBdUNwYnFyMU0zMW55WXhGS1dUQ1F5ZHFYYmFqUVZU?=
 =?utf-8?B?Zkp6czhhVG1Hb0hjQlVsR084WVNadDBOQWdxMm1HYkI1TnM4NjI2NUdoRG9N?=
 =?utf-8?B?KzA1VWo1eWtVM1BBMk9ESkRwV2l4Q0V4QWgrK214cWxRdEFUajdHZGRZU1hO?=
 =?utf-8?B?dXRqVlp2NUxUN2IzUnBwWGMvc3haQWhCT2Z5dzM5dnNPTVpORHhEVTUrNm1o?=
 =?utf-8?B?dWFnT1VrVy9KeXp0YU9qaWp0bGh2Tlg1Y09abDc5SjVUZEZWbU8yWUQ2NEVZ?=
 =?utf-8?B?b0l4WVpvMVRUR3JqeWl5YnJPamxjekUwSmg4MzQ3c0ZHa055WjBZT0hraCt6?=
 =?utf-8?B?UlN3NnlBS2pUaHg5MHFXZDNaWGZ1YVA5amg5OEtYYnMrQXpBNEpxcHY3cWNh?=
 =?utf-8?B?NnVOdGtobXdqdGZPQjVnUytRVnFrb1ViZjd0TXNRaU1yckdaYU1pU25YQnVy?=
 =?utf-8?B?Z2VMd2lzWDljdzB6eWJQYkxHbjBVSGVRbnlMOWdCbkE2a2ZzMG1JRkJzcDNZ?=
 =?utf-8?B?RE5tZXZ1Mk43UjExSUFydWpCTlZGT2lCU1FVeXVVNG8wYWhkV3RGOGpyMVFk?=
 =?utf-8?B?Q2dkYVZOb05LSEY0a00rWGU5N0l0cDFoRGpxTmNqT3JFSnoyNmttbGxvNlVD?=
 =?utf-8?B?aGVzNzMvT0pnbitSMkJYR3dpRWtObXYraGh1UFFDOS9JOXVNUlBtK0VjdkJ5?=
 =?utf-8?B?L3Q3cHZjSHk0RFZ1blMxZFpXdTVoWUI4UHFQN1kzMHArdnJHNWdlbjVDcm9j?=
 =?utf-8?B?Q2UvVXJObGJaZzlCN2NjR1hBaFRhdWRkaE1MWDQ1SjVCU2Jzbzc2b0hGZ2U3?=
 =?utf-8?B?N1RoV0QxU0Z3dmtRR0ZIaGRwMmFRYkttR1kvRnU2NVhuQW0zVkFDdmNXdHlu?=
 =?utf-8?B?VXcvcSs2bFVvOWJGbzRMcDZuOEVUT1NUTzkrY1hoelNhWmVSMndQT2YwMW01?=
 =?utf-8?B?MXhxdkFWQjRsdzJRTUNyNG9BWlhwRWJxckpidEFvUERXb1BRemxGeE5RMUlo?=
 =?utf-8?B?RHVtQUpaQU5FbUhUb21LbnNwY2l5Nk9OUXhaZG42VnFiTmVaajIzRVdVTS9U?=
 =?utf-8?B?STUzNTNUNjZBN0VnS2ZqRGI4TFFuNUFXNXp2aWhwUkhadDlrOExwNUl1WG9F?=
 =?utf-8?B?Vm1mdGdBaU5FT2RiY0tQRGhXQ2NPVys2SG1OelpOdjRRNFlLTXE5QWtSQ0px?=
 =?utf-8?B?YUF1VGZuRnhXTFNsc0pFdTJQVlVncUxXZHNXZGhkUWJWRHZIY3I0aEpuSVFr?=
 =?utf-8?B?SzlYY2JXUGZ6RnJPSlZJd3p1L21TY0Fxa3FwelhhL1JSRkpHK25zT3hxRXha?=
 =?utf-8?B?UngrbnJNdnJOeG5IQUxzTFpUbkRNMTFjWTBYcjdMQjd4eHFqVVhWbFhubGZ5?=
 =?utf-8?B?K29RMXJYY00yb1lKaStLb204aTJGazFReXlmbXV2U3k0clRTdEtrNmU5YkxO?=
 =?utf-8?B?K2wvUGZxZmZJaGx4bEJtYUFVU0Fhc3BPdGRtcVk5S1A3WkdPL2lrZjQ5MGdS?=
 =?utf-8?B?aUxiOThIVE5zTUh4WksvT1QxNzc3M3VmT28wYmRVbjcxeWcraGRpMGpEQnJG?=
 =?utf-8?B?NGdRR1V0TXRIZjFxZDlFakdYQ1lJQnhUR01JcktoVzFIUGZORlJ2TENRczh4?=
 =?utf-8?B?ek9aU0tNRSsySzNWMVNwNkNmSy9POERkYmdiRkE3RlhKMk5IQkwxbWRPY1NL?=
 =?utf-8?B?bWtEWkxIWjUvelRqYzNsdGdkWFhwZFY5ZGxranZyOVkxZERqNElad3pJbGVk?=
 =?utf-8?B?Z3ltUXBpcXNsMW1EZjdPU2l1OWROa0JvL09tVjF6RWNWSzF6RmlDWXF5NFdZ?=
 =?utf-8?B?dzZHWlpVQmtQOHR4S0RqZ3VUWVd1N2FyUXNoeWdoaXBkWVAyUklod2ZSOUwz?=
 =?utf-8?B?Y3NRaVdkZ00xQ0VrRC8wTHFvcmhkSUFtbUYvZmpMSVA1Ky9kQ0NpYzB2Zmxm?=
 =?utf-8?Q?JiPDstRj32hBZTLrOW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa5cd0c-30b4-4d5d-944c-08df26318af8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:17:13.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBixh14+23CKIA8RMBRYD0GZhm8p0F2F18lkWmfy1Nl72+0+WrF0E7vdHMxdpaKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

On Fri Oct 9, 2026 at 12:52 PM EDT, Kyle Zeng wrote:
> __discard_anon_folio_pmd_locked() clears and flushes a huge PMD before
> checking whether the folio can be discarded. If the folio was redirtied
> or has unexpected references, it restores the original PMD. Reclaim holds
> the PMD lock and the anon_vma read lock, but not the owning mmap_lock.
>
> Both zap_pmd_range() and mremap's get_old_pmd() can skip a none PMD
> without taking its lock. A concurrent munmap() or whole-VMA
> MREMAP_DONTUNMAP can therefore miss the PMD and later unlink the source
> VMA from its anon_vma, leaving a restored mapping behind. The anon_vma
> write lock taken by unlink_anon_vmas() waits for reclaim to finish, but
> does not repeat the skipped page-table walk. Once the remaining VMA
> links are removed, the folio's positive mapcount no longer guarantees a
> live anon_vma. Racing lazyfree reclaim against MREMAP_DONTUNMAP as an
> unprivileged user reproduces a KASAN use-after-free in
> folio_lock_anon_vma_read().
>
> Use pmdp_invalidate() to keep a recognizable, non-none huge PMD while
> the discard can still fail. Concurrent unmap and move operations then
> have to synchronize on the PMD lock instead of skipping the mapping.
> Clear the invalidated PMD only after the dirty and reference checks have
> succeeded, before removing the rmap and withdrawing the deposited page
> table. The full invalidation retains the TLB flush required for the
> dirty and GUP-fast checks.
>
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_f=
olio_list()")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  mm/huge_memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e5d68acf62a..20262195385a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3569,11 +3569,17 @@ static bool __discard_anon_folio_pmd_locked(struc=
t vm_area_struct *vma,
>  		return false;
>  	}
> =20
> -	orig_pmd =3D pmdp_huge_clear_flush(vma, addr, pmdp);
> +	/*
> +	 * The discard may fail, so keep the PMD non-none until we're
> +	 * committed to discarding it. Otherwise, concurrent munmap() or
> +	 * mremap() can skip the PMD without taking the PTL and later unlink
> +	 * the VMA from its anon_vma despite a restored mapping.
> +	 */
> +	orig_pmd =3D pmdp_invalidate(vma, addr, pmdp);

There are some gaps we need to close before getting this fix in:

1. GUP-fast cannot follow the invalidated PMD: riscv and LoongArch need
pmd_access_permitted() that requires _PAGE_PRESENT; s390's
pmdp_invalidate() needs a change.

2. sparc64's thp_pte_count can be imbalanced with this change (based on
Lance's offlist feedback).

In addition, powerpc has a page table check issue similr to riscv, where ri=
scv
fixed it with commit 9f4a88b8d01a6. This is not related to this issue
but discovered along with the investigation.

> =20
>  	/*
>  	 * Syncing against concurrent GUP-fast:
> -	 * - clear PMD; barrier; read refcount
> +	 * - invalidate PMD; barrier; read refcount
>  	 * - inc refcount; barrier; read PMD
>  	 */
>  	smp_mb();
> @@ -3607,6 +3613,7 @@ static bool __discard_anon_folio_pmd_locked(struct =
vm_area_struct *vma,
>  		return false;
>  	}
> =20
> +	pmdp_huge_get_and_clear(mm, addr, pmdp);
>  	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
>  	zap_deposited_table(mm, pmdp);
>  	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);




--=20
Best Regards,
Yan, Zi

