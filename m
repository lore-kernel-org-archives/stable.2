Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799980;
	b=nzX4f8NgE63+tOIIms/INY8Tp0xNFd1S+bbqdNmG3G2wl/wHxhCwlaYLKIzZxf8vQEYk
	 KyGAoPKGazw0NUqFic642+PdrITJH1A4AyJj7AWZyTdDcPKKb7xAquXm/VtS/xaeYvOBu
	 n1DBjdv+5q69eQEiyb1AU/oGG60Af8t8qj0FDMSl4PHqlVxoOJ86wiCKhGrf22jvreRaF
	 cEYf0ZINKhonwWcAMnSy0hsjNb8fn4eihBJhl5Ib53RqQoeTdIvsKZwmJiPl0oSBOmH23
	 rOjj5/YhA4u3yTIy+uIWfD3wcpMtB59xkagYbksLVJPLiGRMOKRVnOgvNP0/6lrY3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799980;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=buKhkrOLbFwNVdpoFdKvBgRlgZt6zjBAs2g/Dd0G2x0=;
	b=hhjhOdJjeixNLXwd3e7RxaWRFrPQy+ktjLSKZ3fXeBjGtlBKDfKIHsJ0H+QZXyC0S8TJ
	 soSA7N8ePdbMsDkRt6OWqJTAjyoHjTaPR1y5idvLvlLGuyhIZVKP79Fs9CK2tY5AmXr6i
	 d8hpOr1F6FmMsQGjnLuEi6H478pQzX+q/qQF6xwj0SbgOo4rt+j3s5MC6eqoKXa2MV6NX
	 9HeT97QqrgfcH7RtDCKsZMofE/WnEJTPQnlV+YKoH5yhja0hVVlkYo7U1T7QeKnPvGwSb
	 X0FZUKyVFuEtEggsmnZ44KSDw/ECsOPM5mDDPlmXAOV3PfdD5flfHw6j3gZ6Is/FUqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8CgADtE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673A606A32F;
	Wed,  4 Nov 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8CgADtE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB37E1F000C1;
	Wed,  4 Nov 2026 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799980;
	bh=buKhkrOLbFwNVdpoFdKvBgRlgZt6zjBAs2g/Dd0G2x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S8CgADtEj6KwHA1vy2Fes/qJi9I02l0ZPjMLumOm2kcrl8SyDhSy2Woijq+CtuaVL
	 vNohKO3i5aRfXnMnGgDo5ai2I0CHHfmWwdnCCCaMmhLWfu+uymy4B0mJRAx4ThxLL8
	 i0GMAEgSq9gHHHYbpP4wWZH24qIalljZ3f+4isnnxbnBIw5C5VDL9NLA74H1oyO9Zo
	 VkYElMlTZbDevbquf8OzdA9D94nydp9USZBP4Tfv/e7xRjzUuWPZovGtUUsmr7oeQQ
	 9WW/wBibXVaN5yagXIGWZonA7U2XkWUyv5mJlqThAoR6Qhu01Ptvy0Ur/k8ND/htN5
	 doY0I47tjlU4g==
