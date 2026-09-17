Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625F3FC5AE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621459; cv=none; b=i+QOQtQTR+GdfEYtg1/HIap5oSqVF00Ih13EAo5fkFqthMjA0GzDIPlg/C7IuNSCH0UQ6yYlCarHZoq/0xf1VV6PVUtphRIrQnMd1l6vtal0LTJwQHbXsWeDQs3qFcfPyKHKGPQA6BMN359M6MIvJF8BOP5GchnsPG99qS5X+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621459; c=relaxed/simple;
	bh=Fo+sfbiaynX50FZ3e2l/qI3EVG40HYWAxAwO9e8v/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C50oLQ6s6o5iU8n7sJZ1MjpSeXTxeMaEbwws9q+8UPozq9DSgN9ZBN0SgWYlu4sw0bzZzZ4kM7NJk5vd/aRKIp7KMPrjkUwiRyyOdkveNWi6BQkFSX739jCHvRLTALfMHr3fzfHK2AizoW2s0NFV85MDvJyKkhZCbKMH0/fJdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+tDtQCF; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+tDtQCF"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d0ad9b89so3469761fa.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789621454; x=1790226254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVRhUpNhNdTq48LbqzJgmbnOl6QrDZN44ur0P2rl/Qc=;
        b=e+tDtQCFYPyrul2pdnN0dWvTSAizO7lMjAxSytz2iWGgJ50yzuwebCk4uSPWjDilVl
         4QFuyavDqYP8KuybB64wytjVG6iUvCaw9WIERplGTAXf2AKUMZ6Q4H9XH3cJLaqrdunl
         uItqQmge6r0AT4yx8MU5U30WGbbEDrO04mHD7HAcEDBd1Zn808eHTtkPjgZ9/ie2rLnt
         m+nHSXDYsL6gsuYn+6R95ZZq1TG3nHhmx300UqA1UaKykrHl/iWXpfdLO2zUpevcgSGO
         dq+uMoAcVnOoJIZ8z1KjJJ25PHnQd6gIuhwyva7pw1dkXHD7Inukc2kNdzLn7VfCHtJY
         C7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621454; x=1790226254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVRhUpNhNdTq48LbqzJgmbnOl6QrDZN44ur0P2rl/Qc=;
        b=tkTSCkvfQXF7u7sOoxrl52d0GVvus4GuMIhCEVsyim8FVrmY4vGd6mraylm2iOIV4E
         pcs/XbV2Tqip2rS/VEDyidMy5MOC68FgVNQ6lSZrs1R35BjAmXDB1r5Ba0YA/3RXhxmK
         l1fnJcR4zAZIy2CrBySBKZWKJYprdAMSN+2dOsNFqm7bR0WhXOhHmMs3hF9au5etilSj
         qj0V9fom1cl8s95XQ7DMwjdWNXKyc6ctnO19Vw7UB1ALuejOucpj3xddsn9bnGanMF2U
         CEXScYZPo8QBgUlF+vCPG9tvZ74F05XgRCgdKSlrM5QIMHBHp7YZ7jUbdU+DAeW2e8+4
         Cv8Q==
X-Gm-Message-State: AFuF++mI0BWpcPc45HNk6JUBHVOrZffZEsN2fnvw9JuWvTQztZr7JqqL
	DwO1ze4Y8ru1Ayb/qS8GJyXTWmZo2nTdiV3X42rmFaj7fcoCeHFFt054
X-Gm-Gg: AYBFou2FjW6VXHoXJij6wG4saq2YpmvZXXXR7/pprd0xXx2dz7ZMJOPD8ToYMKD8G8B
	BPWe0cH4IDGetEC8P+PRgik2xbrNFQ1TAnKNGkssSASr8dISB0VhyQPQPqjY1mfStZKsZjlL9+j
	hFDTYquxoGAqUrtkvGxHnosE1Rq43pMtZI84ATveuCyI1x7B5+m+U9GeKeAaTnmnv1kYA+C7rcm
	jeBXKZmPZZN21B8tdsXAuFu6Yl8TK27noq7MB9dB3VoIAZWRQIv3CpgI2EbFhpHc3Z9+JcJ1ACP
	wpdgAfP8Qzhy8vPJxvIjvMghyR6tJhMY6cqEpeTeZBGBDG0sUFUYtvLAWBozWGJVN24cGRzfvfD
	wVH/TB/gQ4Z2Q0vTCivsjhMkPLh1C2+24WMeq9H6oOKm9FnPL8JcWT/LyqoGQG5PTpvDMrK6J7L
	4+9DBO/wXF7KHWlDKRSZFUSXEcLNFzqrLZBhUxuINntL/OnZePFklOaw9vHjPJ1TVWOLvAO3+7o
	J9kYB08dqDKvug71Q7Ycvc3Ekxnah5or00+/7I3A+1d1R6mVHDGXYo=
X-Received: by 2002:a05:6512:31ca:b0:5b5:e0dd:1c6c with SMTP id 2adb3069b0e04-5b8b66123bbmr1555083e87.4.1789621453651;
        Wed, 16 Sep 2026 22:04:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e7e3esm1452052e87.75.2026.09.16.22.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 22:04:13 -0700 (PDT)
Message-ID: <43bdf1d5-bd82-496b-8408-871646fe59d4@gmail.com>
Date: Thu, 17 Sep 2026 08:04:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>,
 Danilo Krummrich <dakr@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260914112053.1686061-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/09/2026 14:20, Guangshuo Li wrote:
> kxcjk1013_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
> 
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> set therefore leaves the runtime PM state incompletely cleaned up after
> the driver is unbound.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 166fb786425f..c6b030f64be1 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
>   
>   	iio_device_unregister(indio_dev);
>   
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>   	pm_runtime_disable(&client->dev);
>   	pm_runtime_set_suspended(&client->dev);
>   

I am not sure if it matters, but it bugs me a bit to see that the 
clean-up path for PM here, and clean-up path at probe error, do still 
not have same steps. As far as I see the probe error path omits the 
pm_runtime_set_suspended(). Do you think this should/could be fixed?

Oh, and if it is fine as it is - I would really appreciate education as 
to why :)

Other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

(I know I am late with the tag as Jonathan applied this already - I 
suppose it's still Ok to say I am "Ok" with the fix :] )

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
