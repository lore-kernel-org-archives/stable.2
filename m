Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616136;
	b=tPtU1A/YfbwwBZ2okV18T8WQt3iB5tYYjhfhWX5vY1NDynlZckWEzUc/4sdcVDLtKYPQ
	 HyuE0cV7S81Vx4HnQ6DPQ5GGdio6QsOlJgPoedl4W3k2pKDJDxWx3Gp+4MKkwdwftdnz5
	 0ThDMy2A3m0E01fXGdYW03sea3OQqrpINeeFVzFrx0tcSDsUSEiIVHZm1LUWtl3kRj/sm
	 Vi/0MZDYaVwpBZ8ZX6n+qcARNrTmNLo2DTMHsPuwBsPSngddcYzkqsam6MKTsZYKC8hF+
	 y/8GCERgvoTs3DfmAgHVFSok0Y0I8f86sVNfd4/oMhboC2lKk7/iju/FV8SlqMllG4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cQXziTHZV6C/cCh4qEBD09P6Zi2IJuFYzr1HsriBBI8=;
	b=KsR8EsyzpoVDrCpHeOAUc4/OanP2VXd9uJDHvlX1o/zlZE8FjF8MgZK+YGsaj1N7nYT7
	 6XHggEfxCeb+DDwr9JgA8WNFJFD3v0KAS4SgS1n8h0wQz+tkKH54uRtHUbcNihvmvrPNC
	 Vy2KuVP+t9TcYdovgXtA8Gv5TDaPfgwFzKaCJZzKkU100TU1CYOTrAvGNzJhXwvVutFHr
	 bJbrOpffofabcOXh3TBwzOeBWvtLe5j8QFo93NY2MLtrrkD9oHpMUp3wrc3UVnYIiBq7+
	 lRHP0MveZSzy9m7pz+gPd2op71hg3LF5D+vTmknXvtk2UROShnfokfcqfVacB+q1AKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu6rA4BX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED2606A31D;
	Wed, 21 Oct 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu6rA4BX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA541F000CC;
	Wed, 21 Oct 2026 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616136;
	bh=cQXziTHZV6C/cCh4qEBD09P6Zi2IJuFYzr1HsriBBI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu6rA4BXqoTTGmb0+CJEOnzAEDIFrAnjUXai4Ab2OrgvdOP06iP3n2DAurw10gr58
	 UjdBEXu8laeRyjipy/l7666aIKsMq2OAzriiktUAsmF8o+dj8jy3ubwnHQXYwbJXIN
	 zmM6Z5tZVrfSy8oQe4iGJawx6XWlbdJs+W6SuaaWmzRVk6UBONP7l7NA04cXhv7jWa
	 BfnYi/moTdv9v9h8/5eYQO8mMjSB2nuy1ESP+ix8UTHHihHupMSnuZoCE2qpQ2ofU/
	 Hom9qoKgg2wnVmVKxNA1DKb6BckRZr63JvM9LchqiSqNjS3gJ3Q+hXQKStOmQ41xHw
	 Lf60z+Spgs8yA==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org,
	socketcan@hartkopp.net
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a per-device lock
Date: Wed, 21 Oct 2026 13:55:34 -0700
Message-ID: <20261021205534.1620083-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021102756.1900679-12-mkl@pengutronix.de>
References: <20261021102756.1900679-12-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
can: protect the receive lists with a per-device lock

This commit adds a spinlock to struct can_dev_rcv_lists. The receive lists
of a CAN device are now protected per device instead of by the per-netns
rcvlists_lock, so can_rx_unregister() can find subscriptions after the
device has moved to another namespace.

RTNL is dropped from raw_bind(), raw_setsockopt(), raw_release(),
isotp_bind() and isotp_release(). These paths now use lock_sock() and a
device pointer published under RCU to serialize against the netdev
notifier.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261020203257.230955-6-socketcan@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 5e1c3971ebfce..8ec37d252557e 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1614,7 +1612,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		goto out;
>  	}
>  
> -	dev = dev_get_by_index(net, addr->can_ifindex);
> +	/* Publish the device inside the RCU section of the lookup: When it
> +	 * is unlisted concurrently, either isotp_notify() sees so->dev after
> +	 * synchronize_net() or the lookup fails.
> +	 */
> +	rcu_read_lock();
> +	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
> +	if (dev) {
> +		dev_hold(dev);
> +		WRITE_ONCE(so->dev, dev);
> +	}
> +	rcu_read_unlock();
>  	if (!dev) {
>  		err = -ENODEV;
>  		goto out;
> @@ -1627,7 +1635,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		err = -EINVAL;
>  		goto out_put_dev;
>  	}

[Severity: Low]
so->dev is now visible to the lockless check in isotp_notify() before the
remaining checks in isotp_bind() run, and before so->bound is set. The MTU
check can still fail the bind:

	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
		err = -EINVAL;
		goto out_put_dev;
	}

so->dev is only cleared again at out_put_dev.

isotp_bind() no longer holds RTNL. Can a NETDEV_DOWN for the same device
run isotp_notifier()->isotp_notify() inside this window?

