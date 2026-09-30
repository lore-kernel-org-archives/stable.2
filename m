Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9105403EA1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766867; cv=none; b=ob9i2b2TDCO+cxcXseuqBBQdA6BeNVkeMTaw1ye+xcaTQuUnSQIy6eBmPVGReddleWlLIGLnaLA2q8INzQX87iYzsc/xWW0veq7DqVdRtoh64XAvgyw12aBWcgXuAK8iSdMtIjBZTPAE3rB9DRjrFiHg0kDq0rsIMNav4PXNY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766867; c=relaxed/simple;
	bh=Eu5gCxXmU1qksq233IRtq79ZkczBwPJLZopCKmZ9oSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxhKlBVwlR5lIo0PAmQNwrkAV1+89fdaFmuxH3dHwWLslXa11fBkuod1DJxIfoROQXNq5zkAElTqZIZA28pbgqsC5xbJvKpkA9q+1K+zCbWE0g0kqkr7UUgi7DM9Wt5clhJqIy7Yc2BWBaU1jko706a3b/S/79wlJ4KAjdcexuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh4QpEAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh4QpEAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3411F00893;
	Wed, 30 Sep 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766865;
	bh=ryP7L9aY9Wd2MkAYrH8xM2DMsQc7qHKa47M+KqEeFTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dh4QpEAQc++AJxhUNTvgxado5DUsX4eTX62sb7cSGPOhPnZP8g6rOXSuqwnRkCpmv
	 wvDL1uW9M66Je2PWrlwDyq9ZNNfrfZAZ0H90tHol1NFWzReOTRUNh12v+Iy4YyuEmL
	 A71ayeaAcvUbJiEjwAOGwbshNwM567WIm2w4N8S49qqSulxT3GZ9WQ5X3owotErB9T
	 MmbowKSZ5M4QLE8MCoQ+eZU8DgeEBvHlItBsXakVGnMHnt3K6fd/bIWWRv7TyFCwDh
	 qWoSk5Qr25ezr+OzEWK9bUvRrVwqtGu2E49RE3+EXoe707iGTqITCdD1gMUVhjvWkj
	 TiJ90ywxDpClg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification
Date: Wed, 30 Sep 2026 07:14:22 -0400
Message-ID: <20260930111423.1207533-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111423.1207533-1-sashal@kernel.org>
References: <2026092919-dab-circus-267e@gregkh>
 <20260930111423.1207533-1-sashal@kernel.org>
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
index 3fa8a7ee45c4b..7bf1065265160 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -315,6 +315,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
 
 	WARN_ON_ONCE(is_hybrid() &&
@@ -330,7 +331,16 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
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
@@ -1010,8 +1020,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
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

