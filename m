Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793866245;
	b=IvR3uMaRL+NL0JiWDnaVYFA+TJs+mFR8sUZzG34HBEIT+ftaQaXWYZU80q610/HVxpOJ
	 ABCX88ri2sjwxCh9/mMdBJkyxHSDlsObtiscMO2W+vBn2kRUG7ZiwFLT3h/gyIvVN3B+k
	 WrZXFAALUcCGPDgvbNDGgSyo3zj+dHQ88sWXDKkNZDifqgEKkV/E1Lph90JUpCKu2TyXE
	 ei6slZlwO1+OR85MLmYFsxZFXcHyPR1KRlV7cFRwX1AIUDmiwyASZXZki5qbVhGjKiQjm
	 8jka6B64+AH4V+3JIf2x4Gro9a5J9mUANWLTQmafhMj00tpj5V7wvfjNpkQDbF5ewQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866245;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DpJSt1J3oBy4CzDK+E+eF+bEhTjYYeDvHIcZlaiwBL8=;
	b=hYrDEnXgMIc//HS+2cI8Uu0ltamcSA7Q0Ou4sHBJEOBIifgojNqV1HGr3TtTgBEBXZVk
	 lpgCBeShbmztUMfzhCytjvV22wf1trtwrJjiRYiZBNkN13f8SNJRnIlDvMPAcoGByAi3Y
	 KsvAPA8e/kZ3G4t/XPCQw3S7nKK9xfrmzUyAZSILM8ZcxQoFiMMazJLIqrX2b+ihn+YZp
	 4GYYLA54kZK29ECGRfE3sTPuHIrlcGquDY9kyinJaZaQLXErXZBQxtyyFDO4aEsSYEK9F
	 Z1hOlwt9N0+rGYJrxTebVfdj7m/EwIJi6fFl4migBQSzNGviCnuQI5ENeIs/E+cditw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RJcVB9Sm;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ejiew3nS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACD606A31B;
	Thu,  5 Nov 2026 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02ACD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=RJcVB9Sm;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ejiew3nS
ARC-Seal: i=1; a=rsa-sha256; t=1793866216; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q7OuVBQGPqWj161mzcCzlQvPbhlo8+hYvt+HdeglpYTdVC/OuTexhZn/50Id01I7nY
    5I0gyWFlIpEBUpd2WwtFA2gzv0Nhg03RpHNtRnuvXhgfJQkMeXixZsrwGePK+/eA4dv/
    GcS+FZEbMOn6442PTs6GtKKXl0Dcc0KO0uYBqQrAY7hoeb+TwUzd9Z8G7PJV9s8KVUzW
    PPPDYvn731pKEw99DmA6FCppCRR6sa/9REwR/wT11nxUBAOmPPqxk7uT7zX3cac7tWc7
    EFYbp8jZXpjMaobblbUFKxMWOk/A3sa/d48DcgxXnauVH+Kee2qbPueZvd9aoVnL+uNN
    SRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793866216;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DpJSt1J3oBy4CzDK+E+eF+bEhTjYYeDvHIcZlaiwBL8=;
    b=GI9q+PtdSpTl1/qD/ZYkRa7VqkE5JWEAC2aZujmeKYatx0tnE5hbn77ybtY1RNRas2
    S21lsyRooIkuk+lK6Dpc1EDkXJHYeHUV0QxyhRU6z1hg8+XQ0b8wDzeQTTY15OGPwEoO
    /lNISyKBfuIsfknwlhIfyEMfmQ+YSARXHvy1xMW5XqDFNVW4L5CF25KFAjIXHFms5/mB
    d7iRDZ2QT+NuzjEF3DrmuhB+fobuPpch2ejazS1c/huRgo/hbeiHZJmNJwG86Wr1KGK9
    oh2juK4X79fuKTXLLCe85bhJF1z2WbB/0nePIFn8eXA81kxcZ7TIZAN25I7n81MvBoti
    QNOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793866216;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DpJSt1J3oBy4CzDK+E+eF+bEhTjYYeDvHIcZlaiwBL8=;
    b=RJcVB9Sm67rtlKjws+PCpRzpIZi8pUZzonvFWuQIfIUpoNguI5c+7CLA/Rf7abGAaG
    qrkZZYfE23ewjxxTxge2rmLz9L41RGtofqrlpseYaP2miFcAKqCDai8nzGn8Ai9LfeqO
    okycVstLHhDMpjhTOrwm6plS2sjcdIU1QV+aNkX8hm+XKd8SHMbNB+G+bjtw3r+EPRhD
    UahHVAFUD7XiL04HBk07v4aEGZ/l5SVI+ezU/lES59XS6MEeoxkRCxh07UcOZMDf04II
    aybtmwEztMJJpn6MJiAimO0QJzN+T22z7WdXmZds9E7iy9nu2I1EEyX1wpIjOLYD3bem
    018g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793866216;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=DpJSt1J3oBy4CzDK+E+eF+bEhTjYYeDvHIcZlaiwBL8=;
    b=ejiew3nSnbYEfWwM/HAOw+NbnrImbGV8DssKBXXAuDCEXTUAoCBbLnKgm/RGRmzMd7
    SSNyuERHt4p4riZDasBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A58AFJmI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 09:10:15 +0100 (CET)
