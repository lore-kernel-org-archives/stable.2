Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACC3F105D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526611; cv=none; b=u+Cdnv/xBtrZYK570DwZlbDhyYq7QtOLWsHtBwUtlANEy1PNunw5/60w2gtJqDvRYebNd6I+PL0HuM6Ud98GsCgW6TiC9BJG6GjQNn8g7gFWsUjHqK7+OLlY6h5o1KPri6JirAocumqYEo5slJD9/iK0SJxoQzlO/yDFPYdU9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526611; c=relaxed/simple;
	bh=Qqm/xOnxE62/wvgOjhIU1u3xn+YPCeDLxc0PlMRCH7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uyMW8Vs33vJ9tLYuz8gIPwpQ7A3QC/aUzewIAGZ/4Jr7fe60U1g0fCBc5myu9xIM/W0owLvnx0qoT+DDorsduxAxs/f4SOnA///Gs5CKKB8fLC1nRvsMxXkunQgoCuEeK3aaRVUXjE0HGVR3dp7eyO4B2xpJ0tDuBtP5Q0M9j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRlQEJFy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRlQEJFy"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8a83d2706fdso50440797b3.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791526609; x=1792131409; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWW6pSaXaHUM1wAEC6gE0iO0re0mXFQVa9Pv7/vaQG8=;
        b=bRlQEJFy2R7r5SAIKw5xm0jJ6kfnMekQY4sFvw7cegAa4jhIfd3JR9eUSi32HJnW60
         dHkrwpOMvVitYXF5QKt9qRCK8OYs89etGsM9HedL9vy86RhrOGNYqta07b/9RXunGdPq
         a7X6y7wxvPgL4FSQH40Bqo9ck3QqJlRbjBX6tmitj5VnPQ9jICc26ZcyC4TjPMKabJXM
         dmjkuT35BrkyIBiJ2qzmKuQoPHg586q2rRko6pc1F0tau6ohvZxX/BHytKIIgTOUK/mX
         jyoQK1gjdEGcu7dsE0iRUB1ppntVDJ6DPyHHy5HawTCbQUrqCM3oG1qmYECByIfZhBM2
         r4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791526609; x=1792131409;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWW6pSaXaHUM1wAEC6gE0iO0re0mXFQVa9Pv7/vaQG8=;
        b=whpjkcfZ6YgMosoGlcB17msCSGteMXifv4fYzJ4oHM5iMbwzFcGwlm7mBIy33IpNpi
         rW+uf2/fw5GnDfDCulZYvIJcko/C4q8SKifoWwRsCNqJxuLvaMADhrWw8Q+MsMDjAQAj
         cvG9UxSBpPThwq7R160eu58IbNDOV6CCB5vAFMT2W4UYqZaho7XIcm+/XU9FtCAqf1Iy
         yA74OC9ImyJwG2xGlfnzvHP2Qtq/A3l+ZqaEowy+IQCirQL4VLwJBYL6ZwOpw+hsKuU7
         ++8csCCvlbanrTuOGKraQA39OUwrE9t4/0iCgw1PJXjBZjhsaVZ8hfWfkS5C9M1Pmjug
         DYDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzINync2reS+iQMWPm7Rs3g380Hl7bBzSACu0BbOBhsWnolIsyLAv2S4eCz4qXniL4bBilGNbQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdCFBwWFl4Wo7agHMU+2plHhHHnqCDR4ql98NjAPsK8Hc4d14g
	0Lavqjd6Skr1U71vJ/qNtU5emPIGqO2pvZZbPqGkqTzjni8A1qeylOejgdlUGWsZQw==
