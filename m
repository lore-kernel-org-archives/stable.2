Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B01538D79
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869477; cv=none; b=M0zJCqA/WWubSUS+1l0Cy4UO9BbEOX7ewsQBOMcN5o2uJBLdrxFZ3kZMBTngCzNG9TZ1Fh9kMIoqIiWx9nxBFNVFRNU30ZRMZYxHNxkC+mL4NzmHgRGCCYZoz5VIXes7L57kEHNSRWY9cNtpL2fy6rQusnzMtsaujfOB2WJrkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869477; c=relaxed/simple;
	bh=3hq1hCpYfFruAk9NwdwkNOcTA0yG+rhjKun45Ep62e4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WwxU0iJRaUC8InxYHRRMW+kgfyVGo+cJ0O0Pf0f+M9JbJjgJ0TSH+Nc/F5Zp5hlFeire+AYZJHm0Ca0jqq12ItTX0Aaa3dupCpgXSLAp2IyVQvMKdUNgdW3FJOW9g2ZtCI/2scWJM9WOU7qb9YLFRPl8K4nIT4+BQcMdVzSQTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugunq0fR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugunq0fR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so36350905e9.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788869464; x=1789474264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DbFI851Wc6QNNKR3nQbUG1a0fTB8uT4edMUZygEozxY=;
        b=ugunq0fRufaLNO+bUusVzPYDVeZylkTeB3/IIDWgzoqRCNr0ewzcPZYSFU8HgmRRbF
         KWAC/WGQlXplUoFUQc0/OjYkyaTq355D1DPdwklrWq6WLGBPFuY0Mj2Lj6BjOdPnpzMs
         jcWR+XQRKI7HfUtyN5APa089jQ/1C0lqOo7CsXStiJ5iv7achFkXJ3N3iplYezrlCuhl
         DhLHsPG01pocwGAiotSg+F5yUqN6MJ0cKq3D92d1NPm+cE0+kqkMIb2+CMXAY/oD2auI
         QO4P8mkEmy7pPjN/jo/IPVX9/LTIvxAItpf9fGAlR4dBZdjosYv/chTvfEk9reYtESMW
         FpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788869464; x=1789474264;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DbFI851Wc6QNNKR3nQbUG1a0fTB8uT4edMUZygEozxY=;
        b=POyL5/W4i+hw8aDTBKFywAKxvot2r4hZTJYLzUesTfHuZ9e6xEdkO6tXZFJ+phIY/P
         brNsDdTKcfEQ7SRDPuOLL/POSi3+XTJ0Lyw97BthyrGrgIUkEzORfXH5SysZy37IYuri
         LvPoavHWsuzhQN0N2M3XtSYeukLNyD983DQf5TsyktI/Gfy4Lu5FTsMOWc8MqxKFCxZs
         PuMC+nYJkoMYq9ZilfzbdAdL3CRII3PBgPB5XMLh0Rfxwc72DUKaok8WvfZotP3GvI0/
         PWoQLnuIKGh29cXqR6u0pw5s3JnqZtr7Rbj8X8J64kqiAQm31On/k0mYsXq8jhtINaUi
         ymgg==
X-Forwarded-Encrypted: i=1; AKwUvBzwvlwvqedhrs8Q9HwIeAIOPYxhyeB2/+XoPcpcFOWiKP5yJ+VuMS/7EZ4+cAySZI5v1CyPo9w=@vger.kernel.org
X-Gm-Message-State: AFuF++kIOlzu+MzjKq/qE0VtIjomz0z5B4B6Wjku9Ldq04bQkFIVbcpo
	SV7yPYsXpoQwHvbf9RN2rgcvOVkdm/vlGZ4Rwj9G9TxPjUcI5MhIpWIRxx1/k3erhXA=
X-Gm-Gg: AYBFou0zmn9uD1ZmZVUhsG7PzdMwt9AK/GzZGeHIT7CIn/KdjPdApzDI+Q86BcxCo0z
	VyfXSKXJrP7VIcv+BzygFBqYvdvpI7q692X5MQcSGrNJpsUojd3Mt2+0WfCefmlUg1sugjKYNin
	2UIGYH7mhV9YBp6Q6IswUs8+Lg9NKY/b4BsYI/8UJHvIthcHvqiMnoL3boSK0NK52knyNe6pswd
	C8sfItyPm36DWd2DlCaAI5JC4BDUwukxXNgNRa2KWj0Zw9ZZC9nbY3NMPoS5DZtvy+oT1MF11yQ
	eATSMbjZii2WRh3pwFcnJSuY0Jrew2zGlefQ6c9O07xGZi3LeLUwyWe3hoeLz20sJWPfas1nctC
	xe/oVyQXJ67VHx+WN02uwi64ElTRLZYUbvwGfz3BwGnVGuBC3z1EhTXMRN9wSwvij7zUgq9ooMc
	G8b/O6jw5LUydZjYkH3ukuztMd1QqzLVD+YbizZZwlq6gcjHrRZygsn/O9Sc+l/Js8KCch7tdZb
	cPo8+RemD6XTgBnfGZ7IWLF62ISP7jNjT02VMyIeTjQ
X-Received: by 2002:a05:600c:46d5:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49cfc6cc142mr239764675e9.29.1788869464167;
        Tue, 08 Sep 2026 05:11:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ea45:883b:8b89:b4e5? ([2a01:e0a:106d:1080:ea45:883b:8b89:b4e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm553052685e9.13.2026.09.08.05.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 05:11:03 -0700 (PDT)
Message-ID: <4688bc5c-edc0-4f1c-8534-286364f03c78@linaro.org>
Date: Tue, 8 Sep 2026 14:11:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
To: david@ixit.cz, Joel Selvaraj <jo@jsfamily.in>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>,
 stable@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
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
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/26 15:19, David Heidelberg via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> This corrects the host initialisation sequence so that we can send
> DSI/DCS commands in prepare().
> 
> Cc: stable@vger.kernel.org
> Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index fb9f9f42be4f2..1ab09c50a6306 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -193,16 +193,18 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
>   	ctx->dsi = dsi;
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   
>   	dsi->lanes = 4;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
>   
> +	ctx->panel.prepare_prev_first = true;
> +
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   
>   	drm_panel_add(&ctx->panel);
>   
>   	ret = mipi_dsi_attach(dsi);
>   	if (ret < 0) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
