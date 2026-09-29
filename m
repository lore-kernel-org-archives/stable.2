Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7963DCD8F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720624; cv=none; b=BAHDm0eDapNYtEOG4rc/Y+gO0DClEsT2hvVA8Fm3oh4MDmh26m4SOV5DBv3kZzWVidQsb1Nt0wHqvwqB8MAikWKruZO/Sj2zoCUcLxteYnj/HCUUFL9RDttYs6HbrTJUicyGNobGtFaGTPp3zHxPXGW1G7BGMttwqBRMdh6nq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720624; c=relaxed/simple;
	bh=1cd+fsXjbY6Ole3IBC/NoQys1al5cJX/UgsBObpqKw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=labh7doHWOl9LHUQpoqSMjFraG7OAwnI/VMXZuDgJyW667JbbeX3bFMjwUfoV92poybSAbM2FZHWl5yLvfy4GuozNxQQXpkrGOkKe7W/bhqHaZywkbxZKXP6RWBdKk5opPc1v4YPTNts0Fs82N8hkT5wtqdb9TD/IhQbX9yptTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hx2Js6bs; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hx2Js6bs"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14a62326b51so2178353c88.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790720621; x=1791325421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Z7ViMG/V6ZZSnId83Ius3GMe5V6F76ypw+4mSbHSM0=;
        b=Hx2Js6bsBiTTirv66UzK/eOJsuFdNehdNVT1CO5dbEfDcXthWf/ub0WncWJ28Giewa
         BkCdzgCjjU+AtfcXR9Mnk853badMEm/Kd+uDW0ZSKS0aD0Pc+nlNxZ5xqPh7M/jh9wYg
         v/ksOH7UqZ6AA/idYbf1mVHtHPDuzm9OKvH2tOK6FDboqM7WCaTUrR7jI23T5phJXxd3
         WONJTCLDm02KJWkVncNl3j0YKi3pAZXKYiplhjJ0ax/pK5SnBCX8vDqVV2BeGxG5eIjW
         UWBNVCqc62KWUxQ+64cDPDAxJ85d++k8J5Ocg3gxQAh6nJk8pRbYD5S0ftVudEpzgjFr
         ZT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790720621; x=1791325421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Z7ViMG/V6ZZSnId83Ius3GMe5V6F76ypw+4mSbHSM0=;
        b=mnE6+bER+NdoJjaQyfeat1GzjQQnMif7SnwLmDtS89QAkis+f71MhCXHYuhKM49la8
         pvvPPzOSAbD5sO1B93vOgXGmL2Y5wFzW0yltC0rgAaleoaRdqBP5NP7j7ArbTcc3Zz9P
         nox5U9OuIX0/jHoW3nNs5U+qPAsCHoGSmCa1O817ojdysV+iRIvR2ZRnH1bo645JUiJ5
         IRiuSRlg/7R8cDI36xsy4rINwIPbV0PGN9mNC+Qn9PIaNS0dS6hydJyD5agSK+N2XKHC
         4CpMXBKg6ThFbucrDkOAFfEd0BPWVeX6aspnPtZIh3O38fbJYFzXEpgxBvnCZCc6Bwjf
         O11A==
X-Forwarded-Encrypted: i=1; AKwUvBwI0iJbZtpax4iw8ORX+/0aOwMn1/xlalpZEuPyX8IrYmX1ny97BFMV/o6Qp/sXPy9DCrieWkk=@vger.kernel.org
X-Gm-Message-State: AFuF++ks7PW8dCOt8aUawvTRWkex9y3EFhqNhHuN8N3CHbNEiKVhPLje
	763UIStQoiYF8e/vvRqouQgkxAgrSBqmkzsmzMlUCjPeThaxsU5WvqjtqIlQv+MphkZ5hWtJ0UK
	WItprvez0lw==
X-Received: from dlbuu7.prod.google.com ([2002:a05:7022:7e87:b0:13f:c1b7:470])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f909:b0:143:298f:33b6
 with SMTP id a92af1059eb24-14c9ed3ada6mr653078c88.46.1790720620470; Tue, 29
 Sep 2026 15:23:40 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:23:32 -0700
In-Reply-To: <20260929182108.794434-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929182108.794434-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929222332.973435-1-irogers@google.com>
Subject: [PATCH v1] perf/core: Replace perf_event_header__init_id with full
 header init
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, song@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_iterate_sb() invokes its callback for each matching perf_event on
the CPU and task context, passing a shared caller-allocated event
structure.

