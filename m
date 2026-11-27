Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805907;
	b=ZaQVAzVk/1lEoch10Pgffr1T8jly+AUCDXmDHHhFU7gkOlCh1/OSjFg+1QtQbhX0H2Jm
	 Y1mzVsHY3Idf1D67NU1RqSUFSrS4hF5/dpU+zUi5qTNI2a0lkCKHqAGD0po0mSZkpRDj9
	 xyj34aSjoOjpLfaZEssljCu2cv665oXwic7i2A8vX0fKZExwxMb7/Avv9LMe1emRiTwfU
	 4YnomD9qVzDEpLj6M2g92o1GBWWUE2W7qfvZ23rwQCXTlMwkjhScP/dQ47/Qm0Z88eK++
	 3QWUqvlaFrPTLBQde9x510gq+BomNrU+oNiM1fECULi2asSwR8Y/4ZecoDUWnXf2/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805907;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V6G0bPzKPqW9y5CcOLYbTf+p7g3V14XBJCbAwz7OwwM=;
	b=mtat4LAnbnKl4Kx4t1W5qaEnO7VUYtIY5mEARI/qpXsxscU16Ou1+lnZqWQUDnazX5pZ
	 ONsWnpksIwXbpzYWmjaUiiJtATVXar7OaRv2MoRmQKH5jLLL+OoTQLcxIg5n5gxf1N/XR
	 bgLG8U+MwpwpZxRqLkRKOntW5uIjNeK72l7C+wTSa0WUHz7JoQd1cKptVwp+JCrZ19cov
	 gUIjo8a4M/H3LC4HWOqcNHWn891w4fvB9f2MwdNVsSAi7RWgpJj/vHDz7lT7EiPtjYWmk
	 KY3KWWJkJXxCsK/DAL3BqRjj0OzcOnUUQH3znZCmSoymKlFB66EGWmeFv1uzLgNtp7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=FGolAFoD;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FD606A31F;
	Fri, 27 Nov 2026 18:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5FD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=FGolAFoD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805903;
	bh=V6G0bPzKPqW9y5CcOLYbTf+p7g3V14XBJCbAwz7OwwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGolAFoDgZU3DzGicV8Vc1sZFuagZFesnIEf9vV+p90etSxy2YCaTqcZwHe3ks2im
	 pDnr8l/fR31m/VL0TFlWBUE092LQNHxqUsHgwopB3/6njtTbxJ9mIcCPE9s6r35J8f
	 uZc3M5xrLjnPftllFAB97SK8q7axm8WCGo8YBXL+6mEKkytu6AiSe5OX5H6bu1e+SY
	 9LL4YvJOExHU/G1OMJAbXHryZQdDmr1Ub9FhWCV+0zcyeENFvIyf7GUcAV0eMWtwiP
	 sZI17CgT/svkJk8omXT3FJIds82N7M7WVofg6UQQ5Fp9hXuyxTSbO4IiYS47cUMSZO
	 okbE57SGRMxbw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNv6FPxzXFq;
	Fri, 27 Nov 2026 13:58:23 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 02/16] sched/membarrier: Report only completed registrations
Date: Fri, 27 Nov 2026 13:58:07 -0500
Message-ID: <20261127185822.158216-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
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

MEMBARRIER_CMD_GET_REGISTRATIONS returns the registration commands
which the process issued.

Each registration has two state bits: one is set when the registration
starts and the "ready" one when it completes. The command reports a
registration when either bit is set.

The sync core and rseq registrations also set
MEMBARRIER_STATE_PRIVATE_EXPEDITED, without its "ready" bit. They set
it because their commands need the same scheduler barriers as
MEMBARRIER_CMD_PRIVATE_EXPEDITED. So a process which only issued
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ is reported as having
issued MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED as well. Yet
MEMBARRIER_CMD_PRIVATE_EXPEDITED returns -EPERM for that process.

A registration which failed with -ENOMEM would be reported the same
way.

User-space gets a wrong registration mask. The command was added for
CRIU, which saves the registrations of a process at checkpoint. A
restored process would carry a registration which the original
process did not issue. A program which trusts the mask would issue
MEMBARRIER_CMD_PRIVATE_EXPEDITED and get -EPERM.

Fix this by reporting a registration only when its "ready" bit is
set.

This changes the mask which user-space reads.
MEMBARRIER_CMD_GET_REGISTRATIONS no longer reports
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED for a process which only
issued the sync core or the rseq registration. The result of every
other command is unchanged.

Fixes: 544a4f2ecd45 ("sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/membarrier.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index cb957b8f1946..46e823a3d668 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -566,15 +566,17 @@ static int membarrier_get_registrations(void)
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	int registrations_mask = 0, membarrier_state, i;
-	static const int states[] = {
-		MEMBARRIER_STATE_GLOBAL_EXPEDITED |
-			MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
+	/*
+	 * Only the "ready" state tells that a registration command
+	 * completed. The other state of each pair is not specific to
+	 * one registration command: the sync core and rseq
+	 * registrations also set MEMBARRIER_STATE_PRIVATE_EXPEDITED.
+	 */
+	static const int ready_states[] = {
+		MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
 	};
 	static const int registration_cmds[] = {
 		MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
@@ -582,16 +584,13 @@ static int membarrier_get_registrations(void)
 		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
 		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
 	};
-	BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
+	BUILD_BUG_ON(ARRAY_SIZE(ready_states) != ARRAY_SIZE(registration_cmds));
 
 	membarrier_state = atomic_read(&mm->membarrier_state);
-	for (i = 0; i < ARRAY_SIZE(states); ++i) {
-		if (membarrier_state & states[i]) {
+	for (i = 0; i < ARRAY_SIZE(ready_states); ++i) {
+		if (membarrier_state & ready_states[i])
 			registrations_mask |= registration_cmds[i];
-			membarrier_state &= ~states[i];
-		}
 	}
-	WARN_ON_ONCE(membarrier_state != 0);
 	return registrations_mask;
 }
 
-- 
2.47.3

