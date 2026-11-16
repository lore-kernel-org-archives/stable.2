Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849966;
	b=plH6T/WBEmpGJbAUQSY8wGfb3nr1xR88l0Y3GqCr4dmFvUYG8BHnxJIvmzLlzDoBsWGx
	 Wwnoqku5xC7GBMaHjbRQ8HJ7JCrj0ysK/Akb0023EOO4C1ccEuQOz+80P8lya5Vn4YAXW
	 GyLxhR11CFTS2WNJM+iknCt+ng5E93cYH4g4ia5cPQMnd2ITQ+z62Di/TtTIDgCLU2b2I
	 hBExCZsdIgW0PLq5+5sqnBQtIa5VR1T9FmaZNVoVKa7i5P+WCmrSZ5Xl0vh1VQ4NTTYhO
	 1G9mfiuvtYdU63Y1IqjUZuGDWvWZmFTHAX40SLBopVqtcp6ymfu517IFatZXIwixSIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849966;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=rzxgjF868Q8FAbCCoDm+JvCE/jhxHH7vVIq4SATyN8s=;
	b=iu6cLWqZ/yCvB6HZOdmikJhBDYKUSBo/MX7uiZujsE3KNE8tm7bVmkReg9nybMEoCLAv
	 Sc0XvpF2b7VvXjtNwFhykkB1Uk1c9zUSYanNCtflX4Dr9NkmOS/lZL5qmBFHSVE6uZ8TZ
	 KqKf89ssx0hvjXlcfQZzEM8AljdAftBdQnx2f/uCBrc95xPrRhLJQRHxJPcdocuUSKUXH
	 2vHq0BJ0WCBVLZhmBOVTfvQEh2NzF2Jvs7agp5zpeRzhBoZEPfQL63ALNdA5CKIqEkBOu
	 EaOdO4WzepcTCW30qZ+UtGhBwfbes1NX3qYbQb/HkDUwSyHPk2Xkdzx+12HjLYvETmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JxnmLjSq;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB4606A322;
	Mon, 16 Nov 2026 17:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADB4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JxnmLjSq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rzxgjF868Q8FAbCCoDm+JvCE/jhxHH7vVIq4SATyN8s=; b=JxnmLjSqavqJ6CKwoKaJlMeyNp
	D6BysKfZB+wzztxq+k73ocwtwInNef3O66o5U/ZZYYhzD8T5gcQs9/P0L68dpAI1+payU/WSVrLYV
	r7RjEULHlK0XjY1WM72Yf4Z/LOI8oWH7hTXeei4gwegj/HejhK+eDCPG0h7sGm62m7KVgLN7wc/EJ
	dNEEZ/JBANht5iXOsLeiMgRjuZbqFd4Trimf/0F8QHfT0kJQPVYQI4oVh4C8+XArRUcq5d/BVFygO
	oNbSRjbjSFYQp3Z6CIGcOAj3VoQtz35oVFCauvlCP6FBP0yisEgsUfBT+9YCbpx8eQ4t4uHBVMGPL
	hDLzO5uw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT0Sy-00000003P62-2xr9;
	Mon, 16 Nov 2026 17:26:04 +0000
Date: Mon, 16 Nov 2026 12:26:01 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
Message-ID: <ofd747zeh26u3rba42fsdryoe2mwdhi6r4cjvrmjn25tps4ar4@ubcwdhamdyui>
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>

On 26/11/13 09:04PM, Lorenzo Stoakes (ARM) wrote:
> In order to establish guard regions, guard markers are installed in the
> page tables of a mapped VMA.
> 
> However, problems arise when one tries to combine this with registering a
> VMA for userfaultfd, as such operations may themselves need to install page
> table markers such as uffd-wp.
> 
> When the installation is attempted the guard marker prevents these markers
> being applied, which can lead to unexpected results (especially if the
> guard regions are later removed.)
> 
> This is especially problematic because guard region installation causes the
> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> ranges will not be logged in this case.
> 
> Additionally, the uffd-wp page table marker will be propagated regardless
> for file-backed mappings as the zap being performed does not clear these
> markers.
> 
> This is problematic, as it can cause repeated failure to install guard
> markers resulting in an infinite loop.
> 
> Therefore, update guard region installation to invoke the zap with the
> ZAP_FLAG_DROP_MARKER flag applied.
> 
> Both before and after this change, uffd remove events will not trigger on
> guard region installation, nor will write protect state be propagated after
> guard region removal.
> 
> This makes sense as conceptually, guard regions mark a part of a VMA as
> effectively unmapped at the page table level, and removing the markers is
> like mapping the VMA again, over which operation uffd markers would in any
> case be lost.
> 
> A survey of open source users indicates nobody is relying on installing
> guard regions in uffd-armed VMAs. Software including glibc, android,
> tcmalloc and CRIU were checked.
> 
> This change means that any already established guard regions are removed on
> zap. These will be overwritten with the newly installed guard markers on
> success.
> 
> However, if this fails for some reason (fatal signal likely the only
> reasonable cause), guard regions may remain removed, and concurrent faults
> may succeed in the interim in the range.
> 
> Since the installation failing guarantees nothing about the range being
> installed into, and since success overwrites with guard markers, this isn't
> an issue.
> 
> Since MADV_DONTNEED does something similar, abstract the zapping to
> zap_range() and call it from both places.
> 
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Reported-by: Tal Zussman <tz2294@columbia.edu>
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
> Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Liam R. Howlett (Google) <liam@infradead.org>

> ---
> v2:
> * Updated to just zap everything as per David + Tal.
> 
> v1:
> https://lore.kernel.org/r/20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org
> ---
>  mm/madvise.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0214efd2a014..4f7728583207 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  	return 0;
>  }
>  
> +static void zap_range(struct madvise_behavior *madv_behavior,
> +		      zap_flags_t flags)
> +{
> +	const struct madvise_behavior_range *range = &madv_behavior->range;
> +	struct zap_details details = {
> +		.reclaim_pt = true,
> +		.zap_flags = flags,
> +	};
> +
> +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> +			      range->start, range->end - range->start, &details);
> +}
> +
>  /*
>   * Application no longer needs these pages.  If the pages are dirty,
>   * it's OK to just throw them away.  The app will be more careful about
> @@ -872,13 +885,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>  
>  {
> -	struct madvise_behavior_range *range = &madv_behavior->range;
> -	struct zap_details details = {
> -		.reclaim_pt = true,
> -	};
> -
> -	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> -			      range->start, range->end - range->start, &details);
> +	zap_range(madv_behavior, 0);
>  	return 0;
>  }
>  
> @@ -1217,9 +1224,11 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  
>  		/*
>  		 * OK some of the range have non-guard pages mapped, zap
> -		 * them. This leaves existing guard pages in place.
> +		 * them. This also drops any PTE markers in the range,
> +		 * including existing guard markers, which we reinstall on
> +		 * the next attempt.
>  		 */
> -		zap_vma_range(vma, range->start, range->end - range->start);
> +		zap_range(madv_behavior, ZAP_FLAG_DROP_MARKER);
>  	}
>  
>  	/*
> @@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
>  	case MADV_DONTNEED:
>  	case MADV_DONTNEED_LOCKED:
>  	case MADV_FREE:
> +	case MADV_GUARD_INSTALL:
>  		return true;
>  	default:
>  		return false;
> 
> ---
> base-commit: 4318887a3efa4c53d6f083ccfd7105b809a3ac65
> change-id: 20261112-disallow-uffd-guard-install-a5294129ad7b
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
