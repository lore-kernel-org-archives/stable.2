Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCC2EB5B8;
	Mon, 10 Aug 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368950; cv=none; b=L/rCxo3PVIe0xsOtXSAjWE4fGf39S+jCXmU2Z4xI99EWxgYeKtNFpI3gKmMte21NkMV5PLWKqJ56U2LMGwMS2JOUG4MBayNU6yISfqdLcWUJavMGX1udR5ps55Buw72RhRMOCMFqWA1oK7nO0EoPYuFq5t78CiCTbMTIlenSVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368950; c=relaxed/simple;
	bh=R5gNkinJAQZpQHyvJ4gIHrE9rkfG9/HhjapIRjtSNmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpL6uRfySxnJ496g2EVMuc9IGNjHjpzZhpBAboKlZxcIGsCxbs4mM3/A+3dWBR9D0eCQNb6K33vCgkFGFZq0ieDm8udeIaVZFnzMdyLrEhnZkcPp/EENmSu8R5wzEZcU/tfa+CGVm4xttlpOtsQ3pQF0i4gHkUI63V2M1cgbKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6sAuLM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6sAuLM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609B91F000E9;
	Mon, 10 Aug 2026 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368949;
	bh=gNT7bjfQ5ypnw0lOWzF1yyyxocddeiAffZrZpT0iW/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6sAuLM7PSbNKjIqL5Inn5dbxuj6R3Jjv4N9KexgPyTH/woXMpcvOw9bjRRHqNkS5
	 Ak5ID5Pl9iAEMcp07Y+K6+UHahvFTFJMIQpZyd+jPUrn+GttdTFz7zPIiS0RLgerZU
	 Srh7e9TR9+6wneRLif7eiTv3xBp09puNC+fHTtryjGK4WIjxEroVHRJFnUmgt5vQSz
	 i0AciJNQbSNH3gteOgkLq4MbgsbXDjMvgLoUx3muvky00oEJ7VmKyXKMnogPjJlFLM
	 7r0gbDzwQHXpuFGFLVi0nS4Gq2OxA72jiGmMIBfez+IsSodTzDSGts8IOjyV6p88SJ
	 7nE+UlO3R1KmQ==
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
Subject: [PATCH v7 1/3] perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()
Date: Mon, 10 Aug 2026 06:35:34 -0700
Message-ID: <20260810133540.1947118-2-puranjay@kernel.org>
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

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set, and
cpc->task_epc is only non-NULL while a task context is scheduled in on
this CPU. __perf_pmu_sched_task() therefore always passes NULL:

  Unable to handle kernel NULL pointer dereference at virtual address 00
  pc : armv8pmu_sched_task+0x14/0x50
  Call trace:
   armv8pmu_sched_task+0x14/0x50 (P)
   perf_pmu_sched_task+0xac/0x108
   __perf_event_task_sched_out+0x6c/0xe0

Pass &cpc->epc instead, the CPU-wide context for this PMU, which the
function already dereferences a few lines up to find pmu.

armv8pmu_sched_task() is the only in-tree implementation that
dereferences the argument, and it only reads ->pmu, so the oops needs
BRBE, added in v6.17.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@vger.kernel.org
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4638544205f28..05635217696c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3907,7 +3907,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_pmu_context *cpc,
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpc->task_epc, task, sched_in);
+	pmu->sched_task(&cpc->epc, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.53.0-Meta

