Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846446;
	b=Ca6XwR2Zy7lt2utNmKCbVylvth4/JOkpwQnvSFjEL0UnP+9YjFfa9TJqUQeJjIOM+TMm
	 pLiz8pseI+HLJDqqSdmx5Z52Mr28I3FB6KpnGwHNAo0maDU1O2Y0Y8MITuzQqIpvYUuHZ
	 sQgeIPLY2P0MujB8wJCqQPAR90kBsT4PPITAGUTu7lsQQP2tuaImOJte+Dg6HqLOfxwPo
	 qz1lpL6ew+X2/QbRnWAkbGK3XE1JjXVJu0VnX0XJt8z53D+kDsa2QyPm8bNQ4c/tf/gxZ
	 EQu28sezoTE/krknPdL/tqrqoCI5W7SMvoLZ1vKtEI9QnZVemxDAB9ToWnHn1Ukp71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846446;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mgoHNCQFmyooSMzLO2bc00mj4pbw+UsxHk7YoLVItNo=;
	b=SFZvzQcRUtBAnlrAicDP7bl0rpKjLpPi+mKGAGU8PNN2aU9vN1TUyjl92CAgY2MkId+u
	 brACcuHkvuN5AHkDX/TKHIDcdgXqKTP/fRGZHcUjCOKo4x5/Qgw2oMTGNzfYGAO+SzXsg
	 QrhCbgjglsec/8IdRNRTDkjIMANN3yJrd82hIyA4XXdoDPRkWbwtgJRwFAN7wgRoC3kS5
	 FYfGIdUdFcq/7mUtPU9K6cpxSydhitg55gC0qC2nj5zoK85qFpNlbzVzQZrv9mFLDnd2O
	 c5R887LLjwTtXqRyOmMlIa931VnzcUOEhkX3m55mmJAxHlCQ6EJqjs1ZJ8IkypcudIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jTUwnHc/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463F606A331;
	Mon, 16 Nov 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTUwnHc/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D54F1F000C4;
	Mon, 16 Nov 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846446;
	bh=mgoHNCQFmyooSMzLO2bc00mj4pbw+UsxHk7YoLVItNo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jTUwnHc/3jQtZGhgn+Svf64L3AAZj0Qq9DNcBY6huUoJdXG5ibRAE0tT/tjFteweP
	 MWYpegq/L1yQYXrPXpb7/Pp3Wm/qcadXwBDHvN5069C5z19zk9ErtnO6yNVCyzSCew
	 2AXf9EEMN1yRv+CHxCVXchJrlvzkdaXwaod7Vs9+v6EszkYaX37UzzQY7jp+Ykz5Vr
	 7SeQQzQoXWL++grJeKQvB0A+qLsEw3vllxBUKjFgIh0GxqsCZr4blKmu/gnSgz+2gv
	 1HRJGFpLezSaTsCEmLXLGGkS2QU6z4DMlBvNYXhXwpCqLQaZK7aMugItpYEjiA7rKi
	 as+ZXXWy3eUFA==
Subject:
 Re: [PATCH net v9 2/4] net: hsr: refuse forwarding devices as HSR/PRP ports
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
Date: Mon, 16 Nov 2026 16:27:25 +0000
Message-ID: <179484644509.3136.13013479615245017745@kernel.org>
In-Reply-To: <20261112153333.20-3-xiexinet@gmail.com>
References: <20261112153333.20-3-xiexinet@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is meant to stop recursive seqnr_lock acquisition from
  the HSR transmit path, but it only refuses a list of device types as…

--

net: hsr: refuse forwarding devices as HSR/PRP ports

