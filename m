Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175706;
	b=vZOu2ncB6pZ+01UdRVPPHzUL3h4sxKPkecFP9V5xoCzgt+JLVx+Bf/nLah2c4Rb++CrC
	 HiCBXfTmjftpeIJUVbinhn5oDMpf0VnsjopHQUZqKro7vmannkU9idNb6UuaelPghnD7r
	 dWmczQyfcVmv3xvbqqBmVpjeILyIiCBQ2pO3CbO3k345zmuK2RZ3uiE+HXXo8EF+gOEOt
	 Dw8RueoweJs/5fIVkT7AjMoITnYfW3aKBIEDozAroAuLXZsPBuZbLu3/zIrIsKlZ0ZXpb
	 +Y7dSazt6ThBglKOU0nn2OjR8Ypy0hxIpr5jNqqkIAU3LQORHuZQzO+TKZbVYGZlloA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175706;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vTNVZdXw6o21WqcFGBxd9DOHUD3xQC0qrIumoTiqvwU=;
	b=LfnscoB0Nkef0pcCThkea5VIl19jvPOouh44f1LDQKf2N/T2JlI22WxgYlI/khxuI+bp
	 QJ+cZRACPajSvnuwpNhD2nB6FHDpZT7wDw4pP4/rcstBnzxYySqkQ52gS6uTj2HZCDSmw
	 2uVtZTbo2q0vHxtqYPfjJ+uLm20/n9om+xwKuDGRnpJi0zRhmHeiaGdfDvT/I6aGzHWbq
	 VPFuUnCe41XbcvVKPnU0Ui8A/W7ZlEh28LpftgJO/LNmL4n5pZxqBE/VV8NtVZuKIuW5v
	 HQrzDERk9d8VZ6Nlz2DKvCAwYnPIelH+ubOkEbicyQFzrG4/8vrxsVpk3ROcxj0Be/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am3cYaRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E18606A333;
	Sun,  8 Nov 2026 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am3cYaRO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D8B1F0089F;
	Sun,  8 Nov 2026 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794175705;
	bh=vTNVZdXw6o21WqcFGBxd9DOHUD3xQC0qrIumoTiqvwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Am3cYaRONk8QHztljHE7Ay5r5WM9squmFdyAqUkQMiDuJwgcRy5nl/lBu4545WkIJ
	 iQlQ+K7TrVc9tS7HoCaIe0H7/YYVRRT8OwW5L29hrNI/H/8YTqCNE8TDtMaEAlPlJN
	 XLoP+trs2pmcEJJNUdFQm08U/6WGKGDDuDTt4M6utHTE1PKEDPOsYfmnMrmZTi0q6Y
	 51eTCjjuz0QM1gWhuO2BrImaASjAcmgLV/wpFxV/zCSiFykzv1NJ3f7pXSHSH96Srg
	 pyINJuPXqZZFrr28OKi74kc3JFeH80Sqj/ClSHsYPSvNPBzPY1OkLiBIRZzBS/9C9d
	 nNqwHH1+Hwx0A==
