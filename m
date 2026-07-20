Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC923B4EA2
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555402; cv=none; b=S6opsH1/PG4jTbAorzarmpC8THIdfNpcPSoAx9jTlQ3IZArjpk3Gt6mTPSG9InNTtXELpVVY0GbrirfVPLKIhFSwNQLwvMpfoLLZq1Fw7WTkls7aP6MPqHXqFgelNbhkxzarh6VzMsWNv0kN1FrHGiG3nOuy1ZxuP2l5QANh8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555402; c=relaxed/simple;
	bh=g7fNv6W5/D0JGeurUUFypETtstzSWt2pBDHOYRF/uWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAkH+54X2KByFCFsEa657bHFNhL1hDjNu4XdTBvyv7EyoeYZCsqFVOfUd8qNLQAdH7F2Y6BJP3LXPmeeinRnNk1Wcrdk/OZEx+VfT0lTtBnza6bRdDNaSYISGVlFDJVSW844yk+klOK57lUkf/Eb8PmCr70XpqaBljQxTEg+dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=KTQw8NgJ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KTQw8NgJ"
Received: by dvalin.narfation.org (Postfix) id AAF001FE5D;
	Mon, 20 Jul 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784555399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzVmyWsEULvCCj1Hne2/Y/LnmDTscBBabRuW7ETcwSU=;
	b=KTQw8NgJoS1ASMQ2C33MINNxoFdfuvOBqo7UdYjsRQh4KjkAS4bQqIWZhuvQAa9IVMElLv
	vQg1gerI1ASKeTnzmZEOEp/gTr8COI+ktkzPPCD3F5SeievilhJtHbPGeS3NWav3FaZP21
	n7779TSbFFhD8ZBcXzl5FfMAdxIvHaY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 15:49:54 +0200
Message-ID: <20260720134954.703026-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072026-trade-smoking-ea24@gregkh>
References: <2026072026-trade-smoking-ea24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8669a550c752d86baebc5fdc83b8ff35c4372c0e upstream.

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
[ switch to old "mesh_iface" name "soft_iface" ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c           |  8 ++++++++
 net/batman-adv/soft-interface.c | 13 ++-----------
 net/batman-adv/soft-interface.h |  2 ++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 04a4638034d27..818d86abf771a 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -258,6 +258,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 void batadv_mesh_free(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_softif_vlan *vlan;
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -273,6 +274,13 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_mcast_free(bat_priv);
 
+	/* destroy the "untagged" VLAN */
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (vlan) {
+		batadv_softif_destroy_vlan(bat_priv, vlan);
+		batadv_softif_vlan_put(vlan);
+	}
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b46480ec7bd1d..05e9a4c5662ec 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -601,8 +601,8 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
  * @bat_priv: the bat priv with all the soft interface information
  * @vlan: the object to remove
  */
-static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_softif_vlan *vlan)
+void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_softif_vlan *vlan)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
@@ -1084,22 +1084,13 @@ static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
 static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 					  struct list_head *head)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_softif_vlan *vlan;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface == soft_iface)
 			batadv_hardif_disable_interface(hard_iface);
 	}
 
-	/* destroy the "untagged" VLAN */
-	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
-	if (vlan) {
-		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_put(vlan);
-	}
-
 	unregister_netdevice_queue(soft_iface, head);
 }
 
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 9f2003f1a4972..13709a5d23e3b 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -22,6 +22,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_softif_vlan *vlan);
 void batadv_softif_vlan_release(struct kref *ref);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
-- 
2.47.3

