Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59A424D64
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809323; cv=none; b=ZRItx9sn68/ePsFx6ueHaprha/kddDpT2JguiUh3Sx7yw2oheA/aFz6ZW3slBZ2QQwSo/gPxTLGi08wmpiA8M4p1pSiTigRFzklRK2If/MS3vLQPFFrT+0hvMZrKl9ZXIRJgHwdJYdSgdmpa0KuDewntqeEAmwNpQIEruIKUEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809323; c=relaxed/simple;
	bh=yZ3pKQNC0tPvkjM+vVpvbFR+R3Sm4sRJbZ1EvlTrxFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPriQB0EGV6um2X1r/UogQwObuL7AkeTTTXQ7Uj9bb7NDqx5aAGNKeeSSnb9yll4MJSCbW3MctWHjLcyr874RaivyfXsC/zjvXMlOTTd3MZrHidFs2vg+NV6UsL0Xj9Ar41rWti0nfy52qvXY52RJbqfIzt+1gpl8j3Ijct1Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ1GxjHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ1GxjHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E881F000E9;
	Sat, 15 Aug 2026 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786809320;
	bh=xVXl6IFooS+7eslXFEGhs//PEMlsN3JeEkrWxmCiDCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQ1GxjHOWGA9FmvM416PV/IizOzvI5tuHefEt12mUjID1YqrBoi74jiGgw/+qc06z
	 Dh2Mk0Ba5Y8EF3217hv4ErGHaKEIp81p820hJv3qQHvLvkt9kIbU0xC948xSTF9mVD
	 L9TQkAgJWyuiv2R0KHl9FT5tOFyBpSiGyquKnBeFn751Lmc2xhqgv5smGAYUHRZN7X
	 oBwLsiqp/gA1jOS/mgh0e2A3l9W1JkOyhTe97d3RxNGfaEKgqmzcwX//BEwpju8BRX
	 D3ppAk04TtRIXnTSrxaDhmBTmOLNVoM+lMG1QxpI0qgb1mBAYnlhfzChscrA2LEUgY
	 4sJ+cV7zjJM+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()
Date: Sat, 15 Aug 2026 11:55:17 -0400
Message-ID: <20260815155517.786060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081349-dropout-afoot-d502@gregkh>
References: <2026081349-dropout-afoot-d502@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 3874892dd27d5387aa9a06f58d9060f18f351d24 ]

The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
dev_parse_header_protocol when skb->dev is null") fixed a crash in
tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
This is required because virtio_net_hdr_to_skb() may invoke
dev_parse_header_protocol(), which dereferences skb->dev. Without the
assignment, a NULL pointer dereference can occur.

However, tap_get_user_xdp() still parses the virtio-net header before
assigning skb->dev. When the vhost TX path passes an XDP buffer containing
a GSO virtio-net header but the protocol is set to zero on purpose,
tun_vnet_hdr_to_skb() can reach dev_parse_header_protocol() while skb->dev
is still NULL, resulting in a crash.

Fix this by looking up the tap device and assigning skb->dev before calling
tun_vnet_hdr_to_skb(), matching the ordering already used in
tap_get_user(). Preserve the existing RCU read-side critical section across
dev_queue_xmit().

Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
Cc: stable@vger.kernel.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260802224612.264563-1-dongli.zhang@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index c460b1f39136a..b3cb7d5a95850 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1199,10 +1199,21 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_hdr(skb)->h_proto;
 
+	rcu_read_lock();
+	tap = rcu_dereference(q->tap);
+	if (!tap) {
+		kfree_skb(skb);
+		rcu_read_unlock();
+		return 0;
+	}
+	skb->dev = tap->dev;
+
 	if (vnet_hdr_len) {
 		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
-		if (err)
+		if (err) {
+			rcu_read_unlock();
 			goto err_kfree;
+		}
 	}
 
 	/* Move network header to the right position for VLAN tagged packets */
@@ -1210,15 +1221,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-	rcu_read_lock();
-	tap = rcu_dereference(q->tap);
-	if (tap) {
-		skb->dev = tap->dev;
-		skb_probe_transport_header(skb);
-		dev_queue_xmit(skb);
-	} else {
-		kfree_skb(skb);
-	}
+	skb_probe_transport_header(skb);
+	dev_queue_xmit(skb);
 	rcu_read_unlock();
 
 	return 0;
-- 
2.53.0