perf_event_header__init_id() mutated header->size in place by adding
event->id_header_size, requiring sideband output callbacks to save and
restore header fields across iterations. Three sideband callbacks failed
to save and restore header.size around perf_event_header__init_id():
- perf_event_ksymbol_output()
- perf_event_bpf_output()
- perf_event_text_poke_output()

When multiple events with attr.ksymbol, attr.bpf_event, or
attr.text_poke and sample_id_all are active on the same CPU, each
subsequent event receives a record whose header.size is inflated by all
preceding events' id_header_size values while only a single id_sample is
written, leaving uninitialized ring-buffer bytes at the end of the
record and causing userspace perf to fail with -EFAULT ("Bad address")
when parsing the sample_id trailer.

Similarly, perf_event_mmap_output() set PERF_RECORD_MISC_MMAP_BUILD_ID
in mmap_event->event_id.header.misc when event->attr.build_id was
enabled, but only saved and restored header.size and header.type. If an
event with attr.build_id was followed by an event with attr.mmap2 and
!attr.build_id, the second event received PERF_RECORD_MISC_MMAP_BUILD_ID
in header.misc while its payload contained maj/min/ino/ino_generation
instead of a build ID.

Rather than splitting header initialization between callers and output
callbacks and saving/restoring mutated header fields, replace
perf_event_header__init_id() with
perf_event_header__init_header_and_id(), which initializes header->type,
header->misc, and header->size alongside the sample_id fields on each
invocation.

Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/perf/imc-pmu.c |  23 +--
 include/linux/perf_event.h  |   7 +-
 kernel/events/core.c        | 309 +++++++++++++++---------------------
 kernel/events/ring_buffer.c |   7 +-
 4 files changed, 149 insertions(+), 197 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f401181d8669..cd427f2a6d26 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1275,6 +1275,8 @@ static int trace_imc_prepare_sample(struct trace_imc_data *mem,
 				    struct perf_event_header *header,
 				    struct perf_event *event)
 {
+	u16 misc = 0;
+
 	/* Sanity checks for a valid record */
 	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
 		*prev_tb = be64_to_cpu(READ_ONCE(mem->tb1));
@@ -1289,23 +1291,19 @@ static int trace_imc_prepare_sample(struct trace_imc_data *mem,
 	data->ip =  be64_to_cpu(READ_ONCE(mem->ip));
 	data->period = event->hw.last_period;
 
-	header->type = PERF_RECORD_SAMPLE;
-	header->size = sizeof(*header) + event->header_size;
-	header->misc = 0;
-
 	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
 		switch (IMC_TRACE_RECORD_VAL_HVPR(be64_to_cpu(READ_ONCE(mem->val)))) {
 		case 0:/* when MSR HV and PR not set in the trace-record */
-			header->misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
 			break;
 		case 1: /* MSR HV is 0 and PR is 1 */
-			header->misc |= PERF_RECORD_MISC_GUEST_USER;
+			misc |= PERF_RECORD_MISC_GUEST_USER;
 			break;
 		case 2: /* MSR HV is 1 and PR is 0 */
-			header->misc |= PERF_RECORD_MISC_KERNEL;
+			misc |= PERF_RECORD_MISC_KERNEL;
 			break;
 		case 3: /* MSR HV is 1 and PR is 1 */
-			header->misc |= PERF_RECORD_MISC_USER;
+			misc |= PERF_RECORD_MISC_USER;
 			break;
 		default:
 			pr_info("IMC: Unable to set the flag based on MSR bits\n");
@@ -1313,11 +1311,14 @@ static int trace_imc_prepare_sample(struct trace_imc_data *mem,
 		}
 	} else {
 		if (is_kernel_addr(data->ip))
-			header->misc |= PERF_RECORD_MISC_KERNEL;
+			misc |= PERF_RECORD_MISC_KERNEL;
 		else
-			header->misc |= PERF_RECORD_MISC_USER;
+			misc |= PERF_RECORD_MISC_USER;
 	}
-	perf_event_header__init_id(header, data, event);
+	perf_event_header__init_header_and_id(header, data,
+					      PERF_RECORD_SAMPLE, misc,
+					      sizeof(*header) + event->header_size,
+					      event);
 
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..8912298e5d4d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1523,9 +1523,10 @@ is_default_overflow_handler(struct perf_event *event)
 }
 
 extern void
-perf_event_header__init_id(struct perf_event_header *header,
-			   struct perf_sample_data *data,
-			   struct perf_event *event);
+perf_event_header__init_header_and_id(struct perf_event_header *header,
+				      struct perf_sample_data *data,
+				      u32 type, u16 misc, u16 size,
+				      struct perf_event *event);
 extern void
 perf_event__output_id_sample(struct perf_event *event,
 			     struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 33210aff3ee6..c1b2d0c9b2af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct perf_sample_data *data,
 	}
 }
 
