Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701301;
	b=iCmledR+UDnZ0nhuld5u+GiiuCVZ3YPWiHVa966Ji9sI6L1smhXIDfxbLGncfTY4CU+N
	 7MLgT28uNLED0iwYNvyV7zvQA/taSoxVUiAmLxflA17tLIwzlOK/1eGfTNZRBWCo89NRr
	 3LLfwDeOB1JUQon1NZUOzUaqEWt0oyaXctdsc3grjZI/wLISeL4PbqchAZMIm2qA2th2L
	 WLuMIAplO7J8jyFjJWJAUmAeNowcNItKYf5pY1sBrCRNdWhf+FAyA+ee/VqihaR6QyAmE
	 9QTqZKqPaTrja6NQPi13/OphdV0uMP0WLizkvZ8Qr5M6GAgd2qrGSMTEiL4Te0MHW4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701301;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S5he5q7MjF9c5T8hA//T+bmi6stTqMHL9VXH/td4Bfg=;
	b=njq4SQtdWRqIPAVC38IGUN6IE3DnNEBn4fPl62n4yMRSYJ0t5TPETSgVemi7SDxO+Ovl
	 03G1p8r14qDivzaxE39l9d7FypRoJTOKSPR/eE9vWOAjpWZtlna6P/6HOSsu1BpBjyTg1
	 DlZMz+HtaOVAmUOQfVVRJ0WwEQ5mSht2J2fYExS6jh3CKqblVc8HyCY8Sn+74/BqdnIT4
	 vPPfVbjGwWB5vFBOZmwlr5QwuzoBL6HBcBsc/KB6WwH1cP7OLITZgxyLLIYCzsDt/iOqs
	 xMjBOoB6CIytWTOzWjWIImipMuUGZSHvWdBpipdIQjbvtu5vkGmsyxzsxOUPaSj7Scw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2CcVi1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D537606B10E;
	Tue,  3 Nov 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2CcVi1M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670F1F00A02;
	Tue,  3 Nov 2026 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701301;
	bh=S5he5q7MjF9c5T8hA//T+bmi6stTqMHL9VXH/td4Bfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y2CcVi1MSlIwyvTc3aBX66wqFCzvjRb9x3ymZooPal6blsTfZOpGGQVYHiqnitX7V
	 j/Sj6XOHIDIy+4+D7KIvh2+pW1FNQyBT/zGCAj/P5Xu0L1DgIX4hKLRQkmytsrdoMF
	 K6Gt9FClhTVe4p6EPqYnwtwZFv4BjOH/7o8TjZUp4mCdKC1jCO1vagOwha82/rsVHV
	 yWbqYwaYmSxml84uWAw+o94naLlwzJGMv8zzYzagmfRVRCt04b8lt1+SG2AMxO/W2f
	 DGWO0qwMyoCx57NVLBbKoLRq3frFlLCQhNhYmFMDu4T95G1y7CuODKrmJD5YaPtBB4
	 EpBKuJE3rT8fw==
Subject:
 Re: [PATCH net v2] net/packet: account user-triggered allocations to memcg
From: netdev-bot+sashiko@kernel.org
To: ahmadag1001@gmail.com
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 03 Nov 2026 10:21:39 +0000
Message-ID: <179370129992.488856.770584041201834715@kernel.org>
In-Reply-To: <20261030100504.23498-1-ahmadag1001@gmail.com>
References: <20261030100504.23498-1-ahmadag1001@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says it charges the per-socket memory a packet
  socket allocates for its user.

--

net/packet: account user-triggered allocations to memcg

This patch changes the allocations a packet socket makes for its user to
GFP_KERNEL_ACCOUNT, so the caller's memory cgroup is charged for them.
These are the ring blocks and block arrays, the fanout groups and rollover
state, the mclist entries and the per-CPU pending counter. The vmalloc
fallback for ring blocks becomes __vmalloc() with __GFP_ZERO.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c910f..06386db4c8e8c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_sock *po)
>  {
>  	po->rx_ring.pending_refcnt = NULL;
>  
> -	po->tx_ring.pending_refcnt = alloc_percpu(unsigned int);
> +	po->tx_ring.pending_refcnt = alloc_percpu_gfp(unsigned int,
> +						      GFP_KERNEL_ACCOUNT);
>  	if (unlikely(po->tx_ring.pending_refcnt == NULL))
>  		return -ENOBUFS;
>  

[Severity: Medium]

The pending counter on the socket() path is now charged. Is struct
packet_sock, allocated on the same path, still left uncharged?

The commit message says:

    struct packet_sock itself comes from sk_alloc(), and the
    netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
    add through dev_mc_add() and dev_uc_add() live in net/core; neither
    is changed here.

The v2 note also says the patch covers "every user-triggered allocation in
net/packet".

>From the code, af_packet itself seems to cause the missing charge, not
net/core. packet_init() registers the proto without a slab:

net/packet/af_packet.c:packet_init() {
    ...
	rc = proto_register(&packet_proto, 0);
    ...
}

So proto_register() never creates the SLAB_ACCOUNT kmem_cache for
packet_proto. packet_create() then passes plain GFP_KERNEL:

	sk = sk_alloc(net, PF_PACKET, GFP_KERNEL, &packet_proto, kern);

Because prot->slab is NULL, sk_prot_alloc() falls back to a plain kmalloc
with those flags:

net/core/sock.c:sk_prot_alloc() {
    ...
	} else
		sk = kmalloc(prot->obj_size, priority);
    ...
}

mem_cgroup_sk_alloc() runs afterwards. It only sets sk->sk_memcg and does
not charge the object itself.

packet_sock holds a struct sock, two packet_ring_buffer structs and a
cacheline-aligned prot_hook. That probably makes it the largest
per-socket allocation here.

A user with CAP_NET_RAW in its own user namespace can create one per fd.
The total is limited only by RLIMIT_NOFILE and process limits, not by
memory.max.

Would either proto_register(&packet_proto, 1) or GFP_KERNEL_ACCOUNT in the
sk_alloc() call in packet_create() close this gap? If packet_sock is left
out on purpose, could the commit message give the actual reason instead of
pointing to sk_alloc()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030100504.23498-1-ahmadag1001%40gmail.com
