Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825415;
	b=ZiQLS4EvO61XJQ2weli5P9So/f0XzhVyVZkYFbl5HPaKCjo4GyIoxR63Ke2gx8I4COcB
	 2JztoXIahBtk0qzC/f92a1FaoueVZwUqVdXAHE1m5I4Kt4vGhyCag2kZWICoUPX4lud16
	 rgKDPbxj/zJn2wHlebVIRpoh3wGS3PJcA54wWJT0nh/7TJsxOcAsa7YPwGaPcNgLZXyfV
	 g7inEqozMlesClKI0cB7YILeHJ2t2CkXpWdO0Wgzu7JVsRd0A3C07UyCrZAp0VzfSYNv2
	 RXsN0x5rdgF8LD6X1C20eVKjxG4tmX0epCsDRbeTAPaVWNdEeDVfjftmniGqyENQPcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LX0+DV+LDSGdBcKNRc1D1pjJHJmtAjduSSHWyN3x/kE=;
	b=NOw8lUEvsGOX8sm1/hxGlQPrJBQE4NTCue2pvmATc5EgZsoZktYK+J37ctjE5VvSYGqd
	 txqllM4y0GtAgTyFV4NyWdh+2gERFrXrIUqIg9ykrto94XPkDIXS2H6gIl0/dUdgAFnaj
	 KP0RdrQw+YcjWFk4veGbbn+5IQweFIuAwZrH4rs8mF0dnU5EJG3Ea8Cf3bLqtYCN7UQpW
	 5YLyfWTQhhs2epaBTknJ88YDBGCc+M+PRGlOUpZ/ln0XKnPZQJsj6C/rE5wpvyBPwm+YH
	 C7J65wuzRUGzOCIuneAIRpX8FT5nG+hISadiQQscWHCwfDv7ppvTzeq4h3DvGws7quQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BPsMS9D4;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFB606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CFB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=BPsMS9D4
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55b8cd4e2abso36074571cf.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794825414; x=1795430214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LX0+DV+LDSGdBcKNRc1D1pjJHJmtAjduSSHWyN3x/kE=;
        b=BPsMS9D495KNtTcUwPLACacoKGxzzcVgbGDBwMzc0rfXnIecz4GUgdjT+nxdKBTr+u
         1+egacBy5IbNmDhSBkl87nDI2uikwsMRELO+HoqCgxx0/40/Q9WM2xxYYvOvMMxogpHJ
         m2LRw6bTfw1dvZJ12Z2tMNqzVK9GDcEdFHXqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825414; x=1795430214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LX0+DV+LDSGdBcKNRc1D1pjJHJmtAjduSSHWyN3x/kE=;
        b=2bf5H+KhooK92qdSxHsLJjPce6KCrqlyQpVokM0A6OYNCs7OGGOkQC49plSL45I1YB
         E51cGMMaVWSjTW/yJdUlGCIIZldMmM2BjIc/No60023LPPN7N6lecOABgA/rbz/mV0Hy
         bnPfAZFCvLI/u4odIaI0fzuA+JD9fY7wYnkzncLC6uapy6N1XBhzUjxKnRPAqmaPfM8h
         kGXML1r2ctvP37Pm8r8hD710m5YqUdUIYUkiJG4i8BPDw/EEFYRpSCj9+HDWuu05fggU
         rMT+yrS0CdkovG+UqV1WMpjFDPb3JJ5Davql0JfYY+xz5d076sQJFYY7Sv351HqJxL0l
         8iEA==
X-Forwarded-Encrypted: i=1; AL+hErGE/0VTbzaZ9DZxKy59cjoBOkGsO0qBJZgZXDKccrjljwa4NtQy7YXB+eVRCZYodUSVOgVKrvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z97TBwyJKujAYAVe5XghyThS6qbs10tTX1RLSnxVyeVKVcHi7ay
	BsrJoZd5IkRwmUWsSJXd8/zBRpVw2vWi6Ljdc61+DQtZMcvn4txfD7J72KicgfAlkg==
