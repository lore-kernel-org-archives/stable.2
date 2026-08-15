Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDF1EB5CE;
	Sat, 15 Aug 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784161; cv=none; b=YMMOBFxQAe0hqjbA0UdEfUfaOG9FXY96kfVK2zdrzav7blxCFpII2eSM9tL2eC9H10XxLkQCSqBJmjndCw/m5C4tlMPB4WGNP+MPWbvpsE8ub+7jUiIrvJ0zSSGeToac0ExtVLLDoiuOrXheMpy1yM+iSTm1UzuB8LmsUfrwHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784161; c=relaxed/simple;
	bh=BRlIggHbTvXBM2XSLbSkUaCyObrjq1mhAWG5T+lAS34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHAVeQ1u3cRY+agJtzX9sognkE5RPzWuzyGIAxyp4UtSjGejdnzS/NKH+vHdIqKp1relXxGA9LzMviZf8fnJp9ReV+q1w/7oP2CmvIzv5wCdZdRO2FNK1zpOW8NdPyaVWpf2+C4XECrTcuzTcgCOow2/f0IFGg5DENxbwvkp4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=xU/KeOJX; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="xU/KeOJX"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4hMXlY3bpkz9tgp;
	Sat, 15 Aug 2026 10:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1786783625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PbQ90j2kAuPiWido4lOkI3CNrmzSoKgP2rPbn7JjGsg=;
	b=xU/KeOJXq5CJ2TSZWFkZjaEY9DQ1T7VCqSAkiUBUJRWOBhFEtwiYc7o1rd/SF6kkhxPvNS
	gWQzAs19IyLZ+5+CmJbh5RSRll8/W8fr/NRKbDeOdruVTjWNJFGE8p7A1AxjEYKNBalyxy
	yH1h4zi76LWR+YeVYHy5HUMJGH1sYY6tvqThu9/5UW08nEZGbVIJ71uJgPIdT5DwCEeX/V
	LcXYKMm9SDFVNgi2iz5C7VO0gj49calqq+VYQgW1UEtLSWkyPqSG2sNx4MlcREFBan3zCK
	v3qdwsBtxl1FABJBqL4dLhqeZZu4T0r35/aNCmbaDH+TZZwWtQSttHHGh6Xtmw==
From: Ralf Lici <ralf@mandelbit.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Leon Romanovsky <leon@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/mlx5e: Advertise MACsec offload only when supported
Date: Sat, 15 Aug 2026 10:46:29 +0200
Message-ID: <0a27c8b7308121fd00c528fc99fc3866782d3990.1786783174.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 339ccec8d43d ("net/mlx5: Enable MACsec offload feature for VLAN
interface") added NETIF_F_HW_MACSEC unconditionally to vlan_features so
that VLAN devices could inherit MACsec offload support.

mlx5e_build_nic_netdev subsequently copies vlan_features into
hw_features and features. As a result, all mlx5e NIC netdevices
advertise MACsec hardware offload, even when the firmware does not
support it and the driver does not install macsec_ops.

Move the vlan_features assignment into mlx5e_macsec_build_netdev, where
NETIF_F_HW_MACSEC is enabled only after the device capabilities have
been validated. This preserves MACsec-over-VLAN support on capable
devices without advertising it on unsupported hardware.

Fixes: 339ccec8d43d ("net/mlx5: Enable MACsec offload feature for VLAN interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
The issue was reproduced on a ConnectX-4 Lx: ethtool -k reported
"macsec-hw-offload: on", while creating a MACsec interface with "offload
mac" failed with EOPNOTSUPP.

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index daff53ba7d09..9a3850457bd2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1724,6 +1724,7 @@ void mlx5e_macsec_build_netdev(struct mlx5e_priv *priv)
 	mlx5_core_dbg(priv->mdev, "mlx5e: MACsec acceleration enabled\n");
 	netdev->macsec_ops = &macsec_offload_ops;
 	netdev->features |= NETIF_F_HW_MACSEC;
+	netdev->vlan_features |= NETIF_F_HW_MACSEC;
 	netif_keep_dst(netdev);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f0407a850ea8..cb8ebca58ce8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5851,7 +5851,6 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->vlan_features    |= NETIF_F_SG;
 	netdev->vlan_features    |= NETIF_F_HW_CSUM;
-	netdev->vlan_features    |= NETIF_F_HW_MACSEC;
 	netdev->vlan_features    |= NETIF_F_GRO;
 	netdev->vlan_features    |= NETIF_F_TSO;
 	netdev->vlan_features    |= NETIF_F_TSO6;

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.55.0

