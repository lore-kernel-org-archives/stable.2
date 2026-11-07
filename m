Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048839;
	b=lQvOqXeehMCxfD7NqZ+vLN2apRP747MQf2vfKAmEvvrRVvsbsdeYZs96BJXdBtKPT6kf
	 8Kb0MgNRpsGCTD09M9JZ9LdbpVYQumkeruA0hsqJaNpnUaijWH/ObpHoufAdTfCYytcpJ
	 MaCOx4NDqslb2ArVqvB2RNkRrsi+6MenJ3f3UZ5myvth3T4stfYAc6ozRGJdJIH0r1ud2
	 kB1auwIHaMXSiGNnUV6WsmL9QU3MQm01Ut1ESC/ovxcXcAfhZAH1yGwmAoW96o93ZuMAY
	 RAfQu9EknP3Vm2xGf7bLyaFDIwIq/SqNVPSZU999yG6Em54vz6FVCp6iPti7806i8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2M5WaaOl+EpCh6SnTdp3KxyapY1CBD7OX9u7y+pmDao=;
	b=uJnh6FPHVCOt/ZVi+EM5iS60mwSBBBIKb3hToncsSFMpEDsh9qXKePstuibxzmyDb4+/
	 Q74eDIwG72jD3cezqUf9/GVl/yaOmzc0NcK7cDbCots04XP2JJPfbsfMciBXEAKnNdJWZ
	 AcQk6BVURo/1FyW66IGZ4Rjg2666tDeGTwr/rzs7fujI7zwRKeAQeydMsFk2BcSRvMsxV
	 kaeAINdj3FtxuxZR1KgOa9Te3m2TFlogBvsYeZZ05AH0RC5AUop6SHJkJhJbyIdE33J5Y
	 RNlucFga1nAFnFMBT7OMSyDbosBu/j+pPmkzxqI0z6xFaTYSjMDAWO4Z6X7P0tjZrHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PC0k3MTA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CB606A338
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PC0k3MTA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D41F0089F;
	Sat,  7 Nov 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048838;
	bh=2M5WaaOl+EpCh6SnTdp3KxyapY1CBD7OX9u7y+pmDao=;
	h=From:To:Cc:Subject:Date;
	b=PC0k3MTA/5NiAK12mxdymoTPtH/qyYHJB643DDlKlQMJfJDrA+EzprN5hWvza8BDq
	 UK4nnbaeF168i9JppZ7hLG5qHUO6Xgs8Q+8a3VwOLQF1XWl2ldNzskoF3MhCv7uG25
	 5JNPIkrrMPa6uNJ9PL+M6a9I8TtdG1jtXE3gr5/bAF7ktTcd5BxbgDCesNxqGThHJc
	 gK0ZYz8zbkwE+aqmTRjc2OyBM4pBAO2ms7YaZyTvVMm1WXz30PXaJPS1cjJuhJH1R5
	 cfxGy3G+BWkyklIG8iIrVFSuHqtYVszeahQ4/d/2vd76sPU3IqJDKPSY/NdWQolSLB
	 PacijWs1LCyxQ==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	edumazet@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: only copy pktinfo to cache reports" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:56 -0500
Message-ID: <20261107055356-failed-6.1-94a6736bb5ab@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055356-failed-6.1-94a6736bb5ab@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




