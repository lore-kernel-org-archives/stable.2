Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607774;
	b=j6WKDoCPhNJuL9xNHaOAqStkev4awbqilxfiDoHbDprzwr7zv/EovCULaCczaIcDb/sr
	 Wjv/BAcTu0K50n2SjGcGoS6BZlo/3Ak6LMiFfoU/SA3Gmc+YR4m00/5tMQSqK0zGnbTrH
	 Rf5SgaRIEFIOAgatDH10SzwraEwylK0mqj8NY96IPq7TWQUG0SP4ysvE5Cf1lfaj9b4w+
	 rrdwlzgx901SzUPJtZScNtjqmwY//8wk3bAzmGS+IDzE8d7Wfdv/dHzF6+bDpdjfsAuYD
	 rHCk8fNqImNmvM7jHyhj4APOdF10yBUku/qwSPAtWODAdtPqqO0P1ohl1y6eoaO6nSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/7w7WDtffWC1NiS68zJjtHBNdebbuTLQzdHDhviSbiQ=;
	b=zqIE6Tl0AxLMoe5FkbqZ5umcFpBlFfbIRuXGhFgxnccTJWScFxXz3JrcBSEUdxbVy7BI
	 jmsiT73hP3H/G//HnAS5zMwMrVLGvQ0L6SceUlTPrL+0tyUlXm/8cHTcmjl/RYMrEEUqt
	 zUUo/7l17j6BVeddT9ymZ4P6MWlhKv74EaNL1jPERj/ACToNctu0R1sqBFOCIvQeywXTV
	 i8A1wKqcYDPdhNfsC1A9uAh7um0VKTHUenoebvgpR/nAQLBYW/RrICuLyun9Sy2T0ZTqG
	 Gu2c6DDenEqdoJm/0X32dxcQuytwcXRVc5rNOJv4JVXMjcsNvz2pUTaKx9PqX2tvl/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnLKVfy2;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA269606A337
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA269606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnLKVfy2
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b4ab53a966so517138a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795607773; x=1796212573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/7w7WDtffWC1NiS68zJjtHBNdebbuTLQzdHDhviSbiQ=;
        b=YnLKVfy2PM1puw+XxY5Mp2kY5GTdEPSbT72AKFvhnN/xd4+kSOnMRtHqohy0+8WXwe
         Uv8FTgHYBM8ZXss2MBvgVrUsvBOdENfjIm6XJheBk7ZcVKPpWs4mkOlJy8tWtm0acI10
         w3Y7678Cd5tZ9G4OAPUoefBEBKjMf3eD0KsqSlcTnXZvWj0eBemmSRS6cG5hrCyE4sAC
         W55KvnLiUh8aPZUKnGQcHpznRW/P92kRxB+Z1Ptf8KDi/JN7yC2bYE2MmyJvJXfMQi9T
         e/YkLMpmGkIhw2K6W14zz8Zud/12lSenhTodgXybaWogTJ7GdIWPoVArl/q4fDOuXyuB
         1dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795607773; x=1796212573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7w7WDtffWC1NiS68zJjtHBNdebbuTLQzdHDhviSbiQ=;
        b=TDGji0TIguzQEcauuXl1BngrD6RFhjKy8iWr5qd9Cm3RbECI60WgaRDFpjnDxctec0
         ap4/u1sR62u6y6TUsnd3gaRGJSi0jSI8XI0FDqMPFWixFwtKl3e5UXIOKIsNVYLZpKEM
         mgf1YS2NuIH2j7GHrs6vW+J78yJPYScTIEMrU8m5g9kn/GEf0bJy7hF24RNrMpe3RsRF
         vM7RNoPjpkuojl9pCRE2GI+XSGNcpQOtX3FFIQb2uyQIGU8b27bwVXLHvwWozebcmsvU
         AyLSD9nVEmiomLrrNAHn2XRXZUdPHLqjmxW0KKKQpEk/xmvN4nddcw9/Q2kFo1V3uwZb
         7Sbg==
X-Forwarded-Encrypted: i=1; AL+hErE7yy3xtC3C5gi4NZkGAD/FN9Uq+XnpRgLZohdEih4M3BkMIT0cwfbVGhO30J5qiVp+HiJsZDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RIDf6ELqe/1lSuu3UnM2rXlZZfskPzXoYcY+OXOZIQYMH30F3
	jMbHgMTF6eEZSVzPtNy3A38Xk++mWjA05y755B8sb94dy1dunSVtV1BB
