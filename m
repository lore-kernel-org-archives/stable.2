Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139D38F935;
	Thu,  6 Aug 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024400; cv=none; b=CbEv6lXUXX4g6oR9MTUnSIll8nBRBHvO4aj9ONm4+n4e+zc++4C6LTqaTCsj8cpjmNsfypaV5IN0m2QkFYKtyvw5LOtWsUJJkIhAj4wM94MTQNWfw0ETlmreuUYIyconTazFqEfb0f8KaKoLu8uDxu/jDOVEDgS+KM7LCvPiO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024400; c=relaxed/simple;
	bh=8j14VJKbz6zpjtn780yxQBSwgJqKRSzQK4DB7rajsE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDzUpLmwDYzNXVr1244rfR5FIoieuVhVWZ7okpcwRfGqTFQj41hqwo3pKxvm7LJpgzk4v5xEYn7Ci5iDQe7UVlVuMDPDmsMG2AZp6ixPzUiT2DT+5tqFIn7pHNoDB9C49PHRrktmdAe44sawSAE4FN6/dvd3OFlJCwlNggG3q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNi74+4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNi74+4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347CB1F000E9;
	Thu,  6 Aug 2026 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024399;
	bh=CNFDGBasAzdtMYMXr/QlbpUhNB9kt+XhO0QxWK3ASd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNi74+4psZcWvuyypQ6jT4auh3Kr9dB0kfp8MHGrNCRMh4o/O7lwSaSoLkHHzdGzK
	 gDm1LX8DUtLnGKzq4JEnFQ5U648Hrj0zzQNEDayOU2Er0E5hfyanaBpX7sJd85RBtP
	 5dxGQqLJVCykmwLMNLyEcBtu4NXOu5YyA8sePqMKRnpbPsVwilm2zl1IeUqap1NPdL
	 V+WNX8tHbeM3iLUF+iZN8Si6b/y7ejToEiEoIN0qwuh1PmZM3wSnGUkfaWgAdN8MHF
	 EXJEaSVaV46HagYmueFLHrjlk740OTb6HSR5QAzRw1efmMg3boy/m/p3O/WlPtjjrY
	 ST5oIHhRfD1CA==
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
Subject: [PATCH v6 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
Date: Thu,  6 Aug 2026 06:52:21 -0700
Message-ID: <20260806135224.3267890-2-puranjay@kernel.org>
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

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
cpc->task_epc is only non-NULL while a task context is scheduled in on
this CPU. __perf_pmu_sched_task() therefore always passes NULL:

  Unable to handle kernel NULL pointer dereference at virtual address 00
  pc : armv8pmu_sched_task+0x14/0x50
  Call trace:
   armv8pmu_sched_task+0x14/0x50 (P)
   perf_pmu_sched_task+0xac/0x108
   __perf_event_task_sched_out+0x6c/0xe0

Pass &cpc->epc instead. __perf_init_event_pmu_context() sets its ->pmu
when the PMU is registered; ->ctx stays NULL until a CPU-wide event
attaches. That is enough here because armv8pmu_sched_task() is the only
in-tree implementation that dereferences the argument at all, and it
only reads ->pmu. The oops therefore needs BRBE, which arrived in v6.17.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@vger.kernel.org
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b282de3e7d7ca..9815894b67e77 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3907,7 +3907,8 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(cpc->task_epc ? cpc->task_epc : &cpc->epc,
+			task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.53.0-Meta

