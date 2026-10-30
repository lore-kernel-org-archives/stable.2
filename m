Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398524;
	b=PEJKS5k8RmgTuv/uBv4p1kcnFkz0t2rflhTkyc30uwPLZVPdENq6obvAKP9v6io8+6fM
	 HO3pd76bmjQGt6SSa43aVgoqLzLlPMLXHUrFfGCkIeBScg3j0pb8kNmWVzgTUoAiMCowt
	 L4BpAUf6z/Lo0VFJ4PhaKKIhuD6+SHcF4CmuxHFe14kRSiEPCKUbgLcy3782tmrYupdFy
	 9mFzPYNTQu62eGOYkL5v4jTct6BxfNfH3eri/enQbql/L6vAuPs6ZZQJzantbxDtxy4IL
	 wfyQM8nBrL2fbvUxgfuYs43HnvV3XPQNGPeOc2otC2n7Ae/ask3jESUY9lW1pCnorYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398524;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ae/WNpwhDO2VnWY2svGWtlkmRzAah686LwChcMW5xuY=;
	b=eKOAUJ/eUAVK16oX3fmuMmO/M6un16aSMJeRMUEvAjv6YPRDbLu9jrstj/2om6JfXO6s
	 c8ILsdZeQdDqa+JR/mJ+fodRodiJ9EuSHzXLrJWQ42rs5WYlViogNAvf8iMbPN6B6d9aF
	 yaOVWjAtqeCTGbPztHE8CLRzVbvC8Ca3oVG9hqZ0b9kPPa/EfWhrg3fwMkrwn2nNoiWvU
	 PsX3js27FG71eGLon88ibAztdpNRYrzpKmV+XAVoj76HqdLGQDunLCHTDAmL3ZswFgxK9
	 VLrgH539emHL7AxKY3dXURnPhzEpRiR36mMOa5LHeRPo3T9zTDvdanW0HMO0g0iM2AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HrSF/e4j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67796606A31D;
	Fri, 30 Oct 2026 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrSF/e4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26BF1F000C1;
	Fri, 30 Oct 2026 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398524;
	bh=ae/WNpwhDO2VnWY2svGWtlkmRzAah686LwChcMW5xuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HrSF/e4jvxLJdiVvNyJjOVr3iEP3BLH4f4XAOlLGgXaIvlPhikoj4YcSfGH7ZIMVF
	 wHUCHkhC6F1spfp2lEuuTiwV0MiUnz53NpxMPVlI+ImhsdAvAAF2hYYkJsCp4hc+hH
	 byDuDl5TI3NUj/SelCEpqDact3Uutl+KgcA2wnfGPEAilnnOBODMx+JoxsiRjYDO6E
	 FH9dNeKGww6ELtUIcxcOHYY63B4XaEZw7LZIRDH95QkrBz6eEd2csTie08F49UaUO4
	 z1AJuSoyoa1fX+EBB3lU0NvvuhtJETgT4+kg8Hk1HqsdhhKjmPkCKL5MSUVaOyNA5J
	 OvrHw4iesX/tQ==
Message-ID: <04ad7001-bdd4-47e1-9a80-5b2464da1044@kernel.org>
Date: Fri, 30 Oct 2026 23:15:18 +0100
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
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
To: mt4022@columbia.edu, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 20:11, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 

Thanks for the report!

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

Ugh.

Why is this special to large folios? I guess because a single PTE keeps the
large folio alive, right?

The problem really is that unuse_pte() open-codes whet do_swap_page() would
usually do. And it doesn't handle large folios in this scenario correctly.

What a mess.

I guess we could just teach unuse_pte() to only map a single PTE.

folio_add_new_anon_rmap() assumes the folios is fully mapped. We could add
up to twp folio_remove_rmap_ptes() calls with everything except the page we want
to map.

But reading below ...

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
> can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
> the entries in again.  With the fix, nothing is reported.

We indeed have this

if (!folio_test_anon(folio) && folio_test_large(folio) &&
    nr_pages != folio_nr_pages(folio)) {
	...
}

check.

The nr_pages check makes sense as in your case below it's simply nr_pages == 1.

> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within a second.

Rings a bell :)

> 
> Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> This conflicts in context with patch 41/47 of David's v2 series [1],
> which changes the line right below in unuse_pte() for KSM folios.  I
> can rebase on top of it once it's applied if needed.

It will likely get applied on top of

	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git for-next

Tomorrow and then quickly find its way into next. So if a resend is required,
best to send against that.

> 
> [1] https://lore.kernel.org/all/20261029-fixes_core-v2-41-a64ce7f83abb@kernel.org/
> 
> Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/swapmthp.c
> ---
>  mm/swapfile.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 189f04d8838f..b0b75ff16835 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2518,6 +2518,18 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	if (!folio_matches_swap_entry(folio, entry))
>  		return 0;
>  
> +	/*
> +	 * A large folio that is not anon yet was swapped in by a page fault
> +	 * that did not map it (yet). It can only be mapped as a whole, by
> +	 * do_swap_page(). Drop it from the swap cache and swap in small
> +	 * folios instead.
> +	 */
> +	if (unlikely(folio_test_large(folio) && !folio_test_anon(folio))) {
> +		if (!WARN_ON_ONCE(folio_test_dirty(folio)))
> +			swap_cache_del_folio(folio);
> +		return 0;
> +	}

I don't enjoy the additional code duplication, including the comment.

Can you pack the existing handling in do_swap_page() into a helper, pass
nr_pages, and reuse it here?

I guess finding a good name is the main challenge ...


static bool swapcache_folio_mappable(struct folio *folio,
		unsigned int nr_pages)
{
	if (!folio_test_anon(folio) || !folio_test_large(folio) ||
	    nr_pages == folio_nr_pages(folio))
		return true;

	if (!WARN_ON_ONCE(folio_test_dirty(folio)))
		swap_cache_del_folio(folio);

	return false;
}


Just a thought.

But it does look like the right fix.

-- 
Cheers,

David
