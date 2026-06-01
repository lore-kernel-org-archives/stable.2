Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AB2BE7B6;
	Mon,  1 Jun 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337526; cv=none; b=PK8NQE+R1oM6jWWLwYH8VDVwD3F9h16DtcfLzHfncK9mDCpF8gSes5sJF2w6JguQTkjfclN4CVLt72p6Coc9CnDfHbk12PwhflcawCkndetaCDIyu6mB5anVyczLYnJCulH1mPDuU3cJ2TAl3VeV2gIoV6veicdtYncEZdp1UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337526; c=relaxed/simple;
	bh=EFgqyDEQDhnFxPVWT8lEYvR/NjrTzlRV3fZDafxeEAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+E+toDpBq71UKXRISxJ2YcPqEGQ6nGVPFKLRo4clrqneLlGJ76vqi5xVsPo0DIHA1Y1C0kNR2Jade0M1MxNM4HtdUYRm+1x/WCerSWVAX0yN6qIe5NHtQrkqcd6MMWBKpcUwIy8RRdcmCoHLld3nBa98Ag9IHcg7u6DtBXm/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQnEi5Jp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQnEi5Jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F0F1F00893;
	Mon,  1 Jun 2026 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337524;
	bh=HM7lYTwI4nJvKoF2NiK7FuKhllQLwtLUYImfGs3ds/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NQnEi5JpvBLwb/88v0kk3K+UC758KKlQw2MTl7MuX/OXstkoJkowO/fHTUzP8dDRR
	 CMfWIs4cit6NEEEnJl/R5qwOy+g06JXJSzAaLpoHI59upC4kbd2vrRA+yD2ad1dPlv
	 U/8meCv0F2kIEkhoGx9inj2HiyxhS9lHHJzdj03rkE6bxcrgPSSNGhblejPgIKdYf3
	 RsC4ypDVRu/XVSIaRqqPo2pKsMFDnllWPUMy8aPw7mRmOtclpyHzea2QcJKwly4wQ4
	 35LGN7/vsFoEI0Ha0d1OgSJakpiyZTwwbTy5B8RYOzdP1yGLNszOuFMQRRi1/1T+tL
	 RD0qYjdcQNBVA==
Date: Mon, 1 Jun 2026 19:11:59 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 5/6] userfaultfd: gate must_wait writability check on
 pte_present()
Message-ID: <ah3KmnfmEeX85M9p@lucifer>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-6-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-6-kas@kernel.org>

On Fri, May 29, 2026 at 06:23:29PM +0100, Kiryl Shutsemau (Meta) wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it. Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits
> that happen to share the same position and return an undefined result.
>
> The intent of the check is "is this fault still WP-blocked?". A
> non-marker swap entry means the page is in transit -- the userfault
> context the original fault delivered against is no longer the same,
> and the swap-in or migration completion path will re-deliver a fresh
> fault if userspace still needs to handle it. Worst case under the
> current code the garbage write bit says "wait", and the thread stays
> asleep until a UFFDIO_WAKE that may never arrive.
>
> Gate the writability check on pte_present() so the lockless re-check
> only inspects present-PTE bits when the entry is actually present.
> The non-present, non-marker case returns "don't wait" and lets the
> fault path retry.
>
> Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

One tiny nit is maybe could mention softleaf :P but it's not important!

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/userfaultfd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 35b206cc9aa6..f6d2a1c67019 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2535,6 +2535,15 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  	/* UFFD PTE markers require userspace to resolve the fault. */
>  	if (pte_is_uffd_marker(pte))
>  		return true;
> +	/*
> +	 * Concurrent migration may have replaced the present PTE with a
> +	 * non-marker swap entry between fault delivery and this lockless
> +	 * re-check. huge_pte_write() on a swap entry decodes random offset
> +	 * bits, so gate it on pte_present(). The migration completion path
> +	 * will re-deliver the fault if it still needs userspace.
> +	 */
> +	if (!pte_present(pte))
> +		return false;
>  	/*
>  	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
>  	 * resolve the fault.
> @@ -2621,6 +2630,17 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>  	/* UFFD PTE markers require userspace to resolve the fault. */
>  	if (pte_is_uffd_marker(ptent))
>  		goto out;
> +	/*
> +	 * Concurrent swap-out / migration may have replaced the present PTE
> +	 * with a non-marker swap entry between fault delivery and this
> +	 * lockless re-check. pte_write() on a swap entry decodes random
> +	 * offset bits, so gate it on pte_present(). The page-in path will
> +	 * re-deliver the fault if it still needs userspace.
> +	 */
> +	if (!pte_present(ptent)) {
> +		ret = false;
> +		goto out;
> +	}
>  	/*
>  	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
>  	 * resolve the fault.
> --
> 2.54.0
>
