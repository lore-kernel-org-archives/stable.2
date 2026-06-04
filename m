Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116C3E6DC9;
	Thu,  4 Jun 2026 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574037; cv=none; b=Ki/g/YfYKhECiiUx8D6FcEbKLItcNfN7+/cJ+EnPVVggQgaq4knQ12T6gXrFS84ej7UyiO0uXnpUgJd0685BNWgEnNxq3BzRpmie1/FLUlpca8HHKHGPIrvz6nLcOFdWQKPg+vqEh1pg19SBlIDyhnNubp5KSbAp5cU54+LyGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574037; c=relaxed/simple;
	bh=6d+LAJ/8/MPqpBMB9iCCLJB///rRRwig9N5IRGC1HmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azitKN4Es0sxPWscsFHhxe7nmVXSdfHh8CbtPu14sqHGQLljabuheKrMS6D5cNBY+39iMdcy9UN/FGMtIC3Md+7vxJuIH9xyhsd6vrULaoMvXi4q8xd8nf0mFpWYFFHCY72l4qkTLETrU3c21PESrrRRO/mP22wyjPjtNwO8Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fka9196a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fka9196a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF491F00898;
	Thu,  4 Jun 2026 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780574036;
	bh=7a96hgGOYIUFEYtBJ1ZoMVbVT8wvXDwq0nYMad7gIU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fka9196aNrRx75DGhKux4dKzI1W6tLEsc7sWIQjf0VphgasGcjPT95LRFuJD1d9P7
	 THJHVIuXBVx4pErt/3ZEznFvmoaKcA9bJHK7oU5N3WRXJhm0VSZoBaIOwIK+P/1fhC
	 uZqyXjsivh2j/9xa0ml6+WG8G1NFY83Op68qWl8Ngwgl2iE9ps01try99WgHgaZ7Xh
	 AbnU9U8Wl6Fg6ulCR0/ofs5CRMhkSwGGZXtUKT/Nu4QaGxF2bcDP8KPuYVAELHFVKp
	 flYM7KZdn7TkfpYE4pnKqiKzH4qBpPODXEJp7rfJQErXCAsoi+liBXBMn0iub7ownQ
	 MuV700BSgtRCQ==
Date: Thu, 4 Jun 2026 13:53:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_brcm: fix refcount leak in brcm_ahci_probe()
Message-ID: <aiFnUGp8PUrET7mv@ryzen>
References: <20260603103008.3741481-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603103008.3741481-1-vulab@iscas.ac.cn>

On Wed, Jun 03, 2026 at 10:30:08AM +0000, Wentao Liang wrote:
> When reset_control_deassert() fails in brcm_ahci_probe(), the
> function returns without calling reset_control_rearm() on the
> previously asserted shared reset control. This leaves the
> triggered count incremented, leaking the reset control reference.
> 
> All other error paths after the reset_control_reset() call properly
> reach the out_reset label which performs the rearm. Rework the
> deassert error path to go through out_reset to restore the
> triggered count and ensure the reference is released properly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a0600d112e3 ("ata: ahci_brcm: Perform reset after obtaining resources")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/ahci_brcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 38c63d73d210..b58343f027cf 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -492,7 +492,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		return ret;
>  	ret = reset_control_deassert(priv->rcdev_ahci);
>  	if (ret)
> -		return ret;
> +		goto out_reset;
>  
>  	ret = ahci_platform_enable_clks(hpriv);
>  	if (ret)
> -- 
> 2.34.1
> 

The code in brcm_ahci_probe():

        ret = reset_control_reset(priv->rcdev_rescal);
        if (ret)
                return ret;
        ret = reset_control_deassert(priv->rcdev_ahci);
        if (ret)
                return ret;

        ret = ahci_platform_enable_clks(hpriv);
        if (ret)


The code in brcm_ahci_resume():

        ret = reset_control_deassert(priv->rcdev_ahci);
        if (ret)
                return ret;
        ret = reset_control_reset(priv->rcdev_rescal);
        if (ret)
                return ret;

        ret = ahci_platform_enable_clks(hpriv);
        if (ret)


This makes no sense.

The order of the resets should be the same in both functions, since it is
different reset handles.


It is probably easier to add a new jump label, so that there is one jump
label per reset handle.

That way you can jump to the correct jump label, so that you only perform
the opposite of the reset that was actually successful.


Kind regards,
Nilklas
