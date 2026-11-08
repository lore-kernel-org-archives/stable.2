Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175708;
	b=tl6euno7UhxaFdvxja0JLUVjjdV3ynXQ0EFUuVt1iqzYp9lQxFWAPS2uH30vTZOY0IQv
	 dt4dQ4PdtY8sJz88kUXgjb9tswLvFzGPNUQHrVrht/rHfc4Rf4FShLi0Krdf8kJPU8MBL
	 RDNx0fRPw3whM42o8BQt0i2R2eFg70brSQ2WurkAp8t2s2P7rYUYrjsj4agd+F5CD3a02
	 NmyoKbVdxJ0zVDHdI4202076fobOWeIm2oHlNJIqR/3lE7/EwjJhsvsuqz4l2805vpP+f
	 Y+jnwN9oY7CL+THvmrtsbwrrni27Sy3l5b39VGSejsukedItG4b/9grfI+UR45shlPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175708;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SOkKIEc2SpX28V7/1Uwnkw5Id1sJIbke+RCOB3FsR1k=;
	b=1iddt7NtbJtIscjEy2MTy/3qE73FeFNmz9wMSO7GooJRFUT+fzhNRqXzcQjCqvpBxNaR
	 hVboqA8ESkS4W45clRIKpqjTJBi6iEg0FPEUS7T3YCY6qT9+VDmgsiZLobWALZa3tTL15
	 HSgtPA8nF8mld8z6opSLMTQyme6F8yxDaniaBJmBhUJb1CYoAPBpNWcl33ikNghplWCjE
	 0ilI8O9cynXM5WDVNHn5UM4Z5H3B6uRMmhlMBBtSztUg7/LuDzRkNzqOKw7DpLlq6bpAy
	 BHPAX092tec5+uFyy8lcwY/W4v9+/j3Gigk0+epnf+vr7/r2IPe7/hhPpye0lEU81Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy4A2a5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D88606A31C;
	Sun,  8 Nov 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy4A2a5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090171F008A2;
	Sun,  8 Nov 2026 22:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794175707;
	bh=SOkKIEc2SpX28V7/1Uwnkw5Id1sJIbke+RCOB3FsR1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oy4A2a5uLZhJpDjqkBSqU4ZZjPxMJHIo0839QttJIXWUtiWF5JVj+EHGhAxlwITIC
	 IAHilU9173YLvCQ5eCtK+tzEO8RNd3Rr9UpYvtZanO2N+uMZRErhbLGIsBZdqkpoGa
	 y+tN7BboVTuyiff2DExUSJg+xuyaW890AuBnUZnAIeR6Pr6NxtDdF4rtVixyxWvilr
	 1Kv0CNAdGdaFvkX4WGgrpdrIfuM1u1bCBLY6HkS/naC6iZQpZNgRQ/IzRgP6VP3InN
	 ouMO0/e2X17Ka9o/SyYxkE0RlBr8V38lZq/ns8tx1V1EwPDhVJAXoS0bFE5JOCNruF
	 P/HjKZviMlv2Q==
Subject:
 Re: [PATCH net v8 2/4] net: hsr: refuse forwarding devices as HSR/PRP ports
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
Date: Sun, 08 Nov 2026 22:08:25 +0000
Message-ID: <179417570554.994134.17137863494736269542@kernel.org>
In-Reply-To: <20261107220544.20-3-xiexinet@gmail.com>
References: <20261107220544.20-3-xiexinet@gmail.com>
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

- [High] The fix does not close the bug class it targets.
- [Medium] hsr_check_dev_ok() now refuses every macvlan and MACsec device
  as an HSR/PRP slave or interlink with -EINVAL, whatever its lower…

--

net: hsr: refuse forwarding devices as HSR/PRP ports

