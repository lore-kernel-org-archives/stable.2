Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44F4B95D3;
	Fri, 18 Sep 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729601; cv=none; b=GOhNZUs0Hx1u6ahmfl6j8Lr7WvwQS+tLV3G6ZbfHPl3yk8M9l8DPilYgXMBxJcKdR7mnY3ehyF6vvlVKCAygkru6XzxnBNCkKv8VNWpWAz/foNe3/NroGnPYlEMR2j+NefJniJTr0PP3Ak4t6/3J2xm5EXh6oVn9MjwOq/oM6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729601; c=relaxed/simple;
	bh=2LcYaKFqWuWLta6ByL1x5bf/A2m1sgG808OsjWIy5aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frLaNXvPfIQPldZfrLsKD9KLEeZlHGI8HKuzD/+WQC4gadRUWENb2NsjgdCyLVfmVwSgken80op3eR3TDfBK3LKsIKz+6OtvhmjwYWqVa8hxzaUA8eZk52Me9f/MjIN+yDhtuO3encgFH4uzojagBTm7bFlh32CQDcpS6HEFtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y++TS9hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y++TS9hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843ED1F000FF;
	Fri, 18 Sep 2026 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729593;
	bh=tgE903lqGo7vvR+PuWF3iT3wDxPGZNkxDy8t2KwkczM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y++TS9hrIVui+YrRZVQoWKOK8EQL7oabi4nzofHq5sr8Z1injXDGsjT1w4nOkSI8R
	 AwVKE5DiM+GUsEVl8GprDFQYJbvUTKVdN1sS2xkdNnPe1ZWxJzS8nLO8czZlv0MZ5F
	 HYY/RJDH2vMyk0jcP3KMvVcaAe9RNWUTHhxpcTOR4vZ7YttEoucS+5A4fx5ix9DFkU
	 5gsDhHj/Hhu8avIXjxgJ28y3Xq9f7F8islH0bGUP3p8//73cfx+a3EY1ni+FbiLK8S
	 XqLm+XXG26CzzkXgwk0l5m1t+Rk4VEHOQ1JJZ2/5ZQAFB+CXRkea7WKP77RcH5qQEl
	 SEvF2HgKcsdiQ==
Date: Fri, 18 Sep 2026 12:06:27 +0100
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Samuel Chessman <chessman@tux.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: tlan: disable PCI device on remove
Message-ID: <20260918110627.GH51261@horms.kernel.org>
References: <20260916061056.2917164-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916061056.2917164-1-lgs201920130244@gmail.com>

On Wed, Sep 16, 2026 at 02:10:56PM +0800, Guangshuo Li wrote:
> tlan_probe1() enables the PCI device with pci_enable_device().
> 
> The probe failure path disables the device with pci_disable_device().
> However, after a successful probe, tlan_remove_one() releases the PCI
> regions and frees the net device without disabling the PCI device.
> 
> Call pci_disable_device() during removal to balance the successful
> pci_enable_device() call.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/ti/tlan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
> index 274a1837025c..0a8bed6c9ca0 100644
> --- a/drivers/net/ethernet/ti/tlan.c
> +++ b/drivers/net/ethernet/ti/tlan.c
> @@ -302,6 +302,9 @@ static void tlan_remove_one(struct pci_dev *pdev)
>  
>  	cancel_work_sync(&priv->tlan_tqueue);
>  	free_netdev(dev);
> +#ifdef CONFIG_PCI
> +	pci_disable_device(pdev);
> +#endif

I don't think that you need the #ifdef and #endif lines
as I believe that there is a noop implementation
of pci_disable_device when CONFIG_PCI is not set.

Sashiko seems to think so too:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916061056.2917164-1-lgs201920130244%40gmail.com

-- 
pw-bot: changes-requested
