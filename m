Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E1499F2C;
	Mon, 19 Oct 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398649; cv=pass; b=KWi6QdCR6kDt6xcqamNa8AqFjb4BG8AUN6BySdDpH1e6GNPOpiPKGSAZ7qGI9qVUJEw++8kpvsYGfk9bnpy9n0jnaOzDrGRorPMTcszMffxrMEOTMOyU5c5KfHveIn+wL7MdxlUfM7OwHu478WrvYdq6zLUE6I9ptoA4U0mND1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398649; c=relaxed/simple;
	bh=HmpVNdhv6QtkHRkJJTcEBjmSr1CccZytO+Ii3tGWQLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FQjHCHmHrHTltFSJG3wGwRz7Jnjk1iKzUEnblVbNryduOXg2RGT2rvnSp+IVsd/67nxTCs69ekrq5mBgnHJ7r1TL4KogrSOW9xhkdpB14yTc3WeOXlZtKXAfSLZX2NEwH1TU7q2lwHvEMOaN6+dkRJq4NDrP9xlLioy6x5SWKDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NBnANE2g; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ERce9Cf9; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NBnANE2g";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ERce9Cf9"
ARC-Seal: i=1; a=rsa-sha256; t=1792398629; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=abb104XcHvYyzG8V0wwesUJjbaehQNaLcUlejxvU9o0EZac3j0n1URqB3Q3LzAPlgG
    MwNm/2rzVp4W2OUtPSiakmK+/Tc2sGItFXtYJG7q5vh6li+QZeICAAo68+2p/PGWCyAK
    EQ6sr7+r+0R+bF1ZR49v4oWCRiYUDFEp2FCrMoM6cKJG9ff+fsk2opl6RDdwDwtzZrId
    VXvTrEYyhX7zjzfcRej0tMJAWp+4y+hT9ZDJfDRNUEpoNw3GuAsjwdA5AZrRBFEve5yv
    d6B1vchijW1pWIR73Qh76MPYnWXjVpodaVb1pdQd3xbsPWXol/hkGx3+x1p11SyGQMEK
    O44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792398629;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HzlIANHSQjjUD/nIIW4EpTjJ/lLBfk8ZmynBzZMwyS4=;
    b=e4du5CLrXBUTXq2WHrRyIvUI4vTeNB0wZ0vN/iqO4FlAGwItYuGKa8+zmbXEQCCU10
    7idDnTYYJYUADf5mqTEKjnSThwOwVZu2lMm64ysilCZXd+2olr5XkXKpx0tssKBYDhmQ
    0FxCdc7Wu+6xXfvmO7bMkuY1iEJp426nBWrqjCoix0HZtGtBznO6jgJ+LtwhWc911e27
    bSf1SFWV4ZWpqqxd5R51yWYeWeO4yHqDz42PgGCkoIU2ZJx5iGD70dlzuzhBbTA3GcV5
    9RfzzFBV25TkY3Y28bcH7RXcm4OpuCpOgaFZcsk5DdrOan8RbeSEJOycKk9SJ7juFZUc
    iy6A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792398629;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HzlIANHSQjjUD/nIIW4EpTjJ/lLBfk8ZmynBzZMwyS4=;
    b=NBnANE2gB4xHmEOq6YMDacU2A8OyMPrnzDBGIJmDo7O/HvjTsI54NpTWmN5ZXwC23Z
    uukWbKWkjv6NKOTX8mXzeEeWY/HdtpUk1OkTV+5VKBqWQbtgWsHPhGzGZVYFz7xTZFYC
    CjsV43uAldYb1LySxQx22XFo0ItjZxOp9Cay3yj7spIiKfFu8UE3wQaDZMHN5cczT5Kk
    MtLq7JDbNMGt+NKT6wzFXbEuFnY1v7Ewpj2VHxWd7LeFl2wgD/eXhMaTF9svsLhcW6kp
    PgURws4c4+Gmmf3uwCSizE50XF1vkU05hNee9aVjLZGvnTWThgYsWQMfSj6ZSutfQT+C
    c6Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792398629;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HzlIANHSQjjUD/nIIW4EpTjJ/lLBfk8ZmynBzZMwyS4=;
    b=ERce9Cf94PGTNMSgpLEdY9fm47G49vVgwytVeCfFJN7s6qQGGiPCUArE8Mjye0HlS2
    ran3PS5QW7yaUaj72PAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29J8USVC7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 10:30:28 +0200 (CEST)
