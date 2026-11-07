Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047134;
	b=eD+CFCYA7HbB33vPjg5xng/+MRcECyfJdCTF54HCibdwysl9ku3ZxtaZBUXI8ebDQH84
	 e5m96f2ePlfKLA53hCZogaO1lYDCF93mWcDEkTs8CrCvXMVAyOs1t9ZgXkV6xmxIUj86E
	 XmAkg28kErBMJ6cZeBQlFJKB2d9hzrg7+qODMJ2J4zSsb8HTWoRDV/zwaqifKUb56Iw+s
	 1xiVtEmjSykoX4mh34sqxTrRoG6t4c6mluD9DRO35R8iG96tvnc4I8qcVOzmQDmif4oUp
	 vnn9uuQeD1FLBRxFQchPmpo7LMexc5Hyq1kRfvaoZcad3mD1TzZLE3ci5bBFOU4M5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SStC4u2/aCSnHrpHKK+GXUpgu9CNPsF4IJaaOvj+Njg=;
	b=ZZYePlsLcsI57nuI0b0MzJh7l2MIPUw1BGjIMhZMl1PGok41+OGNMNloQGFNiRTROUas
	 z/oiXYzEyX01aalcuvRtYq2alMgAaleavzEgyCWzV+aWsr+bAFLcrNAFjY4xI1BslqdiI
	 //3KETlZiSd1PJXDgwuqAfNp5qyWU0rBTT4YZv4OKKPWC5aYXLUCDulbLvm4IxUbAuyFU
	 ipPncPABOx0zdI0yFYltne/ohmxgVSiaE7jKffujeVVeFdeyHdqHDUXvV3R8795K2ECEu
	 o+2540+/sfb632raM/PXH5OJPgG6oCotKaJeeMqKp/AfdboI1MjQRHiU6IS881jkryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNachpgx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F38606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNachpgx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E5F1F0089F;
	Sat,  7 Nov 2026 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047134;
	bh=SStC4u2/aCSnHrpHKK+GXUpgu9CNPsF4IJaaOvj+Njg=;
	h=From:To:Cc:Subject:Date;
	b=RNachpgxg3TyNr3GoqM9djcGA+/WrDPG38hFkSGBNyHCZ+KR/BwOjw/caxUkYpSsU
	 1cUR46wCAExgeVvOs/phkH8MX8UGUHbdzGQfD/D+562G9s6Hx6KwZd9Ee1MvTEObQC
	 s3Zv41AlOLJUYf5gDmrJ5ogXjk2H3sHrUL00GXU5BSAFKNBkuNCuU9/jooXXvpQUeF
	 /9mdWPXJKIUxqezxEsSedMCretCEvidLwNPDc9SDrDKqQashhOl4m8BZOdSztJVEBw
	 ibqYC4vGpf1y5vRZC4EGFOnfGBvpW8Isx83KB6/WME9Ch5d8SqntsS8GPHl8MsDrWg
	 VL3iO9r8CRXxQ==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	edumazet@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: only copy pktinfo to cache reports" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:32 -0500
Message-ID: <20261107052532-failed-6.12-94a6736bb5ab@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 94a6736bb5abe6b2ef38490d0cab19c1c6a7c71f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052532-failed-6.12-94a6736bb5ab@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




