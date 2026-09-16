Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3564C6533
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577345; cv=none; b=j33gge2qhSlOe3+yc23CU3Dafngw5LboAsl2tkPr6YHzXCxAaMMfSr1kFNtVlvZ/OYHj/vzc1pGfv82Kyxs4b8OH5RwnZg0ONhx5z3OeaCKSqen4fAGvhibHUtUWQH0hWHF9VhB+XuPUP5meJA5HAqVPjXC1Li01XAdmEKZK/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577345; c=relaxed/simple;
	bh=pG+8Llh9870swJA78VNf/KjGf53JnclKfqU0zRXtrO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUYA2FKgSoaJIw4umukzSk/XmV8MWCuf5VPyv3ZN1sqg44CYgJdAq/7JKjRQy1LSs+lnvsywwth9ZSlkcv9u8RAyoG6ZbqtsKh+GHVQ7s0XvOcaMh8jpfTX9G+qpUrDYez05hJJTUyRPwGXlF2N1zVkng3VIjNY98kzeOlysrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btwSmeCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btwSmeCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3325B1F0089C;
	Wed, 16 Sep 2026 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577337;
	bh=Uir23+1U3Xwrhu4TisB3IsYpmwbrOSazPUKU+JJZ7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=btwSmeCmcMRF6UfiUSA/4ykbz1Iv2ixbI+Gk02kwvAdWcOq3ElsJrzOglTVDKcNXd
	 XXefhpIQcNSLGZKyxccr+UiJAaTdWPrIftMHQ88OPIEPRnddnpVnNbNQYE/3q7hFoS
	 xy/5lbt9i+pdZSBdWfMa63IM02IaiUumDtnLFpbF2UDAPEZ8sEf3BuX/e715ECMsvJ
	 QGe/fMgo0ABc1dAoErrSXaLFyIY1ZaxWcmcg7axq+ExJ/sqss9imc4shNqVfda/Ery
	 qeEWxqrD+37G6w/dfICLOqf9Fwd/iKUhDeeM8KUtrChEJGXZ1xpoeGc2xpGULW0HTe
	 R9F79IvF+JUjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] tracing: Merge struct event_trigger_ops into struct event_command
Date: Wed, 16 Sep 2026 12:48:52 -0400
Message-ID: <20260916164854.543620-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164854.543620-1-sashal@kernel.org>
References: <2026091626-postnasal-annotate-b622@gregkh>
 <20260916164854.543620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit b052d70f7c9c156409a70e65c10d83b5650e7e78 ]

Now that there's pretty much a one to one mapping between the struct
event_trigger_ops and struct event_command, there's no reason to have two
different structures. Merge the function pointers of event_trigger_ops
into event_command.

There's one exception in trace_events_hist.c for the
event_hist_trigger_named_ops. This has special logic for the init and free
function pointers for "named histograms". In this case, allocate the
cmd_ops of the event_trigger_data and set it to the proper init and free
functions, which are used to initialize and free the event_trigger_data
respectively. Have the free function and the init function (on failure)
free the cmd_ops of the data element.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251125200932.446322765@kernel.org
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

[6.6 dependency adaptation]
The stable branch still selects separate counted trigger callbacks through
get_trigger_ops(), and lacks the upstream count_func/data_ops_trigger
refactoring. Merge the callbacks into event_command while retaining the
existing counted callbacks as count_trigger. Select them in the existing
trigger dispatch functions using EVENT_TRIGGER_FL_COUNT, preserving the
old parameter-based selection and count semantics without adding functions.
Remove the obsolete get_trigger_ops callbacks and event_trigger_ops tables,
including the eprobe selector left behind by the automatic merge.

For shared named histograms, retain the dependency's per-trigger copy of
cmd_ops and its specialized init/free callbacks. Mark the copy as owned by
the trigger and release it in trigger_data_free(), instead of adding frees
to named init/free. This covers normal teardown and parse error cleanup,
including clock validation failure before init after the target is applied.

Keep hist_register_trigger() in the form expected by 6ede78d0563a so that
its clock-before-registration change applies directly. The target itself
is not included in this dependency.

