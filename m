Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253D2F2914;
	Sat, 15 Aug 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786831114; cv=none; b=Qj/GIF52irGO6WtutTP/AzFm03B+OER7HSh4EeyoSeMxns4WokTQu36ynEkjS6UcgCVg6qzEsZJd/Ged7aiWdBtur5xF/m6sN8beQh4dRnojnwGN0d36vytMIzzoZxJiUNHMIQtLvZuPr2JRtKQUSiaVnw/peP3rGHzWFuEpoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786831114; c=relaxed/simple;
	bh=4orediGEN0RT6tjs3Pn0Ek81telg3NyIX9uWlTIcPFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSGTfGGzD1rkOPCJi63n/UwsENMYy6sLw1umD+/CS7Ewou48zM8n/C0OIhvm0YW3SVYP+NwEYr++8OTB5hqZQLJisgmK3A7zjI5slpe5VpfLKrHdlaqOvmwXVEDkG9bFOAoVLfJCjjpmdqtsgNdIZk8+beNO3HQoaFMykPvww3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVWxYWtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVWxYWtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADD51F000E9;
	Sat, 15 Aug 2026 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786831113;
	bh=NXCTlBKyu8BUPb7xFNN5lHswk/UtHZPMMblzmrt/iVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VVWxYWtgNnMz7fmyQqSZjc4xF7QELTpmLWOnJ2fEu5MVLqw5R+X6tZ/W6s0FwAxMo
	 +4jE6hvKKswrG9+xxkq0sLwJ+lQ2Zv0GosrnHoDfhmbbriKoOAsnwifYanmZGq9SgT
	 U6h4GJmw3fFbv5buLTt9mIJkDKmRGPVgdPCJFlmZq5PjRZGZWC0rsH8Av+TlNVxQcY
	 aXeBRcs6sesYUngXS0JuHBjye2AjL/y60gMj5dcrNcq7802KKpU9bHw9rbp3Tmxu7S
	 V+kh32fKsSSAQH6kA1qOecG1YborG8uVgblyBu+3q0R3rAzY5JY1Sz63VXXw5WeS0R
	 WmdurWZ5DZU3A==
Date: Sat, 15 Aug 2026 22:58:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: andy@kernel.org, joshua.crofts1@gmail.com, dlechner@baylibre.com,
 nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: bmp280: fix out-of-bounds access in
 sampling frequency lookup
Message-ID: <20260815225827.2ddb8397@jic23-huawei>
In-Reply-To: <20260811025252.1187644-2-sh_def@163.com>
References: <20260805074127.473731-1-sh_def@163.com>
	<20260811025252.1187644-2-sh_def@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:52:53 +0800
Hui Su <sh_def@163.com> wrote:

> The sampling frequency tables store each frequency as an integer part and
> a fractional part in micro units. num_sampling_freq_avail is initialized
> to the number of flattened integer elements because read_avail() returns
> the table as a flat array.
> 
> bmp280_write_sampling_frequency(), however, indexes the same table as a
> two-dimensional array and uses num_sampling_freq_avail as the number of
> rows. Convert the flattened element count back to the number of rows
> before iterating over the table.
> 
> Fixes: 10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Hi Hui Su

For future reference don't send a new version in reply to an older one. It rapidly looses
all usefulness as the email threads get deeper and more complex.

LGTM Applied to the fixes-togreg branch of iio.git

Note I plan to rebase that once rc1 is out and a pull request will go upstream
sometime after that.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Use plain 2 as the divisor, as suggested by Andy Shevchenko.
> - Add Joshua Crofts' Reviewed-by tag.
> Link: https://lore.kernel.org/lkml/20260805074127.473731-1-sh_def@163.com/
> 
>  drivers/iio/pressure/bmp280-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 990340a9b10c..dbe42233c81d 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -836,7 +836,7 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
>  					   int val, int val2)
>  {
>  	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
> -	const int n = data->chip_info->num_sampling_freq_avail;
> +	const int n = data->chip_info->num_sampling_freq_avail / 2;
>  	int ret, prev;
>  	int i;
>  

