Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852464;
	b=skEFrOFlqXRMICzTqD57t09exd0epXFbeevokfffsGPIVxeTgQx2EfTbkpFUJmPGJOMW
	 wov5XyVE0IRGyUWClclN4wKx1xKduEm4BePex8lpR/3fd9Br/yshZ42p7jR8H+YOdz3Hj
	 2w7DjDvBuLAcIb4slVxGqmqXj7fGW/7SXPFhCFWYA4OsAjcYKIxptfgAsaMbnpzTfRcVA
	 cDV0Tby4QLQzmIoqgWKnsKuPjx9H8iPy769jYgV7GyoLDQnHYTu4xM7nWS+sgiGUx60Oy
	 45tjNHfTnDxf2JvaA5xvs0STNBWgiVJmnvrIL5m1uZpni+XXfGbphwYNSFQVXpJxamw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
	b=pKiHAgtyVvU4mnXU/RytPMEv9tcWTHXcG9xx29qBK3wSQ+vQ8+YkP1tmTNi3p/9qT7U2
	 KWzEFvojJjtb3nfLCwT+7mIRD/BuGKq9XZiQ3IEiIrNDbgQ8/n5+jh4dBJXLAtg2J0e0B
	 k841IUB49F63Vjt/738swbLYOZZq+1HBWZP2CdjQ1H8hOCDtdB7nh69x+yB4H4o7Fjmsb
	 MXaHMxhag+ZGzQb1RbzzHTmjQ+LL0ttZWb8RkdXvnqPpah9VJab5rhzt1kpBoVCVIGO2P
	 P8MDXaRmGlMtgkg7SKz8IOVSC1Y/zn0S69/qHE9ijqYMx+ke0UnIkCZaDstFsIX9KEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=szZkbo4h;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2222606A330
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2222606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=szZkbo4h
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917a707f37eso18561306d6.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852463; x=1793457263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
        b=szZkbo4huFdA0qAokSxTLHJGEW7WossaBqFooRqxKrUz063lzP4tURtZTkmy6OZWFY
         A5BgTN/VwtgFFrz3uJDrwJJVxIJ1lVYgRb2XMHAHoFlzeeb0W3NR0HzOcNVx10gO+EVd
         U0rsSFIFUi3wB0QnL5gOlSSgUgwEWi/0txoaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852463; x=1793457263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
        b=z527dU3+cf+ugc+3uJhg9y8DttKpSK7ZUqmWi0pL7TjfYINpwG/dExQyCRZXQb79MW
         nG4XJTCVU33CVmdR49bIRBflyx59WBkcPTvdEukp0nXdZiWb7WK7ZdN9N6Mgz00BVvR4
         6M0I+sB5O8xNsjsp5pYuU2vDjMrHWcLiHoXnHZO3D/MKYrR/DtWQgWPG2g1qDDAAYgkg
         c9ODK6E6mCLMBe496TLjehK73Bg33M4pYLwWD+hxXOOUC6+uttKL2TiFj+iv5lHgmJlC
         HAOQL4k8OpI/BJXapilT6mOmudpaw6bw5AmHnI25VOiJBrZEEYp6yUKdtNHD0YHFUlbf
         ZEmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx4aEB6BLmnxEHNpj+xmzgVEm0w6KWkWWzSAA0a1vn9LF+3fy+dd25tLn8NS1xytKs2f4RpoA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLrnYfyG9j90Jkj6pb6F40Aq+57GTU8ISyT/259evfK2c6nj/P
	D57nZiA/yiyP85nk87DmrYh9el8wbe25hB3AjS7Vumz93tfKjRqwH6IzcF9r4BOlDg==
X-Gm-Gg: AYBFou01avaK/R1c2+i7+fvu1tqBch1oa7AjMUKPFF/CFMqSGXldf9DS9DAm6oyR+oJ
	Wr6tq/D0reTGICR28X5oTXfpPvJrNV91PN/KUFkYH7ccmOQMpn+pJg1TsFK/NvSgCwMcAg9of/h
	X7Uxnwl3nkxkVrx/Fjzpjn3U07OvUBUTpK7Fzn94YNkuzQRSH7B35l/A2hLk283xgr5pViz25dQ
	N0dPDE/MMleTk+OLf1QsZx5TcnOtkmMIQLpCzwjebc11ZIKS7O1unMPPpL3BlPvgUk2DOG8eWzE
	Na6/jlUFZqoxKqiD3sxxdu+FM5j1i22HSYwlKiypHx1Bum+F/Z8hZ9QdyRqbWXB5Kb+ZxFDxI85
	PNAOgEStvM0AjBPNDz6gdnRUev/XNVHaQLGspVFPwzN0Q+ZxnX8SrmW5MdUxRyFfxqiXF+yoB8I
	VptuGWqp157F9oZo1DAqAqAQorT8YSNv6gy6ng9TjvRF0O8s3gnDk3RUC5VFsLoff/mlHkhiIOd
	1g4iXa0u0262JBJMMWqn6Te2mcdsWUNRsgNbHz5xK61B8S+22qwNB4gW/QzVG+VH63AdmCSGfTz
	zT7iJSSrdgzpgOtB7eHWXybi3m5Y6GIVLZ5yxfwiBA==
