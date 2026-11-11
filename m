Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794423039;
	b=T6jzc24mWcMKmbU2bq3aOY/ulMgsDztYi5ae/m+ySMVHmZlQOqs4+GgJiwvngMU4XoU5
	 eBBaxx3SKin2rrO8ERJhRDbupeiltEIlrdf7s0hNMrbGODjRJrNO02jQrt8s4wNzUXSK0
	 eKm33BHdIcwf581sEVfAF6L0lDaUOUSB+RrsVMShu4IfHB7So2KiZaYlXGk0eIJxdAC7I
	 D9hPoKqmss+yktKJmS4LUKPn0FZc4mgAaosiDt4tiDj2/yO7E7X2lVE/zjC5YScXve2mP
	 NfXTA5do987IyEZXuBr7/qTe4zGiIIZaEVq5ZMuvYxsHUhAsGy1M0+pOsYYgme2giag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423039;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=S9WuI9PTUeiv5O5AStKEefptoT4aWnKBezJfaA7uZAs=;
	b=WbwbbIZXW+WM48QaQW1uScfV3dJJnbNHssFTv51Cq/PtNK6UDkLS2A7QTOUlcXGwyW7B
	 A8amalonWegAuiyqbYTSof2Cw6zdzG++8anK8uGnBxNOqoGsq872L0HIC3kmFBIuzewi9
	 xwJ9JZCCf8jPp8R2K9QOKHgO8ZpQmBMDCk44NjoEDqL+wLIlqFZQ4lY8Ago23B7pc3MtJ
	 42PYoFCqIX4WBXI/DSMPr37TiZibtQkpHGvNt6xrnYFU+pom4WRfw/GruqtmVdjADV1Nq
	 FSuPdEbUcHzaDz0kIFXeGlAWhpD9oMeEYvX0B+65zq/9t7dSYY7yhKjG9aAl8MTa7iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uu5pNF6k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB30606A324;
	Wed, 11 Nov 2026 18:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB30606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Uu5pNF6k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPi1Dx7GMkpj+qyUXhDxT1t/NwGo8nr1U5AVdZpUGXabB2oV3MKIj0dbUEbrvMAMpF6g1CXZE6O0jAGxeLDonDE83krSVzpJuW3p5rI5GxHdpE9oPzHQFfqtXQruKUHN/MqS+YfLBuYjYjWABeI6qOXS4NzQnUMUxqsS7cVpMOfaVUuCUiUafxGuNQA8D8zaalncDKuoP1jjuusZo49Lrq2YC+IVYLLjhXaM7XO7HxEYKPydip+qc5caKhZSzzUkr6V2rohTYYUYACciTB2owPMduUNoyRHsByxyFua+IJ1vcQVcWB+a67QcVkpxZBgxxzDuNNryt8uowGuIQXOpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9WuI9PTUeiv5O5AStKEefptoT4aWnKBezJfaA7uZAs=;
 b=GP4bTd52ZxoU21x4ShcPU4r25+FA3clE2gGoYHS4yOZLW2sbc9x3x5iZKTikJn+coqvQCnBDt79toPjlmLDSXIqeTOvDffYwVTwyTvfCFJpf0SxWzOYO+p52Lq3jlRODLeHN9ZGNCaXfRzNGmvykt0hxqYiJ5rykz9zaQ+yvibPhP3uMZ1sWVLBJl1t+maWxIREK2y/eL4Ndwn9Jiujgjhhbm5o+Dx8Oib7061P6/ySJai0QVKd0JiXo4EZ3bbuOlMS12BlCMvAIHqzOj5F2whNS70GHCyisDEEwZ1VcBCQSjHUxjz/2hCXGXlWSfJK1ThVROn3cWYpkIJZh3Hc9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9WuI9PTUeiv5O5AStKEefptoT4aWnKBezJfaA7uZAs=;
 b=Uu5pNF6k+pWE2vvGyeQF0y/Nb4jfPkn482MR6iTVjk9OES134lLpEMAhuNbo6bYnkWegVymgypVV2S7GEuxULCGcbCGGnp8KVDVcN2oapUHnhq7xm9QvGZORNhUUjI5hB/EeKKxBSkjHkFXsPeA1Amf/AC0W8BzoRvrm+yNxLCq1YWITI6bzvq9q1PT4vN6ZfDbsFytgwrdtKHra1ezlX28YzbJ2T9EA+JAQQa7FkghBPZ6lFd6FGnpQe3EE/XTVsOfjR5FnF9OKcck91jgDtp26mkHPOtzaAwvT/23wTVYMXaHEtYHspJvpEjk27p0YXLY3bp51Ojwt6hGK03ye8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS5PR12MB610447.namprd12.prod.outlook.com (2603:10b6:8:47e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 18:50:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 18:50:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: don't PTE-batch a swap-in over a
 hardware-poisoned subpage
Date: Wed, 11 Nov 2026 13:50:29 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <2214E459-71AA-42FD-AAAD-07C49C81A676@nvidia.com>
In-Reply-To: <20261111113904.650722-2-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
 <20261111113904.650722-2-usama.arif@linux.dev>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN1PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:408:e1::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS5PR12MB610447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c32f3b9-35d2-4c90-b82e-08df4024a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	he+ZVwj0+LviejQYdcsw/NGx8lSlMlMk4rBWxVZwpfeX6jP66N3OW7g1QLSQ0LaDBzH3xlnExf+7rK9ZxwsfsyuTlavLYwtcluaOGr7ScHad7E06n/brHAx5c85he99S9eLyi14w9kSNFJYZczCjNvAix2+lYSW4w7QbhLMDy6IDeYYG00X7y07CAXmxLd2GxgrZJ0bPyhxnqRLyMdsBahsX/QxtnOSGY1IPvF5Puwl7f8DMB0n7kCYWeDcvK03xbrISfaDlqCXx5SEoBo3hfHtu5QLYXPfcCnte/fKJbww33YvI+jUHyVzOwnZEqcLIj+61GMeVSzflP5uGx5Z1powqLT8GYbFL34v9c9npFXDwoTlnAY52z3c9/a5sopfdfcAjySVRjML8mef37gXRgklyGygQce0bff8LNhdz94J23J/wP3kh30ROBBVNDgGB2DjousnlZNyNv4o7OFZ68ylKweLhQ5dDFcaVItbaGJP6DnC/b5odPNuWjoiZ81HHKNZT6kWSeml4Xezk0gzDC9HRjgLDDIkohTs2Ph5Ib0nlDSxtwgues9ZOR27sw1KqXubJVpAFhFOTV55Gb6d/XOSajKcJPLT/OPp8J/EWaJU55ik4BY+28mc+pHhp8Eq/tNVTtM1sVCpi8G4BWY6Z5GnpVPeH6MsnpubR9L7C7p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XsgDbMIkftEZ8P+l+IzJZ71n3bmPtDzXsL5kgnveTOUiBNKWek75Af1XmNN?=
 =?us-ascii?Q?/mPNpwpG4Oy9+rvXWj5CsN6X0jIQgZm2YcWrlWCa0bvvVLxPpULpJgKzz04M?=
 =?us-ascii?Q?jVxXcsgoFMStCp6OrcOnMd5ryO7wkC+X/6NWxwyPnHe5zRpqzcO+SxGyMypf?=
 =?us-ascii?Q?c1WayMcJxgxj+lm1yhzHCUMCmVVmquzIsRAWU5jZruSUwVIqyjUiNe/U1EO5?=
 =?us-ascii?Q?VNf/FMvU8omcpGjvfvqUmHRi4kV8oyTRykLfXXPAY1RWf95+tbdMZPGoSXdh?=
 =?us-ascii?Q?WtsVx0E3pDjjqclDvbsIzjvKw5Xad3kEj0RgD1rtB/RlYv4qDhPwD+r7qSWj?=
 =?us-ascii?Q?3d2vBWBsK3q+y0ww8MH78kwEfLyN4MC6A4i1oAZc3pMekQjpTaDGV5BR7FlZ?=
 =?us-ascii?Q?N/4NLwn+B/Y7zxd1BvgpfR7YV+XtKnXJ/Dt0LQOoAXpHSUWdg81B8aUGqLSc?=
 =?us-ascii?Q?SKGrIxV04ZFL1zHDNkfMDMLUdl/+T0LeOzChtCHsHh5u5Psdv2IPCYaCmNUa?=
 =?us-ascii?Q?WnT3wH11JFX/XCuGua7TXVExxgm8GdQELWjW2BEfCHdrXKVDIuwQOQC6s5jc?=
 =?us-ascii?Q?nJaMZr9I4OP4XSquie0wPdIcNDHHi3siOWB+haxyBGQ4op8uzX7h+U7bGapX?=
 =?us-ascii?Q?pAstoUiz+UwlopWCR95f7L+gxgd7pqD8wCS84gyOYd3rgXbrt/1e7H4EOqov?=
 =?us-ascii?Q?HsYHSG+It+vxMJXgfaOoWGR1kK648yWm/wXCEzUnWf4vAQxNWJ37mux1i40c?=
 =?us-ascii?Q?G0S32z5RrCn2H3Vp4Ljmbl2T+jOBKJrKkHzf4YHnV/mrfkckt+TBJSm0oNWk?=
 =?us-ascii?Q?xCc1l0+A8IC4kVmtVqe/LRlNaxDCanVKjaIlE2fitgwvhH828TjGI2/Q2rW4?=
 =?us-ascii?Q?VGplQIVQdkjvsSskfo5QyufNC1SGl8z3IoSmzoWwACo8QJ7q/wNHVp82OGuM?=
 =?us-ascii?Q?TUD3T6O3ZTdnpDoHbSaL5Q1ucPp3gymYFKHOJMEA9OnA9yirECFNla0zHEs5?=
 =?us-ascii?Q?n+8n2g8X0/ZMkYN+Ivi33fN1IomWzGiiUNYSrHu0yAiBWUNeSEmspGondwiL?=
 =?us-ascii?Q?PdwB5dHvV2wmrhP3WzSRWHHoz91vojtd1P+pqBuiJtJ9ZX2gUP3zI36Rf3MH?=
 =?us-ascii?Q?h5/d95bD6kkufBUKNOtqJtM7AdFVP+2pMrxiHfoPys3EdHD24XCXRFNR1VQs?=
 =?us-ascii?Q?Q8wZzQZz+84KnRdqxu6Sd+wh3+foRO4eYq218q5YH34F94XwIp33K4t6x/oA?=
 =?us-ascii?Q?GB7KxI0oEwHHhZ2K2Y5FjwrnVGrvL35lxhlF98R8XKK5fNmUdB0uE90m9+oW?=
 =?us-ascii?Q?zS0g4QXGeL1ClBE4+le985Q5yE6wDZq/j+fgQ52MtH6TgcV6QIOOQMtuSkym?=
 =?us-ascii?Q?wbH3fpjdVdmgjVIyzAc5RdYe/24eBBOBX/CTHkBfs3zXnsj3DmNtGKKXjo6G?=
 =?us-ascii?Q?cgakHDbrQMZi+87aV20RNpBadLec1aPPU7HZw36sf3SLBrUDBUXu3xKhwkwd?=
 =?us-ascii?Q?nqRyTajbyH/K6JrzPYsJV0T8Jlxcep9KugWOtjKR3AEd8r3LdMmifTu+Rgxi?=
 =?us-ascii?Q?0naPQFA6iimerP4mQ11K4sE1Kgbjxo/jsdpaZpJPXskPlUK3NvQ5nggWVB79?=
 =?us-ascii?Q?hO0bKqpsXNmE7Dmur5Iagp1GMmnFk2rmfVpWoIVwd6KgK6vxinfiqw8UQg9A?=
 =?us-ascii?Q?KcrDBUHiK/ZxU2RHJWLH2/soE/JA+WQLuZT/KLSRmLrZuhKF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c32f3b9-35d2-4c90-b82e-08df4024a96b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 18:50:31.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilBwrFiuRtmzObXv0uACuKYow2t12J8FndqAWDKi7Yp73c3sNhhHpyV1roZq7OzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB610447

On 11 Nov 2026, at 6:38, Usama Arif wrote:

> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without looking
> at the other subpages. A poisoned subpage that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
>
> Skip batching for such a folio and let each page take its own fault,
> where the existing check catches it.
>
> Scan the subpages rather than testing the folio-level PG_has_hwpoisoned:
> memory_failure() sets PageHWPoison() on the subpage first and only sets
> the folio flag much later, and the bail-outs in between - for example
> get_hwpoison_page() losing a page lifecycle race - return with the
> subpage marked and the folio flag never set.
>
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/internal.h | 15 +++++++++++++++
>  mm/memory.c   |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index cd3675c044e0a..e61c02f4019b0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -28,6 +28,21 @@ struct folio_batch;
>  int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>
> +/*
> + * Check every page of the folio for HWPoison, rather than relying on the
> + * folio-level PG_has_hwpoisoned, which memory_failure() can leave clear.
> + */
> +static inline bool folio_has_any_hwpoisoned_page(const struct folio *folio)
> +{
> +	long nr = folio_nr_pages(folio);
> +	long i;
> +
> +	for (i = 0; i < nr; i++)
> +		if (PageHWPoison(folio_page(folio, i)))
> +			return true;
> +	return false;
> +}

It looks almost the same as page_range_has_hwpoisoned() in mm/huge_memory.c.
Maybe change the function to call page_range_has_hwpoisoned() instead.

> +
>  /* mm/workingset.c */
>  bool workingset_test_recent(void *shadow, bool file, bool *workingset,
>  			    bool flush);
> diff --git a/mm/memory.c b/mm/memory.c
> index d477a4f986bc8..4b7d456332200 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5158,6 +5158,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>  			goto check_folio;
>
> +		/* Let a poisoned subpage take its own fault. */
> +		if (folio_has_any_hwpoisoned_page(folio))
> +			goto check_folio;
> +
>  		page_idx = idx;
>  		address = folio_start;
>  		ptep = folio_ptep;
> -- 
> 2.53.0-Meta


Best Regards,
Yan, Zi
