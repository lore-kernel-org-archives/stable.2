Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C93D45F4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349406; cv=none; b=Rza8tee4bTo82oybYeuPylXQlZB5bzLvh87DX59OKhwfNcM4a+/mWNYqWaKUnMgAms2w7ZEqusp1Qb4seDPGBqea0tRFxz923K8JOpehmDs7yGX2dIiPlgpXYldZMOUNqtATgvTcHH9bm1sxIdMFLJUWIOAR6Ko1xQluRYuh8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349406; c=relaxed/simple;
	bh=2xFrY7BGe4dGVsrgnRpdoh/SZXPw4g2jRk6yGOXKQrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR969Wer5q41CIrR3xbOXm8yFaSqSevnM1yxro26QcH2JoEUmLqPTGlcvHPqBa+o4EqSioRyHFmKgCAa7leWe2l0OSLpI+Pf7SBGlKE7xjJwEGACs+p0vDOT5ClDzdpc1FUdwl6cKqaSwmVRYFzObdi+zedchMNPI9t3cLO3gEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=X0ogNrCD; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="X0ogNrCD"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-82503732024so595204a34.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 22:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791349403; x=1791954203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=amWm7rhDqpybZwDdXjCeI1rmEdf0wmiwfyrZDawQrxU=;
        b=X0ogNrCDYQLG4uIXJBNpr+fdxSxz5YVic6Fs99W+roRjZwjMVfYEfGAoZwxnyk4T3v
         k8uS93zm5izlitbvdrfLnpZo3NAzowLdjbEZAesgHg1KuO62Nu/w2ca9dSj5r2LFNiXY
         7GBgECUhY5jPpuQAGTgmWaYy634SmtrOSXNp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791349403; x=1791954203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amWm7rhDqpybZwDdXjCeI1rmEdf0wmiwfyrZDawQrxU=;
        b=lHBtBjI0L46iwhEH9mYL0rlqwNa+OilGuiX0wf8nEoNzdbmRLT+gDaC6yTy4nN/yra
         dB52Tt/JlPThLR2dhDqKy3/mfdx6NFvG3edUDkyvDMbYfjNB5gLwJUHmizo1aZL3rtKM
         4stAnUiA/SdOfZHyUshSM/UoJXavD3mhCcipp52UQxvC4rUfQykQzIsJLz28Px9L691j
         THvWZ+U3cQLxUHSUr0iHCS2SiTTr8e/nQdcVmjMY55M4ITUC2DvYOn336orCRiJFC8eI
         YXvvjmgs5eCM8/SYkVEqWnMvpCukmISihvaUP01TukmnABGzbiONRVrMLleyOLZjvl5x
         3WIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbXb0iEnoaEtgYccqaCYM9Vdve5lkOlBSqxaiOJifLUCMvHNwUWj3iLXiTiBUYs4zFrCb7T30=@vger.kernel.org
X-Gm-Message-State: AFuF++kNK8Ropvgy/VNgC1g9jwhyTVjKePXPPo7YVZxvwdYQ590FO6F1
	lmyYxPbyuoaLQuUZ5jeKmy109KMEtM4qWSLp1cq2EiCybiGDTQCqWv1x/DcJNuo768g=
X-Gm-Gg: AYBFou0bZuw8qyb+5fFMQomEmJh9H7tBtbvqEARRdJeCodSKgsMQfXYNFM4La0itwLe
	Hf6YNYZN79/uixAQIyKWn2edYQMBnMEBebCGEN/yClNHZn6dp4BgQcQqyL81LmN446pT1nJuYpJ
	DzOpEmyT+8B+lTZ/H6rvZe/X3nEpxy9b9CVLhXj0rsvXP5PBtWoCuuYPO3YLbn4s1HDUhkUM87+
	ZuCImwr9h9F8UBsBshhkRwR5cgSPjTfgAcHNyYzZ8h1ZES6aFreuapYfUrDttosTlkQGU7gTgCC
	IXrvqbnn4ZBWx0xHQx8c0xotR+KyMwlEz4MbUDlRA0zIrsz/Ya/0UFOyDOpqiJdWXQOo7MvNKoz
	wC+WfFmZELMD0wK3YKGrespqfu72nEEOYdLDaOW0qQZRrA9SxTgTJ7hNTMIrQif2b1RBphkFjG5
	AFNgZtSIGnivEydMU9KDGGi7k/JP4HOQOKUDHxnCMUyYokAvjWF8S7drTRw1w752Ys0nEnQ1urv
	8L8IGYDBBbTzrlY7bIrJM/IXGq4n//VZt8thWOGpku7E5bI3v1VjLeKtXFXi5C61BZE1rawiGw=
X-Received: by 2002:a05:6830:4906:b0:823:e626:2765 with SMTP id 46e09a7af769-82ad0acd461mr2158934a34.31.1791349402837;
        Tue, 06 Oct 2026 22:03:22 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3f12f0sm1578270a34.13.2026.10.06.22.03.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 22:03:21 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/filters: Check perf permissions before accessing kernel data
Date: Tue,  6 Oct 2026 22:03:15 -0700
Message-ID: <20261007050315.65139-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_trace_event_perm() allows tracepoint counters that do not request
PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted
event with exclude_kernel=1 can therefore reach the filter compiler even
at perf_event_paranoid=2.

The .function suffix resolves its operand through kallsyms. The result
of a numeric filter discloses whether an address belongs to a known
kernel symbol range, allowing the randomized kernel image base to be
recovered. A named filter also exposes the resolved range through the
counter when the tracepoint field is controlled by the caller.

