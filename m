Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846445;
	b=5Uxqs9ekbWgv54eee+M9HP2UYdD3m5RHPseOkB83BqOJC7KZIRZcnP/TaEO4ShsekiI5
	 3xkhyOLQ0x72+vo9ZiO9yZ8GGd7/vS1iCTsdxNLkHVh3zn3W4z+ogkLgZbOYNz4mD6urq
	 S4kuDq8/hrtViYjNz9quqBxBG1TX0pwwDwVCxuyv1l772kttWX5qv/R8Owf3QgwEp1mcE
	 8pkuLBr8rxVyTDM7jfSJwzwT1ZJp/RUoIlkVsT8Nv0aKRvlRY5Dek8jeomDExB/vn/Ae7
	 OtV0d5ouYVYpK94nL3zADudhXFIjlMWHbNEyxZcM2DSoXgIq3leg6zAor6CP2lTUCcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aqVXnpsGKUb5dmAyOvsZyxLyttfxnbXbLvMJdAHt3hw=;
	b=A7w7dkQAyLaIoVLaew2opeTEvqNRtajUd8c5W1oAwKfHb8L+t5up/rWtsexdriDm7WaH
	 kcQXdgPfjZ3vS9On9VKKe4LPPcBUzw6keCBUiXDAtSBYktjbMnMrvmYTMwkf7zOYsoNNe
	 2kCrb8BPc3dXfGtpa+Uo/WackBLaKHL5k5M7PMUAHHjOi0ZYggnfcqGldrVFRRP3ewSax
	 A3c+Z+E0VslrdE9U6gbE2ePDCKqtTM8OAehsLQgQRRxRUirqgmKVVyAfLBiMcTCUmpjZZ
	 Rd1XPe0p3gG5rFlEPI/ZGRcRsUHaDpULt7pRTR+f3FZhI/VkXHEGJmV3lWgYQHK87/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIQgZsHP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312C606A31C;
	Mon, 16 Nov 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIQgZsHP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0791F000C4;
	Mon, 16 Nov 2026 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846444;
	bh=aqVXnpsGKUb5dmAyOvsZyxLyttfxnbXbLvMJdAHt3hw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VIQgZsHPU4uQodvLyAAwsRYYmobWrji3K/0jNrzRo6ZcvRJyw2jluC3GEXDumUeHG
	 vshdVlPKJzv2h8ow2lf2LCxd4EtGKG3she1k9a7HNCNCiM+6kCNk/I0CY8N8rULByL
	 TDOkbJhA4OstvcEodNimQ/pM9bRyYgRLmKiC4Kf+WNNmqFVGwSz3hJsOHzKVIhMgEh
	 /GHpCfNPA137OnbSvPSp55ELxA3u56ls5U3K80LMbdFrhVJZUZ9XsxK09S+OpwuJpL
	 kx25cNpEkX2UtvhDGje24GRYxBH/hu3aNINtgMXi2kbxphTkXvvFbtPUuA/FW2qn1h
	 zegWEGlK2AXSQ==
Subject: Re: [PATCH net v9 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
Date: Mon, 16 Nov 2026 16:27:23 +0000
Message-ID: <179484644326.3136.10831441284903731799@kernel.org>
In-Reply-To: <20261112153333.20-2-xiexinet@gmail.com>
References: <20261112153333.20-2-xiexinet@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch puts HSR-specific policy into the generic core function
  __netdev_update_features() in net/core/dev.c (lines 11279-11285):…

--

net: hsr: keep GRO disabled on HSR/PRP ports

This commit adds an hsr_port bit to struct net_device. HSR sets the bit
on its direct members (slave A/B and interlink). While the bit is set,
__netdev_update_features() clears NETIF_F_GRO and configurable
NETIF_F_GRO_HW from both wanted_features and the computed features, and
an attach fails if software GRO stays on.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b03343..c8c2de2125567 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11269,6 +11269,21 @@ int __netdev_update_features(struct net_device *dev)
>  
>  	features = netdev_get_wanted_features(dev);
>  
> +	/* A direct HSR/PRP port needs per-frame metadata. Drop software
> +	 * GRO and configurable GRO_HW from the request as well as from the
> +	 * features passed to ndo_fix_features(), as the core does for
> +	 * upper-disabled features: drivers such as veth derive state from
> +	 * wanted_features and need the requested and the active bit to
> +	 * agree. Fixed-on or driver-required GRO_HW is left to the driver.
> +	 */
> +	if (dev->hsr_port) {
> +		netdev_features_t gro = NETIF_F_GRO |
> +					(dev->hw_features & NETIF_F_GRO_HW);
> +
> +		dev->wanted_features &= ~gro;
> +		features &= ~gro;
> +	}

[Severity: Low]

The comment says this follows what "the core does for upper-disabled
features". Is that right?

netdev_sync_upper_features() runs inside the lower device's own update.
It masks only the computed features and does not touch the request:

    if (!(upper->wanted_features & feature)
        && (features & feature)) {
        ...
        features &= ~feature;
    }

Only netdev_sync_lower_features() clears lower->wanted_features, and it
does that once, when the upper device turns the feature off. In this
patch, the request is cleared inside the same update that is supposed to
apply it.

Can this make the legacy ETHTOOL_SFEATURES ioctl report success for a
GRO request that was never applied? ethtool_set_features() sets
wanted_features and then runs:

net/ethtool/ioctl.c:ethtool_set_features() {
    ...
	__netdev_update_features(dev);

	if ((dev->wanted_features ^ dev->features) & valid)
		ret |= ETHTOOL_F_WISH;
    ...
}

When hsr_port is set, GRO is already gone from both wanted_features and
features when the XOR runs. So ETHTOOL_F_WISH is not set for GRO, and
the ioctl reports full success while GRO stays off. A later ethtool -k
shows GRO off without the "[requested on]" marker.

Compare LRO disabled by an upper device: there the request stays in
wanted_features and ETHTOOL_F_WISH is returned. The netlink path,
ethnl_set_features(), still reports the mismatch, because it compares
against its local req_wanted copy.

The comment on the new struct net_device field also says "Kernel role
state only; no user ABI", but the field changes behaviour that ethtool
users can see. It also puts HSR-specific policy into the generic
__netdev_update_features() under a "net: hsr:" subject. Later patches in
the series do not touch net/core/dev.c, so this is still the case at the
end of the series.

Would it work to mask only the computed features here, the way
netdev_sync_upper_features() does? Or, if the request has to be cleared
for veth, could the comment stop citing the upper-disable path as the
model and mention the ETHTOOL_F_WISH change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112153333.20-1-xiexinet%40gmail.com
