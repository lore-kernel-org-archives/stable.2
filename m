Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BB51588E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786419; cv=none; b=dclxSNE1Jw+RoTBz2vvzzzbBqQwkP6Ldv5eSfUYtQLHf0Ax12icuCOQO73lvCUxRDAZhzYAN7yr8HuTpaayoq/BpWFJOaqP/5If9SpDZdLl7jsjBl71wQ05fFIpW8OQxlf7Wa8qKok3kp5Ds6rpmGwjxPGJbHAYUi0rTtIs7nOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786419; c=relaxed/simple;
	bh=2NAPzwB3pCM0UXuXRPzbx6adYz9U3+saSsABRKvspjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9Nn7BAPX4jFF5VDr3jeRIAcN9oCwzOUvN+obOzQa+EqrF7RcNbclC3VeA83r6cBpPvlr3KwBE3f/hKWFFEh5DYGHhhJXMoChcma6QScAFu/Wkj3F1ld8dvd8nufFcNxH4NcHqC8CzwKg+62F/ABnKJLluqGG2lsplh1cDcZZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5tHJGly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5tHJGly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427AE1F00898;
	Wed, 30 Sep 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786416;
	bh=uOErqjupB5yz1uyURfu8txseTZl58EdRj5wzHqtP3EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M5tHJGly58+3C800z9LHB+v9bWlEq6UCXuFmWMXoOMpAQuiFL3f1aNEIpQGad9F/o
	 r9NyeNoYqTb59gfq8VDV0JgRtBjqqMUpisOozN4mSX+U4kIlminQZOALJ+xgqywoGQ
	 al5RKgj4fINV7laS1i1vGfkPXU4CEKi4n/unCpna9NuSEbipBBT3hBIZ7A1yBvQXmQ
	 DY9tVG62PKiVTHr+k37ymG4kxDt/xF2R3dEMbuQyqsuwvoVS5Ie66L/sEj4ZbCRYtp
	 GuRUYxpCFElrvqyZN6IZDRSTBwltDFL5oxHVWP1fHCHKYMiQFn16Pl5s0DCIKl2Op4
	 oAN3bltO4mFTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification
Date: Wed, 30 Sep 2026 12:40:14 -0400
Message-ID: <20260930164014.3227731-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930164014.3227731-1-sashal@kernel.org>
References: <2026092920-backward-implant-a0a9@gregkh>
 <20260930164014.3227731-1-sashal@kernel.org>
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
index d1cf9876c931d..d05db7aeef78a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -224,6 +224,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
 
 	WARN_ON_ONCE(is_hybrid() &&
@@ -238,7 +239,16 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
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
@@ -839,8 +849,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
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

