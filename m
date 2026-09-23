Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CC42E43E;
	Wed, 23 Sep 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157170; cv=none; b=E217+LZ5otGVWTN51Pp5aHXd3mUcbsrPtWGImqWz6hz12XPSjHUZ0+uAok4IPycyLqk8BUDkvUSzy2QEABUuMi3tVb9o/pDjfBY+Nd8c+dnxxDcZP0s372D9Fq9KavXbl8IYPsEbNVBXh5/1F+giqa6LItD651ZdiBShWDucExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157170; c=relaxed/simple;
	bh=HAZVNh5M+R6Ke77RXmde94DtjNoFnvXJMuPHBbg6tbk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wr0ke1beL+r099efGizLlKTnTirRhU0G7AWgzWdQqpaKuDIihNyy4OHp6AaCvMQhG+erZrLqUGe63HJ7SPYs96xvTxgUoTIR+glUz56bUBPyuILpYN+f8+rm/SUBDP4/jfZtkEbTWWX5OtyQ5p7I8n2Z6Lew7Yrjjzr9papS4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xh43kWts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ninfAzld; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xh43kWts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ninfAzld"
Date: Wed, 23 Sep 2026 09:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790157166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAjqjo8KNkWTxoYs/KlFcIUqlj679wt/2N2On6Bd/qQ=;
	b=xh43kWtsuU9WRUCQv2YtikWckwUsFat9iUmvpxsrtwyunkwAPHTvBoO9/pqXorSX9WaTcq
	9tp5NSQupMuJrznj9RwS6xHM3aeiJt/ScyZHVjIwgzz46JoMcp0oBdL7iC28cl5n0ljTNC
	dVwGcNhgry1xqGE3JvCm3SzdZsrZALmKw31oVrM8Apb+nCl+60zdgbw9CbEfeAVi0Ss/jh
	Ybc1+l1cElbMXYBdFl6AgVIFamnsH63oaAg4VQYgVDvwdjWhFH1ZNogbRW6+xnVuwY8pLb
	xLeb/YVuXpBvbWvUzA7KNmIXBzt6BS9JK+av4tDre10j585CnCQ6V0rniwohyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790157166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAjqjo8KNkWTxoYs/KlFcIUqlj679wt/2N2On6Bd/qQ=;
	b=ninfAzldsMEY2IfceWh2ozn00pQfWJgVkPZf8wSnZb+WubB0KmPhNumsS1gVF8JEiFw6/7
	ACFqL8M9T+zzQABw==
From: "tip-bot2 for Puranjay Mohan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Run sched_task() for PMUs with only
 CPU-wide events
Cc: Puranjay Mohan <puranjay@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yifan Wu <wuyifan50@huawei.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260810133540.1947118-3-puranjay@kernel.org>
References: <20260810133540.1947118-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179015716509.2819794.7146314872199171606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3d8d74100954a3b17e5c5e37adfe14e16b1db103
Gitweb:        https://git.kernel.org/tip/3d8d74100954a3b17e5c5e37adfe14e16b1=
db103
Author:        Puranjay Mohan <puranjay@kernel.org>
AuthorDate:    Mon, 10 Aug 2026 06:35:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Sep 2026 11:48:35 +02:00

perf/core: Run sched_task() for PMUs with only CPU-wide events

perf_pmu_sched_task() returns early when cpuctx->task_ctx is set and
leaves the work to perf_ctx_sched_task_cb(), which only walks
ctx->pmu_ctx_list. A PMU whose events are all CPU-wide is not on that
list, so nothing calls its sched_task(). With

  perf record -b -e cycles -a -- ls

armv8pmu_sched_task() is skipped on every switch to a task that has a
perf context but no event on that PMU, and BRBE records leak across the
task boundary. intel_pmu_lbr_add() calls perf_sched_cb_inc()
unconditionally too, so LBR records leak the same way on x86.

Drop the early return and skip only the CPCs that
perf_ctx_sched_task_cb() handles. That one needs a gate of its own to
make the split exact: it tests cpc->sched_cb_usage, which
perf_sched_cb_inc() sets per CPU for every branch stack user, so a task
with an event for that PMU pinned to another CPU would be handled twice.
On x86 the second __intel_pmu_lbr_restore() finds lbr_stack_state =3D=3D
LBR_NONE and calls intel_pmu_lbr_reset(), throwing away the callstack
the first one restored.

cpc->task_epc is set only while a task context is scheduled in, and
there is one epc per PMU on ctx->pmu_ctx_list, so the two gates are
inverses.

For the CPCs perf_pmu_sched_task() picks up, the callback now runs
outside the perf_ctx_disable() and perf_ctx_enable() pair in
perf_event_context_sched_in(). __perf_pmu_sched_task() disables the PMU
around the call itself.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yifan Wu <wuyifan50@huawei.com>
Link: https://patch.msgid.link/20260810133540.1947118-3-puranjay@kernel.org
Cc: stable@vger.kernel.org
---
 kernel/events/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ce72f3..634d2cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3764,6 +3764,9 @@ static void perf_ctx_sched_task_cb(struct perf_event_co=
ntext *ctx,
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
 		cpc =3D this_cpc(pmu_ctx->pmu);
=20
+		if (cpc->task_epc !=3D pmu_ctx)
+			continue;
+
 		if (cpc->sched_cb_usage && pmu_ctx->pmu->sched_task)
 			pmu_ctx->pmu->sched_task(pmu_ctx, task, sched_in);
 	}
@@ -3924,15 +3927,17 @@ static void perf_pmu_sched_task(struct task_struct *p=
rev,
 				struct task_struct *next,
 				bool sched_in)
 {
-	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
 	struct perf_cpu_pmu_context *cpc, *cpc2;
=20
-	/* cpuctx->task_ctx will be handled in perf_event_context_sched_in/out */
-	if (prev =3D=3D next || cpuctx->task_ctx)
+	if (prev =3D=3D next)
 		return;
=20
-	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_=
entry)
+	list_for_each_entry_safe(cpc, cpc2, this_cpu_ptr(&sched_cb_list), sched_cb_=
entry) {
+		if (cpc->task_epc)
+			continue;
+
 		__perf_pmu_sched_task(cpc, sched_in ? next : prev, sched_in);
+	}
 }
=20
 static void perf_event_switch(struct task_struct *task,
