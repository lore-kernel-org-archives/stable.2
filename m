Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400861;
	b=qpuRvCdWdrbNVw3cdWTqiQqiI7mWv0HFb4Iw3LXbFFdwwheELPi3AHrihTOPxc959SPh
	 8eegwUyj5jn7FXs+nP6zOqfZfcc6pBa0cNGCdNvm1Bpa4bVAKexsITShYBD4eDCJ7nZl8
	 aSEzWDDrba32xc8xvp/y8RdQwA0KR4cd5w6KHC0A36mjhgqZiwWYbYMfeqpgdtZVwvlP+
	 TjrfINyYYKmD3n6UPavE+Lb7ke2afmQffxtTUT9FVay2pLoVzU6PXNGSUNWv01FsgisAH
	 PiBWsucz7S7T05vAsZmbtm3iHYFEC1Vcf+moLsk7DJD7jBIH1us7ssij0S3Bawp89DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400861;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B4oUzWtr+h3zt3CPlzIuso3ePnMgdYDn2x9olNeUBOg=;
	b=oj3n6BExqM4/UWNiS9pvXa9efwvbdzh7lnkBp4PhaRzPjdH06j3KMiuFlRw6Hoi9VctF
	 BcuaZQ3viYr661QNd4oROm3xcc4oqy4bvbLpCWozJtyJS6UgpAqEkaGJmIujVzvtErm5D
	 AukRfjH9rZS9CMfEn0z7tYmQIeQBghYk3J4sJeK9LoMEWpPvEPX4bsP8qEpOD10VZvF8f
	 oPeNLzCLCljasBqFicNRAyoq+l8E2XyuiPTDkjZxOIqEQnsRIJyu4yplunMT+qpdFYHyz
	 dOeISmmc6aYqRgRACT4FzANcGK5EdhvkTk48iynMvocwcu5oj1pQ44Q6kFBFdxgXoAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PFvSnOch;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC2606A31C;
	Fri, 30 Oct 2026 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=PFvSnOch
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70651F000C1;
	Fri, 30 Oct 2026 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793400860;
	bh=B4oUzWtr+h3zt3CPlzIuso3ePnMgdYDn2x9olNeUBOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PFvSnOchgYwfhYQGiUez99CKhmSXHfQWtwDa8ha9StJx+R4Lnes/u2+NSOfu7IbJJ
	 tSnVGA10DWzHsHpPeLK6rlselFeZZLeOMMGkareStGWpHPlkq1qrNxLviEUHPHZQDD
	 xsrWz0tIc+m4A1pfMQ5m0NJYG4PvBUrdQMfqtTN8=
Date: Fri, 30 Oct 2026 15:54:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park
 <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/swapfile: drop a large unmapped swap-in folio in
 unuse_pte()
Message-Id: <20261030155419.b10056c8fb37bc784b0d2778@linux-foundation.org>
In-Reply-To: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
References: <20261030-swapin-large-unmapped-v1-1-41e4ae378e6c@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 15:11:56 -0400 Mani Tofigh <mt4022@columbia.edu> wrote:

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
> 
> ...
>
> do_swap_page() already drops such a folio from the swap cache when it
> can't map all of it.  Do the same in unuse_pte() so that swapoff swaps
> the entries in again.  With the fix, nothing is reported.
> 
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within a second.
> 
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

Let's not WARN here.  If it hits and someone reports it, what do we
tell them?  "uh, that's working as designed, no action needed".

Also, won't this change cause try_to_unuse() to keep spinning away until
someone kills it?  Might be better to return -EBUSY and fail the
swapoff?