Message-ID: <73ed871b-2248-482f-a96a-31230494b144@hartkopp.net>
Date: Thu, 5 Nov 2026 09:10:15 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/15] can: protect the receive lists with a
 per-device lock
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
References: <20261103204305.3211144-9-mkl@pengutronix.de>
 <179382520797.488856.11630508832915860623@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179382520797.488856.11630508832915860623@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04.11.26 21:46, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Since RTNL is no longer held across raw_bind() and isotp_bind(),
>    a NETDEV_DOWN followed by NETDEV_UP inside the bind() window is never…
> 
> Pre-existing issues:
> - [High] This patch did not introduce this problem, but CAN_BCM still
>    lets an unprivileged task stall a user-memory copy while holding…
> 
> --
> 
> can: protect the receive lists with a per-device lock
> 
> This adds a spinlock to struct can_dev_rcv_lists, so can_rx_unregister()
> finds a subscription even after the device has moved to another network
> namespace. The per-netns rcvlists_lock now only protects the statistics.
> CAN_RAW and CAN_ISOTP bind()/release()/setsockopt() stop taking RTNL and
> rely on lock_sock(), RCU publication of the bound device and a barrier
> pair for NETDEV_DOWN.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Link: https://patch.msgid.link/20261027-can-rx-lock-v12-3-eb5afc2d8b9b@hartkopp.net
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 60406439a13f7..9288b96724da2 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1936,6 +1925,7 @@ static int bcm_release(struct socket *sock)
>>   	list_del(&bo->notifier);
>>   	spin_unlock(&bcm_notifier_lock);
>>   
>> +	/* bcm_notify() can not access this socket anymore */
>>   	lock_sock(sk);
>>   
>>   #if IS_ENABLED(CONFIG_PROC_FS)
> 
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. The
> commit message is about unprivileged users holding up RTNL, though, so
> is CAN_BCM still open to the same kind of problem?
> 

Yes, this is a pre-existing issue that is not introduced by this series.
It has already been answered for this patch set here:

https://lore.kernel.org/linux-can/64f4dfcf-40ec-4838-85d3-a30c3912e242@hartkopp.net/

CAN_BCM (and CAN_J1939) notifier handling will be looked at separately.

