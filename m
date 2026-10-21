Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597039;
	b=p+poqNDw2cqUeYANUAsTTcohMt+xkSGugIixpez7cvBoAHDVHjyprMP3yoQH3xC+duNU
	 vBn9ZIJCzPjWHtMkJu3YX/o2EcqPbPI04efYwRfOa6ZDjZOqZR9o8xsuZtUTIwxWInIw1
	 dRil2km/tyaY5mj92NC++1jVP2tjgoGFFuFJCxvfqzr48qQNd7KC4q6kqRVJLurSMAirj
	 06pGqA2DhPiDSNyLMkv4PU2YtqBnivznYUNRFIVgN0jcKZhVG83L565OGeS9CkEg7IkU5
	 xBTl1+xya0vvNIY8Fq4IOIBydHe7nodPwYCgxUfp+qjR8t0EEaPTfWmAcZ26Pex0YSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/TAFCYmY1d6h1533UQpOgy7mkXVJ98JtODw5xZZ2twk=;
	b=nqqhpfRAy1TkgP3DCPyLykrHHxe6HFMKQLYzuQ6YcA/oePcf1C9R6qgQV3icXmUluVF3
	 63eSox3t9GMBDn7Pt0Jqhzvo5/cgs5nuYHpRKq2QnpkmwJyE/x+7RkfondYzEJrZ/L5+K
	 KEBxpzMqsEJY4Dnv46MH10eYShFlB5yBX9MVgo4hqLioALa8OXawH/MaWGQ+yjfqaxTYG
	 P2OTtUuwefqyTq3uFdBHCalp+8mRTWeVMvJTFeOXU+S746+UCjgbtou+qDBKUbO0W6oTh
	 x0+NNfh0BWOfZgqKOuVY5kzRseLejzxyk19PpcRA8ec1vbYO9wWfBNdefSUcU26kBSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlKLCenB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B0606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlKLCenB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5AD1F000C2;
	Wed, 21 Oct 2026 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597039;
	bh=/TAFCYmY1d6h1533UQpOgy7mkXVJ98JtODw5xZZ2twk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlKLCenBs0WwOlA3FB3Q+h0uzYNT7cwpbK7DaSbolud21/UebZz4864CTTYVPUqW3
	 Sq/pNaS7BuOmKnor8NJZwmkOcrDwGNVsDo75+7loHtKeIZvDWGnHPunrUsUbhf+EOZ
	 g5DOsVg7IdMFr7TQZqgECZCY1wsxnrh7gt+xooDdgnCx0w1LBkx/m7vJBgFKzcoYCg
	 5rvmCmaiRzMZYz+mfSfmUFhyWgf1Grj4nXn1fAsjGKOggN6Vn5ZRILs+7cIpGyF/oZ
	 v2Aa6nBQrITkBauoLQlSWu50JyMQz4sANL0JzJCgdUPlc6kLh1tb86mq5FSWXuLWI3
	 iaSKlGRwNnokQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
Date: Wed, 21 Oct 2026 11:37:17 -0400
Message-ID: <20261021153403.303474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102125-surely-nastily-2d17@gregkh>
References: <2026102125-surely-nastily-2d17@gregkh>
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

From: Lee Jones <lee@kernel.org>

[ Upstream commit a244c241593b5b38a08f0df2cb43c26574efbdcb ]

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
[ sashal: Retained string-only buffer conditions because histogram stacktrace-variable support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 40d9de933fc85..f04037d01bdd7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2067,7 +2067,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -3210,6 +3211,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(var);
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
 	if (!field_var) {
@@ -3837,7 +3839,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
@@ -4360,7 +4365,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
 		update_var_execname(hist_data->fields[val_idx]);
 
-	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
+	if (!ret && !(hist_data->fields[val_idx]->flags & HIST_FIELD_FL_ALIAS) &&
+	    hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
 	return ret;
@@ -5093,7 +5099,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
-			if (hist_field->flags & HIST_FIELD_FL_STRING) {
+			if (!(hist_field->flags & HIST_FIELD_FL_ALIAS) &&
+			    hist_field->flags & HIST_FIELD_FL_STRING) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;
 				unsigned int size;
-- 
2.53.0

