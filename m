Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618791;
	b=2xAu5OyosMOGgwbAF5xdoVA5VHMKkgQuZx+7CmGE7uZSWFEHtV9sM9ZXi8BAVNnecUfP
	 +3MzWeYOnjupg36gjsUC0gI0ZGmkDpSfs3zHrY9Q4Wdj9lAE4O4Sn6BgmjAUzTi2rf6Z1
	 uWDLCh6/EpUjLkmtGwD7Peva6+c7K/4seoFvc8+81XvI6hs0O9P1eLDDrq6BqpyQsrMSy
	 aK0x9EqJFgC+1+yN0wQfTCiqmHq8uSQy+eP8WE24PL7d2u+Tg4SIbrT7HHMY/IFbwM5g7
	 UDniyCdaO5aMEya/HOQ7i9h4fEqGowoGM1XOAVU6P5rV0sPuR9j2mhLIC0Wx7uiLPwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618791;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QmCu5AKk2S3c57ZAB2ojsPsTfvTf7eCUQPKcTVLaD0M=;
	b=qbWxB6BlitBkkPx3wvW/BKBuZT+c0/BQumrFJ98ppwL4n1n5CQHMr0ik/KiEu+gcmWu1
	 J/lUJpehMWiGswZy2a64h8jSlOtGJOpw4E/YGzJgKNLVcEsyzpb8JF3M3ZLIxNX+KkpHX
	 WOzlDocMaBCR4kq9VLPlZsqStlWmWICDN+K64KzrXmtS7Z/Ja5Uat8d82hP0szDPY7MD2
	 fQqJz3M2ydNi8wnxpnbi8JyQVzQuT9Jk4huGVrdYwahT+WB9t51NtRvky/L/4loUvFuvc
	 R3GfEUTSCHpPHJYco8oLDWF6XrUUm1uUpEWgXolX96ygElxW2ETGBc5herhZZ96ptCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="n2x5Zi8/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC9606A327;
	Wed, 25 Nov 2026 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FC9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n2x5Zi8/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3742F;
	Wed, 25 Nov 2026 06:59:46 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6733F632;
	Wed, 25 Nov 2026 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795618789; bh=BL+q0fknC9F7rKqq5zcQg0XNAF41khT3DRJ+4gVKlts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2x5Zi8/WqfDNOnZ6v9d/sVFIIVK3FMWV+exGow74TZqDh+OF+L9kGMdRL71y4deS
	 kBbGDLfBxbCgRa1uIz9HVyDIkbjvjOq/aN15MGozvmdW4VHhX9JmGNFqCDH41dnQqB
	 4rGAC1SeG9p2mb/uwMuB28ncr5OZGq1lDXL6PjZQ=
Date: Wed, 25 Nov 2026 14:59:45 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: will@kernel.org, mark.rutland@arm.com, ying.huang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com, robh@kernel.org, gregkh@linuxfoundation.org,
	ptg-linux-kernel@linux.alibaba.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: fixmap: fix missing break-before-make in
 __set_fixmap()
Message-ID: <awb34Zfblg-A1tHQ@arm.com>
References: <20261125063224.553-1-yadong.qi@linux.alibaba.com>
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
In-Reply-To: <20261125063224.553-1-yadong.qi@linux.alibaba.com>

