Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807029;
	b=dRW4qg/fdfCIwfO+3sUHBgy5Dd2FPm+jVcTspqWJAo1EHvgvJCynTMYjwVSnweC7NNnh
	 HWO1JuIsd5V2MZg5srOBz31aO44Cx2fLnhFsqXYPztzSf0F5FqloYpiA5p4UBumXzFCa6
	 GhWgNZLLZEdlHz+ZDRkDjG3Zr2e0wM8TdnMd60LLt2kzj3w3Uw+lMDv0H3cb7A4dhqDjU
	 CWJGoJqybbhJZ4NVWHzeEgHS5NMtPqTt4pGuv9Uq4ZfOgQAkbVy7ez5la7m4THmxTNgOt
	 HoNBztgRUU7LZaPomjDNA40wLQGQah0mg2u27LK+983zGTE6DYkCqRilHHvmR16G8rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807029;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X+sHAz12Dqk+FEAwV1y7Bc6KSqj0w1iT/sjqDw7CQfM=;
	b=oyvtduQGRscO2FefplhAZiqgCNXU9wRXRm/4kz9LPVOUNKDI7/IrCw7UGmB1aUTsJaIF
	 BkBGNOynCMRyo4JvJDPaNBiEwLH7VeTllu31HJxR/nhkh4Ry0equqt4V6ydYSWNcmV1Mh
	 /wjLIYcEh+PJRW2xz1Xjkf0NVZVpIKr+lfdtT2zjxlYJmOjrNnktF1B65ewrlfkYlA3ch
	 3+SPqDUuq90pQqJUCHwqpS3mhdNJIRAUR9BH1f2m9rI5lxRkwshMBehmggH3vZCRfApaU
	 WFFB+oO3hNC0SirH35PM3FOEEbwiGMtbQVm7hq3IT1RxK6dRzBntzjE7W45E6ySG7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt88HfJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A6606A31A;
	Sat, 24 Oct 2026 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt88HfJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A5C1F01825;
	Sat, 24 Oct 2026 01:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807028;
	bh=X+sHAz12Dqk+FEAwV1y7Bc6KSqj0w1iT/sjqDw7CQfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zt88HfJOLpvyJcbBBlXmVcCfHGO0Q9f7D6usZiJG0ZkvE0Xyb92ApRMNY8Spul16K
	 fzNfTm1ay8PTPWJulwercCdCfzNSJe9/+T5e9zI7z3sOyo2qs3UPCTJeBB+cNTbp8E
	 YAfsismO8/cManUNj2KbpJQFuGahmxQqJP/ms1hpEOhYj/a+6RjDBxc+FZUEwmOROW
	 VO50leAp6rblMetD5AawVcEuHAJzzInjcYfiJS6xggbjSv6Ohcw0E0xatPpBjLOzlx
	 srGP+++BdxV8DcbMFleV2rqRUX2m2nzSS1iFH9Yn2q7uY0AmeJBmJ8hn0J1+8a1AdM
	 W/QQOVEC4Q74g==
Date: Sat, 24 Oct 2026 02:57:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, stable@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9324: fix out-of-bounds read of
 scan period table
Message-ID: <20261024025702.6fd8122d@jic23-hlaptop>
In-Reply-To: <20261023192700.221344-1-kapoorarnav43@gmail.com>
References: <20261023192700.221344-1-kapoorarnav43@gmail.com>
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

On Sat, 24 Oct 2026 00:56:51 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> The scan period of the SX9324 is selected by the 5 bit wide
> SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
> sx9324_scan_period_table[] however only has 16 entries, it was copied
> over from the SX9310 driver where the field is only 4 bits wide.
> 
> sx9324_wait_for_sample() indexes the table with the raw field value, so
> all the codes from 16 to 31 read past the end of the array. The default
> value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
> i.e. 22), so the out-of-bounds read happens with the default
> configuration of the device. It is only avoided when the device has an
> interrupt line, as the wait is only done in the polling case.
> 
> The value read is then used as the duration of an msleep() call, so the
> sensor is polled with a completely random delay.
> 
> Fill the table with the scan periods of all 32 codes, which are the
> periods documented for the corresponding sx9324_samp_freq_table[]
> entries, and add a static assertion to keep both tables in sync.
> 
> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Changes in v2:
> - Format sx9324_scan_period_table[] with a power-of-two number of entries
>   (8) per line and the register value range as a comment at the end of
>   each line, so the table is indexed and a typo is easy to find (Andy)
Looks good and matches what Andy asked about.

Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> - Put the static_assert() on a single line (Andy)
> - Add Fixes tag and Cc stable
> - Rebase on fixes-togreg
> 
> v1: https://lore.kernel.org/all/20261021225417.626946-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have SX9324 hardware.
> 
>  drivers/iio/proximity/sx9324.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 255a36976ac4..43266a21bf2e 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -279,11 +279,20 @@ static const struct {
>  	{ 0, 250000 },  /* 11111: 4 s */
>  };
>  
> +/*
> + * The scan period of the SX9324 is selected by the 5 bit wide
> + * SX9324_REG_GNRL_CTRL0_SCANPERIOD field. The values below are the scan
> + * periods in ms of the corresponding sx9324_samp_freq_table[] entries.
> + */
>  static const unsigned int sx9324_scan_period_table[] = {
> -	2,   15,  30,  45,   60,   90,	 120,  200,
> -	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
> +	1, 2, 4, 6, 8, 10, 14, 18,			/* 0x00 - 0x07 */
> +	22, 26, 30, 34, 38, 42, 46, 50,			/* 0x08 - 0x0f */
> +	56, 62, 68, 74, 80, 90, 100, 200,		/* 0x10 - 0x17 */
> +	300, 400, 600, 800, 1000, 2000, 3000, 4000,	/* 0x18 - 0x1f */
>  };
>  
> +static_assert(ARRAY_SIZE(sx9324_scan_period_table) == ARRAY_SIZE(sx9324_samp_freq_table));
> +
>  static const struct regmap_range sx9324_writable_reg_ranges[] = {
>  	/*
>  	 * To set COMPSTAT for compensation, even if datasheet says register is
> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

