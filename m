Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9C3822AB;
	Fri, 18 Sep 2026 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763095; cv=none; b=V6mXgbVC9cg/QXq1rBNSg24236lNxTPGvtjjiMVfv/gKiPb8oUso/ZEkri0NkyCvZ2DTIs5q/itz+SPvPHC6kPkzhfJbU0xGPk3br3B3NI4ie8YQNK0Kez4W1o9SOCdDCfJnt8VS5divTCiEBysN+jAaanMbT4kdaUqRhG3YYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763095; c=relaxed/simple;
	bh=VuUW+GiEE9nUazia64MA4w6fcXzNGFd8MpY0I77e9Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOmNztbJ3PdU3zmPkZcKvBY0+3qXGqOfje5vKrBpeNJxyOhsPeGESAoPkWV0KTzanl4CrPWqLrH+7rcFtau00UsIZ+17CmKpiQAwzpSIl2IhotXhnJEMl6OhimZEKlwrd/9uBfY3jJ+NmwTNanWmvL4fsymjt8XoL2LYJKSg4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMj3v6Bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMj3v6Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E6C1F00899;
	Fri, 18 Sep 2026 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789763094;
	bh=babmhG3CX0kOyIk0MhmJt1fcAmod/lU85NqbD6hfzmw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fMj3v6BsyPRHwMQyaYa7dqJhrB0LIIXc9+wVmEH9Nyh2d+rxXqXhrA9mWJFHtX2Oa
	 fjNE7R2G250Vrg2BLDuh9n981t4ThUduqFdXwONzqEdNRakcl6hy8FFGCMUVGBdLXJ
	 y8hLr1pFhuPBuZIB4YM06xJZbWQH2XRijwG3BfGMgf/OxSh6l8DJlsbkXAmbkim3bM
	 W9sUuTDt05G1E54xKZ5LsJqv6+1X3Fl/IT7RiKZ2YhrqHH8817hXLauy9NDMRgIQ2K
	 KTx4DZx/sn6Hd2AiYHR0Z/j6aWJOMOMY6kS1Kv6QdIplQVA0i1AP9gumdvIBNe+Bzv
	 SAzDROaU0rcjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C4D29CE09DC; Fri, 18 Sep 2026 13:24:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:24:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: report RCU-tasks quiescent states while
 undoing a range
Message-ID: <a67e8b91-ebc2-4d3d-b6ea-d221b297fad0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
 <20260918123239.8f25b984ca280fcc11ef6e6a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918123239.8f25b984ca280fcc11ef6e6a@linux-foundation.org>

On Fri, Sep 18, 2026 at 12:32:39PM -0700, Andrew Morton wrote:
> On Fri, 18 Sep 2026 04:24:37 -0700 Breno Leitao <leitao@debian.org> wrote:
> 
> > This shows up in the Meta fleet on ftruncate() of large tmpfs files:
> > 
> >   INFO: rcu_tasks detected stalls on tasks:
> >   00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
> >   task:rocksdb:bottom  state:R  running task
> >     __folio_split
> >     find_get_entry
> >     find_get_entries
> >     truncate_inode_partial_folio
> >     shmem_undo_range
> >     shmem_setattr
> >     notify_change
> >     do_ftruncate
> >     __x64_sys_ftruncate
> >     do_syscall_64
> > 
> > shmem_undo_range() walks the whole of the requested range in folio_batch
> > sized steps, twice, and its two cond_resched() calls are the only
> > reschedule points in that walk.
> > 
> > cond_resched() is not an RCU-tasks quiescent state.  Use
> > cond_resched_tasks_rcu_qs() at both points so the walk reports an
> > RCU-tasks quiescent state as it proceeds.
> 
> We keep hitting this.  Whyohwhy doesn't cond_resched() imply
> cond_resched_tasks_rcu_qs().

*I* don't have an objection to that.  ;-)

> > Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
> > Cc: stable@vger.kernel.org
> 
> That's 2014.
> 
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
> >  		}
> >  		folio_batch_remove_exceptionals(&fbatch);
> >  		folio_batch_release(&fbatch);
> > -		cond_resched();
> > +		cond_resched_tasks_rcu_qs();
> 
> Won't this change remove the cond_resched() function from old kernels
> which really want it?

The cond_resched_tasks_rcu_qs() macro implies cond_resched():

	#define cond_resched_tasks_rcu_qs() \
	do { \
		rcu_tasks_qs(current, false); \
		cond_resched(); \
	} while (0)

							Thanx, Paul