X-Gm-Gg: AYBFou1Qmciy1eEOxlVjL5WBIvCRwCR8EIiDMF2sNCW1l/QqkBGm77u9XU4Nh2VKq/B
	6Di/l7F0I6XsvnAjB+bl2SEf5sRKB87NFaR26iWb+yIxs22MCkmXc/5lo2v2vOcBdesHA6FbXYa
	3hO2raaJkNn889Rp4Ka/1nmqjFB3KBxi/toi/PpnK7vCjHeCSW7yFN43YcXlHXdomZsIGtnrOwJ
	TJ79gZ1Z9XMYOZlIVOMhu6NsE9YFrXe9Vp25idKjt3uHiXtGxXXwJ0G+TZLX8G7c3BrdRWIkzo9
	V8S3kO6ebExubj0jR0PyKHgI7jfKIAAQs0SvD768xgx4H1eaFm6xKOKnt5h8XmK2Ow8Rw1EnUF0
	0lLHLih3h9+ma92040n8oiJJAweuMWrzScEEdE6dRfRKbTYrMTnkyZMDdBuMKFE4B3cE5O3KVSI
	Uf5L1OBW0GFryy0GFyA7GXlN5m+2z+8ONfR7hpeN7XMDgEDbip4srlusQyAzReJnqSuEe9p8mBV
	zuVsDO+8PgGIh76PAvY9fjmA1vQwzFRu57eOgIOPPnP7zNuJCBhSts4UjM3mAK+z90L9P6fGJaM
	G4jzOtQpPtMJ5+dArGf7YtEsJRCiIkbuBcK63HI8H/etN7p0du41Xft8qERBUr+n0niyK9X0tRE
	=
X-Received: by 2002:ac8:5995:0:b0:55d:2caf:ae7c with SMTP id d75a77b69052e-55d2cafb009mr79499971cf.19.1794825413577;
        Mon, 16 Nov 2026 02:36:53 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm77778651cf.24.2026.11.16.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:36:53 -0800 (PST)
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
Subject: [PATCH net v5 3/3] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Mon, 16 Nov 2026 05:36:43 -0500
Message-Id: <QDISC-6HS9.v5.r0.20261116052927-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
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
device whose neighbour owns it.

The parked skb has a second consumer: when the neighbour fails instead of
resolving, neigh_invalidate() hands it to error_report() and
dst_link_failure(), which read skb->dev to report the failure, so it names
the slave on that path too.

A parked skb is reinjected by neigh_update_process_arp_queue(), and a
device that transmits straight on skb->dev has to be handed its skb back
there. That is a change to net/core/neighbour.c, posted as its own fix,
and it has to be applied before this one: without it the parked packet
leaves the slave directly, with no link header, because teql_master_xmit()
has already pulled it.

Some context:
Only a module unload frees a master. teql_master_setup() installs no
rtnl_link_ops and default_device_exit_net() moves the device to init_net
when its namespace exits, so the window is a parked skb plus CAP_SYS_MODULE
on an unloaded sch_teql.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=m and CONFIG_VETH=y, run as root. Create a veth pair,
make one end a teql slave, give the master an address and a route, flush
the slave's neighbour entry and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up;  ip link set v0p up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99 &
  sleep 1

The skb waits on v0's arp_queue while the solicitation is in flight.
Remove the qdisc, which drops the module reference it holds, and unload
the module while the skb still waits:

  tc qdisc del dev v0 root
  rmmod sch_teql

teql_exit() frees teql0 there. When the solicitation then fails,
neigh_invalidate() drains the queue through arp_error_report() and
ipv4_link_failure(), whose __icmp_send() reads skb_in->dev; that is the
freed master before this patch and v0 after it. A resolved neighbour
drains the same queue through neigh_update_process_arp_queue().

On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
still names teql0, so the reinjection can reach a master that teql_exit()
has freed.

The park and the headerless delivery reproduce without the unload.
Freeing the master while the skb waits needs sch_teql built as a module,
as above.

An unfixed kernel reports this when the timer drains that queue:

  ==================================================================
  BUG: KASAN: slab-use-after-free in __icmp_send+0x3f9/0x1680
  Read of size 4 at addr ffff8880039bc0b0 by task swapper/3/0

  CPU: 3 UID: 0 PID: 0 Comm: swapper/3
  Call Trace:
   <IRQ>
   ...
   __icmp_send+0x3f9/0x1680
   ipv4_link_failure+0x3a0/0x5b0
   arp_error_report+0x5b/0xc0
   neigh_invalidate+0x125/0x240
   neigh_timer_handler+0x47d/0x750
   call_timer_fn+0x138/0x410
   ...
  Allocated by task 307:
   alloc_netdev_mqs+0x81/0x930
   ...
  Freed by task 335:
   netdev_release+0x45/0x60
   device_release+0x7d/0x120
   kobject_put+0xf3/0x2e0
   put_device+0x13/0x30
   free_netdev+0x3b3/0x4a0
   ...

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 626dc001ec23..e60d8f3b127d 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -374,13 +374,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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
2.34.1

