Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E520ED;
	Sun, 23 Aug 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443344; cv=none; b=oq2lZQVt4TVGMGtV3dbiLokpRYL9Ws4dPX+SWv2ZNWkELjdI4rtJhBNMss9b7G6y9VX91hIMNTnIjBt1burQwXy4zGPUBkY4AYL9cz+RR628UWBkVfDYFVBVW8LvQAZYDSynWF5XNAsXNYDI32QRNcvWqW+Wx8ix2GS+9pcE2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443344; c=relaxed/simple;
	bh=maI3tUHD+hoXVjL3auN0or5mQUIotod85ObaWGgjwdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s11Ffyc+eFqrx/76amrWIsM1vRdeTWsnnjNsHRSuK9QLtpvI69WQI8Lx/MrcfehfBEsOSIKovq3+YKgL2PpAJjdZ9WNL0GJjGPET+ufjbEmcZpuGdfTqe8zbzzLEx6BV/s82E3z99BzcV+62QKdgMS1iI8zABOlCGI/bg5w+DPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b85/OyjA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b85/OyjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B811F000E9;
	Sun, 23 Aug 2026 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787443342;
	bh=yvgQsT8yTLuQg4LiEdcB7T89pTbq9anF5jbupzQnmPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b85/OyjAcsj+mozBiBbM4ejv8hMZ93SMlYeo9hD6Md+1EwFYVGlq65Cepwmnsc1GU
	 QnTQ3OZojDL70+wv9eVTG+XK9AISbXPgO1KcZaCrWbhjakYCzJX55io8b86fKT2MaR
	 2k4wJFK2W8wVZfObEP/57MQNzIVNNGCEG5s0BYGZ4xCGeAA2we9K3aq+LzsnuxSJQ7
	 9dDcT4WlUe0AitV0ra3RzXRsEmrmNgJMk8BWvKt6BfnA/KA3Mhe/TxWbE1KQi7//7O
	 ICA0P7Yz/yN4lZRXjpTaLKiHGy8kB25FOaX9BaFsHBTiYA1GAkTvw1tMSGESE3kove
	 zOKwO6HxXU/wQ==
Date: Sun, 23 Aug 2026 01:02:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu
 <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2] iio: admv1013: initialize callback mutex before
 registering notifier
Message-ID: <20260823010216.76eaaee2@jic23-huawei>
In-Reply-To: <20260819141751.44223-1-runyu.xiao@seu.edu.cn>
References: <20260819014611.18db8689@jic23-huawei>
	<20260819141751.44223-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 22:17:51 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> admv1013_probe() registers a clock notifier whose callback takes st->lock
> on POST_RATE_CHANGE. Initialize the mutex before
> devm_clk_notifier_register() so the callback cannot observe an
> uninitialized lock during probe.
> 
> Use devm_mutex_init() so the lock lifetime is tied to the device and
> cleanup stays paired with the rest of the managed probe resources.
> 
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

The code has changed a bit, so what I applied to the fixes-togreg branch of
iio.git ended up as:

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv10
index b852378b3f68..e86b59bf23fd 100644                                     
--- a/drivers/iio/frequency/admv1013.c                                      
+++ b/drivers/iio/frequency/admv1013.c                                      
@@ -602,11 +602,14 @@ static int admv1013_probe(struct spi_device *spi)     
                                     "failed to get the LO input clock\n"); 

        st->nb.notifier_call = admv1013_freq_change;
-       ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);          
+                                                                           
+       ret = devm_mutex_init(dev, &st->lock);                              
        if (ret)
                return ret;

-       mutex_init(&st->lock);                                              
+       ret = devm_clk_notifier_register(dev, st->clkin, &st->nb);          
+       if (ret)                                                            
+               return ret;                                                 

        ret = admv1013_init(st, vcm_uv);
        if (ret)


It will need a manual backport as a result if we want this to
go to stable.

Note it wasn't a particularly recent change. Make sure your patches
apply on linux-next or the appropriate subsystem tree.

Also, please don't reply to an earlier version when sending an
updated one.  It didn't matter here but for more complex threads
they can become very hard to follow + your email ends up way
back in people's email history so may not get much review.

Thanks

Jonathan

> ---
>  drivers/iio/frequency/admv1013.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index d8e8d541990f..ff599b5c88ef 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -594,11 +594,13 @@ static int admv1013_probe(struct spi_device *spi)
>  				     "failed to get the LO input clock\n");
>  
>  	st->nb.notifier_call = admv1013_freq_change;
> -	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	ret = devm_mutex_init(&spi->dev, &st->lock);
>  	if (ret)
>  		return ret;
>  
> -	mutex_init(&st->lock);
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
>  
>  	ret = admv1013_init(st, vcm_uv);
>  	if (ret) {

