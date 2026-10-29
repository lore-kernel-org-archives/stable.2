Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297778;
	b=A2qCc6jE6erLIt5NICy8giD4vKdkPlvWA7yMdbw2sXS7/JRiLJRcrEb8HMxDwlVGIMbg
	 fqEaK2U68sRZ8T2HI7D1y5V21Vh99A3ZSGwR0//W3zLGAzhlCQYTCeMM3D9abYrcHMEOy
	 W1OR/26QrKu0NkdwcZJqz81IAGXOgR4ZiCi6he9cCsxZuG5jabbvhHbTd97UDfGINr9Sy
	 j2+JNo7AAs6a/PiTFmfv0ahopW768T42hHso+X0BcfnNj8U9IptrDPvT9O8AImWRpmYwn
	 Q5YM/4u9+Pfp3MsFdbp3bvyNcBuu0DD13n7wP0fGSz4JAr6MmjC/+9atm00H1ZG+M2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297778;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/4gAgQ/v/3Bqijm1D2LCxgkMVVLMB4tDzBQLcSYjwMI=;
	b=JQH6nWAI8CObHlu8/1GJ3YHiN06pezjt/eV3YeQM0sBiGxQYp0xYiuwTV/xnfhsjKTgP
	 h4kM8MtrF6clDsCHb11Kr2XWqr7Kxi5vCeQpukT35oZagSN9v3zxYiyu/hCT+qI9jCLQc
	 VMEi1+OuWYV1fr7B7HRmIb/fZ0DWBuOAfk6NTmt0ZVZGZP5NuTw/4KRpaHuz1mpN4i1qo
	 2fEGmTOsIA6q4wXinHy2ktfJ7ZNc2e44nv8aBJ2vclU5v43daVBoX2Adfuq57g+LsYL1l
	 kSkvNv1WY/iL153I67NrJ++eKxU+HBXh5c828Be9VaAEWbSHmoFUPc4twiO0BzVRRKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikpslf4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45909606A323;
	Thu, 29 Oct 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikpslf4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2D61F01824;
	Thu, 29 Oct 2026 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297778;
	bh=/4gAgQ/v/3Bqijm1D2LCxgkMVVLMB4tDzBQLcSYjwMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ikpslf4YPUkOg5LrHDzFgpYpKlX9FjGI+vmKTVrkbTykNdR7VwZu7cuqgx8Yyyf5u
	 VxZ2apLVqTOJZmkvDA6luWYsH7hWhs45Ws60v8fHW8UN+rdMJn/VBdRw0kDXaw3Jc2
	 qd1jSc34CrKjp7nDXowZxk3Vp5ciTuDwiLLOQYUPlbiChTCMtKCqVtOkxwHT6ZuaqQ
	 IGOfQ2Tl1TYNJfzIm56KyHVSrp4E5A/OL9DqlVLuHSQe9r8Al3F4EioOnW4avwZm61
	 CtL3L3vpbIMk0jI66u/nTOSXxcL/J+3W9yuuoa5JIKprYgm+2NMd4uw61yfTnI8rNf
	 z683LYB2t5TLA==
Subject:
 Re: [PATCH] xen-netback: wait for RCU readers before freeing queues on error
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: wei.liu@kernel.org, paul@xen.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 18:16:16 +0000
Message-ID: <179329777698.3134.1942941250754899235@kernel.org>
In-Reply-To: <20261027121438.1266207-1-yhlee@isslab.korea.ac.kr>
References: <20261027121438.1266207-1-yhlee@isslab.korea.ac.kr>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the use-after-free open when the very first queue
  fails, which is every failure for a single-queue frontend.
- [Low] The commit message names xenvif_get_stats64() as one of the RCU
  readers, but xen-netback has no such function.

--

xen-netback: wait for RCU readers before freeing queues on error

This patch changes the connect() error path in xen-netback. It now
publishes num_queues = 0 and calls synchronize_net() before it deinits
and frees vif->queues, which is what backend_disconnect() already does.
The goal is to stop RCU stats readers from dereferencing the freed
vmalloc array.

> The net device is registered in xenvif_alloc() during probe, so it is
> already live when connect() runs. xenvif_get_stats64() and
> xenvif_get_ethtool_stats() read it through the usual stats paths, taking

[Severity: Low]
This isn't a bug, but xen-netback has no xenvif_get_stats64(). The driver
only implements the legacy callback:

drivers/net/xen-netback/interface.c:
	.ndo_get_stats	= xenvif_get_stats,

The KASAN trace also shows that function (xenvif_get_stats+0x28f). Should
the commit message say xenvif_get_stats() instead?

> diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
> index e020f44ac2c71..d1c9e38cfb8ef 100644
> --- a/drivers/net/xen-netback/xenbus.c
> +++ b/drivers/net/xen-netback/xenbus.c
> @@ -835,10 +835,21 @@ static void connect(struct backend_info *be)
>  	return;
>  
>  err:
> -	if (be->vif->num_queues > 0)
> +	if (be->vif->num_queues > 0) {
> +		unsigned int num_queues = be->vif->num_queues;
> +
>  		xenvif_disconnect_data(be->vif); /* Clean up existing queues */
> -	for (queue_index = 0; queue_index < be->vif->num_queues; ++queue_index)
> -		xenvif_deinit_queue(&be->vif->queues[queue_index]);
> +
> +		/*
> +		 * Mirror backend_disconnect(): publish num_queues == 0 and
> +		 * synchronize_net() so RCU stats readers finish before the free.
> +		 */
> +		be->vif->num_queues = 0;
> +		synchronize_net();
> +
> +		for (queue_index = 0; queue_index < num_queues; ++queue_index)
> +			xenvif_deinit_queue(&be->vif->queues[queue_index]);
> +	}
>  	vfree(be->vif->queues);

[Severity: High]
Is the use-after-free still open when the very first queue fails?

Earlier in connect(), num_queues is published before any queue is set up:

	be->vif->num_queues = requested_num_queues;
	be->vif->stalled_queues = requested_num_queues;

If xenvif_init_queue() or connect_data_rings() then fails for
queue_index 0, the failure branch resets the count. For example, when
connect_data_rings() fails:

	xenvif_deinit_queue(queue);
	be->vif->num_queues = queue_index;
	goto err;

This sets num_queues to 0, so the new if (be->vif->num_queues > 0) block
is skipped. synchronize_net() never runs, and vfree(be->vif->queues)
happens with no grace period.

A reader that sampled a non-zero num_queues during the
connect_data_rings() window could still be inside rcu_read_lock():

xenvif_get_stats() {
	rcu_read_lock();
	num_queues = READ_ONCE(vif->num_queues);
	for (index = 0; index < num_queues; ++index) {
		queue = &vif->queues[index];
	...
}

xenvif_get_ethtool_stats() follows the same pattern.

multi-queue-num-queues defaults to 1, and with one queue every failure
happens at queue_index 0. So for a default single-queue frontend, a guest
that supplies a bad ring reference or event channel would still reach
this vfree() without a grace period.

The new comment says this mirrors backend_disconnect(). However,
backend_disconnect() calls synchronize_net() before vfree(vif->queues)
whatever the queue count is.

The commit message says connect() jumps to err: "with num_queues still
counting the queues already set up". That doesn't hold in the queue 0
case.

Should the grace period run whenever vif->queues was allocated and
num_queues was published, and not only when num_queues > 0 at the err
label?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027121438.1266207-1-yhlee%40isslab.korea.ac.kr
