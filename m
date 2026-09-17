Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C9342539
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661912; cv=none; b=IzcQjTwoTOA9TFNiITstEaJjqcz5P7ZS/yBwJXFlpgsDWUUwmyZGKXbYWpKodDwwutMHzptskQXb+qvTQF+CjugsVdNDGah9Atg0ySPRDPAvTw5kU9Xg0rvrcCxR4EYv7CE92SnHAaM4azkcMRs9ZE8v3QZZsQMhWb/R+Svxgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661912; c=relaxed/simple;
	bh=7f9ugOGKQTW5Qk0ljS3y/iJ8JBgiKvV2cFwYzY+rjQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEfB11ipKAxbYA5lalo3EOZU+JZ16egzENSnUgdNfvf6+G+/tlXdY+6D71f+uKMYIbnMelmqVfydk2jeAx2/yFDrH5njdZzEfDbv9FPgOIZJ8c8tNTKAoPndk+1azcboMzNlatVqoT7edB3MMoP3VudL0hl7daayLKb5LvEdxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MCNkybBF; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MCNkybBF"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca17so8193421cf.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789661909; x=1790266709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q2Hi4m2vwNF2BZX3mSCnm4rmtg2QaJGcI1RAR8lvzaY=;
        b=MCNkybBFVs4KT4lkgwKhcevMElK7POSD6QbaPiBMFZFYcsKECpqgmtytFsY0ZfKHH/
         1yh55p1FN79bjKJRKu7yg870yd7eNJQB4IbVCrrLDo2N7v+bViVf5VcHLRWSma3moMwh
         uAYVZZMb/aNpY6C3BYKy21WpdThDE8RZZ949kRg+dCiUcWZ5m+wwzcRYXIVpSrsESqjA
         r68mWXSiC1x80bMVSRRg9Uhj2JMJZs8LLyJIkCANehpYxnAMfSvdI8A3beFyHkadrwGk
         6D8p/xrNnnFKncXFSx80TLuSZw44/dluB4ifBgAs8bY6eBf6T5bCEOWEY1W3/ayirLlR
         o8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661909; x=1790266709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2Hi4m2vwNF2BZX3mSCnm4rmtg2QaJGcI1RAR8lvzaY=;
        b=G9X/fC1e0hV7jPblqpslAtdOpsQTn9uXpivs8DAeSRIptG7wZqkajbxweeBTHBbvDy
         scwsl9datn5lpw7eJP+Lt+qoV/MIePv+BAL2UPSkWCF9zS3JHmy3l6d4Y5Orl2YJB9bQ
         U5Gx2jyEYu4AXGICPDMvK68ALcmx2KFlwiw6Kazpu0oRfGYKo6gv74QCp68tWz0MZmky
         qJLJndHLn+Ngrudsza76/jXr49Bqmfok4ryEIDaXn/zd0G9Bsaz2EDohgwenWC7HWE1m
         c3Vj000N0zwKFlVIAXoXambCADtDU06wfXDol/amYg29ticpWO/nIMoZTS30BjTBoZCd
         klJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkMsmuxQ+Ona47IE341w/I9Q4xpaqRkuvHLjWA7BWBQgqM5Zj0Ee3eESqYIZy81T6ZyFPbBXA=@vger.kernel.org
X-Gm-Message-State: AFuF++kX3ZKxUYWIGY76bTRfLy820KtRNxuNo8LGAauS21lehP0FbLLq
	4vLaR9SSEe0aEL1xbu/iIc3+BcQHdiH0OIhDsnvxxlMXDqva1AH7x7Xne+ErLmwP9/Q=
X-Gm-Gg: AYBFou3Q6ae2+Rc4pod1m27vPlr67wTmpCZC42rpkDftxB9/pv0iTt/xf4JQJxJzlRe
	c5XoThKRWOsz8ylKd/v8xW4B9RDfUu/ROuUBVQO63LFKdsAZGYP+znv28sExGEczQJi20SbA6O/
	HlaMVUUsaVvpEwb1GfFh/ZObo1fb6C5lUv920HipLTiXSMICGfUEZyPnyDcAdD5+cXks+F4Uz+1
	EiGZoYfvLjZ81odsWk90e5J5Jvi3hNBfTnSRu/cq//eJdDEYb+B6Pp4pb+B4L6eftW6oOoDbczs
	6v2meFapXuWr5XYqLDCICXSNBuf4Qrc3dPpykcpL1YMgMwKh30ywURCCaZdDg8V3Japay2czSbR
	2zk1DGaU47OEyM5MkrkQhhp/JSqzIQlJkeZlL+kYooQqy7WlO731O1h8RopK8vqIbpb8aB0T0R8
	X13PIKLIhz2kqdWH9Sny0zQsh4lZWAi98RYIv1cUZQ86VWpfmgqKiqn+YLySSnvqVed13ewv7lX
	KdTSa4YNWGkg24tS0zZ10HAlyA2trhk3Lqn4tUaYYOxc8NwpbhrqSQe7hnce3co/g==
X-Received: by 2002:a05:622a:90c:b0:530:f9e4:a0eb with SMTP id d75a77b69052e-5327ee3c420mr143369761cf.18.1789661909071;
        Thu, 17 Sep 2026 09:18:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620ea2efsm54577441cf.31.2026.09.17.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:18:27 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:18:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, 
	osalvador@suse.de, hannes@cmpxchg.org, raghavendra.kt@amd.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <aqwSBkeP-Df2GBLa@gourry-fedora-PF4VCD3F>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-3-gourry@gourry.net>
 <20260917160827.GN4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917160827.GN4121339@noisy.programming.kicks-ass.net>

On Thu, Sep 17, 2026 at 06:08:27PM +0200, Peter Zijlstra wrote:
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index a369d0c95c38..afd9c97d2389 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2697,12 +2697,14 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
> >  		/*
> >  		 * Do not migrate file folios that are mapped in multiple
> >  		 * processes with execute permissions as they are probably
> > -		 * shared libraries.
> > +		 * shared libraries, unless this is a promotion from a slow tier.
> >  		 *
> >  		 * See folio_maybe_mapped_shared() on possible imprecision
> >  		 * when we cannot easily detect if a folio is shared.
> >  		 */
> > -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> > +		if ((vma->vm_flags & VM_EXEC) &&
> > +		    folio_maybe_mapped_shared(folio) &&
> > +		    (!folio_use_access_time(folio) || !node_is_toptier(node)))
> >  			return -EACCES;
> >  
> 
> Semi related; I've often wondered if we should still account shared and
> pinned vmas in the fault statistic, even though we should not migrate
> them.
> 
> After all, those pages are still used and by not accounting them in the
> fault statistics, it becomes easier to migrate a task away from them.
>

I don't have a strong opinion here to be honest, I'm just trying to get
tiering back on track.  There's some scheduler voodoo there that I will
happily claim ignorance on, so I just tried to keep things as-is here.

> Using the scanning for two different things has made a mess of things
> though :/

This has been my takeaway from this fix as well.

Honestly I'm starting to think hint faults are a big hammer making up
for the lack of hardware support for getting this data.

Would be nice to just have the hardware report what's hot (and how hot)
rather than depending on a software-heuristic like deriving hotness
from a page fault.

~Gregory
