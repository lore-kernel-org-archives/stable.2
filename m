Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965434;
	b=K9WVrKfdFvne6KesYcdnXR2H8DZioNxBa//LIaptnQ61vII3mFmD12xVIYsh1v6X6FZD
	 yEVsDDxZx+w7etNbpJ5G3daMbBtbtc0eGfXYYpRL9LnYVQgD5Fnkt3RUkM+W7Iree9cZR
	 wupBfXJDfPJkf9I+M5GgOvPG6mKeosXBJIKAysyODholBneZHV8gACPsPMn0bb1pToCtf
	 CPiVqBH+/RRXced5wploPgROH9B3V7lmDYQFOtPJPtBB6JNegMd1NUcGUBTCSoI7hPoQw
	 GAm0NdrbbHbMMX9SIBMcVYJYhjHZOeIL+s4UYzA5rCSkVma/xr3MaiGYuFXCORG2ivQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/WqhRxfqqV6Q7suisF2pv2nhmZAR9yq7c2488ERdjbU=;
	b=c4u0wzZVLNumii8cA3vLd92ekuZH5/srV8u4DG9A2UFtIPJUuXpoG3pSylF8WHLYZDMs
	 XcIKP0VNNZix01rU8SdmFbR/FQHFhVj6cmrkFEAdf5aXpaHIX+QHTi0FgWw4JhiY3BpeH
	 AH87NXVb70DwG9SKDWzttPLO3S5231thcrqBo6Q5qqWuofK4fjcUe9w2hIT0GjOZf14um
	 KYzS2Tdds4nBiH4jpEHlfHRpnUxjnJW6eo/04yewu9kJrHK5b38sMWeuinsPZlem45Kqw
	 fznRcOrIw62AonrTu/WRKo8+cKakJlRorsAj24pHdUvLYansrxp8AAtfU3OLkofZOvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhJfQ3on;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B65606A31B;
	Sun, 25 Oct 2026 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhJfQ3on
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5CF1F01825;
	Sun, 25 Oct 2026 21:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792965433;
	bh=/WqhRxfqqV6Q7suisF2pv2nhmZAR9yq7c2488ERdjbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OhJfQ3onjSJNknKSZlQEc2jX+ueQe44w3nqgPo7RTRN1ACtzGqq8rI1itPZ+vJCyu
	 L8s/UMnXPTOVNM3kLx84yPDhQQBjVqJhkv5EcgoEbZ9Ce4b5C8Z4vfMG/hiUYElArR
	 EV7ZjnplENXU2Ol1Q07PqQErhc0VWwllwnV5ly4VNChoqAs5nq0fDVkLAi6pRxmwmr
	 eTjEEzgZEzLmuf03ywNxM6s5FUnjDCDZTD7CA+mF+MJ0NSbfmQdU1DuQ42WPF8hti2
	 gpRD03twfiq6PZ752LcFxjKtl4ZBzEqvxrn6uHNptV/pgb38NlL17p6j7dHMNUC3m3
	 evDt86Vt07Swg==
Date: Sun, 25 Oct 2026 21:57:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <20261025215707.4fe42618@jic23-hlaptop>
In-Reply-To: <20261025211856.256491-1-devnexen@gmail.com>
References: <20261025211856.256491-1-devnexen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 21:18:56 +0000
David Carlier <devnexen@gmail.com> wrote:

> mcp47feb02_write_raw() writes the user supplied raw value to the DAC
> register without checking it against the chip resolution. The parts
> are 8, 10 or 12 bit, and the bits above the resolution are not
> implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
> the output to code 44 instead of failing, and -1 is written as 0xffff.
> 
> The out-of-range value is also cached in dac_data, so it is written
> back on resume and stored to EEPROM by store_eeprom.
> 
> Return -EINVAL for values outside [0, 2^resolution - 1].
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Cc: stable@vger.kernel.org#

Good catch but given the fix will go in the same cycle as the driver
I've dropped the table tag.

This is more about how I choose to queue this up than anything could
know.  I might have held it for next merge window in which case
it would have wanted the stable tag.

Applied to the fixes-togreg branch of iio.git.  I've just rebased that
to reflect the char-misc pull going into Linus' tree (which was needed
to get the driver for this patch). I'll rebase again on rc1 once available.

Given I'll be rebasing anyway, extra tags welcome (and I didn't hold
off on applying as I might have done if aiming for no rebasing). Ariana,
please take a look at this one.

Thanks,

Jonathan



> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Found by LLM-assisted code inspection, reviewed and verified by hand.
> Build tested with W=1 (=m and =y) only; no hardware was available for
> runtime testing.
> 
> v2:
> - Use GENMASK() for the upper bound so it is safe up to 32 bits (Andy)
> - Drop the Assisted-by tag, removed from the docs in 1e035297ffda (Joshua)
> - Move the testing note below the --- (Joshua)
> 
> v1: https://lore.kernel.org/all/20261024214423.865635-1-devnexen@gmail.com/
> ---
>  drivers/iio/dac/mcp47feb02-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
> index 88bffbab0854..b5a2ac4a2e67 100644
> --- a/drivers/iio/dac/mcp47feb02-core.c
> +++ b/drivers/iio/dac/mcp47feb02-core.c
> @@ -696,6 +696,9 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > GENMASK(data->chip_features->resolution - 1, 0))
> +			return -EINVAL;
> +
>  		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
>  		if (ret)
>  			return ret;

