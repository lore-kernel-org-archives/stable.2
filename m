Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464835;
	b=AdrB3dy+OPfStaFKF4GWYVLRkOwVYSdeV/9cnEkcVaVEdxA0xZgK1haEmN3FFlKjv9Lw
	 fJ+MhSnEhn538ao88TISUdLsdMse+dPw9Bq3qZwYQ3zDlTYJ4fvhbPCemNRfwIFMSlOZH
	 qlS882/RjvjHNt4UOEL7QaNczg1nX9VBat+mZWcsr4NniUf7VV8RkuuNHLEeZJocROszN
	 HzCckapcyXJvwY0rnxTrDWB8DNqUTmVFgVtHjDRQda9gMS3UUM9lEHYEmkogbmcxLcfy4
	 3LirXSpq5OUpjsXtu9eXXxDN+xkaPy0zNhlSpDumgNafyKkDYthGAil1HVRfSCaoHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
	b=w8zBZa3WwpihZFoAo4NQ5lqvnhz2YRqgd0Y+5LuEkyaggVLauhn8hxFh10kWy9oRDr8Z
	 IVlEc1yb/O98fXBbMgiHOfPLh4gvk3NfQBrTpDpuN6kgFYxP4NjRQVn0qyqiZEl44udSD
	 nNlsLKxuqvZmcH8mqtELq8VzebCV7yEpxA7oPk2d4wuzN9zjQwlBdTzwUFrDa6P1jIzNE
	 yzzCVd1Ae1Ts5+0iLd2wUwuFclIw6XLXBdRBYODTk29NPK7MlNsYVnC85Lzh+Y2BIeB/u
	 xRTqR16T16zZ1c7Byfbto+Zc1fcvZCAHlRI7qRWh67M1fATb0T0QvBfbDWq+6Uj91Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DDqnOq5x;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8D606A33D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05B8D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DDqnOq5x
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b25d977b91so3915249c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464834; x=1796069634; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
        b=DDqnOq5xq6RaKiZmEG89Cm0Xgoq+vkkGqfz04Cx0/yNmgwsDn2fa8m6rNnMxKKBcvh
         Ebf68WwmVpiPA+oVpjp7/fAyBAdOD3v1PJw6r4zAAy1BkYZoxdHBQ9KM3292s21J28+E
         z4SYiBvNLWBPwy9s50UIlz4WV+dwPBu0D7QFCZ74zSWsTkOAQ2fkZ/ttjfePEBEr+Juo
         sKu591ZVGdNLIovcFl9zPlkbgDKxx3DNs9Ga+ASKhrZaQbgGrCEVbiWKyTOgCdLUOvgE
         jB/Q8g1qJ2Gx1bp3Jw/FNHMs167PuXg7CGSCX5VcbQPcuI7psBTo2D2XOgLBpxDpUpD1
         ou1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464834; x=1796069634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
        b=iIOiBucKZ+9WrMx54Uy+mF/aAX9hdjdqzcW+0hCXVfFMgaja+ZAK1E3AQPbp72WEBB
         X70FAf1k5nG02w3qK0DoqAvFAjZqeVIkczdx6yoVk6BbfvQ7kxibmSH+6BPfjOAkevi1
         BYoZfUMXO/93tIDgm9Zpa+S2k5r9yIRQjFG2Sm0gD4ovz5iRqfruKXDnGZt4eq/LMYt/
         sphDvF30WkvDuGmwGfcIs2tuEgxdXnciRggb8Pg4E0n9yIOUHdnUOU2ZpTX4ebMGHFsH
         ck/kHsKbEmqvWKyb4AmBBqjNS7GyKuNf+Dt1zh7i0YY7n5R2z58jNIUOP5fiDo5ZtHRt
         GQuw==
X-Forwarded-Encrypted: i=1; AL+hErEpr7DoYk9EefF5vWi/JY5PMRWArbIu3bssLKV2iFDs9SqHHuboysQpwgQa1VyGGz38rHHANZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+USUpsp+qo37voSe3aXFGGKn41SanTdSap/dzujBeZXOv5pU1Y
	UY1RY7DgmqsNhuObS39+LcNp2pgBFTXKy426WUL1YsEsiuwz6aL6yG3hDTCliHBSR4eUbb74WVr
	Zj1IcuF6EBOF967H/uw==
X-Received: from dlbts3-n1.prod.google.com ([2002:a05:7022:b043:10b0:1b2:5271:f03b])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2810:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1b5568650b5mr11311923c88.11.1795464833720;
 Mon, 23 Nov 2026 12:13:53 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:51 -0800
In-Reply-To: <cover.1795462673.git.penghuang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com> <cover.1795462673.git.penghuang@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 2/2] sched_ext, sched/fair: Drain blocked load on scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, Peng Huang <penghuang@google.com>
Content-Type: text/plain; charset="UTF-8"

Tasks that exit or migrate while sleeping queue their PELT load and
utilization in cfs_rq->removed rather than deducting and propagating
immediately. When scx_enable() switches all fair tasks to sched_ext,
switched_from_fair() only visits cfs_rq chains that still hold live
fair tasks, leaving unvisited leaf cfs_rqs undrained in rq->cfs.avg.

Once __scx_switched_all is enabled, scheduler_tick() skips
sched_balance_trigger() and fair_sched_class is bypassed, freezing
blocked-load updates. Stale rq->cfs.avg.util_sum can then combine with
active RT/DL util_sum in update_idle_rq_clock_pelt() to exceed divider,
inflating rq->lost_idle_time and stalling rq_clock_pelt().

Export __sched_balance_update_blocked_averages() and call it on each
CPU in scx_enable()'s per-CPU scx_switched_all() loop so pending
cfs_rq->removed entries and task-group propagations are drained cleanly.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/ext/ext.c | 9 ++++-----
 kernel/sched/fair.c    | 7 ++++++-
 kernel/sched/sched.h   | 1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..f7c573092e17 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9013,11 +9013,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		static_branch_enable(&__scx_switched_all);
 
 	/*
-	 * Detach the fair_server bandwidth reservation now that the switch
-	 * is fully committed. In full mode (!SCX_OPS_SWITCH_PARTIAL) no
-	 * task will ever run in the fair class, so give that bandwidth
-	 * back to the RT class. The matching ext_server attach already
-	 * happened earlier; this only releases bandwidth and cannot fail.
+	 * Detach the fair_server bandwidth reservation and drain any
+	 * remaining blocked or removed fair load now that the switch is
+	 * fully committed and periodic fair blocked-load updates stop.
 	 *
 	 * In partial mode keep fair_server attached.
 	 */
@@ -9028,6 +9026,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			guard(rq_lock_irqsave)(rq);
 			update_rq_clock(rq);
 			dl_server_detach_bw(&rq->fair_server);
+			__sched_balance_update_blocked_averages(rq);
 		}
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6c3bbb19557..f19f498e01a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11655,10 +11655,15 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-static void __sched_balance_update_blocked_averages(struct rq *rq)
+/*
+ * Update blocked PELT averages for RT/DL/IRQ and fair cfs_rqs on @rq.
+ * Caller must hold @rq's lock and have updated @rq's clock.
+ */
+void __sched_balance_update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
 
+	lockdep_assert_rq_held(rq);
 	update_blocked_load_tick(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 220927453a88..71a69f90e5df 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2977,6 +2977,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void sched_balance_trigger(struct rq *rq);
+void __sched_balance_update_blocked_averages(struct rq *rq);
 
 extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
-- 
2.56.1.831.g720f3f5937-goog

