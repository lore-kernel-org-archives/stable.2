Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669466;
	b=rxY9PjVXyjWa7ysNBa3IcxBWerxyz3DDEG+tv7Sdxby7s25YWylNERdmvZzOBXex78Ue
	 mHn2U9s2qA5iFq1NtBnwDTJ5FRZxg3IpW3Sf0vXiObRxcYxAsZhN6nGlcEOWZNiWk9gug
	 XLfYn04q6l3MaNw5wzqAFgh0Bnz6dZQXPAirISMRIQdZGWcupKqCuyTl0GumJkfdHyYQV
	 zfvcqXe03Rb6NE2EmSZDoumDDgbtEFncydrKp0mC7Fbs2CokXHfrccUAwTZHYRildjx2p
	 jEvqTRmYWBRoQbM/onepYNskOGBOwsfBNvMxPzBAAdXlXSMBbcNnTVK9o3Z8fe9a4BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=twNMtOuFLtxszqRUIn0Dbc8PQFgf2NID9gokWl+GdmU=;
	b=LaGHKpqYYZ7GvKEiCXtvd7BU4Z68kwOj0IWPT58EA19IrOKJk1Rk57kmcMRVQZEu1i6C
	 YuHWOFSM9Q0K2qhkHH1SZ3ewWMJHXYFOwzD3ozlBr7ZhXswUytaoDHNLxN9h1X85ln2vd
	 31BS9jOxsCmERuoQp4zfiOSFyWKN6htUPloblo5EhUaD7/yLM4ZquC8812Uei3+bkE/Xx
	 UM/FTEuY3KD8scfRMR9qQ9RkkNfIi8c9ITI5AmvGYju/RpJHeDOvX1kK1bvdXQd/cEp2E
	 /jwEC/Eqz5we1c5tLQ8gDcns0xumj8UC2XPh7trC/U9E6Y952PS0X9B9XmHo4GxV5ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv9++XhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B1606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hv9++XhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6C81F000C2;
	Thu, 22 Oct 2026 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669465;
	bh=twNMtOuFLtxszqRUIn0Dbc8PQFgf2NID9gokWl+GdmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hv9++XhRX2MG70Af/x585xkn78LaZpMiT/iRlKMXtoLvevF4n4iUIjCwfOvwGtkGg
	 geb57JPkdtbQaLuLHdEk4hWsQuEy7SaGfjHreH+z2r855Uf388hVw9OO6fNuC+sZ0d
	 pHH2jzyanz4FjmB5WaXIuvAonSSjeu+OR86iLPZTUm5vpy274RFi5UjenffLrEhGh8
	 Qy/t0nJy32vn+syURWJFT8IRVIP4fYw5fX9vaqlPtPGb3bu7bEGs4d2veVoQT7V6DY
	 SPAcnTtePh+dk6/qpLUayo2kduRfxDuuDVh/c1k+MBHR8px7aYD2RFTpidB94Ba2ac
	 GCTVi5fvVizNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Xiangyu Bu <xbu@meta.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
Date: Thu, 22 Oct 2026 07:44:23 -0400
Message-ID: <20261022113413.922711-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102100-retry-bullfight-49bf@gregkh>
References: <2026102100-retry-bullfight-49bf@gregkh>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 7a9df76679633cf26e0fea882a684012c6ec245a ]

With SCX_OPS_ENQ_LAST, the last runnable task on a CPU is passed to
ops.enqueue() instead of being kept running. Exiting tasks without
SCX_OPS_ENQ_EXITING, migration disabled tasks without
SCX_OPS_ENQ_MIGRATION_DISABLED and tasks on an offline rq skip ops.enqueue()
and go straight to the local DSQ. This happens in put_prev_task_scx() after
the pick has settled on idle, so nothing reschedules the CPU, which idles
with the task queued until an unrelated wakeup lands on it or the watchdog
fires.

scx_mitosis, which sets SCX_OPS_ENQ_LAST without SCX_OPS_ENQ_EXITING, hit
this during mass cgroup teardown: exiting tasks stuck in exit_mmap() for
over 40 seconds.

A task put on the local DSQ runs, as anywhere else. If the SCX_ENQ_LAST
enqueue left the task on this CPU's local DSQ, set need_resched on the task
being switched in, as proxy_resched_idle() does. resched_curr() would flag
the task being put instead, and __schedule() clears that right after the
pick.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Xiangyu Bu <xbu@meta.com>
Link: https://github.com/sched-ext/scx/pull/3870
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
[ sashal: Adjusted context to use do_enqueue_task() without the upstream CPU-capability condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c      | 13 +++++++++++--
 kernel/sched/ext/internal.h |  5 +++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8497c967763d..a6fd83dd62bc2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3169,8 +3169,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 *
 		 * Under core scheduling, a pick dispatches only when nothing is
 		 * locally runnable and can legitimately go idle with @p still
@@ -3180,6 +3179,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+
+			/*
+			 * A task put on the local DSQ runs, as anywhere else.
+			 * Here the insert can't reschedule on its own: the pick
+			 * has settled on @next and @p is still curr, so
+			 * resched_curr() would flag @p and __schedule() clears
+			 * that right after the pick. Flag @next instead.
+			 */
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				set_tsk_need_resched(next);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
 		}
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 3cd223c6d7639..03e9223507ef9 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1291,8 +1291,9 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * The BPF scheduler is responsible for triggering a follow-up
-	 * scheduling event. Otherwise, Execution may stall.
+	 * If the task is queued on the local DSQ of the CPU it was running on,
+	 * it continues to run. Otherwise, the CPU goes idle. A scheduler that
+	 * wants a full dispatch cycle on the CPU should kick it.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
-- 
2.53.0

