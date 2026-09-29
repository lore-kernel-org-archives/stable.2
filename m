Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA2392825
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706075; cv=none; b=rU0KwiJNsYZwd+NpoWSsvgJEVT69F6i+VWq1ZuT4a+qu2UGBiXBH5ctdir2uPLSDztgRP6Ux6uoxQ+p4+X9szO5bYjkNu3xYt4Bodc0YWLat0cN9zi3H9/TJT+YdiTMjJEtqvmEP3wsYvtlDxjBez85C369r/PC8VOq57kfkERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706075; c=relaxed/simple;
	bh=pDFhnf3PiaLO2Xb80XiiBDQbEcH42SHTJXY7J5e2sFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2f0L1vJ+brIpR+8DpTor1NllbXrgZ7n0WxS9ertUFn7oPz4S7hW4czi1+nPOzi3DR0+sl24mCnpr7uYBWPAmWSfo3Spgcidz4ZbN+vzPnRT3jPcCUEPUMXNBu9385LlLGQAaS/hOMORnGKsRPaNI3OmczcSwgACIROA7Em4E4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLXvtzvP; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLXvtzvP"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-349ffa249bdso3639172eec.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790706072; x=1791310872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VJeO6eANryWB79IavWsZVtR3aOeqATvhaw4mj6LQkQw=;
        b=MLXvtzvPN1J+O5Vr45CBP+j2uGnrPRERMT6kyDwSILYZg0+ES07UZG0htGzYJtbTTO
         MZAUhI9btmBQzP3woSjD5mKzlq0qW8l8KBM3d84OsdrRJKhJg3t9bSunJ+jwC4yHFRRv
         2Ze0JjR+XUvHs8B5gJ68Ljo3hvW6bjmcsfTyru70eq5HYmZElU9vpkpyk3700tkP41PF
         +MM6jqNRalOjN+Hi8MxmPEQ60cmiHmjHysBnn8Rjyf1CNK+rIgnaGTPk/o7eSzbZLUFT
         Sg3D9IMvHGoO+ZGC31BQFtWqZ5NM6Vze5ZiUZtu8Fmz6TxzYwYvsud5nosIyqLvv4hEw
         zCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706072; x=1791310872;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJeO6eANryWB79IavWsZVtR3aOeqATvhaw4mj6LQkQw=;
        b=VGmVaKFVRMl0Q5LohJAMJvH37zEUcB5bfKtJB01B+oCTvwYUi+w+QCSrnq1HYiL2Z/
         IgZGtmgS7DO4GqoZGdZUNB5wmAtxn/k9oRRlL9OaNHIxx0Lerl6islHooSwQQ9F8RERI
         ljGmFBvJPqvspXQtzL/GOYf7L2L8/1vy66/4Md/FY8Dbx9XMR4Y0ZB6QKgQ+MzblIea9
         XXmtxnCDyagVPnjHBtGMhaCYzpCsS6TDs0YQ5R1oQREGmvILXolzpGa5oYBC7Tri15os
         +PjU7nXf+C6hr8/fguBFjF/9NwWWTrlyfV34EhkkAaDLxujQ65tjXo4ghIyaoLMDoUz1
         idjw==
X-Forwarded-Encrypted: i=1; AKwUvBy+r6miHVc3WLYvO1JhFodny1FjYcI8RjvSSRSpj0APcycnfcE0Bxkzf+W9nO2lA4gArLWrt+0=@vger.kernel.org
X-Gm-Message-State: AFuF++mMm0+1ztDLHYT/pU9TfN8zDRkYmjtU7ZF7MXeQ1dGWb9p9v6uF
	fSW5EhDHkd+rz1euzLjQ0Hb/HIpqyOXmCiDW+AapxsKZc495f9ktGtEs2ifdlaalZ5E4sIBLcrg
	XGOwxxEBHQg==
