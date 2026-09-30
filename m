Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3B3CFF51
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767177; cv=none; b=X9FDWylRECjZiGldezaxCTa59qdV1BQKIySxtU8ZSDFFzTqCKNLFwp3o1v7zkkXb+SvtfRBxZC5WGGd3JPMt2f2ddktM4zVt2apO05YoN/+nk2H+Z412YBhKZkoqpSb4me50e8BLq9whOf2qL2nQBHtHvlanet3CxwBcmAelXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767177; c=relaxed/simple;
	bh=++tAOMJANmjQlx4hiI4Resan3/kqvE0n21U5Ahttk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjcjN4wU+LgJpLdXvgeiyWQgPiyA32tpnw9G02MwsDCCqfD4PmmJEWBmw3jNYWOd3UGHmDcZekBdsnE1TvOlcLKwcZsvO+ybHPS5OrwIw2s5jIa+OoboPbZsHzZj3C7V6cOjLyFbDKHyKvgAIJ/u7Kksph4JleI5IuY/6KeqtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jExfCL5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jExfCL5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75F91F000FF;
	Wed, 30 Sep 2026 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767176;
	bh=6SV/ZKOGagBJv0EQI4l9dbWXe9EdcoJyawmZW3lW9Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jExfCL5nEqGbLtKFdMsVAJGMknLY7wGfbw04hTYZuYDCS6WOxjsWkh7NH1aLNMWvs
	 Nx5128EwNnKxJ+g3HpCwZnQKLjpgeghOXsjkRrdME9Wpx579gN3R2ObgVGwwL+ScUT
	 LvRnB8pZl0chWq49jlhS2gw8husbdkWkE9DXlcFuT93xCr3prFVng5fkxz4tyM9jB7
	 rBKGTtNqBG0lPWudZd3d9YRsaTnkCdsJZ8fNDWrH3NFcY+VQyEaKAFQOLBMR0HIjDC
	 LsU6R0IInD+uw0TcYVWs1bZ+wSf4Yct82SCNCwbCrsvfZ2aVjDR/2Ay4bm6GFovHVv
	 wpd+0CNxwH7YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] perf/x86/intel: Update event constraints and cache_extra_regsfor LNL
Date: Wed, 30 Sep 2026 07:19:33 -0400
Message-ID: <20260930111934.1214295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092943-fleshy-frame-920b@gregkh>
References: <2026092943-fleshy-frame-920b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 331c3e4fa39a87560c09bdd878652090ae040b69 ]

Update perf hard-coded event constraints and cache_extra_regs[] for
Lunarlake according to the latest LNL perfmon events (V1.22).

LNL introduces new extra register values for the OCR L3 cache events,
so introduce lnc_hw_cache_extra_regs[] and skt_hw_cache_extra_regs[] to
reflect the changes.

LNL perfmon events:
https://github.com/intel/perfmon/blob/main/LNL/events/lunarlake_lioncove_core.json
https://github.com/intel/perfmon/blob/main/LNL/events/lunarlake_skymont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260515061143.338553-7-dapeng1.mi@linux.intel.com

[Backport to 6.18: retain the Lion Cove PEBS constraint additions needed
by 7c944595cc43 ("perf/x86/intel: Remove incorrect LionCove PEBS data-source
constraints"). Keep the matching regular counter masks for
TOPDOWN.MEMORY_BOUND_SLOTS (0x10a4, 0x8) and MEM_INST_RETIRED.ANY
(0x87d0, 0x3ff), since that fix removes their PEBS-specific entries and
falls back to the regular constraint table.

Omit the unrelated cache extra-register tables and PMU initialization
changes, which depend on cache-event refactoring and intel_pmu_init_cmt()
absent from 6.18. Also omit the unrelated fixed-counter, non-PEBS OCR,
0x00e0, and Skymont constraint updates. No functions are added.]

Stable-dep-of: 7c944595cc43 ("perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 3 ++-
 arch/x86/events/intel/ds.c   | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 27001daade100..37cc5f94b668f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -411,11 +411,12 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
-	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x8),
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
 	INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
 
+	INTEL_UEVENT_CONSTRAINT(0x87d0, 0x3ff),
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
 
 	INTEL_UEVENT_CONSTRAINT(0x00e0, 0xf),
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 39f5038f5ce4f..8afe088cb11d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1179,6 +1179,13 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
+
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04a4, 0x1),		/* TOPDOWN.BAD_SPEC_SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08a4, 0x1),		/* TOPDOWN.BR_MISPREDICT_SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x10a4, 0x8),		/* TOPDOWN.MEMORY_BOUND_SLOTS */
+
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
@@ -1188,6 +1195,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
 
 	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
 
-- 
2.53.0

