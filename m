Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379237A825;
	Sat, 11 Jul 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764536; cv=none; b=fbw0bi/8wqrpWSwgc7LVwB8Yi5q3UhBW+BO0wFT8TvqBVbmxrcCgqrs6w7w/If0ZxcuAE3GAkyoSl9C5PESZn5qEsRZw7WwZV+h0tBDjoHTKk8X8xtPybvRYSpXc18HNhgIUuZJ78VrlB9yAbK5u5i5QEu8plq7fA/3ckASAbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764536; c=relaxed/simple;
	bh=wCKiajEX2jN38YW/HdMk5uWwXvYjeInWia8Yi/S38ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l06N/fPDMsuJMwzQ/y5i/qAw9iiqVEsen2jEeQXZCIcfJa0yTme62A4eI8Al3HNOjOpScsHMKUF2kHicgNsB1pD/ycLMsmYhazmhDkmxP9TGXi930fJViVt2nODRk0l06PwJuJo+N74mGbKv/NH2woz29CWq2TsO+ZsB251s9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJR7iEPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJR7iEPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51D81F000E9;
	Sat, 11 Jul 2026 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783764534;
	bh=7h3aGld2owdMP9awF/sIZ0ZeSAhD+gvPs1e421zuh8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GJR7iEPvoOLeZDVwN8a/m8eQsstNeIf+B49TSqFKwMDzcFpMtF/YF/maBObxCalaC
	 UUiaJvdi75QpJocaczvMAKnn9lGxyXeSYhgITG+bL8vXr99iad+Xvf3aDHHNhW/8H7
	 XsCm1q+bAukOUDEU06GDaWtlOaBP68l59MkJld1bcXlNBYkw6KxyMk5Bk7NcpXYziv
	 seRHPaOcR7+s1L6tyyq0corRJWjWDsYWiJnZQtjT13c9BscneJ3M+3Pz8NgqFcyWEg
	 8XXsvxxQZsQDY6zq+tkoPbsYBz/LuJ2gDxWek8sIqPOB6M2riU7RIco5FskBQqWO/Q
	 NP8eqdg37xZZw==
Date: Sat, 11 Jul 2026 13:08:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Will Deacon <will@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/ptdump: always stabilise against page table freeing
 using init_mm
Message-ID: <alIWLiLObQuZTGQZ@kernel.org>
References: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org>

On Fri, Jul 10, 2026 at 02:29:21PM +0100, Lorenzo Stoakes wrote:
> x86 and arm64 invokes ptdump_walk_pgd() with non-init_mm mm whilst still

Nit:            ^ invoke

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
> 
> Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>
> ---
>  mm/ptdump.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 973020000096..6bef47b1a073 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
>  
>  	get_online_mems();
>  	mmap_write_lock(mm);
> +	/* To stabilise page tables we must hold the init_mm lock too. */

Maybe

	/* To stabilise kernel page tables we must hold the init_mm lock too. */

Other than these nits

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
