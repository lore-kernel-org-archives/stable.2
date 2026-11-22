Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387766;
	b=NJdYk8AVEf+jBpO8YECZvcnqu82/w1h1MqUY5g246caiGC421gp/uNtX8Me0BSAeUkzS
	 +2IHzQEFHcTsW7SGyNxU8cBCHgEx8uAI4kPF4D15xzie+pJeMKq8HfzmQYtH5UPfNY0sB
	 /wle7oTOjU2Pdln6/K1t9WLu4uUrKZbWcdpXRYIonC3W/oI6c/i022Q/9cbGBZky5NCKY
	 4NbUuDJQJ3GIM2JPRo089thQCRp7tEMBjr0pTeunZpE9w50ZDQPmE7YB1s2ywHiT4QDMu
	 srf6F8dK8ieGQW0kNbQKrY+ElctzXh0YSPmA2It7GrV63/kzvMD17FNhj9kn5ovfaUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387766;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=BJnA/jJMIwrgGXMJrI1daqmrBMQlWcFEETcA+fI4vbo=;
	b=15qR4GXhsK5TQtnyUp7FW62Bh86XEZhCsxOaOpZ/0M6upLhUGpt2NK2WbEwtYt9B3MjL
	 DE7RCTnF2bc/FBG5fzJk9hPIsaXbY/Ycp5X3+r5Y+8FJyQVaRm3Z75r1i99T731tk5bvL
	 s6DzMMhPeZNyl/rnj3jj0je0Xj9VP4bNSqR09xYU3TT2hDybVu6g1qnJedLBXGSmmBDZX
	 wGJlc2mHIpaRvfiIeAffbXp8Fc0GbHznxQmSVpOj1lUtQBsWuopejlSdxLmib65XT3JAf
	 GcBADnYvHvkBMteyfUj3twerShsfAK3+nmLYabPqCZGQOyandfTd9eVjpaYJ8jb3yAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OLctnsug;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eLuWD2sL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4822606A69A;
	Sun, 22 Nov 2026 22:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4822606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OLctnsug;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eLuWD2sL
Date: Sun, 22 Nov 2026 22:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJnA/jJMIwrgGXMJrI1daqmrBMQlWcFEETcA+fI4vbo=;
	b=OLctnsugB60B+/sr/lTtaoR7Li2Hi/a7RzzapkQkd2xSS4XR7OY9C64uMaGXgaWHvxyq/M
	zRdOND8ZNduVJff4eFlvmppJI2ZAVQu0gy50hN148wRvVnnArF/rSdmL7inRlfWD5AY53k
	bJlLDQi24nueoUFvxDjiC5ZUPRCyihOKwuoah41ADukeBVmDM7fY6ShKCH3d5j9Cy6rK2L
	2fB+d4EYinQIj190Gmb9jseNKh3zhj5Y7tOEWGzJX+z0EafrGSlDl/Z3qMYgdm8qDPWeZT
	sCSM86894S1M2oXpNoTxQKvQPBnuUrhRcEAAy7YJ6Fbd2s30GMV+VV3Rgo/ABg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJnA/jJMIwrgGXMJrI1daqmrBMQlWcFEETcA+fI4vbo=;
	b=eLuWD2sLTo6ndZeJwiEb5Pxw3LFRXC32CuoommwO25PLnJr1tBU+RdSit3fWos3et7r1pZ
	YEp0t4ZvVOL1e8Dw==
From: "tip-bot2 for Ibrahim Elshahed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Don't take the idle fast path while
 the core is forced idle
Cc: Roman Kagan <rkagan@amazon.de>, Ibrahim Elshahed <lshahed@amazon.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261120105822.7770-3-lshahed@amazon.de>
References: <20261120105822.7770-3-lshahed@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179538776239.92412.16308910403211370026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     cf2126c9b989d11d42e95e5f5c7fdcfe43914eae
Gitweb:        https://git.kernel.org/tip/cf2126c9b989d11d42e95e5f5c7fdcfe439=
14eae
Author:        Ibrahim Elshahed <lshahed@amazon.de>
AuthorDate:    Fri, 20 Nov 2026 10:58:21=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:16:44 +01:00

