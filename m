Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EB38E5DC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643554; cv=none; b=ulbLseo3XJwNBwI+RqMOOqYL2wz73r3Bf8cFgVsE6CSOqmhsx6PshCNhTkxctcY2x3QHJK3kj3Rd196ZULK5z3ZFXebDFvVUQ0BXAc9SFF+OXz4M02ppCMDSwvKF2ebbBKezd3+YJ3GF4oYfAC2eqrqwdHf7Q8KfAElLF1anfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643554; c=relaxed/simple;
	bh=g9NogA9oVcu8vuq1ThsVC0RktLxbiBf9NSWLBooTqw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEbQkLBPVUb0Zt7Pe4XuoI0ETCzkKOM/hCy87nYGNGXS6EW6a4OmmlzZMezyrsKM5lJSFHynXGZKjpqjAR8yCq1WtBzruM04chM3B+opdcvEFOvu5KcE6SzXamMPYLGvx2QN+yblQOnSYkqTbq/bKV0379eP4LaNT2un0AyLUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pq7/3t2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pq7/3t2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BEB1F000E9;
	Tue, 21 Jul 2026 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784643552;
	bh=OpG/eDfF8gnGt+h+orLfT9No39nI2JxnLBjcyVOwaww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pq7/3t2iyoFwba0JMtX5ihckqUJxmnRahZvW62KX34nfdc7Px8XH8ze2evMjHPC7q
	 Re4UnRVOE3Uwdu2f+GoWJsm31sDVuc6XAqtHWbXAcSOWydX4aIC5oUyn07sJXH9ZmL
	 MYUZ8j7XaC9QEf4ccJ6TKnnSOOLtZqq37SjiYMGA=
Date: Tue, 21 Jul 2026 16:19:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: tj@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched_ext: Skip ops.set_weight() for
 disabled tasks" failed to apply to 7.1-stable tree
Message-ID: <2026072141-spotless-tarantula-5421@gregkh>
References: <2026072131-citation-reshape-587c@gregkh>
 <DK4AN7P1B5KK.15R8G3B5L5E85@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK4AN7P1B5KK.15R8G3B5L5E85@google.com>

On Tue, Jul 21, 2026 at 01:47:04PM +0000, Kuba Piecuch wrote:
> Hi Greg,
> 
> I'm unable to reproduce the failure using the steps provided.
> The patch applies cleanly. The code compiles and tests are passing.
> 
> FWIW, below is the patch after cherry-picking the commit:
> 
> Thanks,
> Kuba
> 
> ------------------------ 8< ----------------------------
> 
> >From adc748e669cc1564255430299abf086b9ecd9b45 Mon Sep 17 00:00:00 2001
> From: Kuba Piecuch <jpiecuch@google.com>
> Date: Fri, 10 Jul 2026 14:43:41 +0000
> Subject: [PATCH] sched_ext: Skip ops.set_weight() for disabled tasks
> 
> When switching a task's sched_class away from sched_ext, we get the
> following sequence of events in __sched_setscheduler():
> 
> sched_change_begin()
>   switched_from_scx()
>     scx_disable_task(p)
>       ops.disable(p)
> __setscheduler_params()
>   set_load_weight()
>     reweight_task_scx(p)
>       ops.set_weight(p)
> p->sched_class = next_class;
> sched_change_end()
>   ...
> 
> Notably, ops.set_weight() is called _after_ ops.disable().
> This violates the expected semantics of the callbacks, the expectation
> being that ops.disable() can only be followed by ops.exit_task() or
> ops.enable().
> 
> Skipping the weight adjustment for disabled tasks should be harmless
> since the weight will be recalculated in scx_enable_task() if the task
> ever rejoins SCX.
> 
> Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> (cherry picked from commit 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6)
> ---
>  kernel/sched/ext.c | 11 +++++++++++

If you look, the original file was:
	kernel/sched/ext/ext.c
your cherry-pick fixed that.

I'll take this, thanks.

greg k-h
