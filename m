Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC4282F13
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712379; cv=none; b=VbfXXmup4aeE6mDm4zU5dBempMGOMed34+Zn6EfJDGYDQkzEv7Z81nSgFEgyHjd7+WHqMrCKm6O7VpbTqeECLwhxtUDmD2dXn1yuovusnCSiUGe4RRXX6o0i/1q8N8Yn25kgoaoPZuA9sjSd4gOc/hYeAdC08QFuPRF9yYUVRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712379; c=relaxed/simple;
	bh=p5Aezv57E7unIRAjxAUYIy8BzzlGUXtTUqgpVbeRpZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r53XmEZpUqJGNMwyg2bOIMGAE4pNlLl47xwyvah9CuACgSLhjdhQG2P4uGtUsx7GoS3b6GKsK6QbbXVwqWxF6i4m1PK1vEdQiWNdgE+YPi33SmXxj0A5AagCC+mIge1CKn0clvZkMK/IWYvHRIaA+eNPKxjcu2VyLQm3NkOPURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzfOgguZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzfOgguZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d049069377so5841875ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787712377; x=1788317177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oz5icm8sYWRIKXUihXBHXUV2LJ3XHQzaAaHTPUPLgHA=;
        b=NzfOgguZ2NCR2kHpah1LbernAvtzP8bjS0pyyVMYPsfzVtngauqAjN2kU0zeB18hF3
         +XZ3+gv9dpupr/34P+J94/L3EwlNNA41SW70KikldvJQ9O1deyD+KPokm7Tgt/yqYHBS
         r0H+YxFid0I0OK5C9UK0OvF4U4yTk9amxbBVdujzckVTq0dLk/6m+dVjNpJVdKiAbVKJ
         xjCWPRGeo/SQ888mYz7RFr8UAicLPI9LBuEnZUm4rD5+Pm2jvtdmqKXgkhlEw/UFY6QI
         5Ukwj+Nb/LESzCJjBDWHbD5E8b9T/KIfH4rA+I6VknvJoXIV+8GfApm9rkV8fs2jFcnX
         auGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712377; x=1788317177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oz5icm8sYWRIKXUihXBHXUV2LJ3XHQzaAaHTPUPLgHA=;
        b=pHXdaFV9fSchPogoDlfJKIvO4vi9RmY1eLs8/M4BFpc7AwOXRjcQH9/wQxkjiW0LPp
         FiwzluKRLa58JSgPjRkS9zoRVqRgWIEUBzqPWQYaD0dJqRQJoZNRyLZf2FzVVeThlfxm
         C2Ix+g0pKPaT55wrt0gOjH3LZh65Ax0kfNeG2Qnc5tyf6cKXpdpgdtidA7KDGe2fYHTm
         fJJiuIwt74N7cZIuoddQUmW9y1iwH+JkRP7opgxa3wNldVt3Lp1M+WIA5GHZJdJyoo3F
         nPGZrJjEl+kDPveC43spgHKsa5PKyBgjk/tNAMSGx5X+vOlUmn6D+Ux1IRXrhxFyMBAU
         A5nw==
X-Forwarded-Encrypted: i=1; AHgh+RqYPRuyu1Qg/HzlIIKHDt1n9/OTCmTp8n8ZuXhgmMdjpeExetR1S6BKaN33Ry4Ex/GGaTWROLE=@vger.kernel.org
X-Gm-Message-State: AFuF++kzB/9MbXIj+BjkjdoCxYjagqePrnllgGK3M/Px8PnFSK72DTKB
	A785+pi/L9fYqO6r2HYmOUvv4ZC+1uar1ioDtJEvCqEjfQUdzso/cadC
