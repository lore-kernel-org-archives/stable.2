Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75167171BB;
	Sun, 27 Sep 2026 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536650; cv=none; b=rxtbgwm5+B3P7CLJ74wKVzRbMOYcObzkYtLL2fiv1CawoXDnss2S1LS85FqxqLhfZaSxwtaDCdkfVMjA4Ek/ETDHlL5Z8IRqOXPDamgAd7t+2yeYz/nRa34mqGOKqeqUgpm6z0pxh3rMXr5PAkioiLLZkTa20CcyU+5tkFJS7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536650; c=relaxed/simple;
	bh=nSYLBMZGdUP0hpME4D1r2BWkQiRLQw5m6OCu7ysCc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIEaF6tDrRSTVlQ/CgH9EMRdYI3CQxcbaC9aStVgh4+XYdwIfkwA+Q9pX6kgOUEYjQWnCgTlmwZ204546SSspRNd5rLYe8wiqrMP/oKxv1Yd8p/C3KwclnfLGXar4luQ9FFSEY9enNnIVi1JDVRmI96Q086iOraStdlTNUssCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDE5FdR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDE5FdR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2421F000FF;
	Sun, 27 Sep 2026 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536649;
	bh=06+yJcHAwyVL0fFSL8xx/C1aDosXVocUDk8PkP9zMTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VDE5FdR0VFkbuCoMZDKjn+s4UL09dMNz+tAbVMGwaDlP8w1zRxIwVhr/gzetWe36e
	 5lm/3HwsZHrCzmsq/Xo22OwnkukEG4BwESnnHDxPAo2StL6eonbvc5iWyotfrnecMb
	 Pd9a2PUKX0jOA3HZBCnryaVkKou6InAUDYKud6OjWkHUqUBkAUySf7+8Y9jyyHpvZa
	 wh4tnE7ljTyDcETM9ToJrJAiQGdbzNeUOhCZerBSVcgiN0ZCiLV71ttCJWsBaayNH0
	 5kDmI9hKkD++4iE1TZHLwtNFMbyrtg+72SivhbEH1M5TTXBNYxIOqXfJxuGtMWXv48
	 wzGqDkE4vgAuQ==
Date: Sun, 27 Sep 2026 20:17:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v8 01/10] iio: pressure: dps310: fix CFG_REG bit
 definitions
Message-ID: <20260927201722.6f379c77@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-2-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-2-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:23 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Driver defines them as BIT(4), BIT(5) and BIT(6). Per datasheet P_SHIFT
> is bit 2, FIFO_EN is bit 1 and SPI_MODE is bit 0.
> 
> Only P_SHIFT has a user. dps310_set_pres_precision() sets it at
> oversampling 16 or above, so with wrong bit the result register is never
> shifted and stops matching the scale factor compensation divides by.
> in_pressure_input returns -ERANGE at oversampling 16, 32 and 64.
> 
> FIFO_EN needed by FIFO support later in this series.
> 
> Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Given we are near the end of the cycle and I'm going to be
travelling for most of the remaining time (which makes it
very random whether I get to IIO review or not!), I'm going
to pick up what is ready of this series.

So applied this one to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/dps310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 45bdb8c7670f..35260b399390 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -50,9 +50,9 @@
>  #define DPS310_CFG_REG		0x09
>  #define  DPS310_INT_HL		BIT(7)
>  #define  DPS310_TMP_SHIFT_EN	BIT(3)
> -#define  DPS310_PRS_SHIFT_EN	BIT(4)
> -#define  DPS310_FIFO_EN		BIT(5)
> -#define  DPS310_SPI_EN		BIT(6)
> +#define  DPS310_PRS_SHIFT_EN	BIT(2)
> +#define  DPS310_FIFO_EN		BIT(1)
> +#define  DPS310_SPI_EN		BIT(0)
>  #define DPS310_RESET		0x0c
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10