Stable-dep-of: 6ede78d0563a ("tracing: Set the trace clock before registering the histogram trigger")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h                | 120 ++++++---------
 kernel/trace/trace_eprobe.c         |  19 +--
 kernel/trace/trace_events_hist.c    | 117 +++++---------
 kernel/trace/trace_events_trigger.c | 230 ++++++++--------------------
 4 files changed, 157 insertions(+), 329 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index cb3b9e3eabead..6c19b3eac7766 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1608,13 +1608,14 @@ extern void clear_event_triggers(struct trace_array *tr);
 
 enum {
 	EVENT_TRIGGER_FL_PROBE		= BIT(0),
+	EVENT_TRIGGER_FL_COUNT		= BIT(1),
+	EVENT_TRIGGER_FL_CMD_ALLOC	= BIT(2),
 };
 
 struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1701,64 +1702,6 @@ extern void event_trigger_unregister(struct event_command *cmd_ops,
 extern void event_file_get(struct trace_event_file *file);
 extern void event_file_put(struct trace_event_file *file);
 
-/**
- * struct event_trigger_ops - callbacks for trace event triggers
- *
- * The methods in this structure provide per-event trigger hooks for
- * various trigger operations.
- *
- * The @init and @free methods are used during trigger setup and
- * teardown, typically called from an event_command's @parse()
- * function implementation.
- *
- * The @print method is used to print the trigger spec.
- *
- * The @trigger method is the function that actually implements the
- * trigger and is called in the context of the triggering event
- * whenever that event occurs.
- *
- * All the methods below, except for @init() and @free(), must be
- * implemented.
- *
- * @trigger: The trigger 'probe' function called when the triggering
- *	event occurs.  The data passed into this callback is the data
- *	that was supplied to the event_command @reg() function that
- *	registered the trigger (see struct event_command) along with
- *	the trace record, rec.
- *
- * @init: An optional initialization function called for the trigger
- *	when the trigger is registered (via the event_command reg()
- *	function).  This can be used to perform per-trigger
- *	initialization such as incrementing a per-trigger reference
- *	count, for instance.  This is usually implemented by the
- *	generic utility function @event_trigger_init() (see
- *	trace_event_triggers.c).
- *
- * @free: An optional de-initialization function called for the
- *	trigger when the trigger is unregistered (via the
- *	event_command @reg() function).  This can be used to perform
- *	per-trigger de-initialization such as decrementing a
- *	per-trigger reference count and freeing corresponding trigger
- *	data, for instance.  This is usually implemented by the
- *	generic utility function @event_trigger_free() (see
- *	trace_event_triggers.c).
- *
- * @print: The callback function invoked to have the trigger print
- *	itself.  This is usually implemented by a wrapper function
- *	that calls the generic utility function @event_trigger_print()
- *	(see trace_event_triggers.c).
- */
-struct event_trigger_ops {
-	void			(*trigger)(struct event_trigger_data *data,
-					   struct trace_buffer *buffer,
-					   void *rec,
-					   struct ring_buffer_event *rbe);
-	int			(*init)(struct event_trigger_data *data);
-	void			(*free)(struct event_trigger_data *data);
-	int			(*print)(struct seq_file *m,
-					 struct event_trigger_data *data);
-};
-
 /**
  * struct event_command - callbacks and data members for event commands
  *
@@ -1808,7 +1751,7 @@ struct event_trigger_ops {
  *
  * @reg: Adds the trigger to the list of triggers associated with the
  *	event, and enables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @init() function).
+ *	initializing it (via the event_command @init() function).
  *	This is also where commands can use the @trigger_type value to
  *	make the decision as to whether or not multiple instances of
  *	the trigger should be allowed.  This is usually implemented by
@@ -1817,7 +1760,7 @@ struct event_trigger_ops {
  *
  * @unreg: Removes the trigger from the list of triggers associated
  *	with the event, and disables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @free() function).
+ *	initializing it (via the event_command @free() function).
  *	This is usually implemented by the generic utility function
  *	@unregister_trigger() (see trace_event_triggers.c).
  *
@@ -1831,12 +1774,40 @@ struct event_trigger_ops {
  *	ignored.  This is usually implemented by the generic utility
  *	function @set_trigger_filter() (see trace_event_triggers.c).
  *
- * @get_trigger_ops: The callback function invoked to retrieve the
- *	event_trigger_ops implementation associated with the command.
- *	This callback function allows a single event_command to
- *	support multiple trigger implementations via different sets of
- *	event_trigger_ops, depending on the value of the @param
- *	string.
+ * All the methods below, except for @count_trigger(), @init() and
+ * @free(), must be implemented.
+ *
+ * @trigger: The trigger 'probe' function called when the triggering
+ *	event occurs.  The data passed into this callback is the data
+ *	that was supplied to the event_command @reg() function that
+ *	registered the trigger (see struct event_command) along with
+ *	the trace record, rec.
+ *
+ * @count_trigger: If defined and a numeric parameter is passed to the
+ *	trigger, this function is called instead of @trigger. It handles
+ *	the count and invokes the trigger when appropriate.
+ *
+ * @init: An optional initialization function called for the trigger
+ *	when the trigger is registered (via the event_command reg()
+ *	function).  This can be used to perform per-trigger
+ *	initialization such as incrementing a per-trigger reference
+ *	count, for instance.  This is usually implemented by the
+ *	generic utility function @event_trigger_init() (see
+ *	trace_event_triggers.c).
+ *
+ * @free: An optional de-initialization function called for the
+ *	trigger when the trigger is unregistered (via the
+ *	event_command @reg() function).  This can be used to perform
+ *	per-trigger de-initialization such as decrementing a
+ *	per-trigger reference count and freeing corresponding trigger
+ *	data, for instance.  This is usually implemented by the
+ *	generic utility function @event_trigger_free() (see
+ *	trace_event_triggers.c).
+ *
+ * @print: The callback function invoked to have the trigger print
+ *	itself.  This is usually implemented by a wrapper function
+ *	that calls the generic utility function @event_trigger_print()
+ *	(see trace_event_triggers.c).
  */
 struct event_command {
 	struct list_head	list;
@@ -1857,7 +1828,18 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	void			(*trigger)(struct event_trigger_data *data,
+					   struct trace_buffer *buffer,
+					   void *rec,
+					   struct ring_buffer_event *rbe);
+	void			(*count_trigger)(struct event_trigger_data *data,
+					 struct trace_buffer *buffer,
+					 void *rec,
+					 struct ring_buffer_event *rbe);
+	int			(*init)(struct event_trigger_data *data);
+	void			(*free)(struct event_trigger_data *data);
+	int			(*print)(struct seq_file *m,
+					 struct event_trigger_data *data);
 };
 
 /**
@@ -1878,7 +1860,7 @@ struct event_command {
  *	either committed or discarded.  At that point, if any commands
  *	have deferred their triggers, those commands are finally
  *	invoked following the close of the current event.  In other
- *	words, if the event_trigger_ops @func() probe implementation
+ *	words, if the event_command @func() probe implementation
  *	itself logs to the trace buffer, this flag should be set,
  *	otherwise it can be left unspecified.
  *
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c7763d67741cc..f35b6055aaec8 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -479,13 +479,6 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 	__eprobe_trace_func(edata, rec);
 }
 
-static const struct event_trigger_ops eprobe_trigger_ops = {
-	.trigger		= eprobe_trigger_func,
-	.print			= eprobe_trigger_print,
-	.init			= eprobe_trigger_init,
-	.free			= eprobe_trigger_free,
-};
-
 static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
 				    struct trace_event_file *file,
 				    char *glob, char *cmd,
@@ -508,12 +501,6 @@ static void eprobe_trigger_unreg_func(char *glob,
 
 }
 
-static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
-							      char *param)
-{
-	return &eprobe_trigger_ops;
-}
-
 static struct event_command event_trigger_cmd = {
 	.name			= "eprobe",
 	.trigger_type		= ETT_EVENT_EPROBE,
@@ -522,8 +509,11 @@ static struct event_command event_trigger_cmd = {
 	.reg			= eprobe_trigger_reg_func,
 	.unreg			= eprobe_trigger_unreg_func,
 	.unreg_all		= NULL,
-	.get_trigger_ops	= eprobe_trigger_get_ops,
 	.set_filter		= NULL,
+	.trigger		= eprobe_trigger_func,
+	.print			= eprobe_trigger_print,
+	.init			= eprobe_trigger_init,
+	.free			= eprobe_trigger_free,
 };
 
 static struct event_trigger_data *
@@ -543,7 +533,6 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 
 	trigger->flags = EVENT_TRIGGER_FL_PROBE;
 	trigger->count = -1;
-	trigger->ops = &eprobe_trigger_ops;
 
 	/*
 	 * EVENT PROBE triggers are not registered as commands with
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ae70e3007fe10..08e1027a16b0a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5704,7 +5704,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -6026,7 +6026,7 @@ static void hist_trigger_debug_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -6334,13 +6334,6 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	free_hist_pad();
 }
 
-static const struct event_trigger_ops event_hist_trigger_ops = {
-	.trigger		= event_hist_trigger,
-	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_init,
-	.free			= event_hist_trigger_free,
-};
-
 static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
 	data->ref++;
@@ -6364,19 +6357,6 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 	}
 }
 
-static const struct event_trigger_ops event_hist_trigger_named_ops = {
-	.trigger		= event_hist_trigger,
-	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_named_init,
-	.free			= event_hist_trigger_named_free,
-};
-
-static const struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
-								  char *param)
-{
-	return &event_hist_trigger_ops;
-}
-
 static void hist_clear(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -6570,13 +6550,25 @@ static int hist_register_trigger(char *glob,
 		data->paused = true;
 
 	if (named_data) {
+		struct event_command *cmd_ops;
+
 		data->private_data = named_data->private_data;
 		set_named_trigger_data(data, named_data);
-		data->ops = &event_hist_trigger_named_ops;
+		/* Copy the command ops and update some of the functions */
+		cmd_ops = kmalloc(sizeof(*cmd_ops), GFP_KERNEL);
+		if (!cmd_ops) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		*cmd_ops = *data->cmd_ops;
+		cmd_ops->init = event_hist_trigger_named_init;
+		cmd_ops->free = event_hist_trigger_named_free;
+		data->flags |= EVENT_TRIGGER_FL_CMD_ALLOC;
+		data->cmd_ops = cmd_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6692,8 +6684,8 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->ops->free)
-		test->ops->free(test);
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
@@ -6745,8 +6737,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
 				tracing_set_filter_buffering(file->tr, false);