Message-ID: <d983320d-3eca-4f36-8974-867050ac5404@hartkopp.net>
Date: Mon, 19 Oct 2026 10:30:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Norbert Szetei <norbert@doyensec.com>,
 stable@vger.kernel.org
References: <20261018164417.1540449-1-mkl@pengutronix.de>
 <20261018164417.1540449-7-mkl@pengutronix.de>
 <088cfba9-f0c7-4f51-a9a5-4e1b28b8e90b@hartkopp.net>
Content-Language: en-US
In-Reply-To: <088cfba9-f0c7-4f51-a9a5-4e1b28b8e90b@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.10.26 20:37, Oliver Hartkopp wrote:
> Hello Marc,
> 
> sashiko-bot complained about problems with the rtnl_lock() usage in this 
> bcm patch here:
> 
> https://lore.kernel.org/linux-can/99fed91f- 
> dbc5-4029-8a34-7e0113acfe13@hartkopp.net/
> 
> This problem applies to all of these fixes:
> 
> [PATCH net-next 04/12] can: isotp: fix filter removal race between 
> release and netns change
> https://lore.kernel.org/linux-can/20261018164417.1540449-5- 
> mkl@pengutronix.de/
> 
> [PATCH net-next 06/12] can: bcm: fix filter removal race between release 
> and netns change
> https://lore.kernel.org/linux-can/20261018164417.1540449-7- 
> mkl@pengutronix.de/
> 
> [PATCH net-next 08/12] can: raw: take rtnl_lock() before leaving the 
> notifier list
> https://lore.kernel.org/linux-can/20261018164417.1540449-9- 
> mkl@pengutronix.de/
> 
> They all correctly fix the race when moving CAN devices to other 
> namespaces when releasing sockets - BUT with the cost of rtnl locks that 
> can be triggered by unprivileged users.
> 
> "Taking RTNL in these release paths is no option: raw_bind(),
> raw_setsockopt() and raw_release() already hold RTNL while adding and
> removing up to CAN_RAW_FILTER_MAX filters per socket, which unprivileged
> users can trigger repeatedly and which makes RTNL a global bottleneck."
> 
> This patch
> 
> [RFC PATCH can-next v2] can: protect the receive lists with a per-device 
> lock
> https://lore.kernel.org/linux-can/20261018180739.689750-1- 
> socketcan@hartkopp.net/
> 
> replaces those three patches and removes the formerly required increased 
> usage of rtnl_lock() by adding a new can_dev_rcv_lists::lock that is 
> placed in ml_priv and is device specific (independently from namespaces).
> 
> I've worked on this patch the entire weekend and tested it extensively.
> 
> I would suggest to replace the three patches with that single one for an 
> updated PR and let sashiko-bot take a final look at it.

I created a v3 series so that sashiko-bot gets a complete series that 
applies properly to mainline for an AI review:

https://lore.kernel.org/linux-can/20261019074244.50391-1-socketcan@hartkopp.net/

The relevant v3 patch 4/4 has some changes in the documentation only 
that should make sashiko-bot even more happy o_O

https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/

Best regards,
Oliver

