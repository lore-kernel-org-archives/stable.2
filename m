Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081536;
	b=PzlB7EZJThoC+VszROvVnd+XLlVGjqDk0EMAw0MQl8aSpPCsa78pEVGOsPGp7Ws/ltCo
	 tfrEIR54KBpKnbNKNViWqEVkvuA82ep+wIiMgOW+6TfRjE5QchoFjfVzYEbxhTnI50GvX
	 Zz2EfSXwiMHud61KHD8CnDxX5lvbQt7L8saPbLcYwRC7DhXwUBzOhyupVnbo1rVpfEr8j
	 Tue0afxYjPHefqt1dtbe8lWZTyweJnSbzUUr2mRZAns4onwNxF204wFGe8rpLrj9bZFSH
	 rd7Qj4KggHCAiC9Np9lJQhsP1WH1+vNnz0iNUT1KCtrwHgWG1aZZdBHfDWCYwLPORIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081536;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K+6FXcYHVfobAwwclOPrbTchyR3ZZDSNjw3ExZa6P2g=;
	b=du+uAhWbxIQ8aQNrf89ILt8rZ8EhYB5AcI3X39/YGFh1KN7syk6CVrC0aOIjt8TdTiTY
	 TE6hDNzqsaF6HGf5h3XrFraaAb7be13o6Qrxt6MmiukvVLTwBQdEdG+AW5waokP+Kg1Ng
	 1/SGjU1lGQjMfoH6VrOX1MZSkewomIJnyutNGHnTczvBohnX8T4lhkbBeVNEzUjuYfp+r
	 Gs1e/oiNkRHmObXSe3F/6WTPp4o3fbNWIDQm+0wifpjODQ7i8k2W6CdS5MF7beQbTRQis
	 nPD2eh4T/SS4yas8n2bJlmLGpFBzmV2vl4Ix39FW8MpyFn1Bg6VK8Yw3eviglnS3PBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw6S19Kp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF85606A32E;
	Sat,  7 Nov 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jw6S19Kp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98CF1F0089F;
	Sat,  7 Nov 2026 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081536;
	bh=K+6FXcYHVfobAwwclOPrbTchyR3ZZDSNjw3ExZa6P2g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jw6S19KpASIeXF4u3PI90hyNUUY14hsQ6bRmBcCqxuo8kxSa0nNryuY7LaFcV4g9e
	 +4CAhq2IQ0rLcDHYphkVKl8+cNLcAAxHlIN3H8nADr3jgJX/iVgICSrC4vTshNGmBB
	 CRDluSAKh6pJUuBAhT1Tbwy2mqS5bNwIBPbzC99XRVUJ026y61R6IxcAvkuA8E8bym
	 ed9JDNdp+rXEiZr1S5StGN0G3vS+RgDn6WjdbZ2ebK64excMfsNw8c6FlibGwmF/0A
	 QjUoa7FlRH1RPFGLXK6ZnY61/X+N2H9ej4FIqhsZPRDoagchh0hDKOKdp9EJo3m9Rf
	 NRj35qOtIj+rw==
Subject:
 Re: [PATCH net] net: mii: Check speed and duplex only when autoneg is off
From: netdev-bot+sashiko@kernel.org
To: anthony.pighin@nokia.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zhangxiangqian@kylinos.cn, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 07 Nov 2026 19:58:55 +0000
Message-ID: <179408153520.994134.11224591607932425032@kernel.org>
In-Reply-To: <20261106195544.4146568-1-anthony.pighin@nokia.com>
References: <20261106195544.4146568-1-anthony.pighin@nokia.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This fix only covers the autoneg case of the read-modify-write
  (RMW) breakage caused by f6f2e946aa4d.
- [Medium] After this patch, mii_ethtool_set_link_ksettings() accepts any
  base.speed and base.duplex when autoneg is AUTONEG_ENABLE.

--

net: mii: Check speed and duplex only when autoneg is off

This patch moves the speed and duplex checks in
mii_ethtool_set_link_ksettings() under the AUTONEG_DISABLE case. With
that change, enabling autoneg on a port with no link no longer fails
with -EINVAL. Before, it failed because the getter reports
SPEED_UNKNOWN.

