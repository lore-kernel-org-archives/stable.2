Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F744AB99;
	Wed, 16 Sep 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545316; cv=none; b=RWBTHDk2+cpHT6Qu0r4zZe6j4JIoB1xplRdqNMmZPZF/nyjBuMrYG6hjlIDMLxRweAkCrh/R8J4vVTZYVZ2OTaRuWyBnLJQwKHDChnIxJEox+dFbnQyyUZen7a6Yn6QG49/B3qhb6B1ug5GUnncN2F2Inac5XyaOFHZfBe5skmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545316; c=relaxed/simple;
	bh=9Rd8d95hEpOJYJ2mI4ASMliBx8UmGzrU/6eJWBBaIrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2Wcvl54JpWv6wTQMrvQ3i8uBvWA8vBHOr0GpInahAxGfk8creILYgeBNcm43haEIwznkOBratkEjp159ek7Q8DuTp+YfpIeVm2APfAv6dK1qY5DyiqNnDzgkHIFGeyvDEEIM76h1H53OudgRTI2LMrPLUhePJxQ2aSn+Gkg0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4HuU9qP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4HuU9qP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9851F000FF;
	Wed, 16 Sep 2026 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789545295;
	bh=AOOVeEhMXHUth3pKN5g2yqVlA3AWASmnH/ahqGp2blI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4HuU9qPnj/YiMZuH8XrjsESnxBLLVv7ksxAj08+vmeU2FPGVs/vU/S6IW7XhIFBd
	 WLEveOLf39NTi1zh6Y8QuwzCnFpLgNG2Qy0jWGatYw5MsdkyDKeZWRkDDnfagEQr4m
	 RUKUX0RFiZ5Oepd0rEcyxEPM6cwZR+zoRrSQ/l44=
Date: Wed, 16 Sep 2026 08:53:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, perex@perex.cz, sen@ti.com,
	tiwai@suse.com, zonque@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in
 __davinci_mcasp_set_clkdiv()
Message-ID: <2026091637-earring-unsoiled-270d@gregkh>
References: <20260916073136.1971673-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916073136.1971673-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 07:31:36AM +0000, Wentao Liang wrote:
> In __davinci_mcasp_set_clkdiv(), pm_runtime_get_sync() is called at the
> entry of the function. If an invalid div_id is provided, the function
> hits the default switch case and directly returns -EINVAL without calling
> pm_runtime_put(), resulting in a runtime PM reference leak.
> 
> Add pm_runtime_put() in the default case before returning -EINVAL.
> 
> Fixes: 4ed8c9b737b6 ("ASoC: McASP: add support for clock dividers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/ti/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)

Did you forget an "Assisted-by:" tag for all of these submissions?
If so, please fix up and send new ones.

thanks,

greg k-h