X-Received: from dlbps2.prod.google.com ([2002:a05:7023:882:b0:144:ce1e:6f56])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2918:b0:14a:d8fe:33af
 with SMTP id a92af1059eb24-14ad8fe3602mr4332112c88.40.1790706071508; Tue, 29
 Sep 2026 11:21:11 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:21:07 -0700
In-Reply-To: <20260929120417.GT4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929120417.GT4120091@noisy.programming.kicks-ass.net>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929182108.794434-1-irogers@google.com>
Subject: Re: [PATCH v1] perf/core: Restore header fields in sideband output callbacks
From: Ian Rogers <irogers@google.com>
To: peterz@infradead.org
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, song@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 5:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 28, 2026 at 06:42:06PM -0700, Ian Rogers wrote:
> > perf_iterate_sb() invokes its callback for each matching perf_event on
> > the CPU and task context, passing a shared caller-allocated event
> > structure.
> >
> > perf_event_header__init_id() increments header->size by
> > event->id_header_size. Unlike perf_event_task_output(),
> > perf_event_comm_output(), perf_event_namespaces_output(),
> > perf_event_cgroup_output(), perf_event_mmap_output(), and
> > perf_callchain_deferred_output(), three sideband callbacks failed to
> > save and restore header.size around perf_event_header__init_id():
> > - perf_event_ksymbol_output()
> > - perf_event_bpf_output()
> > - perf_event_text_poke_output()
>
> I also found perf_event_switch_output(). Does something like so also
> work?

It does. I was considering a general pattern but in the case of
perf_event_switch_output the header size is computed per callback
event rather than in the caller. I wonder if the problem is really
with perf_event_header__init_id mutating and not just assigning the
header. It tangles the header size computation between the caller and
the callback. If we're assigning the header in every callback then
there is no need to save and restore it. It is inefficient to
reinitialize values in the header every time, but saving and restoring
the header is also inefficient. Below is the refactoring I mean and I
think it simplifies the code overall:

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f401181d8669..ada2ebfe1fcf 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1275,6 +1275,8 @@ static int trace_imc_prepare_sample(struct trace_imc_=
data *mem,
 				    struct perf_event_header *header,
 				    struct perf_event *event)
 {
+	__u16 misc =3D 0;
+
 	/* Sanity checks for a valid record */
 	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
 		*prev_tb =3D be64_to_cpu(READ_ONCE(mem->tb1));
@@ -1289,23 +1291,19 @@ static int trace_imc_prepare_sample(struct trace_im=
c_data *mem,
 	data->ip =3D  be64_to_cpu(READ_ONCE(mem->ip));
 	data->period =3D event->hw.last_period;
=20
-	header->type =3D PERF_RECORD_SAMPLE;
-	header->size =3D sizeof(*header) + event->header_size;
-	header->misc =3D 0;
-
 	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
 		switch (IMC_TRACE_RECORD_VAL_HVPR(be64_to_cpu(READ_ONCE(mem->val)))) {
 		case 0:/* when MSR HV and PR not set in the trace-record */
-			header->misc |=3D PERF_RECORD_MISC_GUEST_KERNEL;
+			misc |=3D PERF_RECORD_MISC_GUEST_KERNEL;
 			break;
 		case 1: /* MSR HV is 0 and PR is 1 */
-			header->misc |=3D PERF_RECORD_MISC_GUEST_USER;
+			misc |=3D PERF_RECORD_MISC_GUEST_USER;
 			break;
 		case 2: /* MSR HV is 1 and PR is 0 */
-			header->misc |=3D PERF_RECORD_MISC_KERNEL;
+			misc |=3D PERF_RECORD_MISC_KERNEL;
 			break;
 		case 3: /* MSR HV is 1 and PR is 1 */
-			header->misc |=3D PERF_RECORD_MISC_USER;
+			misc |=3D PERF_RECORD_MISC_USER;
 			break;
 		default:
 			pr_info("IMC: Unable to set the flag based on MSR bits\n");
@@ -1313,11 +1311,14 @@ static int trace_imc_prepare_sample(struct trace_im=
c_data *mem,
 		}
 	} else {
 		if (is_kernel_addr(data->ip))
-			header->misc |=3D PERF_RECORD_MISC_KERNEL;
+			misc |=3D PERF_RECORD_MISC_KERNEL;
 		else
-			header->misc |=3D PERF_RECORD_MISC_USER;
+			misc |=3D PERF_RECORD_MISC_USER;
 	}
-	perf_event_header__init_id(header, data, event);
+	perf_event_header__init_header_and_id(header, data,
+					      PERF_RECORD_SAMPLE, misc,
+					      sizeof(*header) + event->header_size,
+					      event);
=20
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..8912298e5d4d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1523,9 +1523,10 @@ is_default_overflow_handler(struct perf_event *event=
)
 }
=20
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
index 33210aff3ee6..5a1bfffd46e6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct per=
f_sample_data *data,
 	}
 }
