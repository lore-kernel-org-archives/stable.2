Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F563C4B87;
	Tue, 28 Jul 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244297; cv=none; b=MIycvuLxOoSColh3fc4K+jCIEKkgK+3eVXAX7y9RrktFcEEquUb3dm6lKdMgxP64mO5QljltyBTuqrASf5w8D0KyPgftXlZjFy1q67TT3050dmYRmYeljCWKA7x+JgnR6lTIBTOSrp/2uZWuUWDXldkcQoLy47orMYBYNR9A07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244297; c=relaxed/simple;
	bh=Ou21JCvc5HKPxxlwNcJySmXmuJ9pySNSUu/x50iXS6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlKtMfS/ZGP5gyHVLCLe2upW55K6In/e7EXyazzYSlBPmW1d+1wwMaJSCK40PFGhmj1moOLsqi1uWKTc+RPw2daO72P8+047NiA7koAIc8qon8/WTDMlENRxq3jcyIKGsqjo/B4y/UbrN7OWm7fP+CsoCTHuTM4cORP9K7UOVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKcEJwJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKcEJwJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2991F00A3F;
	Tue, 28 Jul 2026 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244296;
	bh=vns0tlxk7C8bBVdnIv05S1BNPahfXX1Lxmvhci83FeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mKcEJwJI+iahQ0Y/Jyo04if+r0C5BJmRYgxH9GAgcjlw2mHG3j1F1Lwqa21fOv9z8
	 hpVMqlZfcTuTVnhORm8SJOfexjZy8oMuhagcu1JwiSmpHcyusSqzbVMvFCX8Fh9hey
	 86gpHFhWEu0ogxPg/+aAuWb7tZrCF3oJdBpHlsulcysmyMyNBtwSGUHs2IFIvE8OeN
	 rmMTGZFhKVYIhT0+G2qbHvB1prablSjrdCB77JF1BUpqVZPTnYV5CleQMxJn3ZkdgO
	 YBMVxyLpMSWgHQP4WgkbVmm75Ly68OejP7V/GaOi90D4Z7blax3l7PGkqcVjKIhsHt
	 WakxVX2BLMaBw==
Date: Tue, 28 Jul 2026 14:11:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <amiqDkAxFx60biG1@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>

Ack on all my patches thanks!

Andrew - let's take the x86 patches from my series through the x86 tree, and the
core mm patches through the mm tree.

There's no ordering requirement in the x86 patches.

On Tue, Jul 28, 2026 at 04:07:43PM +0300, Mike Rapoport (Microsoft) wrote:
> There are a couple of CPA fixes floating around:
>
> Denis Lunev fixed races between split and collapse of the large mappings:
>
> https://lore.kernel.org/all/20260715183453.2381141-1-den@openvz.org
>
> Lorenzo Stoakes fixed UAF caused by races between CPA and ptdump:
>
> https://lore.kernel.org/all/20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org
>
> and an issue with stale page tables in IOMMU:
>
> https://lore.kernel.org/all/20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org
>
> Mike Rapoport fixed a check of RW attribute in lookup_address_in_pgd_attr()
> used for the verification of RWX:
>
> https://lore.kernel.org/all/20260715144519.934289-1-rppt@kernel.org
>
> Some of the fixes got merged into x86 tree, some of them got merged into mm
> tree and some are still hanging in the air.

:)))

>
> Beside the fixes there was a supposed simplification of cpa_lock locking
> that looked like removal of an optimization for DEBUG_PAGEALLOC, but it
> turned out that it was not an optimization but rather a correctness
> guard because with DEBUG_PAGEALLOC the locks could be taken in an atomic
> context and couldn't use plain spin_lock()/spin_unlock().
>
> The changes here are collected from all these fixes into a sinlge coherent
> set on top of tip/x86/mm:
>
> * update to cpa_lock handling with DEBUG_PAGEALLOC
> * fix for races between CPA and ptdumpi causing UAF
> * fix for stale page tables in IOMMU
> * update to the fix of the race between split and collapse of large
>   mappings
> * fix for effective RW computation in lookup_address_in_pgd_attr()

Thanks for this!

>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Lorenzo Stoakes (ARM) (3):
>       x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
>       x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF
>       x86/mm/pat: allocate split page tables as kernel page tables
>
> Mike Rapoport (Microsoft) (2):
>       x86/mm/pat: introcude cpa_lock() and cpa_unlock()
>       x86/mm/pat: fix effective RW computation in lookup_address_in_pgd_attr()
>
>  arch/x86/mm/pat/set_memory.c | 95 +++++++++++++++++++++++++++++++-------------
>  include/linux/mmap_lock.h    |  2 +
>  2 files changed, 70 insertions(+), 27 deletions(-)
> ---
> base-commit: a5a162fe1ae130e3d2ceefef3f43afe3773c1d56
> change-id: 20260727-cpa-fixes-d3c73c075672
>
> --
> Sincerely yours,
> Mike.
>

Cheers, Lorenzo
