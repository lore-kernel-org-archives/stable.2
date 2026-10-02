Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4846EC86;
	Fri,  2 Oct 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933591; cv=none; b=mCnV5qKOtYg5CM1T5skogTp/M5QNdO4TMM3QBJ/s83hYS6ziGl4vcD4e2+FUbaVhxwWIDBoS8JoYYzrfVRiAs6S7VHjGPwmbValQfjUPxzSSV2JRlEsDPTArQYqlQOqzXnWM2G6Z1WDck3WHqWCMlBHwQ0H9jx1OWtE7/43Xgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933591; c=relaxed/simple;
	bh=C6NZJiX9y2XfwG34jo+qiPbU7G1sUwCkS00gvErOtZA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eGwuKAGHFTMk1KRqkcfSdm3v+VRTdrBqaGb+Fz20xw4nXpJB/Vzp52P7Kr8uAi8a5TkN4KLLyBWbtBp+fZRmrzTY3xsa3Jpxo/bHyJUtM7hScdXQryuocD8Gs4bgO3UZxbPtkh8QxtGgh2CFzgDTitrh0DK9bFduSQa5+4/Bbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X07jK4v2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=80CXh06f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X07jK4v2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="80CXh06f"
Date: Fri, 02 Oct 2026 09:33:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790933587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YBHL1XQ+/OB3Mb24+q4tyAnfR0xon9F6XCr4VARnu8=;
	b=X07jK4v2vI0nKNHL3/2NRzQ8nGQuOjGUftVWMxSg0Fib/48isHdvEdBoobLX0cHIM9UJ64
	J5wFyZ14x1sMLHF8fg96bKBSSalzGkba268EveJbfoSDONveC2XrN/DG+sRK9Jp8gMOdI2
	OC50ZO/Yr+bnCqH/J/pXbFHaSnRNNq5qcWAL6bXUIFMx+5btQJw8/EmaFmGJo0QaL251ms
	S28minSFHc77XIlxgFF+vnRcDn1U/e+ul8TwtxgQGtnaMUJG6W/AetET+/rkcfxuxhyyC6
	YlEwqMw8AkqwSImnV/vEGGtGfOcHPT2uKiA/zYn9yEubOgRpO8S6wo5GNeSc4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790933587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YBHL1XQ+/OB3Mb24+q4tyAnfR0xon9F6XCr4VARnu8=;
	b=80CXh06f9FfRRYHfIN5i8sfjmzAW85OE2/iiQYlxJ4q/vqr8GzVSwh3ywe1uHRUUHFHNXM
	XrDaPdCkLHML+XDg==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Replace perf_event_header__init_id with full
 header init
Cc: Ian Rogers <irogers@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260929222332.973435-1-irogers@google.com>
References: <20260929222332.973435-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179093358535.3910103.9423980659422380267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b9d1fdc6f4ac1b6e49f9deafaf137da1407d9af1
Gitweb:        https://git.kernel.org/tip/b9d1fdc6f4ac1b6e49f9deafaf137da1407=
d9af1
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 29 Sep 2026 15:23:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 01 Oct 2026 14:02:06 +02:00

