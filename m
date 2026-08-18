Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC423D295;
	Tue, 18 Aug 2026 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087972; cv=none; b=hD1uUzpo9dS6n5dhsytV5zbzOYjg2YHZCbXuHgQyWtU6DZDIyQTMjz2hUp2bnlULpQ+nq3gJ0p8WmWpVzaIvvNLPKS/eKGC7o1qBugtoSoh431RmbeHhIRFDhq4PKL0mUkulr1RujSyAc/13B3gloLF/CfPI94cxNSXjZtsS0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087972; c=relaxed/simple;
	bh=kQz66puCRVnLyKOloizJFDK26uF8TvoSa7iWtnW1XRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/l4l4jGLP2IA8iOLFGaITT2vwaEpiYgpGS12bpK0QlfHKXsKQooIsUinCkJoC9V9cmSNN51m5EEvNw0rVvILU3C/c6ZXgs8VT4wToht56V5zqTWT7ftikapel1BwY57GSCeYzTGdMJUWVmqijaYp06iBp2OmwUaXGWp7Lt4Kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=aJIpaXrq; arc=none smtp.client-ip=195.10.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="aJIpaXrq"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hPj5g54wSzLlp3;
	Tue, 18 Aug 2026 23:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1787087415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Q3hDPXp0xk1P22OvHP1aQ20Ay86PDu6Al/V+H6iHXk=;
	b=aJIpaXrqgRbgJvUEIOfqpyZ/s28Z8p13Zx8IaLm9q/eQByw1p5RWZGXrU8BviWTOuC0Laf
	jjSya8Jp7TU+emxahfCFfQSLQur/5wn2iaJSqDAVG76NZ4kM3iiKo3icvjPreGnRysa2JW
	uqrGKkC8kDs9AIrH8Mzngu/82a8OTWbPkDRSyeZFUsrn1Ex1ViJ3J+hVIlKoIMx9NGZudz
	RIC5AT0zgiLjqgzBW+OJQKJj3InkMCkyOJFmYlJYMEZNPlVZaAttNHVhu5UGmEtd+odjTl
	2FgGatBz3s10aK0GUM9R6y6MkFE353zM6fPlwQJnQuzNzSRL+/UxFzlVfdTP3Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
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
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: advertise MACsec offload only when supported
Date: Tue, 18 Aug 2026 23:09:38 +0200
Message-ID: <1b7ebced14243c1b342923a25bcc44ec77c45907.1787086511.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hPj5g54wSzLlp3

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
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
The issue was reproduced on a ConnectX-4 Lx: ethtool -k reported
"macsec-hw-offload: on", while creating a MACsec interface with "offload
mac" failed with EOPNOTSUPP.

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

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.54.0

