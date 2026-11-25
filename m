Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597116;
	b=RuhRhxlDy8unRDGdD+aoG9OQcjt+SaTIsoeTYCFnWAdARyl+G+kJnCQ6gVg/bx1XHoVI
	 EmREIusSAfEHrOkc51EGKzQLcnvbr68tMglDg2pqZEi8979peJognfKA/sDDy3y2XAMTX
	 nAQTbdyB5RUjUQ8br4igG/6HD7a1ql+erTqF8hPHcfj/BLSTa+j6cO9oRAPjAo+oow2yZ
	 hq50C1etQEEQGSO8JajIctwpbJJoKZgKUdsKOY4chB4qz3Ormr+Yt7Cs10OryijHW1d9K
	 Ze23duyKUBtiIgMMH3vDGVpubUOCfvmsLBANsOf/FlW30WWhd77LehhN3qITZBi+xwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597116;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SmlnObTyvLLWex2fHr/9/apQ6tGYW8v7LEnW15NaoWc=;
	b=n/TcIZzBdjkM4ZUwkgAh0Nc6nS25YDbCXIc4Er6+ZHb0MbaTw4qNZIqCJ+J5E9/EsHJT
	 2vrdyQRhMA+GhGkUmyl4m0d83sTGFbI7zs/48sZnHCbQwqzVNv0cRne8k68N+rf2tgxWG
	 OHB5mxXatkh6MPCD0i9ll8sUeY/GlmjON3B3OekIDHBv7ZcDK9iCIitz4VLVWE1VRl9vj
	 j2efDXdhIfe4MEcSQVl2OLnhsbmKRb5dJQjSlCHBgiExCbrRe2zBQs2CnDmQT9FeBr84y
	 NSAZ7ZADMhrOLJ8JTDJ+1sGWooeQ8/mBMOrHsBbHkayZ/bp+bvDTU3hu9VpeaIuLzXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GF2jJNlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB24606A68D;
	Wed, 25 Nov 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GF2jJNlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACAF1F000EC;
	Wed, 25 Nov 2026 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597116;
	bh=SmlnObTyvLLWex2fHr/9/apQ6tGYW8v7LEnW15NaoWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GF2jJNlWPjiai7ydXLSS09EXB3h/ov1GxwtX0gIt+Uo2+bI/zN4iYVDqU6VaKVW9S
	 LPbQT7LSzoP8YhwPc6ezH8qFY6rZf8DtMzZFwvm+peI8Qf3G1e2PnCo/hfZUS+zI+z
	 AOkZc1LBzrh6L0S/S5ml7nLcmEC2vImn9A73uHEiRmqVazeXSoUyJ9oXgvHvTSoHi5
	 uF3uWr6h7aPpHfgbTYsY2K3iYow8fo0pDHyLfjQSkqZFPmH6NXUHCYkWHo88NPDqC6
	 2ZGuATJNtnM2Gt+ZFV7RkTOgi28+p/lBWqcdJ1VR1FfJXnZ5r8uuIFXHVNN6f/6nPz
	 TfDrzTX0PUSzg==
Subject: Re: [PATCH net 07/12] can: isotp: reject socket options while a
 transfer is active
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 u.kleine-koenig@baylibre.com, stable@vger.kernel.org, mailhol@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, jeanmichel.hautbois@yoseli.org
Date: Wed, 25 Nov 2026 08:58:35 +0000
Message-ID: <179559711531.3135.15295307789383806315@kernel.org>
In-Reply-To: <20261124085757.1093632-8-mkl@pengutronix.de>
References: <20261124085757.1093632-8-mkl@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that moving the `ae`/`wait_tx_done`
  reads after the claim means "all socket options used by…
- [Medium] The new check in isotp_setsockopt_locked() (net/can/isotp.c,
  lines 1737-1739) reads so->tx.state and so->rx.state with READ_ONCE()…

--

can: isotp: reject socket options while a transfer is active

This patch makes isotp_setsockopt_locked() return -EAGAIN while
so->tx.state or so->rx.state is not ISOTP_IDLE, mirroring the check in
isotp_bind(). It also moves the CAN_ISOTP_EXTEND_ADDR and
CAN_ISOTP_WAIT_TX_DONE reads in isotp_sendmsg() to after the transfer claim
and the so->bound recheck.

Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0b7db1ead7a90..642fec500af9d 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1188,6 +1188,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  		goto err_out_drop;
>  	}
>  
> +	/* read the options after the claim of the transfer */
> +	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
> +	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
> +

