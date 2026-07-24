Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DB2E7F2C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916462; cv=none; b=HzGiMwtIbx4s202TYMGRmB669au9kBO3oyCaIDqlScYOYTS+kI7zXPV9+J2mh6koGNRYurUQ8IGr0/Y0EwbLn+gElprE5gust9+MfCWa87vbTj1adgKd1WrW5pZSwgXcXoAKzmKycZxtknOLeFG2gvZxkdAQTzJhLEZI38FWOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916462; c=relaxed/simple;
	bh=tmYmyf97sfoiQLEEAY36DBZCB6pTgGKz0lACx3VRkJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neJTxBAZUmYDnBg907dgYZUm6YIxw/LVJYsrRikUUv5Tg0Jw6v/cEgGq4zwfdWMWEOh5Cf+/Fx4OHauLmPRI+hCAqiNo7oAD23d3DToDEb0CjcGD8OX6ASMXiz9N4JS4aNFmHXs5ADIFokmNE6KFTkzoWDNMDMuLzp3p35UKFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=j8sKTQrG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="j8sKTQrG"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so9202716d6.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784916456; x=1785521256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nJ7PDP3fl+p5a28n/jRHcjrCN1+1Z9szAdk1WdxxOqM=;
        b=j8sKTQrG8FpVgQbzYha5FTO6MfIaiOFpy9ieq75ImgIAWE8MM8/Rzh6NwvqgK8s+VA
         m7sUKywuFLifToJCmXsy4GvlOdYlibNckEKAeCLsTqt3ErNrCmLAOo3A4uVSr7kwsLxz
         LxevfLSG8jS36uXFUK8XvLGBE4S3NjauMS+4yptzOJldGu4S7MvS0ElvV6mR8Vwjj5Gg
         KM7e9CIqCwALDZ6TUwTWHZcVN9qjzMZPxx/B6R30wYZCCy0JRcDpaCeoJCVVBKafUybM
         J/l32Btdq9EV46ajqgQlzZyqmE1HIk98qFpFVzbwaIhhLG401Jz/QXVbZQkkQglARB4k
         AUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784916456; x=1785521256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJ7PDP3fl+p5a28n/jRHcjrCN1+1Z9szAdk1WdxxOqM=;
        b=celXTkvDwnI6Fq77aibqZtOIsQ5tBVaNDlnaQuqetuI9HHh19o5hl9D/XNtmvsGrin
         X3VDld9sko9JIh/RHTTldv/XHaBpEV2OG9IGicjp406ZoLc1OYol4TMCK2vpNafW6+qn
         M8YzU+CyQhd4Wk8jy28wZv3e4Yklg2Ib6m2yKuXJQLYEic+bBCEJHJDyWiWrtJJzFmAt
         ukOIrSBrqkTkP//FrZxPAB0LoQGzqN3AwU+a9BscgX+vPhwqPSI0kFCDxGlBF962MN5E
         Dv54YzuvMFE+DZONFTsVQLWsCtHIeLRgiDjnMjeZjbQOPiGqgwUxl+UR5VkuvRIGsaAW
         1Rtw==
X-Forwarded-Encrypted: i=1; AHgh+RrdHIvQs8SxP9DQJmMb/PQhpqHgXGY+Ojys8m6UkeRq/W3GuROUxyW0YHL0mZf7UkFNZJpcLPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhleEhAuqUkbtYu1e0JYNHykDim4TmWrG4NCro+w4xJ9glt2iO
	kBfr2e3LkPp8YDMLpO8/Th2c7FpGgUKYQxYAL1sFrcTw23Y/IGGkc+WEn/feOeZyzqI=
X-Gm-Gg: AR+sD128L0aBBd6Sggytz0jd4u+IC8j+22s7MNYq9b0luxkhrjPy219a9bSILCS/m/v
	JVU9KlbI114Mr0C+Cmk53YTmw53GXd7nMGRrlOLSj3lb0vbVI1lxcsjUqZWp6YsWzqe/CUT4QeW
	+d2/0ub1p3KBLdXxFLERTKAzk4kekiGeEp0d2hG+eKnxgyIGb2YA9IaC1PtwbVEhNzGEZbbe/ko
	z/6Yictlu6l18qBDPLb93AUKOucPSRrUoZJMCtW6vDgWFv4mDjTA2DhuQ5FjTmotGFnk0FqU6da
	LUIPKho2SLettgjTIBnaVTGpbtq3To1+elPB+igFF0uCT0e55jpYaa4fweWde53WPo52KQPnvdU
	M8PGbkvkfST1J9v7b+3uC+mBsbTmxGCu/oOBn6amcNW0eSXC1Lcm5a7lw1EPBuvt9PnunKHf+Ob
	m9dF+ai+iHANU=
