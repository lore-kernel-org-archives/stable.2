Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F244A71C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251321; cv=none; b=VgS5xGu6CasfneBHQaH+Lsxvj5eeG9SLs1ElSJaBd0AF1Qu42uk/5B2SGFZMoYgHEomQNmUmfQyi8vD3oro0oywPNRC41f/sM6K4k+XxksbOWSjddaWGhSq+ACrO6L+97e9gwN55Kf9mAYlpR6cWgevQh11w3uwcGrYAkiXlk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251321; c=relaxed/simple;
	bh=jtr55/VK0+kw5FVvWYcPAN8umuln4X9OVoEJEOkye9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOsiBlpRWc3bnhir7sTsUfWbcmMAqhjQqxaY16NDOuv3MAPysF0WVbQaizDS61x7iHIFdxKplDwVCeWFbgv12AvUoPT81qdQwXIKkBa33OhxerCdYaLbEnu5bJui9kKroSmstZpBTHW9cvxh/ot4eMdht9W92vyJPCfCCQBGxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoFCWSgF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoFCWSgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB091F000E9;
	Tue, 28 Jul 2026 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251318;
	bh=A01dsvmvPovSklIMIdap8aKveNfjd1QsKAFfuCGTiYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CoFCWSgF/UJWb2ACHZXA1oTMsIpWIaBDrMDL55x6JlrKzIWbknzBPMRRb6dx5QP83
	 DE4/Tr6A7wu/1JNFFrySHEeFC1BF5z01+VtDsZ6urwLclVyy+AamNDn/PWMv9/2Pga
	 eOJFHRO4F6NQy9W/pubFLGGzXzc8lyE6otP2Z9CRbePlxvWwXBhkS8RsRSrPI4haAY
	 7xSqpfIpdl4GuxjSUk/roknkFq7X8sx/9APKOQJ9lbLhFLY+kP2zIVe32n3mRtWx/9
	 pmNjMJo7YZPZcJBcXw1gnraH+e5GEUiwANnwg8i20KaDjoJb+Kt+XV3X07bU9Hu6mp
	 d/WESoZmJjvQQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id BE81DF40071;
	Tue, 28 Jul 2026 11:08:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jul 2026 11:08:36 -0400
X-ME-Sender: <xms:9MVoajoo4BBH3gOnmfRK0FFM92XU3sByOr9w1OG4jEc47WisOA6sSw>
    <xme:9MVoagw_McjUFEZ8T37px6rLf630437EJy_kRgIkKpxYZiagh_1Gho5FVgtE2_gRJ
    NE9-n5RTraNcFj21XyMovDV5f7ICSzTVwykfQuGof_G_q2cuwvRT-ki>
X-ME-Received: <xmr:9MVoatox7SaRaCgUCG4USRsLnP4Z7AmT3lg91hzRYzCjPydsK90XGjG5ixWcLA>
X-ME-Proxy-Cause: dmFkZTGnznuykIxwCjE96rgdIqIrtInVcRhsVSLqoLYVMWqLd1lwbp/cUtW0TdmzMkCMBq
    EMa41Jzs4xu2zV6VfMrl8K2JJIWS9V7FeK+xSsLO966TEJtLBAoFITIyeGIYnCn9YkL4lJ
    pbKQJ8J4qDpvqqcYDkqrt7+/G7tgjikyq+XhUX4Y1YkdPrTHtHFw0gtqXTIBDlTi6nZyr+
    yroaHoGMEoNAwoceceiIS/sDNcQVOx2TXONSHiN894/1IVjiGTYjhWWdtU/AX7KmCqaHsU
    loHlxxPat/68JghIk2kGOTx/0VE/ZyUwKyGNVGRABIH56t975hdWmaF1ZV595ak+GHhSsJ
    vI/CrxU7XiRRjktFA4Dk05g3FGqbW6BOBXYuUk0mRDxmFrr5c/LS+ig8Ehw/lXrASiOAZ3
    ULQvVKRO3VC082jCZR2dYCIdJkR1FBgwT1GQlPL45SXccuCHTEYlZ4WBYqanU5B+MagzUO
    FQUDukLWU1m7bq6kMG96Se2CBlKnbumUSZDukaFlNku9basMD1bDJG6+xL0vLMS5Br2WTV
    V2RvBwwZL9W2u0uQpFiG7KAGf2PlL5NsmQ4BmeB0f+srSBdUpf44aOhxyb+zOTCmJA9NXO
    xAKKMFcLB0HlcJlt7jqSXUK6t9KP9bUC+wzwpu4EmDfV6ungfFy/KBDd0FLQ
