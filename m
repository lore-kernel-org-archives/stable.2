Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9E332913
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624081; cv=none; b=ZuwkOUVLk5oak6+nNYyXf7u6J+zJh1dwOE5oGZ0nbvlzRP/W6sL/AWOhd0xzwuLfLuAe6CXaK2R/PHVf3cjLRpqGvkYKEfdHHDW3zhi3J088iU4xJSLERtUU7o1/8OGC2VlZH3K9vFoSGfDdT2t8bVJ+IFolUpjQVRGXGLFITeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624081; c=relaxed/simple;
	bh=RhK8NL7b9xdGUJkW4x2b9j4lGkV0bfQTRGxj0r9ifN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbgzNRYRsIAgSKTMELN+TdzQtBdvgiMDkc1okK91sfU5+YDq+ZZMeh4vfXUPJkRTTLemegyYtLtjdCoQzobdRqJH/yIPv2Enc7FLb/CurIpp+Uxsvm/307b/MXe+HFCSp2m78c0wYsCW6yuN4KTBD5zwRNR1se4V9ijwusJI6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BXGBARNU; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BXGBARNU"
Received: by dvalin.narfation.org (Postfix) id 756931FF0E;
	Tue, 21 Jul 2026 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784624077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIyvZ4E8xzieRl+wvjFJMXRC1jvpSJpA0ySET8NUcCE=;
	b=BXGBARNUh4pyKbByGlkAPyH1hbWsr/VqQSnFdm7hq/zumRY4lFahaWlu8o39Vr722iHdfx
	myvDYOGCsjxsZ7wcDsNf3pT+00gM+feXMwr6dlBC+2+2LLPvcKTW/TgT9OnZJgtZcAbEFc
	dzBl9DTMrRDmfnu1z4ARlRLPz8FfocM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10.y v2] batman-adv: clean untagged VLAN on netdev registration failure
Date: Tue, 21 Jul 2026 10:51:24 +0200
Message-ID: <20260721085124.995719-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072026-unmindful-haunt-2787@gregkh>
References: <2026072026-unmindful-haunt-2787@gregkh>
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
[ switch to old "mesh_iface" name "soft_iface", Context, keep early
  batadv_softif_destroy_netlink() cleanup in case sysfs support is active,
  only run destructor VLAN code on non-softif_destroy context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c           | 17 +++++++++++++++++
 net/batman-adv/soft-interface.c |  7 +++++--
 net/batman-adv/soft-interface.h |  2 ++
 net/batman-adv/types.h          |  7 +++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 70c373f5572e3..7b29f02749b51 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -265,6 +265,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 void batadv_mesh_free(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_softif_vlan *vlan;
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -280,6 +281,22 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_mcast_free(bat_priv);
 
+	/* destroy the "untagged" VLAN in case of an register_netdevice() error.
+	 *
+	 * It will be handled normally by batadv_softif_destroy_netlink() and
+	 * batadv_softif_destroy_sysfs() before they call batadv_sysfs_del_meshif().
+	 *
+	 * But when a veto was received during the registration, the VLAN has to
+	 * be cleaned up in the destructor.
+	 */
+	if (!bat_priv->softif_destroy) {
+		vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+		if (vlan) {
+			batadv_softif_destroy_vlan(bat_priv, vlan);
+			batadv_softif_vlan_put(vlan);
+		}
+	}
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c8c62b0cd54c7..9e46104538653 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -625,8 +625,8 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
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
@@ -830,6 +830,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->tt.last_changeset_len = 0;
 	bat_priv->isolation_mark = 0;
 	bat_priv->isolation_mark_mask = 0;
+	bat_priv->softif_destroy = false;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
@@ -1117,6 +1118,7 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
 		batadv_softif_vlan_put(vlan);
 	}
 
+	bat_priv->softif_destroy = true;
 	batadv_sysfs_del_meshif(soft_iface);
 	unregister_netdevice(soft_iface);
 }
@@ -1147,6 +1149,7 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 		batadv_softif_vlan_put(vlan);
 	}
 
+	bat_priv->softif_destroy = true;
 	batadv_sysfs_del_meshif(soft_iface);
 	unregister_netdevice_queue(soft_iface, head);
 }
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 53aba17b90688..2be563c54b0f2 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -25,6 +25,8 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
+				struct batadv_softif_vlan *vlan);
 void batadv_softif_vlan_release(struct kref *ref);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 79ffd25fd4eba..790f62abfe030 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1791,6 +1791,13 @@ struct batadv_priv {
 	/** @bat_v: B.A.T.M.A.N. V per soft-interface private data */
 	struct batadv_priv_bat_v bat_v;
 #endif
+
+	/**
+	 * @softif_destroy: whether the mesh_free() is called via the
+	 *  batadv_softif_destroy_sysfs() or batadv_softif_destroy_netlink()
+	 *  codepath and doesn't have to clean up the untagged VLAN (sysfs)
+	 */
+	bool softif_destroy:1;
 };
 
 /**
-- 
2.47.3

