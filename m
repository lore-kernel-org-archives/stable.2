Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926B258EF9
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380120; cv=none; b=feLP90mPeHPdWB3/luHNPrRrvQ5+w3EyRzjYKyFBme+0b45XCKvqIgrlHn8mn5Z2+byd+WTxVYnq001Vrj/nYXdmwYnEjGu7O2u2jmvWo44mrb+6aPM65g5DweEt19f6+wGPZT/UCpzJ2XSVNqRw+WxFxGxm7dsfdfBEvKic4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380120; c=relaxed/simple;
	bh=BRxKL42iHRlwwz3T2ILra0oTwjSYINv5BFMH6meD/Ks=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mvY1uEMMli07pOHrhu+3KlSlBPV6ZTwvkD4KJMq1B7XvvEUNQeBInL1GkNkbJL7an3VUJ+Ia+C02v9BLM/kii+tMFPBGty2JV1trwjwu6zn+S/csQ6CFUtPfNIg6OfMTXYbAw6xtnnZl+4pMYZyk0mFx1/yF7EBMz/s0dDhlBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmrE2+I1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmrE2+I1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso12451985e9.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789380116; x=1789984916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKBsXKDFOhQRkCfFndxrrlYoWPTZMOH1+ZJPOFn32ME=;
        b=VmrE2+I1uERYvvo/1O5mGNoW8Y71mmf1Dn7Qx+vh9u4Z/VOgH5wnVnDFRfUoUd4bzq
         2/3Xl+TC2AhUAZlyl9iHQr4xgVXAquPvrevlwvAS4Utgxl/VQASwmVrdhpSlh+598Zdx
         0IAiS6CktL8wvT9vZjMv3y82YM0w2qKRKUKjdXHpQARUZPWV9mtLOy+80BTu6oDODj+P
         Bz5U8rMWRiJ7CXKCL0q05t99bpVIDWpFo9vv/Njo+HBC7dk19CTrQxucO4f+ChHqhfCr
         hkDVjR8lJrBBJfDf5dsSwPpq5MHSJiImHDh/D8P5nZhbbzmrAaj4b4Zc1yN5l4vWCK9F
         8Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380116; x=1789984916;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKBsXKDFOhQRkCfFndxrrlYoWPTZMOH1+ZJPOFn32ME=;
        b=tMMtc5ePL3GJNseubMNaInH9+DwfcuUyqWSoHl+v96fT7ze9tx3Z74rOhmYMS3a7an
         TLwUkwF7rN+Y0niFqr+Eph4kGR940dbUwjzGjy2sXm9HK3A5cwMO6VX1B6Rs5FFxE28Y
         K1x4pL7RgYR8050Duy0EImFUPXGZaqI0x62VXMSrvQNAfvQmDPF4s5nBodeE4BQHrJQS
         JqoLUHO3hOIMONWl/B9CfVCWnBLsjSk4UJIxcDWX6hKUnG9SSimqolJhKo0ecSL2juzs
         cSNwIyXhrIYs5aln42h76eqUtqaGQEdkVF39SjH+6TH0Gqz8NirJSMsgn32hTrZpADZI
         C3XA==
X-Forwarded-Encrypted: i=1; AKwUvByzuAEmRgH4diLdeaRkeggW5G2bj5LDSU+rPEHq+t1Ja2lP7sRUjBUl+K8POy94ijZrB5YLre4=@vger.kernel.org
X-Gm-Message-State: AFuF++nh05dp6I6Ssn4Hogetl4KgETrEUhQQSOl/vRfNclOFfMjAMxgK
	aC3o4SCi4mICVnI+fmKbkVD+AeB6po1prVVOd1DHVAnKktwDjabA81Kg/un/v4k5MWU=
X-Gm-Gg: AYBFou35oQDrIoo6hEiHgWqwh9qnPFiS62uE7hfzoBRmYAXzL/wTSq22jSTxv/DmlcL
	ka46Wv5zt2OMBFGdIohQCzPbR8Uk8LkyMXsPy581iKbO+9FUdnkDRP/ftZSCliRXmday6Vugtyy
	3pfp53SDLDrl+wGsCjd0AIht/i4dTAaBwDTGXv2LIcyllOPcj/xTqKSCGq0tngAhp138dJnAbsy
	hybRa5WNy1usPJ3rg/86mBEjK5aERBlilodG4MA3S+I10i4TH0bJDtNcfofAu4oC0UOyx2lsd2r
	TyJ1iM37GMzmmfTTDj9FtkWQXz5AMZ0gDSnluuYTHhAT418Mti75sOQ3IpG/aAQwk++gaZi63EB
	bxcHzw7gZMqwd+pQ93gfjD9uUy/7nkHzuHpU8fWtDiqDzxww4zl8iNOc1th5vQEIUC4WoU/qn98
	yonizpgxPaFqhTfNndR+vObzH4XIG8aPfSsj7rP58JivIEZdThiBo0JrcpgQj2Y/4N0S2jyRlna
	vz/L4ZJYAsCMT54T6CFjluiGR+tVh17V46vW04rx8nOnRlBh4bM
X-Received: by 2002:a05:600c:1c1b:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-49e7a692563mr24010095e9.26.1789380116235;
        Mon, 14 Sep 2026 03:01:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6e39:32ce:833b:47a? ([2a01:e0a:106d:1080:6e39:32ce:833b:47a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71e300f3sm209445435e9.7.2026.09.14.03.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 03:01:55 -0700 (PDT)
Message-ID: <f485c3d8-9551-49c7-88af-1c4389d4d66b@linaro.org>
Date: Mon, 14 Sep 2026 12:01:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable
 delay
To: Fabio Estevam <festevam@gmail.com>
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org,
 Fabio Estevam <festevam@nabladev.com>, stable@vger.kernel.org
References: <20260909201346.937343-1-festevam@gmail.com>
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
In-Reply-To: <20260909201346.937343-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 22:13, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
> between display signal output and backlight power-on.
> 
> Without this delay, the backlight can expose unsettled panel contents
> during display startup, resulting in a brief bright flash.
> 
> Set the panel enable delay to the datasheet-specified minimum.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1b2a9ec82099 ("drm/panel: simple: Add Raystar RFF500F-AWH-DNN panel entry")
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c95964ba25a9..70e37ff12c9e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4354,6 +4354,9 @@ static const struct panel_desc raystar_rff500f_awh_dnn = {
>   		.width = 108,
>   		.height = 65,
>   	},
> +	.delay = {
> +		.enable = 250,
> +	},
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
