Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46A309EF4;
	Tue, 11 Aug 2026 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473542; cv=none; b=fZm2+KwTgawhh3YWUVh3RFMW+k5eBdZq7nR928fM/cxvAFKjJKciK5ja4/Bk/D+btpUP0HnV0XnrLNehTRzqktlbfkw6jw3M5v1YukLUGspTeYRDLY38jsmFjgBBJGYXkoUEJlIUY7ilTJQH6qQKyNFMAI8nhG8BwbJzYCD4pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473542; c=relaxed/simple;
	bh=2IcxlWhkJXmiisVgN76xwntCvgvmPVpeDxv/wcGIiTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJYmYr5FwUp2I0Yks2cRHXPS79v13IC5P/+g5kmM5vKoWxmA7+mzlCzo4SMJSvdH88yBmjtG4DEYbi/tM2frt8bEgQoickip/jRajQAoOuWwH6Fg3L3LL6vpWdCOJCn81zC8rN+eKDAXFu8bdoi+j0VwqF5sfF99xZFFEkx6nAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsq30oIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsq30oIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E01F00A3A;
	Tue, 11 Aug 2026 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786473541;
	bh=do2XKhDCxgRyux4sbGO+SL+POHJmP39DxWYxzqtT9Lw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Bsq30oIXhtCGipX2jCZP84ZNtzuM8tFQ3L5GV2brb1g9D4/D81M+YkOXerdUs0ZDm
	 03iIxqptAvt9OJMyT8dZrRnesKqppvP1bCc3klOPzFXQdw3Tj+8Cex21Y9F41fiQP6
	 fkax0rNyxxHPz3frRXLXT/7pY2ode3Afw4Ju+GaNbkiERm9XFiEN6kUkxRjLeY/rTm
	 I3oa0HAkc8mNvuu6emrgVl6qZdVYQY9ILjQheCjVUhdgnzsTX0E59Oxe4DfWBNBoj9
	 qp91mZuE0H1hsstPext0uX1OffjetvnRJxGjzkKY4h9BeE9V2+2SgtGsbDRz/HUkkQ
	 vQn3lekeyLeZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC26CCE17BC; Tue, 11 Aug 2026 11:39:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:39:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Message-ID: <2a402225-57e2-4d5c-ab2d-7d8724b86246@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
 <anqnkZceNHyvbR5S@linux.dev>
 <e019296d-43f5-47bd-ab49-6dfd1d8da0cb@paulmck-laptop>
 <anthYiiYPuUYbj1Q@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anthYiiYPuUYbj1Q@linux.dev>

On Tue, Aug 11, 2026 at 10:54:23AM -0700, Shakeel Butt wrote:
> On Tue, Aug 11, 2026 at 10:38:40AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 10, 2026 at 09:43:03PM -0700, Shakeel Butt wrote:
> > > On Mon, Aug 10, 2026 at 02:57:36AM -0700, Breno Leitao wrote:
> > > > I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.
> > > > 
> > > >   INFO: rcu_tasks detected stalls on tasks:
> > > > 	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
> > > > 	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
> > > >   Call Trace:
> > > >    shrink_lruvec
> > > >    mem_cgroup_iter
> > > >    shrink_node
> > > >    do_try_to_free_pages
> > > >    try_to_free_pages
> > > >    __alloc_frozen_pages_noprof
> > > >    alloc_pages_noprof
> > > >    pte_alloc_one
> > > >    __pte_alloc
> > > >    handle_mm_fault
> > > > 
> > > > Nothing promises direct reclaim returns in bounded time, and the scan
> > > > loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
> > > > PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
> > > > quiescent state, so the reclaiming task never reports one and becomes a
> > > > holdout.
> > > 
> > > I still don't understand why cond_resched() is being treated as involuntary
> > > preemption but that is orthogonal to this patch.
> > 
> > The history is that cond_resched() was originally intended to be a
> > preemption point in any otherwise non-preemptible kernel.  Therefore,
> > because it is a preemption point, it counts as an involuntary context
> > switch.
> 
> Thanks for the explanation. Is cond_resched_tasks_rcu_qs() voluntary or
> involuntary context switch?

That one is voluntary in order to take care of Tasks RCU's need for a
voluntary context switch.

Except that it doesn't bother involving the scheduler at all, but
instead just updates the current task's state with respect to Tasks RCU.
Much faster that way.  ;-)

							Thanx, Paul
