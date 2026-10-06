Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E932A3C9;
	Tue,  6 Oct 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283948; cv=none; b=IHVeCFBHLAAbE1EnEZlyzwrJEyQ7/iUXILz2NS9jcYd8Q2eooWMVIbOnh4hQklITjsYCR86vKXtFB01Q8HBlbULq7d/4vvCucFzmQ0hrj63TJusQ2K0PPeQ6Dxv3o9tnwSaszeOQQqX/Ck6O2ggWmkaGpPMDD3+xO7GPnsgR3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283948; c=relaxed/simple;
	bh=6gqIl2BJQL6fBztrmd9tMru4MzPSh7dO4bdrepnlO1Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m39a6V4Ut+XyR8CdtLDMISTevDyR3pp+Iun2uxd5QvTE3NotDljn02eq2qJ7E2WJJb/EjuvJKCDWUw7eIzStpLQjcBywkJqcMZsQbmMbR9+UsCA6H8fMysVrt3RBH8Ekq1FTLiMiB6G1D69jhhla9hub3F05eupGfYvtU1MlAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcAtsW3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcAtsW3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF21F000FF;
	Tue,  6 Oct 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283946;
	bh=Nx4bbRMDnlaWX2+Z5qfZZsRdMtrG229Iaf8wUlJP3eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fcAtsW3FQKhmEDhWgGOhm7j/KhkWIi+tlRCCx/AfGZuRNwS/PlTEUchY05VPzkdcH
	 dOBwWZYVE5qJzSY+w934NbpNzzDZEmfOc72XIW+8Gl14HFu6dRQhrPIuqkb+Iz8KaC
	 wEYEEKtdsYbqs4/kwtOvuzZtqvk8rUmLUgEE9uq4qfRKWL373hRBmWMQneoCcN9vui
	 orYZuuBsjUDcitEd3VkylX+1z1yXtkIJGvchbfc9iHC0tiPjk+Ft/8e6eR8BpEnndY
	 4lcO+6gZTcIPRCjxU51TG9ocCjGsdusenepQjTxX0GabsURPZ69ZCqS9vmoxCwI3e8
	 cMHs1po1rsAgA==
Subject:
 Re: [PATCH net v2] xfrm: espintcp: reserve partial message during allocation
From: netdev-bot+sashiko@kernel.org
To: bruno.produit@trailofbits.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, kylebot@openai.com,
 linux-kernel@vger.kernel.org, dominik.czarnota@trailofbits.com,
 sd@queasysnail.net, stable@vger.kernel.org, kuba@kernel.org
Date: Tue, 06 Oct 2026 10:52:25 +0000
Message-ID: <179128394560.434549.12582468406857918145@kernel.org>
In-Reply-To: <20261002102447.148835-1-bruno.produit@trailofbits.com>
References: <20261002102447.148835-1-bruno.produit@trailofbits.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] espintcp_poll() can lose an EPOLLOUT wakeup.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  espintcp_push_msgs(sk, 0) can sleep, and self-deadlock on…
- [Medium] This problem wasn't introduced by this patch, but
  espintcp_poll() and espintcp_sendmsg() use different definitions of a…

--

xfrm: espintcp: reserve partial message during allocation

This patch adds an owned flag to struct espintcp_msg. espintcp_sendmsg()
uses it to reserve ctx->partial while it builds a new message, and the
reservation holds across sk_stream_wait_memory(). While owned is set,
other senders and espintcp_push_skb() treat the slot as busy, and
espintcp_poll() masks out EPOLLOUT.

> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 3e72b9f067b9b..68b9201c98d3f 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c

[ ... ]

> @@ -291,7 +299,7 @@ int espintcp_push_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	espintcp_push_msgs(sk, 0);

[Severity: High]
This is a pre-existing issue and this patch did not introduce it. Can
espintcp_push_msgs(sk, 0) sleep here while the caller is in atomic
context?

esp_output_tcp_finish() calls espintcp_push_skb() under bh_lock_sock(),
and esp6 has the same pattern:

net/ipv4/esp4.c:esp_output_tcp_finish() {
    ...
	bh_lock_sock(sk);
	if (sock_owned_by_user(sk))
		err = espintcp_queue_out(sk, skb);
	else
		err = espintcp_push_skb(sk, skb);
	bh_unlock_sock(sk);
    ...
}

It is also called from espintcp_release(). That function runs as
->release_cb from release_sock() with sk->sk_lock.slock held.

