Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213484;
	b=tisy8eASiJahQkLpEh8v0l20zUdx7VmKVQzG1ynsAk4l85+mjFR9DgfOK96wF6W2xIoY
	 Jw1LpAsohhq6je4ariRIM0LEJPuX3SUYNyHkYALx94tF6dV4poL1kRuL2xWPdfn/UFVqw
	 LgoTIKC78eqxPobhBO4QZZHSQuBb8IXNMLnViiGIGE4kYzxnRrUnRnTJ6cFofHwxp0qLn
	 1b+z0THY7j1yug6TGbnwZgTi4sTCX8PsTNaxn/aHT1Pu44nThcJjZgNK754/1B9/7Cs1p
	 FJfEYiESWpfLBP1tKvKusCJAt4wwU1behw9uzbf0YG/dKdLEELk3f9t0xoJk2tLzLgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213484;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Ubm/LJnygb5OiqcXb1ebUFG4TDpYV4plqGtckBfKlxU=;
	b=mxjWnvZARUt5OwsbOZCCVkLdjhInWk4MG64RyYcVpNLDmevhDifUpc7O/HWD+t5KmToB
	 5kAU2svxTN9hmVf9pfx6iIDAZYMI/RVZrh/zaAJxqstwkuKlX5gxd1Tt/i/txrHRvNGSl
	 sh/k4+XeCDcd3JdBASYC8e+IM1vYd0XtVC4aGquMscUs+kWookQeUv9D7LUetDagmtHDN
	 UWwnexiuBMNXZlvGskUfcUDDOjRqzPFEPrTKHux9GUOy4TYowVr2J23nBgvIjOFSi6Llc
	 Zq/HSbeguwt3K2HBrfop8If4CSUO3zDUD/tzWXyZP8Ew07iK3u55kz+VadTmCxhQsvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xEQb+X2q;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ybaHGCef;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88973606A321;
	Mon,  9 Nov 2026 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88973606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xEQb+X2q;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ybaHGCef
Date: Mon, 09 Nov 2026 08:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794213481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ubm/LJnygb5OiqcXb1ebUFG4TDpYV4plqGtckBfKlxU=;
	b=xEQb+X2q+vQPmc2yBB0Qio8GaW2OSdEtbFJssr1cRX4aNAfuS9NhmA19JhBo9R+nVORG91
	aXfHYjMgQiD2cZ4LWxBDeOMBY3LN+JhgFO6zw4oWfNzt/ZuOw+940mc+Xmq/OuJ+wFq2OO
	EH1f9PSzWY3tGu9bma7lTeInkyJFR2zs4P+6kNSVlB6hGOFwJuIXTLdHdpevW4osz8+dha
	htxeuRDivewO1EBd7XbHLo4LI5KnkamnM6KDdsx3AY7lwCv0rwnndDWEvmhU3WWx2XNqs5
	8r6eM93dXqJAeTJ0bdzBom68mQbzOSDiR1NdV5B+fzm0ZIbfUnoQwjKPd+X4bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794213481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ubm/LJnygb5OiqcXb1ebUFG4TDpYV4plqGtckBfKlxU=;
	b=ybaHGCefpsNp/oN/o+KP8/5seloHme9E11n/ppQbvr2BCmUU50GND78Oe1PQds/Tsa90B9
	Th+h2cac9IefvMBA==
From: "tip-bot2 for Phat Dinh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Do not resurrect cpuctx->cgrp after
 last cgroup event exit
Cc: Phat Dinh <phatdt1116@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106101642.494674-1-phatdt1116@gmail.com>
References: <20261106101642.494674-1-phatdt1116@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421347908.2093942.12212069881429556909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     59f1398140869432c7171b9a2a279ca315467c4e
Gitweb:        https://git.kernel.org/tip/59f1398140869432c7171b9a2a279ca3154=
67c4e
Author:        Phat Dinh <phatdt1116@gmail.com>
AuthorDate:    Fri, 06 Nov 2026 17:16:42 +07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Nov 2026 11:45:15 +01:00

perf/core: Do not resurrect cpuctx->cgrp after last cgroup event exit

perf_cgroup_switch() relies on:

    /*
     * cpuctx->cgrp is set when the first cgroup event enabled,
     * and is cleared when the last cgroup event disabled.
     */

It computes the next task's cgroup, schedules out the CPU context and
then assigns cpuctx->cgrp unconditionally:

    ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
    /*
     * must not be done before ctxswout due
     * to update_cgrp_time_from_cpuctx() in
     * ctx_sched_out()
     */
    cpuctx->cgrp =3D cgrp;

However, ctx_sched_out() can disable events itself. If a cgroup event
has a pending disable from perf_event_disable_inatomic() (e.g. its
PERF_EVENT_IOC_REFRESH limit ran out) that the irq_work has not
handled yet, event_sched_out() consumes it inline:

    if (event->pending_disable) {
        event->pending_disable =3D 0;
        perf_cgroup_event_disable(event, ctx);
        state =3D PERF_EVENT_STATE_OFF;
    }

If that was the last cgroup event, perf_cgroup_event_disable() clears
cpuctx->cgrp:

    if (--ctx->nr_cgroups)
        return;

    cpuctx->cgrp =3D NULL;

and perf_cgroup_switch() then sets it again. cpuctx->cgrp is left
non-NULL with ctx.nr_cgroups =3D=3D 0, so the NULL check in
perf_cgroup_switch() no longer catches it and the next switch trips:

    WARN_ON_ONCE(cpuctx->ctx.nr_cgroups =3D=3D 0);

cpuctx->cgrp does not hold a reference on the cgroup. Once that cgroup
is removed, the next ctx_sched_in() dereferences the stale pointer:

  BUG: KASAN: slab-use-after-free in ctx_sched_in+0xb1f/0xfa0
  Read of size 8 at addr ffff8881008972d0 by task swapper/3/0

  Tainted: [W]=3DWARN
  Call Trace:
   <IRQ>
   ctx_sched_in+0xb1f/0xfa0
   perf_event_sched_in+0x1a/0x70
   ctx_resched+0x32b/0xac0
   __perf_install_in_context+0x475/0xab0
   remote_function+0x105/0x200
   __flush_smp_call_function_queue+0x179/0x8d0
   __sysvec_call_function_single+0x1b/0x1c0
   sysvec_call_function_single+0x66/0x80
   </IRQ>
   <TASK>
   asm_sysvec_call_function_single+0x1a/0x20

Only assign cpuctx->cgrp when cgroup events remain after the context
has been scheduled out, so that it stays NULL as the invariant
requires.

Fixes: e19cd0b6fa59 ("perf/core: Always set cpuctx cgrp when enable cgroup ev=
ent")
Signed-off-by: Phat Dinh <phatdt1116@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261106101642.494674-1-phatdt1116@gmail.com
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1404dab..e870f12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1072,8 +1072,13 @@ static void perf_cgroup_switch(struct task_struct *tas=
k)
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
 	 * ctx_sched_out()
+	 *
+	 * ctx_sched_out() can consume a pending disable and drop the last cgroup
+	 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active cgroup
+	 * event, so do not resurrect it
 	 */
-	cpuctx->cgrp =3D cgrp;
+	if (cpuctx->ctx.nr_cgroups)
+		cpuctx->cgrp =3D cgrp;
 	/*
 	 * set cgrp before ctxsw in to allow
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