=20
-void perf_event_header__init_id(struct perf_event_header *header,
-				struct perf_sample_data *data,
-				struct perf_event *event)
+void perf_event_header__init_header_and_id(struct perf_event_header *heade=
r,
+					   struct perf_sample_data *data,
+					   u32 type, u16 misc, u16 size,
+					   struct perf_event *event)
 {
+	header->type =3D type;
+	header->misc =3D misc;
 	if (event->attr.sample_id_all) {
-		header->size +=3D event->id_header_size;
+		header->size =3D size + event->id_header_size;
 		__perf_event_header__init_id(data, event, event->attr.sample_type);
+	} else {
+		header->size =3D size;
 	}
 }
=20
@@ -8959,17 +8964,16 @@ perf_event_read_event(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	struct perf_read_event read_event =3D {
-		.header =3D {
-			.type =3D PERF_RECORD_READ,
-			.misc =3D 0,
-			.size =3D sizeof(read_event) + event->read_size,
-		},
 		.pid =3D perf_event_pid(event, task),
 		.tid =3D perf_event_tid(event, task),
 	};
 	int ret;
=20
-	perf_event_header__init_id(&read_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&read_event.header, &sample,
+					      PERF_RECORD_READ,
+					      /*misc=3D*/0,
+					      sizeof(read_event) + event->read_size,
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event, read_event.header.size=
);
 	if (ret)
 		return;
@@ -9210,6 +9214,7 @@ struct perf_task_event {
 		u32				ptid;
 		u64				time;
 	} event_id;
+	int new;
 };
=20
 static int perf_event_task_match(struct perf_event *event)
