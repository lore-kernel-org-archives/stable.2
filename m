Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243412;
	b=BWEtklA8yJpxSGq5DDIOIP9RuoXFgD7DgUeD+JEotlRm7PqFeUBPa/mJWXVfnwluQ/t5
	 ltGlC4hFIihKIxUS8tmZeLOLGc7gb3lTVeg+SUre017kvvmy7SImeGRhkHcMKUAqUXjyU
	 C1PhRGwRDf7h8D07ZurAYiyRs5TabfhUQxwbNXyhC0DbMpQSBAdX7o9OXSiHGS2iTaASQ
	 Q0UBnTn7cp8l5XAHoOp8I9WCHa8WMgUN9ZAawulV4rFa3vw2N1q+IINpEih3f2qDvC48P
	 afbNwOuyRHlCYS3Uo51U3MNZgCthVsOg0hiYQCWHeELkZd77I2/j06joJxkaBK7TN1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xqkGm5f4QUzjMFVsDZnppdOxHCaNW2iDkgE+KO329LU=;
	b=z6ZaN0t68FRkbz7MlvOFJJrOYksBRS+sN2iZ2SKW/MIeiS1YBJCeLsJu4551Yj7btmyL
	 su7o7e8d+pUYL9aKVGlEBjrJB4S0nNDCy8lQuq2MLT8akQivZAAZsfJOYX3ish43/J2H/
	 sk6nDa3WuOKfhS9z/0QRS7Du8NNlfCsuYA6b9UoOYpC6sbdGdZOSL0CNRABs6E8NbH5Fq
	 oWDkGxfd+xWl7ALiV4b6D15eqv5OWO5DKPoHeOJluz/Z7x+QHPc344LUsGRxToC1mluuT
	 ATr64JSWLdAX7/LXPx5aUtpEoRXokY1I3G7ybKphNSaPFnBZ1JQi97I3Z6G4rDQwtYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGOxaN9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC37606A33C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGOxaN9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10341F0089F;
	Mon,  9 Nov 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243411;
	bh=xqkGm5f4QUzjMFVsDZnppdOxHCaNW2iDkgE+KO329LU=;
	h=From:To:Cc:Subject:Date;
	b=fGOxaN9u8/+kd0KdfILrUalpLBEiA+iKYrmqWYFD4NJ3DMQ4HTKYHRj0NjBN96xfy
	 oRNYMbBK+vIzqM882kFEe5vhth40be/J7ZqOYtTzWL9EzYDox1brn7XIz+FWgirIKg
	 ecmRhpT8LyknbSse4q8VAQaMXV1eLxkAGtmomsjOnAwZHBG5E+YBwcPpA+DIOwe9My
	 stGf9GvDBv0Pghy5sOj2lMpHB/kOKM5FKpmO/73dN8nBo4m8x9cTRZmkP96x4yMs+P
	 wF8vOJ9GZMv4fo+FeB/jHbbdhoYjJtpRasFYq2rx+TNjLEafvtl0jx0uDNsOJfcZpR
	 sAOx0CM282Iew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [STABLE v5.15-v5.10] tracing/histograms: Verify event_call identity when updating synth_event refcount
Date: Mon,  9 Nov 2026 16:56:48 +0000
Message-ID: <20261109165648.3451454-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 3403d9bb27ebc3572bd048620746b4414e073bf9 ]

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
[Lee: Context conflict in event_hist_trigger_func() - no functional change]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c  | 11 +++--------
 kernel/trace/trace_events_synth.c | 10 ++++++++++
 kernel/trace/trace_synth.h        |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 223b38f9ac0e..c8e57b6e28fd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5797,7 +5797,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -5810,8 +5809,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = find_synth_event_call(file->event_call);
 			if (se)
 				se->ref--;
 
@@ -5834,7 +5832,6 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 	bool remove = false;
 	char *trigger, *p;
 	int ret = 0;
@@ -5931,8 +5928,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		}
 
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
-		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = find_synth_event_call(file->event_call);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -5973,8 +5969,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	se_name = trace_event_name(file->event_call);
-	se = find_synth_event(se_name);
+	se = find_synth_event_call(file->event_call);
 	if (se)
 		se->ref++;
 	/* Just return zero, not the number of registered triggers */
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 62d146254f47..ba5647204d3e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -848,6 +848,16 @@ struct synth_event *find_synth_event(const char *name)
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
2.56.0.506.g506a7eabc5-goog

