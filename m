Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91E44236F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588192; cv=none; b=tGN7WlC7xxx6dJUX9va15D1T1NaeVBWG8Uhac/c2EBsAI3pa2DGSTyRXPA74sIyKhvmA7WqzEa8zmyl9P7aor6wXPPnNbrnJ5dKq0a/Gr41N33nahzFwR2kIuNmWit30WURBYMB1vnciUtJ/vxL+nhI6qoEcgjziV1A/jhwpeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588192; c=relaxed/simple;
	bh=Bwl6rO0VUVIvRFOCUFE/M5J21rfq6jx3Htc2Ffs2H7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwweBIUvb8eweD+rYk+4++FGQ+YsZirk6rUCA1EVh85PygzKyMtgOzkGkkArCkehrNGVAGgJMCPnwJkSzC7lT8c4BdJrZQcz9toKFb4uXHA8MpoUM6M90nhUiLSHeRpr8Kta3eQbYbvz3YZ7ukH7Wvwy7xHRjMyGLXpJFxa3qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grh5cc39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grh5cc39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1761F00899;
	Wed, 16 Sep 2026 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588178;
	bh=fJJB9LIjh9b5onPF/9XCXXmbz6+YkqDAof9bm2QlOpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Grh5cc39UQkZeH03aby4D+69k2ZqBwei1U3Jqb11N4qaRt9Ad658d03TXMD+FYUcr
	 ukCF/JyrWHTUCtB3nHjn0rLwQXbmXCnr77NH6xRxI01cA1zxjzAHjrk4YLoTgcKgd5
	 ghcOxxH6proDpPEnHJ8FDVa8HJB7Jf6fdZwQ3iwN4YMC8HAc87LwnKWCl3sVZbY6sx
	 Im6aKHnjTXybqJvzqcU9CbV+mikiC5KY0mb/wkROI3+2969RwJEfIfZ87YBtMyAqN1
	 +q1axXnKGAYwJ5DSH2GWJUlh1XkzR6o5D9v+BKqHXxh7269LL9ARnBC1368ZBqGGQU
	 7Dgt7OJAXMu1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] tracing: Constify struct event_trigger_ops
Date: Wed, 16 Sep 2026 15:49:33 -0400
Message-ID: <20260916194935.2439878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091601-uncurled-paddle-226d@gregkh>
References: <2026091601-uncurled-paddle-226d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 502d2e71a89fa706843fa9277f4d6de1947072c8 ]

'event_trigger_ops mwifiex_if_ops' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  31368	   9024	   6200	  46592	   b600	kernel/trace/trace_events_trigger.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  31752	   8608	   6200	  46560	   b5e0	kernel/trace/trace_events_trigger.o

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/66e8f990e649678e4be37d4d1a19158ca0dea2f4.1741521295.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 92383cef6679 ("tracing: Undo the registration when enabling the histogram trigger fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h                |  4 +--
 kernel/trace/trace_eprobe.c         |  6 ++---
 kernel/trace/trace_events_hist.c    | 20 +++++++--------
 kernel/trace/trace_events_trigger.c | 38 ++++++++++++++---------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 05ac2b5c8e208..cb3b9e3eabead 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1614,7 +1614,7 @@ struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	struct event_trigger_ops	*ops;
+	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1857,7 +1857,7 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a9be1ed07ae38..c7763d67741cc 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -479,7 +479,7 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 	__eprobe_trace_func(edata, rec);
 }
 
-static struct event_trigger_ops eprobe_trigger_ops = {
+static const struct event_trigger_ops eprobe_trigger_ops = {
 	.trigger		= eprobe_trigger_func,
 	.print			= eprobe_trigger_print,
 	.init			= eprobe_trigger_init,
@@ -508,8 +508,8 @@ static void eprobe_trigger_unreg_func(char *glob,
 
 }
 
-static struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
-							char *param)
+static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
+							      char *param)
 {
 	return &eprobe_trigger_ops;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d7e8018559938..ae70e3007fe10 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6334,7 +6334,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	free_hist_pad();
 }
 
-static struct event_trigger_ops event_hist_trigger_ops = {
+static const struct event_trigger_ops event_hist_trigger_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_init,
@@ -6364,15 +6364,15 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_hist_trigger_named_ops = {
+static const struct event_trigger_ops event_hist_trigger_named_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_named_init,
 	.free			= event_hist_trigger_named_free,
 };
 
-static struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
-							    char *param)
+static const struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
+								  char *param)
 {
 	return &event_hist_trigger_ops;
 }
@@ -6969,38 +6969,38 @@ hist_enable_count_trigger(struct event_trigger_data *data,
 	hist_enable_trigger(data, buffer, rec, event);
 }
 
-static struct event_trigger_ops hist_enable_trigger_ops = {
+static const struct event_trigger_ops hist_enable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_enable_count_trigger_ops = {
+static const struct event_trigger_ops hist_enable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_disable_trigger_ops = {
+static const struct event_trigger_ops hist_disable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_disable_count_trigger_ops = {
+static const struct event_trigger_ops hist_disable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 hist_enable_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 	bool enable;
 
 	enable = (strcmp(cmd, ENABLE_HIST_STR) == 0);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3ef1fe15493d3..48db99b7d61cb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -833,7 +833,7 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
+	const struct event_trigger_ops *trigger_ops;
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
@@ -1375,38 +1375,38 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops traceon_trigger_ops = {
+static const struct event_trigger_ops traceon_trigger_ops = {
 	.trigger		= traceon_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceon_count_trigger_ops = {
+static const struct event_trigger_ops traceon_count_trigger_ops = {
 	.trigger		= traceon_count_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceoff_trigger_ops = {
+static const struct event_trigger_ops traceoff_trigger_ops = {
 	.trigger		= traceoff_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceoff_count_trigger_ops = {
+static const struct event_trigger_ops traceoff_count_trigger_ops = {
 	.trigger		= traceoff_count_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 onoff_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 
 	/* we register both traceon and traceoff to this callback */
 	if (strcmp(cmd, "traceon") == 0)
@@ -1488,21 +1488,21 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops snapshot_trigger_ops = {
+static const struct event_trigger_ops snapshot_trigger_ops = {
 	.trigger		= snapshot_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops snapshot_count_trigger_ops = {
+static const struct event_trigger_ops snapshot_count_trigger_ops = {
 	.trigger		= snapshot_count_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 snapshot_get_trigger_ops(char *cmd, char *param)
 {
 	return param ? &snapshot_count_trigger_ops : &snapshot_trigger_ops;
@@ -1583,21 +1583,21 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops stacktrace_trigger_ops = {
+static const struct event_trigger_ops stacktrace_trigger_ops = {
 	.trigger		= stacktrace_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops stacktrace_count_trigger_ops = {
+static const struct event_trigger_ops stacktrace_count_trigger_ops = {
 	.trigger		= stacktrace_count_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 stacktrace_get_trigger_ops(char *cmd, char *param)
 {
 	return param ? &stacktrace_count_trigger_ops : &stacktrace_trigger_ops;
@@ -1708,28 +1708,28 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_enable_trigger_ops = {
+static const struct event_trigger_ops event_enable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_enable_count_trigger_ops = {
+static const struct event_trigger_ops event_enable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_disable_trigger_ops = {
+static const struct event_trigger_ops event_disable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_disable_count_trigger_ops = {
+static const struct event_trigger_ops event_disable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
@@ -1913,10 +1913,10 @@ void event_enable_unregister_trigger(char *glob,
 		data->ops->free(data);
 }
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 event_enable_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 	bool enable;
 
 #ifdef CONFIG_HIST_TRIGGERS
-- 
2.53.0

