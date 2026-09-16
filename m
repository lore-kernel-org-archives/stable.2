Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133813033CB;
	Wed, 16 Sep 2026 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536514; cv=none; b=t+OWu2FTW1pLg0Q3DLHzQULmyZrBVSrU5Eo9GPjgW4xKSvjNVTMiMvXfRnKowrvFwLRPknYA6s6l/rOif4u37oEhwTVv55hGOk7eRTQJ5cnIX67LY5RROHAhKMnFAYdY24+ZRtGUBjp9g6+ROROC9lhWbpy0OeXrrQ18NYO/9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536514; c=relaxed/simple;
	bh=dkdkd8Lu7qc8W7cHI2YtShJG+Cb5ARVQPtCg3mYi46M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBcVpunFSOrv3LzytRjVJ15dHjjQYREngIt2SyJxNFmC+Npxw7NAbdeZ2DC7V4uK6geWKmQLlNeq5v7heec1akE16SubxwUvEJAsnOXxjUeaTgaDgTxYJxx8CbC+k20g0pV4VlfB8QRAPPSEeXzhoA95iJMrFeSB38bVm59Czm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYZzAj5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYZzAj5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5301F000FF;
	Wed, 16 Sep 2026 05:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536512;
	bh=66PyGPF5wXahXxW5sg6wPuZ0lhWWMmXUKvHfOKoSdYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYZzAj5zgFh920pxLpGKuWZ8NFaBVz6NPYkQGl1EIBxUvvkhG8GyY4i53xxm/U6nQ
	 nLyVV6jbYqY0XmojBX/9D/t9eC1msZQsf/q4508X9g/8PdkVHRolfaIm5e0QrGF7EL
	 3fqdQ9bNXEh7n6NKwybOOZTqlxm1zGMv+JGQDkGihNzMxVOViYveQL+vR4+/SLbL7k
	 yZ+nGRgE8+lk3izvSS+jxsbLmCmo7JRkzZOPJeSeWDQvVkOCLWuuS7MvAv59frQu10
	 WHbdydez2ikJiB0FxpPkRuLPnwAmi9t3ebrIFneJqse6qS+boNZlphsRvVITCnmJjp
	 mVh4BnFZtNlvA==
Date: Wed, 16 Sep 2026 07:28:28 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Gao Pan <b54642@freescale.com>, 
	Fugang Duan <B38611@freescale.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: disable autosuspend on remove
Message-ID: <aqoolBhfLIG1hK8h@zenone.zhora.eu>
References: <20260914091544.1667137-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914091544.1667137-1-lgs201920130244@gmail.com>

Hi Guangshuo,

On Mon, Sep 14, 2026 at 05:15:44PM +0800, Guangshuo Li wrote:
> i2c_imx_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
> 
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> set therefore leaves the runtime PM state incompletely cleaned up after
> the driver is unbound.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

merged to i2c/i2c-fixes.

I applied this patch only because someone spent some time to
review it.

Please, follow Krzysztof advice. group all the patches together,
version them and add a changelog.

Andi
