Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238645592E7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957644; cv=none; b=ps1YphRe74Ed5J6brzCmKipDBwtIC5Fb2IHoTGFlmQ3xivLqqCX+RB/S2nIyyA3imiL2dGrVLyH1YtazVTZAFCrVAT6f9R7gUaKtluue9ZRh+aqRLOIXJMJk/AEdgTBeDFi4qGeUzwimmadgtx/vxxbW+TDP/DSVzW/5E18PqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957644; c=relaxed/simple;
	bh=6FoWX/xdQbqVgm09EhLVDGfoFUUqZopSBryYtbOVmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8mk7gXZbgoV3nv68OVX73AkZqRJqulGztZ7r+2w55I7ZLGixLApq5+/6l/LpW7W8l9AQt0sTSjx/Lc8EIln7mYNaIXi6gmIyHfuFFPOQ3H8v1iccZIY+yZ3+JO8ORoPPjxR5ANKli24Vv4nffKHX7+CE6sAuI5PyYUbJNlJEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTB4HGQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTB4HGQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1E81F00A3A;
	Wed,  9 Sep 2026 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788957641;
	bh=ZLGz7qcCcAldP7WsXSpvwlxG/C40C8HCJfizXJ+53Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RTB4HGQl6Q2qlL8p1xJQm/2C46oX+V7jsK69sP4Rg3wNOeZjhTKU0tpscSSMAXxNT
	 KN70YYNLHWd9P9MUfwpIJn9n43/N5LAYklb15EINjhElGQ/xz+wcBpue+amDOt0b0C
	 r9IKFZ6ziSR+y0aeUdeDWTmJERmdDY3Nxlmhzoq0=
Date: Wed, 9 Sep 2026 14:35:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, SJ Park <sj@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 2/2] mm/kmemleak: report RCU-tasks quiescent
 states during the scan
Message-ID: <2026090934-starlet-arrive-6f08@gregkh>
References: <2026090344-parted-gnarly-5282@gregkh>
 <20260903182658.1452185-1-sashal@kernel.org>
 <20260903182658.1452185-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903182658.1452185-2-sashal@kernel.org>

On Thu, Sep 03, 2026 at 02:26:58PM -0400, Sasha Levin wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> [ Upstream commit 3541a2b06ecd78ba333188df04368dcf97273d6a ]
> 
> kmemleak_scan() can run for ages on large debug kernels. It was
> causing some soft-lockups which I got fixed with commit
> 3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
> stacks") with our beloved cond_resched().
> 
> I've got the fix above deployed in the Meta fleet, and now I am seeing:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>     task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
>      scan_block
>      scan_gray_list
>      kmemleak_scan
> 
> and, worse, blocks the callers waiting on that grace period.  Here a BPF
> struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
> call_rcu_tasks), is stuck long enough to also trip the hung task check:
> 
>   INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
>      __wait_rcu_gp
>      bpf_struct_ops_map_free
> 
> Then I've learned that cond_resched() is not an RCU-tasks quiescent
> state, so, we need to use stronger primitives.
> 
> Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
> reports an RCU-tasks quiescent state as it proceeds.
> 
> Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
> quiescent state for task rcu").
> 
> Link: https://lore.kernel.org/20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/kmemleak.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 5109a9f84ea50..b4a7ed2116353 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1564,7 +1564,7 @@ static int scan_large_block(void *start, void *end)
>  		if (scan_block(start, next, NULL))
>  			return 1;
>  		start = next;
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  	}
>  
>  	return 0;
> @@ -1601,7 +1601,7 @@ static void scan_object(struct kmemleak_object *object)
>  			scan_block(start, end, object);
>  
>  			raw_spin_unlock_irqrestore(&object->lock, flags);
> -			cond_resched();
> +			cond_resched_tasks_rcu_qs();
>  			raw_spin_lock_irqsave(&object->lock, flags);
>  			if (!(object->flags & OBJECT_ALLOCATED))
>  				break;
> @@ -1623,7 +1623,7 @@ static void scan_object(struct kmemleak_object *object)
>  				break;
>  
>  			raw_spin_unlock_irqrestore(&object->lock, flags);
> -			cond_resched();
> +			cond_resched_tasks_rcu_qs();
>  			raw_spin_lock_irqsave(&object->lock, flags);
>  		} while (object->flags & OBJECT_ALLOCATED);
>  	} else {
> @@ -1651,7 +1651,7 @@ static void scan_gray_list(void)
>  	 */
>  	object = list_entry(gray_list.next, typeof(*object), gray_list);
>  	while (&object->gray_list != &gray_list) {
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  
>  		/* may add new objects to the list */
>  		if (!scan_should_stop())
> @@ -1686,7 +1686,7 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>  	raw_spin_unlock_irq(&kmemleak_lock);
>  
>  	rcu_read_unlock();
> -	cond_resched();
> +	cond_resched_tasks_rcu_qs();
>  	rcu_read_lock();
>  
>  	raw_spin_lock_irq(&kmemleak_lock);
> @@ -1731,7 +1731,7 @@ static void kmemleak_scan_task_stacks(void)
>  			}
>  			put_task_struct(p);
>  		}
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();
>  	} while (pid && !stop);
>  }
>  
> @@ -1810,7 +1810,7 @@ static void kmemleak_scan(void)
>  			struct page *page = pfn_to_online_page(pfn);
>  
>  			if (!(pfn & 63))
> -				cond_resched();
> +				cond_resched_tasks_rcu_qs();
>  
>  			if (!page)
>  				continue;
> -- 
> 2.53.0
> 
> 

Does not apply cleanly :(
