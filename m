Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825209;
	b=GFch7KFT2s4Alq7SdjilwNolOqqNgcinuE8yIld30r57LPjXNMeO/XZmjPXymH+wfLM8
	 bxL8+ugoJETzBXUC2N5JVvfj8mc/Y0DkjjcdCMWqBODHvf1tYqMxaKwwSsjX77m67uLl0
	 65scCREC4dDzFyBEkQxdd0mbZZpreT7/Vj/nFNcqXRwnZpHC2CZ8clpa6g0Mw4eCq7SKK
	 JzNl0gyThQg05dJoXbOUk424cT7d+KwMaEYPO/OAWa9GXRc+QBaN5uih3ZI7dMRG6S7+a
	 Zw7qh3Zbk0gbU1sFePE6EwqHoADiT2iDhC3qsugyIVZdf9xtkFQTo63JcRPTLZuIEJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825209;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B1nvCpFBme1gc7cdOXH1bt139yT1X2vla9BBU4EKQc4=;
	b=VpMCSCwge/JnqfrEfAQFsGpCXBJEXQur65+yGYSomnXycEUxYE7EP40kQcb+a48cdWLs
	 FPNQ0nMmH6/TIu6+haxGPk4+7pBg8scrofGIRt2Uj+zcv5bkz+o9OpUVJhlPdk3R/uNKn
	 r6ZHDEsyV+ieo/RcbPBgc5Me9yzSeGvneBi6oudyITdjvAZRVD8YqU4+Kq4mpJqDWDT5/
	 R2b2G/jSRaLMoLp6K70pTGRAk+m8AEpRyHlYfz1pYCNvrgMVLUuWXHK/jAy353u8f/chO
	 tbEH/AfUetwNXMs2+OQCy0GB4lWn7K6v242A+XQ1HyM6XdysyEtzUKcWURBDwl4mnGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsdNsf+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B4606C58F;
	Wed,  4 Nov 2026 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsdNsf+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BF21F0093A;
	Wed,  4 Nov 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825209;
	bh=B1nvCpFBme1gc7cdOXH1bt139yT1X2vla9BBU4EKQc4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jsdNsf+S5gRZ1RcdON0ngtJaCF8WiIzvTm0I6Mua+cOrfbkUMt96kAZ4gog/S2Ww1
	 l+1YYUDZ/FEZjQeYSA4tkx8lFWmONSlr8HKjUkyXoC91d1Cf5MQaKF1kfrk4ZvtSyr
	 8Gn5nIGmVKFbDCpYh+PO84KkiJ3PPkhXLS8rP35Crw9XqTrxzt9Nt2UzxwQ39RoQDz
	 zHdVJkxQvqcbb5gm+uMToiv8R8enFC8vqvFICu/poFhTH4aHXysS4qIKMRtJDvrkTr
	 Q1Le94IUMTvzvTmptk+QzwBOsNFd4K7xJxxg+gn39TiEIId23XzC0LNzrjPSPrL0O7
	 hR+WfRXk1NRbg==
Subject:
 Re: [PATCH net 08/15] can: protect the receive lists with a per-device lock
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 20:46:47 +0000
Message-ID: <179382520797.488856.11630508832915860623@kernel.org>
In-Reply-To: <20261103204305.3211144-9-mkl@pengutronix.de>
References: <20261103204305.3211144-9-mkl@pengutronix.de>
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

- [Low] Since RTNL is no longer held across raw_bind() and isotp_bind(),
  a NETDEV_DOWN followed by NETDEV_UP inside the bind() window is never…

Pre-existing issues:
- [High] This patch did not introduce this problem, but CAN_BCM still
  lets an unprivileged task stall a user-memory copy while holding…

--

can: protect the receive lists with a per-device lock

This adds a spinlock to struct can_dev_rcv_lists, so can_rx_unregister()
finds a subscription even after the device has moved to another network
namespace. The per-netns rcvlists_lock now only protects the statistics.
CAN_RAW and CAN_ISOTP bind()/release()/setsockopt() stop taking RTNL and
rely on lock_sock(), RCU publication of the bound device and a barrier
pair for NETDEV_DOWN.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261027-can-rx-lock-v12-3-eb5afc2d8b9b@hartkopp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 60406439a13f7..9288b96724da2 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1936,6 +1925,7 @@ static int bcm_release(struct socket *sock)
>  	list_del(&bo->notifier);
>  	spin_unlock(&bcm_notifier_lock);
>  
> +	/* bcm_notify() can not access this socket anymore */
>  	lock_sock(sk);
>  
>  #if IS_ENABLED(CONFIG_PROC_FS)

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The
commit message is about unprivileged users holding up RTNL, though, so
is CAN_BCM still open to the same kind of problem?

bcm_sendmsg() takes lock_sock(sk). While it holds the lock,
bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send() copy frame data from
user memory with memcpy_from_msg():

