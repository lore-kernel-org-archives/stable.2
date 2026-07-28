Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2F3B4EBC;
	Tue, 28 Jul 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251807; cv=none; b=OIlOAbi5zNZC09lTC30ccCodqJjdydmw86t+sjgTqia0lmwDxnemRBcT8fuBN6uAF7llOry6jQr9UYzdjFSi+PAndyTzzFliT5ZTUmBUfndbaeO8TG764FJ31LIp5O3qvQlKFoEiwBSJF1uaVquLecVxI6R/0H0X0Gkxfh+uqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251807; c=relaxed/simple;
	bh=3Bpa7ShpR7SfEPuimE/TBmmtxJ9cc07BrXSwXBLzdwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPa/c32o8kq9n0rQ71ZjTgv3FYTy1WZjd17evWXhIjIXjbE+REmwI8x67TGDUGLFHdjlfz1w+DrHSq46w5SWd45i9fH5GFS6NXrI5ad6K7Np81Qwfy3yRaw9GTIqSWTqqqVudMX/LEsHL7MaZMuP60gtjeolrqrcznr+AgAR8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0Z57NRV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0Z57NRV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=65vzM7nthly/ekwxzXMOlRAEVvzXqafNzBka2YxYPLQ=; b=d0Z57NRV/S+FMgNQth4ZfFg2xQ
	xG8atFc2UxHzyT06C6Dg6iHaU5Fx20Ob5hoBehVBdWDadmAErL3oGwcbCIeli8LSvT1Qf9ADj0Ue9
	VV0eMyluYyS1aiXMo8MpM3RICMIBLVZGyFAais6sGCML6LZ4chyFyJStnWGY5oShFDB85qNbHP/G7
	vGRqMtPeKGEYnVu6RWfUglNMh/cnkdD4/cZnfi0ze5miR7X1eKzYMipFnw/uAcdSZ1N9vDpvSlIb9
	+yIb4/TdyVncgIQUuUEgccxUCyZiuDmMbL1kWqeJSe+e+JjKRgVXbPJ0l/9tM6n3+9YeEmNafs3vh
	ymUsDl5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wojXm-0000000DY6Y-10zP;
	Tue, 28 Jul 2026 15:16:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 581C1300EA1; Tue, 28 Jul 2026 17:16:33 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:16:33 +0200
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
Message-ID: <20260728151633.GX751831@noisy.programming.kicks-ass.net>
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

If this lives, we should probably stick an assertion in both the split
and alloc cases for holding _cpa_lock. That debug thing seems to rely on
never hitting those, but having that be implicit is asking for pain.
