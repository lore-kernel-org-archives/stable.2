Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AC4503E1
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543743; cv=none; b=Hd5P7cUH+1Xj2rScGwMx2nuaVY7cT+FzJHbSTxwEIls93oNftlERy+QiKBw93nnqRC01ffgL7fDZfQ5ko8bS5ywrkqHvC92qSQ9yuFAU54r+Le2Moqz5WnwtrdMtG20RQRaWGoF7XNl+IedaEDr8yh17dDCqrjIOXawZ9JOByOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543743; c=relaxed/simple;
	bh=U1vKkmJEbFWvYu9E0zmEz50dFOo8A6mbVFrYdJm8OL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRL3/CYej7J087mdF3Ot2t7CfgxPh3f4ikCCVs7EJgxE+wKyxxlgBAu6qASx/Or5MmAPuwet60YJ58r7n4aRapuNK9eoIykzoY00zgQCq5fmBnajF/phexyOQrB+Lym3RBy9XWgbfLoCmZMzvq9YK4/CBgYpMvXmuA0WCb9DZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoLpmq9x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoLpmq9x"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfff5f88dbso11377405ad.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786543738; x=1787148538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nzV6WlxbIAg8UqrumPBkuydUfiC8qMZf5ogneGtVSg=;
        b=BoLpmq9xLyUDL2av6JfDRiomZzO6vCPVOlx+8kCm7DGKiAngjFP5yvS5djvnrXIT4s
         NmSLOAewyXMqjgD0fUPYwYjx/Ge2z+QpfnfvIT9+fw+CDk+hdMFdqy23htVi1MoN3Qwz
         bvhAE/hWned4gDNGQTAf54FlHGDcOaPRuUDhgmXp1uyhLL6GUCruFFS//dBq4iMRVAsx
         uAB0Z8izS/31jHlemsLse7Vnd8wQHXYUPj5TqwHS+0KkF1+mrit7flEjEd1FY6GvWzq0
         pjFFLpPvLYhHzFkXhA1pHGrAvKDzghsDvbtT0FbBzFFuBoRJAPosVq3jbPuqGal3bhv2
         gU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543738; x=1787148538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nzV6WlxbIAg8UqrumPBkuydUfiC8qMZf5ogneGtVSg=;
        b=aL0sqyheSXQY6eFS+1TPfP6SOI+w50Gyr+SL0yeKMKaRgGLMkb158uWjvA7VrkrnOH
         5LnqB0ccu5zEoYQaLcDUkseIikCEkaUHIiO5JAUst2fagZ7ijlrZTtpgTtpqEHgaCWVA
         AUHOK/xxU2lp43NwkKMGmffYYMpT/s65JC1VZZpc+/oafjgbr41cjnLx+Tku4j6q8D8C
         uOzFRmxNFh9+50LxsUR9MkylzyYKU/BG/oOKox3AFtJUxMwlPdBI5gFxhPAXDg1bj/5W
         Iy+c7IbQ5zV0OOLi9HWqRdeO1hpzSHMdcIWEf9eMI4gsdrt66xzYbhNaVp6V561iWIKO
         avxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+2i79zhuSdeXxYjR/YqSvcGG8Eoxwh4wuCjXDpL20pqv7oVqc53z+dcRS/4IUaMTMrOhIrw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g1Zm1/3FBMjz+3AqeXB6skoFLO1UZ7kXjAVif1VYCYLz/SG6
	2rv7+b0tAxe2mTjy5Gi0yD2oadBAA+fHevNDycZz78CqOu/p2PrteEyR
X-Gm-Gg: AR+sD11OoW7GedbMtljlCNqLiMd5hzJqfBaqGiWliCQnFPIPcLtgsaZofxwFMM2zxsb
	eg7HY9V3PZTj44I86PjhTJRbvKMAVxJhceEYfntnRV9LSki10yBB7TSAg6hKAKC++nZYteheDt8
	/eQJaenvMYKjwpp+48yySFE9RYlpxRrb1+MUge0bTN3HMupAts0DRGX61Ovr93ffGx6gUbvACl/
	XM/Z8Cgghom3ZjjQCgYbYduD3Nnlk52MkS/XT0x0ValGUy7uS2UNfsjfa9P9r2B7mmNAZTmNy+k
	77N5m2D17FRHOKCUSwlTy/EfDNDJf13UmLxynpFmuTQ4aPbdtyVYK586gEXaT5ZMBuZGHN797JN
	zOxMAzwUoBlf/LXQjHDoyKZtPEppvW66rlYSAlQbBkkZyeSSpOpgUGUpui0H6mekALbM707VfmH
	WZBfAHtGxlJdzzyjKElpv9LQp5ke7bWPVJplJ00fLSAO1x/fQHYB1ffZjAre2XRheTrImFTP+L
X-Received: by 2002:a17:90b:268b:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3930145ea9emr6278923a91.9.1786543738282;
        Wed, 12 Aug 2026 07:08:58 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d2a8esm3901229a91.7.2026.08.12.07.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:08:57 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:08:49 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: don't pass swap entry value to
 trace_mm_khugepaged_scan_file()
Message-ID: <7328756b-ad4f-4cfe-8d55-4659510212de@gmail.com>
References: <20260811133655.267739-1-vernon2gm@gmail.com>
 <20260811121225.fe45676262404b82270843a1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811121225.fe45676262404b82270843a1@linux-foundation.org>

On Tue, Aug 11, 2026 at 12:12:25PM -0700, Andrew Morton wrote:
> On Tue, 11 Aug 2026 21:36:55 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:
>
> > When the swap entries found exceed max_ptes_swap, the loop is left via
> > break with folio still holding the xarray value that encodes the swap
> > entry, not valid folio pointer.
> >
> > That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
> > to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
> > plain pointer arithmetic, so the trace event merely prints bogus
> > scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
> > dereferencing the tiny encoded integer and oopsing khugepaged whenever
> > the trace event is enabled.
> >
> > So set folio to NULL before breaking out, the tracepoint maps NULL to
> > scan_pfn of -1, just like exhausted scan naturally.
> >
> > Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
>
> Added in 2022.  Why so long - do people not use tracing?

For most architectures, SPARSEMEM_VMEMMAP is the default, where
page_to_pfn() is plain pointer arithmetic, merely printing bogus
scan_pfn. Only on classic SPARSEMEM, the swap entry value cause
khugepaged to oops.

> Sashiko might have a found a couple of other tracing bugs in this code,
> which I suggest are on-topic for your patch:
>
> 	https://sashiko.dev/#/patchset/20260811133655.267739-1-vernon2gm@gmail.com
>

David also mentioned "Using the folio after dropping the reference",
and the same issue exists in
trace_mm_khugepaged_collapse_file()/trace_mm_khugepaged_scan_pmd(),
which merely prints a overdue scan_pfn without oopsing khugepaged.
However, this approach does have potential issues, just that they
haven't been triggered yet. I can fix them together.

I will add PATCH#2 and PATCH#3 in the next version of the patchset to
fix the other two trace_xxx() functions, rather than mixing them
together into one large patch.

> Also a possible bug mapping large folios which straddle i_size, which
> is a separate thing.

Yes, I will submit a separate fix patch later to resolve this issue.

--
Cheers,
Vernon
