Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99F4A2A41;
	Thu, 24 Sep 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264655; cv=none; b=M6cRkPvWB4x0JRl30FXh9KlmIKm/YvHwS9HThWMwxYaqcAPG1na1oFQV4rrIrX2xL8n9OSvxprDBiyvxqTdODiLFrBjtt7LxzLw1oAcKuxXZxoSs0sFYuEaCAH9yAcDAzw/ewnUxtUDCqX1i5cLJrKn4A+HYeMBFVQB+iSD8yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264655; c=relaxed/simple;
	bh=6+PpXr9we17NiHs9bfur1AcFceo7Prw6yWY+x/mBO1s=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=oalDxchJ7y5DUqIa6/Ewc43Ek0U9NLrPIEH8X4hP/miNhihNk/uVrTKd9UXRAR/TjiSWKmZBicof+VRPdKNRC3kmTC4yeCiGTYLjn+CBbkuwAVptFk8Ql+MaA2Juxm4OWO99WZpdvpFuw6RN0/fIIa7iL2xb6GGidOIVuSAQoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=TLnU+Qhs; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=vq7Hpc2U; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="TLnU+Qhs";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="vq7Hpc2U"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790264650; bh=i2iaEK+NM6sskxsNF3Qx6tK
	fZhZ0WROgaR2aVfzDl2E=; b=TLnU+QhsFfP2m1PRm/z9eS5x8rViKPLMRHiobywvA6to/oHsy8
	JvrVzrWbY6+FRfowiludcCzemr8oWdacmwTf5kg8ixk3o8XeZYP2KvPHlhaDp4iing0OS5XVieh
	YSLTYMB5LQXJwoH9BBaV1nehBlKFaHWkpvwA51JJs7VkYc8KLwq5kU8bywE0GbflG0QT1tU1uc/
	2O+AOIWAd1QoHyMNWsQFVJGqUwvz/Bf72/S2N8BOfXpL51s9gAHZhXtXL7I0n78BwhgUzezZrTH
	nL9gnMlsj9FtjEFv+c8Adlny3uFxZyNdG6d23mUKoPhUtiqDLJIjQRCcuJ08dyQXx8w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790264650; bh=i2iaEK+NM6sskxsNF3Qx6tK
	fZhZ0WROgaR2aVfzDl2E=; b=vq7Hpc2UbOhktvTPwoiLvwTmIUiMuk/lFcXbpPOxdBtJesn+lS
	ik+qivB/AfCVFRYdrghhf/2PTOnz8wnHbuAQ==;
Date: Thu, 24 Sep 2026 16:44:12 +0100
From: Bradley Morgan <brads@mainlining.org>
To: parri.andrea@gmail.com
CC: davem@davemloft.net, josef@toxicpanda.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, naveen@kernel.org,
 rostedt@goodmis.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kprobes=3A_Fix_permanent_ha?=
 =?US-ASCII?Q?ng_when_flushing_the_kprobe_optimizer?=
In-Reply-To: <20260924092142.199198-1-parri.andrea@gmail.com>
Message-ID: <B46E3026-C65B-4D01-9A6C-7DACB6D6552A@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 September 2026 10:21:39 BST, Andrea Parri <parri.andrea@gmail.com>
wrote:
>Writing 0 to /proc/sys/debug/kprobes-optimization while a kprobe is
>jump-optimized never returns. The writer sleeps in D state forever with
>kprobe_sysctl_mutex held, so any later read or write of that sysctl
>hangs as well. For example, with vfs_read+9 as an optimizable address
>in this build:
>
>  # cd /sys/kernel/tracing
>  # echo 'p:myprobe vfs_read+9' >> kprobe_events
>  # echo 1 > events/kprobes/myprobe/enable
>  # # wait until /sys/kernel/debug/kprobes/list shows [OPTIMIZED]
>  # echo 0 > /proc/sys/debug/kprobes-optimization

Couldn't reproduce this on PowerPC, because PowerPC won't work for this
bug unfortunately...

But this is a real bug in some cases:


Reviewed-by: Bradley Morgan <brads@mainlining.org>


