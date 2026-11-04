Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825210;
	b=aTszMjearo/TqxscM611lCIjkrYGZmLX3+7MB8E1mXscssizem7iIBIC2ZB6SNGKo8Mr
	 DqCSfVJnL80ji1aIn1YQhOBqCDo9I4UbOmbUWt2cnIlq++DEYynY7LrtS+kXNLN+zbrB0
	 i/gg7NuR9SYGx3ah1VpyotRccyuvB6JYbsttZB0ZhFdJnW6kvfN2DXtnVnZ/UUmKqGTzs
	 Rh8lSqrzS5kU3wy6ulmazOPSo7zs1TbJWa8FmWHUCP6CyAZfgDPMPSLpYEc4KjbGHA6iZ
	 dgEozOFdbUMDgatu1mkw8k8qpp7lpT/qRqiIIj5eVO0kFMrLv53y+hqpNVl1iDBKvvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825210;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6kDklRHxeJbP19X2gPkeCnRUqEiSyCdqaMmB98XvLnw=;
	b=LBRWCtpGvVGREAFrrHPIcTOtIuiLICeCO6U0pOigw4ZrhKhyfwJYrWxrJVaaHGFrHKdF
	 84lh+w1dsWTFooRQ6uWpdPBcs4bclRC1lEd9zsJVYTW47dYoPqUjJaQpX+sIkdSZQz29/
	 NzeKpPTnChLeUDWRmWgm4tVirg+vLDYuleIrH7bIES4T3Jv19/n3OeJF6QnVDHd+AYibg
	 4lKkGE4Kv3IexoGORYuJ57qwSg4wey84c6NsSDyH1e/gHbre/IZX/IFxK5r+5DQ4EKzHk
	 YzL8+3LsIqVAVb9lgkG8Zh2OfU8j0vi4QC/bfQpcK3RyecrKOmiLmWGdMnF2w6FW9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8AGlTNP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BE6083633;
	Wed,  4 Nov 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8AGlTNP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F91F00A02;
	Wed,  4 Nov 2026 20:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825210;
	bh=6kDklRHxeJbP19X2gPkeCnRUqEiSyCdqaMmB98XvLnw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C8AGlTNPofwk9WqlC3PZ6Qy5pgZqKZ+yY+QgOm+d9053PINrbfWJ2uQaVQiYmNWIi
	 h7+2tvXujDavHFg8gsI6w0cmaFK8/j1PQmafzx8D9T9ybMqkjapapGrYeb2P8RjRZf
	 hDtcCZZjna03JgxPn7QPQ14ioplEz1fYh0m1OVqboYIYWE8jtz5L6BEbp7c100QK16
	 /RymX0IErQxOgaw6WpAX6aLoGp8cfRaietv0DwpANxG/PrtJH8kufXDQSYtRFzY9xj
	 PUmGUp4+uDwYBrnUqaKGEK5QBkJfp6LAYWptEHiKFWEwzS8TS/cIthxvbObtfq9C3q
	 db1iJ4DFZObgQ==
Subject: Re: [PATCH net 09/15] can: raw, isotp: copy socket options outside of
 lock_sock()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 20:46:49 +0000
Message-ID: <179382520924.488856.15425235949830518760@kernel.org>
In-Reply-To: <20261103204305.3211144-10-mkl@pengutronix.de>
References: <20261103204305.3211144-10-mkl@pengutronix.de>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not remove the RTNL stall it describes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but CAN_BCM has
  the same RTNL-stall problem through a sibling notifier, and the series…

--

can: raw, isotp: copy socket options outside of lock_sock()

This commit moves the user space copies for the CAN_RAW and CAN_ISOTP
socket options, including the CAN_RAW_FILTER filters, so they happen
before lock_sock(). raw_getsockopt() now duplicates the filters under
the socket lock and copies them to user space after release_sock(). The
goal is to stop a stalled user copy from holding lock_sock() and blocking
raw_notify()/isotp_notify() under RTNL.

Link: https://patch.msgid.link/20261027-can-rx-lock-v12-4-eb5afc2d8b9b@hartkopp.net