-			if (test->ops->free)
-				test->ops->free(test);
+			if (test->cmd_ops->free)
+				test->cmd_ops->free(test);
 		}
 	}
 }
@@ -6922,8 +6914,11 @@ static struct event_command trigger_hist_cmd = {
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
 	.unreg_all		= hist_unreg_all,
-	.get_trigger_ops	= event_hist_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_hist_trigger,
+	.print			= event_hist_trigger_print,
+	.init			= event_hist_trigger_init,
+	.free			= event_hist_trigger_free,
 };
 
 __init int register_trigger_hist_cmd(void)
@@ -6969,52 +6964,6 @@ hist_enable_count_trigger(struct event_trigger_data *data,
 	hist_enable_trigger(data, buffer, rec, event);
 }
 
-static const struct event_trigger_ops hist_enable_trigger_ops = {
-	.trigger		= hist_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops hist_enable_count_trigger_ops = {
-	.trigger		= hist_enable_count_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops hist_disable_trigger_ops = {
-	.trigger		= hist_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops hist_disable_count_trigger_ops = {
-	.trigger		= hist_enable_count_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops *
-hist_enable_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-	bool enable;
-
-	enable = (strcmp(cmd, ENABLE_HIST_STR) == 0);
-
-	if (enable)
-		ops = param ? &hist_enable_count_trigger_ops :
-			&hist_enable_trigger_ops;
-	else
-		ops = param ? &hist_disable_count_trigger_ops :
-			&hist_disable_trigger_ops;
-
-	return ops;
-}
-
 static void hist_enable_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
@@ -7024,8 +6973,8 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			update_cond_flag(file);
 			trace_event_trigger_enable_disable(file, 0);
-			if (test->ops->free)
-				test->ops->free(test);
+			if (test->cmd_ops->free)
+				test->cmd_ops->free(test);
 		}
 	}
 }
