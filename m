Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCA3B95E7;
	Thu, 23 Jul 2026 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850842; cv=none; b=i6UMc98JfIKVd4y+J0WUTnM63MMqUiamt44JYd3vY0hsPRzutqmG61scctyqmAMNtxViwszKkeSIS6tWj57/IVogjefHLJD+1hLXWkb+rxkHVE3uy6lSaCM5cEWUHgEl4NYxq7L++BDZumN5Z+WvjKuACW4wb3EV9rNyVIK21J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850842; c=relaxed/simple;
	bh=EERrT+SP5hKNmqW1XX2NCJTV8SM1z4K5SB7+yfuvHbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+Um0F/O9UQ3gnO3cc3WbnxoTxlYYkEXh8a7MKZSEthDGuSARW+lALqP+yDrRUL4oLQRVuob2YTwMQMgL9XPTpy15UOe5nqlu76PHMccWJ0spYf9Nb7zOmPW+vKDsckZSq8Zi6p0I0iC8kHGGOZKBAj3Y2l3V5yqtrj00V+AuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIdqkzaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIdqkzaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6A21F000E9;
	Thu, 23 Jul 2026 23:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850840;
	bh=x9FS/rNlAm0LxtaeyJrU1CFWCKPcNZpOU+MHjW4+2gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CIdqkzaY3XEtqjE/Yqo+CADO8gmOwubO2uA1I97zyPdyqkoKiWGyM/ubGisXyHJOs
	 MUYW7qy/kzkZpFg3P3n8X2pkzz7uryr51DPtM0/UO2KEJqPlfOTG6ui0Kx+n9SU/C8
	 ZTvoisQM08x6WEjTNn48DFbZ40cu4zCYTq4HJRWcMdDTlkqx7sbjKoW4sbn0THD9V4
	 BEPNxtAlkgc3kFieAQbNVP7wKaGmAN6uLcnjMYku57mfw82jMQRfPN+tCWZ3nDDPB/
	 7dSEfLrJxTUxD1xTSIpDUnvnrlUsHiktchOHrhRBAz8VHt7nOi9zDpHfodsqtOqkor
	 b6R2456sR9wwQ==
Date: Fri, 24 Jul 2026 00:53:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: jonathan.cameron@oss.qualcomm.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: mpl115: Fix runtime PM cleanup
Message-ID: <20260724005356.4505e552@jic23-huawei>
In-Reply-To: <20260720024312.27037-1-pengcan@kylinos.cn>
References: <20260720024312.27037-1-pengcan@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 10:43:12 +0800
Can Peng <pengcan@kylinos.cn> wrote:

> mpl115_probe() enables runtime PM when a shutdown GPIO is present and
> then returns the result of devm_iio_device_register(). If registration
> fails, runtime PM remains enabled and autosuspend remains selected.
> 
> The same unmanaged runtime PM state is also left behind on driver
> unbind, as the IIO device registration is managed but the runtime PM
> setup is not.
> 
> Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
> probe failure and driver unbind, and check pm_runtime_set_active() so
> setup errors are reported.
> 
> Set the autosuspend parameters before enabling runtime PM. Once probe
> has completed, the driver core queues an idle request for the device, so
> an explicit pm_runtime_get_noresume()/pm_runtime_put() pair is not
> needed to start autosuspend.
> 
> Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
> Cc: stable@vger.kernel.org
> Suggested-by: jonathan.cameron@oss.qualcomm.com
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
Hi,

Looks good to me. I'm going to take it the slow path via the next
merge window as it is a fairly low impact bug.

Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
> Changes in v2:
> - Drop the explicit pm_runtime_get_noresume()/pm_runtime_put() pair and
>   rely on the driver core idle request after probe.
> - Set autosuspend parameters before enabling runtime PM.
> - Update the commit message accordingly.
> - Link to v1: https://lore.kernel.org/all/20260718061909.428476-1-pengcan@kylinos.cn/
> 
>  drivers/iio/pressure/mpl115.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 16e112b796ba..2929ea8e4e01 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -203,9 +203,9 @@ int mpl115_probe(struct device *dev, const char *name,
>  
>  	if (data->shutdown) {
>  		/* Enable runtime PM */
> -		pm_runtime_get_noresume(dev);
> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);
> +		ret = pm_runtime_set_active(dev);
> +		if (ret)
> +			return ret;
>  
>  		/*
>  		 * As the device takes 3 ms to come up with a fresh
> @@ -215,7 +215,10 @@ int mpl115_probe(struct device *dev, const char *name,
>  		 */
>  		pm_runtime_set_autosuspend_delay(dev, 2000);
>  		pm_runtime_use_autosuspend(dev);
> -		pm_runtime_put(dev);
> +
> +		ret = devm_pm_runtime_enable(dev);
> +		if (ret)
> +			return ret;
>  
>  		dev_dbg(dev, "low-power mode enabled");
>  	} else