perf: Replace perf_event_header__init_id with full header init

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
perf_event_header__init_id() with perf_event_header__init(), which
initializes header->type, header->misc, and header->size alongside the
sample_id fields on each invocation.

Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260929222332.973435-1-irogers@google.com
Cc: stable@vger.kernel.org
---
 arch/powerpc/perf/imc-pmu.c |  23 +--
 include/linux/perf_event.h  |   7 +-
 kernel/events/core.c        | 307 ++++++++++++++---------------------
 kernel/events/ring_buffer.c |   7 +-
 4 files changed, 148 insertions(+), 196 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f401181..a9f8464 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1275,6 +1275,8 @@ static int trace_imc_prepare_sample(struct trace_imc_da=
ta *mem,
 				    struct perf_event_header *header,
 				    struct perf_event *event)
 {
+	u16 misc =3D 0;
+
 	/* Sanity checks for a valid record */
 	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
 		*prev_tb =3D be64_to_cpu(READ_ONCE(mem->tb1));
@@ -1289,23 +1291,19 @@ static int trace_imc_prepare_sample(struct trace_imc_=
data *mem,
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
@@ -1313,11 +1311,14 @@ static int trace_imc_prepare_sample(struct trace_imc_=
data *mem,
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
+	perf_event_header__init(header, data,
+				PERF_RECORD_SAMPLE, misc,
+				sizeof(*header) + event->header_size,
+				event);
=20
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 915c6fd..2d5e768 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1506,9 +1506,10 @@ is_default_overflow_handler(struct perf_event *event)
 }
=20
 extern void
-perf_event_header__init_id(struct perf_event_header *header,
-			   struct perf_sample_data *data,
-			   struct perf_event *event);
+perf_event_header__init(struct perf_event_header *header,
+			struct perf_sample_data *data,
+			u32 type, u16 misc, u16 size,
+			struct perf_event *event);
 extern void
 perf_event__output_id_sample(struct perf_event *event,
 			     struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c2882b5..3aa2235 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8131,10 +8131,15 @@ static void __perf_event_header__init_id(struct perf_=
sample_data *data,
 	}
 }
=20
-void perf_event_header__init_id(struct perf_event_header *header,
-				struct perf_sample_data *data,
-				struct perf_event *event)
+void perf_event_header__init(struct perf_event_header *header,
+			     struct perf_sample_data *data,
+			     u32 type, u16 misc, u16 size,
+			     struct perf_event *event)
 {
+	header->type =3D type;
+	header->misc =3D misc;
+	header->size =3D size;
+
 	if (event->attr.sample_id_all) {
 		header->size +=3D event->id_header_size;
 		__perf_event_header__init_id(data, event, event->attr.sample_type);
@@ -8971,17 +8976,16 @@ perf_event_read_event(struct perf_event *event,
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
+	perf_event_header__init(&read_event.header, &sample,
+				PERF_RECORD_READ,
+				/* misc=3D */ 0,
+				sizeof(read_event) + event->read_size,
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event, read_event.header.size);
 	if (ret)
 		return;
@@ -9222,6 +9226,7 @@ struct perf_task_event {
 		u32				ptid;
 		u64				time;
 	} event_id;
+	int new;
 };
=20
 static int perf_event_task_match(struct perf_event *event)
@@ -9238,17 +9243,21 @@ static void perf_event_task_output(struct perf_event =
*event,
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
+	perf_event_header__init(&task_event->event_id.header, &sample,
+				task_event->new ? PERF_RECORD_FORK : PERF_RECORD_EXIT,
+				/* misc=3D */ 0,
+				sizeof(task_event->event_id),
+				event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	task_event->event_id.pid =3D perf_event_pid(event, task);
 	task_event->event_id.tid =3D perf_event_tid(event, task);
@@ -9270,8 +9279,6 @@ static void perf_event_task_output(struct perf_event *e=
vent,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	task_event->event_id.header.size =3D size;
 }
=20
 static void perf_event_task(struct task_struct *task,
@@ -9288,18 +9295,7 @@ static void perf_event_task(struct task_struct *task,
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
@@ -9376,6 +9372,7 @@ struct perf_comm_event {
 		u32				pid;
 		u32				tid;
 	} event_id;
+	bool			exec;
 };
=20
 static int perf_event_comm_match(struct perf_event *event)
@@ -9389,18 +9386,21 @@ static void perf_event_comm_output(struct perf_event =
*event,
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
+	perf_event_header__init(&comm_event->event_id.header, &sample,
+				PERF_RECORD_COMM,
+				comm_event->exec ? PERF_RECORD_MISC_COMM_EXEC : 0,
+				sizeof(comm_event->event_id) + comm_event->comm_size,
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
=20
 	if (ret)
-		goto out;
+		return;
=20
 	comm_event->event_id.pid =3D perf_event_pid(event, comm_event->task);
 	comm_event->event_id.tid =3D perf_event_tid(event, comm_event->task);
@@ -9412,8 +9412,6 @@ static void perf_event_comm_output(struct perf_event *e=
vent,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	comm_event->event_id.header.size =3D size;
 }
=20
 static void perf_event_comm_event(struct perf_comm_event *comm_event)
@@ -9428,8 +9426,6 @@ static void perf_event_comm_event(struct perf_comm_even=
t *comm_event)
 	comm_event->comm =3D comm;
 	comm_event->comm_size =3D size;
=20
-	comm_event->event_id.header.size =3D sizeof(comm_event->event_id) + size;
-
 	perf_iterate_sb(perf_event_comm_output,
 		       comm_event,
 		       NULL);
@@ -9446,15 +9442,8 @@ void perf_event_comm(struct task_struct *task, bool ex=
ec)
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
@@ -9488,18 +9477,20 @@ static void perf_event_namespaces_output(struct perf_=
event *event,
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
+	perf_event_header__init(&namespaces_event->event_id.header, &sample,
+				PERF_RECORD_NAMESPACES,
+				/* misc=3D */ 0,
+				sizeof(namespaces_event->event_id),
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	namespaces_event->event_id.pid =3D perf_event_pid(event,
 							namespaces_event->task);
@@ -9511,8 +9502,6 @@ static void perf_event_namespaces_output(struct perf_ev=
ent *event,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	namespaces_event->event_id.header.size =3D header_size;
 }
=20
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
@@ -9543,11 +9532,7 @@ void perf_event_namespaces(struct task_struct *task)
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
@@ -9615,18 +9600,19 @@ static void perf_event_cgroup_output(struct perf_even=
t *event, void *data)
 	struct perf_cgroup_event *cgroup_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	u16 header_size =3D cgroup_event->event_id.header.size;
 	int ret;
+	u16 size =3D sizeof(cgroup_event->event_id) + cgroup_event->path_size;
=20
 	if (!perf_event_cgroup_match(event))
 		return;
=20
-	perf_event_header__init_id(&cgroup_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init(&cgroup_event->event_id.header, &sample,
+				PERF_RECORD_CGROUP, /* misc=3D */ 0, size,
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	perf_output_put(&handle, cgroup_event->event_id);
 	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
@@ -9634,8 +9620,6 @@ static void perf_event_cgroup_output(struct perf_event =
*event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	cgroup_event->event_id.header.size =3D header_size;
 }
=20
 static void perf_event_cgroup(struct cgroup *cgrp)
@@ -9650,11 +9634,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
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
@@ -9677,7 +9656,6 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 	while (!IS_ALIGNED(size, sizeof(u64)))
 		cgroup_event.path[size++] =3D '\0';
=20
-	cgroup_event.event_id.header.size +=3D size;
 	cgroup_event.path_size =3D size;
=20
 	perf_iterate_sb(perf_event_cgroup_output,
@@ -9733,38 +9711,40 @@ static void perf_event_mmap_output(struct perf_event =
*event,
 	struct perf_mmap_event *mmap_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int size =3D mmap_event->event_id.header.size;
-	u32 type =3D mmap_event->event_id.header.type;
-	bool use_build_id;
+	int size =3D sizeof(mmap_event->event_id) + mmap_event->file_size;
+	u32 type =3D PERF_RECORD_MMAP;
+	u16 misc =3D PERF_RECORD_MISC_USER;
+	bool use_build_id =3D false;
 	int ret;
=20
 	if (!perf_event_mmap_match(event, data))
 		return;
=20
 	if (event->attr.mmap2) {
-		mmap_event->event_id.header.type =3D PERF_RECORD_MMAP2;
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->maj);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->min);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->ino);
-		mmap_event->event_id.header.size +=3D sizeof(mmap_event->ino_generation);
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
+		use_build_id =3D event->attr.build_id && mmap_event->build_id_size;
+		if (use_build_id)
+			misc |=3D PERF_RECORD_MISC_MMAP_BUILD_ID;
+	}
+	if (!(mmap_event->vma->vm_flags & VM_EXEC))
+		misc |=3D PERF_RECORD_MISC_MMAP_DATA;
+
+	perf_event_header__init(&mmap_event->event_id.header, &sample,
+				type, misc, size, event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	mmap_event->event_id.pid =3D perf_event_pid(event, current);
 	mmap_event->event_id.tid =3D perf_event_tid(event, current);
=20
-	use_build_id =3D event->attr.build_id && mmap_event->build_id_size;
-
-	if (event->attr.mmap2 && use_build_id)
-		mmap_event->event_id.header.misc |=3D PERF_RECORD_MISC_MMAP_BUILD_ID;
-
 	perf_output_put(&handle, mmap_event->event_id);
=20
 	if (event->attr.mmap2) {
@@ -9789,9 +9769,6 @@ static void perf_event_mmap_output(struct perf_event *e=
vent,
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	mmap_event->event_id.header.size =3D size;
-	mmap_event->event_id.header.type =3D type;
 }
=20
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
@@ -9887,11 +9864,6 @@ got_name:
 	mmap_event->prot =3D prot;
 	mmap_event->flags =3D flags;
=20
-	if (!(vma->vm_flags & VM_EXEC))
-		mmap_event->event_id.header.misc |=3D PERF_RECORD_MISC_MMAP_DATA;
-
-	mmap_event->event_id.header.size =3D sizeof(mmap_event->event_id) + size;
-
 	if (atomic_read(&nr_build_id_events))
 		build_id_parse_nofault(vma, mmap_event->build_id, &mmap_event->build_id_si=
ze);
=20
@@ -10011,11 +9983,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
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
@@ -10045,18 +10013,15 @@ void perf_event_aux_event(struct perf_event *event,=
 unsigned long head,
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
+	perf_event_header__init(&rec.header, &sample,
+				PERF_RECORD_AUX, /* misc=3D */ 0, sizeof(rec),
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
@@ -10081,15 +10046,14 @@ void perf_log_lost_samples(struct perf_event *event=
, u64 lost)
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
+	perf_event_header__init(&lost_samples_event.header, &sample,
+				PERF_RECORD_LOST_SAMPLES,
+				/* misc=3D */ 0,
+				sizeof(lost_samples_event),
+				event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
@@ -10114,6 +10078,8 @@ struct perf_switch_event {
 		u32				next_prev_pid;
 		u32				next_prev_tid;
 	} event_id;
+	bool			sched_in;
+	bool			preempt;
 };
=20
 static int perf_event_switch_match(struct perf_event *event)
@@ -10126,6 +10092,9 @@ static void perf_event_switch_output(struct perf_even=
t *event, void *data)
 	struct perf_switch_event *se =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u32 type;
+	u16 misc;
+	u16 size;
 	int ret;
=20
 	if (!perf_event_switch_match(event))
@@ -10133,18 +10102,22 @@ static void perf_event_switch_output(struct perf_ev=
ent *event, void *data)
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
+	perf_event_header__init(&se->event_id.header, &sample,
+				type, misc, size, event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event, se->event_id.header.size=
);
 	if (ret)
@@ -10170,22 +10143,11 @@ static void perf_event_switch(struct task_struct *t=
ask,
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
-	if (!sched_in && task_is_runnable(task)) {
-		switch_event.event_id.header.misc |=3D
-				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
-	}
-
 	perf_iterate_sb(perf_event_switch_output, &switch_event, NULL);
 }
=20
@@ -10205,20 +10167,17 @@ static void perf_log_throttle(struct perf_event *ev=
ent, int enable)
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
 	};
=20
-	if (enable)
-		throttle_event.header.type =3D PERF_RECORD_UNTHROTTLE;
-
-	perf_event_header__init_id(&throttle_event.header, &sample, event);
+	perf_event_header__init(&throttle_event.header, &sample,
+				enable ? PERF_RECORD_UNTHROTTLE
+				: PERF_RECORD_THROTTLE,
+				/* misc=3D */ 0,
+				sizeof(throttle_event),
+				event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
@@ -10257,12 +10216,14 @@ static void perf_event_ksymbol_output(struct perf_e=
vent *event, void *data)
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int ret;
+	u16 size =3D sizeof(ksymbol_event->event_id) + ksymbol_event->name_len;
=20
 	if (!perf_event_ksymbol_match(event))
 		return;
=20
-	perf_event_header__init_id(&ksymbol_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init(&ksymbol_event->event_id.header, &sample,
+				PERF_RECORD_KSYMBOL, /* misc=3D */ 0, size,
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
@@ -10303,11 +10264,6 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32=
 len, bool unregister,
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
@@ -10351,8 +10307,11 @@ static void perf_event_bpf_output(struct perf_event =
*event, void *data)
 	if (!perf_event_bpf_match(event))
 		return;
=20
-	perf_event_header__init_id(&bpf_event->event_id.header,
-				   &sample, event);
+	perf_event_header__init(&bpf_event->event_id.header, &sample,
+				PERF_RECORD_BPF_EVENT,
+				/* misc=3D */ 0,
+				sizeof(bpf_event->event_id),
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
@@ -10408,10 +10367,6 @@ void perf_event_bpf_event(struct bpf_prog *prog,
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
@@ -10439,18 +10394,23 @@ static void perf_callchain_deferred_output(struct p=
erf_event *event, void *data)
 	struct perf_callchain_deferred_event *deferred_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
-	int ret, size =3D deferred_event->event.header.size;
+	int ret;
+	u16 size =3D sizeof(deferred_event->event) + (deferred_event->trace->nr * s=
izeof(u64));
=20
 	if (!event->attr.defer_output)
 		return;
=20
 	/* XXX do we really need sample_id_all for this ??? */
-	perf_event_header__init_id(&deferred_event->event.header, &sample, event);
+	perf_event_header__init(&deferred_event->event.header, &sample,
+				PERF_RECORD_CALLCHAIN_DEFERRED,
+				PERF_RECORD_MISC_USER,
+				size,
+				event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				deferred_event->event.header.size);
 	if (ret)
-		goto out;
+		return;
=20
 	perf_output_put(&handle, deferred_event->event);
 	for (int i =3D 0; i < deferred_event->trace->nr; i++) {
@@ -10460,8 +10420,6 @@ static void perf_callchain_deferred_output(struct per=
f_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
=20
 	perf_output_end(&handle);
-out:
-	deferred_event->event.header.size =3D size;
 }
=20
 static void perf_unwind_deferred_callback(struct unwind_work *work,
@@ -10470,12 +10428,6 @@ static void perf_unwind_deferred_callback(struct unw=
ind_work *work,
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
@@ -10487,7 +10439,8 @@ static void perf_unwind_deferred_callback(struct unwi=
nd_work *work,
 struct perf_text_poke_event {
 	const void		*old_bytes;
 	const void		*new_bytes;
-	size_t			pad;
+	u16			tot;
+	u16			pad;
 	u16			old_len;
 	u16			new_len;
=20
@@ -10508,13 +10461,18 @@ static void perf_event_text_poke_output(struct perf=
_event *event, void *data)
 	struct perf_text_poke_event *text_poke_event =3D data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 size =3D sizeof(text_poke_event->event_id) + text_poke_event->tot + tex=
t_poke_event->pad;
 	u64 padding =3D 0;
 	int ret;
=20
 	if (!perf_event_text_poke_match(event))
 		return;
=20
-	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, even=
t);
+	perf_event_header__init(&text_poke_event->event_id.header, &sample,
+				PERF_RECORD_TEXT_POKE,
+				PERF_RECORD_MISC_KERNEL,
+				size,
+				event);
=20
 	ret =3D perf_output_begin(&handle, &sample, event,
 				text_poke_event->event_id.header.size);
@@ -10552,15 +10510,11 @@ void perf_event_text_poke(const void *addr, const v=
oid *old_bytes,
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
@@ -10591,13 +10545,12 @@ static void perf_log_itrace_start(struct perf_event=
 *event)
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
+	perf_event_header__init(&rec.header, &sample,
+				PERF_RECORD_ITRACE_START, /* misc=3D */ 0, sizeof(rec),
+				event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
@@ -10622,12 +10575,10 @@ void perf_report_aux_output_id(struct perf_event *e=
vent, u64 hw_id)
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
+	perf_event_header__init(&rec.header, &sample,
+				PERF_RECORD_AUX_OUTPUT_HW_ID, /* misc=3D */ 0,
+				sizeof(rec), event);
 	ret =3D perf_output_begin(&handle, &sample, event, rec.header.size);
=20
 	if (ret)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1b1ffe0..13bd42e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -246,14 +246,13 @@ __perf_output_begin(struct perf_output_handle *handle,
 	handle->size =3D (1UL << page_shift) - offset;
=20
 	if (unlikely(have_lost)) {
-		lost_event.header.size =3D sizeof(lost_event);
-		lost_event.header.type =3D PERF_RECORD_LOST;
-		lost_event.header.misc =3D 0;
 		lost_event.id          =3D event->id;
 		lost_event.lost        =3D local_xchg(&rb->lost, 0);
=20
 		/* XXX mostly redundant; @data is already fully initializes */
-		perf_event_header__init_id(&lost_event.header, data, event);
+		perf_event_header__init(&lost_event.header, data,
+					PERF_RECORD_LOST, /* misc=3D */ 0,
+					sizeof(lost_event), event);
 		perf_output_put(handle, lost_event);
 		perf_event__output_id_sample(event, handle, data);
 	}