-void perf_event_header__init_id(struct perf_event_header *header,
-				struct perf_sample_data *data,
-				struct perf_event *event)
+void perf_event_header__init_header_and_id(struct perf_event_header *header,
+					   struct perf_sample_data *data,
+					   u32 type, u16 misc, u16 size,
+					   struct perf_event *event)
 {
+	header->type = type;
+	header->misc = misc;
 	if (event->attr.sample_id_all) {
-		header->size += event->id_header_size;
+		header->size = size + event->id_header_size;
 		__perf_event_header__init_id(data, event, event->attr.sample_type);
+	} else {
+		header->size = size;
 	}
 }
 
@@ -8959,17 +8964,16 @@ perf_event_read_event(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	struct perf_read_event read_event = {
-		.header = {
-			.type = PERF_RECORD_READ,
-			.misc = 0,
-			.size = sizeof(read_event) + event->read_size,
-		},
 		.pid = perf_event_pid(event, task),
 		.tid = perf_event_tid(event, task),
 	};
 	int ret;
 
-	perf_event_header__init_id(&read_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&read_event.header, &sample,
+					      PERF_RECORD_READ,
+					      /*misc=*/0,
+					      sizeof(read_event) + event->read_size,
+					      event);
 	ret = perf_output_begin(&handle, &sample, event, read_event.header.size);
 	if (ret)
 		return;
@@ -9210,6 +9214,7 @@ struct perf_task_event {
 		u32				ptid;
 		u64				time;
 	} event_id;
+	int new;
 };
 
 static int perf_event_task_match(struct perf_event *event)
@@ -9226,17 +9231,21 @@ static void perf_event_task_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data	sample;
 	struct task_struct *task = task_event->task;
-	int ret, size = task_event->event_id.header.size;
+	int ret;
 
 	if (!perf_event_task_match(event))
 		return;
 
-	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&task_event->event_id.header, &sample,
+					      task_event->new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
+					      /*misc=*/0,
+					      sizeof(task_event->event_id),
+					      event);
 
 	ret = perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	task_event->event_id.pid = perf_event_pid(event, task);
 	task_event->event_id.tid = perf_event_tid(event, task);
@@ -9258,8 +9267,6 @@ static void perf_event_task_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	task_event->event_id.header.size = size;
 }
 
 static void perf_event_task(struct task_struct *task,
@@ -9276,18 +9283,7 @@ static void perf_event_task(struct task_struct *task,
 	task_event = (struct perf_task_event){
 		.task	  = task,
 		.task_ctx = task_ctx,
-		.event_id    = {
-			.header = {
-				.type = new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
-				.misc = 0,
-				.size = sizeof(task_event.event_id),
-			},
-			/* .pid  */
-			/* .ppid */
-			/* .tid  */
-			/* .ptid */
-			/* .time */
-		},
+		.new	  = new,
 	};
 
 	perf_iterate_sb(perf_event_task_output,
@@ -9364,6 +9360,7 @@ struct perf_comm_event {
 		u32				pid;
 		u32				tid;
 	} event_id;
+	bool			exec;
 };
 
 static int perf_event_comm_match(struct perf_event *event)
@@ -9377,18 +9374,21 @@ static void perf_event_comm_output(struct perf_event *event,
 	struct perf_comm_event *comm_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size = comm_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_comm_match(event))
 		return;
 
-	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&comm_event->event_id.header, &sample,
+					      PERF_RECORD_COMM,
+					      comm_event->exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
+					      sizeof(comm_event->event_id) + comm_event->comm_size,
+					      event);
 	ret = perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
 
 	if (ret)
-		goto out;
+		return;
 
 	comm_event->event_id.pid = perf_event_pid(event, comm_event->task);
 	comm_event->event_id.tid = perf_event_tid(event, comm_event->task);
@@ -9400,8 +9400,6 @@ static void perf_event_comm_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	comm_event->event_id.header.size = size;
 }
 
 static void perf_event_comm_event(struct perf_comm_event *comm_event)
