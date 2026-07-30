Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC91424653
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414864; cv=none; b=Hau6KpTrC/A3bxZ0tqnBpqUjkpDUsIlLkDW4Kz82cumHDdIg+1QZ6XVm7TFcSNNfI/TTfW/ziuRY6VwU21KTqUHaYJp3dgAVSGClnOFInb4Ib9FZI14EkXI0xrd57QtaxC4kBjGM6AI+oz9I2XagVkdrMSZPXbdV+HuGSvUOrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414864; c=relaxed/simple;
	bh=nuR2lVmEsKfd2K6SKJWHPDEnug4GaQajUMZSFuOp9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRi5e4nQqYYp2qk13pOhWBsvOy1cC17e1xXzrByIEku4KisurNl53mxJEy3Jikm96+XKRmzt+eY65nG2RVxwSuOkG5uCUKIe7whmtrdV8Y5NGY8kAKvX9upUSmYzussc4Q9dRF+8yLEElyFOlYb+3ltXxH3h+hOU+fXebz3iaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=JfJ9MSOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAkMfovJ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JfJ9MSOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAkMfovJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E3CEE1D00077;
	Thu, 30 Jul 2026 08:34:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jul 2026 08:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785414860; x=1785501260; bh=RuD/XkKINV
	WYetz1G+LXXpxDOsQetZDNT7n3xehXPw4=; b=JfJ9MSOGeP1JAG/UoqfSL3DRTa
	hW5aC7PPsru8ua2u/5kezQavzqJjiozP1Gb9tKUYBz2PF3jvxMj/qTVNow57gLZg
	VbEbst1ALTnUVBo2EKxlzuji6g6R0a9QLOFWQHRkWxzYAJ7iWVvyDsVqcZmmRQsI
	1fBlR2Mf9+pZT26OXlwIcC6eTWNVWmoAnRZNY5Or8en+oYsKNGN4jXiMYAQ7Ktir
	DfwgGABPoEZ2zzE0l1lktOl9OHQ4R5hmLyktWWx6FScbyOP5S2raT9RHNTlKOubI
	h3Ud3CDit9kI0NyFUu1HBRKbIDx+msKTGy2kZtHHs9V3K+ADWSJuXqig/a2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785414860; x=1785501260; bh=RuD/XkKINVWYetz1G+LXXpxDOsQetZDNT7n
	3xehXPw4=; b=UAkMfovJHjY8HhSQ7NH8YNyUOIDtovyzisY+We+smaWDOY2OHWj
	VH5h4bKKM1RKtz5DiqcdQvkNDrVS6MN8a7ZzOb/7WqZAvRDq433X0ZraZ5tJ40l7
	bilmqp10roW3nAYVa2xruI70ip5UJ48jLKFT4tXExl6YaN73AhDyz1ocRzLHYfxh
	mFUadImTim7Dn7Q2Lds7kk2CJDUb4LEmAiDhHhL44X1UoILHJRofrYTgAgs0yVct
	Ub2JtyBSw+lQkV8qcZeUijFq47fmM0NG0Jj+KBb2gj5f4aIWib//5Byiwo+nS4vv
	fx14PCydDRG7eMocOl3rmf2OlQz2rLaBViw==
X-ME-Sender: <xms:zERraoUKebaXNEXKewn-5nJiC_kK-XZq5Jl0igtABcagi5Aii-IFJg>
    <xme:zERrap_vGNCsDRyKQNG9KnT__9cqzrTOyhZR2R4dH8GiuXT4aUuZdOD-1xufFcC06
    JidBitHu-Fs_XEunfOjcuN80YnQpA3cauzdRTH099cmy6NrhQ>
