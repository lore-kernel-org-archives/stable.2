Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE942467E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591685; cv=none; b=cgvnUER07QE0P6lR3W5D+SN6QtFyu9bO7UCYraJIWJ+ta3xWHLRDR/grbGkF4fBUqfVAcrY9zCMaPcvUERoH803GQ/UdgRK4o5+O9Z2lQkBZA0sS3r/lL5nRzhPWYf3Ayy/29oa0xWFKCsU0VEHlf7SH4TtkZlTgvK+mqN5A8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591685; c=relaxed/simple;
	bh=09RT1g0Ee/8ayCagxmghEFPK5VCV9C5gIQ7O7pAgppk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeJu4lcp+7Y8srzzSliGeNUt8B+uJnQ0JufRRbqaR9YeXriK9gmmK7dR6NewbDxKv1sLB67hk7wkrYCKTYU7mOjBW4LssRcBFso/nbqrISSetkUXTPovLk0OcFWIwDLnQdzCAVpjg+NUE4fVRXqDjwv9vibIFE7Y0iWNP/xJeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPXo4ct/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPXo4ct/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A447B1F00899;
	Wed, 16 Sep 2026 20:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591672;
	bh=qHk+xwIZVx5S2u4iBDtpy3YB5mAsM7vb0Lq3gFF1IiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPXo4ct/sfrQCrCql1zVUpz4FfqMNDdNj1P920wlBUN0smw9RsKe3M+ci+3pUjtgN
	 J+Oi64W7/NmFqhR6im2bh+HWP0xrmKPWRhQmYW5CDkXrVJrYEWMBFME6qgxIj/68xp
	 fTUtlHhdHBWi6XHsdxSdDLy0y7v3Ty7NuRA8CsAWvQHO/vezioVNKiRN1mOfX2LrJ2
	 PPID7hDNjMlrvuqRp3OppkIGvcMs3DkbdUVOHNALuH6sRqupFOpMpEcwfIOnrA2MPr
	 y/QMV53DWbxMFVT7phNwicgaElccIImxna4Z/10MXcqij0xH0/uIfWEFwu7mX2a927
	 n/ZRdtCd4buhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] tracing: Remove get_trigger_ops() and add count_func() from trigger ops
Date: Wed, 16 Sep 2026 16:47:48 -0400
Message-ID: <20260916204749.2726383-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916204749.2726383-1-sashal@kernel.org>
References: <2026091604-putdown-resort-2cec@gregkh>
 <20260916204749.2726383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit bdafb4d4cb3bb18b29517eaae09fb49d25f854f0 ]

The struct event_command has a callback function called get_trigger_ops().
This callback returns the "trigger_ops" to use for the trigger. These ops
define the trigger function, how to init the trigger, how to print the
trigger and how to free it.

The only reason there's a callback function to get these ops is because
some triggers have two types of operations. One is an "always on"
operation, and the other is a "count down" operation. If a user passes in
a parameter to say how many times the trigger should execute. For example:

  echo stacktrace:5 > events/kmem/kmem_cache_alloc/trigger

It will trigger the stacktrace for the first 5 times the kmem_cache_alloc
event is hit.

Instead of having two different trigger_ops since the only difference
between them is the tigger itself (the print, init and free functions are
all the same), just use a single ops that the event_command points to and
add a function field to the trigger_ops to have a count_func.

When a trigger is added to an event, if there's a count attached to it and
the trigger ops has the count_func field, the data allocated to represent
this trigger will have a new flag set called COUNT.

Then when the trigger executes, it will check if the COUNT data flag is
set, and if so, it will call the ops count_func(). If that returns false,
it returns without executing the trigger.

This removes the need for duplicate event_trigger_ops structures.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251125200932.274566147@kernel.org
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Stable adaptation for 92383cef66791a0c63a2f27755cadbdb2fbf270b:

Keep the stable snapshot trigger's unregister_trigger callback; this tree
has no snapshot reference counting or unregister_snapshot_trigger helper.
Retain the stable explicit locking and existing trigger init semantics.

Fold in the callback migration from b052d70f7c9c so the target can use
cmd_ops->free directly, including the distinct lifetime of copied command
ops for shared named histograms. The stable histogram initializer cannot
fail, so its upstream hist_pad allocation error handling is unnecessary.
Select the histogram clock before allocating copied command ops or
publishing a named trigger, and enable filter buffering after init, so a
clock selection failure cannot strand those resources.

Also drop the redundant event_trigger_reset_filter call as in
a4e0ea0e10a26: trigger_data_free already performs that cleanup. This
provides the target's out_free context without changing its patch.

