Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065B945198C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999344; cv=none; b=dmH8Q6ZDGLSk8f1Ot/Br4rQvDbfN4m/yAgVE20z+FVtFXxkG4rf0Ni2qAAhUj9DQjTtfi+cLDwBbvvSwPPU/0gQljAey2OfAL6Pyuf7qNWp4W2+p+05O4cAWcQ7/Q///blS2vQLjrFyKJO9ThM8xV3ObulcmR0fLrMvxnGAcr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999344; c=relaxed/simple;
	bh=bmrYhg8GPmLNgo3OC03WDmuMfcBOKUh4DkpRoc+gZsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=asz/gK9hrEQWvGs8Kjjvy0tFXoww5i1UB+ycvbK2ej0jL3F376FNyMSeU9Nu+zPL3Qf15UmeFmckJPOaxhCireWjmPBWvLFBbPbvR5dADQQDHRKaKA9zQ5V8PX6DguQIo69EOxFzarISluMEnHf5QIdICUP9K4I6xgq/Qwf3xLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=iCmgOkNn; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="iCmgOkNn"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43db0c29so21831577b3.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789999341; x=1790604141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8wZJIn/YLIvaeMgy4QlEYYl+fSKkh+mCzNGRZOGqW8=;
        b=iCmgOkNns7XIkHQLyWN9VzPFLA79EGf4GsXcNkegnzzqonXhf6x/4iqPbp6+uH9s2J
         UhKc/Kbq8WTnZKeCU0JR4Eh4mHt9sVDi6fkaQNsBirjLBaHePaoqxmHTfw1D08IlyO/0
         lDoQfvCYr8bAnP0Nn/xDXK42V0MlWhZeU9OjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999341; x=1790604141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8wZJIn/YLIvaeMgy4QlEYYl+fSKkh+mCzNGRZOGqW8=;
        b=tVwAEjuplhuRmN0C7MdYNuORG3OG3m7wYys5Hf/D0spzHXtZ+4f5PCz0AUM0IkV64/
         ocqe0cG3fp9O9FlCNaESnXHL5rzwOehIliVD8kmkJ7ZV+Qmcw8pl58+ogC2mA2WFc4AD
         rW1m/jDbP24+MM3mYxgcxcXZtv9GPPIUo3oTOg09V6zfa/9pXSICHKUN17NbOXkuM8OS
         hqY+Yp7nj47VnVDcXScPWsTDLSqT0Z3upRJToTXXJLlE/CpO8hUPKJZ6B0EXeGctmwA/
         Irra2eHnHXgnphmsRlxKNgJWgGBxUPFkMveni9Tc7dkDD73sM8hxt+CMvNmsBX/mvJWw
         Rjfw==
X-Forwarded-Encrypted: i=1; AKwUvBwysDhKM20JMM6OJUIoBAEa0lZpFvtMJHoEy8g7tkUsK58e3d4F9tqkSzn0QnPJ+t93oa0h8Sg=@vger.kernel.org
X-Gm-Message-State: AFuF++n+MoqnxvSWWR+Oqa08ossrbVwCP0UQWD7yrlQsAUcndZRg+47W
	5hgsrDuFjJcN50bQsUkJTdCDCFwIKRtLokMIIL+WWaAAURAn+mCgjeW6v5d5sfhcxg==
X-Gm-Gg: AYBFou3yKUyjImLSO1MV7Se184ckl+bsZgG1ibcJWtlp8L9X+fP2lkRblPTyXnEv6dy
	7Bt2KNk5nWzc5mrlIh6OdSzDEDE1g8R9e8PGEgmGgZxaDE4/YfwCm/pYYYOeeUryaHPn/Fn9aF7
	bE448/HocxR4J8KiEbnooXj39p+ZDSzxOX/TZnYqLCQcnfDJx5+6/ELE+arxjTsEnIS+mntAxoQ
	3V5FNF3KiXuCwQxevOd+PxmRZmoiOqWF//bEdmA5TBiwrbgPW3WdfV3/mHY9Q0soUOWQrHU8Hs4
	/CZQlJCIYzBm4+SXphRVnjh2L6DeFdwOLJc+1XkK0LleNYedMlp1qYYDYz/b4xbWWsdDS4xOi1S
	Qug6PokT1y4eyX8y8C2+GGLabZxyxlRGWbaomkiRJccAgFDSXyFX/nK4MPYNNv1kAnwY0jZzH50
	SIYaHStAaNHHNDmzuIfF3s8itlaXNlHiokdNjs8iwwQqk0boZCDuenurjG5y6HOMCAkFOy8ZaYa
	mwex4QETvFl5otOIesOP9t6cCZgdHm18f+bcWrdn1+VAwvcq7S/x5loQTKkkIELPJxfJmP4oUlb
	hjWGpcE3Tt2+Nv3bYmPQTmM=