@@ -9226,17 +9231,21 @@ static void perf_event_task_output(struct perf_even=
t *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data	sample;
 	struct task_struct *task =3D task_event->task;
-	int ret, size =3D task_event->event_id.header.size;
+	int ret;
=20
 	if (!perf_event_task_match(event))
 		return;
=20
-	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&task_event->event_id.header, &samp=
le,
+					      task_event->new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
+					      /*misc=3D*/0,
+					      sizeof(task_event->event_id),
+					      event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	task_event->event_id.pid =3D perf_event_pid(event, task);
 	task_event->event_id.tid =3D perf_event_tid(event, task);
@@ -9258,8 +9267,6 @@ static void perf_event_task_output(struct perf_event =
*event,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	task_event->event_id.header.size =3D size;
 }
=20
 static void perf_event_task(struct task_struct *task,
@@ -9276,18 +9283,7 @@ static void perf_event_task(struct task_struct *task=
,
 	task_event =3D (struct perf_task_event){
 		.task	  =3D task,
 		.task_ctx =3D task_ctx,
-		.event_id    =3D {
-			.header =3D {
-				.type =3D new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
-				.misc =3D 0,
-				.size =3D sizeof(task_event.event_id),
-			},
-			/* .pid  */
-			/* .ppid */
-			/* .tid  */
-			/* .ptid */
-			/* .time */
-		},
+		.new	  =3D new,
 	};
=20
 	perf_iterate_sb(perf_event_task_output,
@@ -9364,6 +9360,7 @@ struct perf_comm_event {
 		u32				pid;
 		u32				tid;
 	} event_id;
+	bool			exec;
 };
=20
 static int perf_event_comm_match(struct perf_event *event)
@@ -9377,18 +9374,21 @@ static void perf_event_comm_output(struct perf_even=
t *event,
 	struct perf_comm_event *comm_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size =3D comm_event->event_id.header.size;
 	int ret;
=20
 	if (!perf_event_comm_match(event))
 		return;
=20
-	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&comm_event->event_id.header, &samp=
le,
+					      PERF_RECORD_COMM,
+					      comm_event->exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
+					      sizeof(comm_event->event_id) + comm_event->comm_size,
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
=20
 	if (ret)
-		goto out;
+		return;
=20
 	comm_event->event_id.pid =3D perf_event_pid(event, comm_event->task);
 	comm_event->event_id.tid =3D perf_event_tid(event, comm_event->task);
@@ -9400,8 +9400,6 @@ static void perf_event_comm_output(struct perf_event =
*event,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	comm_event->event_id.header.size =3D size;
 }
=20
 static void perf_event_comm_event(struct perf_comm_event *comm_event)
@@ -9416,8 +9414,6 @@ static void perf_event_comm_event(struct perf_comm_ev=
ent *comm_event)
 	comm_event->comm =3D comm;
 	comm_event->comm_size =3D size;
=20
-	comm_event->event_id.header.size =3D sizeof(comm_event->event_id) + size;
-
 	perf_iterate_sb(perf_event_comm_output,
 		       comm_event,
 		       NULL);
@@ -9434,15 +9430,8 @@ void perf_event_comm(struct task_struct *task, bool =
exec)
 		.task	=3D task,
 		/* .comm      */
 		/* .comm_size */
-		.event_id  =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_COMM,
-				.misc =3D exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
-				/* .size */
-			},
-			/* .pid */
-			/* .tid */
-		},
+		/* .event_id */
+		.exec	=3D exec,
 	};
=20
 	perf_event_comm_event(&comm_event);
@@ -9476,18 +9465,20 @@ static void perf_event_namespaces_output(struct per=
f_event *event,
 	struct perf_namespaces_event *namespaces_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size =3D namespaces_event->event_id.header.size;
 	int ret;
=20
 	if (!perf_event_namespaces_match(event))
 		return;
=20
-	perf_event_header__init_id(&namespaces_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&namespaces_event->event_id.header,=
 &sample,
+					      PERF_RECORD_NAMESPACES,
+					      /*misc=3D*/0,
+					      sizeof(namespaces_event->event_id),
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	namespaces_event->event_id.pid =3D perf_event_pid(event,
 							namespaces_event->task);
@@ -9499,8 +9490,6 @@ static void perf_event_namespaces_output(struct perf_=
event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	namespaces_event->event_id.header.size =3D header_size;
 }
=20
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
@@ -9531,11 +9520,7 @@ void perf_event_namespaces(struct task_struct *task)
 	namespaces_event =3D (struct perf_namespaces_event){
 		.task	=3D task,
 		.event_id  =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_NAMESPACES,
-				.misc =3D 0,
-				.size =3D sizeof(namespaces_event.event_id),
-			},
+			/* .header */
 			/* .pid */
 			/* .tid */
 			.nr_namespaces =3D NR_NAMESPACES,
@@ -9603,18 +9588,19 @@ static void perf_event_cgroup_output(struct perf_ev=
ent *event, void *data)
 	struct perf_cgroup_event *cgroup_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size =3D cgroup_event->event_id.header.size;
 	int ret;
+	__u16 size =3D sizeof(cgroup_event->event_id) + cgroup_event->path_size;
=20
 	if (!perf_event_cgroup_match(event))
 		return;
=20
-	perf_event_header__init_id(&cgroup_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&cgroup_event->event_id.header, &sa=
mple,
+					      PERF_RECORD_CGROUP, /*misc=3D*/0, size,
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	perf_output_put(&handle, cgroup_event->event_id);
 	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
@@ -9622,8 +9608,6 @@ static void perf_event_cgroup_output(struct perf_even=
t *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	cgroup_event->event_id.header.size =3D header_size;
 }
=20
 static void perf_event_cgroup(struct cgroup *cgrp)
@@ -9638,11 +9622,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
=20
 	cgroup_event =3D (struct perf_cgroup_event){
 		.event_id  =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_CGROUP,
-				.misc =3D 0,
-				.size =3D sizeof(cgroup_event.event_id),
-			},
 			.id =3D cgroup_id(cgrp),
 		},
 	};
@@ -9665,7 +9644,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 	while (!IS_ALIGNED(size, sizeof(u64)))
 		cgroup_event.path[size++] =3D '\0';
=20
-	cgroup_event.event_id.header.size +=3D size;
 	cgroup_event.path_size =3D size;
=20
 	perf_iterate_sb(perf_event_cgroup_output,
@@ -9721,8 +9699,9 @@ static void perf_event_mmap_output(struct perf_event =
*event,
 	struct perf_mmap_event *mmap_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size =3D mmap_event->event_id.header.size;
-	u32 type =3D mmap_event->event_id.header.type;
+	int size =3D sizeof(mmap_event->event_id) + mmap_event->file_size;
+	u32 type =3D PERF_RECORD_MMAP;
+	u16 misc =3D PERF_RECORD_MISC_USER;
 	bool use_build_id;
 	int ret;
=20
@@ -9730,20 +9709,23 @@ static void perf_event_mmap_output(struct perf_even=
t *event,
 		return;
=20
 	if (event->attr.mmap2) {
-		mmap_event->event_id.header.type =3D PERF_RECORD_MMAP2;
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->maj);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->min);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->ino);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->ino_generation)=
;
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->prot);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->flags);
-	}
-
-	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
+		type =3D PERF_RECORD_MMAP2;
+		size +=3D sizeof(mmap_event->maj);
+		size +=3D sizeof(mmap_event->min);
+		size +=3D sizeof(mmap_event->ino);
+		size +=3D sizeof(mmap_event->ino_generation);
+		size +=3D sizeof(mmap_event->prot);
+		size +=3D sizeof(mmap_event->flags);
+	}
+	if (!(mmap_event->vma->vm_flags & VM_EXEC))
+		misc |=3D PERF_RECORD_MISC_MMAP_DATA;
+
+	perf_event_header__init_header_and_id(&mmap_event->event_id.header, &samp=
le,
+					      type, misc, size, event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	mmap_event->event_id.pid =3D perf_event_pid(event, current);
 	mmap_event->event_id.tid =3D perf_event_tid(event, current);
@@ -9777,9 +9759,6 @@ static void perf_event_mmap_output(struct perf_event =
*event,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	mmap_event->event_id.header.size =3D size;
-	mmap_event->event_id.header.type =3D type;
 }
=20
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
@@ -9875,11 +9854,6 @@ static void perf_event_mmap_event(struct perf_mmap_e=
vent *mmap_event)
 	mmap_event->prot =3D prot;
 	mmap_event->flags =3D flags;
=20
-	if (!(vma->vm_flags & VM_EXEC))
-		mmap_event->event_id.header.misc |=3D PERF_RECORD_MISC_MMAP_DATA;
-
-	mmap_event->event_id.header.size =3D sizeof(mmap_event->event_id) + size;
-
 	if (atomic_read(&nr_build_id_events))
 		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_=
size);
=20
@@ -9999,11 +9973,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
 		/* .file_name */
 		/* .file_size */
 		.event_id  =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_MMAP,
