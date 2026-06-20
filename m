Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998E1BBBFC
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782000020; cv=none; b=GAv+ut1Z7bfsPPUNnYl1om0oyeqf/mFJgXvyZoT3FZ6MKaAnLpOIjuwj6uDgfEZ8wr/VIyHw5HBLkuyv7OjrnFxs8/1UfGtiFphpULVx317m6k7C5R+nQu7STQr+k7tE/SmE6Gmmo+ImFDhyl3iJRcpEi2wUJQwJ0TPYIuNxmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782000020; c=relaxed/simple;
	bh=THoMjS5P8rRPLfdpA2khAi4J+HG4OZ65hEd1yfBbELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXaBw7Y7+tgummnHhqeJsdjO9IbFUJbkqR/Qjo/AI+kFw5jGJu283+vnvA8AN0mz1wpur0olYUp0Nksy8+3r0leOgUso2Zsulz8MZVWacF9spz+e5uv34pueRZBjhOi1AHlLiJj4aU/nXfgF9R1QqHieKEqdDEdXbWQtBik1wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8fEWxL/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8fEWxL/"
Date: Sat, 20 Jun 2026 23:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782000007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8DR1NL1clN/D0PALl4ZSRlHhu6LMi/K1lpoGDWtHVw=;
	b=n8fEWxL/zvpO7q3SfWA0VDNtohcksoOrUtuGpMyRTqUeqriaswG8bDp4LResEEfcpNgrPh
	FXqgFxhN5vejvSqdWUkUWdQrqt6QTC+DUpXI6PeFvHUJBGylUBXntEmXRXeUmGKKib8xSQ
	lX9IRhvpTS51a6BZPWj1fl0mnasvMMI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
	Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
	coregee2000@gmail.com
Subject: Re: [PATCH V2] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Message-ID: <20260620235953.tiofjko4spmm3isd@coder-jfernandez-main-0.coder-jfernandez-main.remote-dev.svc.cluster.local>
References: <20260205155425.342084-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205155425.342084-1-ming.lei@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, 5 Feb 2026 23:54:23 +0800, Ming Lei wrote:
> Move the flush from __blkg_release() (RCU callback) to blkg_release()
> (before call_rcu). This ensures the RCU grace period waits for any
> concurrent flush's rcu_read_lock() section to complete before freeing.

We started seeing this in the wild on a 6.18.35-based kernel as a NULL
pointer dereference rather than a KASAN report.  The freed blkg /
percpu iostat slot gets reallocated and zeroed before the concurrent
flusher reaches it, so bisc->blkg reads back as NULL:

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  #PF: supervisor read access in kernel mode
  RIP: 0010:__blkcg_rstat_flush.isra.0+0x8d/0x1c0
  Code: ... 48 8b 1a 4c 8d 78 f8 31 c0 f3 48 ab <4c> 8b 73 30 ...
  RBX: 0000000000000000
  Call Trace:
   <IRQ>
   __blkg_release+0x2d/0xf0
   rcu_do_batch+0x1b8/0x570
   rcu_core+0x167/0x350
   handle_softirqs+0xda/0x330

The workload is container-heavy with frequent block-device add/remove,
so multiple blkgs in the same blkcg routinely hit blkg_release()
concurrently on different CPUs.

I can reproduce reliably under KASAN by inserting a udelay(2000)
between llist_del_all() and raw_spin_lock_irqsave() in
__blkcg_rstat_flush(), then driving direct I/O to N loop devices from
one cgroup followed by parallel LOOP_CTL_REMOVE on each device.  KASAN
reports slab-use-after-free in __blkcg_rstat_flush() with the expected
alloc=blkg_alloc / free=blkg_free_workfn stacks.

With this patch applied on top of the same udelay-widened tree, the
same harness runs 150 rounds clean.

This doesn't appear to have been picked up after V1 was dropped; would
be good to get it queued.

Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
