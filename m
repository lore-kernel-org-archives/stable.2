Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FC41B360;
	Thu,  9 Jul 2026 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599390; cv=none; b=r2C0rah24HIuhxBj320BbiSUV0cKdVoD87guvvFAPPBNTyZgfiCIW0qG1BIOLJddf/ox9tyTTYISa3TAYsytXeLoC70UctpRFfYMs9YQlQt/OzvcJJVXtRc1s5diqHLoxsZ7PqjV6fdOsGJHqLjWKFi2QSOVLqbXIco+dHbscno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599390; c=relaxed/simple;
	bh=MyDYzXDJp8P6A4QYLRssEWQGipFjCpj1mbG3TTt8cg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSPMlW+k1cjQwh+yyxFPembA5rRIOAOmohaGI7Id5tQUX2x6ojUTJMmogpiwl5X5dIehpr8xrwfZrZCNH8mTm/hwy8nGkPmY4h3FsXnNZSDCy08AOLFsXQmF+4+uBUPRhZdL603vF9dahOZEFwHbhPC14c547s8mWRce5OwW5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=dxwmt6Qh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNwFyr6C; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="dxwmt6Qh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNwFyr6C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 231C0130055D;
	Thu,  9 Jul 2026 08:16:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783599385; x=
	1783606585; bh=HIwaKTOmqJ5ZVBRg39BGgQYKwRe26TKiebrofOqIHLE=; b=d
	xwmt6QhiWu8SktKIZKxPVQccvw3oshk6O22+g/ikdXjOiKMxzS2oXLZWVtbyLU2+
	JJlTQnLZOMpyqSsq0zNSVSqMnyCbPT50YOkPGdWI7uvjxVEGDd1s7ibTQ3CTfzhV
	UC1idf187udWuWvcqWDxSnbFvJhKS0i14Wstvow3bEFDnBeOu1juZBUXFJM2t1oX
	LD+NF4jq08yfh/Y6BjTofEpTogeZKEk8afxpfPCgUrWaMEyZ7Ii2dTOB2T0sD4vE
	DY+E7kWU9lEaoOiIneV7MXR9YOXsNq4yVVa2ybgON+wiNLQdv6UAdulFtkAbelOc
	uh7GIqaoKqQTBKQOU7Igg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783599385; x=1783606585; bh=HIwaKTOmqJ5ZVBRg39BGgQYKwRe26TKiebr
	ofOqIHLE=; b=lNwFyr6CP7+3EaZiJ/fnW/gcypFWXXYRV7q3MSJdW+wysLXXKUx
	uuMNnRejQ8nnQwADrDLk8dVEkjrHcP9HX1Uem4V6cXBjiunN0xRlW3aHe+fKNZ28
	WLhd3iO4PcP8p08POenPhiYu2BcOZnlXlUaFG5K80Xz6kQRNTUYDkazt9Zg/NUOH
	EIED9iGIUM2rdnVmawqMXE7ehhCDcdhc6bNEzlEX2JWXEoQlO07dRi51b0vysdez
	UrtJstnlieH2evhqpOpr//cW/pghFYH1Om4l1VibJ4ypQ1TqBxke63n3Wj25Q1fM
	oYXM1vvLyuqxZlGhb8LAwKNAiL7+KI2X3UA==
X-ME-Sender: <xms:GJFPainhc_rHji32bHQtr0iLzXhREvXF3CTZSc1Jrw3KpDRANvRCrA>
    <xme:GJFPatKi_9WMIncuE5w2it7vfuehzouU3xM4GsXc1xgFar8RwVt7Jnm5pfvCh-_K7
    Plu8oYn7Ut7lUnbRCmqMlyp9mOl0yUnBDLY-kPSf5CTG16vRIXVe-M>
X-ME-Received: <xmr:GJFPakup8A0aNPbur0tmyadtFvKMyb22nx95-MzOdxjuP2yF_G6Mn8tmPSJHtg>
X-ME-Proxy-Cause: dmFkZTEhah7gSrK85ugcDpjusH538xKH/tNlc59fvxnWezgS8nIMC5SP/YgvwWsii132jX
    mxiqe7ot+Oim0K+hjQZFlvESyWD2V7koG9FjxZtTR5r4JYjIFHXmmzVspwniH0lU8glUQL
    qcCjYbTnKl45F4V7n1kyCydwzyZ/Ix5PetK42ZSXJhRf4CFuKf/gLR8rDiVlfz5GB3t1wU
    vgLJ/EshFga1wxvyXnhMwSetqLj6bljasKNRtyA92fRRtI+VcFSxTRy/ix4mmmmaeGU70a
    G6wiIcsMpe7QxOeK4qDPB3ZTPS9T3RhUpRy3Cqpju3lEG726/L7V4qik92mIBoVzjONQcV
    grfQNMgJWwOEPbZvmE5jEqjfmLhQClCwuoyYJPKxh3GHD5gRMaCf0mmo9ee6BxB4vsr/ri
    w+XYHqEEsB+KLQPyxltyFvQI/ZxS70HRoBijqHA0v1OAhbic6Dt4qgP6u4DPRsrdaKFRiS
    rUZl0VlAGbHZ6ZnYKQ9xSjP8+RTix/EcgN+QhCuo3PRN2rXaDA+MSfnfblP/4QGk48m30O
    xtevthAh3uC5ov755sq+VRyrlUNyLn0dG3+n1H/qoW2z4MiMttp5VRdJNb+TbBF5Q8XLPm
    nlWs7Rc0w8LPn+YETkbRUde5Knnx93GDi3ffJXajtruzCeWe3F48y6dGrQMQ
