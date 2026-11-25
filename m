Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622137;
	b=cSM/rwvqxf6d95s5vOf4yTlbuAVrN5N0TwwgX3bKnqAKIXQW2NEU6VCocwqprPWN5ybf
	 FyOKF6KDD3pMRG2IYFou3HzVePvrwNsIutpSto6MbJRBsgyd0Q3pJLorFfW6Jtq4b1PE2
	 b42tq7DqicHI2mXbDlj5I+R4cDwdKZIltw+t+kAqe0Ftkkc594S56pMKXRe1MIKgD403k
	 aE6vadctDfVzNelFpd+fgP2QMOD9BMpjZxWn1xVYwdNI4eL+gjDplLDl0kKl6vhgWof5Z
	 rEFg36u1Pm3eVBTDStZVQzK1ggNtdkDaVcLVw5FZRUg0xt1X8hDdF9ARuheerSJH91w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UZPCnOI8zaWCFPx81IX44CsWUisKK0Kp6jlRjLOcMT4=;
	b=uO0huGDQNd5iNB/HEFQnK26LLC89qbSsWmVb2/qkywT/qePVZuPEeCH2/WACPRXMVs9H
	 r6OrJY/Lp3mLQtJC5U/pz99o3m+Gc2RFAFViXFWF2atj9lL6VNRmTneSum/u0riaMPrNt
	 HIecrU13gPwzffWcec7Q3hSM5YCTAS2ATHWAMFLdcVU5WO1+Xty4PgYOee4en3+NQWOX6
	 uTE1jFFRSK6u6m2USsrWIavDuuq53kwjgCBp2hSc4OqyQc1vOn+WRzQOfHuW/Icb7T3iy
	 HSqDx+yofuHGSVL7CkfoDDiF2L+cSLuy3ehO2VqSPHRSOJERA2wQA/g/S6DrPwTI/+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvoXH4Ty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B85606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvoXH4Ty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD2F1F000C6;
	Wed, 25 Nov 2026 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622136;
	bh=UZPCnOI8zaWCFPx81IX44CsWUisKK0Kp6jlRjLOcMT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvoXH4Ty9/GHslOBFDFtXo7GlMHfpC0FxQ1kvE9GwXCVJcl7bhHNMwzolkrAGsTnx
	 sQM9VEQd9oB3KnpRr5xWKp/JfpDX5a+5fTW4xsDSLJlp6qhYdgmJMLENRhcJLo7jUX
	 1mdV56jjdXRrZKUmlCnnL6W6JA2nkcBfQdHfVv2LVXD7/0s+lJw8Jkkre3F2A+kQnE
	 Zx9bMT4LPQ+HKun9hz6Tw+z2LJqhvGEkv3ZHK/7qiCR8fFInpr5ETZ59tr6xHzb5Xi
	 YZ19OxiUEkSHbz4mB2KmIV1iJAFWZv8RyYs4N/oRrYqqRPxtYm85imK/rb+rkWoygJ
	 9oHFr5EyJan9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phat Dinh <phatdt1116@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] perf/core: Do not resurrect cpuctx->cgrp after last cgroup event exit
Date: Wed, 25 Nov 2026 10:55:34 -0500
Message-ID: <20261125155517.621280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112533-alkaline-hate-c122@gregkh>
References: <2026112533-alkaline-hate-c122@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phat Dinh <phatdt1116@gmail.com>

[ Upstream commit 59f1398140869432c7171b9a2a279ca315467c4e ]

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
    cpuctx->cgrp = cgrp;

However, ctx_sched_out() can disable events itself. If a cgroup event
has a pending disable from perf_event_disable_inatomic() (e.g. its
PERF_EVENT_IOC_REFRESH limit ran out) that the irq_work has not
handled yet, event_sched_out() consumes it inline:

    if (event->pending_disable) {
        event->pending_disable = 0;
        perf_cgroup_event_disable(event, ctx);
        state = PERF_EVENT_STATE_OFF;
    }

If that was the last cgroup event, perf_cgroup_event_disable() clears
cpuctx->cgrp:

    if (--ctx->nr_cgroups)
        return;

    cpuctx->cgrp = NULL;

and perf_cgroup_switch() then sets it again. cpuctx->cgrp is left
non-NULL with ctx.nr_cgroups == 0, so the NULL check in
perf_cgroup_switch() no longer catches it and the next switch trips:

    WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

cpuctx->cgrp does not hold a reference on the cgroup. Once that cgroup
is removed, the next ctx_sched_in() dereferences the stale pointer:

  BUG: KASAN: slab-use-after-free in ctx_sched_in+0xb1f/0xfa0
  Read of size 8 at addr ffff8881008972d0 by task swapper/3/0

  Tainted: [W]=WARN
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

Fixes: e19cd0b6fa59 ("perf/core: Always set cpuctx cgrp when enable cgroup event")
Signed-off-by: Phat Dinh <phatdt1116@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261106101642.494674-1-phatdt1116@gmail.com
[ sashal: Adjusted context for the older scheduler call cpu_ctx_sched_out(cpuctx, EVENT_ALL) and indented the guarded cpuctx->cgrp assignment one extra level to match this tree's loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ca5009e11b022..135cddab253ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -857,8 +857,13 @@ static void perf_cgroup_switch(struct task_struct *task)
 		 * must not be done before ctxswout due
 		 * to update_cgrp_time_from_cpuctx() in
 		 * ctx_sched_out()
+		 *
+		 * ctx_sched_out() can consume a pending disable and drop the last cgroup
+		 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active cgroup
+		 * event, so do not resurrect it
 		 */
-		cpuctx->cgrp = cgrp;
+		if (cpuctx->ctx.nr_cgroups)
+			cpuctx->cgrp = cgrp;
 		/*
 		 * set cgrp before ctxsw in to allow
 		 * perf_cgroup_set_timestamp() in ctx_sched_in()
-- 
2.53.0

