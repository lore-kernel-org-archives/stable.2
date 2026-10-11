Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44E448D18;
	Sun, 11 Oct 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791721216; cv=none; b=C1uNOdeWab7ZDMcjipZYs8TMI9j7fDuBtqYfjlVOcBz6P6vYuUuuBBPilcRdm8i59AT8z7CgnUDNq+4rECabMAI+An+PeWx8qCLPiikaga7hoEhZrr7ml9BulYIaFa+p3HXkiSGLYLRnKOc6IVmhdRoej0F5itj3mpnrbil95Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791721216; c=relaxed/simple;
	bh=m+xvtPafCMud6D8UrsxPqP4zUbPUmIsKZJyLFqbBsiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEBuXPjkNRyjEmEBf3y1TXdAayUznQ62f174xLkFDvZyFXknDpQtN2j8kcIkpTImAwnPFpWgk8Nwn0sF8wmTRSUrOMmnu6nacQ64CF8vdXk+rojZRZDqdaabjbTnUTiTiAJ7dzUISQdOBT/mP+y8KHIbdpL0TUn863vVlnJZCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNA7CnB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNA7CnB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B15E1F0089B;
	Sun, 11 Oct 2026 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791721205;
	bh=OEoV6gvrqGXQ9GjLqXSpB5SGZ/q82zWyeAYV0tCx4+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LNA7CnB8rS23vU8iVx2eD6jsdwnnLNFzZpT9+QVKlC3gTzDzn9pg2DwGEuM3OXbQc
	 NG7EAJfe/TFulPeLMJ7G5D44oSwYdw7MG4Z5LKFyPYLA5qeHQbFkbBd8N/KLFUBPuV
	 4TCISba6JSDoKANLy36/1ncj/5UJdVSk5pARAuzpKWx0jD/iDgg3StnuDAtNIQ+2f9
	 PAA+PaNLGZGMkRt+/aNiFBhdmbsu6mBD7terzj5fYf+/V7mi049IdMXSnuF6M5kszX
	 oCTC33TQGTa1+B2Jxz6pzkM4eYRsJRJCGCCtEki1tgYTptTYyzWJnLXoQKwcITmA7v
	 Hpjhpq1ej5bXw==
Date: Sun, 11 Oct 2026 13:19:46 +0100
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v10 03/10] iio: accel: mma8452: Fix runtime PM bugs in
 mma8452_read()
Message-ID: <20261011131946.16bf4ef2@jic23-hlaptop>
In-Reply-To: <20260928-mma8452-open-drain-v10-3-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<20260928-mma8452-open-drain-v10-3-b906fb408386@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 10:26:19 +0200
Esben Haabendal <esben@geanix.com> wrote:

> When runtime PM support was added [1], the implementation in mma8452_read()
> was done incorrectly, as it calls mma8452_drdy() before ensuring runtime pm
> has set the device active, so it can cause read from STATUS register while
> device is suspended/off. At the same time, the return value from
> i2c_smbus_read_i2c_block_data() was discarded, and the function would
> return the value returned from pm_runtime_put_autosuspend() instead.
> 
> When the latter bug described above was fixed [2], another bug was
> introduced, as mma8452_read() would now leak the runtime PM reference
> counter when i2c_smbus_read_i2c_block_data() failed.
> 
> This commit corrects this mess.
> 
> [1] commit 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> [2] commit 5bdff291d20c ("iio: accel: mma8452: handle I2C read error(s) in mma8452_read()")
> 
> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>

I suppose not directly relevant to this patch but that
set_runtime_pm_state() helper is definitely not helping.
I'd follow up with ripping that out and calling the two runtimme
pm calls directly.  Then you would be trivially able to use
ACQUIRE_RUNTIME_PM() etc to reduce complexity in places like this.

In more recent drivers I've always pushed back against that
sort of helper precisely because it stops other sensible refactors.

In general that also follows the common pattern of not checking for
errors in the put as that trips up on things like !CONFIG_PM and
is generally not that useful!

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index a937cbd84f30..a77c4b88b61d 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -242,21 +242,25 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  
>  static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  {
> -	int ret = mma8452_drdy(data);
> -
> -	if (ret < 0)
> -		return ret;
> +	int ret;
>  
>  	ret = mma8452_set_runtime_pm_state(data->client, true);
>  	if (ret)
>  		return ret;
>  
> +	ret = mma8452_drdy(data);
> +	if (ret < 0)
> +		goto out_runtime_put;
> +
>  	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
>  					    3 * sizeof(__be16), (u8 *)buf);
>  	if (ret < 0)
> -		return ret;
> +		goto out_runtime_put;
> +
> +	return mma8452_set_runtime_pm_state(data->client, false);
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, false);
> +out_runtime_put:
> +	mma8452_set_runtime_pm_state(data->client, false);
>  
>  	return ret;
>  }
> 