-				.misc =3D PERF_RECORD_MISC_USER,
-				/* .size */
-			},
+			/* .header */
 			/* .pid */
 			/* .tid */
 			.start  =3D vma->vm_start,
@@ -10033,18 +10003,15 @@ void perf_event_aux_event(struct perf_event *even=
t, unsigned long head,
 		u64				size;
 		u64				flags;
 	} rec =3D {
-		.header =3D {
-			.type =3D PERF_RECORD_AUX,
-			.misc =3D 0,
-			.size =3D sizeof(rec),
-		},
 		.offset		=3D head,
 		.size		=3D size,
 		.flags		=3D flags,
 	};
 	int ret;
=20
-	perf_event_header__init_id(&rec.header, &sample, event);
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_AUX, /*misc=3D*/0, sizeof(rec),
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
@@ -10069,15 +10036,14 @@ void perf_log_lost_samples(struct perf_event *eve=
nt, u64 lost)
 		struct perf_event_header	header;
 		u64				lost;
 	} lost_samples_event =3D {
-		.header =3D {
-			.type =3D PERF_RECORD_LOST_SAMPLES,
-			.misc =3D 0,
-			.size =3D sizeof(lost_samples_event),
-		},
 		.lost		=3D lost,
 	};
=20
-	perf_event_header__init_id(&lost_samples_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&lost_samples_event.header, &sample=
,
+					      PERF_RECORD_LOST_SAMPLES,
+					      /*misc=3D*/0,
+					      sizeof(lost_samples_event),
+					      event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
@@ -10102,6 +10068,8 @@ struct perf_switch_event {
 		u32				next_prev_pid;
 		u32				next_prev_tid;
 	} event_id;
+	bool			sched_in;
+	bool			preempt;
 };
