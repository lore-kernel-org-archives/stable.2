Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A533B97D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047943; cv=none; b=rXfg/GLK2lUybDFTqSo19VhhXQ0iLXpCFdmSeba7Bz6WWykpkBMHn9SYgq0BIihwPqlOE/e/QV0tfWAmXZD0dTwJYksxq7GYYNmctZNpA2iad57RdKVUvTGKSbMmtrHzCKAi6uUQXAgmjulIst2eNB4qQYJXppzr5e11YHY48IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047943; c=relaxed/simple;
	bh=bLIM7DnFowCq1jT+yUdwsPQAYaaDVQi9ZmLOg5eamXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiIq5nSgIzheQx7wZEgNWeNigj8mtkfpWin3/fVztGYSL0cSPYuEXsHiYqkN5xioJXiQbePXrHIgWL6q9Hr6gg3abLl+6aqiGMfnRCZhYPDf93h7ksDA2SQqyn52rMqaFlUcHpJXQ9p5RT/LoIkRoTHKKLgweDODsPQqt9YuHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYkd3MAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYkd3MAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6241F000FF;
	Thu, 10 Sep 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047941;
	bh=XXZhsMBrARoFE7iLvSIsYaZm/ZPLV3QBIGQBui1ntww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYkd3MAfN3KOpO9/O9hh+Fx8yLDnfLyIpBj871+5QBxMHo9DiFuDiIzLIHc6C/XdY
	 ajUxJkfjaVN2U+LVI7pR6fmQ9pbh/EdPgZv3kEUtN7nQB28Dh6YB0RLl1GXHoZHBy1
	 F3mIimz3wMXVB7mQxhgkTE/eHcw+k2EEZ3jYxPbwqzfWPLc4PEt1hIe4kQQAU6BtYl
	 Vz66bUaIzOG0bhS+Xgx31KVo66HI8W9fMZPFTzGsUYkzigEbycN06F+FfWJZ7WlA2n
	 vP08BjRdbqOd1f+mamkDwR4tiGgMSeCf5eRWibf/+MIOn1atiL4H8Onz3Xm/9WxJrB
	 xAoUPDtHQlcqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] tracing: Clean up use of trace_create_maxlat_file()
Date: Thu, 10 Sep 2026 09:45:38 -0400
Message-ID: <20260910134539.386642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090833-darn-control-392b@gregkh>
References: <2026090833-darn-control-392b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit ba73713da50e5c24499ca8941171593466ea34f7 ]

In trace.c, the function trace_create_maxlat_file() is defined behind the
 #ifdef CONFIG_TRACER_MAX_TRACE block. The #else part defines it as:

 #define trace_create_maxlat_file(tr, d_tracer)				\
	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
			  d_tracer, tr, &tracing_max_lat_fops)

But the one place that it it used has:

 #ifdef CONFIG_TRACER_MAX_TRACE
	trace_create_maxlat_file(tr, d_tracer);
 #endif

Which is pointless and also wrong!

It only gets created when both CONFIG_TRACE_MAX_TRACE and CONFIG_FS_NOTIFY
is defined, but the file itself should not be dependent on
CONFIG_FS_NOTIFY. Always create that file when TRACE_MAX_TRACE is defined
regardless if FS_NOTIFY is or is not.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260207191101.0e014abd@robin
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: f2951ebd15c3 ("tracing: Take trace_array reference when opening options file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5ef1c79dc5c9e..8b536db426ce5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1707,10 +1707,7 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 unsigned long __read_mostly	tracing_thresh;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops;
-
 #ifdef LATENCY_FS_NOTIFY
-
 static struct workqueue_struct *fsnotify_wq;
 
 static void latency_fsnotify_workfn(struct work_struct *work)
@@ -1727,17 +1724,6 @@ static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
 	queue_work(fsnotify_wq, &tr->fsnotify_work);
 }
 
-static void trace_create_maxlat_file(struct trace_array *tr,
-				     struct dentry *d_tracer)
-{
-	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
-	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
-	tr->d_max_latency = trace_create_file("tracing_max_latency",
-					      TRACE_MODE_WRITE,
-					      d_tracer, tr,
-					      &tracing_max_lat_fops);
-}
-
 __init static int latency_fsnotify_init(void)
 {
 	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
@@ -1762,14 +1748,22 @@ void latency_fsnotify(struct trace_array *tr)
 	 */
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
+#endif /* !LATENCY_FS_NOTIFY */
 
-#else /* !LATENCY_FS_NOTIFY */
-
-#define trace_create_maxlat_file(tr, d_tracer)				\
-	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, tr, &tracing_max_lat_fops)
+static const struct file_operations tracing_max_lat_fops;
 
+static void trace_create_maxlat_file(struct trace_array *tr,
+				     struct dentry *d_tracer)
+{
+#ifdef LATENCY_FS_NOTIFY
+	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
+	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 #endif
+	tr->d_max_latency = trace_create_file("tracing_max_latency",
+					      TRACE_MODE_WRITE,
+					      d_tracer, tr,
+					      &tracing_max_lat_fops);
+}
 
 /*
  * Copy the new maximum trace into the separate maximum-trace
@@ -1904,7 +1898,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
-
+#else /* !CONFIG_TRACER_MAX_TRACE */
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
@@ -9745,9 +9741,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.53.0

