Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795075480;
	b=sp0NdQs0QfHfWFJQSSgIAxhSWp7lz81219YrgbI66uhoMWsLhNsdDRdlH9jBhC4bnPVt
	 R6rtUDOIZo7Vwz1Zca7mZsLL+BW/zewGG3OE8rb7A6KD60UXYuQhLj61vYP5rZj9lP1g/
	 EbLH2cTwUtDbrxHdwcoSGxqkfo3GWu3nZ7Q8MHmkwZqbZFFqhMUgTmkwMa6UGMyMKj1Iu
	 omI0Ve4LzE3f/zZiCtGJUuD3n2TEE5+EamXuCw93ODJE1LQGFuLuGY4CQiU7iJfOMuQ+q
	 0ies2YcDgiL/d9SC77Bo3v8l2XQ5xZXtNifHzovr31cdj9UdQZrpoP/b2rTzUJ952NA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075480;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Nch3ULFgsDznWHgkPb7IzLLlcZQIVkKBgNjjIP3Hws=;
	b=nOgXkPRavp4zrA/nML+KsAmBBUy1gElozeKlRqTZjVjNMRquTuj0aWHDKba5kGPGr6pD
	 udHJTTjrmBBI/YdMgjiWtFFQEqMBwEJ7f5NR/lI6pJ/lZrTp29wnTBxEFahK4xRa/q5bu
	 iqwOH0ksi8yUHuj8L7crZZmvm2iZI1cW0hGv6B5we8XSeVdEldwz+ueHXLc9MaiQVdTU/
	 Rtlw8AciQ7/Nx/skmAYGVdjSFVUk/Mbo67d+NyybJ+DSJs+flprKkryANVaHzPP93JzzB
	 1iGIE3pdEP5ZAnyV7sDaPUr4J0GH0Mydzr5nk7gQAgpxgfb4EsTOGBm3gxaKt7cPrEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BTIBfShj;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HZDURsOU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC2606A320;
	Thu, 19 Nov 2026 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AC2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BTIBfShj;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HZDURsOU
ARC-Seal: i=1; a=rsa-sha256; t=1795075465; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GzOZD9WBjAOV9mJFybAP+UmUh8LJi0NoP3fsbgx+yApyTXN5tirLaWInqiK7NNNxJl
    WUgbvoMWAkewlHHRqUFp9/a6uKgvF/XoxRfSvE5iJFXHbRUGYWHqY2RPkBfkm2AkOxWM
    TApHbV0BWKPMwfnrzRXaPJxeQACFvDl7C/dPRgvKXSEVuYFkImU3IXnGUClLRe+XHzTr
    eUb0Hz5BqP/c4csh2KQYhyZSU29fq3hrBS6SJgJtFsNQO+u4bTNQ5Bzt+hUiK0pFRTag
    Or2Ld2b10RyyRD+vCVBeuhAY0Ub5WVkTnctRDMnCzej/lQRH2lVyFq922Z1gUuwhReB4
    xw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795075465;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Nch3ULFgsDznWHgkPb7IzLLlcZQIVkKBgNjjIP3Hws=;
    b=X95lned6lXfZGQRrvNQEE6kSGomet8PyNdeSLu9p4XvEes/eO9mH1f0ubXlqyNqaXC
    7iP4idEmD9Sm4MKpdq/5WBHk0IpQ4zffz87NfNuTzNW8MvAr+iS7rEGYJWpBtjyqjmH9
    PiTMSZr7IF9Xjqyz0dfGvy2zytujRWSQfGd+TlkvLwalKFWBcGI3aPJifsxM8PA7Kkv4
    xUvO53M4sFbVqKu0F0vtvrS3HiIh3wsMKjlme4xXXZaVdeH1Y4TJ0UFoxXbEf/OZC0VH
    dh1ZbbJOZUyqOvPRoWvKzkMTOcJkkr2u6McYG4XuVZhUkWrNqH2nOuwIi8J4DOwGi0kc
    KVZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795075465;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Nch3ULFgsDznWHgkPb7IzLLlcZQIVkKBgNjjIP3Hws=;
    b=BTIBfShj8LWBNVonJ6nZsoxwsuXpzQ3x7JgRyb/6eGClvFanAtNzUB8w+obG03WHTZ
    yZcrSCEBjRUiyPyo8KgIaEG44ErHGOquAxEa8ZhThyZvSYi4PckbtPzLHWT4t3zGt3qq
    RTDXE/KEzPvbfUHlboLJp/FJPSmmJSuyZXOubnNbugHpzNynPWyvwf4WG5y3uz+Jp5X3
    zGgwlhGyX3VcEJ4EBtHd433WCU4JKANwZIqFRj8Tfio9jB2mCPzN4DNIl2bu3GrSVCVb
    2cTYKyWh27HKFVnNNWCuhi2Y3ZZYFUzF9Nhe3FXXwNF9EGlweEPl1iw20idHLJjRmuzW
    hxZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795075465;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Nch3ULFgsDznWHgkPb7IzLLlcZQIVkKBgNjjIP3Hws=;
    b=HZDURsOUqQoA7JQERb71EfEkOvfd2ajFCEGhfrq87p2jPp0Ei/bmUl6SyWGVAsJB/K
    nlDQy2BYFqA3Cc7IP5CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJ84OJrm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 09:04:24 +0100 (CET)
