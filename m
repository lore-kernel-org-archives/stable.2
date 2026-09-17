Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC94E4314;
	Thu, 17 Sep 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648088; cv=none; b=tF5DR3Kc9TIrWJweC55HFwD3fKn0NivLI1XHv3rgjrkYQyGXJ8i65w/53+wm2yUjGoaO06jXJPIAmRi/69sqc1DeHmFbVTsYbUpyE6QJw71G5EFmf3UYCOdLVeRVkbWi53sEYPcw8kxqm2o7NrQPZ1Armw2bXVlf+OTq9DgE4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648088; c=relaxed/simple;
	bh=/uqgZPPn4hNbKiFhEuoJhBmLAX3/qowM+46x249WfEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxFam8d4YDkT5K8s6crCwELYtlXSsoXXF9QL1S3q5iMn3Mc7jDtMgJCoGQTP8Rk1jW16FtY6WA9sdVbVVzKhbcZIGVo7ayLaf+T5YuFyi9ZYlALAZNyUaO+GbzD0ElBWDO3p3wAgsXpmnkVJ4Ui6vIv1N10zgLPv74DEr3FMdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=cjQu6+B4; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="cjQu6+B4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hlw4s1r72z5xBW;
	Thu, 17 Sep 2026 14:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789648061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDxh/p8SFg2ydcVJyonwxD2khfmofoSAkIYRAIVB6h8=;
	b=cjQu6+B4MJnt5Nt3yLAvFKi3C5w3z9aYKFVGXMT6Vgs7dQm0JS16xmEOKxjf2+l39PXHVV
	x7dz7NF/vLtt09sm2ZIPQtKUXFJ1lSXl83eTGZkagvhIlCoJ/WtpbVHC/IPaoCdnz5fBeV
	2evFVyMgBjpg6AryQJwHLwbtJCuixmYBknXREGd4MSrrIq4FLmqkZ04t4Zo4EIxnXCMCl5
	a/0KfQhQgxTivslviaJ5oyh4FXVz3oIUtZBtd2M/16+LWKijpOKGGI9mtt6baBnMx0k1sw
	oMLqNURB2ukbSU3uklY0Y3uVjEQ252cdLXSnmF0uts+NGA8Z7zk+x0citzXgNA==
From: Ralf Lici <ralf@mandelbit.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net/mlx5e: advertise MACsec offload only when supported
Date: Thu, 17 Sep 2026 14:27:23 +0200
Message-ID: <20260917122724.654639-1-ralf@mandelbit.com>
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

Set the MACsec feature bits in mlx5e_macsec_build_netdev, after device
capabilities have been validated. This preserves MACsec-over-VLAN
support and the ethtool feature control on capable devices, without
advertising either on unsupported hardware.

Fixes: 339ccec8d43d ("net/mlx5: Enable MACsec offload feature for VLAN interface")
Cc: stable@vger.kernel.org
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/netdev/1b7ebced14243c1b342923a25bcc44ec77c45907.1787086511.git.ralf@mandelbit.com/
- Rebase onto the latest net/main.
- Add Reviewed-by tag from Tariq.

Changes since v1 https://lore.kernel.org/netdev/0a27c8b7308121fd00c528fc99fc3866782d3990.1786783174.git.ralf@mandelbit.com/
- Set NETIF_F_HW_MACSEC in hw_features as well, preserving ethtool
  configurability and restoration after an eswitch mode cycle (Sashiko).

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index daff53ba7d09..38a3415acf7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1724,6 +1724,8 @@ void mlx5e_macsec_build_netdev(struct mlx5e_priv *priv)
 	mlx5_core_dbg(priv->mdev, "mlx5e: MACsec acceleration enabled\n");
 	netdev->macsec_ops = &macsec_offload_ops;
 	netdev->features |= NETIF_F_HW_MACSEC;
+	netdev->hw_features |= NETIF_F_HW_MACSEC;
+	netdev->vlan_features |= NETIF_F_HW_MACSEC;
 	netif_keep_dst(netdev);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fc110a7d16e8..4c6060d54fbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5851,7 +5851,6 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->vlan_features    |= NETIF_F_SG;
 	netdev->vlan_features    |= NETIF_F_HW_CSUM;
-	netdev->vlan_features    |= NETIF_F_HW_MACSEC;
 	netdev->vlan_features    |= NETIF_F_GRO;
 	netdev->vlan_features    |= NETIF_F_TSO;
 	netdev->vlan_features    |= NETIF_F_TSO6;

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
-- 
2.55.0
