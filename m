Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE23B5304
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578742; cv=none; b=XA66umgF3lvDwgN9pGFyh1APq6P/IccjXZZ7jXuq0X2FuOxSF0dLvhXE/1lKSzAFCtPvf6fSZ0QmXlWDsVF7rVyrAk1xzsJZ5knlAhY5QlT3aX1CGXhLVhCzJlbiFqpgewaWkF9HoF3F5aZBlhzMOolWgE2ITw1FkEXxD9A+E4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578742; c=relaxed/simple;
	bh=5aC6ETyS/RbXb0MmZHWI2JLUp0odfR2kYckG64NJhdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7udKuP0htQQDWqwPDpd4Gtv/ymph2JvAd75f51z3U2AOG0tw7rgY2ZQh82ph6ej77vQoLWUw9PWBZMjD1acHnXBHNAmZ6ruxhE5d10v4rJwCIoMfAiQzb10kxuFy2JjHH0Huu7VpW6jlI03SVvSimblM80z4NxUdN+hYIrUDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoTlI3W/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoTlI3W/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3421F000FF;
	Wed, 16 Sep 2026 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578725;
	bh=FtIM4UJR2bmbSZvrLbrYGVkyJn1+wC1LCtrfVHNl9Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BoTlI3W/KXdtNZFNXCGEkLfhhdzAqph55vpoHfng/4WWPyPR585GTtAP9J5D9OVDd
	 aue65OcCKxhzoiK85qA1gQdLDTrp5AWrqAcoFGxxMNMs7kisMW0BoYx/PSLlIhMN6U
	 M/4arozw3MR55eOTi770Qi2ZFBO6HARWoaiVDrjV9Zrw64Bz10sP7NRwNG/nSuKeF7
	 DWmPvuO6/Y1Bo9t8RquzOh5ITtn6NnWkLOMUrPfscrZyixam99vZHH2OLKmfmpcji5
	 Q2wfcLGUQekkgGRjb1r4Bjfouw4sVLdLMR1XMIHAiEwTPNXeaPDCvkevQeI0exmTHn
	 nLZcLcijhIOzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] tracing: Constify struct event_trigger_ops
Date: Wed, 16 Sep 2026 13:12:01 -0400
Message-ID: <20260916171203.783212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091627-stylized-awry-e55f@gregkh>
References: <2026091627-stylized-awry-e55f@gregkh>
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
Stable-dep-of: 6ede78d0563a ("tracing: Set the trace clock before registering the histogram trigger")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h                |  4 +--
 kernel/trace/trace_eprobe.c         |  6 ++---
 kernel/trace/trace_events_hist.c    | 20 +++++++--------
 kernel/trace/trace_events_trigger.c | 38 ++++++++++++++---------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8cdb8e1a33c1e..2002d48c8a931 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1557,7 +1557,7 @@ struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	struct event_trigger_ops	*ops;
+	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1800,7 +1800,7 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 2c98e831808c0..d55dc47b6fd63 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -574,7 +574,7 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 	__eprobe_trace_func(edata, rec);
 }
 
-static struct event_trigger_ops eprobe_trigger_ops = {
+static const struct event_trigger_ops eprobe_trigger_ops = {
 	.trigger		= eprobe_trigger_func,
 	.print			= eprobe_trigger_print,
 	.init			= eprobe_trigger_init,
@@ -603,8 +603,8 @@ static void eprobe_trigger_unreg_func(char *glob,
 
 }
 
-static struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
-							char *param)
+static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
+							      char *param)
 {
 	return &eprobe_trigger_ops;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4e131895d6a9c..c29ffde262e3e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6020,7 +6020,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_hist_trigger_ops = {
+static const struct event_trigger_ops event_hist_trigger_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_init,
@@ -6052,15 +6052,15 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
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
@@ -6657,38 +6657,38 @@ hist_enable_count_trigger(struct event_trigger_data *data,
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
index 401d88d3b2c4b..af319d2cf824c 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -831,7 +831,7 @@ struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
 					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
+	const struct event_trigger_ops *trigger_ops;
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
@@ -1360,38 +1360,38 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1473,21 +1473,21 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1568,21 +1568,21 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
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
@@ -1693,28 +1693,28 @@ void event_enable_trigger_free(struct event_trigger_data *data)
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
@@ -1898,10 +1898,10 @@ void event_enable_unregister_trigger(char *glob,
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

