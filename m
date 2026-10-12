Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17514D09E8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829270; cv=none; b=WxU/VOKsy+nQ8NVI4PRvq85nSnS4bUi2z+MfUst7YWfO+nmb+3F4u7m7U0vmkriRpfuQcf0ZRuA8PQuqrovdj7a/1qmqUheVa0eWFRGCE9eteb5KNcq58mvrYVyc36c1/VOxmkQFSWjeEUb7X/Mnlroe8UFA5bXCKnwO0RF0P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829270; c=relaxed/simple;
	bh=35anN/46F/wn7lyuyc64Wn3s2LfGYLVid8tSiXKPycI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SllyUa11peMGAttqDvxUmB7Nx0BXFqihrq4A51Z16Ak/fn9lISmneviQw4Geesg6a/EqLQKdnA4X0CJT98ZPRqzpa6jaWxw2UUSbcwS6CC1Xtli4QrzogdjUzIMLbu8Ml2GtPrmJpTyseMvN7JI5zaf9Uevp0Hjrdipphzg4h4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DRTw348y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DRTw348y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e7457349eso204399385a.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791829267; x=1792434067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=DRTw348ye0Q3NufTvpCTVucO86QKPbR+W/yBKdzWMTBNTJTXXtk4CJkeYmXOoUgkS+
         HgkK/aCAIDyysGkEKG4ey/tbsFTTH+V3ODGfR5lfuCZd8crFGVzqJ/w0+28g/kvEQL2u
         80JuZvfSd2DY6imV1nuaFiLgNkS6QC1ugwQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791829267; x=1792434067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=NoqNdVknGjc+NYyuFDGlDjLF9Y7s5oqxHiaNoOmBvEkdeHq5zT8b64tNIxh2t/2y+D
         BADwg7LrQX3ZRIVb1yQ3QMr0V/zwVeDWtCx85tbqcU2AVtgkXAZorS753RpOo0SAPHPK
         AljAmGndUpL3aRTzRWi8H4pHKnkl6Xwqe3mlTxoi0CgLg/FacYxG/5dG351XPABVSSEw
         gq6U3v9lDqGw1irIEu3w65gcnscA+C3CPDuuo0OviFPBRrt7usyAFgRUx8577C6aPnVA
         TnO+YUKEQN+mnTTgfbomKEel7klFRXlbW4o2sgBhD9IN/jI7felqiI3gnRMcRPOyhUCv
         C2uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA2lgQz0LpGqjSPQJnFbozejuFuKPZoPAxWAsBWfB1KTle1f5RF/M5NEk8KKZ/AKXmwiTTuyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOrz1UBUllsDCG9Ih0Y68IJoMXazgxJMu/icLoC7/MabOULrsK
	upsa7Y0aNa1olF4AhiK2sQECy160vwFqQXF3fHxBvJ1+Y4XheohjpoItufjPvM21ng==
X-Gm-Gg: AYBFou0XuRqrnJJEarCKTxJ79yv/0aonjQRrV3WgBL0sef1EjAxK9rC9KoHA4fkvnof
	D/m9EM/ElH8PEDnvYNwG6LbjVI+16pL6SFb+xHXbJwUA2sxa0tgB2OL9Fo05Xvu8A8SkuyOGjlt
	HoO2iY60MI0jzm8msh8tyHYsQtQIl3ZvymRtivDUMplO5z+0nr4X8f6VTSgGEacnPLZ1OT17hP4
	g78M27e3MjaooiztiyKHuXjeqZ6kAH2ZiVQ5mi6Jy66LbdUe4xcRcryHmWrjP2vAnqHO7O2PDMw
	Lio9aOrvgSSU8ZmfCgo4xi541FW2Ap8uI88/IqaTJuGU5dGUufUtp2f/GShsI+4KJyHjA5i3iA/
	LO6FY2GZynGm4dZVPHQixQLL/UqCTbW2ESmv/WkMKCgK6kq+pAx8jUjGm8XOeEUKGtdIr76LuZs
	pqHF6niwjlhlPQljcax88qVsaV/2ziCHGdcuSL9ExOYeN9U//J1j70hqi7NmTRCJMuO7qeznVB7
	89z/6bNa9x6qQAulM/1JxjUpQUSDUWd3MNGb3Rheh5M
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4417 with SMTP id af79cd13be357-93ec12c4ad4mr1206566185a.83.1791829267285;
        Mon, 12 Oct 2026 11:21:07 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50b6c4fsm45130985a.47.2026.10.12.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:21:06 -0700 (PDT)
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
Subject: [PATCH net 2/2 repost1] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Mon, 12 Oct 2026 14:21:04 -0400
Message-Id: <QDISC-6HS9.v1.r1.20261012134711-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

That alone is not enough: when the neighbour resolves,
neigh_update_process_arp_queue() re-looks-up the top-level neighbour so
shaper, eql and teql can be re-entered, but it calls n1->output()
without restoring skb->dev. A skb that was parked with skb->dev set to
the slave then leaves through the slave directly, skipping
teql_master_xmit() and the dev_hard_header() call that builds the
slave's link-layer header, and is transmitted headerless. Restore
skb->dev = n1->dev at the reinjection point; this is the identity for
every other parker (neigh_resolve_output() parks with skb->dev ==
neigh->dev, ndisc probes carry no skb) and the needed repair for teql.

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path"), which restored skb->dev
to the master after each slave iteration but left the master-vs-slave
mismatch on the neighbour/ARP-queue path, and left the queued skb
naming the master rather than the device whose neighbour took it.

Conditions to recreate the bug: a teql master with a slave whose
neighbour is unresolved; send one packet through the master so the skb
parks on the slave's arp_queue. On the unfixed tree the parked skb
names the master (kprobe on __neigh_event_send shows skb->dev=teql0);
with only the first hunk applied, the parked packet is delivered to the
slave's peer without a link-layer header when ARP completes.

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

