Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080726;
	b=rlTuZRv87HnrjLLif4l5eJIfjdLNCBkLoteEn5VLawj7yxZVZhwpshnwiGDo6WgxDvub
	 FQ3GRca+VtjfxZos1AKPUQ5JrkCsDc5RS6e6N0bqeHpfm2PeiGj/NeaVXYZrgbqNHT4JW
	 7VCPoK5bls603Ymw7iqhenOPDH3gFSUvL9QoPtIZ2H/+m0RNyuCcmcJj/9lxRF1JFKx0z
	 dpzCriVhB05otmNcDWZCenO1psVX6uGniMOcrwA6RwghnfBso0DRzmu4PowXFVLbMt84Z
	 9BJ9fTR/N1T4wXvhjqP8biAjYSYrAkF1x7AXqn1oJzjEVtVRnwoBuGorG4YFSHrA4tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080726;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EhZ8QQRDtpojRf+w+WKdi7PLTN6QFmI45738JzQYc8w=;
	b=BdIvs6jtvykqb48fjoB9IgSi7sqxb3ZK6XgV7mihlpVau5xdXsZgmk9inh1K4DOY7SNI
	 4GSQNADVyj54j/xe2llgMp9TKadvv6UjgT7NkSxIrRoHyqiLD4Eln/QQpNSLKyx2eGfLa
	 3dlzTV0AXqWXKGZ6QmpX1bFNKMcS302soyM8M6flBZIK5uyOJf/p5G0jDyvHfBW3gEvcX
	 7F070SyMdImhCe5unkasB8HyQhKGhKEomPmxN30S58zGNudvaMDgrR+MA5Ym7quO+yMEh
	 pLQuunt05jKradIj/fozVBiGAsD+TdWmTK4PvPFplJbgx4I6bSZMQiAuxgs5eo+A/mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WOKHMYK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92651606A31A;
	Tue, 27 Oct 2026 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WOKHMYK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E271F01825;
	Tue, 27 Oct 2026 05:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793080725;
	bh=EhZ8QQRDtpojRf+w+WKdi7PLTN6QFmI45738JzQYc8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WOKHMYK6SK7R3B+Sntmb9766mpP0UzVUVkXUedAUYPPCyop2x4NZwvgCgtuJCWrxO
	 d/5C9m0rl/zm+RyifN88rLWoE3/RQkQRGXNAjB5ifdtux/CFMfi1yeyTnKfOtxojf8
	 AJrJeIpltA9ZeoTvIyLE4rUkNItQDcI1E7h+7wUE=
Date: Tue, 27 Oct 2026 06:58:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: andreyknvl@gmail.com, krishnagopi487@gmail.com, kees@kernel.org,
	balbi@kernel.org, zhugl3@xiaopeng.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: raw_gadget: fix dangling ep->desc on enable
 failure
Message-ID: <2026102733-cameo-upturned-bf2a@gregkh>
References: <20261027032332.1945140-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20261027032332.1945140-1-liuc63@xiaopeng.com>

On Tue, Oct 27, 2026 at 11:23:23AM +0800, Liu Chao wrote:
> raw_ioctl_ep_enable() assigns the user-supplied endpoint descriptor
> to ep->ep->desc before calling usb_ep_enable(). If usb_ep_enable()
> fails, or if the subsequent usb_ep_alloc_request() fails, the error
> path frees desc via out_free but leaves ep->ep->desc pointing at the
> freed memory.
> 
> The UDC driver may have captured the stale descriptor pointer during
> the partial enable sequence and may dereference it in subsequent
> operations, resulting in a use-after-free.
> 
> Clear ep->ep->desc before jumping to out_free on both failure paths
> so the pointer never outlives the descriptor it references.
> 
> Fixes: 97df5e5758f7 ("usb: raw-gadget: fix gadget endpoint selection")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
>  1 file changed, 2 insertions(+)

How was this found and tested?

thanks,

greg k-h
