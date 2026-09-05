Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301E33E360;
	Sun,  6 Sep 2026 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659052; cv=none; b=pQUOVTgOw8C55rlQJfkwcZ7A5OsO/0VIoDSf3E1YxQVpVlDoAmW374MPUnbiHztPc79OxjynXcfEX/bRQUlgDiIkDvahGXLjZrRewoTkY8reUnm+xGjPPXHRYieCYNVSNmrX8DVigrpiBVlEQL+l/CgNgKV/2EoOdcMoMcJ69Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659052; c=relaxed/simple;
	bh=C/nmJqIpj9Qo37/aXuKCkckjdqnuKl5TtqMJGfAZ+xQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ejuLfN6GNUIjbFfTThmGJa8Gp/LOm9n1OccFLMxrR6lZinv1RvRFVbnmYTgEL/4Jo81xbckW9ghNv/9I49I1u/+r5hxMxU3/MxjYb0CFC00xVxJXkGhvOd32eEEXOZ+K4qXF04XmBwqISbrUgog+sdCmwVbrtmEG1EJZu+YMZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRxeJn9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRxeJn9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE671F00A3A;
	Sun,  6 Sep 2026 01:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659050;
	bh=1YUfvz1vxFFyEzl/5JjQa4kmCbP460iPGSkmlkg4LKw=;
	h=Date:From:To:Cc:Subject:References;
	b=JRxeJn9j5nJXZgdqNmhypfWD5WOxmDwgsseQ52jvxiX+SwmE+hj3s8R8d5c2kAi9c
	 /xEBVscJlDAq9sKfaXvVhA4ygw22RWYKec6cBnWay/SMqBqZ+vY0L/Tj6IwvIZLV+l
	 yQXICe8xz+v1iceuh97SyikzlXC6RSrUoZASWDsy5H78cCvuuf0doVBtxfXJ+mCZd8
	 GFHfaYY7AhniEZdQHRMF7jb1SYSDmh5JWDhc9CiNOXAfeeiGC661iv0c5JS1p2UNWn
	 pSPzZIpqQpgN+kpGpLzpGsxj7MMAFU9hmaGlI0qcSoBVeiadDn+4xfiEQxYatL9hPB
	 RG5VuNoGbQKPg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x2whP-00000006J97-0nSY;
	Sat, 05 Sep 2026 16:09:15 -0400
Message-ID: <20260905200915.040838641@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 16:08:29 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>
Subject: [for-linus][PATCH 02/12] ftrace: Take trace_array reference before accessing its ftrace_ops
References: <20260905200827.773347757@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace instance files set_ftrace_filter and set_ftrace_notrace was
updated to work with specific trace instances (trace_arrays). The issue is
that when these files are opened, there is a small race window where it
will use the ftrace_ops from the inode->private pointer to get a reference
to the trace_array and then take its reference. The problem is that the
ftrace_ops itself could be freed. If the rmdir on the instance happens at
the same time the set_ftrace_filter file is opened, the rmdir could have
also freed the ftrace_ops and referencing it will cause a use-after-free
bug and crash the kernel.

Instead, pass in the trace_array as the file private data (NULL for the
top level instance), and then pass both the trace_array and the ftrace_ops
to the ftrace_regex_open() function. If the trace_array is NULL, then it
just uses the ftrace_ops without the need to take its reference (like
normal). If the ftrace_ops is NULL, that is only the case for the top
level instance and the global_ops can be used.

This allows the trace_array to have its reference incremented before
touching the ftrace_ops that could also be freed when the instance is.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260828223901.29e26edb@robin
Fixes: 591dffdade9f0 ("ftrace: Allow for function tracing instance to filter functions")
Reported-by: Breno Leitao <leitao@debian.org>
Tested-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h         |  5 +--
 kernel/trace/ftrace.c          | 57 ++++++++++++++++++++++------------
 kernel/trace/trace.h           |  5 +--
 kernel/trace/trace_functions.c |  2 +-
 kernel/trace/trace_stack.c     |  2 +-
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02bc5027523a..bd76a16a63af 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -866,8 +866,9 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
 extern ftrace_func_t ftrace_trace_function;
+struct trace_array;
 
-int ftrace_regex_open(struct ftrace_ops *ops, int flag,
+int ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file);
 ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
 			    size_t cnt, loff_t *ppos);
@@ -1077,7 +1078,7 @@ static inline unsigned long ftrace_location(unsigned long ip)
  * have them defined when ftrace is not enabled, but these
  * functions may still be called. Use a macro instead of inline.
  */
