Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794971448;
	b=JwkmoNFt3kyW9PMAfimksgyWABZAAythNbuOwjD2J2olZ1NuK567hkZeot4VTY0QN+Me
	 Obz/ota/vq1fLEI0tZDRptD/DqN62GnAHRyKsIJU/qi2YZJeNji0kN43GhW/GpKzN1WG6
	 Z0tbRvwDURfr+y3WlLGlhEdSfbVOULGgfZnewjiwCl/1MasKUZW4h8w8Uax1t5wHtfuVb
	 7neWcNXMS8o20Ex8+CY7gHlFlhc35CkpAU8zqm7PvzJsDsF1aR2P81bHOf6DYnscjAbeI
	 NWfonzJkYE2IBlTcgC3KZEpmNPN1Kon9Hi7fK5cEVFWQUnZLGhJ/1jxHlOOgoqFutug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794971448;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nfA5i4d2gCwIuNfl/V1REoqxWlwBpLBqgHxGC6bP5bg=;
	b=XvoVEYMCQhNhRoYfwV92PkQZ59mfpajPPYe96QyGjuQKHNtJ32Jb8Q7W35CEloJvUSD3
	 +gzG1mdIROXAXyaOGMVeMqlPY/tgU0viSiUOXRSZTuQUHv9yO7Llu88RmE8CJxvNS2WV0
	 inLnOSdSarDeu9DWQhNDcV1NvyJpsYHstHrxsloQS+oteriZdUEBjZ0+1LG2dm7rfYpNh
	 w3TUvkC0tcNDkFe7+KXv6HwXDKKFyJVbqNvARJQX2p79PkKTGgTJ6XXbqGy9e3oWVEx98
	 tysNUXmuA9spJl0ssP6SVA23GtipdPgOjxbyyO6VrCFFy6BX9aaS3b+5GnboFn7dgVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vamNkQ+K;
	arc=none smtp.remote-ip=95.215.58.126
Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E4606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479E4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vamNkQ+K
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eEhQXNIJ/LtAn0ef1h8RiySWKjEFVX1iaNKIEFjrPfY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794971445; v=1; x=1795576245;
 b=vamNkQ+KDQxz1fvgSr5uSrJNBhqZkNgjq0BHyNAyJFjJL6SgEcnAN/PeohSqcL/kh7m4DZtd
 O9aImLfuDPm5MS5bMdOS6A1nZWNIbHSiJtt+HLIAl0B6a1mlkltw+sy6YauXIPhC6L268b4MgHA
 dIS3fG44WPxGIL190MJglMu0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 3059d6b605696205;
	Wed, 18 Nov 2026 03:10:45 +0000
X-Mizu-Trace-ID: 3059d6b605696205
X-Migadu-Flow: FLOW_OUT
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	donettom@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	xu.xin@linux.dev
Subject: Re: [PATCH] mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
Date: Wed, 18 Nov 2026 11:10:38 +0800
Message-Id: <20261118031038.75525-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e971c3f2-e8cf-4eb0-ae25-e7e4d9ea02ee@kernel.org>
References: <e971c3f2-e8cf-4eb0-ae25-e7e4d9ea02ee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 11/17/26 09:18, xu.xin@linux.dev wrote:
> > From: "Xu Xin (vivo)" <xu.xin@linux.dev>
> 
> Hi,
> 
> thanks for the report.

Hi David,

Thanks for the feedback!

> 
> > 
> > As documented in Documentation/admin-guide/mm/ksm.rst, ksm_zero_pages
> > accounts only for zero pages actually placed by KSM.  However, the
> > current implementation wrongly accounts for forked zero-page PTEs as
> > KSM's contribution, inflating both the child's per-mm counter and the
> > global ksm_zero_pages counter.
> 
> But ... they were placed by KSM?
> 
> Just like any other KSM folios deduplicated before fork and then shared with the
> child?

I see your point, but in practice, people evaluating use_zero_pages=1 often
look at ksm_zero_pages to gauge how much memory KSM actually saved. Since
forked pages already share the same physical frame via COW even without KSM,
counting them across many forked children can give a somewhat misleading
impression of KSM's actual savings.

Also, ksm_merging_pages right next to it is already reset to 0 on fork (even
when regular KSM folios are shared with the child), so resetting ksm_zero_pages
keeps the two counters consistent. 

> 
> So won't there be an inconsistency when MADV_UNMERGEABLE?
> 

As for MADV_UNMERGEABLE, leaving the child's mapping as a normal read-only shared
zero page is safe and avoids extra allocations. Plus it naturally avoids the
skipped-VMA (MADV_DONTFORK) accounting bug you spotted, and does so
without extra per-PTE overhead.

What do you think?

> > 
> > Originally, commit e2942062e01d ("ksm: count all zero pages placed by
> > KSM") marked KSM-placed zero-page PTEs with the dirty bit for unmap
> > accounting, but forgot to clear this marker during fork().  Later, to
> > prevent ksm_might_unmap_zero_page() from underflowing the counters on
> > child exit[1], commit 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter
> > handling in mm_struct during fork") kept the child's inherited per-mm
> > counter and added it to the global counter.
> > 
> > Instead of inflating the counters, fix the root cause by resetting the
> > child's mm->ksm_zero_pages to 0 in ksm_fork() and clearing the dirty
> > bit marker via pte_mkclean() when copying a KSM zero PTE in
> > __copy_present_ptes().  With the marker cleared,
> > ksm_might_unmap_zero_page() will not decrement the counters on child
> > exit, MADV_UNMERGEABLE in the child will not unnecessarily unshare
> > inherited zero pages, and the global counter remains untouched.
> > 
> > [1] https://lore.kernel.org/all/53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com/
> > 
> > Fixes: 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter handling in mm_struct during fork")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> > ---
> >  include/linux/ksm.h | 8 +++++---
> >  mm/memory.c         | 8 ++++++++
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> > index 93793ca6bcc4..3c6db19d825e 100644
> > --- a/include/linux/ksm.h
> > +++ b/include/linux/ksm.h
> > @@ -56,11 +56,13 @@ static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> >  {
> >  	/* Adding mm to ksm is best effort on fork. */
> >  	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
> > -		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
> > -
> > +		/*
> > +		 * Child's inherited zero-page PTEs are unmarked on copy and
> > +		 * were not placed by KSM in the child, so reset its counter.
> > +		 */
> >  		mm->ksm_merging_pages = 0;
> >  		mm->ksm_rmap_items = 0;
> > -		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);
> 
> So I think there is definitely a BUG int he existing code when we skip copying
> some VMAs during fork. We should have instead adjusted the counter as we
> duplicate them into the child process.