No functions beyond those already introduced by bdafb4d4cb3b are added.
The target fix itself is left unapplied.

Stable-dep-of: 92383cef6679 ("tracing: Undo the registration when enabling the histogram trigger fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h                | 124 +++++-----
 kernel/trace/trace_eprobe.c         |  19 +-
 kernel/trace/trace_events_hist.c    | 156 ++++---------
 kernel/trace/trace_events_trigger.c | 344 ++++++++++------------------
 4 files changed, 232 insertions(+), 411 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2002d48c8a931..b09c2645ad21e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1551,13 +1551,13 @@ extern void clear_event_triggers(struct trace_array *tr);
 
 enum {
 	EVENT_TRIGGER_FL_PROBE		= BIT(0),
+	EVENT_TRIGGER_FL_COUNT		= BIT(1),
 };
 
 struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1582,6 +1582,10 @@ struct enable_trigger_data {
 	bool				hist;
 };
 
+bool event_trigger_count(struct event_trigger_data *data,
+			 struct trace_buffer *buffer,  void *rec,
+			 struct ring_buffer_event *event);
+
 extern int event_enable_trigger_print(struct seq_file *m,
 				      struct event_trigger_data *data);
 extern void event_enable_trigger_free(struct event_trigger_data *data);
@@ -1644,64 +1648,6 @@ extern void event_trigger_unregister(struct event_command *cmd_ops,
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
@@ -1751,7 +1697,7 @@ struct event_trigger_ops {
  *
  * @reg: Adds the trigger to the list of triggers associated with the
  *	event, and enables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @init() function).
+ *	initializing it (via the event_command @init() function).
  *	This is also where commands can use the @trigger_type value to
  *	make the decision as to whether or not multiple instances of
  *	the trigger should be allowed.  This is usually implemented by
@@ -1760,7 +1706,7 @@ struct event_trigger_ops {
  *
  * @unreg: Removes the trigger from the list of triggers associated
  *	with the event, and disables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @free() function).
+ *	initializing it (via the event_command @free() function).
  *	This is usually implemented by the generic utility function
  *	@unregister_trigger() (see trace_event_triggers.c).
  *
@@ -1774,12 +1720,41 @@ struct event_trigger_ops {
  *	ignored.  This is usually implemented by the generic utility
  *	function @set_trigger_filter() (see trace_event_triggers.c).
  *
- * @get_trigger_ops: The callback function invoked to retrieve the
- *	event_trigger_ops implementation associated with the command.
- *	This callback function allows a single event_command to
- *	support multiple trigger implementations via different sets of
- *	event_trigger_ops, depending on the value of the @param
- *	string.
+ * All the methods below, except for @init() and @free(), must be
+ * implemented.
+ *
+ * @trigger: The trigger 'probe' function called when the triggering
+ *	event occurs.  The data passed into this callback is the data
+ *	that was supplied to the event_command @reg() function that
+ *	registered the trigger (see struct event_command) along with
+ *	the trace record, rec.
+ *
+ * @count_func: If defined and a numeric parameter is passed to the
+ *	trigger, then this function will be called before @trigger
+ *	is called. If this function returns false, then @trigger is not
+ *	executed.
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
@@ -1800,7 +1775,18 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	void			(*trigger)(struct event_trigger_data *data,
+					   struct trace_buffer *buffer,
+					   void *rec,
+					   struct ring_buffer_event *rbe);
+	bool			(*count_func)(struct event_trigger_data *data,
+					      struct trace_buffer *buffer,
+					      void *rec,
+					      struct ring_buffer_event *rbe);
+	int			(*init)(struct event_trigger_data *data);
+	void			(*free)(struct event_trigger_data *data);
+	int			(*print)(struct seq_file *m,
+					 struct event_trigger_data *data);
 };
 
 /**
@@ -1821,7 +1807,7 @@ struct event_command {
  *	either committed or discarded.  At that point, if any commands
  *	have deferred their triggers, those commands are finally
  *	invoked following the close of the current event.  In other
- *	words, if the event_trigger_ops @func() probe implementation
+ *	words, if the event_command @func() probe implementation
  *	itself logs to the trace buffer, this flag should be set,
  *	otherwise it can be left unspecified.
  *
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index d55dc47b6fd63..d2a4ef7472375 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -574,13 +574,6 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
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
@@ -603,12 +596,6 @@ static void eprobe_trigger_unreg_func(char *glob,
 
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
@@ -617,8 +604,11 @@ static struct event_command event_trigger_cmd = {
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
@@ -638,7 +628,6 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
 
 	trigger->flags = EVENT_TRIGGER_FL_PROBE;
 	trigger->count = -1;
-	trigger->ops = &eprobe_trigger_ops;
 
 	/*
 	 * EVENT PROBE triggers are not registered as commands with
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c29ffde262e3e..311d7f68278d7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5490,7 +5490,7 @@ static void hist_trigger_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -5724,7 +5724,7 @@ static void hist_trigger_debug_show(struct seq_file *m,
 		seq_puts(m, "\n\n");
 
 	seq_puts(m, "# event histogram\n#\n# trigger info: ");
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
@@ -6020,13 +6020,6 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	}
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
@@ -6047,24 +6040,14 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 	data->ref--;
 	if (!data->ref) {
+		struct event_command *cmd_ops = data->cmd_ops;
+
 		del_named_trigger(data);
 		trigger_data_free(data);
+		kfree(cmd_ops);
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
@@ -6257,18 +6240,6 @@ static int hist_register_trigger(char *glob,
 	if (hist_data->attrs->pause)
 		data->paused = true;
 
-	if (named_data) {
-		data->private_data = named_data->private_data;
-		set_named_trigger_data(data, named_data);
-		data->ops = &event_hist_trigger_named_ops;
-	}
-
-	if (data->ops->init) {
-		ret = data->ops->init(data);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (hist_data->enable_timestamps) {
 		char *clock = hist_data->attrs->clock;
 
@@ -6277,10 +6248,34 @@ static int hist_register_trigger(char *glob,
 			hist_err(tr, HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
 			goto out;
 		}
+	}
 
-		tracing_set_filter_buffering(file->tr, true);
+	if (named_data) {
+		struct event_command *cmd_ops;
+
+		data->private_data = named_data->private_data;
+		set_named_trigger_data(data, named_data);
+		/* Copy the command ops and update some of the functions */
+		cmd_ops = kmalloc(sizeof(*cmd_ops), GFP_KERNEL);
+		if (!cmd_ops) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		*cmd_ops = *data->cmd_ops;
+		cmd_ops->init = event_hist_trigger_named_init;
+		cmd_ops->free = event_hist_trigger_named_free;
+		data->cmd_ops = cmd_ops;
+	}
+
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
+		if (ret < 0)
+			goto out;
 	}
 
