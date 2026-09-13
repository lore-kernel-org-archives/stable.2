Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25158379993;
	Sun, 13 Sep 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340972; cv=none; b=t6PpR1yu9W3s3Kl3oza1B7fLRLGOEnGvTtKS0ZSi8uxE5X3kb5E8qltcUFI1VrYi7f4SpzILXgzJkdf03ce3vd+Q5Gwt+FIxF27TcYd1rm0ui9XQxnL6iVdJg7thtCze91a+aNUh/gzjrCCnu+OBoky2AfjxaOdJmcOS0+egB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340972; c=relaxed/simple;
	bh=McisCuoDJAzv7/DvApnIRk83zKXBrmus6JEH/3vaOxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzvNe9pmkOsZGfC2WmMx8yKOvrauY204Uh4YTmJ7fXmPYSGZYKg62aiWc9mey+fZHoGREyq7rFH6CHjAbjQcU6uztcJlHGzTBp+zOzWiF/uztXKIUW2pKUNbNUsFrfsNNFFFh5pGsT0O9/e+QeRJvADSxsPD2vR+mFl2oaNTMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrh0ggxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrh0ggxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21FF1F000FF;
	Sun, 13 Sep 2026 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789340970;
	bh=eX0K33Erd6KchpUfLPQiE+mK+G5TuFBmX6Lx8FiEtNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mrh0ggxRgUCBEnJlM76AURlMM/0fk0ys2iom1/iZQZU9bXa1J+7uAMxfZrG5R2mJZ
	 rNETcHkROQQtarCs5y5WZN798lfv+kK1R1clGvq4o9qSS4NBylqt7FxnmyoFixBYqj
	 NrBG7M1OzT/MkJ5pqABRvwI9caNmn5KzH5rFd3CBy2UE4VB8/98WGSc9uZ0ANHEG0y
	 IAIVwU3+y1sV1wZteuYe7KmT3SRZiV8CtFXsPsypQzIDnGD4Z86IXMpge6K4TgM6Wt
	 r/JHjizqWCPKYXJO7O1gSxf9ZvzAaebg3jlnk236af2okWmho9a44u4qVq7sq4sT+Q
	 KwhCrlw7ZuX6g==
Date: Mon, 14 Sep 2026 00:09:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v8 2/9] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Message-ID: <20260914000924.165405fc@jic23-hlaptop>
In-Reply-To: <20260907-mma8452-open-drain-v8-2-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-2-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:50:57 +0200
Esben Haabendal <esben@geanix.com> wrote:

> If mma8452_probe() fails in iio_device_register() or later, we could end up
> with runtime suspend callback being called with a now freed device pointer.
> 
> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Sashiko calls out some preexisting stuff that is worth a look
https://sashiko.dev/#/patchset/20260907-mma8452-open-drain-v8-0-c17407e22118%40geanix.com

Why freefall mode is set after the iio_device_register() is indeed an interesting
question. Any idea?

As far as it goes this patch is fine. I'm not sure about the other sashiko
comment about making sure the device is suspended. Given pm_runtime_set_active()
is called I would assume that one of the register sequences has indeed
turned on the device (maybe the reset?) and we should be turning it off again.

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index fe62a903f0e2..a937cbd84f30 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1681,7 +1681,7 @@ static int mma8452_probe(struct i2c_client *client)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto free_irq;
> +		goto runtime_suspend;
>  
>  	ret = mma8452_set_freefall_mode(data, false);
>  	if (ret < 0)
> @@ -1692,6 +1692,10 @@ static int mma8452_probe(struct i2c_client *client)
>  unregister_device:
>  	iio_device_unregister(indio_dev);
>  
> +runtime_suspend:
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +
>  free_irq:
>  	if (client->irq)
>  		free_irq(client->irq, indio_dev);
> 

