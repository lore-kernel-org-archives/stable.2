Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42D468C05
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470903; cv=none; b=WyuEc7rdrB1q39N6m5YBXgOQ3lBOKR7mEfUHiURuYkhVYPH2oKyGcS4TswS06HAX3nnMq7ulugPDOJH2fRc4kAMI6zed6jGx7SvV/HRXNJjm3NBKqh8fNBzbfMuiXRUUI5GRVh/DecQ8oH2hKi55AdH0yWPBuUySLzi+ZrLjgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470903; c=relaxed/simple;
	bh=sdKPNZB/EbvoRufnXKQTKh044E5S8QDYW3oAeVfkLeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ7m9uvKRyyOZpATjUEGGEXmDwsABYUjmN3s8tihCNMDIt5gpF1v7tZPT5PN2jWtV2PJsQkuvpPijQOoiNMic5AogB5d1ADT90gfQif0DkDM9ilIbc0tjcV8U675Wfw2liV8VFvcfjusSc8m2QsqwLvaKuS2zJpeL3QjZ+ZrTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IAHxzHg3; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IAHxzHg3"
Date: Tue, 11 Aug 2026 10:54:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786470889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlQGZdIlw8dZKOYB+3h54gW4Pow/7J1yzxtJDd3AvJo=;
	b=IAHxzHg3SZAFfF7I0+DqOl4o5Jn88kzxU2J5dQxlDMgdAmfj+lR5fYQUx7uBaMsccKWTwO
	/MPhdZVkA5+ETCRy/MDoScErxkyKrbSJ/UrKxkLFs9QfP5kuDJosDgY40nnMT9HB4DzGLg
	sO3XvGk9zhDUuU8hKdb0c03qVuJbk9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Message-ID: <anthYiiYPuUYbj1Q@linux.dev>
References: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
 <anqnkZceNHyvbR5S@linux.dev>
 <e019296d-43f5-47bd-ab49-6dfd1d8da0cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e019296d-43f5-47bd-ab49-6dfd1d8da0cb@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 11, 2026 at 10:38:40AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 10, 2026 at 09:43:03PM -0700, Shakeel Butt wrote:
> > On Mon, Aug 10, 2026 at 02:57:36AM -0700, Breno Leitao wrote:
> > > I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.
> > > 
> > >   INFO: rcu_tasks detected stalls on tasks:
> > > 	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
> > > 	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
> > >   Call Trace:
> > >    shrink_lruvec
> > >    mem_cgroup_iter
> > >    shrink_node
> > >    do_try_to_free_pages
> > >    try_to_free_pages
> > >    __alloc_frozen_pages_noprof
> > >    alloc_pages_noprof
> > >    pte_alloc_one
> > >    __pte_alloc
> > >    handle_mm_fault
> > > 
> > > Nothing promises direct reclaim returns in bounded time, and the scan
> > > loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
> > > PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
> > > quiescent state, so the reclaiming task never reports one and becomes a
> > > holdout.
> > 
> > I still don't understand why cond_resched() is being treated as involuntary
> > preemption but that is orthogonal to this patch.
> 
> The history is that cond_resched() was originally intended to be a
> preemption point in any otherwise non-preemptible kernel.  Therefore,
> because it is a preemption point, it counts as an involuntary context
> switch.

Thanks for the explanation. Is cond_resched_tasks_rcu_qs() voluntary or
involuntary context switch?