This patch stops bridge, OVS, bond and team masters from being used as
HSR/PRP slave or interlink ports. It also refuses macvlan or MACsec
devices that sit on top of such masters or on top of an HSR master. It
adds checks for a busy or unsupported RX handler and for an existing
master, and hsr_dev_finalize() now checks every port before changing any
of them.

Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index b7765a4bb9920..666220b24dee4 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -131,13 +163,56 @@ static int hsr_check_dev_ok(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* HSR over bonded devices has not been tested, but I'm not sure it
> -	 * won't work...
> +	/* Forwarding devices feed HSR frames into another device's
> +	 * transmit path and can nest seqnr_lock through a second HSR
> +	 * device. A bridge, bond, team or OVS master makes no sense as a
> +	 * ring or LAN port and is refused by type. A macvlan or MACsec
> +	 * device is refused if such a master or an HSR/PRP master is
> +	 * below it. Other devices keep their lower devices unchecked:
> +	 * DSA user ports are uppers of their conduit.
> +	 */
> +	if (netif_is_any_bridge_master(dev) || netif_is_lag_master(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot use a bridge, bond, team or OVS master as HSR port.");
> +		return -EINVAL;
> +	}

[Severity: High]
If a routed L2 tunnel is used as a slave, can its transmit path come back
into the same HSR master while seqnr_lock is still held?

A gretap, VXLAN or Geneve device is ARPHRD_ETHER with ETH_ALEN. It has no
rx_handler and no master. It is not a VLAN, bridge, LAG, macvlan or MACsec
device, so it passes every check in hsr_check_dev_ok().

Suppose the tunnel's remote address, or its ARP, is routed through hsr0,
for example because hsr0 has an address on the remote's subnet. Then the
announce timer alone looks like enough to trigger it:

hsr_announce()
  send_hsr_supervision_frame()
    spin_lock_bh(&hsr->seqnr_lock);
    hsr_forward_skb()
      hsr_xmit()
        dev_queue_xmit(gretap0)
          gre_tap_xmit()
            ip_tunnel_xmit()
              iptunnel_xmit()
                ip_local_out()
                  ip_finish_output2()
                    dev_queue_xmit(hsr0)
                      hsr_dev_xmit()
                        spin_lock_bh(&hsr->seqnr_lock);

ip_tunnel_xmit() only rejects a route that goes back through the tunnel
device itself:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
    ...
	if (rt->dst.dev == dev) {
		ip_rt_put(rt);
		DEV_STATS_INC(dev, collisions);
		goto tx_error;
	}
    ...
}

hsr_dev_setup() sets IFF_NO_QUEUE and lltx on hsr0, so __dev_queue_xmit()
takes the no-qdisc path. netif_tx_owned() does not see the recursion,
because xmit_lock_owner is not set for lltx devices. dev_xmit_recursion()
is also far below XMIT_RECURSION_LIMIT at this depth.

In the syzbot report the two locks belonged to two different HSR devices.
Here both belong to the same HSR device. So instead of a lockdep warning,
this looks like the CPU deadlocking on a seqnr_lock it already holds, with
BH disabled. User traffic through hsr_dev_xmit() would follow the same
path. A user with CAP_NET_ADMIN in a user namespace can create both the
HSR and the gretap links.

The commit message says this case is not handled:

  Not covered are a tunnel whose route leads back through the HSR master,
  a tc or BPF redirect to it, other stacked devices, and a software
  device without an identifying flag such as batman-adv. Narrowing
  seqnr_lock, planned for net-next, addresses that class as a whole.

This patch has Fixes: tags for the commits that added the seqnr_lock
coverage. Would narrowing seqnr_lock be a better fix here than a list of
refused device types that will have to be replaced later anyway?

At the end of the series, after "net: hsr: segment GSO before per-frame
forwarding", hsr_forward_frame() in net/hsr/hsr_forward.c still holds the
lock around forwarding:

	if (numbered)
		spin_lock_bh(&hsr->seqnr_lock);
	hsr_forward_skb(skb, port);
	if (numbered)
		spin_unlock_bh(&hsr->seqnr_lock);

Both supervision senders also still hold seqnr_lock across
hsr_forward_skb(). So this recursion still seems reachable after the full
series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112153333.20-1-xiexinet%40gmail.com
