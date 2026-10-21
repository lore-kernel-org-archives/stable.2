Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594247;
	b=euOmyKnr4JJtHSc15szaf3o5mn2PpfrFZ5VwBOFaIRkeq60VFmd5iN9SDrLzptuowdsM
	 ANWoKPKFKxRqhreMqZ7QD1mmgvxBCYnZwz1YOXH7TJTR5wzA4mdJDbxjVrR3iKJOilwBl
	 LvzqyNtlKyckmM5KswBN1XNtNtkl7DGrKp0DpD83cnulCB40tevBhLQOWcbTwdl88LvtW
	 AoiqghbE96048gGbcu2M+VRyEjVx+NhEKG6rt0dNx5Oq4FZHO05gGm/p33ENrjgOhpm76
	 nUU2Nqp2tIF3bRNDTT8NdMUowBWSVKRwj1/Hu9nHSkmIYCcRPLK3MdWL+V18mTQ5zrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594247;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n9Ir14eSKwEKGMTmwP/0uqmXxqQ7uJx5Rav2Y58V9/A=;
	b=cmcxS0QTMp9jIWABdHOjALnauOoXdQ/rbLlE4SMtMiXp3BzlJtAjHiHVTWFIyOMZbwWh
	 bQBgkocthuCeEM6pEI9DuCU7QSTWmnSmzmqSC5WrWNnMl3R6Bmmk621+O8UvuWDOdnXf8
	 PotjLqKeaXzf9Whq3cRuTn6wl/EAf77TDTPsKG+SfalCh683xFu2eNsEu2UjNefkU2PXA
	 iOQayyRVhMRLbtEAXFmFiD58DeYiWP0XpNLK1b3SfZfbAxAbdpqVEd3oIWciIb4yGLOMj
	 FVqx8w68kExVlLDikavZVUiYUAseliBU8GRjpyHb0y8/lqH+3gJ+hMM1DPAbM+rUW6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZGDGu5Mw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0A606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZGDGu5Mw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C221F000C1;
	Wed, 21 Oct 2026 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594247;
	bh=n9Ir14eSKwEKGMTmwP/0uqmXxqQ7uJx5Rav2Y58V9/A=;
	h=Subject:To:Cc:From:Date;
	b=ZGDGu5MwvqiEA3ZBPlhTnBwRaqh7+3UMQ0gFt2XTzKWOSChYnXarzKASezmBI761g
	 Lhgk1q26cqCpWuTMlRJD89qDqmMX+sGLKjtPbDUxoHnDQW4D0PnyqfMNm6KRKcCPiT
	 oWhmsaYe1OpBVga78fEaUmyP8BiLJ/WRBFsoXlns=
Subject: FAILED: patch "[PATCH] tracing/histograms: Reject non-stacktrace fields for" failed to apply to 5.10-stable tree
To: lee@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:42:26 +0200
Message-ID: <2026102126-groggy-doorknob-d4de@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a244c241593b5b38a08f0df2cb43c26574efbdcb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102126-groggy-doorknob-d4de@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a244c241593b5b38a08f0df2cb43c26574efbdcb Mon Sep 17 00:00:00 2001
From: Lee Jones <lee@kernel.org>
Date: Tue, 13 Oct 2026 11:24:48 +0000
Subject: [PATCH] tracing/histograms: Reject non-stacktrace fields for
 synthetic stacktrace fields

In check_synth_field(), when a synthetic event field is a stacktrace
(field->is_stack) and the histogram field is not a "long[" stacktrace
array, validation falls through to the generic size and signedness
comparison.

Because parse_synth_field() sets a stacktrace field's type to
"__data_loc unsigned long[]", its size is sizeof(u64) and
synth_field_signed() marks it as signed.  Consequently, any 8-byte
signed scalar histogram field passes the fallback check, and its scalar
value is subsequently dereferenced as a kernel stacktrace pointer in
get_field_size() and trace_stack().

Furthermore, checking strstr(hist_field->type, "long[") is insufficient
because tracepoint fields defined with __bitmask() or __rel_bitmask()
also have type "__data_loc unsigned long[]" or "__rel_loc unsigned
long[]", whilst create_hist_field() treats them as 4-byte scalar values
without HIST_FIELD_FL_STACKTRACE.

Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
variables (whilst excluding variable aliases from per-element
stacktrace capture), and reject any mismatch between
HIST_FIELD_FL_STACKTRACE and field->is_stack in check_synth_field().

Cc: stable@vger.kernel.org
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Link: https://patch.msgid.link/20261013112449.1006088-1-lee@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 571a57e0f369..dcb5d7321095 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2121,7 +2121,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -3318,6 +3319,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(var);
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var = kzalloc_obj(struct field_var);
 	if (!field_var) {
@@ -3946,7 +3948,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
@@ -4487,7 +4492,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
 		update_var_execname(hist_data->fields[val_idx]);
 
-	if (!ret && hist_data->fields[val_idx]->flags &
+	if (!ret && !(hist_data->fields[val_idx]->flags & HIST_FIELD_FL_ALIAS) &&
+	    hist_data->fields[val_idx]->flags &
 	    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
@@ -5228,7 +5234,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
-			if (hist_field->flags &
+			if (!(hist_field->flags & HIST_FIELD_FL_ALIAS) &&
+			    hist_field->flags &
 			    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE)) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;

