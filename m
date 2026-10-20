Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516328;
	b=h1ZFgARaf5trEpPC+MYgxUhL0BSs/22e7ndGzYwfc5TCW52lXThN0uDCoNWuKY7qmbXO
	 WR5NewXP6tkeXyTiG0IsB3Jactk6TaTCzkxhMMN9QZX3qVBi2CzDGYAfGukBsqjgIamdE
	 ntHDws8K30uWHLhVtvgrC97RLW/LtUnUso2YXES/67d5QU4602Z5JAvXaaLEun/IvkbIK
	 4IRmyA8UmixfwA3h3VfV7yo6DDlcMYyzPw8c8DiyalixxD42gd8M93ccUduCHtMrsAQ7f
	 Jcbl+v3mso6/P6hs93aWqluwiM/Hqsqaa1YpNZCMQwhWPPmJ+S9qUMvfFTOrmPflGVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516328;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=o3WJRJcePloVZq4AExePZBL3lYY5STJ5wC5g0j9QDrc=;
	b=nPH45SKAPuy04uGJusyarTeDPqIZ1dp1/sSv4VTYKBkxourv0RhjDUxhLkLyTOD4pKpE
	 UdNWKSQexJtLmbTvyGqS1kvQpJSc6TK7Quq4PpZ+7PXH35oMI0x2C/A4Wc4pzSJA8BHa1
	 wUIrWmq4k8PBiMJaiXCw6ORCAe05g1/LWiOY5BPqLvsOvXoPzxZcYpsRVTfPmsyGW3itc
	 ns7lCMhq798NgLnGa5aGr1p4kBd8ovBPipqec0E8vIrNRLrt3OyTETcHvxWufUqzl/5pb
	 b/vEBer5OCGpplLnpGleW+52Vk9eTXOQZI2igsTewErk2lCVCo1r3JCw/qttKAUF3dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfuCXTLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9088606A336;
	Tue, 20 Oct 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfuCXTLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63A1F000C9;
	Tue, 20 Oct 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792516327;
	bh=o3WJRJcePloVZq4AExePZBL3lYY5STJ5wC5g0j9QDrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YfuCXTLEJo5Auvh+BJQePp4Hi1Q1e+SQiXY4c0RnpEqIJUvljLBA59Dmej+qkrTCn
	 uyxr6l5IXgexqoM2kH5TKf0oYulDUTooMyfTaEuY35IAmjH5ckZktU0RkRR2fGGtXM
	 yg/+cWAjwcIbVANWF7+5rs6b5VrUmkma+CEYh4tlVEc+1uwkh9T8XMj8565mJIm5nP
	 MGwz+WkB3DRpGc7EvoMaWf3VdMqK7DWesZpUV2k8QX/aFfusO02zFtUIB/UFcC6YUl
	 QGsQO5Eumtonm1722ohiW8bEsm6bWBDbun5BWM2+7DH7QH4uNyG7/PAYw2Ogsh00AD
	 PRrVJURMxz+vA==
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, 1579567540@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org
Date: Tue, 20 Oct 2026 17:11:39 +0000
Message-ID: <179251629957.3135.180755777057921325@kernel.org>
In-Reply-To: <20261019170834.1727150-12-mkl@pengutronix.de>
References: <20261019170834.1727150-12-mkl@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] raw_bind() no longer holds RTNL, so the socket can miss a
  NETDEV_DOWN that arrives while it is binding.
- [Low] The commit message says "the callers pass the namespace that has
  been used for can_rx_register()", and the new kernel-doc of…
- [Low] The new comment on netns_can.rcvlists_lock in
  include/net/netns/can.h says it "protects rcv_lists_stats".

--

can: protect the receive lists with a per-device lock

This commit adds a spinlock to struct can_dev_rcv_lists. The receive lists
of a CAN device are now protected per device instead of by the per-netns
rcvlists_lock, so can_rx_unregister() still finds subscriptions after the
device has moved to another namespace. It also drops RTNL from raw_bind(),
raw_setsockopt(), raw_release(), isotp_bind() and isotp_release(), and
relies on lock_sock() plus a device pointer published inside the RCU
lookup to serialize with the netdev notifiers.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261019152741.54854-6-socketcan@hartkopp.net

