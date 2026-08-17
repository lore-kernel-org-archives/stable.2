Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AA41DDE5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972362; cv=none; b=KdmBOmZkY6aWyGLldWhAMi05KXC7wgbF1yQHeJt9PSN7AWMFALn3zXHtv+hF0FO7RBgRDu/B0dKlZ5UxJMDqBRCiBVcp3HSuLLvg4DpGXs+oo7SAcBy5+D0JQfgQG9EYGjH6OLv0CEizG6W7DRRVA5vbCdSXrUVCWJLSHbrcink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972362; c=relaxed/simple;
	bh=C1yG6OkeWNS4WGgqw4PPxXcfGHqZYq6ERMkmKT0etD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuAGEBqurHNkh4LZfyiMfcGU0esvMrlu0zraVdsqB1nSg+vdpcBs1hwxzugoMDsiXpFXdI6fB2781xqMYaVxjd0k37YzYOkiS53rEwx4jQAV9aAgFRDKtsFWYhTWsde4PI+Qp8YdcclRNlNMzK8ZifmaxgmpepnLk5QcEeWWGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEwupt8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEwupt8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484081F00A3E;
	Mon, 17 Aug 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786972360;
	bh=JM2CQPW8Lspl1MZHnnnIptLq/+u+SzFEoezwmq0GwUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEwupt8Y7e4IK9O44HT/RuDRX2ePGXW0HB3/91IeGrAPJxGwuAIEhTo/ATlQ+k98V
	 GZgZTL0QQT3Gg2Pgd2lQMhAf0bwI7rCbDzueWv/EOsiHKNL4FlnOrDKltqnG4YuCV1
	 KH2sPv4h44yvmeFR38eYfSbiYslNkABhZYwZQQ+53zThuqvIWspfsIEB0h8iEVjeBe
	 7HBsoObO9YXSugFCI2oIAquWjqbHwA08QnUr0rGtBnJLFaIfYcqRIHrZmE5C7Agd+Z
	 63gQjArs9tnPqpc0ykm84/kSHSZ4ZSNgWJuzqy6dIx3cG8MdzPNRJqZksvnLz/gR9W
	 cd4EHbUgSll8A==
Date: Mon, 17 Aug 2026 14:12:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com, hare@suse.de, 
	hughd@google.com, kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	npache@redhat.com, p.raghav@samsung.com, ryan.roberts@arm.com, shy828301@gmail.com, 
	stable@vger.kernel.org, uqbarz@gmail.com, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/huge_memory: separate out" failed to
 apply to 5.10-stable tree
Message-ID: <aoMHsUr2PuKVixmi@lucifer>
References: <2026081737-unleveled-prologue-7681@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081737-unleveled-prologue-7681@gregkh>

On Mon, Aug 17, 2026 at 02:40:37PM +0200, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hi Greg,

Sorry about this this patch was mis-tagged and shouldn't be backported to any of
the kernel releases (it's not harmful, but there's no need to resolve conflicts
in any case).

It's a pure cleanup so is only necessary for tip.

Cheers, Lorenzo

