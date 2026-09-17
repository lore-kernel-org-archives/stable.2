Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C650EBFF;
	Thu, 17 Sep 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662223; cv=none; b=FkFT0G6OQyMu1fzkg/6Ic8EgXm/wBDPYHDfmMJEL3CQEi2KEZ+ui9XgJSpxBQxNsrxL8qOPjY/fLcoCohEP56Zb8jNsH+Pjqk76QphIgLKbXjpnQgiTLebsrgBqPdn2n6k4cIshvkoARfC5Ly13iBGLbICOFhmjUcaePs96dJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662223; c=relaxed/simple;
	bh=9VDNn3ef6f6AzNuZmQfHkaBYtuXx8fKs++DI6QHVSZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl78Avxi3nyLkCuMLpVL067IH2/pE6hNGMh1Q/qS/qlQCUmebQBQBSTs4tU4ayuFFKJNmxLgsd9wvSIO5y8GYzlBdapQ5+macmYAsL1Orrs2K4MAxPJhzLtPWONTyflkrKjWPGOMUE543fy73du75JpoIROrpdwf8e0GiRO7tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LON76xnC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LON76xnC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=akxJwcOoJrvjy31LionuZZGpZM3k20wc3rbedtFuCUI=; b=LON76xnCeHbv2ylczLrJJF42Wu
	yOy+OAZXXgl93ZHt9cCEq6IsAl6qiI0NjT1zz4oDHHi4s1+yqNeRPBfyqGMQDeUQ1Ptr1sBPFxePm
	lYLHliWUlJtZB+c8QKojwptdjZnpwRjedSUTh9SvYgMRiWH6oWwp29dGqobOj91gpqjxcOT2U0wbV
	RXFyFIUk6e/EEtKYC/lxFq/Wfqjg19F3opRtlAasce3lkGps0GdnLEr0UttV6k8/rhTRRyjZLnmHs
	BtNpl1SFml80noMK9mg5aH9wp6PS6IW6xuJIkxfl6ynACjQ9CEuX01793uKLjj6ML9aIWIilpQgfL
	Qqq9Znsw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7EtR-0000000B13U-2L6c;
	Thu, 17 Sep 2026 16:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FD47301BD5; Thu, 17 Sep 2026 18:23:24 +0200 (CEST)
Date: Thu, 17 Sep 2026 18:23:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	jannh@google.com, pfalcato@suse.de, osalvador@suse.de,
	hannes@cmpxchg.org, raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast
 tier
Message-ID: <20260917162324.GP4121339@noisy.programming.kicks-ass.net>
References: <20260911001826.2109390-1-gourry@gourry.net>
 <20260911001826.2109390-3-gourry@gourry.net>
 <20260917160827.GN4121339@noisy.programming.kicks-ass.net>
 <aqwSBkeP-Df2GBLa@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqwSBkeP-Df2GBLa@gourry-fedora-PF4VCD3F>

On Thu, Sep 17, 2026 at 12:18:24PM -0400, Gregory Price wrote:
> On Thu, Sep 17, 2026 at 06:08:27PM +0200, Peter Zijlstra wrote:
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index a369d0c95c38..afd9c97d2389 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -2697,12 +2697,14 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
> > >  		/*
> > >  		 * Do not migrate file folios that are mapped in multiple
> > >  		 * processes with execute permissions as they are probably
> > > -		 * shared libraries.
> > > +		 * shared libraries, unless this is a promotion from a slow tier.
> > >  		 *
> > >  		 * See folio_maybe_mapped_shared() on possible imprecision
> > >  		 * when we cannot easily detect if a folio is shared.
> > >  		 */
> > > -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> > > +		if ((vma->vm_flags & VM_EXEC) &&
> > > +		    folio_maybe_mapped_shared(folio) &&
> > > +		    (!folio_use_access_time(folio) || !node_is_toptier(node)))
> > >  			return -EACCES;
> > >  
> > 
> > Semi related; I've often wondered if we should still account shared and
> > pinned vmas in the fault statistic, even though we should not migrate
> > them.
> > 
> > After all, those pages are still used and by not accounting them in the
> > fault statistics, it becomes easier to migrate a task away from them.
> >
> 
> I don't have a strong opinion here to be honest, I'm just trying to get
> tiering back on track.  There's some scheduler voodoo there that I will
> happily claim ignorance on, so I just tried to keep things as-is here.

Yeah, fair enough.

> > Using the scanning for two different things has made a mess of things
> > though :/
> 
> This has been my takeaway from this fix as well.
> 
> Honestly I'm starting to think hint faults are a big hammer making up
> for the lack of hardware support for getting this data.
> 
> Would be nice to just have the hardware report what's hot (and how hot)
> rather than depending on a software-heuristic like deriving hotness
> from a page fault.

Yeah, there is/was this patch-set from AMD that uses their IBS counters
for this, but 'ab'-using the performance counters for this also has ick.
PMU data isn't ideal either. Mostly they generate a ton of data that
needs to be analyzed as well. Its not clear cut and easy.

I'm not sure there's been proposals for better hardware support.