-#define ftrace_regex_open(ops, flag, inod, file) ({ -ENODEV; })
+#define ftrace_regex_open(tr, ops, flag, inode, file) ({ -ENODEV; })
 #define ftrace_set_early_filter(ops, buf, enable) do { } while (0)
 #define ftrace_set_filter_ip(ops, ip, remove, reset) ({ -ENODEV; })
 #define ftrace_set_filter_ips(ops, ips, cnt, remove, reset) ({ -ENODEV; })
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9d80c7bd9f1..c7cf36f2dd7b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4677,7 +4677,8 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
 
 /**
  * ftrace_regex_open - initialize function tracer filter files
- * @ops: The ftrace_ops that hold the hash filters
+ * @tr: The trace_array that holds the ftrace_ops [optional]
+ * @ops: The ftrace_ops that hold the hash filters [optional]
  * @flag: The type of filter to process
  * @inode: The inode, usually passed in to your open routine
  * @file: The file, usually passed in to your open routine
@@ -4691,26 +4692,45 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
  * tracing_lseek() should be used as the lseek routine, and
  * release must call ftrace_regex_release().
  *
+ * Note, If @tr is not NULL, its reference has to be taken before
+ *       @ops may be referenced.
+ *       If @ops is NULL and @tr is not, then @tr->ops is used.
+ *       If @tr is NULL and @ops is not then @ops->private is uesd for @tr.
+ *       If both @tr and @ops are NULL, then the &global_ops is
+ *         to be used, and @tr will be the global_ops.private pointer.
+ *
  * Returns: 0 on success or a negative errno value on failure
  */
 int
-ftrace_regex_open(struct ftrace_ops *ops, int flag,
+ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file)
 {
-	struct ftrace_iterator *iter;
+	struct ftrace_iterator *iter = NULL;
 	struct ftrace_hash *hash;
 	struct list_head *mod_head;
-	struct trace_array *tr = ops->private;
-	int ret = -ENOMEM;
-
-	ftrace_ops_init(ops);
+	int ret = -ENODEV;
 
 	if (unlikely(ftrace_disabled))
 		return -ENODEV;
 
+	if (!tr) {
+		if (!ops)
+			ops = &global_ops;
+		tr = ops->private;
+	}
+
 	if (tracing_check_open_get_tr(tr))
 		return -ENODEV;
 
+	if (!ops)
+		ops = tr->ops;
+
+	if (WARN_ON_ONCE(!ops))
+		goto out;
+
+	ftrace_ops_init(ops);
+
+	ret = -ENOMEM;
 	iter = kzalloc_obj(*iter);
 	if (!iter)
 		goto out;
@@ -4788,21 +4808,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 static int
 ftrace_filter_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops,
-			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
-			inode, file);
+	return ftrace_regex_open(tr, NULL,
+				 FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
+				 inode, file);
 }
 
 static int
 ftrace_notrace_open(struct inode *inode, struct file *file)
 {
-	struct ftrace_ops *ops = inode->i_private;
+	struct trace_array *tr = inode->i_private;
 
-	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
+	return ftrace_regex_open(tr, NULL, FTRACE_ITER_NOTRACE,
 				 inode, file);
 }
 
@@ -7492,15 +7510,15 @@ static const struct file_operations ftrace_graph_notrace_fops = {
 };
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent)
 {
 
 	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_filter_fops);
+			  tr, &ftrace_filter_fops);
 
 	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
-			  ops, &ftrace_notrace_fops);
+			  tr, &ftrace_notrace_fops);
 }
 
 /*
@@ -7525,7 +7543,6 @@ void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 {
-
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
@@ -7538,7 +7555,7 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("touched_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_touched_fops);
 
-	ftrace_create_filter_files(&global_ops, d_tracer);
+	ftrace_create_filter_files(NULL, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	trace_create_file("set_graph_function", TRACE_MODE_WRITE, d_tracer,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..3c111ca88e32 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1340,7 +1340,7 @@ extern void clear_ftrace_function_probes(struct trace_array *tr);
 int register_ftrace_command(struct ftrace_func_command *cmd);
 int unregister_ftrace_command(struct ftrace_func_command *cmd);
 
-void ftrace_create_filter_files(struct ftrace_ops *ops,
+void ftrace_create_filter_files(struct trace_array *tr,
 				struct dentry *parent);
 void ftrace_destroy_filter_files(struct ftrace_ops *ops);
 
@@ -1363,11 +1363,12 @@ static inline void clear_ftrace_function_probes(struct trace_array *tr)
 {
 }
 
+static inline void ftrace_create_filter_files(struct trace_array *tr,
+					      struct dentry *parent) { }
 /*
  * The ops parameter passed in is usually undefined.
  * This must be a macro.
  */
-#define ftrace_create_filter_files(ops, parent) do { } while (0)
 #define ftrace_destroy_filter_files(ops) do { } while (0)
 #endif /* CONFIG_FUNCTION_TRACER && CONFIG_DYNAMIC_FTRACE */
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index cd37f2013758..c879d43a5fbb 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -101,7 +101,7 @@ int ftrace_create_function_files(struct trace_array *tr,
 		return ret;
 	}
 
-	ftrace_create_filter_files(tr->ops, parent);
+	ftrace_create_filter_files(tr, parent);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 0aa2514a6593..e7f4e523587d 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -499,7 +499,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 	struct ftrace_ops *ops = inode->i_private;
 
 	/* Checks for tracefs lockdown */
-	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
+	return ftrace_regex_open(NULL, ops, FTRACE_ITER_FILTER,
 				 inode, file);
 }
 
-- 
2.53.0


