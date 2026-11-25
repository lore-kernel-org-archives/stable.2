Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599057;
	b=WjyeA8FlxBR221Gk6Qj8BpzEvLw6RJYuWQXTe8LbPD8+s5N8Ew9yQGXPBGhBxYn2Bt6r
	 Lq5t4uZQnb9Fd+vioYA78vnQ6sgahsVU9uIkjs7l6ZSIsOcKZmiWBWenqt2+vQQ+gAT3D
	 Nbp/6u2r0pal/0lYEgaFPhdg1hi3RQPcJXNAFuhIhV5HuIZvd8BQGA91AUkaJYkTUOPFb
	 V8MKfRzOdjmeDEkOI4uz87BRx6wYDUunqqH8HDqiGpXuFsMj4V9/DQYULYSuTQ68c0qwu
	 epHTodkcZ7I4oOG1vnwK/BTEa37c2hhB6gpETrGqyVkR71D4JZSKFsG6AdakrotyeBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599057;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jl0V6yNxc4gxj7uSt0gF3h6ymhc/ELAwjcCqcR9MZ0I=;
	b=Q4bE4FoUoxPcuCBvVMeCRs0UqpEjjg2LKJexObLwvpz5nE0SuzUUikiyT3cG8MRFGHQj
	 kJ1iWZBZDhbgYTC3N6kus4Ci9N3PoLB78HGFd+nFcn21f9al17VAVq+AEoK+n3JYhRXoi
	 2svIkkOinAUD3xMzfSG/wCzE8U3yiZK5d3YzQxwfqMRM7Bf+LJNbdcxzG2YAq/wmzX3Fr
	 C97O+pOwPqty5vFAq4B6+IgTz1+OLaW6SlMV7NDB5hxlDFYYGZBqJBAZO6fhjP8LvXFgU
	 mQ2ULLme5a+Xyfw7dzI5IzZfuktKTIePALhLpPavpgTJl8coMbylw8MWwPaFKFzSYsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KVwRH4Gq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=N1Dxvqc2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECA606A31E;
	Wed, 25 Nov 2026 09:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26ECA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KVwRH4Gq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=N1Dxvqc2
ARC-Seal: i=1; a=rsa-sha256; t=1795599033; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dmB+cUGxbN9jjYT1yRDe9wNaUcL6K3RIOtbj/tMe9zppXxB1xfZejDJl5enKsMT1Ca
    VHPgzBOp4dYM8cdsne9+HYGDwxAnAluk9hSUOV+4Aew3RcL+SLVvO6s1JrahHtEC84+Q
    S+3yn2o/E9m75ulW0V9p9OqEOFAw0DKyu3vDKEwKQ2zzOfKNGp1agQj+na2W3JgzS3rd
    naci7nHeQ5njNazWCxKcM5Wg6FrqvhGHbuxuWbBmoDHBgsKaGIUvpftYgODXBS6EKlbp
    ZxMrVEEpaerlckRZZOxe1lbPaU8bftxHH9qYjutUvfmbd7UieF57Tt3h8xSWpnZXx6fe
    B+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795599033;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jl0V6yNxc4gxj7uSt0gF3h6ymhc/ELAwjcCqcR9MZ0I=;
    b=P3FNqtrSFwvr4xcUZMhRWSX/ywqH3kUVIcLeT0e5A34t7iA6NXuxmw6TOr3rvv+sGf
    vXHUn+60Yoa/GhtkjMGqt3LNG+tUWL9lKgmy4L+eAfcQHww09FzVVT+0osKSyKcjyQWu
    CJ7A8Vb+PORpjz6lJ/hxtr1umQdqExrFwiKf3L6y6Ysjt4TGfesgleyHg4iZG70nem+W
    GCv0BFGmaKxeKzo/epIGRYXiYnzjIIdCfkdsJdhfOUdB0jtBE1EcApgaNpySRRvbEHRK
    sC5a8ChXYV2EfXtG25dJ5zP9GBDsphlP0TxD5WaP+T15paqmi0o/cDDZT0btef8yFWlM
    dX4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795599033;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jl0V6yNxc4gxj7uSt0gF3h6ymhc/ELAwjcCqcR9MZ0I=;
    b=KVwRH4Gq0meH3pVdHS34GsfDXzW3qfmNUZGO8PsYwO4wJKWQiLPEo+uLazrKb+fW+L
    KYyTZS6jR/oVog2CWmWSok57uXGMh30H6zzRltkd3Vp4kExUXoJ8Ya7mqjx4trQw4pJU
    juIiZdSzUtit2giYBaNB/QUHLNPNvvAmYIUTrR8X+q13HPBrUtMV1Gt+u1+cIVQNdvJ/
    0+Pv+m5ErQ3QVTQFCLubKRKdFoPLE3PXjeIS3/gDF5UutHDM+OkAXo49XQ97B8Z3OND6
    WACMjOVpmPbykui/c4+wahs81H3XI8Anmt7ewvoN5iBnfUhedCKUbPubdV8iVK3GI8zX
    M/sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795599033;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jl0V6yNxc4gxj7uSt0gF3h6ymhc/ELAwjcCqcR9MZ0I=;
    b=N1Dxvqc2FMf88ov4nAy9aDPy6aJldTv9shK/IKy+QeQ7H/2febuD+dbRzDTCYUTAPa
    0TVHTk7VaH3y3BescvAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AP9UWlWr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 25 Nov 2026 10:30:32 +0100 (CET)
