Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31788390C8A;
	Sun, 13 Sep 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789309944; cv=none; b=aTxEWw/6A6YkYWPGgTn8QfDCZj3UxkGRqVpu8+A6LJ7EHvp5/wNibqfj/QYSPtnoe3GnEJH7s2UT59MoVXqpSj5jdNrcTwzItQz/gtS+VdP1AKRx4Tu5YhIz+s0zMglOmdxz76JB8zws49HhMiKoUbWR4rle3zPZ46OCbS9bXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789309944; c=relaxed/simple;
	bh=YCRt6Qtdz8AMOeJGn4MqiXS9j+QuoLCUvZ+/FVgzzKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuxIfNZPGYEztQE1eA0/o9loXawSxjDC305xqU7GR01wVxKx4CkaOYXbw7yTcfHLdYDzajBBL4ScjOxvKJ3224RWnrIh3TveiYelDASnUJix9Lygh0QMa9Do7snGXVKKozFLfWPQAVTFuH2+dSrIilTOU9UmsgQFl7cMI9+ezq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejEy0u2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejEy0u2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD611F000FF;
	Sun, 13 Sep 2026 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789309942;
	bh=U8+fvsKWx0snbmn4Ih3GcyudjqWXY2cMF/YzeWKfsmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejEy0u2RywAWFgdi8YQImjiSg5lZVpYNoXMAWUEjDO6vxrpp9B0B7L83F7+H1+1HM
	 ody1P/AkS50HbuJMokMq8gYflsU66DtYC51WvNhA3g3/pbiP3/cEjEBOI0pPXzbPFR
	 8+0S34CTwsR7MTI3Hm560TLxrCfCViBPLd8jxkq7LYrWs1ARBb0oHWu9ktsG0Z8hcz
	 kKxeXZ1iU7xPcRttwD367O6ou/rAIZKKhujf5f6SzpfGDuDGDz52f2IHSVtch9Tup3
	 nv3QCWS99mKeOU5KICnrWLl6exALYG7pKw5RcpySEcKXz0AaivQ5r23m6oiFW0gL45
	 ZRQodGzmq/CwQ==
Date: Sun, 13 Sep 2026 15:32:18 +0100
From: Simon Horman <horms@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
Message-ID: <20260913143218.GJ48209@horms.kernel.org>
References: <20260731161740.44955-1-mhun512@gmail.com>
 <20260910231400.31919-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910231400.31919-1-mhun512@gmail.com>

On Thu, Sep 10, 2026 at 07:14:00PM -0400, Myeonghun Pak wrote:
> setup_shmem_window() acquires a PCMCIA memory window using
> pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
> ioremap() fails, the function returns without releasing the requested
> window.
> 
> pcnet_config() treats shared-memory setup failure as non-fatal and falls
> back to setup_dma_config(). Probe can therefore continue while socket
> window 3 and its reserved iomem range remain unnecessarily held for the
> rest of the bound lifetime of the device. pcmcia_disable_device()
> eventually releases the window during teardown.
> 
> Route error paths after a successful request through a new release label
> that calls pcmcia_release_window(). Fold the existing buffer-verification
> cleanup into the same path, keeping iounmap() before the window release
> when a mapping exists. Leave the request failure path unchanged.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

As pointed out by the AI-Generated review of this patch at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910231400.31919-1-mhun512%40gmail.com
This patch seems to be more of a cleanup than a bug fix - as noted above in
the patch description, the resources are eventually released anyway.

So I wonder if the Fixes and CC to stable should be dropped.

> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Clarify that the window remains reserved only until device teardown.
> - Make the DMA fallback and continued probe description conditional.
> - Avoid claiming that every request failure leaves no resource held.
> - Restore the surrounding indentation for the new goto statements.
> 
> Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gmail.com/

The process nit above notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
