Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB16199E89
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786267026; cv=none; b=M4BnJyQolvAdJ2VvCxlX0zBNaL8PFP/zyeY+3MZl91yhYPcVt0e76tl18EpQ6wwFc7OkRHiL9fKA8hEK5WFyBjjgKzFWbQ8b2PqwFQ66YFtYZBk3G1bD0NkwFOB2rGQnGW/+NJ9No5X+4EigEMiHmxGXMszqD58BkfDUwrf/POI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786267026; c=relaxed/simple;
	bh=9doRA+1sWwyjLbVQ522xpNREC3rpQr6NfZSlNioXjik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TD9nq9b1NW3i/k4hhCSXGk58SnbOviEr5GDJhM3/ape2V/EV/D3Kx0WKKka+OrpzNTIHPCMUkfmtUrTepggXsprRO8YHTm8+Gkyl8H8GIUeJ9WucCr5kqobfnVMwir0YUnbNMMLJgcaF3zjznLE6dE+nfxryz42t6Tqqj7GlvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TccpCHBM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TccpCHBM"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eeb4508f29so5426816d6.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786267023; x=1786871823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Obn2pyh0n848Fa0t+qEhzbG3dNJa1Fltj/IPDQO7Zgs=;
        b=TccpCHBMSuhia4dUK4GYR9lN7DpAemoPH44cvCP5MTgwdDnUTrDPZOEi/zZQi/EL5N
         j6zl0jzQbk8faglhmGfewPCzi05XA5a32rfx/QXWMKxUYI8weQWTyBsON3rZZuKSCobK
         py8b76XwlXsijgr2JDOktDotlvMY7ZolhZ5gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786267023; x=1786871823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Obn2pyh0n848Fa0t+qEhzbG3dNJa1Fltj/IPDQO7Zgs=;
        b=DEdi5LsiLpOUOmv6518JqoTvkT6jPoZ4mXwmVXiB9uB/j2D+9XBJ/HAEZIyfBLWpNj
         zAFxr1pJDeqF96GUuxopDXaX5PQukidNTA7etOjj3crq4gYwwETvkED7FVP8vGDgPWdY
         t3Wjbj2uafDmfWSZSOBNnh7hy8mBO0bvn9c7KwjISjRDE1GvwJuab6OCl8aBEO3SFJ23
         nO5ruTikQdPkgccYVgJjvVefj9GWPQY7ip4DuBpXbu3bPAKLNK1ncFPOZwRTcjVXRgg4
         QJiAICdYSttT++rpeRqy/wsS+DqXF0OBncCl/OdASfJHSbrSvku5yPkkE1xKFtldiRh+
         Wukw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2XCKe7TTloot1/OADFFL1F3fnqyjjnKJCpWFo5UOdr3N/1NFPoKOvVW9wywF+QPs86CMEP/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEw0iKGsqvFNkeceB2KFNz/LVcWCXAnlzw2hdSzdX9WVTVpbf3
	N3y80YBsb/xfn2OsYTqJqNHksav+sY1rhn1ajq8FBaxo20BSPLd5BMXJgKZ/S1IbWQ==
X-Gm-Gg: AR+sD11mQNpUqcyyP4r2sthVnrlJfkSQOC3kw0zWWUSg4CsCkEnXlZcTmI0pNJk1Fnh
	TIhTDjwNfNgZ68q5WpwxseOZhGDIzs3Ov1DybtcTO8jF/svXp2nw7GFZn3eSCKUFyu2MypvEtOD
	V0X3DVYhWCZuRVdktD9EAKegGEorzR1mW48bcaWQ3Dg1Wjg7mWS5VaGzRBny8Tcs6EHc8vQy8bv
	UBMbF3n2wMKOPfj7lFmVrHysc+3HYRfkrs7b5O1HunXDb71/aEbluqnWJssiUmVM2p+0Yv4NbqC
	r7VpRK1dahi+BzxM7iCrAFrKlxX7OT38JUo2viBEX1J5eUnvmQ3X+erIrTSB8XfI89ZNLPW7ptJ
	BFoQj+rNojDhxhqv70GyPRUM4yU5gu8QnCEiTWLDqcCP9r5UbMYSEb+105YmERXSoqtwTdnjSxq
	61Rp4RYY1slVOQcpZVhToafqvsi4WMXwBeQnHavAEymUAwWhza5Gs3lE6LqbJQry/kOn8DIS+gi
	c1l+CANSwf3toTCZab0EvMci2Y/SBn9xawCxJ0b9RlPZtU=
X-Received: by 2002:a05:6214:3115:b0:907:c31d:dfad with SMTP id 6a1803df08f44-908811ae4b2mr425112586d6.9.1786267023033;
        Sun, 09 Aug 2026 02:17:03 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918db45sm46986446d6.4.2026.08.09.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:17:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	David Ward <david.ward@ll.mit.edu>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
Date: Sun,  9 Aug 2026 05:16:57 -0400
Message-Id: <20260809091657.879929-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gred_enqueue() admits a packet when the current backlog plus the packet
length fits within the queue limit:

  sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit   (default VQ)
  gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit (configured VQ)

sch->qstats.backlog and q->backlog are u32, and qdisc_pkt_len() returns
unsigned int, so both sums are computed in 32 bits and wrap at 2^32.
Once the true backlog exceeds 4 GiB the wrapped sum becomes small and
admission keeps succeeding, so the queue grows without bound and the
kernel can be driven to OOM.

Promote the sums to u64 so admission stops once the true backlog exceeds
the limit.  The limit is u32, so the bounded queue stays below 2^32 and
the stored u32 backlog never wraps.

Fixes: a3eb95f891d6 ("net_sched: gred: add TCA_GRED_LIMIT attribute")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_gred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index fcc1a4c03636..f04f425c6c44 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -179,7 +179,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 * if no default DP has been configured. This
 			 * allows for DP flows to be left untouched.
 			 */
-			if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
+			if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
 					sch->limit))
 				return qdisc_enqueue_tail(skb, sch);
 			else
@@ -244,7 +244,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 	}
 
-	if (gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
+	if ((u64)gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
 		q->backlog += qdisc_pkt_len(skb);
 		return qdisc_enqueue_tail(skb, sch);
 	}
-- 
2.34.1

