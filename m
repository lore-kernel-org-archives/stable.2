Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77B2BEFEE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766869; cv=none; b=PuYqdH59l1IKRfKH1gyxsP6I6wH9OGfbHwhV1So0gRt30oQBWkdwQ01ML7eFv6DsS6xGSFA7TmdjeBjIZzK+mfXP+dwPsbsX25c+/8TVc6pF3oU4rAZ06S6P9+iuoB2hYd9OYjEk47MaJ0irMijCn29z4xLTs3JLIGmhORPNNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766869; c=relaxed/simple;
	bh=XxS8mN85UYhYBn9UZVKrVTDnWVO+Yza1JWWNaQC9LH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVKJK7ZxyWvBWznCARGUnI2TaqZ3G7R0TzipRIQPiScVPTCXTHgFVrF4JlaNL4eavJJZJwdd1JTqyjvZam5uRlPvjFXnuZ/p/NTOcZMMQDgZXXA4X5Hiog/p/DfIJ5kGTAk335r3lUQlqsHzeBA24Aq57msXNrf0El2ezkYolxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw0xKeVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw0xKeVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3071F000FF;
	Wed, 30 Sep 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766867;
	bh=9D6YpaxDDk0qd4LjYEvoZETQEeN/P9Nv/w4FF6Mr11U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qw0xKeVxSE/Se+Lni4FYAtNHQcrTeUuDxL8AlvZTHHTuiIxPGagrHjW4x6KgCbwvm
	 t9WPO6THufH2GQQolCKUj5/B4wI+m3MZ6Z2S5C/iEhlt5BOgMB24fgKsmnxBCRsx6U
	 7pTTayNkkfVjZUNKY5FQNJywLeIR1USggsDyoyR4sEUSaKPSmEuHx/R1Ww/wF8hCVQ
	 uXwdJ+bgc5a0LaRBX5GQFf0Dio/PObQFRQqB8/zIIQpB6HUWVwGZxrXANmIjtG8qM1
	 x4wDGraTVZpLyGy69zjusTSi0QC1ElfafGbcmPBsakF+xAPa40REAae0Vx887YXf2H
	 mWyF0APuOmk7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] perf/x86/intel: Update event constraints and cache_extra_regsfor LNL
Date: Wed, 30 Sep 2026 07:14:24 -0400
Message-ID: <20260930111425.1207870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092943-cosmetics-enforced-4f4e@gregkh>
References: <2026092943-cosmetics-enforced-4f4e@gregkh>
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
index 4dacbf664b303..72f8131a60339 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -412,11 +412,12 @@ static struct event_constraint intel_lnc_event_constraints[] = {
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
index 711e8a6f46a3a..99afbcf130bc7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1208,6 +1208,13 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
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
@@ -1217,6 +1224,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
 
 	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
 
-- 
2.53.0

