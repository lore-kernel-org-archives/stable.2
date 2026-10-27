Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087817;
	b=QzkrQbiyo6JdgdkiU019nK4/cDafEJ9iNc/eXSZxg4/Kh7DpjDkLelIi6FC5lpBlCkcs
	 pJA2spn0Qiki/bN1NyiPKY+wWuuo1hqjwpQpwiYqQ7JEl8qAihqlmkwgTUTobEmG7Vc5l
	 vCDPOz7CPl2a7mcZIjZkYZ17GZdsDQzH9einmJodGFoiTjZNfNVIBOVikr3tKNcsksqIC
	 Ey7Ob9UwPV87teuq3R4lcF36yXcVFAQFLblcWlNW3VqaldRIaPRwAiOh67wuC8QNBRD28
	 kYQDILNyJ1TYSiXX4O1+Yg/q9tACNKtEajlHkCmRofpa5AJ+xfluzfcCL/UjXBf4zVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
	b=cHueUYawp10LYvzaU8fpSvIgA+fpJcSguXzmSMtK/+apS3n9G3aVSkYTKliaTDhf7Q4n
	 5EHCTBy6mER8SQkk3MwzzaxsSxnYg2y4A0VA7Ao7pb7eIjK/l+CHilNhQG2aq/AVLSREP
	 Yj2C7+PEECCszGyFiZrrgHhsIr7mxDUR7tbsnx6lMw30M0XbTbWmh7tk8bc4RePhDKFr+
	 HfkpkyKBqQzZPb/nlwmZBPifT8q7gq/aqGmMcAtmDx0zA+m4LW+E3NSTVbEzgn3dI9/vs
	 rt/d8QHayRaj7aCrsB/6qRXGRkACf2wgPxFIrcYgEQjm2EYPLKnCBiBYqKbX3FKE7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R14r4DTk;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14C606A324
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A14C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R14r4DTk
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f2493c28bso313967585a.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087815; x=1793692615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
        b=R14r4DTkHR5zQFvQmfzoA3DVtcSTydqWCIujZ7/6DxEZK/JM+Hve/Jho7+z2wEUW9N
         S69VK4FBKrdCklDS1QHH1dDKvO5AQXjlOZ4YpXRuTbm6JqrPzfRtFiThMEZvI1BPmZLa
         Am+ivBP9EAEYZAq2GXU8rGdIwRg6XZP4kYdNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087815; x=1793692615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
        b=2XzxXptYiwndWZGMrfg+otiKrWC5t9KqvJLBqmUhvb5RFQPL9tQLCulyumbwaaHOaK
         NTdwwrJxepSxfDF5mQdNmDAZVSBVBRqgVlVOUIizP9eVjBob6Fg3PCCiSHKodBKh6q0m
         EljLgUwX073bmZy3BL0Jl0ET/GHUFDtCIb8RAGp8lMBo0YmYXVTwv8dPoWRpB66VP8+q
         CAAPWZ8O6b7GOLVY/M3GnUN1jbT8JC+tURV/+gK3opBHXol6wHUZh13acwGe09zmLmxQ
         I7fihZRJ3kcIXpxVLX86U6x8VWjIDURWkQUMmBZ/rFZQq5yKbCIlPi4fHoPAJHtrcAmR
         gPSw==
X-Forwarded-Encrypted: i=1; AKwUvBxY+fwaHbZrOJ0Cy1lSow2RRLXqckEHJAbRXtxmZMJqUeWfayk6T4CvZu+fCIHT6IS+UsCEXLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYNjU2etWePAYQPQh7GVTSVQbgPKL+SeUBvAEXDoYHvzHR1Knw
	6Yp7lc+qM3RAWHmNy5uqTJAeWw8gMpS9wK+dDKV8qaRNMIZBJJzG1RRsfYoU2aoFhA==
X-Gm-Gg: AYBFou3YlKF6yLEjJPah1zvzpsgSEhyP3eHBvooD+rRn+qtKUY+4pyq/RQL/Zeb9Tup
	6BpwYnXEgTrPHuIL75n6cMS9HXmXiRTW1PMZaAQgQqP9Ip4XSuc5jonXNjnIt67kE6WVC0sAufL
	m16ZKRnign4jdRTA+9XtFFS7YjxSCRTwNrMHfUPfJefgx4JEcZjpVm3hD0jjA3tU6KMPP40drEX
	mOTWuA2/ifI1Hi7ZNVa4jolN7DfCNu5w4/BI0zbzTrdvl5bg9Dx7lu6G1UuQZPz4FkWFRzNEvOe
	efoiV6jv0TPpQdbNXIgd2zhXzNNV3pwwV2QhMJkqZgm6um+1538CtKNA66xyc3kW0Lm5jN3Sx0h
	bRb4Krm8tAP+YXt81heSgszwTL8LZ+Hcd4k4ri43W/qmTRRVUjd3iUlzOynWKfTwVZ6spAcaMMU
	r02wPN3MRzFbUQTy2tbtU9sx7wQ5ua9IKAMTjtpUiBIG3Go+2RKTox8zh2TEchDV+16v664dY6d
	F+qrRe+BhyaN/X9Fu8nRjpL+d8qvUonb1a/Gep6jVJMYOFnFGIBwzW0TlnWEpqHQ+egBqM4lRwA
	/z3sajysCQoR7etZ1ZAgCfPUpQzfE+bNgY5Eg7kOsjw=
X-Received: by 2002:a05:620a:448a:b0:93a:3d67:391f with SMTP id af79cd13be357-940ef7d5658mr1344922185a.7.1793087815549;
        Tue, 27 Oct 2026 00:56:55 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:54 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2 repost3] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 27 Oct 2026 03:56:43 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com> <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
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

teql_master_xmit() sets skb->dev = slave only right before the slave's
ndo_start_xmit(). If the slave's neighbour is unresolved, teql_resolve()
parks the skb on the slave's arp_queue with skb->dev still naming the
teql master. The master can be freed while the slave lives, so the
queued skb can dereference freed memory.

Set skb->dev = slave before teql_resolve() so the parked skb names the
device whose neighbour owns it, and restore skb->dev = n1->dev at the
neigh_update_process_arp_queue() reinjection point so the skb goes back
through teql_master_xmit() instead of leaving headerless.

The reinjection restore is not an identity for other parkers:
bpf_redirect_neigh() with explicit nexthop parameters and nft
fwd ... neigh can park with dst->dev != skb->dev. For those paths it
moves skb->dev to the dst device and the packet can re-enter that
device's egress path. This is a behaviour change for those paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
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

