Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A123EAA6
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764019; cv=none; b=ZSkJX01ZwzUonM3zlMP+2QXdI4v6liZyUz7ErRenClFbiKrOyn4VI721lq+8th5GE0Xlc6BACO8sQQRBWAOoqHGnaIOxB6CwGz0IoiEp8Y7hdUBzpJaa1WnFmBUbxGKnQw5m/7DPyfF2MeyNTT0Qjk89drf8hf0yFOonLw/lHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764019; c=relaxed/simple;
	bh=2K9WpobqlYJCiJXxy5j9qZuFEkB66GC9nSVuCuGtLEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1bmylbA+HN+Gl4FZjXGMsDI1UIlxiMv+yA4K3Dgp7akjMFFczbi0fe2593Et+PJMzFbVJyoJ/LA6h5T/D+KF0PNUwHnVybjgOKEBbr+Y/3aIBLyZLXdN1XBvq+gLg6obDrYYsn/JFDdgqI9t2xqobobACkLCUGDD3MHP9phM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV2mpINn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV2mpINn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B1A1F000E9;
	Wed, 22 Jul 2026 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764017;
	bh=pLkISwJJ5WJ2kUPgDvUp77xrOitfNt5S2Wm/aAKIbmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WV2mpINn6K7Dt3Kb7sRaWzdG6FTpRDH782XsDbVMvrmxKRVi9qMnye700eTJFsyta
	 eYrraIy6fbvYV03AUKxVBEC8b5dA2qqVnK6InDUCYVepSh38hsJwUpMjA5UhupFxYQ
	 +2MXt7UY/YVrU5aDsdLYdSC957ZLglsP1dyksUgHEUxsMmFYluGYdpDl3xZaZHf61m
	 Jy21kPTcNZA5uXmu6xyJGCdZ4dXHxRsP4lEH6TXNLbe0vM64naG1lvw80h3i/2G6Pu
	 YEf2pICi1rQNkrggIyNXrr442r+ZRzlGFMx7QxfvNt26+xRL+t2sjIB4YDlQqMQ78A
	 iJOR17A4kkC1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
Date: Wed, 22 Jul 2026 19:46:54 -0400
Message-ID: <20260722234655.2612015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072025-willpower-discolor-ccfb@gregkh>
References: <2026072025-willpower-discolor-ccfb@gregkh>
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
index 2aec55dd07c666..2560bbf5df74b2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4357,6 +4357,88 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
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
@@ -4381,6 +4463,12 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
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
@@ -4410,6 +4498,8 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
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