Message-ID: <8cf5687f-4dd4-42f9-b459-5e192b2bcdd5@hartkopp.net>
Date: Thu, 19 Nov 2026 09:04:24 +0100
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
Subject: Re: [PATCH net 07/11] can: isotp: reject socket options while a
 transfer is active
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de
References: <20261117220818.1142581-8-mkl@pengutronix.de>
 <179504036031.3136.7813193141510099541@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179504036031.3136.7813193141510099541@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

In general, a CAN_ISOTP socket whose bound CAN device has been removed
or moved to another network namespace is unbound by isotp_notify() and
reports ENODEV. A regular application sets the socket options once
before bind() and closes the socket in this case. The scenarios with a
concurrent setsockopt() and bind() on such a socket can only be created
on purpose. They do not lead to memory corruption and affect at most
the socket of the attacker and a single, possibly inconsistent, flow
control frame on the attacker's own target CAN device.

On 18.11.26 23:19, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new -EAGAIN check in isotp_setsockopt_locked()
>    (net/can/isotp.c:1732-1734) assumes, as the commit message says, that…
> - [Medium] isotp_sendmsg() reads so->opt.flags into 'ae'
>    (CAN_ISOTP_EXTEND_ADDR) and 'wait_tx_done' (CAN_ISOTP_WAIT_TX_DONE) at…
> 
> --
> 
> can: isotp: reject socket options while a transfer is active
> 
> This commit adds a check to isotp_setsockopt_locked() that returns -EAGAIN
> while so->tx.state or so->rx.state is not ISOTP_IDLE. This matches the check
> already done in isotp_bind(). The goal is to stop a concurrent setsockopt()
> from changing so->opt, so->ll and so->tx.ll_dl while isotp_sendmsg() is
> still building frames after the device was unregistered.
> 
> Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 0293d590186c4..32c88749d75e7 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
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
> 
> [Severity: High]
> 
> The commit message says:
> 
>    "As the transmission and the reception always end by their timeouts at
>    the latest, this state is only temporary."
> 
> Is this true for the rx side?

This is the same finding as for "can: isotp: always start the rx timeout
in ISOTP_WAIT_DATA state". I will send a separate patch that moves the
length checks in isotp_rcv_cf() in front of hrtimer_cancel(), so that
the rx state can not remain in ISOTP_WAIT_DATA without a running rx
timeout. With this patch the statement in the commit message holds for
the rx side as well.

