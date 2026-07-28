Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317813A9854;
	Tue, 28 Jul 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248487; cv=none; b=L9VaQu34DtR3N/38IEqIbBoZA35Qwog0wL33ojReHkQwCZYGnq3LfdYJA4TedrPRak+Dft1pY32O5uin/TVYLN0XsV0lLDBvx8jLroeg2yl5miiRIgWzf74Zd/9ldlXbeg+eVDd92irTN12rXG+DbVecr25gMrfHIJfKmRqGhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248487; c=relaxed/simple;
	bh=AOD2AgKy1L5MrAuEskFC1jwDhSBYgTRhStWuzowDRBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecjc01QfcDL90lqUptM1XxzfrwCHGT6eMMSThvggB0LbJnuo7AA/jdevwE/mJCVH2tBUNqgEF+/jF4+/aJZfTOaKHIQ1izJpIAX9DUg+TvdSrgSZwjQgM1fiTb7+YfNgGnpB27ngu7glPbYvuRPWodRX9U0yijqfLOaAHNT2e9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uv0l70G/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uv0l70G/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZcNWBxahuwKCE/IvTx/lMrMdjhnO/GCiW5lbVkdZ3aM=; b=Uv0l70G/RQc8iY7YKLRhWWcAgH
	egIjbftZ8rc+/7md8Xpm9oA6zpCBifwIpPHNbC6vAniqiaKMB6qQrapfPZTfi3sEttrWrCs/EPuVm
	YBXFYu+3Z9CIiO0z6G0UIVDB79aXzzt/yGQmdhaF0C3qNu4JscW4jK5nkuPyVWLC375tCt12IM1hq
	o6dRYDya2SvFaJq5ea5696WbU8d/R2dHOMrRZJCq89sd6hmxGQdDV3YXY5QQ+CR1F1HnyrVfCypjb
	9+OvYZg91bL6FrTW+xe3BN8luztvJ06ph6hsyw/MagpQWCHvuY/1ThxQX/Zeo7pn+SQ5qVo2KKH19
	FoThB4sA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woigA-000000050iu-0Nvt;
	Tue, 28 Jul 2026 14:21:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5EFD300969; Tue, 28 Jul 2026 16:21:08 +0200 (CEST)
Date: Tue, 28 Jul 2026 16:21:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <20260728142108.GW751831@noisy.programming.kicks-ass.net>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>

On Tue, Jul 28, 2026 at 04:07:44PM +0300, Mike Rapoport (Microsoft) wrote:
> The splitting and merging of kernel page table mappings between small and
> large is protected by cpa_lock.
> 
> Commit 5fce67641a3e ("x86/mm/pat: Don't gate cpa_lock on
> debug_pagealloc_enabled()") disabled gatig of cpa_lock on
> debug_pagealloc_enabled() to simplify the code presuming that skipping
> the lock when debug_pagealloc_enabled() was an optimization.
> 
> However Lorenzo Stoakes notes that:
> 
>   __kernel_map_pages() can be called from irq context:
> 
>   < GFP_ATOMIC context >
>   kfree() or whatever
>   -> ...
>   -> __free_pages_prepare()
>   -> debug_pagealloc_unmap_pages()
>   -> __kernel_map_pages()
>   -> __change_page_attr_set_clr()
>   -> cpa_lock spins [irqs off]
> 
>   So you're spin locking in irq context here, which is probably not a
>   good idea.
> 
> It would be possible to unconditionally use spin_lock_irqsave() and
> spin_unlock_irqrestore() but that would complicate locking rules even
> more.
> 
> Restore gating of cpa_lock of debug_pagealloc_enabled(), but instead of
> putting the open-coded condition
> 
> 	if (debug_pagealloc_enabled())
> 
> before every lock and unlock operation, wrap the condition and the
> locking operation into cpa_lock() and cpa_unlock() helpers.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index b1e780a465b5..4c8922695fd3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -65,8 +65,25 @@ static const int cpa_warn_level = CPA_PROTECT;
>   * Serialize cpa() using cpa_lock so that we don't allow any other cpu, with
>   * stale large tlb entries, to change the page attribute in parallel to some
>   * other cpu splitting a large page entry along with changing the attribute.
> + *
> + * When debug_pagealloc_enabled(), page attributes could be changed in atomic
> + * context that would warrant disabling IRQs. But since debug_pagealloc always
> + * uses 4k pages in the direct map there are no races for splits and collapses
> + * and locking can be just skipped altogether.
>   */
> -static DEFINE_SPINLOCK(cpa_lock);
> +static DEFINE_SPINLOCK(_cpa_lock);
> +
> +static inline void cpa_lock(void)
> +{
> +	if (!debug_pagealloc_enabled())
> +		spin_lock(&_cpa_lock);
> +}
> +
> +static inline void cpa_unlock(void)
> +{
> +	if (!debug_pagealloc_enabled())
> +		spin_unlock(&_cpa_lock);
> +}

There was already a patch merged that removed the shole debug_pagealloc
exception. Is that not better?
