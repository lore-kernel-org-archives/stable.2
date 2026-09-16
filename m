Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D841443A
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587915; cv=none; b=Bke9/8PnV+dXHt6vi7iJr8D5X95rBYiWNKeIwhx/EtRKOdylI5eC3YTSjPBIGO0B8CmJ/wlkUsIw7fXBGJuEe61/DUFQVmKrzB4wtwasJ/0tPlRbaZnygHtL8mqet4v/7nhZX7aMy30YgDTe0frwd0v0RuuQ41O9b4Hd38qYVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587915; c=relaxed/simple;
	bh=0tL3h4qjY/E0hUHFmOv6yyKn1cYc1hIOoYQMNE6KYUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbhCMljaET9ZzskR6+FBLECt7JztpwBMQbKcQILizK0Vw9VOD3y5mIXuVf5mWTvz7m0gxTXn3d20sQ6x3/Gl7xaNgndNG1KGs4u4F2crzfF+Fu7SXI47YAO9qD312pvVqe+gGAV2FlY8KM8cK2UAOZojNveuw0h5rJ6j3xkbx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnv1pdWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnv1pdWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCC01F00893;
	Wed, 16 Sep 2026 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587900;
	bh=i2xDjrmfNvh6M1fYWWtX7mfi+iLu1l2ILlMC6D5+aEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jnv1pdWQV1yeEPlGvR0t+RNvUGRWvOu2aWf0M+Tu3bj31kG+FGnzmptALBewaLp5m
	 9eW9I8L5ciL6xd72zAUMGsgfNrqpMEXSQicol9L9RMw0jAGzvLrxas9XRSsbyyVPYn
	 taVDntQJZN0uPAlb1hV6aUdpx0DvkaOxvrWcdFRYrcIfYV6CyLFMdrVHfJmHbK+D44
	 BR6vVgiwB69Tf8JL4RzqrTdRN3zVQ4Xgz+87C59CRM5hDCEgKBFUbPMGYSzBQjdRYw
	 IBXcaF6YtmZ+svXGYrWSEuyL8A0UBQ33GHuSgo9crKZyCmw7TG0G+bAuWdzZ8S6XiI
	 nTl4KHsYYYSWQ==
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
Date: Wed, 16 Sep 2026 15:44:55 -0400
Message-ID: <20260916194456.2410788-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916194456.2410788-1-sashal@kernel.org>
References: <2026091639-aim-spindle-49e1@gregkh>
 <20260916194456.2410788-1-sashal@kernel.org>
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

Stable backport note: Linux 6.6 still uses get_trigger_ops() to select
separate counted and uncounted trigger implementations. Limit this
preparatory merge to the init/free lifecycle callbacks and retain the
existing trigger/print dispatch in event_trigger_ops. Move every lifecycle
initializer and caller to event_command, including eprobes and histogram
enable/disable commands.

Keep the upstream allocation, initialization-failure cleanup, and teardown
of private command operations for named histograms. This supplies the
context needed by commit 0fe23b8eaba0 ("tracing: Take the reference before
publishing the named histogram trigger") without importing the missing
counting and unregister refactors or adding any functions.

Stable-dep-of: 0fe23b8eaba0 ("tracing: Take the reference before publishing the named histogram trigger")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h                | 49 ++++++++++------------
 kernel/trace/trace_eprobe.c         |  4 +-
 kernel/trace/trace_events_hist.c    | 65 +++++++++++++++++------------
 kernel/trace/trace_events_trigger.c | 60 +++++++++++---------------
 4 files changed, 86 insertions(+), 92 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index cb3b9e3eabead..718cdf94f1600 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1707,18 +1707,13 @@ extern void event_file_put(struct trace_event_file *file);
  * The methods in this structure provide per-event trigger hooks for
  * various trigger operations.
  *
- * The @init and @free methods are used during trigger setup and
- * teardown, typically called from an event_command's @parse()
- * function implementation.
- *
  * The @print method is used to print the trigger spec.
  *
  * The @trigger method is the function that actually implements the
  * trigger and is called in the context of the triggering event
  * whenever that event occurs.
  *
- * All the methods below, except for @init() and @free(), must be
- * implemented.
+ * All the methods below must be implemented.
  *
  * @trigger: The trigger 'probe' function called when the triggering
  *	event occurs.  The data passed into this callback is the data
@@ -1726,23 +1721,6 @@ extern void event_file_put(struct trace_event_file *file);
  *	registered the trigger (see struct event_command) along with
  *	the trace record, rec.
  *
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
  * @print: The callback function invoked to have the trigger print
  *	itself.  This is usually implemented by a wrapper function
  *	that calls the generic utility function @event_trigger_print()
@@ -1753,8 +1731,6 @@ struct event_trigger_ops {
 					   struct trace_buffer *buffer,
 					   void *rec,
 					   struct ring_buffer_event *rbe);
-	int			(*init)(struct event_trigger_data *data);
-	void			(*free)(struct event_trigger_data *data);
 	int			(*print)(struct seq_file *m,
 					 struct event_trigger_data *data);
 };
