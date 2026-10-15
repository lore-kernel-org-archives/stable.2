Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022088.outbound.protection.outlook.com [52.101.82.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1A3CA4B9;
	Thu, 15 Oct 2026 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075581; cv=fail; b=bjjF+aHC9Q06xMNk/LoXPk+5K2O9ixrRjRkVe2gu085lgaO5YlIGLB7BcQdet3NMBedJ4DU2Ne17OMkx9FRDFVHgnwJtw+u1umG5rhUe+5umcODv7CRHT1KpJ84zg3uz3CMy+pb09c49cypbqVn42uzZeU2J+LpDDkgCbD9286g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075581; c=relaxed/simple;
	bh=VhzkggN50sEY60Q77XzZ+yoLP7iBt4pmpRCB4Xim/iQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rPjfI4AYtx09fxW47ieqnX+Njfojx24tQ1JK+KDWKYpaAL/LQAS0wpCeSW7LnbXXr7xhUzNOzKZpdwuM9EtQj5fzEA+UHxwv69NvbGZ74S87oiAY+CD1nHveclzvErGDJm/lbPkfC47KE6yXOlWBj8oa8FZM8xsSyC7X0x27Fuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=T4iGG9F2; arc=fail smtp.client-ip=52.101.82.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="T4iGG9F2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSlHpM+0mNs2Ab5Ldy2s7B0Eu/GuF+85Eu3yeZJw/Hv6Z4pfEL27aTNs+9repQ+MFbwXab0PhYkYdCj0NwVOqUhif2EYxH3sL4PA1e50bmn69vX3bjDJNwMF6kdv90fbfWHhY4vw5WiB12cqpirirdslo+FUlciWkBb8mhZRyi15M37ifY2jmwhzMLxEiWwF+aQeg7txKQlJNxmPTfgza8jdtXKpOkNFD3qNPEls1RHq+kP3CsLHw1+m5YQAWqxcUroIxp+dS8Van1ljr/KNBedzUst3cI1lfxg80cAy07wZ4RAvRgvblid+gERsptByx3/pz2pRlmVxEDvxCR/Qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHPCH9con3JlISppVqJT2qapW7Am0X8wW4Im+ECd1cs=;
 b=DsVfYcKiv7X1ioBhZU2gTu6AB5HaY+NGBXmLT0F5dUfiKbEF54mA0SKZ3dEHk6r+z4fFUMlG32LkTqK9pOKmXsWFSaAu/KSzYkUJZx+lnHRr9JRDb8JrpzY5hEQArdV1Wk70NpHvL8/ihMsEyH9eH8z2JzOHdiw3lWi+JO+LeFxR1GwHdaUYBGHatBNnnnYU87EJwm5Do5p7ilIg2oD06B7+aD4lDWRUiZQ02tm16x183RvC5V/18uSh7Qjg13MH95MlcqNJVna5QB4PLE8pD6eAGAJ6hlfcQxv7njJyVLMPADc9CpN+T8F0b7H+YJDdxBvFJ8BlOMRzqSTKv2zJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHPCH9con3JlISppVqJT2qapW7Am0X8wW4Im+ECd1cs=;
 b=T4iGG9F2GWdG9LqyUM839lR59d7X1kLqOVS50GSPFpUWP01PNB1P2bZLH/CJCv0YYBQ49oplWJVkNUVd8aU8A3l9rC+8HHdypC6HcNjaEnCWdWRoY4RxWfTBrTqjkwbIkTk86An4D/Z4xE+6XzLFKlq85Faz70tPbjPhKO2buEU23Gvb2c3vk3XcX673iWrRCBLyt+tf8sqfSAmlPPPDvz6TjZwHzhdD8G3PYKVCnIK8V5BShoymYek4WpYAsDiBMVOZk1TkJ86VLNxnKwktkrMZhAOzMmF7kfPGFeIeQLOAxikaiYOVo/fs5DVY8wXe8kvCKCGQ2Xi8iK9zfa86eg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV3P280MB0402.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:46:13 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 15 Oct 2026
 14:46:13 +0000
Message-ID: <61ab29d3-929f-49de-bb64-5a49318ede00@gaisler.com>
Date: Thu, 15 Oct 2026 16:46:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sparc64: flush only the aliased page, not its
 whole folio
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org
References: <20260928132102.1707-1-kaloz@kernel.org>
 <20260928132102.1707-2-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260928132102.1707-2-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0008.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:30::9) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV3P280MB0402:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bd6355-af38-4de0-579e-08df2acb0f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uhxPIUbkyur4DIly43A+A3rvNVarG7wvB5BDACB9+UzhUqwtgIs9hkEVShAsKwK5nSgPeesErdvzF+/7h6vOVqY9lmp06ajWQqNJm67hUPYK145wDJPYpdx7+PLRGTCtvoW7tRgwCg8/cLOPtBe7rvW5AaNMiS0FCilQGBwMOj/pMDqHA7v2c4qW6Ibeo758jPZ1lEqOVFLY6M0DANYilaOKP+/R9MNirkHvLSjRaLnXmgliy2rSJ7Au5OZH/19TkliD/+Z85Ov9R9gAxB10xbOf7HaL/oDyFbxX3MmUnoOcJfEz8cd5v0rIjG7cBJqSWOqXkNh2gOGOmh+rF3JSWJN3/vCqpIuYR2q1edX5YIIfUQP7JBN1JG1wRcbP3F5CeOYDs/dUZX1ybBcsmbFtjFVOGzMWJsf8Rn1dqEmpCrGmD01h+833YzOvIrQiMxtAAL6fra1GpTHm7MzI8XzL+ebKA7IJdlFnBsYaCgvSwoTte0+bvPcdxzyBca4Vp764d36y6NLg/Jn59Od+x+oSrvuokdtykppyhyGCyBoUAEbvHZd0cK9yR3xLInwrimMgxybvZdIYNVTjcK+q/8lX2Q3rlCrEgnTriWa0SoSXM6C8VrmlslQD9rBbSxs1M+LJ8Kn1dNiomvF01yz23L27v46X1P7/aGtkGy+oe2eVZBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2g2T0dBY2xSaDRZb0NQUEtkbGNSblFBUzB4UUU4azdweUZkcE9jbWROUE5s?=
 =?utf-8?B?RG1RZEJsK2tGQUU3eEJ3REc0SGQyczAvVWlDS0xsT3F4djVCaFZld0lsVVcx?=
 =?utf-8?B?YmtObUdVbGtrbWIwcEV0aTdzVC9QMkRDSjFzWk9Wc1pYdkQxa2JmcUFTVmJq?=
 =?utf-8?B?QTJidVRNbG1FaEVQNVI2eldMTlhaNitSUGhiODNtZjhHUE8rZ0xRUzVnZytw?=
 =?utf-8?B?azhhRmd2N0I1N3hxdjRaYmE3cnE3bkVGTk00TWk0cUwwbm1tby9GSlJJcTI4?=
 =?utf-8?B?TTM0WGpwckRKdklUWVI0SXk4MEI5bGpxZmJ0UWtNdzZRRnlVbkxnUnBBTE4z?=
 =?utf-8?B?czBzSjF6YlFoVFdFRlZaZkx1ZmdiM0R1NnE5a0RJRXJib0NRWGlPNE5ic244?=
 =?utf-8?B?ZGg3QXhjcWdSKzUweXFqVjNRMEYvWkZvYlRocXBkNy9GbmpRZlZFelBpZnJW?=
 =?utf-8?B?UGpCYU5CcGtnKyswNjdvMkFXamFSZ04rNVFNNzdRb1FMMVFjYzV5TWRTN2R6?=
 =?utf-8?B?ekdSdlBDQXdiTkRiWHRHekhvTWFCMDhlTGl0NWkzUDl3ZlN1TnRLenJteXJy?=
 =?utf-8?B?SW9pTW8zUVhlYU5uVTg2dEI0Y08wc3JjMDlha3lwbTY4ays1WHJPRStlZGNH?=
 =?utf-8?B?YzdDaTQrWFVNRVlOQmhqK1FPM2JpTmlTdnlITDBtMkxUTE54TFdiTEd6OEdh?=
 =?utf-8?B?ZThJcENLalRBMHFoRVJJMXdjc3NJYVBTUmNhSUU3cndHOUd3ODB3VTc3ZlhP?=
 =?utf-8?B?QTJZOUZZNW9HSkhIaHduSUpLRW9QT3pMWUV3WDIrMU00VitXZFRvaVozWGdw?=
 =?utf-8?B?cXA2TjJpbFVTUUE4VzNuNitMekQyQUc0cVpST0MwdTY1R0dmMTdhVEowK2Yz?=
 =?utf-8?B?RktGODJENzFtNEwyY21aOE9tK0lCa2RZMGJHd1RHa2VnSXVwNlBhRkZ1Yy9W?=
 =?utf-8?B?YzdVaGMzNkVwLzkzMk9MNytxRng1aEZ3THgvOG82WUY0MGQ5MTJYOUt5SHdE?=
 =?utf-8?B?U2xsdjVFNzdnU0E4N1NwaUx1eUNsemFnbWc2OUUzOFFtMW81QkVpM3d5bjhr?=
 =?utf-8?B?U0xIVjZRcG84UHJQVmdSYUt5bG9VTnFHTkVqZk43K3FRZldqRmpjcjhHemx6?=
 =?utf-8?B?amI3RDBEUWpNZVdsMkVob2RRNVJhYk93WTZyQXcrczVJN3huU0JjRitpS2pl?=
 =?utf-8?B?aVJESlhTaGJhN1NlOHBRaDIwNUIwdFdlYWtEeVlYUkVNbGpuMFl2ek5jR2di?=
 =?utf-8?B?S0R1SHhVUFp1dHRNZ3FWZkFwRmsreEpJYlZIUFh5YWxwS3YwL3o5S2QxSDN4?=
 =?utf-8?B?ZFltRTFzdU1TUUpFNlJNZkJHdmhSSCtxWlJVV0Z1UmdpV2hHYlA3QkptUkMr?=
 =?utf-8?B?Ykt1TnNUSlBtNktlNDFvck9kNEcvVUFRZGhwbFVwd3F5UmtXeDQycWpDNldk?=
 =?utf-8?B?MzBnWjVCemFmSTFUMTRmdVZBTGhTWldPWk1YaDhBbitKYTFFMkc1cERwU1BW?=
 =?utf-8?B?QmoySFdLdms2clI2YThxdkVsb3JRTnpLNmtoVmx6Qi91QUxkc2Uxb1c3WXNi?=
 =?utf-8?B?d3lJYitEdTZXYU45TEx2RUx4ckh2Y3pFVWpGUnNUQW5FclJzZXhPbFF1RStC?=
 =?utf-8?B?MXo4QVlUUUtmTDZrdURUdEllQy9wVmEzc3RXeGFWc2o1dVFFUWVBUHFSODdP?=
 =?utf-8?B?TDlYZkhzaHJMNFltRVhDeVREUzVNd1VCdXdYVzhFbkVPV2Fyall5SXlvdEt4?=
 =?utf-8?B?Z29zbWZOdERJazJKMjdaUHhodnF1cFZDNStkV203Z0sxNTN5cE1GRHRVQWN3?=
 =?utf-8?B?YklmNFdob1FFWTJGSi92cUZmOXVDNVlFVXZwRjN3anpraUVTMXhVVzFyYkZO?=
 =?utf-8?B?L2ZJZ3YwaWhzZi9UMWRMRHlEM3pzUnd5REgzR3dOaWtERC9xS2xoV3hnQjlJ?=
 =?utf-8?B?TkVDWTVKN1hVTm5vT3RudFRXaFk3WElCdkVZL2tMenJOL0luZ2E1TlcwTUNx?=
 =?utf-8?B?b09yOWRUWjhZRmVMQ3A1VjQyT0hDdW9OQ0EyUHcxemRDOWM5bUtGN3Z2TDJS?=
 =?utf-8?B?YzZ3NGpPYzVuQjNkMzR4ZExMUnNsZEZKZXRmMkdHSFg0a0RSYnNMTmV2WXp1?=
 =?utf-8?B?dkgzY0hrNk1yb0pGTDVlSDdFREJZdjlSRjNXb2IyUWdJcXoxSCtlQjUxWHEr?=
 =?utf-8?B?Mjd4K1NJQ2VSaFdrVVBwVFJqSEd4RmMvdnB4WlVYSHNzcWd5eXlzWkRIUTh6?=
 =?utf-8?B?eWcwWjkwTkdFaldyMWpQbEQzOWo1QjlIb3JGUjBFcjNKd3ltb3QraHhyS3BQ?=
 =?utf-8?B?RHlvelJTUm1HNWRIMWd2UkMwanlJblBuYStwcUczZ1FQVHZBM1doZDRZeXJx?=
 =?utf-8?Q?2hhoU4j1FepiA5wI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd6355-af38-4de0-579e-08df2acb0f27
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:46:13.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VInNPNVLr/bESJiP7U7al2EGl019UHrAtNoymfae+UhrHd7WurBIRdbK4XyrcR4rj0DGBQhjhnEpA+Gzo/OK2MlD34/033nXxtsg7d96pH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0402

