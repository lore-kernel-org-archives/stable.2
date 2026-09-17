Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02EC2EEE83;
	Thu, 17 Sep 2026 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605246; cv=none; b=MUXr0CX1xxFS/e3ZFT2bnDp154A1T/RT+f0q9U2C7d8OUeZiTGN3HfLOBJ3O806PEtsinYjPk45PSfTxFnjFID17G1zLyl++4R919HATW1foWCsbnJPz9pk1jZouByk1oFrrEbSJd6/EdVAGVg3zotd9SRGbW2cQEssM1Ovbhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605246; c=relaxed/simple;
	bh=ttJvnD6+TdUWnt8ZWZyr50DEuv2I2ACAscocmO7JVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihMf6U/Jyr74PmvocVDRQelZMsvz6gxG7ZMVSihlTQCY4sAFrkeVQoFxDSuRd+v8n8E6jx+y6Oa7XveLTevgaLXzRZ7u5L9E/i8RUTxVD/T2Ig4cGo4HlJolJPA06XJRJYmfcjbU2E7yHiGTuboWT70gF5sKe5uRqBpimrgqYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euug1m+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euug1m+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA351F000FF;
	Thu, 17 Sep 2026 00:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605244;
	bh=W2ncFYeDcvoCNyEJjCNLN6rq2hHQLV5DuRrVyS76AMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euug1m+Ddo8rxASq/FmQe/Lpf1KspIMHli0mdb37z5kwm0mPWzzghi5YJrhlP8CVS
	 BwpwsATwR6FLjUu4Mfhat7FJMr+N2Dk/lOApAEhG3mJRTyVEN8Y59tAOdXGVGgR0El
	 AfQ9EwoXPnMfiJvp6OLiB/d8HeKzLhsyRMGjDTJ1CYVFvyDUE/jNblKI3E+Av1aBn3
	 Qf7ZX9fMhxCILm9LYlD3y85XoqYZuY2+I508FqLggdndqdRVcwTY+69pIK0eKM0upx
	 LQGp0Pd3F1NyRH8qkWkOTVbXPl64IKlFm6zzdbSFXdqVGvHNjqgPePJx/NWP+GPajp
	 tim4ydDEQgFSg==
Date: Thu, 17 Sep 2026 01:33:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linusw@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak in
 mpu3050_drdy_trigger_set_state()
Message-ID: <20260917013359.05f95b69@jic23-hlaptop>
In-Reply-To: <20260916162949.2083791-1-vulab@iscas.ac.cn>
References: <20260916162949.2083791-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:29:49 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The enable path of the trigger state callback called
> pm_runtime_get_sync() and returned early on every following register
> access failure without releasing the runtime PM reference, leaving
> the device powered permanently. Use pm_runtime_resume_and_get() to
> propagate resume errors without bumping the usage count, and release
> the reference on all error paths before returning.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Take another look at the code that results and think about whether having a
unified cleanup block makes sense as it stands.  There are two legs in this
function in if / else and the cleanup block only has anything to do with one
of them.  That is a strong sign that it is time to split the function up
and introduce two helpers (one for each of the if / else). Those helper
functions can then do appropriate error handling.

So fix is valid but larger changes needed to ensure the code remains
maintainable.

Thanks,

Jonathan


> ---
>  drivers/iio/gyro/mpu3050-core.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..aab2984a0c09 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -988,20 +988,23 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  		return 0;
>  	} else {
>  		/* Else we're enabling the trigger from this point */
> -		pm_runtime_get_sync(mpu3050->dev);
> +		ret = pm_runtime_resume_and_get(mpu3050->dev);
> +		if (ret)
> +			return ret;
> +
>  		mpu3050->hw_irq_trigger = true;
>  
>  		/* Disable all things in the FIFO */
>  		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Reset and enable the FIFO */
>  		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  				      MPU3050_USR_CTRL_FIFO_EN |
>  				      MPU3050_USR_CTRL_FIFO_RST);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		mpu3050->pending_fifo_footer = false;
>  
> @@ -1013,12 +1016,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  				   MPU3050_FIFO_EN_GYRO_ZOUT |
>  				   MPU3050_FIFO_EN_FOOTER);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Configure the sample engine */
>  		ret = mpu3050_start_sampling(mpu3050);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  
>  		/* Clear IRQ flag */
>  		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1037,10 +1040,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  
>  		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  		if (ret)
> -			return ret;
> +			goto err_pm_put;
>  	}
>  
>  	return 0;
> +
> +err_pm_put:
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops mpu3050_trigger_ops = {

