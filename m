Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363030;
	b=qZT02PVwMhUEzfhRX/VxHNHjmEkz3fI4y/xTVIfTf1F9YgTpGuWkuFWtxfy0+ThZcexz
	 eq1fxvQRAQS8mU95f6JEkFpZ7We3UR6GHJ0+REpEnML7fnP6ni58A3U9/PQHNBrTiuDny
	 fDBpT++ojkkAHpOVFntpnGt5Q74BReZN5MpIn9NacLNOvlk5Du1njTOVE7YZpcefJq/SS
	 RT/hGmr2RYoBsn2MQn/3B/Wrgo5rQOvQEXD1F9kSnlDPFYfIReKSDNhmf40Rqe447soNV
	 EB7jgpCWrjPMl6K0fzbC76ZBzMALOBad//mrO8FQH3DQeZ3p0zP1QpcGftlo067YSxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
	b=G9q4RMYD1oucCIYqjPEloBCVbXIbjDwugMYb8Lm6ExfwZ6ZH6LSEm2gOTpQVSjNBwZ3j
	 Jc48U+FU2B5yOuDjDzFrRZhzWsPryKwKK7MGJ1FE3pW69OKXqpsf/3C0EIUO8psmt3AjS
	 9aeCpJt9JEzpUvwofa7fG9GIBFCbLpZtZIC6CVCLYJ5lE7ml5Rshuu2vUNTc/pyvvcsVQ
	 99cGTfdVAS765t3Nn0j2IJOO2EZds+QPIEkVz52r1BoD1O/bTeU3zyw+tLgz/xV+bVl00
	 cXyzO/asMN2z9hvnkWQaVSZjSmCLmiMjiHKBW5ebUCUFX6TvU6+4oDB4F2Ft7IK/gpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/gmsNPI";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB71606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB71606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/gmsNPI
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1102951b3a.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795363029; x=1795967829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
        b=c/gmsNPIXsQr4SFgvieDaS9vN8kMJn/F7zOT6gVit4cZCnEZAdeVRY56OGkkFh0zT7
         2tQNP+FZucYItfDiEAvP6KVA/bYQOGWYsgn8/9BquU91WAauqGqKcq4W5wTN/t1TovuM
         dlionaEwc48fajftsT5J0kZhoEn/ePDG5vO9ivnmHOAhe25fc1c6x4pAoWICiiOmnIwI
         jCVcQBTvndZkptLEg34endAKAp39nk3yBtr1LxvTXlHqFu4js5N1nDGxKUjafmdhIAFl
         OrFjkerein0greGKQVeA8qbk6kv7sY7iAq/x1EhjG4PJpMj+9IkBVbhAGLrh3kMJrAT8
         0zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363029; x=1795967829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLQyCMsvy09QyUXPiWKY2K4VQCxavVMU+Xlpye7L2/Q=;
        b=W07tVC+NHoF67z7PY6HORkWFjnId1TX1FMtUf/S6P7nxfxAMKjueQtAQu6So5PY++r
         ELc2qRq06u7ihKqX+HWSQf/Bd2u5a01ccsBYP+o8OdbecBciEcHO4vynNTZdEKi6N9ca
         r8FbozEJB+OThoxhxRQYnuf8HfaKsNucpoVi9hEr6KIAsyMblRfVq8Kze1p2VTUpplB8
         pS9YPiytN5+Ekyq5Kh/GwLQ+u3TVmw/hVeaKd9CWk2YIT2GzeDp7gMEoOSpuJGSP8fKG
         A1I1r3ZKJYzSE5JbK/dG8H74dBkcKIeFOosATvt2u0+qdzlvGTlywceg179Ccl9j0h7v
         zYOg==
X-Forwarded-Encrypted: i=1; AL+hErGJ/Vevr5l8Z5PSJ/fE6he9ddavoiXK7gQ32fa3VCKfepY7Z2pmlJqten2mshFnVYbUej1sFSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZKIBISxITro4Mgl7ktg8mpVnp2h9fhp4CqplvYVVky0WM+LbB
	E2Hy+3YlduTB6c6AegK2ekZMJ3kXtPtvihPnh971bw3IzbIOtv8D4biWLbW1t77ASck=
X-Gm-Gg: AZFdTZcmLe77/VJsTpPPsNTqHoCPJCxLWPG7/Qs4gzkeWp0/A6MktkFt7wG8jSegB86
	iW/YGOdJCUWJOKbYus1RXxH//6LjUh0+CFTp3amJaZct2F8rvKyTKbo/pZnBX7KCKP5Z1gxy853
	kbwboC+HbJFyor/i6AR1VcDcDC0K6b5i9YazosJK4OAFKnDzuVoim9V4CM6HR80d/Q7XTTFPdJh
	n8pWf0d2L4sek8lfN94+Ir6ti6kUMaKj00Xw8VY18biQhEtrd/gn+wMeaMCjeGJdIK+sBo4qNEG
	gHtst9QF9zAZJu7+7scCAWdHJjMTXli2eUR0LZl2Q03RbAzcZ8tHEXCKad5nwYVoJdehJNbpLcK
	iQ+ViOYiHHMy+TZI69m5ZmILCucp5mSMKFNAX8uiPfgyp3EsbWcIJK1fVa8vYS/YJop2M/6L6u3
	ua3g9ELhKfoXoo9RCe/BywlIQL0GjlYdhw7ZsGSCgjy2BlmWg0HM6wJQN+TruiGx8Ba9JCfqS/F
	m2lTuJezvysywtQ7XAhIkl0fDZpoiwuR/BKTgZOsK8pkJyI6rPuhdjzYUvwuN6D76rcqO4zuJLb
	hobuVGL+0NS0I2Fgxme9mWynM39AyrTsKn33W67B7Ft+QfNvPw/zVKdYqV3frbZV/TxY+zcuDRx
	0Bw==
