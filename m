Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05231F996;
	Thu, 17 Sep 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605546; cv=none; b=DROqXU4YUsO8tIKPrGATM4VwDtL1JUivHdmNHYI94vr9Jz2x2w5p6jvsYt3kC08WZ+vje8S94h/sMDsTgn8t8AKrSS3qlcDSGPoYlM4cpJC5zb+eHVsNtDwBY9yiFLDLXCZgBqtil/VCpD+/9HIIwBTitSX+ANu50riujytYDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605546; c=relaxed/simple;
	bh=rTaMBlu/atMBwpIOzW4tym2zKc4eagtobxi239s3zNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMeFptYvRXo9UnCqkO7pU+z9B8cXRErI+9SaMwCAgcrfFwMgHaJexb4FkOuoX8fcPWyfB2wmwD+RkyIvlJhN8eMcIoPvY9rJiOsoaJkWZzhiXBKPMvc1JyGragv9eowixDWhm1oJF6+upPUKg+D4YIjOoF1h8zhhSt4MXQa2A40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkRfCcEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkRfCcEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5211F000FF;
	Thu, 17 Sep 2026 00:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605544;
	bh=FX13SbXpn8F5JIE8DipKpp6sW+qYMimlPAgPFlrQeag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QkRfCcEMW1fwZF2KdnN7aatKlwZtXETICIbFKZN+zAE/wuresTksRnZELFwy7SIMN
	 GLjkmwcx1st3gG+7iAkFKcOsVTf4ewdJO4PFDDd0ugmF5PdRWrU9XJSekjEqChO0B3
	 19ElCvAmiffAdYYYYdu0ZS98x0U+25XvJCWskboZUW5go1lpbTr96grkJzRivo2O/9
	 XiZuUvhRxPaUBXNxO4LrQiyD66nRkcfG3pAPezoMDQOJaD2Yv0Bz3I8tFsiUV1MShR
	 Y6L5GYKKlSsa2mUpyG4SR7yiaP+UC3lX4dgL0bUkj5r8f7cI28sZKQHs4JqRSLiZvT
	 zljMdagl9jX1w==
Date: Thu, 17 Sep 2026 01:39:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 rajat.khandelwal@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: mpl115: Fix runtime PM leak in
 mpl115_read_raw()
Message-ID: <20260917013900.41be498d@jic23-hlaptop>
In-Reply-To: <20260916163852.2084375-1-vulab@iscas.ac.cn>
References: <20260916163852.2084375-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:38:52 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> pm_runtime_get_sync() increments the usage counter even on failure,
> so every successful call must be paired with a put. Both sensor read
> failures returned early and skipped the paired
> pm_runtime_put_autosuspend(), permanently preventing runtime suspend.
> 
> Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
see upstream...

> ---
>  drivers/iio/pressure/mpl115.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 830a5065c008..3266b79bdab8 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -106,8 +106,10 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		pm_runtime_get_sync(data->dev);
>  		ret = mpl115_comp_pressure(data, val, val2);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			pm_runtime_put_autosuspend(data->dev);
>  			return ret;
> +		}
>  		pm_runtime_put_autosuspend(data->dev);
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
> @@ -115,8 +117,10 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  		pm_runtime_get_sync(data->dev);
>  		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
>  		ret = mpl115_read_temp(data);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			pm_runtime_put_autosuspend(data->dev);
>  			return ret;
> +		}
>  		pm_runtime_put_autosuspend(data->dev);
>  		*val = ret >> 6;
>  