X-Received: by 2002:a05:690c:38b:b0:873:5c6b:a30f with SMTP id 00721157ae682-897381a79d3mr29832287b3.61.1789999340710;
        Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae512550sm64806751cf.1.2026.09.21.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	"Victor Nogueira" <victor@mojatatu.com>,
	Tonghao Zhang <xiangxia.m.yue@gmail.com>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
Date: Mon, 21 Sep 2026 10:02:17 -0400
Message-Id: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skbedit can set skb->queue_mapping and __dev_queue_xmit() honors it
through the skip_txqueue flag; netdev_tx_queue_mapping() clamps the
index it uses to select the netdev_queue but leaves the out-of-range
value in skb->queue_mapping.

Every later consumer of skb_get_queue_mapping()/skb_get_tx_queue() on
that path then reads past the device's queues. Taprio's child array
q->qdiscs[] is sized to the device's queue count, so taprio_enqueue()
indexes past its allocation; qdisc_restart() likewise dereferences
dev->_tx[queue_mapping].

A local user in a network namespace can redirect a packet from a device
with more TX queues to one with fewer (mirred action) after setting a
mapping valid only on the larger device. That reaches these reads and,
under KASAN, faults with "slab-out-of-bounds in taprio_enqueue".

Store the clamped value back into skb->queue_mapping, as
netdev_core_pick_tx() already does for the mapping it picks, so the
whole egress path observes an in-range queue index.

I have looked at other alternative places to put this "fix", none
appealing: an out-of-range queue_mapping is read by every consumer
on the xmit path, not just by taprio. For example, upon testing
an approach that only bounds-checked taprio_enqueue() I observed
the fault relocated to sch_direct_xmit()/qdisc_restart() instead
(because dev->_tx[queue_mapping] is still indexed with the raw value).
Another approach was to cap it in skbedit;  cannot work: the
redirect target, whose queue count bounds the mapping, is not known
when the action runs, and act_mirred sets skb->dev afterwards.
So the decision is to cap the value where it is first trusted and
result is it fixes all downstream readers at once.

Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=y,
CONFIG_NET_ACT_SKBEDIT=y, CONFIG_NET_ACT_MIRRED=y and KASAN enabled,
create a 3-queue dummy qa and a 2-queue dummy qb, put a taprio root on
qb, then on qa's clsact add matchall with "action skbedit queue_mapping
2 pipe action mirred egress redirect dev qb" and send one packet out
qa. Mapping 2 is valid for qa but past qb's two-entry taprio child
array.

Reproduction: reproducer ran on a KASAN build with panic_on_warn=1:
the unfixed control faults with "BUG: KASAN: slab-out-of-bounds in
taprio_enqueue", a read 0 bytes past a 16-byte taprio_init allocation,
and panics.
The fixed kernel runs the same reproducer without a report, only the
expected ratelimited "qb selects TX queue 2, but real number of TX
queues is 2" notice.

Fixes: 2f1e85b1aee4 ("net: sched: use queue_mapping to pick tx queue")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c67900354fa6..736b3664b635 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
 static struct netdev_queue *
 netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
 {
-	int qm = skb_get_queue_mapping(skb);
+	int queue = skb_get_queue_mapping(skb);
+	int capped;
 
-	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
+	capped = netdev_cap_txqueue(dev, queue);
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return netdev_get_tx_queue(dev, capped);
 }
 
 #ifndef CONFIG_PREEMPT_RT
-- 
2.43.0

