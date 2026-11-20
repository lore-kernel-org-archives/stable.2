Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141322;
	b=vV6iChbj/mxnGnRV/gkeOfuVIAZvHgXVjTSKLfWbY7avoP/o81oUD/x5zDZZKqm+dc9d
	 CW22vnQRfIxfS5acORCEkQg8VcJvN/tic6h8p5oVnCSI2qXCo/A6L/1rvfiUAeKCcHOrG
	 V2IpY7Shqwhb7pkPDgPovb1qvlQz6Y8qhHtqJdHSPMvJXZ6RRGOS7LxbF7UjU3EVeEfNx
	 tvbOLtJceqqiIKq4qyGbbdm9r5PWas6ad6+oOWnVqa8wjIjxaQYj/83iMFqsHkFavJAsZ
	 sKkUWQ7kvOKtRVKQkMLDcPoJ8J5djBXxE7Djq3UiU4uZzeh1DxDK0qd23WLDBWOxOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141322;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gDfMbB0iLO5147W7hciH56ETASFEwnLRXOCRyFYMdqQ=;
	b=eTOsGB64fWo7Nhdh/bMEBzRsgI56YzMO7QO1hNfuEKUdGXjQzypq5MyvDLqy1BQmNmUO
	 ukcej3Mw7hq9Gre73VaTIwFU1XUmppU3afWZgL6jUESYSjhWwSER9YYArVFFdvr5o+kLJ
	 kji7TNVtdx2FU4k/+poLVDdYAKgywrHRBauGsvC9xJ/tWVWn+NoNaBFNRlmJYbTEvzlST
	 VZnSEy6z8XMeY6afq9rspsvbKFy6YRHTE2G4+HmJHnKDrIL6JvWoPe9mJYnkEPUpTx5Z3
	 iUGTYL85deBkW6CiRGSLyD2dGrkf2sDE1oA10WmQRHWnxNv7OhLUIt5vZnSgiccf3jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T031gPTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECE606A320;
	Fri, 20 Nov 2026 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T031gPTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EDE1F000CA;
	Fri, 20 Nov 2026 02:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141321;
	bh=gDfMbB0iLO5147W7hciH56ETASFEwnLRXOCRyFYMdqQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T031gPTSzRGf5px/5xZoOAaCt9a/jrJuJTElhgersdptRgSVlRj30JsYC4srxx9Xc
	 XLIw2JLsLZefBUuNyA+0lGphtfeDK0ZylsU3w/oskVDoh8W+gTxvWTauOkS9MJjMJB
	 zWiTOyvjzeQj1IVGa/MAzyBdkwEUXYgeImNGAhG4e5WxD79Qtqq9Fh8XTolVi5+Vrj
	 oYKR3NC+VR7uLE0fQFUtg5M85u5mfYCGQCF2tJgH/lVToFLyw+31Eu2i/O3aQK6uJ6
	 LVf6VXN3VRVzDc632HVrsybjl81+SDk1/FfbUugS8CUyzFd3/DGoA7zMeQm+MNjxAB
	 etliTNMtri2Hg==
Subject: Re: [PATCH net v10 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
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
Date: Fri, 20 Nov 2026 02:22:00 +0000
Message-ID: <179514132000.3136.2415655157145361596@kernel.org>
In-Reply-To: <20261117141922.20-2-xiexinet@gmail.com>
References: <20261117141922.20-2-xiexinet@gmail.com>
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

- [Medium] When dev->hsr_port is set, __netdev_update_features()
  (net/core/dev.c) clears NETIF_F_GRO, and NETIF_F_GRO_HW if it is in…

--

net: hsr: keep GRO disabled on HSR/PRP ports

This patch adds an hsr_port role bit to struct net_device and sets it on
HSR/PRP slave and interlink devices. While the bit is set,
__netdev_update_features() removes NETIF_F_GRO and configurable
NETIF_F_GRO_HW from both dev->wanted_features and the computed features.
The attach is refused if software GRO is still on after the update.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3c58db732761a..1f51a55ff2b08 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11289,6 +11289,21 @@ int __netdev_update_features(struct net_device *dev)
>
>  	features = netdev_get_wanted_features(dev);
>
> +	/* A direct HSR/PRP port needs per-frame metadata. Drop software
> +	 * GRO and configurable GRO_HW from the request as well as from the
> +	 * features passed to ndo_fix_features(): drivers such as veth
> +	 * derive state from wanted_features and need the requested and the
> +	 * active bit to agree. Fixed-on or driver-required GRO_HW is left
> +	 * to the driver.
> +	 */
> +	if (dev->hsr_port) {
> +		netdev_features_t gro = NETIF_F_GRO |
> +					(dev->hw_features & NETIF_F_GRO_HW);
> +
> +		dev->wanted_features &= ~gro;
> +		features &= ~gro;
> +	}

[Severity: Medium]
Does clearing dev->wanted_features here make the ethtool uAPI report a
GRO request on an HSR member incorrectly?

With the legacy ioctl, ethtool_set_features() in net/ethtool/ioctl.c
stores the request, calls __netdev_update_features(), and then works out
ETHTOOL_F_WISH from dev->wanted_features:

net/ethtool/ioctl.c:ethtool_set_features() {
    ...
	dev->wanted_features |= wanted & valid;
	__netdev_update_features(dev);

	if ((dev->wanted_features ^ dev->features) & valid)
		ret |= ETHTOOL_F_WISH;
    ...
}

On a member, "ethtool -K <port> gro on" ends with GRO cleared in both
wanted_features and features. The call therefore succeeds without
ETHTOOL_F_WISH, even though GRO stays off.

include/uapi/linux/ethtool.h documents the flag as:

 *   %ETHTOOL_F_WISH - some or all changes requested were recorded but the
 *      resulting state of bits masked by .valid is not equal to .requested.

Is that contract broken in this case?

On the netlink side, ethnl_set_features() in net/ethtool/features.c
builds its reply from the local req_wanted bitmap:

	bitmap_xor(wanted_diff_mask, req_wanted, new_active,
		   NETDEV_FEATURE_COUNT);

So the SET reply says GRO is wanted but not active. A later
ETHTOOL_MSG_FEATURES_GET then reads dev->wanted_features in
features_prepare_data() and shows GRO as not wanted. Can the SET reply
and the GET that follows it disagree about the same request, and can the
ioctl and netlink interfaces disagree with each other?

The commit message describes this behaviour:

    A GRO request on a member is dropped,
    not kept pending: while GRO stays off, the legacy ETHTOOL_SFEATURES
    ioctl returns no ETHTOOL_F_WISH for it, and the netlink reply still
    shows the request as not applied.

The other core paths seem to handle this differently.
netdev_sync_upper_features() and ndo_fix_features() only mask the
computed features, so a bridge port's LRO request still returns
ETHTOOL_F_WISH. dev_disable_lro() and dev_disable_gro_hw() clear
wanted_features only once, when they are called. This new branch erases
the request on every recompute.

Could the request stay in wanted_features, with only the computed
features masked here? veth's use of wanted_features (veth_gro_requested()
reads dev->wanted_features) could then be handled separately.

>  	if (dev->netdev_ops->ndo_fix_features)
>  		features = dev->netdev_ops->ndo_fix_features(dev, features);
>

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117141922.20-1-xiexinet%40gmail.com
