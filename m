Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29138F935;
	Thu,  6 Aug 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024404; cv=none; b=QUV5TchacwTiWuwY/ED2CDfCSeetw1nj5vYN46dlxr0ZhxScIkaZmPym6TsCgfUoOOncL1C33nxur85MOytqG1gKhhKemsyFbdNqOEC3MbyTnCdzIXCMUi8okUqLhh2cQVrH6rGzTWbQjrbJVhkdOeNyz/KPqRYMkVrniMOmd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024404; c=relaxed/simple;
	bh=CO1nekQ96Zo5yBUy9L+L/CcDmHipw3KUTjZ/59r0Ymc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkbULHPjrAWaveNr2+gzeyoTJ84F4/6loxPyONebU/c6PvlilN5kRtwcKAts77NILAiNhcNvQm/y7wLzVr2unFLbFAO3slyIMG/I/YI3XryGIwV8pt3xuBxicwcJL0j6cUTaP2Eoe1ZtU4+pTA6Mt9AHOQHO9IGHD+DjZWaVoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+BWU4WI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+BWU4WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E11F000E9;
	Thu,  6 Aug 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024402;
	bh=7DTQ07GJKnfbpZQI4eZNwIceuMVDGsiSmnyh13hn3T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+BWU4WIQSW3J6P4C5TRKyo/AXNNQHs35lrkU1rCrq12MFCQqUAJcnTiEAfwgaA0K
	 QGpIWb/krRM7CI3msRzsZATYaZVO6J6jwU3uVBzd5atQj8NQnB4TrtZW2RnaYIl/X0
	 h9H+f7VOsjjpg5yQLjx1OHOhoDb/HWkPWnN9W3WbAv5WTrb5lNa04cljWr/zdgBWDn
	 795UkbpZDwZubWpMnseP/14Fn24rJ6H6nUzSmB7OVGPMRYoDOhLbwM7wIIrnSleikD
	 zlF4xMB6eMteV9aDqgoJ3lE94Ja/GJfwMQRSXr/WOq8orxYhvIcQlRTWDcdHmvunSA
	 S/VSKMKP43H6w==
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
Subject: [PATCH v6 2/3] perf/core: Run sched_task() for PMUs with only CPU-wide events
Date: Thu,  6 Aug 2026 06:52:22 -0700
Message-ID: <20260806135224.3267890-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806135224.3267890-1-puranjay@kernel.org>
References: <20260806135224.3267890-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
leaves the work to perf_ctx_sched_task_cb(). That one only walks
ctx->pmu_ctx_list, so a PMU whose events are all CPU-wide is never
visited and its sched_task() callback does not run. With

  perf record -b -e cycles -a -- ls

armv8pmu_sched_task() is skipped on every switch to a task that has a
perf event of its own, and BRBE records leak across the task boundary.
intel_pmu_lbr_add() calls perf_sched_cb_inc() unconditionally as well,
so LBR records leak the same way on x86.

Drop the early return and instead skip the individual CPCs that
perf_ctx_sched_task_cb() already handles.

That requires the two to agree on which CPC belongs to which path, and
they do not. perf_ctx_sched_task_cb() gates on cpc->sched_cb_usage,
which perf_sched_cb_inc() sets per CPU for every branch stack user,
while the new gate uses cpc->task_epc, which __link_epc() sets only on
the CPU the task context is scheduled in on. A task with an event for
that PMU pinned to another CPU has an epc on ctx->pmu_ctx_list while
cpc->task_epc is NULL, so both paths would run and sched_task() would be
called twice per context switch. On x86 the second
__intel_pmu_lbr_restore() finds lbr_stack_state == LBR_NONE and calls
intel_pmu_lbr_reset(), throwing away the callstack the first one
restored. So gate perf_ctx_sched_task_cb() on cpc->task_epc too.

For the CPCs that perf_pmu_sched_task() now handles, the callback no
longer runs inside the perf_ctx_disable() and perf_ctx_enable() pair in
perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
around the call itself, so the callback still runs with it disabled.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@vger.kernel.org
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9815894b67e77..675dd05935f35 100644
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
@@ -3921,12 +3924,15 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cpu_pmu_context *cpc;
 
-	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
-	if (prev == next || cpuctx->task_ctx)
+	if (prev == next)
 		return;
 
-	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		if (cpuctx->task_ctx && cpc->task_epc)
+			continue;
+
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
+	}
 }
 
 static void perf_event_switch(struct task_struct *task,
-- 
2.53.0-Meta

