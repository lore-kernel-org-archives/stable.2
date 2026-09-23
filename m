Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A447ACD3;
	Wed, 23 Sep 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158737; cv=none; b=lXPcFAayxWzo2umWft0sQz3oDFvYJkQPH+gcgcblgFAJQNj2vZoN3oOSeDz2XnXXzsNxk6rQ5GVDOL60VpUkfUh3t7dUVgjywpIwlqZx94O12RJOaA4Eixlzk9g7w/LwKR7no2cQ04R2T2V/cx3QCG9cTcP18LzPmGG9sdDl7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158737; c=relaxed/simple;
	bh=V4Q2d9SWFRSulhmeW7JCxPpkN62U7tLTlpAffBZcLe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS1982lTs+VDGtPhemyBLfEDyD6Iq2HenNp87dNtF/rg7+tHQz1L734fP7H6uu6blRsd/rRctrtTDhWHlYInGk82FigJHmOtLzbE5fAllWEjYIFEDwCDyoa4J3LNdpsDfxbMCma5uOrRYw0V0A5LuivoLjk7eFGZuMNvug218Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k85fmGbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k85fmGbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4001F000FF;
	Wed, 23 Sep 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790158732;
	bh=LBU0qSMwIeK+091WkCTVnhQHPJJhzuQXB+5jtMYIaEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k85fmGbFLLC4zSYE+ACyEAOp6EpqyHRfyvSEq2YEjH69ogl2HSePyb7gJjbcWGVUN
	 Jhr1fnBXGfKBF/bkwTz2LgLvxGvx0VieZvqYs48UQbB0L3N2/EU/jU3jAEc2GsnoSY
	 sNxBCPUHWkI+1PzEQtvhsqzLxPVuE5xAsHv7ebCw=
Date: Wed, 23 Sep 2026 12:18:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: icom: Disable the PCI device on final adapter
 release
Message-ID: <2026092304-splendid-lego-7601@gregkh>
References: <20260915010000.52974-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915010000.52974-1-mhun512@gmail.com>

On Mon, Sep 14, 2026 at 08:59:59PM -0400, Myeonghun Pak wrote:
> icom_probe() enables the PCI device, but the final adapter release
> never disables it. Balance the enable after releasing the IRQ, mapping
> and PCI regions, while the adapter's PCI device pointer is still valid.
> 
> The imbalance is already present in the initial Git import.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/tty/serial/icom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
> --- a/drivers/tty/serial/icom.c
> +++ b/drivers/tty/serial/icom.c
> @@ -1691,6 +1691,7 @@ static void icom_kref_release(struct kref *kref)
>  	free_irq(icom_adapter->pci_dev->irq, (void *) icom_adapter);
>  	iounmap(icom_adapter->base_addr);
>  	pci_release_regions(icom_adapter->pci_dev);
> +	pci_disable_device(icom_adapter->pci_dev);

Are you sure this is correct?  Lots of time disabling the device is not
what you want to do as it can cause hardware problems.

Have you tested this on the hardware?  If not, I can't take it for
obvious reasons.

thanks,

greg k-h
