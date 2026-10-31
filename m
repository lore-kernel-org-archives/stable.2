Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477911;
	b=GnMggmKgp64A0dYenfofReAteP842XEZnkJheKW/zGDbo2pCs6pMI3/4BjymrYm7PyE9
	 aw2xCuXE0a9M4B1mGTX9pKPP5Rctyah4/xhpLn4n9mUKlbrVdfmm1IbLdQ57sSQT30qZC
	 UJOvWTRxRsz/gGRzKjIJhy0FS310h0GrFOhJNnMs/wwomcGoyRmF7zlQjnqsCiPHz6dTw
	 siQ1tJSkHE3PCeAo4pRLfja+HAFIie8oZkQt7ntsNmPg48MxHZ2EeiCR96ni3MA3p3LwC
	 /2JxwXimtMhEHCfBsPZhN9eZumhtUvbNcLVAoSWbCTefe5x9Vh4b3PnI0UpvX5TyVgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
	b=4uaFR7FpQQRY8GxQ5hsHSL8NG+7miQoHILbT8LmNL56ia38ajH4bdGhZz1C97PbasX7J
	 rtgEf0le+5Aa/zIbXHR8op17BvhqWKkYJHYESrg2HnLHIo4FqRFkLWnBRTiQVtfi08d6E
	 c14rUkX9Wplin1UrUwcbjBR0mGhYbC6GJ3PC7MrDg/b52FAdbBYE6n2FqrDMV9pgFtEnU
	 ttach1DHTONIpSZOqItwPUKCA00MSzRDgvDHwTeYGtUGeOw9okgq+cgYxyrCUVML/ofNK
	 lc8HrlIiGIpwsjt+DcnBXqTtsUY+K5dCk1DMRbF+jZt0iCF1fKpVxh1sdY9huPi+CDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="CSW/oTos";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684E606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2684E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CSW/oTos
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c79f306e9so21510796d6.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477910; x=1794082710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
        b=CSW/oTosbHHKk97aJNAmCwOBy46OHvfIHs+LRYjW6TQPx7ZLdruWgSTKuZUulrGi0C
         eZpR4tgHwAxcvcDmzuDGwdFFfUIexzPsvWPjj6OcxGKljaRGEWV9SrvKU5pVKjazt2vD
         mQU6XJqyvQhi/ihKsdonp0+/2yBPOnqw/rvIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477910; x=1794082710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGKJiamAitTKQtqe2g22VNzvYmBlctd6oSPWEhMy8xg=;
        b=warIcjAAzxwnxd+rjh5t1QPtbgIHYAi9f8BY1mGup08fRp01ZCKvhkZbHPItsGWQUn
         QjDcOa+XbqOEXEKOggUf/H7ZSqLdLzQtVVlNq/rcJTN6dxVvzvxvNBDfPlILrd/yMkiz
         TGa1NG2as/EyuKjT3OoUwZekD8ou/sBYfscs5mhP8qx1fA4MhGbr+AyNzKF6gfcyRmjE
         8hEuoQG1sdVUDpyQSavF7djMBSBtq86PcsKuJ7FSQjFlvykU2BdWcCkB5UrfVSNfgc5g
         DlaHgDcjqi5fAMTlSj6huk23M6UdMaWJSo8Dj8s9965MYUWcCjpltv1mqLzieC6UjX5K
         FC9A==
X-Forwarded-Encrypted: i=1; AKwUvByKnY7w2mVOkMqG0l1OVzhj5zvsQG20n+MIwvTGZMOsYT3b1QbedStCNOjXkfG/SDTJC6xJ+14=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnF7PsV90k/ZWx5jPM+KWHkdUhxxLCDqehhFUl/1jXGnLuIusy
	uOEvRcByMt0eFsmmiPDESznx4wkaGaaoUpuj5PP4GPBlgXflW4WAytlB96/leoPGkg==
X-Gm-Gg: AYBFou3Wgd4phu84lYX7Wj+x2t6wngsi2UYsfMn6y9C0kxC0HukDYYwwSibhgYZ/3Yp
	NzXExmc4lMh4+YMp5lZJQwofhJz0LONfk4uhRnnsAMD2WIt0N+wkArhLWm3aK9xyQUbFYyTvvfy
	c1ncmakmOxP1//yeFzPfWFehv6+zaefxKyzAw/jE6HfhQMu+Sok/AQuC8e9FUYoofGMoPsMPGaV
	yIbumQun05dgpXWesCJK7jM+XmpI04hnSusCkqO3SA5r6voa4YCQ5xZMilEM5IJqlnM9nnQHzVJ
	ropne+2ckqWgmVmj8Ii4jufiWCAn3spe7pTF9jAaTik5juGmViaSw5RxrsO9iRtjfPZyftRZWsB
	7efbJwRETgjkyXWwmC0DwY7in6K/hJ2l3mJiWBmm8mPuBYlgO62oU1KxvdVFhbCgOPtf60Kt+cG
	GZmmZzKEW/wN8cqaUwj9Q+4DSNYx2WDCqmNO3mjy0u+fHRcvfXd839KC4f2OHK1JNBSRdqQ7B1d
	b8rV+aLYaUTezwEfkTflV+hpKx54D7/xwHNULeAdVixxzAztfdt4u6HFGjwrQPNSa8wSJHasPV1
	IVElNrEsShcwSTfBS4nOJDQVkGzVjIzDZmAHREoezn031z02bUwMT5Hah4A5oEWkpQYR8pZn1Bj
	bfA1XHAYxt7vhFG8=
X-Received: by 2002:a05:6214:252a:b0:91b:9496:6a11 with SMTP id 6a1803df08f44-91ca4b1cb27mr102837326d6.29.1793477910007;
        Sat, 31 Oct 2026 13:18:30 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:29 -0700 (PDT)
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
Subject: [PATCH net 3/3 repost2] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Sat, 31 Oct 2026 16:18:20 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

repost1 -> repost2: rebased onto the current net tip.  8b2043279dae
("sch_teql: fix slaves_lock IRQ deadlock") rewrote teql_qdisc_init() to
take the raw spin lock with irqsave flags, so the hunk context changed
and the repost1 posting did not apply.  The fix is unchanged.
---
 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..c5f171a66060 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -200,12 +200,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *first;
 	unsigned long flags;
 
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
@@ -213,8 +220,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->m = m;
 
-	skb_queue_head_init(&q->q);
-
 	raw_spin_lock_irqsave(&m->slaves_lock, flags);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
-- 
2.43.0

