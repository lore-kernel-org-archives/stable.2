Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EB391E57
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298794; cv=none; b=Ayry2ccOYn7EM1Hh7UZC/xmdE4U+Z9VGd2RqoQJtMN+3b3bcAkCB9Ml+SKIUnn6LgAxHChtz07/3MdJilnLap2VZ0svc2zMz9BkJhtaQiaznYkEZYGtdW5I5aMJyWg4o3r8n6PJXAZr1ocC65LPNAFjTUm4Us0YA7kKBOudVdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298794; c=relaxed/simple;
	bh=nsyS1KF/Yx0efGlf5bGWpUB8R3X5l3PTrQ+Vv5oCp6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkWKI3zy2dE6e3xTIPi9Fdbe4UaivWLm6h0+ucqRTON8dOH2nseIgdOXzqdu9d4OZpn2jSjqLXPNANKMnZz2D8RD8KeqTXEcjvuiXGaVt4Fp6/FYpHQd5G0kTg89tvAvC2fdMtSVTme609sbeLeZksxbM07fFb0MtCh+hGV6k+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JcZndjuN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JcZndjuN"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90e7c71f86eso2766186d6.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298792; x=1788903592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGuYJDHW5gzTbgrufbU1+/mKrx+hmR/Us1xsgN+1wt4=;
        b=JcZndjuNCJkWTFpunwHLlApLqJmf1J8QTXN6i/njvHRYpFZyuDcNgzjW4U2dVMWktl
         hvayOzuczbd/xeDtK7lRpZWtyjHfK/MoP1cKbbf9Acd1a4F6fcurCataTY2waygAz50S
         CkbvKrciUMjpiFo3aE+AHSkY2LDDrE29T7Lmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298792; x=1788903592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGuYJDHW5gzTbgrufbU1+/mKrx+hmR/Us1xsgN+1wt4=;
        b=oSMf81OfGc+tL8fBH7FW2LbUcbQ1TVG4O8HAaAdWDITRi4uYnjmJ78blLAye5ydE+e
         v7xH8GgVBIBqQ1Newzhgk7iFiqwdd2cKPfOHV5HeNWLMbjZjppri7LCExzFlalqDkXsG
         gC4sCzyAI9N+Heyoo37T35B0rwpls4YpzfCwoT0WDHwhcslyoZ7u0JfgqS2AuVi3hvwx
         tNUvo8UaVWQbbFTsT2zAEYdJ22CChvGRPlcQV1BrrExGkDhhsI9s9xEUkxJXr/a+72zq
         kow0iFaZN6ElIOlBKnbKNXicx00T/A+O6iNE9zVMQ6vbT0Cf74EX7yvH+oUmyxnB3DVT
         dqNA==
X-Forwarded-Encrypted: i=1; AKwUvByDLX7AI13TNPCQKsDhEpB3qPrKHBNPOPfcfo5M6tbINxyyXUxokdgBDr6t1OjkLZdLNcripII=@vger.kernel.org
X-Gm-Message-State: AFuF++kBsxOd3QaIFvIK5aQ7QLChwY6/hPMWdIzd7tMpBqrhIAgHs1At
	hBthwgXKm9t6T3VKSZvxwoouxD9hvxqO0qEbeYbBh8KoGx728M+YMeDiM3jy/MBL5w==
X-Gm-Gg: AYBFou2t/3XAzj27/bZ/Bf9suB/VwmNxrzxpwmVlwEzYk9xFN0j5LrJHK31FWD01ShU
	6i7SXKtxFc1wkLICnZGBflvcxaCemXGai6xMVXtoI56lW3/1VafcobiiD2iIpGiF4kAxgcxbtMu
	zQCEhBJKmJizUfMyKRL3/SfIGHlpSR/wUJloxbM/ykFXycdfK6vrhURTd3EKSjz4fLL+vy8GsA3
	YSnFexJcu49A1iqStlaJWP6w4rp5BgjG4d++04X1DcAW19EAgxPSNYevNopmH0ZxpkmPTVDtiXu
	k6xL/LEap+zsdJlZQX3g5dbZ27qalk7UlxLjQR7emmTSd4YE7m5ugyDOvBT1DMAu0QhDzBJoGZf
	2c/uF7aTh9vELOBV9JqR4Gm2M8aBdmjw8urmJsHpo2GTGbM6yUmg7uAzWyyvPmpktnoR5iYkDue
	Xfy7XRs7I30GwNi31Djcx2yPFs4Lzrv95/SjfdiWC8CVQi3X2Syux6tra5zJrbH7VDFsoYS+f95
	v+UK7+8tXn95bYkSFV04ZBMO1yluvGqS6h/eg==
X-Received: by 2002:a05:6214:21c8:b0:90e:996d:b6c3 with SMTP id 6a1803df08f44-90e9f24be39mr8398246d6.11.1788298791895;
        Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:51 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 4/9] net/sched: hhf: clamp quantum in change and init paths
Date: Tue,  1 Sep 2026 17:39:25 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.5>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hhf_change() accepts any quantum from userspace, including 1. With a
crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1 makes
the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) in hhf_change() matching fq_codel_change(). Clamp
hhf_init() to [256, 1<<20] matching the siblings, and remove the old
fallback that only set quantum=256 on overflow.

Conditions to recreate the bug:
  CONFIG_NET_SCH_HHF=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root hhf
  tc qdisc change dev dummy0 root hhf quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96acab6a8da0..fc72f825fbd9 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	if (tb[TCA_HHF_QUANTUM])
-		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
+		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));
 
 	if (tb[TCA_HHF_NON_HH_WEIGHT])
 		new_hhf_non_hh_weight = nla_get_u32(tb[TCA_HHF_NON_HH_WEIGHT]);
@@ -613,7 +613,7 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	int i;
 
 	sch->limit = 1000;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 	INIT_LIST_HEAD(&q->new_buckets);
 	INIT_LIST_HEAD(&q->old_buckets);
@@ -624,10 +624,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
-	if ((int)q->quantum <= 0 ||
-	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
-		q->quantum = 256;
-
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
-- 
2.43.0

