Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C751476F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583837; cv=none; b=UpCCA+cZmkyNAiJBuucz3F3St7MfZKP/p1Xazyu69SEa53AwAxsxJRRhrLVGRyAqymJ90rZ1hdbZhWfbQqHnxtolbZTsBT3ZX/vqRMXaXVIXLOK3ebTHohY2n3cneAO3T4OAWUqQZdmIPR9eb6Y+cdj4tl1hS5nb950LaykMIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583837; c=relaxed/simple;
	bh=A8Mb5tG5EC00LCqW2f6049ZKCMb3GBOWFllfA340C2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNKF7V0lPLvoNN0GNrUiizzXYJpBgT+G5J5O04Qa4MOCIoEY1aVY3lGDKJl/TMe09P/1Ur1b8oUSe4AJ4Z+6SNejDHx2HLkfZrnBFlmbLOiaeYK/r5FupsAMPuhkK6bOaQNgv3KsiM4uADvbWRudA6oP75I2SSOwuiSvq4bbFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrIH+mjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrIH+mjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129521F008A2;
	Wed, 16 Sep 2026 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583810;
	bh=U0T2WLNAYZ3lnpTAP7b3JMJirgDKUetj/cOQGaCa7KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrIH+mjdqw4dyRA5JwFPQDb6kKJnXmETG5N/i9npqkVZqPrE2xYHNSlxemXUEFTu7
	 CJBQGcLgPMZ9ChsXERv8F3QEJuCyn2gj0uC0Q5hdCk8GNI4BP7Nx+KCktVLdLuKuxO
	 E53cGzxS9IOdZindfmf+LM9OFQY/GXnyJctAG//ORunRJK6z6KVCL+wGzfnllf7ERw
	 zI9IaGtKAiE8cVq7WGSS+qPR+vhBc05NcjeiGgfWfWvrj8F464OgK+9nTl7ovcISls
	 pgn1MUJNr0gQ4CVaInG+2f+m55S+LPXBL9c1TOnr4Sx2u+c6chwNTZO3Z39D2B2XcR
	 KicsZYUYMJkhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] tracing: Merge struct event_trigger_ops into struct event_command
Date: Wed, 16 Sep 2026 14:36:47 -0400
Message-ID: <20260916183648.1771833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091628-jargon-sandstorm-f337@gregkh>
References: <2026091628-jargon-sandstorm-f337@gregkh>
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

[5.15 dependency adaptation]
Limit the merge to the histogram initialization callback needed by
6ede78d0563a ("tracing: Set the trace clock before registering the
histogram trigger"). This branch still uses get_trigger_ops(), separate
counted operation tables, and callbacks with an explicit ops argument.
Keep those interfaces and the existing trigger, print, and free callbacks.

Move the two existing histogram init callbacks to event_command with the
single-data-argument signature expected by the target. Copy the histogram
command into a static named-histogram command at command registration and
override its init callback. Existing named trigger operations continue to
handle teardown; no per-trigger command allocation or new function is
needed.

Match the target's shared-histogram cleanup context by calling the existing
remove_hist_vars() before destroying the unused histogram data. Drop the
unrelated eprobe and generic trigger conversions. Leave the clock ordering
change to the target commit.

[ sashal: Reduced backport -- upstream b052d70f7c9c1 touches 4 file(s), this
  backport carries 2. Not backported here:
  kernel/trace/trace_eprobe.c
  kernel/trace/trace_events_trigger.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 6ede78d0563a ("tracing: Set the trace clock before registering the histogram trigger")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h             |  4 ++++
 kernel/trace/trace_events_hist.c | 27 +++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a632965446b8e..eb753d623105b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1759,6 +1759,9 @@ struct event_trigger_ops {
  *
  * @get_trigger_ops: The callback function invoked to retrieve the
  *	event_trigger_ops implementation associated with the command.
+ *
+ * @init: An optional initialization function used by histogram commands
+ *	instead of the event_trigger_ops @init() method.
  */
 struct event_command {
 	struct list_head	list;
@@ -1781,6 +1784,7 @@ struct event_command {
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
 	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	int			(*init)(struct event_trigger_data *data);
 };
 
 /**
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ecc78916431d..e415be35fe6b0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2416,6 +2416,7 @@ static char *find_trigger_filter(struct hist_trigger_data *hist_data,
 }
 
 static struct event_command trigger_hist_cmd;
+static struct event_command trigger_hist_named_cmd;
 static int event_hist_trigger_func(struct event_command *cmd_ops,
 				   struct trace_event_file *file,
 				   char *glob, char *cmd, char *param);
@@ -5378,8 +5379,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	return 0;
 }
 
-static int event_hist_trigger_init(struct event_trigger_ops *ops,
-				   struct event_trigger_data *data)
+static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
@@ -5433,18 +5433,16 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 static struct event_trigger_ops event_hist_trigger_ops = {
 	.func			= event_hist_trigger,
 	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_init,
 	.free			= event_hist_trigger_free,
 };
 
-static int event_hist_trigger_named_init(struct event_trigger_ops *ops,
-					 struct event_trigger_data *data)
+static int event_hist_trigger_named_init(struct event_trigger_data *data)
 {
 	data->ref++;
 
 	save_named_trigger(data->named_data->name, data);
 
-	event_hist_trigger_init(ops, data->named_data);
+	event_hist_trigger_init(data->named_data);
 
 	return 0;
 }
@@ -5467,7 +5465,6 @@ static void event_hist_trigger_named_free(struct event_trigger_ops *ops,
 static struct event_trigger_ops event_hist_trigger_named_ops = {
 	.func			= event_hist_trigger,
 	.print			= event_hist_trigger_print,
-	.init			= event_hist_trigger_named_init,
 	.free			= event_hist_trigger_named_free,
 };
 
@@ -5636,13 +5633,16 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		data->paused = true;
 
 	if (named_data) {
+		struct event_command *cmd_ops = &trigger_hist_named_cmd;
+
 		data->private_data = named_data->private_data;
 		set_named_trigger_data(data, named_data);
 		data->ops = &event_hist_trigger_named_ops;
+		data->cmd_ops = cmd_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
 		if (ret < 0)
 			goto out;
 	}
@@ -5659,8 +5659,10 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		tracing_set_filter_buffering(file->tr, true);
 	}
 
-	if (named_data)
+	if (named_data) {
+		remove_hist_vars(hist_data);
 		destroy_hist_data(hist_data);
+	}
 
 	ret++;
  out:
@@ -6002,12 +6004,17 @@ static struct event_command trigger_hist_cmd = {
 	.unreg_all		= hist_unreg_all,
 	.get_trigger_ops	= event_hist_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
+	.init			= event_hist_trigger_init,
 };
 
 __init int register_trigger_hist_cmd(void)
 {
 	int ret;
 
+	/* Named histograms share command callbacks, except for initialization. */
+	trigger_hist_named_cmd = trigger_hist_cmd;
+	trigger_hist_named_cmd.init = event_hist_trigger_named_init;
+
 	ret = register_event_command(&trigger_hist_cmd);
 	WARN_ON(ret < 0);
 
-- 
2.53.0

