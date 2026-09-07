Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE219B5A3;
	Mon,  7 Sep 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819190; cv=none; b=VryHbi4E8M1VWHbD67itq5rudt5HPiddi/FJl4Ubv9kQuxEewuEa/zz6AmuV+SfugoIiGECxq6EGVJ7POtdVsj2jYmrLHF7zVsi7XoSqHbsPhNBnjpDf+bBZJ6IpWL209RJVV1b7a54mcl8q4nBWlNNUii8xtHrtWq9ROwx6OWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819190; c=relaxed/simple;
	bh=nLLoq5LKUlUMUnKPmzTqh2Cu1MstubRzvP1g2edCRU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrUKqjmvQYGIvOsUbWqNd0sTdIe7xm80ZTMYF7Sl01b2dWYv9RQ+FoSWXoIp8ZyTdOlFZItgF9m61dFuQTA8z4D1tXom7yKIkDSCr322nI4TOIqnAaCi7ZmVmjPVVoEjVp1UuTXuwPmRz54Ds/y1QlFr2++7W3FmnNYRp6b1LZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRhAfxUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRhAfxUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EFE1F00A3A;
	Mon,  7 Sep 2026 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788819188;
	bh=EYtJSyuXSYrOvvQxntJIRl+6xaeQMAx7tDBik21yYOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRhAfxUxHfMU3UhaemNnMGxMs34NRzV5n/NjVmTw5e/Le25jsYWMtN1zTizA1H/gi
	 v6ifM3NEfXu37NvOpJ46dXnzrQxpePDV9LyzQU9RfEyM698iHPil1W4vRfFhpEBSya
	 RrNjP/Rzd5WO1289cd1lCU3U1LP7gTvvXbppU0SmYKCJQVNV8tuvhISphHICB/Z5Th
	 +xXEdPlnlHcBY0E7SY/t/gLlDue95ZxWi1EijWY45B3yZLrdzgyJz0emVHWzSPYvo8
	 0skkOfW1uKdA1JL7VjEO5/0ly/NHZapTKUnbSI+okTSU1bfucYjFair+LzKYQEZiC2
	 cuQgP31TYsemQ==
Date: Tue, 8 Sep 2026 00:13:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 2/8] exec: Cleanup POSIX timers right after de_thread()
Message-ID: <ap828QiQiWbxxbBq@pavilion.home>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.716693014@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905185839.716693014@kernel.org>

Le Sat, Sep 05, 2026 at 08:59:06PM +0200, Thomas Gleixner a écrit :
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> A per-thread CPU timer holds a reference to the PID of the thread it is
> attached to and, while it is armed, its node is queued in that thread's
> posix_cputimers. The task is looked up by that PID.
> 
> When a non-leader thread exec()s, de_thread() changes which task owns
> that PID. pid_task(timer->it.cpu.pid, PIDTYPE_PID) then returns NULL,
> but the node is still queued on tsk, which is alive. timer_lock_sighand()
> takes a failed lookup to mean that the node is already dequeued, so it
> has nothing to undo.
> 
> begin_new_exec() calls posix_cpu_timers_exit(me) right after
> exec_task_namespaces() and that removes the leftover node, so the state
> normally stays invisible. But bprm->point_of_no_return is set before
> de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
> exec_task_namespaces() fails, the task dies before it gets there.
> exit_itimers() then frees the k_itimer while its node is still queued,
> and reaping tsk later erases that freed node from the rbtree.
> 
> In short:
> 
>       the non-leader thread B           the parent
> 
>   timer_create(CLOCK_THREAD_CPUTIME_ID)
>   timer_settime()
>     arm_timer()            // the node is queued on B
>   execve()
>     de_thread(B)
>       exchange_tids(B, leader)  // B's PID now belongs to the leader
>       release_task(leader)
>         __exit_signal(leader)
>           posix_cpu_timers_exit(leader)  // cleans leader's queue, not B's
>           __unhash_process(leader)  // that PID has no task anymore
>     exec_mmap()
>       mmap_read_lock_killable(old_mm)
>                                 kill(B, SIGKILL)
>       // -EINTR
>   get_signal()
>     do_exit()
>       exit_itimers()
>         posix_timer_delete()
>           posix_cpu_timer_del()
>         posix_timer_unhash_and_free()  // freed while still queued
>                                 wait4()
>                                   release_task(B)
>                                     posix_cpu_timers_exit(B)
>                                       cleanup_timerqueue()
>                                         timerqueue_del()  // use-after-free
> 
> Move the POSIX timer cleanup right after de_thread() before any of the
> later failure conditions brings the task into do_exit().
> 
> [ tglx: Move the cleanup right after de_thread() ]
> 
> Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/ao7Q8miiuLAPVnWv@v4bel

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
