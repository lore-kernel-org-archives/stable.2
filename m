Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9923859F5
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790397638; cv=none; b=doFgrRbUGCfwxgzd9Qm3jkPoMuS5+A+A44pz6VUMBecSPGgPmRqfWNHz0YHwuKE31j43yegCA4lPPtmmpdTr+TxwCj91eC9qcaiSfSNck/PJEsYK6KAFmCzOBDJn0QjBfacghwqM+YoL6H0EjnyWozRnfkE1I0uw4e1a8CJBehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790397638; c=relaxed/simple;
	bh=9/8pQ7p02Q5KmGp4IRdYWIfOXW7xj9/SWyUcOpAt66s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T98pdcZe6Vs6Gsa8VIHYOMuS3w9iNQ7aDbzM6/1hMMgNJ3TLjAHB0PtlpdSAKVrkxCXRQKpnAHBeTFvhu4W20ciyPr4LDrP8DLo/j3PEMNFm4r0ug2xS+hAZWxFRAZslyap/SAgFtBgqaMjKV3LyAnse0/aRCJI/WuMKTRC3KQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ0X+k1Z; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ0X+k1Z"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so1774600eec.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790397636; x=1791002436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUYBRI5sdXRLkIxlzo71bpLRDvT0ncaqZ/+GUrIm8/E=;
        b=ZJ0X+k1ZokMbEMxaNXbmKkwxVT4DgAY4qGz8jtRM7WA1hMlBbEL3KR5UkrAXE/l3Ml
         5aj3jEq9po2uT7rjl1kSTmSsl1QI2tOsbv1HTbZL8NXQ00cEqMFZMtfKR9lnY3uM/Upm
         dmCteq9/XCCYXPaEBnXni8hojKoUR4eaRq2Rd6vRWMsrL2NNBmhTxq1y3Q5300QeUnk0
         7S8pDT3f4iRRfw5O6h29OxRrsC6T7KTp5PBBjFj6OhULzDSU8oeTuXmHJ6zuWhAsfl8u
         x11OiLXBKyjz4y/0HwF/LzPDu+ZJSyWNYGIBd+TEv4VLaRRJV6WNftleKhOgm2UnIobn
         HcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790397636; x=1791002436;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUYBRI5sdXRLkIxlzo71bpLRDvT0ncaqZ/+GUrIm8/E=;
        b=sLfwV4vXEggFeRM68B/X40sF6uFTcNsU6Xe2Pbf56swfgfSG/p8NgXmlo7Wgy1Nuw+
         lpfD1ZztkEh690LBPwLWMv79ijmMv+uL4p1+/QFu3hg5kFYdlQ2yG20XkuHTCmo9k8Cq
         ThP69kekbigoSKUttjPzlezt2ByX5mfYj3wW2n/q/ammscliVyk1kTzpx+6oUDt2QUp0
         4K34RN9ia6Fb6FV9GVlLunvMU/efRMmMokUep2RzHYa9d/YwzzOqei5ImEoPZi65wMTX
         QSFbwa2KeHh5QfJ9DzO8hzAahi7dC2ON9NMA3WwQ5h7YjPglXqi96VMnyFiAFbyEtibw
         6kLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5s9lpF1AezpdLBccqoZM5RR6m7ZHIeS/g/ID+UiVDXydCdajLdvDEkXYOaKCZj/iYxpq0n/0=@vger.kernel.org
X-Gm-Message-State: AFuF++m77prNFZSs2DPjxoilCkcPWdwGI+vtkB1Pohyh0bCqKzWAIuNp
	9C6wRYH2J0bD3jP44aOzgNurZKRzPC6kQUqyrHUbBbvoJt+I3hS3PTk2
X-Gm-Gg: AYBFou1JAV8L5Yf4s65/xE7t3CHnj0z0YjFUXKQzkRmdH3F59k0rT1NjuelOE6zYZYP
	WXRNgC4kpV3Ap8xb2M0PqgScjlSPMw/tGrSle8x+Gd3EEJ5KO6HM0whRr4DUy9mCPJx5dymsl7C
	0e5NnhgoXTQeDrQ4yiEjcBFX+eXVZp3SyLdyhJ7rcqBYAsCk+bEwIeqQJpGfQDfBz/KSYu/M/NQ
	xZ5+NdLyKTLuzwfKTuDs/MA+v10AaSJnu8rA9VDBckZzigzRjnY7y1T8F2lTSK2MP1IkrlrZDpM
	zDHTDqkd++wc8TdqQHex2PpZUp3sw6HOHwKUzUdZhowEWhl0OOTuPDJBqUNKOTO55BUYnSMb6Wi
	d+amhIXhYIQ0UeK3b+AbJK3YFK0DgiUvM4Cgxtuz3cLZ5n3fNO/QPbTdfssb8GJ8fzWUeFIvzyg
	MsveqjyJZyU5y23DtP/VlQ/07ZHrtx/gYxTo2e/93EcmrUb/o4kkQkH5vFxA2rKYZF4PvDbAsGi
	of996guNe/3h7Ntcx5VYdytSooXbaINHdi0HJ4=
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr2032551eec.31.1790397636098;
        Fri, 25 Sep 2026 21:40:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341447576b9sm11731720eec.15.2026.09.25.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:40:35 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:40:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
	Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: s6sy761 - fix resume ordering and restore sensing
Message-ID: <ardMSVsG1RlOOkNp@google.com>
References: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>

Hi David,

On Wed, Sep 23, 2026 at 03:27:06PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> System suspend powers the controller off and resume powers it back on,
> but the resume path enables the interrupt before s6sy761_power_on()
> checks the boot. The firmware raises its boot-complete event on the
> interrupt line, the threaded handler consumes it, s6sy761_power_on()
> then reads an empty event and resume fails with -ENODEV, skipping the
> touch function setup:
> 
>   s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19
> 
> Power the chip on first and only then unmask the interrupt. Once resume
> completes the boot handshake the chip comes back with sensing off, as
> at probe where input_open() turns it on, so the touchscreen stays dead
> after resume. Send SENSE_ON again when the input device is open.
> 
> Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
> the touch function and sense status match the pre-suspend state.
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/input/touchscreen/s6sy761.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> index 0f24a9b730635..c52c45a7d1029 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -495,20 +495,29 @@ static int s6sy761_suspend(struct device *dev)
>  	s6sy761_power_off(sdata);
>  
>  	return 0;
>  }
>  
>  static int s6sy761_resume(struct device *dev)
>  {
>  	struct s6sy761_data *sdata = dev_get_drvdata(dev);
> +	int err;
>  
> +	err = s6sy761_power_on(sdata);
>  	enable_irq(sdata->client->irq);

Why are we enabling the interrupt even if power on failed?

> +	if (err)
> +		return err;
>  
> -	return s6sy761_power_on(sdata);
> +	guard(mutex)(&sdata->input->mutex);
> +
> +	if (!input_device_enabled(sdata->input))
> +		return 0;
> +
> +	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);

Explicit return err/return 0 please - there are multiple failure points
in this function.

Thanks.

-- 
Dmitry
