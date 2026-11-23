Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464834;
	b=Hy2emfoq/iHEnQBqhvnVH49KyDBtJ8vPV7p9GbXnbfG+/cDQvB9QR7R+ErP80QqO5NYf
	 t+8NzwAVDuPUJ5VZ4gDlKO1ZCQ/dXdkoqXmAKdt8YsJVf+Ffckqi42j8d19I9C1FMGXUo
	 UXyZEDzc+MrAoetpGWQjbjQkzIj/NkZ+/LPlU0bgAEOgv5ZrI2/pqwt8NOowpohzKo+qu
	 xrMOk1tVdvh+ZI63OBezaaWkQzS+i/Dx//q8IDr3vKaxe2r1ydPKd6WKFY9Aokoq9DXCb
	 Xoj2rV00JSH1JZ6NvHR0QVbafvuhw8qG35zrVtWIBJsEZkhofP7KfaJeAvQJx+WbpTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
	b=gxVBvBJuUeZFg/Pt/QiOhnjsPMRUZP3oYnZGa44pW0pdQrQAIP916imL8fmVJCxcIvxy
	 5nSGjdOmbDKrmHw28sX7BL/0ciXoYdQdhEqbw9QnuzkzDw/bFhhiX3kzCZtBewC5ey6k9
	 9IJ30xU0ZK40hEGMhP9AIgLOXeR9tDMnk7Hde1fLDoV3QZFp81N0o2DO97dnTEf0Yk5sg
	 S/94TOTeu0LwCJmOYGiFqrCTm2GbTEvnqVUKj3R5egJMGJUViI/q5wfR/mwH/wFJR55uM
	 Gwk8416XJQQ8SAofBjam1chqTKjunYDYOxa7CG8pmDB4kbZ2S2/L6Xt8zERmE6WjLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M8BBCR94;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D01606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D01606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M8BBCR94
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386b8624cf7so2017292eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464833; x=1796069633; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
        b=M8BBCR94zUt79VyIkrqlSXJkrYGQg87WTnED9fNR2feH+PwXwZ+mklCRCG3+wUZVY+
         /sfhqNyygkBKEUmbqAdtBT4StrZN6cLdMqz/2bMcijO/y3nLPMmWG8zSvF+2MSqni45Z
         76AmSEe7Uw0LHiMrOKzAceMQ8XRMoWe5rfYlPbt9xpAOEpITJMsLJCs/1m8Jrs13IWIz
         zuoeCv7xYuQNBdBzwj1luqUZ1ZuUxrdK7OXk8UhqCcWOkYyxTYaCm4O+aeQL/nT/KaII
         99kqyuX5wroEvx/uixvKI4LDsU8tigI5QATZ7DHkq+3msTwVYggSGTy9bkd3itty9N9e
         oefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464833; x=1796069633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07eBemD258TjOvIXnaCAqD1xKEe3Z3jPTS5xgfZLphA=;
        b=UvpUjFdu/xR2FveiPQFkRe7uMqcjpR/+ZknhQQFbshXmUr6iziqL+OmILaUHncgh0v
         zW0ANAXOyqVgNUtYVZXWpyRAHjdxLEIZRhaKGnJsFRS6ay9XbjwT9x4KM8FB4rRAb9/w
         qxt7kh6CIDquflZk/Ye21DcbkkTU4ZFLWNGTQUxL3e6E8XIY7ixTWTzh2yNPTiAQDi44
         YiQTqTpjQChk2p6BbHG5NAObjPxWbtE0Hfy/xkzKfaSWLR55q7Py+EmarhWHKtPXw097
         mUyKzjpTcjjv7Iz6fwUgmsfSEpFKGryNksKlCHsI8uHc3JaEbLgJ1Cd4yokqgXI2Cla9
         sMiQ==
X-Forwarded-Encrypted: i=1; AL+hErGDF1S8IBax23FAszfYa4k+rt9UNJAfFnFCFmJZnhXzwNFLTw51YmOGj/Iqsq/0fqc6WGRlFKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tamWp549ceINd+cnpmsaa3ueMySEhB/MT4b234Z7TYBOSF92b
	XW2B9UNC6/5PDUzkZQUcAw3iWf5QVaolXEIHu6tYLIPRCj92ERjDx2PZWUrccduoQ5/AOeADYoc
	Ql/T/vZCFYX3dN59Shw==
X-Received: from dybmb7.prod.google.com ([2002:a05:7301:1907:b0:385:6c3c:3ea1])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:f498:b0:386:a716:916b with SMTP id 5a478bee46e88-386a7169544mr6533417eec.31.1795464832877;
 Mon, 23 Nov 2026 12:13:52 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:50 -0800
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
Message-ID: <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group avg propagation
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

In update_load_avg(), __update_load_avg_se() ages the group entity @se
before propagate_entity_load_avg() runs. If @se's _avg has already
decayed to 0 while its _sum still holds a sub-divider residual, and the
child gcfs_rq's _avg also reaches 0 (e.g. when its last task detaches),
update_tg_cfs_{util,runnable,load}() see delta_avg == 0 and return early
without subtracting @se's remaining _sum from the parent cfs_rq.

Keep scaling non-zero averages by the parent cfs_rq's divider to
preserve period_contrib alignment, while letting zero-avg propagations
proceed whenever @se still holds a non-zero _sum so the residual is
cleared from both @se and its parent cfs_rq.

Fixes: 7ceb77103001 ("sched/pelt: Continue to relax the sync of util_sum with util_avg")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/fair.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c8af1cac2d5..f6c3bbb19557 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5516,9 +5516,15 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
 	u32 new_sum, divider;
 
-	/* Nothing to update */
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep util_sum as-is for unchanged non-zero avg */
+		if (gcfs_rq->avg.util_avg != 0)
+			return;
+
+		/* Nothing to clear once se->avg.util_sum is also 0 */
+		if (se->avg.util_sum == 0)
+			return;
+	}
 
 	/*
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
@@ -5543,9 +5549,15 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	u64 new_sum;
 	u32 divider;
 
-	/* Nothing to update */
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep runnable_sum as-is for unchanged non-zero avg */
+		if (gcfs_rq->avg.runnable_avg != 0)
+			return;
+
+		/* Nothing to clear once se->avg.runnable_sum is 0 */
+		if (se->avg.runnable_sum == 0)
+			return;
+	}
 
 	/*
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
@@ -5617,8 +5629,15 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_avg = div_u64(load_sum, divider);
 
 	delta_avg = load_avg - se->avg.load_avg;
-	if (!delta_avg)
-		return;
+	if (delta_avg == 0) {
+		/* Keep load_sum as-is while child load is non-zero */
+		if (load_sum != 0)
+			return;
+
+		/* Nothing to clear once se->avg.load_sum is also 0 */
+		if (se->avg.load_sum == 0)
+			return;
+	}
 
 	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
 
-- 
2.56.1.831.g720f3f5937-goog

