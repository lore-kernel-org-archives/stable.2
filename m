Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6712F260C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090004; cv=none; b=lpZF850qAFcPtzU3DPvy9AQmLvd59A1bpXKgwIUBpPCOlTgEgtH6LZwZXg9xxUy8pEviBgVwHXenwCAjpQkKCA35xZ0zeB+lo+iigRv0lAfEK4QX64tLwvQP/DqPv8JX1u2CBEpQpDWCHENSPNhREQmqSLxDCi20SA/DpA7EAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090004; c=relaxed/simple;
	bh=V+7rsFQPKnOBAlz/LmYg2ZdalQA3vgQb/HuQrB2V3dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ASxvt1Ai9ym5N+hq9qoJprl6bbuU0NN1wwxGvV1XYfPTHiTYpL7yEPXoh1zQQTlAsWwIhj6Tz4Oer0T91GTSWkWGTbOb5jZmxlfjuHxVpmWO+K2+Z21pbYbit3pr0x8lwTHAp5oKQO3Ag+cMr/DU8UXPqo5SH/+ynWo33AvfUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ccDAFl+W; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ccDAFl+W"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1da63791so5402197a12.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790090000; x=1790694800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GaZEEmN9wNq82T/9Yu9vmbJ6QJ0MSvGHJAIrLmYMR8=;
        b=ccDAFl+WGZzjKVGFWYJdS8g/1qurWy5XMEGe54eSNxr3yJn8jUY1aTE7kkCP9oKWOI
         Q5aaqnl0TiDrZz5hT4Tt55RunzQxDZnUAHbgmHvpL5ZUy7O9jvBVX6lXZjXtbQhyfl++
         wNnrBeVSy2inQsONMB49cg2bOWFcD+SWCyj5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090000; x=1790694800;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GaZEEmN9wNq82T/9Yu9vmbJ6QJ0MSvGHJAIrLmYMR8=;
        b=uWCiIOJCOMXzS5OwgbA+cGW23wSv9CGhY06zzViovMaW1bTVh3u5V7dMuwZHtkCGEz
         aT/x15FRTBX18SgFPbUI8Z8N/TdHh3oE9QSugddGlS2vFThz0ymd0ahYBBdiPcVnsvyW
         erkEfHda2yuHBw2E2MDf5Yo23cpgcJen/v6S0+WylUI6E4LzgX8LvhCBu/cNLw4Dg/os
         od8t0564eRf54wfsyy+X6OnZRTuJ9EX7z4LFBiuDKY55ioi5saebVOnmnnDLy/vIw87Y
         uQO1mKVYxT5EWDeQE7MQj4s+gPLa+w0r+KPp5fdQz5aN64KALex55VxBP8e5Uryxyj1v
         LaNA==
X-Forwarded-Encrypted: i=1; AKwUvBwMbyptuW7K5XxxFqFX3HSF74IvPQyU575+gChsoIWp48/NpuQ8DjclYBq6MJBgKJA/RBOUhJI=@vger.kernel.org
X-Gm-Message-State: AFuF++nj0VKT593Xg9nc3VdSSkvRPudjEkP/ipkq7+tqg859dROdewLx
	tF7KZ5mMAeweJhTx0XLZYsD6Ifp4t7zZu5BWyXSZNdrWzdh6cj8yTbx+zMNYsOOj8M0=
X-Gm-Gg: AYBFou0YEL/bX0/323RY06iYEN59WSUS8I1EIUQg0z6Pb4IkXke4IpiT/IsjhGU/YHv
	0XJBC0tM304xXdvw5T+8AoOr6+aac/RSQ+9SyhrcZjYWoZIq3ltUID8CUIX2ec0uFGogmRMXfZz
	hdmBTAPJPKQsF3Dxrxzwm/qKiM1VKjrdIHzUuNACMn7vsWhvbu3IwCLlS8exeA/gsOBgZkKYiLU
	fy5SY/Fegu5QOVWh+6toU6BoNh6mwo/xwxkQBuubpMqK+ZbJSOKJjH5sKrUOcGQffUytGkLlw92
	vNoPPYhaB7U6NN9ZgoganMXMOO0xWL7vlYGszhhoSL8XllkrYyMxpgA1bTe+XatKK1RpfjVDC8W
	DRteU01wLQEWN8fdVdqGZjMenQZYrPLenZAhnym+bhqPkS76SytR5Na1ldG/gCfIDyS3io+za9Y
	hzGZIt3M7TO9jano/0KzK/onQSdJ32rWBikvhJwlQteuny4GJyz6Jw0ZfuFtWvlqu2X+nSFA==
X-Received: by 2002:a05:6402:3209:b0:6a7:ee54:f89e with SMTP id 4fb4d7f45d1cf-6aa531b8f50mr11963548a12.34.1790089999809;
        Tue, 22 Sep 2026 08:13:19 -0700 (PDT)
Received: from [10.214.128.75] ([38.97.137.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44f9a77sm1278240a12.17.2026.09.22.08.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:13:19 -0700 (PDT)
Message-ID: <bc0459ae-390f-4d48-b517-53388b0c5452@linuxfoundation.org>
Date: Tue, 22 Sep 2026 09:13:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: tools: fix wrong variable and double le16toh in
 list_gadget_devices
To: longlong yan <yanlonglong@kylinos.cn>, linux-usb@vger.kernel.org,
 valentina.manea.m@gmail.com, shuah@kernel.org, stable@vger.kernel.org,
 i@zenithal.me
References: <20260818020140.1863-1-yanlonglong@kylinos.cn>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260818020140.1863-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 20:01, longlong yan wrote:
> In list_gadget_devices(), the sprintf() call for idProduct_buf incorrectly
> uses idVendor instead of idProduct due to a copy-paste mistake. This causes
> the displayed product ID of vudc gadget devices to always show the vendor
> ID instead.
> 
> Additionally, usbip_names_get_product() is called with le16toh() on
> idVendor and idProduct values that were already converted from
> little-endian to host byte order on the preceding lines. This double
> conversion produces incorrect vendor/product IDs on big-endian
> architectures, leading to wrong product name lookups.

Why isn't this a problem on little-indian? Shouldn't this double
conversion cause problem on both little and big endian systems?

> 
> Fixes: e0546fd8b748 ("usbip: tools: Start using VUDC backend in usbip tools")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>   tools/usb/usbip/src/usbip_list.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
> index 3d810bcca02f..85e6a8a1fc36 100644
> --- a/tools/usb/usbip/src/usbip_list.c
> +++ b/tools/usb/usbip/src/usbip_list.c
> @@ -298,13 +298,12 @@ static int list_gadget_devices(bool parsable)
>   		idVendor = le16toh(d_desc->idVendor);
>   		sprintf(idVendor_buf, "0x%4x", idVendor);
>   		idProduct = le16toh(d_desc->idProduct);
> -		sprintf(idProduct_buf, "0x%4x", idVendor);
> +		sprintf(idProduct_buf, "0x%4x", idProduct);

This is a good find. How did you find it and can you send me usbip list output
before and after this change on little and big endian systems? Are these systems
running linux?


>   		busid = udev_device_get_sysname(dev);
>   
>   		/* Get product name. */
>   		usbip_names_get_product(product_name, sizeof(product_name),
> -					le16toh(idVendor),
> -					le16toh(idProduct));
> +					idVendor, idProduct);
>   
>   		/* Print information. */
>   		print_device(busid, idVendor_buf, idProduct_buf, parsable);

thanks,
-- Shuah
