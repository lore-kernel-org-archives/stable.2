Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930F49EC5C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390236; cv=none; b=DlCiTRA5yEKXHK15SEuDM4LRAf/XOFRPBSbUsru9PasqfTNoYGlzwsp7FTRdeErqb9vvYukjDEbFwVYBfeEW68m6kE4SpZ61E7QMDHAIs0xycv65BrAnvrSg6hATv/Z9J4x54cT3+ma+yCW+ZUwAOQwKSjh+NYZVNFMAt4BLVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390236; c=relaxed/simple;
	bh=CMYe6CzVR1lQ4POVMp/udjPhXuoEKJUqjohFpdJjIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZlDvPtUFr2boLRpE4/qdyK1iXFB2FRKuov0vduV+nfkyoicQDYw7ZkBmFWMP2E7LGwHpCA2K8XabR4RLWCbQHqhx4RZ8gu/7RJWIydgd2tlO2w1HgMIYVHFjZ9hZkeMYI8BwpQr6w+1Mht2Lr2O8yufAWC6Oj3urvYEdrvQVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwftJ+Wm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwftJ+Wm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486e70f2457so1655392f8f.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390232; x=1789995032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFP+vIzlMYUkbBxuUWjprqiU9MvG3SgKEPUqZyew3x0=;
        b=qwftJ+Wm2ptD7ylDhNOtdkE1Uj2os+7n04pLouNVH7M5f5Av1/kAkU2U4iYYkSeuM0
         5/mCUGu/t++YubOarRkrTE19zplY89GpR8ngwIAWuQfJ+BIa54UI0uR8rmYiQVtgr7Tn
         8EKmW4Fp0+VdNlxTtykwMY1tYDTEoUhbh+/nDO8LelGcz17nJlxowD72zYeUdIY5olmf
         veHorqOWjPWNQ5DQGqvhPiimJsqCqz1YiKRaF0VriUfDhwT9iL8DQy/KymliF9GL0k1Z
         MrN4Gvl0oyBd8O2qJK1h7J2xYLeUt+c0iAa5TU/RBhFNzn54gAn6fe/YkSEvoTtpZXs/
         7Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390232; x=1789995032;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFP+vIzlMYUkbBxuUWjprqiU9MvG3SgKEPUqZyew3x0=;
        b=tW7cpNzAUxKM4Sjw/wny2bl5T0gE15vlFI+r0UdsoWWAQ4lGwphkEnPy3zTOKTe5gG
         DRW574fk9DJydC7PGZpzb2wsa7b5oAEtAad0z+8Monrwgm/Tx9e5/zHJ8U9GUKfoBV3/
         nEP6GIVyDDNAcCRi1irDaEMrZJFDWo5Cxc482oFTdTFgpkZRg2iQ5guLpuhfcBj4S4II
         +5ZvRq4Wu34qU80E3YO5Tz3Sh6EwpgJDBWHizRxLi/rLFBjLNr76E+Eu32hVOg4ML0/c
         /hB+WbgdyIL9HwY3hGZ1cUwNO7gjuS5iYvP8AyN94dUyp+L2YzFoPtdK0vuwvXPwYdb7
         9Ygg==
X-Forwarded-Encrypted: i=1; AKwUvBxOdORXdHzRL+6GVP7YSAb1tAnbJDQEXAZasMNI4xKm9zpRJvPIu/raADLUuUzJPxtjjviNi3k=@vger.kernel.org
X-Gm-Message-State: AFuF++lDOTUCWRZUjeJIKTOp0p2EsTIwNLjcDjhBeIyErZogUXZp6Ygk
	U1oUwjM8XI0L+bUMdD7eErxIrEB0uO0Q34J+Bj/VQ3zZo8MEc2bUriu1
X-Gm-Gg: AYBFou2nN3GxTE/LFUt3vkuT4gq/mz9T3qpMtX+Hj02r6IKQrGtTGlI43ltcwowfyNZ
	sPHNy4geWDIX8Ffwy6ZCa9KSJ/vFOVCMFgkQazyEdvZFw4m+tBE437h3jyrjmZS1zS9Xvejan1t
	93mEJdcI0dTX7wwr7agISOld0sQ0j1fYKQRO75xn+70BU7eno43i2FnbXvIPLVO3zfzecC4tLxu
	iMCRSMenENEK/ZlT4wQBaCFOronX3/uL0XbAMxe9K+Kf5e5on7QLS3hXEYrYafKRQUNcuj02uXi
	GkmQ1DtY1ef3LXsaS29ZYhTfy+Xyyigmsm+1pM0dBJZSeSm57R+J92fJPrKZAmJFWqi6709zB7b
	BBVKaRIBrEdLw08JMwkqXAG12azPM6qNX8LWAWnvtiO25J9bScFzC7ipDmyk7fVzHk1s/ri+Ztg
	pGzwKX/tmR2vbBt7iVkwF6aOqzdNqMXC8hgGBFr9fHXrsQpCN8B/+/WVXfb/2dsHMuItXH5eiMR
	H+CLcXlx9ywFZiZh36bKEMt+X6f5ezo3kuwgwsAA9Rz3xOk0JFC7cFLQ1VtWSrIbE5xFP0OFanD
	fwQMNj776hhIHOerfhmixPCBERZD4NNeKjhYhJGOUyxTBhXKWCtm8aYNTz4v7/gJGUmG6vBVzaT
	c0bqcC1X4Oliitz8huIK4BEOLIcUiJHUOEJz/oHXaj4Y4ZoJH+/nb4ulbcw/yP//uWw4C08FnLh
	hBYj1U
X-Received: by 2002:a05:6000:220e:b0:485:8c16:a357 with SMTP id ffacd0b85a97d-48702b2ed22mr2693304f8f.47.1789390231445;
        Mon, 14 Sep 2026 05:50:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea4fsm28119004f8f.21.2026.09.14.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:50:31 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:50:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Pan Chuang <panchuang@vivo.com>, Irina Tirdea
 <irina.tirdea@intel.com>, Vlad Dogaru <ddvlad@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551: disable autosuspend on remove
Message-ID: <20260914145021.00006863@gmail.com>
In-Reply-To: <20260914112447.1686972-1-lgs201920130244@gmail.com>
References: <20260914112447.1686972-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:24:47 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> mma9551_probe() enables runtime PM autosuspend with
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
> Fixes: 6da93a6710a3 ("iio: accel: mma9551: Add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/accel/mma9551.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 7e01427fd9c4..182f488edab1 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -500,6 +500,7 @@ static void mma9551_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
