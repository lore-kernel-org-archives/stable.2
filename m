Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B04DE72D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591664; cv=none; b=AxuF3KDsnOEbhadKtV5zzrNV0wgIT0Al8aDPf2G9ZqpB8u9AmW76/iju18pb8D0L7OK1CjjNdnP7SUTvfQ4/wigsT8fxMGmocxMNtpKw2ihO6eVBcB56nGhX3ZYWbducEq4WMvsjSw5oFonRnC7GMUzhs6mKS09k1DjVZXLFo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591664; c=relaxed/simple;
	bh=FodffRXVtg5nVz3HLl/k9sFDgoYHNmOkZ6qs67x42k4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fLmSRixGeFZvDDZwNcb323Mi7yF6PcGbrpgv0PYJNuczjnvnLuhug2PQ4lgYDkY1ITij37uhmGkU3X97BWDCgIomu2Wi6WS8FwnTvZjRMz5WO31UdyfZDO8KtAsI8vzBrDk+ZnmTxXHIihpe0Q+aAR/fcJs4QG3TEaz7EyOWf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bx47N+Li; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rWZRVVWM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bx47N+Li";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rWZRVVWM"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789591648; bh=klWOPIADV94M3xOIMgNawsU
	37HZBjQTc1PtDioE6GuQ=; b=bx47N+LiztZnuLp0jc2svCKHx7sGtLWE2I43YinO205+IDCEzu
	plQVWN5ZxVwtvK6sdHIlOaJHbtmkaKPvykF4lAsEwp3KT8xNJobiDf/YD8WDf47TghTxwbK9Ti9
	6IjNXc9FD8GsaLtVvUZ2+SKVvt9Hz8ef1v/57WK9fYy1mWGf+ILWt2REfE1+jDaDFWdHvfDTSwH
	IQU9beUsoDShRnKm/SKc2EQF8CxbjxsQae8UDePy0hI0Jb5Z/BujoNQjUWslCYmpifOVWnWAG50
	cNwKD+q31ihIJFXR+PxyF81bh5sPoA4SjZgZ0C+z26yJFeuruoNA/ArOcuYGPVROeAQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789591648; bh=klWOPIADV94M3xOIMgNawsU
	37HZBjQTc1PtDioE6GuQ=; b=rWZRVVWMOBXOeEyJxGOzh38HykxNcAiUiZgEvzyhHT/JawwHFP
	OOuHAp/VilvhGh0GrQB098eeQgcCsxL5AiDw==;
Date: Wed, 16 Sep 2026 21:47:29 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
CC: Daehyeon Ko <4ncienth@gmail.com>,
 syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
 syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com,
 Oleg Nesterov <oleg@redhat.com>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6=2E18=2Ey_3/3=5D_exit=3A_hold_a_refe?=
 =?US-ASCII?Q?rence_to_thread=5Fpid_across_proc=5Fflush=5Fpid?=
