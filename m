Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD141A542
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414828; cv=none; b=o9lOIM56Zt3z79RDZ7rnRMBwmcKsQ9Ph3/rQ51XA37NVH2TDYXeSqq914aLWEGvsz204dGuvsmRxb4b0ggPEtE0JT/oHKQhRhxRzmU1pdF9VCWkXxNJxscGrxgZgJLhcHzlmP7pmnX4Gn7H0E89aolM1K5TaTh7H6d8xijGwFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414828; c=relaxed/simple;
	bh=Ydgpg66eioyEWiov1cbJqOEa1CGZWtmfrtbiX8kth9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki7U3idutJxk3o0gAbgWHzD76TBTLZtXAq/gQPBChNC9v9z7iMjo1YCdZp7THWeDnoS3t0HMyNLJKJHnJgG3oWAuqrDD5dhuZ0pppmTMnDByzi9EYr/Nt/Y8blgsFNuPzKNoxmtSXWuI5ZmW/X/L3QwyBvCzc9ClwaZPZkUuTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lQvvr6fH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQPzjbOB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lQvvr6fH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQPzjbOB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 56FB91D00019;
	Thu, 30 Jul 2026 08:33:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jul 2026 08:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785414824; x=1785501224; bh=a1Y5SnQ0NS
	ZWXXPmvjST23nmk6IFK6GKQKXvxOmhYqs=; b=lQvvr6fHn0P3BuNTsx1+/Uzhbr
	K64Sd7uVVICShJoY1xVVObS1XHGuBFOPrbindGVPWZWtMtz7cXiyTCRww8gk9qEX
	3IaHPlZL1gGEkxAr9gB4hs4A/HlbUpuGTHcbGGCCWw4DIfgR/RQKtN5yTSsst2oR
	ude48++8FxoU6G5RS2ES6pbGR3X6UqsZdx8TneG5593A3Jt0WZP0ZsbS9qj/SpSi
	N15KKeO0qT21OJtK4JVA38Tjkzu8Fi3EFqv7D8QkxI3G2zVhRaoWTuALdJzrAoXF
	K6MwixSzhpiXVUnx5G4s3sYVf1pJ0vrQ03qEzi47vdAsfnzX5P+UgRj5Pp9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785414824; x=1785501224; bh=a1Y5SnQ0NSZWXXPmvjST23nmk6IFK6GKQKX
	vxOmhYqs=; b=AQPzjbOBMl8gXr9yBkTC4imoaLldjxpSt/+aJiUL1qFhLP6sbHq
	1Csix4bzHCAi6vyDXj1V5pM6xnLJbsat5BYv7TTVn5TssuFnp+GDXc6ZC8cgtlSS
	4V+DNRhY4HG3TIQCg2oiIasbgb7YbDV5nOpo8kXRaxgzD2fIGNeZitnrHVuwB+oE
	2TsBSYL0UsibPj/UlM6gJXkeFOFJSWr6a8LHw40PTCAhS9DPQZZIK+G9ppL7lVgO
	KTYwz/S8mJW/nG1C7t0dVljHzqupaB1xbiv7CfumomLyeoz0/lsrxYUhsY0CVBux
	tIxQAwzBMSGmY8ifiKPGpNR2bYxoZdLM/zg==
X-ME-Sender: <xms:p0RraoG8IPtghxIx0Lu0iMOmwtqpUzQhQwKsfdLEXETOTFpLwNjPbA>
    <xme:p0RrausfuFEXSssxzSepjTJ5A-vJ-Oe38ct9HW2No_Egwg6PG500lGeIRzV8bvWD7
    trm_L5hoHUzFDs9Y8x9gFLVGFqJkp88iCr0VVYByJiRdeOG>
X-ME-Received: <xmr:p0RrauKtmEPAaabxrc23Q4aKI294BUflCxRdUyB7dCqVLky_dpfoCU1CfIi2CHDKf8loeXNZRqZslXQeIzYzgcC06MyKi8uroK3tTSigF3k>
X-ME-Proxy-Cause: dmFkZTEmeFr3boXjjsfruoPxeCnv42fZwc873M1731/6FHdggump5HMtaxwKBuVtyKZyN9
    ebg2iH7aMJcFGS5VqoRAbiNeRosdL0IcocHFZrK2AuG324Acf4ElRFwFeomB01Rm9scruT
    zsMLFWaME+dEknj0K56R8It9Rf909+YYBOHAvkeJzluFmGWOwqoeIEVubA6vZInRr5bbXg
    2wDVPFEynQ44s9cw8PCXKXIPSWRv1jxoQzcVHDhuudOrU9sRei75UWzt/leSHdneZZ4nVc
    y8uetk+fgkWoNr3mc8nvQry/GjExdEI2GA1PkQA89P0WUg2Zi5np9LJX+HnjC2/FJTixDv
    IYvpHs9VRrn0SiANfFNjvuNtpQyjp4Idx/3NzXyU3ETbGpdysOM2ntvzNHNjWLnb9l1Jrw
    aohVO0qOwRAxhyYejWm0OYgOp1W5OUfAAyZOfBy2ef39unG02yzlIMHjP/WdQoVzSuubm8
    GN1BtgSemg5ju7lIDSvIX+SCkFJrfU/mo4hfipJjdJmshR6jdvfTBhZmaL3yIB9zj75fxo
    QgQWnGIls0QKr5VSkwk25cOl5sk2nb+rqqPPPKThvPCXIygyJ85AEhcJIdb9O3KpFonFqJ
    k9Varzp0OV/gDtYAmT5905XqOJW9Nt5eeoOgzzVOiwjoSiWbCu0vruOafnJQ
