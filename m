Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024573;
	b=QFN59yDt+t17o3QMjPov3ZVp1qY8/2/gooLczdCXyjUnCuY5JmEEwfhO0nIMJGsa9Xqe
	 bXiqr/98Zcv6ehKJAlGZ5N5PrqTVecEZxDkagG65huv8ik9dAfa8+skEJkm5yeuCO4Mgd
	 YhyJ09e4fRysb1LHv186GkKydNoS4kXC4KO26hZS3lM/7+sLzk9au2JFxpdwCT2VCrCp/
	 aW2cGood+XjTnP9JXVDUr2KdqJvqWmKQNLBdC/XUPlZet2F4osiRV6xNosuQKlds4ViPn
	 ssGKKa2+XxqMl/BU9iKvu8BnTrfvL46Wq6uiI2iRhvWmd7YQOR+oRv1fuwitbeInyfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1UtlG/I50/AGyhCzapfCShuG8oAfU+hAtrPZyA2cTAU=;
	b=wuc5N/+84QTtu09w5gaOFKEHaaG8MF0ywFr9cNDIC9NknQp/zIJL04VMwHUkhfnoQHbd
	 AKnnudjYNr8CgsqeTv1ucnu4wx4977NXR3siZaSwLkmmOgwwwSewOQ3wVPVHV6U+/y0Nc
	 drBve/WHxf8T9kJO6DM5cECsP5pg9taNDrGdc960WWDIwPKE5CxM/ZWg7TYvpLmhXxVho
	 dTSAFbEbVSY9FAPc3m3AI7wruvwpRalZP3wAtWWRJrjJ+Z4OJ6YcJ8Ivma6JPsRt9yuk1
	 mDyRFFot0SDWkgNCzfghD/peITSPc6cMORfdlWN5wI82M6n+PHGw7EfLcATI0xPAkpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCUcS+7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01266606A326;
	Mon, 26 Oct 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCUcS+7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F31F01828;
	Mon, 26 Oct 2026 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024572;
	bh=1UtlG/I50/AGyhCzapfCShuG8oAfU+hAtrPZyA2cTAU=;
	h=From:To:Cc:Subject:Date;
	b=iCUcS+7P9f6/HxtuTfZcbpU43fdlBII3hHFl77wd+3Q1E+bUnhF1WLwvbDaqyJVtO
	 F2rg4dushI4Qdqry2wT69iw+NHWJMB5MSPy4H9ldS+zuGMxW7JMNEFLBtSjKptidM+
	 q+9bZ/aJ1BiEAwMoznAY2kwLuqPdiuMAxxOi5RSxTUClLQetNLIw5Rd5OHs4LqZbHL
	 CKWsBg8fVkO9ycnnpZ5S1hxyhxy3k9oSsNWwK3DzkBB6v7tpIH65cNsW8WmMInYLMG
	 jr8Lkhfu4/4DCR1UCIuKVnMGE+4HZRx/wBrOkE64I7gfRRoTZk15j1orHWTTNNOr6N
	 Opl3xIx2DSczw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [STABLE v6.1-v5.10] tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
Date: Mon, 26 Oct 2026 14:22:47 +0000
Message-ID: <20261026142248.3526008-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
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
[Lee: Omit create_var_field() and hist_trigger_elt_update() hunks as
      288709c9f3b0 ("tracing: Allow stacktraces to be saved as histogram
      variables") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8e5efdfa0fc7..b8fb45fa3cfc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2066,7 +2066,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -3203,6 +3204,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret =  -ENOMEM;
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var->var = var;
 	field_var->val = val;
@@ -3820,7 +3822,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
-- 
2.56.0.257.gf7497c7d27-goog

