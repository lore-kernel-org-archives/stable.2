Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BF377A9B;
	Fri, 18 Sep 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723451; cv=none; b=FgtqS/Q2D87qB29fJFX3Qwr0kP7L1ixCm2VJaQazSE3OYo5BAwjbB0myCxfoRd7PVE5vlcxwktHqFQtifR+XlvlA0RSsxhbyTP4EiNk9zGmKqppJsOjv81hXgR1gSQhAIn82OCcX9/+JQ3hW9kwkpq4peQojxs4uYuqXaoOldfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723451; c=relaxed/simple;
	bh=RY8PncdFeWsVFlLeJylMxLlR9z1bC2lIoHu4PyY6Qrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JczJdJi7aqoMtAfDUNrByBYGitNVKVI5M56AeoguL4n0boLB70Gyk5hQTU1mcv1gDSNg+g+YI176yLxB/2ctUsV++cxghiJALJnqiuHY/cyzrdaoioSifstQ1IrgVqarR3OJbUq3I+ipyIP/AbF5piYDLVij4Ya4EIyqWigPxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1fHzUmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1fHzUmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128661F000FF;
	Fri, 18 Sep 2026 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723449;
	bh=3AyPjWu4Gl0yX56nO/NLviif3j02J/T6027fVk46sWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y1fHzUmTY6xJdh3xAeL1nIj/NFGevYq92scK49asLxP5JPN0jllIKza+b107haWAV
	 bw27IMYN7F/gnZcZgyp7zn08A0ykr9vXn00E/o8vXJ9EqLsWgkwLliyiudY1sDTVHs
	 l6rWlvybG1h803Uy1SSV4aND4nudjPaqFC5DO6zeNiLDsIoPPsB37G3Ni6kctBDDS4
	 QFWJS0DhSzKQ5hzVrKnkSM0PoSiUBr9KtDfqSfj/deBmPubm9WWMpclLYbVBc9LPrh
	 CYqkbKwSflAHkBhrQFJ4tJ9nbDuWiZgZp3R3H85x7Rqn7wfaGC6PUvo99yYVP0uN9F
	 gW4i/WcjxlZHg==
Date: Fri, 18 Sep 2026 10:24:04 +0100
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
Message-ID: <20260918092404.GF51261@horms.kernel.org>
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
> ---
>  drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index d3c772ed5fc9..071e3f3de78c 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -1007,6 +1007,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
>  	fep->ops->cleanup_data(ndev);
>  	dev_set_drvdata(fep->dev, NULL);
>  	phylink_destroy(fep->phylink);
> +	kfree(fep->fpi);
>  	free_netdev(ndev);

Reviewed-by: Simon Horman <horms@kernel.org>