Message-ID: <a8f1344e-4197-414b-9971-d82da8cfeb3b@hartkopp.net>
Date: Wed, 25 Nov 2026 10:30:26 +0100
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
Subject: Re: [PATCH net 07/12] can: isotp: reject socket options while a
 transfer is active
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 u.kleine-koenig@baylibre.com, stable@vger.kernel.org, mailhol@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, jeanmichel.hautbois@yoseli.org
References: <20261124085757.1093632-8-mkl@pengutronix.de>
 <179559711531.3135.15295307789383806315@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179559711531.3135.15295307789383806315@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.11.26 09:58, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says that moving the `ae`/`wait_tx_done`
>    reads after the claim means "all socket options used by…
> - [Medium] The new check in isotp_setsockopt_locked() (net/can/isotp.c,
>    lines 1737-1739) reads so->tx.state and so->rx.state with READ_ONCE()…
> 


Both findings belong to the scenario that has already been discussed
for v6 of this patch:

https://lore.kernel.org/linux-can/8cf5687f-4dd4-42f9-b459-5e192b2bcdd5@hartkopp.net/

> --
> 
> can: isotp: reject socket options while a transfer is active
> 
> This patch makes isotp_setsockopt_locked() return -EAGAIN while
> so->tx.state or so->rx.state is not ISOTP_IDLE, mirroring the check in
> isotp_bind(). It also moves the CAN_ISOTP_EXTEND_ADDR and
> CAN_ISOTP_WAIT_TX_DONE reads in isotp_sendmsg() to after the transfer claim
> and the so->bound recheck.
> 
> Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 0b7db1ead7a90..642fec500af9d 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
>> @@ -1188,6 +1188,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   		goto err_out_drop;
>>   	}
>>   
>> +	/* read the options after the claim of the transfer */
>> +	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
>> +	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
>> +
> 
> [Severity: Medium]
> 
> The commit message says this change means "all socket options used by
> isotp_sendmsg() are covered by this check". Is that accurate?


This requires that the caller removes or moves its own CAN device and
changes the socket options while its own sendmsg() is in progress. At
most the first frame of this sendmsg() is sent with the flags byte of
the new options, and only when the caller has moved the CAN device into
another network namespace and set it up again. See below.

> 
> Later in isotp_sendmsg(), so->ll.tx_flags is still read after the final
> tx.state is published, the timeout is armed and so->rx_lock is dropped:
> 
> net/can/isotp.c:isotp_sendmsg() {
>      ...
> 	WRITE_ONCE(so->tx.state, new_state);
> 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
> 		      HRTIMER_MODE_REL_SOFT);
> 	spin_unlock_bh(&so->rx_lock);
> 
> 	/* send the first or only CAN frame */
> 	cf->flags = so->ll.tx_flags;
>      ...
> }
> 
> After that point the transfer can return to ISOTP_IDLE without sendmsg()
> doing anything. isotp_tx_timeout() can cmpxchg tx.state to IDLE after the
> FC or echo timeout. In WAIT_FIRST_FC, an FC frame that isotp_rcv_fc()
> handles (overflow, unknown status, bad padding) can also set IDLE.
> 
> Suppose NETDEV_UNREGISTER then clears so->bound in isotp_notify(). Then
> isotp_setsockopt_locked() passes both the so->bound check and the new
> tx.state/rx.state check. CAN_ISOTP_LL_OPTS can then memcpy() a new so->ll
> before the cf->flags assignment runs.
> 
> Would the first frame then take its flags byte from the new options, while
> its skb size (old ll.mtu), length and payload come from the old ones?
> 
> can_send() usually fails with -ENETDOWN here. The frame could still go out
> if the device was moved to another netns and brought up again.
> 
> Could cf->flags be set while the frame is built, before tx.state is
> published and the timer is armed?
> 
> [ ... ]
> 
>> @@ -1726,6 +1730,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>>   	if (so->bound)
>>   		return -EISCONN;
>>   
>> +	/* A transmission or reception that outlived a previous binding
>> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
>> +	 * socket options, see isotp_bind().
>> +	 */
>> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
>> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
>> +		return -EAGAIN;
>> +
> 
> [Severity: Medium]
> 
> This check runs under conf_lock only, without so->rx_lock. Can it race with
> RX paths that have already set rx.state to ISOTP_IDLE but are still reading
> the socket options?


