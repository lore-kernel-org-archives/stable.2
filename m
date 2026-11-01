Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550486;
	b=zn5lkm+Q9SEiNO5lBXNtXGVRbFcbBkLHAk9fwjqV1shDnbfoNWIwEdxPqzMTkBuImyAO
	 8tC9iUusBnNWrCX3z3wU9auTa7GrdwA0sP+9kP+C7YgaoFeBRDO/wPS8huufS9o7qhnwL
	 JSoi4Cult+CopuU1V8YhZol+Pox3OIF4GHc1gcnfI+AH9L8RSUqUJa1ftD/LE2Qi9Cc9p
	 sKfrmkSv5melf1BaM2K41zCwqAWYxf327RRQnjshbOdldbvt9FA4KqOU7xdPxCPXXqPYF
	 gGEFuTCByChtrdSIMNPdp1R1e0+6sJDL3h3QbA3dQWkeH4YU65RtbpAIlEM9/qOfeRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
	b=NgLmLbxkYLLnF6TUn0e6sQY70mzV2sl7CNqVzI5mTI5wsIiPpHJ+oYCuC4682F1UR0YJ
	 7egiPq7QZyMXqxSzOX6mWDn0CAwmdoSUWn8rZKJuDoQcnpR8hmhw9kt7nuc836wd1DBbd
	 mR5BsLicfpW6xzL/Ndj2+tH+1UD11r7Dr5OstTOc8LX7Ncbh4xtvuyFnIKm7bd5Ogrk5O
	 bAEkNSJ4CiH+rYJgTJ8NfycNX0V1pjGrcFsjO0+YXynEa0y4SvZHYLduxqmUJIE8v8Qt3
	 YFcPv4E81IHdR0vX442zqaXl5NRc4fd/1graAWkeZVru7sI7PfGUpzULTMv2IP6DI3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KlSbhk99;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9915606A32F
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9915606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KlSbhk99
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c616c84so205302285a.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793550484; x=1794155284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
        b=KlSbhk997vYicLVChZABuzfSGqZO4ISJcWPChRKjMTX6ZLwRdmt8W77XAKkDK3U5Mo
         YxSMeZZ3DdfnlYlb1WTGyTow3tbSO8Fapi5fmUoAULoLCnom4VQpGp/ke4gdWO9p30LK
         mkPjJ/zkVWo+YzECxJlcWe+TYxSTAct51O/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550484; x=1794155284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
        b=pC7amCsKdD2n2JjytqaID53S8G6I6tllC+c74r8w9IYtDIVFOEUxN+qzN1MoiITfBw
         HmzOo+T2R+C6HkF5Xt94UUvA1heopLt3pgq8iqUH9HS2Czc3/Ptm2lrbJIlRPMacNY1c
         DQd5dOsWjuA5SI1xVTXgSd7WmE5P87v/jqL1HvyNWHpBphDS57pcKSKfErm4Wy7vEdId
         SwG2RzdwsPKwmuGf2H7QyhvXIt31CFghERzbw0DDkIcM6Arca5SE5vHsL4wm65g7ho6D
         /NOVVCzTsylCoJfWda8IhdmTYzF/SVxZhkpC0SSnTL35TgV+5RIzBjG0zLntWvWbOBRw
         IdgA==
X-Forwarded-Encrypted: i=1; AKwUvBx7KLDT6mIwj6APYwAs399OvBKh9NFA9vwT05Xhz2vJzIDeP7BS2bQ2le2Pi2rk/c1Go7ks9U8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe/tJeRqxJ6iv+na8nZor7xJC+VFVTjUeXGtcNL1WOwnwOE4ql
	yzr2RL93iinCU5ozGXJ85iTJ+T/eEXhtdovPi04CKkoz2ZQjSjl1ealeJkABtKvaYg==
