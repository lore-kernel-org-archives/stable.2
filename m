Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636552AD16;
	Sat, 22 Aug 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787441897; cv=none; b=HEVHoSxtvxDYptj3m4ZKOdn5QaB+gRPW9u18RglOprZ0UUK4+4ZisLTlySa/Yw4xHwhwn3zJkC0hTmPnJwYlzeeJWmUJrKwTxV8Uk26n85K/EmohHpfdspYbVBqJYLy5h22e8tbp5mgiA4Cbtj4C0ja+8XMGOxyGa8TFhm1Yy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787441897; c=relaxed/simple;
	bh=FH0+j3Eli6N2X96Uj1h7hqnRqTvh2B5xK9jJ0lAgqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZK0ui3eAj+M2eaKaTURmTmcMHXRxlA0PPSwtnP13fjrnAvA92AtbYarwYGWZSlfc/4IeMvHoFz47NR1hN4KcewCKXXw1Y1eW0FJMQVu6hnUud6yJ5h6+tlb8H4LE60WdGeTkeYmDG+M9FAhAXRSBpqX3nnNscsUnLm7y34Icqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIQsTKIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIQsTKIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF101F000E9;
	Sat, 22 Aug 2026 23:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787441896;
	bh=zBkhZsortqWMDEMlzdtp+vg2aNfCtFcD1PZlUHKKdbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JIQsTKIQxlzef+gbxXyT8tbA8fXIJd7tUvnGTNt9N7H6MHVuqj0Rnhhy7juqfmaf2
	 om3gn4Ppu45l7kcdGHtqVuWkNP+eFRgylcuoQ9nRdqxPUOi8Nx9lhP9+lYc5ioFUsp
	 y9Ul1UWyu6TOB73mkYJiCQoFROt+LVXk8GeSwTEwUIksk26mmEKq2JrbQDXcs4JfZt
	 RIOcEJQF4eqC9gVyVqI4U5hOuvysZziWIsu8NsjpCqDZnIRyp/r0eFiZDDLXPQmcNB
	 /CDnAuu0W3Paq+neZYtlia/JGs4whRt6fcbBSdeHctWNOLG43tllWVl2gUyyFM+lcB
	 o0wyXv3n+xoMA==
Date: Sun, 23 Aug 2026 00:38:09 +0100
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 4/8] iio: light: ltr501: Power down chip if request
 irq fails
Message-ID: <20260823003809.25a19c2d@jic23-huawei>
In-Reply-To: <20260817-liteon-ltr329-v5-4-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
	<20260817-liteon-ltr329-v5-4-6f71ab2b0588@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:08:53 +0200
Esben Haabendal <esben@geanix.com> wrote:

> In case devm_request_threaded_irq() failed, we were leaving the chip
> powered instead of powering it down again. Power down the chip switching
> ALS and PS modes to standby.
> 
> Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
> Cc: stable@vger.kernel.org
> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7d045be78c6d..7746d374688f 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1540,7 +1540,7 @@ static int ltr501_probe(struct i2c_client *client)
>  		if (ret) {
>  			dev_err(&client->dev, "request irq (%d) failed\n",
>  				client->irq);
Some noise on this one because the above print is gone in the iio tree.

Anyhow, I think I didn't mess up the conflict resolution but please check!
Next patch also goes away for same reason

Jonathan

> -			return ret;
> +			goto powerdown_on_error;
>  		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
> 

