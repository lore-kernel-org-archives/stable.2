Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26834394785;
	Fri, 21 Aug 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308941; cv=none; b=jNNLPQ+wCi9KqrE2XvAPpTtm2gQ3Pkqp0lYLPO48qtKlxiQaCwW4ygKlIp5I1F6umOtOFTgMffHHLllLeGTD+PMKFPiil2owQpophKTpVKRbumC3VZIropUL2vQAtxKVbNpJEgoFrbQQsLqsLxpdr3FolGZVCLaoil2+fMCZ7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308941; c=relaxed/simple;
	bh=GPEWFCAe8jABWoqqPSwt04wAt6/qFOkQHvs5cY7nNdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCl9wxL3I5UKibRKEfx72ZEKFGHQtEai3Uar8PJNsh8a624Ud6GiEvIeQvmv3lNWCaaGIsvy8cVDgG0+Bh9zRpe6XPhYDhewc9y9NajMMZXDW5TkJpyvMCPrDYD/TXq/nX9++QEY7Zt2+xth6m6ifdIvu1iXPPXM51CL9xdbm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUSP9EIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUSP9EIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BBA1F000E9;
	Fri, 21 Aug 2026 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787308934;
	bh=GX9FyFmbJrKH4U9jR8X9bA/nC9XnQujMg5M2OVoplLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUSP9EIEHGwIWb9aQ1TdnsRNod7xv/XY/5fh7Pi6nQnkgfBylwcPfxZy8+1PYtSKT
	 1PFZ4nD/ixGkGHb8sSTTfG4h+H3n2KaZeVzcQPdxKlJga5GjVhjlULfUQJ20/dsAsT
	 zMFsSE/EFhrvH2WbXtnoJ3L9+oXPg29JlbijE8SDa7Mq5Jt0jFKINfrhQx/mWaXCX6
	 gVsGKsRdpVntMXWAKtmPEwxfO8gYx79K/S3yRVWcE2rwHOegsskSMF6ylPmmpo2pho
	 kK4Cd4YF90NG8jvSQZDjqiZa6qYHEZFoPQQ68kccBuhOOYHkX8OArD+/9WY9F/UIBC
	 GQebispCbUT9A==
Date: Fri, 21 Aug 2026 12:42:10 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>, 
	Dirk Brandewie <dirk.brandewie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: designware-pci: fix autosuspend cleanup during
 teardown
Message-ID: <aogiXF11b7z16U2G@zenone.zhora.eu>
References: <20260809073055.2980971-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809073055.2980971-1-lgs201920130244@gmail.com>

Hi Guangshuo,

On Sun, Aug 09, 2026 at 03:30:55PM +0800, Guangshuo Li wrote:
> i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
> i2c_dw_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")

This Fixes: is wrong because there was no autosuspend here. Maybe
you are referring to:

Fixes: 43452335224b ("i2c-designware: switch to use runtime PM autosuspend")
Cc: <stable@vger.kernel.org> # v3.10+

?

> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 468287922363..f1f4955f9a3f 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -300,6 +300,7 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
>  
>  	i2c_dw_disable(dev);
>  
> +	pm_runtime_dont_use_autosuspend(device);

If I haven't missed anything, pm_runtime_dont_use_autosuspend()
can drop the reference and trigger a suspend, which then calls
i2c_dw_runtime_suspend() and eventually i2c_dw_disable() for the
second time.

If this is correct, pm_runtime_dont_use_autosuspend() should be
moved towards the end, followed by i2c_dw_disable(), which would
then need to become the final cleanup step.

Intel folks need to verify the order anyway.

Thanks,
Andi

>  	pm_runtime_forbid(device);
>  	pm_runtime_get_noresume(device);
>  
> -- 
> 2.43.0
> 
