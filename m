Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594242;
	b=0MyJwXmANKTTTHkfdvCnhN4UgUYc9/zLX5kmkeIRoJBmwW8xiMfeOtZLEsmmq8kodfEi
	 SgAV/DwSH6YEghGvXUPcbsk9QLKEtmSW4i8d5m1mW41ObPuX9wgqvscJVIidJ1YouxQw5
	 6Rvy+Zr7v3VrsZU9UaTbB7IjZbnWChwnOyVbTR2BrvNWaEKFrHzblfoMiLSUx3zXkSyhw
	 qullx1ljmRZby0jB2qZanuayeRd16dQ4iDWmfokkwCoOQet/a6V/8dSemMDYe+XIIn2Zf
	 wSQ/BsCgdKHaYN6jIWtUpEVJ9RJ+npcQz01PhNnpNl3n7hlw9fnCis2RcAFRabEluIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594242;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bY1zRcbVSEN2JsAefOMNKbciI0zqhuwOD2i5pwIWulI=;
	b=oZxGJtJXDW3Qx7EAQ6mYSnixroD1ShQovwmOvHBDP1IaCg6RQHxC2K08bqCokG8+TWWO
	 8iaaQlpMRPRDxSAI/08BdqFnXWWmKpxvCksdBkfNTZTOcZN9UsvnL3dVRXQLS6KHpBuUi
	 oE6YnXh8ICULVVRkcVTtRPapFC0LFdOCC+Fjg1i3KMlf6ubXnj41w+QSX+FJg+GpD7UZM
	 GRJXqDAvpbevASV9dyU6K5HofidFBra56YK1HsKjZxp4RU0KdXTJE7t9VvHr5hqgES+ad
	 7epxcg1qCPRhjgbUkPwGqNN2aGlaw92Y8sJJGIZ/e7KElshry+mE/IdEMyUd3WEpgeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BMlH767W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08A606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BMlH767W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6531F000C1;
	Wed, 21 Oct 2026 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594241;
	bh=bY1zRcbVSEN2JsAefOMNKbciI0zqhuwOD2i5pwIWulI=;
	h=Subject:To:Cc:From:Date;
	b=BMlH767WhwWn1pHMlVnTWrQEvF+hunT5O/6dq1u0OpWXwxzImAg/4FmofUceDo3kH
	 HZ1yMW7q1bhTJbVjB5rRJ4wi6RGaQVwR28H6LO7Q7pqbDQWmdhDE6hwb7FDraApMNI
	 2F3aOEz0NGLKyhW+W9yb0u0EZuxIkgsdBXNecRB8=
Subject: FAILED: patch "[PATCH] tracing/histograms: Reject non-stacktrace fields for" failed to apply to 5.15-stable tree
To: lee@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:42:26 +0200
Message-ID: <2026102126-gallantly-unknotted-4bc4@gregkh>
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
git cherry-pick -x a244c241593b5b38a08f0df2cb43c26574efbdcb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102126-gallantly-unknotted-4bc4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

