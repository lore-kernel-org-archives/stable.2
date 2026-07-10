Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65953ADB91;
	Fri, 10 Jul 2026 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715396; cv=none; b=PYiET7wGvgFtho2l+HS4mk6C5vHw0A4x7Z7LhSVrS3aEmA6l/jmCLDKX70c/2JiRAbkl5b3LM094NVd9q2BShalhpIQyZWXr1fYhuAqVZ5kzbw5BCf81tIgg0l298Q556781+6uDxPAbqUMwY293FtKYX+G3W3lFcbbex7egmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715396; c=relaxed/simple;
	bh=Q8Mg6KHi8ObRkvTXLh698Y6gMruUGSh0uaQnigao7+0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AgWkMS5cfoNC4p3GrH0IRcQE0Qp9RyfgI2VQtKlo0bM9x1sjh9ZIrYItudVJbCo52TZaRJMXrcIuV0/sNZQIO8P8xcK4zjlO6qAzid3z5eMsCGrm1zx/JnhSPfxRVkPRpjPEqvIUbpZG8gxUaF18tNiR5APyi4Q3W1Ab4xkpPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CRblMYXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CRblMYXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96BF1F00A3D;
	Fri, 10 Jul 2026 20:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783715395;
	bh=Uceh3gpjLST7XLAIXuAF2LqD5TvR9k+/w5GQWdiEcT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CRblMYXffQi+FIsxfpogDWIha2S8idYY7hlFe/hupRbmmEGTpi6BJ4HWTDByp44h8
	 /3KRTjFlIkQUy1k+KZfduunfVgWR6YZ2blivarDsUJXjaKDGjX+VaUowKSvDe3Q17Q
	 2r5q2LUoryHQT1HEWXwjVr9G90Mg+9z9Z6tAEqas=
Date: Fri, 10 Jul 2026 13:29:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>, Catalin Marinas
 <catalin.marinas@arm.com>, David Carlier <devnexen@gmail.com>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Will Deacon <will@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/ptdump: always stabilise against page table freeing
 using init_mm
Message-Id: <20260710132954.49c85be140500c59c1fcb773@linux-foundation.org>
In-Reply-To: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
References: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 14:29:21 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> x86 and arm64 invokes ptdump_walk_pgd() with non-init_mm mm whilst still
> walking kernel page table ranges.
> 
> For x86 this is done in ptdump_curknl_show() and ptdump_efi_show(), the
> first passing current->mm, and the second passing efi_mm (we reach kernel
> mappings that init_mm protects for current->mm due to x86 cloning shared
> kernel page tables for arbitrary mm's).
> 
> arm64 does so via ptdump_debugfs_register(), configured by efi_ptdump_info
> for efi ranges against efi_mm.
> 
> The init_mm mmap lock is used to stabilise page table freeing against
> ptdump, so take a nested lock on init_mm to ensure that we are correctly
> stabilised.
> 
> We take this after mmap write locking the non-init_mm mm. Nothing acquires
> the init_mm lock first before locking an arbitrary mm, so no deadlock is
> possible.
> 
> Other fixes have been sent which update the two cases which can cause races
> with ptdump in init_mm ranges to acquire the init_mm mmap write lock - vmap
> and x86 CPA huge page promotion.
> 
> For arm64, commit fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump")
> already provides exclusion against init_mm for the vmap case, which this
> patch also pairs with.
> 
> The first point at which ptdump can race kernel page table freeing is
> commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> table"), so we target this in the Fixes tag.

Does this have any known userspace impact?

> Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")

Since 2018, so I won't make this a hotfix, OK?

