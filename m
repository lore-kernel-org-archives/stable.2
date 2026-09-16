Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969749A3B0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585682; cv=none; b=azjJ2kn1pXKPJj1uptmCS8BFkYcnOjfwA+X3Wgz0AEmxoDvwOdn5+yGAZ62tlL8IkQuHmN/jfPJ5rk1fvhbvwYvHFCCyBnyJt6UoopncTemoFZ9pD57XUqAQ4LkV0nAJeQnE1QLPAqQQhnQjemyRObGO6fbcEFAGP0dtVzRYKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585682; c=relaxed/simple;
	bh=PNJUsGGjVuSIA/O5zQ1rD1JIcXG/l7dg002MMysxvVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6C4rocP5byl+2h9muj9A29Wz+aylGiR3hopUaamXjnzdRp1nb1xRqNxFowvJ9pznWc2RHj6UCQJJ4U4Wc4nRwHAgPdQVW4El/wLrzU7x4TCE5/S/RXBsIeDHM2Nht0cUn17AwaUIVpNN/YQRsN7CR4QJaIPDQck7kqtU5cok1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrPXqRHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrPXqRHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE381F00899;
	Wed, 16 Sep 2026 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585661;
	bh=lbAIXHzkUL4i8jo86odaiuUmjmseRH/B0SsKExSTbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZrPXqRHhLm6oN3C8gSqTBs20b0IOXVNne2t/5kMH77ekEY3V3SdenXx2fG/BhzNj7
	 VNh8tBEs8sgGooQagLYLKOM9xNuXeGRJaTZEuj7LelGS5Q7MllaXMSvDwsoN/pPQIi
	 nYaa1wU8fxrEKB91i8hfFW8YMaTTtQRpo3sAfYViVxt1rEG8bDNwpi2dOFQsnUcSIc
	 hvUQCc2wtb4RQx9t9rAHsJHOmiJiLP+ivTxjNlzSciuwW8lKD9j6q2wwVszOvRgxmx
	 qCZEcIq/1F+btzaLy17kCToiSFT5OGRkZq2slE9bsdsy/IIjFNa4exxcZEy1Nzbf0g
	 Fl3RRXsWGo9Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] tracing: Constify struct event_trigger_ops
Date: Wed, 16 Sep 2026 15:07:36 -0400
Message-ID: <20260916190739.1968367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091600-excluding-geriatric-1cba@gregkh>
References: <2026091600-excluding-geriatric-1cba@gregkh>
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
index 176e493f79db8..327c01655585d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1698,7 +1698,7 @@ struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	struct event_trigger_ops	*ops;
+	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1941,7 +1941,7 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index e3dd6551c4689..06436fe0786e8 100644
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
index f3899430a2fb5..96d7091995793 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6326,7 +6326,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	free_hist_pad();
 }
 
-static struct event_trigger_ops event_hist_trigger_ops = {
+static const struct event_trigger_ops event_hist_trigger_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_init,
@@ -6356,15 +6356,15 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
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
@@ -6961,38 +6961,38 @@ hist_enable_count_trigger(struct event_trigger_data *data,
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
index 1e4e699c25478..d153a10ae50e1 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -849,7 +849,7 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
+	const struct event_trigger_ops *trigger_ops;
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
@@ -1391,38 +1391,38 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1515,21 +1515,21 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1610,21 +1610,21 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1735,28 +1735,28 @@ void event_enable_trigger_free(struct event_trigger_data *data)
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
@@ -1940,10 +1940,10 @@ void event_enable_unregister_trigger(char *glob,
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

