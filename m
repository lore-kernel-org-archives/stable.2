Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57B38F930
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991176; cv=none; b=TuzKQfyjLRbjf1RdgIIUWnpZRtN0NgNXS936QrCD45tvNXyhmrAOG6+8/AFYaz9vDU6cR+nJB9GBgS9enMyH48ZMBJvCGzXn+goWe6rzRiDQA55n7lVUwiMZEeJ+Ugt9NyuLzJbG7RUt417YD5uPdWC2JKLhgsHd6e5gZrc8kbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991176; c=relaxed/simple;
	bh=8uDIkkzVKcJJcGm8vz8sajeR8G60JBz5XXY98NmCRk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrJm+AyPFIkfY1Kxoi44grjLWauMPhd0yuEGIwAdGdu28C/HuByrb0+GWMxLwn63AD4pauaoFtOYVd57McdvdYps90BjBjzaHp9ptMaQv895jqZovdm7qLvUDcxiU/gUiAc32vbYK56asGgsJ/zX2gptb/782lBSY+FAFJouNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=puVYzYMi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="puVYzYMi"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936cda0e3fbso175255085a.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991174; x=1788595974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7oz77OMrkgFB1w0C3emSz4sp5+lLJW/M03ziQF+FrN8=;
        b=puVYzYMivFjUN+1ZUoWwZl0dtlx5Z2Gus3isnKs/6PuRrVJ8rsr4nmTzY6W657TZuw
         GRhNYra+JfU40nfa1rPJahBE1n51Q9HJ+r9AqINyBi6rwGIoXjgytdloxdU3/89EBctK
         NBWb3/WUJ7bDX1W8R1p/EKCJpPyoU8uHHcNs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991174; x=1788595974;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oz77OMrkgFB1w0C3emSz4sp5+lLJW/M03ziQF+FrN8=;
        b=JCGzhySoTZEl4yaGGM1t3/CsRsTZcBIgpnzW6dvTqNO8TXB/+NYxUkiYrUSMhjAZli
         /LF+OckpmpAue2bxx71BAbE5Xxbu/utXUjOL5DYj55V9zZmiQZp7EadKN2T2GNII2u7H
         hm7cNmVc1Un/LgxmneSxtuKJJNH3kKRPkvNBzSOMdzt7enpC7BafqeNdDaX1+dPiAff4
         NjJgQ7cY33y/IOD0RKAxUYztTsAUJWsQ1f5ceoKUa2u6wHjsSz6phAcAUxQl9sjBn0LC
         KOlKax5DC4YoL6mERyrSsXEiUGgc2WmSICzVl7DJUxSsv60BLTXRnbh10OCqlg5pS2Rs
         ETag==
X-Forwarded-Encrypted: i=1; AHgh+Rrk6XIvZaS0yx7xi2Zmgf1gyajy9g44N4c9PsywR9jzs6Hqn4Si+Y+uX/Q38OoeZ0PG5MJjiBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mFp6cetTFQSrIbH2ACaM9BvB4mtsslC6B+f3Fub2Yf0Hl5jzAo
	xyuSExZGr3A5GOkjhNZYt5wWOj5p2VqqwBxa8mqqqUQz8UA34es2f21bihWOUHSIFg==
X-Gm-Gg: AR+sD11nXSOAOjvbD5jVTgasR+Rnfeo7gOyve0aFHClKW9gTyc6mfI3WNBwqD2xr7Be
	J/+/hFj/WctxC1n3IMg1LCsSNk1qYLy5VZ8qhdbYS9pYVCsUkLlDZuXGv3ZlK2bjxMSjbOkQfio
	vkRHp0efk7G3S5BvKz8NqiN1wGOHM7h9I4mjbpluHr5hJtBXzt7FkKe1sJdf64IYmCcoxwYQHrH
	7DLJcGdjeEpzuqz33foQarDVnwP+A66Zsd7zwBlT3hSQgNKmD9P9EZPe398mlOPhGMxmkOL1+Po
	yQ4ZpXaCqBV3ePrznOtAMRAyqbq0ZLjrWYpe/2FpWEWlgDGGZQpGpHtpvRvDw4BVtw2dYgtVgxO
	2O0W+bCY4+/HZcHbRURd+HXHjWAYC40WWxTaMIk+N+LvvOUdBtaZiYdOtslbsUalI/i3WWmKzst
	EjwBx1ragnfxSpnUWHqZGgwqhap4L2yKvoY9AyHSsPexaneNQf/Hcv15tWzXg7Vl11EWJbdpNhC
	YsP2fyLJpiI+rcx/2aQUrrbflSbG41Uq31xfmeIC/GKa2VBFIvJyRI4BHlltXLXTmcBQZRl2QrN
	/+LDUOJ8Tgh55RFpUO1Xjj0xZHhws+c2SHSwWw==
X-Received: by 2002:a05:620a:880f:b0:92e:bd39:9993 with SMTP id af79cd13be357-93913952c79mr1475368585a.31.1787991169629;
        Sat, 29 Aug 2026 01:12:49 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:48 -0700 (PDT)
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
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 4/8] net/sched: hhf: clamp quantum in change and init paths
Date: Sat, 29 Aug 2026 04:12:25 -0400
Message-Id: <20260829081229.81708-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
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
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
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

