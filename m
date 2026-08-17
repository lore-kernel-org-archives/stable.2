Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7332B131;
	Mon, 17 Aug 2026 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945903; cv=none; b=EnnRWnhFXhb/kHEwnaz3PZmzbUZyvhsUObsnMVkwmgiWs+g8batYIH5ReCjRFW+Fs/VUgoFo9iPu7/mHngoN89PptI4Gtpl7uQzOYS2BpL9zDmiS8eLLpF/1vtM+NxoKgLePjReLGIdVv5ub6wMtfbAi/hmKCWjUxOWrJIFlMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945903; c=relaxed/simple;
	bh=YSYOP8MdQKz8Mamy8EjTxufZQVa9pRaebBJsJfp5qO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkRP/zo1GMdDplqwY2IHMTYZIvWJkBR/woVwNP8mFxyP0ESriuXO7EhRk8AWjGMf+/JzFdHFZOce83m9dCfUJzY6TRynVbZOqU/Av3R+3OgZ48N8jdkTsJ3CTiVYpt8TsGEI967Trs8+MfcVrrc9FBgEvoupq3YmR+/ONbcOugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2gKdWFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2gKdWFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9EC1F000E9;
	Mon, 17 Aug 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786945901;
	bh=49GLJIYRy4vZ3cG5rYKQJNFQilEnE70SWvjy9to5mKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2gKdWFh05E+WTUIOy6fVlmJoZ3AvzL3kKF6IpS67NmfM0FfdNGCl0v01yMKbnGC5
	 gdYwLQP5f3+qFGLh37gfG4MPQtnrkZ/Ly5TzzUuhdbxJEpKQzEOewIjVencSyP5sWg
	 qePR8aIdDUEXfbYtP2RFGB7IRpDpKJR3GnykUJ5p1yZFfcoxDTNJNy80cVP7Zr10ZY
	 o6S9F93N96hliFB9V0GwS0CS0qP5agd9pNj/qum8Hcal7Syo8NGbz0OdNbKfOqpKWA
	 zjROHDvoZF+n5TBVvlruFBx7pLDYILQsS0OoalotCdVlBLjku764siAifLFJzQ/S6M
	 X8q/9FNobYH5A==
Date: Mon, 17 Aug 2026 08:51:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kiarash Azarnia <kiarash.azarnia@gmail.com>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix signed shift UB in
 kho_preserved_memory_reserve()
Message-ID: <aoKhZqkTNUJGpOEf@kernel.org>
References: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>

On Sun, Aug 16, 2026 at 12:30:37PM +0330, Kiarash Azarnia wrote:
> kho_preserved_memory_reserve() computes the size of a preserved
> reservation as:
> 
> 	sz = 1 << (order + PAGE_SHIFT);
> 
> `1` is a signed int, so the shift is signed-int arithmetic. For order
> 19 (a 2 GiB region) it produces 1 << 31, which is unrepresentable in
> int and is undefined behavior; in practice it yields 0x80000000,
> sign-extended on the assignment to the u64 sz. For order >= 20 the
> shift count exceeds the width of int, which is also undefined. The
> return value of memblock_reserve() is ignored and memblock_cap_size()
> clamps the bogus size, so the kernel silently reserves the wrong
> amount of memory for the preserved region.
> 
> kho_alloc_preserve() caps order at MAX_PAGE_ORDER and cannot reach
> order 19, but a boot-time reserve_mem= region of at least 2 GiB drives
> kho_preserve_pages() to compute order 19, and kho_preserve_pages() is
> EXPORT_SYMBOL_GPL(), so the path is reachable.

This looks like LLM generated, please make sure to add Assisted-by tag next
time.
 
> Cast the shift operand to u64 so the arithmetic is done in 64 bits:
> 
> 	sz = (u64)1 << (order + PAGE_SHIFT);
> 
> Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiarash Azarnia <kiarash.azarnia@gmail.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 175c08a6e41e..c79f48bd64ac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
>  	struct page *page;
>  	u64 sz;
>  
> -	sz = 1 << (order + PAGE_SHIFT);
> +	sz = (u64)1 << (order + PAGE_SHIFT);
>  	page = kho_get_preserved_page(phys, order);

This is already fixed:
https://patch.msgid.link/20260727150240.889555-1-pratyush@kernel.org
  
>  	/* Reserve the memory preserved in KHO in memblock */
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
