Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC71D47AC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767182; cv=none; b=U5jyfUmTysmiZXTuDyIloZH1ZFryby/2s/tmMmFvp2FsxiugAIbJ/mRu/uqTYZy70Hi5ClaJw1pp7lGZRW4Ro4EY2zJtGDLFU8HZaBRls7BGL1Y585WfQ6GE7O+ghtN3L8X2hbq/e8ZNuKphsgfw/yslq/i+12EGDockPaWuN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767182; c=relaxed/simple;
	bh=rO2ZKfQu64fKuAWEYKYSceSMqJnb2AnH7Of48XvxTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOaMira9ZL1Gg3WwQJ5OyFpxIFe3TSp+XNjPSs6SnqA0LXRnp+zktCqHZ1M5OZxbIItfJlZuYOtuiqAOajcIGTQbmshmuBvULZhIU47l7aBe//3KarDR3p46eVST3iDyY6J/p9naairZI+SZ4P4fCib/qbjJk0DfQ3VDLNPq7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEr5t3Bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEr5t3Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E2D1F00898;
	Wed, 30 Sep 2026 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767180;
	bh=N6aw6qYxrg4z87lGYE+ZWJNBkP0spmVHoY+NeGdZ+JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEr5t3BockOwnJ51IemtjX2qCHx9Qu1WXJvsA0ZgMbVHjDFwbREBRRytNDVuhBsEz
	 Pi/17+jCJ5PaDFDp1Uhp9Ly+vkNBAEcL0S+fSpETmMpLh7+6cj3TDZVOnEoDhzaBX6
	 JHbv0+ieGyIVQmxxFKQN1dnLso31D2b4RDReATdDbNZKM8u8kUiI06AjnhqBVvFUnU
	 sIo3X46Tliw5MN9NGQ4lsocZY8y8m8Hw2eOda8fBnEePfBAMDG8V7M+tqJNQItBIp7
	 jDuVjBo5IBhOKf1GH9u1xhtFaHEI3qcDJzX0M8rVJBCt+fRETV+8M4jn8PFAkuOR+6
	 4LBNkgvKtQLwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification
Date: Wed, 30 Sep 2026 07:19:38 -0400
Message-ID: <20260930111938.1214426-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111938.1214426-1-sashal@kernel.org>
References: <2026092920-boned-lyricist-0082@gregkh>
 <20260930111938.1214426-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 89dc568e8c0be60e05e5fcd0b528c79077d7b84b ]

On Gracemont, intel_grt_pebs_event_constraints[] applies LAT_CONSTRAINT
constraints to MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set
explicit LOAD/STORE flags for those events.

The PEBS latency path (pebs_latency_data(), via __grt_latency_data())
uses the event flags to determine memory operation direction. Without an
explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
misclassified as LOADs.

Set explicit LOAD/STORE flags in intel_grt_pebs_event_constraints[] for:

- MEM_UOPS_RETIRED.LOAD_LATENCY
- MEM_UOPS_RETIRED.STORE_LATENCY

Also update __grt_latency_data() to explicitly interpret these flags when
assigning the sampled memory operation direction.

This fixes incorrect STORE sample classification.

Fixes: 39a41278f041 ("perf/x86/intel: Fix PEBS memory access info encoding for ADL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
Link: https://patch.msgid.link/20260917015234.981153-2-dapeng1.mi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/ds.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a055db3479483..710fab99d7500 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -303,6 +303,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
 
 	WARN_ON_ONCE(is_hybrid() &&
@@ -318,7 +319,16 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
 	else
 		val |= P(BLK, NA);
 
-	return val;
+	src.val = val;
+
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op = P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
 }
 
 u64 grt_latency_data(struct perf_event *event, u64 status)
@@ -981,8 +991,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.53.0

