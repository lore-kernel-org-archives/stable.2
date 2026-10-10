Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCED381EB6
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598472; cv=none; b=XeePTEhLtcK18QFWvSRiNSXnkW31hnclONlPCen480UW4lwL1qXZDYptNhu9Xsw1pDzXnwT1owBtkkl9cZmmNPnm1rltrBy2Z0EmGHerz7aoGWyHJFMs07ke7te6NJl0jnPYFTX7ffgrN5hl6ep9CUjcUL6p6eRQGq7Y7W8PjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598472; c=relaxed/simple;
	bh=8M5YOEIrXDD6XLd1ZsIBaFlISHd8WA2lKAFGHUrHgzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEctasDybC20RKWh9ojyqQzP6RouaS2U2R+wwl+iHWDGFYTZGxL+NZA98hdwf8jhTIlfRTiMIYa+uolQXE2jeSXCAB3QnVZ8JErbPSHHn2CG72NT5bpgSJEj0Yf1SFFySekyTvGHMSa9RCmNpAERUSkZlgejH5vX324n5YYo1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=a5PRAD4X; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="a5PRAD4X"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so228489b6e.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791598468; x=1792203268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewsgbjqBMzM/54gVEY1eYtAsThNx/wBnYzgn18kV244=;
        b=a5PRAD4X3iPG5iL2hThLNfvRl79MBO4SY0SxpYHKQcWc4AZHIJaK62S4tnsh+aLMZb
         QrtBO4d5L1j5kCEfvIF0Odn11YXgiRL8wk2nSisTQ6uI8U5+eF3yCyGFIjUS0TKg0OIc
         Txoj+pMkv1pHY4Kmw4pwAqstaz0bq7P+0s1kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791598468; x=1792203268;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewsgbjqBMzM/54gVEY1eYtAsThNx/wBnYzgn18kV244=;
        b=cG2SIw3wH7ZUl4RvMon5tu3xAM48Rev+cvC8qLxjkY8vTGuTjlxK+jvrvJ8EiDmVzM
         KP/twJkva0JWXIkuVhHky+ylq3D42cCux5RDB6ubEaIaW9zwh6wnP+omKRgsw0HDJmNS
         KwKR84WkI+ubqnnXNIyMWac5YCFcJq8GhgP6ejWPmetNFplHAzy2bbMnhR16x7K6bH8Q
         2TBNOwOvepdDfsKI80wb/8spwBuflaRF0Lm8rZqxbCeOdIT0pZ9DHIuouM5yYCDGlSDf
         0A/bG8dR7Ju8gQzET2opzPsQnfbFISarBIkFWBCn9O8GK3+YuKyfu1hK5BZkccbLSsuI
         wMdw==
X-Forwarded-Encrypted: i=1; AKwUvBzr29pYvWcbnlBD46GOqv9jRPFAPbdFkyqWEQJNyXaAOWnY1g/sesgV/S/ZMZH4axujmK9cd7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMUFX9kGufIY6F7Xn6u0uoQwvgA2UlvFznCXIkTu5xLhLofU+8
	N40gJMDTCVe9ZIeqVIVkn/sVpcBhUj36QF5EpfSYzHAnUMzhfyI/TmzYxgYQ4amFiaLxkQ2FB02
	CCw16RQ8=
X-Gm-Gg: AYBFou0LIYoe+DmzpKgKxCrBzxJCo/GGMGdZxBDQ1T33BAa4toKopw87Z16VWEqYWMp
	h8rm01eSZTNoM5gbprQ4m1PTZbIw4j1z7jBpHu3uDXsQt6AGeS55oTwZegTQ/thFOxC0GtufKxS
	Rc8Bh/lJgHcFNaH64q60df9KO6u6+TBmKBeVAn7gXjkpJkY76tBQJsc2HPuiYDN7pHioIEJtICW
	/k2TFDP89dgXaNFJPqEKAkTOwv/g4P1VgoO3GKzW2C+FCjg4zXBcbQzoRTB7Hbo3dtQvutZ2xPN
	69rCqPuCP0CZZAJxTCF/qub2DeKUAMXd55a1UJU8TWp8/ja1+ntVfIfMdfA1WgxKPxOoDCPlewV
	LXd9Beb28omFTM+VQv6r0qqiX67WDZpe/tQUUNVHPYTgtkM0DTsWuMQdnY7hLhb/fxgWEvivRmP
	1lsOIleAP9oupOsq1G7IpPd6H1cjzCMmfyXz+fjyfOc1QeimyMrP5rwSdqJERxoTbLsOHfHSzh0
	8HaiB1B96OIll/pYYwFt9LxiXKkl0zjrWOlXCmMk2xmiNbQanru/g==
X-Received: by 2002:a05:6808:3384:b0:4b9:a8ac:489 with SMTP id 5614622812f47-50c52a4eb8cmr3292704b6e.39.1791598467997;
        Fri, 09 Oct 2026 19:14:27 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm4211994b6e.1.2026.10.09.19.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:14:27 -0700 (PDT)
Date: Fri, 9 Oct 2026 19:14:22 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <asmffmSz9MSjxD04@com-75606>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>

On Fri, Oct 09, 2026 at 10:08:18PM -0400, Zi Yan wrote:
> __discard_anon_folio_pmd_locked() clears a lazyfree THP PMD before it knows
> whether the folio can be discarded, and restores it if the folio was
> redirtied or has extra references. A concurrent munmap() or
> MREMAP_DONTUNMAP skips the temporary none PMD and unlinks the VMA from its
> anon_vma, so the folio stays mapped after the anon_vma is freed and a later
> rmap walk uses the freed anon_vma.
> 
> Using an invalidated PMD instead of a cleared one requires additional arch
> code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
> shrink_folio_list()").
> 
> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> The proposed fix[1] requires additional arch code fixes[2]. Disable it
> first for stable fix. The function will be re-enabled along with arch code
> fixes.
> 
> Link: https://lore.kernel.org/all/20261009165214.40212-2-kylebot@openai.com/ [1]
> Link: https://lore.kernel.org/all/DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com/ [2]
> ---
>  mm/rmap.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 805db93fe0428..1131b76bbbc28 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  		}
>  
>  		if (!pvmw.pte) {
> -			if (folio_test_lazyfree(folio)) {
> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
> -					goto walk_done;
> -				/*
> -				 * unmap_huge_pmd_locked has either already marked
> -				 * the folio as swap-backed or decided to retain it
> -				 * due to GUP or speculative references.
> -				 */
> -				goto walk_abort;
> -			}
> -
>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>  				/*
>  				 * We temporarily have to drop the PTL and
> 
> ---
> base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
> change-id: 20261009-lazyfree-stable-fix-67712b2049dd
> 
> Best regards,
> --  
> Yan, Zi
> 

Reviewed-by: Kyle Zeng <kylebot@openai.com>
