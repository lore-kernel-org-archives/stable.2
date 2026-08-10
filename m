Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E143E0096;
	Mon, 10 Aug 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368955; cv=none; b=AAfZqT474HVzkzeTmsFbvbc84VuAPoOq63PMl0+VhTez52whSuEkOT+5OEDCuFJ7EAejKXoeH0uFZ/bjECu5ytNCE/Zz5qgxQm4LmKDUOj1FJhyokM6iIXe767utBJZIKYtpDe12wlsioYHAIuqBPNZbh/403G701xTkGGXAXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368955; c=relaxed/simple;
	bh=EgSOJGmrrtDIwoONebb2VWePpMr0xPNQX6dcGwPtH1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP/Y44fGs2BptRrZ+EmCDP3+0ff/0YMw6+gIscaeuaceo1P0IfxwappAIKaTd9947y8G9c7OTHU6EVyhHZEZWqrPdBNUeyuFMYFxTqm1zXeVbd4fTUWLo2genzIvv/hY78VgkkhULcFzGoTU04wkkd1K7r7t5ONv7AiR0qEcgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA6+rlWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA6+rlWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2341F000E9;
	Mon, 10 Aug 2026 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368954;
	bh=utuvlWj153YehjtmXoJH+cLSsBfPwLyLld+tIz5367I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fA6+rlWx9MznANhijGPEQXzbpI+LfE4qbpQQzwavQcB45kKtouBfKT5U9NOxNwiiv
	 zU8TntJjpdOWZiPYDOBnphwZgS3LsNYyjIiiFeU7o7kmYZrKgUa0BR0SDgMYiKa8Ik
	 HBTgYwWgNtUwhBoR5iETKkE3/Bleroy4htu44CaW5JR4yLIlc0Ixwb0Ecgt2pyiKTG
	 PIoEh7rHabI5Y+BS3Wh77wgGVMRmB1wP222iPgsfAEEaxRckTCq8GE/vb/owHcKSbQ
	 76biHZgc4hv+CKXusKGQWmL1Fp3yBsD39NI8u5TvECj50IV4aivyfG9QuZudT3CEAi
	 z813PvehqSf5w==
From: Puranjay Mohan <puranjay@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 2/3] perf/core: Run sched_task() for PMUs with only CPU-wide events
Date: Mon, 10 Aug 2026 06:35:35 -0700
Message-ID: <20260810133540.1947118-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810133540.1947118-1-puranjay@kernel.org>
References: <20260810133540.1947118-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
leaves the work to perf_ctx_sched_task_cb(), which only walks
ctx->pmu_ctx_list. A PMU whose events are all CPU-wide is not on that
list, so nothing calls its sched_task(). With

  perf record -b -e cycles -a -- ls

armv8pmu_sched_task() is skipped on every switch to a task that has a
perf context but no event on that PMU, and BRBE records leak across the
task boundary. intel_pmu_lbr_add() calls perf_sched_cb_inc()
unconditionally too, so LBR records leak the same way on x86.

Drop the early return and skip only the CPCs that
perf_ctx_sched_task_cb() handles. That one needs a gate of its own to
make the split exact: it tests cpc->sched_cb_usage, which
perf_sched_cb_inc() sets per CPU for every branch stack user, so a task
with an event for that PMU pinned to another CPU would be handled twice.
On x86 the second __intel_pmu_lbr_restore() finds lbr_stack_state ==
LBR_NONE and calls intel_pmu_lbr_reset(), throwing away the callstack
the first one restored.

cpc->task_epc is set only while a task context is scheduled in, and
there is one epc per PMU on ctx->pmu_ctx_list, so the two gates are
inverses.

For the CPCs perf_pmu_sched_task() picks up, the callback now runs
outside the perf_ctx_disable() and perf_ctx_enable() pair in
perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
around the call itself.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@vger.kernel.org
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 05635217696c2..34eb05e9d74d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3757,6 +3757,9 @@ static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
 		cpc = this_cpc(pmu_ctx->pmu);
 
+		if (cpc->task_epc != pmu_ctx)
+			continue;
+
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
@@ -3917,15 +3920,17 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 				struct task_struct *next,
 				bool sched_in)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cpu_pmu_context *cpc;
 
-	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
-	if (prev == next || cpuctx->task_ctx)
+	if (prev == next)
 		return;
 
-	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		if (cpc->task_epc)
+			continue;
+
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
+	}
 }
 
 static void perf_event_switch(struct task_struct *task,
-- 
2.53.0-Meta

