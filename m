Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398023B7B66;
	Fri, 18 Sep 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759963; cv=none; b=KSzJJC++4WdJB2l72orcmuBjFHCcpa3eSzpflBp8kVX7oGm5UaTfq5/o+y508VUUarmimcjojVNHcUEZhsQFyw8so4AsQ7j+F6uM2ISJ5za9CCkzvHJ09pwzc2RN9VcalBfkda1QOu3mzZW1ZaNZ8/uIFRP+Y7Ob3TimvBFjDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759963; c=relaxed/simple;
	bh=zUx7Kuxn+6eJHxt0lkTaqPSM5PnlhZSlkXq1l2wW4eo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GDQb7EGWal+vF/BlC9YDgvM7N00WWMMTnYvepWWjo/dhU61GeH+MS3Hh8pfqd0UcoYlHLAK2aruASZVXaMlI/S1/L++c2kx1VCHd4KdaihUBcbPlQKy+D5+vCuR+6pNOUxeKxFoCs+S1YFbKOXMMn2pQsoj2vHaLUZESwrwmnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kr5npqUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kr5npqUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8391F000FF;
	Fri, 18 Sep 2026 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789759959;
	bh=VABaJiNkB+07BojV48SKGNtgg2IwaRyrt+EONkqTGrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kr5npqUTuUYIza0EGwv8Pg0oNpVs/9IBZjeSpnYCPu6IPmMsPIRAUgoG3t7c4L2kz
	 LVnje1t/pJHBSKi241YC/xgs60r2ae+81Xt09eCek58jEYUAcGTfyqSoN/L/TtYEUX
	 HrejmoiEpUBqYcpsbCg8muFi3WxyiezK9mUxrI1w=
Date: Fri, 18 Sep 2026 12:32:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: report RCU-tasks quiescent states while
 undoing a range
Message-Id: <20260918123239.8f25b984ca280fcc11ef6e6a@linux-foundation.org>
In-Reply-To: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
References: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 04:24:37 -0700 Breno Leitao <leitao@debian.org> wrote:

> This shows up in the Meta fleet on ftruncate() of large tmpfs files:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>   00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
>   task:rocksdb:bottom  state:R  running task
>     __folio_split
>     find_get_entry
>     find_get_entries
>     truncate_inode_partial_folio
>     shmem_undo_range
>     shmem_setattr
>     notify_change
>     do_ftruncate
>     __x64_sys_ftruncate
>     do_syscall_64
> 
> shmem_undo_range() walks the whole of the requested range in folio_batch
> sized steps, twice, and its two cond_resched() calls are the only
> reschedule points in that walk.
> 
> cond_resched() is not an RCU-tasks quiescent state.  Use
> cond_resched_tasks_rcu_qs() at both points so the walk reports an
> RCU-tasks quiescent state as it proceeds.

We keep hitting this.  Whyohwhy doesn't cond_resched() imply
cond_resched_tasks_rcu_qs().

> Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
> Cc: stable@vger.kernel.org

That's 2014.

> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  		}
>  		folio_batch_remove_exceptionals(&fbatch);
>  		folio_batch_release(&fbatch);
> -		cond_resched();
> +		cond_resched_tasks_rcu_qs();

Won't this change remove the cond_resched() function from old kernels
which really want it?

