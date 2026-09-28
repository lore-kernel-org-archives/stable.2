Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com [74.125.229.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC736B921
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553660; cv=none; b=XAM/o9T6/ZqAZUYJsW6pWJ67aoq7P++0ZYA4OGqbZwT4+O7BA+z5f5td78RfY32a+J+YFRrV9pUdgS3UZiDP6SIpr5QcPtixwis4D9Q4DWH/Cd3VVxNc8JKPuuWy68JbORXjQ/VJ/CIID6fhLC7MrkUUjsz47d6gfPpvNfFqi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553660; c=relaxed/simple;
	bh=xWkv0NihhCtba8cbXTsytw0F5OHSkub8FBy2TOh+/n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tocyS5+u3BiSkckYYvG7wntIZhv8R+9vfqcXkzPaQnuSswMFqHIXmvKIg4BS4IMIEia4cxr5GT9QmOhlxhS9uxsxYeOCc+zNMWEoLKv+qy3cRvAT2robVblRgmUjh4zqvy3bWLOtyqQclVhGXnFrNUgqe8RWj40NUNcS98GHQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlHGzwzX; arc=none smtp.client-ip=74.125.229.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlHGzwzX"
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so2072699c88.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790553654; x=1791158454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5cgQdvrBNSADM3zuXYKc6bozW58YifUapijoQlKriE=;
        b=JlHGzwzXcrQgKJrInmJDcWONF29/yJ5zQZsQFMI7jKts8OntGJ5IGd3ns6kdCLRe+r
         w8dH3kBwL5f9xI6N0FgA19j10pdgz2/s8EbZb2vz4A1njy90UW2sEQ7sfgeT9ohkkpjQ
         VrlbKsdFBQWm7epF0smaBbd/AzfNpMcp7Ywk6z0mAZa+JwP9vEzucx2jPvmKCcVHTKJ3
         KJIvQx15E3/uFjggBswfUWW36oAB3zYSTL7EFIR5ih62MLBwVbzaEgqQnPlqicb/ZAF8
         cTwOQOcarP88rG4fL2SA5C6jirCNWYM97h7zDPMe5zGy9kcAB9ZSGjTb4eGWyE8NRAq5
         JOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790553654; x=1791158454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5cgQdvrBNSADM3zuXYKc6bozW58YifUapijoQlKriE=;
        b=YcsBbDNauRmpQ2FIAX+CoaGNQD5xoIi+Lq6GXemYlw0YiOG5/drmXiBNNDEy3dPnvr
         juz6w+JysSeFeDW4lw3NNDz7aEHTQv3WrpArfeBv1dc5T56ZBaSO/Fhelj5neFQwhyG8
         yQpew9h7pEZ3HJydSaayPIz3wYasbehoQUGlYgNenaA6ULA3XNWZCtDrJfT/5eiA3O3w
         6BpmZ+rp7c9nZ8GtDGppKyseVFJLGZCWZI6BFg+DNJYkE3sKl/K0pmhytZoHe+qyJzAH
         2QCipTqUON9HaoPDeXzo+H6jutaUSeIcxNJr9uONd+6i4kEcyYSXUfdt0WTkzNUwha+d
         zwlg==
X-Forwarded-Encrypted: i=1; AKwUvByHl11CdNmh3Ed570UA3UJj+5x+bI4FzLEzCDepKfwxxCdf8l73yKOuxQfso4hVrctbCmsyCMI=@vger.kernel.org
X-Gm-Message-State: AFuF++lrPge/IQY47NOIEs5s5NvqZ0DnNHwA+YszWM0u9b0iqJh+X7w8
	02j2W0kBWHX7SQeXhvMiveKMqWUSVka4QYLFmuvKKzdP1qvu+r0012TN
X-Gm-Gg: AYBFou3PeWc0SnGQE26kFSrtNusrKPVdebwZ7/YxIESeHUKekC0vho9BqvW0mBnE2A5
	rqgUarxN4bflYfjY470CpWC+YViAdXOT00HpOR2GXs20vBU0FtyFXfwZa72JKvbdMV1s0bEOgm7
	Q6d8fB7IMMQPB52jtLeKjf+eNJ18aEf80pCNpVY1dUqmvEaBeS8yVm69u2PjFRpaBmJfYnDNS7M
	3jg7HQ/wN9GUeSd2nskxJprVGBLjAxwpDRzzujg7d6jAq9iF64OI1s3AZyHgwu7M8qb+Ov6wDH3
	I993+XwIuY0/UazO6jadVX6oOrjmcQ/wgEchHjlu7dArOqzGzi+VAt+hC4j2CGMxJL5KpmHOOt3
	By2vWP+VurfKtnqEd4bk5WLiW3zG1f62OYMYWs2b8fSEwL8TYvtBcPSWuY1cullp8KdL2KXRwX2
	pv/zegOxFBjnc2h96y20eZnJIWQmBoWLoFqsdlOCtV6e1YCs6XrGqPHs0e3vGvtFW/+aM5uIJHq
	BarZobPfk+itIvwDM4=
X-Received: by 2002:a05:701b:2406:b0:138:243e:ceb1 with SMTP id a92af1059eb24-146ce1a9961mr7838998c88.6.1790553654259;
        Sun, 27 Sep 2026 17:00:54 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm23752109c88.6.2026.09.27.17.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:00:53 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ross Zwisler <zwisler@google.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH 1/1] tracing: Require tracepoint permission for perf function filters
