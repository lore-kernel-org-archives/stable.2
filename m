Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728725;
	b=i2F7eRtl9OnA3tAd1HMKLPjlzj21RHOjxUYOg6C+ccdi+eUYK7CyjMVW9boxA9e/2Ev4
	 c/q+TLRz0Uz+UPz4C80hNUmGUWd+e6VOvMNDykqf5UoU0UDHUei/5q0amdY0wdOgFdwSN
	 RzkO9UUao+/nBsF3K9K08ozitdjMLF88zEXpRdUdOHNnzdXv7Nk1enXM7vKyjIz+vU/VT
	 PfC5QDGP8VQsU1yT0UrQCl63qPxdOnZ4h746Cc/7RRPM02DWu5JkJrG11+L0XXYf5Y531
	 Q71TJqFWMc16/jpsLodCdsudUJYGNBUnpkP535tapRcnBXDxmJfo7wBN6fOelcYY8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
	b=w1ZjSpcGzAtHhnRyQ0UEcltsXet8uRCxahO3oPz3hkSOsF1MUCDe4JxIVC4CQvr62MLk
	 qpT4jZ/C2TiJOhbB/fpqwz2Sa7QuXrnau+7vL4VN75H+/npJjgrXOnG2erB0LGW3v7mZR
	 +R2qu5xIBbcZYsnGzdWLykHKONKKYl0jqp7r+oRNwqJ5oogZDe6IsIvGb3N1DjeLAfIDw
	 aUvAUHAD0fRZ9FDwzlg5XMEWkcVpNaR6nSj/PD4k3WMe8jv4mypsu12Zb9oQeQNko46DP
	 utrig4ZyddMbMTxN44gqupsdIFBFV/K4XpTqEezabqXgAFi/stmEc1oUBFVERvHdK7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0iMPh/WP";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54F606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B54F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMPh/WP
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36661f953e4so6732429eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728724; x=1794333524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
        b=0iMPh/WPjxqV5uoKPvI4vwhDncTSqaRmwcWFHV7NdZS/iITtkwufMIJa+5PfwfFisB
         dgg/jP2TTAUmdvOFygojVZh8NcS9OjMMpoPy9TyECJuOv71nbPo8PUd+rp7RMjzVXk2Y
         IhXOwB5zYhNrJlPJ0OD8KQUnkSaaDoM7zSH3tjzWj6fQawxUzEozsqP411NMGtt26V+Q
         DY+iNdphHkOSzh1nu4DZuNCOZEZtU0tEe00RizbGEk7dUug7o3xMedBpc8zX6IfvWT5o
         UGPtRvm3LjKkFH0iaxnhkenYtmjgV5CwMA97cr3KZimoMs7eaGDLdnixmyxeZ5rXG6iC
         dMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728724; x=1794333524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PElxI0aYTQe7EyopaZuArpxV8n0ScCes61k5/emAHuk=;
        b=REnnEI/cWeiD3zQgfi1gC2mv866X+CCOGDSDUN9mHNieQstOPJ4VN5XldoYzMjYdJb
         1LBn4ZW+AByap+I1lIVvAQoaO+fde9fQjlGpTgjORo3e75Bd/C75lLEthoRI3c6QiOuY
         1z4L8vhuUj7394t/avV4b12uU8vgfppgSLdZ7iGMPvItvJ+qjGXBKOThBmRcIDJAiWI4
         fvXImJpXFQLhYp7zQFTR0SfhlKajqxMyju1xFjx7IbKET0MPHRzCYSmlgOJRLZ8tm5fW
         BIup8sH8JqDlMzrd26QbCKI3xBKbN7o6AFTQz3MEEbdslUlkmBqEDX1+KbYYNNHSVUi2
         6LNA==
X-Forwarded-Encrypted: i=1; AKwUvBxVLaEGjf1kPDddDMxKemNbOlJEskZ/dmh3hth4uFJNyDGMOzzNdS+zjFeuxu/j8YnqyCbQlhY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BO2N2Xoi/HD9Eq4RSxeSlYR60YK8CU1cEvBT2jmpelhQVBVuz
	4evx1m5zqWGLCLpy+3CfoxYwFb+mbpPI+kKrS4bA/EmGnU06pxwpFn8NlvIDuwlnmJ8=
