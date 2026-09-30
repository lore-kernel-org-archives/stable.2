Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EC2F8EAE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766869; cv=none; b=swJGK25yPF/0os1cOx1UvnlLi6kvNpnrBpttLs7kVvEO+vOGXLm74OvPUOqQZs3lUdXEpz9huZQlr6wmOa5lCwHf6cV3atAmJbyS2Wy7L7DWH4gZ/ihPL0nnU7jg50VBtHILTQCon2DK10uT1kw42nOtqEwWcc7US4eAprfmWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766869; c=relaxed/simple;
	bh=vWd1vAEEkhz/3pY1X27+cQBUoN3ot9ph08D6bRvbdpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbqMUppuGmBzjUpnPFw32tduM910j4r4Xztp5WqVOmLfNouN8AUfPKLK2Ln8LlToG+hAl/8IHe/HyiLn0rlvU84dUR2p6JQQJVPs4XaXWs4OLDQUw5zEu64+6WR2LxMdxBWWVRROJ7uBa1EgwcVPL/Emp0EJRYKJBIVsfy3tx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoE7/eZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoE7/eZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AC51F00898;
	Wed, 30 Sep 2026 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766868;
	bh=I9KZUi6i2zblRhZaoxAGTKLQB1VX/CkNRaVvIvJe3uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoE7/eZq+kEXHFeLLUxJfVXnJvCPxyvtTFieaI3fML4LIF9nziiXGqNmrtSprw9bA
	 1vazUCctYMvTnQfqwOT1lKLabbwVtxBjooNt19SJQMgiqfdNeETaUObGblrnLEKd8s
	 rIRs5vGT112BYJlQYQh5TaNZZrfLYw/dMo8MXH6TIGPdiy0PsI+1PJzq6xdL08ulVb
	 J2N6FJbZTF0jFWii5xY/bag4afvoXEF01wMCm1bdHvLIWhIXjI8MysE6gkH/UtA9To
	 qyeWXyv3ZFUoCBrdKU6bmOAVJeXMWiIM/7Zy1WlIFMks992d9T8wC0K5rsgpFHb7s+
	 wne1nlutLhe7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] perf/x86/intel: Remove incorrect LionCove PEBS data-source constraints
Date: Wed, 30 Sep 2026 07:14:25 -0400
Message-ID: <20260930111425.1207870-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111425.1207870-1-sashal@kernel.org>
References: <2026092943-cosmetics-enforced-4f4e@gregkh>
 <20260930111425.1207870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit 7c944595cc43a664019edc22505b6d6f6039be5e ]

On Lion Cove, PEBS data source is valid only for these events:

- MEM_TRANS_RETIRED.LOAD_LATENCY (0x1cd)
- MEM_TRANS_RETIRED.STORE_SAMPLE (0x2cd)

The perfmon database (https://github.com/intel/perfmon) previously
tagged additional memory events such as MEM_INST_RETIRED.STLB_MISS_LOADS
with L1_Hit_Indication, implying PEBS data-source support, which is
incorrect. The database has since been fixed, but
intel_lnc_pebs_event_constraints[] still follows the old definition and
marks those events as data-source capable.

As a result, get_data_src() may decode data-source information for
events that do not provide valid PEBS data-source data and mislead
users.

Remove those non-data-source memory events from the Lion Cove PEBS
constraint table so matching falls back to the regular non-PEBS
constraints, which already provide the same counter constraints.

Also update lnc_latency_data() to decode LOAD/STORE flags explicitly
when setting memory operation direction, for consistency with other
*_latency_data() helpers.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260917015234.981153-6-dapeng1.mi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/ds.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 99afbcf130bc7..22b08be040fce 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -385,7 +385,11 @@ static u64 lnc_latency_data(struct perf_event *event, u64 status)
 		val |= P(BLK, NA);
 
 	src.val = val;
-	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op = P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
 		src.mem_op = P(OP, STORE);
 
 	return src.val;
@@ -1211,24 +1215,8 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
 
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04a4, 0x1),		/* TOPDOWN.BAD_SPEC_SLOTS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08a4, 0x1),		/* TOPDOWN.BR_MISPREDICT_SLOTS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x10a4, 0x8),		/* TOPDOWN.MEMORY_BOUND_SLOTS */
-
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
-	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
-
-	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
-
-	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
 
 	/*
 	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
-- 
2.53.0

