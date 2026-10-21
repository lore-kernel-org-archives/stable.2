Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604671;
	b=rMji4Blw3/WdyDg54SIbaWMbnxURMwSmLtHd/S/RXPqvTzY5xVI2E5zFQS3oH/QP0XRG
	 49V759xvqyuYXq+KFi4OsfyrTHQbIuSo+DDzUu9VcF8VrO5JcJ8muJB2hgOY3UevO+tcd
	 vZziFvMeBra3GbUT7Tk9pC+ORcSX1AB6v/EPJSrHqAuPXnmIAacgQgjq5nfZtwZgvjn1o
	 oifpOJTgz5KsNXbTMXzIxZ9OURlvNfiU+jiT6BHdKnHvzfVN27as1DJ2oPCJINaF18/nU
	 tvSPko8Wx6vkRK3+lABAzdhMqRd7qK9EjByazBLBAsDeihRehUSf7tbohSzRWWn/96w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604671;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xWbmkTghQXBeOsr8TVyJjJbtbTKGSup92NsDqnjRdTo=;
	b=ubRlIZJ+DY7UKRyJtHqDu4LfotZJ3vIrR3KgF46rnXcQclj10SH9JLrhTMtt8d4NkGfE
	 JGzgS6sSk2ACIwfHGgVGa64pwKgohDKDROyztQpW/VJu/DrxAhcAh6meV4VMvEy8teQgc
	 52Rb4v0XJvh+lGJL6p9f5Z0eHbzl/jGBfROE4kqdzDJYpnv6avKm1912KM1FvkKv+5z+8
	 xQ5zKAwzSfqUXQAF7WAL6yXj2bRtweZhElPGXcH9knrBajbLlt09ObNZLndEuvgS5dPEF
	 HnpKUnP1SxspGO6vvYfLdx4I/ortcGXzELZ6T93Bf7YZih0VcITFhdbpmfhU5DKaDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tscu8qTQ;
	arc=none smtp.remote-ip=91.218.175.3
Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AB606A325
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02AB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tscu8qTQ
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1E/Ah9c/xEmhiUW3Al9gJhcc0ql5iSclAZFrvguw7UU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792604668; v=1; x=1793209468;
 b=Tscu8qTQSlPQvW9lHIVLkKySYQlLzQYWk0Mr4aZCds+v67/nLsKz7XrCOCF7r80s7np2lrKC
 r7XP+0zeJlLLUi8WEtQSjCSo1bnw8ZUu6KXb+Z+L5qyvzsUN/p/eoa0axq8bjAtDHYK3Js8HOAb
 fRALJfxaIpdnyd7GThroQqg4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dcdf2fc6b9d40495;
	Wed, 21 Oct 2026 17:44:28 +0000
X-Mizu-Trace-ID: dcdf2fc6b9d40495
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
Subject: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
Date: Wed, 21 Oct 2026 10:44:05 -0700
Message-ID: <20261021174406.2891598-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021174406.2891598-1-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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

Fix this by allocating inline with GFP_NOWAIT instead of pre-allocating
a fixed batch. GFP_NOWAIT does not sleep, so it is legal inside the RCU
read-side critical section.

A single sweep now serves every task, so the walk becomes O(N) rather
than O(N_total * N_null), and the retry loop is no longer the normal
path.

The pre-allocated array remains as the fallback when GFP_NOWAIT fails.
The runs below never needed it, so it was exercised with failslab
injection: at a 100% failure rate every task falls back and -EAGAIN
retries ~1560 times for 50000 threads, with no stall or splat.

The open-coded rcu_read_lock() and the goto unwind are kept as-is so
this stays easy to backport; converting them to scope-based cleanup is
left to a follow-up.

smp_store_release() is a drop-in replacement for the smp_wmb() and
plain store it replaces.

Measured on a 60-core Sapphire Rapids machine running a PREEMPT_LAZY
kernel (CONFIG_PREEMPT_DYNAMIC=y, mode lazy), timing the write that
drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
while fgraph is inactive so every one of them has ret_stack == NULL,
and the loop was instrumented to count sweeps:

	threads   before              after
	          sweeps   time       sweeps   time
	100000     3126     15.3 s      1       0.019 s
	200000     6253     59.1 s      1       0.047 s
	400000    12503    227.8 s      1       0.092 s

The sweep count is 1 throughout. Time now scales linearly with the
thread count at roughly 230 ns per task, which is the allocation and
initialisation of one shadow stack.

Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack into task_struct and allocate it dynamically")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
Cc: stable@vger.kernel.org
---
 kernel/trace/fgraph.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b53513b..4c74f1a15ad4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1033,13 +1033,16 @@ void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 
-/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
+/*
+ * Loop thru all the tasks in the system and assign ret_stack.
+ * The @ret_stack_list is a small pre-allocated fallback, in case
+ * the GFP_NOWAIT allocations here fail.
+ */
 static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 {
-	int i;
-	int ret = 0;
 	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
 	struct task_struct *g, *t;
+	int i, ret = 0;
 
 	if (WARN_ON_ONCE(!fgraph_stack_cachep))
 		return -ENOMEM;
@@ -1056,20 +1059,26 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
-		if (start == end) {
-			ret = -EAGAIN;
-			goto unlock;
-		}
+		unsigned long *rs;
 
-		if (t->ret_stack == NULL) {
-			atomic_set(&t->trace_overrun, 0);
-			ret_stack_init_task_vars(ret_stack_list[start]);
-			t->curr_ret_stack = 0;
-			t->curr_ret_depth = -1;
-			/* Make sure the tasks see the 0 first: */
-			smp_wmb();
-			t->ret_stack = ret_stack_list[start++];
+		if (t->ret_stack)
+			continue;
+
+		rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
+		if (!rs) {
+			if (start == end) {
+				ret = -EAGAIN;
+				goto unlock;
+			}
+			rs = ret_stack_list[start++];
 		}
+
+		atomic_set(&t->trace_overrun, 0);
+		ret_stack_init_task_vars(rs);
+		t->curr_ret_stack = 0;
+		t->curr_ret_depth = -1;
+		/* Make sure the tasks see the 0 first: */
+		smp_store_release(&t->ret_stack, rs);
 	}
 
 unlock:

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0-Meta

