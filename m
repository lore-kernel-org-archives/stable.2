Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312652;
	b=cwAJ32XUrvmU2sgBHYe3mU7sXpFT1iujVO42FIQOAoTQR2i5VoVwezJz4qVKZdaYzqBX
	 q1YJRbmoRAzRI+q0Jozc+V+LRbHFrOwfxHg5CyyWWk8rycGlQZdHYrgY4euy7vEe53/OI
	 dJPifXqbtcg+B1P2P07X4soZ5mQMHWU3pcg5L5N5CaQ0rCSTaV0zKCo4kH5bpRXG6fqXJ
	 UjJT/EBJbmXo464uywfnRyrsVmmtUO8M4RcbZIS7udGweddlMfGxNjGetAUymzF5FvZtJ
	 Nt09iJXDf8myi9fTOSNor1aqxAeRL8jGc8LjpSFwFbt9szhu7ysl2ltuKDBlpYkcJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
	b=yjRWqbXO34XAQ9Hzt83jp7i8gqEfnUWz1vCXBKxyCACQpMu6t5lue4UOOGxFy+emBjSU
	 qgj3gE6ntPzPJSo5Sews5av9ibFXLohjvNlqGrA1y7VrgJTRA3s7k/SjW8+HSg2D6WNPn
	 CdXqleYtX07xPv6EXuRlkjbOH5Je+RIKlwKgKcV8xUmBgfG0l7YhX4FBqXCQL3m1xV1fP
	 Zpw5nVDwqPBxVATsyATVQ4wmfpVmARDTEo1M0sQPORknjYJbkBmGf/d1WquVCxmFqxBV6
	 OF7u0FvREK1L6iViivnXbMWjrLYM3gAmDXA4KG/QoXuv6GzO3HYSmxBTsK7Yz/8JWhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IrqSsEfn;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3B606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD3B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IrqSsEfn
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b56c696405so1296361c88.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 17:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795312651; x=1795917451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
        b=IrqSsEfnmfXoFpshwVJGt5+kKTWm4IGzyYFibY2bmokQWKKRb2hgFxdV1T0BcFPu67
         zBgLNA4wuAdlhZDlnFPRcbvDf/j4jQbSTiWwFPqyakxFaMoxfOwX8CfU7QV2xMv9kFSp
         ehQMv+dnVdFyF1E5gvWzv97aI5InFNYMRjths6leW0UUNjzYTKQrrC084KkUj9XRxe7K
         krbrxnSvQ0o6hXp5tzALQ4S7OEjnHQnNSNawCSc+sVWqbVpyi8D4UETO3s5Ajai1Wjos
         x4Xz4hOlhkKmFTSqEDb6UEy6yhM1iV8dZbstxViPGoIchLKDzS50PrgCLdzmrHVMSA3U
         htvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795312651; x=1795917451;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BslzRReFXUd+tW3SQkN1QdM1be6GaD92Qfct44ghPbA=;
        b=rk4xsnCA+AQeJ76v2NXMlPj6QS5eCu9apnX5zRzm2dW3tj3FyrspLAJ5fRUXy8xZZ0
         mVB97Ua6mgQ8708KltN+lvzwAEYbzbpt8IjminXauvCKs1OwVtmOSvd1nmVz6wMDXiLL
         QFD1ZUbKX3biXFrySZC3MWS0bYyr0VN365P5mNbESAlL6oFCfiQ/YhFwEnDLr+T8GPRC
         yeuV3yHtBfN77rJM4PdA78IA0jLzyYbWaZJWZR3VNmeaCW1uGv3vto7SUmgIJZdx0ohm
         fZ4TJvrpB8nmKAp+OmM4VJ1X/PwGuoXoxoKmT1CT8tSVIqjMPTeK3+IQHSuAJCBeGX7L
         ecXA==
X-Forwarded-Encrypted: i=1; AL+hErEstaqa55k+eVCSBdiIApOPh3m5XvZRS4Twtywskf9eFvaUttKzalyvPuhu/PvhEOqSq2WtCJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ccjoFsmlKbHQpRI/8q3BhS9wOvkT5KtX3bc39Ajafah0cgQ1A
	P6ukv9clujeH9lWWLlsPShrsUU9cz0jdfE2CT1yUz3ZHl8Fhhf8T7ttC9ZUrO3GztHI1/uqqp3M
	DCxDmNHS20x2joDo2/Q==
X-Received: from dldz10-n1.prod.google.com ([2002:a05:701b:418a:10b0:1b5:9ce:e6d5])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:321:b0:145:287:ce91 with SMTP id a92af1059eb24-1b5568cb6b6mr11510102c88.14.1795312650111;
 Sat, 21 Nov 2026 17:57:30 -0800 (PST)
Date: Sat, 21 Nov 2026 17:57:29 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122015729.2512645-1-penghuang@google.com>
Subject: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peng Huang <penghuang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When scx_switched_all() is enabled, all fair-class tasks move to
sched_ext, scheduler_tick() skips sched_balance_trigger(), and fair_rq
scheduling is bypassed. As a result, rq->cfs.avg.util_sum stops updating
and retains whatever stale load was present prior to switching to SCX.

When a CPU later goes idle, update_idle_rq_clock_pelt() still adds this
dormant rq->cfs.avg.util_sum. If stale cfs.avg.util_sum plus active RT
and DL util_sum reaches divider, update_idle_rq_clock_pelt() treats the
rq as overutilized, continuously increments rq->lost_idle_time, and
stalls rq_clock_pelt(), which in turn freezes RT and DL PELT updates.

Exclude rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() while
scx_switched_all() is active so dormant CFS load cannot stall idle
rq_clock_pelt().

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/pelt.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index f921302dc40f..6d31e1fbd094 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -138,7 +138,12 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 static inline void update_idle_rq_clock_pelt(struct rq *rq)
 {
 	u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
-	u32 util_sum = rq->cfs.avg.util_sum;
+	/*
+	 * Under scx_switched_all(), CFS PELT is dormant and may stay stale;
+	 * exclude it so idle CPUs do not trip lost_idle_time and freeze RT
+	 * PELT.
+	 */
+	u32 util_sum = scx_switched_all() ? 0 : rq->cfs.avg.util_sum;
 	util_sum += rq->avg_rt.util_sum;
 	util_sum += rq->avg_dl.util_sum;
 
-- 
2.56.1.750.gf70dc682cf-goog