In-Reply-To: <20260916203656.2689289-3-sashal@kernel.org>
References: <2026091657-curry-myself-be92@gregkh> <20260916203656.2689289-1-sashal@kernel.org> <20260916203656.2689289-3-sashal@kernel.org>
Message-ID: <E01AAD86-816E-4B90-9D5D-E4281573ACBA@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 21:36:56 BST, Sasha Levin <sashal@kernel.org> wrote:
>From: Daehyeon Ko <4ncienth@gmail.com>
>
>[ Upstream commit cdd812d0683dee14ead02c9eded568685e61b23f ]
>
>Commit 0a36bad01731 ("release_task: kill the no longer needed
>get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
>It assumed that free_pids(post.pids) at the end of release_task() would
>keep thread_pid alive until then.
>
>That assumption is wrong.  __change_pid() only records a detached PID in
>post.pids when pid_has_task() is false for every PIDTYPE.  If another task
>still uses the exiting task's PID as its process group or session ID,
>__unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
>the PID out of post.pids.  release_task() therefore holds no reference to
>it after dropping tasklist_lock.
>
>The other task can then remove the remaining PIDTYPE links.  Its
>free_pids() call schedules delayed_put_pid(), and the RCU callback can
>free
>the PID before the first release_task() reaches proc_flush_pid().
>
>An unprivileged reproducer races wait4(-1) against setsid() to trigger
>this
>ordering.  Three of three fresh v7.2 KASAN boots reported:
>
>    BUG: KASAN: slab-use-after-free in
>    proc_invalidate_siblings_dcache+0x3e2/0x3f0
>    Read of size 8 by task h7_pid_reaper/1921
>
>    Call Trace:
>     proc_invalidate_siblings_dcache
>     release_task
>     wait_consider_task
>     __do_wait
>     do_wait
>     kernel_wait4
>
>    Freed by task 0:
>     kmem_cache_free
>     put_pid
>     delayed_put_pid
>     rcu_core
>
>    Last potentially related work creation:
>     __call_rcu_common
>     free_pids
>     ksys_setsid
>
>KASAN identified a 144-byte object from the pid cache and located the bad
>read 80 bytes into the freed object, matching pid->inodes.  With an
>explicit reference, three of three fresh boots completed without a KASAN
>report.  The concurrent RCU callback dropped its reference while
>proc_flush_pid() was protected, and the balancing put_pid() performed the
>final free afterward.
>
>Take a reference before __unhash_process() clears p->thread_pid and
>release
>it after proc_flush_pid() completes.
>
>A tested source reproducer is available privately on request.  No
>controlled read or write, information leak, or privilege escalation is
>claimed.  The mainline patch applies directly to v6.19.y and newer;
>v6.16.y through v6.18.y need a context-adjusted backport.
>
>Fixes: 0a36bad01731 ("release_task: kill the no longer needed get/put_pid(thread_pid)")
>Reported-by: syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=0aee5e8066eddbbe7397
>Reported-by: syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
>Link: https://syzkaller.appspot.com/bug?extid=e8b3520b53e78e90034e
>Cc: stable@vger.kernel.org # see patch description, needs adjustments for 6.16.y-6.18.y
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>Link: https://patch.msgid.link/20260831001221.3755948-1-4ncienth@gmail.com
>Acked-by: Oleg Nesterov <oleg@redhat.com>
>Reviewed-by: Bradley Morgan <brads@mainlining.org>
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>[ Adjusted context for cgroup_release() and the missing
>exit_cred_namespaces() call. ]

Do you manually do all these? Or use a AI program to do these.

If you use a AI program to do automated backporting, please add something
like:

[LLM: Thing it's done to fix the conflict]

If you do all these manually then Im shocked (also thank you)


>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> kernel/exit.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/exit.c b/kernel/exit.c
>index b22ede84c0ec9..d60c1241923a9 100644
>--- a/kernel/exit.c
>+++ b/kernel/exit.c
>@@ -264,8 +264,11 @@ void release_task(struct task_struct *p)
> 	pidfs_exit(p);
> 	cgroup_release(p);
> 
>-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
>-	thread_pid = task_pid(p);
>+	/*
>+	 * Pin @thread_pid before __unhash_process() clears it. The last
>+	 * PIDTYPE detach can otherwise free it before proc_flush_pid().
>+	 */
>+	thread_pid = get_pid(task_pid(p));
> 
> 	write_lock_irq(&tasklist_lock);
> 	ptrace_release_task(p);
>@@ -294,8 +297,8 @@ void release_task(struct task_struct *p)
> 	}
> 
> 	write_unlock_irq(&tasklist_lock);
>-	/* @thread_pid can't go away until free_pids() below */
> 	proc_flush_pid(thread_pid);
>+	put_pid(thread_pid);
> 	add_device_randomness(&p->se.sum_exec_runtime,
> 			      sizeof(p->se.sum_exec_runtime));
> 	free_pids(post.pids);
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
