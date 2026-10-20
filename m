Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792529360;
	b=kMR4sW87oyFMzC34PjSb1m15Ku2S0EX6cH6G6N20RiosbuxKecv4OZ7OrS869Cg4N2eU
	 YvKpz0VyTFSoPMbfkJqWBm4oHdaROF8CSaEwXYho6VPW10nsulaiqYxdYcC+wbyq5y1yA
	 vD4t/RufoiGxyyc9iBfzuHmvrJ9k6WT53oXkiWnI4l30tbE0fMwKgt4dZENQ07o5Q32pQ
	 UAnZ4cmaahIuB6t31vc0Ign7Y9oDtA5D3pFO0hhTxSjlsFty/gDTLLib4a+PuCkCzx0nK
	 6JtvdqSBMwDd+3zHDp5WHqKCu4RJU3CVGgp5CZJNc5AqrzkhbufP96RORW3Mwqgn7SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529360;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=I37y3PbjDyW7wAadNG2flDkR02gL+gBhqVZhtsgvRCQ=;
	b=cm2UMETcuXus6fChg2Z3hzmtMhwsu/Pp8ZrQ8isktCNuJJhTiokA+qQPo8DGkjTRYJji
	 O1nX/elajifbQuSZWHUM+mANP2VQxSwSEdOrFI4dVT8GKtWpubC0uj1UnJNsAGNMwkIoC
	 2sAHC+r6BlpfJX8wFbHZTgv2wCj6EB7Mc+22yAzl7f7y/4rgpjIFsrtDjZj4GHjb7/avK
	 ERCkDROlIdTeFFXjHOx7UY0zc/9B5t79DaZPv5JONsf0sERU2uKERA9VhIx/WjtSuY/5i
	 fy7IIaZ1NPsZDl4rkvGkCEE4wdMVa9jV+RvGLdWz3qcNj/ozOG+CW1tocErLzIi0JlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=X4ahpd+0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iIsJX5E+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85A606A31D;
	Tue, 20 Oct 2026 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA85A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=X4ahpd+0;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iIsJX5E+
ARC-Seal: i=1; a=rsa-sha256; t=1792529293; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Er23p06ctFyOOrQtj8N2zgbBrSpMVXByddu2K63eFVngcvDghcJxAkxsncBa6zXL8g
    H1GlGSjtGgc7A1RuULtdkByx9ouIS/4RSIUGhWjm/MkKO15bzORPUDo1mHMJ3RdzGzMc
    gz877rFypIQ2GErjD85TgXPuzkt057xWSi+c/B5qqgT1mmDnN2zasYdvFpaQxjF9Ki+k
    CNX1gMpB10BrkrxbY3bAxn7POLR+O/unmiBJaZEwKkY9jtcUtqHHyIwnLvvCUUqQHfTb
    52PIrdfgi3NB0uVxEj1V5JnrhS3JI35JRko35+kShSADkjuoF3HNUz9BijLw+mx0Ey8T
    /B+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792529293;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I37y3PbjDyW7wAadNG2flDkR02gL+gBhqVZhtsgvRCQ=;
    b=PDp5StqFy4xzGDoZeJBd2xqzEzpC6+zIv/eixyFLm7j5LeyKhUUVaM7fqSmSbOaHe0
    hhZNdhCtEkcBpQ8cJHUWxL4iqX19KT8nemL1GRqN4DSNF5o2WnPX1SNmNEKaRcOlkpmJ
    TO8o8GqTxJ309Yt9lbffIFhIsBcVrHQiw695On8fypm0PviGRiNwoE8rEZousoR/Ke+V
    kpFBqNQ1cTjbNqr0/AgL00I3wIUp+H6VqK0ozVXIDZIpfMgM6s/4MXGWoDOhW/fA56CE
    pE7BeQCKAJGC5FCOtPDjDF9ytfi0nh2lPLGLx1Ht4ihH8SERW9Y2UjWgrRdYJuMUqXv5
    vHgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792529293;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I37y3PbjDyW7wAadNG2flDkR02gL+gBhqVZhtsgvRCQ=;
    b=X4ahpd+0hluAe5oyLKv/vx8clFD87qfB9s/fYnFBM6yJQw6UHm0Tk8qpna3EVbAfez
    7hc/1ol0oNbQs9/6lGMlafdORbFtB+i/4LbVg4IcPRnPMQUJVLfJ4QAL0ujSerLUaiwP
    gWWYqat08QfgmU1FH3MfnbNeW7WyvylBNQRFvOd67z0WsgA5pMDWGbjUU2zbeuG/zbMU
    SsG+8NvvbWTOVl7Ayxo92yR7YFwk0aE/yGxJBECsieQ7uTWoMakPR75S3gGv+ggWHi9R
    9zUHOVbtpy2fmD+V8DVF84K57juCRoEc2sNHT7mcnzgThcwfKmqAYhF+TOriuyOr7u2/
    ebzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792529293;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I37y3PbjDyW7wAadNG2flDkR02gL+gBhqVZhtsgvRCQ=;
    b=iIsJX5E+R4xfsNA6u4c5MiWij7xlNPDVdA1t8XZNCDVDsJKg9PboJ4Q4btM9m0tSgS
    0sFRSJWR/fYTXWBe0gBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKmCdP5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:48:12 +0200 (CEST)