The NETDEV_DOWN case only checks READ_ONCE(so->dev) != dev. It does not
look at so->bound or recheck under lock_sock():

	case NETDEV_DOWN:
		sk->sk_err = ENETDOWN;
		if (!sock_flag(sk, SOCK_DEAD))
			sk_error_report(sk);
		break;

Would this set a stale ENETDOWN on a socket that was never bound, whose
bind() then returns -EINVAL? A later successful bind() to another device
(after fixing ll.mtu with CAN_ISOTP_LL_OPTS) would then get that error from
the next recvmsg() or poll().

raw_bind() avoids this. It only publishes ro->bind_dev early, which
raw_notify() uses for NETDEV_UNREGISTER only, and it sets ro->dev after
success. Could isotp use the same approach?

> @@ -1653,15 +1666,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  	 * can safely reach the device later, even if a concurrent
>  	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
>  	 */
> -	so->dev = dev;
>  	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);

[Severity: Low]
This isn't a bug introduced by this patch, but isotp_bind() ignores the
return values of both can_rx_register() calls just above this:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, sock_i_ino(sk), sk);
	...
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, sock_i_ino(sk), sk);

It then sets so->bound = 1 unconditionally.

can_rx_register() returns -ENOMEM if kmem_cache_alloc(rcv_cache,
GFP_KERNEL) fails. Can the socket then report a successful bind() while it
is missing its FC/RX receiver or its echo receiver?

Later, isotp_release() and isotp_notify() would call can_rx_unregister()
for an entry that was never added and hit the "receive list entry not
found" warning. raw_enable_filters() and bcm_rx_setup() check this return
value and unwind.

-ENODEV from the net_eq() check does not look reachable here.
isotp_notify() waits on lock_sock() for NETDEV_UNREGISTER, so dev_net(dev)
cannot change during the registrations. That leaves -ENOMEM as the only
error.

The earlier commit "can: replace ARPHRD_CAN type checks with
can_get_ml_priv()" in this series already notes that isotp_bind() ignores
these return values.

[ ... ]

> diff --git a/net/can/raw.c b/net/can/raw.c
> index dfea48768b231..d07f3bb68cd5c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -750,18 +772,47 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>  			  sockptr_t optval, unsigned int optlen)
>  {
>  	struct sock *sk = sock->sk;

[ ... ]

> -	rtnl_lock();
> +	if (optname == CAN_RAW_FILTER) {
> +		/* Copy the filters before lock_sock(), so a stalled copy can
> +		 * not block raw_notify() waiting for lock_sock() under RTNL.
> +		 */

[ ... ]

> +	}
> +
>  	lock_sock(sk);
>  
> -	err = raw_setsockopt_locked(sock, optname, optval, optlen);
> +	err = raw_setsockopt_locked(sock, optname, optval, optlen,
> +				    filter, &sfilter, count);

[Severity: Medium]
The comment says a stalled copy must not block raw_notify() while it waits
for lock_sock() under RTNL. The early copy only covers CAN_RAW_FILTER,
though. Do the other options still copy from user memory with lock_sock()
held?

In raw_setsockopt_locked(), CAN_RAW_ERR_FILTER still does:

	if (copy_from_sockptr(&err_mask, optval, optlen))
		return -EFAULT;

CAN_RAW_LOOPBACK, CAN_RAW_RECV_OWN_MSGS, CAN_RAW_FD_FRAMES,
CAN_RAW_XL_FRAMES, CAN_RAW_XL_VCID_OPTS and CAN_RAW_JOIN_FILTERS do the
same after lock_sock(sk) is taken here.

raw_getsockopt(CAN_RAW_FILTER) also writes to the user buffer with
lock_sock() held:

	lock_sock(sk);
	...
		if (copy_to_iter(ro->filter, len,
				 &opt->iter_out) != len)
			err = -EFAULT;

Suppose one of these copies stalls on a FUSE-backed mapping while the
socket is bound, or while ro->bind_dev matches the device. Would a
NETDEV_UNREGISTER of that device then leave raw_notify() sleeping in
lock_sock() with RTNL held?

raw_notifier()
  raw_notify()
    lock_sock(sk)   <- waits for the stalled setsockopt/getsockopt

The unregister could come from ip link del of a vcan device in the user's
own network namespace, a namespace move, or a USB unplug.

The new ro->bind_dev hint also adds cases where raw_notify() takes
lock_sock(): a stale bind_dev that matches the unregistered device leads
there too.

Before this patch, raw_setsockopt() held rtnl_lock() itself across these
copies, so overall exposure is lower than before. The new design relies on
lock_sock() never being held across a user copy, though. Should the
remaining copies in raw_setsockopt_locked() and raw_getsockopt() also move
out of the locked section?

isotp_setsockopt() has the same pattern against isotp_notify(), since every
option is copied under lock_sock():

	lock_sock(sk);
	ret = isotp_setsockopt_locked(sock, level, optname, optval, optlen);
	release_sock(sk);

That code predates this patch. With RTNL gone from isotp_bind(), however,
bind relies on lock_sock() alone to serialize with isotp_notify().
