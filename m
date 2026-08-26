Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166E3C9888
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736123; cv=none; b=Xj5eAsE6IQNpNBwUgwFsQCY/Yj5Y4CPDHQnbiONWQ5e4awytga0mFnnbDKCN9Ds3aIG896emVjoo/4xIl2G49U2i3CyRNMcIt5EUQNJW/2364Z4lETNiWv9bhkcpBJn806it/M4EuDBaUrxWvHKEvyx5GEx+Mdq80tTr4EMvO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736123; c=relaxed/simple;
	bh=IBPxf6OZGvf01iPqu934qlUWO5hXy1HyOFafFD1QGEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IroDJFJUH98pdpkJwicYW5A3kNXFs5Ma+V5jV8JARJkKAnYMVwRazuEiLBsCrtiJhQGPqVoi+h4JZ5gSYBMYAitzZKrKWy9rdeHhhDI7u9AtorfmcJoq/TPAXIia4L46yh6P+4FUlGkVhz+7U92IQGmy6rnCBDm5WlbQop37Wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgPfnqeY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgPfnqeY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39675172593so509993a91.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787736121; x=1788340921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jALS777Z+qg1ejYQPjNAfxupaXWG07m9ugFq1DHHkyY=;
        b=DgPfnqeY9ST2DfoCpZSuuhMkzN3hcT1LSbcOcgqkTgMBoqOiezb95YN+js9dFfx6oT
         TYIwmTscNASIx0hE3HxvglnLOL04ulGhZT7zKbuzYbFvNRrYSAbo5OpA/laoWRNIJNcL
         d+UT76Jr0m65l8s3QAs7qhuQQTGgPSduQV+mJMWhmnp6jWrFtHHrpZxmuv/job0iSdiq
         OGYX8jzo5nW8mDms4Busk091Tbmzp94D2xAwhvdqlIbabt2lwBZ0umekXwJoxvBzLECD
         APQniHc0QPaLhFooHSeVWbj2p6MFBjJ7xtTYeUpudfOnkIg+2zsbRUbHztIsc0yGQFa6
         xHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787736121; x=1788340921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jALS777Z+qg1ejYQPjNAfxupaXWG07m9ugFq1DHHkyY=;
        b=fJ02SSXd02Wr+1Vgpb+TDt8S5NxYc+L5QD86jbp3fOijqEqgaAL9kfNRm5qPRe6NWv
         muFLSfmVGOPayee0LZ3UBdUNOYFf/GqguN++EAVXIrptoo3zDNcsI4tsTJL2JRKhZJoj
         1di0guqQoOqEsp7ZrCjZi5DqR2wxll+8xtQ7SLREWK/MZ6F3TwccCOR8caD8kCsmETKu
         pYn2h8Wl0SYWqTP9KNG5Fu6yfRPnZr6ZxngjH/A5BmrPr9YlfvBNycOOqoyN9bfZGgAs
         w6TZFoaNUT4KaGwbCuUlR1athVUCyl4rQDW2UK8kJYOZnN5gyJNatMvMDDXBr49bEaWg
         s7CA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9mSXkooCuKd6+rmmqF3qtGLqKJhRQzVFJ1GyqnowBo2TN4dQw1IKrygoxp5s0YHIbiSVSp4g=@vger.kernel.org
X-Gm-Message-State: AFuF++nVrHqxhIFigsb7QEXnT0+q8EksfGCPRzooXu1KUaNPVLLk/uHk
	IMKHn8fDshw8s/ho3XNefYssIQoOykfv92Y1PCWlPxjOO62MW/h3l//e
X-Gm-Gg: AR+sD12aL1S6Vrg002aovWdt/oTfXxYbNvy8dpMuCVAMd0LjQxtpTgL/3uioXn9ancw
	LnQT5AH6Oe8of+Rc95nm1m2FFFllYJuLsIjikrDenS48WNC2Ye9sVgeyCPGGy0JQbvDolQaSMOD
	AZgwmnxi5cvLzFDJuSbaSDfVRRsJ0cLeFlOgaZ8CrWZOT4gUmGSY2zFDNKpCFV6vrOyxqjg1Ovr
	cLoXCMAy1OZVbkO4zar3YxKui6HDLw5uLxpPRGpeCu2mNE25kPuAj8D8gg2sqnhUm2U4O+lNx3h
	py5a5G/XSYgJuR2/CeQ/D0mq/JEwbCDzGMtcLfXgFssLgfT3HeIpk0qBEN2+vuf5YMsF5QOut76
	Xp2RGvY4X0FTNixCOwmcBqj2wQefnELeBAOlRNLYaHgMmBaEaMM4R+uT9gq4m2oEpYpcQZv3t3a
	G9hvTuqqXZE861rzq82a3g9S5HYU/nd+rIoDWh+HL48zkiMWkNC+twG0HN23/AdN/PADW10LTm+
	cMeY5IR1Qgq5A==
X-Received: by 2002:a17:90b:1804:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-3966d400328mr10605164a91.10.1787736120866;
        Wed, 26 Aug 2026 02:22:00 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm7002492a91.17.2026.08.26.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:22:00 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:21:51 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 1/3] mm: khugepaged: fix swap entry value to
 folio_pfn()