> diff --git a/net/can/raw.c b/net/can/raw.c
> index d6517f71cadeb..0926d5686e419 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -795,17 +730,84 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>  			  sockptr_t optval, unsigned int optlen)
>  {
>  	struct sock *sk = sock->sk;
> +	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
> +	struct can_filter sfilter;         /* single filter */
> +	union {
> +		can_err_mask_t err_mask;
> +		int flag;
> +		struct can_raw_vcid_options vcid_opts;
> +	} val;
> +	unsigned int size = 0;
> +	int count = 0;
>  	int err;
>  
>  	if (level != SOL_CAN_RAW)
>  		return -EINVAL;
>  
> +	/* Copy the option values from user space before lock_sock(), so a
> +	 * stalled copy can not block raw_notify() waiting for lock_sock()
> +	 * under RTNL.
> +	 */

[Severity: High]
The comment says a stalled copy can not block raw_notify() waiting for
lock_sock() under RTNL. Is that true for the socket as a whole?

The same bound CAN_RAW socket can still hold the socket lock during a
user copy through the SOL_SOCKET path. sk_setsockopt() takes the lock
before it handles SO_ATTACH_FILTER:

net/core/sock.c:sk_setsockopt() {
    ...
	sockopt_lock_sock(sk);
    ...
			ret = sk_attach_filter(&fprog, sk);
    ...
}

and sk_attach_filter()->__get_filter() then copies the program from
user space:

	if (copy_from_user(prog->insns, fprog->filter, fsize)) {

SO_ATTACH_REUSEPORT_CBPF goes down the same path. On the getsockopt
side, sk_get_filter() calls copy_to_sockptr() under sockopt_lock_sock().
That is the SOL_SOCKET equivalent of the CAN_RAW_FILTER copy this patch
moves after release_sock().

Suppose fprog.filter points into a FUSE or userfaultfd backed mapping
that never resolves. On NETDEV_UNREGISTER or a netns change of the
bound device, raw_notify() then waits under RTNL:

net/can/raw.c:raw_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

As far as I can tell, net/can/ has no capability checks. That would
make this reachable by any local user who can create and bind a CAN_RAW
socket.

The commit message says "The generic SOL_SOCKET options in
sk_setsockopt() are not affected by this patch". It does not say that
the RTNL stall is still reachable on the same socket. No later patch in
the series changes net/core/sock.c or net/core/filter.c.

Would it be better to stop raw_notify() and isotp_notify() from blocking
on lock_sock() under RTNL? The other option would be to also move the
generic filter copies out of the socket lock.

> +	switch (optname) {
> +	case CAN_RAW_FILTER:

[ ... ]

> +	if (size) {
> +		if (optlen != size)
> +			return -EINVAL;
> +
> +		if (copy_from_sockptr(&val, optval, size))
> +			return -EFAULT;
> +	}
> +
>  	lock_sock(sk);
>  
> -	err = raw_setsockopt_locked(sock, optname, optval, optlen);
> +	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
>  
>  	release_sock(sk);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
CAN_BCM seems to have the same RTNL stall through its notifier. This
series does not address or mention it.

bcm_sendmsg() takes the socket lock and then dispatches to
bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send(). These copy the CAN
frames from the user iovec while the lock is held:

net/can/bcm.c:bcm_sendmsg() {
    ...
	lock_sock(sk);
    ...
}

net/can/bcm.c:bcm_tx_setup() {
    ...
			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

bcm_notify() takes the lock for every bcm socket in the netns under
RTNL. It does this before checking whether the socket is bound to the
vanishing device:

net/can/bcm.c:bcm_notify() {
    ...
	if (!net_eq(dev_net(dev), sock_net(sk)))
		return;

	switch (msg) {

	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

Say a BCM socket sends TX_SETUP, RX_SETUP or TX_SEND with the frame
data in a FUSE or userfaultfd backed mapping that stalls. Can any CAN
device unregistration in that netns then block RTNL indefinitely?

No later patch in the series changes these paths. The only bcm.c
changes are proc and can_rx_register naming.

>  
> +	/* on error free the filters allocated for CAN_RAW_FILTER above */
> +	if (err && count > 1)
> +		kfree(filter);
> +
>  	return err;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103204305.3211144-2-mkl%40pengutronix.de
