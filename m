Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AE48EC9D
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257083; cv=none; b=JUq9HQ8wu/ZF40Qvb36SxydUz3zed297uAOb/tWB7YHcamZmI6G5rgYemNBSp0BDhzkpEoDiQhm+bmv2bhU1nrbINjLfXawYqsD5eaNy2o1IrOOzk/bW31V/8YM6TYVMphqSIHbTiRNzBq3x9/5hXu26+fKagOiz/X0xlkxrU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257083; c=relaxed/simple;
	bh=uBVumAGvxpFaaov/Th+EWyfqXFiE07geQnHeIk6jyio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jZcVH95H/M2jkT8vP1Dm9HZNF7xxZkgoxwurrpkospJu8CcA4QWY5N2Puao8DljOh/sthKPlvvu6yL+r1BCvjrigRJELSG2oolSWUADyhO7NCBT6YHsEKgG6IkykJ1TOAEcYpb0o2/lsv7ZU1xHtcXL7amMwHdDMRiw0NcO06Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXvoQCtz; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXvoQCtz"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887635e952so163154f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790257071; x=1790861871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czECHI0/k3wkyu2UFpcXryFcDXjrvdMhsjt10rPpJ7M=;
        b=DXvoQCtzjEPswEYmU2NQORfOF5rIYZyiv81s+4AMYRsUm9jb96vTqvTomEIWl80seW
         bjBbc+CXuNJ1QwgERGm2bWWbSMf6/vA5CewJKoPH1r/Q7K9Gd6Osae/GW2WJ6jayr1Td
         HkC9jrPePQQRkGSD2zm/R+Czu70/BBG93vsbGvqQ36fv8OvF/p6wgJJZigt2KzSXlOTh
         h8MYAYvhPg30Zw6z2Yw44QYuOsgnE47Qvo11Lvbah3+e5q8iMOODQxK3+jDtIDUGGLKp
         02bFrrG6oRBGvKBLBk/E4YYoJki0r+fEprC+59H9MxfWbgMWblZo3/oD8K9tn/FiHiPb
         b0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257071; x=1790861871;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=czECHI0/k3wkyu2UFpcXryFcDXjrvdMhsjt10rPpJ7M=;
        b=j0KvN9kKjibXwbc2GpPYa64LD+jAy4jWsuWQXYw7G0nJULy3CxucRiP9KfYS9ZITlG
         R/Mc4TRWo4cBvvlkjrrB3pBbiHoK9RbVIWZSqT8WhNwmanbg7FY0Aq66wSUXea4wR90Z
         15kQ9r/08mctqdvf1Znkk3n/2gPRITKS66p/ENV8jMK9KBjjQvKscaHEmtux61NhmZhH
         VHMR4REPBNm1P4ENTzJMmpV80ZTZ6gH9bFYiTXQYsVZsxqZSMa3HMf5Luxe4zq+EcC4v
         22TjMYLhSYDZ4mTOigcVgDEf1wizKLXxQqCETFUIyn+9HLC8GRkn8U9z1y6ZxOOYYm+b
         tAyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnQPZPwTU2aG28QJuVIBia40uyA0I9O3mlngzHDtk7QgujAtyFVc6UBpmDxq8q6q0a7pRb0UM=@vger.kernel.org
X-Gm-Message-State: AFuF++nxmRIW6tj9WbHV5ZosYbszC66OGpB7UmAWk/7TwRPimOkjV3Kr
	t00YRegoJMshbPFDCv8FlQs7ccIKVZZlLcnvr6ejU7DbMy7dNifjeSR5uB0NIY3Wn3I=
X-Gm-Gg: AYBFou1TokyOFco7CIlPwRJ9jizWoxapcfFXaVaAVAOrvq1ckzhBtBYe+jI1HUgJ9zs
	Y+PRyef85hJS/uso12S1GJOGse+Pw7RHF4vZhdL6HE3Rg+STlZpP5p6zQxTfAax+lQ2Zw99tiZ9
	TjW73is73FywiNqk7T1oUnj/oyghC24bEG1XaoScR8/ThwVg5HxDKqF4nWZMb8XFBYxmpLA0x3o
	HlL27s4ka4Da1IIOOtBHsacz80Tf0k6I6adx8MFJ5UoKHMbMQA49r7GPhm2LKwLm72yaGgth+AO
	wLRuXYcM4Jk3UI+iMM1pF9VINsnv5cKIRDzBojmqMUELu6dUESPwsq+lbdfMzukfwaRm0Teqe9x
	ZmoDMrLCQ17fUH4MYqjBO6c+M25VOLlFiyt+1yeau+fyL7IkHhVIEvOLwx5EKGISQWzyhG5kVSV
	xrHpElI7U9qP3OxgXByUg5oifQQAaaI8Mhh0oWNAPTGmErB8W2ZXcZQTKbJWZixCynSLwrzeS2d
	V5r6ohscUSaTRANkOtdp/WFcsyWqyYBrcXojmV4euchTv3ynQD7QQ==
X-Received: by 2002:a05:6000:470e:b0:487:342:eb37 with SMTP id ffacd0b85a97d-488716954e0mr4204794f8f.7.1790257070687;
        Thu, 24 Sep 2026 06:37:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a? ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm14741846f8f.2.2026.09.24.06.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:37:49 -0700 (PDT)
Message-ID: <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
Date: Thu, 24 Sep 2026 15:37:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260919191524.268810-1-meatuni001@gmail.com>
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
In-Reply-To: <20260919191524.268810-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 21:15, Muhammad Bilal wrote:
> tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
> into the global panel_list before tdo_tl070wsh30_panel_probe() calls
> mipi_dsi_attach(). The panel object itself is allocated with
> devm_drm_panel_alloc(), which only arranges for an automatic
> drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
> is torn down; unlike devm_drm_panel_add(), it does not call
> drm_panel_remove() for you.
> 
> If mipi_dsi_attach() fails, probe() returns the error directly:
> 
> 	return mipi_dsi_attach(dsi);
> 
> Once probe() returns an error, the driver core releases devres
> resources for the device, which drops the allocation's own
> reference. But drm_panel_add() had already taken its own reference
> and linked panel->list into the global panel_list, and nothing
> undoes that. The panel is left registered in panel_list pointing at
> a device that failed to bind, where it can still be found and
> dereferenced by later lookups/iterations such as
> of_drm_find_panel() or find_panel_by_fwnode().
> 
> Call drm_panel_remove() when mipi_dsi_attach() fails, mirroring what
> tdo_tl070wsh30_panel_remove() already does on the normal teardown
> path, and matching the pattern used by other MIPI-DSI panel drivers
> that pair a manual drm_panel_add() with mipi_dsi_attach().
> 
> Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> index fa961abdd2d7..32f2dd2bcee7 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -179,7 +179,11 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
>   	if (err < 0)
>   		return err;
>   
> -	return mipi_dsi_attach(dsi);
> +	err = mipi_dsi_attach(dsi);
> +	if (err < 0)
> +		drm_panel_remove(&tdo_tl070wsh30->base);
> +
> +	return err;

Switch to devm_mipi_dsi_attach() instead.

Neil


>   }
>   
>   static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)

