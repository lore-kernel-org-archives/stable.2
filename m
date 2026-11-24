Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536661;
	b=ftAQy9OdV5AVWQLUXloDwMXb7qMB5Pzpq5viQcIC0jduN/yW9a1wCxmSupySPMoHoHYt
	 z58qKTWr5Q0Gpr+ikzgrN2KMXVHZSYVZapFCFPS9stUKKkctic/4ZTq5zmM4sUvAPj7Wj
	 ICmGrLu9Gx31535SiN6XvzfNHeOv9x0TTSZaYfZZjImF5qnQOuPrisqGd9wiHmBRF5yBO
	 EaejUJ7SSeOxFtT/czlF0wO5pF33tMDPbW9D3ayqV7uaT6I64q+40rD6l7OS6vs6JY7es
	 acc96qKQT14uKTWewSdYJR0OrsIR00aGaTKYtI0L7wu+7asg4RHM+Y/6fv/vk8Nze6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+3hZmmjdGAbIUFaURgCd0rN5E6bZhKjLrYHk5hB6lCI=;
	b=tb9SrkfQa56hZdWX9kDhnN7KEZxkdaTadLZlQtsxSgfZE+Cg+rnYpGAKQf/zSH5BE1OV
	 Mk9XVt6tcctdoqO5EjbSMwGxBU3U0nyRBlgkYkTKgbYnrzxkoabQzltyhrhwHt6PYtgIh
	 PdZUVCUpO+WytxgGU8ULmEao01dEikMiUKhI4zquTLzD/GkmX6jPgBslyZsOWfqNfVymB
	 BMGSUtTsQW5ck3yn7BV3DDHl4plTOTbgXnJ1kxGiD7jAWk4fJLGJq08OXN8L0aX+FDsvC
	 RdDuYeWMN9fJE6/jBs3q1PEpSsIj6+EcJxR6bdYU05GuOfZOxHZTn9vlWE+vDA1ot9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uyS0uad2;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE847606A321;
	Tue, 24 Nov 2026 16:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE847606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uyS0uad2
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C981339;
	Tue, 24 Nov 2026 08:10:57 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6AF3F86C;
	Tue, 24 Nov 2026 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795536660; bh=p/KCMH8AjHrrntbvJyfGXGcKxAMK6NHv+k3lXnBmCdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyS0uad2H7yAitY7PNlw/9nw1YVzLML57ue2KgWGcaUzqiW9okVo6dD7IudPE7I83
	 FKpHSfeoU0gmH9JG9neCn4nxwb8+xw29BkEoutD3khGr4+0Qu9BokM4oQgBoN8r8wG
	 ulNaTgZfZ2RXvPyCp11l5KoqT26Wx3K5WqXHhibc=
Date: Tue, 24 Nov 2026 16:10:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: will@kernel.org, mark.rutland@arm.com, ying.huang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com, robh@kernel.org, gregkh@linuxfoundation.org,
	ptg-linux-kernel@linux.alibaba.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: fixmap: fix missing break-before-make in
 __set_fixmap()
Message-ID: <awW3Dw743-rw_-cf@arm.com>
References: <20261123093505.974-1-yadong.qi@linux.alibaba.com>
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
In-Reply-To: <20261123093505.974-1-yadong.qi@linux.alibaba.com>

On Mon, Nov 23, 2026 at 05:35:05PM +0800, Yadong Qi wrote:
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index f66a0016dd02..5593d7e0d523 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
>  
>  	ptep = fixmap_pte(addr);
>  
> -	if (pgprot_val(flags)) {
> -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> -	} else {
> +	/*
> +	 * Break-before-make: when the slot still holds a valid mapping
> +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
> +	 * old entry and flush the TLB entries caching it before a new
> +	 * mapping is installed, so old and new translations never coexist.
> +	 */
> +	if (pte_valid(__ptep_get(ptep))) {
>  		__pte_clear(&init_mm, addr, ptep);
> -		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>  	}
> +
> +	if (pgprot_val(flags))
> +		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>  }

I guess that's easier than getting the driver or earlycon code to do
clear_fixmap(). Note that I queued Fuad's patches for missing barriers
onto arm64 for-next/fixes, so please rebase on top.

Sashiko also has a valid point about keeping the TLB flush unconditional
for the clear_fixmap() case:

https://sashiko.dev/#/patchset/20261123093505.974-1-yadong.qi@linux.alibaba.com

-- 
Catalin