X-ME-Proxy: <xmx:GJFPas_AhHetiFEfH-onbOO622kOWGAkKUKP-5Y5R4vHvqfr1p0g7w>
    <xmx:GJFPamxVaLnQL5dh0UDk6REidP2yBMKhNW-ntAjTwGnI46M21VmdDg>
    <xmx:GJFPagJtkI7eTyL5Wt5sEcPyM41jz2rdlAET3iil52bH8IoFyZUC4Q>
    <xmx:GJFPahaqG1t5wY2KSaLtWmmQfCFSa1Jx5DCG-d0UcSb5Ke7UVkRzcg>
    <xmx:GZFPasoY_72obgE-19kUQIGESo3HlFiN09xjl54nhO1u9T4qsy_6JjtG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 08:16:24 -0400 (EDT)
Date: Thu, 9 Jul 2026 13:16:22 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: usama.anjum@collabora.com, peterx@redhat.com, liam@infradead.org, 
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, 
	david@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for
 PMD holes
Message-ID: <ak9pxTMPA4BrlUKl@thinkstation>
References: <20260708103429.150655-1-kirill@shutemov.name>
 <20260708200844.09b42937d19bf733849d2886@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708200844.09b42937d19bf733849d2886@linux-foundation.org>

On Wed, Jul 08, 2026 at 08:08:44PM -0700, Andrew Morton wrote:
> On Wed,  8 Jul 2026 11:34:29 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > PAGEMAP_SCAN reports an unpopulated PTE in a uffd-wp VMA as written
> > (pagemap_page_category() and the PAGE_IS_WRITTEN fast path), but a range
> > with no page table at all -- a PMD hole -- is skipped.
> > pagemap_scan_pte_hole() evaluates the hole against p->cur_vma_category,
> > which pagemap_scan_test_walk() builds from only PAGE_IS_WPALLOWED and
> > PAGE_IS_SOFT_DIRTY, so PAGE_IS_WRITTEN is never set: the hole is neither
> > reported nor, under PM_SCAN_WP_MATCHING, armed.
> > 
> > This is reachable. An anonymous THP is write-protected in place as a huge
> > PMD (change_huge_pmd(), anon is not split), and a full-PMD MADV_DONTNEED
> > clears it to pmd_none. A WP-async consumer such as CRIU then misses the
> > 2MB drop -- the range is not reported written and the next incremental
> > dump keeps stale data. (A file/shmem THP is split on write-protect, so a
> > later DONTNEED leaves a populated page table of pte_none entries, which
> > are already reported; only anon THP reaches the hole path.)
> > 
> > Add PAGE_IS_WRITTEN to the categories evaluated for a hole in a
> > non-hugetlb uffd-wp VMA, matching the pte_none handling in
> > pagemap_page_category(). The existing PM_SCAN_WP_MATCHING path then also
> > arms the range: uffd_wp_range() allocates the page table and installs
> > markers under WP_UNPOPULATED, so the next scan sees it clean until
> > re-written.
> > 
> > hugetlb is excluded on purpose: an allocated-but-empty huge entry reads
> > as not-written via pagemap_hugetlb_category(), so reporting an
> > unallocated hugetlb hole (which also reaches this path) as written would
> > be inconsistent within the same VMA. hugetlb hole handling is left as-is.
> > 
> > Add a pagemap_ioctl selftest that forms an anon THP, drops it with
> > MADV_DONTNEED and checks the resulting PMD hole is reported written.
> 
> hoo boy, that was heavy going.

Will make it brief in v3.

> > Assisted-by: Claude:claude-fable-5
> 
> OK ;)
> 
> But what do our users see?  afaict the result of the bug is "the next
> incremental CRIU dump keeps stale data".  Why is this a problem?  How
> would operators look at a user bug report and figure out that this
> patch will address it?

The core point is that MADV_DONTNEED has fill-with-zeros semantics and
should be treated as write for write-tracking purposes.

Ideally, we want to have PMD marker here, but we don't have enough infra
to handle non-present PMD entries. Usama works on this.

> Is there some Reported-by/Closes?

Closes: https://sashiko.dev/#/patchset/20260707151349.92143-1-kirill@shutemov.name

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
