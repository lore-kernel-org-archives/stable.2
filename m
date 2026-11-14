Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682580;
	b=V/MXdhzqjqVPODgDuT4heBbscwSPxzCRO3R2qtApE4yxNj5tXqCCWx0GpTPA9ee7dbJe
	 rCNrdgG8otHB4yHFKKO1UhFkOEk5CF94nuDsBVn8pOFTviouq02VfiR7JCeY5dko4HEEN
	 PK9gYYIXWS0L4pu+FWCuw7XFxKTA35e3yFWWHm1y/dzwfkTyitA751DDs1hlocur9A2B2
	 AzY5S432Hf5jEGjseVZ2VzEjv9kE8DOW6PTL/TJe+orDbKtg94WaVhcOtR3MMwkl2L7wl
	 QHhkPe6wiDBJjNrIpempw+ba4vl3tlfp1K8huB/npWdGPUC2RKjvIP3IWxIZITN2leQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682580;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=//GruLIthFISZCy43B0WDxoPfxAVchEQzL1ze90Ia1U=;
	b=L4P0xdCpFqmrqjwmFECe9R2u0JqCuZyVQFxM+YfmvTPmjeV4S4rJXYreIDgUc0tGN1W3
	 XP7gfM4jXZYh/iMZiA1QcSbGrjrUsAgYuvzdKdkJYLWUH0lCxHeNO91/belpl7vN4wtto
	 H5IFvK19ycQX8Yx2nvACja3kNrsqZ7MJHc4SQxzIlRYcIrvb3s4Jcz2WP7n/bK+sbaIIL
	 V1m979161JBmOsTW7eft3T1rGQJiaqkzcRuPfxDoPMVGDJa60JoAuALsUT7QnYVk8JzUo
	 cUtbbXSYticcJSirf0sQXorj4vf9UeX7nXPKB17FWuhPQuzfLIjIjW8Ih8/pClEiI8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFXT4w+R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99C606A329;
	Sat, 14 Nov 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFXT4w+R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5C1F000C4;
	Sat, 14 Nov 2026 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682580;
	bh=//GruLIthFISZCy43B0WDxoPfxAVchEQzL1ze90Ia1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hFXT4w+RF00hYPkv+JLeIEZAjbBCTc5CY95xB7nG2ZeZC6xVNc/tyLfLCXLXXfzU/
	 0xwjpH4uqHfJv3b9jTPfEDI05f7epSGY7WNGrFU65nrM599kdWjAEstILA4u/ArbNH
	 FTR5pcJyhgtGykdCgnB9yTDQlTEGPmVB2LhUyMM/DydIocWWISlDCPO5SdDwgRJIHN
	 4wq5xnK84S73I5MUqu84dXHgKrRnMmjnl0JRhFS++dhSPVoIn0UZspmNkPF5QG60KR
	 Pr81J5yjOzly8Xwkbx+5AcxopvUR+FkweegBHOBezVZ17Bld0ubFOCo/dvixMRJFbK
	 Aqop4pp6GTflA==
Date: Sat, 14 Nov 2026 18:56:10 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Wilson <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Rik van Riel <riel@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: do not call vm_ops->access with FOLL_ANON
Message-ID: <aviukG1XPZw2Rja9@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-1-988a5c470db2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-access_shite-v1-1-988a5c470db2@kernel.org>

On Thu, Nov 12, 2026 at 11:08:57PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> Reading /proc/<pid>/cmdline or /proc/<pid>/environ can block in a device
> driver, or read device memory, if the virtual addresses point at a device
> mapping.
>
> Ever since commit 7f7ccc2ccc2e ("proc: do not access cmdline nor environ
> from file-backed areas") we use FOLL_ANON to only read from anonymous
> memory. While GUP properly handles FOLL_ANON, __access_remote_vm()
> will fall back on GUP errors to vma->vm_ops->access() without similarly
> considering the flag.
>
> Fix it by not calling vm_ops->access if FOLL_ANON was specified, to
> truly limit it to anonymous memory only.
>
> Fixes: 7f7ccc2ccc2e ("proc: do not access cmdline nor environ from file-backed areas")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> [ david: simplify description; slightly rework implementation ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1a0ec09c56fd7..d4370c1b331c9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7398,6 +7398,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  				continue;
>  			}
>
> +			if (gup_flags & FOLL_ANON)
> +				break;
> +
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
