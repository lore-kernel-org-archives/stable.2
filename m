Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036F472F86
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767181; cv=none; b=S+lNNfj55KiJVjiTWDvttrQWq8vhKqEMTlDYqOey92AI++mjWMjAELYo7xTpKqW2qdisOXFeoiqR88W2zZcE1wxrZ4TCbVWICKH+Dr0jYQBBN+WeHUdlgMEmueu1iJnhX6J6UPSuugi1RGxg36FDJJRQxfQVvjrsBzASYdgCYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767181; c=relaxed/simple;
	bh=Bjk+tcbfVlVLacVu4CAIzXJeAdxMpP/9gRMkoeTSu8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrFm2tKDoRyX3UMr07/Z9j347bQce5fRrPKZX4rjHMylOCQA33YvVrhOosVN7dWn4FiqrF9a35aNTPNUr1ZlwXsesPuZEUfstLUZWFCmujme/MJ42msMqQyJRXgPCBoIoSB59yqqbedfz2IHP9lpam92zKfx89IsczTiP0kUZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqmBjCjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqmBjCjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA291F000FF;
	Wed, 30 Sep 2026 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767180;
	bh=nF02Mo3HpgMtLpjLv4gAtIzPQgNeQv9HRtEB6r5c6AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqmBjCjhrqjjh4CljfRpXHKPwn8uA+GZ2QZ6s96qbWy4T4QjAQEhVt/AFi0SBcSvV
	 NuRFdljX/PO23fobMFywBltWWOYLhashOKfjwxWcKjvQfezAGVZD1/4w+XLxtU40GP
	 244KVRDpdiQwDWSD58BvZYC0m+FGtkipe82ar53w9RSZOKOC5ClKoyjvPXYkuW/IfV
	 FfI+Xk5qcKp5Vlf87myBH8f/aF9UJUoBpXqJkrss9NWSbYUWs4fiIIW3a92V+wxvIc
	 lk6XmPjpQx1MJB39MnWbgBNexmYhtEVdmEaYtrhEvqbyGFtx2MwoIcm/8hmlmi25cM
	 CLW4Xnn0MRXiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] perf/x86/intel: Update event constraints and cache_extra_regsfor ADL
Date: Wed, 30 Sep 2026 07:19:37 -0400
Message-ID: <20260930111938.1214426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092920-boned-lyricist-0082@gregkh>
References: <2026092920-boned-lyricist-0082@gregkh>
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
index 39f5038f5ce4f..a055db3479483 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -982,7 +982,7 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
 	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.53.0

