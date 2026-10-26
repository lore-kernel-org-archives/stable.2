Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011274;
	b=Taikomqx+Co2yv6XR0z7QWw9IN1O/gBWdXZ1e1Ibj1PKej87Rkv+63MlpltHxB/m2tRy
	 MoZQ8/gQtx6kA7NWA7TAT3jxoW/Afte1IVzsX2PbfBeY533ll3BylZEmUDx1wVNZJXoaH
	 BIOTVFDDEuvLbVlr96rcpJeWjHWMCZSwp12nOkXJtnCGtWXF9bmqDCyVzeZlMn72AjKC+
	 uXn3WLiqtgURjf+pHQJSk1ADDPGawwz+d7qf5sk16cyTQR4TWuVR6eNlV6R6eBKrm8AH8
	 4mnV+PBE3Sn6iuh7OgXvKKrXl6ntV8oISctGLSFcEk5VzfzgsSfSe09Ac0f/b3AEJ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sJmDHnBLEdft3BbzBut/ID+xSxqG4s8c0c0mwhwfkAc=;
	b=oKw9VLJNuowt2cVOR76TpRHB0D9rArzxe1d7DmFWarwyRCWnRByoIcCXnGv7zB6UgjFO
	 bds/2Hl8NbFjx5H/PVdLLu2LMnHTd4RFQKrRuIhgnWXb1QpFjsjoY4d3yBPjQ/be6puat
	 koa5IaWgxkZnoB08f/YnCVKUq4PYmcGwCF0H4HYXBhqNl+tPJLeuJmTFKfydQwYS9tTXf
	 aPRq341/MbJoUmxdV45KvpkzyDay+dNrIHXfk943oPR1utOACDRfb+IxGhQf83SepkkqB
	 Qq9Wtq2SwneYxjhYA86uSfcGlHft/nloxTCq9dt3NDoZH0BnYNotELlI2WrKXZDJT0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="U7Y4d0/K";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEB606A325
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABEB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U7Y4d0/K
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b060ec084so1713054f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793011273; x=1793616073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJmDHnBLEdft3BbzBut/ID+xSxqG4s8c0c0mwhwfkAc=;
        b=U7Y4d0/Kp8EWSnH/Jk87Bb1JRM3PUKO/bHN1I1um6SbcCJRW/LOJT5OIM38/3Q/+TH
         SzH0TiVeF8B28chgsbZVVILH+gQC2/IlQVXMv2Wz/Mdr9N5D0R/mV96j781CJ88Q4Qoy
         3bBUH7GsuOfR6gvV+LrPo8bQ3vQXYCecAh7izsiwtVRlkOx4u8vwFHnGR/h0aTsLRCE/
         gUoL3wyVkhEigjRlWt4h4mzIEae7yBSpmBulfh2v8O6rkOONbYOH3M8Z8tNCo6GWWZiL
         mL2KcuuFT0TkG11c1SHOO/J/aE51CkoMCPem3nko50+HmXGfORpmhvvBrxssPzvhfJju
         0ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011273; x=1793616073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJmDHnBLEdft3BbzBut/ID+xSxqG4s8c0c0mwhwfkAc=;
        b=xu3MMuMt9PQ0urLBIRhuzxfhVDMWyK8xWRWEHtwt4Xards8q2jPIS6uKmB4CcTWZNn
         qlnW1Icxde1axsG8be/9tI2vq19Gp3MxyBH48G+gDkfJgxgXD9d9IEdbMHZEmdDk+7g5
         fjUBEXDdXn8hIlaFUKk62cqnq5zVnrYxyoZuaDwOsJPiSoSw1VdtWQvGvQ3rGFMZwxU9
         ON6KCaDLxLY50vH8szimMtRcayJZpIl6xO2Ql7QeB8bCL7lL3AeZITAsE7hu9CrLauY1
         cSyETyKF46uzs7m3Q4TR4KqCYBeJAKT+18yTtrVpqn2OS2tuDrGBS6uoTR17D/iMpM5C
         N8hg==
X-Forwarded-Encrypted: i=1; AKwUvBwrHGzxOi9QOcSbhuyfgkwaToK8Xphx02nqQUD0Mg004REjP53WELbgQWnA0ZFPbxsKJHVRv20=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6BGxntsD7wD6A/kBJhw6rE9HJhq2Cw2HVPLYw45N9LDuKFR30
	yAVkj54jEOHIZ0m5tlJOGFdPU2Fuj5xfnTJ2puVgJWpsBGzoPz9YTy8lBlPjJtDGI8I=