net/can/bcm.c:bcm_tx_setup() {
    ...
			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

bcm_notify() runs from the netdev notifier with RTNL held. On
NETDEV_UNREGISTER it takes lock_sock() on every BCM socket in the
device's namespace, whether or not the socket is bound to that device:

net/can/bcm.c:bcm_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

Suppose the sendmsg iovec points at a FUSE-backed mapping whose daemon
never answers. The copy then stalls with the socket lock held.

A CAN device unregister in that netns then blocks bcm_notify() in
lock_sock() with RTNL held. For example, the user can delete a vcan in
their own unprivileged user+net namespace. After that, every RTNL user
on the host hangs.

The CAN_RAW version of this is fixed later in this series by "can: raw,
isotp: copy socket options outside of lock_sock()". That covers
memdup_sockptr()/copy_from_sockptr() in raw_setsockopt_locked() and
copy_to_iter() in raw_getsockopt() under lock_sock(). Before this
patch, raw_setsockopt() even held RTNL directly across the copy.

CAN_ISOTP is not affected. The BCM paths look the same at the end of
the series.

Could the BCM frame data also be copied before lock_sock()?

[ ... ]

> diff --git a/net/can/raw.c b/net/can/raw.c
> index e1d741a25be3f..d6517f71cadeb 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -305,16 +309,31 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>  		       struct net_device *dev)
>  {
>  	struct sock *sk = &ro->sk;
> +	struct net_device *bind_dev;
>  
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		return;
>  
> -	if (ro->dev != dev)
> +	if (msg == NETDEV_DOWN)
> +		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
> +
> +	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
> +	 * Read it before ro->dev, pairs with smp_store_release() in
> +	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
> +	 */
> +	bind_dev = smp_load_acquire(&ro->bind_dev);
> +	if (READ_ONCE(ro->dev) != dev &&
> +	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
>  		return;

[ ... ]

> @@ -479,14 +500,25 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len

[ ... ]

> +		rcu_read_lock();
> +		dev = dev_get_by_index_rcu(sock_net(sk), addr->can_ifindex);
> +		if (dev) {
> +			dev_hold(dev);
> +			/* pairs with smp_load_acquire() in raw_notify() */
> +			smp_store_release(&ro->bind_dev, dev);
> +		}
> +		rcu_read_unlock();

[ ... ]

> @@ -496,9 +528,6 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>  			goto out_put_dev;
>  		}
>  
> -		if (!(dev->flags & IFF_UP))
> -			notify_enetdown = 1;
> -
>  		ifindex = dev->ifindex;
>  
>  		/* filters set by default/setsockopt */

[ ... ]

> @@ -528,24 +557,32 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>  		ro->ifindex = ifindex;
>  		ro->bound = 1;
>  		/* bind() ok -> hold a reference for new ro->dev */
> -		ro->dev = dev;
> +		WRITE_ONCE(ro->dev, dev);
>  		if (ro->dev)
>  			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
> +
> +		if (dev) {
> +			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
> +			 * we see the cleared IFF_UP, pairs with raw_notify()
> +			 */
> +			smp_mb();
> +			if (!(READ_ONCE(dev->flags) & IFF_UP))
> +				notify_enetdown = 1;
> +		}
>  	}

[Severity: Low]
The commit message says:

  "As RTNL does not keep NETDEV_DOWN out of bind() anymore, bind() checks
  IFF_UP after publishing the bound device, with a barrier pair against
  raw_notify() and isotp_notify(), so a down transition during bind() is
  still reported with ENETDOWN."

Does this still hold when a full down/up cycle happens inside bind()?

raw_bind() registers the filters with raw_enable_allfilters() before it
publishes ro->dev. raw_rcv() can already queue frames for the socket at
that point. raw_enable_filters() can do up to CAN_RAW_FILTER_MAX
GFP_KERNEL allocations with cond_resched(), so this window can be long.

In raw_notify(), the bind_dev hint only covers NETDEV_UNREGISTER. A
NETDEV_DOWN in this window returns early:

raw_bind()                            RTNL holder
  smp_store_release(&ro->bind_dev)
  raw_enable_allfilters()
    /* frames get queued */
                                      dev_close()
                                        clears IFF_UP
                                        raw_notify(NETDEV_DOWN)
                                          ro->dev != dev -> return
                                      dev_open()
                                        sets IFF_UP
  WRITE_ONCE(ro->dev, dev)
  smp_mb()
  IFF_UP is set -> no ENETDOWN

isotp_bind() has the same window. so->dev is published early, but
isotp_notify() drops NETDEV_DOWN while so->bound is still 0:

net/can/isotp.c:isotp_notify() {
    ...
	case NETDEV_DOWN:
		if (!READ_ONCE(so->bound))
			break;
    ...
}

isotp_bind() only sets so->bound after both can_rx_register() calls,
and samples IFF_UP after that.

Before this patch, holding RTNL across bind() ruled out this
interleaving. Is it acceptable to miss ENETDOWN in this case? If so,
should the commit message only promise this for a down state that is
still in effect when bind() samples IFF_UP?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103204305.3211144-2-mkl%40pengutronix.de
