Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D5375AB1;
	Tue, 18 Aug 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077397; cv=none; b=CH+TdTvowzza3RI+wmGP33DssKA8uRLQhFFUlt6A3BmNg4yRucgxH3A+5KydpLA+sIk4IwRivafZyIjP66yWDP4x9uQfMtHLoPjEFIRyiydNbO4rxNj/DICoZkmnyPOLh4DiBbd99jxZMQSnANyn14lCKVJpCTBd/qbyewX2WyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077397; c=relaxed/simple;
	bh=5Evpp+U4fHPOJ5zgWws8ZtPMBLpjNrqaYYN2Yx1XsS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JryfTTUsvNCl/TFFqEOoefJ9GsFn3tknnukjcCSR8V4ISV/8brm7HRw7Jxq2pMBRucxQO1qak25EIHohRrAbG/yz8WuP+G2s6Djc1hhcE5jXRDRo7KFK2oAuXdh1vyces9Va8kJV+PbW5gsnjTvRchUroNe3JzQ/vaR/69o/YHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLU3gu0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLU3gu0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A11F000E9;
	Tue, 18 Aug 2026 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787077394;
	bh=posjS38abV8AgqqIdl+8RlYKAuivtT7vrcQQbTN1Pw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLU3gu0tuKBYVlDMHu3kyJCp+JhY0JDFG3INrpueeDYJ2uQ8l/vFZtKx66q+BbGU7
	 Ijf4AxMqcSexyXVXtne2b/dJ6DhSJZNGqdE6xDaTP/gDMi4BWF/bEWblACD4JAgW/k
	 bRhEHdYcnyZw7ruen2O0g5auBWmsqlHq5lWNMmnc=
Date: Tue, 18 Aug 2026 20:23:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Kris Huang <huang_kris@projectara.com>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] staging: greybus: light: initialize channel lock before
 registration
Message-ID: <2026081801-arguable-gosling-c590@gregkh>
References: <20260818142020.1989539-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818142020.1989539-1-runyu.xiao@seu.edu.cn>

On Tue, Aug 18, 2026 at 10:20:20PM +0800, Runyu Xiao wrote:
> gb_lights_light_register() registers each channel before initializing
> light->channels[i].lock. Channel registration exposes the LED class
> device and its brightness callback, which later takes this mutex. A
> concurrent brightness update can therefore hit an uninitialized lock.
> 
> Initialize the channel mutex before registering the channel so the
> callback always sees a valid lock.
> 
> Fixes: cc43368a3cde ("greybus: lights: Control runtime pm suspend/resume on AP side")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/staging/greybus/light.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 38c233a706c4..056ef6b0276e 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -1043,11 +1043,11 @@ static int gb_lights_light_register(struct gb_light *light)
>  	 * found.
>  	 */
>  	for (i = 0; i < light->channels_count; i++) {
> +		mutex_init(&light->channels[i].lock);
> +
>  		ret = gb_lights_channel_register(&light->channels[i]);
>  		if (ret < 0)
>  			return ret;
> -
> -		mutex_init(&light->channels[i].lock);
>  	}
>  
>  	light->ready = true;

How was this found and tested?

thanks,

greg k-h
