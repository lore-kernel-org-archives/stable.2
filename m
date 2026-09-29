Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE84DE716
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677024; cv=none; b=jwBHmmRZ/0FEv1AEFd3okAQ8xGp2X0GaZjT9n5nNnzDFkxwIfVCe5ygiZEFHubnmDNZMZr3sOn3nVAUjckUy8S1QRNRS9o4U0J2crWJQHb8/tbWr8s6mHXAw36rWhYCXELjLrivJkJvdd8klLuUQvvlgIRl52Ji5AM+x5Kw4AwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677024; c=relaxed/simple;
	bh=a1Rg097Yr51bniGaH0SmdFyh32jryMA500quhl3/SlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDQDLRZCi+HYJsGtJum1/myS1SoQwtmX4WXMCte4LjC0cV4Xq43In39pu1H47UoQ4k9ufdtsQHmR/sx/2ZzwJcjpLmc59LQ4aOa8idJiG7d9P3mxyF45VBXPrEUkA8T5k6Q2VZTAy/QpLuGf9WyWuTrlWE+3lBcKxtGR2i3UniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=V7pC8aQR; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="V7pC8aQR"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5d3dc9b7f45so42023e0c.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790677012; x=1791281812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9hvZlReGddEztlJbTgolgZnvl5WN5QuKtMdmaNjRTU=;
        b=V7pC8aQR1GMfqtdS0vX6QisQVKiU8iO9bsKdPZ0Wm/C6Qsv7zJKFTODBmgDPUU8BzB
         zpVbAdDy9mQGNiLWEN+J3YYqqotEeG7H7ULuwjYNfzOxQQPVDrEgkxx537rwOhle8ldN
         NT6REfZQ3Jo/6oDf/m8Q1ki2BY0ieD6k3aIZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677012; x=1791281812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9hvZlReGddEztlJbTgolgZnvl5WN5QuKtMdmaNjRTU=;
        b=AwEGMw3kCrnla2+PIiR49i6yOwQ23LdWGJI+r6N4xNIGCMpH0BJURkF4PsjqpPcV1c
         4N+JrQIvWdYIOpSLdaJeddIN22IsjNsTW7OOh5RehZGn08Joo9CaaIUmG5xenGl3S1UL
         nt6rxEClwLI0Sz9EECdZJ3pGy8FrOEWaEGRE5jCVWzY99zXydALZ38NbYWmeLzupiY5Q
         QJrrzgrtDZ82Sopral5ta61delPww0h9/fiypFvTO1PqQWDD430tIWfcUSmTf6n+m6bP
         HkhXTWSMX6AsrqUM2KVYpzcZRFJoME4sk83SHvcJp3qj7rOf8rstPmJNFB14Hx5uooRJ
         ysAw==
X-Forwarded-Encrypted: i=1; AKwUvBw92u/8rC9rhHiq8pK9suSN8Prw/CC9a6vezTtuglikz/pgMGxW7M+K+/v/yLHWx8/2RkAStXY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuUxMHNga0YNHNOvmiOjf/t8RQbSWJnzfieAWpZCJ+Los1p5xk
	IHutILhzxtGXzA3oToa+lKV09Xb6oQfkEcyw8nkFNs2TenkXQ1coYLKzdCs8TRUTPRrWoVo0/Nf
	5UJiO5A==
X-Gm-Gg: AYBFou3Ymo2I+62Mw1inuMLh1D5Zof5CPKm75SI/FZIgEMgd2PErmA6qciS2zdstYXe
	ukaD6ODSWxWvbjOfHuROvaDo+mZi3ZYpJ4Dq3ddkB5wKX9uIa+KulVEBuHcOZZCZgz8KwIA5mMd
	yg5uSttuaV8DthOY5KjTFwxRARS/97/cqsI6OXzxfZr+6o5ohUikNabJN4O1tCayliiSs+jr4Q3
	FLy14baED6jZ43iHzSseGnXgtTYr6gEsK4QPRc4cGRxVANe6j2x5t4WjkEn1ss4yAzh3oouLnrB
	pTQwHoo53rhbm6NKbnOqwy5hdiFcYEXFCdx159fCwDEwKJmVpVQxBXPlirUQd+f92W/Q5bgohBk
	9LsiyTFvp6o7AynxuShhxx1P9oYvyYZnKCzGc1hWaJd5je22I7ZE2lmmZOxMfs9ISd/il+9Cqk2
	MEztLMtg++wHLfeziNsrsWWyIFx/zt+ta5rTK9UJSASpqaI4Ha3Kkn+tDkUulHbuUXlVp3H9eZR
	RZKbifb7cXQSmEnA3UEgZQEuAt4qDuW3T5zzNt9ccWj3/8Ylw==
X-Received: by 2002:a05:6102:869c:10b0:7af:7db1:8291 with SMTP id ada2fe7eead31-7af7db19351mr3104730137.5.1790677012425;
        Tue, 29 Sep 2026 03:16:52 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm13134189137.5.2026.09.29.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:16:50 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 29 Sep 2026 06:16:14 -0400
Message-Id: <QDISC-6HS9.v1.20260928064754@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path"), which restored skb->dev
to the master after each slave iteration but left the master-vs-slave
mismatch on the neighbour/ARP-queue path, and left the queued skb
naming the master rather than the device whose neighbour took it.

teql_master_xmit() sets skb->dev = slave only right before calling the
slave's ndo_start_xmit(). When the slave has no resolved neighbour,
teql_resolve() hands the skb to neigh_event_send(), which queues it on
the slave's neighbour arp_queue while skb->dev still points at the
teql* master. skb->dev takes no netdev reference, and the master is
freed unconditionally on teql_exit() while the slave is still alive, so
a queued skb that runs the ARP retransmit path can dereference a freed
device.

Move the assignment to before teql_resolve(), so a skb parked on the
slave's arp_queue carries the slave's device and is flushed with it.

There is a second issue: when the neighbour resolves,
neigh_update_process_arp_queue() re-looks-up the top-level neighbour so
shaper, eql and teql can be re-entered, but it calls n1->output()
without restoring skb->dev. An skb that was parked with skb->dev set to
the slave then leaves through the slave directly, skipping
teql_master_xmit() and the dev_hard_header() call that builds the
slave's link-layer header, and is transmitted headerless. Restore
skb->dev = n1->dev at the reinjection point; this is the identity for
every other parker (neigh_resolve_output() parks with skb->dev ==
neigh->dev, ndisc probes carry no skb) and the needed repair for teql.

Conditions to recreate the bug: a teql master with a slave whose
neighbour is unresolved; send one packet through the master so the skb
parks on the slave's arp_queue. On the unfixed tree the parked skb
names the master (kprobe on __neigh_event_send shows skb->dev=teql0);
with only the first hunk applied, the parked packet is delivered to the
slave's peer without a link-layer header when ARP completes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/neighbour.c | 1 +
 net/sched/sch_teql.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7448320f7ad5..5823f5007812 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index acd03f9afc6b..3fbd5af10028 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -348,12 +348,12 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		skb->dev = slave;
 		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 
-				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
-- 
2.43.0

