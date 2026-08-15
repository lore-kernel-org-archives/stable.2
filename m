Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443921B4223;
	Sat, 15 Aug 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786765073; cv=none; b=mNkhs/ZsxtRUTs0Aa5jK93+GDn/cVLC7JmpBJWQXfZwOfEXptY8icV3RCVECUXDMQ3gsqXU0j9R8a5nAM+0MqZV3G+x5b9F6IEYG/C7njNyqrgbgWDeFriSz1D7lxV7S0agtE2vP3zzRr+TrXmBvJPS+klIDWZKAB5dBCS9b2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786765073; c=relaxed/simple;
	bh=CXuNB2kiCORPhPAPXeTaXWwgBguOo2oOKSAH4g6OLw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNB99pZVHrz5/6zXSgotDQGknFpWfOAAmBbSdPgoEtck1mMUgdBqihzkLJpj/UCiFnznHmwy8SY8v2vQfMj/cfMkj3YcO7rUDuxq8AUhha8ZTQTzM0fbXxGPvtG6HxQY0QlcOcXchPCWia+IBkA9lqEfGqeu8DCZsyo96ahNbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYCI+8mV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYCI+8mV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279BF1F000E9;
	Sat, 15 Aug 2026 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786765071;
	bh=PaAdTT6dJZzqvTlK77BRFSc6W5awSJtVOHwG1MbRn68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UYCI+8mV+3O1DV+MKGe5qzvflPhM0P0gWICdTcO1Xn4HD0TOXyvBSV7onUYP8Bma+
	 ezRxXFzM45x4oEbHakrbjsTnsiUrEpB5SIIWJlTB8UTMCYnyvmVfNGaSqvMmAUZ3r4
	 /yaKk1iC75qGc53BwGypPUVUD+QTSzXgbvqWXOz/XY8A6TCDweUflIZndyF8smw/W0
	 PKL4U1GjSr2Ynhw2c9OU8qGLch9XQdm9ji+fm7LLWQUFq9uQK2W5f5+w3R9LzhyKci
	 AbmDz9JyqEQ/kZSiTibvBBUM5D70/tLbRF/9yeQfnP1Ayntha4pyuXatgXwZyR9l2p
	 Y3B27AG3j/5AQ==
Date: Sat, 15 Aug 2026 04:37:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry
 <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li
 <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 5/7] iio: light: ltr501: Fix duplicated error message
Message-ID: <20260815043715.5ec442c7@jic23-huawei>
In-Reply-To: <20260810-liteon-ltr329-v4-5-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-5-8bd3dfd15280@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 09:11:15 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The dev_err() message was causing duplicated error messages, as
> devm_request_threaded_irq() calls dev_err_probe() on failure.
> 
> Fixes: 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
Not a fix.  This is tidying up.  All good, but we don't want anyone
to think this is something to backport.

So drop the Fixes tag and tweak the patch title to not say it is a fix.

Drop duplicated error message
or something like that.

Thanks,

Jonathan

> Cc: stable@vger.kernel.org
> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/light/ltr501.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7746d374688f..b36bd10a0262 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
>  						IRQF_ONESHOT,
>  						"ltr501_thresh_event",
>  						indio_dev);
> -		if (ret) {
> -			dev_err(&client->dev, "request irq (%d) failed\n",
> -				client->irq);
> +		if (ret)
>  			goto powerdown_on_error;
> -		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
>  	}
> 