This patch makes hsr_check_dev_ok() refuse bridge, OVS, bond, team,
macvlan and MACsec devices as an HSR/PRP slave or interlink. It also
refuses devices with IFF_NO_RX_HANDLER or a busy RX handler before any
state is changed. The target is a syzbot recursive locking report: a
supervision frame sent with seqnr_lock held goes to a bridge slave, which
floods it into a second HSR master.

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index bc340ae0b52e1..26f16d98e4793 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -131,9 +147,19 @@ static int hsr_check_dev_ok(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* HSR over bonded devices has not been tested, but I'm not sure it
> -	 * won't work...
> +	/* Forwarding devices feed HSR frames into another device's
> +	 * transmit path. A bridge, bond, team or OVS master or a macvlan
> +	 * or MACsec device makes no sense as a ring or LAN port and can
> +	 * nest seqnr_lock through a second HSR device. Refuse them by
> +	 * type: devices with lower devices in general stay valid, DSA
> +	 * user ports are uppers of their conduit.
>  	 */
> +	if (netif_is_any_bridge_master(dev) || netif_is_lag_master(dev) ||
> +	    netif_is_macvlan(dev) || netif_is_macsec(dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot use a bridge, bond, team, OVS, macvlan or MACsec device as HSR port.");
> +		return -EINVAL;
> +	}

[Severity: High]
Does this type check close the seqnr_lock nesting, or only the bridge
reproducer from syzbot?

The lock is still held across the whole transmit path of the port. For
example, in hsr_dev_xmit():

net/hsr/hsr_device.c:hsr_dev_xmit() {
    ...
		spin_lock_bh(&hsr->seqnr_lock);
		hsr_forward_skb(skb, master);
		spin_unlock_bh(&hsr->seqnr_lock);
    ...
}

send_hsr_supervision_frame(), send_prp_supervision_frame() and the
interlink branch of hsr_handle_frame() follow the same pattern. The call
hsr_forward_skb()->hsr_xmit()->dev_queue_xmit(port) runs the port's tc,
BPF and ndo_start_xmit with the lock held.

spin_lock_init() is only called from hsr_dev_finalize(), so all HSR
instances share one lockdep class.

Any ARPHRD_ETHER port that passes these checks but whose egress reaches an
HSR master synchronously seems to hit the same splat:

- A plain veth or NIC slave with a clsact egress filter doing
  "mirred egress redirect dev hsr1". In that case
  tcf_mirred_act()->tcf_mirred_forward() calls dev_queue_xmit(hsr1). The
  mirred loop check only compares against devices already in
  sched_mirred_dev[], so it does not catch the first redirect.
  bpf_redirect() from tcx or cls_bpf behaves the same way.

- A virt_wifi device created on top of an HSR master. virt_wifi_newlink()
  accepts any lower device, and the virt_wifi device is set up with
  ether_setup() and none of the refused priv_flags.
  virt_wifi_start_xmit() then does:

	skb->dev = priv->lowerdev;
	return dev_queue_xmit(skb);

- Ethernet tunnels whose underlay routes through an HSR master. The
  commit message already mentions these.

Suppose the redirect targets the same HSR master: veth0 is a slave of
hsr0, and veth0's egress filter redirects to hsr0. Can this deadlock the
CPU?

hsr_announce() timer
  spin_lock_bh(&hsr0->seqnr_lock)
  hsr_forward_skb()->hsr_xmit()->dev_queue_xmit(veth0)
    sch_handle_egress()->tcf_mirred_act()->tcf_mirred_forward()
      dev_queue_xmit(hsr0)
        hsr_dev_xmit()
          spin_lock_bh(&hsr0->seqnr_lock)

hsr0 is lltx and IFF_NO_QUEUE, so __dev_queue_xmit() calls ndo_start_xmit
directly. Neither the dev_xmit_recursion() limit nor MIRRED_NEST_LIMIT is
reached before the second spin_lock_bh(), so the CPU spins on a lock it
already holds, with BH disabled. Setting this up only needs CAP_NET_ADMIN,
which a user namespace provides.

The commit message says:

    A chain of two devices does not deadlock, but such a port makes no
    sense

It lists only tunnels and batman-adv as not covered. Should it also
mention tc/BPF redirects, virt_wifi and the single-device self-deadlock?

The later commit "net: hsr: segment GSO before per-frame forwarding" moves
the lock into hsr_forward_frame(). It still holds the lock around
hsr_forward_skb(), and so around dev_queue_xmit(), so the problem appears
to remain at the end of the series.

Would it be better to change the locking itself? For example, the
sequence number could be assigned under seqnr_lock and the frame sent
after dropping the lock. At minimum, each instance could get its own
lockdep key. Either would replace this denylist rather than extend it, so
the Closes: tag for the syzbot report looks premature.

[Severity: Medium]
Is it intended to refuse every macvlan and MACsec device here, whatever
its lower device is?

Before this patch both types were accepted as a slave or interlink. Both
are ARPHRD_ETHER with ETH_ALEN, neither sets IFF_DONT_BRIDGE or
IFF_NO_RX_HANDLER, and their RX handler is on the lower device.

The commit message justifies the type rule with "ports can be added
later", but that only applies to bridge, bond and team masters. A
macvlan's lower and a MACsec real_dev are fixed when the device is
created. After that, macvlan_port or macsec holds the lower's RX handler,
so the lower cannot join a bridge or bond later either.

Could a single walk of the lower chain at attach time close the nesting
path through these two types, refusing an HSR master or a bridge/LAG
master found there? Configurations that cannot nest seqnr_lock would then
keep working. Examples are PRP LANs or HSR links over MACsec-protected
physical links, and PRP ports on macvlan in containers.

Because of the Fixes: tags, stable kernels would start rejecting these
previously valid rtnetlink requests with -EINVAL, for example
"ip link add ... type hsr slave1 macsec0 ...". Should the commit message
say that these configurations are no longer allowed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107220544.20-1-xiexinet%40gmail.com