@@ -9416,8 +9414,6 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
 	comm_event->comm = comm;
 	comm_event->comm_size = size;
 
-	comm_event->event_id.header.size = sizeof(comm_event->event_id) + size;
-
 	perf_iterate_sb(perf_event_comm_output,
 		       comm_event,
 		       NULL);
@@ -9434,15 +9430,8 @@ void perf_event_comm(struct task_struct *task, bool exec)
 		.task	= task,
 		/* .comm      */
 		/* .comm_size */
-		.event_id  = {
-			.header = {
-				.type = PERF_RECORD_COMM,
-				.misc = exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
-				/* .size */
-			},
-			/* .pid */
-			/* .tid */
-		},
+		/* .event_id */
+		.exec	= exec,
 	};
 
 	perf_event_comm_event(&comm_event);
@@ -9476,18 +9465,20 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	struct perf_namespaces_event *namespaces_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size = namespaces_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
 		return;
 
-	perf_event_header__init_id(&namespaces_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&namespaces_event->event_id.header, &sample,
+					      PERF_RECORD_NAMESPACES,
+					      /*misc=*/0,
+					      sizeof(namespaces_event->event_id),
+					      event);
 	ret = perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	namespaces_event->event_id.pid = perf_event_pid(event,
 							namespaces_event->task);
