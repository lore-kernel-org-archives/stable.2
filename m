Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168D477983;
	Tue, 18 Aug 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068890; cv=none; b=VAXoBhWpeI/uRmqDydFxKSmtkPBMy6yv907m/wkty+0iJOFS8O587dCdc+29nse2h612XXgBZ6C79aPwwaTyibJ9g3Rdo+Eue8PwiN046sU5t6F52ld7JVy89BhRBnuwHR+BOCINB9ZNn7niAXWNeeXNjE2w3EeVwU85KeMNqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068890; c=relaxed/simple;
	bh=T7JYQMkq3KtJ8HRVAnuEdXgNXPTmppuXPrV+NLf3n7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD2RY6iXd0C5E1z6FsSih/QVvQsYkC3ZDMOCjzEx1Sl7NM5wIyjfWh6XlkOwHf1xA97UAcWw+cQylLMnIYuEC1j1FqoX7wuxiFQ1tc9rKhRSZTdg3mliFhzdr/olkMRVS6Az8U74wDkOz08AfzVDvbNjtLEwfCDfsMO1KjfMPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igqCOKAT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igqCOKAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A471F000E9;
	Tue, 18 Aug 2026 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068887;
	bh=vUs4Uk6bsbg//akSHlRKqVfj3MQp0uzLIj/vIKWSeC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igqCOKAThyQbc03/ALtgAMPq4IoLavKoAXgoivCGuNOzlQIMyEC/pgTy0NJwzJuqr
	 nGw9f3SvHVCPFdY8iOyzEMYRYDZKY6ksA/VBnOOZMxI+NiJjkcPsvTuhrGx2OJXza/
	 qX5fvLPOQzBm7ij1gD30/IWnJmkmbmB0rUTzSGwQXEnNXQ8B38aqCvQoBTWzg4m5sD
	 99O9+MuG4A4ShMzg5HFNg4X/8N8jQN+ZiovoSd31+6ETIAlxOyDzgL7ARmtWfvGkG9
	 D+jMfld2PVyITvV0wsO/MtWQ+4GddV5Zvqr0Jea48GWJV2hHso/dXBXwwwcKj4zf0l
	 gFokpm/LwqVrg==
From: Simon Horman <horms@kernel.org>
To: ralf@mandelbit.com
Cc: Simon Horman <horms@kernel.org>,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	leon@kernel.org,
	borisp@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ehakim@nvidia.com,
	sbhatta@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5e: Advertise MACsec offload only when supported
Date: Tue, 18 Aug 2026 17:01:14 +0100
Message-ID: <20260818160114.643278-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0a27c8b7308121fd00c528fc99fc3866782d3990.1786783174.git.ralf@mandelbit.com>
References: <0a27c8b7308121fd00c528fc99fc3866782d3990.1786783174.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0a27c8b7308121fd00c528fc99fc3866782d3990.1786783174.git.ralf@mandelbit.com?part=1
---
--- Patch [1]: [PATCH net] net/mlx5e: Advertise MACsec offload only when supported ---
commit 38bf72f7e49d9a5074017d708c51a11b180b96fb
Author: Ralf Lici <ralf@mandelbit.com>

net/mlx5e: Advertise MACsec offload only when supported

The patch moves the NETIF_F_HW_MACSEC assignment to vlan_features out of
mlx5e_build_nic_netdev() and into mlx5e_macsec_build_netdev(), so that
only devices whose capabilities were validated advertise MACsec hardware
offload.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> index daff53ba7d09f..9a3850457bd22 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> @@ -1724,6 +1724,7 @@ void mlx5e_macsec_build_netdev(struct mlx5e_priv *priv)
>  	mlx5_core_dbg(priv->mdev, "mlx5e: MACsec acceleration enabled\n");
>  	netdev->macsec_ops = &macsec_offload_ops;
>  	netdev->features |= NETIF_F_HW_MACSEC;
> +	netdev->vlan_features |= NETIF_F_HW_MACSEC;
>  	netif_keep_dst(netdev);
>  }

[Severity: High]
[Finding: main-1-0]
[Sources: opus-5]
Should this hunk also set netdev->hw_features |= NETIF_F_HW_MACSEC?

mlx5e_macsec_build_netdev() runs at the very end of
mlx5e_build_nic_netdev(), which is after the snapshots:

	netdev->hw_features       = netdev->vlan_features;
	...
	netdev->features          = netdev->hw_features;
	...
	mlx5e_macsec_build_netdev(priv);

So on a MACsec-capable device the bit now lands in features and
vlan_features but never in hw_features, whereas before the patch it
reached hw_features through the vlan_features copy.

Does this turn macsec-hw-offload into a fixed feature for users?
ethtool_set_features() masks requests against dev->hw_features:

net/ethtool/ioctl.c:ethtool_set_features() {
	...
	if (valid & ~dev->hw_features) {
		valid &= dev->hw_features;
		ret |= ETHTOOL_F_UNSUPPORTED;
	}
	...
}

With the bit absent from hw_features, ethtool -k reports
macsec-hw-offload as [fixed] and ethtool -K ethX macsec-hw-offload off
fails, which was a working knob since 339ccec8d43d.

The second effect is that the offload does not come back after an
eswitch mode cycle. register_netdevice() computes:

net/core/dev.c:register_netdevice() {
	...
	dev->wanted_features = dev->features & dev->hw_features;
	...
}

so NETIF_F_HW_MACSEC is not in wanted_features either, and it only
survives in dev->features via:

include/linux/netdevice.h:netdev_get_wanted_features() {
	return (dev->features & ~dev->hw_features) | dev->wanted_features;
}

When the device enters switchdev mode, mlx5e_fix_features() ->
mlx5e_fix_uplink_rep_features() strips it:

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_fix_uplink_rep_features() {
	...
	features &= ~NETIF_F_HW_MACSEC;
	if (netdev->features & NETIF_F_HW_MACSEC)
		netdev_warn(netdev, "Disabling HW MACsec offload, not supported in switchdev mode\n");
	...
}

and __netdev_update_features() writes that mask back into dev->features.
After that the bit is in none of features, wanted_features or
hw_features, and nothing re-adds it: mlx5e_macsec_build_netdev() is only
reachable from mlx5e_build_nic_netdev(), whose only caller is
_mlx5e_probe(). The legacy-mode restore path
mlx5e_netdev_attach_nic_profile() -> mlx5e_netdev_change_profile() ->
mlx5e_netdev_attach_profile() does not re-run it.

Can this make devlink dev eswitch set ... mode switchdev followed by
mode legacy leave ip link add ... type macsec offload mac failing with
EOPNOTSUPP until mlx5_core is reloaded? Before the patch the bit lived
in hw_features and wanted_features and was restored automatically.

Since the patch carries Cc: stable, this behaviour change would be
backported as well.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index f0407a850ea82..cb8ebca58ce82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5851,7 +5851,6 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
>  
>  	netdev->vlan_features    |= NETIF_F_SG;
>  	netdev->vlan_features    |= NETIF_F_HW_CSUM;
> -	netdev->vlan_features    |= NETIF_F_HW_MACSEC;
>  	netdev->vlan_features    |= NETIF_F_GRO;
>  	netdev->vlan_features    |= NETIF_F_TSO;
>  	netdev->vlan_features    |= NETIF_F_TSO6;