X-ME-Received: <xmr:zERraobVXJ-j3uty1z7KwWkVTcEdpFQkm3M2nba8x9GPHVS6Kh_Z7Z5XqlWjPv3Y_x_FXSNnt_lcFI4OZXnINNja3s9LmfOfuyXXpSWeMK8>
X-ME-Proxy-Cause: dmFkZTEmeFr3boXjjsfruoPxeCnv42fZwc873M1731/6FHdggump5HMtaxwKBuVtyKZyN9
    ebg2iH7aMJcFGS5VqoRAbiNeRosdL0IcocHFZrK2AuG324Acf4ElRFwFeomB01Rm9scruT
    zsMLFWaME+dEknj0K56R8It9Rf909+YYBOHAvkeJzluFmGWOwqoeIEVubA6vZInRr5bbXg
    2wDVPFEynQ44s9cw8PCXKXIPSWRv1jxoQzcVHDhuudOrU9sRei75UWzt/leSHdneZZ4nVc
    y8uetk+fgkWoNr3mc8nvQry/GjExdEI2GA1PkQA89P0WUg2Zi5np9LJX+HnjC2/FJTixq5
    +yTFJJriOBReyWx04B+C+bivA6B/D3BmQYZyR5D0Qk+ewpSJDHP08fXYunCjTERh+37shi
    ssfhHRxkh07W5mDbeEUFYSoH7DO9idoubU5gT6u/Bdv5T0cUWfV4B9TxB6soaOsXUPC+fm
    +xwMIyPOIzCRpQCZCafBvMBVkxrP3lVcL0byt0sqyy8TBxjen2Ia3iDRydGIBUCMNb2Oxe
    5bqpvhnNbcPXBnzL8Al+D080jQA7BAlIGtyF1jPOyldfoJiM6cs9Udjh3jprg6gcU6GZai
    GODUb7Kp3RIzsEiYmU2gyo+NkSNbl9HxxvazTp4UcnA6/HbIez+wsYKnp+8w
X-ME-Proxy: <xmx:zERrarDQr-9vHR3JRl_TVd6NzhWxhbQqxtZywwqfw55ciUuJ_4pO_g>
    <xmx:zERrauJGNkIVkt-CSFVnIJLMAo3DIG_RJBSBc9trVDSeJZu9xjVodw>
    <xmx:zERras-fQ-0_o9vHS2tbRhsMlzYqxEiTM7tfEe8m06867C-0SeZN6w>
    <xmx:zERranqbwHmd6YgImIkkG7NXfhJNzCYDQCaCbJ3GKY5slwOlHhN9AQ>
    <xmx:zERrahLAsYJHtB1GdrVVa807bovwJycQeCXSY13Wr1iYIgvhu9nl3b4f>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:34:19 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:34:07 +0200
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
Message-ID: <2026073055-lemon-uniformly-46b7@gregkh>
References: <2026072031-lapping-tubby-5b19@gregkh>
 <20260725105433.1853930-1-sashal@kernel.org>
 <2026073016-gulf-cushy-de29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073016-gulf-cushy-de29@gregkh>