Hi Imre,

On 2026-09-28 15:21, Imre Kaloz wrote:
> Since the conversion to folios, move_pte() and tlb_batch_add() flush the
> D-cache of every page in the folio a single PTE maps.  Both run once per
> PTE, so moving or unmapping a range backed by a large folio flushes each
> of its pages once for every PTE of that folio, and each page flush is a
> cross-call to all other online CPUs.

It would be good if the description of what the patch does uses present
tense, but past tense for what was wrong before the patch, or was
otherwise reworded to make it clear.

The cross-call overhead is not true for all sparc64 machines and only
for SMP configurations.


> Only the page the PTE maps can hold lines at the old colour, so flush
> just that page, as before the conversion.  flush_dcache_folio_all() has
> no other users and becomes flush_dcache_page_all() again.

This could perhaps be a bit misleading, as multiple PTEs in the range
handled by the caller can hold the old colour, could it not? Rather it
is the traversing of the whole range one by one in the caller that does
the trick. What do you aim to add to the previous description with this
paragraph?


> On SMP QEMU guests, apt rebuilding its caches through mremap() triggers
> RCU stalls and soft lockups in move_pte().

Past tense or rewording here as well as this patch fixes this.

> 
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/include/asm/cacheflush_64.h |  3 +--
>  arch/sparc/include/asm/pgtable_64.h    |  7 +++++--
>  arch/sparc/kernel/smp_64.c             | 24 +++++++++++++-----------
>  arch/sparc/mm/init_64.c                | 22 ++++++++++++++++++++++
>  arch/sparc/mm/tlb.c                    |  2 +-
>  5 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
> index 06092572c045..02c969417e7b 100644
> --- a/arch/sparc/include/asm/cacheflush_64.h
> +++ b/arch/sparc/include/asm/cacheflush_64.h
> @@ -38,11 +38,10 @@ void __flush_dcache_page(void *addr, int flush_icache);
>  void flush_dcache_folio_impl(struct folio *folio);
>  #ifdef CONFIG_SMP
>  void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
> -void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
>  #else
>  #define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
> -#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
>  #endif
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
>  
>  void __flush_dcache_range(unsigned long start, unsigned long end);
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 0837ebbc5dce..6712eac4baf1 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -946,6 +946,9 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>  
>  #ifdef DCACHE_ALIASING_POSSIBLE
> +/* Without pte_batch_hint(), move_ptes() calls this once per PTE, so
> + * only the page this PTE maps can have lines at the old colour.
> + */

