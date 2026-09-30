Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370024052DE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766866; cv=none; b=N1Ry7m3hpwslCSAU4fhU22ZrP5PqCxTu6I2snexqrvpaPupv6t56HcVJyzoQ7jYgatMfceeavmhp0dH3p13nvxo06iusPjPveO2YQ+BMVOI0kgTOw6lJfOVlgAg8SWIbEndkdvuzAR9pA4vWaILV5kJrZGw5bCDjGaaSf9sE9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766866; c=relaxed/simple;
	bh=zaw64Q8eSeoN5SClJ0N5H3EM9Yq2zwne6/jP+fAbGQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPtPFSqKNelcfQduaCO1SAfWJcjgtZXMeyDwYUkiHdoz5SsnQBw8nxUc/bMkDz4EjpnR8AWeiiwgfUpZqOKfTVNuOI7ZYjnRHnQZaNrVHzH51DofMu5mBQmwQpTzr6spfEycTBZ+YRn+aRPrjQZassR7kAiotro13UGW7NqdDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU+5dgYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU+5dgYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702891F000FF;
	Wed, 30 Sep 2026 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766864;
	bh=nA+TGNroDhqHJ+LWYeh2num2V5wSUffpCGT5x4e60fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HU+5dgYe+9UCj0kaFRhxGVzhfvk6QdOh4dQWZ5Vv9LoPFSFQO0V3rLdE5qXhxqrfE
	 EIpsMpjbeXFUGiGGGifSM2eCyMbYM+1GYi21zXH+teL4iPlcsvgSDSk21qJ6hSA6T+
	 mUsqfOfYcdcHTNsDm4b6o35iF11Nip50AUsPoPHcsYAfsnPWdMpt87lanSZLTNgCpC
	 c6lp8+2zhbCf2qp9cMaBfqNZbNbWPHZmlFN7IFP6Om2A4MZ6hXX89tzt4ZKFKzDXiQ
	 PhzTqmjB9msPoOzt/XxAb3+9g7FEqUATtx53hwVj0CzmcM4d6TJGQW7tXRRMXG4v68
	 DGdQF5UOR5WNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
Date: Wed, 30 Sep 2026 07:14:21 -0400
Message-ID: <20260930111423.1207533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092919-dab-circus-267e@gregkh>
References: <2026092919-dab-circus-267e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 4ef863352bcde482d65722ed721c3fd3967a67d6 ]

Update perf hard-coded event constraints and cache_extra_regs[] for
Alderlake according to the latest ADL perfmon events (V1.39).

One important note is that ADL has differences on the L3/node related
OCR events although it shares same uarch with SPR server, e.g.,
ADL has different extra MSR values and no node events. So some variants
of structures and functions are introduced to reflect these
differences, like adl_glc_hw_cache_event_ids[],
adl_glc_hw_cache_extra_regs[] and intel_pmu_init_glc_hybrid(), etc.

Please note these changes would temporarily impact other platforms like
MTL/ARL-U which shares hard-coded event structures, but it would be
fixed soon in subsequent patches.

ADL perfmon events:
https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_goldencove_core.json
https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_gracemont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260515061143.338553-5-dapeng1.mi@linux.intel.com

[Stable dependency adaptation]
Retain only the Gracemont STORE_LATENCY (event 0x6d0) PEBS counter-mask
update from 0xf to 0x3f in intel_grt_pebs_event_constraints[]. This is the
preimage required by target 89dc568e8c0be60e05e5fcd0b528c79077d7b84b.
The existing latency decoder and LOAD/STORE constraint macros are already
available in this stable tree, so no new functions are needed.

Drop all core.c changes: the cache-event tables, offcore MSR masks,
fixed-event aliases and hybrid initialization changes are unrelated to the
target. Their upstream context includes cache tables absent from 6.18,
and retaining them would bring in an unnecessary helper function and
broader platform changes.

[ sashal: Reduced backport -- upstream 4ef863352bcde touches 2 file(s), this
  backport carries 1. Not backported here:
  arch/x86/events/intel/core.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 89dc568e8c0b ("perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix sample classification")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 711e8a6f46a3a..3fa8a7ee45c4b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1011,7 +1011,7 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
 	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.53.0