Message-ID: <b437c07e-96e4-4812-9685-97f6e3e65dec@kernel.org>
Date: Wed, 4 Nov 2026 14:46:08 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
To: mt4022@columbia.edu, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
References: <20261103-swapin-large-unmapped-v2-1-87c70e597250@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261103-swapin-large-unmapped-v2-1-87c70e597250@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 21:12, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> Since commit f1879e8a0c60 ("mm, swap: never bypass the swap cache even
> for SWP_SYNCHRONOUS_IO"), a fault can read a swapped-out mTHP range into
> one large folio in the swap cache.  The folio only becomes anon once
> do_swap_page() maps all of it, so if the faulting PTE changes in the
> meantime the folio stays in the swap cache while not being mapped or
> anon:
> 
>   Task A (fault)                       Task B
>   do_swap_page()
>     /* swaps in large folio F */
>                                        madvise(MADV_DONTNEED)
>                                          /* zaps the faulting PTE */
>     /* PTE changed (F not mapped) */
> 
> swapoff then maps it, which marks all of its pages as mapped and
> exclusive, and the next fault on one of the other PTEs crashes in
> do_swap_page():
> 
>   [    6.424485] kernel BUG at mm/memory.c:5195!
>   [    6.424503] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   [    6.427654] CPU: 0 UID: 0 PID: 67 Comm: swapmthp Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [    6.432665] RIP: 0010:do_swap_page+0x24eb/0x2fa0
>   [    6.451035] Call Trace:
>   [    6.451567]  <TASK>
>   [    6.453841]  __handle_mm_fault+0x13b5/0x3b40
>   [    6.458525]  handle_mm_fault+0x16f/0x480
>   [    6.461143]  do_user_addr_fault+0x312/0xa30
>   [    6.462044]  exc_page_fault+0x66/0xc0
>   [    6.462846]  asm_exc_page_fault+0x26/0x30
>   [    6.476708]  </TASK>
> 
> do_swap_page() already drops such a folio from the swap cache when it
> can't map all of it.  We move that check into a helper and use it in
> unuse_pte() too, so swapoff drops the folio and swaps the entries in
> again as small folios.
> 
> Such a folio was never mapped, so it shouldn't be dirty.  If it is, the
> helper warns and the folio stays in the swap cache.  unuse_pte() then
> returns -EBUSY so swapoff fails instead of retrying forever.  With the
> fix, the next fault doesn't crash anymore.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 1s.
> 
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Changes in v2:
> - Move the check in do_swap_page() into a helper and use it in
>   unuse_pte() too (David)
> - Use VM_WARN_ON_ONCE() for a dirty folio (David, Kairui)
> - Keep a dirty folio and return -EBUSY from unuse_pte() instead of
>   dropping it, since dropping it would lose data (Kairui)
> - Rebase on mm/core.git for-next-fixes
> - Link to v1: https://lore.kernel.org/r/20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/swapmthp.c
> ---
>  mm/memory.c   | 17 ++---------------
>  mm/swap.h     | 21 +++++++++++++++++++++
>  mm/swapfile.c | 11 +++++++++++
>  3 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 91836d217d25..2e0dadbee382 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5166,21 +5166,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
>  	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
>  
> -	/*
> -	 * If a large folio already belongs to anon mapping, then we
> -	 * can just go on and map it partially.
> -	 * If not, with the large swapin check above failing, the page table
> -	 * have changed, so sub pages might got charged to the wrong cgroup,
> -	 * or even should be shmem. So we have to free it and fallback.
> -	 * Nothing should have touched it, both anon and shmem checks if a
> -	 * large folio is fully applicable before use.
> -	 *
> -	 * This will be removed once we unify folio allocation in the swap cache
> -	 * layer, where allocation of a folio stabilizes the swap entries.
> -	 */
> -	if (!folio_test_anon(folio) && folio_test_large(folio) &&
> -	    nr_pages != folio_nr_pages(folio)) {
> -		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
> +	if (!swap_cache_folio_mappable(folio, nr_pages)) {
> +		if (!folio_test_dirty(folio))
>  			swap_cache_del_folio(folio);

See below. I don't think we have to worry about dirty folios.

>  		goto out_nomap;
>  	}
> diff --git a/mm/swap.h b/mm/swap.h
> index d5bf21f517dc..f045a384fe79 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -464,6 +464,27 @@ static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
>  }
>  #endif /* CONFIG_SWAP */
>  
> +/*
> + * If a large folio from the swap cache already belongs to anon mapping, then
> + * we can just go on and map it partially. If not, and we can't map all of
> + * it, the page table have changed, so sub pages might got charged to the

"sub pages" doesn't exist. maybe just say "some folio pages might be ..."

> + * wrong cgroup, or even should be shmem. So the caller has to free it and
> + * fallback. Nothing should have touched it, both anon and shmem checks if a
> + * large folio is fully applicable before use.
> + *
> + * This will be removed once we unify folio allocation in the swap cache
> + * layer, where allocation of a folio stabilizes the swap entries.

Best to drop that and only mention it in the cover letter.

Also, I suggest to just move the comment above the if() below, and not having
this as a function documentation. it's mostly implementation details.


> + */
> +static inline bool swap_cache_folio_mappable(struct folio *folio,
> +					     unsigned int nr_pages)

Nit: two tab indent.

> +{
> +	if (folio_test_anon(folio) || !folio_test_large(folio) ||
> +	    nr_pages == folio_nr_pages(folio))
> +		return true;
> +	VM_WARN_ON_ONCE_FOLIO(folio_test_dirty(folio), folio);
> +	return false;
> +}
> +
>  extern const struct swap_ops swap_bdev_ops;
>  
>  int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 71ef9e2efb3a..fe2a00190806 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2513,6 +2513,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	if (!folio_matches_swap_entry(folio, entry))
>  		return 0;
>  
> +	/*
> +	 * A large folio that a fault didn't map can't be mapped one PTE at a
> +	 * time here, so drop it and swap in small folios instead.
> +	 */
> +	if (unlikely(!swap_cache_folio_mappable(folio, 1))) {
> +		if (folio_test_dirty(folio))
> +			return -EBUSY;

Should we even handle that? it should never happen, and we warned already on
debug kernels.

> +		swap_cache_del_folio(folio);
> +		return 0;
> +	}
> +
>  	swapcache = folio;
>  	folio = ksm_might_need_to_copy(folio,
>  				       folio_file_page(folio, swp_offset(entry)), vma, addr);
> 
> ---
> base-commit: 71555ae8c7572fd99158013ca2e29187c5d2508d
> change-id: 20261030-swapin-large-unmapped-6c8f6e691864
> 
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>

In general, LGTM, thanks!

I suggest Andrew will pick this up as it is mostly swap related.

-- 
Cheers,

David
