Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617343;
	b=2oLmJN+lj7G2HyNsReB6qecaFvSmrJfMdE0bYp50PGEZ2Zz33/DMGKGlRpURZplpG7HM
	 AF8o9jPEsauikYxV9XYutc498QrJ9Dg17WlbHCJHp7TWxselZfl8DHbdXIGYAvcfbbE9r
	 Oj6k8HqzZmE7aQGK7I9AdXeIlH5U2lLgOFv0cAij7W918t2X4WxmrkG1hzu1aA03/Rm7B
	 MgLkhH1kT6/3YBQMoM0W32sB4BLOI2f0PFQCJtRAxRc0GeSK7qICIVPydannvrOyZ+SZP
	 6a7LB3XHdB+cUqKV4zsyWPEpSqnCqwc/I8SyYIlL/6mnhUeyuQ9ceau8KlQS5Koe5Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEChbe07XcS8VyFGE2E+prkuKsnUUoiLjh3WmKMknlw=;
	b=LbIEbtWw7gKXB3Zlqd07ULlU39LrSLJqTSR1ul/KoNIYVEQcqCR7kOQY5iaHhZIc3KJp
	 FVsOK2EpCLzamYbdTwAPkDFbxuRr3S68IkFEK4wQ5tVf70ItwYtEOSXzgPpru243Fxw7n
	 8p3U2s253mAIYqM1ngK6T8HgdSQC4lMYbM8Trt3DHJxsnUmjUeAYfxYfnC5/12HUlYfYJ
	 RuvKIxNtGHl3ifaQIjpDgxfbFt9dUOCYgN/vVIpS4tw/kErjb8raKUHDrIqrYGGtrCewQ
	 mH7cOaXv1kmtETEkNCjvHQ3q0udumvVJZplR+bQBP3JFsLEsuBHPtbd0JPqsyhIMKhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=iUayklwr;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC0606A32C
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40AC0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=iUayklwr
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-921367ef6b3so41411546d6.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795617342; x=1796222142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEChbe07XcS8VyFGE2E+prkuKsnUUoiLjh3WmKMknlw=;
        b=iUayklwrU1PG2k6O4K+7E2RsYgwQjeelhy4qUu1w1laVhgVKKEzQFEsZLbXcW28eOv
         kkox1y2v5pajz0OHbrJorz87RMQUGckKOEsStB7D750l0+zCO+gSPSfcs0CWq+wj4mkP
         ho1qLESpaq0/NPY39gCNx3CpWsiX/MwxbOihWyOYOVcck9z9Hu+HOAaj+fRGG6ERW+CX
         uvmi+VJQ+qFnSmfmdMJ9wLnA4lNCPOYHEh5pGzD5u3ohAJRVP2nU3UfGxGVDpTvFFNIA
         0wcGRu8u037a3rVcJqfjtxYkH67xfJXnX9PawBIBPaTeA8wrqJbAZu5y9lmrb4jAQB9q
         HNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617342; x=1796222142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEChbe07XcS8VyFGE2E+prkuKsnUUoiLjh3WmKMknlw=;
        b=bION2bO2azvtqSc7nQvJts7aizQkGeiJRzsCv7ZrEea8FoH6XnHxVMBbsRQTRC9iki
         BDhOhlPtXgbjnOiRJ9v5cXoxPufteFU6kftTybnvD5tDhFIhQRMjo/2rDG0RiSUeTMp/
         AxDeov90a22zii2dgLCSyDatw/n8I+cM+KmKlMVapzqA8P8fLlybsaHPhnhFg0ZiXvX6
         wIieoACNxhYwxxIiLDZgoErSkSIvdY6nwpDITMLWry5BUXMDoiW4HTLCMeU/k0RL4ztc
         g5mvYGZWWPUVysBw4JovxVN/q8aNR+/pOfQ88f9OpMOK7uXrTh96iH51uiJObZTbvdIo
         BhQA==
X-Forwarded-Encrypted: i=1; AL+hErFXXmsBIug1mdsj7rY+lPN2uhuYrkFZQFVXFM4PE1TClDyWetwxPHHwlQl+pVaEa5I2uwcj7vo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fkNY0+cRK3HBCVQesNyya5tj5qf7YqtcIVcdQPzHx0oJtsf6U
	o3/HlYx7ALI6HvUg6O/rg+BMYRRWlXZd/Tt+gKuBrlIZ7ZTwg6znZPxKsI4vRDJJgg==
