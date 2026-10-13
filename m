Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88D3DB33C;
	Tue, 13 Oct 2026 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891541; cv=none; b=DiA2AzjhDgqQ3BIonqC3MRY+ED5IbINJhaGjgRdXIIWhL1yhNesDr5XuyTaa6Ad3rPq4xwmVfP/+0d1vTAWTMLz09lRnAyby8OxEIjY83rSKiz9VAIhCWJzshfk/VEleqjD6egYD9c4GAO2mjMlLnEv27KfOVU7ZVCS/olu0QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891541; c=relaxed/simple;
	bh=F3jbrUon50I/esfgt38aY5mZa678/5mAa/00VYW7/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BALNjAeggFBuFFeVxi5Tv+DcOHG0dOIAt7+3knOe6eiElfJc67UsURc5z5zZ56UllV7LDXgro1ga5xXp6mN3a5oPmbNeb61fUVmVTxho14SFiimaHpESsp2fAiCDnj9jWSs5oyGHGO9I0FDNoxO9kmxuCQs/JsSPU0kXkixasxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLyRBUQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLyRBUQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5421F000FF;
	Tue, 13 Oct 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791891539;
	bh=iM7Kn1upRKCYgX3my+5a9iEmzXraOMK8a7ELFfehbz4=;
	h=From:To:Cc:Subject:Date;
	b=BLyRBUQxmYZGUAeaHFZEzWN0WXTwLON5T6iRtekbZ28LOLeR9AvTb8QnRRsdR8UrL
	 796ejjZfccuD7wK8vjH6e0Boe62b7KWRJAiNsO2+/iFFqlivG90MLbN+zX+XtyeNxw
	 BSOsSoNeyqlzfthkBIEKIsy42+fN+u5Y542Fwl+ZhuPt370uFubIHQvZTVro25+q3G
	 tRsN7O6rWjrxm6G1c9oVjlNalmF8GBsO+FEPP10IVtM0IHNoAr6fGG4YbFEdoI54UX
	 5ecw6Ce9ekUpN7fcRiYXc8kTPpNqGYgksodQGALu3/elqjmoNWNVpMzBLY+7FwgNJq
	 Y3OIPV+5Y3Cfw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
Date: Tue, 13 Oct 2026 11:24:48 +0000
Message-ID: <20261013112449.1006088-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 -> v2:
  - Check HIST_FIELD_FL_STACKTRACE instead of strstr(hist_field->type, "long[")
    so __bitmask() and __rel_bitmask() fields are also rejected.
  - Propagate HIST_FIELD_FL_STACKTRACE to variable references and field
    variables, whilst excluding variable aliases from per-element stacktrace
    capture.

 kernel/trace/trace_events_hist.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..d8864b3165d2 100644
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
-- 
2.56.0.385.gd3acb90ef8-goog

