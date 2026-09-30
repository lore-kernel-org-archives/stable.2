Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1F4E3245
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781355; cv=none; b=cSxsGw6nqmHJOvtwbMY9gMSFvwuPlylFowN5lFFsQy2A0ACOhQY7+uQjH/EPBOlOVbbmqZolFXYJ8qt5ZQfVS04g1ipnzscoPRcgs2zbxO4EpAeA3pghKpQ9lSOvZAYgAndwgNYKDk3n/F0187M/cih7ER0DjcpO7Fo3lSxYWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781355; c=relaxed/simple;
	bh=FEhz0xA8bKDFRX2pqkqDcuOKqfuBekninmbczxg2Uag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=et+hNJIEC5eV1dA1lxIMPoGSmmOJVsa9saj7iu8KyWXnzuRac5EeVqghQPO2K4Wlp+VySaWCWJhwvn8uAtT4YvZgsy0kd6OXJw/blXSMfqUbFY/aoLKhezImQI8mR6VqGYdTgOMHsXl15NLXUYiaPzVh0M8NaFDXSzrtDNk7gaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAd+cWQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAd+cWQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2901F0089A;
	Wed, 30 Sep 2026 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790781343;
	bh=5FWPaUjtGMCJLVYkoH1i1A8xxge2Fjnxkg3SmBY5bgQ=;
	h=Subject:To:Cc:From:Date;
	b=KAd+cWQaGy3ko7ietkG7GPS+g0tL2DStTXGLRGRfs7jEJU+uaI6XOHBwiy7XAgUKG
	 yjV6wEDuYF+YWazhYVMH5qmNKmNF87EWkdbjp2xboO57dD22P8zrOlFHK/EqnzXrrJ
	 B0dUvUwfDod24a92i5kG/9UKfNfrGMZ2LZCFdIv0=
Subject: FAILED: patch "[PATCH] net/mlx5: Bridge, fix multicast packets sent to uplink" failed to apply to 6.1-stable tree
To: moshe@nvidia.com,gal@nvidia.com,saeedm@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 17:15:36 +0200
Message-ID: <2026093036-scowling-eject-1966@gregkh>
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
git cherry-pick -x ec7cc38ef9f83553102e84c82536971a81630739
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093036-scowling-eject-1966@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec7cc38ef9f83553102e84c82536971a81630739 Mon Sep 17 00:00:00 2001
From: Moshe Shemesh <moshe@nvidia.com>
Date: Sat, 30 Dec 2023 22:40:37 +0200
Subject: [PATCH] net/mlx5: Bridge, fix multicast packets sent to uplink

To enable multicast packets which are offloaded in bridge multicast
offload mode to be sent also to uplink, FTE bit uplink_hairpin_en should
be set. Add this bit to FTE for the bridge multicast offload rules.

Fixes: 18c2916cee12 ("net/mlx5: Bridge, snoop igmp/mld packets")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
index a7ed87e9d842..22dd30cf8033 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
@@ -83,6 +83,7 @@ mlx5_esw_bridge_mdb_flow_create(u16 esw_owner_vhca_id, struct mlx5_esw_bridge_md
 		i++;
 	}
 
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	rule_spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 	dmac_v = MLX5_ADDR_OF(fte_match_param, rule_spec->match_value, outer_headers.dmac_47_16);
 	ether_addr_copy(dmac_v, entry->key.addr);
@@ -587,6 +588,7 @@ mlx5_esw_bridge_mcast_vlan_flow_create(u16 vlan_proto, struct mlx5_esw_bridge_po
 	if (!rule_spec)
 		return ERR_PTR(-ENOMEM);
 
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	rule_spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 
 	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
@@ -662,6 +664,7 @@ mlx5_esw_bridge_mcast_fwd_flow_create(struct mlx5_esw_bridge_port *port)
 		dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
 		dest.vport.vhca_id = port->esw_owner_vhca_id;
 	}
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	handle = mlx5_add_flow_rules(port->mcast.ft, rule_spec, &flow_act, &dest, 1);
 
 	kvfree(rule_spec);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 1616a6144f7b..9b8599c200e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -566,6 +566,8 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 		 fte->flow_context.flow_tag);
 	MLX5_SET(flow_context, in_flow_context, flow_source,
 		 fte->flow_context.flow_source);
+	MLX5_SET(flow_context, in_flow_context, uplink_hairpin_en,
+		 !!(fte->flow_context.flags & FLOW_CONTEXT_UPLINK_HAIRPIN_EN));
 
 	MLX5_SET(flow_context, in_flow_context, extended_destination,
 		 extended_dest);
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6f7725238abc..3fb428ce7d1c 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -132,6 +132,7 @@ struct mlx5_flow_handle;
 
 enum {
 	FLOW_CONTEXT_HAS_TAG = BIT(0),
+	FLOW_CONTEXT_UPLINK_HAIRPIN_EN = BIT(1),
 };
 
 struct mlx5_flow_context {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 37230253f9f1..c726f90ab752 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -3576,7 +3576,7 @@ struct mlx5_ifc_flow_context_bits {
 	u8         action[0x10];
 
 	u8         extended_destination[0x1];
-	u8         reserved_at_81[0x1];
+	u8         uplink_hairpin_en[0x1];
 	u8         flow_source[0x2];
 	u8         encrypt_decrypt_type[0x4];
 	u8         destination_list_size[0x18];