Pointer-string filters expose kernel memory in the same way. A caller
can supply a kernel address as the filename argument to openat() and
install a string filter on sys_enter_openat. Without .ustring, the
filter uses strncpy_from_kernel_nofault() on that address. Whether the
counter increments reveals whether the kernel bytes match the pattern.
The nofault copy prevents faults but does not authorize disclosure.

Pass the filter's perf origin to the predicate parser and require
perf_allow_tracepoint() before resolving a .function operand or creating
a kernel-pointer string predicate. This uses the existing sysctl,
initial-namespace capability and LSM policy for raw tracepoint access.
Keep ordinary counting filters, explicit user-string predicates and
filters created through the separately controlled tracefs interfaces
unchanged.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Fixes: 5967bd5c4239 ("tracing: Let filter_assign_type() detect FILTER_PTR_STRING")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v2:
- Require raw-tracepoint permission for kernel-pointer string filters
  as well as .function predicates, preserving explicit .ustring filters.
- Add the pointer-string Fixes tag and describe the confirmed
  sys_enter_openat counter oracle.

 kernel/trace/trace_events_filter.c | 41 ++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..84d4a4fe56ad 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1625,12 +1625,18 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 	}
 }
 
+struct filter_parse_data {
+	struct trace_event_call *call;
+	bool is_perf;
+};
+
 /* Called when a predicate is encountered by predicate_parse() */
 static int parse_pred(const char *str, void *data,
 		      int pos, struct filter_parse_error *pe,
 		      struct filter_pred **pred_ptr)
 {
-	struct trace_event_call *call = data;
+	struct filter_parse_data *pdata = data;
+	struct trace_event_call *call = pdata->call;
 	struct ftrace_event_field *field;
 	struct filter_pred *pred = NULL;
 	unsigned long offset;
@@ -1687,6 +1693,16 @@ static int parse_pred(const char *str, void *data,
 		i += len;
 	}
 
+	/* Even counting filters can disclose kernel addresses and data. */
+	if (pdata->is_perf &&
+	    (function || (!ustring && field->filter_type == FILTER_PTR_STRING))) {
+		ret = perf_allow_tracepoint();
+		if (ret) {
+			parse_error(pe, ret, pos + i);
+			return ret;
+		}
+	}
+
 	while (isspace(str[i]))
 		i++;
 
@@ -2205,8 +2221,12 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
 static int process_preds(struct trace_event_call *call,
 			 const char *filter_string,
 			 struct event_filter *filter,
-			 struct filter_parse_error *pe)
+			 struct filter_parse_error *pe, bool is_perf)
 {
+	struct filter_parse_data data = {
+		.call = call,
+		.is_perf = is_perf,
+	};
 	struct prog_entry *prog;
 	int nr_parens;
 	int nr_preds;
@@ -2232,7 +2252,7 @@ static int process_preds(struct trace_event_call *call,
 		return -EINVAL;
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
-			       parse_pred, call, pe);
+			       parse_pred, &data, pe);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
@@ -2281,7 +2301,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter->filter_string)
 			goto fail_mem;
 
-		err = process_preds(file->event_call, filter_string, filter, pe);
+		err = process_preds(file->event_call, filter_string, filter, pe, false);
 		if (err) {
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
@@ -2377,6 +2397,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * @call: trace_event_call to create a filter for
  * @filter_string: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
+ * @is_perf: filter is being created for a perf event
  * @filterp: out param for created filter (always updated on return)
  *           Must be a pointer that references a NULL pointer.
  *
@@ -2391,7 +2412,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  */
 static int create_filter(struct trace_array *tr,
 			 struct trace_event_call *call,
-			 char *filter_string, bool set_str,
+			 char *filter_string, bool set_str, bool is_perf,
 			 struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
@@ -2405,7 +2426,7 @@ static int create_filter(struct trace_array *tr,
 	if (err)
 		return err;
 
-	err = process_preds(call, filter_string, *filterp, pe);
+	err = process_preds(call, filter_string, *filterp, pe, is_perf);
 	if (err && set_str)
 		append_filter_err(tr, pe, *filterp);
 	create_filter_finish(pe);
@@ -2418,7 +2439,7 @@ int create_event_filter(struct trace_array *tr,
 			char *filter_str, bool set_str,
 			struct event_filter **filterp)
 {
-	return create_filter(tr, call, filter_str, set_str, filterp);
+	return create_filter(tr, call, filter_str, set_str, false, filterp);
 }
 
 /**
@@ -2476,7 +2497,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 		return 0;
 	}
 
-	err = create_filter(file->tr, call, filter_string, true, &filter);
+	err = create_filter(file->tr, call, filter_string, true, false, &filter);
 
 	/*
 	 * Always swap the call filter with the new filter
@@ -2721,7 +2742,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	if (event->filter)
 		return -EEXIST;
 
-	err = create_filter(NULL, call, filter_str, false, &filter);
+	err = create_filter(NULL, call, filter_str, false, true, &filter);
 	if (err)
 		goto free_filter;
 
@@ -2868,7 +2889,7 @@ static __init int ftrace_test_event_filter(void)
 		int err;
 
 		err = create_filter(NULL, &event_ftrace_test_filter,
-				    d->filter, false, &filter);
+				    d->filter, false, false, &filter);
 		if (err) {
 			printk(KERN_INFO
 			       "Failed to get filter for '%s', err %d\n",

base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
