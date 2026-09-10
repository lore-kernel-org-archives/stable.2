Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9248F854
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047036; cv=none; b=GmVT2arEbJBYmfEBdUW8WK26uFMRfp9qj/EoVgQfr5TSNBZj+M1AZDHOnN9q0PRfzjhl98c2v6/NOzSP+0CSOn4Gqraxl+qrvg9yuZqVOJrcru7L15t6WObeVLFePMsiq0KP2C1jIj6bs55WFXk2FYyTkqbSFlszIrXK6qdU2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047036; c=relaxed/simple;
	bh=jI5G7gmRUt832AhOcrNVGdwQr/udxWjXGZyrBWJFqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOXTni14j2FV6zJATCUkzOzgcQ42kwhrWO2S2UzTPXb0tFIrwabRakSK0mkkD9ppyiAu5hE7FmNebvLYeTygTmjofMBy+ybkMD3PSJAcdPf/vxMYdxts8b21QpHu0Op/lwgL32CD4MwNL5J+4pg8iD4o8L2fJVd2wGFyTWb4OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcYM6rT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcYM6rT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F961F008A1;
	Thu, 10 Sep 2026 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047034;
	bh=QNejb6yICqN+fotwMn9rf4282ePtH/kytWq5So8dc60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dcYM6rT17pFu7hIIwRsucd5taB9ucQss784v1iC80jArrB8CKBmZ1C6uXel385DAd
	 8EdCVeSeS6beFSb2+MVk2K/djARoOPhjlwQR/kb7hH+GEqfhtWmUX/Bh2IROZcerxL
	 LNwBVwrAltB8vYR/1sJW4ZvQDHOND0GxaIv5gasJ1AFf/ib8CvNfIuM4BZ+4KZBiOU
	 3KWqonjqSziq8I4uUVa1eV9UTCjJvfd0DjODR+YpyBwSkW8Loxce8Su9k61TfrMDPX
	 4ENZRbF0KuR1OElx0y85+m7H9tQkw0tMcvCoYAPoplVXoUH/GOEE5WEBYAY6MzHems
	 iTL9Lbqt5K79g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tracing: Clean up use of trace_create_maxlat_file()
Date: Thu, 10 Sep 2026 09:30:31 -0400
Message-ID: <20260910133032.267975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090832-earflap-imprecise-3dce@gregkh>
References: <2026090832-earflap-imprecise-3dce@gregkh>
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
index 9d25992f0cf3c..25e7dff19c64e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1830,10 +1830,7 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 unsigned long __read_mostly	tracing_thresh;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-static const struct file_operations tracing_max_lat_fops;
-
 #ifdef LATENCY_FS_NOTIFY
-
 static struct workqueue_struct *fsnotify_wq;
 
 static void latency_fsnotify_workfn(struct work_struct *work)
@@ -1850,17 +1847,6 @@ static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
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
@@ -1885,14 +1871,22 @@ void latency_fsnotify(struct trace_array *tr)
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
@@ -2027,7 +2021,9 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	__update_max_tr(tr, tsk, cpu);
 	arch_spin_unlock(&tr->max_lock);
 }
-
+#else /* !CONFIG_TRACER_MAX_TRACE */
+static inline void trace_create_maxlat_file(struct trace_array *tr,
+					    struct dentry *d_tracer) { }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 struct pipe_wait {
@@ -9710,9 +9706,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	create_trace_options_dir(tr);
 
-#ifdef CONFIG_TRACER_MAX_TRACE
 	trace_create_maxlat_file(tr, d_tracer);
-#endif
 
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
-- 
2.53.0

