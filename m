Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F73B9617
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327078; cv=none; b=LSNBQy/b6HI4v4v1FGI7iVWOmAdrImn9hTGQT2iVWQjmLbtSdxCd6T8oiZJ4rG2CMjI4t4lvFOZoSiMYKVj7yus8tiaRfAPyzQpSCZzbK9fDZRFMZd6ckBUy6uDmO8l+bzIqeFzqkDODv4jSwyw+VEZhrY5UKY4GHeEOP8Udcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327078; c=relaxed/simple;
	bh=LtqBfUkMehdLjlMovd2yp1Je0fkDCULYYEXjSV5piI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSu4L4KkTEpcy2E7u2b785YZpN2qBwWu2xUr+Jgg1YB8DlhigDOu27tIylXp2ppQU5MwTXq8gO5ny9+1uRsz3bo8KvHKw9MwYML9/+HvfD0kGYxcKwNUNKxc6I1uD05ACNqkS1tv43r+jc5k2MNok6WinoQ11JtXAGOl3DVUfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=BWfwbuxv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="BWfwbuxv"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-49de8ea072cso480331fac.3
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327077; x=1791931877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToOAV8TgXOyA3LFSl1CewS9crYTHWwfFriGHE0UgWII=;
        b=BWfwbuxvN9LUh+2X334METZu5dlDr+Yam/WtnQ2QsYCWZ5dI5k2aJArNOAvZODtH9V
         qorwBWxJcpv5G3MoupOkoJAduht0U0iwb40Z3FejLAIxZQokZpTlvAmW+Ul/18hr6AJ/
         h/1skRxrJOu2W5nuj2HKSq7igH2iE/hGxbfUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327077; x=1791931877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToOAV8TgXOyA3LFSl1CewS9crYTHWwfFriGHE0UgWII=;
        b=XyXgH2pbuXrcG4+ZK++x4zd9W/gaYdNX7mrXdwTx3EGkIoePQthdalRb41CQoK9KVE
         mcqByRuFlbg5aDL+pS7CX53Y149+W++cR8HxSUSdr89584mwwV7fJqJK1KA6lzcMYGqJ
         0go4IuqNXo+gqnA9z0I/FzNZNkke+0ROEjWjgBZ8YfC4jFDhrDZzK0j2+3kMhy3C4c/a
         xDYJBE/kUSFKAx2mUfiYNlkzBZdOKdqrDunk6aKSsJ+5ZcBBdij2YLE7T6n5ULfgcf9e
         ZW/6oyZIjBoNOr7pL/0VyRYqFkzfCSYvSitXADmkoS76ABwcUSzHI75NhwJCJWjTahkJ
         F7bQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9CUdstbttJdgHLgh5x/6uZ7YOxxs98JrmiDPlJOu6Y66zcqWejSqPV8cdqCLGzbxLZPurn7c=@vger.kernel.org
X-Gm-Message-State: AFuF++nnrh8PT0K79BQPWr+sV4wbuQMF/hj1xT2pxCGG7lpUQMXBmyLR
	71yjk0/kJh8TJG+cT22rYKzjQcVS7ibXE9MYyxEG8xPHlxyZGB2KZVSS4xFGI/H4qFE=
X-Gm-Gg: AYBFou2/MD6wfoOCgrC9HXBFQqSNaJcYEaT8gukVDKscq00M/pv/9zaqJ8DZzLQiIlp
	YWXlaLKEpUxxA0VZLPiBvIYex9AC4rBmHN7qsbUEsKeiln+qzyFp+T/p6mn7NrBbLgeT0fyak6s
	lSYYJh8zN4QqfKtA4d1vGRB6MOv3wqxNjbNs+aVnLYWD1W8McrwE7o9DUOMFaW8lyLaRBuWcj8m
	W217Jqjbo28g5z1zW5TXC1hBKnGVHA2xcOHfPH2R/bpoWTZ4+09+N3ij2EGI72SaRh8ZTQubo3Z
	k/fWfmcb65W2x5DEgbLQYGV4nZ7++dIjz8wmEYQPZ/iDN+GXsPjGiA6YADpd3onOotHuE/zzO5E
	X8ttYm+XujRBttajSOn43fGZBJG0D9Yleyx7chXlg59r2NBJAbFcKS644JgrQ0/AfefKwqJObV4
	z4KKPpPhwDfrUAfro65i2xTPnnB1VvvGvE3tziClvn6+4R5lGUq1v/iVPSvOC1kD8ttFR4qLCIT
	z6IhN5toDnC+JhA9L1O9M0rgNi/wmDxuKAZx/E/+Hf3SABuA3VJhnyR+XdujZbUtScsHso7BXv6
	mFd80Yrmqg==
