Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF51E9919
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769407; cv=none; b=lkIRQHXC9unK9ANhue2z+PC8fKYsBxPHeZbAMTdRADCSUmzcOo2h7hsyabsPX4VIjTPMa+5G06FIC0DTQLjksTA2v08kv2jxlfEYiyu3elFtlEw9svO3s9ABp+/8+cw4OsNwfPB0C23YE/HY5+u4S0+dHkosUbsAm8pWvh/Qm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769407; c=relaxed/simple;
	bh=kN0s+Nmrw4CAr3zo6cyQWxPDtvRrgBevoqLCQZjcI30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSBU+m5++nHtArgmolrPmZbuylVbP9KoPz9iGgqFOTlt5rKZal0ywegDCUaHaVXII6jhh7m3XI+eMvyvadt1xBVB4vPiCgDhj9N1Wqeu/07jMuNFZkX5G6wdRV2uqgYa3v2Receg7dtV+/CporLVhTB9XGeUOUGlUECLDOroajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCX/LIwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCX/LIwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A30D1F000E9;
	Thu, 23 Jul 2026 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769406;
	bh=A7/dkpuMLV6UmhW0R2brKifHZEpNsgygcJYyw9KC+TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCX/LIwbdoToS7nfgwZ+9iRSUG8ZYsQ0+K03D8SWxjeaPLd49vxOMn2X1T16kZaAx
	 DdNWbC5wohd2KdDoDksbDLEtmJTEPX9nwA6eZe6JEtsO2CJdUBG7vfHEGxiRUM9I8c
	 GTC84dCkOjBhWO/1+Yiu89IRczwHVbyF/ETIuoGg/uAOz2kLsnHRcL3xjPAE00UjUF
	 n/x9SXNomNbbzOcN9xTBH9Pdlvm56+N+BVmaiVqZtdTT8HvhuyA3nLik8fKFiwbu3s
	 3XmIDON1xVNlG2rOBeY4Ome9otFjri4LIPcUfAjmwLthJkKXyr+wnkPWM3GKxGVoZf
	 BCloQsqf7yStg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
Date: Wed, 22 Jul 2026 21:16:42 -0400
Message-ID: <20260723011643.2779021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072025-extended-consumer-8888@gregkh>
References: <2026072025-extended-consumer-8888@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit 987c7782f0627e1c87617458806a7e6c1995678a ]

Currently it never happens that a netdevice that is already a bridge slave
would suddenly become mlxsw upper. The only case where this might be
possible as far as mlxsw is concerned, is with LAG netdevices. But if a LAG
already has an upper, enslaving mlxsw port to that LAG is forbidden. Thus
the only way to install a LAG between a bridge and a mlxsw port is by first
enslaving the port to the LAG, and then enslaving that LAG to a bridge.

However in the following patches, the requirement that ports be only
enslaved to masters without uppers, is going to be relaxed. It will
therefore be necessary to join bridges of LAG uppers. Without this replay,
the mlxsw bridge_port objects are not instantiated, which causes issues
later, as a lot of code relies on their presence.

Therefore in this patch, when the first mlxsw physical netdevice is
enslaved to a LAG, consider bridges upper to the LAG (both the direct
master, if any, and any bridge masters of VLAN uppers), and have the
relevant netdevices join their bridges.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 41c8c1d65b32 ("mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 85353042a790cb..8d1e7b018e9ac5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3837,6 +3837,88 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 	return -EBUSY;
 }
 
+static int mlxsw_sp_lag_uppers_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
+					   struct net_device *lag_dev,
+					   struct netlink_ext_ack *extack)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+	int done = 0;
+	int err;
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master)) {
+		err = mlxsw_sp_port_bridge_join(mlxsw_sp_port, lag_dev, master,
+						extack);
+		if (err)
+			return err;
+	}
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (master && netif_is_bridge_master(master)) {
+			err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
+							upper_dev, master,
+							extack);
+			if (err)
+				goto err_port_bridge_join;
+		}
+
+		++done;
+	}
+
+	return 0;
+
+err_port_bridge_join:
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master || !netif_is_bridge_master(master))
+			continue;
+
+		if (!done--)
+			break;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master))
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+
+	return err;
+}
+
+static void
+mlxsw_sp_lag_uppers_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master)
+			continue;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master)
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+}
+
 static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack)
@@ -3861,6 +3943,12 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
 		return err;
+
+	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
+					      extack);
+	if (err)
+		goto err_lag_uppers_bridge_join;
+
 	err = mlxsw_sp_lag_col_port_add(mlxsw_sp_port, lag_id, port_index);
 	if (err)
 		goto err_col_port_add;
@@ -3890,6 +3978,8 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				     mlxsw_sp_port->local_port);
 	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 err_col_port_add:
+	mlxsw_sp_lag_uppers_bridge_leave(mlxsw_sp_port, lag_dev);
+err_lag_uppers_bridge_join:
 	if (!lag->ref_count)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
 	return err;
-- 
2.53.0

