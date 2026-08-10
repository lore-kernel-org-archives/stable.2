Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB092344D8C;
	Mon, 10 Aug 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376294; cv=none; b=hIa0+bZ58gwT+lvo5rpAM1mjWo/o0Pb9GkJdDdWDlJcAoCk5fk3oFhT2EexjYLYKfo1CSDAR7Gou1Lmuv4xMqg8nmNdbdJxKHp8V0UQXkxM/PQAncNAUk12mm9SfJNYWHTJODL8YSY0pFwzqMRRpg5D/cmRRcABDBjHfaeYYENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376294; c=relaxed/simple;
	bh=IusbE80q4cJCIS6atf7A1Cghdzu0D+dRbr+vAl1F3I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg6PE5K1oUOOsWnPyyuhkiisydXHfUcS9/CnuXJ4c/0+4sREP/1QlGCQ89ge4mRf0jrf5MNWyu1iHRANmOpx8EvKBeYkF3q05AMxYlN1MlrF3682pDfYsPv6OA5Lb1AfzXxl1JIXlK3sfylxb5gYVM+rTEdS3WA7QQ5Vq3fy8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYA+p6dL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYA+p6dL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387DD1F000E9;
	Mon, 10 Aug 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376292;
	bh=UD1jUU/Xp6ZTbXB7QP7I5IDt9vAd1Pf4TVWzTUto5Uc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KYA+p6dL02ZGEdXx7zR35VtI8zyVtbLlfzKYRhERDFrrcBsfy+pzO8JmcSh8Qz/7y
	 MalDzJ+rVHBIlJmqjYEHaO21ZPbtLOqYV9/CazxEgNhDDOAtPKdFcbDKeXh6QIa6MM
	 Sqk3gFjMruWaaUNVdydE/bHwggT15Z7IzjlyrTm+aP0254CNoTFIuFupBzUW2+1gF8
	 i2+o3nQhjeNpz5PezqMlngimWvIwFoYh8VKJhSMiXm1KMW54L5ipjBzuivRKc7u9Si
	 8P9bmKAascdq6qv1IaU0S15GwJDUKj2VdowYiv4l2Pj1hqKze9A98+75DIHDODPviD
	 rV0Z5YRvj9SnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB5B4CE0B65; Mon, 10 Aug 2026 08:38:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:38:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Message-ID: <0d6559c8-3b47-4300-bde9-9275e452d32a@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> 
> Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
> state even when cond_resched() does nothing.
> 
> PS: This has been discussed in [1]
> 
> Link: https://lore.kernel.org/all/amdWVTs0WKOxguxP@gmail.com/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 26436059ea394..6ac2fde137b89 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6023,7 +6023,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  			}
>  		}
>  
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  
>  		if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
>  			continue;
> 
> ---
> base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
> change-id: 20260810-rcu_task_shrink_lruvec-711112e87de0
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