X-Gm-Gg: AYBFou0zPxoa20L7+ydKPO0JQke3YUqTA0C/bQ3qHxVJgfLvYBDfltrMfGtBoD7wqsO
	TFtC+XsjLICvZpj9pa61OSg+SoDoUb/Q/nRzb1xX5Q7J5JCCgShZ2CI/85/uupOkXUs9FESPbl2
	vOkrOm03dYI5BFNynhtuUFQniDdtn67yhHFdLz8wcwYUI3qU9PQpBsXaBDCUUTTbNBKXQiCVzlw
	IR4TmKGxVob4TczLdvG3rDjM+RClm+vZ1paMdJN6shulXQWF3sLeCvdXmSGxvnKsjP/7gzR5Iff
	I2/isaUnlEfJSVB67YvAz1E6uXw8gywqXhdA1kVrhILB/N/mN272qp8rI05jgaH4LGW/SX4OSok
	mkHT2ZgL5jaYtThidvykVl8Av2v9IStKdJza6iLMQF4+mGcDrbX9awK2aYP6u35Cms6NDi7xBVJ
	BU+qY2iZqBAmiZP+58Ln7M8IgexK85g6jT+22/BXj03FGLGpz1RnvUGYnmhqUbcL7O0Fuq9h9cu
	EqntJtHLlBrI7BQXNeAusKC+zjKTopLTMEaoXUN56Fb9OHiSHy0wUVIZ9j5zt4tHsYsBjHls/c4
	9oKoY3ckSg2GT+iDd8vjMB9zaVdXXlr8LRWkT/PCM4kaTGd/41Fh6l951hp+L2PMxdhWvC1KOL2
	r9A==
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id 5a478bee46e88-36a423f6947mr18594964eec.32.1793728723530;
        Tue, 03 Nov 2026 09:58:43 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm52256902eec.20.2026.11.03.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:58:42 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ftrace: Wait for graph readers before releasing operations
Date: Tue,  3 Nov 2026 09:58:30 -0800
Message-ID: <20261103175832.3374540-1-bestswngs@gmail.com>
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

unregister_ftrace_graph() removes an operation from the graph array before
returning. A graph callback may already hold the operation or its filter,
however, while the caller can release them as soon as unregistration
completes.

This can happen without a hash update failure. For example, consider three
graph operations with identical filters where one also enables PID
filtering. Removing that operation leaves the manager hashes unchanged, so
an in-flight fgraph_pid_func() may call gops->saved_func after unregister
has cleared it.

Graph callbacks run with preemption disabled and may run while RCU is not
watching. Separate removing the operation from graph dispatch from waiting
for callbacks that may still be using it. Keep unregister_ftrace_graph()
synchronous by performing both steps, and require internal users of the
split interface to pair every successful removal with a reader wait.

For fprobes, unpublish the graph operation and release its slot
synchronously, then queue the reader waits and filter release. This keeps
the waits out of unregister_fprobe_async(). Flush the work before reusing
the shared graph operation.

Disable fprobe return dispatch before unpublishing the operation and check
that state inside the callback's RCU critical section. Re-enable dispatch
only after graph registration succeeds, so a return callback cannot use a
released fprobe while cleanup is pending.

Cc: stable@vger.kernel.org
Fixes: df3ec5da6a1e ("function_graph: Add pid tracing back to function graph tracer")
Reported-by: <co+bba0c6b49150bef3@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/trace/fgraph.c          | 47 +++++++++++++++++++++++++++++++---
 kernel/trace/fprobe.c          | 21 ++++++++++++---
 kernel/trace/ftrace_internal.h |  2 ++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b535..14733f519 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1420,13 +1420,26 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	return ret;
 }
 
-void unregister_ftrace_graph(struct fgraph_ops *gops)
+/**
+ * unregister_ftrace_graph_start - unpublish a function graph operation
+ * @gops: graph operation to remove
+ *
+ * Remove @gops from graph dispatch, release its array slot, and update the
+ * graph and subop state. Existing graph callbacks may still be using @gops
+ * after this returns.
+ *
+ * Return: true if @gops was unpublished. The caller must then invoke
+ * unregister_ftrace_graph_finish() exactly once before releasing @gops or its
+ * filter, even if the subop hash update failed.
+ */
+bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
 {
 	int command = 0;
+	bool removed = false;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
 		      "function graph ops unregistered without registering"))
-		return;
+		return false;
 
 	guard(mutex)(&ftrace_lock);
 
@@ -1440,7 +1453,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (fgraph_lru_release_index(gops->idx) < 0)
 		goto out;
 
-	fgraph_array[gops->idx] = &fgraph_stub;
+	WRITE_ONCE(fgraph_array[gops->idx], &fgraph_stub);
+	removed = true;
 
 	ftrace_graph_active--;
 
@@ -1460,7 +1474,32 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
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
+ * unregister_ftrace_graph_finish - wait for readers of an unpublished operation
+ * @gops: graph operation previously unpublished by unregister_ftrace_graph_start()
+ *
+ * Wait for existing graph readers, then clear the saved callback. This may
+ * sleep. The caller may release @gops and its filter after this returns.
+ */
+void unregister_ftrace_graph_finish(struct fgraph_ops *gops)
+{
+	/*
+	 * The graph callbacks run with preemption disabled and may run while
+	 * RCU is not watching. Wait for both kinds of readers before the
+	 * caller can release the graph ops or its filter.
+	 */
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
index da286619c..c53ad37a0 100644
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

