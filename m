Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41754CF6C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583848; cv=none; b=AbcD76/QBndjp5FBiKZW/acHTS6TNIlXKoOFPhT9xn8myFZYTx7YoLrvWx7PdYQHBc44r1Xy++NGwbF1hjVOqvQkWX0OoJXbfb06aH6a7kwpoQ09JTLKY5VM9DY0+JiEwOxy18NzAJ3qXEcRg1VSad13PBENxddTBdwwDJCKn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583848; c=relaxed/simple;
	bh=707XasMbJU2ZQ4SM1Xahej/S34B5eaJUZhxkIQSiWcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwcinhcJyLJSDVd0mtKGIsOD5xGaBakxMlJB1oxaLIgb9tCI3WyxCdp03sjsSRXdKuhCWFajSXwP6+wBmCINVvTpvKgzTwpyiq8XjJtkFhpxpTy+N8/kboH/mbGndFTOybsk0vFR9dMfAWwhohghYL0GSMKKWPWN7Ai6trvs8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxwpL4bi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxwpL4bi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1B91F00898;
	Wed, 16 Sep 2026 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583817;
	bh=0dd5P5ecA+1OIDVOVCGmTQAxlO6y5Du4AfLNHILMg8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxwpL4biyg1MOlPu4CQPukiunEwgEbMYLW/XwcXv+tLSLgrpAy+FKsRTtM69YwkLb
	 BcnbIMQCLoMg2Da10pi5cy55b6Qvc1YEMDZ79vWvqI8DkTHY9i2fT1cPknxa/oXNcC
	 H0IsVnjDgqirr9xJsTatRUFX2Vig4uiZK8uSNOX1V7FIRfWGh4E+pbVDJYUwSvmZkA
	 FZjIzRUooTSaqWcXGzVj8U5cGWNeb21ICGctvTxQfaNR0gXOTFr6nqRhnADfIr7gmU
	 Ta7GqePuLbLEly4C1khMF6CRp/LjOUhXFwqVOGR4arq1HOVJv5ym3DejlceMfWpB3j
	 VDrOd7S95i2jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] tracing/hist: Call hist functions directly via a switch statement
Date: Wed, 16 Sep 2026 14:36:54 -0400
Message-ID: <20260916183655.1773427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091621-debtor-hazelnut-dfc6@gregkh>
References: <2026091621-debtor-hazelnut-dfc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 86087383ec0a7ac2bcc3284e13e0e9966f7e3bfa ]

Due to retpolines, indirect calls are much more expensive than direct
calls. The histograms have a select set of functions it uses for the
histograms, instead of using function pointers to call them, create a
hist_fn_call() function that uses a switch statement to call the histogram
functions directly. This gives a 13% speedup to the histogram logic.

Using the histogram benchmark:

Before:

 # event histogram
 #
 # trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
 #

{ delta:        129 } hitcount:       2213
{ delta:        130 } hitcount:     285965
{ delta:        131 } hitcount:    1146545
{ delta:        132 } hitcount:    5185432
{ delta:        133 } hitcount:   19896215
{ delta:        134 } hitcount:   53118616
{ delta:        135 } hitcount:   83816709
{ delta:        136 } hitcount:   68329562
{ delta:        137 } hitcount:   41859349
{ delta:        138 } hitcount:   46257797
{ delta:        139 } hitcount:   54400831
{ delta:        140 } hitcount:   72875007
{ delta:        141 } hitcount:   76193272
{ delta:        142 } hitcount:   49504263
{ delta:        143 } hitcount:   38821072
{ delta:        144 } hitcount:   47702679
{ delta:        145 } hitcount:   41357297
{ delta:        146 } hitcount:   22058238
{ delta:        147 } hitcount:    9720002
{ delta:        148 } hitcount:    3193542
{ delta:        149 } hitcount:     927030
{ delta:        150 } hitcount:     850772
{ delta:        151 } hitcount:    1477380
{ delta:        152 } hitcount:    2687977
{ delta:        153 } hitcount:    2865985
{ delta:        154 } hitcount:    1977492
{ delta:        155 } hitcount:    2475607
{ delta:        156 } hitcount:    3403612

After:

 # event histogram
 #
 # trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
 #

