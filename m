Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A463BD63C;
	Tue,  2 Jun 2026 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389185; cv=none; b=JcftKKd8sxc1OMyO5lAzfbv/PJtiWoHgt/GibC8vHjBOKjMWT/L2m3NhZvJdJGFUm1WIG9jcJ/ROj73vdxOlTOg2Y6M453XAuWpNqbv9Sy7Nu14K7h9k6hsNTbM6yZg6M95g7wPVog5fTUHLokqzV/Ley2jDOF621JEv8w3PpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389185; c=relaxed/simple;
	bh=bdX2Xt6j18Lg8V8SssoC+l+w8pPe1UrfZrht6WkWgJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYBeu0TpghZJmoGmPe0S9XswWZlPya8XwrteZCoO09hf3D6jLQM+VPSDnzh34T+xJevfJOGrh9lmy8byHfngmRmRNWAzeV1MrzLIYrdTy3JjonvYztPudw4uiEfZZ8nHSeHZoJXKaqLvZLrvbavm/q+mB7+FpnmlpenhYYpNB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhPA+n+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhPA+n+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A61F00899;
	Tue,  2 Jun 2026 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780389182;
	bh=6ImCYU+TtOZg2vTfWZSd4fkm9BzeEqJiDqaIVmGVhX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhPA+n+iHPnrTiQhiY+2njrnPuAKPmUMA1XLzg8zXiDW8Ur1i82vNx+RfsJaHbG/V
	 t7LbB5UhCxBdzaJgsH+Lvuq6RDqn9YeoBU8syoFnxCx8408jaBxPSYzu4Bo0magd+R
	 qUqAb6faRwucvYUwiOcr8ToMu/106/cWUy0iiey2TdjOO8+ez1b83N0mMkwbwL6mGH
	 odmbpkrqwFdeEaR3JsP3SgaX86XCV0HQFNbu3Ac0xCeTVpcwjH4xS+y5Oe5DYue6pW
	 xOhvUH3gY8D7rkv/tpgMPWHflYIBNWAxY4wlaO8LVww9UXDrQLnYP/FAT47uclaej+
	 pk4ioZzvUkOSw==
Date: Tue, 2 Jun 2026 11:32:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
	Pedro Falcato <pfalcato@suse.de>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6/6] userfaultfd: build __VMA_UFFD_FLAGS from
 config-gated masks
Message-ID: <ah6VNjfXXx-3Nh9l@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-7-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-7-kas@kernel.org>

On Fri, May 29, 2026 at 06:23:30PM +0100, Kiryl Shutsemau (Meta) wrote:
> The VMA flags bitmap is a single word today: NUM_VMA_FLAG_BITS is
> BITS_PER_LONG, so on 32-bit vma_flags_t holds only 32 bits. (The bitmap
> type exists so this can grow past BITS_PER_LONG later; until it does,
> anything declared above the first word is out of range on 32-bit.) The bit
> enum nevertheless declares some bits unconditionally above BITS_PER_LONG --
> VMA_UFFD_MINOR_BIT is 41, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
> actually carries the bit.
> 
> __VMA_UFFD_FLAGS feeds VMA_UFFD_MINOR_BIT to mk_vma_flags() unconditionally.
> On 32-bit that becomes __set_bit(41, &one_long), a write one word past the
> end of the single-word bitmap. The compiler folds the out-of-bounds store
> with wraparound (1UL << (41 % 32) == bit 9) into the first word; bit 9 is
> already in __VMA_UFFD_FLAGS so the mask happens to come out right today, but
> it is an out-of-bounds write all the same, and any high-numbered bit whose
> mod-BITS_PER_LONG position is otherwise unused would silently OR an extra
> bit into the mask.
> 
> Rather than feed bit numbers that may not exist on the current build to
> mk_vma_flags(), build the mask from whole per-mode masks that collapse to
> EMPTY_VMA_FLAGS when their feature is unavailable. Add
> mk_vma_flags_from_masks() for that, and define VMA_UFFD_MISSING / _WP /
> _MINOR alongside the VM_UFFD_* flags, gating VMA_UFFD_MINOR on the same
> config as VM_UFFD_MINOR (which implies 64BIT, where bit 41 fits). An
> out-of-range bit is then never materialised, on any arch, and the in-range
> fast path stays a compile-time constant.
> 
> Fixes: 9ea35a25d51b ("mm: introduce VMA flags bitmap type")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-8

Can you ask claude to produce more concise changelogs and better split it
to paragraphs?

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm.h            | 39 +++++++++++++++++++++++++++++++++++
>  include/linux/userfaultfd_k.h |  4 ++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0f2612a70fb1..485df9c2dbdd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -496,6 +496,21 @@ enum {
>  #else
>  #define VM_UFFD_MINOR	VM_NONE
>  #endif
> +
> +/*
> + * vma_flags_t masks for the userfaultfd VMA flags. VMA_UFFD_MINOR is gated on
> + * the same config as VM_UFFD_MINOR -- which implies 64BIT, where the bit fits
> + * -- so an out-of-range bit is never fed to mk_vma_flags() on a build whose
> + * bitmap cannot hold it.
> + */
> +#define VMA_UFFD_MISSING	mk_vma_flags(VMA_UFFD_MISSING_BIT)
> +#define VMA_UFFD_WP		mk_vma_flags(VMA_UFFD_WP_BIT)
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> +#define VMA_UFFD_MINOR		mk_vma_flags(VMA_UFFD_MINOR_BIT)
> +#else
> +#define VMA_UFFD_MINOR		EMPTY_VMA_FLAGS
> +#endif
> +
>  #ifdef CONFIG_64BIT
>  #define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
>  #define VM_SEALED		INIT_VM_FLAG(SEALED)
> @@ -1238,6 +1253,30 @@ static __always_inline void vma_flags_set_mask(vma_flags_t *flags,
>  #define vma_flags_set(flags, ...) \
>  	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
>  
> +static __always_inline vma_flags_t __mk_vma_flags_from_masks(size_t count,
> +		const vma_flags_t *masks)
> +{
> +	vma_flags_t flags = EMPTY_VMA_FLAGS;
> +	size_t i;
> +
> +	for (i = 0; i < count; i++)
> +		vma_flags_set_mask(&flags, masks[i]);
> +	return flags;
> +}
> +
> +/*
> + * Combine pre-computed vma_flags_t masks into one value, e.g.:
> + *
> + * vma_flags_t flags = mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR);
> + *
> + * Unlike mk_vma_flags(), which takes bit numbers, this takes whole masks --
> + * each of which may be EMPTY_VMA_FLAGS when its feature is unavailable -- so a
> + * bit that does not exist on the current build is never materialised.
> + */
> +#define mk_vma_flags_from_masks(...)					\
> +	__mk_vma_flags_from_masks(COUNT_ARGS(__VA_ARGS__),		\
> +		(const vma_flags_t []){__VA_ARGS__})
> +
>  /* Clear all of the to-clear flags in flags, non-atomically. */
>  static __always_inline void vma_flags_clear_mask(vma_flags_t *flags,
>  		vma_flags_t to_clear)
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 3ec8e1071673..68edac4dcd78 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -23,8 +23,8 @@
>  /* The set of all possible UFFD-related VM flags. */
>  #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
>  
> -#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
> -				      VMA_UFFD_MINOR_BIT)
> +#define __VMA_UFFD_FLAGS mk_vma_flags_from_masks(VMA_UFFD_MISSING, VMA_UFFD_WP, \
> +						 VMA_UFFD_MINOR)
>  
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.
