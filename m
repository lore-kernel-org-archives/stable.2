Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787349;
	b=tigxMslloiGjN4dFSt90iTe8+YilpICDwnNnGVHg+BacvwMcqUBVDs+doBd/H6DMMPMM
	 8moEHt+OswWBW6vcmQ4FDv/m0e6v3R32x7ehImb72l1iK9TJb4xtFAvNeQq3RQAVZNn/Q
	 Vlp/UDX2KVAbUjtPrWL5C+TnPXjDVKJtGuYMarDb42p8JUJn713fH+X/DprS7svVvDSZx
	 QMXdXHOnFhKPq3lK5yvSgNUKDZmOoBDkGIo0uq4+NN3VTt26DkvGQWdFMydnnLWA1oMM/
	 u9MDq2XTZnuxQQ4o98pvAk8EjYxUXW4qsWgAC4iqMxaePsAM2/iL2xlEqz7ySqABlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787349;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0LiZaiovIoEgc2+KzKF9v3Bvxk8MU684up3WOQq16sY=;
	b=geuFcUB7VQmuN3aBvSFS9sP5pTZOGRJ3GCX3pyqDSHQwPasETDJ534hgq9fZR5tQQW+E
	 Bmk6NOYLueKiBq1RtQA7iwaHnmUqK+SaskLINxtzQ6R/9Q8q5G8243gpRqHfIhpzoklF4
	 AsoSIya/rOudjGWkdlimhJO5Rk8utPkNFzINVIGF3yDnxNsMAzGlk6GcMJor57b63JQ7h
	 pV4AitCHhy4f/pGNhebMvqK1VmklEkgS54Nvc2g2zuOsndKGfDNvjTMZs4nzgKHYinkkX
	 WFCftugNK/EEVL/mUC/FJZ+vuNnFmniNfId90SDKIOjhmW9Vnagj4nVrxOQzDh+7OPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irUiT623;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A1606A31F;
	Mon, 16 Nov 2026 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irUiT623
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517CE1F000C4;
	Mon, 16 Nov 2026 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794787349;
	bh=0LiZaiovIoEgc2+KzKF9v3Bvxk8MU684up3WOQq16sY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=irUiT623aRt32I4fhbQ5pqZjzskjxyj/oIiFf4X64UuBPVJnLFBEooSWi5qHOsejM
	 0ZKXg1cLffpgEOkAWwjPWjzFyO9HkVK00eyymwk4FiQppgTiRCW1Yb0I520qBx0fcQ
	 dYbAULLLkF2hV9Kr6IrqpHlQzn1SdqQU1TMcl8Bjwl8HdgtmIj9tdziztL9dEZEr3F
	 DbfY1UjHUUzrqbwrvvzTg1ycDJbeDl909lCiOPYliWDTmAzUdh5RrEz5jwFQ13PZy4
	 fpmxYxK0Z7vMoJlMLLeU6T3veq+IMlUytVbdariGyV9z52/5Ex5fUUNqasVzGRR88G
	 p1Yhk/viXd7kg==
Subject: Re: [PATCH net v4 1/2] tls: restrict device-down TX fallback to
 hardware TX sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com,
 alice.kernel@fastmail.im, linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 00:02:27 +0000
Message-ID: <179478734781.3136.1664474557678569331@kernel.org>
In-Reply-To: <20261111232930.2532497-1-rjethwani@purestorage.com>
References: <20261111232930.2532497-1-rjethwani@purestorage.com>
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

- [High] In tls_device_down() (net/tls/tls_device.c), this patch decides
  whether to call tls_dev_del(TX) from the result of…

--

tls: restrict device-down TX fallback to hardware TX sockets

This commit changes tls_device_down() so the TX validator is switched to
the software fallback only for sockets that use hardware TX. The cmpxchg
result now decides whether the driver TX state is deleted. RX driver
state is tracked with TLS_RX_DEV_CLOSED, which is set at context
creation and cleared after a successful RX tls_dev_add().

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 4cdfbb57ecff0..a42cbc89db2bb 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c

[ ... ]

> @@ -1350,10 +1350,14 @@ static int tls_device_down(struct net_device *netdev)
>  	spin_unlock_irqrestore(&tls_device_lock, flags);
>  
>  	list_for_each_entry_safe(ctx, tmp, &list, list)	{
> +		bool tx_hw;
> +
>  		/* Stop offloaded TX and switch to the fallback.
>  		 * tls_is_skb_tx_device_offloaded will return false.
>  		 */
> -		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
> +		tx_hw = cmpxchg(&ctx->sk->sk_validate_xmit_skb,
> +				tls_validate_xmit_skb,
> +				tls_validate_xmit_skb_sw) == tls_validate_xmit_skb;

[Severity: High]
Is ctx->sk still guaranteed to be allocated when this cmpxchg runs?

The cmpxchg is in the second loop, after tls_device_lock has been
dropped. The refcount_inc_not_zero() in the first loop pins only the
tls_context, not the socket.

The final reference on a hardware TX socket can be dropped from skb
freeing, and that path does not take device_offload_lock. The socket
destructor then sees the extra ctx reference held by tls_device_down()
and returns early:

__sk_destruct()
  tls_device_sk_destruct()
    tls_device_queue_ctx_destruction()
        spin_lock_irqsave(&tls_device_lock, flags);
        if (unlikely(!refcount_dec_and_test(&ctx->refcount))) {
            spin_unlock_irqrestore(&tls_device_lock, flags);
            return;
        }

The ctx survives, but the sock is freed. ctx->sk is left dangling. Each
earlier context in the list adds a synchronize_net() before this one is
reached, so the window can be fairly wide.

If that happens, can the cmpxchg read and write freed or reused socket
memory? There seem to be two bad outcomes:

If the compare fails, tx_hw is false and tls_dev_del() is never called
for TLS_OFFLOAD_CTX_DIR_TX. ctx->netdev has already been set to NULL,
and the final refcount_dec_and_test() in tls_device_down() goes to
tls_device_free_ctx(), which never calls tls_dev_del(). Would this leak
the driver TX offload state?

If the memory has been reused by another TLS socket whose validator is
tls_validate_xmit_skb, the cmpxchg would switch that unrelated socket to
the software fallback.

The unconditional WRITE_ONCE() through ctx->sk in the second loop was
already a use-after-free before this patch, so that part is pre-existing.
What this patch adds is that driver TX teardown now depends on that
unprotected access, where before it used the pinned ctx->tx_conf.

The next patch in this series, "tls: fix socket use-after-free during
device-down", seems to address this. It moves the cmpxchg into the first
loop under tls_device_lock, records the result in TLS_TX_DEV_DOWN, and
tests that flag in the second loop. Would it make sense to fold that fix
into this patch, or reorder the two? Then this commit would not add the
dependency on its own, which matters since it is marked for stable.

>  
>  		/* Stop the RX and TX resync.
>  		 * tls_dev_resync must not be called after tls_dev_del.
> @@ -1370,13 +1374,14 @@ static int tls_device_down(struct net_device *netdev)
>  		synchronize_net();
>  
>  		/* Release the offload context on the driver side. */
> -		if (ctx->tx_conf == TLS_HW)
> +		if (tx_hw)
>  			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
>  							TLS_OFFLOAD_CTX_DIR_TX);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111232930.2532497-1-rjethwani%40purestorage.com
