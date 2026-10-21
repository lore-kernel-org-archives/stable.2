Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792619976;
	b=DvtL8+sNVPXGwqLhE8BPzZfNNka70qxJCd7KG0Q/fjy5IlHExKlPApOz49N9UzSTlauf
	 MqQHzKNdevQWFl5c8vbQpHtWFGU3dZ/8PeASMGu5FidClvkZfn3ToTiIdlDYSIplVYqUP
	 ++dhee+s4KWpaHBbWv+7wGGQnOCrcpZx0MhJRii+cqX9k/Aj/Iwe3N0VGrIzX2pkRGyut
	 7+0AsEl06Lhz8m/UK1ZMANZnslUQX4z+4LTSVQeFbT8IajsMryR53LKRVqmotlRfkoo6M
	 CB+0/RxsoHM/PMrBoVdJCrxhB4Qps03AWIhBCzny3utSJaqLxFM32bE5TJVFTzS40rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619976;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=otw5itjN1AqmZN9yJF4MBF+r0zNY/Fkb/PotwLLomVw=;
	b=V1tzcr+kvjHPJxLlxmjK9jQRNDbFOUkS2BxLgbyq9SgUMXo/+JQnHC8e3+/lWrrtBVo6
	 8wHQ9RC0OZXA5YIAXRwbdGjNTTy7p+MFIIkGN4SXw0/1RTfkAQ5m2fTRwGT83GtmrgNV5
	 z9okuA6CAupm5/jLnArmfuv5ID0aj+sx/s1i9OrmgAnNU5lnROfC8Xv5urkKCqOu0Razf
	 LkaPw7TFpewqce+0dL242H7zYp3NVfOtwK7PKv7eOo6ex2VY3l/b4azbJFP4tpBjQFdWG
	 ehp28rMGOXc5KzyqUzsTcYzJhfAWDccX/cNjARFfFDhPJLL5eAjld84wfvN5wAhLRqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bMH8+s5k;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4dFFAlA0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA09606A31A;
	Wed, 21 Oct 2026 21:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA09606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=bMH8+s5k;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4dFFAlA0
ARC-Seal: i=1; a=rsa-sha256; t=1792619958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DR9N4KO1XqrdTXBpRxGNdoZso2YsuB8q3fz+dwN16s4CpRgmfdVKxTgFXHWYzkRECz
    LjV9u+qltKlwLCcZieUGePWvbNthx0WSq+vsY7nrNOhI9eyA5WVpuyzbpSH6PxRw7Pc+
    zFBXf6lfc6zgET4/vjyN2gk9WjfNPpuMfnZgHoqpU5S0vpbtJCrMVDyqdDbzFwKviEPz
    q7IARSyQTBtuLCXRpMwHWb/fL3+IV0WIgp7CnHQNXOkcQ/VmeB8daef8EfYQ1gTHRC/p
    PBVSn7JPrz+R+izMReYOBw8+JZSXN4ORI89YeML0DpAY1V9yJWrKAnA5f1Zhxzt3FAz9
    nxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792619958;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=otw5itjN1AqmZN9yJF4MBF+r0zNY/Fkb/PotwLLomVw=;
    b=Qrfvx2aSdQ18622RvOu49fGR8EnKjZr6XWjukJsK6voJv9GUdYAe6GhHmORU84SsI3
    Ql5e7+8hRY3NjCIMh2LKoYpK5mYzJeXBmzT97iqFrdwt4aEKlxl3dyCIcbJQYdxD5IRL
    SEXZU6WbgSlTKQFkfAeb9SdA4RT6Z+N8hmhN7is86++2gAVQ0AVa4CFCgJECxzZ5L7ip
    XZHKsDgdAWfQ5corUt65kpxFohkiSJAfDBLy8tIxxxNiYOuWUpGnedO/900HyDiEjkJe
    zeWrmGxU39jcmqpczJtWhNtolBlk9vvmsnj/oxNYq5WPSJ1k8nEpBTHn+gTUFmmNUyrL
    57aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792619958;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=otw5itjN1AqmZN9yJF4MBF+r0zNY/Fkb/PotwLLomVw=;
    b=bMH8+s5kJ6wHt2dbbZho5bdGhtwTdfXutXTiEw6SpNEqROl5sab1sc48gXKGYFHbDJ
    l44KhXCpk1od3Xne+jC12/ADzJErhtRXS3hQZjisxO1qdRH2xO+mW3jGmrB7coDfmZ5X
    43sFFjTD2QgTP4AZPPAGyjIoxo+XrFqSaJTiRoK/1fzzM5GsV5zGlZLZAqGQSpoBjKAN
    +aGX5GLe+R5s/idHJ2C/1lqhDXXBD71jG6pSZKDCUvxOzUJTPEKXC9Nyc0wsuWv2kXxE
    QM616KkxrYT8e6FecTPA2+WAfj5rU9aB0PwSGlp/mVFTnPg8BhKSCY0sF3pdE9rLDaZ0
    4dog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792619958;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=otw5itjN1AqmZN9yJF4MBF+r0zNY/Fkb/PotwLLomVw=;
    b=4dFFAlA0nHMJ6ogsnzBp9PIYpOyxieeaKykr2l5gE+GfEmiWXlR0QAd/NLVvayz+zB
    vm8wqctkGnbkQqPFNbCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29LLxHl65
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 23:59:17 +0200 (CEST)
Message-ID: <47b77a2a-ff3d-4189-b633-54b1fad3cd1a@hartkopp.net>
Date: Wed, 21 Oct 2026 23:59:17 +0200
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
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
To: Jakub Kicinski <kuba@kernel.org>, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, runyu.xiao@seu.edu.cn, stable@vger.kernel.org
References: <20261021102756.1900679-12-mkl@pengutronix.de>
 <20261021205534.1620083-1-kuba@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261021205534.1620083-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.10.26 22:55, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> can: protect the receive lists with a per-device lock
