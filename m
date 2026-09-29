Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C8353A69
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681741; cv=none; b=lRg0OCJzDYVSFWNPdwwFkUOsKcCJr7xXxHUT0K3j4TWrdWfcqLQP6+IQGUkMU2iLv25fGG/wj7qAmw+hGn7Wlf1fNz/e5UQeYwd+MQBaX9qjm96/3UYcxdeRrwCfoERvecESrYjsRP9kYcIEaIl60cNQH4QoFYZ+ghGkuQ0eacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681741; c=relaxed/simple;
	bh=8T7EmXPB29aWLgZ4FBTm2GKm/L1Ck3ln7mDJSYhowq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SmM/vLij36ekhMiV8r8EyJDEqNja+Fqb4L6TJAW+zg3kVqXAkCHK8kiQ7p92uj5KrckdlQ4uGRSP650itKIqdSQ3/gigzHWYynvpuZ/OmLadHr/p7zzkOvCikYLiAxPclUID/0XQJLoO1JWhfND663E6FngWQtGa1bZOXiSsaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xonqIM2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xonqIM2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AB11F000FF;
	Tue, 29 Sep 2026 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681739;
	bh=COs+JvMorzPB2rgvkhroym40iXEBdBXJMjtwtXgj0FY=;
	h=Subject:To:Cc:From:Date;
	b=xonqIM2/DPx79CNugB4NUJT4iucOiHx/RLj4bklGMvl8o+HGgWlfDhe9HFz7jWGXo
	 AkddiU7Z0jAFXvGkPQ/FtFjrsvdNEidHXvqL+wG7Y+/2TADb3eBcnmh43JugQw/w6M
	 lU0uFdX2Ob7vIjH+S9Mu4W4SQQKE30BsGixRuMLU=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Fix GRT PEBS load/store direction for latency" failed to apply to 6.12-stable tree
To: dapeng1.mi@linux.intel.com,mingo@kernel.org,peterz@infradead.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:35:20 +0200
Message-ID: <2026092920-boned-lyricist-0082@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 89dc568e8c0be60e05e5fcd0b528c79077d7b84b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092920-boned-lyricist-0082@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89dc568e8c0be60e05e5fcd0b528c79077d7b84b Mon Sep 17 00:00:00 2001
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date: Thu, 17 Sep 2026 09:52:23 +0800
Subject: [PATCH] perf/x86/intel: Fix GRT PEBS load/store direction for latency
 events, to fix sample classification

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

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b98029b44052..fff98f457576 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -455,6 +455,7 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 static u64 __grt_latency_data(struct perf_event *event, u64 status,
 			       u8 dse, bool tlb, bool lock, bool blk)
 {
+	union perf_mem_data_src src;
 	u64 val;
 
 	WARN_ON_ONCE(is_hybrid() &&
@@ -470,7 +471,16 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
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
@@ -1291,8 +1301,8 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 