=20
 static int perf_event_switch_match(struct perf_event *event)
@@ -10114,6 +10082,9 @@ static void perf_event_switch_output(struct perf_ev=
ent *event, void *data)
 	struct perf_switch_event *se =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	__u32 type;
+	__u16 misc;
+	__u16 size;
 	int ret;
=20
 	if (!perf_event_switch_match(event))
@@ -10121,18 +10092,22 @@ static void perf_event_switch_output(struct perf_=
event *event, void *data)
=20
 	/* Only CPU-wide events are allowed to see next/prev pid/tid */
 	if (event->ctx->task) {
-		se->event_id.header.type =3D PERF_RECORD_SWITCH;
-		se->event_id.header.size =3D sizeof(se->event_id.header);
+		type =3D PERF_RECORD_SWITCH;
+		size =3D sizeof(se->event_id.header);
 	} else {
-		se->event_id.header.type =3D PERF_RECORD_SWITCH_CPU_WIDE;
-		se->event_id.header.size =3D sizeof(se->event_id);
+		type =3D PERF_RECORD_SWITCH_CPU_WIDE;
+		size =3D sizeof(se->event_id);
 		se->event_id.next_prev_pid =3D
 					perf_event_pid(event, se->next_prev);
 		se->event_id.next_prev_tid =3D
 					perf_event_tid(event, se->next_prev);
 	}
+	misc =3D se->sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT;
+	if (se->preempt)
+		misc |=3D PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
=20
-	perf_event_header__init_id(&se->event_id.header, &sample, event);
+	perf_event_header__init_header_and_id(&se->event_id.header, &sample,
+					      type, misc, size, event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event, se->event_id.header.si=
ze);
 	if (ret)