I'm not ecstatic about implementing a function that in the general API
can be called for multiple ptes, even though this never happens on
sparc64 as things stands right now. The code paths that saves us, from
commit 0b5be138ce00 ("mm/mremap: avoid expensive folio lookup on mremap
folio pte batch"), was "only" added as a performance regression fix.

Perhaps the best logical solution would be if move_pte() got an added nr
argument just as get_and_clear_ptes() has.

Barring that, the comment should not describe why the change is ok, but
rather descrive the code as it stands after this patch, that it depends
on only being called for single pte's, and that this is accomplished by
using the default pte_batch_hint().

I would prefer the nr argument though, but that would go outside
arch/sparc. Comments from mm people on this would be great.

>  #define __HAVE_ARCH_MOVE_PTE
>  #define move_pte(pte, old_addr, new_addr)				\
>  ({									\
> @@ -955,8 +958,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  									\
>  		if (pfn_valid(this_pfn) &&				\
>  		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
> -			flush_dcache_folio_all(current->mm,		\
> -				page_folio(pfn_to_page(this_pfn)));	\
> +			flush_dcache_page_all(current->mm,		\
> +					      pfn_to_page(this_pfn));	\
>  	}								\
>  	newpte;								\
>  })
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 371460e34484..18b6145da591 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -982,8 +982,9 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
>  	put_cpu();
>  }
>  
> -void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
>  	void *pg_addr;
>  	u64 data0;
>  
> @@ -996,7 +997,7 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>  	atomic_inc(&dcpage_flushes);
>  #endif
>  	data0 = 0;
> -	pg_addr = folio_address(folio);
> +	pg_addr = page_address(page);
>  	if (tlb_type == spitfire) {
>  		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
>  		if (folio_flush_mapping(folio) != NULL)
> @@ -1007,18 +1008,19 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>  #endif
>  	}
>  	if (data0) {
> -		unsigned int i, nr = folio_nr_pages(folio);
> -
> -		for (i = 0; i < nr; i++) {
> -			xcall_deliver(data0, __pa(pg_addr),
> -				      (u64) pg_addr, cpu_online_mask);
> +		xcall_deliver(data0, __pa(pg_addr),
> +			      (u64)pg_addr, cpu_online_mask);
>  #ifdef CONFIG_DEBUG_DCFLUSH
> -			atomic_inc(&dcpage_flushes_xcall);
> +		atomic_inc(&dcpage_flushes_xcall);
>  #endif
> -			pg_addr += PAGE_SIZE;
> -		}
>  	}
> -	__local_flush_dcache_folio(folio);
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	__flush_dcache_page(pg_addr,
> +			    tlb_type == spitfire && folio_flush_mapping(folio));
> +#else
> +	if (tlb_type == spitfire && folio_flush_mapping(folio))
> +		__flush_icache_page(__pa(pg_addr));
> +#endif
>  
>  	preempt_enable();
>  }
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 103db4683b16..8792e5d92517 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -214,6 +214,28 @@ inline void flush_dcache_folio_impl(struct folio *folio)
>  #endif
>  }
>  
> +#ifndef CONFIG_SMP
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	if (tlb_type == hypervisor)
> +		return;
> +
> +#ifdef CONFIG_DEBUG_DCFLUSH
> +	atomic_inc(&dcpage_flushes);
> +#endif
> +
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	__flush_dcache_page(page_address(page),
> +			    tlb_type == spitfire && folio_flush_mapping(folio));
> +#else
> +	if (tlb_type == spitfire && folio_flush_mapping(folio))
> +		__flush_icache_page(page_to_phys(page));
> +#endif
> +}
> +#endif
> +
>  #define PG_dcache_dirty		PG_arch_1
>  #define PG_dcache_cpu_shift	32UL
>  #define PG_dcache_cpu_mask	\
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 6d9dd5eb1328..1221814ca0e1 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -144,7 +144,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
>  
>  		paddr = (unsigned long) page_address(page);
>  		if ((paddr ^ vaddr) & (1 << 13))
> -			flush_dcache_folio_all(mm, folio);
> +			flush_dcache_page_all(mm, page);
>  	}
>  
>  no_cache_flush:

Thanks,
Andreas