+	if (hist_data->enable_timestamps)
+		tracing_set_filter_buffering(file->tr, true);
+
 	if (named_data) {
 		remove_hist_vars(hist_data);
 		destroy_hist_data(hist_data);
@@ -6380,8 +6375,8 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->ops->free)
-		test->ops->free(test);
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
@@ -6433,8 +6428,8 @@ static void hist_unreg_all(struct trace_event_file *file)
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
@@ -6592,8 +6587,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
  out_free:
-	event_trigger_reset_filter(cmd_ops, trigger_data);
-
 	remove_hist_vars(hist_data);
 
 	trigger_data_free(trigger_data);
@@ -6610,8 +6603,11 @@ static struct event_command trigger_hist_cmd = {
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
@@ -6643,66 +6639,6 @@ hist_enable_trigger(struct event_trigger_data *data,
 	}
 }
 
-static void
-hist_enable_count_trigger(struct event_trigger_data *data,
-			  struct trace_buffer *buffer,  void *rec,
-			  struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	hist_enable_trigger(data, buffer, rec, event);
-}
-
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
@@ -6712,8 +6648,8 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
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
@@ -6725,8 +6661,12 @@ static struct event_command trigger_hist_enable_cmd = {
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_func		= event_trigger_count,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_hist_disable_cmd = {
@@ -6736,8 +6676,12 @@ static struct event_command trigger_hist_disable_cmd = {
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
 	.unreg_all		= hist_enable_unreg_all,
-	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= hist_enable_trigger,
+	.count_func		= event_trigger_count,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_hist_enable_disable_cmds(void)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index af319d2cf824c..35bfefe20425e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -31,6 +31,20 @@ void trigger_data_free(struct event_trigger_data *data)
 	kfree(data);
 }
 
+static inline void data_ops_trigger(struct event_trigger_data *data,
+				    struct trace_buffer *buffer,  void *rec,
+				    struct ring_buffer_event *event)
+{
+	const struct event_command *cmd_ops = data->cmd_ops;
+
+	if (data->flags & EVENT_TRIGGER_FL_COUNT) {
+		if (!cmd_ops->count_func(data, buffer, rec, event))
+			return;
+	}
+
+	cmd_ops->trigger(data, buffer, rec, event);
+}
+
 /**
  * event_triggers_call - Call triggers associated with a trace event
  * @file: The trace_event_file associated with the event
@@ -71,7 +85,7 @@ event_triggers_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->trigger(data, buffer, rec, event);
+			data_ops_trigger(data, buffer, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -81,7 +95,7 @@ event_triggers_call(struct trace_event_file *file,
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->trigger(data, buffer, rec, event);
+		data_ops_trigger(data, buffer, rec, event);
 	}
 	return tt;
 }
@@ -123,7 +137,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->trigger(data, NULL, NULL, NULL);
+			data_ops_trigger(data, NULL, NULL, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -192,7 +206,7 @@ static int trigger_show(struct seq_file *m, void *v)
 	}
 
 	data = list_entry(v, struct event_trigger_data, list);
-	data->ops->print(m, data);
+	data->cmd_ops->print(m, data);
 
 	return 0;
 }
@@ -400,7 +414,37 @@ __init int unregister_event_command(struct event_command *cmd)
 }
 
 /**
- * event_trigger_print - Generic event_trigger_ops @print implementation
+ * event_trigger_count - Optional count function for event triggers
+ * @data: Trigger-specific data
+ * @buffer: The ring buffer that the event is being written to
+ * @rec: The trace entry for the event, NULL for unconditional invocation
+ * @event: The event meta data in the ring buffer
+ *
+ * For triggers that can take a count parameter that doesn't do anything
+ * special, they can use this function to assign to their .count_func
+ * field.
+ *
+ * This simply does a count down of the @data->count field.
+ *
+ * If the @data->count is greater than zero, it will decrement it.
+ *
+ * Returns false if @data->count is zero, otherwise true.
+ */
+bool event_trigger_count(struct event_trigger_data *data,
+			 struct trace_buffer *buffer,  void *rec,
+			 struct ring_buffer_event *event)
+{
+	if (!data->count)
+		return false;
+
+	if (data->count != -1)
+		(data->count)--;
+
+	return true;
+}
+
+/**
+ * event_trigger_print - Generic event_command @print implementation
  * @name: The name of the event trigger
  * @m: The seq_file being printed to
  * @data: Trigger-specific data
@@ -435,7 +479,7 @@ event_trigger_print(const char *name, struct seq_file *m,
 }
 
 /**
- * event_trigger_init - Generic event_trigger_ops @init implementation
+ * event_trigger_init - Generic event_command @init implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -452,7 +496,7 @@ int event_trigger_init(struct event_trigger_data *data)
 }
 
 /**
- * event_trigger_free - Generic event_trigger_ops @free implementation
+ * event_trigger_free - Generic event_command @free implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -514,8 +558,8 @@ clear_event_triggers(struct trace_array *tr)
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
@@ -580,8 +624,8 @@ static int register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -627,8 +671,8 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 /*
@@ -817,9 +861,13 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
  * @private_data: User data to associate with the event trigger
  *
  * Allocate an event_trigger_data instance and initialize it.  The
- * @cmd_ops are used along with the @cmd and @param to get the
- * trigger_ops to assign to the event_trigger_data.  @private_data can
- * also be passed in and associated with the event_trigger_data.
+ * @cmd_ops defines how the trigger will operate. If @param is set,
+ * and @cmd_ops->count_func is non NULL, then the
+ * data->count is set to @param and before the trigger is executed, the
+ * @cmd_ops->count_func() is called. If that function returns
+ * false, the @cmd_ops->trigger() function will not be called.
+ * @private_data can also be passed in and associated with the
+ * event_trigger_data.
  *
  * Use trigger_data_free() to free an event_trigger_data object.
  *
@@ -831,18 +879,16 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
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
+	if (param && cmd_ops->count_func)
+		trigger_data->flags |= EVENT_TRIGGER_FL_COUNT;
 
 	INIT_LIST_HEAD(&trigger_data->list);
 	INIT_LIST_HEAD(&trigger_data->named_list);
@@ -1271,31 +1317,28 @@ traceon_trigger(struct event_trigger_data *data,
 	tracing_on();
 }
 
-static void
-traceon_count_trigger(struct event_trigger_data *data,
-		      struct trace_buffer *buffer, void *rec,
-		      struct ring_buffer_event *event)
+static bool
+traceon_count_func(struct event_trigger_data *data,
+		   struct trace_buffer *buffer, void *rec,
+		   struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
 
 	if (file) {
 		if (tracer_tracing_is_on(file->tr))
-			return;
+			return false;
 	} else {
 		if (tracing_is_on())
-			return;
+			return false;
 	}
 
 	if (!data->count)
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	if (file)
-		tracer_tracing_on(file->tr);
-	else
-		tracing_on();
+	return true;
 }
 
 static void
@@ -1319,31 +1362,28 @@ traceoff_trigger(struct event_trigger_data *data,
 	tracing_off();
 }
 
-static void
-traceoff_count_trigger(struct event_trigger_data *data,
-		       struct trace_buffer *buffer, void *rec,
-		       struct ring_buffer_event *event)
+static bool
+traceoff_count_func(struct event_trigger_data *data,
+		    struct trace_buffer *buffer, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
 
 	if (file) {
 		if (!tracer_tracing_is_on(file->tr))
-			return;
+			return false;
 	} else {
 		if (!tracing_is_on())
-			return;
+			return false;
 	}
 
 	if (!data->count)
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	if (file)
-		tracer_tracing_off(file->tr);
-	else
-		tracing_off();
+	return true;
 }
 
 static int
@@ -1360,58 +1400,18 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
+	.count_func		= traceon_count_func,
+	.print			= traceon_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static struct event_command trigger_traceoff_cmd = {
@@ -1421,8 +1421,12 @@ static struct event_command trigger_traceoff_cmd = {
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= traceoff_trigger,
+	.count_func		= traceoff_count_func,
+	.print			= traceoff_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 #ifdef CONFIG_TRACER_SNAPSHOT
@@ -1439,20 +1443,6 @@ snapshot_trigger(struct event_trigger_data *data,
 		tracing_snapshot();
 }
 
-static void
-snapshot_count_trigger(struct event_trigger_data *data,
-		       struct trace_buffer *buffer, void *rec,
-		       struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	snapshot_trigger(data, buffer, rec, event);
-}
-
 static int
 register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
@@ -1473,34 +1463,18 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
+	.count_func		= event_trigger_count,
+	.print			= snapshot_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_snapshot_cmd(void)
@@ -1547,20 +1521,6 @@ stacktrace_trigger(struct event_trigger_data *data,
 		trace_dump_stack(STACK_SKIP);
 }
 
-static void
-stacktrace_count_trigger(struct event_trigger_data *data,
-			 struct trace_buffer *buffer, void *rec,
-			 struct ring_buffer_event *event)
-{
-	if (!data->count)
-		return;
-
-	if (data->count != -1)
-		(data->count)--;
-
-	stacktrace_trigger(data, buffer, rec, event);
-}
-
 static int
 stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
@@ -1568,26 +1528,6 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1595,8 +1535,12 @@ static struct event_command trigger_stacktrace_cmd = {
 	.parse			= event_trigger_parse,
 	.reg			= register_trigger,
 	.unreg			= unregister_trigger,
-	.get_trigger_ops	= stacktrace_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= stacktrace_trigger,
+	.count_func		= event_trigger_count,
+	.print			= stacktrace_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_stacktrace_cmd(void)
@@ -1631,24 +1575,24 @@ event_enable_trigger(struct event_trigger_data *data,
 		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
 }
 
-static void
-event_enable_count_trigger(struct event_trigger_data *data,
-			   struct trace_buffer *buffer,  void *rec,
-			   struct ring_buffer_event *event)
+static bool
+event_enable_count_func(struct event_trigger_data *data,
+			struct trace_buffer *buffer,  void *rec,
+			struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
 	if (!data->count)
-		return;
+		return false;
 
 	/* Skip if the event is in a state we want to switch to */
 	if (enable_data->enable == !(enable_data->file->flags & EVENT_FILE_FL_SOFT_DISABLED))
-		return;
+		return false;
 
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, buffer, rec, event);
+	return true;
 }
 
 int event_enable_trigger_print(struct seq_file *m,
@@ -1693,34 +1637,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
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
@@ -1852,8 +1768,8 @@ int event_enable_register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1894,30 +1810,8 @@ void event_enable_unregister_trigger(char *glob,
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
@@ -1926,8 +1820,12 @@ static struct event_command trigger_enable_cmd = {
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_func		= event_enable_count_func,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_disable_cmd = {
@@ -1936,8 +1834,12 @@ static struct event_command trigger_disable_cmd = {
 	.parse			= event_enable_trigger_parse,
 	.reg			= event_enable_register_trigger,
 	.unreg			= event_enable_unregister_trigger,
-	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.trigger		= event_enable_trigger,
+	.count_func		= event_enable_count_func,
+	.print			= event_enable_trigger_print,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_enable_disable_cmds(void)
-- 
2.53.0