> bcm_sendmsg() takes lock_sock(sk). While it holds the lock,
> bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send() copy frame data from
> user memory with memcpy_from_msg():
> 
> net/can/bcm.c:bcm_tx_setup() {
>      ...
> 			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      ...
> }
> 
> bcm_notify() runs from the netdev notifier with RTNL held. On
> NETDEV_UNREGISTER it takes lock_sock() on every BCM socket in the
> device's namespace, whether or not the socket is bound to that device:
> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 	case NETDEV_UNREGISTER:
> 		lock_sock(sk);
>      ...
> }
> 
> Suppose the sendmsg iovec points at a FUSE-backed mapping whose daemon
> never answers. The copy then stalls with the socket lock held.
> 
> A CAN device unregister in that netns then blocks bcm_notify() in
> lock_sock() with RTNL held. For example, the user can delete a vcan in
> their own unprivileged user+net namespace. After that, every RTNL user
> on the host hangs.
> 
> The CAN_RAW version of this is fixed later in this series by "can: raw,
> isotp: copy socket options outside of lock_sock()". That covers
> memdup_sockptr()/copy_from_sockptr() in raw_setsockopt_locked() and
> copy_to_iter() in raw_getsockopt() under lock_sock(). Before this
> patch, raw_setsockopt() even held RTNL directly across the copy.
> 
> CAN_ISOTP is not affected. The BCM paths look the same at the end of
> the series.
> 
> Could the BCM frame data also be copied before lock_sock()?
> 
> [ ... ]
> 
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index e1d741a25be3f..d6517f71cadeb 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> 
> [ ... ]
> 
>> @@ -305,16 +309,31 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>   		       struct net_device *dev)
>>   {
>>   	struct sock *sk = &ro->sk;
>> +	struct net_device *bind_dev;
>>   
>>   	if (!net_eq(dev_net(dev), sock_net(sk)))
>>   		return;
>>   
>> -	if (ro->dev != dev)
>> +	if (msg == NETDEV_DOWN)
>> +		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
>> +
>> +	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
>> +	 * Read it before ro->dev, pairs with smp_store_release() in
>> +	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
>> +	 */
>> +	bind_dev = smp_load_acquire(&ro->bind_dev);
>> +	if (READ_ONCE(ro->dev) != dev &&
>> +	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
>>   		return;
> 
> [ ... ]
> 
>> @@ -479,14 +500,25 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
> 
> [ ... ]
> 
>> +		rcu_read_lock();
>> +		dev = dev_get_by_index_rcu(sock_net(sk), addr->can_ifindex);
>> +		if (dev) {
>> +			dev_hold(dev);
>> +			/* pairs with smp_load_acquire() in raw_notify() */
>> +			smp_store_release(&ro->bind_dev, dev);
>> +		}
>> +		rcu_read_unlock();
> 
> [ ... ]
> 
>> @@ -496,9 +528,6 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>>   			goto out_put_dev;
>>   		}
>>   
>> -		if (!(dev->flags & IFF_UP))
>> -			notify_enetdown = 1;
>> -
>>   		ifindex = dev->ifindex;
>>   
>>   		/* filters set by default/setsockopt */
> 
> [ ... ]
> 
>> @@ -528,24 +557,32 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>>   		ro->ifindex = ifindex;
>>   		ro->bound = 1;
>>   		/* bind() ok -> hold a reference for new ro->dev */
>> -		ro->dev = dev;
>> +		WRITE_ONCE(ro->dev, dev);
>>   		if (ro->dev)
>>   			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>> +
>> +		if (dev) {
>> +			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
>> +			 * we see the cleared IFF_UP, pairs with raw_notify()
>> +			 */
>> +			smp_mb();
>> +			if (!(READ_ONCE(dev->flags) & IFF_UP))
>> +				notify_enetdown = 1;
>> +		}
>>   	}
> 
> [Severity: Low]
> The commit message says:
> 
>    "As RTNL does not keep NETDEV_DOWN out of bind() anymore, bind() checks
>    IFF_UP after publishing the bound device, with a barrier pair against
>    raw_notify() and isotp_notify(), so a down transition during bind() is
>    still reported with ENETDOWN."
> 
> Does this still hold when a full down/up cycle happens inside bind()?
> 

No. As RTNL does not keep NETDEV_DOWN out of bind() anymore, a down/up
cycle that completes between the filter registration and the IFF_UP
check in bind() is not reported with ENETDOWN. Frames received in this
window before the down transition may then already be queued for the
socket.

I consider this acceptable: ENETDOWN is an asynchronous notification
and bind() has not returned at this point. When bind() returns, the
socket is bound to a device that is up, and every down transition
after the bound device has been published is reported, which is
ensured by the barrier pair. So no down transition is missed for a
bound socket.

The commit message could be more precise here, but I don't think this
justifies a respin.

> raw_bind() registers the filters with raw_enable_allfilters() before it
> publishes ro->dev. raw_rcv() can already queue frames for the socket at
> that point. raw_enable_filters() can do up to CAN_RAW_FILTER_MAX
> GFP_KERNEL allocations with cond_resched(), so this window can be long.
> 
> In raw_notify(), the bind_dev hint only covers NETDEV_UNREGISTER. A
> NETDEV_DOWN in this window returns early:
> 
> raw_bind()                            RTNL holder
>    smp_store_release(&ro->bind_dev)
>    raw_enable_allfilters()
>      /* frames get queued */
>                                        dev_close()
>                                          clears IFF_UP
>                                          raw_notify(NETDEV_DOWN)
>                                            ro->dev != dev -> return
>                                        dev_open()
>                                          sets IFF_UP
>    WRITE_ONCE(ro->dev, dev)
>    smp_mb()
>    IFF_UP is set -> no ENETDOWN
> 
> isotp_bind() has the same window. so->dev is published early, but
> isotp_notify() drops NETDEV_DOWN while so->bound is still 0:
> 
> net/can/isotp.c:isotp_notify() {
>      ...
> 	case NETDEV_DOWN:
> 		if (!READ_ONCE(so->bound))
> 			break;
>      ...
> }
> 
> isotp_bind() only sets so->bound after both can_rx_register() calls,
> and samples IFF_UP after that.
> 
> Before this patch, holding RTNL across bind() ruled out this
> interleaving. Is it acceptable to miss ENETDOWN in this case? If so,
> should the commit message only promise this for a down state that is
> still in effect when bind() samples IFF_UP?
> 

