Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792522893;
	b=ra77sdXi/+QWZARjH0RjOdzNPL7HYU+Vnf8Sp9FKGQa9JmRCGJN1ddzxc+u3YZSlRXou
	 TsdSJ4vh0k7fnYRYjlX+wVJjSyIW+h2272yw4sYpFGnqdRYereuqgVVDRtWGPsLBu7vTa
	 xEpc5E3n48FIjc/DB5nxe5ZRDSKlOWpK73pM7gMvmqNt1YffweZmOorWXecMm/h0D2q2g
	 lHDelfIstdR2uGYOFmOH0auDv0CiGXG4lQmt+NloqXkdDvMmuwONYsHxXrQG0wKpqNctu
	 opK30ytFr4NQ/yB48Wa9ru3DmYyw7V8EWvaLLAPoMedujWESUVwxERGbY0PM2TKOcfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522893;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L94ISj9l4H3Wuk6RHQZ+sIUxjHr69Z3PAjUEKXQG0iU=;
	b=Ne6j08FZYvluJWXcKd5sF3zme5IfiM4gymrJWmpu9667opmQKxvQmJKs4aViYfgR3yIN
	 +A63HwTWkcu4dnMy++1a29uQf7Y5GbdpwCxenrFOB6J7MRT+HOTnmMRYUi9eGEyADG5QE
	 WH84XKG/rxtWwsEYyIEYzQFM3z3F2I45Kos6NkDuFYkQFoUT/rq2eJ85jibP6U4B02/r1
	 Ujb7vvKZ5mPhhCWrjy4B2Jn7iFAe1CeWFvRC1xnkHzlFKI311OWO1TnGdgGq06vpKgs3k
	 V0RyjMIiYCqq0zrRtH0Zb7t8Oba7p9IeYAGclhPv0ZeCVR07EWnzLpcr09RuRKgS5VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aPZfXEmy;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Z4Koh+me;
	arc=fail smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0142606A31B;
	Tue, 20 Oct 2026 19:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0142606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aPZfXEmy;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Z4Koh+me
ARC-Seal: i=1; a=rsa-sha256; t=1792522826; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Subt+VLwroiKxzMDMAtb3lPfFX5KZUv7RoKiXME7wUnC/MNSAlKG4ho98Lh4S6qCTP
    Ny+0ujCGYGLlQVOF/JktRc6+APYqtQ/0p519CkDEi8b2a72KkcgWRVrg3JwRLHeDY7Eg
    2fKvAUdJa4QvEW4AafJ9Nz7biWbKdlqE/YLu6bzPFYEUCZVvKLSdWwcGqUuJZQeiRd2u
    G0QpL1ebZkXrbYu30iLNXkPBug8d3rXcZ4vZ65y+kg9I6qRcSj4WehezJhyi7OFT3qpI
    sHEeZETc8ZmoWcturF4ZclmeoMKNDEmZf/HNnUJQHslk46xwEhRnvjdfTPyeyyI3j4ZA
    eMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792522826;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L94ISj9l4H3Wuk6RHQZ+sIUxjHr69Z3PAjUEKXQG0iU=;
    b=lYkOHlT64kusUD8NqC0Y1KsB/YlNt0C57JDyphULVrQFzWvA87jHs3QXItObjGYSN/
    bX5AIeF61NHIXTNPAJJhaeOHEIPgB6kv/HMyxy2gmE589/uw7t84sySu2RCr4ELOmriM
    hGJCSPSuBrL4Lb/DGEG/19IzLDByQqc9utSQ4JVMSMf9WUbZ1dxb/Pe1cpjzSTRRnZYM
    BkiWQ1Y1TgHhsxhAFZFkeNNbOrZ/e0rk1va2XHR0FfLZ8HNiWih/V2uwSXMZVzEu06+f
    LiKO48Q722uHcLJLzLakztAIg610/lLnZqle6ahlR9m7lDsErR6tMhKL9F1lJRe6ULQC
    6yYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792522826;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L94ISj9l4H3Wuk6RHQZ+sIUxjHr69Z3PAjUEKXQG0iU=;
    b=aPZfXEmyQNebWJ1EOpR67gJvt7DOiXKfpQ2njE1XIR1Ol5Rh5AFA32qvMN6uqLz26n
    kueo5KAgRrSXfSjwHWxKAWyLHH+iLg6yNlIF8KBygFRy6RPuQF1wLfdnctceUnkLD10m
    QW7/BJMjw/6X/LI/96foIt7N5/KL+LCuW1bd2wC9I/jsR7XKNHAHXcSSJvAluHVx5bLh
    HsE5TTwnwN0VtX2wMzWE55moxu0X/eBv+LzoFrAnzGr4ffB1Nf7qZ8gsqoYasQCqo20k
    mNRAdNl7sZxq7V61ufgiEa7v2g7I3ktz/M+5iJtYZk3IOP5EQXmpUmKFsJGBDKFepMUr
    4vNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792522826;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L94ISj9l4H3Wuk6RHQZ+sIUxjHr69Z3PAjUEKXQG0iU=;
    b=Z4Koh+mebxiPPaw4aAClUSL+xE7fFzSVwRxp0unbbPQnniLeC9IvOIsQjWgV/Idao3
    EXkTR2Y0P1Pef2htOUCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KJ0Pd5f
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 21:00:25 +0200 (CEST)
Message-ID: <bc3bf21e-0437-4947-9541-0d10657aac02@hartkopp.net>
Date: Tue, 20 Oct 2026 21:00:25 +0200
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
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, 1579567540@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org
References: <20261019170834.1727150-12-mkl@pengutronix.de>
 <179251629957.3135.180755777057921325@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179251629957.3135.180755777057921325@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.10.26 19:11, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] raw_bind() no longer holds RTNL, so the socket can miss a