Message-ID: <3aa7aa70-fe76-4b4c-a097-c0c22a1f9cb9@hartkopp.net>
Date: Tue, 20 Oct 2026 22:48:12 +0200
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
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, 1579567540@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org
References: <20261019170834.1727150-12-mkl@pengutronix.de>
 <179251629957.3135.180755777057921325@kernel.org>
 <bc3bf21e-0437-4947-9541-0d10657aac02@hartkopp.net>
Content-Language: en-US
In-Reply-To: <bc3bf21e-0437-4947-9541-0d10657aac02@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.10.26 21:00, Oliver Hartkopp wrote:
> 
> 
> On 20.10.26 19:11, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 2
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply
>> (one such reply per series is enough).
>>
>> - [Medium] raw_bind() no longer holds RTNL, so the socket can miss a
>>    NETDEV_DOWN that arrives while it is binding.
>> - [Low] The commit message says "the callers pass the namespace that has
>>    been used for can_rx_register()", and the new kernel-doc of…
>> - [Low] The new comment on netns_can.rcvlists_lock in
>>    include/net/netns/can.h says it "protects rcv_lists_stats".
>>
> 
> Thanks for the review.
> 
> [Medium] NETDEV_DOWN during raw_bind():
> 
> The window exists, but it only affects a down transition in the middle
> of raw_bind(). Missing the asynchronous ENETDOWN there is harmless and
> not worth an additional barrier pair in raw_bind() and raw_notify():


I did a closer look into it.

Although the missing of -ENETDOWN in raw_bind() is not a big issue it 
changes the former behaviour which is more relevant for reading from the 
CAN_RAW socket than writing to it.

 >> isotp_bind() publishes so->dev before it reads IFF_UP, so it does not
 >> seem to have this problem.

In fact both raw and isotp need smp_mb() to have the correct ordering.
I would bet a beer sashiko-bot would have remarked it next time :-/

While at it I also fixed the low severity commit and documentation 
remarks from sashiko-bot in patch 5 and patch 4.

New v5 patch set with updated cover letter for can-next is here:

https://lore.kernel.org/linux-can/20261020203257.230955-1-socketcan@hartkopp.net/

Best regards,
Oliver

pw-bot: cr

