Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E37206E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551432; cv=none; b=Hd9VgmQ1oOvN8bqq1uv1aC/aItxBQTksNjbXUV+rqVryywtsLjwH7n1NLy/eIFuPjaE0wYfRPrSnv4ngjcOFZEc0AxyZ1ktut/CTsO9GInMY2OjvMYCnC21oFm70lkBUziaJUOrRFX0eM764ZaeKJCfzCV4qCRevCt8ky7DY3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551432; c=relaxed/simple;
	bh=7aovCWkkOc+dzMWEj59f6rjGIeu6ynqcN/5mXFFrHIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X0zTJi2PNaWzydLFPSmKl3MQtMBSUD2h4gFp6iPF8EVeArkRg529NaeEH3/2wAsnXNowzI6YcEIHFJC4CSxrC6mnSv3jLPNW4zjNcWPUE4QOabWbb2P2kjLDHJDsFWjnK+osGf0m6q98PJy/ZEABl6zVelFSYZoOgRNckucV3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ume8iYjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ume8iYjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378701F000E9;
	Mon, 20 Jul 2026 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551430;
	bh=vIc07QYY/RFiH4/HxXAtnB/X9AWbrFJzRoCatdxep8I=;
	h=Subject:To:Cc:From:Date;
	b=ume8iYjXevAaP7V6oiJvr/a/jBHj+X4xrnRfBPT91v/OvCuy4pwOZBO2PD7IGnHwW
	 UxDguwDWiLaZF0ie/Toq1NwA9JLyQ+D8zK55r34RiHcVwTBz/B3Lvru8PTSDGRwleu
	 PnU0IKj8ww9/38lB2BW7VD5RN2Ck+IxwGzozBjY4=
Subject: FAILED: patch "[PATCH] batman-adv: clean untagged VLAN on netdev registration" failed to apply to 6.1-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:43:26 +0200
Message-ID: <2026072026-starboard-problem-44f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8669a550c752d86baebc5fdc83b8ff35c4372c0e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072026-starboard-problem-44f9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8669a550c752d86baebc5fdc83b8ff35c4372c0e Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 4 Jul 2026 09:46:09 +0200
Subject: [PATCH] batman-adv: clean untagged VLAN on netdev registration
 failure

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

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 8844e40e6a80..67bed3ee77e7 100644
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
index 0b75234521b6..fbfd99268de4 100644
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
index 53756c5a45e0..5e1e83e04ffb 100644
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