> diff --git a/drivers/net/mii.c b/drivers/net/mii.c
> index 37bc3131d31a8..4394446375373 100644
> --- a/drivers/net/mii.c
> +++ b/drivers/net/mii.c
> @@ -333,12 +333,6 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
>  	struct net_device *dev = mii->dev;
>  	u32 speed = cmd->base.speed;
>  
> -	if (speed != SPEED_10 &&
> -	    speed != SPEED_100 &&
> -	    speed != SPEED_1000)
> -		return -EINVAL;
> -	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
> -		return -EINVAL;
>  	if (cmd->base.port != PORT_MII)
>  		return -EINVAL;
>  	if (cmd->base.phy_address != mii->phy_id)
> @@ -346,8 +340,19 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
>  	if (cmd->base.autoneg != AUTONEG_DISABLE &&
>  	    cmd->base.autoneg != AUTONEG_ENABLE)
>  		return -EINVAL;
> -	if ((speed == SPEED_1000) && (!mii->supports_gmii))
> -		return -EINVAL;
> +
> +	/* Speed is SPEED_UNKNOWN while the link is down; autoneg ignores it */
> +	if (cmd->base.autoneg == AUTONEG_DISABLE) {
> +		if (speed != SPEED_10 &&
> +		    speed != SPEED_100 &&
> +		    speed != SPEED_1000)
> +			return -EINVAL;

[Severity: High]

Do forced-media ports with no link still hit the same -EINVAL?

mii_ethtool_get_link_ksettings() sets the speed to SPEED_UNKNOWN after
both branches. In forced mode, that replaces the speed the
AUTONEG_DISABLE branch has just read from BMCR:

drivers/net/mii.c:mii_ethtool_get_link_ksettings() {
    ...
	} else {
		cmd->base.autoneg = AUTONEG_DISABLE;

		cmd->base.speed = ((bmcr & BMCR_SPEED1000 &&
				    (bmcr & BMCR_SPEED100) == 0) ?
				   SPEED_1000 :
				   ((bmcr & BMCR_SPEED100) ?
				    SPEED_100 : SPEED_10));
		...
	}

	if (!(bmsr & BMSR_LSTATUS))
		cmd->base.speed = SPEED_UNKNOWN;
    ...
}

So a request that leaves the speed alone sends SPEED_UNKNOWN back. One
example is "ethtool -s eth0 duplex half" on a forced-media port with no
cable.

On the netlink path, ethnl_update_linkmodes() only updates
lsettings->speed when ETHTOOL_A_LINKMODES_SPEED is present. The ioctl
read-modify-write path behaves the same way.

That SPEED_UNKNOWN then fails the check above and returns -EINVAL.
Before f6f2e946aa4d the same command worked, because the getter reported
the BMCR speed in forced mode.

Since this carries the f6f2e946aa4d Fixes: tag and Cc: stable, should
the forced case be covered too? phylib reports the forced speed and
duplex even when the link is down, and only reports SPEED_UNKNOWN under
autoneg. Would doing the same in the getter's AUTONEG_DISABLE branch fix
the remaining case?

> +		if (cmd->base.duplex != DUPLEX_HALF &&
> +		    cmd->base.duplex != DUPLEX_FULL)
> +			return -EINVAL;
> +		if ((speed == SPEED_1000) && (!mii->supports_gmii))
> +			return -EINVAL;
> +	}

[Severity: Medium]

With AUTONEG_ENABLE, any base.speed and base.duplex now pass this
function. mii_ethtool_sset() in the same file still rejects those values
in every mode:

drivers/net/mii.c:mii_ethtool_sset() {
    ...
	if (speed != SPEED_10 &&
	    speed != SPEED_100 &&
	    speed != SPEED_1000)
		return -EINVAL;
	if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
		return -EINVAL;
    ...
}

Can this leave the pch_gbe PHY without the requested advertisement?
pch_gbe_set_link_ksettings() only rewrites speed == UINT_MAX. It then
stores whatever this function accepted:

drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c:pch_gbe_set_link_ksettings() {
    ...
	ret = mii_ethtool_set_link_ksettings(&adapter->mii, &copy_ecmd);
	...
	hw->mac.link_speed = speed;
	hw->mac.link_duplex = copy_ecmd.base.duplex;
    ...
}

Some requests used to get -EINVAL and now succeed. One is
"ethtool -s ethX autoneg on speed 2500 advertise 0x2f", where the
explicit advertise mask skips ethnl_auto_linkmodes(). Another is an
out-of-range duplex sent through raw netlink or ioctl.

When the interface is not running, the path is:

pch_gbe_set_link_ksettings()
  pch_gbe_reset()
    pch_gbe_phy_init_setting()
      pch_gbe_phy_write_reg_miic(hw, MII_BMCR, BMCR_RESET);
      mii_ethtool_sset()   <- returns -EINVAL

pch_gbe_phy_init_setting() passes the stored hw->mac.link_speed and
hw->mac.link_duplex to mii_ethtool_sset() right after the PHY reset.
mii_ethtool_sset() rejects them and "Error: mii_ethtool_sset" is logged.

The requested advertisement is never written to the freshly reset PHY,
even though the ethtool call has already returned success.

The stored link_speed can also reach pch_gbe_set_rgmii_ctrl() and
pch_gbe_set_mode() in __pch_gbe_suspend(). This happens if the watchdog
never overwrites it, and the watchdog only does that once the link comes
up.

Should mii_ethtool_set_link_ksettings() and mii_ethtool_sset() stay
consistent here?

>  
>  	/* ignore supported, maxtxpkt, maxrxpkt */
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106195544.4146568-1-anthony.pighin%40nokia.com