X-Received: by 2002:a05:6870:ab08:b0:42c:49c7:a499 with SMTP id 586e51a60fabf-4a25920b9c7mr482958fac.3.1791327076582;
        Tue, 06 Oct 2026 15:51:16 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a257228c01sm638027fac.14.2026.10.06.15.51.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:51:16 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/filters: Check perf permissions before resolving .function
Date: Tue,  6 Oct 2026 15:51:12 -0700
Message-ID: <20261006225112.53503-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_trace_event_perm() allows tracepoint counters that do not request
PERF_SAMPLE_RAW without raw tracepoint permissions. A self-targeted,
disabled event with exclude_kernel=1 can therefore reach the filter
compiler even at perf_event_paranoid=2.

The .function suffix accepts any field of sizeof(long) and resolves its
operand through kallsyms_lookup_name() and kallsyms_lookup_size_offset().
The success or failure of a numeric filter discloses whether an address
belongs to a known kernel symbol range. On x86-64 this can be used to
recover the randomized kernel image base. A named filter also exposes
the resolved symbol range through the counter when the tracepoint field
is controlled by the caller, as with a syscall argument.

Pass the filter's perf origin to the predicate parser and require
perf_allow_tracepoint() before resolving a .function operand. This uses
the same sysctl, initial-namespace capability and LSM policy as raw
tracepoint access, and closes both the numeric and named-symbol oracles.
Do not change ordinary perf counting filters or filters created through
the separately controlled tracefs interfaces.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace_events_filter.c | 39 ++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..0f8c2054f4a7 100644
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
@@ -1683,6 +1689,14 @@ static int parse_pred(const char *str, void *data,
 
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
+		/* Even counting filters can disclose kernel addresses. */
+		if (pdata->is_perf) {
+			ret = perf_allow_tracepoint();
+			if (ret) {
+				parse_error(pe, ret, pos + i);
+				return ret;
+			}
+		}
 		function = true;
 		i += len;
 	}
@@ -2205,8 +2219,12 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
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
@@ -2232,7 +2250,7 @@ static int process_preds(struct trace_event_call *call,
 		return -EINVAL;
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
-			       parse_pred, call, pe);
+			       parse_pred, &data, pe);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
@@ -2281,7 +2299,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter->filter_string)
 			goto fail_mem;
 
-		err = process_preds(file->event_call, filter_string, filter, pe);
+		err = process_preds(file->event_call, filter_string, filter, pe, false);
 		if (err) {
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
@@ -2377,6 +2395,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * @call: trace_event_call to create a filter for
  * @filter_string: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
+ * @is_perf: filter is being created for a perf event
  * @filterp: out param for created filter (always updated on return)
  *           Must be a pointer that references a NULL pointer.
  *
@@ -2391,7 +2410,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  */
 static int create_filter(struct trace_array *tr,
 			 struct trace_event_call *call,
-			 char *filter_string, bool set_str,
+			 char *filter_string, bool set_str, bool is_perf,
 			 struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
@@ -2405,7 +2424,7 @@ static int create_filter(struct trace_array *tr,
 	if (err)
 		return err;
 
-	err = process_preds(call, filter_string, *filterp, pe);
+	err = process_preds(call, filter_string, *filterp, pe, is_perf);
 	if (err && set_str)
 		append_filter_err(tr, pe, *filterp);
 	create_filter_finish(pe);
@@ -2418,7 +2437,7 @@ int create_event_filter(struct trace_array *tr,
 			char *filter_str, bool set_str,
 			struct event_filter **filterp)
 {
-	return create_filter(tr, call, filter_str, set_str, filterp);
+	return create_filter(tr, call, filter_str, set_str, false, filterp);
 }
 
 /**
@@ -2476,7 +2495,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 		return 0;
 	}
 
-	err = create_filter(file->tr, call, filter_string, true, &filter);
+	err = create_filter(file->tr, call, filter_string, true, false, &filter);
 
 	/*
 	 * Always swap the call filter with the new filter
@@ -2721,7 +2740,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	if (event->filter)
 		return -EEXIST;
 
-	err = create_filter(NULL, call, filter_str, false, &filter);
+	err = create_filter(NULL, call, filter_str, false, true, &filter);
 	if (err)
 		goto free_filter;
 
@@ -2868,7 +2887,7 @@ static __init int ftrace_test_event_filter(void)
 		int err;
 
 		err = create_filter(NULL, &event_ftrace_test_filter,
-				    d->filter, false, &filter);
+				    d->filter, false, false, &filter);
 		if (err) {
 			printk(KERN_INFO
 			       "Failed to get filter for '%s', err %d\n",

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