> 
> - Every transmission on a CAN_RAW socket goes through can_send(), which
>    checks IFF_UP and returns -ENETDOWN to sendmsg(). So the state is
>    reported reliably on every send attempt.
> 
> - The missed notification does not affect the binding: the CAN_RAW
>    socket stays bound and its filters stay registered across down/up,
>    and frames are received again once the interface is up.
> 
> - Applications can not rely on this notification anyway: a CAN_RAW
>    socket bound to all CAN interfaces (ifindex 0) never gets ENETDOWN.
>    Applications that need the link state have to track it via
>    rtnetlink, not via the CAN socket.
> 
> [Low] rcvlists_lock comment / j1939 @net: These are documentation
> details; the j1939 statistics behaviour is unchanged by this patch, as
> noted in the patch description.
> 
> Best regards,
> Oliver
> 
> 
>> -- 
>>
>> can: protect the receive lists with a per-device lock
>>
>> This commit adds a spinlock to struct can_dev_rcv_lists. The receive 
>> lists
>> of a CAN device are now protected per device instead of by the per-netns
>> rcvlists_lock, so can_rx_unregister() still finds subscriptions after the
>> device has moved to another namespace. It also drops RTNL from 
>> raw_bind(),
>> raw_setsockopt(), raw_release(), isotp_bind() and isotp_release(), and
>> relies on lock_sock() plus a device pointer published inside the RCU
>> lookup to serialize with the netdev notifiers.
>>
>> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4- 
>> CBAE2F301A8E@doyensec.com/
>> Link: https://patch.msgid.link/20261019152741.54854-6- 
>> socketcan@hartkopp.net
>>
>>> diff --git a/include/net/netns/can.h b/include/net/netns/can.h
>>> index 48b79f7e6236..ef7aefdf7b23 100644
>>> --- a/include/net/netns/can.h
>>> +++ b/include/net/netns/can.h
>>> @@ -29,7 +29,7 @@ struct netns_can {
>>>       /* receive filters subscribed for 'all' CAN devices */
>>>       struct can_dev_rcv_lists *rx_alldev_list;
>>> -    spinlock_t rcvlists_lock;
>>> +    spinlock_t rcvlists_lock; /* protects rcv_lists_stats */
>>
>> [Severity: Low]
>> This isn't a bug, but is this comment accurate? The lock only serializes
>> the rcv_entries and rcv_entries_max updates in can_rx_register() and
>> can_rx_unregister().
>>
>> can_init_stats() in net/can/proc.c updates other fields of the same
>> structure without taking rcvlists_lock. It runs from the stats timer, or
>> from the reset_stats proc read when the timer is disabled:
>>
>> net/can/proc.c:can_init_stats() {
>>      ...
>>     rcv_lists_stats->stats_reset++;
>>
>>     if (user_reset) {
>>         user_reset = 0;
>>         rcv_lists_stats->user_reset++;
>>     }
>> }
>>
>> can_stats_proc_show() also reads these counters without the lock.
>>
>> Could the comment name rcv_entries and rcv_entries_max specifically?
>>
>> [ ... ]
>>
>>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>>> index d97f85fc3232..bf612c4b983d 100644
>>> --- a/net/can/af_can.c
>>> +++ b/net/can/af_can.c
>>
>> [ ... ]
>>
>>> @@ -509,6 +513,13 @@ static void can_rx_delete_receiver(struct 
>>> rcu_head *rp)
>>>    *
>>>    * Description:
>>>    *  Removes subscription entry depending on given (subscription) 
>>> values.
>>> + *  The receive lists of a CAN device are protected by a per-device 
>>> lock,
>>> + *  so the subscription is found even when the device has been moved to
>>> + *  another network namespace after can_rx_register(). The caller 
>>> has to
>>> + *  ensure that @dev stays valid, e.g. by holding a reference to 
>>> @dev or
>>> + *  RTNL. @net is the namespace that has been used for 
>>> can_rx_register().
>>> + *  It selects the 'any' CAN device lists for @dev == NULL and is 
>>> used for
>>> + *  the receive list statistics.
>>>    */
>>
>> [Severity: Low]
>> The new kernel-doc says @net is the namespace that was used for
>> can_rx_register(). The commit message says the same: "the callers pass
>> the namespace that has been used for can_rx_register()".
>>
>> Does j1939 follow this? It reads dev_net(ndev) again at unregister time:
>>
>> net/can/j1939/main.c:j1939_can_rx_register() {
>>      ...
>>     ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, 
>> J1939_CAN_MASK,
>>                   j1939_can_recv, priv, 0, NULL);
>>      ...
>> }
>>
>> net/can/j1939/main.c:j1939_can_rx_unregister() {
>>      ...
>>     can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
>>               j1939_can_recv, priv);
>>      ...
>> }
>>
>> A j1939 registration can outlive a namespace move. j1939_sk_bind() does
>> not hold RTNL. It calls j1939_netdev_start(), which registers with the 
>> old
>> namespace, before it calls j1939_jsk_add().
>>
>> Suppose the NETDEV_UNREGISTER from __dev_change_net_namespace() runs
>> j1939_sk_netdev_event_unregister() in that window. The socket is not
>> J1939_SOCK_BOUND yet, so it is skipped and the registration survives the
>> move. The final release then passes the new namespace:
>>
>> j1939_netdev_stop()
>>    __j1939_rx_release()
>>      j1939_can_rx_unregister()
>>        can_rx_unregister(dev_net(ndev), ...)
>>
>> The receiver is still found through the per-device lists. However,
>> rcv_entries is decremented in the new namespace's rcv_lists_stats
>> (clamped at 0) and stays elevated in the old one. This accounting matches
>> the behaviour before the patch.
>>
>> Should j1939_priv store the registration namespace (with a netns
>> reference)? Or should the kernel-doc and commit message describe a looser
>> rule?
>>
>> [ ... ]
>>
>>> diff --git a/net/can/raw.c b/net/can/raw.c
>>> index dfea48768b23..0d8edfa772fb 100644
>>> --- a/net/can/raw.c
>>> +++ b/net/can/raw.c
>>
>> [ ... ]
>>
>>> @@ -305,16 +309,28 @@ static void raw_notify(struct raw_sock *ro, 
>>> unsigned long msg,
>>>                  struct net_device *dev)
>>>   {
>>>       struct sock *sk = &ro->sk;
>>> +    struct net_device *bind_dev;
>>>       if (!net_eq(dev_net(dev), sock_net(sk)))
>>>           return;
>>> -    if (ro->dev != dev)
>>> +    /* Lockless fast path, ro->bind_dev covers a concurrent bind().
>>> +     * Read it before ro->dev, pairs with smp_store_release() in
>>> +     * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
>>> +     */
>>> +    bind_dev = smp_load_acquire(&ro->bind_dev);
>>> +    if (READ_ONCE(ro->dev) != dev &&
>>> +        (msg != NETDEV_UNREGISTER || bind_dev != dev))
>>>           return;
>>
>> [Severity: Medium]
>> Can a NETDEV_DOWN be lost while raw_bind() is running? The bind_dev hint
>> is only checked for NETDEV_UNREGISTER, and raw_bind() no longer holds
>> RTNL.
>>
>> raw_bind() now runs these steps in order:
>>
>>      smp_store_release(&ro->bind_dev, dev);
>>      ...
>>      if (!(READ_ONCE(dev->flags) & IFF_UP))   /* device still up here */
>>          notify_enetdown = 1;
>>      ...
>>      err = raw_enable_allfilters(sock_net(sk), dev, sk);  /* 
>> cond_resched() */
>>      ...
>>      WRITE_ONCE(ro->dev, dev);
>>
>> Suppose dev_close() runs after the IFF_UP check but before ro->dev is
>> published. raw_notifier()->raw_notify() then sees ro->dev != dev with
>> msg == NETDEV_DOWN, so it returns at the check above and never reaches
>> case NETDEV_DOWN. raw_bind() finishes with notify_enetdown == 0.
>>
>> The socket ends up bound to a down interface, and sk_err = ENETDOWN /
>> sk_error_report() is never raised. Before this patch, rtnl_lock() in
>> raw_bind() kept dev_close() out of this window.
>>
>> isotp_bind() publishes so->dev before it reads IFF_UP, so it does not 
>> seem
>> to have this problem.
>>
>> Could raw_notify() also check bind_dev for NETDEV_DOWN? Alternatively,
>> raw_bind() could publish ro->dev before the IFF_UP check.
>>
>> [ ... ]
>>
> 
> 

