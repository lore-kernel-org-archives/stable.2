Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492716;
	b=sdNGvB5CwLUN+oH8cutMfJpE6eJ0U2jhuU6IqbIAzRef5XiEIk7RFfuN5A7VCMvXuY5B
	 VGZYtL52DgqLzLaa7VRaMQPr37gN0mxoUzfdSB4jkBN+I4f3FwGiCJQSW3rX+cedrNf2o
	 SBabn7jpw7ikDcP97ri6p6PACbtV12USXPQLVo8I+NN3aI+qKtSxVkUNXSo0uCRAKool7
	 BAjoZWCkmwGY+z0cxwBuyCHNOLjHUB6es9ACwnhdtjZvJ2+yMYUPaFNfgJMZUoBC9IdhL
	 GTkUXtTc6LfxS6H7wObXJ6WGeo2ZEH5GeeqW8pboEyb+VGPapy5NyEI0hCFbJ/7bnGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
	b=FTC1KWoWUnpIvMk8giot9+n9UVCygYbS0vSKTC/mxbkqfmziEs3z9J4GQd1F04tUjOaN
	 0OSOdE0mE2fJV+koTF9Y9BXJdwH9Fx69QqTW1eZQQL5XFoxqxZvBjmcn7ZZGdj/atqOYu
	 b6DP15m/jmsIOMoLkjXMrvdHekd7lxpoCMi+les+XUcnDi1RySAX+k1yICKsywe/qBTdK
	 5zsv9uq2M4To9NiKPmscYdZlqBNUY97uyJOGs7JmhipeL2FxryRYLrlESt+D0fMa0sgLz
	 VFskBYBOY8jFH3g5F3zCLojVYJDvWZaN0cnXHj1ASdyvh81vbCwNtwx2PM7ogysg+gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bSOuHo0V;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF06606A32A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF06606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bSOuHo0V
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917997ab0d9so26660036d6.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492715; x=1793097515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=bSOuHo0VChRuxXqgAqzeZ5y5gJVxqIMp9ZUNOXlpSfpjdXjV0a9DjNVCEJYWxcuhLg
         vCzguybR+vrrH6srLzXrJecE+HIKY2UKqNibv0H0Y+iZAfKjP3YQUrHXBzPp4X3eFUpo
         8hnwPnGusRZ8KdiA43s39Lwwzl2BeoGdEeUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492715; x=1793097515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=odZlmqkayYJ338hRhyQa1HET1q9PVML34h/TeoCH5pY+3GNHWeLav/LHTFYylS7vMj
         gHimgJX7KvWS7FFeHOomW1Zj9OhiLKzV23Zl/Q24ZVo+sDi1zJxxlbpOYyPmtAYEVOzq
         i34QYJ2NhlEw3Ev/ak9EVxUTK16bhmxRmZ+0Dwo4ZxG58PhmwxZdCUBfS0eFFWlJOsCW
         w2Dc3ETv3KFgCVPcKIiETfiL8Rg/MM2LGYmiA63ne4Y+1cxi2Ge0Dr5k+9S1s4S8jOiR
         tXyaaGWIvpYpWgndSNA6fQawpL/oy5n5HHDRSvRYer8w2XlxJFMa7B6kthzxlINQC3d2
         1pIw==
X-Forwarded-Encrypted: i=1; AKwUvBxf/bLAfHQkD13chTjig93aWOfWlf/ky0Se070UvsiuaNHifud8KB/Ts/tWTQGov/98y6WiHvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbztG+UUIUpg8ogGaIfBDrd7ChLuwDh4SGJEp9TufTYljz2trk
	rataUeAHIeDXHBct2gAjH9QbxwYwAyswIhn8/KYHM9FRz91Z2d8lBf+jZ9dCvAO/0Q==
X-Gm-Gg: AYBFou3BERP9lio0v42nZJPrfmw2FRtHCy/sKmnfiedvx4RIFaXmyBVpokOePFrVDba
	SMxfce7mAbfZa61lYevhI0bX3qmcHYub1DFkU410P2MHRVvqWPvB21bWZynr7YZ/+PAfOA9UYnd
	tNxOWKBEtUxPv8btnHEMNYSP9THn/RBR3C7Aj4S0FsLbvC8Z28RKmDbh8ntufQXUJEOebzXZyTG
	UTijDLMw6az+1AqU1ZWsvT2FjuJ65gi/rbXW4BgCikqRcDPWDsfI20poSMzkRJl5BYnS98vpYFY
	hBsZAECgEb/w8GPOcmzw5lEQ4ZUFlrKwttU4bWaPtMRXopnT+7z0Qy+CPqtIOKweyTB9oYC3Gxt
	A8d3PvZAJzMlX8ALEe+o5etleki0xDQFuI19gmPOdK1tULHU7G3PlMx1pMesalL+1tR7s5feTSn
	/uHzCe6dYg3SuVls3kgtBloWVtei4mukWhRtskFLfvNB+JTogDPwzBi0mGekEGVpuyIHkAdco6e
	NFSPELmGxwG+qnUuGiVLuRSDrv/dhfV9dM/5iLEmbPf+C1Nk33OVLYiUoq+WEqqPTHqZbjj/pfE
	iDvJW7pkYlmGAjP3XlRy4SIXL3K2ZkRAmNFcdb08WcmGM/g=
X-Received: by 2002:a05:6214:d87:b0:91b:a948:fbab with SMTP id 6a1803df08f44-91bdec2ea1cmr184223406d6.6.1792492715479;
        Tue, 20 Oct 2026 03:38:35 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040b4915sm23275556d6.26.2026.10.20.03.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:38:34 -0700 (PDT)
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
Subject: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 20 Oct 2026 06:38:27 -0400
Message-Id: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com>
References: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com> <QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com>
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

