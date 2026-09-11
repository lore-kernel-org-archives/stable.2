Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300BA485CD5;
	Fri, 11 Sep 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132129; cv=none; b=QNX6iElifQOG7yoyUm5CUjXF+KP38Yw5bgrdT6tWEih029N60ZgxJOozN0zaVnPK6iYtKLUg0VEeSWJrxbkJDdKhHEcakz5iFjAYbExmIda7ja60W/Xaiyzreph+CDam+4o1nF+NG6nJ6xqr1FMhPRKRKOiMCQifD1HmRcoOPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132129; c=relaxed/simple;
	bh=iNt6dci9h2IKUvJz0YQiWrA3d8fLeVQdvJoLhn44zZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMOMG4G6c9NPr11yug3oBbic7SJGa8pfEfLm0ijT3Y8WKvIKslytFxuDuhmx1G7oVCY21ZtX6humV5S362d2T+/odrnK28TcQD1uQ3YyBYtyNBpZNBVcKStVADKGLvUEm9+T1wGMcuOQgo6G3/q+okiXG7eWb3VwhPNisJaUNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxrkAnAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxrkAnAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1CB1F000FF;
	Fri, 11 Sep 2026 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132128;
	bh=n1VHONHG9ZichJd9nirKCMDvnRx1U9EW/n/kEkPZzuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MxrkAnAPotL3bthM6o+xTjJJds5sVWBgZTE4OWCQHMNFKwy6zd7Zo5mAg/fFuS7g9
	 +55spiY48eaRfmsYrYBo989ID22+0m+72+BW3A8+pnbvYlI3WcBNUW93ElnZWY76Ct
	 Zi8TkEfA2i8ytNRgvDyC7xRaxhxhBtEkl8rPxmJq8K7n25bmq9d+8IZEzv9QYvWxhl
	 i+ly9lZEnuXza/Ix5d6vkeBOXf9JkppTAlhopjfKilY+SB7nQBXIHUBil+N8cSDL6N
	 GNNdMeIqs9hSltBwg89jeLvzWrN0gS8igILplM5kYeaW5hd6HZFahiKo9bGqxYgreL
	 FuzDUZDZK2FtA==
Date: Fri, 11 Sep 2026 15:08:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alan Stern <stern@rowland.harvard.edu>, stable@vger.kernel.org
Subject: Re: [patch V3 1/8] signal: Prevent exec() race
Message-ID: <aqP9XYckv9mhLuQf@localhost.localdomain>
References: <20260911090341.949101445@kernel.org>
 <20260911090541.572536604@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911090541.572536604@kernel.org>

