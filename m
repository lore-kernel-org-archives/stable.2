Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498812;
	b=ClsexVvfgcTQq7fgG7RonoC58HIgHxsvRC5nMNjLMKesOYxeboYodxMhsvz1TVATBU3o
	 WplvTk/G7zSL0blv5W6FZIVTyTx5Xt2f/aT/8HzBKLMdfX7lje5PMu5+TYOm5JgLrgN/K
	 aiLtCfebQ9fZfXaNfEZhYXwtDRBhgj66xktBDaVpnGJOOXaqnpeZAbEqUGtPSS2uFkc03
	 OBiRZq4pArbvQ0SyIRd18gnIjeb2ISdO454XGRGDcD84DKAbWPgt4cS+Np99BQ5S8d/YJ
	 p4b2zbebVLQg2RtYUgRPdV6RRmVTnhrsHwi1IN4k3H16zgJwTSBdujHVMcjTxVGu6ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498812;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=ySnz3QHaslrc3VCiLcfpz/lmJKxRkFVUF4QHzOOrXOQ=;
	b=o4eEBPHxmLVhsyI/U3xl1jTkOgk8JEYo6IR12cN3SlQr/XaM5UhYJUsSxV3+4HPmVUgi
	 XELKb17FXqllO98ZWvFG86pa+whczry+uqvOkWEBNJePDyz80dlPJcDQm2neLOaHkomIY
	 xlMSWxWHELk44ugB576QqfmLxVQiyLcwl+rE9IC1gfBWCzukfhbBSQ1EyOpHi0UY2nUeo
	 IgJ1MweumsQX09EhUqiRm+yBnCRJnHA97S8TLDlm5wFAqYELXGvMF25Xln/ZHJhT60A6a
	 CUAaX7vdCQ1k1bhWh+VIcSxbJrkyI4P3mDkMOmA0kE4YF4X7umu1GfdmU74kjPT8o3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2K9OlyT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439960A2601;
	Tue, 20 Oct 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2K9OlyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA771F000C4;
	Tue, 20 Oct 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498812;
	bh=ySnz3QHaslrc3VCiLcfpz/lmJKxRkFVUF4QHzOOrXOQ=;
	h=Date:From:To:Cc:Subject:References;
	b=o2K9OlyTjZvA56Y20vxs1s9UKLOSPiW/9rfHgGB1EaJQOKpItU2AsFYnYK1giXZgc
	 kKmCUXGXk6uOPQlUp4xFW9Hjx9QZR6EavrQLcbggAl5sDkxQJqNFaQrpDGIWVewCzk
	 JBbAe9HJQrwqQSLLYgbVgy3vVntIv7yHVlbeMm06yKicIcVBXRkNuusGUyXC6mgyMl
	 RJngI5XY9yPguruylZCLrJBbLtuEwQj6DAoT8ZwVgGwxlLfvisUTAaN8gDTe4jSI6R
	 Qe68KUS67lKo/2UzvhKsf4QDa+q0kM1LJX9sS40XfqQGXaL45ZVWZ3nR/PUgapSNI5
	 eLWYM8TD7uacQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xJ8p9-00000001y3x-2kxs;
	Tue, 20 Oct 2026 08:20:11 -0400
Message-ID: <20261020122011.462212650@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 20 Oct 2026 08:20:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Lee Jones <lee@kernel.org>
Subject: [for-next][PATCH 5/6] tracing/histograms: Verify event_call identity when updating
 synth_event refcount
References: <20261020121956.600452831@kernel.org>
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

From: Lee Jones <lee@kernel.org>

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
Link: https://patch.msgid.link/20261019120730.2342739-1-lee@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c  | 11 +++--------
 kernel/trace/trace_events_synth.c | 10 ++++++++++
 kernel/trace/trace_synth.h        |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 42b89171134d..f39fa8942673 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6812,7 +6812,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6825,8 +6824,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = find_synth_event_call(file->event_call);
 			if (se)
 				se->ref--;
 
@@ -6850,7 +6848,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	struct hist_trigger_data *hist_data;
 	char *param, *filter, *p, *start;
 	struct synth_event *se;
-	const char *se_name;
 	bool remove;
 	int ret = 0;
 
@@ -6944,8 +6941,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = find_synth_event_call(file->event_call);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -6980,8 +6976,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
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
2.53.0
