Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06952B1F6;
	Tue, 22 Sep 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070404; cv=none; b=MskNQtl3utGhinGTNvMVgEcR/UuPlgwJybRmbqcoApDsgWFgt8Pc6ReckxKTI1IXwRu9gfd59L1edGEKOr5u1qzyxoSmpR2PUdhk+enquRog+NNTDuu76cmLfw1eyJxLOh/1qP82ZGwYUuXhOVC8NvgFY/mDPcsROHzchYIHvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070404; c=relaxed/simple;
	bh=GJCjBXl5qxGrWAQ+83Dj55v2FqS+6ILha4dba8YX4q8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HUkjMHKIw/RopeAigNv7A9z8xgUkHKa3FzpyTVVeIkb+n6kDbDu44nN4O3D+587+6YJ5lhQXBFWEUO6NwYDoMqgDzDikZYjUBadp/KXM/jCZQV4CSC4XmAWxt1hIuZ0DGeBdRCNDVeXCZ2E8VeO0636S1Z5ux5IYbuTKaHVtvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ccIycCdR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9wzvgR97; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ccIycCdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9wzvgR97"
Date: Tue, 22 Sep 2026 09:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790070400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oJzhPcQw6HR0ZtrXOV1zcy7uE6WF8KTsUrxpsuAe3w=;
	b=ccIycCdRAD0ZPtt6aGKQVOYp6y6hbYw+cwA0jV1pJEwJH51LEQIvtXq0HJPBckbNXrYkSI
	AGERxAO/hLJCA8wPfIhS2BUJUkzkZkmECF++SVon+5ujmfczQeU4ty1o8cpIesAD2VImMV
	L+fK33VU3IIvhi2dSeDrov48msoHdhcjXxR7Ol369oN5wX0gobkjG4qN+/BCO2yL6cO24P
	TKIFMC2g7QBqa+m34HSIchQKR6co7sptD3ZJp3GP3ZBb7Qh6Ae6QLPWNLJ9Fm9cuo93jJh
	BmKYxQlNsszcGF2WMu8eWL71uaFFtduFq+QslhckLw30NUEUhaxPBUXB/qgT0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790070400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oJzhPcQw6HR0ZtrXOV1zcy7uE6WF8KTsUrxpsuAe3w=;
	b=9wzvgR97SDwisCDaT7Mx7QJnNn36CrW/LRSN7j4k80ZdP8ahYDa4RHkH0fU0cSx9Q+/B6M
	zse+HXKDg2dQdwAQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix GRT PEBS load/store direction
 for latency events, to fix sample classification
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917015234.981153-2-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179007039880.2819794.3577837900857930442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     89dc568e8c0be60e05e5fcd0b528c79077d7b84b
Gitweb:        https://git.kernel.org/tip/89dc568e8c0be60e05e5fcd0b528c79077d=
7b84b
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 17 Sep 2026 09:52:23 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2026 11:17:00 +02:00

perf/x86/intel: Fix GRT PEBS load/store direction for latency events, to fix =
sample classification

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

Fixes: 39a41278f041 ("perf/x86/intel: Fix PEBS memory access info encoding fo=
r ADL")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # v7.2+
Link: https://patch.msgid.link/20260917015234.981153-2-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b98029b..fff98f4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -455,6 +455,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, =
bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
=20
 	WARN_ON_ONCE(is_hybrid() &&
@@ -470,7 +471,16 @@ static u64 __grt_latency_data(struct perf_event *event, =
u64 status,
 	else
 		val |=3D P(BLK, NA);
=20
-	return val;
+	src.val =3D val;
+
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_LDLAT | PERF_X86_EVENT_PEBS_LD_HSW))
+		src.mem_op =3D P(OP, LOAD);
+	if (event->hw.flags &
+	    (PERF_X86_EVENT_PEBS_STLAT | PERF_X86_EVENT_PEBS_ST_HSW))
+		src.mem_op =3D P(OP, STORE);
+
+	return src.val;
 }
=20
 u64 grt_latency_data(struct perf_event *event, u64 status)
@@ -1291,8 +1301,8 @@ struct event_constraint intel_glm_pebs_event_constraint=
s[] =3D {
=20
 struct event_constraint intel_grt_pebs_event_constraints[] =3D {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
=20
