Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732066;
	b=Xpb7HrA7ihnmYQefVty1IQ1hfLwEv28upju72oShVdFy2SyhTYsKl4fu+1kIGSJnZ/9Z
	 hzPfrnq6lEQkV3gAodUHcsS6qzMDuzwYx6kUb2Ts12kT/ZLpjP7EIwK8Zo8HUk4+7Iu1u
	 OQfuC3/XDhzQSaDaQ4MWNwWfV+ICuAa0nJ64BdoZ8wAenppr3cask9B8sUEd3pElcRdET
	 gz+hCpoGZtcUsDcShRUUcTZAwx8ufPcMx3zQlaPdWjg84yJqfFA9gOHF1Jaut1HxGnNax
	 i9hubhDL/IjdIvTFWEm4R1GpVs+cquyctwK8mNEJeAlKrwncbGlF2DYqewAY1cl2t2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
	b=rzWXy9khuCSq3a0ngOfOovWS98NHaL6v/+EiYnVjdRDg3o2Bme872w80Uay1Y6lLvuvc
	 PjeikA976ELerRE9sQKI90xOfdqwuQZbQ1frsQXOs2bQQSgLR4Avbh1UvFl6vk+hKEVs3
	 mJrodBhC8sJH0XGUXkg7s3ScvDfrmgIHultsbrVpTsgsNihmyguOAb8e3v9n6UVXrtlAm
	 lCKTajuyW95F4JAUl+3NXbWxLRI49HzrPRDa9Hm+b5SpbSfEXAkUSx0Q2M03gtLMxI8pN
	 eZ1XOJ+K4jjQaYBhtmMql+vE8ZWbT15va1kCiMJYm/2EZ8N7EaI2M7hH4MmbNm8O09g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgITnaNd;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D4606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175D4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgITnaNd
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so6221435eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732065; x=1794336865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
        b=LgITnaNdSvowF6Qh9MK3lhkdJPA8Hol85Npafv8fz6TgPGGRUf3tlmYysTR89Xtxp6
         VSnrZDzLthYWxaLR1kgxM9Jur6pTJsckxVY4tK/XJBjEyJ3M3Gxoj5yFyUjxjbrUIBHY
         MyUU9yqaJ9iRsVwaDEW1Gzu20I3B4dufRV/InC434N05ZrwIQF4DjjkL1uVzCrFLcHMP
         P1D5zUfo9KF7DdPoBkMh6cFnxX/BGNublaSDhMQ8yWb3fqRzQ988S1tPrmLmpUzioddU
         JBuxKh78qeEIG78xc6hHQmruArbOJM7KN2Edhs7yjt0E8wSiKbFRBA+mFX35jq8145R/
         P2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732065; x=1794336865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSLS6P8awR8sg8YK6TCBsmvvbL4PGOeF41QBtG7ggjM=;
        b=JUK6wg75PHiCgGRfEU9ZksDkkGkPRnPQBwZUr1Q+OC+7UHA6MZvlHMqEwZC6MISzpq
         6/Jo4S/n6I18ABj26z0dNAmPmbyXe2cdJgD03cqQCCW0Mr0DBc0x4Q3yz0zMiLdeZLbU
         7ETj8mIZlYWQH33wvk0rEm6nKKd+sRH66Po8jhHlJXjmMv/vnR9t2Fg5XGipusapmtYe
         zE4Zlc/BI+rr1ALuM+Ei9MpFwce1b0pmR626cF9J4sNEkDdpUiShr1GVN5RJBGAxKLIj
         RcnKiW8d+zdNJlTCk30JNILlVIuDV/aCLZKw8XHjIxQsW2ESb5GfYyQsm1a3hHyBk1oP
         iNHA==
X-Forwarded-Encrypted: i=1; AKwUvBzJWjLXfqsAJmPzWJBVDydnYaFB8Sc2nUyI7lyGak2Vn+FzzsEVAc+ZvQ5PZJML5f+/tsGyE8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e1lCBnShCicn/aiyVeo2KCh0J7+MNhO3AMqnBQjlQZJm0+AS0
	sbyFK1Qob1B5ekGJOrPh936grkVu4mELzPH7JXL4z88lNs9821ka53DO
X-Gm-Gg: AYBFou1nWSH3y78upT7aP4jj9bPpYctFhY5HcLJaM7jyQiJYj39CIZdqNnqOFGj0FPw
	N9W9hbTRjIVUbXHLLcu0faRU9kIiSSYmSKI73ESK9cpV3uB3d3pEvTI1wiNp9/8IBbiRYI4uq2j
	0AVxONgmvoeB8azX7mRYaZJV1ff+8k40x48jH2dPYDaWQy3aZqGi3xvxcFXrWepDRA8KAQZ9zeB
	5Ah/rW7sru9JJINV9kK3A8r6HL5j2eroRPyWvEvg2kTfD7i2fVn6opfzYsz5T1gG31pP84xPCcN
	tz5WxX+ViCfF8x758nnRJZI1fB6iSYWuYrKAXCwhmr6PWLbMCYuIZKiWxGFEoNQ9psRqaqOTeQ1
	sG9ovC2b9WxZGDzXubhKqSr/OEoez9FYwcJzZcV3/pBWyL0LnI++MRQAPc5Oi5OKhkyEQPtxzvK
	LwJENt7EsUU5IJl03PY0RpDPemLrKvAkq4BUcI8ZCwBtaI/QZWX7ZjgX7nrnmhC5skk21NdNk5A
	dSi+obwijr4phT3JVlQ8erQOx9WFeen4Utn0YdoXYr4mr3bGehyAc98SzGoYYUQRo8QInnJvDm7
	IVpNE2nX+xVmbM6ApZuENaumPs/I+KiJsBR7KWdoetXt95grJR+/QYxD2VbmzQMjSi3b
X-Received: by 2002:a05:7301:3ab0:b0:369:535f:4d12 with SMTP id 5a478bee46e88-36a4221aa1dmr21444083eec.3.1793732064912;
        Tue, 03 Nov 2026 10:54:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm82913eec.9.2026.11.03.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:54:24 -0800 (PST)
Date: Tue, 3 Nov 2026 10:54:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <auos7TgVNv7EWnbj@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-5-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-5-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:32PM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/keyboard/lpc32xx-keys.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
> index 285d5c32fe70..1d0b082e7881 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -142,6 +142,11 @@ static int lpc32xx_parse_dt(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	if (rows > 8) {

This should be a constant/#define.

> +		dev_err(dev, "rows and columns must be at most 8!\n");
> +		return -EINVAL;
> +	}
> +
>  	kscandat->matrix_sz = rows;
>  	kscandat->row_shift = get_count_order(columns);

Thanks.

-- 
Dmitry
