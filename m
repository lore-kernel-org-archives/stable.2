Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258915;
	b=wQPXE5v4FI/0uTftG1CxqNmEKz5JuEmIIH/TTj0ApWMk3Z6lvVJ+4slurT+UQwcsEpaY
	 ehJXMsqCxaBYQpPX+qrwvvSw8r6tuQ5i6OabgnCfpwHZ8qP9E/52r+kPZ7SyGcpjl2QkZ
	 Ff62hAyG5y5nC9OUgmw46+en3gjKu7+C6nCSMa+/CAutKCGJlt19tS9/zTs06H8kk/w0/
	 h1BoK/6CTM321kXBo1mPlITh0Lzy796xg859EF2Ys7hPwB1nMDpV/I2pO0U5oypc5sJGj
	 ltX+24E5jjoF4LXnpWD5eeaOiPa9iI7BpDZEwNM+wG1gBgp6PXNw9KOn1oDM0TatLvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258915;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TWf+jlBIQBGwk4QT4KRo+cGa7wFWGG2xF2hmkjUB8u0=;
	b=DSAPAyNCi+GsU3aG11K1zNX+2Reo7+W1kG50RB37Jr/bx39d+7jugMZ+FemQpXpJbd6+
	 eD4DqMbJMzQSu8tnU8uIexhUaGT6QJD22SS4XEkdtwgL6gqEwcJHQObfy7+yCyaLEhHft
	 8XHKTpkU4yRFDiK1CtU25iqmBrGd3psNGtqj4c177aRxbFBxjMYAbcP3GJ/L9SMpeFKUA
	 mcQTXLQm1e6SU8xp+48GOdBR9/9XcwTSIBVxmdWXPBQr+ehhmvR0aErPwWscZ/ZTryVjJ
	 1MgicW7DyIFZGQ7m167LYc5Wjdrsxzy/8SWj3uKx+mVywKun/nfkH1kWyp4zLHQbf1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m+MLl17U;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2370606A320;
	Sat, 21 Nov 2026 11:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2370606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m+MLl17U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B29761575;
	Sat, 21 Nov 2026 03:01:50 -0800 (PST)
Received: from [10.57.93.173] (unknown [10.57.93.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85D23F673;
	Sat, 21 Nov 2026 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795258913; bh=b606/LbDulrarsbGOfDsZnPHYpPyDvJEr5RossCWTCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m+MLl17UBpYuoJHPoix2uCTLkZOTjwAdDBLO2DuGlFrb/3ap/qbaoRqkWqHw5FDPJ
	 rYPl8cGGuPCr3y3My2HROvuBYmb8cU5lAsrv89CKDDSQ+Linu+MNsLN6Pb5ivVmjW3
	 OFeIq2rlrbSU+itEgTGbAVIriMtbruJm30MnGltQ=
Message-ID: <6782b5ee-3dfe-4076-a79c-fbeb2c2ac7da@arm.com>
Date: Sat, 21 Nov 2026 11:01:49 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: mm: Don't defer the barriers when installing a
 fixmap entry
To: Fuad Tabba <fuad.tabba@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
 <20261120121638.194154-4-fuad.tabba@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261120121638.194154-4-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 12:16, Fuad Tabba wrote:
> In lazy MMU mode, __set_pte(), which __set_fixmap() uses, only queues
> its DSB and ISB, but a caller can dereference the slot as soon as
> __set_fixmap() returns. On a CPU with BBML3, runtime changes to the
> linear map are made in lazy MMU mode. With 4K pages and 39-bit VAs, for
> example, such a change can update a top-level entry, which
> set_swapper_pgd() writes through FIX_PGD. That store can fault, and the
> kernel then warns about a spurious translation fault. When kgdb stops a
> CPU in lazy MMU mode, its breakpoint writes through FIX_TEXT_POKE0 can
> fault the same way, and fail.
> 
> Emit the barriers directly in __set_fixmap().
> 
> Fixes: 5fdd05efa1cd3 ("arm64/mm: Batch barriers when updating kernel mappings")

My memory might be betraying me, but I think this change went in before BBML3
(BBML2_NOABORT)? In which case, the bug is only exposed by the latter series?

> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> --->  arch/arm64/mm/fixmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index f66a0016dd02d..951004ad700c3 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -127,7 +127,9 @@ void __set_fixmap(enum fixed_addresses idx,
>  	ptep = fixmap_pte(addr);
>  
>  	if (pgprot_val(flags)) {
> -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> +		/* The slot must be usable on return, even in lazy MMU mode. */
> +		__set_pte_nosync(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> +		emit_pte_barriers();

I wonder if it would be clearer to wrap __set_ptes():

lazy_mmu_mode_pause()
__set_ptes()
lazy_mmu_mode_resume()

I notice that ptep_try_set() is also using emit_pte_barriers() directly, but
that feels like a layering violation to me.

Thanks,
Ryan


>  	} else {
>  		__pte_clear(&init_mm, addr, ptep);
>  		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);