X-Received: by 2002:a05:6300:492:b0:3e0:df21:9df2 with SMTP id adf61e73a8af0-4014ca45234mr4831520637.10.1795363029069;
        Sun, 22 Nov 2026 07:57:09 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm4192683b3a.1.2026.11.22.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:57:08 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] ftrace: Finish removing subops after a hash update failure
Date: Sun, 22 Nov 2026 07:56:19 -0800
Message-ID: <20261122155620.319722-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When removing a non-final graph subop, ftrace_shutdown_subops() first
detaches it, then rebuilds and installs the manager hashes. If
rebuild_hashes() fails, the subop stays detached with its ENABLED and
SUBOP flags and manager pointer intact. If ftrace_update_ops() fails, the
subop is added back even though unregister_ftrace_graph() has already
removed its graph slot.

In the fprobe path, ftrace_free_filter() then warns and returns, while
__fprobe_graph_unregister() marks the shared graph operation unregistered.
A later registration follows the stale SUBOP state into an empty manager
list. rebuild_hashes() leaves its output pointers uninitialized in that
case, and ops_equal() dereferences one of them.

Complete non-final removal on both manager-hash failure paths and
initialize empty rebuild outputs to EMPTY_HASH. Keep direct dispatch
disabled after an update failure because the old manager hashes may cover
functions needed only by the removed subop; normal dispatch still applies
the remaining subops' filters.

Completing removal also lets the caller free the subop filter. Split graph
unregistration into removal and callback-wait helpers so Tasks RCU waits
run before saved_func or the operation can be released. For asynchronous
fprobe removal, remove the graph operation immediately and defer the wait
and filter release to a worker that is flushed before reuse. Gate return
callbacks on fprobe_graph_registered while cleanup is pending.

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
Call Trace:
 ftrace_update_ops (kernel/trace/ftrace.c:3464)
 ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
 ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
 ftrace_set_hash (kernel/trace/ftrace.c:6006)
 ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:6769)
 register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1020)
 register_fprobe (kernel/trace/fprobe.c:979)
 __register_trace_fprobe.part.0 (kernel/trace/trace_fprobe.c:838)
 enable_trace_fprobe (kernel/trace/trace_fprobe.c:823 kernel/trace/trace_fprobe.c:1483)
 fprobe_register (kernel/trace/trace_fprobe.c:1553)
 __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
 event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_events.c:1995)
 vfs_write (fs/read_write.c:665)
 ksys_write (fs/read_write.c:719)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:89)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Kernel panic - not syncing: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Reported-by: <co+bba0c6b49150bef3@bugs.sh>
Link: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Merge the dependent teardown and graph-reader fixes.
- Use Tasks RCU waits and defer the fprobe callback wait and filter release
  to a worker.
- Rebase onto 4405c18c95d2 and decode the reproduced crash trace.
- v1: https://lore.kernel.org/r/20261103175832.3374540-2-bestswngs@gmail.com

 kernel/trace/fgraph.c          | 53 +++++++++++++++++++++++++++++-----
 kernel/trace/fprobe.c          | 21 +++++++++++---
 kernel/trace/ftrace.c          | 22 +++++++++-----
 kernel/trace/ftrace_internal.h |  2 ++
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6d87143b3..3760795d3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
 
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
-	if (!ret)
+	if (!ret) {
 		fgraph_array[i] = gops;
+		if (ftrace_graph_active == 1)
+			ftrace_graph_enable_direct(true, gops);
+	}
 
 error:
 	if (ret) {
@@ -1420,13 +1423,27 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	return ret;
 }
 
-void unregister_ftrace_graph(struct fgraph_ops *gops)
+/**
+ * unregister_ftrace_graph_start - remove a function graph operation
+ * @gops: graph operation to remove
+ *
+ * Remove @gops from graph dispatch, release its array slot, and update the
+ * graph and subop state. Existing graph callbacks may still be using @gops
+ * after this returns.
+ *
+ * Return: true if @gops was removed. The caller must then invoke
+ * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
+ * filter, even if the subop hash update failed.
+ */
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
 {
 	int command = 0;
+	int ret = -EINVAL;
+	bool removed = false;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
 		      "function graph ops unregistered without registering"))
-		return;
+		return false;
 
 	guard(mutex)(&ftrace_lock);
 
@@ -1440,16 +1457,17 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (fgraph_lru_release_index(gops->idx) < 0)
 		goto out;
 
