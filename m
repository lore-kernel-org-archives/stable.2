Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8D34EEEE;
	Tue, 29 Sep 2026 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683476; cv=none; b=BISrcKwFb8tM7TTa3Gs/4sq7Lsiw00mUABmkOUoDk8Qre428MgtikYWNf2sAa4Ev7l8aQAGviiNTlQV/ixn5t9p6Uzh+dmzKDgLKlECV5Fl3NVD8kYvMnYr4Sz1mOCMKjAvZgz6WCbh8AdtXcGrjT/Woaf39ycXwp8JkAW1CtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683476; c=relaxed/simple;
	bh=1y76855U6ChdIrhrqweUZHPoC7pVIbY69wDQlNdEx1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9uBvSd4bOZhoT+Pubk7YDzlQ3SGK/Hcuk8j9iNU5bGUc2cw4KdST2Kexz8nLJwyglUSuIBhRpfXhA/Fjz4MZ8HxyJXY4ksRKCssnpegPyxoC96fkROthFGupvkARFWpk88aH7obEqmksolADDzKBfPmHq05bRxbF6fe0rijbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ih+isx6z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ih+isx6z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gwtnzsRCmg/KlI6wP8v+iy295jBczPbk3ZA5tWfqhFU=; b=Ih+isx6zVuklPt3zqlYuYMHcDJ
	Z+oJjTxwVPT2IfD2qzUkUBeXDQJjQGx60kF14PoAR6gatbxEs4IOr5cJ0jzWg06PQPFIpBYgOgq84
	1y/kPBdrHZYlj5clLymuiY3LfcGJdCK5ukJwPprqV5QPZ9+R2+BSGnC5R0/WFWL6FAn05DBHJRF3Q
	aXAISh8JNzXK99pwcoVJx8APQhd6hDdxlP2Fj+PdjkZasQkOtGmM7E+htVDfWliWGMTbOnz4SB67h
	ZJEi3+tu5kivXfje569oEmyGkunPMVVo3GABtfbxsI5sGs2bheSTj+O1aquxVwelIrlDUikLmLAJP
	MPSuXVbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBWZH-00000002aLG-2A5m;
	Tue, 29 Sep 2026 12:04:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0029F300AAD; Tue, 29 Sep 2026 14:04:17 +0200 (CEST)
Date: Tue, 29 Sep 2026 14:04:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] perf/core: Restore header fields in sideband output
 callbacks
Message-ID: <20260929120417.GT4120091@noisy.programming.kicks-ass.net>
References: <20260929014206.4175245-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929014206.4175245-1-irogers@google.com>

On Mon, Sep 28, 2026 at 06:42:06PM -0700, Ian Rogers wrote:
> perf_iterate_sb() invokes its callback for each matching perf_event on
> the CPU and task context, passing a shared caller-allocated event
> structure.
> 
> perf_event_header__init_id() increments header->size by
> event->id_header_size. Unlike perf_event_task_output(),
> perf_event_comm_output(), perf_event_namespaces_output(),
> perf_event_cgroup_output(), perf_event_mmap_output(), and
> perf_callchain_deferred_output(), three sideband callbacks failed to
> save and restore header.size around perf_event_header__init_id():
> - perf_event_ksymbol_output()
> - perf_event_bpf_output()
> - perf_event_text_poke_output()

I also found perf_event_switch_output(). Does something like so also
work?

---
 kernel/events/core.c | 131 ++++++++++++++++++++++++---------------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index de05df65ab3d..28770ca689c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9108,12 +9108,22 @@ perf_event_read_event(struct perf_event *event,
 	perf_output_end(&handle);
 }
 
-typedef void (perf_iterate_f)(struct perf_event *event, void *data);
+typedef void (perf_iterate_f)(struct perf_event *event, struct perf_event_header *header);
+
+static __always_inline
+void __perf_iterate_output(perf_iterate_f output,
+			   struct perf_event *event,
+			   struct perf_event_header *header)
+{
+	struct perf_event_header old = *header;
+	output(event, header);
+	*header = old;
+}
 
 static void
 perf_iterate_ctx(struct perf_event_context *ctx,
 		   perf_iterate_f output,
-		   void *data, bool all)
+		   struct perf_event_header *header, bool all)
 {
 	struct perf_event *event;
 
@@ -9125,11 +9135,11 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 				continue;
 		}
 
-		output(event, data);
+		__perf_iterate_output(output, event, header);
 	}
 }
 
-static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
+static void perf_iterate_sb_cpu(perf_iterate_f output, struct perf_event_header *header)
 {
 	struct pmu_event_list *pel = this_cpu_ptr(&pmu_sb_events);
 	struct perf_event *event;
@@ -9147,7 +9157,8 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 			continue;
 		if (!event_filter_match(event))
 			continue;
-		output(event, data);
+
+		__perf_iterate_output(output, event, header);
 	}
 }
 
@@ -9158,7 +9169,7 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
  * your event, otherwise it might not get delivered.
  */
 static void