> 
> In isotp_rcv_cf(), the rx watchdog is cancelled before the length checks.
> Two of the early exits that follow return without resetting so->rx.state
> and without re-arming so->rxtimer:
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
> This leaves the socket in ISOTP_WAIT_DATA with no timer armed, so
> isotp_rx_timer_handler() never runs to set it back to ISOTP_IDLE. While
> the socket is bound, the next SF or FF fixes the state through
> isotp_rcv_sf() or isotp_rcv_ff().
> 
> On NETDEV_UNREGISTER, isotp_notify() unregisters the isotp_rcv filter and
> clears so->bound, but it does not touch so->rx.state:
> 
> 	so->ifindex = 0;
> 	WRITE_ONCE(so->bound, 0);
> 	WRITE_ONCE(so->dev, NULL);
> 
> After that, only isotp_release() can bring rx.state back to IDLE.
> 
> One possible sequence:
> 
>    1) a node on the bus sends a valid FF; isotp_rcv_ff() sets WAIT_DATA
>       and arms rxtimer
>    2) the same sender sends a malformed CF (classic CAN: a 3 byte CF
>       while more than 7 bytes are still missing; CAN FD: an FF with len 8
>       followed by a 12 byte CF)
>    3) isotp_rcv_cf() cancels rxtimer and returns early, still in WAIT_DATA
>    4) the CAN device is unregistered (USB unplug, vcan/vxcan deletion,
>       netns teardown)
> 
> Would every later setsockopt() on this socket then return -EAGAIN until
> the socket is closed?
> 
> The matching check in isotp_bind() would also keep returning -EAGAIN. The
> socket could then be neither reconfigured nor rebound.
> 
> An earlier commit in this series, "can: isotp: always start the rx timeout
> in ISOTP_WAIT_DATA state", seems meant to close this class of stuck
> states. It only adds hrtimer_start() on the success paths of
> isotp_rcv_ff() and isotp_rcv_cf(), and these two early exits are not
> covered.
> 
> The isotp_bind() comment that this check points to makes the same
> assumption:
> 
> 	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
> 	 * and RX watchdog timers bound how long this takes. Checked together
> 
> Could these exits re-arm rxtimer or reset rx.state to ISOTP_IDLE? Another
> option would be for isotp_notify() to cancel rxtimer and reset rx.state on
> NETDEV_UNREGISTER.
> 
> [Severity: Medium]
> 
> Does this check fully cover isotp_sendmsg()? The locals derived from the
> options are computed at function entry, before so->tx.state is claimed:
> 
> net/can/isotp.c:isotp_sendmsg() {
>      ...
> 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
> 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
>      ...
> 	/* so->bound is only checked once above - a wakeup may have
> 	 * unbound/rebound the socket meanwhile => recheck
> 	 */
> 	if (!READ_ONCE(so->bound)) {
>      ...
> }
> 
> The new check only rejects setsockopt() once tx.state != ISOTP_IDLE, so
> the window between function entry and the claim is not covered.
> 
> Here is how that could play out. isotp_sendmsg() is waiting in the claim
> loop (or is preempted) when the device is unregistered. Then
> setsockopt(CAN_ISOTP_OPTS) toggles CAN_ISOTP_EXTEND_ADDR or
> CAN_ISOTP_WAIT_TX_DONE, and bind() succeeds. In that case the bound
> recheck above passes.
> 
> The SF/FF size checks, isotp_fill_dataframe() and isotp_create_fframe()
> would then use the stale ae with the new so->tx.ll_dl and
> so->opt.ext_address. Meanwhile isotp_send_cframe() recomputes ae from the
> new flags:
> 
> 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
> 
> Could the FF and its CFs then use different extended addressing layouts
> within one PDU? And would the WAIT_TX_DONE blocking for that sendmsg()
> call still follow the old options?

The observation is correct, but it does not add a new kind of problem.
It requires a concurrent setsockopt() and bind() on a socket whose CAN
device vanished, while another thread waits in isotp_sendmsg(). As you
already noted, there is no out-of-bounds access, and the result is at
most one PDU with an inconsistent extended addressing on the attacker's
own CAN device, which is the same class of effect as for a frame in
flight described above.

Reading ae and wait_tx_done after the claim and the so->bound recheck
would be a cleanup, which I will consider for can-next.

Best regards,
Oliver

> 
> This does not look like an out-of-bounds access. The indices stay bounded
> by so->tx.ll_dl, and the skb is sized from so->ll.mtu, which is read after
> the claim. It does not quite match the commit message's statement that
> "the socket options can only be changed when no transfer is active".
> 
> Would moving the ae and wait_tx_done computation after the claim, next to
> the bound recheck, close this window?
> 
>> +
>>   	switch (optname) {
>>   	case CAN_ISOTP_OPTS:
>>   		memcpy(&so->opt, val, sizeof(so->opt));
> 