sched/core: Don't take the idle fast path while the core is forced idle

Since v6.12, with commit 3dcac251b066 ("sched/core: Introduce SM_IDLE
and an idle re-entry fast-path in __schedule()"), an idle CPU with an
empty runqueue skips pick_next_task() when it is rescheduled. Under
core scheduling that pick also ends or re-examines the core's forced
idle.

A core-wide selection chooses a task for an idle sibling and reschedules
it. If the chosen task is migrated away before the sibling schedules
and it was the sibling's only task, the sibling goes back to idle
through the fast path. When that selection also forced the other
sibling idle, because its runnable tasks did not match the chosen
task's cookie, the core stays forced idle with nothing running on it,
and two things go wrong:

- Without the previous patch, the idle sibling's rq->core_pick keeps
  pointing at the migrated task, and with schedstats enabled the forced
  idle accounting keeps writing through it, even after the task and its
  cgroup are freed:

  BUG: unable to handle page fault for address: ffff8d6b205f7018
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  RIP: 0010:__cgroup_account_cputime_field+0x3c/0x70
  Call Trace:
   __sched_core_account_forceidle+0xd8/0x140
   __schedule+0x1390/0x18d0
   schedule_idle+0x1a/0x30
   cpu_startup_entry+0x29/0x30
   start_secondary+0x11e/0x140

- The forced-idle sibling keeps waiting with runnable tasks until some
  unrelated event reschedules the core. Likewise, when the forced-idle
  CPU itself loses its last task, the reschedule that
  sched_core_dequeue() sends to end the forced idle also ends in the
  fast path.

Take the SM_IDLE fast path only when the core is not forced idle. A
pending rq->core_pick needs no check of its own: the previous patch
clears it when the picked task is dequeued, so a CPU with an empty
runqueue has none.

Fixes: 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle re-entry fast=
-path in __schedule()")
Co-developed-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Ibrahim Elshahed <lshahed@amazon.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261120105822.7770-3-lshahed@amazon.de
---
 kernel/sched/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4b1d36c..b2f6b99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -347,6 +347,15 @@ void sched_core_dequeue(struct rq *rq, struct task_struc=
t *p, int flags)
 		resched_curr(rq);
 }
=20
+/*
+ * An idle CPU with an empty runqueue must still call pick_next_task() while
+ * the core is forced idle. Only that pick ends or re-examines the forced id=
le.
+ */
+static inline bool sched_core_idle_needs_pick(struct rq *rq)
+{
+	return sched_core_enabled(rq) && rq->core->core_forceidle_count;
+}
+
 static int sched_task_is_throttled(struct task_struct *p, int cpu)
 {
 	if (p->sched_class->task_is_throttled)
@@ -550,6 +559,7 @@ void sched_core_put(void)
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) =
{ }
 static inline void
 sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
+static inline bool sched_core_idle_needs_pick(struct rq *rq) { return false;=
 }
=20
 #endif /* !CONFIG_SCHED_CORE */
=20
@@ -7290,8 +7300,13 @@ static void __sched notrace __schedule(int sched_mode)
 	 */
 	prev_state =3D READ_ONCE(prev->__state);
 	if (sched_mode =3D=3D SM_IDLE) {
-		/* SCX must consult the BPF scheduler to tell if rq is empty */
-		if (!rq->nr_running && !scx_enabled()) {
+		/*
+		 * SCX must consult the BPF scheduler to tell if rq is empty,
+		 * and core scheduling may need pick_next_task() to end forced
+		 * idle.
+		 */
+		if (!rq->nr_running && !scx_enabled() &&
+		    !sched_core_idle_needs_pick(rq)) {
 			next =3D prev;
 			rq->next_class =3D &idle_sched_class;
 			goto picked;
