Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171900;
	b=3soj/k02tEHtj64HD+km+YKLhDarLf9/pSm5S3TDj8sTYuCEKtZD2yBz6Gvm0xx7HqIM
	 oY7U9s6+3H+YdIkMi1HDQd2O2yezZZ6nnKCRoqeixUrp5EkBIsv0afmGd2pcjL0gZS5dR
	 W/82oNhmBr6v8OBF0aj+Ftl+L5NbXHM1GOioUDkVKdop7VIUnl9ZQ690k+c+MGHKuYX18
	 Qtf1HXAGwYD3sg2PyH9AahAmotAmpg7NkU7QXoagia76tUgeCUQnwRlphlxWtRf4LftDG
	 h9p830+F9xPJgSUepBSpD2kRlBhLkJvBMvPE7P+JgKcvgqJRYlVLySBlP0cZKvxuK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171900;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=krgZwyjxrCIUZLlQLcUb/n73QFlmrRfeqYeUKVXIUJ0=;
	b=d3fU984AVof+pqr8G2JYghZh7vIYgHJN/RNzTd04qR0XuGCEs+AqdcUHDvZFLciAWt1U
	 I28kiyv++FMaUON6qn/Fu/Uf73AL++z2W41HsjCCt5mK1FYOe/4z4CyGlDZUhH1LHqVvS
	 N4BCSxYKRoaiDepbTiDXYFXviLR+Ud6wcrI8Lyle41EUd5k/gIXkG1VPSoyhrIK3JqPr9
	 yLECDZC4KKrFrUK3nnymhqcw4oDwFDFY3OYFe/Gg1pmiZjgLsc8IHQNehqw4AOQBoWz/E
	 867kGdMikzJ5uy5l85T6z9zW+9LBE4RNM1CabJX2mrUwJZpYV+l3UyVimpxhqcFqfWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmMyhEg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC606A31C;
	Sun,  8 Nov 2026 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmMyhEg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE161F0089F;
	Sun,  8 Nov 2026 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171899;
	bh=krgZwyjxrCIUZLlQLcUb/n73QFlmrRfeqYeUKVXIUJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OmMyhEg1BPjcNDIitkZuD3rqShKRhucsH5bhcXilZgQjIORW1QFJBeohga/z5mlEZ
	 b/NUUbV7/srSV/4k/tX/wW9y1DYYGHM/OB8MBnZxzpwlQDwRxObXciStJ0DUVXsmX0
	 T66mrwHrWoUW8nWO5juqjCY6FmDmNJII8n/LWMNqUrfjjCzW6v1VGeDl1naFrF9IcZ
	 mwB9LVFcK9MjruDckre2HSK6DO69CkEH5Ctge6Ys2WnFsZaulf+xcVg9s6RghJDjxM
	 vEhL9IZniXaFZBvX8C/yh39ykW5pFzPf2d1A78c6REM16e0r4tCCF8ST5a3eM4NW/h
	 1kSwXac2b59TQ==
Subject: Re: [PATCH net v2] net: mii: Accept link settings read back while the
 link is down
From: netdev-bot+sashiko@kernel.org
To: anthony.pighin@nokia.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zhangxiangqian@kylinos.cn, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sun, 08 Nov 2026 21:04:58 +0000
Message-ID: <179417189843.994134.10373591226348070230@kernel.org>
In-Reply-To: <20261107210236.721901-1-anthony.pighin@nokia.com>
References: <20261107210236.721901-1-anthony.pighin@nokia.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On ksz884x, `ethtool -s ethX autoneg on` while the link is
  down now succeeds but writes a half-duplex-only advertisement to the…

--

net: mii: Accept link settings read back while the link is down

This patch changes mii_ethtool_get_link_ksettings() so that it reports
SPEED_UNKNOWN only when autoneg is enabled and the link is down. It also
makes mii_ethtool_set_link_ksettings() accept SPEED_UNKNOWN when autoneg
is enabled. With both changes, ethtool's read-modify-write of link
settings succeeds while the link is down.