@@ -10158,15 +10133,9 @@ static void perf_event_switch(struct task_struct *=
task,
 	switch_event =3D (struct perf_switch_event){
 		.task		=3D task,
 		.next_prev	=3D next_prev,
-		.event_id	=3D {
-			.header =3D {
-				/* .type */
-				.misc =3D sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT,
-				/* .size */
-			},
-			/* .next_prev_pid */
-			/* .next_prev_tid */
-		},
+		/* .event_id */
+		.sched_in	=3D sched_in,
+		.preempt	=3D !sched_in && task_is_runnable(task),
 	};
=20
 	if (!sched_in && task_is_runnable(task)) {
@@ -10193,11 +10162,6 @@ static void perf_log_throttle(struct perf_event *e=
vent, int enable)
 		u64				id;
 		u64				stream_id;
 	} throttle_event =3D {
-		.header =3D {
-			.type =3D PERF_RECORD_THROTTLE,
-			.misc =3D 0,
-			.size =3D sizeof(throttle_event),
-		},
 		.time		=3D perf_event_clock(event),
 		.id		=3D primary_event_id(event),
 		.stream_id	=3D event->id,
@@ -10206,7 +10170,11 @@ static void perf_log_throttle(struct perf_event *e=
vent, int enable)
 	if (enable)
 		throttle_event.header.type =3D PERF_RECORD_UNTHROTTLE;
=20
-	perf_event_header__init_id(&throttle_event.header, &sample, event);
+	perf_event_header__init_header_and_id(&throttle_event.header, &sample,
+					      PERF_RECORD_THROTTLE,
+					      /*misc=3D*/0,
+					      sizeof(throttle_event),
+					      event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
@@ -10245,12 +10213,14 @@ static void perf_event_ksymbol_output(struct perf=
_event *event, void *data)
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
+	__u16 size =3D sizeof(ksymbol_event->event_id) + ksymbol_event->name_len;
=20
 	if (!perf_event_ksymbol_match(event))
 		return;
=20
-	perf_event_header__init_id(&ksymbol_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&ksymbol_event->event_id.header, &s=
ample,
+					      PERF_RECORD_KSYMBOL, /*misc=3D*/0, size,
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
@@ -10291,11 +10261,6 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u=
32 len, bool unregister,
 		.name =3D name,
 		.name_len =3D name_len,
 		.event_id =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_KSYMBOL,
-				.size =3D sizeof(ksymbol_event.event_id) +
-					name_len,
-			},
 			.addr =3D addr,
 			.len =3D len,
 			.ksym_type =3D ksym_type,
@@ -10339,8 +10304,11 @@ static void perf_event_bpf_output(struct perf_even=
t *event, void *data)
 	if (!perf_event_bpf_match(event))
 		return;
=20
-	perf_event_header__init_id(&bpf_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init_header_and_id(&bpf_event->event_id.header, &sampl=
e,
+					      PERF_RECORD_BPF_EVENT,
+					      /*misc=3D*/0,
+					      sizeof(bpf_event->event_id),
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
@@ -10396,10 +10364,6 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	bpf_event =3D (struct perf_bpf_event){
 		.prog =3D prog,
 		.event_id =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_BPF_EVENT,
-				.size =3D sizeof(bpf_event.event_id),
-			},
 			.type =3D type,
 			.flags =3D flags,
 			.id =3D prog->aux->id,
@@ -10427,18 +10391,23 @@ static void perf_callchain_deferred_output(struct=
 perf_event *event, void *data)
 	struct perf_callchain_deferred_event *deferred_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int ret, size =3D deferred_event->event.header.size;
+	int ret;
+	__u16 size =3D sizeof(deferred_event->event) + (deferred_event->trace->nr=
 * sizeof(u64));
=20
 	if (!event->attr.defer_output)
 		return;
=20
 	/* XXX do we really need sample_id_all for this ??? */
-	perf_event_header__init_id(&deferred_event->event.header, &sample, event)=
;
+	perf_event_header__init_header_and_id(&deferred_event->event.header, &sam=
ple,
+					      PERF_RECORD_CALLCHAIN_DEFERRED,
+					      PERF_RECORD_MISC_USER,
+					      size,
+					      event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				deferred_event->event.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	perf_output_put(&handle, deferred_event->event);
 	for (int i =3D 0; i < deferred_event->trace->nr; i++) {
@@ -10448,8 +10417,6 @@ static void perf_callchain_deferred_output(struct p=
erf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	deferred_event->event.header.size =3D size;
 }
=20
 static void perf_unwind_deferred_callback(struct unwind_work *work,
@@ -10458,12 +10425,6 @@ static void perf_unwind_deferred_callback(struct u=
nwind_work *work,
 	struct perf_callchain_deferred_event deferred_event =3D {
 		.trace =3D trace,
 		.event =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_CALLCHAIN_DEFERRED,
-				.misc =3D PERF_RECORD_MISC_USER,
-				.size =3D sizeof(deferred_event.event) +
-					(trace->nr * sizeof(u64)),
-			},
 			.cookie =3D cookie,
 			.nr =3D trace->nr,
 		},
@@ -10475,7 +10436,8 @@ static void perf_unwind_deferred_callback(struct un=
wind_work *work,
 struct perf_text_poke_event {
 	const void		*old_bytes;
 	const void		*new_bytes;
-	size_t			pad;
+	u16			tot;
+	u16			pad;
 	u16			old_len;
 	u16			new_len;
=20
@@ -10496,13 +10458,18 @@ static void perf_event_text_poke_output(struct pe=
rf_event *event, void *data)
 	struct perf_text_poke_event *text_poke_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	__u16 size =3D sizeof(text_poke_event->event_id) + ALIGN(text_poke_event-=
>tot, sizeof(u64));
 	u64 padding =3D 0;
 	int ret;
=20
 	if (!perf_event_text_poke_match(event))
 		return;
=20
-	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, ev=
ent);
+	perf_event_header__init_header_and_id(&text_poke_event->event_id.header, =
&sample,
+					      PERF_RECORD_TEXT_POKE,
+					      PERF_RECORD_MISC_KERNEL,
+					      size,
+					      event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				text_poke_event->event_id.header.size);
@@ -10535,20 +10502,15 @@ void perf_event_text_poke(const void *addr, const=
 void *old_bytes,
=20
 	tot  =3D sizeof(text_poke_event.old_len) + old_len;
 	tot +=3D sizeof(text_poke_event.new_len) + new_len;
-	pad  =3D ALIGN(tot, sizeof(u64)) - tot;
=20
 	text_poke_event =3D (struct perf_text_poke_event){
 		.old_bytes    =3D old_bytes,
 		.new_bytes    =3D new_bytes,
+		.tot          =3D tot,
 		.pad          =3D pad,
 		.old_len      =3D old_len,
 		.new_len      =3D new_len,
 		.event_id  =3D {
-			.header =3D {
-				.type =3D PERF_RECORD_TEXT_POKE,
-				.misc =3D PERF_RECORD_MISC_KERNEL,
-				.size =3D sizeof(text_poke_event.event_id) + tot + pad,
-			},
 			.addr =3D (unsigned long)addr,
 		},
 	};
@@ -10579,13 +10541,12 @@ static void perf_log_itrace_start(struct perf_eve=
nt *event)
 	    event->attach_state & PERF_ATTACH_ITRACE)
 		return;
=20
-	rec.header.type	=3D PERF_RECORD_ITRACE_START;
-	rec.header.misc	=3D 0;
-	rec.header.size	=3D sizeof(rec);
 	rec.pid	=3D perf_event_pid(event, current);
 	rec.tid	=3D perf_event_tid(event, current);
=20
-	perf_event_header__init_id(&rec.header, &sample, event);
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_ITRACE_START, /*misc=3D*/0, sizeof(rec),
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
@@ -10610,12 +10571,10 @@ void perf_report_aux_output_id(struct perf_event =
*event, u64 hw_id)
 	if (event->parent)
 		event =3D event->parent;
=20
-	rec.header.type	=3D PERF_RECORD_AUX_OUTPUT_HW_ID;
-	rec.header.misc	=3D 0;
-	rec.header.size	=3D sizeof(rec);
-	rec.hw_id	=3D hw_id;
-
-	perf_event_header__init_id(&rec.header, &sample, event);
+	rec.hw_id =3D hw_id;
+	perf_event_header__init_header_and_id(&rec.header, &sample,
+					      PERF_RECORD_AUX_OUTPUT_HW_ID, /*misc=3D*/0, sizeof(rec),
+					      event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
