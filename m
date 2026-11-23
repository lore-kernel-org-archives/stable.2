Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454439;
	b=YzxKjIp8c3HN53AnStg+Ghze9NtDCZH/+Lf63linj8i9+UlmQtNGujFbaW32OOLt8wc/
	 Yn4LhMBkwZbXJYEaJkS4HP6CrZwoRV1pkQhaxR5GRAST0CTN1h/hBQvpNAJKClZZiRTqU
	 1GBeh6RYjVy5WsurAsdnwXEKLyCRQh45Yevq7urg6tzr3egTXchuoIj4XW6kA52g9TdSf
	 1S0C9TrBgyAlUbNkeqfJWZYfIiDMhKF7LDdUh6bIilazM3gEKKjRvh3KOoxncb/XwimSd
	 YQ8/hgTI5Cb3+S1h4/SKRWVPzs0GIDxVn1o8Auq4fsXmDmpn11a5qzBNX1y+xGz0Zww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454439;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cIMG3GuotDWafza35SJT3j9PzXDW+c0cLhrovo6/hu4=;
	b=KhWyjncEuoUnU7ASnmSVk+bIEvrEwhe4tt6FSMFzvJ7/A5YJ7WY9DqqMxCfIjBJRvgZu
	 rZj/xcQkOOf3Mf01IxpmedLZL7Zb2yMvBhMM0thLYSdNfkJJBWHDjyAAIVh1nUH10Hemy
	 ZTR5Ta7UcgB8C51ObdqtOGGq6iXZ3HYzx8CBDFtjzh8zb1iezC3dT/5gGCb1FpYvgHYP0
	 RcWe/orP96LctZYoO6nFyA6sR/wI2aE8Sg8/h08kqF+k4xz5+A3ITkpy2goc+wmNXDg7J
	 1/Y9jNuq/Gr8BEXPI9+uCovqqPjRjWlgMCcNnGjgzxyI3hlS08shaJpWeKl79VtC/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ou4o6cs7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2040606A31A;
	Mon, 23 Nov 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ou4o6cs7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12201F000D2;
	Mon, 23 Nov 2026 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454439;
	bh=cIMG3GuotDWafza35SJT3j9PzXDW+c0cLhrovo6/hu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ou4o6cs7SWT8jjNrRrYjJhEUt0jj/4mPU0LuSDBtgg3QQoEUyrthXCncjCJYqjSvv
	 CgOdMJM6dUIJWzEElfWSiW+dmbqti8sfrqORheD3Nn/+esjuBCmU/IESFQ66DcjIRj
	 P6Htxk55smefV1SBgrt3Yz4jea+CHM5ndo+U1wVDy3Gv3NuaYdlkUIJxFAOBqChKqk
	 mXGEEkoglH25k10nr0rFfAY5exXbT5xIpA4643WuWkriuGEIW6K9L/lLT2kUdlM6Iy
	 0L+/0jy3HpThuW8qHLW2ss68S39npAuZXI56L0o0tIoyH9E7VeGzpq/II5znXzhGtP
	 t/I1CpQxyiqhA==
Date: Mon, 23 Nov 2026 17:20:28 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mm: don't PTE-batch a swap-in of a folio with a
 hardware-poisoned page
Message-ID: <awR1zpKGgJrZQQPx@gremlin>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
 <20261123163301.1568240-3-usama.arif@linux.dev>
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
In-Reply-To: <20261123163301.1568240-3-usama.arif@linux.dev>

On Mon, Nov 23, 2026 at 08:32:08AM -0800, Usama Arif wrote:
> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without
> looking at its other pages. A poisoned page that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
>
> Skip batching for such an anon folio and let each page take its own
> fault, where the existing check catches it. do_set_pmd() already backs
> off the same way.
>
> Leave a freshly read folio alone: it is not anon yet and can only be
> mapped as a whole, and falling back would free it with the poisoned
> page still in it, which the retried fault can then get back from the
> page allocator.
>
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Neat! I didn't even know about that function :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 282266dd5e5dfa..d7b200e00bce17 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5194,6 +5194,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		pte_t *folio_ptep;
>  		pte_t folio_pte;
>
> +		/* A poisoned page in the folio must take its own fault. */
> +		if (folio_test_anon(folio) &&
> +		    folio_contain_hwpoisoned_page(folio))
> +			goto check_folio;
> +
>  		folio_pte_range(folio, vma, address, idx, &folio_start,
>  				&folio_end);
>  		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
> --
> 2.53.1-Meta
>

--
Cheers, Lorenzo
