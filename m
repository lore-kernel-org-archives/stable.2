Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8D2877C3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423415; cv=none; b=eZhA2kB2T+TeYiT4Pj1zyn5mus53ww25IhCSlM1ByU2koVbNaGVF8tslor5G9SrVz693Ey7i89/BG1vt01XnYpLcsX+IBiD57ivj1w4TKI2PhknlWRPv/j8sb2dLkBbyrBtaFTn8Z2BxOwN/xLXeJiTFfTYWEjNoQNNl5D1eskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423415; c=relaxed/simple;
	bh=25Kd5oDz3HiAxhr3Y6gzOh0iU2oh3SA8XXonCZFjW1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwxyRs8E0ZOoLfdR8DuIotYSeHxPTgsmc/qXIypI/p4lFOwqQdMk5saQvRzGSO/BTMXo0MyNW6+SoKIJ+rAczunEXGckrb3twq4jJ8iFXSvhSp+49AmUPMAor8HpEzE70FUP7fdyo/k80rfcqLnoWiSVdmEb92rTGvWrlWZvFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5ql89xR; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5ql89xR"
Date: Mon, 10 Aug 2026 21:43:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786423411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TAa3sw5p0PFvqcG8s8R3U9OywJr1pI3i1+gG5+gOdl4=;
	b=c5ql89xRYRy2pSpxstsC1459EUgtdleOV6rPwoKDYgmirKS5mwSSsBYuB/M1bb+lQJ1EoR
	q645k+I9xrkOD7oY9SrI4VwAZKlFfdH6emocNjLWRViEMUD+fcOLFPSfbmoP6HJHwml4bn
	Or/1SYv+F4PtNfIdH9uYlnHY6XLibXs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	paulmck@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Message-ID: <anqnkZceNHyvbR5S@linux.dev>
References: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 10, 2026 at 02:57:36AM -0700, Breno Leitao wrote:
> I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.
> 
>   INFO: rcu_tasks detected stalls on tasks:
> 	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
> 	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
>   Call Trace:
>    shrink_lruvec
>    mem_cgroup_iter
>    shrink_node
>    do_try_to_free_pages
>    try_to_free_pages
>    __alloc_frozen_pages_noprof
>    alloc_pages_noprof
>    pte_alloc_one
>    __pte_alloc
>    handle_mm_fault
> 
> Nothing promises direct reclaim returns in bounded time, and the scan
> loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
> PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
> quiescent state, so the reclaiming task never reports one and becomes a
> holdout.

I still don't understand why cond_resched() is being treated as involuntary
preemption but that is orthogonal to this patch.

> 
> Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
> state even when cond_resched() does nothing.
> 
> PS: This has been discussed in [1]
> 
> Link: https://lore.kernel.org/all/amdWVTs0WKOxguxP@gmail.com/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

