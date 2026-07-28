Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D430C146;
	Tue, 28 Jul 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254526; cv=none; b=sD7Mc7paP2eJ08qWIBVT6RUfrojMDLr6848HPh+K9cri6unnqUwiL/fOSfqq2EqyKxFv+0kafm2MncAJQ0dGndmCTfytn2HrLu+fxhYaGwu4Zbv5KxnTkVG/FAUZD0t3IfoOYvVM8VushfzdPrJI0iUIFxKiQTqJ0AIN6cipRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254526; c=relaxed/simple;
	bh=4s2g8iXJqft0O79Ix91eWR9MCeMo5c27wVl61TiqdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpl0KnKJP1EGorazZIIxOEmxvtjjZdGlqGajynLDYJCR7MXcoI+deiS+KZU38LMazAf3la5S8EoWXmXLN84EO6xlBzafk3+8/Hgv456tIBT7FVeinX7sJXHCiUK0Ve4e44yRuNxFqC6zyg6WKRFwEnMM2ZgL0vURaj9drtDcYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evolvZWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evolvZWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B96E1F00A3A;
	Tue, 28 Jul 2026 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254524;
	bh=53Tcc2FrcqM5RSe5+P9Xw7NVIdmOkwy3TvduRaDIlPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=evolvZWzbLE9VSD/7i9PnT0FIdFupRwT0Mtfs26PCh7vXA5e8Qi5Avx6mA6hXc5gn
	 9dzMC6/9hvhDXBBph7w84dXFeyP9431U+p8OymcD4vyXshZ9y5ZxuBh9told/YZseK
	 ORkIAEWFaqWshK6K+c/Xl2aycQmRerOqFv5695xJAmEP0UwUfuHk9zhHDKSBtZV2c0
	 NJaWL3gEKEjw/HDp9099I36KKPuGLcZ7uAmrvc0tcDuNZgafMyMr3kU+UcWwlE4/rW
	 wzWFDVcyos5BMdnJOiU5I86f5OlHsoNPY4Ouw83HeukpZOW3BnzIo2C7q0nFZ7Fj6f
	 kaROK/scBxTOw==
Date: Tue, 28 Jul 2026 19:01:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <amjScICeRPqDzskV@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728151633.GX751831@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728151633.GX751831@noisy.programming.kicks-ass.net>

On Tue, Jul 28, 2026 at 05:16:33PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 28, 2026 at 04:07:44PM +0300, Mike Rapoport (Microsoft) wrote:
> 
> >  arch/x86/mm/pat/set_memory.c | 33 +++++++++++++++++++++++++--------
> >  1 file changed, 25 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index b1e780a465b5..4c8922695fd3 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -65,8 +65,25 @@ static const int cpa_warn_level = CPA_PROTECT;
> >   * Serialize cpa() using cpa_lock so that we don't allow any other cpu, with
> >   * stale large tlb entries, to change the page attribute in parallel to some
> >   * other cpu splitting a large page entry along with changing the attribute.
> > + *
> > + * When debug_pagealloc_enabled(), page attributes could be changed in atomic
> > + * context that would warrant disabling IRQs. But since debug_pagealloc always
> > + * uses 4k pages in the direct map there are no races for splits and collapses
> > + * and locking can be just skipped altogether.
> >   */
> > -static DEFINE_SPINLOCK(cpa_lock);
> > +static DEFINE_SPINLOCK(_cpa_lock);
> > +
> > +static inline void cpa_lock(void)
> > +{
> > +	if (!debug_pagealloc_enabled())
> > +		spin_lock(&_cpa_lock);
> > +}
> > +
> > +static inline void cpa_unlock(void)
> > +{
> > +	if (!debug_pagealloc_enabled())
> > +		spin_unlock(&_cpa_lock);
> > +}
> 
> If this lives, we should probably stick an assertion in both the split
> and alloc cases for holding _cpa_lock. That debug thing seems to rely on
> never hitting those, but having that be implicit is asking for pain.

I'd rather stick an assert for !debug_pagealloc_enabled() there.

-- 
Sincerely yours,
Mike.
