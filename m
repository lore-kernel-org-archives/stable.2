Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046432;
	b=L3/4buaJt+VppkxLrD++7rWIZ+6qQD7KmK9aHa0EqtzuG65JWx5tIQ6LsAq8elnyPFTw
	 qaq0btK3t+U4kxmDdElxyd1URyNxdfU6BQugBPy5pq7MoqLfoLgjhunJ2MJusPW4OoBxr
	 WED06d5RZpgQjyE1OYCZxvxJImUP76HgSeEHldMthq+TUcGdO0b2mOuvz74FZB4HQY7J7
	 /uA6abjk+VZORsQGJhY4jp587rqgoLCf9mSst/E9C78sCsSYXdbPU3J6HMWtDAntAjc1k
	 +NbBK7hho1/XDv5WcAVB2u/tWwTvMIQs27QUEt4c52dgNwkNlQ8hwIvtctyokS/nbkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zRGoslc16QJshxNVapc4oY2rUAlwfGNPAzElDRC25Rk=;
	b=Gas5cwxuh6ULJMTR9tAVIxDm0CpzpmYvC7sqcFnEHM3q9wwUBYiHYz/FhZklImH6gJvb
	 olDxUbxpec2yMpIBBR/jHdhF9m0n98inOpujmyDaTo/CbNbXe17l2foktn9Lv47bBil+L
	 bXyIFYP4JFJ3Fi1YpDJd6GVDWmgk0qihxAvv5GJTvI0erCBM6c21MFah7LF0IphiCc2Dc
	 EubIVzHsz79xnFAnX2lPcZXGVI7bx/rj+f3puRG9GgHJTHGIt+vnU95djQAIptDYBlegL
	 ybJsFjlA0jlYbFHaz3YfXu0vBWiouvSR0IgOlf5cL/oIhFwzY/gaUOGvcr0Vv5Q8dOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6o5+LN9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09531606A33B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6o5+LN9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C7D1F008A5;
	Sat,  7 Nov 2026 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046431;
	bh=zRGoslc16QJshxNVapc4oY2rUAlwfGNPAzElDRC25Rk=;
	h=From:To:Cc:Subject:Date;
	b=c6o5+LN9Bpc+qNmIeT3Cg0RfI66IcV4pODI+d9tQJkGgW9UrD8ATX75BUXiYyQ4Pt
	 eEShFLLTI6KMLOJ3mpJrfv+htoCOugOU/7jekoDuMrotTf3A9UnbEpuiomhSXUN02E
	 5Nl3DsshTiriRWfyQ04lSU00/z06FerX8HVaJ0ISeGpBRso4cMzv1imZ+YFruAEahe
	 P1ojwwEAb5hf+bE6v0N3bwH2FUAVrOsW+wcgLdsGiw/brLIWFHNcRyO5Ri95R6RpBp
	 UYmorfmpKo07PXSuFYHd59JXO1YvunOcuJFz7QGeskPYrZQLKEcBwSt4j9Sm/8PPle
	 8IUmqELLPVweA==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	edumazet@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: only copy pktinfo to cache reports" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:50 -0500
Message-ID: <20261107051350-failed-6.18-94a6736bb5ab@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051350-failed-6.18-94a6736bb5ab@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Tue, 20 Oct 2026 14:39:36 +0800
Subject: [PATCH] ipmr: only copy pktinfo to cache reports

ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fields
when packet info is disabled. Since the skb can continue through the data
path, preserve and restore its original control block around the helper.

The original implementation copies the entire control block to the report
skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted as
IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled,
corrupted option offsets cause out-of-bounds reads or a stack buffer
overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
offsets when their header is prepended.

Clear the report skb control block. Only prepare and copy pktinfo when the
input skb has an IPv4 header. Synthetic route-query skbs use NETLINK_CB,
not IPCB, so leave their report control block zeroed. Restore pkt->cb after
preparing pktinfo for regular IPv4 packets.

Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/ipmr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e4c51ca473019..acacaae05cc49 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1063,6 +1063,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
+	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
@@ -1118,8 +1119,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
-		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
 		/* Add our header.
 		 * Note that code, csum and group fields are cleared.
 		 */
@@ -1130,6 +1129,15 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
+	memset(skb->cb, 0, sizeof(skb->cb));
+	/* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
+	if (ip_hdr(pkt)->version) {
+		memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
+		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
+		*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
+		memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
+	}
+
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
-- 
2.53.0




