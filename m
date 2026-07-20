Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75552D9EFB
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560544; cv=none; b=ibs081s3dLV+k0TUZYsqRWxVeibEsRBg+b+vzQbOTgV72gYrOZshvMlHbXpAuo7BZ+D+YXgWrRepXUIOZi6bg6bf93vwCSY16pM3ho158JznTqCFoStxyBZwBElFti5J7Jh2poxZbvKL1nUoNnooSd5EIH4VzERPZ7HXXmbXEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560544; c=relaxed/simple;
	bh=w01zaOquNxJda7fZwRLd1DD3wicf2UriN+gPXjyqF/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sjvoRLoKt/4npOGBel5AvZpbvSXniLN4S2RCWDpKkeI4PH1+AXV7VQzAR21Xrs63j7vBbJvxR/ptD66GnR0I1IYJhtd2p1H4km+BXE0gnfpI23/DZQZLTPJ776gpe8+eUtw7CcUzeJwBh6AyWG9Ce8sRJJjLJH4SFkjtRW0YR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1RhfSmEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RhfSmEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DDE1F000E9;
	Mon, 20 Jul 2026 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560543;
	bh=+jpyNezZDIYtXsHDoVM2Q8fBVHF9OjfdmicZcE7ZTJE=;
	h=Subject:To:Cc:From:Date;
	b=1RhfSmEB9P3ZDoeNUf4O+6WAdQ8/oJQAoB50NeJPA8verG4qayjaIelIS1UgN/360
	 OCGYFMiNEXJ4pqeqadOAUia1rQQRCb7bkGn3mCrZ8Eedpha4n7dsjhSy0rILIakVUe
	 4qE+kczVMO1nA+08SYg+W8dCM5iqTuOt6p4blLg8=
Subject: FAILED: patch "[PATCH] bpf,fork: wipe ->bpf_storage before bailouts that access it" failed to apply to 5.15-stable tree
To: jannh@google.com,andrii@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:15:29 +0200
Message-ID: <2026072029-trend-escalator-b641@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b51a6155d14389876916726430da30eabb1d4ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072029-trend-escalator-b641@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b51a6155d14389876916726430da30eabb1d4ed Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Jun 2026 17:52:52 +0200
Subject: [PATCH] bpf,fork: wipe ->bpf_storage before bailouts that access it

Currently, copy_process() can bail out to free_task() before p->bpf_storage
has been initialized, with this call graph (shown here for the
!CONFIG_MEMCG case):

copy_process
  dup_task_struct
    arch_dup_task_struct
      [copies the entire task_struct, including ->bpf_storage member]
  [RLIMIT_NPROC check fails]
  delayed_free_task
    free_task
      bpf_task_storage_free
        rcu_dereference(task->bpf_storage)
        bpf_local_storage_destroy

In this case, the nascent task's ->bpf_storage member that
bpf_local_storage_destroy() operates on is a plain copy of the parent's
->bpf_storage pointer, not a real initialized pointer.
This leads to badness (kernel hangs, UAF).

This is reachable as long as the process calling fork() has been inserted
into a task storage map.

Cc: stable@kernel.org
Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/fork.c b/kernel/fork.c
index 13e38e89a1f3..f0e2e131a9a5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1009,6 +1009,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->mm_cid.active = 0;
 	INIT_HLIST_NODE(&tsk->mm_cid.node);
 #endif
+
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
+	tsk->bpf_ctx = NULL;
+#endif
 	return tsk;
 
 free_stack:
@@ -2247,10 +2252,6 @@ __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
-#ifdef CONFIG_BPF_SYSCALL
-	RCU_INIT_POINTER(p->bpf_storage, NULL);
-	p->bpf_ctx = NULL;
-#endif
 
 	unwind_task_init(p);
 

