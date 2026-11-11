Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410261;
	b=AjbedRhI5lhsTFxQBqkbqlZkQu4+QVN3m71zNLWqxKcYyYMFq312YzadedJGb7L1sULB
	 FpWcE8cg2E5OgM+dRWfp8dOukQW3OOnTplbgg8nAYR98PzJ5qRPuGjms2UJDvmTTThAPD
	 pkVbKUselICQ3DMoygtpN54BTb/hntlE7Mzfo+yUVS6fBto/wijjHQinXojEmYyVxrs9o
	 M2n4NJOWPxW+Qr6JvZQjzoBqrjAtN85sXqz4CKWWVfm7y2L8jzmk+hJ5sgO2MVQ8N6898
	 cQnWzmIj8wJF74kRqAKAmmB3HGOMKhJMvjhhS1Lsd8IdhTonn54H9xeU4k5EoqxXB7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fb1BuTd8Qdd5dScIxIahcjCU39aHCzq4j68dvvRT6cI=;
	b=EEmCyiDJKJ7mwEYOLZUEayViI3LSL7kmxriK4V+pmj7XHvMMKCs8DIpvoHVTPBG8tblK
	 9x0jgzhWB792NOf8HJa2P4WGQAfA/ibCB+Bnqr05AYfaSYi/ODjJeensEOQwmZDIAA6Ta
	 f+Jj/P56+Dp24TZ3Ss6B4xxqfDymJ6yjbBmFT/z0jLhtlc8mU3SDhcMPB/lFamaBRZIQc
	 uINVNDwU7z+UXsLwkNobQ3HrZTUeU5aGahVszgG1+4J68AxRCCeAUgt189IFDpnnuWLE+
	 RQAQ1Re3LSPGZd/AsMbpMXQoszTAhBDMotZNLtwe52oGknz13fzq06OG2OQWB/qvfTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UkDLMs4f;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354C606A889
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5354C606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UkDLMs4f
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b305d38bafso26876407b3.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410260; x=1795015060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fb1BuTd8Qdd5dScIxIahcjCU39aHCzq4j68dvvRT6cI=;
        b=UkDLMs4frWeJNsVGLmw41nhNjVIS3eyumrw5kd1oiFdJ9939nYam6wsR9/3XYbhIpf
         ZnVsORTMkhHXMgPoYzpdVCYR1T4QRPxBGSwuvLzntrDl8tfuURXa5oSqJwnlkDL4z1IP
         lz7aJEwC10IMM2TMHQZILjgXJeB7MJeB32fKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410260; x=1795015060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fb1BuTd8Qdd5dScIxIahcjCU39aHCzq4j68dvvRT6cI=;
        b=waUgdt4Ngy4/yXSLnSXL+YW02KF4BT2X5dyr4TATlWhYILVQK9rl/tXFZEZqlr84sl
         aDNlLLS5OiyXz/3akVM7o+kfn88DoELC2TzQrQe3pjOepTo9dwS2P/KmTc+1VVzG8oV/
         kRd4EiiBSSQGDuKbh8FhfBF1CpEkL1Hu+e5IxZJYBM92CqcR/xC43UEQUPkmGyvAf9w1
         tRM1IH9FtBM1TU6oVXTyLieLRNJ7Llexvn4puCoVhR7MyM65xoHRcdizIoCGV05DsN4m
         G7IONrzvsbjjGyEfsVNRxw4G+mNn6kXj8cJOacw7rD3i9VXtC1drPEaaT4+jBz13mhI4
         Ildw==
X-Forwarded-Encrypted: i=1; AL+hErGfHMWV66wYAzootW8fcGrEN0wh4sMBiLY0cbuGS2yfRSQsEqdWnGEJyG8xTYbV63miWlatbUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nXqQPuFlNKPiZSFcbKnp5L26b9YTxtdWDrBc9uN9hDqZR+FIi
	uAw7/CSoTnijknaGwaWaq4Bd/k7wTmS0RDDu+shgDqfiENnk8tUfUEMQvb8251bCIg==
X-Gm-Gg: AYBFou1G01UGlxurmT4b3VPivdL2W757o1J5x1sjKNkZ9ItZl6WtDDZIDZ33Kw4jr9y
	DOLVy20TwsFGZkGREenczlvtARw7zJdPWeYHcwHNRQPOP84riSmfBlghNUa28RsTIXZY8F3a20e
	GnXtFs392Hgqr+3iOaB5U0SlEgkymhKQbVqICKDjGRo5VMXpVkKeoLgTmypvS8ma4UP0dcRtL2j
	c8Sq4DfsA7Xi+iaZALo05WXxHOgxkMySpSeyKpEfvGNa6AHbSRsB6+8550LJoC8dT9r+f4ngtYi
	/jTJ+iIKhl/zYVtnjCPcuFZiiKgUH0SZqyXJzjgKUd1fxPxao2qbqbzJCXOY3euw/j5n8Uqr4Sf
	JVgLZ4GtMoJMaVPu6QuGoetGe0ECAUptV1cNGCCvBEAjpzuIgR8NTL/IGdsDuwSrkGokXlnMA4T
	FB/kFbBxQlpIgP2ibwVn1OLGHgOjBNOUM0DW7YPudD5n9x8k5ryIB/WilKe4rGnoMlORLZNm487
	bKxGRBn289sF/gHYY2yQPHwHqpevPXFB+uVJFXjkgnHv2GI9iJRqbPODl+Gv1IG3MWMpQS4dfZC
	HHAFmtj+vXq80Ma+vGyW/thYEy4Z63gBsO3mM7/SH1lmyELP9FN5X9RxLuM7120spJr2E9hqRst
	+zTmHsfvAYtbdGA==
X-Received: by 2002:a05:690c:113:b0:8b0:ecb2:883a with SMTP id 00721157ae682-8b3a81d7fdbmr20123797b3.62.1794410260356;
        Wed, 11 Nov 2026 07:17:40 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:39 -0800 (PST)
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
Subject: [PATCH net v4 3/3] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Wed, 11 Nov 2026 10:17:30 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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

v3 -> v4:
- Move the net/core/neighbour.c change out of this patch into its own fix,
  as asked in the review. The sch_teql change is unchanged. Considered
  comments from Jakub Kicinski.

---
 net/sched/sch_teql.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 3f781a3ffb41..2a8383546ce8 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -373,13 +373,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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

