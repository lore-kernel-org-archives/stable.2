Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BA3019D6
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773739; cv=none; b=fOX+II/UyS9gcbehR53vnjsKJodL8Zg4w8ncN4ZGrC1iDRyQTduf3JmrrgTAMUFpXMo9PiR7uj5xXclEV3Mc6KFL1yfz/AN/T9f+rYFbeGAlaHOhPC+SE87WJgPksYaadvFFOj7BDBHPjwKJE5ZN27Qnbb1Y+MG1cY4ExNj3M/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773739; c=relaxed/simple;
	bh=dXg7xPdvZsI9PalRF+0olVJULy2JQL+UHEUdX9spv0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfBk5aas5vSUiLZ8PoRo+oNMEsg8mKby0OHAEsQafp6/O8kG4/1yT1F5xtKhCxVAsQqrHQi72Niy8fZGXj1ARFeRSTYzf6vktaGx4PRVZ3kY6aUt8l/4GUOCUwqHV6cTeO3ZHug+9QcnhUmXdITCR2t5/hRnpr6lir2EKbdS3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVMutv6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVMutv6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAF71F00A3A;
	Thu, 23 Jul 2026 02:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773738;
	bh=FNhud1wuQY8mYGfzNRU5SFRv9h1NpKtcboN6NanKhOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVMutv6vyYSWIvDRlm5XrjY8oBr5oiXtxAR/msnzziZ+RefRRyw4CwItLN/HMaD9C
	 85T1l5csSt3NvfRQLAfNqsyxslHoqjzaJrSq3E9TUNhUfoTo9zbaMKESTEESTzpKQ1
	 eZ2hBRgCYQxhzHBmdfeF2kAP7RtVYbqRmv17LO6ZtlImiGA2km89h0bWTIKyYHCjE5
	 w57lAqYXus4PW4CHjI8rLWIdLGdaPdfFPao03wSh3afvbyH+p+PkQiCPGRZKbmEXWH
	 WZWunh3N2qd8eNybFANk5ZfSOY0eraho99CkxmnSfEs7UG4NegWOA8OqzANfbs1wW5
	 QFy3KP3M6LIoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mlxsw: spectrum: Apply RIF configuration when joining a LAG
Date: Wed, 22 Jul 2026 22:28:54 -0400
Message-ID: <20260723022856.2844792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072025-thirsting-chance-450b@gregkh>
References: <2026072025-thirsting-chance-450b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 31e1de4f1242f338eaa62cc53d582116c83b9dd0 ]

In case a router interface (RIF) is configured for a LAG, make sure its
configuration is applied on the new LAG member.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 41c8c1d65b32 ("mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 17 ++++++++--
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  4 +++
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 31 ++++++++++++++++---
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 8ab7e591b66af9..f8d15a76eede69 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3550,7 +3550,8 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 }
 
 static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
-				  struct net_device *lag_dev)
+				  struct net_device *lag_dev,
+				  struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	struct mlxsw_sp_upper *lag;
@@ -3586,8 +3587,20 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (mlxsw_sp_port->default_vlan->fid)
 		mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port->default_vlan);
 
+	/* Join a router interface configured on the LAG, if exists */
+	err = mlxsw_sp_port_vlan_router_join(mlxsw_sp_port->default_vlan,
+					     lag_dev, extack);
+	if (err)
+		goto err_router_join;
+
 	return 0;
 
+err_router_join:
+	lag->ref_count--;
+	mlxsw_sp_port->lagged = 0;
+	mlxsw_core_lag_mapping_clear(mlxsw_sp->core, lag_id,
+				     mlxsw_sp_port->local_port);
+	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 err_col_port_add:
 	if (!lag->ref_count)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
@@ -3920,7 +3933,7 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 		} else if (netif_is_lag_master(upper_dev)) {
 			if (info->linking) {
 				err = mlxsw_sp_port_lag_join(mlxsw_sp_port,
-							     upper_dev);
+							     upper_dev, extack);
 			} else {
 				mlxsw_sp_port_lag_col_dist_disable(mlxsw_sp_port);
 				mlxsw_sp_port_lag_leave(mlxsw_sp_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 3e7576e671df87..4f0af7636344ba 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -665,6 +665,10 @@ mlxsw_sp_netdevice_ipip_ul_event(struct mlxsw_sp *mlxsw_sp,
 				 struct net_device *l3_dev,
 				 unsigned long event,
 				 struct netdev_notifier_info *info);
+int
+mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+			       struct net_device *l3_dev,
+			       struct netlink_ext_ack *extack);
 void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan);
 void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index e22ee1336d7421..3689b0ec982237 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6675,9 +6675,9 @@ static void mlxsw_sp_rif_subport_put(struct mlxsw_sp_rif *rif)
 }
 
 static int
-mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
-			       struct net_device *l3_dev,
-			       struct netlink_ext_ack *extack)
+__mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+				 struct net_device *l3_dev,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = mlxsw_sp_port_vlan->mlxsw_sp_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -6742,6 +6742,27 @@ __mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
 	mlxsw_sp_rif_subport_put(rif);
 }
 
+int
+mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
+			       struct net_device *l3_dev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port_vlan->mlxsw_sp_port->mlxsw_sp;
+	struct mlxsw_sp_rif *rif;
+	int err = 0;
+
+	mutex_lock(&mlxsw_sp->router->lock);
+	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, l3_dev);
+	if (!rif)
+		goto out;
+
+	err = __mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan, l3_dev,
+					       extack);
+out:
+	mutex_unlock(&mlxsw_sp->router->lock);
+	return err;
+}
+
 void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
 {
@@ -6766,8 +6787,8 @@ static int mlxsw_sp_inetaddr_port_vlan_event(struct net_device *l3_dev,
 
 	switch (event) {
 	case NETDEV_UP:
-		return mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan,
-						      l3_dev, extack);
+		return __mlxsw_sp_port_vlan_router_join(mlxsw_sp_port_vlan,
+							l3_dev, extack);
 	case NETDEV_DOWN:
 		__mlxsw_sp_port_vlan_router_leave(mlxsw_sp_port_vlan);
 		break;
-- 
2.53.0

