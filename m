Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726602;
	b=NKjHrl012c3Hxd8FqFKRgh8fV8xG1RvJpbijQWPzHOchK8+3/dgnyLzRu+VslqaYMb3G
	 Km2n845XT4jf6KxBRH4LSw1wGNiWwdlWAFOe8eNNV5DD5Ss5l1uc5pd2jIBJn8H7ImaPY
	 AgWw9P1Q0bVpK4TyWSKfTblH+uzMw0BgsZwDoSOHVLf/RZGgPIFHA59qb0/rfNOCRTIsV
	 JkHVRCR8ToNFc1mX/m5J4rqVe8EbKE/dF+E/RrGsMLpUinUqys1H3/J8ZkiCnHC4AWLhD
	 CSHB2fx3uedjHFEV3lmdDz5smyJZi1cEEARQzpJBKUqghWbiwDOp9/dNv2HWAWXBt2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726602;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AuKn591EgQ1tWMd/4PZVEoVe72lj8WLpCUaituRFd7s=;
	b=U5li2IJlL/WHxCqDoYqior9rTGfGsn+5woO0AMqyP3i8QdbNRbWfjkG96gfMUe8RTF+J
	 oAZgbVBSQmubPC8ZiqlWQVd8J56yFjr5hMV3270dmQ4RRmYN7Et805lKxWYxQippK1yjn
	 lJRsWt6XNZ64y82BiPObxCcxBgNk6MiUpQIgsHVOcX3TNg+Snepx1vEVWacV6N+wgqzx3
	 CD3/ukw9rqZXVwb/P+eOuaJ3ESj7sqsFNEtts0nlLG85l7HUS0szxXFj8d6xM6dPmg/E0
	 XvFNaoyO1L0Z1BsiojXNTHgO4qQqF8sKO4Fk2UPZmhP6XpK+oKNyxTGOIsNFKlVaiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDx48RjO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9EF606A31E;
	Thu, 26 Nov 2026 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDx48RjO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A31F00896;
	Thu, 26 Nov 2026 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726602;
	bh=AuKn591EgQ1tWMd/4PZVEoVe72lj8WLpCUaituRFd7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nDx48RjOcbil4/XGdGMnGgwz/+FbKRZTbeNPMSI8urs/Yqw0RVXKLqanm3LNDFDKR
	 3Ss89g/ORVxslTBdCk3G1hlXzu5viwU1L/kt1snNVpv6PiWbs49+kprDDhSJmoGz6d
	 aDyW/JZnJ2ojldM4pVdWTrQm/g+iODPMuyCJZwLDU2kpfpmIZRFE/Uoj5lVMhfmDM/
	 qP47H6ht0E9hYQj38iojbJkkQal4mUKjTq/mW39kGqSyUdCMsPa3Qv9gRQpofxa/KY
	 o5Om/RHBA2wQ+UJeJtOmruZ8GFrHGywlfswOw2qGRDfcX7Vd83kfis68B3uqg0MKvf
	 Z13NJRpVSfBeA==
Date: Thu, 26 Nov 2026 21:56:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261126152414.GH49833@noisy.programming.kicks-ass.net>

