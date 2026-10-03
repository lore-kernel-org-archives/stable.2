Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074A202F71;
	Sat,  3 Oct 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007242; cv=none; b=V1Bl6qP31ojdEMfz6R9f9bYccVpOJGDp0sQh/UgICl9T1S7tA23NQBO7cHjItY/D7Pffw1LDGZb069paqXPcFwgmZzo93+C/ejd3ekFQ33OEAyZN7O32USYzSRXq8iWzqucDWvT4Obg6POwbTB/WAyuEzxPEqE2rwbFNbzo6ezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007242; c=relaxed/simple;
	bh=ohIPok/BFP6uMJfM7qyNOJIMzdDYxxZNv+MIpcymZns=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BtQm8pDX+GidtCWfbi6cfKteyggsyI72C6fmr3D4cS3R0wvzPcLtFGtQVjC0BW0XNVBVu5bpXAfqcEHIlvn8mQalURFujYuM0I1G5wKh6j7c1SjmNPC0UKdqif5bcolI4RDDaberU4Xtw4FzwhHCPm6Ty77apZekdh69Oe0qav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkPVsCvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkPVsCvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107221F0089B;
	Sat,  3 Oct 2026 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791007240;
	bh=jjTCW0XcHmBwpD7KH26Wd4I5Y6sUM0wHJc97IGGvjLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gkPVsCvpRlMRshL38fhu/7dV+qCi5SHzFjkgQf7AXL59AQBwVFI2s8ffNq4gICpaM
	 G31qd22XCC0SVos3av2UGPYDqNeOU84CePwxR5qa5amw6TKNxAAr5Qzp4YE992fr1O
	 zyCYse7wF65Zlctj02FdRDIBcc6uTHI6bKZEI5nX041IzV9wL+EtSXEzCUQILwfXlO
	 1NgBxffSmpjpzX4NgiqdTOoKhY6qUN2CY/7xiNKPDx6vNHU2JBWoNsdw82wL4S1B1a
	 GW6iujzswVbsDqEk3LVcT4igPyQ+QzXUj5rf/VC7DVvkPcplhDkjEBqdFktldIHye8
	 DRSkcgXkKaqDQ==
Subject: Re: [PATCH v4 1/3] can: remove CAN filters independent from namespace
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, norbert@doyensec.com, stable@vger.kernel.org,
 kuba@kernel.org
Date: Sat, 03 Oct 2026 06:00:39 +0000
Message-ID: <179100723953.1406898.16481112360707650171@kernel.org>
In-Reply-To: <20260929154125.3298-2-socketcan@hartkopp.net>
References: <20260929154125.3298-2-socketcan@hartkopp.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_notify() now calls lock_sock(sk) right away for every BCM
  socket on the global bcm_notifier_list.
- [High] Releasing a BCM socket that races with a namespace move of its
  bound device can still leave a receive filter pointing at a freed…
- [Medium] The commit message's account of the bug cannot happen.
- [Low] The commit message presents the isotp_release() change as
  converting two 'missing' call sites.

--

can: remove CAN filters independent from namespace

This patch removes the net_eq(dev_net(dev), sock_net(sk)) early return
from the raw, isotp and bcm netdev notifiers. In bcm.c it adds tracked
device pointers (bo->dev, op->tx_dev) for device comparisons and takes
lock_sock() for all of bcm_notify(). In isotp_release() it passes
dev_net(so->dev) to can_rx_unregister() instead of sock_net(sk).

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/

> When the devices namespace is changed the socket namespace and the device
> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
> the CAN protocols netdev notifiers therefore led to skipping the required
> removal of the CAN filters from the (namespace changed) CAN devices.

[Severity: Medium]
Is this description of the bug accurate? In __dev_change_net_namespace(),
NETDEV_UNREGISTER is sent while dev_net(dev) still points to the old
namespace. The namespace is switched only afterwards:

net/core/dev.c:__dev_change_net_namespace() {
    ...
	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
    ...
	dev_net_set(dev, net);
    ...
}

Every bound device is resolved with dev_get_by_index(sock_net(sk), ...).
raw_bind() and isotp_bind() do this under rtnl_lock(). bcm_connect() and
bcm_rx_setup() do it under lock_sock(). So for every socket still on the
notifier list, the removed net_eq() check seems to have always been true
when its device got NETDEV_UNREGISTER.

In raw_notify() and isotp_notify(), the ro->dev != dev and so->dev != dev
checks that follow already made the net_eq() check redundant.

The bug that actually existed appears to be the sock_net(sk) argument in
isotp_release(). That function runs after the socket has left the
notifier list.

Could the commit message describe the real mechanism? As written, it also
justifies the bcm.c rework (bo->dev, op->tx_dev and the unconditional
lock_sock() in bcm_notify()). That rework is needed only because the
net_eq() check was removed, and it is the source of the bcm_notify()
concern below.

> In isotp.c the two missing can_rx_unregister() calling sites are converted
> to use dev_net(dev) instead of sock_net(sk) to get the correct namespace.

