Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105301;
	b=BhiyBN7Fq27Ia/rDZwihFbqDaey8BsmZb5QRDIdeA4hpSvnlmmP+IFv8/0ZJcEjBUHyq
	 RwZHH+u+ckE4FhIt1Bm4MwpiKc5DOy3WNpiZt2f7Ri2DMB0FFaU6UQvlwVFFEtkXT3JBG
	 he2+J+CGkarh6nU2WGgWQs4JMd602ON/RHobyQsy/c7zV/6HCzykAijtKE1Il7rUoBTIq
	 McYCyREtQwWs7ZtGSePgoZJaGFsZH/20qnwHajDuxf/NVI4OmHSo1buO//i6EsXxv+Gxo
	 fEWMvnZCM/6SQnQsojLoPT2kOotGqT6Bl7+6iUMUo2jd+5Sx1t8WENWbfa3i/TXh/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105301;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sYEvR0y/S587RGU4gKT0zwa1IWS1hIurv3wif+IluiY=;
	b=3dBjJnCbAdzc7hMpgo7199IQ+NDTVvhK4hTXPmvDajZxyL9L++fA1brE5U8Zj0HAYDGk
	 aRxsRDFDECgTtmX6QbuO2y1Cx0IaE7p4iglfgVwwFOXRIt/lUJyJJ4rtR+APCU3qpZSQL
	 nIGpgMVVNdVk8zfXkbTw7vlqBaIi6j8pZYirQ3kCUKbYpPfJxkhQ5rnfu8yB2Q21UWhWD
	 I1OvGFHEdILyInYQRXEZqWQcEeA4Ui9SmWf79sMf/CloKAC/NuANmte27kx5lWxtaVFHX
	 c1/n4jiuWXSpUY3HlMKCg+UN76O/hk+G0pjnSKgvI3Vd6QhF37G/B0r3o/DOcKKGHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="EjX/aDxP";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B15606A32A;
	Thu, 19 Nov 2026 16:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B15606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EjX/aDxP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105300;
	bh=sYEvR0y/S587RGU4gKT0zwa1IWS1hIurv3wif+IluiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjX/aDxPKHDm/BxDpDNs6Sruxc9sfLfTtMRAy3ZbORRs+OtDILN3HjAH+hyynRpUz
	 asXFabGBowtO9UibuguLwBipE8i4Uc7M6XalFfKSjU7FL+NpfOqk5DCZyOoX/COWkz
	 4zV2jIJJGFBqENlYLHWwE7nKNkvbTc9eDSAwy1Ss99yquqdMJCWtxNHMVTBMy/n2IW
	 6WRxMOiW8jJFLw7KRKMekUzPyua3UFzPFv+E0w/knR3v3mKQMTN1us9xT6oLIEeaNJ
	 IbHs22OMHL9lOuMWewzoR2ynJY+TBztJCXy2PwuuInAbRTyUqEb3SJfjriczgiIX8c
	 iV/Qq4bNq4mDQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHm2PSdzT9T;
	Thu, 19 Nov 2026 11:21:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 03/17] sched: Let a task boosted by a deadline waiter change its policy
Date: Thu, 19 Nov 2026 11:21:24 -0500
Message-Id: <32e83abf79c6cebb23193478bdfea27e3525b025.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

A SCHED_OTHER or SCHED_FIFO task that holds an rt_mutex can be boosted
into the deadline class by a deadline waiter. Then a sched_setattr() or
sched_setscheduler() call on it fails with EBUSY, unless it asks for
SCHED_DEADLINE. sysrq-n would not reset it either.

The admission test runs "if setscheduling to SCHED_DEADLINE (or
changing the parameters of a SCHED_DEADLINE task)", as its comment
says. sched_dl_overflow() then handles three cases, by the task's
policy: the task enters, leaves or stays in SCHED_DEADLINE. But the
call site tests dl_task(p). That tests the priority, so a boosted task
passes it. For such a task and another policy, sched_dl_overflow()
matches no case and returns -1.

Fix this by testing the policy, with task_has_dl_policy(). A boosted
task has no bandwidth of its own to admit or release.

Now sysrq-n can take a boosted task out of the class.
normalize_rt_tasks() calls __sched_setscheduler() without pi, so the
task gets its normal priority. Nothing then drops the boost. At the
unlock, rt_mutex_setprio() sees no change of priority. The pi_se of the
task would keep pointing to the waiter, which can exit. So also drop the
boost in __setscheduler_dl_pi() when the task leaves the class, as
rt_mutex_setprio() does.

The boosted_owner_policy case of deadline_bw_test, added later in this
series, fails with EBUSY on v7.4-rc2. It passes with this series. The
sysrq_boosted_owner case of deadline_switch_test tests the sysrq-n path.

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/syscalls.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6f8ce5fd94a1..cb115aa9b0b3 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -304,6 +304,13 @@ static inline void __setscheduler_dl_pi(int newprio, int policy,
 			scope->flags |= ENQUEUE_REPLENISH;
 		}
 	}
+
+	/*
+	 * Without pi, as from normalize_rt_tasks(), a boosted task can leave
+	 * the class. Drop its boost then, as rt_mutex_setprio() does.
+	 */
+	if (!dl_prio(newprio))
+		p->dl.pi_se = &p->dl;
 }
 #else /* !CONFIG_RT_MUTEXES */
 static inline void __setscheduler_dl_pi(int newprio, int policy,
@@ -691,6 +698,10 @@ int __sched_setscheduler(struct task_struct *p,
 	 * is available. Keep this check last. If a later check failed,
 	 * nothing would give back the bandwidth it reserves.
 	 *
+	 * Test the policy, not the priority. A task boosted into the class
+	 * by priority inheritance has no bandwidth of its own to admit or
+	 * release.
+	 *
 	 * With SCHED_FLAG_KEEP_PARAMS, the task keeps its parameters, so
 	 * there is nothing to admit. Such a call changes other attributes,
 	 * such as the utilization clamps. A deadline task does not use its
@@ -699,7 +710,8 @@ int __sched_setscheduler(struct task_struct *p,
 	 * them from the task without a lock.
 	 */
 	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
-	    (dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+	    (dl_policy(policy) || task_has_dl_policy(p)) &&
+	    sched_dl_overflow(p, policy, attr)) {
 		retval = -EBUSY;
 		goto unlock;
 	}
-- 
2.47.3

