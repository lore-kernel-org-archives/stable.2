Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F14457DE;
	Fri, 24 Jul 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905821; cv=none; b=WfH3f5+HkSoh8D4u2iwOWHC9gkmwshK0mDsbxBfeG3IVP/XGxc5b5d4Zf5ZQ52KP2GNoBeOEq0TJ/JNOMMdSaDJmhQ+346KkglDZM86d7prAKQff2MS8RHotvu0x4irzyUqZLMuYcVTz9SQlVJoHHBNfStyYm8G6aHf42O6741I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905821; c=relaxed/simple;
	bh=7E4f6w0jZa+tVfpcCgxEjRABmM9E3juEN7YJhMNR+58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkQF17oQU5Y9HsjmV/3/9JbQEN7nqe78tI2Qf1vc/TX7lFSvhVzVQwG9lJhThBLd42OEdAOD6cUK82ry/hqZBXVx6yK+RZT/bIpA5pFsSLa66J08wD9sZV6rM6xaE6uKs7tGH9K3zWi9COG9tlI0nlr2i898ihuMZgbeI9sSGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clXeYOxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clXeYOxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADC81F000E9;
	Fri, 24 Jul 2026 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784905814;
	bh=tb5O8wjKcs1Pw/yvf0gMKaayemz7IuqUU9nVaaWlvg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=clXeYOxQXDLXpoAFDrENkwTGS7dui0fvsU/h7Ajf1ew3+S1zHO/VInmDubBEe3KWJ
	 JX6jw8hkeIkNGGu6MY3CNkRCy3HysYs8Nb1uimnA1D4lSbUVRwffoZHRkJC3MpQAuL
	 Z2MKlVbWshUBo2CLTVtcgzh9vLEcvQCh1dCSo2VQvftbC9Fv41taVeNEu9puIqTQQT
	 fx5k1OoQV4j+3oVp7dQXtTWzQb0HpQWJfKB/UC0e9LAAJYVebm2TTU0e49BOMnI8WG
	 BNvgUvp4of6vGbUSykKTAFl/EXryoPxo8uD4ojxLNdMP6+36VCT5lSZ1apZFEeCgdU
	 Dvo0Dg6q+d4IA==
Date: Fri, 24 Jul 2026 16:09:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	stable@vger.kernel.org, syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v6 0/5] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <amOANEMRAsJsTBR3@lucifer>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
 <20260723162646.350cf3bf415a0855140d139b@linux-foundation.org>
 <20260723163233.54b38cfc682a25eb6edf7cc7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723163233.54b38cfc682a25eb6edf7cc7@linux-foundation.org>

On Thu, Jul 23, 2026 at 04:32:33PM -0700, Andrew Morton wrote:
> On Thu, 23 Jul 2026 16:26:46 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > @@ -1250,7 +1251,11 @@ static int split_large_page(struct cpa_d
> >
> >  	if (!debug_pagealloc_enabled())
> >  		spin_unlock(&cpa_lock);
> > +	if (cpa->init_mm_read_locked)
> > +		mmap_read_unlock(&init_mm);
> >  	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
> > +	if (cpa->init_mm_read_locked)
> > +		mmap_read_lock(&init_mm);
> >  	if (!debug_pagealloc_enabled())
> >  		spin_lock(&cpa_lock);
> >  	if (!ptdesc)
>
> btw, this affects your later "x86/mm/pat: allocate split page tables as
> kernel page tables".  Which I resolved thusly:
>
> static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
> 			    unsigned long address)
> {
> 	pte_t *pte;
>
> 	if (!debug_pagealloc_enabled())
> 		spin_unlock(&cpa_lock);
> 	if (cpa->init_mm_read_locked)
> 		mmap_read_unlock(&init_mm);
> 	pte = pte_alloc_one_kernel(&init_mm);
> 	if (cpa->init_mm_read_locked)
> 		mmap_read_lock(&init_mm);
> 	if (!debug_pagealloc_enabled())
> 		spin_lock(&cpa_lock);
> 	if (!pte)
> 		return -ENOMEM;
>
> 	if (__split_large_page(cpa, kpte, address, pte))
> 		pte_free_kernel(&init_mm, pte);
>
> 	return 0;
> }
>
>

Thanks that's correct!

Cheers, Lorenzo