Le Fri, Sep 11, 2026 at 11:09:12AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@kernel.org>
> 
> Hyunwoo debugged the following KASAN UAF splat:
> 
>   BUG: KASAN: slab-use-after-free in __send_signal_locked+0xb27/0xba0
>   Write of size 8 at addr ffff888007ed80c8 by task poc/79
>   ...
>   Call Trace:
>    __send_signal_locked+0xb27/0xba0
>    do_send_sig_info+0xa7/0x160
>    do_send_specific+0x76/0xa0
>    __x64_sys_tgkill+0x193/0x270
>   ...
>   Allocated by task 80:
>    do_timer_create+0x1a4/0x1030
>    __x64_sys_timer_create+0x145/0x190
>   ...
>   Freed by task 12:
>    kmem_cache_free_bulk+0x1f8/0x4a0
>    kvfree_rcu_bulk+0x14f/0x1c0
>    kfree_rcu_work+0x128/0x1a0
>   ...
>   Last potentially related work creation:
>    kvfree_call_rcu+0x39/0x390
>    __flush_itimer_signals+0x211/0x320
>    flush_itimer_signals+0x47/0x90
>    begin_new_exec+0xa6b/0x28c0
> 
> It turned out that this happens with a non-leader exec() as Hyunwoo
> explained:
> 
> de_thread() calls exchange_tids() before release_task(leader), so the
> struct pid held by a SIGEV_THREAD_ID timer created against the leader's tid
> now points to the thread which called execve(). pid_task() returns that
> thread and lock_task_sighand() on it succeeds.
> 
> If the timer signal is blocked, its sigqueue stays queued on the leader's
> task::pending. The next expiry of that timer can then run while
> release_task() flushes the queue.
> 
> posixtimer_send_sigqueue() checks whether the sigqueue is already queued
> with a plain list_empty(), which only reads list_head::next.
> list_del_init() is not atomic and INIT_LIST_HEAD() stores list_head::next
> before list_head::prev, so the check can pass in between. list_add_tail()
> queues the entry on the task::pending of the live thread, and the
> list_head::prev store from the flush then overwrites the list_head::prev
> link that list_add_tail() has just set.
> 
> __flush_itimer_signals() does not undo that either. With list_head::prev
> pointing at the entry itself, its list_del_init() only stores the same
> values again, so the entry is not removed from the list. It is still there
> after the last reference is dropped and the timer is freed by RCU, and the
> list_add_tail() of a later tgkill() follows that list_head::prev into the
> freed timer.
> 
> This problem surfaced with the recent commit which moved the sigqueue flush
> out of the sighand lock held region.
> 
> Hyonwoo proposed to fix this by using list_del_init_careful(), but that
> just papers over the problem. After some disucssions and various attempts
> to solve it, Eric pointed out that there is no reason to flush
> task::pending late in release_task() and it should be done in
> exit_signals() already.
> 
> As nothing can collect and deliver signals which are queued in a dying
> task's pending queue, there is no reason to delay it further.
> 
> But it has to be ensured that no signals can be queued into it after that
> point. exit_signals() sets PF_EXITING in task::flags, which can be used as
> an indicator for this.
> 
> Cure it by:
> 
>   - Preventing signal queueing for task private signals (PIDTYPE_PID) when
>     the task has PF_EXITING set in __send_signal_locked() and in
>     posixtimer_send_sigqueue().
> 
>   - Protecting the unlocked setting of PF_EXITING in exit_signals() for the
>     task group empty and the group exit case with sighand lock
> 
>   - Flushing task::pending signals right there.
> 
>     Optimize that by moving the whole pending list to an on-stack list head
>     under sighand lock and free the signals without the lock held.
> 
> There has been quite some discussion about the lockless flush and the
> non-leader exec case on weakly ordered systems. The problem is that a third
> party which tries to send a posix timer signal relies on the PID lookup to
> find the target task and that lookup might result in the new leader when
> the signal was originaly directed to the old leader. In case that the
> signal was queued on the old leader then the lockless flush raised a
> concern over the following situation:
> 
>    old_leader		new_leader              third party
> 
> A: flush_list()	// list_del_init() stores to sigqueue
> 
>    LOCK (tasklist)
>    old_leader->exit_state = EXIT_ZOMBIE;
> B: UNLOCK (tasklist)
> 
> C:			LOCK (tasklist)
> 			if (old_leader->exit_state)
> 			   transfer_tids()
> D:			     store PID
> 						posix_timer_send_sigqueue()
> 						// Observes #D so t = new_leader
> E:						t = get_target()
> 
> F:						LOCK (sighand)
> 
> G:						   if (list_empty(sigqueue))
> 							list_add(sigqueue)
> 
> The concern was that the third party might observe #D but not observe #A
> and therefore would proceed to #G while the list_del() stores (#A) in
> flush_list() are not visible yet, which could result in list corruption.
> 
> That would be possible if looking at it solely from a RELEASE+ACQUIRE
> ordering point of view, but B-C is a UNLOCK+LOCK hand-over, which is not
> the same as RELEASE+ACQUIRE:
> 
>   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
>   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering
> 
> As B-C is UNLOCK+LOCK, which is RCtso and that does impose store order,
> A stores must happen before the D store.
> 
> Combine with E-F, which has a data dependency from the LOAD to the LOCK and
> thereby constraints later LOADs, those sigqueue loads in G that come after
> F must in fact observe the A stores.
> 
> Fixes: fb3bbcfe344e ("exit: change the release_task() paths to call flush_sigqueue() lockless")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Debugged-by: Hyunwoo Kim <imv4bel@gmail.com>
> Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Cc: stable@vger.kernel.org
> Closes: https://patch.msgid.link/aok1rdkBgZsynHZB@v4bel

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
