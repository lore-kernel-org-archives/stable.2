Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047941A4ED;
	Mon, 27 Jul 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159643; cv=none; b=VFGlSvW6Se6tlkhPmLwGUzgUO1m622ND3IizjahmoMXabXZnLw4EAikMBKYUs3YziV6f1wyA3K2S6ooNIIkYkMsRfzUEB4F7mMGQfbz1sIu5Bhx0/3w0n8UrbtP+T342d/6xk9jSHZQ+JFR84Z48VBBciEQ7Bfn5vkm3SLAOrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159643; c=relaxed/simple;
	bh=DBi4f4szGopYg8KaWLlQPaJXaYdUdYsLfDg6M5racUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig79tJW4y8AftKNejxjBXcCZFONz1vUVP2vgTYxNtcxATgRR5fKH9KeXj1T2eUEdMZqCXcL6rT3gXHGD99ZGarom8FqZ4Z8W8kulG58ztbGF70TBVjqHvOrjkCfmhg777jpEOJ84DEy/6hbAn39bHwFfwwbNKJ8pNjZp1NDthUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NciMao/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NciMao/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805BF1F000E9;
	Mon, 27 Jul 2026 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159642;
	bh=cm+6RO6NKrmQhCTAXomhESN+8SE1hTWFq0tnUoVm+go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NciMao/7Bbc7u/PPvksd4RtB7y9NUjZzNmswpiTdU9O5cxf/tThmsVnswGl5G3fP+
	 cEF0+uzWKff/hO8HHckYSaz7Jy04adTELzgaheA02Ryc3nAvRnIOeWi9G9/j70OEYX
	 rBKG6QZsqZ8TFSyamCNdVHWeQerRcGPlFQKc9xFYV18Qj55K0fDht3+3BLMGsbcdhD
	 ljNeTOEtAJdm5twueyvyuoNGGHpWJoA67imPhW5CmaqtNeD3yFXjtQ/k+lDcFXQ0Hk
	 wYXOKwgDxTZZHm8Wn8otqZzjye+vTUjgyJuFShlNZin7M+jD74dCqwUFIjjEl0W1i8
	 WZqT7BYEGbrdA==
Message-ID: <4146d4f5-c8fb-42cf-9dc8-a9d4c26055da@kernel.org>
Date: Mon, 27 Jul 2026 15:40:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm/thp: serialize huge-zero folio state
 transitions
To: Hengbin Zhang <uqbarz@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>
References: <177a1767-c782-4210-b377-44c520c74619@kernel.org>
 <20260727131814.3983064-1-uqbarz@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260727131814.3983064-1-uqbarz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 15:18, Hengbin Zhang wrote:
> The nonpersistent huge-zero shrinker clears huge_zero_folio and then
> invalidates huge_zero_pfn. A concurrent fault can publish a replacement
> folio and PFN between those updates, after which the old shrinker
> invalidates the replacement generation's PFN identity.
> 
> A later partial mprotect() can then misidentify the live special PMD and
> enter the ordinary anonymous THP split path.
> 
> A writer-side spinlock keeps huge_zero_folio and huge_zero_pfn updates
> from different generations together. Lockless getters still use the
> refcount fast path. atomic_set_release() publishes an initialized new
> generation before a successful atomic_inc_not_zero() can admit a getter
> on weakly ordered architectures.
> 
> The race was reproduced using test-only instrumentation that widens the
> shrinker/allocation window; that instrumentation is not included here.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Link: https://lore.kernel.org/r/20260724100509.2300200-1-uqbarz@gmail.com
> Signed-off-by: Hengbin Zhang <uqbarz@gmail.com>
> ---
>  mm/huge_memory.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b5d1e9d4463d..89771a9b282d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -78,6 +78,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  static bool split_underused_thp = true;
>  
>  static atomic_t huge_zero_refcount;
> +static DEFINE_SPINLOCK(huge_zero_lock);
>  struct folio *huge_zero_folio __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  unsigned long huge_anon_orders_always __read_mostly;
> @@ -237,17 +238,19 @@ static bool get_huge_zero_folio(void)
>  	}
>  	/* Ensure zero folio won't have large_rmappable flag set. */
>  	folio_clear_large_rmappable(zero_folio);
> -	preempt_disable();
> -	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
> -		preempt_enable();
> +	spin_lock(&huge_zero_lock);
> +	if (READ_ONCE(huge_zero_folio)) {
> +		spin_unlock(&huge_zero_lock);
>  		folio_put(zero_folio);
>  		goto retry;
>  	}
>  	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
> +	WRITE_ONCE(huge_zero_folio, zero_folio);
> +
> +	/* Publish the identity before admitting lockless getters. */
> +	atomic_set_release(&huge_zero_refcount, 2);
> +	spin_unlock(&huge_zero_lock);

Can't we just keep the

atomic_set(&huge_zero_refcount, 2);

after the spin_unlock() ?

>  
> -	/* We take additional reference here. It will be put back by shrinker */
> -	atomic_set(&huge_zero_refcount, 2);
> -	preempt_enable();
>  	count_vm_event(THP_ZERO_PAGE_ALLOC);
>  	return true;
>  }
> @@ -297,15 +300,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
>  static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
>  						 struct shrink_control *sc)
>  {
> -	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
> -		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> -		BUG_ON(zero_folio == NULL);
> -		WRITE_ONCE(huge_zero_pfn, ~0UL);
> -		folio_put(zero_folio);
> -		return HPAGE_PMD_NR;
> +	struct folio *zero_folio;
> +
> +	spin_lock(&huge_zero_lock);
> +	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1) {
> +		spin_unlock(&huge_zero_lock);
> +		return 0;
>  	}

Do we really have to move that refcount modifications under the lock?

I'd assume it's sufficient to only move setting huge_zero_pfn+huge_zero_folio
under the spinlock.

-- 
Cheers,

David