{ delta:        113 } hitcount:        272
{ delta:        114 } hitcount:        840
{ delta:        118 } hitcount:        344
{ delta:        119 } hitcount:      25428
{ delta:        120 } hitcount:     350590
{ delta:        121 } hitcount:    1892484
{ delta:        122 } hitcount:    6205004
{ delta:        123 } hitcount:   11583521
{ delta:        124 } hitcount:   37590979
{ delta:        125 } hitcount:  108308504
{ delta:        126 } hitcount:  131672461
{ delta:        127 } hitcount:   88700598
{ delta:        128 } hitcount:   65939870
{ delta:        129 } hitcount:   45055004
{ delta:        130 } hitcount:   33174464
{ delta:        131 } hitcount:   31813493
{ delta:        132 } hitcount:   29011676
{ delta:        133 } hitcount:   22798782
{ delta:        134 } hitcount:   22072486
{ delta:        135 } hitcount:   17034113
{ delta:        136 } hitcount:    8982490
{ delta:        137 } hitcount:    2865908
{ delta:        138 } hitcount:     980382
{ delta:        139 } hitcount:    1651944
{ delta:        140 } hitcount:    4112073
{ delta:        141 } hitcount:    3963269
{ delta:        142 } hitcount:    1712508
{ delta:        143 } hitcount:     575941
{ delta:        144 } hitcount:     351427
{ delta:        145 } hitcount:     218077
{ delta:        146 } hitcount:     167297
{ delta:        147 } hitcount:     146198
{ delta:        148 } hitcount:     116122
{ delta:        149 } hitcount:      58993
{ delta:        150 } hitcount:      40228

The delta above is in nanoseconds. It brings the fastest time down from
129ns to 113ns, and the peak from 141ns to 126ns.

Link: https://lkml.kernel.org/r/20220906225529.411545333@goodmis.org

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Backport notes for 5.15:
Keep the switch-based dispatch and hist_field layout needed for
4bddcb346a6cf4615ca77f69a589623b877ca267 to apply without conflicts.
Restrict the enum and dispatcher to evaluators already supported here.
Drop changes for numeric constants, multiplication/division (including
constant-division optimizations), and relative dynamic strings, whose
implementations are absent from this stable tree.

Retain the stable expression parser, operand validation and cleanup paths;
convert its existing plus/minus assignments to the matching enum values.
No additional helper functions or missing feature implementations are
introduced beyond the dispatcher already supplied by this dependency.
The variable-reference ownership changes remain in the target commit.