X-Gm-Gg: AZFdTZcbrMFZR3sq2ixQBgFimHSHmHTOdN8vWWr/G0bGwyrV4H5Gkgvg8vCplAcSUuT
	UeJP+AivzKGBzSfocdESoxdzg1V2JlSbKuWSgxtzj987jYY9j6DZuTTG0QFDg6tWXxSc97yzWLQ
	ISEn4hkn5oO8XRPk/aW6rfuSJWka6xXqcuep7bbnDeplxp/I9zJnEhuFfy4EK1h2ikVZV9ItR8s
	AoI90ZwSz9e0zDgmbQKERw4U2/zb6+63PSKEdDybHyq5X9z/hUMm/vDvysJxec/yEpF6hD7ot2e
	WIZLDGP3eQv48kDDYYjbWy/8u01IcrHxI5BpSnXHIu+2mLkHMiPR9NN+xU7AlP2+DdIeMjhjRFu
	tusIn4zYxxavD2hFOcxPCiO9daypyKhmktOIecMgucy4jC6/t7EbbAUa2NRiGdblftVazsV2blf
	gb25x7khQqm7QYJ6fiobeenEIlbh9RZOUkiPWV28P1XwoP/dzswyfD0x6VIinxOXaSdRwcGejOE
	e0YAd2kSGlIVR+WQiAJfy6J5WM2b494vrU7DzP04TQ7QxuX0N18SXiCg3Va8UFXBIZND0ls+yOX
	ltTWj4JZhobHR0Hhw7Cqo6tHnzz0WloFgZ5sciBKQPnJk6oZERRQRcI=
X-Received: by 2002:a17:90a:e70c:b0:3a0:c1b1:45fb with SMTP id 98e67ed59e1d1-3b41c58aebdmr27297074a91.0.1795607772912;
        Wed, 25 Nov 2026 03:56:12 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm26506574a91.7.2026.11.25.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:56:12 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Wenwu Hou <hwenwur@gmail.com>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Avoid counting sleep time as run delay after migration
Date: Wed, 25 Nov 2026 19:55:19 +0800
Message-ID: <20261125115519.2373653-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

A task with sched_delayed set is sleeping even though it remains on
its runqueue. Migrating such a task calls enqueue_task() on the
destination CPU, where sched_info_enqueue() starts last_queued despite
the task still being asleep. A subsequent wakeup does not replace the
nonzero timestamp, so sched_info_arrive() includes the intervening
sleep in run_delay.

The timestamp can also survive final delayed dequeue: pick_next_entity()
calls __dequeue_task() directly, bypassing sched_info_dequeue(). A later
ordinary wakeup therefore retains the migration timestamp as well.

Reproduce with the Python script [1] on a four-vCPU KVM guest with
DELAY_DEQUEUE enabled.
With competing loads on CPU0 and CPU1, a worker runs on CPU0 for 8 ms
and sleeps for 40 ms. Migrate it to CPU1 while sleeping on alternate
trials, and compare run_delay against trials without migration.

Output excerpts from python3 repro.py:

Before this patch:
  worker=697, CPUs=[0, 1, 2]
  trial=00 migrate=True state=S run_delay_delta_ms=40.259
  trial=01 migrate=False state=S run_delay_delta_ms=0.223
  trial=02 migrate=True state=S run_delay_delta_ms=40.194
  trial=03 migrate=False state=S run_delay_delta_ms=0.229
  trial=04 migrate=True state=S run_delay_delta_ms=40.202
  trial=05 migrate=False state=S run_delay_delta_ms=0.230

After this patch:
  worker=350, CPUs=[0, 1, 2]
  trial=00 migrate=True state=S run_delay_delta_ms=0.005
  trial=01 migrate=False state=S run_delay_delta_ms=0.225
  trial=02 migrate=True state=S run_delay_delta_ms=0.620
  trial=03 migrate=False state=S run_delay_delta_ms=0.232
  trial=04 migrate=True state=S run_delay_delta_ms=0.236
  trial=05 migrate=False state=S run_delay_delta_ms=0.234

Across 15 trials per group, migrated-task run_delay increments fall
from 40.167-40.259 ms to 0.005-0.624 ms. Controls measure
0.223-0.234 ms before and 0.201-0.620 ms after.

Link: https://gist.github.com/hwenwur/61cf383f8df72d4270ad9918b1d4edc8 [1]
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 515b9d0353ce9..043885c66365e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2198,7 +2198,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	psi_enqueue(p, flags);
 
-	if (!(flags & ENQUEUE_RESTORE))
+	/* Delayed tasks remain asleep across migration requeues. */
+	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed)
 		sched_info_enqueue(rq, p);
 
 	if (sched_core_enabled(rq))
-- 
2.43.0

