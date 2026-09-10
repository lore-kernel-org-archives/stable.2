Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B64A2613
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053084; cv=none; b=UTaP8K7Mb8bGQaFC0sCzl3piW8OwGJCZYb0oyYTmk6tt1oEWIFt8eJ73qOB97OQAGHIy3wHIG0ijRCIptUkjmqluYs2LdecxxPH9wb1kGQ2wxSE+FmHvWBmHGLE3z+M8L7az9bQ75f4Q+MPYKOXACVKZKtJ256mrcK6H5hsVNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053084; c=relaxed/simple;
	bh=j6v5untrQCR7B/qd2Pd2SBoFAt5ELkAboSj+lytsVjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmHQRrby+AdXEFY33mYRAIsyyb/yFzSPWm6cRk9KyRsM3fgxiwsXz7bFm6AyY0jJWstyDWtohWmujNEXabEohoePJraz8hCuSBo0KTrkn+L5QCEYSeDtLm1xWRpBLtOfW7cT0WEQoLgXC+epMhS40I8LeXdmj67cedLbWGkzOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgtZMrXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgtZMrXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2251F000FF;
	Thu, 10 Sep 2026 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053075;
	bh=U3QArTcGsJCnJV2+uX5OgGCItRbix3UrUVGxj3Xyj9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IgtZMrXraDH4yYTJa62GF3eBvsSuMYTt9iHV4cL2eS+atOgBzlhAMX1gDb1o+h7Hg
	 RdwDwNgCThZ4YGPRkI3umte3aB49r/+r53LxHxpdfFQkFE/jLaRvNZJkl32OzfGjRl
	 7VPvd7rQTcipxGI4c6c+gMFPIwWzhid1Q7yiUss4hmYdIuZUDrcQjhbZ5zTbIgNRjG
	 hAegQwNSC0MIL36n7AymdwK1XVUrnr5iue2xIRCJTtTDOnP78CmMoQlycGAQ354t4y
	 vAsfXX7r0WjBlcXYKpoxYdzEPsOgTqLhNzwmBQ2v4iVW3Womt3iSzYaQmAZlbbmd/J
	 ref+tWd2VCdmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] tracing: Clean up use of trace_create_maxlat_file()
Date: Thu, 10 Sep 2026 11:11:12 -0400
Message-ID: <20260910151113.854712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090833-imaging-carving-723a@gregkh>
References: <2026090833-imaging-carving-723a@gregkh>
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
index 1a29a9d9e8685..8b333fbdb2f63 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1690,10 +1690,7 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 unsigned long __read_mostly	tracing_thresh;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops;
-
 #ifdef LATENCY_FS_NOTIFY
-
 static struct workqueue_struct *fsnotify_wq;
 
 static void latency_fsnotify_workfn(struct work_struct *work)
@@ -1710,17 +1707,6 @@ static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
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
@@ -1745,14 +1731,22 @@ void latency_fsnotify(struct trace_array *tr)
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
@@ -1887,7 +1881,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
-
+#else /* !CONFIG_TRACER_MAX_TRACE */
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
@@ -9694,9 +9690,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.53.0