On Thu, Nov 26, 2026 at 04:24:14PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 26, 2026 at 12:45:37PM +0100, Christian Brauner wrote:
> > PERF_EVENT_IOC_SET_FILTER parses the address filters with the mutex of
> > the event's context held. A filter can name a file and the parser looks
> > that file up with kern_path(). So the mutex is held for as long as the
> > lookup takes and on a FUSE filesystem it's the caller who decides how
> > long that is.
> > 
> > Since commit 2e498d0a74e5 ("perf: Add support for event removal on
> > exec") perf_event_exec() takes that mutex with exec_update_lock held
> > whenever the task has a perf context. So an exec of the task the event
> > counts for hangs past the point of no return until the lookup is done
> > and can't be killed. And everyone who needs the exec_update_lock of the
> > task waits with it.
> 
> Nah, we do this per commit:
> 
> 79c9ce57eb2d ("perf/core: Fix perf_event_open() vs. execve() race").
> 6914303824bb ("perf: Use new infrastructure to fix deadlocks in execve")
> f7cfd871ae0c ("exec: Transform exec_update_mutex into a rw_semaphore")
> 
> > It gets worse. Since commit 6255da28d4bb ("proc: protect
> > ptrace_may_access() with exec_update_lock (FD links)") looking up
> > /proc/<pid>/exe takes the exec_update_lock of the task. So with such a
> > file in a filter the ioctl takes the two locks the other way round:
> > 
> >   WARNING: possible circular locking dependency detected
> >   ------------------------------------------------------
> >   perf-addr-filte/113 is trying to acquire lock:
> >   (&sig->exec_update_lock){++++}-{4:4}, at: call_proc_get_link+0x4f/0x110
> > 
> >   but task is already holding lock:
> >   (&ctx->mutex){+.+.}-{4:4}, at: perf_event_ctx_lock_nested+0xb2/0x200
> > 
> >          CPU0                    CPU1
> >          ----                    ----
> >     lock(&ctx->mutex);
> >                                  lock(&sig->exec_update_lock);
> >                                  lock(&ctx->mutex);
> >     rlock(&sig->exec_update_lock);
> > 
> > and an exec of the task deadlocks with it:
> > 
> >   task:exec-task       state:D pid:114
> >   Call Trace:
> >    __schedule+0x53e/0x13f0
> >    schedule+0x36/0x100
> >    schedule_preempt_disabled+0x11/0x20
> >    __mutex_lock+0x7bf/0x11f0
> >    perf_event_exec+0xb9/0x640
> >    begin_new_exec+0x622/0xf90
> >    load_elf_binary+0x12a/0x1990
> >    bprm_execve+0x39d/0x870
> >    do_execveat_common.isra.0+0x165/0x180
> >    __x64_sys_execve+0x38/0x50
> >    do_syscall_64+0x110/0x600
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> >   task:paf-setter      state:D pid:116
> >   Call Trace:
> >    __schedule+0x53e/0x13f0
> >    schedule+0x36/0x100
> >    schedule_preempt_disabled+0x11/0x20
> >    rwsem_down_read_slowpath+0x186/0x5f0
> >    down_read_killable+0x78/0x1b0
> >    call_proc_get_link+0x4f/0x110
> >    proc_pid_get_link+0x3c/0x70
> >    pick_link+0x52b/0x640
> >    step_into_slowpath+0x16a/0x3a0
> >    path_lookupat+0x169/0x2e0
> >    filename_lookup+0x124/0x230
> >    kern_path+0x2c/0x50
> >    _perf_ioctl+0xbd9/0xea0
> >    perf_ioctl+0x50/0x90
> >    __x64_sys_ioctl+0xb4/0x100
> >    do_syscall_64+0x110/0x600
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > The parser doesn't need the mutex. So drop it while the filters are
> > parsed like perf_event_set_filter() already does for the filter of a
> > tracepoint. The pmu may be unregistered in the meantime so check again
> > whether the event has been revoked once the mutex is back.
> > 
> > The parser bumped the event's count of file based filters as it went
> > along and looked at event->ctx->task. Count in a local, store that when
> > the new filters are installed and test PERF_ATTACH_TASK instead.
> > 
> > This also makes the count exact. It was only ever reset when a set of
> > filters was refused. So once an event had a file based filter every
> > later set took the mmap lock of the task and for a task without an mm
> > the new ranges were never written.
> > 
> > Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> > Fixes: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> 
> Somewhat hard to read; and I'm not sure I follow. You're saying:
> 
>   ioctl(PERF_EVENT_IOC_SET_FILTER)
>     perf_ioctl()
>       perf_event_ctx_lock()		// perf_event_context::mutex
>       _perf_ioctl()
>         perf_event_set_filter()
> 	  perf_event_set_addr_filter()
> 	    perf_event_parse_addr_filter()
> 	      kern_path()
> 	        ...
> 		  call_proc_get_link()
> 		    down_read_killable(&exec_update_lock)

Yes.

> This violates established locking order; which is correct.
> 
> (Why can we add proc files to the filter?)

I think we can. But it feels a bit annoying because this such lock
inversions involving exec_update_lock and perf isn't the first time.
So I tried to get this inversion out of the way.
