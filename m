Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39152940B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117750; cv=none; b=PKnf7CTWRbPNOma2hLMlc17vC8It8i6NBbMCmKBGmCtQJ/R3YXULqjs+weogKws0xgsCyN4LmodSiAmrpu9sdJmewEw8zHSjHfZqQj/7lQUHAFpyy4eXmObaXoyuzNn3l+K86WqnEQWbDAfKFXwvk2CIjO70FJUc+ssS2dVFHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117750; c=relaxed/simple;
	bh=Azhr/Ymn+QhvjiuQXJGj9VxIyXHjY5pCGMdkRbVMMcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJuA9SrcCsypndD4K3yiSch8VM2b76Zt6NCo2co19TWdiw9azFbyEtOaQvrSxGz1QR1W+FUFwUISwzgIG9/iTsNbyrJs17ePE69cwgpjDRMG0L+FGkCzw5THGAkKeMEuUaOZPSKBNEg4ZP7BJ1AMs3Kb9hFDDkLUstdfOZPT0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQk0ZACf; arc=none smtp.client-ip=95.215.58.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQk0ZACf"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Azhr/Ymn+QhvjiuQXJGj9VxIyXHjY5pCGMdkRbVMMcY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790117743; v=1; x=1790722543;
 b=WQk0ZACfXQg7DKuNSAYOpgk5aYv9TBodi/ijlaM4u440NcZtUzBRGjy4hF/sz1bJso/Qzhe8
 qCaVbx+xRy7d5iJOjfdo/9EN8iP2Fjtq9yEohA7dGhGUaahtpyGSsTukm23C5sP0GtBPFwKxog4
 waiBiKP6ztHGMneEXsWc9szM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d67416f0fb06a32;
	Tue, 22 Sep 2026 22:55:43 +0000
X-Mizu-Trace-ID: 6d67416f0fb06a32
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	andrii@kernel.org,
	peterz@infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Vineet Gupta <vineet.gupta@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to 1024
Date: Tue, 22 Sep 2026 15:55:25 -0700
Message-ID: <20260922225526.1554758-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922225526.1554758-1-vineet.gupta@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ftrace graphing is turned on, all tasks in the system missing
return stack page are assigned one. This is done in a simplistic
multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
at a time as follows:

   start_graph_tracing()
	do {
		alloc_retstack_tasklist
	} while (-EAGAIN);

   alloc_retstack_tasklist()
	alloc x32           # GFP_KERNEL, may sleep
	rcu_read_lock()     # preempt off
		for_each_process_thread    walk N_total, no cond_resched
                     t->ret_stack = new_page
	rcu_read_unlock()   # preempt enable but no explicit yield

Each successive iteration of loop invokes for_each_process_thread()
which doesn't support cursor based resume and always restarts from the
init_task. Thus each successive loop needs to skip the tasks assigned
ret_stack in prior sweeps and thus take longer and longer to find the
candidate 32 tasks. And while the loop end calls rcu unlock,
and re-enables preemption briefly, there is no explicit yield.

The total number of iterations turn out to be

	N_total * N_null / (2 * FTRACE_RETSTACK_ALLOC_SIZE)

where N_total is the number of threads on the system and N_null the number
of those whose ret_stack is still NULL. After boot with no fgraph user that
is every thread.

This is not a tracing-only path. Since commit 4346ba160409 ("fprobe:
Rewrite fprobe on function-graph tracer") fprobe is built on fgraph,
so an ordinary kprobe_multi BPF attach that flips ftrace_graph_active
from 0 to 1 pays the whole cost inside one bpf() syscall. Commit
2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
narrows that to return and session probes but does not remove it.

A host running hundreds of thousands of threads, with the current batch
size of 32, turns the ftrace_graph_active 0 -> 1 transition into a
multi-second, and eventually multi-minute, operation which showed up as
RCU stall and softlockup_panic on heavily loaded Meta Fleet machines
with preemption disabled.

    rcu: INFO: rcu_sched self-detected stall on CPU
    rcu: 0-....: (20718 ticks this GP) (t=21000 jiffies g=913 q=8 ncpus=8)
    CPU: 0 UID: 0 PID: 160141 Comm: bpftrace
     ___slab_alloc+0x549/0xa20
     kmem_cache_alloc_noprof+0x16c/0x340
     register_ftrace_graph+0x3d7/0x6c0
     register_fprobe_ips+0x2d5/0x310
     bpf_kprobe_multi_link_attach+0x218/0x7e0
     __sys_bpf+0x267a/0x27a0

Fix this by raising the batch to 1024.

Measured on a 60-core Sapphire Rapids machine, running a PREEMPT_LAZY
kernel (CONFIG_PREEMPT_DYNAMIC=y, mode lazy) timing the write that
drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
while fgraph is inactive so every one of them has ret_stack == NULL,
and the loop was instrumented to count passes:

	threads   batch 32              batch 1024
	          passes   time         passes   time     speedup
	100000     3126     15.3 s        98      0.44 s   34.8x
	200000     6253     59.1 s       196      1.61 s   36.7x
	400000    12503    227.8 s       391      7.25 s   31.4x

At smaller thread counts (<= 200k), speedups are better than expected
due to cache locality, and degrade at 400k threads due to cache misses.

This is a latency fix, specially on preemptible kernels.
On !CONFIG_PREEMPTION builds, where the walk is not preemptible, the
same loop additionally produces RCU stall and soft lockup splats;
those are a separate problem, and raising the batch only helps there
by making the operation too short to trip the thresholds.

The cost is a larger allocation burst. Shadow stacks are
SHADOW_STACK_SIZE (4K) each, so a batch is a 4M GFP_KERNEL burst out
of fgraph_stack_cachep taken while ftrace_lock and fprobe_mutex are
held, and the pointer array kcalloc()'d by start_graph_tracing() grows
from 256 bytes to 8K. Both are still ordinary kmalloc sizes, and any
unused tail of the batch is freed at the end of the pass as before.
1024 was picked to keep that array a single order-1 allocation; going
much higher would need kvmalloc.

This is a constant-factor improvement, not a cure: the retry loop
stays O(N_total * N_null), so wall time still grows quadratically with
the thread count and the batch will need revisiting as hosts get
bigger. Making the walk resume from a cursor instead of restarting
from the head would fix this properly, but task_struct lifetime makes
it considerably more involved, so it is left for later.

Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack into task_struct and allocate it dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/ftrace.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index bd76a16a63af..d2f8e433ce53 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1317,7 +1317,12 @@ unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 #define __notrace_funcgraph		notrace
 
 #define FTRACE_RETFUNC_DEPTH 50
-#define FTRACE_RETSTACK_ALLOC_SIZE 32
+/*
+ * Batch for handing out Shadow stacks in one sweep.
+ * This bounds how many times task list is walked and the allocation
+ * burst given page size of 4K.
+ */
+#define FTRACE_RETSTACK_ALLOC_SIZE 1024
 
 extern int register_ftrace_graph(struct fgraph_ops *ops);
 extern void unregister_ftrace_graph(struct fgraph_ops *ops);
-- 
2.53.0-Meta