-	fgraph_array[gops->idx] = &fgraph_stub;
+	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
+	removed = true;
 
 	ftrace_graph_active--;
 
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
 
-	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
+	ret = ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
-	if (ftrace_graph_active == 1)
+	if (ftrace_graph_active == 1 && !ret)
 		ftrace_graph_enable_direct(true, NULL);
 	else if (!ftrace_graph_active)
 		ftrace_graph_disable_direct(false);
@@ -1460,7 +1478,28 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
-	gops->saved_func = NULL;
  out:
 	gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
+	return removed;
+}
+
+/**
+ * unregister_ftrace_graph_finish - wait for callbacks using a removed operation
+ * @gops: graph operation previously removed by unregister_ftrace_graph_start()
+ *
+ * Wait for existing graph readers, then clear the saved callback. This may
+ * sleep. The caller may release @gops and its filter after this returns.
+ */
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
+{
+	/* Graph callbacks can run where RCU is not watching. */
+	synchronize_rcu_tasks_rude();
+	synchronize_rcu_tasks();
+	gops->saved_func = NULL;
+}
+
+void unregister_ftrace_graph(struct fgraph_ops *gops)
+{
+	if (unregister_ftrace_graph_start(gops))
+		unregister_ftrace_graph_finish(gops);
 }
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 47d565a1e..29fc2bfc4 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -14,9 +14,11 @@
 #include <linux/rhashtable.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/workqueue.h>
 
 #include <asm/fprobe.h>
 
+#include "ftrace_internal.h"
 #include "trace.h"
 
 #define FPROBE_IP_HASH_BITS 8
@@ -279,6 +281,14 @@ static struct fgraph_ops fprobe_graph_ops = {
 static int nr_fgraph_fprobes;
 /* Is fprobe_graph_ops registered? */
 static bool fprobe_graph_registered;
+static void fprobe_graph_cleanup_workfn(struct work_struct *work);
+static DECLARE_WORK(fprobe_graph_cleanup_work, fprobe_graph_cleanup_workfn);
+
+static void fprobe_graph_cleanup_workfn(struct work_struct *work)
+{
+	unregister_ftrace_graph_finish(&fprobe_graph_ops);
+	ftrace_free_filter(&fprobe_graph_ops.ops);
+}
 
 /* Add @addrs to the ftrace filter and register fgraph if needed. */
 static int fprobe_graph_add_ips(unsigned long *addrs, int num)
@@ -286,6 +296,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 	int ret;
 
 	lockdep_assert_held(&fprobe_mutex);
+	flush_work(&fprobe_graph_cleanup_work);
 
 	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
 	if (ret)
@@ -297,7 +308,7 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 			ftrace_free_filter(&fprobe_graph_ops.ops);
 			return ret;
 		}
-		fprobe_graph_registered = true;
+		WRITE_ONCE(fprobe_graph_registered, true);
 	}
 	return 0;
 }
@@ -305,9 +316,9 @@ static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 static void __fprobe_graph_unregister(void)
 {
 	if (fprobe_graph_registered) {
-		unregister_ftrace_graph(&fprobe_graph_ops);
-		ftrace_free_filter(&fprobe_graph_ops.ops);
-		fprobe_graph_registered = false;
+		WRITE_ONCE(fprobe_graph_registered, false);
+		if (unregister_ftrace_graph_start(&fprobe_graph_ops))
+			schedule_work(&fprobe_graph_cleanup_work);
 	}
 }
 
@@ -679,6 +690,8 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
 	guard(rcu_sched_notrace)();
+	if (!READ_ONCE(fprobe_graph_registered))
+		return;
 
 	curr = 0;
 	while (size_words > curr) {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d..7c712d99f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
 	bool first = true;
 	int ret;
 
+	*filter_hash = EMPTY_HASH;
+	*notrace_hash = EMPTY_HASH;
 	temp_hash.filter_hash = EMPTY_HASH;
 	temp_hash.notrace_hash = EMPTY_HASH;
 
@@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  * will not affect functions that are being traced by other subops that
  * still exist in @ops.
  *
- * If the last subops is removed from @ops, then @ops is shutdown normally.
+ * If @subops is the last subop, @ops is shut down normally. Otherwise,
+ * @subops is detached even if the manager hash update fails. The manager
+ * hashes may be partially updated, but still cover all functions required by
+ * the remaining subops.
+ *
+ * Return: 0 on success, or a negative error code on shutdown or hash update
+ * failure.
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
@@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	/* Rebuild the hashes without subops */
 	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
-	if (ret < 0) {
-		list_add(&subops->list, &ops->subop_list);
-	} else {
-		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
-		subops->managed = NULL;
-	}
+
+out:
+	subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
+	subops->managed = NULL;
 	free_ftrace_hash(filter_hash);
 	free_ftrace_hash(notrace_hash);
 	return ret;
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 3235470e6..abb7776a2 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -52,6 +52,8 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops);
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops);
 # ifdef CONFIG_DYNAMIC_FTRACE
 extern void fgraph_update_pid_func(void);
 # else
-- 
2.56.0

