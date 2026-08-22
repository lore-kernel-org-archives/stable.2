Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79613367B73
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428530; cv=none; b=kTXCIzNfum70SBsIgkrSxNnao+6ZZrXJChQ/Ob53k05rflay2lVAFMz9VTbKabvnCMYkNbwuqrgftvEOB2c/owH+pLpQVVKF7l4SSQ9YRrv9SSVzER92zDACra9TuaRe3TTIqelbDyFzlF9eTzL7LTVLHpLNkkJa8v6t38OOwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428530; c=relaxed/simple;
	bh=Ork20gjEQOn288yqxNrf6dVpwI5OlsU02o9Ttam94bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2z6x8K79X5iYulqcZYRwRvnkqLVaZheSgeNb7tf8X9Jg4z3znHCKsUbq10lCnoJG90j+9d6YDoEp5lqCXYLz/G3ohkJqiDVDeiXywkq2myt4j87KfnjwWyThVMVk5oKcGuN/feUCKi1ViggLEhFLYLIhgnujxC3UlkZgu/gSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eApwlkUU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eApwlkUU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e55b62640so101029885a.0
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428527; x=1788033327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDlmITuUrdcrFWmFMMERDH8nQErt5aUJfnzyC9EWVzU=;
        b=eApwlkUU9vBGySmfLEXRSXV0oM1Q51i9hyVtDUgUT5Q2aYfM2OjYPyXaalel2ERVKp
         bpnJ8fMCqJTZZcAHSCdT+HsiCQa0EG/rmF7gC4QwI8L41GuB3lMvpqkxHISEe3zNNC35
         f4nOfocOOfC6jXKo9DD71ucLm2dJa4014gnjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428527; x=1788033327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDlmITuUrdcrFWmFMMERDH8nQErt5aUJfnzyC9EWVzU=;
        b=PSko9EY1k3D1p+tsO37u9F+PiliPlzkyKUyE3OTPU6JDF0RvEHlNuGYCAWwX971dLW
         rWgraNM60XIH3kKf+d8xOzSOVIP94lJiaNcVksNgUsAqHQxTnzL0n/z+GPB7e0fZLbDE
         H7h0VELMVx3CJ244IlypqV8FSeZhVj8MJ9Y7KXsUwrOGvjNZ0KOZ3kdXbN0L74Se5yHV
         6fQv9sssaeewJjEV5Ik473USVrA8EayOy9OezT31x9mu9Ze60onZZxh6h0NykQA924vv
         6RHKSZ4AzeHtD76EqncqMkm9BYHIAkIhuihkWFLJBYjYALS/LEhAxLqiM0LQsJYScTzC
         0R9A==
X-Forwarded-Encrypted: i=1; AHgh+RoriMHgJ9NkCRwns9G+TVCEWXwdu2prOrVR+dGFXIgzk5B+FCGMfJ2M2J392yGzQXr2HDXaEo0=@vger.kernel.org
X-Gm-Message-State: AFuF++lAtlnoGFUrhcWb538qyNQaabsYWNRSXiF2iKFY5NQnej4W8DHi
	YiSzC83kPQtBtS4XnH6KZlQRxIEoEo3Cs2WnfPGnx2CxErH5V9/MzR5LYeRMm722Jg==
X-Gm-Gg: AR+sD12Vu4YVWw3Nq4nZWtiJwN+wQaZ5p5kFpRqeOESew1u+tyRZwcSrRImS2PhWgru
	quqoZW0t0eyREMNODvihPLr4PNYqEDO0ArxClpI18Qmt8mzKj+WxFAenvc10/HKGjlN+O9T0KYV
	vp/Y/ZLvpv+4fFAMTfSwEqY4wqflryNdk1cplKTE7hwdwxAOTwYYDJVAHQVRcX4K1OwygLySds7
	hefD75ZXE3nm+tVdxGoE2kEtWA9qd+Is1MEbgcWf9UK28415o+PILCgxdWt4CvqqflhLbk5CjVw
	/uvPrBHQ7o+i/2cN0Yzlt3HuX7jU1+SZhyERO/bIt8YZfti/fUqeM2TjluV6ICIVmfvg/DzHeFR
	LOvVchPdZXKMa0TSBWe6I5S9HR6/FxVzU08l20YRFG1IcI2DhX8Rros2C0Jpz6lNtkyupgQLFFy
	w9dSlfBjgGgjRfMwzKBG+JqRlxY5eifaJmLOLy3HvZCX1lFhPUDbKo
X-Received: by 2002:a05:620a:4115:b0:92e:d7c7:7de9 with SMTP id af79cd13be357-937468531e3mr661718185a.8.1787428527395;
        Sat, 22 Aug 2026 12:55:27 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum and initial quantum
Date: Sat, 22 Aug 2026 15:55:04 -0400
Message-Id: <20260822195509.112717-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fq_init() computes quantum = 2 * psched_mtu() and initial_quantum = 10 *
psched_mtu() with no overflow check. A device with a huge MTU (e.g. dummy
with max_mtu == 0 accepting MTU 2147483634) makes psched_mtu() return
0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
arithmetic, so q->quantum == 0. Then in fq_dequeue() the credit-refill
loop adds 0 to f->credit (which stays <= 0) and goto begin loops
forever under the qdisc lock, creating a soft lockup.

Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
cannot wrap, then cap the result at 1 << 20, matching the bound already
enforced on TCA_FQ_QUANTUM in fq_change().

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
dummy device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..8a071c35b869 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 		   struct netlink_ext_ack *extack)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
+	u32 mtu;
 	int i, err;
 
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
-	q->quantum		= 2 * psched_mtu(qdisc_dev(sch));
-	q->initial_quantum	= 10 * psched_mtu(qdisc_dev(sch));
+	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+	q->quantum		= min_t(u32, 2 * mtu, 1 << 20);
+	q->initial_quantum	= min_t(u32, 10 * mtu, 1 << 20);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
 	q->time_next_delayed_flow = ~0ULL;
-- 
2.43.0

