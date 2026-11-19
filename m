Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795074825;
	b=vild4og33SdlBRsqFvAmI8E8Ut9g43DovK/C54BykRM+FMVSfNoco70Aofmb09ilYH/d
	 PQGX1yaegV1CxIVs9WDp+6tEZPEo27UB9flI5Ps5nn4nfKFo9vWKIAC1GEMzzrODiCRHV
	 uYF1jrqR6yO9oJ2bU/yFhb6PFrqg6+A1u7pII856bgeyZhySjtTixR6B5P+qPEwJkBwil
	 /ZVpzwIEMA7BMNC2tiMRGIUEUCztEQkypeQlMlVfTYHhey1kgzNG9oFw0soMlI945KIw2
	 bvYlKokh2a4dzfP7F0iBU6ybjyBWwxIhtDb8dj4eULA4wYXGhG8vIPpAeNzegCaZzDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074825;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ikdrQBcV7fEi8twDu7AZzbCA1Ao/qDNxXhbwpnyhkE4=;
	b=sebIiGsQku1j5Re3wDyfdIfq9Z/jEN6aty9VCt/Y6u1zuY7LH+2QPme4cyAIJpT7vJsJ
	 C804EE4AMtCOuAjsgTEaDmlWWRAe0o1bSH7jrp0OrBWNLms7VIPkkoVL9aFygJWaztMeD
	 /OXduqDGV/2X6o8DedqwxMjDxcvzKERYcY69fFSMirpsaBntpiEAqMF/+0orjRu4gZ2m1
	 +lvemihbbBmelOjILBZQxHrlrusVc+idHAhnzsdx5nbf83leH97tkPycXT85jI/hicxEV
	 5rRqlBw+lC/mcxeiHJ2tgRmBeFacbov1qBUDmQMGhlFivSMvnINg/yJGtp3K2b5+9eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qLa2PyfA;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=N4TTc3wF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB384606A320;
	Thu, 19 Nov 2026 07:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB384606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qLa2PyfA;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=N4TTc3wF
ARC-Seal: i=1; a=rsa-sha256; t=1795074809; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sprPs1bx9BFHCGsiy4CkFxbmy1E6iIRwon6d7bLN27FKH3gBTm/9fkvuVObc0e0tm+
    MkFY4QjvbhsIw7v+nlt0V4P3hoAzW4Ow5RUuZ0oHB1KQvKsnb8c00NftE5O2o6NC9RZh
    u9m9R8i3U8e/Yrl2TdD9anCRB0kr1dJzD/bNmLUEmkHkKBSOEc9dE4BHZaEOtp27M3n5
    Ua135HJAEJq69nTZNPYLXbdO8Rdhq6fDt/azqCKnNhIlmVvsmgOKaiHbLi0Ke+2kLG7G
    J7UrqXqKY2psEywXXPwidF/D+d33wcgBLSIj47OAMYXfM15/QmHMLT6zKjJhhwMkDVoR
    VuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795074809;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ikdrQBcV7fEi8twDu7AZzbCA1Ao/qDNxXhbwpnyhkE4=;
    b=BiE8uez7J/WC7mMWAQDIWPWG/vkj8xnLpnmJKzT8Me23ItjBFE8IlPHvs/2gL/dxLs
    xfGV4vnB+pprWsks5U1XqPpNvD+iORISxr+rsYI3R9Qz1hgIiVfrkzBkiJNvT2Y5AIEf
    W5wmYtEkPyL3rD4qCd5jZ9t7Fy/NXhDLSbY2T+Dm4fnZ6qkauxfsd49ltSyAkf83TeZq
    KQmToQGVAkyTgwACVSt3PmmpTUjRbr/feLl8XL9EIgpLjDEEIUrjRP5RrLmvzEEnP/n7
    PhSAJjhikOjylXgOVcKpsPLOiMsa7B7pRKxkpDetuUH9KV8JRGNj/k1rgvNS3abUy52W
    AxqA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795074809;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ikdrQBcV7fEi8twDu7AZzbCA1Ao/qDNxXhbwpnyhkE4=;
    b=qLa2PyfAvClUxs33ckzQ3kweH4f0x05OEFSNlOfMAnr8bWAou8ax72auueWC6+Ui/I
    rMgMdSoc4b98aAAX9qsmsvyAcKcsHKhwoQP/NfBmSNQBoNZigsJolZMzA+tf8q/h2p5C
    Ogt6QieLGzEV/YFa0rpxNyIwv+SXpf7KYQqfXj6PVVnNkn0tHtj4nsAFQ2PXnlxThJMW
    gpDdP/jWsMQwZKNxbhXjwgyn1Liq2rRuseM7quNO86ZI/cAq8EAzdEV/0UMlMZYgtgqV
    O2k9WCJjm9c0uTxyW7amwgoxZDXkd2S2U6gXxkHMczqbJ+sSOst9Hw2s3ypNDKW0cTy2
    SAnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795074809;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ikdrQBcV7fEi8twDu7AZzbCA1Ao/qDNxXhbwpnyhkE4=;
    b=N4TTc3wFSs3x5Wo0uMrR1cAX9fWbo0uzaaquPT3tjxWbO+2Dm2Ivr8kwjdXQyaOfAp
    TxWjcvp5RQAJskMqbECw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJ7rTJo4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 08:53:29 +0100 (CET)