> 
> This commit adds a spinlock to struct can_dev_rcv_lists. The receive lists
> of a CAN device are now protected per device instead of by the per-netns
> rcvlists_lock, so can_rx_unregister() can find subscriptions after the
> device has moved to another namespace.
> 
> RTNL is dropped from raw_bind(), raw_setsockopt(), raw_release(),
> isotp_bind() and isotp_release(). These paths now use lock_sock() and a
> device pointer published under RCU to serialize against the netdev
> notifier.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Link: https://patch.msgid.link/20261020203257.230955-6-socketcan@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 5e1c3971ebfce..8ec37d252557e 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1614,7 +1612,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   		goto out;
>>   	}
>>   
>> -	dev = dev_get_by_index(net, addr->can_ifindex);
>> +	/* Publish the device inside the RCU section of the lookup: When it
>> +	 * is unlisted concurrently, either isotp_notify() sees so->dev after
>> +	 * synchronize_net() or the lookup fails.
>> +	 */
>> +	rcu_read_lock();
>> +	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
>> +	if (dev) {
>> +		dev_hold(dev);
>> +		WRITE_ONCE(so->dev, dev);
>> +	}
>> +	rcu_read_unlock();
>>   	if (!dev) {
>>   		err = -ENODEV;
>>   		goto out;
>> @@ -1627,7 +1635,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   		err = -EINVAL;
>>   		goto out_put_dev;
>>   	}
> 
> [Severity: Low]
> so->dev is now visible to the lockless check in isotp_notify() before the
> remaining checks in isotp_bind() run, and before so->bound is set. The MTU
> check can still fail the bind:
> 
> 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
> 		err = -EINVAL;
> 		goto out_put_dev;
> 	}
> 
> so->dev is only cleared again at out_put_dev.
> 
> isotp_bind() no longer holds RTNL. Can a NETDEV_DOWN for the same device
> run isotp_notifier()->isotp_notify() inside this window?
> 
> The NETDEV_DOWN case only checks READ_ONCE(so->dev) != dev. It does not
> look at so->bound or recheck under lock_sock():
> 
> 	case NETDEV_DOWN:
> 		sk->sk_err = ENETDOWN;
> 		if (!sock_flag(sk, SOCK_DEAD))
> 			sk_error_report(sk);
> 		break;
> 
> Would this set a stale ENETDOWN on a socket that was never bound, whose
> bind() then returns -EINVAL? A later successful bind() to another device
> (after fixing ll.mtu with CAN_ISOTP_LL_OPTS) would then get that error from
> the next recvmsg() or poll().
> 
> raw_bind() avoids this. It only publishes ro->bind_dev early, which
> raw_notify() uses for NETDEV_UNREGISTER only, and it sets ro->dev after
> success. Could isotp use the same approach?
> 

Yes, changing the order here to

         rcu_read_lock();
         dev = dev_get_by_index_rcu(net, addr->can_ifindex);
         if (!dev || !can_get_ml_priv(dev))
                 err = -ENODEV;
         else if (READ_ONCE(dev->mtu) < so->ll.mtu)
                 err = -EINVAL;
         if (!err) {
                 dev_hold(dev);
                 WRITE_ONCE(so->dev, dev);
         }
         rcu_read_unlock();
         if (err)
                 goto out;

is a good hint from sashiko-bot and follows the raw_bind() concept.
@Jakub: I've sent a V6 only for this single patch 11/11 here:

Is this ok for you? I think Marc is offline and can not re-spin the PR 
right now.

https://lore.kernel.org/netdev/20261021215456.119268-1-socketcan@hartkopp.net/