>
>  INFO: task sh:246 blocked for more than 10 seconds.
>  Call Trace:
>   <TASK>
>   __schedule+0x1176/0x4f70
>   schedule+0xdc/0x2c0
>   schedule_timeout+0x17b/0x260
>   wait_for_completion+0x173/0x3c0
>   wait_for_kprobe_optimizer_locked+0xbc/0x130
>   proc_kprobes_optimization_handler+0x156/0x1b0
>   proc_sys_call_handler+0x324/0x490
>   vfs_write+0x52d/0xfe0
>   ksys_write+0xff/0x200
>   do_syscall_64+0x106/0x630
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
>  ...
>  INFO: task cat:265 is blocked on a mutex likely owned by task sh:246.
>
>wait_for_kprobe_optimizer_locked() reinitializes optimizer_completion,
>asks the optimizer thread to flush and sleeps in wait_for_completion().
>The thread drains the (un)optimizing lists, but calls complete() only
>if completion_done() is true, i.e. if the completion is already done,
>which never happens while someone waits. disarm_all_kprobes() and
>kprobe_trace_self_tests_init() wait the same way.
>
>Calling complete() unconditionally would not be enough: the waiter
>drops kprobe_mutex while it sleeps, and nothing else serializes the
>sysctl handler against the debugfs "enabled" file. A second flusher
>that still finds the lists non-empty, e.g. because a disabled probe is
>queued for unoptimizing, reinitializes the completion under the first:
>
>  sysctl write                      debugfs "enabled" write
>  unoptimize_all_kprobes()
>    wait_for_kprobe_optimizer_locked()
>      init_completion(c)
>      mutex_unlock(&kprobe_mutex)
>      wait_for_completion(c)
>                                    disarm_all_kprobes()
>                                      wait_for_kprobe_optimizer_locked()
>                                        init_completion(c)
>                                          // c->wait is reset, the first
>                                          // waiter is off the queue
>                                        mutex_unlock(&kprobe_mutex)
>                                        wait_for_completion(c)
>  kprobe_optimizer()
>    complete(c)
>      // wakes the debugfs writer only
>
>where c is &optimizer_completion. Lining up the two writes during an
>optimizer pass loses the sysctl writer this way.
>
>Replace the completion with a counter of optimizer passes, bumped at the
>end of each pass and signalled with wake_up_var_locked(), both under
>kprobe_mutex. A flusher samples the count and waits with
>wait_var_event_mutex(), which drops kprobe_mutex only while sleeping, so
>a new count means a whole pass ran in the meantime. Nothing is
>reinitialized, so several flushers can sleep in the wait at once.
>
>Fixes: 73c12f209462 ("kprobes: Use dedicated kthread for kprobe optimizer")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
>This overlaps with two patches under discussion in the "rcu-tasks: build
>Tasks RCU on Tasks Trace readers in trampolines" thread:
>
> - Masami's RFC "kprobes: Make optprobe optimizer multi-generational and
>   asynchronous" [1] rewrites the same code.  It drops the
>   completion_done() check, which fixes the hang reported here, but it
>   keeps init_completion() in wait_for_kprobe_optimizer_locked(), so the
>   concurrent-flusher case described above remains.  The two patches
>   conflict textually.
>
> - Josef's "kprobes: Expose the optprobe jump window to Tasks RCU" [2]
>   changes kprobe_optimizer() around synchronize_rcu_tasks(); its
>   kernel/kprobes.c hunks still apply on top of this patch.
>
>[1]
>https://lore.kernel.org/all/179017148080.466588.9116221556625712980.stgit@devnote2/
>[2]
>https://lore.kernel.org/all/20260922-b4-rcu-tasks-preempt-qs-v5-3-410f57770bad@toxicpanda.com/
>
> kernel/kprobes.c | 22 ++++++++++++++--------
> 1 file changed, 14 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>index 6337da5cab9e7..4edd8ca5c6578 100644
>--- a/kernel/kprobes.c
>+++ b/kernel/kprobes.c
>@@ -42,6 +42,7 @@
> #include <linux/execmem.h>
> #include <linux/cleanup.h>
> #include <linux/wait.h>
>+#include <linux/wait_bit.h>
> 
> #include <asm/sections.h>
> #include <asm/cacheflush.h>
>@@ -526,7 +527,8 @@ enum {
> 	OPTIMIZER_ST_FLUSHING = 2,
> };
> 
>-static DECLARE_COMPLETION(optimizer_completion);
>+/* Bumped at the end of each kprobe_optimizer() pass, under 'kprobe_mutex' */
>+static unsigned long optimizer_passes;
> 
> #define OPTIMIZE_DELAY 5
> 
>@@ -654,9 +656,9 @@ static void kprobe_optimizer(void)
> 		do_free_cleaned_kprobes();
> 	}
> 
>-	/* Step 5: Kick optimizer again if needed. But if there is a flush requested, */
>-	if (completion_done(&optimizer_completion))
>-		complete(&optimizer_completion);
>+	/* Step 5: Wake up flushers, and kick optimizer again if needed. */
>+	optimizer_passes++;
>+	wake_up_var_locked(&optimizer_passes, &kprobe_mutex);
> 
> 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
> 		kick_kprobe_optimizer();	/*normal kick*/
>@@ -708,7 +710,8 @@ static void wait_for_kprobe_optimizer_locked(void)
> 	lockdep_assert_held(&kprobe_mutex);
> 
> 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
>-		init_completion(&optimizer_completion);
>+		unsigned long passes = optimizer_passes;
>+
> 		/*
> 		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
> 		 * idle. If it's already kicked, it will see the state change.
>@@ -717,9 +720,12 @@ static void wait_for_kprobe_optimizer_locked(void)
> 			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
> 			wake_up(&kprobe_optimizer_wait);
> 
>-		mutex_unlock(&kprobe_mutex);
>-		wait_for_completion(&optimizer_completion);
>-		mutex_lock(&kprobe_mutex);
>+		/*
>+		 * kprobe_optimizer() holds 'kprobe_mutex' for a whole pass, which
>+		 * this drops while sleeping, so a new count means a full pass ran.
>+		 */
>+		wait_var_event_mutex(&optimizer_passes,
>+				     optimizer_passes != passes, &kprobe_mutex);
> 	}
> }
> 
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