X-Received: by 2002:ad4:5c8d:0:b0:917:8d82:ad9c with SMTP id 6a1803df08f44-91c48e58627mr34094516d6.24.1792852462930;
        Sat, 24 Oct 2026 07:34:22 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: owen kwan <owen@verialabs.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop
Date: Sat, 24 Oct 2026 10:34:15 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com> <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
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

From: owen kwan <owen@verialabs.com>

The issue: teql_master_xmit() tests the slave's ndo_start_xmit() return
value against NETDEV_TX_OK alone. A slave that consumes the skb but
returns an error code (rc < NET_XMIT_MASK, e.g. NET_XMIT_DROP) is treated
as if the skb were still owned, so the loop restores skb->dev and calls
__skb_pull() on it. A VLAN slave returns the result of dev_queue_xmit()
from its ndo_start_xmit() (propagated since cbbef5e18307), and when the
lower qdisc drops the packet that value is NET_XMIT_DROP after the skb
has been freed, giving a use-after-free in teql_master_xmit().

The Fix: test for consumption with dev_xmit_complete(), which accepts
NETDEV_TX_OK and every rc < NET_XMIT_MASK, matching other callers that
need to distinguish consumed results from busy. Only NETDEV_TX_OK keeps
the packet counted in tx_packets/tx_bytes and advances the slave; a
consumed result that is neither a success nor NET_XMIT_CN ends the
attempt and is charged to tx_dropped, so lower-qdisc drops are no longer
reported as good transmits. NET_XMIT_CN is counted like success because
it can accompany acceptance of the current packet: pfifo_head_drop drops
the old head, enqueues the current skb and returns NET_XMIT_CN.

Conditions to recreate the bug:
With CONFIG_NET_SCH_TEQL,
CONFIG_VLAN_8021Q and CONFIG_DUMMY enabled, add lkrdummy0 (dummy) and
lkrvlan0 (VLAN id 37 on lkrdummy0); set a pfifo limit 0 root on lkrdummy0
and a teql0 root on lkrvlan0; bring teql0 up with an address and send one
UDP packet to it. The VLAN xmit returns NET_XMIT_DROP from the lower
qdisc while holding a freed skb.

Fixes: 572a9d7b6fc7 ("net: allow to propagate errors through ->ndo_hard_start_xmit()")
Link: https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/
Link: https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: owen kwan <owen@verialabs.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v1 -> v2 (feedback by Sashiko-gemini):
- Save the slave ndo_start_xmit() result once; use
  dev_xmit_complete() only to decide whether the skb was consumed.
- Count tx_packets/tx_bytes and advance the slave only for
  NETDEV_TX_OK; charge other consumed results to tx_dropped, so
  lower-qdisc drops are not reported as good transmits.  NET_XMIT_CN
  is counted like success: it can accompany acceptance of the current
  packet.
- Describe the counter behaviour in the commit message.
---
 net/sched/sch_teql.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index c7dcec25ef42..b60ab79a6572 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -347,12 +347,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
+				int rc = NETDEV_TX_BUSY;
 
 				skb->dev = slave;
-				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
-				    netdev_start_xmit(skb, slave, slave_txq, false) ==
-				    NETDEV_TX_OK) {
-					__netif_tx_unlock(slave_txq);
+				if (!netif_xmit_frozen_or_stopped(slave_txq))
+					rc = netdev_start_xmit(skb, slave, slave_txq, false);
+				__netif_tx_unlock(slave_txq);
+				if (dev_xmit_complete(rc)) {
+					if (rc != NETDEV_TX_OK && rc != NET_XMIT_CN) {
+						master->tx_dropped++;
+						rcu_read_unlock();
+						return NETDEV_TX_OK;
+					}
 					raw_spin_lock_irqsave(&master->slaves_lock, flags);
 					if (rcu_dereference_protected(master->slaves,
 								      lockdep_is_held(&master->slaves_lock)) == q)
@@ -366,7 +372,6 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 					rcu_read_unlock();
 					return NETDEV_TX_OK;
 				}
-				__netif_tx_unlock(slave_txq);
 			}
 			if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)))
 				busy = 1;
-- 
2.34.1

