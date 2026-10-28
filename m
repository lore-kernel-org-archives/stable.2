Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166188;
	b=ud09YNFcd3y8GLAaCbhgdxcDuoVZqxCpCyVpgGZ4EJPRcL+5Gp1+pe9tUKQMdLA2G41y
	 yXQ7azxfuUBh8GNiOB5JoazslG89WAmPKg9i/B6PPAv/iulRBIraKKgfakUVtTmg3HPxD
	 UUD0+y7W7+AxkC3uI4igIU0syTm9hEo6qvSf0hRohI64yseSorjZq34TM/aWusJHbvgU/
	 77/Iup8B/0egDE8Szd82opp+MYwLT6tuu/PnbF469kSqzu0Mg6mVOIUf09s1q4u5Zmufg
	 KVntK8C5rcEjonqtZNKKwLhR0mkEKGQLF4ULDMVWINbS1IaAW1lqPeWx4sffY73tqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166188;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JKSX/QDPiM2sEr9XTWreBYydgF9/T83qhu6VFRhHwmM=;
	b=cv83lqX9wqh2hf/F6V0WfrOuqcgr1y1xx39OyQLFq6GZNeeBtv+vSqFGhEacWtySDxtv
	 HtDAl47AnUHGyaYEyFAZ8ntdjtwbLMBHv5y0/xbUfyowO9TP2t3/O9h4R8Wjgec3Lj8C0
	 x7DPMQGC6fgBWed7W/+6TaNFYp3S20EQ4eLDa1Xfjgp6r+4nDGFmE/clFN9/MA3f++6uo
	 PYrSGIm5ceRzxplwpN/E+3B0CoeGF0/BJoPmAruOPPFZpuDnIYLOroxj9eHAeAuPMlGEE
	 IS8ibOtLVCHQWSiAqbP0kEEa+9Y0hD2bPOdJoKwyGUzFGKCiqImOTFCF54YLpRblazg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qKz3C17i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E4606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qKz3C17i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57B21F01825;
	Wed, 28 Oct 2026 05:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793166187;
	bh=JKSX/QDPiM2sEr9XTWreBYydgF9/T83qhu6VFRhHwmM=;
	h=Subject:To:Cc:From:Date;
	b=qKz3C17iivhyFZN7AyH59BcOY1AjdBhAgvTAIDGt4ENJcLxcN/8RfZ6CkuIJRP5GF
	 CgWTJQ4cwVxPLN2KoKT+Gt7IMHgtFK5ihCsYre3bun/NW+BkgWcbucn1BsVgJ6i3tT
	 /u0JHl3PfAAJ6QhqFH6LOV++3xTBWV1cVudBatPI=
Subject: FAILED: patch "[PATCH] tracing/histograms: Verify event_call identity when updating" failed to apply to 5.15-stable tree
To: lee@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 06:43:05 +0100
Message-ID: <2026102805-estate-dragster-adef@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3403d9bb27ebc3572bd048620746b4414e073bf9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102805-estate-dragster-adef@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3403d9bb27ebc3572bd048620746b4414e073bf9 Mon Sep 17 00:00:00 2001
From: Lee Jones <lee@kernel.org>
Date: Mon, 19 Oct 2026 12:07:29 +0000
Subject: [PATCH] tracing/histograms: Verify event_call identity when updating
 synth_event refcount

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

