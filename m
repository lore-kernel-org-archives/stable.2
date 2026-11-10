Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315878;
	b=mEIPzYGhiuJCY1cJ8pa4tqEtgH5JySCmgtHMZ5zkexUcDRoZf7PBI2TmeCNhRjFljeBZ
	 VW8b+U1DE2YgMQmOcB17ry++bpuJRgh8Mi8UUPFQrhcPrYqJKAXAVq9XA6+1g0MuG5zsd
	 4gKbHbHKQV1HrVElXPPfW/wv9eINANW/n6YjIaTcmuklJTPbpG9jFvzlrQ4A/giIbQ1Bv
	 Tof0H7Csok1mK9iNO0eszeoMOooTI+H6BkaGVHVSuPVNnNLCXKCZVpgUG9hXeMzULaEW1
	 XIxHdpWxNmeZ2zlrNWuV9r/fyfjlxLnUjh2Ki0SBw75KqqUZvfG/1OcT4XAYLfs+xwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315878;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EnWbVDYQ/6puggi0QqXD0bxXsZrTtGcnJLqSymIBlOI=;
	b=tTYli00ylTVCfTL1+M2Rc4/LLmdQw+0EG8G/9Nv6tVrfJ9fljmJc19G64mIyjwkmLz33
	 kVKVLVqDGHv/4qwK+QuEdWpzhLwZJTyHdoqU4dkd+ucPfUmTPJQJ3RoigFCfKesYqi104
	 qkDX3INJVSGpIzi6jCy+m2dnRb3jRIDhe4RZn//0mprHnKNcJ0/zhzQ17b1thrROtFjSy
	 7sTXHahw38IG9tIMZUUgb1ltL1VJ9t07bDDWyduHsYzcSRYGW0Orknt8H8J5Xgzw4rmgH
	 PXYm27s9CTlQgWxkXZIq0lqAcetRZMV05wIwN50MuxBbh4E9F5BZUK1VvxyxbT92/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDw8Liv9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E3606A336;
	Tue, 10 Nov 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDw8Liv9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E01F0089F;
	Tue, 10 Nov 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315877;
	bh=EnWbVDYQ/6puggi0QqXD0bxXsZrTtGcnJLqSymIBlOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lDw8Liv9Ggm6qVu6iULhp3dA8tGCXo1zz7IlG3Z1ClryFeLIADN2w499Nvu34XeKI
	 tlcdHc+3bb1iQp4Xs4EEV32OVK/zqc0JXsl5qRJJr2F9tbjSG5JO27KHxUBL3nPyU7
	 2KkatvBT/FN4EQDfUoITl3Boswqr44ktlPlA6N+x1AuqmugRrACbB/k7uWZ/al2DTn
	 OFwhNNUr42DYI+72hCCzrLGtpZWMuNYpP8v/iKQZ2i8a/TA2bTNwqWjLpdhduLhZDU
	 DRSEibh9cMMf/OyGpG+rTUaJKPoQu/P5mFo/s3fz9Sy2+B2qw80vhoD1pbuLqu2b9Z
	 2l29J8hWdPOGg==
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
From: netdev-bot+sashiko@kernel.org
To: dennylin0707@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, n05ec@lzu.edu.cn, ylong030@ucr.edu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Date: Tue, 10 Nov 2026 13:04:36 +0000
Message-ID: <179431587680.994134.9895439231970781828@kernel.org>
In-Reply-To: <20261106124639.12584-1-dennylin0707@gmail.com>
References: <20261106124639.12584-1-dennylin0707@gmail.com>
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

- [Medium] The patch only partly isolates the host PHY from the VLAN's
  network namespace.

--

vlan: prevent cross-netns MII register writes

This commit makes vlan_dev_ioctl() reject SIOCSMIIREG when the VLAN
device and its real device are in different network namespaces.
SIOCGMIIPHY and SIOCGMIIREG are still forwarded across namespaces on
purpose, and writes are still allowed when both devices share a
namespace.

> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index bca0a3693636c..0d0904103302f 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -416,9 +416,12 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	ifrr.ifr_ifru = ifr->ifr_ifru;
>
>  	switch (cmd) {
> +	case SIOCSMIIREG:
> +		if (!net_eq(dev_net(dev), dev_net(real_dev)))
> +			break;
> +		fallthrough;
>  	case SIOCGMIIPHY:
>  	case SIOCGMIIREG:
> -	case SIOCSMIIREG:
>  		err = dev_eth_ioctl(real_dev, &ifrr, cmd);
>  		break;

[Severity: Medium]
Can the VLAN's namespace still change host PHY state through
SIOCGMIIREG?

The commit message describes the threat as letting the VLAN namespace
"modify PHY registers on the host's real device". It also says the
patch will "Preserve MII reads across namespaces". MII reads are not
always free of side effects, though.

For phylib drivers, the read path ends in phy_mii_ioctl() in
drivers/net/phy/phy.c. That function does a raw bus read at a phy_id
and reg_num chosen by the caller:

drivers/net/phy/phy.c:phy_mii_ioctl() {
    ...
	case SIOCGMIIREG:
		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
			...
			ret = mdiobus_c45_read(phydev->mdio.bus, prtad, devad,
					       mii_data->reg_num);
		} else {
			ret = mdiobus_read(phydev->mdio.bus, mii_data->phy_id,
					   mii_data->reg_num);
		}
    ...
}

The BMSR link status bit is latched low, and genphy_update_link() in
drivers/net/phy/phy_device.c depends on that latch:

	/* The link state is latched low so that momentary link
	 * drops can be detected. ...
	 */

Vendor interrupt and event status registers are also often
clear-on-read. A read from inside the container could consume a
latched link drop, or acknowledge a pending PHY interrupt, before the
host's phylib state machine or IRQ handler sees it. Would the host
then miss link-change events?

The read also isn't limited to the PHY attached to real_dev.
mii_data->phy_id can name any C22 or C45 address on the host's MDIO
bus, including other PHYs or switches unrelated to the VLAN.

The only privilege check on this path is in dev_ioctl() in
net/core/dev_ioctl.c, and it is against the VLAN namespace's user
namespace:

	case SIOCGMIIPHY:
	case SIOCGMIIREG:
	case SIOCSIFNAME:
		dev_load(net, ifr->ifr_name);
		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
			return -EPERM;

Container root can satisfy this check once the VLAN has been moved
into its namespace.

The write side here follows the vlan_dev_hwtstamp_set()/get split,
where only set has a net_eq() check. Hardware timestamp get has no
hardware side effects, but MII reads can.

Should SIOCGMIIPHY and SIOCGMIIREG also be rejected when
dev_net(dev) and dev_net(real_dev) differ? If not, could the commit
message explain why these cross-namespace reads are acceptable?

>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106124639.12584-1-dennylin0707%40gmail.com