X-Received: by 2002:a05:6214:5c01:b0:907:562d:e3 with SMTP id 6a1803df08f44-907ca33efbbmr100210026d6.39.1784916456394;
        Fri, 24 Jul 2026 11:07:36 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e854feadsm3525256d6.15.2026.07.24.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:07:35 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:07:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Message-ID: <amOp4wV3Yl6PKx_1@cmpxchg.org>
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
 <DK6WANTYCK4H.CRSXHW3ST1Q5@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK6WANTYCK4H.CRSXHW3ST1Q5@linux.dev>

On Fri, Jul 24, 2026 at 03:09:49PM +0000, Brendan Jackman wrote:
> On Wed Jul 22, 2026 at 2:56 PM UTC, Johannes Weiner wrote:
> > As we deployed defrag_mode into Meta production, pressure spikes and
> > excessive swapping were observed on some workloads. Tracing confirmed
> > that this is unmovable/reclaimable requests spinning in the allocator
> > and direct reclaim, causing excessive amounts of swap.
> >
> > The initial plan for defrag_mode was to rely on kswapd/kcompactd to
> > produce blocks, and if those are overwhelmed under high pressure, let
> > the allocator fall back (__rmqueue_steal()) after its retry loops.
> > However, that retrying results in more reclaim on some of these
> > workloads than we'd hoped, sometimes excessively so, spurred on by the
> > !costly order conditions in should_reclaim_retry().
> >
> > The storms are dependent on the request type. Reclaim will inevitably
> > make room in existing movable blocks, since that's where the LRU pages
> > live. So if movable requests retry on reclaim, they make progress.
> >
> > When non-movable requests spin in reclaim that isn't productive. They
> > cannot use the individually freed pages, and the process is unlikely
> > to accidentally free whole blocks to meet the ALLOC_NOFRAGMENT bar.
> > They spin and overreclaim excessively, which tanks performance and
> > triggers userspace guards like swap exhaustion or pressure based OOM.
> >
> > To fix this, send non-movable requests, regardless of order, into
> > pageblock reclaim/compaction. This way, they help move things along to
> > meet the ALLOC_NOFRAGMENT bar. After this patch, the reclaim storms
> > and excess OOM rates are no longer observed in production.
> >
> > The longer-term plan is still to have all requests, including the
> > movable ones, help make blocks to spread the cost of defragmenting
> > more evenly and fairly; combined with proper watermarking to reduce
> > allocation latencies in the common case. However, doing this naively
> > unearths scaling and concurrency limitations in compaction that need
> > to be addressed first. Promoting just non-movables for now is the
> > minimally viable bug fix for the above issue.
> 
> Please forgive the noob question, I'm still struggling to get a really
> good mental handle on this stuff. But what about compact_first here?
> When we're promoting the order for compaction does it also make sense to
> promote compaction itself?

My understanding is that this is just an optimization for requests
that are more likely shape-limited (block contiguity) rather than
capacity-limited (free order-0). In that case we do a quick async
compaction attempt first and skip a potentially unnecessary but still
disruptive reclaim invocation.

However, it does seem to me there is a bit of redundancy between the
allocator and reclaim: direct reclaim also has that early bailout
condition on compaction_ready() for costly orders.

In defrag_mode, since reclaim is promoted to pageblock_order (costly),
we always bail reclaim on compaction_ready(). So I would assume there
is not much difference from which we call first - although I have not
tested it.

> I'm aware you said "minimally viable bug fix" so it's fine if this falls
> outside of that, I'm just trying to poke around to improve my
> understanding.

It works in production, but I'm not entirely happy yet with the retry
logic. I also find it somewhat difficult to understand, especially the
split between should_reclaim_retry() and should_compact_retry().

I'm working on unifying them and put the defrag_mode order promotion
directly into the slowpath function. This way we can use "work_order"
and "order" throughout the functions and its callees as appropriate.

But yeah this is follow-up work to the fix here.
