Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBF1A9F97
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227451; cv=none; b=L5CdNDMeIBhGX0+aOVFAhPyzh4qObZIjKSqWcGyBP2wp+Ou45+A++5LeAp30AN/5/UvY3cGaRY6DrYVqBuLAlNVque8uhaRMvlq0amaVr2hxMTupMIK70wpb/BLOH5N5moxKYjjNPgS01I6ZP3ast/vTLmEKBkUjhjg8A9XKUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227451; c=relaxed/simple;
	bh=zD+Tt+tlF3sKHvM99SHQfbP3s8lZ/MekZMRh/GzEnb4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJ0ljG5zGomEn4/Jp2hJwJLk2ES6yirc+W4EEmCXyJACtHPxvkn6b+Ki9aYAgIiReJsG1ny2Y7X5WygvErKE7mNnWb3OXYVMXMzr5q+EHWluW++LPkuWSVpCD0ViKXWoFEzWjl/pPGWwdqVuPTbpGPHwQ/Xsp55k3yDLnGDt1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEKOxF6h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEKOxF6h"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49553515a8bso43471015e9.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785227448; x=1785832248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXOP4XN0PqhQT+v4jXW4sP+aBgVsrUPoLsPqH/lHN1Y=;
        b=XEKOxF6hNf8sV3h2KDrCsCQAogkpdgAKT+2voA1nmy8RNvwVfQZU0SJyeXRyj5BqbZ
         yLjEgkqyOWHX2/lQI4qFNNA4f0tOhay9PeLwuu5Mx87f2G7SHScaQjkt/DB9CiYJqR+t
         aFfJKM7V2iRuZwMI2xE9WpEfnqvqj9X4q8DUhZkln5DO3v+5ZMYspIRFcMiLf4xm3ssq
         jFblB46UXiYac8DgWiOx2M1FOG2+Oc50J25r0JdBcCcRiJ1VArTzWs7JzP6aerjguo9B
         ke0fMj1R7m1abtG7MWDPPbyHt58uIIZiayfBADoatQcKv58qcJoTyYMCIbM7mNkf2BMx
         44oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785227448; x=1785832248;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXOP4XN0PqhQT+v4jXW4sP+aBgVsrUPoLsPqH/lHN1Y=;
        b=YFKHjKcFBc8V6pihFra/y6vgmMd3RYiSbcXKoiusO1QXbyLedumJ8W0MygCFrepfTb
         glxWr+rOhSAu6WqEig7OLa44/qTx1I/MrzKav4RDP266r9He/uSIuTAb+uTb6FzdHK8v
         ST2ahRK4wDuhtCKK9s23miPnF7QcvRLhaOvKWNE5KaqyWMsbg+Wja9ShfsrWBqQs4V2d
         G/PvB7UmkLUmo0THxuTOY1/dsDLDtZaXugUZyRXzcUqvdDTgUaJR+WBVVvIFehFb/okF
         ruhdjoZkpkEwfsfsn4FBjlZODgheascPDsqmlqt/Yp454nE+Z0t+wpqgeR+5R5k6K8ws
         WHsQ==
X-Gm-Message-State: AOJu0YztBwvvS/s8+c4A2NInTdPbry0FncrrxCCyeBqplaTnVyIg5Ds9
	+d/SO+w5CfSM9HgYAS9QyzJ/z+9dw2XYYHUUlDgKJiZKU/c9bv6fwm6QOYPeMSw8LUM=
X-Gm-Gg: AR+sD10kGQsIVXmyaVheC3i6VsN1XO+IB6/flkh1DDVbidhMUATe888U373jE9zAsE7
	1ODKbR/J3PeN/1fJKg/LEspQODzcub1TESOnDddR6l+sUnCjbcmdsDUTbMIvZ185ujoonWk07m+
	KzVJNjBTQvFJiq0px64DBikKaWx+bFy0xSCN6MYp4tkJ71PTdJuYN1IIaTnTYU8nn+O0jZXFn8S
	61c4CgWm98UrsYkbVnYayMnMctunfGCizR62Gf/n4Km1BvEnZriw+8VDq3CwwazVpRetfM6nbYr
	L5Js/ixExSbt1t2r1nlxKXFRQRASpvf95j+BQ0tBjZ8lt6ypU4az7Rd2wHv+0lQl0vXhwsHCSuQ
	sCI8wbpfayunovRcy5MrWiwlyKeDuy8hR54yT7fCaEqrhhqSVBXjyeGPq/rdDBGonbddzrWHWgP
	8OEyEGSFmwt8Qj61mebU7LhgUmnQtjW3MoN1Xgs+MQbjqS012LN2XKGGw6ow==
X-Received: by 2002:a05:600c:3b13:b0:495:3c6d:f294 with SMTP id 5b1f17b1804b1-496c6571db3mr16805925e9.23.1785227448036;
        Tue, 28 Jul 2026 01:30:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5788:c4e1:cf35:7211? ([2a01:e0a:106d:1080:5788:c4e1:cf35:7211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44afaecsm68281745e9.2.2026.07.28.01.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:30:47 -0700 (PDT)
Message-ID: <e73bf1bc-aab5-4786-b97b-803c3e118a46@linaro.org>
Date: Tue, 28 Jul 2026 10:30:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 08/15] media: meson-ir-tx: Ensure rc_free_device() is
 called on unbind
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <4674de80dfb7ab8c4a66282be26260ce4e7c9055.1785158244.git.sean@mess.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <4674de80dfb7ab8c4a66282be26260ce4e7c9055.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/26 15:18, Sean Young wrote:
> Make rc_dev devm managed.
> 
> Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
> Signed-off-by: Sean Young <sean@mess.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/media/rc/meson-ir-tx.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
> index e7bb107e6a84..abb107d19e8c 100644
> --- a/drivers/media/rc/meson-ir-tx.c
> +++ b/drivers/media/rc/meson-ir-tx.c
> @@ -345,7 +345,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "irq request failed\n");
>   
> -	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
> +	rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW_TX);
>   	if (!rc)
>   		return -ENOMEM;
>   
> @@ -358,10 +358,8 @@ static int meson_irtx_probe(struct platform_device *pdev)
>   	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
>   
>   	ret = devm_rc_register_device(dev, rc);
> -	if (ret < 0) {
> -		rc_free_device(rc);
> +	if (ret < 0)
>   		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
> -	}
>   
>   	return 0;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
