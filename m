Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196476;
	b=saGX2XT4gu5LUMwtYSM8oSmjWeeGu6NGefbLLvQCatFVviylWpTTz+aR17GmMagZN9cU
	 U6TaM3W4OV3rwCorFMhLlHwLS2OdLI3WzBnSBgb3nX/32cLVMCIPlt23TOBq04aYXsD6Q
	 vYhXvLX721v8AMrdGYLBu2GKOEYGCoJUUtOHs0sp3zh1TYfLtsJcsIYmm3QZ8Ok11Usbt
	 6l3ITJ/Rg55hta7ySGTfco3fgL7VhAxHLMzYyYxKyi0uMfQ5G9Nh1g/CW7ISTBpNB9ioX
	 sVTVBqxM7qlB5J1RN610dpahcXIPmPSwa2fL0P3hdO2dwz7wbSnrPvk0Gwct9lFTeqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196476;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=x4jvh8ydOVs3x0UYASVI8+WP/hsoTYFADxWW4RmKSZQ=;
	b=Ibjuu2xVREr7RDk9X32HT0Crb5qG6/w1qo3Y5rUSs083121yfcJEOJrvp8G3aF/2XlXm
	 6ZyCdStZE4jCwTaHpswrkSu1qvd290tAwlwg/Bin/R1zqtrKuTwIW1PaqTUCR1bhCFzYy
	 uImVKT1gIH/5AT9umJoX7MeJeBnZbHA/2gN918XgQiPZDUGse1gJM2QwrhwYsGtM0QmR6
	 hElcYsAzpNBKK6yeQvb05WoI6cGgB0xrFUsrZB9kIboFTShpJpAMVv06rPaWFa0UUcphU
	 gZ3jjCfjzOvEtPP9IRItCUpQfiD45iHoFDlnLVHCtav8c0gzYEFW3V15xg08MWil9kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTuXbe6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737560A2622;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTuXbe6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154011F00AE3;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196476;
	bh=x4jvh8ydOVs3x0UYASVI8+WP/hsoTYFADxWW4RmKSZQ=;
	h=Date:From:To:Cc:Subject:References;
	b=fTuXbe6KceG+KQGXPx9TRnI6jwpZLHAYOFV6RPt0Ah3bOTdOWz42/GQ0jwhAUw2pQ
	 qVmUAfz/NbT5WtBrwqO8+bO/qPvG4bMoqwDF46ai78+iNOzrZlFv56EgHwATFV3Mco
	 swwYXZvY3MMr1cjXH2SCb8zKPhcZJ8CK7Vqyr1frGuWrovZrETNIub1NR3VN94j4vT
	 PK++Q3g99fj2YBBmAHcnuPDxu0CmSCdHG0kSzitd7K89JiJMckRiICeUiq0xUY0fMa
	 c+0sMOrn4/2HGFLuNUrvdClRnXbyBmXGNm84rMmH+ELtTzu+FCwPFBMR6kg5MueA2g
	 8o5NABacZXDrg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbr-00000004aHW-1XVy;
	Fri, 20 Nov 2026 12:41:15 -0500
Message-ID: <20261120174115.186242337@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:38:58 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 06/32] tracing: Drop the synthetic event ref when clearing hist triggers
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: David Carlier <devnexen@gmail.com>

clear_event_triggers() frees a hist trigger on a synthetic event without
dropping the se->ref taken by event_hist_trigger_parse(). Removing an
instance with such a trigger leaves the synthetic event busy forever.

Cc: stable@vger.kernel.org
Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Link: https://patch.msgid.link/20261022205405.1228742-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  2 ++
 kernel/trace/trace_events_hist.c    | 20 +++++++++++++-------
 kernel/trace/trace_events_trigger.c |  2 ++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0635503a31dd..6b695a7f42c8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1912,9 +1912,11 @@ extern const struct file_operations event_inject_fops;
 #ifdef CONFIG_HIST_TRIGGERS
 extern int register_trigger_hist_cmd(void);
 extern int register_trigger_hist_enable_disable_cmds(void);
+extern void hist_put_synth_event(struct trace_event_file *file);
 #else
 static inline int register_trigger_hist_cmd(void) { return 0; }
 static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
+static inline void hist_put_synth_event(struct trace_event_file *file) { }
 #endif
 
 extern int register_trigger_cmds(void);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1aae7d7c6dc5..a87d626e40e8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6761,6 +6761,17 @@ static bool hist_trigger_check_refs(struct event_trigger_data *data,
 	return false;
 }
 
+void hist_put_synth_event(struct trace_event_file *file)
+{
+	struct synth_event *se;
+
+	lockdep_assert_held(&event_mutex);
+
+	se = find_synth_event_call(file->event_call);
+	if (se)
+		se->ref--;
+}
+
 static void hist_unregister_trigger(char *glob,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
@@ -6816,7 +6827,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
-	struct synth_event *se;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6829,9 +6839,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se = find_synth_event_call(file->event_call);
-			if (se)
-				se->ref--;
+			hist_put_synth_event(file);
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
@@ -6946,9 +6954,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se = find_synth_event_call(file->event_call);
-		if (se)
-			se->ref--;
+		hist_put_synth_event(file);
 		ret = 0;
 		goto out_free;
 	}
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4d2fde996c0f..a2487ad7fef8 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -643,6 +643,8 @@ clear_event_triggers(struct trace_array *tr)
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
+			if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
+				hist_put_synth_event(file);
 			if (data->cmd_ops->free)
 				data->cmd_ops->free(data);
 		}
-- 
2.53.0
