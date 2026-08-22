Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A831367B61
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428537; cv=none; b=Oo/XzrXdt7sNtAPDx/NS8V27nviXZGX+5UphWCzBimfjZjkp1JoDdvPMZ41smOh8K4YSSgJ559oj2+aJYiIed1d1QX3uqFhHyhkCEFurGPU4K6Khipn41LOQ5EMvcY6ER9iwRt4GEXk5CZvG209aR29NgudlpPSweyFlyaAHELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428537; c=relaxed/simple;
	bh=p+iuf3goQGfdg3eS+bSvkUUzL+pJBXz0TDWhbuggpSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwWTkEr67nNNmSMnh/O3YouFTwwBAkyoCT3ybypdSgAAeFnakaaNJhl0n+6/PHFYFmXIVJYqf3drZXzK+FvQLOOx3XiVHFoZtgfdqWgrn2UvfCdu3uFa6Bz+cTVDb5GJ6VC7YXk0MgCxsLYD3+fH7IdUGqEyZc8NZb9KMLUytDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FzaIf4oY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FzaIf4oY"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930c0f9c1b1so118626685a.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428535; x=1788033335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUREPyeQYoMY/Ohx9nG5ofB1l7i1YkW1VcVay50y8NI=;
        b=FzaIf4oY14yiJqPH3y5EeHKMR+rHQ4yw932o6V5MOX6PPpdjswaWsWo7sKjt79rq4b
         kqnjpBzslB7BA4Q4SaDf1xZ6gvymHKeeyHStOxKq/KWefvz+vtVXddEXv72ZfbQZjrUA
         buibJQZ5Jp2BizOByUkJ5ChnLvn/zafZW2CjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428535; x=1788033335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUREPyeQYoMY/Ohx9nG5ofB1l7i1YkW1VcVay50y8NI=;
        b=AJrGFlLHrMFGaSILDmqBpNYh/67hscyskvtDxzD7uGML2mOxYZiuyN8U/62eqoYYui
         Uy9l61e462bZXW0wnkNbSY7xWpi0ImF+AxmV22iCXFHJC0ovb4hOd4BPvjlfsp/y6WTX
         H/M1lI7bhfIBEoFcS7yQrDovaMFZiCoa0A6s16YiHZvHrEVX6rFP+BxQuVsKzfstlvHO
         psG1xgUre+YWaW2wUZbsG62CYX28yfEJyeCLrCns/2x0IoAS4N+jtvTGiZKpGlTzGexS
         vnYAABDZNC4IbE3peBhI9hrG14XT/cGOj7Gnp6JFO4KxvVvx7Lfpt8os99zTdz29FWgf
         sW0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/3kpBbGtHxKkyWNKboAGA8OPMZovItbyPsN33Zx8gqtFL10+7DBmxk9XgZxCqW9wSO/UIMSM=@vger.kernel.org
X-Gm-Message-State: AFuF++mF/hS5iCCs6Qhcnb8espIwP82n5/1aq0S/DcZIOCaWn7kOHVff
	Haqq3U+Kti4O5OfUpQhUeVbOJfJ0/KYuInMv94r425NGuD3uZO1qHYqIOXECFOCSdQ==
X-Gm-Gg: AR+sD11Uwywdgovna0PqNHgs+UVlAf83t0xsxgju0taT3kbG7ftVMlHZAHJ1/9MXLYA
	ZNt2JEc2C9NcKV2bjMLPABQzm+PUOjNkyQwOSsr5VHQEqLTfHkrUGTi4wPmOVmLhuK2mujaW2G5
	y5ifkM62bqDdLtr4FF7CBKRFX7uA63O+Cqi2miS5biIy3mGgHZIL3KqgVBp6YpzuIesiC0tC0fk
	kYjqrdWoF9I0VNi/xK77KQTVpjD4T6915X2Q0AvepH6AjkQmL/sbju2W6mLt7JK9eqSfcm/+Uhf
	8RCjaMcr3yxXGNviAA0MzI780beqPJVQoMddYTzMQ2It2SV3rRUsiCy/vtzeSdt8/V5bCIjT2ph
	KjInZMrkgdXDjRCN2+SeGWdORRFNltRf3yKDa4CuRV0+rOGQ94RlnzE/XaBXBDp/5miw64RTBCQ
	9cMgLTJg5B85tvRlBMud6SBqFGI0zJRhHrTJfvUtsLdbzJJtEyhLF5
X-Received: by 2002:a05:620a:1b86:b0:933:9e3:b95d with SMTP id af79cd13be357-937396e774amr1502902685a.43.1787428535289;
        Sat, 22 Aug 2026 12:55:35 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:34 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	"Sachin D . Patil" <sdp.sachin@gmail.com>,
	"V. Saicharan" <vsaicharan1998@gmail.com>,
	Mohit Bhasi <mohitbhasi1998@gmail.com>,
	Leslie Monis <lesliemonis@gmail.com>,
	Gautam Ramakrishnan <gautamramk@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 4/6] net/sched: fq_pie: clamp default quantum to avoid signed overflow
Date: Sat, 22 Aug 2026 15:55:07 -0400
Message-Id: <20260822195509.112717-5-jhs@mojatatu.com>
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

fq_pie_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) without
clamping. A device with a huge MTU (e.g. dummy with max_mtu == 0
accepting MTU 2147483634) makes psched_mtu() return 0x80000000, which
overflows the signed flow->deficit to INT_MIN in fq_pie_qdisc_dequeue(),
causing an infinite loop and soft lockup. Emulate fq_pie_policy which
is already bounded to [1, 1 << 20]; clamp the default to [256, 1 << 20].
256 matches fq_codel's floor and is a sane minimum for a DRR quantum.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_pie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 069e1facd413..b27d95418707 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -427,7 +427,8 @@ static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
 	pie_params_init(&q->p_params);
 	sch->limit = 10 * 1024;
 	q->p_params.limit = sch->limit;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+			     256, 1 << 20);
 	q->sch = sch;
 	q->ecn_prob = 10;
 	q->flows_cnt = 1024;
-- 
2.43.0

