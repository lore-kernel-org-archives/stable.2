Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14547A0B8
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257021; cv=none; b=RqOuc9gex/sog/CYn6686UrpfLqrOF8gfApwN7NtdNZ7X4EX2yOjW5EBqGSdnLnz2pJRnSz92ojiHIH2c5LKHsxSTdm/hoac39jm8L5RnTqtqu2v/i/ApyDhaaIulPEzHKvacV2UjdWCt9f+Gvs3Cbgq2/mnooIfBIEfRRMxQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257021; c=relaxed/simple;
	bh=h/S/qyS5zfANXYCprjt2K0FZNKdUhZgNY83n2Q03IQ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l61R7LhGiHoi0DVEAFf366BTbQCWEXYYolKvwZpyP9xWms8CNJ5QBWfftekdS55WcCxWKR79Gn4VgMxpdScoApnObw3s9SOnZiWpj61Zb211nRRHk8kxPJ/XAsBK5fsVj758f4aTSr28jS6wnMciABUdpnlInUOBeBgmj6knAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xvYKnTIr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvYKnTIr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso15261775e9.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790257005; x=1790861805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXlP/969CHxJtU22HfzbT0qcpswupuWX/2g/r8D5tLk=;
        b=xvYKnTIrXk4m4Zxs2WTzzVBqPPrVR8hIdPqsqf+NQTZsgsyyHQi7lR03BbdJUqGSZO
         UUvpX/9QApG29vK0uljTDyEqAwA4Ya8MpJKwevNzhGhPdHRe/aEQ2n8eEXbjFkHeli/s
         25OQWDKuadH87nahDpipiIpgD+tZAfN2lqd0r7AP5wpuL4FDkK2WJEjF0H1hc2OA5cFS
         6QsQ36AZQCHoAtXRrQUgGzA3wajXvm04O6fsBOZwWWquY/CJlv5I/1zeFUYGuWlbLp0n
         Oh8wsySoWEfu8IoMZCUrjx7w4lAK9Vm4M9YecxPrhYi3wpx/ddUvfMHbKkcWMT9y2jPR
         3nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257005; x=1790861805;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xXlP/969CHxJtU22HfzbT0qcpswupuWX/2g/r8D5tLk=;
        b=mGT7sZ0Nmd38MO/6IikePKON+2qGkt0221Ngc+R+mhZVlO0ulCGxljG8WHy2tXJz3t
         BKg2RdGqlncCskFm6bNvngrVjbSgZQiy0SMtCg+cUUuyB3EY6XqUdtKFJ4dtoCEO6I7V
         iESFkM6Xob0VqH3emB8R5LWgz+Nq0fZHr8Wh0jEBfvfmveK9Cb/YZ0lnXPWNG5RAZAEq
         PySwXZHy87391U8bmvpk/S2txGKZ8hE2TbbuvVTd2ZrFne/2OGUjwp1QDOhSPEa9eY7z
         MZkfvUzsspkARavn7nSPJk1rJkb799u6jyZDoPIfed2uy3mHcKiMA2Bc8UV8Lvas9Mji
         yNvA==
X-Forwarded-Encrypted: i=1; AKwUvBw39WZUxN9wF8KoqbZ+tmAOMFvDtOfA5pqtYjnPsz3gFr+Qv9MAmxjwj5IfqBfFD3B49KCPnH8=@vger.kernel.org
X-Gm-Message-State: AFuF++k4GDhnOFUbCxD6G4XRISeneHEERRmsQlgOcLheBlIIzwcyntVb
	beU8Mv0XnOup7Z79aPPjTtaT0HJhzMDDLAkngw+DpbwQ/87AZpTTvRXaIlozee4Br34=
X-Gm-Gg: AYBFou3b05VBQ66HwUPfWWH6BAixE7M71NFdVf+SOfFjWeq9i1E3t5Mv8jraqIyzd7r
	SdyzZnfa1d4YgirhOBGxa893/DBdgc09dCAyeVvnv8UyS/Y8zeTvKCUcKgY+aFSPsSl4g4ZQPXf
	wqtbUb7BmdQp2gRF8H5jC5GUcJSSRBKHqXdZuvHA5GjYPPYxbDk0HSv8iyZP/KFNmgChuwe7xeU
	vBhWuNh818u8TIJYhPMm+bhXb9I0q5c+vwe2QLIErHIkhMXoaOGnSKNMmXdvMOQwQH6K+X8XpU/
	c3Mr+80pOK6tGgUBTkBjIs8mE9d1Af9PRsGn/XJ8IIeRKybJWGVPTe0Ubhrj8YR62SAMmn8k4Ih
	myzUX6MqceruFcHla6rbVqpgi2I3li2GVIsr4w8zC8uGNv0qgXDcbdW1OCqZesHzMVFbFrLpvK3
	2tybxSo8TC1B68bxzKH/ktQFq17t3HGXf+8xp/qG/t71XJh1LqmkpHonl14D1DD4DHx0Khm69Mn
	Vtdcoj95MPAyodoJq9OK5URZRm+g3VFjjQ5NsuyFJEHaWI64cPUdG4=
X-Received: by 2002:a05:600c:468c:b0:49f:bd3c:bc19 with SMTP id 5b1f17b1804b1-49fe66f4cabmr40024985e9.20.1790257005322;
        Thu, 24 Sep 2026 06:36:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a? ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889130sm14521695f8f.37.2026.09.24.06.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:36:44 -0700 (PDT)
Message-ID: <8f18e32d-07a7-46d9-9e6b-55c8fd25ede6@linaro.org>
Date: Thu, 24 Sep 2026 15:36:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: Fix node reference leak in
 rpi_touchscreen_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: architt@codeaurora.org, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, eric@anholt.net,
 florian.fainelli@broadcom.com, jesszhan0024@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, treding@nvidia.com,
 tzimmermann@suse.de, stable@vger.kernel.org
References: <20260916180549.2090497-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20260916180549.2090497-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 20:05, Wentao Liang wrote:
> of_graph_get_remote_port() returns a reference to the remote port
> node.  On the success path that reference is passed to the registered
> DSI device and released with it, but if mipi_dsi_device_register_full()
> fails the reference is never dropped.  Release it on the error path.
> 
> Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index dc4bb8ad9131..c14776561623 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -428,6 +428,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c)
>   	if (IS_ERR(ts->dsi)) {
>   		dev_err(dev, "DSI device registration failed: %ld\n",
>   			PTR_ERR(ts->dsi));
> +		of_node_put(info.node);
>   		return PTR_ERR(ts->dsi);
>   	}
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