[Severity: Low]
This hunk looks like the actual fix for a use-after-free, but the commit
message doesn't say so. Could it describe the race and the use-after-free?

isotp_release() removes the socket from isotp_notifier_list before it
takes rtnl_lock(). If __dev_change_net_namespace() runs in that window,
its NETDEV_UNREGISTER notifier never sees the socket, and the device moves
to the new namespace.

Before this patch, isotp_release() then passed sock_net(sk) to
can_rx_unregister(), which returns early on the namespace mismatch:

net/can/af_can.c:can_rx_unregister() {
    ...
	if (dev && !net_eq(net, dev_net(dev)))
		return;
    ...
}

The isotp_rcv() and isotp_rcv_echo() receivers stay registered with
data == sk, and sock_put(sk) then frees the socket. can_rx_register()
holds no reference on sk, so the next matching frame on the moved device
calls isotp_rcv() on freed memory.

raw_release() already used dev_net(ro->dev) under rtnl_lock(), and bcm
goes through bcm_rx_unreg(), which uses dev_net(dev).

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..cd3522ec32c0a 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1792,15 +1833,13 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>  {
>  	struct sock *sk = &bo->sk;
>  	struct bcm_op *op;
> -	int notify_enodev = 0;
> +	int sk_err = 0;
>  
> -	if (!net_eq(dev_net(dev), sock_net(sk)))
> -		return;
> +	lock_sock(sk);

[Severity: High]
Can a user confined to their own network namespace now stall rtnl_mutex
here indefinitely?

bcm_notifier() walks every BCM socket on bcm_notifier_list for each CAN
NETDEV_DOWN or NETDEV_UNREGISTER, with rtnl_lock() held. Before this
patch, sockets in a foreign namespace returned before taking any lock,
and NETDEV_DOWN never took lock_sock(). Now lock_sock() is taken on every
BCM socket in the system for both events.

bcm_sendmsg() holds the socket lock across user copies:

bcm_sendmsg()
    lock_sock(sk);
    bcm_tx_setup()
        memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

bcm_rx_setup() has the same pattern.

An unprivileged user can put the frame data on a page whose fault they
control, for example a FUSE-backed mapping inside a user namespace. The
socket lock can then be held for as long as they want.

Any host-side "ip link set can0 down", unplug, unregister or netns move of
any CAN device would then block in bcm_notify() with rtnl_lock() held.
All link, address and route configuration and netns creation or cleanup
would stall behind it.

A similar same-namespace stall was already possible for users who can
create and delete their own vcan. This patch extends it to host devices
and to NETDEV_DOWN.

Could the bo->dev, op->tx_dev and op->rx_reg_dev comparisons be done as a
prefilter, so that lock_sock() is not taken on unrelated sockets? Even
with the rest of the series applied, only the device type check in
bcm_notifier() changes, so this lock_sock() stays unconditional.

>  
>  	switch (msg) {
>  
>  	case NETDEV_UNREGISTER:
> -		lock_sock(sk);

[ ... ]

> @@ -1984,6 +2025,10 @@ static int bcm_release(struct socket *sock)
>  	if (bo->bound) {
>  		WRITE_ONCE(bo->bound, 0);
>  		bo->ifindex = 0;
> +		if (bo->dev) {
> +			netdev_put(bo->dev, &bo->dev_tracker);
> +			bo->dev = NULL;
> +		}
>  	}

[Severity: High]
Can bcm_release() still leave an rx filter pointing at a freed bcm_op if
it races with a namespace move of the bound device?

bcm_release() removes the socket from bcm_notifier_list and then takes
only lock_sock(sk), not rtnl_lock(). For each rx_op with op->rx_reg_dev,
teardown goes through bcm_rx_unreg():

bcm_rx_unreg()
    can_rx_unregister(dev_net(dev), dev, ...)
        if (dev && !net_eq(net, dev_net(dev)))
            return;

Meanwhile __dev_change_net_namespace() runs under rtnl_lock(). Its
NETDEV_UNREGISTER notifier skips this socket because the socket is already
off the list. It then calls dev_net_set(dev, net).

Suppose dev_net_set() lands between the dev_net(dev) read in
bcm_rx_unreg() and the re-read in can_rx_unregister(). The receiver then
stays linked with func == bcm_rx_handler and data == op.

can_rx_unregister() returns void, so bcm_rx_unreg() still clears
op->rx_reg_dev and drops the reference. bcm_release() then frees the op:

bcm_remove_op()
    call_rcu() -> bcm_free_op_work()
        sock_put(op->sk);
        kfree(op);

The next matching frame on the moved device would call bcm_rx_handler()
on freed memory. The window per op is narrow, but it can be retried, and
a socket with many rx_ops widens it.

isotp_release() and raw_release() avoid this by holding rtnl_lock() around
the unregister. Should bcm_release() take rtnl_lock() as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929154125.3298-1-socketcan%40hartkopp.net
