Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316469;
	b=PZRjqI5UaWKnUNr//A+qS1MGbARahY0N4B/StF5aUC/mY8V5YkWcOcM7UMMINgb7j4lR
	 vvYaVxUS5wy1zO5yXLdoSvccco264jO4jZbOOEfMea3ISp6uBRZHSz1y6Bo+pur6Z9YOB
	 2Iz5XETiEbxnv5LqBFnN9PjEgtU6ENgdtcl1XGXQd+WUQgvjJ/rDA5Kc/Mgd7PG1j4C7L
	 NjDqZ2PG3wEnAjrHXSDdSC9FwP4DdBaaE3LgjY93xhlP1PdBSAGH2yvbv7JnSALUSogZV
	 bkwHrlS1YT5tjUAdruZwbUP53sSovvNAUcI4fzmJa0fs/j4QI4uKUf9eP/6t7qkNfjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
	b=ndD7AXlIVOmpmqDpi/Lu2JesddyVj4wpuRuDnWMQZWaXLWr1qiL/ky5EXTvzkzpet3mW
	 dupak1EzeZz9rQnaOkwrv2o1M2FqWzJmpS7Hg7jTmmtnog+Xht1jwmr8lpwJ3jkrBaP0f
	 T66tzzkuus6ah/tompd3ofEwvAD4hJI7/FaOPJBs2You16dSfqdI2/JKAG21nT9r0ua7l
	 AZig1Vt7nNGcpU7iEQRv0BDnu2bRDE2+oRUKXWgXuBqUS8vucT11lmMFs3a25Al4XhRjq
	 oPJl2vaPk6ONGdv+BiaBKAbIITZrHxaJmRSQEMHtAUtSQHSTW13800/oBOfM4yf+BfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=zP79A2BY;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D1606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 23:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5D1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=zP79A2BY
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c895a0eso5376385a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793316468; x=1793921268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=zP79A2BYQxt43e0Mt2tUUbvkfLwmvNCoWjf2DYm+QaWHhzwqx+lljFgGZIMhh0rQU0
         EFhcZkiRWpwEj1IEFoXs6t0puXkEDNHUldaXOW3V2P1R2obGGKe8qtq8edadqPVn0PFX
         xBKJZZsgdeLzcPL5+kDojNbXqto2l+lMNmPGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316468; x=1793921268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tcw4NzrOgqE+x7t21T1n7e3eg9qgEAOu7RVJe3lTDxQ=;
        b=I0iMMxRMVxgRm0XbqYIXNa+/y+WMbDnRCyXXiaS15XHXzU1y47m3+RP/ejmrDPFdO+
         gH+680snJISpNkhrhWKWQf3sk4de4upkZCgLo31qmlBAUo4Ns08zYxGenbdA/gMOkSiQ
         WgeMCIsm4FHm9o4JHkdKVW2cGoA6bELiyP/ruNSk/1h8M3RrpU6euPzcmpQSZzRPE0CX
         2Aeznyrl/t4l2nj7ix0TAbfn3YMmv5SUrYIqnQCSF0xFv1LwEVPXUcGloohLlbYlaSw9
         7IlnwGRSY5yo9svRBDnGk1Hy9bHsF4K3LuTXukihLv2XMnsM958Cx1ClzffYbiPFxABW
         Iu/w==
X-Forwarded-Encrypted: i=1; AKwUvByGeMgL/On7QQCBoEXOM10b2Ol1p3O7PSc4GE5MIXlps77IpHZqscMxiSLDpFpAoDFwzwskqJo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPJqrhxw9jSplwxaowcjhCVQflGKdTB+FgwxpAay/iX2YKw9Jg
	u1E99WGA7Sih06qkk/CNVkL5LOzTtclb4LSG9K9RSye/Um1Yc5000hKGZcx6gIeeRw==