On Wed, Nov 25, 2026 at 02:32:24PM +0800, Yadong Qi wrote:
> __set_fixmap() installs a new PTE with __set_pte() but never invalidates
> the TLB; only the clear path calls flush_tlb_kernel_range(). The
> dsb(ishst)/isb that __set_pte() emits makes the new PTE visible to the
> table walker but does not invalidate stale TLB entries. Overwriting a
> still-valid slot therefore leaves the old translation cached and
> violates break-before-make: accesses may keep hitting the old output
> address, and changing the attributes of a cached entry can trigger TLB
> conflict aborts or CONSTRAINED UNPREDICTABLE behaviour.
> 
> Two in-tree callers overwrite a valid FIX_EARLYCON_MEM_BASE slot:
> 
>  - earlycon: earlycon_map() maps the UART before match->setup() runs.
>    If setup fails, con->write is unset, or the DT reg-io-width is
>    unsupported, the slot stays valid but no console is registered. The
>    console_is_registered() guard only blocks successful registrations,
>    so a later attempt (e.g. a failed DT earlycon followed by earlycon=
>    on the command line) remaps the slot to a different UART.
> 
>  - samsung_tty: apple_s5l_early_console_setup() overrides the
>    just-installed entry from PROT_DEVICE_nGnRE (FIXMAP_PAGE_IO) to
>    PROT_DEVICE_nGnRnE on the normal successful boot path.
> 
> Both are valid-to-valid changes (different output address or memory
> type), which arm64 requires to be break-before-make.
> 
> Fix this in __set_fixmap() by invalidating any existing valid mapping
> up front: clear the old PTE and flush the TLB, then install the new PTE
> only when setting. The old translation is gone before the new one is
> created, so the two can never coexist in the TLB. A first-time mapping
> (old entry invalid) skips the invalidation and pays no extra cost, and
> clearing a slot is handled by the same step.
> 
> A clear (!flags) always clears and flushes, even when the PTE is already
> invalid. An invalid PTE does not imply an invalid TLB: another CPU may
> have cleared the PTE but not yet completed its TLB flush, leaving a stale
> entry cached locally. The unconditional flush preserves clear_fixmap()'s
> TLB shootdown guarantee, which callers such as the KVM VNCR unmap path
> rely on when racing with a remote invalidation.
> 
> This belongs in the callee, as on x86: __set_fixmap() there calls
> set_pte_vaddr(), which flushes the TLB unconditionally after writing the
> PTE. x86 can flush after the write because it has no break-before-make
> requirement; arm64 must invalidate and flush before installing the new
> valid entry to avoid TLB conflict aborts.
> 
> Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
> Cc: stable@vger.kernel.org
> Reported-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>

Nit: commit 9aac5 added earlycon_map() -> set_fixmap_io() but I think a
a few other commits later caused overriding this fixmap entry. I think
set_fixmap_io() was underspecified, not requiring a clear_fixmap() after
use but they inherited the x86 behaviour already which did the flushing.
Anyway, I think a better tag would be (to make it arm64-specific issue):

Fixes: bf4b558eba92 ("arm64: add early_ioremap support")

> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index 951004ad700c..5da49e201b6f 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -126,13 +126,49 @@ void __set_fixmap(enum fixed_addresses idx,
>  
>  	ptep = fixmap_pte(addr);
>  
> +	/*
> +	 * Break-before-make: when the slot still holds a valid mapping
> +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
> +	 * old entry and flush the TLB entries caching it before a new
> +	 * mapping is installed, so old and new translations never coexist.
> +	 *
> +	 * A clear (!flags) always flushes even if the PTE is already invalid:
> +	 * a remote CPU may have cleared the PTE but not yet completed its TLB
> +	 * flush, leaving a stale entry cached locally. Take KVM VNCR unmap as
> +	 * example:
> +	 * When CPU1 wins atomic_xchg_relaxed(&vt->cpu, -1) in unmap_l1_vncr(),
> +	 * CPU0 calls clear_fixmap() on its own slot so it cannot finish
> +	 * vcpu_put() before the local TLB entry is invalidated:
> +	 *      CPU0                                  CPU1
> +	 *                                 invalidate_vncr()
> +	 *                                 unmap_l1_vncr()
> +	 *                                   atomic_xchg_relaxed(&vt->cpu, -1)
> +	 *                                   clear_fixmap(vncr_fixmap(0))
> +	 *                                     __pte_clear(..., ptep)
> +	 *                                     <delayed before TLB flush>
> +	 * kvm_vcpu_put_hw_mmu()
> +	 * this_cpu_reset_vncr_fixmap()
> +	 *   unmap_l1_vncr() == -1
> +	 *   clear_fixmap(vncr_fixmap(0))
> +	 *     !pte_valid(__ptep_get(ptep))
> +	 *     <skips flush_tlb_kernel_range()>
> +	 *                    <stale TLB entry still live on CPU0>
> +	 * If another nested vCPU then schedules on CPU0 and calls
> +	 * kvm_map_l1_vncr() before CPU1 finishes flush_tlb_kernel_range(),
> +	 * __set_fixmap() also sees !pte_valid(__ptep_get(ptep)) and installs
> +	 * the new PTE while the old translation is still cached in CPU0's TLB.
> +	 * Unconditionally clearing and flushing when !pgprot_val(flags)
> +	 * preserves clear_fixmap()'s TLB shootdown guarantee.
> +	 */

There's too much text here. Move it in the commit log if you want and
just write a few lines in the code, something like:

	/*
	 * Break-before-make if the slot holds a valid mapping. Always
	 * flush on clear since another CPU may have cleared the pte
	 * without completing its TLBI yet.
	 */

> +	if (pte_valid(__ptep_get(ptep)) || !pgprot_val(flags)) {
> +		__pte_clear(&init_mm, addr, ptep);
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	}
> +

With these changes,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
