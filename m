Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C02D2495;
	Thu, 17 Sep 2026 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605860; cv=none; b=dqRXE8XYtaWUlzXav0ilyoYL/DdijmE1xwFvdOF3AJhCsPvw51OpnXcrY3UuGl4mIeyimaKPJoZcqbVXG5iGbTTea5DX9zKpSy0XImkk+irfXkCcwoP17X6oAChvNH8i3uhjHyy8yN6/iVSgRj9oH5z/qUNw+OEmnFoJ1GE11wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605860; c=relaxed/simple;
	bh=LWdJ5sLJYH8ufeHZm+Aq/WwvaCL27Ftwr+bvAkao5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYt8mX0UgKol6b2m4+xV9aWgAf8ktMlqb5adKk+AANAR0Vf1CBqOBiLW8L9PaSgYzk1dTNDMbb5IeLH8YMeRwMuYFT5vdxoCYRvaSH7cYuLjX3VhOZ+Z+7LT+7yzRUwc8Kv5h/C1n0salOox8P3sadGbAArKNWlGKhV2VowXN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXWigmc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXWigmc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AB21F000FF;
	Thu, 17 Sep 2026 00:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605858;
	bh=JrmqII1Cn0Cov0+KMRVkBMAR7oZfytZ8PiuaPFmq54w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OXWigmc4sGaFWsZa9UqPg6j48N8d2xrFucTenxmN0kvwbLmtYJwzBj1qz78t/kO8e
	 jYnASkLRgcGiwt2ut/KKsRNFLq8w3f1D5lEfvkgPcM6PRliiMCaqRz21MJsrgfA+iz
	 f4aOgr52j/PSJ8lCdyTihMRmn1CBTg38nI49PZMSdQrPnBiNxQVM+9hpsnfgPeE9PD
	 lRrk4GlGzXuuxDfMkakQTsXW73TaSB4znzoCaggpwKHJ7zRp/o3ipvYgVHxdnBMqZm
	 XQZR+04+ZxQT6KNStqUG6Zqz4Z0hgCgy3jHucLEzAf2YmYHl7Vwoih97c393BUBBU6
	 KTxwlFpn5DhFA==
Date: Thu, 17 Sep 2026 01:44:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: david@lechnology.com, jm@ti.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, wbg@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: Fix runtime PM imbalance in
 ti_eqep_probe()
Message-ID: <20260917014413.2f9ee87c@jic23-hlaptop>
In-Reply-To: <20260916072247.1967830-1-vulab@iscas.ac.cn>
References: <20260916072247.1967830-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 07:22:47 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> In ti_eqep_probe(), runtime PM is enabled and acquired via
> pm_runtime_get_sync(dev). However, if devm_clk_get_enabled() fails,
> the function returns directly without calling pm_runtime_put_sync()
> and pm_runtime_disable(), leaving the runtime PM usage count and
> enable state unbalanced.
> 
> Add the missing pm_runtime_put_sync() and pm_runtime_disable() calls
> on the clock error path.
> 
> Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/ti-eqep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index d21c157e531a..84fbf500b0f8 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -548,8 +548,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
> +		pm_runtime_put_sync(dev);
> +		pm_runtime_disable(dev);

Having manual cleanup immediately after a devm call is not a good sign as
it will be out of order.  Use devm_pm_runtime_enable() and consider if the
pm_runtime_get_sync() that the put is reversing is actually needed.
I suspect not.

>  		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +	}
>  
>  	err = counter_add(counter);
>  	if (err < 0) {