@@ -7037,8 +6986,12 @@ static struct event_command trigger_hist_enable_cmd = {
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_trigger		= hist_enable_count_trigger,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_hist_disable_cmd = {
@@ -7048,8 +7001,12 @@ static struct event_command trigger_hist_disable_cmd = {
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_trigger		= hist_enable_count_trigger,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_hist_enable_disable_cmds(void)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 48db99b7d61cb..de0e2075d3627 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -28,6 +28,8 @@ void trigger_data_free(struct event_trigger_data *data)
 	/* make sure current triggers exit before free */
 	tracepoint_synchronize_unregister();
 
+	if (data->flags & EVENT_TRIGGER_FL_CMD_ALLOC)
+		kfree(data->cmd_ops);
 	kfree(data);
 }
 
@@ -73,7 +75,10 @@ event_triggers_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->trigger(data, buffer, rec, event);
+			if (data->flags & EVENT_TRIGGER_FL_COUNT)
+				data->cmd_ops->count_trigger(data, buffer, rec, event);
+			else
+				data->cmd_ops->trigger(data, buffer, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -83,7 +88,10 @@ event_triggers_call(struct trace_event_file *file,
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->trigger(data, buffer, rec, event);
+		if (data->flags & EVENT_TRIGGER_FL_COUNT)
+			data->cmd_ops->count_trigger(data, buffer, rec, event);
+		else
+			data->cmd_ops->trigger(data, buffer, rec, event);
 	}
 	return tt;
 }
@@ -124,8 +132,12 @@ event_triggers_post_call(struct trace_event_file *file,
 	list_for_each_entry_rcu(data, &file->triggers, list) {
 		if (data->paused)
 			continue;
-		if (data->cmd_ops->trigger_type & tt)
-			data->ops->trigger(data, NULL, NULL, NULL);
+		if (data->cmd_ops->trigger_type & tt) {
+			if (data->flags & EVENT_TRIGGER_FL_COUNT)
+				data->cmd_ops->count_trigger(data, NULL, NULL, NULL);
+			else
+				data->cmd_ops->trigger(data, NULL, NULL, NULL);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -194,7 +206,7 @@ static int trigger_show(struct seq_file *m, void *v)
 	}
 
 	data = list_entry(v, struct event_trigger_data, list);
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 
 	return 0;
 }
@@ -402,7 +414,7 @@ __init int unregister_event_command(struct event_command *cmd)
 }
 
 /**
- * event_trigger_print - Generic event_trigger_ops @print implementation
+ * event_trigger_print - Generic event_command @print implementation
  * @name: The name of the event trigger
  * @m: The seq_file being printed to
  * @data: Trigger-specific data
@@ -437,7 +449,7 @@ event_trigger_print(const char *name, struct seq_file *m,
 }
 
 /**
- * event_trigger_init - Generic event_trigger_ops @init implementation
+ * event_trigger_init - Generic event_command @init implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -454,7 +466,7 @@ int event_trigger_init(struct event_trigger_data *data)
 }
 
 /**
- * event_trigger_free - Generic event_trigger_ops @free implementation
+ * event_trigger_free - Generic event_command @free implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -516,8 +528,8 @@ clear_event_triggers(struct trace_array *tr)
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
-			if (data->ops->free)
-				data->ops->free(data);
+			if (data->cmd_ops->free)
+				data->cmd_ops->free(data);
 		}
 	}
 }
@@ -582,8 +594,8 @@ static int register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -629,8 +641,8 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 /*
@@ -819,9 +831,9 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
  * @private_data: User data to associate with the event trigger
  *
  * Allocate an event_trigger_data instance and initialize it.  The
- * @cmd_ops are used along with the @cmd and @param to get the
- * trigger_ops to assign to the event_trigger_data.  @private_data can
- * also be passed in and associated with the event_trigger_data.
+ * @cmd_ops provide the callbacks for the event_trigger_data.  @param
+ * selects the counted callback when the command supports one.
+ * @private_data can also be associated with the event_trigger_data.
  *
  * Use trigger_data_free() to free an event_trigger_data object.
  *
@@ -833,18 +845,16 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	const struct event_trigger_ops *trigger_ops;
-
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
 	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
 	if (!trigger_data)
 		return NULL;
 
 	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
 	trigger_data->cmd_ops = cmd_ops;
 	trigger_data->private_data = private_data;
+	if (param && cmd_ops->count_trigger)
+		trigger_data->flags |= EVENT_TRIGGER_FL_COUNT;
 
 	INIT_LIST_HEAD(&trigger_data->list);
 	INIT_LIST_HEAD(&trigger_data->named_list);
@@ -1375,58 +1385,18 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops traceon_trigger_ops = {
-	.trigger		= traceon_trigger,
-	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops traceon_count_trigger_ops = {
-	.trigger		= traceon_count_trigger,
-	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops traceoff_trigger_ops = {
-	.trigger		= traceoff_trigger,
-	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops traceoff_count_trigger_ops = {
-	.trigger		= traceoff_count_trigger,
-	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-onoff_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-
-	/* we register both traceon and traceoff to this callback */
-	if (strcmp(cmd, "traceon") == 0)
-		ops = param ? &traceon_count_trigger_ops :
-			&traceon_trigger_ops;
-	else
-		ops = param ? &traceoff_count_trigger_ops :
-			&traceoff_trigger_ops;
-
-	return ops;
-}
-
 static struct event_command trigger_traceon_cmd = {
 	.name			= "traceon",
 	.trigger_type		= ETT_TRACE_ONOFF,
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= traceon_trigger,
+	.count_trigger		= traceon_count_trigger,
+	.print			= traceon_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static struct event_command trigger_traceoff_cmd = {
@@ -1436,8 +1406,12 @@ static struct event_command trigger_traceoff_cmd = {
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= traceoff_trigger,
+	.count_trigger		= traceoff_count_trigger,
+	.print			= traceoff_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 #ifdef CONFIG_TRACER_SNAPSHOT
@@ -1488,34 +1462,18 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops snapshot_trigger_ops = {
-	.trigger		= snapshot_trigger,
-	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops snapshot_count_trigger_ops = {
-	.trigger		= snapshot_count_trigger,
-	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-snapshot_get_trigger_ops(char *cmd, char *param)
-{
-	return param ? &snapshot_count_trigger_ops : &snapshot_trigger_ops;
-}
-
 static struct event_command trigger_snapshot_cmd = {
 	.name			= "snapshot",
 	.trigger_type		= ETT_SNAPSHOT,
 	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= snapshot_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= snapshot_trigger,
+	.count_trigger		= snapshot_count_trigger,
+	.print			= snapshot_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_snapshot_cmd(void)
@@ -1583,26 +1541,6 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static const struct event_trigger_ops stacktrace_trigger_ops = {
-	.trigger		= stacktrace_trigger,
-	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops stacktrace_count_trigger_ops = {
-	.trigger		= stacktrace_count_trigger,
-	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
-};
-
-static const struct event_trigger_ops *
-stacktrace_get_trigger_ops(char *cmd, char *param)
-{
-	return param ? &stacktrace_count_trigger_ops : &stacktrace_trigger_ops;
-}
-
 static struct event_command trigger_stacktrace_cmd = {
 	.name			= "stacktrace",
 	.trigger_type		= ETT_STACKTRACE,
@@ -1610,8 +1548,12 @@ static struct event_command trigger_stacktrace_cmd = {
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= stacktrace_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= stacktrace_trigger,
+	.count_trigger		= stacktrace_count_trigger,
+	.print			= stacktrace_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_stacktrace_cmd(void)
@@ -1708,34 +1650,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static const struct event_trigger_ops event_enable_trigger_ops = {
-	.trigger		= event_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_enable_count_trigger_ops = {
-	.trigger		= event_enable_count_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_disable_trigger_ops = {
-	.trigger		= event_enable_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
-static const struct event_trigger_ops event_disable_count_trigger_ops = {
-	.trigger		= event_enable_count_trigger,
-	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
-};
-
 int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       struct trace_event_file *file,
 			       char *glob, char *cmd, char *param_and_filter)
@@ -1867,8 +1781,8 @@ int event_enable_register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1909,30 +1823,8 @@ void event_enable_unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
-}
-
-static const struct event_trigger_ops *
-event_enable_get_trigger_ops(char *cmd, char *param)
-{
-	const struct event_trigger_ops *ops;
-	bool enable;
-
-#ifdef CONFIG_HIST_TRIGGERS
-	enable = ((strcmp(cmd, ENABLE_EVENT_STR) == 0) ||
-		  (strcmp(cmd, ENABLE_HIST_STR) == 0));
-#else
-	enable = strcmp(cmd, ENABLE_EVENT_STR) == 0;
-#endif
-	if (enable)
-		ops = param ? &event_enable_count_trigger_ops :
-			&event_enable_trigger_ops;
-	else
-		ops = param ? &event_disable_count_trigger_ops :
-			&event_disable_trigger_ops;
-
-	return ops;
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 static struct event_command trigger_enable_cmd = {
@@ -1941,8 +1833,12 @@ static struct event_command trigger_enable_cmd = {
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_trigger		= event_enable_count_trigger,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_disable_cmd = {
@@ -1951,8 +1847,12 @@ static struct event_command trigger_disable_cmd = {
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_trigger		= event_enable_count_trigger,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_enable_disable_cmds(void)
-- 
2.53.0

