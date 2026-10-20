Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792518714;
	b=mm9Osgsf3Ps4ijAxb1Ul0zz0sZ+UG1R8x5aAXYT6Jh0gXaQ/NE7JQ7nEE1bvp6UeAunF
	 sbwOuKNnrwwY3/Jpts1tjgKIeaiNn3TUGIUsbcHY7D4kQc6MyVOg1XXxvRVX7LbO+bEL2
	 gBN2yAr3lhmEac5qG3DzVKHTPDGPqnRjun1yQwgrAAW/mY6QCH8FHhCYwTWmI/GmD4Tv5
	 vfZdgGv4Odii7doQtMYptFeFe7TuEZqkNOTRv2xpNFfd76WXqsXrVZV4YB3pHOCxqrih5
	 nckFkvLMdmuLZho4LySnJ+8Y/vErDzlGuAHoWzAS9+X/wcF6v6bVtTIkDZMdGupwnoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518714;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/lWhkwvW5Kg+2rQ8alcge5uahNeabNpwNFOn2oIPdwY=;
	b=QIIxMrA9VopjkwBRf+otiWfWI8ceLcAps9iT53fTrvo5xGS1Ad7tvrCF680YXPUaWObz
	 tNylgBEv89dtyrESNujSQCkmzHlemGtbG3/aT+Hrv2+kPl49Mk14pHkGZoBZg+MEkTpaw
	 o9NWZr+6TI93akphtKsXMGIfjqY81seddtjbHIeGWSOIRlmgQkdfD4uFNYczQqY5Nh80C
	 2Ygez7atny2K3TNgf2Dve81RveW7ZhcKzVYW3BihABrxvsM5OXhyXYa/IisrVFg7d2+0M
	 PsL4hq8PxKbAOhJvqFfLQp2kK2BD0Q/Um2mH4MxAbSC7/vVBNDXjMA0sCJ1XqCZjrmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qsrdJ736;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PpKCZH2l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218D606A319;
	Tue, 20 Oct 2026 17:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F218D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qsrdJ736;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PpKCZH2l
ARC-Seal: i=1; a=rsa-sha256; t=1792518639; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PoIdf2JB6Bga4xLIk3/OkYraJUbzqEoQ7tA6TuPPTq77/Z7VRc/8JZq+4R4G18r5E0
    fw6xnQLGyGjKou5zY4CYfh4mAyDtyL9wUYvN/TthEIGbGJnwJJWQEazfyGcAOJlhHtIz
    IV05/s9T+v/H/r4Dkmvred00QbslQOdAnwaLf0m1mqiy7je4PwZ+R0NVunfQApvkcjRi
    aoNo0VFhekvVbJqqPEn9Qd7oNd5A0bX5sfiv6m+uBmG6M3TGOBWvaNpyYRHAuCG1Jl9z
    hmp5OJVwkt7oJDwg33fGI7SVPjYlpQt21FV0j2hhHCnST1tgL7b4rwASmioAJZE57snz
    Y8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792518639;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/lWhkwvW5Kg+2rQ8alcge5uahNeabNpwNFOn2oIPdwY=;
    b=MCobCW37K0Aum5wzm/wa+G93um4P1G3NpUNi0tM0XIB4CqyydFsCylYu88aa1I+eo2
    7wFDWvtDNZvayyScB1V3S8uKRRRSRN6uL+cWl1YZRK6bqwf1AfsxtahzijHf+oL5mPd5
    VGVp24SV75MOiJqufcbVUqJkoKG8R1QPsEAQ3J8H6rHeaz1q8KQYyFytqW4rs3+VIl6P
    1n/F0ARW7mY2rJ52pBp9vvpqfTSRrgS1SuYwuKI2Y1DolMXORU4IP5oi+aXMsQUksjCk
    mXB3Fh4HV1shs3G2jzuxefaSQgYL6eNMEJciUj+O+A8Y8PYwbTeDPa+q0YHhQ+Lj+eGb
    WQ5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792518639;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/lWhkwvW5Kg+2rQ8alcge5uahNeabNpwNFOn2oIPdwY=;
    b=qsrdJ736iy5dxaPNpq4xzuhhjEVfHoD78VUZ9iCMUc9rGrb9MAuVEenzVcMWJIfKM0
    TL/rY1PBRTn8leBE4mfKW8NfPH32WFjxhMT5FYbE5FWohM8WEIGR9SEzJpiE45OzsTcA
    vCOhjtGmsr+SHjP4wpZBeEVSTB4oRIJaW+tpAk6wMCiZWVXXqBK+vC4VEdsTwcGLa/vO
    SVTLVS7BYhCADDuDvPWfR35HSJkomMYCQ/T1vriIxYwjo3zaAvfzaI0dGw0dFHx5tQbR
    +nZfkvBiubDDTLfHdjazDrNlelZWUso+3BjmcRx7DzrTtbCyKDFJi8QjixcXptfO9UHb
    TgLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792518639;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/lWhkwvW5Kg+2rQ8alcge5uahNeabNpwNFOn2oIPdwY=;
    b=PpKCZH2lwbuVOO0agjMWUilNAChmp4BlDVe9Jv9H20x2bgiTqliGW7OYfcRplyybbb
    QisLTwca1ne1IUSBneAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KHobcw6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 19:50:37 +0200 (CEST)
