Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559C23E33D
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033227; cv=none; b=LdpmADZYDK18ibtsSc8dvhJ2KB6nQf7eAIBtxwNf0O+3n30JfgVkMhXvOyJH0ayXom3JAz+YafRcImHpeFh6e26Nb0tGmqujYyZuH4al/4vTUAqd17kqfhXrWsUMd5AazI68AbNH/qKlFi65VH1rYkOYqQDP/ANZqDrwtBkicuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033227; c=relaxed/simple;
	bh=bE8eJPHqsQhJdFYwCSLsy5MbwDZz+q5zUxIouJ1FGSQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WO+XTe+O3nbqcsxaZhVISs5kexZzsEHed/C+vIzZo3QpzVkZ7d5iEZAt82Ls0+VelheHymURLNrr3G4QP3Dfdw010umGboVd1u+v/a3R8JQOxp/HZQ9DQUDjbblLfgiEAD+/rLLLQRFpEqgi4gqHWG+h9E0PFQko+XYhyYZp6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1J3+PtRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1J3+PtRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00901F0089B;
	Sat,  3 Oct 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033225;
	bh=FsJfnCsmjzxiJcyK32wbJIyyl9N2ziLyCE3zhjFqzKU=;
	h=Subject:To:Cc:From:Date;
	b=1J3+PtRAXInOVaQ//OFhogkzkAyoid+TjOJ0337Rm1vxXW+EiSHcIL9b0VQaHt+2w
	 PR2LZvWT0l5F+p+C2tUMtacNQw4ciK8LpqwsOt31dNYULpzLogx4zEUo5Ai6O2sxUY
	 ri4uq7HMdb5MA0cBUZTB3YzBEh7NvS2nOXTLgWtA=
Subject: FAILED: patch "[PATCH] fprobe: Use guard(rcu_sched_notrace) and check" failed to apply to 6.18-stable tree
To: mhiramat@kernel.org,paulmck@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:13:41 +0200
Message-ID: <2026100341-letter-overstate-ddf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e0a6249190402a28f1e2925a81acf573157d55ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100341-letter-overstate-ddf7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0a6249190402a28f1e2925a81acf573157d55ef Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 29 Sep 2026 09:19:12 +0900
Subject: [PATCH] fprobe: Use guard(rcu_sched_notrace) and check
 rcu_is_watching()

unregister_fprobe() and unregister_fprobe_async() (used by BPF
kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
and call_rcu()) to wait until in-flight fprobe handlers complete before
freeing the fprobe.

However, if an fprobe handler executes while RCU is not watching (such
as in the idle loop or nohz_full extended quiescent states), standard
RCU does not track preemption-disabled sections. Consequently,
synchronize_rcu() does not wait for those executions, which can lead
to a use-after-free if the fprobe is freed immediately after
unregistration. Ensure handlers exit early when !rcu_is_watching().

Furthermore, fprobe_fgraph_entry() and fprobe_ftrace_entry() previously
used guard(rcu)() and rcu_read_lock(), which invoke lockdep on every
hit under CONFIG_PROVE_LOCKING. This adds overhead and can cause lockdep
recursion if probed functions interact with lockdep.

Since rhltable_lookup() and rhl_for_each_entry_rcu() use
rcu_dereference_all_check() (which checks rcu_read_lock_any_held()),
holding preemption disabled via rcu_read_lock_sched_notrace() is fully
valid and sufficient so long as rcu_is_watching() is true.

Define and use guard(rcu_sched_notrace)() across fprobe_ftrace_entry(),
fprobe_fgraph_entry(), and fprobe_return(). This eliminates fast-path
rcu_read_lock() and lockdep overhead while guaranteeing safe grace
period synchronization.

Link: https://lore.kernel.org/all/179064115227.394389.16910234241400391996.stgit@devnote2/

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace period")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9f2d98181779..da286619c5d8 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -47,6 +47,10 @@ static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
 static struct fgraph_ops fprobe_graph_ops;
 
+DEFINE_LOCK_GUARD_0(rcu_sched_notrace,
+		    rcu_read_lock_sched_notrace(),
+		    rcu_read_unlock_sched_notrace())
+
 static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
 	return hash_ptr(*(unsigned long **)data, 32);
@@ -329,16 +333,14 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct fprobe *fp;
 	int bit;
 
+	if (!rcu_is_watching())
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
 
-	/*
-	 * ftrace_test_recursion_trylock() disables preemption, but
-	 * rhltable_lookup() checks whether rcu_read_lcok is held.
-	 * So we take rcu_read_lock() here.
-	 */
-	rcu_read_lock();
+	guard(rcu_sched_notrace)();
 	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
 
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
@@ -353,7 +355,6 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 		else
 			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
 	}
-	rcu_read_unlock();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_ftrace_entry);
@@ -567,10 +568,13 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 	struct fprobe *fp;
 	int used, ret;
 
+	if (!rcu_is_watching())
+		return 0;
+
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
-	guard(rcu)();
+	guard(rcu_sched_notrace)();
 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
@@ -665,13 +669,16 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	int size, curr;
 	int size_words;
 
+	if (!rcu_is_watching())
+		return;
+
 	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
 	if (WARN_ON_ONCE(!fgraph_data))
 		return;
 	size_words = SIZE_IN_LONG(size);
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
-	preempt_disable_notrace();
+	guard(rcu_sched_notrace)();
 
 	curr = 0;
 	while (size_words > curr) {
@@ -687,7 +694,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		}
 		curr += size;
 	}
-	preempt_enable_notrace();
 }
 NOKPROBE_SYMBOL(fprobe_return);
 