>    NETDEV_DOWN that arrives while it is binding.
> - [Low] The commit message says "the callers pass the namespace that has
>    been used for can_rx_register()", and the new kernel-doc of…
> - [Low] The new comment on netns_can.rcvlists_lock in
>    include/net/netns/can.h says it "protects rcv_lists_stats".
> 

Thanks for the review.

[Medium] NETDEV_DOWN during raw_bind():

The window exists, but it only affects a down transition in the middle
of raw_bind(). Missing the asynchronous ENETDOWN there is harmless and
not worth an additional barrier pair in raw_bind() and raw_notify():

- Every transmission on a CAN_RAW socket goes through can_send(), which
   checks IFF_UP and returns -ENETDOWN to sendmsg(). So the state is
   reported reliably on every send attempt.

- The missed notification does not affect the binding: the CAN_RAW
   socket stays bound and its filters stay registered across down/up,
   and frames are received again once the interface is up.

- Applications can not rely on this notification anyway: a CAN_RAW
   socket bound to all CAN interfaces (ifindex 0) never gets ENETDOWN.
   Applications that need the link state have to track it via
   rtnetlink, not via the CAN socket.

[Low] rcvlists_lock comment / j1939 @net: These are documentation
details; the j1939 statistics behaviour is unchanged by this patch, as
noted in the patch description.

Best regards,
Oliver