Message-ID: <508dfe04-805a-4872-a95c-c29d5fd4b4e6@hartkopp.net>
Date: Tue, 20 Oct 2026 19:50:31 +0200
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
Subject: Re: [PATCH net-next 10/11] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, 1579567540@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org
References: <20261019170834.1727150-11-mkl@pengutronix.de>
 <179251627911.3135.5362969890074772101@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179251627911.3135.5362969890074772101@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.10.26 19:11, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message is inaccurate about where the crash happens.
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but isotp_bind()
>    in net/can/isotp.c still ignores the return value of both…
> 
> --
> 
> can: replace ARPHRD_CAN type checks with can_get_ml_priv()
> 
> This patch replaces the remaining dev->type == ARPHRD_CAN checks in
> af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The TUNSETLINK
> ioctl can switch a TUN/TAP device to ARPHRD_CAN while dev->ml_priv stays
> NULL, and such a device passes the old type checks.
> 
> Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
> Link: https://patch.msgid.link/20261019152741.54854-5-socketcan@hartkopp.net
> 
>> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
>> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
>> netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
>> dereference when CAN filters are created and when they are removed,
>> e.g. by the CAN protocols' netdevice notifier handlers.
> 
> [Severity: Low]
> Is the "when CAN filters are created" part accurate for this tree?
> 
> Commit 8aa59e3559494 ("can: af_can: fix NULL pointer dereference in
> can_rx_register()") already made can_rx_register() reject devices
> without ml_priv:
> 
>      if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
>          return -ENODEV;

The commit message refers to the CAN filter register/unregister
procedure as a whole, not to a single code path in a specific tree.

Commit 8aa59e3559494 only added the ml_priv check to can_rx_register().
can_rx_unregister() and the CAN protocols kept checking dev->type only.
So that commit fixed the problem only partially, and the NULL pointer
dereference is still reachable on the unregister side.

This patch completes that fix. It uses can_get_ml_priv() as the only
criterion for a real CAN device in all register/unregister paths and in
the protocols' bind/notifier code. It no longer relies on each caller
handling the can_rx_register() return value correctly.

> 
> raw, bcm, gw (through cgw_register_filter()) and isotp all create filters
> through can_rx_register(). So creating a filter can't reach the NULL
> ml_priv.
> 
> The only dereference left seems to be on removal. can_rx_unregister()
> checked only dev->type, and then can_dev_rcv_lists_find() does:
> 
>      struct can_ml_priv *can_ml = can_get_ml_priv(dev);
>      return &can_ml->dev_rcv_lists;
> 
> The spin_lock_bh() on dev_rcv_lists->lock then goes through a near-NULL
> pointer.
> 
> The path that actually gets there looks like isotp. isotp_bind() ignores
> the -ENODEV from both can_rx_register() calls and sets so->bound = 1
> anyway. Later, unregistering the filters crashes:
> 
> isotp_bind()
>      can_rx_register() -> -ENODEV, ignored
>      so->bound = 1
> 
> isotp_release() or isotp_notify(NETDEV_UNREGISTER)
>      can_rx_unregister()
>          can_dev_rcv_lists_find()
>          spin_lock_bh(&dev_rcv_lists->lock)
> 
> The code change itself looks correct. Could the commit message describe
> the crash on removal and the isotp path instead? That would show stable
> backporters which code is affected.
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 64ff203a37f4..5e1c3971ebfc 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1618,7 +1619,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>>   		err = -ENODEV;
>>   		goto out;
>>   	}
>> -	if (dev->type != ARPHRD_CAN) {
>> +	if (!can_get_ml_priv(dev)) {
>>   		err = -ENODEV;
>>   		goto out_put_dev;
>>   	}
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch.
> Further down in isotp_bind(), the return values of both can_rx_register()
> calls are still ignored:

Right. That's a separate issue, and it doesn't belong to this patch. The
missing error handling in isotp_bind() will be addressed in a separate
patch.

Best regards,
Oliver

> 
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, sock_i_ino(sk), sk);
> 	...
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
> 
> 	/* switch to new settings */
> 	...
> 	so->bound = 1;
> 
> The new can_get_ml_priv() check rules out the -ENODEV cases. However,
> can_rx_register() can still return -ENOMEM:
> 
> 	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
> 	if (!rcv)
> 		return -ENOMEM;
> 
> In that case, does bind() report success even though the socket has no RX
> receiver, no echo receiver, or neither? RX frames would be dropped without
> any error, and isotp TX would wait for echo frames that never arrive.
> 
> A later isotp_release() or isotp_notify() for NETDEV_UNREGISTER would
> only print "receive list entry not found" from can_rx_unregister(). It
> would not crash.
> 
> Other CAN protocols handle this: raw_enable_filters() rolls back on error,
> and bcm_rx_setup() checks err. Should isotp_bind() check these results and
> unwind too? The last patch in this series ("can: protect the receive lists
> with a per-device lock") still leaves both calls unchecked.
> 