Date: Sun, 27 Sep 2026 17:00:31 -0700
Message-Id: <95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790553331.git.zcliangcn@gmail.com>
References: <cover.1790553331.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count-only perf tracepoint events can be opened without tracepoint
permission because they do not sample raw event data. Their SET_FILTER
ioctl still parses .function predicates. Numeric operands call
kallsyms_lookup_size_offset(), making ioctl success an oracle for
recovering the randomized kernel text base. Symbolic operands resolve
hidden symbol addresses and can also match user-controlled event fields
against those addresses.

Pass the perf origin through filter parsing and require
perf_allow_tracepoint() before resolving either form of .function
operand. Ordinary perf count filters and tracefs event filters retain
their existing behavior.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
 kernel/trace/trace_events_filter.c | 39 ++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..f99b0f1e32d8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1625,12 +1625,18 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 	}
 }
 
+struct event_filter_parse_data {
+	struct trace_event_call *call;
+	bool from_perf;
+};
+
 /* Called when a predicate is encountered by predicate_parse() */
 static int parse_pred(const char *str, void *data,
 		      int pos, struct filter_parse_error *pe,
 		      struct filter_pred **pred_ptr)
 {
-	struct trace_event_call *call = data;
+	struct event_filter_parse_data *parse_data = data;
+	struct trace_event_call *call = parse_data->call;
 	struct ftrace_event_field *field;
 	struct filter_pred *pred = NULL;
 	unsigned long offset;
@@ -1686,6 +1692,12 @@ static int parse_pred(const char *str, void *data,
 		function = true;
 		i += len;
 	}
+	if (function && parse_data->from_perf) {
+		/* Both numeric and symbolic operands resolve kernel addresses. */
+		ret = perf_allow_tracepoint();
+		if (ret)
+			return ret;
+	}
 
 	while (isspace(str[i]))
 		i++;
@@ -2205,8 +2217,13 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
 static int process_preds(struct trace_event_call *call,
 			 const char *filter_string,
 			 struct event_filter *filter,
-			 struct filter_parse_error *pe)
+			 struct filter_parse_error *pe,
+			 bool from_perf)
 {
+	struct event_filter_parse_data data = {
+		.call = call,
+		.from_perf = from_perf,
+	};
 	struct prog_entry *prog;
 	int nr_parens;
 	int nr_preds;
@@ -2232,7 +2249,7 @@ static int process_preds(struct trace_event_call *call,
 		return -EINVAL;
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
-			       parse_pred, call, pe);
+			       parse_pred, &data, pe);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
@@ -2281,7 +2298,8 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter->filter_string)
 			goto fail_mem;
 
-		err = process_preds(file->event_call, filter_string, filter, pe);
+		err = process_preds(file->event_call, filter_string, filter, pe,
+				    false);
 		if (err) {
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
@@ -2377,6 +2395,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * @call: trace_event_call to create a filter for
  * @filter_string: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
+ * @from_perf: require tracepoint permission for function predicates
  * @filterp: out param for created filter (always updated on return)
  *           Must be a pointer that references a NULL pointer.
  *
@@ -2391,7 +2410,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  */
 static int create_filter(struct trace_array *tr,
 			 struct trace_event_call *call,
-			 char *filter_string, bool set_str,
+			 char *filter_string, bool set_str, bool from_perf,
 			 struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
@@ -2405,7 +2424,7 @@ static int create_filter(struct trace_array *tr,
 	if (err)
 		return err;
 
-	err = process_preds(call, filter_string, *filterp, pe);
+	err = process_preds(call, filter_string, *filterp, pe, from_perf);
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
-- 
2.34.1