X-ME-Proxy: <xmx:9MVoareU4r3DoxnaDeBUFk1rv41cUUwdWW9liZg7hFvVxf_EKBkjjg>
    <xmx:9MVoahjqpnCIXYgQ92a7x95HvYhek4-T660RWgkB0uKIXkZrWmYIhg>
    <xmx:9MVoasIfDonbC770PmvAmmigdmgVMtpXjZDShVBgWHoRlGj5PzLjEQ>
    <xmx:9MVoanmDlVivCUPG3KCGvfFKeG-9WWTN-GRZ0a6ZlvA0Zvdbwee0lw>
    <xmx:9MVoagRG7P0c08ZPRUkGLfYjAtgEyt2h_x0owQry3GAhzv0Te36sanZb>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 11:08:35 -0400 (EDT)
Date: Tue, 28 Jul 2026 16:08:35 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hengbin Zhang <uqbarz@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 1/2] mm/huge_memory: separate out
 CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic
Message-ID: <amjD1MtOiXBRDxVi@thinkstation>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <20260728-fix-refcounted-huge-zero-v1-1-3f261f5447b4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-fix-refcounted-huge-zero-v1-1-3f261f5447b4@kernel.org>

On Tue, Jul 28, 2026 at 01:05:44PM +0100, Lorenzo Stoakes (ARM) wrote:
> Rather than mixing the refcounted and non-refcounted
> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic, separate the two out cleanly
> so it is clear what happens when this configuration option is set and what
> happens when it is not.
> 
> Introduce HUGE_ZERO_UNSET_PFN to abstract the ~0UL assignment, only
> introduce the refcount and shrinker if !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO,
> abstract initialisation and teardown, abstract the huge zero folio
> allocation from refcounting.
> 
> Also change a BUG_ON() to WARN_ON_ONCE() while we're at it.
> 
> Without this change, the subsequent fix for a subtle race is harder to
> understand thus this is a dependency of it.
> 
> Cc: stable@vger.kernel.org # 6.18.x: dependency of subsequent fix
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/huge_memory.c | 159 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 94 insertions(+), 65 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 032702a4637b..0f60bc82e87a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -77,9 +77,14 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  					 struct shrink_control *sc);
>  static bool split_underused_thp = true;
>  
> -static atomic_t huge_zero_refcount;
> +#define HUGE_ZERO_UNSET_PFN (~0UL)
>  struct folio *huge_zero_folio __read_mostly;
> -unsigned long huge_zero_pfn __read_mostly = ~0UL;
> +unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
> +#ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
> +static atomic_t huge_zero_refcount;
> +static struct shrinker *huge_zero_folio_shrinker;
> +#endif
> +
>  unsigned long huge_anon_orders_always __read_mostly;
>  unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
> @@ -221,22 +226,58 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return orders;
>  }
>  
> -static bool get_huge_zero_folio(void)
> +static struct folio *alloc_huge_zero_folio(void)
>  {
>  	struct folio *zero_folio;
> -retry:
> -	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
> -		return true;
>  
>  	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
>  				 ~__GFP_MOVABLE,
>  			HPAGE_PMD_ORDER);
>  	if (!zero_folio) {
>  		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
> -		return false;
> +		return NULL;
> +	}
> +	folio_clear_large_rmappable(zero_folio); /* Explicitly not rmappable. */
> +	return zero_folio;
> +}
> +
> +#ifdef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
> +static int __init huge_zero_init(void)
> +{
> +	huge_zero_folio = alloc_huge_zero_folio();
> +	if (!huge_zero_folio) {
> +		pr_warn("Allocating persistent huge zero folio failed\n");

I am not sure the warn is enough. mm_get_huge_zero_folio() will produce
NULL pointer now without any attempts to allocate again.

Have you considered moving huge_zero_folio to BSS for
CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y?

> @@ -308,7 +323,46 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
>  	return 0;
>  }
>  
> -static struct shrinker *huge_zero_folio_shrinker;
> +static int __init huge_zero_init(void)
> +{
> +	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_folio_shrinker) {
> +		shrinker_free(deferred_split_shrinker);
> +		list_lru_destroy(&deferred_split_lru);

Hm. What? Why does huge_zero_init() touches deferred_*?
That's caller business.

>  static void __init thp_shrinker_exit(void)
>  {
> -	shrinker_free(huge_zero_folio_shrinker);
>  	shrinker_free(deferred_split_shrinker);
>  	list_lru_destroy(&deferred_split_lru);
> +	huge_zero_shrinker_exit();

Any reason behind the reorder?

>  }

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