-perf_iterate_sb(perf_iterate_f output, void *data,
+perf_iterate_sb(perf_iterate_f output, struct perf_event_header *header,
 	       struct perf_event_context *task_ctx)
 {
 	struct perf_event_context *ctx;
@@ -9172,15 +9183,15 @@ perf_iterate_sb(perf_iterate_f output, void *data,
 	 * context.
 	 */
 	if (task_ctx) {
-		perf_iterate_ctx(task_ctx, output, data, false);
+		perf_iterate_ctx(task_ctx, output, header, false);
 		goto done;
 	}
 
-	perf_iterate_sb_cpu(output, data);
+	perf_iterate_sb_cpu(output, header);
 
 	ctx = rcu_dereference(current->perf_event_ctxp);
 	if (ctx)
-		perf_iterate_ctx(ctx, output, data, false);
+		perf_iterate_ctx(ctx, output, header, false);
 done:
 	preempt_enable();
 	rcu_read_unlock();
@@ -9347,13 +9358,13 @@ static int perf_event_task_match(struct perf_event *event)
 }
 
 static void perf_event_task_output(struct perf_event *event,
-				   void *data)
+				   struct perf_event_header *header)
 {
-	struct perf_task_event *task_event = data;
+	auto task_event = container_of(header, struct perf_task_event, event_id.header);
+	struct task_struct *task = task_event->task;
 	struct perf_output_handle handle;
 	struct perf_sample_data	sample;
-	struct task_struct *task = task_event->task;
-	int ret, size = task_event->event_id.header.size;
+	int ret;
 
 	if (!perf_event_task_match(event))
 		return;
@@ -9363,7 +9374,7 @@ static void perf_event_task_output(struct perf_event *event,
 	ret = perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	task_event->event_id.pid = perf_event_pid(event, task);
 	task_event->event_id.tid = perf_event_tid(event, task);
@@ -9385,8 +9396,6 @@ static void perf_event_task_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	task_event->event_id.header.size = size;
 }
 
 static void perf_event_task(struct task_struct *task,
@@ -9418,7 +9427,7 @@ static void perf_event_task(struct task_struct *task,
 	};
 
 	perf_iterate_sb(perf_event_task_output,
-		       &task_event,
+		       &task_event.event_id.header,
 		       task_ctx);
 }
 
@@ -9499,12 +9508,11 @@ static int perf_event_comm_match(struct perf_event *event)
 }
 
 static void perf_event_comm_output(struct perf_event *event,
-				   void *data)
+				   struct perf_event_header *header)
 {
-	struct perf_comm_event *comm_event = data;
+	auto comm_event = container_of(header, struct perf_comm_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size = comm_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_comm_match(event))
@@ -9513,9 +9521,8 @@ static void perf_event_comm_output(struct perf_event *event,
 	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
 	ret = perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
-
 	if (ret)
-		goto out;
+		return;
 
 	comm_event->event_id.pid = perf_event_pid(event, comm_event->task);
 	comm_event->event_id.tid = perf_event_tid(event, comm_event->task);
@@ -9527,8 +9534,6 @@ static void perf_event_comm_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	comm_event->event_id.header.size = size;
 }
 
 static void perf_event_comm_event(struct perf_comm_event *comm_event)
@@ -9546,7 +9551,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	comm_event->event_id.header.size = sizeof(comm_event->event_id) + size;
 
 	perf_iterate_sb(perf_event_comm_output,
-		       comm_event,
+		       &comm_event->event_id.header,
 		       NULL);
 }
 
@@ -9598,12 +9603,11 @@ static int perf_event_namespaces_match(struct perf_event *event)
 }
 
 static void perf_event_namespaces_output(struct perf_event *event,
-					 void *data)
+					 struct perf_event_header *header)
 {
-	struct perf_namespaces_event *namespaces_event = data;
+	auto namespaces_event = container_of(header, struct perf_namespaces_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size = namespaces_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
@@ -9614,7 +9618,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	ret = perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	namespaces_event->event_id.pid = perf_event_pid(event,
 							namespaces_event->task);
@@ -9626,8 +9630,6 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	namespaces_event->event_id.header.size = header_size;
 }
 
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
@@ -9701,7 +9703,7 @@ void perf_event_namespaces(struct task_struct *task)
 #endif
 
 	perf_iterate_sb(perf_event_namespaces_output,
-			&namespaces_event,
+			&namespaces_event.event_id.header,
 			NULL);
 }
 
@@ -9725,12 +9727,11 @@ static int perf_event_cgroup_match(struct perf_event *event)
 	return event->attr.cgroup;
 }
 
-static void perf_event_cgroup_output(struct perf_event *event, void *data)
+static void perf_event_cgroup_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_cgroup_event *cgroup_event = data;
+	auto cgroup_event = container_of(header, struct perf_cgroup_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size = cgroup_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_cgroup_match(event))
@@ -9741,7 +9742,7 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 	ret = perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	perf_output_put(&handle, cgroup_event->event_id);
 	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
@@ -9749,8 +9750,6 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	cgroup_event->event_id.header.size = header_size;
 }
 
 static void perf_event_cgroup(struct cgroup *cgrp)