X-Gm-Gg: AYBFou19m1hDW+S7qSZ87xuQ/RxnWJrDL+hHxt1X2T/d3nK7xDSYFDIaMUuj8qnIb2X
	/l8sb9ZWJNA7Q7HotvjXXf8Sm57ivrTvp+g2i7VRa/Nur1F+W+htWtGuO578teRWtlLwfhP8u3g
	ZP1wVh7tR9Z56uB6byAN5Hm70t8Qq2TyupG1NWY56fSHmc/AllZL23H85tu5p/5Gh4IaFHHcFt8
	g2LxuW9ve+8E0LTCw5rbeoNNCwbHYNwzEmY4tABYvKmV0uRmswyyfFRMV+d1f/0tcb/WY53mZP7
	hITr1rqK+ySilTJsaNyc03wpsbsnKRgWUwrKe/B6LMqMn89ELRIOfiWjRVt8VozJy7SxA2dhfCA
	CxgNVTJhb7JijUVlSMvomdQiPZd2Ruecc0W9DR3Zima48gX1z+4wd90IIuPlkXau7HVnvQ0gIXg
	ymtZwOUWnV5Kdo8Jb7uYZNm/rbqKi9B7HAR+TqTZCsLN0BQ5lTXmroEfZ/8uY8NYTpNfYfuOO1s
	jWInY10ZeDk51kxoSZ6GG0pLPB3jqyZJrMnStb1v44RZ5cf+oq9wvVzVwDjpol50AXikddLmH+3
	hF6+1S55PRO9TLGMxE1kFCnm/LS7+kv6DW7c09Iy7g18LedtVuOCZJGXPJI/ZmUdDvW0n10rhNc
	c0mvDPnzkylmkRwI/+hNR
X-Received: by 2002:a05:620a:372c:b0:93b:d79a:c45f with SMTP id af79cd13be357-944216cfea2mr131022985a.55.1793316468408;
        Thu, 29 Oct 2026 16:27:48 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94424243823sm5384385a.21.2026.10.29.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:27:47 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net 3/3] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Thu, 29 Oct 2026 19:27:39 -0400
Message-Id: <SER-NSBD.v1.r0.20261029191634-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-1@mojatatu.com> <SER-NSBD.v1.r0.20261029191634-2@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The issue:
The teql master devices are created once in the initial network
namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
teql_master embedded in the registered sch->ops and uses it without
checking whether the new qdisc's device lives in the same network
namespace as the master. A qdisc created in another netns can therefore
attach to the init-net master and change its MTU and flags.

The Fix:
Reject a teql qdisc whose device is not in the master's network
namespace with -EOPNOTSUPP and an extack message; same-netns teql still
works.

Initialize the private skb queue before any validation so every
constructor failure path, including qdisc_create_dflt(), which resets the
qdisc before destroying it, sees an initialized empty queue.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_DUMMY=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
As an unprivileged UID, unshare a user and network namespace, create a
dummy device, set its MTU to 60000, and add a root teql0 qdisc:

  unshare -Urn
  ip link add dummy0 type dummy
  ip link set dummy0 mtu 60000
  tc qdisc add dev dummy0 root teql0

The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
on the same device leaves the MTU unchanged, and a direct MTU change on
init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
privilege is required. With the fix the attach fails with
"Operation not supported" and the init-net MTU stays 1500.

Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace aware")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..55f9944ca47d 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -188,12 +188,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct teql_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *first;
 
+	skb_queue_head_init(&q->q);
+
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
 
 	if (m->dev == dev)
 		return -ELOOP;
 
+	if (dev_net(dev) != dev_net(m->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
+		return -EOPNOTSUPP;
+	}
+
 	if (sch->parent != TC_H_ROOT) {
 		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
 		return -EOPNOTSUPP;
@@ -201,8 +208,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->m = m;
 
-	skb_queue_head_init(&q->q);
-
 	spin_lock_bh(&m->slaves_lock);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
-- 
2.34.1

