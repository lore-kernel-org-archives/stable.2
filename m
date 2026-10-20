Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522541;
	b=dO1Tw+DKgk15SFMAYNy+JS850hW6ZpEynBiM6htyx7YvXMLtuXfzYyb3d4y/2kbhBk4y
	 TXKo4ZY9OuxAsYvWMcyTgvmoYHXW3Prn1vhxRud/Gu7t2ANCj2GbhRgQQy7cadcOt4kao
	 edTBLwuJY3qHfofTutCqixMh3hAFmULDvOIWMhImYIFWqsjjmWk2udrhLWxGSvkr8XVga
	 Dqro8ilW/oFOheTdvUvzcc63N+h19IjVXALpzDjxZKAVxWhiyT4khdx4l57kEH2FKCkkS
	 DsRXHVQrAfu/REbkGZ+vqxIAYZHwmTc6N/3sUxH4w3BsaqMTwXU3kJ4RHJJVO+7SqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522541;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4PK2lzk2mI4nQc8YfV5A1vWK0eiPo0oKUX3U4tb8dEk=;
	b=bH2hCEX+HwDC1NQGX1Sw2YjmZGwaZzCbJaCvj7fXKFurqxINeTxLQdA3N+GTXUawwyZ9
	 NrUb/StD3zt5LEj/D1O/w2VnnznLBNfcMl4gvPlAOLy+Fw3cqHswFK7OsvLsPaa7QZvI9
	 ap29idzrqrCzlx7/gsKxh8iUAikUhCeglalNbvEl6stZNKcbyNTReETj3AX3h4tDWEgpO
	 sww9t9kpx/p2eWduXQ4/tfTE0eCNlIsE7CF4jM2yDQ3ZQlwUVSWbPcGaqyYEPKhlpT1le
	 nT31X2+iHYBZQgMzOQj3hZ55mnZAOldQhEN6tITDmj+wpjfQCGhFfGY6Rr/j0KcaNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixrA1YXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48872606A319;
	Tue, 20 Oct 2026 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixrA1YXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95591F000C9;
	Tue, 20 Oct 2026 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522540;
	bh=4PK2lzk2mI4nQc8YfV5A1vWK0eiPo0oKUX3U4tb8dEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ixrA1YXoG1+qDDsa71ntE6lr2e2co5LFsNrTKt8FNl3m6zEf+qKK604id9y1tabd8
	 14W+Z3DkFxcjCaLductg5BAFEYKUO/ziRrIBgad7TlD7Ux5YukQqYgpeulnSiaMR62
	 N0aRHjT3HzxcpmuNxWh2VOoAmQgl4EOdXN8PUXHgSsGXT7AT/fKY45YiDCm8mZNXWR
	 5E1OveQbNkOjLlxffgevQBqSit/uR6E5Gn2TBr9dhF7BshNAWk2hR7vV1c0HogUU4Q
	 QsDZ+HUowwJwoEVGcYgikapOSOf2EUNvV5YE2kuXOITX6tvb6g3I6tsnyU6ACMGpUL
	 ZMXY+v7EkiUFg==
Date: Tue, 20 Oct 2026 19:55:36 +0100
From: Simon Horman <horms@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: axienet: don't advance the TX ring head before
 the descriptor is ready
Message-ID: <20261020185536.GR503057@horms.kernel.org>
References: <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-b4-axienet-dmaengine-ring-head-v1-1-7add24e74477@toxicpanda.com>

On Tue, Oct 13, 2026 at 06:25:06PM +0000, Josef Bacik wrote:
> axienet_start_xmit_dmaengine() bumps lp->tx_ring_head before
> skb_to_sgvec(), dma_map_sg() and device_prep_slave_sg(), and none of
> their error paths undo it.  The skb is freed and nothing is submitted,
> but the slot stays claimed.  axienet_dma_tx_cb() walks tx_ring_tail
> once per completion, so the next completion lands on the abandoned slot
> and dereferences whatever skb pointer is left there: NULL if the slot
> was never used or was already completed, or a stale skb that gets
> consumed a second time.  Every completion after that is accounted
> against the wrong slot.
> 
> dma_map_sg() and device_prep_slave_sg() can fail at runtime, and so can
> skb_to_sgvec() on a malformed skb.  Only advance tx_ring_head once
> those have succeeded.  The completion callback can't run before
> dmaengine_submit(), so claiming the slot just before that is fine.
> 
> dmaengine_submit() itself can also fail on xilinx_dma after a channel
> error, and its return isn't checked either.  That's a separate problem
> and isn't changed here.
> 
> This was found by the Sashiko AI review of the skbuff BUG_ON() series.
> 
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> Compile-tested only, I don't have the hardware.  The bug is in the error
> paths, which are easy to see from the diff: every goto after the old
> increment returns without submitting anything.

Reviewed-by: Simon Horman <horms@kernel.org>

