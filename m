Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040360;
	b=V986Ees7ncPxUw9Js+4X+6oACz5cslM7ehy3PyRS+Ic/aBR/rX8gqC6tIWFAgeOTp3bd
	 i1U2wweTtDSOyBve7vCK8AI3tB9dl0IBfp5jBBW43XGJMpJS9XxhpxdcdphkQ2z0k1Z29
	 Z2W/YKcGQf+hfV+ob1f5obiednh42M1yE89B6QKiuDodH1gaTR05Ol4DrUK1IzL6QGR9l
	 610cmh4SpdD4xwPmt8gpPxGiv3fuUsmv1BBxqeYa5Cxc2hOuCqC5pYCExp/ioTdSvKaMK
	 bMFnvtjfiray1MdiYLW/B3+45XIsX7jK8kAS7wOXDMX1g+xLgWQ4TNzvajXLBjus6Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040360;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sPuA6klLt6ipgQRC8lOszhMzi1m+N/35iXaLAzIOmDI=;
	b=rRmICTZj4iQjL4g4IZBY0ZM65Vs3RxOyspHvoP3BakQv6oL5cLQxdaG2lxc7evCxoTBw
	 UDMbklNFGnrotB1JR+XtpI/QXvudDMH6sc/vSy+WWbW0Mb8lT+8raoIR5BxKS8mPr5Yl1
	 jNnNDvvFGkQBDJ+J5bTlunGpM6zu+6pgMRh0o/pAaZQG98ylwspS1r9NUpGkYVryP/uFg
	 g2DoB0pHJr/SIRPZrnQsiwNWi/qksYOjp3004oEtazLxkBdS3Ny8RJLfzCEeYI1dnBHvu
	 PcXqoKlOBVfGfb80hnDiFQV9mYKDEuQ79pTwFNIiF2yKmOF6GmDR9cogZ0X9Rc75ZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm1CbH3u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C102606A31C;
	Wed, 18 Nov 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm1CbH3u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961CE1F000C4;
	Wed, 18 Nov 2026 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795040360;
	bh=sPuA6klLt6ipgQRC8lOszhMzi1m+N/35iXaLAzIOmDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fm1CbH3uAby8Net5mrmNaqxSG4nHXdc3BOthS1xFwFsrvTbExuhiBF44wJw2dSPkB
	 d+bymk5/TGFSTNnj+vunBHTyqaIrMBOUHVAUYIkpR1IGKGHfFUlw3xo+JMGaaAwBFs
	 fZh8SN8p4eeZ10NfDI/ITr7fXQMS/kMMBE7l9LCBWoSG6ur8SVPaqt9GeCf0dmIeCH
	 tVCkcp0vNf+F9IgF83u7eESHFxkClc7GB29JCgPDYQLv6dtkU9IXJ41ONt1Qnbc5vo
	 Hk/IRA1Ssj27BPSul/YwMQZNtBINeR5h7QVivROmEeCbXH8eGtHmyOhRUHPGl+5e1r
	 UeBJB796uyvww==
Subject: Re: [PATCH net 06/11] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, socketcan@hartkopp.net, mailhol@kernel.org,
 o.rempel@pengutronix.de
Date: Wed, 18 Nov 2026 22:19:19 +0000
Message-ID: <179504035916.3136.12986898667697830880@kernel.org>
In-Reply-To: <20261117220818.1142581-7-mkl@pengutronix.de>
References: <20261117220818.1142581-7-mkl@pengutronix.de>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state

This patch starts the rx timeout in isotp_rcv_ff() and isotp_rcv_cf()
whenever reception continues in ISOTP_WAIT_DATA state. Previously the
timeout could be missing when isotp_send_fc() failed, in listen mode, or
at the end of a block. Without it, a socket whose CAN device was removed
could stay in ISOTP_WAIT_DATA, and isotp_bind() would keep returning
-EAGAIN.

Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 8229b6a69ecd0..0293d590186c4 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -726,13 +730,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
>  		return 0;
>  	}
>  
> +	/* start rx timeout, isotp_send_fc() restarts it */
> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +		      HRTIMER_MODE_REL_SOFT);
> +

[Severity: High]
Does isotp_rcv_cf() still have paths that leave so->rx.state in
ISOTP_WAIT_DATA with no rx timer armed?

Earlier in isotp_rcv_cf(), the timer is cancelled unconditionally. Two
length checks after that cancel return before this new hrtimer_start()
is reached:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);
    ...
	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

Neither path restarts the timer or sets rx.state to ISOTP_IDLE.

Both paths look reachable from the bus, because isotp_rcv() only checks
skb->len against so->ll.mtu and never checks cf->len:

- On a CAN CC socket, padlen() gives rx.ll_dl = 8 for the first frame.
  A following CF with len < 8, sent while more than 7 bytes are still
  outstanding, takes the second return.

- On a CAN FD socket, a first frame with len 8 (ll_dl = 8) followed by
  a CF with len 12..64 takes the first return.

The frames could come from any remote node, or from a local CAN_RAW
socket on vcan.

Suppose such a malformed CF is the last frame before NETDEV_UNREGISTER.
isotp_notify() does not reset rx.state, and isotp_rx_timer_handler() is
not armed. So isotp_bind() would still return -EAGAIN until the socket
is closed:

net/can/isotp.c:isotp_bind() {
    ...
	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
		err = -EAGAIN;
		goto out;
	}
    ...
}

This is the failure the commit message says it removes.

The later patch in this series, "can: isotp: reject socket options while
a transfer is active", adds the same rx.state != ISOTP_IDLE -> -EAGAIN
check to isotp_setsockopt_locked(). So setsockopt() would be blocked in
the same stuck state.

There is also a case before the device is removed. In
CAN_ISOTP_HALF_DUPLEX mode, isotp_rcv() drops every incoming FC frame
while rx.state is not ISOTP_IDLE. That lasts until the next FF or SF
arrives.

Could these two returns also re-arm the rx timer (or set ISOTP_IDLE)? An
alternative would be to restructure the function so that every return
after hrtimer_cancel() that keeps ISOTP_WAIT_DATA re-arms the timer.

>  	/* perform blocksize handling, if enabled */
> -	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
> -		/* start rx timeout watchdog */
> -		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> -			      HRTIMER_MODE_REL_SOFT);
> +	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
>  		return 0;
> -	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117220818.1142581-2-mkl%40pengutronix.de