@@ -9499,8 +9490,6 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	namespaces_event->event_id.header.size = header_size;
 }
 
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
@@ -9531,11 +9520,7 @@ void perf_event_namespaces(struct task_struct *task)
 	namespaces_event = (struct perf_namespaces_event){
 		.task	= task,
 		.event_id  = {
-			.header = {
-				.type = PERF_RECORD_NAMESPACES,
-				.misc = 0,
-				.size = sizeof(namespaces_event.event_id),
-			},
+			/* .header */
 			/* .pid */
 			/* .tid */
 			.nr_namespaces = NR_NAMESPACES,
@@ -9603,18 +9588,19 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 	struct perf_cgroup_event *cgroup_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size = cgroup_event->event_id.header.size;
 	int ret;
+	u16 size = sizeof(cgroup_event->event_id) + cgroup_event->path_size;
 
 	if (!perf_event_cgroup_match(event))
 		return;
 
-	perf_event_header__init_id(&cgroup_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&cgroup_event->event_id.header, &sample,
+					      PERF_RECORD_CGROUP, /*misc=*/0, size,
+					      event);
 	ret = perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	perf_output_put(&handle, cgroup_event->event_id);
 	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
@@ -9622,8 +9608,6 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	cgroup_event->event_id.header.size = header_size;
 }
 
 static void perf_event_cgroup(struct cgroup *cgrp)
@@ -9638,11 +9622,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 
 	cgroup_event = (struct perf_cgroup_event){
 		.event_id  = {
-			.header = {
-				.type = PERF_RECORD_CGROUP,
-				.misc = 0,
-				.size = sizeof(cgroup_event.event_id),
-			},
 			.id = cgroup_id(cgrp),
 		},
 	};
@@ -9665,7 +9644,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 	while (!IS_ALIGNED(size, sizeof(u64)))
 		cgroup_event.path[size++] = '\0';
 
-	cgroup_event.event_id.header.size += size;
 	cgroup_event.path_size = size;
 
 	perf_iterate_sb(perf_event_cgroup_output,
@@ -9721,38 +9699,40 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_mmap_event *mmap_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size = mmap_event->event_id.header.size;
-	u32 type = mmap_event->event_id.header.type;
-	bool use_build_id;
+	int size = sizeof(mmap_event->event_id) + mmap_event->file_size;
+	u32 type = PERF_RECORD_MMAP;
+	u16 misc = PERF_RECORD_MISC_USER;
+	bool use_build_id = false;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
 		return;
 
 	if (event->attr.mmap2) {
-		mmap_event->event_id.header.type = PERF_RECORD_MMAP2;
-		mmap_event->event_id.header.size += sizeof(mmap_event->maj);
-		mmap_event->event_id.header.size += sizeof(mmap_event->min);
-		mmap_event->event_id.header.size += sizeof(mmap_event->ino);
-		mmap_event->event_id.header.size += sizeof(mmap_event->ino_generation);
-		mmap_event->event_id.header.size += sizeof(mmap_event->prot);
-		mmap_event->event_id.header.size += sizeof(mmap_event->flags);
-	}
-
-	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
+		type = PERF_RECORD_MMAP2;
+		size += sizeof(mmap_event->maj);
+		size += sizeof(mmap_event->min);
+		size += sizeof(mmap_event->ino);
+		size += sizeof(mmap_event->ino_generation);
+		size += sizeof(mmap_event->prot);
+		size += sizeof(mmap_event->flags);
+		use_build_id = event->attr.build_id && mmap_event->build_id_size;
+		if (use_build_id)
+			misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+	}
+	if (!(mmap_event->vma->vm_flags & VM_EXEC))
+		misc |= PERF_RECORD_MISC_MMAP_DATA;
+
+	perf_event_header__init_header_and_id(&mmap_event->event_id.header, &sample,
+					      type, misc, size, event);
 	ret = perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
-	use_build_id = event->attr.build_id && mmap_event->build_id_size;
-
-	if (event->attr.mmap2 && use_build_id)
-		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
-
 	perf_output_put(&handle, mmap_event->event_id);
 
 	if (event->attr.mmap2) {
@@ -9777,9 +9757,6 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	mmap_event->event_id.header.size = size;
-	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
@@ -9875,11 +9852,6 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->prot = prot;
 	mmap_event->flags = flags;
 
-	if (!(vma->vm_flags & VM_EXEC))
-		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_DATA;
-
-	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
-
 	if (atomic_read(&nr_build_id_events))
 		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
@@ -9999,11 +9971,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
 		/* .file_name */
 		/* .file_size */
 		.event_id  = {
-			.header = {
-				.type = PERF_RECORD_MMAP,
-				.misc = PERF_RECORD_MISC_USER,
-				/* .size */
-			},
+			/* .header */
 			/* .pid */
 			/* .tid */
 			.start  = vma->vm_start,
@@ -10033,18 +10001,15 @@ void perf_event_aux_event(struct perf_event *event, unsigned long head,
 		u64				size;
 		u64				flags;
 	} rec = {
-		.header = {
-			.type = PERF_RECORD_AUX,
-			.misc = 0,
-			.size = sizeof(rec),
-		},
 		.offset		= head,
 		.size		= size,
 		.flags		= flags,
 	};
 	int ret;
 
-	perf_event_header__init_id(&rec.header, &sample, event);
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_AUX, /*misc=*/0, sizeof(rec),
+					      event);
 	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
@@ -10069,15 +10034,14 @@ void perf_log_lost_samples(struct perf_event *event, u64 lost)
 		struct perf_event_header	header;
 		u64				lost;
 	} lost_samples_event = {
-		.header = {
-			.type = PERF_RECORD_LOST_SAMPLES,
-			.misc = 0,
-			.size = sizeof(lost_samples_event),
-		},
 		.lost		= lost,
 	};
 
-	perf_event_header__init_id(&lost_samples_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&lost_samples_event.header, &sample,
+					      PERF_RECORD_LOST_SAMPLES,
+					      /*misc=*/0,
+					      sizeof(lost_samples_event),
+					      event);
 
 	ret = perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
@@ -10102,6 +10066,8 @@ struct perf_switch_event {
 		u32				next_prev_pid;
 		u32				next_prev_tid;
 	} event_id;
+	bool			sched_in;
+	bool			preempt;
 };
 
 static int perf_event_switch_match(struct perf_event *event)
@@ -10114,6 +10080,9 @@ static void perf_event_switch_output(struct perf_event *event, void *data)
 	struct perf_switch_event *se = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u32 type;
+	u16 misc;
+	u16 size;
 	int ret;
 
 	if (!perf_event_switch_match(event))
@@ -10121,18 +10090,22 @@ static void perf_event_switch_output(struct perf_event *event, void *data)
 
 	/* Only CPU-wide events are allowed to see next/prev pid/tid */
 	if (event->ctx->task) {
-		se->event_id.header.type = PERF_RECORD_SWITCH;
-		se->event_id.header.size = sizeof(se->event_id.header);
+		type = PERF_RECORD_SWITCH;
+		size = sizeof(se->event_id.header);
 	} else {
-		se->event_id.header.type = PERF_RECORD_SWITCH_CPU_WIDE;
-		se->event_id.header.size = sizeof(se->event_id);
+		type = PERF_RECORD_SWITCH_CPU_WIDE;
+		size = sizeof(se->event_id);
 		se->event_id.next_prev_pid =
 					perf_event_pid(event, se->next_prev);
 		se->event_id.next_prev_tid =
 					perf_event_tid(event, se->next_prev);
 	}