Message-ID: <330789dd-94e2-4827-abdd-23671263608f@gmail.com>
References: <20260824092935.73892-2-vernon2gm@gmail.com>
 <edd7ed8d-0f2c-4de3-89e5-f2b23c2dd1e5@kernel.org>
 <6a9c2369-5589-4f2a-bcfe-c6e3b46a1ccd@gmail.com>
 <c8e3bb54-e4f1-45d3-8059-3ee1910a920a@kernel.org>
 <ao6c6Oe_KV0O1LJn@gremlin>
 <b6fbf952-c619-4fc7-8a8e-62a0ae64ff0d@kernel.org>
 <ao6fSHW_nX8YC9QK@gremlin>
 <42695df0-3962-4126-9afb-9a1905d096a0@kernel.org>
 <49aa013f-f613-42be-bc58-35956ef189de@kernel.org>
 <ao6jVbVHLUmuY2UA@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao6jVbVHLUmuY2UA@gremlin>

On Wed, Aug 26, 2026 at 09:35:38AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 26, 2026 at 10:24:56AM +0200, David Hildenbrand (Arm) wrote:
> > On 8/26/26 10:16, David Hildenbrand (Arm) wrote:
> > > On 8/26/26 10:11, Lorenzo Stoakes (ARM) wrote:
> > >> On Wed, Aug 26, 2026 at 10:08:58AM +0200, David Hildenbrand (Arm) wrote:
> > >>>
> > >>> Elaborate.
> > >>
> > >> It's overly long, I read it and am confused as to what is 'problematic' or not,
> > >> it reads weirdly in English and pfn_xxx is the usual convention for naming of
> > >> pfn's anyway.
> > >
> > > Excuse me, what? Are you now just making up arguments?
> > To clarify, we have various users of "xxx_pfn" in the tree and I fail to see how
> > "this is a problematic pfn" -> "problematic_pfn" is odd and why
> > "pfn_problematic" would be any clearer.
> >
> > I do agree with the "problematic" aspect. "failed" might indeed be nicer.
>
> Right yeah. Mostly the push back is on the word being a bit confusing. Fair
> enough on the pfn thing, failed_pfn is actually the nicest name suggested so far
> :)

failed_pfn is good to me.

> I still think:
>
>        	if (result == SCAN_SUCCEED) {
>                	...
>                	trace_mm_khugepaged_scan_file(mm, -1, file, present, swap, result);
>        	} else {
>                	trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
> 					      swap, result);
>        	}
>
> Is a little neater as then it's only on the failure path that we trace the
> failed pfn, and otherwise we explicitly -1.

I understand what you're trying to say, but personally it isn't necessary,
because failed_pfn defaults to -1, and one
trace_mm_khugepaged_scan_file() already covers it.

If everyone clearly expresses that they want two
trace_mm_khugepaged_scan_file(), please let me know explicitly. Thanks!

> But it's not exactly a show stopper this :)
>
> Very rough edit of your patch - if you're happy then let's go with this, if not
> then edit it + post so Vernon has a clear direction. I'm not feeling super
> strongly on this so don't want to block anything:
>
> ----8<----
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 75639298efc27..371ee0b16d10c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2683,6 +2683,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>        	int present, swap;
>        	int node = NUMA_NO_NODE;
>        	enum scan_result result = SCAN_SUCCEED;
> +       unsigned long failed_pfn = -1;
>
>        	present = 0;
>        	swap = 0;
> @@ -2714,6 +2715,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                	}
>
>                	if (is_pmd_order(folio_order(folio))) {
> +                       failed_pfn = folio_pfn(folio);
>                        	result = SCAN_PTE_MAPPED_HUGEPAGE;
>                        	/*
>                          * PMD-sized THP implies that we can only try
> @@ -2725,6 +2727,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>
>                	node = folio_nid(folio);
>                	if (collapse_scan_abort(node, cc)) {
> +                       failed_pfn = folio_pfn(folio);
>                        	result = SCAN_SCAN_ABORT;
>                        	folio_put(folio);
>                        	break;
> @@ -2732,12 +2735,14 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                	cc->node_load[node]++;
>
>                	if (!folio_test_lru(folio)) {
> +                       failed_pfn = folio_pfn(folio);
>                        	result = SCAN_PAGE_LRU;
>                        	folio_put(folio);
>                        	break;
>                	}
>
>                 if (folio_expected_ref_count(folio) + 1 != folio_ref_count(folio)) {
> +                       failed_pfn = folio_pfn(folio);
>                         result = SCAN_PAGE_COUNT;
>                         folio_put(folio);
>                         break;
> @@ -2773,7 +2778,7 @@ static enum scan_result collapse_scan_file(struct
> mm_struct *mm,
>                	}
> -      	}
> -       trace_mm_khugepaged_scan_file(mm, folio, file, present, swap, result);
> +       	trace_mm_khugepaged_scan_file(mm, -1, file, present, swap,
> +				SCAN_SUCCEED);
> +	} else {
> +	       trace_mm_khugepaged_scan_file(mm, failed_pfn, file, present,
> +				swap, result);
> +	}
> +
>         return result;
>  }
>
> --
> Cheers, Lorenzo
>