@@ -9796,7 +9795,7 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 	cgroup_event.path_size = size;
 
 	perf_iterate_sb(perf_event_cgroup_output,
-			&cgroup_event,
+			&cgroup_event.event_id.header,
 			NULL);
 
 	kfree(pathname);
@@ -9832,9 +9831,8 @@ struct perf_mmap_event {
 };
 
 static int perf_event_mmap_match(struct perf_event *event,
-				 void *data)
+				 struct perf_mmap_event *mmap_event)
 {
-	struct perf_mmap_event *mmap_event = data;
 	struct vm_area_struct *vma = mmap_event->vma;
 	int executable = vma->vm_flags & VM_EXEC;
 
@@ -9843,17 +9841,15 @@ static int perf_event_mmap_match(struct perf_event *event,
 }
 
 static void perf_event_mmap_output(struct perf_event *event,
-				   void *data)
+				   struct perf_event_header *header)
 {
-	struct perf_mmap_event *mmap_event = data;
+	auto mmap_event = container_of(header, struct perf_mmap_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size = mmap_event->event_id.header.size;
-	u32 type = mmap_event->event_id.header.type;
 	bool use_build_id;
 	int ret;
 
-	if (!perf_event_mmap_match(event, data))
+	if (!perf_event_mmap_match(event, mmap_event))
 		return;
 
 	if (event->attr.mmap2) {
@@ -9870,7 +9866,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	ret = perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
@@ -9904,9 +9900,6 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	mmap_event->event_id.header.size = size;
-	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
@@ -10011,7 +10004,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
 	perf_iterate_sb(perf_event_mmap_output,
-		       mmap_event,
+		       &mmap_event->event_id.header,
 		       NULL);
 
 	kfree(buf);
@@ -10236,9 +10229,9 @@ static int perf_event_switch_match(struct perf_event *event)
 	return event->attr.context_switch;
 }
 
-static void perf_event_switch_output(struct perf_event *event, void *data)
+static void perf_event_switch_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_switch_event *se = data;
+	auto se = container_of(header, struct perf_switch_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
@@ -10301,7 +10294,7 @@ static void perf_event_switch(struct task_struct *task,
 				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
 	}
 
-	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL);
+	perf_iterate_sb(perf_event_switch_output, &switch_event.event_id.header, NULL);
 }
 
 /*
@@ -10366,9 +10359,9 @@ static int perf_event_ksymbol_match(struct perf_event *event)
 	return event->attr.ksymbol;
 }
 
-static void perf_event_ksymbol_output(struct perf_event *event, void *data)
+static void perf_event_ksymbol_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_ksymbol_event *ksymbol_event = data;
+	auto ksymbol_event = container_of(header, struct perf_ksymbol_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
@@ -10430,7 +10423,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 		},
 	};
 
-	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
+	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event.event_id.header, NULL);
 	return;
 err:
 	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
@@ -10456,9 +10449,9 @@ static int perf_event_bpf_match(struct perf_event *event)
 	return event->attr.bpf_event;
 }
 
-static void perf_event_bpf_output(struct perf_event *event, void *data)
+static void perf_event_bpf_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_bpf_event *bpf_event = data;
+	auto bpf_event = container_of(header, struct perf_bpf_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
@@ -10536,7 +10529,7 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	BUILD_BUG_ON(BPF_TAG_SIZE % sizeof(u64));
 
 	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
-	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
+	perf_iterate_sb(perf_event_bpf_output, &bpf_event.event_id.header, NULL);
 }
 
 struct perf_callchain_deferred_event {
@@ -10549,12 +10542,12 @@ struct perf_callchain_deferred_event {
 	} event;
 };
 
-static void perf_callchain_deferred_output(struct perf_event *event, void *data)
+static void perf_callchain_deferred_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_callchain_deferred_event *deferred_event = data;
+	auto deferred_event = container_of(header, struct perf_callchain_deferred_event, event.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int ret, size = deferred_event->event.header.size;
+	int ret;
 
 	if (!event->attr.defer_output)
 		return;
@@ -10565,7 +10558,7 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	ret = perf_output_begin(&handle, &sample, event,
 				deferred_event->event.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	perf_output_put(&handle, deferred_event->event);
 	for (int i = 0; i < deferred_event->trace->nr; i++) {
@@ -10575,8 +10568,6 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	deferred_event->event.header.size = size;
 }
 
 static void perf_unwind_deferred_callback(struct unwind_work *work,
@@ -10596,7 +10587,7 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 		},
 	};
 
-	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
+	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event.event.header, NULL);
 }
 
 struct perf_text_poke_event {
@@ -10618,9 +10609,9 @@ static int perf_event_text_poke_match(struct perf_event *event)
 	return event->attr.text_poke;
 }
 
-static void perf_event_text_poke_output(struct perf_event *event, void *data)
+static void perf_event_text_poke_output(struct perf_event *event, struct perf_event_header *header)
 {
-	struct perf_text_poke_event *text_poke_event = data;
+	auto text_poke_event = container_of(header, struct perf_text_poke_event, event_id.header);
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	u64 padding = 0;
@@ -10680,7 +10671,7 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 		},
 	};
 
-	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event.event_id.header, NULL);
 }
 
 void perf_event_itrace_started(struct perf_event *event)
