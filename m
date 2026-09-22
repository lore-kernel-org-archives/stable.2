Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59500542EF5;
	Tue, 22 Sep 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080640; cv=none; b=Oxao0nhw2PRHL7WjroHt/nRuBiKk65o4cNz5W26+DODqpR/YQf8VZVS3ytl5xewLRmCNmrmnG/PhNzAsyR+F6r3XK4IUfzrOehB/AZOQkrbMP1NXpQlPGCRO1U4MZbotueqSb6dL9uZURZ/FdOQ1i734Xru4tvAnr3ZO2FPaco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080640; c=relaxed/simple;
	bh=owHFIll/02vFd6AoMWMI2trbfPhi7DsWdtwl5tP9lns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK7fIFCpoq8Ub5wnB5JHBKiY1uhtEBSzIJO4F7FbaYCQ3lPaCHnWVywRxwq6TVqEsbrGfgYt7SX5I0r7h+0brm9AqomByh9hBlM0VDfXAfmLBT9RfxupFdYCawwnFB9cPr2/kinxEttcBRnIX2976lyXTOHxiZdGQiNk7Q1IUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0CP/5Fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0CP/5Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683AD1F000FF;
	Tue, 22 Sep 2026 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080637;
	bh=oM2vt5ZWSSP8Hx/7WSzLEjgK4Cq4XVZp8JbfwooMOeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0CP/5FmiGxT348+52Ei3xecF880hPehRoBnh5em3UilDbIsvdjcKALgcKzPiZWgq
	 s38SbSPdJOdKVy2+x0RJu9AGcaLfPecrT5ZevrlxeyYdytPf0RVBAvA7fECye6Yclq
	 2veOxv4e1BbuXAWDpVTWVsKxohFoMiHl2ugPuVbKeRE6673YWqQd3SfOO3A8mYhMJa
	 nQfvjsprPf5QJ+An0ajnscCEt2e8d6x3UIJwE0ekGfPHh89h5YoQtj89UL/YGItPtM
	 iX5w6Xx1ZQysecKo0mN4GfZ8KvwAB6dS9w4Jmkn4fMmO/dK+osf4zOn15LzKj1sn+m
	 6l4na0aQg20YA==
Date: Tue, 22 Sep 2026 13:37:13 +0100
From: Lee Jones <lee@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jan-Simon Moeller <jansimon.moeller@gmx.de>,
	Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: Remove sysfs group on allocation failure
Message-ID: <20260922123713.GE3277918@google.com>
References: <20260915020600.91955-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915020600.91955-1-mhun512@gmail.com>

On Mon, 14 Sep 2026, Myeonghun Pak wrote:

> register_multicolor() returns on allocation failure without removing the
> sysfs group created by blinkm_probe(). Remove it on this path, matching
> the helper's existing LED registration error cleanup.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/leds/leds-blinkm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -691,8 +691,10 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
>  
>  	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
>  					GFP_KERNEL);
> -	if (!mc_led_info)
> +	if (!mc_led_info) {
> +		sysfs_remove_group(&client->dev.kobj, &blinkm_group);

If 'blinkm_group' was created in blinkm_probe(), shouldn't it be cleaned up in
the error path of 'blinkm_probe()' rather than here in the callee?

>  		return -ENOMEM;
> +	}
>  
>  	mc_led_info[RED].color_index = LED_COLOR_ID_RED;
>  	mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;

-- 
Lee Jones