> diff --git a/drivers/net/mii.c b/drivers/net/mii.c
> index 37bc3131d31a8..225488f2438b2 100644
> --- a/drivers/net/mii.c
> +++ b/drivers/net/mii.c
> @@ -199,6 +199,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
>  			cmd->base.speed = SPEED_10;
>  			cmd->base.duplex = !!(nego & ADVERTISED_10baseT_Full);
>  		}
> +
> +		if (!(bmsr & BMSR_LSTATUS))
> +			cmd->base.speed = SPEED_UNKNOWN;
>  	} else {
>  		cmd->base.autoneg = AUTONEG_DISABLE;

[ ... ]

> @@ -333,9 +333,11 @@ int mii_ethtool_set_link_ksettings(struct mii_if_info *mii,
>  	struct net_device *dev = mii->dev;
>  	u32 speed = cmd->base.speed;
>  
> +	/* Autoneg ignores speed, which is SPEED_UNKNOWN while the link is down */
>  	if (speed != SPEED_10 &&
>  	    speed != SPEED_100 &&
> -	    speed != SPEED_1000)
> +	    speed != SPEED_1000 &&
> +	    !(cmd->base.autoneg == AUTONEG_ENABLE && speed == SPEED_UNKNOWN))
>  		return -EINVAL;
>  	if (cmd->base.duplex != DUPLEX_HALF && cmd->base.duplex != DUPLEX_FULL)
>  		return -EINVAL;

[Severity: Medium]
Can this make ksz884x write a half-duplex-only advertisement to the PHY
when "ethtool -s ethX autoneg on" is run while the link is down?

With autoneg on and the link down, lp_advertising is 0 in
mii_ethtool_get_link_ksettings(). That makes nego 0, so the read-back
is:

    cmd->base.speed  = SPEED_UNKNOWN
    cmd->base.duplex = !!(nego & ADVERTISED_10baseT_Full);  /* DUPLEX_HALF */

The commit message cites genphy_read_status(), but unlike that function
this code does not report the duplex as DUPLEX_UNKNOWN here.

The ksz884x caller, netdev_set_link_ksettings() in
drivers/net/ethernet/micrel/ksz884x.c, treats the read-back speed and
duplex as user intent when autoneg is set and the advertising mask
matches priv->advertising:

    if (cmd->base.autoneg && priv->advertising == advertising) {
        advertising |= ADVERTISED_ALL;
        ...
        if (0 == cmd->base.duplex)
            advertising &=
                ~(ADVERTISED_100baseT_Full |
                ADVERTISED_10baseT_Full);
        ...
    }
    ...
    } else {
        port->duplex = cmd->base.duplex + 1;
        if (1000 != speed)
            port->speed = speed;
        ...
    }

As a result:

- the full-duplex modes are dropped from the advertising mask
- port->duplex becomes 1 (half)
- SPEED_UNKNOWN is truncated to 0xff in the u8 speed field of struct
  ksz_port

Before this patch, mii_ethtool_set_link_ksettings() returned -EINVAL for
SPEED_UNKNOWN and never touched MII_ADVERTISE. Now it continues: it
writes ADVERTISE_10HALF | ADVERTISE_100HALF through the driver's
mdio_write() and restarts autoneg. Once a cable is connected, the PHY
negotiates half duplex.

The legacy ethtool path reaches this directly. "ethtool -s ethX autoneg
on" sets advertising to the current non-mode bits plus all supported
modes. When the PHY already advertises all four 10/100 modes, that
matches priv->advertising. Speed and duplex are passed through
unchanged from the read-back.

port_set_link_speed() also reads port->duplex == 1 as a manual
half-duplex request, and strips the FD bits again on later
reconfiguration:

    if (1 == port->duplex)
        data &= ~(PORT_AUTO_NEG_100BTX_FD |
            PORT_AUTO_NEG_10BT_FD);

The old code already wrote the port fields before mii_ethtool_set_link_ksettings()
returned -EINVAL. What is new is that the PHY now gets reprogrammed right
away.

Could the get and set paths be made consistent here? One option is to
report DUPLEX_UNKNOWN for autoneg with the link down, as genphy does,
and accept it under autoneg in the set path. Another is to make sure
callers like ksz884x do not treat speed and duplex from a link-down
read-back as user intent.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107210236.721901-1-anthony.pighin%40nokia.com