>> @@ -1653,15 +1666,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   	 * can safely reach the device later, even if a concurrent
>>   	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
>>   	 */
>> -	so->dev = dev;
>>   	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but isotp_bind() ignores the
> return values of both can_rx_register() calls just above this:
> 
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, sock_i_ino(sk), sk);
> 	...
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
> 
> It then sets so->bound = 1 unconditionally.
> 
> can_rx_register() returns -ENOMEM if kmem_cache_alloc(rcv_cache,
> GFP_KERNEL) fails. Can the socket then report a successful bind() while it
> is missing its FC/RX receiver or its echo receiver?
> 
> Later, isotp_release() and isotp_notify() would call can_rx_unregister()
> for an entry that was never added and hit the "receive list entry not
> found" warning. raw_enable_filters() and bcm_rx_setup() check this return
> value and unwind.
> 
> -ENODEV from the net_eq() check does not look reachable here.
> isotp_notify() waits on lock_sock() for NETDEV_UNREGISTER, so dev_net(dev)
> cannot change during the registrations. That leaves -ENOMEM as the only
> error.
> 
> The earlier commit "can: replace ARPHRD_CAN type checks with
> can_get_ml_priv()" in this series already notes that isotp_bind() ignores
> these return values.

Right.

This is a pre-existing issue and will be fixed separately. With the
can_get_ml_priv() check in isotp_bind() and the namespace change being
serialized via lock_sock() against isotp_notify(), the only remaining
error from can_rx_register() is -ENOMEM from the GFP_KERNEL allocation
of the receiver. The fix will be addressed in the next net-next cycle.
As this is an improvement for a very unlikely allocation failure, it is
not intended for stable.

> 
> [ ... ]
> 
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index dfea48768b231..d07f3bb68cd5c 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> 
> [ ... ]
> 
>> @@ -750,18 +772,47 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>   			  sockptr_t optval, unsigned int optlen)
>>   {
>>   	struct sock *sk = sock->sk;
> 
> [ ... ]
> 
>> -	rtnl_lock();
>> +	if (optname == CAN_RAW_FILTER) {
>> +		/* Copy the filters before lock_sock(), so a stalled copy can
>> +		 * not block raw_notify() waiting for lock_sock() under RTNL.
>> +		 */
> 
> [ ... ]
> 
>> +	}
>> +
>>   	lock_sock(sk);
>>   
>> -	err = raw_setsockopt_locked(sock, optname, optval, optlen);
>> +	err = raw_setsockopt_locked(sock, optname, optval, optlen,
>> +				    filter, &sfilter, count);
> 
> [Severity: Medium]
> The comment says a stalled copy must not block raw_notify() while it waits
> for lock_sock() under RTNL. The early copy only covers CAN_RAW_FILTER,
> though. Do the other options still copy from user memory with lock_sock()
> held?
> 
> In raw_setsockopt_locked(), CAN_RAW_ERR_FILTER still does:
> 
> 	if (copy_from_sockptr(&err_mask, optval, optlen))
> 		return -EFAULT;
> 
> CAN_RAW_LOOPBACK, CAN_RAW_RECV_OWN_MSGS, CAN_RAW_FD_FRAMES,
> CAN_RAW_XL_FRAMES, CAN_RAW_XL_VCID_OPTS and CAN_RAW_JOIN_FILTERS do the
> same after lock_sock(sk) is taken here.
> 
> raw_getsockopt(CAN_RAW_FILTER) also writes to the user buffer with
> lock_sock() held:
> 
> 	lock_sock(sk);
> 	...
> 		if (copy_to_iter(ro->filter, len,
> 				 &opt->iter_out) != len)
> 			err = -EFAULT;
> 
> Suppose one of these copies stalls on a FUSE-backed mapping while the
> socket is bound, or while ro->bind_dev matches the device. Would a
> NETDEV_UNREGISTER of that device then leave raw_notify() sleeping in
> lock_sock() with RTNL held?
> 
> raw_notifier()
>    raw_notify()
>      lock_sock(sk)   <- waits for the stalled setsockopt/getsockopt
> 
> The unregister could come from ip link del of a vcan device in the user's
> own network namespace, a namespace move, or a USB unplug.
> 
> The new ro->bind_dev hint also adds cases where raw_notify() takes
> lock_sock(): a stale bind_dev that matches the unregistered device leads
> there too.
> 
> Before this patch, raw_setsockopt() held rtnl_lock() itself across these
> copies, so overall exposure is lower than before. The new design relies on
> lock_sock() never being held across a user copy, though. Should the
> remaining copies in raw_setsockopt_locked() and raw_getsockopt() also move
> out of the locked section?
> 
> isotp_setsockopt() has the same pattern against isotp_notify(), since every
> option is copied under lock_sock():
> 
> 	lock_sock(sk);
> 	ret = isotp_setsockopt_locked(sock, level, optname, optval, optlen);
> 	release_sock(sk);
> 
> That code predates this patch. With RTNL gone from isotp_bind(), however,
> bind relies on lock_sock() alone to serialize with isotp_notify().

Right, the early copy in raw_setsockopt() only covers CAN_RAW_FILTER.
Before this patch, raw_setsockopt() held RTNL itself across all user
space copies, so this patch already improves the current situation. The
complete rework that moves all remaining user space copies in raw.c and
isotp.c out of lock_sock() will be addressed in the next net-next cycle.
This is an improvement and not intended for stable.

Best regards,
Oliver