This is the case of a frame in flight that has already been described
in the referenced mail: when the caller moves its own CAN device into
another network namespace and concurrently changes the socket options
and binds the socket, a single, possibly inconsistent, flow control
frame can be sent on the caller's own target CAN device, or the padding
check for the caller's own reception can use the new options. There is
no memory corruption, as alloc_skb() takes the buffer for these small
sizes from skb_small_head_cache, which is larger than CANFD_MTU, so
skb_put_zero() with the new so->ll.mtu stays within the buffer.

> 
> For example, isotp_rcv_ff() sets IDLE on entry. On the overflow path it
> then calls isotp_send_fc():
> 
> net/can/isotp.c:isotp_rcv_ff() {
>      ...
> 	hrtimer_cancel(&so->rxtimer);
> 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
>      ...
> 	if (so->rx.len > so->rx.buflen) {
> 		/* send FC frame with overflow status */
> 		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
> 		return 1;
> 	}
>      ...
> }
> 
> isotp_send_fc() reads so->ll.mtu twice:
> 
> net/can/isotp.c:isotp_send_fc() {
>      ...
> 	nskb = alloc_skb(so->ll.mtu, gfp_any());
>      ...
> 	skb_put_zero(nskb, so->ll.mtu);
>      ...
> }
> 
> It also reads so->opt, so->rxfc and so->ll.tx_flags.
> 
> There are similar cases:
> 
> - isotp_rcv_cf() sets IDLE before check_pad() uses so->opt.
> - isotp_rcv_sf() sets IDLE and then reads so->opt.
> - isotp_rcv() reads so->opt.flags, so->ll.mtu and so->opt.rx_ext_address
>    before it takes spin_lock(&so->rx_lock) at all.
> 
> isotp_notify(NETDEV_UNREGISTER) calls can_rx_unregister() and clears
> so->bound without waiting for a grace period. The comment in
> isotp_release() already says this happens "without waiting for in-flight
> isotp_rcv() callers to finish".
> 
> Frames can still arrive in that window. For example, vxcan_xmit() delivers
> to the peer via netif_rx() without checking IFF_UP, and can_rcv() does not
> check it either.
> 
> So setsockopt() could see bound == 0 with both states IDLE, and overwrite
> so->opt, so->ll, so->rxfc or so->tx.ll_dl while isotp_rcv() on another CPU
> is still using them. Couldn't that produce an FC frame built from mixed
> option sets (alloc_skb() with the old ll.mtu, skb_put_zero() with the new
> one), or run padding checks against the wrong options?
> 
> Would either of these close the window?
> 
> - Do the state check and the option update under
>    spin_lock_bh(&so->rx_lock), and move isotp_rcv()'s pre-lock option reads
>    under that lock.
> - Wait for a grace period after the unregister.


The caller only harms itself: other sockets and other users are not
affected. At most, a single frame with partly updated options is sent
on the caller's own CAN device.

The regular sequence for a CAN_ISOTP socket is setsockopt() -> bind() ->
sendmsg()/recvmsg() -> close(). When the bound CAN device vanishes, the
application gets an ENODEV error and either closes the socket or binds
it again, optionally after setting new socket options. While a transfer
is still pending, this returns -EAGAIN until the transfer has ended. To
reach the described windows, the caller has to move or remove the CAN
device itself and fire setsockopt() and bind() at its own socket without
waiting for this error. This is a pointless misuse of the socket API
without any gain for the caller.

Covering these windows would need so->rx_lock in setsockopt() and for
all option reads in isotp_rcv() for every received CAN frame, or a
grace period in the netdev notifier, which runs under RTNL and would
bring back the kind of RTNL stall that this series removes. Both add
complexity and cost for every regular user without any benefit.
Therefore the code is not changed for these scenarios.

Best regards,
Oliver

