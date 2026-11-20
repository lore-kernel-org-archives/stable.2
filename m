Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141323;
	b=d2kFOONWJQsCOJMoklpXUCVXtbhptxGYXcDcfU11tPAI9e7Lvf2GFg3UW+CI5MhwA8hE
	 OsLjEbEF6LxtMOA5rNOk1Ad+ltnxs6AzC3dcIYpK5dKWAgGHxIrkZ0XqROhtb9fE/iHI4
	 F5e9QdO+SVusMV1yi/3QBwUJ17aW+3AFt1YUemKDVlYsrEzb15ErFjrh9PYUAejWe8GsU
	 TaNWVGuH2qnk8SqbCGvPbz2c6kFsj3iGhVmULSZCZgMdJ9J2soIEGp3y5dXUKC0huJObm
	 bm7FbttAWBCe/uZqf1DOjCzSinDAoy5QOicmNFrx5n2awUy0UB+IHCgoeGkLC/2+L5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=88EqaMcAVCVa0mUft6YesqlVkqgDXhu3IuFsh2jgQGo=;
	b=jvIKYSc7FzY8nKKLKZ805DxMz5LYRQ8lQUMWdydrthLsEfLfddkgW2C52lcJ74EWHPP2
	 VXfj3tXkleqLFgT6dx1AQeeVG2nKfuF74qxEKRwB9LO0IF+ajKzCwGKgztusN8CLr55Ed
	 UkRygKIsjS61XUVN261R/IgeV/LSqB25Y+9IjrNcVw4lGJxnDrLUhN2jPEU/Bz2IuLgCu
	 4G7Q2G1RkrUcPU6hXhnV0Asl+ZfYdDxX8k+4YEjckpJjF+JYhkrb2dqMZj36/Fp+gFJE/
	 fZB8Ka6bemM9Y7YjH6nJ0ve2Kq4iflJOfo46SFAlqdSPWONJeY7oN0i/OwPXrHpizDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwbAeWXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7860A2602;
	Fri, 20 Nov 2026 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwbAeWXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE361F000C4;
	Fri, 20 Nov 2026 02:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141323;
	bh=88EqaMcAVCVa0mUft6YesqlVkqgDXhu3IuFsh2jgQGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hwbAeWXnkShbg2VP8D/oqQVl+99+QSjWteEwKNT+Nz0EcBm2/PagbQQ22ySuXDISG
	 PiKJ4TR1nhNY71grWUNw2yeafD9hlQ8RvuRZIdq5j+t1vVCRQRWL2t7weTiEmW+VQa
	 i9eN3PNFyHHTQxF9RnDb4BYs9wDZyxSgojiD2kqlxfeSOINhqnHQpPw6g5k7/uDazM
	 V1/NSqaHi9vHcL7TNgM/wQbQijQGZ2spJ33jX/RO8+9sh6u2LJyCJXRUUbOm/4G36F
	 RrqnjNcJCdLn0+OLa82IMQPmC2M98Egu3je6NcOyE8ujK4Vak8H/nrNGQm6Js9EIKx
	 vSLy6TkovKKZQ==