On Thu, Jul 30, 2026 at 02:33:30PM +0200, Greg KH wrote:
> On Sat, Jul 25, 2026 at 06:54:32AM -0400, Sasha Levin wrote:
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> > 
> > [ Upstream commit 36f8f7ef7fd2f238922e9d217e86c69838319d8c ]
> > 
> > Allow users of KHO to cancel the previous preservation by adding the
> > necessary interfaces to unpreserve folio, pages, and vmallocs.
> > 
> > Link: https://lkml.kernel.org/r/20251101142325.1326536-4-pasha.tatashin@soleen.com
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Changyuan Lyu <changyuanl@google.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Stable-dep-of: 0e39380a7316 ("kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  include/linux/kexec_handover.h |  18 ++++++
> >  kernel/kexec_handover.c        | 104 ++++++++++++++++++++++++++++-----
> >  2 files changed, 109 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> > index 25042c1d8d54af..e1af332a262fba 100644
> > --- a/include/linux/kexec_handover.h
> > +++ b/include/linux/kexec_handover.h
> > @@ -52,8 +52,11 @@ bool kho_is_enabled(void);
> >  bool is_kho_boot(void);
> >  
> >  int kho_preserve_folio(struct folio *folio);
> > +int kho_unpreserve_folio(struct folio *folio);
> >  int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> > +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
> >  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
> > +int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
> >  struct folio *kho_restore_folio(phys_addr_t phys);
> >  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
> >  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> > @@ -83,17 +86,32 @@ static inline int kho_preserve_folio(struct folio *folio)
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline int kho_unpreserve_folio(struct folio *folio)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> >  {
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline int kho_preserve_vmalloc(void *ptr,
> >  				       struct kho_vmalloc *preservation)
> >  {
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline struct folio *kho_restore_folio(phys_addr_t phys)
> >  {
> >  	return NULL;
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index c13b99f7c9891e..37e6048118e8b7 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
> >  	return no_free_ptr(elm);
> >  }
> >  
> > -static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> > -			     unsigned long end_pfn)
> > +static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
> > +				   unsigned int order)
> >  {
> >  	struct kho_mem_phys_bits *bits;
> >  	struct kho_mem_phys *physxa;
> > +	const unsigned long pfn_high = pfn >> order;
> >  
> > -	while (pfn < end_pfn) {
> > -		const unsigned int order =
> > -			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> > -		const unsigned long pfn_high = pfn >> order;
> > +	physxa = xa_load(&track->orders, order);
> > +	if (WARN_ON_ONCE(!physxa))
> > +		return;
> >  
> > -		physxa = xa_load(&track->orders, order);
> > -		if (WARN_ON_ONCE(!physxa))
> > -			return;
> > +	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> > +	if (WARN_ON_ONCE(!bits))
> > +		return;
> > +
> > +	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> > +}
> > +
> > +static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> > +			     unsigned long end_pfn)
> > +{
> > +	unsigned int order;
> >  
> > -		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> > -		if (WARN_ON_ONCE(!bits))
> > -			return;
> > +	while (pfn < end_pfn) {
> > +		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> >  
> > -		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> > +		__kho_unpreserve_order(track, pfn, order);
> >  
> >  		pfn += 1 << order;
> >  	}
> > @@ -739,6 +746,30 @@ int kho_preserve_folio(struct folio *folio)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_folio);
> >  
> > +/**
> > + * kho_unpreserve_folio - unpreserve a folio.
> > + * @folio: folio to unpreserve.
> > + *
> > + * Instructs KHO to unpreserve a folio that was preserved by
> > + * kho_preserve_folio() before. The provided @folio (pfn and order)
> > + * must exactly match a previously preserved folio.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int kho_unpreserve_folio(struct folio *folio)
> > +{
> > +	const unsigned long pfn = folio_pfn(folio);
> > +	const unsigned int order = folio_order(folio);
> > +	struct kho_mem_track *track = &kho_out.track;
> > +
> > +	if (kho_out.finalized)
> > +		return -EBUSY;
> > +
> > +	__kho_unpreserve_order(track, pfn, order);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
> > +
> >  /**
> >   * kho_preserve_pages - preserve contiguous pages across kexec
> >   * @page: first page in the list.
> > @@ -783,6 +814,33 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_pages);
> >  
> > +/**
> > + * kho_unpreserve_pages - unpreserve contiguous pages.
> > + * @page: first page in the list.
> > + * @nr_pages: number of pages.
> > + *
> > + * Instructs KHO to unpreserve @nr_pages contiguous pages starting from @page.
> > + * This must be called with the same @page and @nr_pages as the corresponding
> > + * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
> > + * preserved blocks is not supported.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> > +{
> > +	struct kho_mem_track *track = &kho_out.track;
> > +	const unsigned long start_pfn = page_to_pfn(page);
> > +	const unsigned long end_pfn = start_pfn + nr_pages;
> > +
> > +	if (kho_out.finalized)
> > +		return -EBUSY;
> > +
> > +	__kho_unpreserve(track, start_pfn, end_pfn);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
> > +
> >  struct kho_vmalloc_hdr {
> >  	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> >  };
> > @@ -944,6 +1002,26 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
> >  
> > +/**
> > + * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
> > + * @preservation: preservation metadata returned by kho_preserve_vmalloc()
> > + *
> > + * Instructs KHO to unpreserve the area in vmalloc address space that was
> > + * previously preserved with kho_preserve_vmalloc().
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> > +{
> > +	if (kho_out.finalized)
> > +		return -EBUSY;
> > +
> > +	kho_vmalloc_free_chunks(preservation);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
> > +
> >  /**
> >   * kho_restore_vmalloc - recreates and populates an area in vmalloc address
> >   * space from the preserved memory.
> > -- 
> > 2.53.0
> > 
> > 
> 
> Oops, nope, dropped this and patch 2/2 as this causes a build error :(
> 
> 

Actually patch 2/2 works just fine on it's own, so I've kept that.
