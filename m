Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E5372B31;
	Sun, 12 Jul 2026 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853275; cv=none; b=M2G2GYlSVNcX7lgqIRMhnvwDyupJhFMadwDmMWTxQZUikXOLw4YmfQ7hG5KpNo41eoA54y2wGDK4bcei6clj1xLp9ijq8oa1ul2igIx5Fi8vbMLOCqMFFXyHbLBH+OX7a1cGuvl93AfepC+TY6DIaR4+Fy53b8yYqQEa8jYRSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853275; c=relaxed/simple;
	bh=/qQuNHwfggsZrnd+KuV0gCXU2w7baMsOVUJIH5eNkXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKeY3gt/JSiL30z0RiK0io917W+ajpbRNVIDNIMHFK5wolxv20DXlWC5m+D588zkN/QjaoH7b1VGKSd+wjDwDSliqz6T0GuVcE2wp53t2zk7Lj8O0lhFj9k+VwTYngCTT706FSd6aul7UHGPP+H18vCxxlyhWPC9c29VPw+YDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1ozN2CI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ozN2CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA251F000E9;
	Sun, 12 Jul 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783853274;
	bh=/qQuNHwfggsZrnd+KuV0gCXU2w7baMsOVUJIH5eNkXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1ozN2CI66ESnpPd6ytBXeC3H6HMQRK81sUTWsm21lJyTwKGzX/HRRlnuAqyYbD0X
	 IiTOsAg97PRsAt6Oq1sufKt9qpvuqnhabuDX+fqYj3UR8UzW+X3ycE9Fe5YOuBJdde
	 XLo3/VPmEaanQVvrThzd+K8cf0ztSHDWmJWSr+JY38UvmY4KK7A2jKmlgiiD0+q0d7
	 W0RhK/rAJgRcPqJp6wI4Vba4z+2ph9ZZiuTzt6egY+Q5ayfqw9sunhIJO0+5AOCpn5
	 GzbAjhhzR4rN4YdjyS/fjZWQKLQH2puxrILzkYdDT3R2mrVoJLl1AMtLj80STq2UfQ
	 FqAJyroPITEtQ==
Date: Sun, 12 Jul 2026 11:47:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Will Deacon <will@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm/ptdump: always stabilise against page table freeing
 using init_mm
Message-ID: <alNwoFee3Qe9mK1_@lucifer>
References: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
 <20260710132954.49c85be140500c59c1fcb773@linux-foundation.org>
 <alH27K6kvUVxJ672@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alH27K6kvUVxJ672@lucifer>

On Sat, Jul 11, 2026 at 08:57:18AM +0100, Lorenzo Stoakes wrote:
> (+cc Dave as we were discussing on another thread)
>
> On Fri, Jul 10, 2026 at 01:29:54PM -0700, Andrew Morton wrote:
> > On Fri, 10 Jul 2026 14:29:21 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > > x86 and arm64 invokes ptdump_walk_pgd() with non-init_mm mm whilst still
> > > walking kernel page table ranges.
> > >
> > > For x86 this is done in ptdump_curknl_show() and ptdump_efi_show(), the
> > > first passing current->mm, and the second passing efi_mm (we reach kernel
> > > mappings that init_mm protects for current->mm due to x86 cloning shared
> > > kernel page tables for arbitrary mm's).
> > >
> > > arm64 does so via ptdump_debugfs_register(), configured by efi_ptdump_info
> > > for efi ranges against efi_mm.
> > >
> > > The init_mm mmap lock is used to stabilise page table freeing against
> > > ptdump, so take a nested lock on init_mm to ensure that we are correctly
> > > stabilised.
> > >
> > > We take this after mmap write locking the non-init_mm mm. Nothing acquires
> > > the init_mm lock first before locking an arbitrary mm, so no deadlock is
> > > possible.
> > >
> > > Other fixes have been sent which update the two cases which can cause races
> > > with ptdump in init_mm ranges to acquire the init_mm mmap write lock - vmap
> > > and x86 CPA huge page promotion.
> > >
> > > For arm64, commit fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump")
> > > already provides exclusion against init_mm for the vmap case, which this
> > > patch also pairs with.
> > >
> > > The first point at which ptdump can race kernel page table freeing is
> > > commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > > table"), so we target this in the Fixes tag.
> >
> > Does this have any known userspace impact?
>
> Taken in conjunction with the other fixes mentioned it resolves a UAF, so yes :)
>
> >
> > > Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> >
> > Since 2018, so I won't make this a hotfix, OK?
> >
>
> No, this has to be a hotfix, it is part of solving a live UAF issue.
>
> Cheers, Lorenzo

Have put this patch in a series in [0], as easier to just keep everything
together and makes dependencies clear and what it's for.

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org/