Subject:
 Re: [PATCH net v10 2/4] net: hsr: refuse forwarding devices as HSR/PRP ports
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
Date: Fri, 20 Nov 2026 02:22:01 +0000
Message-ID: <179514132185.3136.17085396682149520983@kernel.org>
In-Reply-To: <20261117141922.20-3-xiexinet@gmail.com>
References: <20261117141922.20-3-xiexinet@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch addresses the seqnr_lock recursion only by refusing
  certain port device types at attach time (bridge/OVS/bond/team…
- [Low] The patch is tagged for backport as a seqnr_lock recursion fix
  (Fixes: 06afd2c31d33, from v6.2, and Fixes: 430d67bdcb04), but it also…

--

net: hsr: refuse forwarding devices as HSR/PRP ports

This patch stops bridge/OVS/bond/team masters from being used as HSR/PRP
slave or interlink ports. It also refuses a macvlan or MACsec device that
sits on top of such a master or an HSR master. This addresses the
seqnr_lock recursion that syzbot reported. The patch also refuses devices
whose RX handler is busy or unsupported, or that already have a master.
All ports are checked before any of them is modified.

Closes: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 4c4f8fe3d128a..a4dd64227db5f 100644
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
> +	if ((netif_is_macvlan(dev) || netif_is_macsec(dev)) &&
> +	    netdev_walk_all_lower_dev(dev, hsr_lower_forwards, NULL)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot use a macvlan or MACsec device stacked on an HSR, bridge, bond, team or OVS master as HSR port.");
> +		return -EINVAL;
> +	}

[Severity: High]
These checks in hsr_check_dev_ok() refuse ports by device type, and only
at attach time. seqnr_lock is still held across the synchronous transmit
to the ports:

net/hsr/hsr_device.c:hsr_dev_xmit() {
    ...
		spin_lock_bh(&hsr->seqnr_lock);
		hsr_forward_skb(skb, master);
		spin_unlock_bh(&hsr->seqnr_lock);
    ...
}

hsr_forward_skb() then goes through hsr_xmit() to dev_queue_xmit() on the
port device. The same pattern is in send_hsr_supervision_frame(),
send_prp_supervision_frame() and the interlink branch of
hsr_handle_frame().

Can a plain veth slave still re-enter the xmit path of its own HSR master?
For example, take veth0 as a slave of hsr0, with a tc egress mirred
redirect back to hsr0:

hsr_dev_xmit(hsr0)
  spin_lock_bh(&hsr->seqnr_lock)
  hsr_forward_skb()
    hsr_xmit()
      dev_queue_xmit(veth0)
        tcf_mirred_act()   /* egress redirect to hsr0 */
          dev_queue_xmit(hsr0)
            hsr_dev_xmit(hsr0)
              spin_lock_bh(&hsr->seqnr_lock)   /* already held */

On the first redirect, tcf_mirred_act() only looks at
sched_mirred_dev[], and hsr0 is not in it yet. hsr0 is lltx with
IFF_NO_QUEUE, so neither the xmit_lock_owner check nor
dev_xmit_recursion() would stop this either. veth passes every check in
hsr_check_dev_ok().

That would be an AA self-deadlock on one instance with BH disabled. That
is worse than the cross-instance lockdep splat in the syzbot report.
CAP_NET_ADMIN in an unprivileged user namespace seems to be enough to set
this up.

Other ways back into an HSR master also get past these checks:
ARPHRD_ETHER tunnels routed through the HSR master, BPF redirects,
stacked devices whose lower devices are not walked (for example
virt_wifi over a bridge), and batman-adv.

The commit message acknowledges this:

    Not covered are a tunnel whose route leads back through the HSR
    master, a tc or BPF redirect to it, other stacked devices, and a
    software device without an identifying flag such as batman-adv.
    Narrowing seqnr_lock, planned for net-next, addresses that class as
    a whole.

This is still the case at the end of the series. There,
hsr_forward_frame() in hsr_forward.c takes spin_lock_bh(&hsr->seqnr_lock)
around hsr_forward_skb().

The bug class covered by the Fixes: tags is still reachable. Would it be
better to stop holding seqnr_lock across dev_queue_xmit() in this fix,
instead of adding a denylist that the planned lock narrowing would
replace?

> +	/* A macvlan takes its GRO setting from the lower device, so the
> +	 * member role cannot turn it off. Refuse at attach, before any
> +	 * state change, if the lower device runs GRO; it can still turn
> +	 * GRO on later.
>  	 */
> +	if (netif_is_macvlan(dev) &&
> +	    (macvlan_dev_real_dev(dev)->features & NETIF_F_GRO)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "macvlan inherits GRO from its lower device; turn GRO off on the lower device.");
> +		return -EBUSY;
> +	}

[Severity: Low]
This check only makes sense together with the member-role GRO policy
from the previous patch, "net: hsr: keep GRO disabled on HSR/PRP ports".
It is an earlier form of the rejection that patch added to
hsr_portdev_setup():

    hsr_portdev_role_set(dev);
    if (dev->features & NETIF_F_GRO) {
        NL_SET_ERR_MSG_MOD(extack,
                   "software GRO still on after feature update, cannot join");

It is not related to the seqnr_lock recursion.

This patch carries Fixes: 06afd2c31d33 (v6.2) and Fixes: 430d67bdcb04.
The previous patch is only tagged Fixes: 5055cccfc2d1 (RedBox, v6.10).

Suppose stable takes this patch into 6.1 or 6.6 without the GRO policy
patch. Would this hunk then refuse a macvlan on a NIC or veth, where GRO
is on by default, with an error message that does not apply to that
tree?

The patch probably won't apply cleanly there anyway, since the "Member
role and feature policy" block and the interlink argument to
hsr_dev_finalize() don't exist in those trees. A backporter may drop
this hunk, but nothing in the commit tells them to.

Could this hunk move into the GRO policy patch, or could a stable
dependency note be added? Right now the commit message mentions the
previous patch only in the prose.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117141922.20-1-xiexinet%40gmail.com
