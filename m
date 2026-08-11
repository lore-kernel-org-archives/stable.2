Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284983D5652;
	Tue, 11 Aug 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469922; cv=none; b=UhQmJDvHddINMfoeMGRFAbwukaLBIScbtyVTaXlBYsK3wcFasZhJh4/XnUVELORjksrKB/7I+JpEaRXf8aB2YuHibwnIQhXoJomRp0E33yz1OQDS4QKPUrHNf0ofIVRHq5h3fWpNHELQMmqbMa2X3HJCdNeI5A8cwWYwp3GVyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469922; c=relaxed/simple;
	bh=LZE41/5slaD46/MHd9VGAIQqANvj9xcK7PDUhcSCQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEyakIBFm4n0NJb8R5JQitUDxmtRMG60b74CF/dkUOQhXdCo2xNtrJv8mS67cJel5i+wvXzE0/G7JIPHLBujxgQD5a39Zcp3MvLvlTe42eFRfdmF4rqy1GBYAGE7cj/m2FuZLkLSUxg97XrDofi1/HB++3Xqgmde3+zWChBJi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No247fuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No247fuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8501F000E9;
	Tue, 11 Aug 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786469920;
	bh=QEPPggs8PJNHHljShEYMadexxBKRpvP66LYQ1YU/1GM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=No247fuKxaN6t1LDDKmSjpWYovQnxMVIrZbOGR7nbJWXVmMlQGV0liBwMvRhdxhp1
	 b/k7LRWClSY1eDmO0XZhEVEFIzc7Yk6M4hw9jkupgFfkfpQGbL/IhMllGjYbgpGSne
	 fRyaeV17/PPyBPGH9gjiGVbca4LjHXO/ulXuYZ46ZFVdke30I2BJmpDaPUFTycuuH/
	 AewU2NKJFOzRh7F7UBcZYTnhWLnk1HjLIWerJ9s/yZxC/cGpUmtjmeKpa+IYjVN7T1
	 8yBxYV9cRsOtA0M2MhxHx4mqUl6cGhdhbnRMWWEmpD51uSzRLr7xcaThvu9bi9n7ab
	 bFkqn/ra4xYBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89F42CE17BC; Tue, 11 Aug 2026 10:38:40 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:38:40 -0700
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
Message-ID: <e019296d-43f5-47bd-ab49-6dfd1d8da0cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
 <anqnkZceNHyvbR5S@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anqnkZceNHyvbR5S@linux.dev>

On Mon, Aug 10, 2026 at 09:43:03PM -0700, Shakeel Butt wrote:
> On Mon, Aug 10, 2026 at 02:57:36AM -0700, Breno Leitao wrote:
> > I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.
> > 
> >   INFO: rcu_tasks detected stalls on tasks:
> > 	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
> > 	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
> >   Call Trace:
> >    shrink_lruvec
> >    mem_cgroup_iter
> >    shrink_node
> >    do_try_to_free_pages
> >    try_to_free_pages
> >    __alloc_frozen_pages_noprof
> >    alloc_pages_noprof
> >    pte_alloc_one
> >    __pte_alloc
> >    handle_mm_fault
> > 
> > Nothing promises direct reclaim returns in bounded time, and the scan
> > loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
> > PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
> > quiescent state, so the reclaiming task never reports one and becomes a
> > holdout.
> 
> I still don't understand why cond_resched() is being treated as involuntary
> preemption but that is orthogonal to this patch.

The history is that cond_resched() was originally intended to be a
preemption point in any otherwise non-preemptible kernel.  Therefore,
because it is a preemption point, it counts as an involuntary context
switch.

							Thanx, Paul

> > Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
> > state even when cond_resched() does nothing.
> > 
> > PS: This has been discussed in [1]
> > 
> > Link: https://lore.kernel.org/all/amdWVTs0WKOxguxP@gmail.com/ [1]
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