X-Gm-Gg: AYBFou21bEghVgY0Zh/3sGwHOhspUXzuO+N783l8sSHySB43rangBtGQGumEzETH1b9
	YMxe45gNg395bFd4+bSg+o4JtXRa4fqQrGC5qTAvtH1XzCaInxj1ihzCsC3bQbX6zPglBIeLj6/
	DyrMWePskcy5gWxRuECdJdO96uP7R+PqfxzZaJeR7HAlhb89tQ9MCCm2RQOWTv5PMsYrawhW5IR
	IuSV0BW+noYSUMe901T9jaVoLfDZmZ1ZgHF83rCC0nrOcbK/19pG9OIrtmEK7U/sDin/UVOwEFb
	M8JLN3MDGMulEkAiU6MsTZ/NJP3RuTKsOq6IcZz4rrVkJLVuKKIwW1c7g9nlhWMiygSzTLUXTRc
	okPcc4o63Fo57dJAPmezSVrW4uJuGv0ZR3Q+3dO/RkEFlhbmsvjcSwstpZhxOC72jSLLaT7kZNU
	ISu/ywfD5FNelq9w8giIGvcjROb614e+RruTaGGqd7dR/5QW5gzUrDcQZzPRNIJElxwwfv0gZAw
	DB2LBYKJNgcedgIh5ASiToWiVbIIM+ZuP5rchUK/A7FiD08fUa7sk2IPTRfqQmOIeykZ5wL
X-Received: by 2002:a05:6000:2312:b0:48e:e98:8b64 with SMTP id ffacd0b85a97d-48e3eb8b45bmr11290896f8f.19.1793011272569;
        Mon, 26 Oct 2026 03:41:12 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:6bdb:f87:1da6:12eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm16869581f8f.18.2026.10.26.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:41:11 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	stable@vger.kernel.org,
	sh_def@163.com
Cc: sashal@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7.2.y] sched/fair: Avoid overflow in place_entity()
Date: Mon, 26 Oct 2026 11:41:09 +0100
Message-ID: <20261026104109.1357489-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
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

[ Upstream commit 2f93bcb3f9aaf6ceee1aec0a97d4fe386d48e781 ]

place_entity() inflates an entity's virtual lag with

    lag * (load + weight) / load

Commit 4823725d9d1d ("sched/fair: Increase weight bits for avg_vruntime")
replaced the scaled-down weights used in this calculation with
avg_vruntime_weight(), removing the arithmetic headroom provided by
scale_load_down().

The multiplication can overflow s64 before the division even when the
final quotient is representable. A task's hierarchical effective weight
can be as small as 2 after avg_vruntime_weight() scaling under group
scheduling, while entity_lag() bounds |vlag| by

    calc_delta_fair(cfs_rq_max_slice(cfs_rq) + TICK_NSEC, se)

For example, with HZ=1000, NICE_0_LOAD=1048576, and the minimum scaled
hierarchical weight scale_load(2)=2048, this bound is 891289600. With 114
maximum-weight entities, the runqueue load is 10361604096. The
intermediate product is:

    891289600 * (10361604096 + 2)
        = 9235189971864780800
        > S64_MAX

The signed overflow corrupts the entity's placement.

Rewrite

    lag * (load + weight) / load

as

    lag + lag * weight / load

The two expressions are equivalent, but the latter avoids multiplying the
virtual lag by the total runqueue weight. entity_lag() bounds vlag against
the entity's effective weight, so the remaining lag * weight product stays
bounded. rescale_entity() preserves this scale across h_load changes and
already relies on the same product when rescaling vlag.

Keep the original zero-load warning semantics by multiplying lag by weight
after replacing the divisor with one.

Fixes: 4823725d9d1d ("sched/fair: Increase weight bits for avg_vruntime")
Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260928124754.1692077-1-sh_def@163.com
[ Backport to v7.2 which doesn't have flat hierarchy ]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
---
 kernel/sched/fair.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b6cace1d0e32..9e1a28a158da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6250,12 +6250,20 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		load = cfs_rq->sum_weight;
 		if (curr && curr->on_rq)
 			load += avg_vruntime_weight(cfs_rq, curr->load.weight);
-
-		weight = avg_vruntime_weight(cfs_rq, se->load.weight);
-		lag *= load + weight;
 		if (WARN_ON_ONCE(!load))
 			load = 1;
-		lag = div64_long(lag, load);
+
+		weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+
+		/*
+		 * Rewrite, because the product (W + w_i)*vl'_i might
+		 * overflow s64:
+		 *
+		 *   vl_i = (W + w_i)*vl'_i / W
+		 *        = (W*vl'_i + w_i*vl'_i) / W
+		 *        = vl'_i + w_i*vl'_i/W
+		 */
+		lag += div64_long(lag * weight, load);
 
 		/*
 		 * A heavy entity (relative to the tree) will pull the
-- 
2.53.0

