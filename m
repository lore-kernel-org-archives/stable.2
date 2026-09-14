Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F24A33F5
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390284; cv=none; b=Z3D8UXYCuxZ+wjPzErqXriuzdYKAkkyAyJ5FEkcFJ1WDVGGtY39t7MZkG/SDr+sPrHsoOt/CuhJW/XFHHvhoTZL95q1CGaAnSXufnUx5Jd9uBPAT39S/nxngp3JLOJGmABE5e3y6XSKvhsoWHHomni0sSgYCwxpjCLbLagLCm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390284; c=relaxed/simple;
	bh=RUOT7D+R6XRFK6ZDB58sR8ABaVNr55aigsppqxnh9T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2UFJyubZ8LhkOeVcGrXScPvvdsYh82dvepJZ3d5eLvPlK/cgBdiMFXPfGdZ3k92s6OCqTHg3B1vNV6v5FAX9QgYaW5WXj0qyllDe1i/iFHqKrI9q2e61pBezNcKUfV0XtUrv3zftvSYhr5oD/waL0nY+oLqfWd7n/WdGpcH3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y00wAIrj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y00wAIrj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so20078175e9.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390281; x=1789995081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgQC1Yl5RhRkFvfEBoKl0QIvsiqz4jd8a1ncnGvXLCI=;
        b=Y00wAIrjzP5NyVDNPzPu1Kf6i+gtyWosj4TxHuzUwqGnwuw/GoY8Lt15Wggpq2lCd4
         /dtmKKIWNehNh7YOCucMxSGDXYisJh8JX/CTnG8AhfzCsP621g2bprgA+zWSLsURJui5
         iWiEavIHoudV16OSUufIfmaBxNEFrMVm4lDN6jrg4GPiyFsEdP2k3eg3vEUnKssV1K34
         Fu3ZzFw7Ttd7qz21XjYJACIbCxgJvPW0d1Dr3+ZdSnL0Cdqc8yDwC04qGeXy1iDTm9Bm
         EyoYljHIDK/8Aa44P6j387hELQEoHCm30v+IdsUIRAHFOF2Oe3p8v74MTQtYi5qi8Y4g
         ETPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390281; x=1789995081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgQC1Yl5RhRkFvfEBoKl0QIvsiqz4jd8a1ncnGvXLCI=;
        b=IAZxCoKmN5gpXZFMU2PDgduBmr8hlzBwegoDIVextG6Gyse6dKhEOY1DF3+Zovt2nb
         PqvpIl6j8EXo5Y8A6aUeuW58HOFDd0ZUS7U+n35Hgbjw0Zz8pI9SK7/Q1DS6m1UEBTYd
         zkZHwg1xAPi2jbNEKSeapEaBkDMLybMkFM+s5/Qee0oJZzcOLqu0WtQsD423vN8zofMA
         jn7BKCP8q0Qb7TVGyGvcVuuK3c3IqvCfcNZjdofygs8T0svNKQoM7RscEWIcjJZXICQV
         wG6cAtx77MMNMYHcp0GICGG1MMY+yKp4I1DdU5uz/yixQWCwuoV2RR7RwB6/Q6BJUY4I
         C/VQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfoyBPu3RN7SPBydDB1814c5Rh0hppxpL2aDF+5krnoBSNuRoXWPVHJ/JlaGVQWw1EJLBSz9k=@vger.kernel.org
X-Gm-Message-State: AFuF++mpkR74iIzpm17yx2LHYli2UJUlpmzGl455J5SJpTtHOK9C51Xy
	l2XbTsblI4rdeLV6sAn5BBg1wLQQCRxCJbwmwJ4I+SJp/15rVXgfu3yJ
X-Gm-Gg: AYBFou05kLpxJS4oiA2ItDd2YlykbzWaxJuoLXEjnz+vWMcC9ekwdgTijJDZva4Keqt
	LkPkqrSX7kb37ci+MVpDci3w4fD3M8qSg+VpV+MeDZvGTORC3gcO8uJjFU5Ytjq+2Uwm7IZXy5n
	Wk59o3UTJmzJWrxrudjYu6GLBpAxrmn6aNNv2w+ErA2V3Y1kSoYPpBhXhtoZK7/HF/ZF8OPR4Ow
	0YxJuxaao46DyHdgq/vuNID01WvDGipwcJsTIfzzaFfxAlNigtd2w0LC21Y4vD5KC2dskPj2f0f
	I7chwqlL/TJO1AdQeU28jLtwuYFp0cmZb7Mgnsi1ZVmelLe169EYOmWtiWwNC4Sibd5gX8CSIQZ
	uRZVMObiou6qp2RzgOMhPfEhiCEardQdJ3smzOvtuAGm2SdBuHtBWHJYBdsGVolYRddJ/xJvYtH
	jgOjF0J/To+0VSxHqu7i2WQrEN/kkePZVDob6vGA8Qmp61+hP3hDW8Ew2A0goK8MB2fz+smkUgf
	Ju/SbgJYEDQuaLNIC99X9SisTKAX8ObRQRneGsBQV56Cu1aLBIE6i0H/1xesrB9lr9uijjGEw++
	QbmhfXLEZX4C4zS0yuMMr3klJjEUAZpuhSxoo5YYcIT/f1lePvtiHeWNbVetp9VDX/GjX/kB4hP
	W3PigihazX6zHLV2esF/il9uWJcpZVJThtIqrmLbLuMCsvnjbLXPxqCNeet3oto1J18pGCnkjBK
	WMtBC1
X-Received: by 2002:a05:600c:4f41:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49e7a685a1amr32353785e9.16.1789390280541;
        Mon, 14 Sep 2026 05:51:20 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm378995405e9.3.2026.09.14.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:51:20 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:51:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Danilo Krummrich
 <dakr@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Pan Chuang
 <panchuang@vivo.com>, Irina Tirdea <irina.tirdea@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9553: disable autosuspend on remove
Message-ID: <20260914145118.00007445@gmail.com>
In-Reply-To: <20260914113012.1688043-1-lgs201920130244@gmail.com>
References: <20260914113012.1688043-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:30:12 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> mma9553_probe() enables runtime PM autosuspend with
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
> Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/accel/mma9553.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 8e7aaac89d47..5a36d415a837 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1136,6 +1136,7 @@ static void mma9553_remove(struct i2c_client *client)
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
