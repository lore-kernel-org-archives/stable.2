Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F543B3C9;
	Tue, 15 Sep 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458135; cv=none; b=VHXGGCZRKWqlA0f4tH/ZPpciz9XgorvHy6uY51ZwNcGzCygZWNKNl17VbCu3pkogChy3KtCqftNnUehycKv+y1qTaZY7zkZacUDw94J6kmAdLGUCeeb6Lznp/gqEkv2ug6s8LDb2iGJXPz15Lide6jNjTMey71dj+HRY2QCdkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458135; c=relaxed/simple;
	bh=O89gakJys6wPQGXYejH/dKowwbeP7xrfUSMJnFD+AGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5vSPYfVW4W4Q1WQFmK80KgYR2BBySyiI1ZbdZlm2QAMUI/KRD18zWcJ+Alq3KBGwj/s/60ZMhzXtHBLjp01DShItn76eTEs7fYzegWuvrwANQnrEl+g1fF2eNyPhsn0ClddOrrO9E923aBjILJeGNoWgG9eLYofT0lVlkw1AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f28fd274b0d811f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b152c5bd-7a2f-4ada-813a-7530dbb6c21a,IP:0,U
	RL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c92542d2913318dabd5ee757778a38e8,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:99|11|95|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f28fd274b0d811f19a56ed5b684f684d-20260915
X-User: liuqiqi@kylinos.cn
Received: from kylin-pc [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuqiqi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 281404417; Tue, 15 Sep 2026 15:42:05 +0800
Date: Tue, 15 Sep 2026 15:42:02 +0800
From: Qiqi Liu <liuqiqi@kylinos.cn>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: apply per-task GFP context in bulk
 allocator
Message-ID: <20260915074202.GA246486@kylin-pc>
References: <20260914080451.294896-1-liuqiqi@kylinos.cn>
 <b932c690-7ab0-4521-a7d2-5ed5130379b8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b932c690-7ab0-4521-a7d2-5ed5130379b8@kernel.org>

Thanks for the suggestion. I'll fold this into the commit message and send v3.

Best regards,
Qiqi

On Mon, Sep 14, 2026 at 03:01:14PM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/14/26 10:04, Qiqi Liu wrote:
> > alloc_pages_bulk_noprof() does not call current_gfp_context(), so
> > per-task scoped allocation constraints (PF_MEMALLOC_NOIO,
> > PF_MEMALLOC_NOFS, PF_MEMALLOC_PIN) are not applied on the bulk fast
> > path.
> > 
> > The most direct consequence is PF_MEMALLOC_PIN: without clearing
> 
> I'd say ignoring PF_MEMALLOC_NOFS/PF_MEMALLOC_NOIO also can have a direct
> consequence?
> 
> Let's replace the line above with:
> 
> By ignoring PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS, the allocation can
> theoretically result in a deadlock.
> 
> Ignoring PF_MEMALLOC_PIN also has consequences: without clearing ...
> 
> > __GFP_MOVABLE, prepare_alloc_pages() selects MIGRATE_MOVABLE for
> > the PCP list, and a task with PF_MEMALLOC_PIN set receives movable
> > pages from the bulk allocator.  Once pinned, these pages can no
> > longer be migrated but remain in MOVABLE pageblocks, violating the
> > mobility contract.  This can increase fragmentation and interfere
> > with compaction or contiguous-memory allocations, eventually
> > surfacing as higher allocation latency or allocation failures under
> > memory pressure.
> > 
> > Found via review of the bulk allocation tracepoint hooks [1].
> > 
> > [1] https://lore.kernel.org/all/20260907120949.418450-1-liuqiqi@kylinos.cn/
> > Link: https://sashiko.dev/#/patchset/20260907120949.418450-1-liuqiqi%40kylinos.cn
> > Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qiqi Liu <liuqiqi@kylinos.cn>
> 
> LGTM.
> 
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> > ---
> >  mm/page_alloc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 12fac9084c48..3be7288a1aa7 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5207,6 +5207,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> >  
> >  	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
> >  	gfp &= gfp_allowed_mask;
> > +	gfp = current_gfp_context(gfp);
> >  	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
> >  		goto out;
> >
