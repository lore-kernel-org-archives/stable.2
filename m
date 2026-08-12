Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A776402436
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543404; cv=none; b=YpgcTnQe3YZc/xnCqFAvBlnAe4O7f2vT0z3GEoy+LibUariwCo1OGR+w8CAxeIePrhB3kzKVEp0hlp0h9thqCcFkfO15AQFE9WKXJE3QFDTNQJQqiexazM0CHNYyROcvTf0GFlH2elzxYFxc96mT+kV8sb+6NJGEG0l2edW9R24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543404; c=relaxed/simple;
	bh=Pn5u5ZIVOieorN1UAEsWAT2SRTtMhlItGdfgXJ1zMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rznEIq0NYvVubTt17sfQMk2+9Rb9CmOE076QTm9K0B8+I1AZzVnPsaI2UmR+5xSTBHt1gOnPsyclCZFSHcxZgoV7w/A4+3za44tMukYMsbo+k6pLSF7gitF0BVmrtm+YvqmafEQz16TTJ+mB09i0n8EVdYRinMeuQ2eKEcLOVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxL75EYq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxL75EYq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so12365765ad.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786543401; x=1787148201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FijbjGvORINBRhLeBoIFty9YdQZ9hefeTZ+Nf9pC9YQ=;
        b=TxL75EYqd1DGOWhMjrNHFXXrSc1ExpQ4av0dgbYBTbKW8ihI2ujLoJFmvquZWLYNM4
         zjnPLuIGWjSXjJC3RxsbxuXMfDaBaWyobLE4NXJ0za2doMY6CPiypCeLSsHvBqqx7krZ
         +CmG/QKXQ/ckFD/gMlxz2ufRbDoV6hZN1VbOwXJLrP4h63rdbGTEZEqLngM37dJLFTmg
         A9Cp5C/HDWuNlVtwnuVqIs5/Mldq/MYGXfDkiYoD4cIpz2d4jrltlLmb+gBuyFPvqO6d
         PMThNNRhm7kRvbh2pk9BQdmSb8b7AmYf4XaQVIKkcbtd6DGtsRdpA7r82TsbFsnnpZ3s
         tGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543401; x=1787148201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FijbjGvORINBRhLeBoIFty9YdQZ9hefeTZ+Nf9pC9YQ=;
        b=RPrPY4RbXUbGsIqWee8DqIMBpVQCDnKxR284XbQm+NZX3pi8uz3R/ZczXuUyrisECB
         ReXAClf+lEnU8K9xqzRnVGDZwf49vvP94RczVF87tnt7QNUUinCr1n5MjGeKNVRf7MvF
         WU7AYHhTepk16XppLwM+HxUfuSW7mBPhPzDB1MphC33nL7spB0teWJuvI6RbWMMkVsaN
         2vw6OzMCOcvkoAE6BiDrZVW6yvUtGPHid4iBwrljx8/Ozfrcq7j+FsOe+96xiLI7yLRk
         AWM5P+gvQxVSEyBM5KJ+kaiGG8sXPymFuMOEQZc6kwOIsh/kWoCWRg9hCXo+/AAiY5H9
         jdUw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi3ZfocmqhD+rPumwbUCVg4thljovZSuHupNA4YngcDrGivB+z3ukj35Rnxye5U210ETFvdAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JGqf8GfBMhXnNt5XQGVVXMqQTWoLtw7Z0di5iI3dd4oyGb/7
	zmYElK0K+7Ez5EbDL/m+v5Pg2jI7UV4gJYHN58chOvl4dSAR7bnzq6b0
X-Gm-Gg: AR+sD12edb1ssJsxWiZAmvcPou6DWXLyDD2TqLwEbDZJU3EmoyFo6k+e/F4KtVnJRv4
	zkxrTjucjJVQcECo47dksvx/wKDmV/GOENFwiAvIz1OQ+iIlXQ5tZVIac8J6uucc+Y1UBxJNBuY
	wIxvX2I03vPV7Jrh2vHD4VBkr0riGBh5ZdmFwqTTkEW71EIQez+ufKnPcMwqKh2/TAJAVNFK4zb
	3QcpPoUBq/8j6YqhLAYxOr1lOyXGXQukswqAp4x1B0+nydWjMLWuqE36+s+2aHSxGf4H+Vdp716
	uWuiRJGuwfc3oWHBbDLEwqWH2noRA9GifucSjHEZJ7k+2bOKWXW7asNLgOTrWC+cwIuuM5aqoyG
	rm+1Hh8ya2YwETPu+EbqSfz5s6/meQPRN3hUg+vysSmKQ9TinSjSPuhWQye2xLpxvg5I3S6lHEX
	73Pio1PZvYvC6HzQXlr8DBxqUCqPt94qXccEe0LztdROUonLmvPWzCZZNdizvbd76BGGrLFPsp
X-Received: by 2002:a17:903:2cb:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2d345713af3mr66438065ad.23.1786543400647;
        Wed, 12 Aug 2026 07:03:20 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d351147e35sm7165115ad.24.2026.08.12.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:03:19 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:03:09 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	usama.arif@linux.dev, zokeefe@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: don't pass swap entry value to
 trace_mm_khugepaged_scan_file()
Message-ID: <473fe48f-ecd0-47fa-9aa2-d907b685138b@gmail.com>
References: <20260811133655.267739-1-vernon2gm@gmail.com>
 <57248ac2-2d5e-4995-9ecd-b71b233fe5d4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57248ac2-2d5e-4995-9ecd-b71b233fe5d4@kernel.org>

On Tue, Aug 11, 2026 at 05:19:38PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 15:36, Vernon Yang wrote:
> > From: Vernon Yang <yanglincheng@kylinos.cn>
> >
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
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > ---
> >  mm/khugepaged.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 617bca76db49..bc0d04c9162d 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2696,6 +2696,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  		if (xa_is_value(folio)) {
> >  			swap += 1 << xas_get_order(&xas);
> >  			if (swap > max_ptes_swap) {
> > +				folio = NULL;
> >  				result = SCAN_EXCEED_SWAP_PTE;
> >  				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> >  				break;
>
> Yes, we'll do a folio_pfn(), and used to do a page_to_pfn().
>
> Using the folio after dropping the reference is rather nasty.
>
> Instead of passing the folio, should we just pass the pfn directly?

Yes, LGTM.

Would similar modifications like the following match the effect you want?
If so, I'll make these changes in the next version.

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49..e7830761d3a2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned long pfn;

 	present = 0;
 	swap = 0;
@@ -2720,27 +2721,23 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			 * PMD-sized THP implies that we can only try
 			 * retracting the PTE table.
 			 */
-			folio_put(folio);
 			break;
 		}

 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-			folio_put(folio);
 			break;
 		}
 		cc->node_load[node]++;

 		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
-			folio_put(folio);
 			break;
 		}

 		if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
 			result = SCAN_PAGE_COUNT;
-			folio_put(folio);
 			break;
 		}

@@ -2759,7 +2756,14 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			cond_resched_rcu();
 		}
 	}
+	if (!folio || xa_is_value(folio)) {
+		pfn = -1;
+	} else {
+		pfn = folio_pfn(folio);
+		folio_put(folio);
+	}
 	rcu_read_unlock();
+
 	if (result == SCAN_PTE_MAPPED_HUGEPAGE)
 		cc->progress++;
 	else
@@ -2774,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		}
 	}

-	trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
+	trace_mm_khugepaged_scan_file(mm, pfn, file, present, swap, result);
 	return result;
 }

--
Cheers,
Vernon
