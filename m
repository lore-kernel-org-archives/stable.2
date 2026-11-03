Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731524;
	b=mYvCaWqy9ffV3oyWDifKafnZRAhfnyJnoj9k0KOn0E+Fyoo7Ln1DRSnOgZZRg8F0xmK9
	 eUgL1cvcUkwKsiurmvQdG0xnsEOYMamvpEgLgO69kaWZh1aIEzQugL2ebJsKSJCAUB9b+
	 x5oPepgUexzCTWUw12WYnyvv23FJ8Jx11f29XqgPdgCFEKFJfrNOGNuvtiwI8Mp2PcruU
	 8YfjMocFKVCmYspqtImh2oWtPpiG9Rj9tyoCpVPN41nn3n22TI0K9ZKigOdn6Qy3yJu3A
	 UMDN6uvJh8GPsdKXl11//uOSX8ABVShIpYibjdG87rfY6MpDU10o8HeodtF5UL0Zhzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
	b=HxNfnaIPPy7UrC2gfQcL15yXF9A6NG0BL2xPeiKBcnXadl9oTPnQXwAly/aw705j0tax
	 Yt4Vlw3ucUKqjl3+2GJDnvRNgFrNrV9Tmt9kLNpteBjha/1ulxXxtYUfhHUljt5b7giwr
	 M9Zh7A0bLJhqGTzBmvUUECkRMYzaNWyDZpRyRtt8HQvatgGBD12VSPnEes90pZN3SgRSs
	 AayQVKd19RxwfGoFfPAq2uQ1ZStjhvmcR8/Yat2UltsR33rRcF3Dm8TCy3qbcrkicCKNo
	 7sDiuhSMTNceFcPZ8DsjUYeoQRsqHilHUIj31Z+v27U2sIMzEbCCUHYbLdZ/GQI+HsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bRn/Owv1";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC9606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDC9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRn/Owv1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35b2c599f43so8042273eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731523; x=1794336323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
        b=bRn/Owv1Hbfs4AmSN8ZJ7uUv/i0z0jsI2n/FSJWVnU6sdNs5Vsb6Xm0EVSeeyfd25e
         s08GRHSnBiw1wt2ZJ57iKnFkzIRWVkEfnnoHjWhJR6uaMXyzdi2V1uY1dCOJnvcLcAGa
         tOl46D5H4NCfA8pH4ty8mpstLEBI841odDGE8iZL288BlhkJoNYgWzNsmV3/wZQvJ+Wd
         b1IW+EwkaujwJlpUkvjFTkIXOHtGxTisL8ZYCyaQVlXAw4Nhu+h4ZNRpfaPBcmrbx2YY
         dlot7YrLO0aHSIq4qsDCn2RGmFQI/dsYji3caC76+BjaLIBiVvV1Oes6fIIA41IYUj8V
         x01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731523; x=1794336323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
        b=VYRpx50TWK8kIlH1ZU7EGOSFzRLEBcYQTYCg+jrBcq40hD+zKinxTY4b2/LXDpib2A
         SiKClYpMEGAscSdjlIcF0Dj02471lZfxmeiCu64CLgDf+4rDRuUv1YM/PxgJeTrHUC66
         sgQhifTA36N23KTUSxXyg7NZ6lNVlF818ebZrZ1BWzfVPb8thTnVRxJDFnxV7ArUsA91
         bYFqHZTAMPHztf6cPN/Q7Jj1fkkYqhQqAslSg1Eb17zJPby+yeAQJkTKX1uFiWbaxAtW
         yzYrRqn64YJdcnkZhJcyW7rQvaRTZeq4ZxVd8rwLnTM4dywHBwFCOFA4wTWsMPheXTha
         gIUA==
X-Forwarded-Encrypted: i=1; AKwUvBwPzFPEPtXRkD9EiZkRmHez5dPcbRQqqZvPBci0y0BajSuVqekZkOUErejfcUYheyvCLeh6dH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z96QmGBBtQWrg1gAQLltNficn7II1LsaZh9nNCzCs7cjcIV4RPL
	Po0aUyB3Fj4qCpASgsklzZ2yHUu1X2zKuxqAZHxLRbGNUezZsT9aKjAh
X-Gm-Gg: AYBFou04j8tyvnwOaoxVc2cdgE4rGRknCbS926kkJgGy8/4Hi5gUA39oFO6UAQ6zzrd
	5kn2isW8jrsur4L7BpEtvIeJaFxqLfvh5glUgpUilXxkm3hXyUtiM0fG+Xi6DGBNsLE7BqpHyOq
	qSaBt5c+MmGZzHTKUVzsuisfuym0/hAePqUmV5vO9/5BoRtpXzWTf3IC+EO2JraCCnj8kFfKIIt
	GAP5GCAJNJZ7gWYB83V+nBAmuwGp/QTWW5sTdnCrXm7t8vQOh09CDgyvHtFcQU+GaG2BUZxqt4I
	9iyOpKIzHYjoq7T4mgJHtgC4bFA1xnq+nndebMiATcDgI7vfOcS2a8HjJUWBbN8x6LeuqA6yjm+
	/RXVncrPfOBgPdKHcHg1A0AYbr94EdHXhauZQ77R8jphiXVSeSxB6WLj9ET5/pOTdcopgWs/YWl
	4gm93DOyFIsSAvaNUzBEABBGkyya+ftTbsIvgKf400DSoeiiCrWAfS/eHIruXt9Tc4R++CiTrYZ
	xHugeogg+7izh1g8VYoOx2F1WYKLbZNoQNN5OhNJJrjazH2PKOTKziRzNTbE7m7Mwniplvo+gpb
	yHZfRCHYW4VB9/X3xtlq61yE8yNuWO5WpdLz+KNVRMunJyGXixYoVdwNPmXFg/uqyxd0+GZ6fec
	tXqA+VRQnkHLYQg==
X-Received: by 2002:a05:7301:648a:b0:369:d793:328d with SMTP id 5a478bee46e88-36c9dd475camr1585502eec.31.1793731523122;
        Tue, 03 Nov 2026 10:45:23 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm102648eec.1.2026.11.03.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:45:22 -0800 (PST)
Date: Tue, 3 Nov 2026 10:45:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: joydev - avoid an undefined shift in the legacy
 0x read
Message-ID: <auorp8LgmW8Fr9tY@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:28PM +0800, Guanglei Zhu wrote:
> The legacy 0.x read path shifts the axis values by the calibration
> constants that JS_SET_CAL installs:
> 
> 	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
> 	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
> 
> JS_CORR is copied straight from userspace as three s32 values and
> never validated, so the shift count can be negative or wider than
> the type, which is undefined behavior: the shift compiles to
> whatever the architecture does with an out-of-range count, and the
> compiler is free to assume it cannot happen.
> 
> Clamp the shift count to the width of the shifted value.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Why do all these need to be in stable?

> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/joydev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 32459fd8a7c1..4740099599bf 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -353,8 +353,8 @@ static ssize_t joydev_0x_read(struct joydev_client *client,
>  	for (data.buttons = i = 0; i < 32 && i < joydev->nkey; i++)
>  		data.buttons |=
>  			test_bit(joydev->keypam[i], input->key) ? (1 << i) : 0;
> -	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
> -	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
> +	data.x = (joydev->abs[0] / 256 + 128) >> clamp(joydev->glue.JS_CORR.x, 0, 31);
> +	data.y = (joydev->abs[1] / 256 + 128) >> clamp(joydev->glue.JS_CORR.y, 0, 31);
>  
>  	/*
>  	 * Reset reader's event queue

Thanks.

-- 
Dmitry