X-Gm-Gg: AZFdTZcgzXr+l/fxT8OEeS13RaRlotg6Nu2rKyzgx3MWkHQiVQMm3odAh6bqlbeklnV
	ELjAYqO2q7v0DwAiP4RXCr2ynSgt+RZQ4drFk5LrGq6olrt1zxe9FLjjUyEUp/qYCdLYl78rTlN
	H+Czmhy5MKhCRsSGcGV1G7d0kaiv4JNnselYIK71WPrJbsrv8fWWLi77lRs53TEzcESG21c7Rnv
	iJGsQBKBRcvlBDQNntsqbCm+QBYkixX56B8oK82z0FNhmFezB3HKL6zFyULZgwDvmbExyeiY33r
	U3kVkOPWy8tvXmA+N1pGGYbEzKoaNmAxpbG5VbyM+gbtwxYs3+9CMlxoEVVS9fyeb/yfZkbnR1v
	IlDVxsrr4MeAGoyVMM7V9qM4571YwdEubx9LyxINBFqva4n7pfVeUtGC357Fpyd1mezwQ7u9mkK
	MuL/76TDYGOonJP58f88mA0FUinGPMilzi0bco64wdWQOfz13/oiQQEsKjMqtjJxWFu7xqhPmxV
	vlKv6CHm9geu56iE1VC3efeE7jL2qda9p/NgTUSzi46vzmnZO1QnfidEAmCRhkCrtLqeU/AbvFx
	eoApeZmp2+BmrvGxmbt1Fvt6hncvhg==
X-Received: by 2002:a05:6214:2a48:b0:920:f523:b033 with SMTP id 6a1803df08f44-92134ac19b9mr335925696d6.29.1795617341974;
        Wed, 25 Nov 2026 06:35:41 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::9a34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0e35sm163215246d6.20.2026.11.25.06.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:35:41 -0800 (PST)
Date: Wed, 25 Nov 2026 09:35:39 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: udc: do not fail bind when the UDC has
 no pullup callback
Message-ID: <722603d5-ad2b-44d4-93b5-a629ceec9305@rowland.harvard.edu>
References: <20261125092004.15562-1-aristo.chen@canonical.com>
 <20261125092004.15562-3-aristo.chen@canonical.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125092004.15562-3-aristo.chen@canonical.com>

On Wed, Nov 25, 2026 at 09:05:30AM +0000, Aristo Chen wrote:
> Commit 0ea39e030a80 ("usb: gadget: udc: Handle gadget_connect failure
> during bind operation") made gadget_bind_driver() fail when
> usb_udc_connect_control_locked() returns an error. Before that commit
> the return value was ignored.
> 
> usb_gadget_connect_locked() and usb_gadget_disconnect_locked() return
> -EOPNOTSUPP when the UDC driver has no pullup callback. So since that
> commit, no gadget driver can bind to such a UDC. max3420_udc,
> fotg210-udc, fsl_qe_udc, goku_udc and snps_udc_core have no pullup
> callback.
> 
> The core cannot control the pullup of such a UDC, so there is nothing
> for it to do in this step. Skip the step during bind when there is no
> pullup callback. If the step runs and returns an error, the bind still
> fails, which is what the commit above wanted.
> 
> I do not have hardware for any of these drivers. I found the problem
> with a KUnit test under User Mode Linux that emulates a MAX3420 on a
> fake SPI controller. There the bind failed with -EOPNOTSUPP:
> 
>   udc spi0.0: failed to start max3420-kunit: -95
> 
> With this patch the bind works and the emulated controller answers
> SETUP packets. I did not test on hardware or with the other drivers.
> 
> This patch and the test were written with an AI coding assistant.
> 
> Fixes: 0ea39e030a80 ("usb: gadget: udc: Handle gadget_connect failure during bind operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/usb/gadget/udc/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 577bc15f61a1..aa6226666eb5 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1680,9 +1680,12 @@ static int gadget_bind_driver(struct device *dev)
>  	}
>  	usb_gadget_enable_async_callbacks(udc);
>  	udc->allow_connect = true;
> -	ret = usb_udc_connect_control_locked(udc);
> -	if (ret)
> -		goto err_connect_control;
> +	/* Without a pullup callback the core cannot control the pullup */
> +	if (gadget->ops->pullup) {
> +		ret = usb_udc_connect_control_locked(udc);
> +		if (ret)
> +			goto err_connect_control;
> +	}
>  
>  	mutex_unlock(&udc->connect_lock);

Your patch may conflict with this one from Alexey Charkov:

https://lore.kernel.org/linux-usb/20261117-udc-connect-v3-3-9413b491d213@flipper.net/

You should look into this and see if any changes are needed.

Alan Stern
