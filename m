Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027D255F2C;
	Sun, 20 Sep 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890502; cv=none; b=tGxk2MPGA9lG2zS7KT/nx+kog3SYWTLWcI8lmpgHFSP4sjhPh2D7vwL+JBZwqUHGxpqn9MZkXQthuJCAJkWPQs7A0vJnveI6ZqJQsOtqyRwsJAhDD/hNBJhi770PzPqB7UjAj02qYmiOuwYRvxEBMFbLA72ehMhsD3Y6BjHVSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890502; c=relaxed/simple;
	bh=lKo/fBHPCwPkEQhwejYaMzZx0KmUwaYcJsPZU4ABglo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdMmNx0PjZoWVyJO0sitVTahSj87+abL9sViu31Q08mrGUFfz39She2apYWLiKxR1DZmEG3NkuONvYV1emqEeuT8o6jlAbs5kf+YYmIlObUvT5WOY8OXwn8c6NJVeNiAI82NmgiwhSoo/DLThpJH4aOpjdYoI9A2UZZigkQJJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgYh3QTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgYh3QTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798EE1F000FF;
	Sun, 20 Sep 2026 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789890501;
	bh=BLmlFgde0QSjxDALyLy9smJnfbZgGpYUkZ3OKMxeQgM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BgYh3QTpFQeCcN0wMKS7UPAHa15RNDOkVTnhWBm92go7sUgDeatY5cmHFTqxMgEWN
	 dU6C9QCUuRujz27OQKiE3tUBBXRsuN6rNI7sEV/qdFufzl9CtNFOpwOV1MJHduOMcX
	 CgNXwQJdlG1r5wm4x8lJXO95PKJgRk54pB0U2ggUqBf0GDnGBKbOv7DpKqYv/lFBMa
	 hSQ5fojNPOrnTo06lrhuIySVFsEvoXnM0+xgzjXEdw7hbP8A0i1qKgmg2xDYv37ex0
	 /XytMFp28PrAJ/KD6YsTmMagED985R3o0muwAAHt4yGTOeOQbGNXRL4EVYcMZ5L1w6
	 9JN6pXtK3STqA==
Subject:
 Re: [PATCH] nfc: llcp: Fix socket reference leak in nfc_llcp_recv_ui()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: davem@davemloft.net, david+nfc@ixit.cz, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, pabeni@redhat.com,
 sameo@linux.intel.com, stable@vger.kernel.org
Date: Sun, 20 Sep 2026 07:48:19 +0000
Message-ID: <178989049996.2160803.13194045712273112388@kernel.org>
In-Reply-To: <20260916073424.1971784-1-vulab@iscas.ac.cn>
References: <20260916073424.1971784-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the identical nfc_llcp_sock_get() reference leak
  remains at the sibling call site in nfc_llcp_recv_connect()…

Pre-existing issues:
- [Critical] Post-handoff SKB access / use-after-free race in
  nfc_llcp_recv_ui() (net/nfc/llcp_core.c:902-907): the extra SKB…

--

nfc: llcp: Fix socket reference leak in nfc_llcp_recv_ui()

This splits the combined NULL/socket-type test in nfc_llcp_recv_ui() so that
the reference taken by nfc_llcp_sock_get() is dropped with
nfc_llcp_sock_put() when the socket is not a SOCK_DGRAM socket.  Previously
that branch returned with the reference still held.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index cac1b5487064d..f83196e49d2a6 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -890,8 +890,12 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
>  
>  	/* We're looking for a bound socket, not a client one */
>  	llcp_sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
> -	if (llcp_sock == NULL || llcp_sock->sk.sk_type != SOCK_DGRAM)
> +	if (!llcp_sock)
>  		return;
> +	if (llcp_sock->sk.sk_type != SOCK_DGRAM) {
> +		nfc_llcp_sock_put(llcp_sock);
> +		return;
> +	}

[Severity: High]
Does the same nfc_llcp_sock_get() reference get leaked in
nfc_llcp_recv_connect(), which is a few lines below this in the same file?
It has the identical condition shape that is being split apart here:

net/nfc/llcp_core.c:nfc_llcp_recv_connect() {
	if (dsap != LLCP_SAP_SDP) {
		sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
		if (sock == NULL || sock->sk.sk_state != LLCP_LISTEN) {
			reason = LLCP_DM_NOBOUND;
			goto fail;
		}
	...
fail:
	/* Send DM */
	nfc_llcp_send_dm(local, dsap, ssap, reason);
}

The fail: label only sends the DM PDU and returns, so when sock is non-NULL
but sk_state != LLCP_LISTEN, the reference taken by
nfc_llcp_sock_get()'s sock_hold(&llcp_sock->sk) is never released.  Every
other exit of that function (acceptq full, LLCP_SAP_MAX, nfc_llcp_sock_alloc
failure, nfc_llcp_local_get failure, and the success path) does call
sock_put(&sock->sk).

Is that branch reachable from a remote peer?  nfc_llcp_sock_alloc() sets

	llcp_sock->ssap = 0;
	llcp_sock->dsap = LLCP_SAP_SDP;

and llcp_sock_bind() publishes the socket with

	nfc_llcp_sock_link(&local->sockets, sk);
	...
	sk->sk_state = LLCP_BOUND;

so a bound-but-not-listening socket (any bound SOCK_DGRAM socket, or a stream
socket bound before listen()) matches the lookup key used by
nfc_llcp_recv_connect(), and a CONNECT PDU aimed at its ssap would leak one
sk_refcnt per frame received.  Since the socket would then never reach
llcp_sock_destruct(), does the nfc device reference that destructor releases
leak as well?  Would it make sense to fix both call sites in one patch?

>  
>  	/* There is no sequence with UI frames */
>  	skb_pull(skb, LLCP_HEADER_SIZE);

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at
nfc_llcp_recv_ui() the ordering of the skb reference just after the quoted
hunk looks racy:

net/nfc/llcp_core.c:nfc_llcp_recv_ui() {
	skb_pull(skb, LLCP_HEADER_SIZE);
	if (!sock_queue_rcv_skb(&llcp_sock->sk, skb)) {
		/*
		 * UI frames will be freed from the socket layer, so we
		 * need to keep them alive until someone receives them.
		 */
		skb_get(skb);
	...
}

Can the skb be freed before skb_get() runs?  sock_queue_rcv_skb() links the
buffer into sk->sk_receive_queue, drops sk_receive_queue.lock and then calls
sk->sk_data_ready(), so at that point skb->users is still 1 and the buffer is
already visible to a reader on another cpu:

net/nfc/llcp_sock.c:llcp_sock_recvmsg() {
	skb = skb_recv_datagram(sk, flags, &err);
	...
		kfree_skb(skb);
}

If that reader dequeues and frees the buffer first, does skb_get() then do
refcount_inc() on freed memory?

And would nfc_llcp_rx_work() free the same buffer a second time afterwards?

net/nfc/llcp_core.c:nfc_llcp_rx_work() {
	...
	kfree_skb(local->rx_pending);
	local->rx_pending = NULL;
}

No lock appears to span the handoff here: nfc_llcp_recv_ui() does not hold
the socket lock, the queue spinlock is released inside
__sock_queue_rcv_skb() before the wakeup, and the nfc_llcp_sock_get()
reference only keeps the socket alive, not the skb.  Would taking the
reference before sock_queue_rcv_skb() and dropping it when queueing fails be
the safer order?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916073424.1971784-1-vulab%40iscas.ac.cn
