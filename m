Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1B33B97B
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581203; cv=none; b=gtsp5ibvCekJKu1IPpPHXn0a9t1U9/Pr2zAW/1KgeyyEJtGSvK83/DkXyrBFW7VklLuHi8XmgXIAOjO+ALFyMeZfj2wXYxX+1eXOVf3ox+h5KtdWkKN1TASpuh1fj3lCBo7uKUa96hWLtN0Lgx4b2zqkW44wCP90xa3wOKv2+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581203; c=relaxed/simple;
	bh=4P+AxRu+aP0P/lZrxKgWWxmE5YAZHis7WqiS/V5axvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lW/41rmaBS+2egPAV6ckwilHjJyvKw+MhtjMFceLr68+XgDT6W0AX3UnhNVHw8/W7HZPhdq8w6+0mVLFvzS2CCo5cElEhfq+bS8aCoyjxobrtyvaNiwDDavQBLzfs6lLqBA1Ved91gXuAvLx4rFVV7Xxph8YtdVTL+rv1iW8Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNflKD2c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNflKD2c"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49249707788so16161965e9.2
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581200; x=1783186000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDQP8mnP+Jn71ABEIP8xYOjy07PIL00ezJXXjBMJLS0=;
        b=nNflKD2cbAh8+nXjj8nFF5N7LBT8EL1im+xl2YmyrdJFtugAIy+fj9OVGZf1JROvQA
         q8kKMUBuaAZEaqKSlSsRZtUKMNz9qwFqP/tdtzl4T1qZ4ZLFd4+6cQaP6Sbr5XnGBx6N
         wYBJhK68ob5P3wuWW++AuJfG8WHnqvZyVXs+stbT+aoup7DO2ht6XyPy3NeepiQCTPbR
         KIAbamcdSGJd3k857v7rV0Vjr7uk1j/4DV0gX6ExjWqa7nIi8vnB7wQL+yQ6VjmqVka1
         /RJgs9Xv1z+0Ng+UIuDPoGU9a2BF3QP04stBq1qQsrVEYXDbxkR6vy/ACXOk1skBoTdD
         P5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581200; x=1783186000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDQP8mnP+Jn71ABEIP8xYOjy07PIL00ezJXXjBMJLS0=;
        b=eMrtYV1Z9Ub6LGr1DpUTWl7RGeQ1DRpuN19dOUYkQoKRkONzEar6NH5qP8XLEKdQNe
         DCS5dKYO8wQlbby/56SpY5qi8k1RiOwO6O4k+TyV4ErwIf79U6iJiecKh8d+/LC6bpAS
         H4IR8lADodfhhzHScU4kOk1oc1maQMw10GCmofBmbUhh3zfGHVm+esaSFQMqmLFaGyMY
         vhVgbXiV5nfjIrG9ihPTUtyyKyraCc/aBuYdsbgwvdjo1y7SEPKkILgoHA0tKkgZksAl
         mHMf4GwMuzOj2Brajs8xS/mnAKjf7ycYyDf6iDsKTggOWoa5uaB4bSjR7827iDPygPZB
         +7EA==
X-Forwarded-Encrypted: i=1; AFNElJ/vhh95J0cAISxyNPopns94wYuTgf8pG3bonny+PB4UO4ZlkR4tdc5JpnKKeB2aHVeG856RthA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBuRZSNM9PFridUpMaWZuuUHld7UDtO+/ISKp34YK6n2VP9N2
	yKhXT6wtBckWsW9Wmm0WXMUhaLWDw5BoXJHkb7l8p5FKDqU0t4uxZHGgbxc+sg==
X-Gm-Gg: AfdE7cnnIujMYuqax5CSumyWIQMg+o5Ohs0KF4wJg7mCKuZd4zl6jMJZl8zPHbkOP6S
	JS8jIrWDzjp4h8DWRTMZQgiWKeyx2JCmB2zTF8dPxdGgbfwLfw5RHNiautEkcpClei1swCSr3LC
	KDZOnGAyfZxlO6KtVBXRHw5lhj35KmieefvtKxGR0g/4Igyie+X0aF4Fd/M4IiVi0EJp0DKpv2v
	0WKyh79B1zUVaSTyj2aCjcY2063uU3I4xOCN0mc/7raMUzXoWj2EU3CsPR6ywObkseu2XAH9nDw
	JMCt5K2OQT51eJtpSnyiyYHYo1m69aQt7Zo9t98CCn20GwukVuA/Arh5CQhlCcLwLUqct8sOm+e
	FdmJtgOEMZLDoL7cZioFoRa/01ciHq2TemN0Ursn+F9oZr/vSs82N6zu4xA8MrnwdHdE+Wy7GzQ
	dh+OkEyZ93Skei9ExSelzLB1VT2mXxtsM82sTVNDvXqW+NccLoKdpzStoKKaGdY+JBrqv2T+AbS
	Vt27Y2LfCEABV8XuJGRF1Hd4eJcKIyxcPMiiDS8KpemW5sDNEvkEo0Gv95CZ1lnDo0+y6hoDlU5
	renlgUPRXa1takCh
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr87904095e9.24.1782581200242;
        Sat, 27 Jun 2026 10:26:40 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071c9esm170020025e9.9.2026.06.27.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:26:40 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:26:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: adc: ad7779: Initialize completion before
 requesting IRQ
Message-ID: <20260627192638.5623df0e@systembl0wer>
In-Reply-To: <20260627112205.31409-1-mokshpanicker.7@gmail.com>
References: <20260627112205.31409-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 11:22:05 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> init_completion() is called after devm_request_irq() in
> ad7779_setup_trigger(). If the IRQ fires before init_completion()
> runs, the completion is in an undefined state.

This is probably impossible, as devm_request_irq() is called with
IRQF_NO_AUTOEN as a parameter, therefore IRQs are enabled manually
in the code.

> Move init_completion() before devm_request_irq() to ensure the
> completion is ready before the IRQ handler can signal it.
> 
> Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/iio/adc/ad7779.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 695cc79e78da..db8f5f4c6d6a 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -838,6 +838,8 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  	st->trig->ops = &ad7779_trigger_ops;
>  
>  	iio_trigger_set_drvdata(st->trig, st);
> +	init_completion(&st->completion);

Is there really any point in having this when st->completion isn't
used anywhere in the driver? I'd rather be for removing this function
call and the struct completion from struct ad7779_state.

> +
>  
>  	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
>  			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,

Unrelated, however the dev_err_probe() call below this is unnecessary,
as devm_request_irq already returns a dev_err_probe on failure. Consider
sending a patch for this as well.

-- 
Kind regards

CJD
