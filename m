Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E72BF3F4
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944001; cv=none; b=QNg8W9S6BRJDaRuZYuiXOjcnK6/Vvn5yQ306gattVmLwvEcfGHlC/OisPGuvRSAnp0DH7GYyRW3z8/IrGGlqXPrzS9ls6LjlblRmD5kQZDu3+/mUfN5nl6Nz4gP8qbO96SoIxCMdb9DpBK+tiBtZXx6OdWxJO1zeWEVLFn4HvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944001; c=relaxed/simple;
	bh=ToVhc3AhBahetbU3qnqMMwbQ2+rzSYcR6RO/UlkrYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFMXVOPpDQrRQCZLQGErGoY6Q2JFGKCLrqNeowbM4FocW+iCS/f+prEelVkREua4CJBQdkGEXLz4BPTBSXN8J07doieRI0xZgul9lo8LBhDJch6O5Xz2oiFqtH4iXQD+jGGVhFGs0J6QbCmuaii5r/RgYHJOVHVLNOZENMiqpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evetzjdL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evetzjdL"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso807749a91.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784943999; x=1785548799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eV48ZQHtSwmQ+39i7v6iCNrnUnn9zhxOQgslZYAxE2c=;
        b=evetzjdLLFT6PmhCTwkph0bX/kgsxSIURBk6XIh3EKuv8dtCAybtdGxmaYWz3Cv7UO
         fi/49nLPWPM0peEyKHtTeJncwc28GjMapzgXAO3Ira9yFxPiwXxt303xXC+9p+GFQX/c
         JTUog4ZavQaY1NCHpmIrjYQURXjCxCMniFDYbY+6R4pl5w7A65q3gZzTG+lLVehTrmEx
         G/65opCJ5qCWP7g0HXhhWfswkHbz61N2bzYWh/Lod02yaq6JKt8VjttLuiPzbaNNGzLF
         IWFtw1NDqKVc4gV5P3WSK/QBcFnzsNxtDwtDeoZs/CIIKz3ni2UQ+0LleFFfB7ZJq/Ew
         zOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943999; x=1785548799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eV48ZQHtSwmQ+39i7v6iCNrnUnn9zhxOQgslZYAxE2c=;
        b=UYFHW3eu40ogleuQWsS1IH7qIcqfWYTjkEUhPy4tLuiNzALRGIKOBkK3pEnTkrP66L
         DackqUrxUNk+Bw0EXu9sTXChrJvpHoCqOz8WPU2rYdlCGhGuKH0Nn0P6nIy4r83HT8Qt
         vy7U8Ya5KQrgsrI9M2lvImP+W0DE/VTKXK2ndU2hfKD4JFSqP25vw5xG5vGxtzYZVWbs
         FtIVGKTUTraWVFnbXb4Aeap9cCZ82IUt4ei1mHPxhrEDaW1Qo/MqBfp9VI6vk76FSZtT
         9BNRboUZMFzKzD4SE/3GpPp2cV05Tdx3tSsxlVyM1L+nhVrILLlxBSF7OrxAFLAvvROB
         yWrw==
X-Forwarded-Encrypted: i=1; AHgh+RrsLCvW28tNhoF96mM1uOcddvOMLOmM/oLtQ2rZAvGeK5wAPs/zKh4KL/JQ7ZGjly8BWOLvC/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItNmqlWxovFnYLJzitHwFvbQtibdCZoq7r8csfYpsbbhXCtYR
	dUWX6xIrWDPv97ZULWV4mlx4+aTeHClqrNj9g+YkoMTqoH0HC9vwrvPDokP1sQ==
X-Gm-Gg: AR+sD12CSM/pysPjuOfHx1vASHBQPP50Ebx+ll9Mru4NJG1aiZwqRrgL7+/X7JcIFWh
	D7a8MMQNRQZY6fvdSA8kZymi8OfaCA3q5Rn8d+LQk4BRwn5cBHTf0Sg2KfOlgsSL3ODnCTT0o9y
	LjV/eTbzQvyQvOi7XaWDxClZ205ppBQZxvx+nvP8v0VG/Q4DmFCGGYIO0g8DaL8LypFIj2x57m2
	y5BnvKQzm5xSIxdcC6qOd0gOm0tjLi01hOOuGGv+kY/5/4y3kzoXoEUPw5vG7B/aF+N4Ts5/ynf
	1rZauGlsx99Hf5mjMXwY3z9E4S1lERJH51nlZKKj55KaPxXx6I2gsuVmOIqZVHQcRXK7KvFaTlv
	O7XIET7v+wOyDdYQL+kiKLELV2bi0D4/VN1BTWy6GF0BMIDHwOyOn9khjLkwfhJR1GEbC44XzT4
	mWLW9QR9fMMEHFJKv/lZD+0/8MX43GkfEyp4nQppPz9qs5REBFjc4FPg==
X-Received: by 2002:a17:90b:5443:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38f2961e0e6mr756142a91.26.1784943999088;
        Fri, 24 Jul 2026 18:46:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm4637809eec.17.2026.07.24.18.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:46:38 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:46:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, 
	Tomohiro Yoshidomi <sylph23k@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: psxpad-spi - set driver data before use
Message-ID: <amQVSXuehlUKEeCy@google.com>
References: <20260721055551.1714965-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721055551.1714965-1-lilinmao@kylinos.cn>

Hi Linmao,

On Tue, Jul 21, 2026 at 01:55:51PM +0800, Linmao Li wrote:
> psxpad_spi_suspend() retrieves the controller state with
> spi_get_drvdata(), but probe never stores it, so suspend dereferences a
> NULL pointer. Store it during probe.
> 
> Fixes: 8be193c7b1f4 ("Input: add support for PlayStation 1/2 joypads connected via SPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/input/joystick/psxpad-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
> index f902a56d011f..b1ab2486bb0d 100644
> --- a/drivers/input/joystick/psxpad-spi.c
> +++ b/drivers/input/joystick/psxpad-spi.c
> @@ -301,6 +301,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
>  	/* input poll device settings */
>  	pad->idev = idev;
>  	pad->spi = spi;
> +	spi_set_drvdata(spi, pad);

I moved the assignment to the end of probe and applied, thank you.

-- 
Dmitry
