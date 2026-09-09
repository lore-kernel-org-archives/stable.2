Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0D5678C6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980134; cv=none; b=jf9WFg5a8e/HAAS+fJ5P+F01N9Uk+5udSmUuFR9ioDyQWXuxMR/k3uGevmEmuvO8JHzwsmxMk5cOGtASQQax9rCMQN1A8SSxZsbQ1UhCb9NG0YeF5Qe+HKQPO7SYclCaH8/hbGq3Ezier4vTKQXFaTh6DuhbPJNZwj1EHRe2z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980134; c=relaxed/simple;
	bh=ChSjPFTvJ6Ue5qK9vpcF7gN1S321k9zu3rhAHXZq5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT5EXwD3G327+D8URh1/5zrGwbolnT4F9QdpcWAUDZI6WGCfU/0ypD3PBD2+p6Q1qabyUQMUcr4ajGaMgdosKSjKxcjsfnSXza79bIWOnscym7pu17zg1+sy8ZqovgUAiJhurnvk2zY7i7ZawfOf/4lqJ3lFop06kizIwp6x27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=CtNPNT0g; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="CtNPNT0g"
Received: by dvalin.narfation.org (Postfix) id AD929203EB;
	Wed, 09 Sep 2026 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788980127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/sjMBuxP81R+IC091sz1JCaWeXjuVDy6ncZueS2zMg=;
	b=CtNPNT0gnB8nMFUplwV+g3tZ+PWF3nzMo5ngXDMVrstSaZQjObh3NzijCD/O3tFbbwMAnA
	NMtDlRtkPPfHw+kApf3805+onJRVOHsWsm0ZZXQShhZuuPTxNxMFZFrtUuuCAqvGQqZ/Ig
	gWCFaRG9avkNwxQ0RiYVPZoj5s8ovso=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12.y] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
Date: Wed,  9 Sep 2026 20:55:24 +0200
Message-ID: <20260909185524.979838-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090932-fossil-parakeet-6fe7@gregkh>
References: <2026090932-fossil-parakeet-6fe7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7aedb59b80993c912ab45ce24386a2775150962b upstream.

batadv_mcast_forw_mode_by_count() pushs the skb->data for BATADV_FORW_MCAST
forwarding via batadv_mcast_forw_mcsend(). But the
batadv_skb_set_priority() expects the ethernet header directly before
(skb->data + offset). With the moved skb->data, just some random data would
be accessed to get the priority data.

Move the batadv_skb_set_priority() before the decision about the handling
multicast packets and potential header modifications.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index aaebe74c1bc0a..47715a612320a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -271,6 +271,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	batadv_skb_set_priority(skb, 0);
+
 	gw_mode = atomic_read(&bat_priv->gw.mode);
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw mode is off, broadcast every packet */
@@ -304,6 +306,9 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			/* WARNING batadv_mcast_forw_mode might add more headers
+			 * in front of the skb. and might even reallocate the skb
+			 */
 			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
@@ -321,8 +326,6 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
-	batadv_skb_set_priority(skb, 0);
-
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
-- 
2.47.3

