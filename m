Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464834;
	b=p5rZhFrX2OxHR3mi06x/AGew8ZJS6Np/9xZTVz8OmWpCHbkcOchmZp960jvhH6FTlXDB
	 zhQqfSHEgq64N4Ph6jAH9klou6jMhygP+uvhg8bwaaiPskNRdcomNd+lVPv8zjYs8a1VD
	 NBb/oI+9XhuxwdfjjpZWTgEnaX7e1HlLyjgT5KDP4QeRm0PuvM7zqG08C1L6nVdfN476Q
	 c5gQC69tb/hSKzorark4MqiOUrD+o+xs8/3MYEFy42cds99mDfIXRnpw5c9cSrUCe25lg
	 w240nREhqtG/xXtASTOkzCuRVQ9kqGed1Prymz7DdGM+78kl34rH5V7sF8E0nZPQyyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
	b=mlI520+hrv42LNm1oGjcUot9BbhoVLt8d14HWyXf9L82H7Lah7mYK3qa6y4vDruxmfvF
	 lOtP8UMsY4veRDVz+qxIRTu0XGk3Ph2wCvsgz9vTukf6TBcLxAuFoA3riOrz30/1NREDt
	 KSjoHoi23Jc4USwlU8JDwEfck/C8dAj5cxF/6v7xDKEXdkfwjld220mdHg8KEJKOJAFYr
	 csBE3ZuPPZHkh3FY3TJrayYFPKgXx6JGm19gVuGbES96J1Em6j6Ra/57pCKKuyZdyeVWi
	 Q5PM/yTNbPLxVmkhCKMlHsQ4L8Gnb/fMNCwNRndgYD/aYG37oC73YyZTsbeVwj9EyDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ExdR84Sg;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4596A606A326
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4596A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ExdR84Sg
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso3837412c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464832; x=1796069632; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
        b=ExdR84Sg4qGyK1Z3xbQi9qCNA6tsQU7qMmNYWQNGJjIHAVEHnXnhaPig4NAUglJvvd
         JI9CPksQy0MAS/HDv7J4Lhu0/xKlIcdjQqXsfY9JP032c1GPBiKs6+IS0Po+kz3rGnmc
         NVLrMbJmUzx9KamqBxzGBo4lh8qQZZSrw2dkgXmmeMgNuIdhzw1PIUFOrfsWHUpj67tq
         QNwzaImt0DY4xWdgEbi20XsmxT8dLOPoak3DMcDbV2595sg8BFbsAWO2Tcx5egALHL2j
         LxU9rJ29paztZhwoClp9XOgKbd5dH4UOHHhjAZymAbARMM04o6S86o2vcwTs+UTVycPv
         PYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464832; x=1796069632;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVeUwz94rgbPYTqCCXqv45bL9TNBppX/JDLXrhnAnoM=;
        b=UgZbrxtWPOIObW7ze2vlbvXXkJdJkrjmrRvcnpLnQYfee3ZxHJdI/JFg7mSKM0sMMa
         1XIVt+rOPbTuOQO76IwGCIeov7NrM23jKe9erYAo01mJaQQwsmXBw6yAeNtPkeGIk/G9
         VvqiGLX9OzWHCt21jIOY8e99ORqaFmXRXn5o5Jrp9Qi8TKHbsuTnNBFZ5sTegJ4HrFYV
         3iuX34LyeCDRajE1dUtq5aTb4fHRN8mGxfRwHzuwGCZAoXFBJrbQK+8B5tSSnFWVzxgX
         vyd6aQsT4EbG1HwAqEDZCMradLvbzxSNm6L5Pa3pZCnamcySTpwg/xSyzmtCnTBAiT7V
         YolA==
X-Forwarded-Encrypted: i=1; AL+hErGuhfOaP86BjImgX/uCFXfnBFknFE3TOUm36S9D6RnCSi9Y8aPGx9OKLX1VfLRdsMmpA8xFBP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MFUhJH05isKbmgEw3okHxV1oRUP3nFbDXZOaFV4d/sMoFDue/
	UeY3AazYpZUGa3iQqdMCFnaQlr9yl8s4UnhZZu7Isyjfts80Cs3Fuq3w18ybwpCv3SEWYntKyFa
	evuMAjDolStvF/xNsOA==
X-Received: from dlaj23.prod.google.com ([2002:a05:701b:2817:b0:1b2:4c55:e320])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701a:ccca:20b0:1b5:71bb:6800 with SMTP id a92af1059eb24-1b571bb698bmr4130548c88.3.1795464831930;
 Mon, 23 Nov 2026 12:13:51 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:49 -0800
In-Reply-To: <20261122015729.2512645-1-penghuang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <cover.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 0/2] sched_ext, sched/fair: Drain blocked fair load on scx_switched_all
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

v1 [1] skipped rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() when
scx_switched_all() was active. As Vincent Guittot pointed out, that hid
the underlying issue: once all fair tasks switch to sched_ext, fair
blocked load should be properly drained and propagated rather than left
stale in rq->cfs.avg.

Investigating why rq->cfs.avg.util_sum remained non-zero showed two
causes:

1. In update_tg_cfs_{util,runnable,load}(), if the group entity @se's
   _avg had already decayed to 0 while its _sum still held a sub-divider
   residual when the child gcfs_rq's _avg also reached 0, delta_avg == 0
   caused an early return without clearing @se's residual _sum from the
   parent cfs_rq.
2. Tasks that exited or migrated while sleeping before scx_enable()
   leave deferred removals in cfs_rq->removed, and switched_from_fair()
   only visits cfs_rq chains with live fair tasks. Once
   __scx_switched_all is enabled, periodic blocked-load updates stop,
   stranding unvisited leaf cfs_rqs in rq->cfs.avg.

Patch 1 clears residual task-group _sum values on zero-avg propagation
while keeping parent period_contrib divider scaling for non-zero
averages. Patch 2 reuses __sched_balance_update_blocked_averages() in
scx_enable()'s per-CPU scx_switched_all() loop to drain cfs_rq->removed
and propagate blocked averages across all leaf cfs_rqs.

Changes in v2:
- Drop the pelt.h workaround from v1 (Vincent Guittot).
- Clear residual sums in update_tg_cfs_{util,runnable,load}() when
  propagating a zero average (Vincent Guittot).
- Reuse __sched_balance_update_blocked_averages() in scx_enable() under
  scx_switched_all() to drain remaining blocked fair load (Vincent
  Guittot).

[1] https://lore.kernel.org/r/20261122015729.2512645-1-penghuang@google.com

Peng Huang (2):
  sched/fair: Clear residual sums on zero task-group avg propagation
  sched_ext, sched/fair: Drain blocked load on scx_switched_all

 kernel/sched/ext/ext.c |  9 ++++-----
 kernel/sched/fair.c    | 42 +++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h   |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.56.1.831.g720f3f5937-goog

