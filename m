Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC52F6918;
	Thu, 17 Sep 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605603; cv=none; b=UzMzaRmxYcvlT8dRmhHJieZI5wpNrGMGevA1Hw1VJlEIlyetqQqMlM3Wmwyx2Zup7972ufFA2WzHJOj/+z5Z/YqIQfMza6gHpWMVkDVBcgDrcq9G/7SnFJe+01laF/t4l4PrGvi3lH5Xi72ljR7Al70WZtDwJRzK43zp5T1PVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605603; c=relaxed/simple;
	bh=saoJFz/iKct4GQR0aAET3tqyTqetWrUIssGdjmfLz5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOsCcrPT98A1HiPeK9fETamK9WAtbbwk73AuknJbPsq118XA9twVj6F3zTcod1WM7mIsQQwEBbzmyZkSi2M57hW9IwY+qa2LBJS9PzPZSxyPFr48p7VY2Mx3B0qFeXGo9H2eHiTOPk4ZgbN8u005wNOuNj3kDVHdrFEjkyUU2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQr4LUwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQr4LUwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71701F000FF;
	Thu, 17 Sep 2026 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605602;
	bh=FleVe1PuuYTK8idTs46lNFjcBWdGpen0GiM+cr+o79A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bQr4LUwqi+C4a6cmV7lujDqgPHr9zuQRDqfQJnw2zUR+jBO48n6h/7YVOceAmw6Bh
	 hitNuVUhgpVPg++SNa0BReDB3GfRbAOG1HcvSqVVCySrchMSk/V7b1mYyOh9d+W0Kb
	 psJ5SocgemRsSTkuK/V6eHFfx+32gEaBLTZhdVbMR9ZNsCOCaHFafVBRyLrfWMAeN3
	 4bReLedegMh3GCUT5KOaGw28bhvymcMJbwmIW+aDkESuyQeQNq/8oXmepnI1Rd1ZmE
	 L/dbdyPIVy3OQCe8efiuE6vrHhvsuXuJn7VfkpgG1hzKG0gxbq7CgFYYkqGNC0XiH1
	 5RYZoNaJFravA==
Date: Thu, 17 Sep 2026 01:39:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: abhashkumarjha123@gmail.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, songqiang1304521@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: vl53l0x: Fix trigger reference leak in
 vl53l0x_probe()
Message-ID: <20260917013955.5ae11745@jic23-hlaptop>
In-Reply-To: <20260916164043.2084494-1-vulab@iscas.ac.cn>
References: <20260916164043.2084494-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:40:43 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The reference taken with iio_trigger_get() is only dropped by
> iio_dev_release() when INDIO_BUFFER_TRIGGERED is set. Failure of
> vl53l0x_configure_irq() or of triggered buffer setup returns before
> that mode is set and leaks the reference acquired for
> indio_dev->trig. Move the iio_trigger_get() after those setup steps
> succeed.
> 
> Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Not this way for same reason as in other similar patches. 
Subtle ordering constraints are not maintainable so any fix for these
leaks needs to not require that.

Jonathan

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index ad3e46d47fa8..abef4129e645 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -374,8 +374,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  		if (ret)
>  			return ret;
>  
> -		indio_dev->trig = iio_trigger_get(data->trig);
> -
>  		ret = vl53l0x_configure_irq(client, indio_dev);
>  		if (ret)
>  			return ret;
> @@ -387,6 +385,8 @@ static int vl53l0x_probe(struct i2c_client *client)
>  					&iio_triggered_buffer_setup_ops);
>  		if (ret)
>  			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(data->trig);
>  	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);