> --
> 
> can: protect the receive lists with a per-device lock
> 
> This commit adds a spinlock to struct can_dev_rcv_lists. The receive lists
> of a CAN device are now protected per device instead of by the per-netns
> rcvlists_lock, so can_rx_unregister() still finds subscriptions after the
> device has moved to another namespace. It also drops RTNL from raw_bind(),
> raw_setsockopt(), raw_release(), isotp_bind() and isotp_release(), and
> relies on lock_sock() plus a device pointer published inside the RCU
> lookup to serialize with the netdev notifiers.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Link: https://patch.msgid.link/20261019152741.54854-6-socketcan@hartkopp.net
> 
>> diff --git a/include/net/netns/can.h b/include/net/netns/can.h
>> index 48b79f7e6236..ef7aefdf7b23 100644
>> --- a/include/net/netns/can.h
>> +++ b/include/net/netns/can.h
>> @@ -29,7 +29,7 @@ struct netns_can {
>>   
>>   	/* receive filters subscribed for 'all' CAN devices */
>>   	struct can_dev_rcv_lists *rx_alldev_list;
>> -	spinlock_t rcvlists_lock;
>> +	spinlock_t rcvlists_lock; /* protects rcv_lists_stats */
> 
> [Severity: Low]
> This isn't a bug, but is this comment accurate? The lock only serializes
> the rcv_entries and rcv_entries_max updates in can_rx_register() and
> can_rx_unregister().
> 
> can_init_stats() in net/can/proc.c updates other fields of the same
> structure without taking rcvlists_lock. It runs from the stats timer, or
> from the reset_stats proc read when the timer is disabled:
> 
> net/can/proc.c:can_init_stats() {
>      ...
> 	rcv_lists_stats->stats_reset++;
> 
> 	if (user_reset) {
> 		user_reset = 0;
> 		rcv_lists_stats->user_reset++;
> 	}
> }
> 
> can_stats_proc_show() also reads these counters without the lock.
> 
> Could the comment name rcv_entries and rcv_entries_max specifically?
> 
> [ ... ]
> 
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index d97f85fc3232..bf612c4b983d 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
> 
> [ ... ]
> 
>> @@ -509,6 +513,13 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
>>    *
>>    * Description:
>>    *  Removes subscription entry depending on given (subscription) values.
>> + *  The receive lists of a CAN device are protected by a per-device lock,
>> + *  so the subscription is found even when the device has been moved to
>> + *  another network namespace after can_rx_register(). The caller has to
>> + *  ensure that @dev stays valid, e.g. by holding a reference to @dev or
>> + *  RTNL. @net is the namespace that has been used for can_rx_register().
>> + *  It selects the 'any' CAN device lists for @dev == NULL and is used for
>> + *  the receive list statistics.
>>    */
> 
> [Severity: Low]
> The new kernel-doc says @net is the namespace that was used for
> can_rx_register(). The commit message says the same: "the callers pass
> the namespace that has been used for can_rx_register()".
> 
> Does j1939 follow this? It reads dev_net(ndev) again at unregister time:
> 
> net/can/j1939/main.c:j1939_can_rx_register() {
>      ...
> 	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
> 			      j1939_can_recv, priv, 0, NULL);
>      ...
> }
> 
> net/can/j1939/main.c:j1939_can_rx_unregister() {
>      ...
> 	can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
> 			  j1939_can_recv, priv);
>      ...
> }
> 
> A j1939 registration can outlive a namespace move. j1939_sk_bind() does
> not hold RTNL. It calls j1939_netdev_start(), which registers with the old
> namespace, before it calls j1939_jsk_add().
> 
> Suppose the NETDEV_UNREGISTER from __dev_change_net_namespace() runs
> j1939_sk_netdev_event_unregister() in that window. The socket is not
> J1939_SOCK_BOUND yet, so it is skipped and the registration survives the
> move. The final release then passes the new namespace:
> 
> j1939_netdev_stop()
>    __j1939_rx_release()
>      j1939_can_rx_unregister()
>        can_rx_unregister(dev_net(ndev), ...)
> 
> The receiver is still found through the per-device lists. However,
> rcv_entries is decremented in the new namespace's rcv_lists_stats
> (clamped at 0) and stays elevated in the old one. This accounting matches
> the behaviour before the patch.
> 
> Should j1939_priv store the registration namespace (with a netns
> reference)? Or should the kernel-doc and commit message describe a looser
> rule?
> 
> [ ... ]
> 
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index dfea48768b23..0d8edfa772fb 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> 
> [ ... ]
> 
>> @@ -305,16 +309,28 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>   		       struct net_device *dev)
>>   {
>>   	struct sock *sk = &ro->sk;
>> +	struct net_device *bind_dev;
>>   
>>   	if (!net_eq(dev_net(dev), sock_net(sk)))
>>   		return;
>>   
>> -	if (ro->dev != dev)
>> +	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
>> +	 * Read it before ro->dev, pairs with smp_store_release() in
>> +	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
>> +	 */
>> +	bind_dev = smp_load_acquire(&ro->bind_dev);
>> +	if (READ_ONCE(ro->dev) != dev &&
>> +	    (msg != NETDEV_UNREGISTER || bind_dev != dev))
>>   		return;
> 
> [Severity: Medium]
> Can a NETDEV_DOWN be lost while raw_bind() is running? The bind_dev hint
> is only checked for NETDEV_UNREGISTER, and raw_bind() no longer holds
> RTNL.
> 
> raw_bind() now runs these steps in order:
> 
>      smp_store_release(&ro->bind_dev, dev);
>      ...
>      if (!(READ_ONCE(dev->flags) & IFF_UP))   /* device still up here */
>          notify_enetdown = 1;
>      ...
>      err = raw_enable_allfilters(sock_net(sk), dev, sk);  /* cond_resched() */
>      ...
>      WRITE_ONCE(ro->dev, dev);
> 
> Suppose dev_close() runs after the IFF_UP check but before ro->dev is
> published. raw_notifier()->raw_notify() then sees ro->dev != dev with
> msg == NETDEV_DOWN, so it returns at the check above and never reaches
> case NETDEV_DOWN. raw_bind() finishes with notify_enetdown == 0.
> 
> The socket ends up bound to a down interface, and sk_err = ENETDOWN /
> sk_error_report() is never raised. Before this patch, rtnl_lock() in
> raw_bind() kept dev_close() out of this window.
> 
> isotp_bind() publishes so->dev before it reads IFF_UP, so it does not seem
> to have this problem.
> 
> Could raw_notify() also check bind_dev for NETDEV_DOWN? Alternatively,
> raw_bind() could publish ro->dev before the IFF_UP check.
> 
> [ ... ]
> 

