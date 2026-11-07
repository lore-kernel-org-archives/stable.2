Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047912;
	b=Wc5ii9Sv3i3CWbVCd7750/qel+/m6NHRQTlcvWyo9Mcs0RHhbxmXntwGmnvm/lmYgAQN
	 iTXO1kbdLZCb4pHQsEfEw69i0jadZ/PVqeEyug0bkl/9+v0OMVHOmKwmy2H1oykbPVIY0
	 KgePCOziMIgsklR7aiZGA9TBBcHiMauhewW3VL8vlsOjD/CuAe9KTUqdmbU1Fn6E5/m1Y
	 xAMsKHpQKNW6aOZ1Mr4XfV4DUBtPN0vKes96Cj9qUcIHrkeNMbdsFSeyESMUzWa8qGQhD
	 O1/emBYUFMw1eVHfYSM21DoZ+ZyOo8hDyRsrxq9sGDsUi2D+tNzWgAnBrpeh33NM/iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5Pc5iA5kqFB1c0Y8/88Ab5qRN0UPl/HiceDUSuhx8tY=;
	b=hcl39XbHCVh2DoUGWRoJhis4yjc/bysQWAiaXiQAlHSc7hNtTUBkNeciwLFRSxBBYi85
	 cOHVBPkqsjnmS6dfEAUGxygxzW6OORkH7V+PCRtHTl6Vdc7zijlQXA0tPIf45ju9hlFBq
	 26Hj1yZfwgY60PkR1qIRifEGHVvzHZKD8F7OIVrXoIW1H/qyr86FOmMq0aqztmiZVCJpy
	 sO+6Je00HKIzAaY86Cotd+g1dafZuqj4gb4qs1bzVuwz/SAp6Is1JWDEBLZ2QMGgPR0Jg
	 htcBOFWvievmNXDQHcF1OmpF0HslSJZ8n8tpEgL/T64JbNwo8ZjLccF/lgJiuyQ6Nkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM4IPsin;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C12606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM4IPsin
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0D1F008A5;
	Sat,  7 Nov 2026 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047911;
	bh=5Pc5iA5kqFB1c0Y8/88Ab5qRN0UPl/HiceDUSuhx8tY=;
	h=From:To:Cc:Subject:Date;
	b=aM4IPsin/zygF+z3n+Ed+EOhUxXcehgXeaIrkDzfIT2vZDQe3QvVJ+ip8ngwbYOnN
	 Thmr270d2FNh7hAJ+3wJ/XBAhEgS1etxiKmJJ7Y4eUfsBb/ECZUQzVU4XXbv5ChlIU
	 5v5ZsghVFvSvEAXW2TSMOUD+x4xhAUbpTc5fWwT4ay/9P23BrQmmEYDTfb7CYD23pj
	 Zm8DT72K0Ycpi6AaTb0hsv0i/RsxAl6hF/fZ2EuMG+JRI3rylizGniXXuGU80F4nDd
	 OAu2OPQSFtu9RXQsjwWcKQ2TC+3CaYVyIRXZXDus3CDH7jNksiKwAmqqh1xwwmq8X1
	 DPp65cEKWLe8A==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	edumazet@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: only copy pktinfo to cache reports" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:30 -0500
Message-ID: <20261107053830-failed-6.6-94a6736bb5ab@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053830-failed-6.6-94a6736bb5ab@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