+	misc = se->sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT;
+	if (se->preempt)
+		misc |= PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
 
-	perf_event_header__init_id(&se->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&se->event_id.header, &sample,
+					      type, misc, size, event);
 
 	ret = perf_output_begin(&handle, &sample, event, se->event_id.header.size);
 	if (ret)
@@ -10158,22 +10131,11 @@ static void perf_event_switch(struct task_struct *task,
 	switch_event = (struct perf_switch_event){
 		.task		= task,
 		.next_prev	= next_prev,
-		.event_id	= {
-			.header = {
-				/* .type */
-				.misc = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT,
-				/* .size */
-			},
-			/* .next_prev_pid */
-			/* .next_prev_tid */
-		},
+		/* .event_id */
+		.sched_in	= sched_in,
+		.preempt	= !sched_in && task_is_runnable(task),
 	};
 
-	if (!sched_in && task_is_runnable(task)) {
-		switch_event.event_id.header.misc |=
-				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
-	}
-
 	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL);
 }
 
@@ -10193,20 +10155,17 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 		u64				id;
 		u64				stream_id;
 	} throttle_event = {
-		.header = {
-			.type = PERF_RECORD_THROTTLE,
-			.misc = 0,
-			.size = sizeof(throttle_event),
-		},
 		.time		= perf_event_clock(event),
 		.id		= primary_event_id(event),
 		.stream_id	= event->id,
 	};
 
-	if (enable)
-		throttle_event.header.type = PERF_RECORD_UNTHROTTLE;
-
-	perf_event_header__init_id(&throttle_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&throttle_event.header, &sample,
+					      enable ? PERF_RECORD_UNTHROTTLE
+						     : PERF_RECORD_THROTTLE,
+					      /*misc=*/0,
+					      sizeof(throttle_event),
+					      event);
 
 	ret = perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
@@ -10245,12 +10204,14 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
+	u16 size = sizeof(ksymbol_event->event_id) + ksymbol_event->name_len;
 
 	if (!perf_event_ksymbol_match(event))
 		return;
 
-	perf_event_header__init_id(&ksymbol_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&ksymbol_event->event_id.header, &sample,
+					      PERF_RECORD_KSYMBOL, /*misc=*/0, size,
+					      event);
 	ret = perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