>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 98bd3af0bb6bfdb0fb39cbfa05456acb374b691e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081737-unleveled-prologue-7681@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 98bd3af0bb6bfdb0fb39cbfa05456acb374b691e Mon Sep 17 00:00:00 2001
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Date: Thu, 30 Jul 2026 11:55:48 +0100
> Subject: [PATCH] mm/huge_memory: separate out
>  CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic
>
> Rather than mixing the refcounted and non-refcounted
> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic, separate the two out cleanly so
> it is clear what happens when this configuration option is set and what
> happens when it is not.
>
> Introduce HUGE_ZERO_UNSET_PFN to abstract the ~0UL assignment, only
> introduce the refcount, lock and shrinker if
> !CONFIG_PERSISTENT_HUGE_ZERO_FOLIO, abstract initialisation and teardown,
> abstract the huge zero folio allocation from refcounting.
>
> Also change a BUG_ON() to WARN_ON_ONCE() while we're at it.
>
> No functional change intended.
>
> Link: https://lore.kernel.org/20260730-fix-refcounted-huge-zero-v2-2-c5d8a41b317f@kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Fixes: 3b77e8c8cde5 ("mm/thp: make is_huge_zero_pmd() safe and quicker")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Hengbin Zhang <uqbarz@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kiryl Shutsemau <kas@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Pankaj Raghav <p.raghav@samsung.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f43852ef9944..f84fe7913d88 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -78,10 +78,15 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  					 struct shrink_control *sc);
>  static bool split_underused_thp = true;
>
> +#define HUGE_ZERO_UNSET_PFN (~0UL)
> +struct folio *huge_zero_folio __read_mostly;
> +unsigned long huge_zero_pfn __read_mostly = HUGE_ZERO_UNSET_PFN;
> +#ifndef CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
>  static atomic_t huge_zero_refcount;
>  static DEFINE_SPINLOCK(huge_zero_lock);
> -struct folio *huge_zero_folio __read_mostly;
> -unsigned long huge_zero_pfn __read_mostly = ~0UL;
> +static struct shrinker *huge_zero_folio_shrinker;
> +#endif
> +
>  unsigned long huge_anon_orders_always __read_mostly;
>  unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
> @@ -223,6 +228,47 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return orders;
>  }
>
> +static struct folio *alloc_huge_zero_folio(void)
> +{
> +	struct folio *zero_folio;
> +
> +	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
> +				 ~__GFP_MOVABLE,
> +			HPAGE_PMD_ORDER);
> +	if (!zero_folio) {
> +		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
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
> +	} else {
> +		huge_zero_pfn = folio_pfn(huge_zero_folio);
> +		count_vm_event(THP_ZERO_PAGE_ALLOC);
> +	}
> +	return 0;
> +}
> +
> +static void __init huge_zero_shrinker_exit(void)
> +{
> +}
> +
> +struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
> +{
> +	return huge_zero_folio;
> +}
> +
> +void mm_put_huge_zero_folio(struct mm_struct *mm)
> +{
> +}
> +#else
>  static bool get_huge_zero_folio(void)
>  {
>  	struct folio *zero_folio;
> @@ -231,15 +277,9 @@ static bool get_huge_zero_folio(void)
>  	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
>  		return true;
>
> -	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO | __GFP_ZEROTAGS) &
> -				 ~__GFP_MOVABLE,
> -			HPAGE_PMD_ORDER);
> -	if (!zero_folio) {
> -		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
> +	zero_folio = alloc_huge_zero_folio();
> +	if (unlikely(!zero_folio))
>  		return false;
> -	}
> -	/* Ensure zero folio won't have large_rmappable flag set. */
> -	folio_clear_large_rmappable(zero_folio);
>
>  	/* Paired with critical section in shrink_huge_zero_folio_scan(). */
>  	spin_lock(&huge_zero_lock);
> @@ -266,33 +306,7 @@ static void put_huge_zero_folio(void)
>  	 * Counter should never go to zero here. Only shrinker can put
>  	 * last reference.
>  	 */
> -	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
> -}
> -
> -struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
> -{
> -	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
> -		return huge_zero_folio;
> -
> -	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
> -		return READ_ONCE(huge_zero_folio);
> -
> -	if (!get_huge_zero_folio())
> -		return NULL;
> -
> -	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
> -		put_huge_zero_folio();
> -
> -	return READ_ONCE(huge_zero_folio);
> -}
> -
> -void mm_put_huge_zero_folio(struct mm_struct *mm)
> -{
> -	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO))
> -		return;
> -
> -	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
> -		put_huge_zero_folio();
> +	WARN_ON_ONCE(atomic_dec_and_test(&huge_zero_refcount));
>  }
>
>  static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
> @@ -316,14 +330,53 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
>  		zero_folio = huge_zero_folio;
>  		VM_WARN_ON_ONCE(!zero_folio);
>  		WRITE_ONCE(huge_zero_folio, NULL);
> -		WRITE_ONCE(huge_zero_pfn, ~0UL);
> +		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
>  	}
>
>  	folio_put(zero_folio);
>  	return HPAGE_PMD_NR;
>  }
>
> -static struct shrinker *huge_zero_folio_shrinker;
> +static int __init huge_zero_init(void)
> +{
> +	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_folio_shrinker) {
> +		shrinker_free(deferred_split_shrinker);
> +		list_lru_destroy(&deferred_split_lru);
> +		return -ENOMEM;
> +	}
> +
> +	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
> +	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
> +	shrinker_register(huge_zero_folio_shrinker);
> +	return 0;
> +}
> +
> +static void __init huge_zero_shrinker_exit(void)
> +{
> +	shrinker_free(huge_zero_folio_shrinker);
> +}
> +
> +struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
> +{
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
> +		return READ_ONCE(huge_zero_folio);
> +
> +	if (!get_huge_zero_folio())
> +		return NULL;
> +
> +	if (mm_flags_test_and_set(MMF_HUGE_ZERO_FOLIO, mm))
> +		put_huge_zero_folio();
> +
> +	return READ_ONCE(huge_zero_folio);
> +}
> +
> +void mm_put_huge_zero_folio(struct mm_struct *mm)
> +{
> +	if (mm_flags_test(MMF_HUGE_ZERO_FOLIO, mm))
> +		put_huge_zero_folio();
> +}
> +#endif /* CONFIG_PERSISTENT_HUGE_ZERO_FOLIO */
>
>  #ifdef CONFIG_SYSFS
>  static ssize_t enabled_show(struct kobject *kobj,
> @@ -987,39 +1040,14 @@ static int __init thp_shrinker_init(void)
>  	deferred_split_shrinker->scan_objects = deferred_split_scan;
>  	shrinker_register(deferred_split_shrinker);
>
> -	if (IS_ENABLED(CONFIG_PERSISTENT_HUGE_ZERO_FOLIO)) {
> -		/*
> -		 * Bump the reference of the huge_zero_folio and do not
> -		 * initialize the shrinker.
> -		 *
> -		 * huge_zero_folio will always be NULL on failure. We assume
> -		 * that get_huge_zero_folio() will most likely not fail as
> -		 * thp_shrinker_init() is invoked early on during boot.
> -		 */
> -		if (!get_huge_zero_folio())
> -			pr_warn("Allocating persistent huge zero folio failed\n");
> -		return 0;
> -	}
> -
> -	huge_zero_folio_shrinker = shrinker_alloc(0, "thp-zero");
> -	if (!huge_zero_folio_shrinker) {
> -		shrinker_free(deferred_split_shrinker);
> -		list_lru_destroy(&deferred_split_lru);
> -		return -ENOMEM;
> -	}
> -
> -	huge_zero_folio_shrinker->count_objects = shrink_huge_zero_folio_count;
> -	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
> -	shrinker_register(huge_zero_folio_shrinker);
> -
> -	return 0;
> +	return huge_zero_init();
>  }
>
>  static void __init thp_shrinker_exit(void)
>  {
> -	shrinker_free(huge_zero_folio_shrinker);
>  	shrinker_free(deferred_split_shrinker);
>  	list_lru_destroy(&deferred_split_lru);
> +	huge_zero_shrinker_exit();
>  }
>
>  static int __init hugepage_init(void)
>

--
Cheers, Lorenzo
