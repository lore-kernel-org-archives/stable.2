Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634079;
	b=gPW/tPIQQTfNhVPFFRVFVOc9zat/ZmmcWIPXDQ+Vj7RL2hGEOAlxS4RZYJakyVSmsSYF
	 KkoGrtif2nAjE4LaFOGJ2gdWEv9TIuJVqL+RNset6o2ysJ4WAVhNvOiJ3UyEbQqdFLLLa
	 4aM1gQNrHS+nB8FXz5H3260zoLhpx+pn+4hpu4aRCn6UNQXyZ5wtoQ9BObTVUUej29g/Y
	 taMOIqNyBLHhZz+fMwE2mevWnzhHwFhqpDGXPNta7UCWIq0Ek77/j80pJZCpdXKGYWgkn
	 YrXgVrQNUYR6i2uLEK1m5euoZVRcj4xoUD+sCvNy4KkCWGvKKQLOkQSbGadQDIntycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vyDQED3EGkZZiLHFtXYyzYOTnF57mjSAU39yebIZJk8=;
	b=evEIoshIceNvOBc8CbeHGtCxErggO4dc86DozhqC0OnNWyklnsM/ofSWLGe/pziBQZaY
	 ZPPeWyYKpTQjp8MX6iYb4igoIULs1PVFADD4MjG8QM0kTVUhqWDSk+OqJVez9mXRsmjP7
	 j6nbTUN6Vt3XJhD6zFUIhU21RdM1MtTd2xeYk3vBGmrBjhhSf02K5s1sfTIeWmXxuULVc
	 ueblh/fkaoUTEsknWOsqugMjvDuS6ziLdb7iFj6n4lm5GgHR3/86sJ5Ad85iPGV6rWcnR
	 h9glUFCsYZR9ATzoLVUci7X1ivXpGE0w+me6v8yX8+TDIfKY/E6WZ3wggSwyR1euehA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvP4gCC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD9606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvP4gCC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43EB1F000D0;
	Wed, 25 Nov 2026 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634078;
	bh=vyDQED3EGkZZiLHFtXYyzYOTnF57mjSAU39yebIZJk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NvP4gCC109QMRsxEdH+znFxAsBg6njZhhSJFS/rMgZJ5ix1JWE6PmL5H/MnceAlvQ
	 dBzUBcZyJcWdXVsatIqwslP4VvX3LAy4OmM/fmKwmiwNsMVv7sx3dmclT+XJ32ADS+
	 2NvttoEV+F/3F8PyUCBRYZVJjVBW2x/w6jAhzgQHe87y9+ZzwgaJy+eFuIM5Os/gyT
	 oMfZq4SnbLjxRTerQUVDlYWND/3cMfHOiPll7wrNXf5h1aSAhsL2eIWfP569WD3nul
	 QNX+k/YEw12pqoLFzoahQ6LQRYx41CiwMV2wXM5lcfPB2Fl/vmyxl9VGcS9UX7mjiF
	 FBo1bdCB5pvFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Factor out drain_offline_rq()
Date: Wed, 25 Nov 2026 14:14:36 -0500
Message-ID: <20261125191426.1206736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-tipping-unblessed-bf3f@gregkh>
References: <2026112517-tipping-unblessed-bf3f@gregkh>
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

[ Upstream commit 1826e5aa068cf6c21791773f160b4a2ce5d5f9a5 ]

Factor drain_offline_rq() out of rq_offline_scx() so that the drain can move
to handle_hotplug() in the following patch, which removes the rq_online and
rq_offline hooks. The drain is the rescue flush and the re-enqueue of an
offline cpu's tasks onto its local DSQ. No functional change.

Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ sashal: Replaced guard(sched_change) with sched_deq_and_put_task()/sched_enq_and_set_task(), dropped the missing scx_rescue_flush() and the sched.h comment hunk, and used the old scx_ops_bypass() name and ext.c path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7a4b23e48cc6f..bd093abaac0e7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2114,7 +2114,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_ops_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_ops_bypass() and drain_offline_rq()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -3507,6 +3507,25 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 			update_builtin_idle(cpu, idle);
 }
 
+static void drain_offline_rq(struct rq *rq)
+{
+	struct task_struct *p, *n;
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		struct sched_enq_and_set_ctx ctx;
+
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK, &ctx);
+		sched_enq_and_set_task(&ctx);
+	}
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	int cpu = cpu_of(rq);
@@ -3540,27 +3559,13 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
-	struct task_struct *p, *n;
-
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 
 	/* sched domain rebuilds call rq_offline with the CPU staying alive */
 	if (cpu_active(cpu_of(rq)))
 		return;
 
-	/*
-	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
-	 * onto the local DSQ so that they run here and balance_push() moves
-	 * them off.
-	 */
-	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
-		struct sched_enq_and_set_ctx ctx;
-
-		if (p->scx.dsq == &rq->scx.local_dsq)
-			continue;
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK, &ctx);
-		sched_enq_and_set_task(&ctx);
-	}
+	drain_offline_rq(rq);
 }
 
 #else	/* CONFIG_SMP */
-- 
2.53.0

