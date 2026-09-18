Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C581F09AD;
	Fri, 18 Sep 2026 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723863; cv=none; b=uT9tD/Gxk+vUBpEEHmS+gS1pkXysOikz+5onD1ufjYhsd9fsxmijYYDCVHqhDR+xDXDJAfKGzSOz/97Mvn3byjLuAH5Te8ORzg08AtJAW1F53ovcg2v6D4WvRHXtOc8bNdvhrBptA1vH9wRHTd2h4FRZ6Y/0R7N4n0ll33QaAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723863; c=relaxed/simple;
	bh=L4YM+nBivMLSNNtlGU9JKIs4iMpnJtMwEQj+J8hlrd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AosQmBBfFm/j1TyK3DYFwaXVl2yvHnXyuRWyXCxz/RQZia3r2ANGjL+WNe4D8UpyI9+LqVwACgHUP7eFJrOOHkEFRSFv7i5YjF/p5rOAaxzga/KVk1LIoGFc9w/tNbJJ+a6kv8URzKhGSpWODvZnee/zfyirL5QRoDhLALKRaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1uBqEnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1uBqEnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538861F000FF;
	Fri, 18 Sep 2026 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723862;
	bh=jUkv5B4pUOLxWKcrJ90ETrNmPqz8J2MnsOKX2jmyHv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1uBqEnNDp4mapzjtRXODSu6/BBte8RVWokujt+OS4A12yrHyExHF0j7OXoB0U0LO
	 VCwOZBeCBbPPusOtU+vU+Lk6/uEc6GfXvxkQjTBvIsrYP+IO7yDC5ceHdu7LXCpn5u
	 BpMNelI/Z2NsM/MxxtaiFMsJtx5LBCKOATr1qAorj6Jt6jzowkjovGJCQ/rIVyaAxI
	 fxs4Dn/bWwSPqytRV8RRsmCxGu1bMYFg8/mdPvuVeJnOW/TObFWznWQjMU7RSRZ5Ds
	 u7AP4mTm1GTBzAznQTTvD+Rs4gkjOtJzpXhzX5zH8xsoLxS//lK9aeBIg9ZeCBvZRE
	 IojTcHoJa044A==
Date: Fri, 18 Sep 2026 10:30:56 +0100
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fs_enet: fix platform info memory leak on remove
Message-ID: <20260918093056.GG51261@horms.kernel.org>
References: <20260916031414.2875022-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916031414.2875022-1-lgs201920130244@gmail.com>

On Wed, Sep 16, 2026 at 11:14:14AM +0800, Guangshuo Li wrote:
> fs_enet_probe() allocates the platform information structure with
> kzalloc_obj() and stores it in fep->fpi.
> 
> The probe failure paths release this allocation with kfree(). However,
> after a successful probe, fs_enet_remove() tears down the network
> device without freeing fep->fpi, leaving the platform information
> structure allocated after driver removal.
> 
> Free fep->fpi before releasing the network device.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