Subject: Re: [PATCH net v8 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
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
Date: Sun, 08 Nov 2026 22:08:23 +0000
Message-ID: <179417570353.994134.16201150912134067025@kernel.org>
In-Reply-To: <20261107220544.20-2-xiexinet@gmail.com>
References: <20261107220544.20-2-xiexinet@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hsr_portdev_setup() (net/hsr/hsr_slave.c:210) calls
  hsr_portdev_role_set() on every non-master port without checking…
- [Medium] hsr_portdev_role_set() calls netdev_change_features() with
  dev->hsr_port set.

--

net: hsr: keep GRO disabled on HSR/PRP ports

This patch adds an hsr_port role bit to struct net_device. The bit is set
on HSR/PRP slave A/B and interlink ports. While it is set,
__netdev_update_features() drops software GRO and configurable GRO_HW
from both wanted_features and the computed features, and the attach
fails if software GRO stays active.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b03343..2916b17f4169f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11269,6 +11269,21 @@ int __netdev_update_features(struct net_device *dev)
>  
>  	features = netdev_get_wanted_features(dev);
>  
> +	/* A direct HSR/PRP port needs per-frame metadata. Drop software
> +	 * GRO and configurable GRO_HW from the request as well as from the
> +	 * result, as the core does for upper-disabled features: drivers
> +	 * such as veth derive state from wanted_features and need the
> +	 * requested and the active bit to agree. Fixed-on or
> +	 * driver-required GRO_HW is left to the driver.
> +	 */
> +	if (dev->hsr_port) {
> +		netdev_features_t gro = NETIF_F_GRO |
> +					(dev->hw_features & NETIF_F_GRO_HW);
> +
> +		dev->wanted_features &= ~gro;
> +		features &= ~gro;
> +	}
> +
>  	if (dev->netdev_ops->ndo_fix_features)
>  		features = dev->netdev_ops->ndo_fix_features(dev, features);
>  
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index a546f70f9cc8b..bc340ae0b52e1 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> +static void hsr_portdev_role_clear(struct net_device *dev)
> +{
> +	netdev_lock_ops(dev);
> +	dev->hsr_port = false;
> +	/* Recompute features without the role. GRO was dropped from
> +	 * the request while the role was set and stays off; the user
> +	 * can turn it back on with ethtool. A dying device just drops
> +	 * the role, a netns move stays registered and is recomputed.
> +	 */
> +	if (dev->reg_state == NETREG_REGISTERED)
> +		netdev_change_features(dev);
> +	netdev_unlock_ops(dev);
> +}

[ ... ]

> @@ -169,6 +199,22 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  	if (res)
>  		goto fail_upper_dev_link;
>  
> +	/* Enable the member role and recompute before the RX handler
> +	 * is published, so that software GRO on this device is off
> +	 * before frames can arrive. This covers the direct member
> +	 * only: a stacked member receives from a lower device that
> +	 * may still run GRO and can deliver merged frames as GSO skbs.
> +	 * A still-active software GRO rejects the port, a remaining
> +	 * GRO_HW alone does not.
> +	 */
> +	hsr_portdev_role_set(dev);
> +	if (dev->features & NETIF_F_GRO) {

[Severity: Medium]
The role is set here for every non-master port. Nothing checks
prot_version, port->type or hsr->fwd_offloaded first. Is GRO actually a
problem on all of these ports?

On PRP slave A/B, frames that carry an RCT trailer do not appear to be
merged. inet_gro_receive() flushes when the IP tot_len does not match
skb_gro_len():

net/ipv4/af_inet.c:inet_gro_receive() {
    ...
	flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
    ...
}

prp_is_lan_dup() also drops A/B forwarding. Untagged LAN traffic goes to
the master or interlink untagged, the same way a bridge forwards GRO
skbs.

Some slaves have HW forwarding offload (NETIF_F_HW_HSR_FWD, for example
icssg, ksz9477 and xrs700x). For those, hsr_drop_frame() does:

net/hsr/hsr_forward.c:hsr_drop_frame() {
	if (port->dev->features & NETIF_F_HW_HSR_FWD)
		return prp_is_lan_dup(frame->port_rcv->type, port);
    ...
}

so merged skbs are never re-tagged towards the other slave.

There is also no GRO offload for ETH_P_HSR or ETH_P_PRP. Outside
net/hsr, the only references are in flow_dissector, so tagged frames
cannot be merged. The per-frame metadata problem seems to exist only
where untagged frames get tagged: the interlink, and SAN frames
forwarded between non-offloaded HSR slaves.

Because wanted_features is cleared and not restored when the port
leaves, PRP ports and HW-offloaded ports lose software GRO for good.
Host-bound receive then costs more CPU and gets less throughput. The
commit message does not mention this cost. The Fixes: tag would also
bring this behaviour change into stable kernels.

Could the role be limited to the ports where GRO actually breaks
per-frame tagging?

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "software GRO still on after feature update, cannot join");
> +		res = -EBUSY;
> +		goto fail_role_policy;
> +	}
> +
>  	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
>  	if (res)
>  		goto fail_rx_handler;
> @@ -177,7 +223,12 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  	return 0;
>  
>  fail_rx_handler:
> +fail_role_policy:
> +	/* Rollback order: unlink the upper, clear the role and
> +	 * recompute, then undo this setup's promiscuous increment.
> +	 */
>  	netdev_upper_dev_unlink(dev, hsr_dev);
> +	hsr_portdev_role_clear(dev);

[Severity: Medium]
Can a failed attach leave GRO disabled on a device that never became an
HSR member?

hsr_portdev_role_set() leads to __netdev_update_features(), which clears
NETIF_F_GRO (and configurable GRO_HW) from dev->wanted_features. This
happens before the attach is known to succeed. The previous request is
not saved anywhere. hsr_portdev_role_clear() only recomputes from the
reduced wanted_features.

This rollback undoes the upper link, the role bit and promiscuity, but
not the GRO request. The -EBUSY check above can fire, for example, when
ndo_set_features() fails. In that case __netdev_update_features()
returns early with dev->features unchanged, but wanted_features has
already been cleared.

A second path goes through hsr_del_port(). hsr_dev_finalize() attaches
the ports one at a time:

net/hsr/hsr_device.c:hsr_dev_finalize() {
    ...
	res = hsr_add_port(hsr, slave[0], HSR_PT_SLAVE_A, extack);
	if (res)
		goto err_unregister;

	res = hsr_add_port(hsr, slave[1], HSR_PT_SLAVE_B, extack);
	if (res)
		goto err_unregister;
    ...
}

Slave B or the interlink can fail, for example in hsr_check_dev_ok() or
in the new -EBUSY check. Then err_unregister runs
hsr_del_ports()->hsr_del_port()->hsr_portdev_role_clear() on slave A,
which had attached successfully, and slave A keeps GRO disabled. For
example:

  ip link add hsr0 type hsr slave1 eth0 slave2 lo

fails, but GRO stays off on eth0.

The commit message says:

  A failed attach does not restore the GRO request either; the next patch
  refuses the usual causes before any state is changed.

The next patch, "net: hsr: refuse forwarding devices as HSR/PRP ports",
only adds checks to hsr_check_dev_ok() for the port being attached.
Wouldn't that still leave out ports attached earlier in
hsr_dev_finalize(), and ndo_set_features() failures?

A stable backport selected through the Fixes: tag could also take this
patch without the follow-up.

>  fail_upper_dev_link:
>  	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
>  		dev_set_promiscuity(dev, -1);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107220544.20-1-xiexinet%40gmail.com