X-Gm-Gg: AYBFou1nGVh55ogZOkBCvanTUBQRgs6Y1/9VyECrltsppTxgZnjRmaht3H8NwMXD7P8
	Qg/Km6135QxHLYKP4LxJuld5kx0wt2RX9k8X3I48BabRMnS+cT91h/nRpT2cltL8enkb5/p3F/x
	VBdFdLa7n9VRhyFMLrdgQEnFyTyIFB4WNfQRjmv8ii/3dAo8AhMXMSM1JygiWZS0KyWjY1MYYts
	L2KPrKdrNeWQ3+xf4RALcq9PueZhXDlnbbcD7R3FcfYOh895hkVbYEIaf0uCiqRsLFPSvsYkuf1
	xj+FDS0fzFQ9VjmjzuxV0YhxZSKsIG5q5BzlL+mQss5P5tzlrSqC0qc+vUqbq4GPvHY0kKE70SF
	1iw1uznWS3EaYHhWUJ/JhaYHbzKOVhE5hNW6MO0gYKvxtzuuviT5aPXowMhogS75pI6kV5r3O1t
	6crsjmvUcvxNBZpwt2S0lfjLvlKkMrfOQdhF+FvWMgdjeQLUr8pO93cahHG/uOX+b+kqhmmHMiZ
	UY87C/QiIwOlge7egR2GO4mytQfMGpNiPONQF/zs9l48npKwiGaJbutV2O753mjALq02+DMUwGF
	yAwuVKeWOPuFMY5fVLdmhl4JXpQruQTRBxPgb8N26OcvNSgyi+NFpILp7Wx6Pww5Cft8RJOHS59
	hRYcMvEyqIMiTxT86oIGS4Aub1jNfPQJxp3ME
X-Received: by 2002:a05:620a:2801:b0:93f:26d6:d70d with SMTP id af79cd13be357-944216a23bcmr1387687485a.31.1793550483739;
        Sun, 01 Nov 2026 08:28:03 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm627354885a.1.2026.11.01.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:28:03 -0800 (PST)
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
	sashiko-bot@kernel.org
Subject: [PATCH net v2 2/2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Sun,  1 Nov 2026 11:27:56 -0500
Message-Id: <QDISC-6HS9.v2.r0.20261101105945-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
References: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
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

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path") by Victor Nogueira, which covered the
slave side of the same mismatch.

The issue:
teql_master_xmit() sets skb->dev = slave only right before the slave's
ndo_start_xmit(). If the slave's neighbour is unresolved, teql_resolve()
parks the skb on the slave's arp_queue with skb->dev still naming the teql
master. teql_exit() frees the masters on module unload and a slave can
outlive them, so a queued skb can be reinjected through freed memory.

The Fix:
Set skb->dev = slave before teql_resolve() so the parked skb names the
device whose neighbour owns it, and restore skb->dev = n1->dev at the
neigh_update_process_arp_queue() reinjection point so the skb goes back
through teql_master_xmit() instead of leaving headerless.

The restore is limited to a top-level neighbour whose device has no
header_ops, which is the shaper/eql/sch_teql class: those devices get
neigh_direct_output() from arp_constructor() and ndisc_constructor(), an
output that transmits on skb->dev and builds no link header, so the skb
has to be moved back.

A forward that steers the skb to another device, nft fwd ... neigh or
bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
dst of the original route still attached. The drain looks the neighbour
up from that dst and not from the forwarding device, so when the original
route is itself a headerless device this gate matches there and the skb
goes back out the original device, running its egress hook a second time.
Those forwards supply their own device and nexthop and do not consult the
retained dst, so dropping it at those two sites is where that is fixed;
that is a separate change to the producers, not part of this series.

Some context:
Only a module unload frees a master. teql_master_setup() installs no
rtnl_link_ops and default_device_exit_net() moves the device to init_net
when its namespace exits, so the window is a parked skb plus CAP_SYS_MODULE
on an unloaded sch_teql.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_VETH=y, run as root. Create a veth pair,
make one end a teql slave, give the master an address and a route, flush
the slave's neighbour entry and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99

On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
still names teql0, so the reinjection can reach a master that teql_exit()
has freed. Moving skb->dev to the slave without restoring it at the
reinjection point leaves the packet going out v0 without a link header.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v1 -> v2:
- Limit the skb->dev restore in neigh_update_process_arp_queue() to a
  top-level neighbour whose device has no header_ops: shaper, eql and
  sch_teql output straight on skb->dev without building a link header, so
  the skb has to be moved back for them.
- Say how a master is freed and add the conditions to recreate the bug.
  Considered comments from Sashiko (nipa) and Sashiko (gemini).
---
 net/core/neighbour.c | 3 +++
 net/sched/sch_teql.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..541cf699abae 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		/* headerless outputs (teql, shaper) transmit on skb->dev */
+		if (!n1->dev->header_ops)
+			skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index ed8faa848f18..4eac1f9c8ddf 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -368,13 +368,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		skb->dev = slave;
 		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 				int rc = NETDEV_TX_BUSY;
 
-				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq))
 					rc = netdev_start_xmit(skb, slave, slave_txq, false);
 				__netif_tx_unlock(slave_txq);
-- 
2.43.0