X-ME-Proxy: <xmx:p0RratyXXd7i8OYKM-Ll-t0vh5Svwf5otOn5ag_GyGn87LaCO9ENlg>
    <xmx:p0Rrap6ctccjkXpqrNZ-RSh5-G1VFpAnlFb3FzXMteTAovTWzz6yLQ>
    <xmx:p0RratsI0jyiSpXmWlbUr6KwZxeVB5dSHJsVnlrT49A5oI6uEiNVdQ>
    <xmx:p0RrapYd1IqCHWdIXId8ohn6An-WTn_eDbwYRUqJ7-egVNWREm74Tw>
    <xmx:qERram696IrXoRt2DFYd7YhKMfo784zhObSUkXI_b7Dykj1p2NpcxhLq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:33:43 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:33:30 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] kho: add interfaces to unpreserve folios,
 page ranges, and vmalloc
Message-ID: <2026073016-gulf-cushy-de29@gregkh>
References: <2026072031-lapping-tubby-5b19@gregkh>
 <20260725105433.1853930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725105433.1853930-1-sashal@kernel.org>

On Sat, Jul 25, 2026 at 06:54:32AM -0400, Sasha Levin wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> [ Upstream commit 36f8f7ef7fd2f238922e9d217e86c69838319d8c ]
> 
> Allow users of KHO to cancel the previous preservation by adding the
> necessary interfaces to unpreserve folio, pages, and vmallocs.
> 
> Link: https://lkml.kernel.org/r/20251101142325.1326536-4-pasha.tatashin@soleen.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Changyuan Lyu <changyuanl@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 0e39380a7316 ("kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/kexec_handover.h |  18 ++++++
>  kernel/kexec_handover.c        | 104 ++++++++++++++++++++++++++++-----
>  2 files changed, 109 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 25042c1d8d54af..e1af332a262fba 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -52,8 +52,11 @@ bool kho_is_enabled(void);
>  bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
> +int kho_unpreserve_folio(struct folio *folio);
>  int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
> +int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> @@ -83,17 +86,32 @@ static inline int kho_preserve_folio(struct folio *folio)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_unpreserve_folio(struct folio *folio)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int kho_preserve_vmalloc(void *ptr,
>  				       struct kho_vmalloc *preservation)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>  	return NULL;
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c13b99f7c9891e..37e6048118e8b7 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
>  	return no_free_ptr(elm);
>  }
>  
> -static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> -			     unsigned long end_pfn)
> +static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
> +				   unsigned int order)
>  {
>  	struct kho_mem_phys_bits *bits;
>  	struct kho_mem_phys *physxa;
> +	const unsigned long pfn_high = pfn >> order;
>  
> -	while (pfn < end_pfn) {
> -		const unsigned int order =
> -			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		const unsigned long pfn_high = pfn >> order;
> +	physxa = xa_load(&track->orders, order);
> +	if (WARN_ON_ONCE(!physxa))
> +		return;
>  
> -		physxa = xa_load(&track->orders, order);
> -		if (WARN_ON_ONCE(!physxa))
> -			return;
> +	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> +	if (WARN_ON_ONCE(!bits))
> +		return;
> +
> +	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +}
> +
> +static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> +			     unsigned long end_pfn)
> +{
> +	unsigned int order;
>  
> -		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> -		if (WARN_ON_ONCE(!bits))
> -			return;
> +	while (pfn < end_pfn) {
> +		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>  
> -		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +		__kho_unpreserve_order(track, pfn, order);
>  
>  		pfn += 1 << order;
>  	}
> @@ -739,6 +746,30 @@ int kho_preserve_folio(struct folio *folio)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
> +/**
> + * kho_unpreserve_folio - unpreserve a folio.
> + * @folio: folio to unpreserve.
> + *
> + * Instructs KHO to unpreserve a folio that was preserved by
> + * kho_preserve_folio() before. The provided @folio (pfn and order)
> + * must exactly match a previously preserved folio.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_folio(struct folio *folio)
> +{
> +	const unsigned long pfn = folio_pfn(folio);
> +	const unsigned int order = folio_order(folio);
> +	struct kho_mem_track *track = &kho_out.track;
> +
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	__kho_unpreserve_order(track, pfn, order);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
> +
>  /**
>   * kho_preserve_pages - preserve contiguous pages across kexec
>   * @page: first page in the list.
> @@ -783,6 +814,33 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_pages);
>  
> +/**
> + * kho_unpreserve_pages - unpreserve contiguous pages.
> + * @page: first page in the list.
> + * @nr_pages: number of pages.
> + *
> + * Instructs KHO to unpreserve @nr_pages contiguous pages starting from @page.
> + * This must be called with the same @page and @nr_pages as the corresponding
> + * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
> + * preserved blocks is not supported.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +{
> +	struct kho_mem_track *track = &kho_out.track;
> +	const unsigned long start_pfn = page_to_pfn(page);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	__kho_unpreserve(track, start_pfn, end_pfn);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
> +
>  struct kho_vmalloc_hdr {
>  	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
>  };
> @@ -944,6 +1002,26 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
>  
> +/**
> + * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
> + * @preservation: preservation metadata returned by kho_preserve_vmalloc()
> + *
> + * Instructs KHO to unpreserve the area in vmalloc address space that was
> + * previously preserved with kho_preserve_vmalloc().
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> +{
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	kho_vmalloc_free_chunks(preservation);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
> +
>  /**
>   * kho_restore_vmalloc - recreates and populates an area in vmalloc address
>   * space from the preserved memory.
> -- 
> 2.53.0
> 
> 

Oops, nope, dropped this and patch 2/2 as this causes a build error :(


