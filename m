Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427069;
	b=0kAWZj4/xhW2xGAKiRJmqDJCnHC7WqY5ZQkOd2wENrBAoRdT/NImoY9D3uNtbbqT+59j
	 2qOK+5++90n5aPU3pVwUGMpbzQ9q2W6yaOQyxS99pPxkCWwWSI6ol18H5HvZF0bsKcXaW
	 hUxbc65HCXZX4p6Pkmcj28GU3yivbyt3WcCH8XDQy+MMP+tBgh/95Io8KCwMBLx8KhkWL
	 0nP1uoZAWRHRK6ffiavpnF2tsq3NolgyNXCT60xAU38n6Yp+stKaXSK1nFldshWW9QjkX
	 3OsBZOsQkUBnSBTjgQsOOiryEnVn+MAkTMjgbRwRio7pUoc1nb1kGUENQMnM43OMpEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427069;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=XXZTF0uTkX+SttFMkG8ioYO8nVRHeycJF30zfifWrrs=;
	b=bAJdHv26FcB0mobt468wOq6/G/QVqkFHf4+1Zs+4F0RkTA83D6Yj38oqj1mK3gdGoSn1
	 yrSkbjIcD7dwASOEwAI6NvUlKxmgsLioUPcZvNwf7Wk1xuRsaGLV8SuhlfPx+g76smn3l
	 zlQhLXbijf68fl3KFkvR2G0cGP37SpILC1FU57MF3S2aVqHBdnfjBy6r+64bCc7i1xFbs
	 Ru0Yn8GUilIwjtv4lBBs2etLFRga2bT0/eUzqjdNlJGjOUVLb8CheRq4m6av8z/nfOPHJ
	 w2TpwlYi+wpswiCHcwFYqa1F/PxJvDkiddZb6pIeUNIBiiv/fHTLwGFCniyjqtIeUZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xlmx0CEi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iuXWhKmi;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F290606A32A;
	Mon, 23 Nov 2026 09:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F290606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xlmx0CEi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iuXWhKmi
Date: Mon, 23 Nov 2026 09:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZTF0uTkX+SttFMkG8ioYO8nVRHeycJF30zfifWrrs=;
	b=xlmx0CEiFRA46pr/T/bZTsTaz+aUTx8wmCDcDS70ygbyfbOW1GygRULPpnJ8nkUxF1NJVe
	nMM7ot9ElMo51e/8/BT5uJy0OdkDqfCPM1dIzABy6MBb+P3JSZEJPT9FkjZPw/Nz/uPanL
	9ZfrJESi03/RtlTJuocO3FTny6UBRxSJq5N6+DnLXAdti8OMIKEKCOUP091WpieR11uhZY
	Y8R0pNvVeG4qaSVomAIkKdqBOIGoyL0JVFhhlY/aF8DjYxjUvM+7lnNpe4ClFsVVpweCoE
	WECVT/S+mxB33cvY9pZWcEE28hlJ2Wn4xkXmL7j8AosufQGuWK/qOUwJ8INT5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZTF0uTkX+SttFMkG8ioYO8nVRHeycJF30zfifWrrs=;
	b=iuXWhKmiJRhV7QLqxWm+2UUilbpIs9gndkcMF8k7EJPC3FFH46209JH6caOixkuTwluAGZ
	EPLwbdSj+63PkmCg==
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
Message-ID: <179542706459.92412.897398883218691952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     029c90c449bfe0e200cdeb24c5b1a775764c0006
Gitweb:        https://git.kernel.org/tip/029c90c449bfe0e200cdeb24c5b1a775764=
c0006
Author:        Ibrahim Elshahed <lshahed@amazon.de>
AuthorDate:    Fri, 20 Nov 2026 10:58:21=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:38:26 +01:00

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
