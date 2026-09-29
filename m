Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1C515998
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682228; cv=none; b=mSAR4E0fzXqBvX8BvAcfq9QVgltwTxZsYCsnPihyDr8UaZfO6fliCJKpiChAWWR2Juj4ENU1VukF3dThwVpVnZo5aHXs3UIcLU1dxYv2tzOXYt4Ol7YlbK/dEybft7XRbLpRUG9+TVohz0KWYqXj5pFPL4O5NZwR8YcLnflUE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682228; c=relaxed/simple;
	bh=SPjyt9EsQanDwhd/aVwTPAeDaYT94PX4kQY3ZofbsYg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fVOhXLeWcb18+lkHt4dS/ee317UP0h+rD6whJDmPUklndQoYm/0x2yUmzK9MseheovdjzSdh+7qei3M2nf87M9yL575uOFCb3xSqirJoHdFkbv756Q/Zn+vaiYM+WhuDzzrbqHQdIzHQ+mXqqYI/HCi6Z1R2Y59bDZyZekPcYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yiHoxP1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yiHoxP1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92591F000FF;
	Tue, 29 Sep 2026 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682226;
	bh=nN0gor3N7j9OEAY7r/EtK+IlXFRpkoJrTRlOeVbeH4A=;
	h=Subject:To:Cc:From:Date;
	b=yiHoxP1GM8tLazGuccBH4QxUpaiBgSaL35KRCDwtlVsiNMngVrAkCetnxWGWsaESX
	 UxAZkdZfhQdvsZUc+ihmCupyDMHEAfAR2qV1dFgP8+Maz0ovtD58s0rZ4njM14Z3uB
	 0y7sDzq+6kN7uy4BZuvp3Lm/kfD0GSgCib+pFa6M=
Subject: FAILED: patch "[PATCH] sched/cache: Skip kernel threads for cache aware scheduling" failed to apply to 7.2-stable tree
To: yu.c.chen@intel.com,mingo@kernel.org,peterz@infradead.org,stable@kernel.org,tim.c.chen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:43:35 +0200
Message-ID: <2026092935-angelic-kick-1d0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 65efcccddc83d6a19e8a2e2a6117811e39e589bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092935-angelic-kick-1d0a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65efcccddc83d6a19e8a2e2a6117811e39e589bf Mon Sep 17 00:00:00 2001
From: Chen Yu <yu.c.chen@intel.com>
Date: Mon, 21 Sep 2026 17:37:26 -0700
Subject: [PATCH] sched/cache: Skip kernel threads for cache aware scheduling
 to rubustify the code

Kernel thread should not be covered by cache aware scheduling as
it borrows the statistics from the user space thread. Filter the
kernel thread in account_mm_sched().

In theory a kernel thread does not have any valid
cache group, so !grp should gate the kernel thread.
Add the PF_KTHREAD check explicitly here for safety
reasons, to guard against future modifications and
to pair with task_tick_cache().

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@kernel.org> # 7.2.x
Link: https://patch.msgid.link/058f0c6ea7b991c177a17de347fa3157f25489a7.1790035273.git.tim.c.chen@linux.intel.com

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 974a7dfe3215..57360f5cdde4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1907,8 +1907,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	/*
 	 * init_task, kthreads and user thread created
 	 * by user_mode_thread() don't have a cache group.
+	 * In theory a kernel thread does not have any valid
+	 * cache group, because sched_cache_fork() is not
+	 * invoked for a kernel thread - !grp should gate the
+	 * kernel thread. Use the PF_KTHREAD check explicitly
+	 * here for safety reasons, to guard against future
+	 * modifications and to pair with task_tick_cache().
 	 */
-	if (!grp || !grp->pcpu_sched)
+	if (p->flags & PF_KTHREAD || !grp || !grp->pcpu_sched)
 		return;
 
 	pcpu_sched = per_cpu_ptr(grp->pcpu_sched, cpu_of(rq));

