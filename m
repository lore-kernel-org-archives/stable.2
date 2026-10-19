Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A594ED1A5;
	Mon, 19 Oct 2026 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411657; cv=none; b=sQzUtcJug97FzK08S5DhVPRlFn6wmZWxpx24nutfzcrXvwblcC+IX7GLnuDQFzmfzgLaJQesuTTAyCpW0cuJZY3sfuZkdq5B0KBjgyGFaaUIKriugB1/6YTkVcipFM1TmV8R1oxFRJUugtWnKCObo3+nSN1s2BHqmujWhbYctjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411657; c=relaxed/simple;
	bh=0VD279vbdOS0EiyvVxP/U5jXF1MFq44rMijcaDVhVNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhM/jOCSh/ueGvW/xwl4hM/7xkDUPwwBiqBMPju3fKaZV2vV4KNSuTwWsD43SbEjgdSdWuipaNcehY+e4dzbs8OWACr6TCYd6DvGfhQr5oDUjy9/woiquz9opD5CH+GYvd96PGBTaEWSVteGlii97uJOWm/myiGUUJkv4Fl3Lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW0uv/+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW0uv/+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2871F000C6;
	Mon, 19 Oct 2026 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411654;
	bh=RF1BCrenhcVKcdUJCeYXXIn58WVKEsWB0QjtqkJFbPY=;
	h=From:To:Cc:Subject:Date;
	b=jW0uv/+P1WZ7NmnDqoeL1W5d6JLqGiqZ9qff4O2AtRpYHx86WoKa8B6/b/cW4ypPi
	 CskWQJImUMnuy9XwYK/np6IlxHWjr3AVQINzxHILh/v3XaP0HXoVuGY7hN+QwBg4A/
	 wUOFcDBwZgtLA/Gfu/8zVftH1F8lllmzvYrWjBh+QfN7rXiiKOWf581PGAB4XvCHY9
	 Wp8oOnRDUHRKAWa/OM64a2YH9L0jjiDVAACfa+RYySnwDCUB47bIGJxv9UOQ+xhW7H
	 aT1E5nkvYgMuuwkJtxkawSrs4YhtlPPvHI4p4XEIJfFELJfgS4G4u6GMjMZveuauk8
	 Ur6wLkTQay09w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] tracing/histograms: Verify event_call identity when updating synth_event refcount
Date: Mon, 19 Oct 2026 12:07:29 +0000
Message-ID: <20261019120730.2342739-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In event_hist_trigger_parse() and hist_unreg_all(), the histogram
registration and unregistration paths look up find_synth_event() using
trace_event_name(file->event_call) and adjust se->ref if a match is
found.

Because find_synth_event() only compares the event basename, registering
or removing a histogram on a non-synthetic trace event whose basename
matches a synthetic event erroneously modifies the synthetic event's
reference count.  If a histogram is registered on the non-synthetic
event before the synthetic event is created and removed afterwards,
se->ref is decremented without a matching increment, allowing the
synthetic event to be freed while an active histogram action still holds
a pointer to it.

Introduce find_synth_event_call() to verify that &se->call matches
file->event_call before adjusting se->ref.

Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 -> v2:
  - Introduce find_synth_event_call() helper instead of open-coding the
    &se->call == file->event_call check at each call site (Steven).

 kernel/trace/trace_events_hist.c  | 11 +++--------
 kernel/trace/trace_events_synth.c | 10 ++++++++++
 kernel/trace/trace_synth.h        |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 00a1d8522036..9a789f57ed95 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6792,7 +6792,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6805,8 +6804,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = find_synth_event_call(file->event_call);
 			if (se)
 				se->ref--;
 
@@ -6830,7 +6828,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	struct hist_trigger_data *hist_data;
 	char *param, *filter, *p, *start;
 	struct synth_event *se;
-	const char *se_name;
 	bool remove;
 	int ret = 0;
 
@@ -6924,8 +6921,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = find_synth_event_call(file->event_call);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -6960,8 +6956,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	se_name = trace_event_name(file->event_call);
-	se = find_synth_event(se_name);
+	se = find_synth_event_call(file->event_call);
 	if (se)
 		se->ref++;
  out:
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dc15658a887c..e2870212e58d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -914,6 +914,16 @@ struct synth_event *find_synth_event(const char *name)
 	return NULL;
 }
 
+struct synth_event *find_synth_event_call(struct trace_event_call *call)
+{
+	struct synth_event *se;
+	const char *name;
+
+	name = trace_event_name(call);
+	se = find_synth_event(name);
+	return se && &se->call == call ? se : NULL;
+}
+
 static struct trace_event_fields synth_event_fields_array[] = {
 	{ .type = TRACE_FUNCTION_TYPE,
 	  .define_fields = synth_event_define_fields },
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 43f6fb6078db..d4ebf01b7049 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -37,5 +37,6 @@ struct synth_event {
 };
 
 extern struct synth_event *find_synth_event(const char *name);
+extern struct synth_event *find_synth_event_call(struct trace_event_call *call);
 
 #endif /* __TRACE_SYNTH_H */
-- 
2.56.0.212.g129ede20d9-goog