[Severity: Medium]

The commit message says this change means "all socket options used by
isotp_sendmsg() are covered by this check". Is that accurate?

Later in isotp_sendmsg(), so->ll.tx_flags is still read after the final
tx.state is published, the timeout is armed and so->rx_lock is dropped:

net/can/isotp.c:isotp_sendmsg() {
    ...
	WRITE_ONCE(so->tx.state, new_state);
	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
		      HRTIMER_MODE_REL_SOFT);
	spin_unlock_bh(&so->rx_lock);

	/* send the first or only CAN frame */
	cf->flags = so->ll.tx_flags;
    ...
}

After that point the transfer can return to ISOTP_IDLE without sendmsg()
doing anything. isotp_tx_timeout() can cmpxchg tx.state to IDLE after the
FC or echo timeout. In WAIT_FIRST_FC, an FC frame that isotp_rcv_fc()
handles (overflow, unknown status, bad padding) can also set IDLE.

Suppose NETDEV_UNREGISTER then clears so->bound in isotp_notify(). Then
isotp_setsockopt_locked() passes both the so->bound check and the new
tx.state/rx.state check. CAN_ISOTP_LL_OPTS can then memcpy() a new so->ll
before the cf->flags assignment runs.

Would the first frame then take its flags byte from the new options, while
its skb size (old ll.mtu), length and payload come from the old ones?

can_send() usually fails with -ENETDOWN here. The frame could still go out
if the device was moved to another netns and brought up again.

Could cf->flags be set while the frame is built, before tx.state is
published and the timer is armed?

[ ... ]

> @@ -1726,6 +1730,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  	if (so->bound)
>  		return -EISCONN;
>  
> +	/* A transmission or reception that outlived a previous binding
> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
> +	 * socket options, see isotp_bind().
> +	 */
> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
> +		return -EAGAIN;
> +

[Severity: Medium]

This check runs under conf_lock only, without so->rx_lock. Can it race with
RX paths that have already set rx.state to ISOTP_IDLE but are still reading
the socket options?

For example, isotp_rcv_ff() sets IDLE on entry. On the overflow path it
then calls isotp_send_fc():

net/can/isotp.c:isotp_rcv_ff() {
    ...
	hrtimer_cancel(&so->rxtimer);
	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
    ...
	if (so->rx.len > so->rx.buflen) {
		/* send FC frame with overflow status */
		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
		return 1;
	}
    ...
}

isotp_send_fc() reads so->ll.mtu twice:

net/can/isotp.c:isotp_send_fc() {
    ...
	nskb = alloc_skb(so->ll.mtu, gfp_any());
    ...
	skb_put_zero(nskb, so->ll.mtu);
    ...
}

It also reads so->opt, so->rxfc and so->ll.tx_flags.

There are similar cases:

- isotp_rcv_cf() sets IDLE before check_pad() uses so->opt.
- isotp_rcv_sf() sets IDLE and then reads so->opt.
- isotp_rcv() reads so->opt.flags, so->ll.mtu and so->opt.rx_ext_address
  before it takes spin_lock(&so->rx_lock) at all.

isotp_notify(NETDEV_UNREGISTER) calls can_rx_unregister() and clears
so->bound without waiting for a grace period. The comment in
isotp_release() already says this happens "without waiting for in-flight
isotp_rcv() callers to finish".

Frames can still arrive in that window. For example, vxcan_xmit() delivers
to the peer via netif_rx() without checking IFF_UP, and can_rcv() does not
check it either.

So setsockopt() could see bound == 0 with both states IDLE, and overwrite
so->opt, so->ll, so->rxfc or so->tx.ll_dl while isotp_rcv() on another CPU
is still using them. Couldn't that produce an FC frame built from mixed
option sets (alloc_skb() with the old ll.mtu, skb_put_zero() with the new
one), or run padding checks against the wrong options?

Would either of these close the window?

- Do the state check and the option update under
  spin_lock_bh(&so->rx_lock), and move isotp_rcv()'s pre-lock option reads
  under that lock.
- Wait for a grace period after the unregister.

If so, the commit message claim that "the socket options can only be
changed when no transfer is active" would also hold on the RX side.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124085757.1093632-2-mkl%40pengutronix.de