@@ -10291,11 +10252,6 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
 		.name = name,
 		.name_len = name_len,
 		.event_id = {
-			.header = {
-				.type = PERF_RECORD_KSYMBOL,
-				.size = sizeof(ksymbol_event.event_id) +
-					name_len,
-			},
 			.addr = addr,
 			.len = len,
 			.ksym_type = ksym_type,
@@ -10339,8 +10295,11 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 	if (!perf_event_bpf_match(event))
 		return;
 
-	perf_event_header__init_id(&bpf_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&bpf_event->event_id.header, &sample,
+					      PERF_RECORD_BPF_EVENT,
+					      /*misc=*/0,
+					      sizeof(bpf_event->event_id),
+					      event);
 	ret = perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
@@ -10396,10 +10355,6 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	bpf_event = (struct perf_bpf_event){
 		.prog = prog,
 		.event_id = {
-			.header = {
-				.type = PERF_RECORD_BPF_EVENT,
-				.size = sizeof(bpf_event.event_id),
-			},
 			.type = type,
 			.flags = flags,
 			.id = prog->aux->id,
@@ -10427,18 +10382,23 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	struct perf_callchain_deferred_event *deferred_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int ret, size = deferred_event->event.header.size;
+	int ret;
+	u16 size = sizeof(deferred_event->event) + (deferred_event->trace->nr * sizeof(u64));
 
 	if (!event->attr.defer_output)
 		return;
 
 	/* XXX do we really need sample_id_all for this ??? */
-	perf_event_header__init_id(&deferred_event->event.header, &sample, event);
+	perf_event_header__init_header_and_id(&deferred_event->event.header, &sample,
+					      PERF_RECORD_CALLCHAIN_DEFERRED,
+					      PERF_RECORD_MISC_USER,
+					      size,
+					      event);
 
 	ret = perf_output_begin(&handle, &sample, event,
 				deferred_event->event.header.size);
 	if (ret)
-		goto out;
+		return;
 
 	perf_output_put(&handle, deferred_event->event);
 	for (int i = 0; i < deferred_event->trace->nr; i++) {
@@ -10448,8 +10408,6 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-out:
-	deferred_event->event.header.size = size;
 }
 
 static void perf_unwind_deferred_callback(struct unwind_work *work,
@@ -10458,12 +10416,6 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 	struct perf_callchain_deferred_event deferred_event = {
 		.trace = trace,
 		.event = {
-			.header = {
-				.type = PERF_RECORD_CALLCHAIN_DEFERRED,
-				.misc = PERF_RECORD_MISC_USER,
-				.size = sizeof(deferred_event.event) +
-					(trace->nr * sizeof(u64)),
-			},
 			.cookie = cookie,
 			.nr = trace->nr,
 		},
@@ -10475,7 +10427,8 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 struct perf_text_poke_event {
 	const void		*old_bytes;
 	const void		*new_bytes;
-	size_t			pad;
+	u16			tot;
+	u16			pad;
 	u16			old_len;
 	u16			new_len;
 
@@ -10496,13 +10449,18 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 	struct perf_text_poke_event *text_poke_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 size = sizeof(text_poke_event->event_id) + text_poke_event->tot + text_poke_event->pad;
 	u64 padding = 0;
 	int ret;
 
 	if (!perf_event_text_poke_match(event))
 		return;
 
-	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&text_poke_event->event_id.header, &sample,
+					      PERF_RECORD_TEXT_POKE,
+					      PERF_RECORD_MISC_KERNEL,
+					      size,
+					      event);
 
 	ret = perf_output_begin(&handle, &sample, event,
 				text_poke_event->event_id.header.size);
@@ -10540,15 +10498,11 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 	text_poke_event = (struct perf_text_poke_event){
 		.old_bytes    = old_bytes,
 		.new_bytes    = new_bytes,
+		.tot          = tot,
 		.pad          = pad,
 		.old_len      = old_len,
 		.new_len      = new_len,
 		.event_id  = {
-			.header = {
-				.type = PERF_RECORD_TEXT_POKE,
-				.misc = PERF_RECORD_MISC_KERNEL,
-				.size = sizeof(text_poke_event.event_id) + tot + pad,
-			},
 			.addr = (unsigned long)addr,
 		},
 	};
@@ -10579,13 +10533,12 @@ static void perf_log_itrace_start(struct perf_event *event)
 	    event->attach_state & PERF_ATTACH_ITRACE)
 		return;
 
-	rec.header.type	= PERF_RECORD_ITRACE_START;
-	rec.header.misc	= 0;
-	rec.header.size	= sizeof(rec);
 	rec.pid	= perf_event_pid(event, current);
 	rec.tid	= perf_event_tid(event, current);
 
-	perf_event_header__init_id(&rec.header, &sample, event);
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_ITRACE_START, /*misc=*/0, sizeof(rec),
+					      event);
 	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
@@ -10610,12 +10563,10 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 	if (event->parent)
 		event = event->parent;
 
-	rec.header.type	= PERF_RECORD_AUX_OUTPUT_HW_ID;
-	rec.header.misc	= 0;
-	rec.header.size	= sizeof(rec);
-	rec.hw_id	= hw_id;
-
-	perf_event_header__init_id(&rec.header, &sample, event);
+	rec.hw_id = hw_id;
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_AUX_OUTPUT_HW_ID, /*misc=*/0, sizeof(rec),
+					      event);
 	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1b1ffe0533e5..90fae9c41b9b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -246,14 +246,13 @@ __perf_output_begin(struct perf_output_handle *handle,
 	handle->size = (1UL << page_shift) - offset;
 
 	if (unlikely(have_lost)) {
-		lost_event.header.size = sizeof(lost_event);
-		lost_event.header.type = PERF_RECORD_LOST;
-		lost_event.header.misc = 0;
 		lost_event.id          = event->id;
 		lost_event.lost        = local_xchg(&rb->lost, 0);
 
 		/* XXX mostly redundant; @data is already fully initializes */
-		perf_event_header__init_id(&lost_event.header, data, event);
+		perf_event_header__init_header_and_id(&lost_event.header, data,
+						      PERF_RECORD_LOST, /*misc=*/0,
+						      sizeof(lost_event), event);
 		perf_output_put(handle, lost_event);
 		perf_event__output_id_sample(event, handle, data);
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