X-Gm-Gg: AYBFou1qUBYlk8PXO7nIJx2bTE+BlbqNm5/uVBpH68ac3fD9L/oa1Md66PyKkodH+px
	SmqaKKZqLorJJnuFIomklAbHV80LSJ5Kvcu06cz5P+c4uxSSvNtqWTkL5lkfrUL1zfoOJ+JuFiT
	uucg9I535hYBWj6n0G5vDzPDkblsaLsoTMAk5yidwdgnq0DiTRn5PtoJpMbyHjXZAbX6SXdoPHu
	DqGFZkn00icvIi4ewKgn98IrwZ6TULdlO1lRzS0RVS2SEuXyB4N0WTeXx/E3Vvz2FQ6mYG/nxkv
	wmC/77MKs/2KHRdcXXoXBkdH/yh5p2fx2kW82YTqqA5UzdgiBsMXD+RxMtzPBjFQWIRElXaAbkh
	JLjXEABjAXT5cimi7ATU9dl2G3CTeZtbmZ1Vr/NMGxMhgZk6FjR96sldQ8HEbkzo52f/+gJxdWV
	+dPtSMnCIWFncwdfl0N7DysGRh8lB282B5txfGc6H/jICp1qOlOmA7cUInoO+fvNR224VM0V0O4
	XSV26nKibxIYM57H5UUYVEmL174hJedSuIl00Pj8B0EUmtCYhn4K9Dy2R0=
X-Received: by 2002:a05:690c:3685:b0:89a:63bc:8c4 with SMTP id 00721157ae682-8b07ee6d7e3mr2905837b3.78.1791526608330;
        Thu, 08 Oct 2026 23:16:48 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ef106sm3668887b3.22.2026.10.08.23.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:16:47 -0700 (PDT)
Date: Thu, 8 Oct 2026 23:16:36 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kyle Zeng <kylebot@openai.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    outbounddisclosures@openai.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: flush deferred unmaps before dropping
 a failed folio
In-Reply-To: <20261007041001.43181-1-kylebot@openai.com>
Message-ID: <f079a394-32e2-d8aa-f750-d5e3e87a7f42@google.com>
References: <20261007041001.43181-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Oct 2026, Kyle Zeng wrote:

> collapse_file() can fail its reference-count or dirty-folio check after
> unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
> then unlock it and drop the lookup reference before reaching the common
> try_to_unmap_flush().
> 
> The page-cache reference does not keep the folio stable once the lock is
> released.  Another collapse can replace and free it.  With its PTEs
> already gone, that collapse cannot flush the first task's per-task TLB
> batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU
> can therefore retain a user translation to the freed folio.  This has
> been reproduced with unprivileged MADV_COLLAPSE on a memfd.
> 
> Flush at out_unlock while the lookup reference and folio lock are still
> held.  The common flush continues to cover the accumulated pagelist on
> both success and rollback, preserving batching on successful collapses.
> 
> Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Good catch, yes, thanks: the folios already on the pagelist were correctly
flushed before reference dropped, but the one failing folio had its
reference dropped too soon.

I might have chosen to fix it differently (holding the final reference),
rather than duplicating the try_to_unmap_flush(); but you've put a nice
comment on its no-op when already flushed (thanks to Zi Yan), so I don't
think it's worth messing around with this good fix you've already tested.

Acked-by: Hugh Dickins <hughd@google.com>

> ---
> Changes in v2:
> - Use Assisted-by: LLM.
> - Explain that the common flush is a no-op after out_unlock flushes.
> 
>  mm/khugepaged.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 75639298efc2..e1a5890818ad 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2478,6 +2478,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  		index += folio_nr_pages(folio);
>  		continue;
>  out_unlock:
> +		/*
> +		 * The folio may have been unmapped with TTU_BATCH_FLUSH.
> +		 * Flush before releasing the lock and our last reference.
> +		 */
> +		try_to_unmap_flush();
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		goto xa_unlocked;
> @@ -2488,9 +2493,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  xa_unlocked:
>  
>  	/*
> -	 * If collapse is successful, flush must be done now before copying.
> -	 * If collapse is unsuccessful, does flush actually need to be done?
> -	 * Do it anyway, to clear the state.
> +	 * Flush before copying the folios, or releasing them in rollback.
> +	 * This is a no-op if out_unlock already flushed the batch.
>  	 */
>  	try_to_unmap_flush();
>  