> diff --git a/include/net/netns/can.h b/include/net/netns/can.h
> index 48b79f7e6236..ef7aefdf7b23 100644
> --- a/include/net/netns/can.h
> +++ b/include/net/netns/can.h
> @@ -29,7 +29,7 @@ struct netns_can {
>  
>  	/* receive filters subscribed for 'all' CAN devices */
>  	struct can_dev_rcv_lists *rx_alldev_list;
> -	spinlock_t rcvlists_lock;
> +	spinlock_t rcvlists_lock; /* protects rcv_lists_stats */

[Severity: Low]
This isn't a bug, but is this comment accurate? The lock only serializes
the rcv_entries and rcv_entries_max updates in can_rx_register() and
can_rx_unregister().

can_init_stats() in net/can/proc.c updates other fields of the same
structure without taking rcvlists_lock. It runs from the stats timer, or
from the reset_stats proc read when the timer is disabled:

net/can/proc.c:can_init_stats() {
    ...
	rcv_lists_stats->stats_reset++;

	if (user_reset) {
		user_reset = 0;
		rcv_lists_stats->user_reset++;
	}
}

can_stats_proc_show() also reads these counters without the lock.

Could the comment name rcv_entries and rcv_entries_max specifically?

[ ... ]

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index d97f85fc3232..bf612c4b983d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c

[ ... ]

> @@ -509,6 +513,13 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
>   *
>   * Description:
>   *  Removes subscription entry depending on given (subscription) values.
> + *  The receive lists of a CAN device are protected by a per-device lock,
> + *  so the subscription is found even when the device has been moved to
> + *  another network namespace after can_rx_register(). The caller has to
> + *  ensure that @dev stays valid, e.g. by holding a reference to @dev or
> + *  RTNL. @net is the namespace that has been used for can_rx_register().
> + *  It selects the 'any' CAN device lists for @dev == NULL and is used for
> + *  the receive list statistics.
>   */

[Severity: Low]
The new kernel-doc says @net is the namespace that was used for
can_rx_register(). The commit message says the same: "the callers pass
the namespace that has been used for can_rx_register()".

Does j1939 follow this? It reads dev_net(ndev) again at unregister time:

net/can/j1939/main.c:j1939_can_rx_register() {
    ...
	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
			      j1939_can_recv, priv, 0, NULL);
    ...
}

net/can/j1939/main.c:j1939_can_rx_unregister() {
    ...
	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
			  j1939_can_recv, priv);
    ...
}

A j1939 registration can outlive a namespace move. j1939_sk_bind() does
not hold RTNL. It calls j1939_netdev_start(), which registers with the old
namespace, before it calls j1939_jsk_add().

Suppose the NETDEV_UNREGISTER from __dev_change_net_namespace() runs
j1939_sk_netdev_event_unregister() in that window. The socket is not
J1939_SOCK_BOUND yet, so it is skipped and the registration survives the
move. The final release then passes the new namespace:

j1939_netdev_stop()
  __j1939_rx_release()
    j1939_can_rx_unregister()
      can_rx_unregister(dev_net(ndev), ...)

The receiver is still found through the per-device lists. However,
rcv_entries is decremented in the new namespace's rcv_lists_stats
(clamped at 0) and stays elevated in the old one. This accounting matches
the behaviour before the patch.

Should j1939_priv store the registration namespace (with a netns
reference)? Or should the kernel-doc and commit message describe a looser
rule?

[ ... ]

> diff --git a/net/can/raw.c b/net/can/raw.c
> index dfea48768b23..0d8edfa772fb 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -305,16 +309,28 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>  		       struct net_device *dev)
>  {
>  	struct sock *sk = &ro->sk;
> +	struct net_device *bind_dev;
>  
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		return;
>  
> -	if (ro->dev != dev)
> +	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
> +	 * Read it before ro->dev, pairs with smp_store_release() in
> +	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
> +	 */
> +	bind_dev = smp_load_acquire(&ro->bind_dev);
> +	if (READ_ONCE(ro->dev) != dev &&
> +	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
>  		return;

[Severity: Medium]
Can a NETDEV_DOWN be lost while raw_bind() is running? The bind_dev hint
is only checked for NETDEV_UNREGISTER, and raw_bind() no longer holds
RTNL.

raw_bind() now runs these steps in order:

    smp_store_release(&ro->bind_dev, dev);
    ...
    if (!(READ_ONCE(dev->flags) & IFF_UP))   /* device still up here */
        notify_enetdown = 1;
    ...
    err = raw_enable_allfilters(sock_net(sk), dev, sk);  /* cond_resched() */
    ...
    WRITE_ONCE(ro->dev, dev);

Suppose dev_close() runs after the IFF_UP check but before ro->dev is
published. raw_notifier()->raw_notify() then sees ro->dev != dev with
msg == NETDEV_DOWN, so it returns at the check above and never reaches
case NETDEV_DOWN. raw_bind() finishes with notify_enetdown == 0.

The socket ends up bound to a down interface, and sk_err = ENETDOWN /
sk_error_report() is never raised. Before this patch, rtnl_lock() in
raw_bind() kept dev_close() out of this window.

isotp_bind() publishes so->dev before it reads IFF_UP, so it does not seem
to have this problem.

Could raw_notify() also check bind_dev for NETDEV_DOWN? Alternatively,
raw_bind() could publish ro->dev before the IFF_UP check.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019170834.1727150-2-mkl%40pengutronix.de
