Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB43E7BD5;
	Sun, 13 Sep 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304016; cv=none; b=XcAfeEv7INYiAJKjVCEB3fDPkX1aFPHph6qTubMx3N4g6dNuKAX21B0UJWsVXGDeE+N+GhEW2IGCvAMZJ8QpI+9/PvwPODa5qXmejngIPhZWL+zVffunYGDVky6Q6MadFA2rcV1tvnqw3OErLa/GNY7QklPEFIYvxCPjhjO8fHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304016; c=relaxed/simple;
	bh=Rmbvzu07RO229VVu5Lzel92B01b/WTH3yHYQzFz3jkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anb6hqGP37OHJs98fKNgUP7wKLSbx6831SZkG4xLMFg5rKVwV3j9pCFwdEsXUeFfBGdhIE+AwPsQpV/ZqZOsZfuva3SHNjD/qQ/6WkgD+3+iMULx/Us4kttb+kyhzIbC6lAlDJtqcDoBYDUtRKjSLAJh9xvMFnCmUR0QuqJWqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 95EBF2958;
	Sun, 13 Sep 2026 14:53:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6F5C36280A04; Sun, 13 Sep 2026 14:53:24 +0200 (CEST)
Date: Sun, 13 Sep 2026 14:53:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Haowen Bai <calvin.bai@ugreen.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: pci-quirks: abort xHCI handoff if MMIO is
 inaccessible
Message-ID: <aqacxOz0jPWIfXGs@wunner.de>
References: <A8558181A93455E3+20260906162614.26940-1-calvin.bai@ugreen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8558181A93455E3+20260906162614.26940-1-calvin.bai@ugreen.com>

On Mon, Sep 07, 2026 at 12:26:14AM +0800, Haowen Bai wrote:
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1026,15 +1026,22 @@ static void quirk_usb_disable_ehci(struct pci_dev *pdev)
>   * Returns 0 when the mask bits have the value done.
>   * Returns -ETIMEDOUT if this condition is not true after
>   * wait_usec microseconds have passed.
> + * Returns -ENODEV if the register reads as all-ones (hardware removed).
>   */
>  static int handshake(void __iomem *ptr, u32 mask, u32 done,
>  		int wait_usec, int delay_usec)
>  {
>  	u32	result;
> +	int	ret;
>  
> -	return readl_poll_timeout_atomic(ptr, result,
> -					 ((result & mask) == done),
> -					 delay_usec, wait_usec);
> +	ret = readl_poll_timeout_atomic(ptr, result,
> +					(result & mask) == done ||
> +					result == U32_MAX,
> +					delay_usec, wait_usec);
> +	if (result == U32_MAX)
> +		return -ENODEV;
> +
> +	return ret;

Nit:  Checking for PCI_POSSIBLE_ERROR(result) might be slightly clearer
than U32_MAX.

Thanks,

Lukas