> 
> ps. I did your requested instrumentation and found a missing glitch 
> which is the reason for the v2 patch. The v1 will get its sashiko review 
> today at ~10pm due to the 24h embargo :-/
> 
> On 18.10.26 18:41, Marc Kleine-Budde wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> bcm_release() removes the socket from bcm_notifier_list before it takes
>> any lock that serializes against the netdev notifier chain, which runs
>> under RTNL. A socket that leaves the list in this window is skipped by
>> bcm_notify() and has to remove its CAN filters itself.
>>
>> This fails when the bound device is moved to another network namespace
>> in this window: bcm_rx_unreg() reads dev_net(dev) without holding RTNL,
>> and can_rx_unregister() silently returns when this namespace does not
>> match dev_net(dev) anymore. The op is freed anyway and the remaining
>> receiver leads to a use-after-free in bcm_rx_handler().
>>
>> Take rtnl_lock() before removing the socket from the notifier list, so
>> that bcm_release() and bcm_notify() can not both skip the removal and
>> dev_net(dev) is stable while the device specific filters are removed.
>> As the notifier chain is always invoked under RTNL, bcm_busy_notifier
>> can not point to the released socket anymore. Replace the now dead
>> busy-wait loop with a WARN_ON_ONCE().
>>
>> RTNL is only held for the notifier list removal and the removal of the
>> device specific filters. Once the socket has left the notifier list,
>> bcm_notify() can not access it anymore. So the procfs entry, the tx_ops
>> and the filters for 'any' CAN device, which live in the socket's
>> namespace, are removed after RTNL has been released. This way a stalled
>> reader of the world-readable procfs entry can not hold up RTNL, and the
>> removal of the 'any' CAN device filters does not delay RTNL anymore.
>>
>> Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
>> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4- 
>> CBAE2F301A8E@doyensec.com/
>> Cc: Norbert Szetei <norbert@doyensec.com>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Link: https://patch.msgid.link/20261016091128.325332-3- 
>> socketcan@hartkopp.net
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   net/can/bcm.c | 47 +++++++++++++++++++++--------------------------
>>   1 file changed, 21 insertions(+), 26 deletions(-)
>>
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 6759662e024c..fbc79da4e4fc 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1926,17 +1926,30 @@ static int bcm_release(struct socket *sock)
>>       /* remove bcm_ops, timer, rx_unregister(), etc. */
>> +    rtnl_lock();
>> +
>> +    /* The netdev notifier chain runs under RTNL, so bcm_notifier() 
>> can't
>> +     * be walking bcm_notifier_list and point to this socket. The 
>> spinlock
>> +     * is still needed as bcm_init() adds sockets without holding RTNL.
>> +     */
>>       spin_lock(&bcm_notifier_lock);
>> -    while (bcm_busy_notifier == bo) {
>> -        spin_unlock(&bcm_notifier_lock);
>> -        schedule_timeout_uninterruptible(1);
>> -        spin_lock(&bcm_notifier_lock);
>> -    }
>> +    WARN_ON_ONCE(bcm_busy_notifier == bo);
>>       list_del(&bo->notifier);
>>       spin_unlock(&bcm_notifier_lock);
>>       lock_sock(sk);
>> +    /* Remove the device specific subscriptions under RTNL */
>> +    list_for_each_entry(op, &bo->rx_ops, list)
>> +        if (op->ifindex && op->rx_reg_dev)
>> +            bcm_rx_unreg(op->rx_reg_dev, op);
>> +
>> +    rtnl_unlock();
>> +
>> +    /* bcm_notify() can not access this socket anymore. Release the 
>> other
>> +     * resources without holding RTNL, e.g. remove_proc_entry() waits 
>> for
>> +     * concurrent readers of the procfs entry.
>> +     */
>>   #if IS_ENABLED(CONFIG_PROC_FS)
>>       /* remove procfs entry */
>>       if (net->can.bcmproc_dir && bo->bcm_proc_read)
>> @@ -1948,31 +1961,13 @@ static int bcm_release(struct socket *sock)
>>           bcm_remove_op(op);
>>       }
>> -    list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>> -        /*
>> -         * Don't care if we're bound or not (due to netdev problems)
>> -         * can_rx_unregister() is always a save thing to do here.
>> -         */
>> -        if (op->ifindex) {
>> -            /*
>> -             * Only remove subscriptions that had not
>> -             * been removed due to NETDEV_UNREGISTER
>> -             * in bcm_notifier()
>> -             *
>> -             * op->rx_reg_dev is a tracked reference taken
>> -             * when the subscription was registered, so it
>> -             * stays valid here even if a concurrent
>> -             * NETDEV_UNREGISTER already unlisted the device.
>> -             */
>> -            if (op->rx_reg_dev)
>> -                bcm_rx_unreg(op->rx_reg_dev, op);
>> -        } else
>> +    /* 'any' CAN device subscriptions live in the socket's namespace */
>> +    list_for_each_entry(op, &bo->rx_ops, list)
>> +        if (!op->ifindex)
>>               can_rx_unregister(net, NULL, op->can_id,
>>                         REGMASK(op->can_id),
>>                         bcm_rx_handler, op);
>> -    }
>> -
>>       synchronize_rcu();
>>       list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
> 
> 

