Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64372F1FEC;
	Sun,  2 Aug 2026 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785714082; cv=none; b=KXtJ6H540hnaBRc1AtvoChj1QmfFNtEbp3anbeFfVbXetToTIYH0ykqoWXP2t/QkT1VrdVGCBPbTQmpdfTX+4Sx3PsTUZgRPKhwOdGyWHe16wfxyvoSMTAmSR4ew5bVX2M443zrPJotBYFiHcU0+AdtpMNRpQ0ruDSfd1dOPdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785714082; c=relaxed/simple;
	bh=saInv1esiO8O6zHPyX+ufBsfM4xEBN9JSeDDHbAsSpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieuIMi2/RJJvHGxSlIQ0zplfmni7FZuV99K5V8WlzBNFcBjorxXL9vHb2ZF4PP1gMXjZKxj/YzpraMpiQQqsvXy9ewisi457Sr0YhczNG9wP8eEhgShdWmiNHhG4qFDSKVA7Wyif1rJH1esSm115qLXxSnXEnAhLKREr3iWqfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8pgiA5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8pgiA5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B986E1F000E9;
	Sun,  2 Aug 2026 23:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785714080;
	bh=baRHJ5pCzhbJNIZ1mXCf1/EuHtWXAmVKciU3amIoVMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z8pgiA5pLaCCCtflNoXV/PNdqlw3pJ2rg7eK3a0WzBJ02dFr28ZGuS2E8ZunI905K
	 C2vS4V0aNz7N6bznJlidsFsfJT39UCUfyI0iWsC11bd1nBB3jki//j0X++O9nB0RhR
	 YVQIyFEChHNEXboSaUY6kmATNx+xKSv35GACnj3Mh0N1FWdWeRJERYhE5d0ORNxi01
	 hLaEmLOjfd8vSyKD8BzFnejWCrJNm9f9kAfYRO/NDr6+3GLfUTHEf6Uw+GYMFD8C1b
	 Fo0Pg/mTs1J4hsov1f+ghL/N9geL3iDWMkOGUrdyGzN9Znlv2DuNz6Gcp8IFgi42yW
	 8nvPi+p3WaicQ==
Date: Mon, 3 Aug 2026 00:41:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: dlechner@baylibre.com, subhajit.ghosh@tweaklogic.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()
Message-ID: <20260803004116.7e97cb68@jic23-huawei>
In-Reply-To: <20260802190701.10685-1-mokshpanicker.7@gmail.com>
References: <20260802190701.10685-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 19:07:01 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> apds9306_read_data() calls pm_runtime_resume_and_get() but several
> error paths return directly without calling pm_runtime_put_autosuspend(),
> leaking the runtime PM reference and preventing the device from
> autosuspending.
> 
> Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
> automatically handle runtime PM reference release on all return paths.
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Note however that I'm not planning to do another fixes pull request for this
cycle so this will go upstream during the coming merge window

Thanks,

Jonathan

> ---
> Changes in v2:
>  - Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR()
>    instead of goto pattern as suggested by Jonathan Cameron
> 
>  drivers/iio/light/apds9306.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 5ca4c87524fe..d582bda4d847 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -469,9 +469,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  	int status = 0;
>  	u8 buff[3];
>  
> -	ret = pm_runtime_resume_and_get(data->dev);
> -	if (ret)
> -		return ret;
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return PM_RUNTIME_ACQUIRE_ERR(&pm);
>  
>  	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
>  	if (ret)
> @@ -535,8 +535,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  
>  	*val = get_unaligned_le24(&buff);
>  
> -	pm_runtime_put_autosuspend(data->dev);
> -
>  	return 0;
>  }
>  