Suppose ctx->partial holds an IKE sk_msg that was only partly sent
(emsg->skb == NULL, emsg->len != 0). A MSG_DONTWAIT sendmsg, an
SO_SNDTIMEO timeout or a signal can leave that state behind. In that
case espintcp_sendskmsg_locked() calls tcp_sendmsg_locked() without
MSG_DONTWAIT:

	struct msghdr msghdr = {
		.msg_flags = flags | MSG_SPLICE_PAGES | MSG_MORE,
	};

That means tcp_sendmsg_locked() uses sk_sndtimeo. If the send buffer is
still full, it can take this path:

espintcp_push_msgs(sk, 0)
  espintcp_sendskmsg_locked()
    tcp_sendmsg_locked()
      sk_stream_wait_memory()
        sk_wait_event()
          release_sock()
            spin_lock_bh(&sk->sk_lock.slock)

The caller already holds sk->sk_lock.slock. Wouldn't this self-deadlock
with BH disabled? Even without the recursion, wait_woken() would sleep in
atomic context.

Here is one sequence that looks reachable:

1. An IKE sendmsg(MSG_DONTWAIT) leaves a partial message behind.
2. During that call, an ESP packet gets queued to out_queue.
3. The final release_sock() in espintcp_sendmsg() then runs
   espintcp_release()->espintcp_push_skb()->espintcp_push_msgs(sk, 0).

A peer that withholds ACKs or advertises a zero window can keep the send
buffer full.

The skb path seems safe only because __skb_send_sock() forces
MSG_DONTWAIT. The skmsg path doesn't do that. This patch changes
espintcp_push_msgs() with the owned early return, but leaves this
behaviour as it was.

>  
> -	if (emsg->len) {
> +	if (emsg->owned || emsg->len) {
>  		kfree_skb(skb);
>  		return -ENOBUFS;
>  	}

[ ... ]

> @@ -549,8 +559,13 @@ static __poll_t espintcp_poll(struct file *file, struct socket *sock,
>  {
>  	struct sock *sk = sock->sk;
>  	struct espintcp_ctx *ctx = espintcp_getctx(sk);
> +	__poll_t mask;
> +
> +	mask = datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
> +	if (READ_ONCE(ctx->partial.owned))
> +		mask &= ~(EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);

[Severity: Medium]
Can a poll or epoll waiter miss the EPOLLOUT wakeup here?

espintcp_poll() runs without the socket lock. A thread that polls only
for EPOLLOUT can see partial.owned == true while another thread is inside
espintcp_sendmsg(), and then go to sleep. That window covers both the
sk_msg_memcopy_from_iter() copies, which can fault, and
sk_stream_wait_memory().

When owned is cleared, this is the only notification:

espintcp_unreserve_msg()
  sk->sk_write_space()
    espintcp_write_space()
      ctx->saved_write_space()    /* sk_stream_write_space() */

sk_stream_write_space() only wakes waiters when __sk_stream_is_writeable()
holds:

	if (__sk_stream_is_writeable(sk, 1) && sock) {
		clear_bit(SOCK_NOSPACE, &sock->flags);
		...
			wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
						EPOLLWRNORM | EPOLLWRBAND);

That check is based on sk_wmem_queued. datagram_poll_queue() decides
EPOLLOUT with sock_writeable(), which is based on sk_wmem_alloc.

Say sk_wmem_queued is between about 2/3 of sk_sndbuf and sk_sndbuf, for
example because of unacked ESP or IKE data:

- sk_stream_memory_free() is still true. The sender's own push doesn't
  reach wait_for_space, so SOCK_NOSPACE is never set.
- __sk_stream_is_writeable() is false, so the unreserve wakes nobody.

Later ACKs go through tcp_check_space(). It only calls
__tcp_check_space() when SOCK_NOSPACE is set, and datagram_poll_queue()
only sets SOCKWQ_ASYNC_NOSPACE.

Could the poller then sleep until its timeout, even though a fresh poll
would report EPOLLOUT? Before this patch EPOLLOUT never depended on owned,
so this path looks new.

[Severity: Medium]
This is a pre-existing issue and this patch did not introduce it.
espintcp_poll() and espintcp_sendmsg() still disagree on when the partial
slot is busy.

espintcp_sendmsg() returns -ENOBUFS when it sees this:

	if (emsg->owned || emsg->len) {

With MSG_DONTWAIT it can also return -EAGAIN from espintcp_push_msgs()
when the pending message can't be drained. espintcp_poll() only checks
partial.owned.

Take a published message that is still pending (emsg->len != 0, owned ==
false). Poll reports EPOLLOUT whenever sock_writeable() is true, but
sendmsg reports busy.

Can an event-driven, non-blocking IKE sender spin in that state? The len
half of this mismatch was already there before this patch. The patch only
adds the owned half to poll.

>  
> -	return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
> +	return mask;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002102447.148835-1-bruno.produit%40trailofbits.com