X-Gm-Gg: AR+sD13VAk121xhLYA3IIV8iJ5OxsMQ3T9x5SccNgkfyG/563mAAYd7uae094E3jKf9
	I3oVpH34Ay+/hoLqqCqJIx+tgkpLDu3ZAC/4kvM1h2X9hfbxKAnk7XWPUBh0C40QgSx+mLQZrzC
	TgYHjpUbNOVKXzdbvX6XlOAJ+sEyks44WzxpZsWCT5RpGq4kKU8ufuockFYHI32EkhZJiXsjC53
	5GjsNdfqOU0rKs5NGrxp8kTq2RDvcI9X5NJF23DepdguVZABR0VLdK9Zt7zxbh/p+aNXENETcP3
	c4eWIo0OoPJuqiElB1qmZtZD/YKGzVh1yuRFj3XN5ihZ2yf5k00n8DRgAmdPNjOatjB/aDnJY1U
	fsiVmrA9s1Qz7+Z8i8zdwljApomGrJp1LUM5ZqPA4uqSyraQ8a9ZRKZ2azyQ9wnXpoSx3CXhZDT
	68N5c93rJHoQrZ3kYEnBNlgH/icv4+2BbzFWBtjXgvC18W01V1U3rjdy26F/+NjqUV11KRIjaHt
	KI=
X-Received: by 2002:a17:903:1a0d:b0:2d0:8b28:51ab with SMTP id d9443c01a7336-2d707ad0d63mr52827945ad.7.1787712377408;
        Tue, 25 Aug 2026 19:46:17 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493d127sm3388825ad.17.2026.08.25.19.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 19:46:16 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:46:11 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 2/3] mm: khugepaged: fix folio is used after
 pte_unmap_unlock()
Message-ID: <f285e26a-b790-4afb-91e9-a2b404df018f@gmail.com>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-3-vernon2gm@gmail.com>
 <0bc399df-2555-4378-bee4-eacbff434bdd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc399df-2555-4378-bee4-eacbff434bdd@kernel.org>

On Mon, Aug 24, 2026 at 01:57:15PM +0200, David Hildenbrand (Arm) wrote:
> On 8/24/26 11:29, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
> > After the page table lock has dropped, the folio can be freed
> > concurrently. The trace_mm_khugepaged_scan_pmd() is left with
> > a dangling folio pointer.
> >
> > So using the folio_pfn() before dropping the page table lock,
> > closing use-after-free window.
> >
> > Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  include/trace/events/huge_memory.h | 6 +++---
> >  mm/khugepaged.c                    | 5 ++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index 7b526528f85b..fa828967e1fb 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -55,10 +55,10 @@ SCAN_STATUS
> >
> >  TRACE_EVENT(mm_khugepaged_scan_pmd,
> >
> > -	TP_PROTO(struct mm_struct *mm, struct folio *folio,
> > +	TP_PROTO(struct mm_struct *mm, unsigned long pfn,
> >  		 int referenced, int none_or_zero, int status, int unmapped),
> >
> > -	TP_ARGS(mm, folio, referenced, none_or_zero, status, unmapped),
> > +	TP_ARGS(mm, pfn, referenced, none_or_zero, status, unmapped),
> >
> >  	TP_STRUCT__entry(
> >  		__field(struct mm_struct *, mm)
> > @@ -71,7 +71,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
> >
> >  	TP_fast_assign(
> >  		__entry->mm = mm;
> > -		__entry->pfn = folio ? folio_pfn(folio) : -1;
> > +		__entry->pfn = pfn;
> >  		__entry->referenced = referenced;
> >  		__entry->none_or_zero = none_or_zero;
> >  		__entry->status = status;
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 00337405c0e0..4e0fca5942dd 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1618,6 +1618,7 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  	enum scan_result result = SCAN_FAIL;
> >  	struct page *page = NULL;
> >  	struct folio *folio = NULL;
> > +	unsigned long pfn = -1;
> >  	unsigned long addr;
> >  	unsigned long enabled_orders;
> >  	spinlock_t *ptl;
> > @@ -1780,6 +1781,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >  		result = SCAN_SUCCEED;
> >  	}
> >  out_unmap:
> > +	if (folio)
> > +		pfn = folio_pfn(folio);
>
> Should we reset the folio to NULL at the beginning of the loop? Then we really
> only trace the PFN if it really was problematic.

Yes, this is a pre-existing bug, and I'll fix it together. Thanks!

But it is not at the beginning of the loop, it is at the __ending__ of
the loop, for the same reason as PATCH#1.

--
Cheers,
Vernon