Message-ID: <ef111405-f753-4a99-b56f-881aaa177339@hartkopp.net>
Date: Thu, 19 Nov 2026 08:53:24 +0100
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
Subject: Re: [PATCH net 06/11] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de
References: <20261117220818.1142581-7-mkl@pengutronix.de>
 <179504035916.3136.12986898667697830880@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179504035916.3136.12986898667697830880@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.11.26 23:19, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete.
> 
> --
> 
> can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
> 
> This patch starts the rx timeout in isotp_rcv_ff() and isotp_rcv_cf()
> whenever reception continues in ISOTP_WAIT_DATA state. Previously the
> timeout could be missing when isotp_send_fc() failed, in listen mode, or
> at the end of a block. Without it, a socket whose CAN device was removed
> could stay in ISOTP_WAIT_DATA, and isotp_bind() would keep returning
> -EAGAIN.
> 
> Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 8229b6a69ecd0..0293d590186c4 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -726,13 +730,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
>>   		return 0;
>>   	}
>>   
>> +	/* start rx timeout, isotp_send_fc() restarts it */
>> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
>> +		      HRTIMER_MODE_REL_SOFT);
>> +
> 
> [Severity: High]
> Does isotp_rcv_cf() still have paths that leave so->rx.state in
> ISOTP_WAIT_DATA with no rx timer armed?

Yes. This is a valid finding.

The two length checks for invalid consecutive frames in isotp_rcv_cf()
return after hrtimer_cancel(), so so->rx.state stays in ISOTP_WAIT_DATA
without a running rx timeout. This already happens without this patch.
It is not limited to an attack, as the invalid consecutive frame can be
sent by any node on the bus and the CAN device can be removed by an
unplug of a USB adapter.

This patch starts the rx timeout in the cases where no flow control
frame is sent, i.e. when isotp_send_fc() fails or in listen mode, and
is correct for these cases. To also cover invalid consecutive frames
I will send a separate patch, which moves the length checks in front
of hrtimer_cancel(), as suggested. Then an invalid consecutive frame
does not touch the rx timeout and every return after hrtimer_cancel()
either ends the reception or restarts the rx timeout.

Best regards,
Oliver

> 
> Earlier in isotp_rcv_cf(), the timer is cancelled unconditionally. Two
> length checks after that cancel return before this new hrtimer_start()
> is reached:
> 
> net/can/isotp.c:isotp_rcv_cf() {
>      ...
> 	hrtimer_cancel(&so->rxtimer);
>      ...
> 	/* CFs are never longer than the FF */
> 	if (cf->len > so->rx.ll_dl)
> 		return 1;
> 
> 	/* CFs have usually the LL_DL length */
> 	if (cf->len < so->rx.ll_dl) {
> 		/* this is only allowed for the last CF */
> 		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
> 			return 1;
> 	}
>      ...
> }
> 
> Neither path restarts the timer or sets rx.state to ISOTP_IDLE.
> 
> Both paths look reachable from the bus, because isotp_rcv() only checks
> skb->len against so->ll.mtu and never checks cf->len:
> 
> - On a CAN CC socket, padlen() gives rx.ll_dl = 8 for the first frame.
>    A following CF with len < 8, sent while more than 7 bytes are still
>    outstanding, takes the second return.
> 
> - On a CAN FD socket, a first frame with len 8 (ll_dl = 8) followed by
>    a CF with len 12..64 takes the first return.
> 
> The frames could come from any remote node, or from a local CAN_RAW
> socket on vcan.
> 
> Suppose such a malformed CF is the last frame before NETDEV_UNREGISTER.
> isotp_notify() does not reset rx.state, and isotp_rx_timer_handler() is
> not armed. So isotp_bind() would still return -EAGAIN until the socket
> is closed:
> 
> net/can/isotp.c:isotp_bind() {
>      ...
> 	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
> 	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
> 		err = -EAGAIN;
> 		goto out;
> 	}
>      ...
> }
> 
> This is the failure the commit message says it removes.
> 
> The later patch in this series, "can: isotp: reject socket options while
> a transfer is active", adds the same rx.state != ISOTP_IDLE -> -EAGAIN
> check to isotp_setsockopt_locked(). So setsockopt() would be blocked in
> the same stuck state.
> 
> There is also a case before the device is removed. In
> CAN_ISOTP_HALF_DUPLEX mode, isotp_rcv() drops every incoming FC frame
> while rx.state is not ISOTP_IDLE. That lasts until the next FF or SF
> arrives.
> 
> Could these two returns also re-arm the rx timer (or set ISOTP_IDLE)? An
> alternative would be to restructure the function so that every return
> after hrtimer_cancel() that keeps ISOTP_WAIT_DATA re-arms the timer.
> 
>>   	/* perform blocksize handling, if enabled */
>> -	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
>> -		/* start rx timeout watchdog */
>> -		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
>> -			      HRTIMER_MODE_REL_SOFT);
>> +	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
>>   		return 0;
>> -	}
> 
> [ ... ]
> 

