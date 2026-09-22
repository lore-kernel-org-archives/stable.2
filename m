Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB63C10B6;
	Tue, 22 Sep 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062903; cv=none; b=qNhKBJ12J1TemN8Z9qHVXYpIJd78pPwQuAKN+Ig4vBqbdGenkZ6aeKzydmGbdmUBB3Pr2UW/SHIsQ7wsSidAstJPOHSpJnKGdkrwoR4GmuZ4Eb5CcPDA6/cUI8X66G1p7ntCOQ3lQIl4M+xzjt+8ZfmT5O6aoGGgyKObvNr/NSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062903; c=relaxed/simple;
	bh=MRWKgY82CUpg1snH7yiPJ9pyoG6UUlyyvgwUzZlGFBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc9GsFqxP1ZjmTZyok+C0hNibm95WUDrZQmZQ9BqODBVOqAGS/cypbXrQqkwEXf/SzAjWjzry/lArVTzHuicI9PzSqfYgvFPz+vdtaqQrWKUeoCMeIhZ+oudG7G6FuTpEluThG/hut5iWlOUlAqz2B1Mj/wbkNva7pU1vwtJCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5V7onsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5V7onsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D291F000FF;
	Tue, 22 Sep 2026 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062902;
	bh=m6RhWUuU6In2Zao3hDUD1vpbLTCibSWwKZ0cfNwJQ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i5V7onsuosKcdKoiqRfPOCnWfZ2CiYRXzhjx9nFZuIUX+sft49fNq66YfjbzPgq6f
	 8lw7XLrEwOV2fvWwZAgMpybUwJtpfXNhXlPZA7p3pLJ318DJ1P0WdpsvJZFQM3+vYR
	 Lin11/XNWefPyfz0/1PHvpM5eyLTgL6dnaZdXjjoTpy+68ehe1u4fANmm/mL0ETOGr
	 hKbAF2A67GyJ7vzF1zmKywYv6t8tH5OymhfIboRGqVvzhLKFYwzZtPdKN7cq9AhFLG
	 g5weevg3I2MReX3F1PGBO51j4hFsbnafnXd9hK/X6cqaCLoZUVYFgDYlGpfzxxjFcE
	 lU+0A80KquMZQ==
Date: Tue, 22 Sep 2026 08:41:37 +0100
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Ludovic Barre <ludovic.barre@stericsson.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Julien Delacou <julien.delacou@stericsson.com>,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: fix child device leaks on probe failure
Message-ID: <20260922074137.GG2348773@google.com>
References: <20260921110909.370945-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921110909.370945-1-lgs201920130244@gmail.com>

On Mon, 21 Sep 2026, Guangshuo Li wrote:

> ab8500_probe() registers MFD child devices before completing the
> remaining device initialization.
> 
> On AB8540, the main MFD device batch may be registered successfully
> before registration of the cut-specific batch fails. In that case,
> the probe returns without removing the child devices registered by
> the earlier mfd_add_devices() call.
> 
> The same issue occurs when sysfs group creation fails after the MFD
> children have been registered. Since the probe returns an error, there
> is no later teardown path to unregister those devices.
> 
> Call mfd_remove_devices() on these error paths so that MFD child
> devices successfully registered earlier in the probe are properly
> unregistered and released.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
> Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mfd/ab8500-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index f0bc0b5a6f4a..e675223b6023 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -1220,8 +1220,10 @@ static int ab8500_probe(struct platform_device *pdev)
>  		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
>  				ARRAY_SIZE(ab8500_devs), NULL,
>  				0, ab8500->domain);
> -	if (ret)
> +	if (ret) {
> +		mfd_remove_devices(ab8500->dev);

What about switching to devm_*() a.k.a. managed resources?

>  		return ret;
> +	}
>  
>  	/* Add battery management devices */
>  	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
> @@ -1243,8 +1245,10 @@ static int ab8500_probe(struct platform_device *pdev)
>  		ret = sysfs_create_group(&ab8500->dev->kobj,
>  					 &ab8505_attr_group);
>  
> -	if (ret)
> +	if (ret) {
>  		dev_err(ab8500->dev, "error creating sysfs entries\n");
> +		mfd_remove_devices(ab8500->dev);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

-- 
Lee Jones