@@ -1808,7 +1784,7 @@ struct event_trigger_ops {
  *
  * @reg: Adds the trigger to the list of triggers associated with the
  *	event, and enables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @init() function).
+ *	initializing it (via the event_command @init() function).
  *	This is also where commands can use the @trigger_type value to
  *	make the decision as to whether or not multiple instances of
  *	the trigger should be allowed.  This is usually implemented by
@@ -1817,7 +1793,7 @@ struct event_trigger_ops {
  *
  * @unreg: Removes the trigger from the list of triggers associated
  *	with the event, and disables the event trigger itself, after
- *	initializing it (via the event_trigger_ops @free() function).
+ *	initializing it (via the event_command @free() function).
  *	This is usually implemented by the generic utility function
  *	@unregister_trigger() (see trace_event_triggers.c).
  *
@@ -1837,6 +1813,23 @@ struct event_trigger_ops {
  *	support multiple trigger implementations via different sets of
  *	event_trigger_ops, depending on the value of the @param
  *	string.
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
  */
 struct event_command {
 	struct list_head	list;
@@ -1858,6 +1851,8 @@ struct event_command {
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
 	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	int			(*init)(struct event_trigger_data *data);
+	void			(*free)(struct event_trigger_data *data);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c7763d67741cc..1f5668a2c6423 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -482,8 +482,6 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 static const struct event_trigger_ops eprobe_trigger_ops = {
 	.trigger		= eprobe_trigger_func,
 	.print			= eprobe_trigger_print,
-	.init			= eprobe_trigger_init,
-	.free			= eprobe_trigger_free,
 };
 
 static int eprobe_trigger_cmd_parse(struct event_command *cmd_ops,
@@ -524,6 +522,8 @@ static struct event_command event_trigger_cmd = {
 	.unreg_all		= NULL,
 	.get_trigger_ops	= eprobe_trigger_get_ops,
 	.set_filter		= NULL,
+	.init			= eprobe_trigger_init,
+	.free			= eprobe_trigger_free,
 };
 
 static struct event_trigger_data *
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ae70e3007fe10..516a610dce8da 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6337,17 +6337,23 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 static const struct event_trigger_ops event_hist_trigger_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_init,
-	.free			= event_hist_trigger_free,
 };
 
 static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
+	int ret;
+
 	data->ref++;
 
 	save_named_trigger(data->named_data->name, data);
 
-	return event_hist_trigger_init(data->named_data);
+	ret = event_hist_trigger_init(data->named_data);
+	if (ret < 0) {
+		kfree(data->cmd_ops);
+		data->cmd_ops = &trigger_hist_cmd;
+	}
+
+	return ret;
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)
@@ -6359,18 +6365,14 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
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
 static const struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
 								  char *param)
 {
@@ -6570,13 +6572,24 @@ static int hist_register_trigger(char *glob,
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
+		data->cmd_ops = cmd_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -6692,8 +6705,8 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->ops->free)
-		test->ops->free(test);
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
@@ -6745,8 +6758,8 @@ static void hist_unreg_all(struct trace_event_file *file)
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
@@ -6924,6 +6937,8 @@ static struct event_command trigger_hist_cmd = {
 	.unreg_all		= hist_unreg_all,
 	.get_trigger_ops	= event_hist_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_hist_trigger_init,
+	.free			= event_hist_trigger_free,
 };
 
 __init int register_trigger_hist_cmd(void)
@@ -6972,29 +6987,21 @@ hist_enable_count_trigger(struct event_trigger_data *data,
 static const struct event_trigger_ops hist_enable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops hist_enable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops hist_disable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops hist_disable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops *
@@ -7024,8 +7031,8 @@ static void hist_enable_unreg_all(struct trace_event_file *file)
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
@@ -7039,6 +7046,8 @@ static struct event_command trigger_hist_enable_cmd = {
 	.unreg_all		= hist_enable_unreg_all,
 	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_hist_disable_cmd = {
@@ -7050,6 +7059,8 @@ static struct event_command trigger_hist_disable_cmd = {
 	.unreg_all		= hist_enable_unreg_all,
 	.get_trigger_ops	= hist_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_hist_enable_disable_cmds(void)
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 48db99b7d61cb..c517515d9f859 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -437,7 +437,7 @@ event_trigger_print(const char *name, struct seq_file *m,
 }
 
 /**
- * event_trigger_init - Generic event_trigger_ops @init implementation
+ * event_trigger_init - Generic event_command @init implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger initialization.
@@ -454,7 +454,7 @@ int event_trigger_init(struct event_trigger_data *data)
 }
 
 /**
- * event_trigger_free - Generic event_trigger_ops @free implementation
+ * event_trigger_free - Generic event_command @free implementation
  * @data: Trigger-specific data
  *
  * Common implementation of event trigger de-initialization.
@@ -516,8 +516,8 @@ clear_event_triggers(struct trace_array *tr)
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
@@ -582,8 +582,8 @@ static int register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -629,8 +629,8 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 /*
@@ -1378,29 +1378,21 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 static const struct event_trigger_ops traceon_trigger_ops = {
 	.trigger		= traceon_trigger,
 	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops traceon_count_trigger_ops = {
 	.trigger		= traceon_count_trigger,
 	.print			= traceon_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops traceoff_trigger_ops = {
 	.trigger		= traceoff_trigger,
 	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops traceoff_count_trigger_ops = {
 	.trigger		= traceoff_count_trigger,
 	.print			= traceoff_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops *
@@ -1427,6 +1419,8 @@ static struct event_command trigger_traceon_cmd = {
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static struct event_command trigger_traceoff_cmd = {
@@ -1438,6 +1432,8 @@ static struct event_command trigger_traceoff_cmd = {
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= onoff_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 #ifdef CONFIG_TRACER_SNAPSHOT
@@ -1491,15 +1487,11 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 static const struct event_trigger_ops snapshot_trigger_ops = {
 	.trigger		= snapshot_trigger,
 	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops snapshot_count_trigger_ops = {
 	.trigger		= snapshot_count_trigger,
 	.print			= snapshot_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops *
@@ -1516,6 +1508,8 @@ static struct event_command trigger_snapshot_cmd = {
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= snapshot_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_snapshot_cmd(void)
@@ -1586,15 +1580,11 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 static const struct event_trigger_ops stacktrace_trigger_ops = {
 	.trigger		= stacktrace_trigger,
 	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops stacktrace_count_trigger_ops = {
 	.trigger		= stacktrace_count_trigger,
 	.print			= stacktrace_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_trigger_free,
 };
 
 static const struct event_trigger_ops *
@@ -1612,6 +1602,8 @@ static struct event_command trigger_stacktrace_cmd = {
 	.unreg			= unregister_trigger,
 	.get_trigger_ops	= stacktrace_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_trigger_free,
 };
 
 static __init int register_trigger_stacktrace_cmd(void)
@@ -1711,29 +1703,21 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 static const struct event_trigger_ops event_enable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops event_enable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops event_disable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 static const struct event_trigger_ops event_disable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
-	.init			= event_trigger_init,
-	.free			= event_enable_trigger_free,
 };
 
 int event_enable_trigger_parse(struct event_command *cmd_ops,
@@ -1867,8 +1851,8 @@ int event_enable_register_trigger(char *glob,
 		}
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -1909,8 +1893,8 @@ void event_enable_unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data && data->cmd_ops->free)
+		data->cmd_ops->free(data);
 }
 
 static const struct event_trigger_ops *
@@ -1943,6 +1927,8 @@ static struct event_command trigger_enable_cmd = {
 	.unreg			= event_enable_unregister_trigger,
 	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static struct event_command trigger_disable_cmd = {
@@ -1953,6 +1939,8 @@ static struct event_command trigger_disable_cmd = {
 	.unreg			= event_enable_unregister_trigger,
 	.get_trigger_ops	= event_enable_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_trigger_init,
+	.free			= event_enable_trigger_free,
 };
 
 static __init void unregister_trigger_enable_disable_cmds(void)
-- 
2.53.0

