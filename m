Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88C288AD;
	Sun, 12 Jul 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846444; cv=none; b=VEiMRAgTkBSVIDixtvnLnXntqJbW6+cm/4KCE5+CdDzvqHiwQa+pmRb4CbiexgxREu2xdDlNz0LopmBKPZdCF3eGw4kBohn++P4HQcTNDRkaPG6aRvCSYu0o6eR/AYDiEnxcdeOoRSUuurQB2PTGA1WiPJy5cQhmSNlyOUE5JNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846444; c=relaxed/simple;
	bh=9DFk7VOCmynRRKPUUq71HL3wG6Q8EVEA70ApaU2FkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDbgBglsB7ymK4NT8wDQROF7xQ2Gw6FifnM3fQ8K+kLI8hkvji4RJdMtwWTFJnI0n3JJjnStR3sguiqV+E1jyzQ9R+MzxTnpyiQeWtxgEsUUxvmJKk/ZW/H3oBGU2JSMnlAziBEBNN7q11uWXKTHUGR23nkXyuxZGosuqkpR/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epPcl9sY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epPcl9sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1958B1F000E9;
	Sun, 12 Jul 2026 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846443;
	bh=GnL9C72NCuP+8WoVaUMRNhlRZdNBSwfW36nJtkAt9LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=epPcl9sY5qVsxQZgyUPrZsLn7kXboM/IbScY0npRmn9P+uRRsG+P7J04YR+iaTObs
	 1Px8rtHkErijBwOPBiUblVWwHivtzui7iKOQzLnQCbfVUWTosHxOMF+GGFijea9wlK
	 zbz39L341j03oPz2WAoRaPtTJh2riBYK1+pzbZ//v7p4o3QWUPlAcJ0yDZ/ZtLH2I3
	 oCr2y9pF59kfYfOJFdkWO49UwMw4GcYox72kxTR4mDa4FbEoXG2CkFx8yZYdAjkTL3
	 E6oDW4BUgoGmtZEjVpvqLSM6YwBYEbG5gElIdhTpYK4nxTZEhlk/ORnJAQa2ENgvoc
	 w58yTf35cMoSg==
Date: Sun, 12 Jul 2026 09:53:48 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Will Deacon <will@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/ptdump: always stabilise against page table freeing
 using init_mm
Message-ID: <alNWAE1818jgGTqW@lucifer>
References: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
 <alIWLiLObQuZTGQZ@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alIWLiLObQuZTGQZ@kernel.org>

On Sat, Jul 11, 2026 at 01:08:46PM +0300, Mike Rapoport wrote:
> On Fri, Jul 10, 2026 at 02:29:21PM +0100, Lorenzo Stoakes wrote:
> > x86 and arm64 invokes ptdump_walk_pgd() with non-init_mm mm whilst still
>
> Nit:            ^ invoke
>
> > walking kernel page table ranges.
> >
> > For x86 this is done in ptdump_curknl_show() and ptdump_efi_show(), the
> > first passing current->mm, and the second passing efi_mm (we reach kernel
> > mappings that init_mm protects for current->mm due to x86 cloning shared
> > kernel page tables for arbitrary mm's).
> >
> > arm64 does so via ptdump_debugfs_register(), configured by efi_ptdump_info
> > for efi ranges against efi_mm.
> >
> > The init_mm mmap lock is used to stabilise page table freeing against
> > ptdump, so take a nested lock on init_mm to ensure that we are correctly
> > stabilised.
> >
> > We take this after mmap write locking the non-init_mm mm. Nothing acquires
> > the init_mm lock first before locking an arbitrary mm, so no deadlock is
> > possible.
> >
> > Other fixes have been sent which update the two cases which can cause races
> > with ptdump in init_mm ranges to acquire the init_mm mmap write lock - vmap
> > and x86 CPA huge page promotion.
> >
> > For arm64, commit fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump")
> > already provides exclusion against init_mm for the vmap case, which this
> > patch also pairs with.
> >
> > The first point at which ptdump can race kernel page table freeing is
> > commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > table"), so we target this in the Fixes tag.
> >
> > Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >
> > ---
> >  mm/ptdump.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/mm/ptdump.c b/mm/ptdump.c
> > index 973020000096..6bef47b1a073 100644
> > --- a/mm/ptdump.c
> > +++ b/mm/ptdump.c
> > @@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> >
> >  	get_online_mems();
> >  	mmap_write_lock(mm);
> > +	/* To stabilise page tables we must hold the init_mm lock too. */
>
> Maybe
>
> 	/* To stabilise kernel page tables we must hold the init_mm lock too. */
>
> Other than these nits

Ack on nits will fixup on respin.

>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo
