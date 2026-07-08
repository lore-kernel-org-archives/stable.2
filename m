Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00291409127;
	Wed,  8 Jul 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502738; cv=none; b=EsrkkBVMxYWKjTISTS4X0oRzzotYHznxAd2cepV9Rqakr+FX10hFL6vFbqMPbLG8qridxh1bB4Y2/e9UjSMJZo1LCWvuMz/IFW31CVq3oibc6g/SvTUgFi6Zv3iD5ZGlo4cttt4MyWgGPWpf6I8uECCdlloIpIozRlXEivyqScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502738; c=relaxed/simple;
	bh=I6JG3l5yadE4ni050YRFuLiJpYeSBeDZaMZ6ox/5iIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG3VCGV7S9Gl2bL6IXVxNC3JXDtOGTF6+yIrR+5ciPa6ztr4g5O6r/oWrQufMar1dJ3lzoqaWch8ZfWgAM8LSbwl6gRCOWdt4XRFWlq6rwQaR1hLXu2zzeEVjeWdyMitI0ZQJLXx1UK7ZasawAiAyKPX/AN0wMfvOlE4XyJ01Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=vtg7s09u; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="vtg7s09u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AMdxW44N2haoNqT9owFcCG9SY8E2sZKqXc4kIUckTo=;
	b=vtg7s09uKKic1UBT1uzejFiC7QPuFsBbHLSeebTB7+kWaNdQkoqkyLoly26gW2WAGPftda
	+Rai9PCNdEylgOR2YYaQ66PGuhpKj4yYyrV2U4jCKoui1TJSF8T9bwfEFpjvDeVB5tkv0h
	YCcrtw5wSu01TGhXeQxjriKm2rNZJ0JmblcLqKV3pEzPzRZD0760wYtmR+mqt+YPcMoz4H
	S9+CMxSzDi7q/nRhhGkCtA5/9QR8o3e7zy7CCqIFEHs8JlIZM2k2561wuFHgPa3GTVMnER
	ZYvvXdVty836cjlWd8o7LspXRqXVhDmMDxWmtPcGqsVijltodXx02QSre/4QoA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 3/9] batman-adv: clean untagged VLAN on netdev registration failure
Date: Wed,  8 Jul 2026 11:18:15 +0200
Message-ID: <20260708091821.314516-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When an mesh interface is registered, it creates an untagged struct
batadv_meshif_vlan on top of it via the NETDEV_REGISTER notifier. But in
this process, another receiver of this notification can veto the
registration. The netdev registration will be aborted because of this veto.

The register_netdevice() call will try to clean up the net_device using
unregister_netdevice_queue() - which only uses the .priv_destructor to
free private resources. In this situation, .dellink will not be called.

The cleanup of the untagged batadv_meshif_vlan must thefore be done in the
destructor to avoid a leak of this object.

Cc: stable@vger.kernel.org
Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c           |  8 ++++++++
 net/batman-adv/mesh-interface.c | 13 ++-----------
 net/batman-adv/mesh-interface.h |  2 ++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8844e40e6a803..67bed3ee77e7e 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -259,6 +259,7 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 void batadv_mesh_free(struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	struct batadv_meshif_vlan *vlan;
 
 	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -273,6 +274,13 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 
 	batadv_mcast_free(bat_priv);
 
+	/* destroy the "untagged" VLAN */
+	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (vlan) {
+		batadv_meshif_destroy_vlan(bat_priv, vlan);
+		batadv_meshif_vlan_put(vlan);
+	}
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 0b75234521b63..fbfd99268de47 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -595,8 +595,8 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
  * @bat_priv: the bat priv with all the mesh interface information
  * @vlan: the object to remove
  */
-static void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_meshif_vlan *vlan)
+void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_meshif_vlan *vlan)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
@@ -1091,22 +1091,13 @@ static int batadv_meshif_newlink(struct net_device *dev,
 static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 					  struct list_head *head)
 {
-	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_meshif_vlan *vlan;
 
 	while (!list_empty(&mesh_iface->adj_list.lower)) {
 		hard_iface = netdev_adjacent_get_private(mesh_iface->adj_list.lower.next);
 		batadv_hardif_disable_interface(hard_iface);
 	}
 
-	/* destroy the "untagged" VLAN */
-	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
-	if (vlan) {
-		batadv_meshif_destroy_vlan(bat_priv, vlan);
-		batadv_meshif_vlan_put(vlan);
-	}
-
 	unregister_netdevice_queue(mesh_iface, head);
 }
 
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 53756c5a45e04..5e1e83e04ffbc 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -21,6 +21,8 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 bool batadv_meshif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_meshif_vlan *vlan);
 void batadv_meshif_vlan_release(struct kref *ref);
 struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
-- 
2.47.3