Stable-dep-of: 4bddcb346a6c ("tracing: Free histogram var refs regardless of how often they are referenced")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 186 +++++++++++++++++++++----------
 1 file changed, 128 insertions(+), 58 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ecc78916431d..9596bb513ad3a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -97,6 +97,31 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+enum hist_field_fn {
+	HIST_FIELD_FN_NOP,
+	HIST_FIELD_FN_VAR_REF,
+	HIST_FIELD_FN_COUNTER,
+	HIST_FIELD_FN_LOG2,
+	HIST_FIELD_FN_BUCKET,
+	HIST_FIELD_FN_TIMESTAMP,
+	HIST_FIELD_FN_CPU,
+	HIST_FIELD_FN_STRING,
+	HIST_FIELD_FN_DYNSTRING,
+	HIST_FIELD_FN_PSTRING,
+	HIST_FIELD_FN_S64,
+	HIST_FIELD_FN_U64,
+	HIST_FIELD_FN_S32,
+	HIST_FIELD_FN_U32,
+	HIST_FIELD_FN_S16,
+	HIST_FIELD_FN_U16,
+	HIST_FIELD_FN_S8,
+	HIST_FIELD_FN_U8,
+	HIST_FIELD_FN_UMINUS,
+	HIST_FIELD_FN_MINUS,
+	HIST_FIELD_FN_PLUS,
+	HIST_FIELD_FN_EXECNAME,
+};
+
 /*
  * A hist_var (histogram variable) contains variable information for
  * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
@@ -116,15 +141,15 @@ struct hist_var {
 struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
-	hist_field_fn_t			fn;
-	unsigned int			ref;
-	unsigned int			size;
-	unsigned int			offset;
-	unsigned int                    is_signed;
 	unsigned long			buckets;
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+	enum hist_field_fn		fn_num;
+	unsigned int			ref;
+	unsigned int			size;
+	unsigned int			offset;
+	unsigned int                    is_signed;
 
 	/*
 	 * Variable fields contain variable-specific info in var.
@@ -154,14 +179,11 @@ struct hist_field {
 	unsigned int			var_str_idx;
 };
 
-static u64 hist_field_none(struct hist_field *field,
-			   struct tracing_map_elt *elt,
-			   struct trace_buffer *buffer,
-			   struct ring_buffer_event *rbe,
-			   void *event)
-{
-	return 0;
-}
+static u64 hist_fn_call(struct hist_field *hist_field,
+			struct tracing_map_elt *elt,
+			struct trace_buffer *buffer,
+			struct ring_buffer_event *rbe,
+			void *event);
 
 static u64 hist_field_counter(struct hist_field *field,
 			      struct tracing_map_elt *elt,
@@ -215,7 +237,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
@@ -229,7 +251,7 @@ static u64 hist_field_bucket(struct hist_field *hist_field,
 	struct hist_field *operand = hist_field->operands[0];
 	unsigned long buckets = hist_field->buckets;
 
-	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
 	if (WARN_ON_ONCE(!buckets))
 		return val;
@@ -250,8 +272,8 @@ static u64 hist_field_plus(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	return val1 + val2;
 }
@@ -265,8 +287,8 @@ static u64 hist_field_minus(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	return val1 - val2;
 }
@@ -279,7 +301,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	s64 sval = (s64)operand->fn(operand, elt, buffer, rbe, event);
+	s64 sval = (s64)hist_fn_call(operand, elt, buffer, rbe, event);
 	u64 val = (u64)-sval;
 
 	return val;
@@ -1159,38 +1181,32 @@ static const char *hist_field_name(struct hist_field *field,
 	return field_name;
 }
 
-static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
+static enum hist_field_fn select_value_fn(int field_size, int field_is_signed)
 {
-	hist_field_fn_t fn = NULL;
-
 	switch (field_size) {
 	case 8:
 		if (field_is_signed)
-			fn = hist_field_s64;
+			return HIST_FIELD_FN_S64;
 		else
-			fn = hist_field_u64;
-		break;
+			return HIST_FIELD_FN_U64;
 	case 4:
 		if (field_is_signed)
-			fn = hist_field_s32;
+			return HIST_FIELD_FN_S32;
 		else
-			fn = hist_field_u32;
-		break;
+			return HIST_FIELD_FN_U32;
 	case 2:
 		if (field_is_signed)
-			fn = hist_field_s16;
+			return HIST_FIELD_FN_S16;
 		else
-			fn = hist_field_u16;
-		break;
+			return HIST_FIELD_FN_U16;
 	case 1:
 		if (field_is_signed)
-			fn = hist_field_s8;
+			return HIST_FIELD_FN_S8;
 		else
-			fn = hist_field_u8;
-		break;
+			return HIST_FIELD_FN_U8;
 	}
 
-	return fn;
+	return HIST_FIELD_FN_NOP;
 }
 
 static int parse_map_size(char *str)
@@ -1677,26 +1693,26 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out; /* caller will populate */
 
 	if (flags & HIST_FIELD_FL_VAR_REF) {
-		hist_field->fn = hist_field_var_ref;
+		hist_field->fn_num = HIST_FIELD_FN_VAR_REF;
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
-		hist_field->fn = hist_field_counter;
+		hist_field->fn_num = HIST_FIELD_FN_COUNTER;
 		hist_field->size = sizeof(u64);
 		hist_field->type = "u64";
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_STACKTRACE) {
-		hist_field->fn = hist_field_none;
+		hist_field->fn_num = HIST_FIELD_FN_NOP;
 		goto out;
 	}
 
 	if (flags & (HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET)) {
 		unsigned long fl = flags & ~(HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET);
-		hist_field->fn = flags & HIST_FIELD_FL_LOG2 ? hist_field_log2 :
-			hist_field_bucket;
+		hist_field->fn_num = flags & HIST_FIELD_FL_LOG2 ? HIST_FIELD_FN_LOG2 :
+			HIST_FIELD_FN_BUCKET;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		if (!hist_field->operands[0])
 			goto free;
@@ -1708,14 +1724,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	}
 
 	if (flags & HIST_FIELD_FL_TIMESTAMP) {
-		hist_field->fn = hist_field_timestamp;
+		hist_field->fn_num = HIST_FIELD_FN_TIMESTAMP;
 		hist_field->size = sizeof(u64);
 		hist_field->type = "u64";
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_CPU) {
-		hist_field->fn = hist_field_cpu;
+		hist_field->fn_num = HIST_FIELD_FN_CPU;
 		hist_field->size = sizeof(int);
 		hist_field->type = "unsigned int";
 		goto out;
@@ -1735,12 +1751,12 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 			goto free;
 
 		if (field->filter_type == FILTER_STATIC_STRING) {
-			hist_field->fn = hist_field_string;
+			hist_field->fn_num = HIST_FIELD_FN_STRING;
 			hist_field->size = field->size;
 		} else if (field->filter_type == FILTER_DYN_STRING)
-			hist_field->fn = hist_field_dynstring;
+			hist_field->fn_num = HIST_FIELD_FN_DYNSTRING;
 		else
-			hist_field->fn = hist_field_pstring;
+			hist_field->fn_num = HIST_FIELD_FN_PSTRING;
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
@@ -1748,9 +1764,9 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		if (!hist_field->type)
 			goto free;
 
-		hist_field->fn = select_value_fn(field->size,
-						 field->is_signed);
-		if (!hist_field->fn) {
+		hist_field->fn_num = select_value_fn(field->size,
+						     field->is_signed);
+		if (hist_field->fn_num == HIST_FIELD_FN_NOP) {
 			destroy_hist_field(hist_field, 0);
 			return NULL;
 		}
@@ -2084,7 +2100,7 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 	if (!alias)
 		return NULL;
 
-	alias->fn = var_ref->fn;
+	alias->fn_num = var_ref->fn_num;
 	alias->operands[0] = var_ref;
 
 	if (init_var_ref(alias, var_ref, var_ref->system, var_ref->event_name)) {
@@ -2224,7 +2240,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 
 	expr->flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
-	expr->fn = hist_field_unary_minus;
+	expr->fn_num = HIST_FIELD_FN_UMINUS;
 	expr->operands[0] = operand1;
 	expr->size = operand1->size;
 	expr->is_signed = operand1->is_signed;
@@ -2379,10 +2395,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	switch (field_op) {
 	case FIELD_OP_MINUS:
-		expr->fn = hist_field_minus;
+		expr->fn_num = HIST_FIELD_FN_MINUS;
 		break;
 	case FIELD_OP_PLUS:
-		expr->fn = hist_field_plus;
+		expr->fn_num = HIST_FIELD_FN_PLUS;
 		break;
 	default:
 		ret = -EINVAL;
@@ -2694,7 +2710,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 		struct hist_field *var = field_var->var;
 		struct hist_field *val = field_var->val;
 
-		var_val = val->fn(val, elt, buffer, rbe, rec);
+		var_val = hist_fn_call(val, elt, buffer, rbe, rec);
 		var_idx = var->var.idx;
 
 		if (val->flags & HIST_FIELD_FL_STRING) {
@@ -3825,6 +3841,60 @@ static u64 hist_field_execname(struct hist_field *hist_field,
 	return (u64)(unsigned long)(elt_data->comm);
 }
 
+static u64 hist_fn_call(struct hist_field *hist_field,
+			struct tracing_map_elt *elt,
+			struct trace_buffer *buffer,
+			struct ring_buffer_event *rbe,
+			void *event)
+{
+	switch (hist_field->fn_num) {
+	case HIST_FIELD_FN_VAR_REF:
+		return hist_field_var_ref(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_COUNTER:
+		return hist_field_counter(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_LOG2:
+		return hist_field_log2(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_BUCKET:
+		return hist_field_bucket(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_TIMESTAMP:
+		return hist_field_timestamp(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_CPU:
+		return hist_field_cpu(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_STRING:
+		return hist_field_string(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DYNSTRING:
+		return hist_field_dynstring(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_PSTRING:
+		return hist_field_pstring(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S64:
+		return hist_field_s64(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U64:
+		return hist_field_u64(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S32:
+		return hist_field_s32(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U32:
+		return hist_field_u32(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S16:
+		return hist_field_s16(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U16:
+		return hist_field_u16(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S8:
+		return hist_field_s8(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U8:
+		return hist_field_u8(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_UMINUS:
+		return hist_field_unary_minus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_MINUS:
+		return hist_field_minus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_PLUS:
+		return hist_field_plus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_EXECNAME:
+		return hist_field_execname(hist_field, elt, buffer, rbe, event);
+	default:
+		return 0;
+	}
+}
+
 /* Convert a var that points to common_pid.execname to a string */
 static void update_var_execname(struct hist_field *hist_field)
 {
@@ -3836,7 +3906,7 @@ static void update_var_execname(struct hist_field *hist_field)
 	kfree_const(hist_field->type);
 	hist_field->type = "char[]";
 
-	hist_field->fn = hist_field_execname;
+	hist_field->fn_num = HIST_FIELD_FN_EXECNAME;
 }
 
 static int create_var_field(struct hist_trigger_data *hist_data,
@@ -4596,7 +4666,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
+		hist_val = hist_fn_call(hist_field, elt, buffer, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
@@ -4627,7 +4697,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 	for_each_hist_key_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
+			hist_val = hist_fn_call(hist_field, elt, buffer, rbe, rec);
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
 		}
@@ -4704,7 +4774,7 @@ static void event_hist_trigger(struct event_trigger_data *data,
 					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, elt, buffer, rbe, rec);
+			field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
-- 
2.53.0

