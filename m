Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC544014B2;
	Mon, 15 Jun 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536474; cv=none; b=LkHcxAYFWePhxDMzwV80GA5psW7MtCOWbXjew3ID7r4TiNN8j8WLlVcieGVSFb93cFiJ/OrE3AbM1j/iXyKJJytR5TrK/fspTcNEEyTujS02ymWzwLx7u5gQeIgJEKvF62RiuJPh8m5k/9M8wCsQ7jAoMdN83Nmc/5M92UDMW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536474; c=relaxed/simple;
	bh=TqCvq8HuzjhtLuGo9AEWhAkADYM7OhlJv5p4sTGdXLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSbJftIDDymgFDZv8ZT+Rf0z2CUZ8DwCUSYrHSgtMLbigBRUmvTTSDJh4eJjsimNNMfoCI5YlZvEAcxNdQWMhahLXC6jM/LKBfFes1AW6M1fwP7dToqbnpOGoSwfJVd8TqyTwb8V+Xt5BhrpJf0ID88x2AOOdltgvJ+ASuTsppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mnqinHxO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mnqinHxO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B3B153B;
	Mon, 15 Jun 2026 08:14:25 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD2F3F915;
	Mon, 15 Jun 2026 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781536469; bh=TqCvq8HuzjhtLuGo9AEWhAkADYM7OhlJv5p4sTGdXLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnqinHxOiPCCvyPisW0wug5785E1Is8A3HtzdDQZacq1hYP9wlIO1HiQO/7qC0B/V
	 dmTQtXKezHaRtwo+lG7oAfK07xDSHjruWvnpR7kESoW8dE2zBussBILxyc1BIkxJ5V
	 HO7T9p09f4dsui+MkPT+VrzxrSmLLJ6+4xyVveoc=
Date: Mon, 15 Jun 2026 16:14:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ajAWzSN_dgD9K_FY@arm.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
 <aiw9u4BllwZXDH2S@arm.com>
 <ai_wOdHprarXnURN@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_wOdHprarXnURN@redhat.com>

On Mon, Jun 15, 2026 at 02:29:45PM +0200, Oleg Nesterov wrote:
> On 06/12, Catalin Marinas wrote:
> >
> > Yet anther variant below, untested. Basically, it follows the
> > next_tgid() or task_seq_get_next() approach (we might as well move this
> > to a separate function to avoid excessive indentation):
> >
> > 	if (kmemleak_stack_scan) {
> > 		struct pid *pid;
> > 		int nr = 1;
> >
> > 		do {
> > 			struct task_struct *p = NULL;
> >
> > 			rcu_read_lock();
> > 			pid = find_ge_pid(nr, &init_pid_ns);
> > 			if (pid) {
> > 				nr = pid_nr(pid) + 1;
> > 				p = pid_task(pid, PIDTYPE_PID);
> > 				if (p)
> > 					get_task_struct(p);
> > 			}
> > 			rcu_read_unlock();
> 
> I don't think we need get_task_struct(p), the code above can just do
> 
> 				if (p)
> 					stack = try_get_task_stack(p);

I think we still need the task_struct around. It depends on whether
CONFIG_THREAD_INFO_IN_TASK is set but even when it is, the refcount is
still in task_struct and task->stack_refcount does not prevent freeing
of the task_struct. Then we have the !CONFIG_THREAD_INFO_IN_TASK where
try_get_task_stack() does not touch any refcount.

(or I'm misreading this code)

-- 
Catalin
