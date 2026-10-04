Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232AC244687
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127870; cv=none; b=TdErbmgM5Bc38jioA9qd+a+COz9Wt4QKCskzzUugNhNkrbm2bfNU+McFtQNgDIsALxxSim/8GOeGNLj8UQrfIs6VH3IaydDToOOoBLHBv9kvyVmPBUQwgCJyG8cXxF7pmM8R3ljSOfBYBlOCrjUCohIPl6b6jK/QzIWjkKqrSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127870; c=relaxed/simple;
	bh=JCxYXeUCq8xcNaZe3tzWxzTXxOKlUeGiHyX3ydaw3G0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c0cZDcaQ64/WK6fxjI6RhsOp6bYsM1us1t2DTKaVTaWeXxvJnC4Q1FnqbukxKxVnN7qIj6vi5vDdtowmWxXHjuvBJAQokI1/qPU3pDKer7/GP52s607U99VFps+bKogDwkFZWzxAQSJTQkGpiK+CkSdKyrnqA9JCo2+oGIJgNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdCyVTeC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdCyVTeC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b001cd92bso509214f8f.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791127867; x=1791732667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8UQiiW/gzilrgvSzhDTIjzX+BX5W1JZdipDo+7xtF0=;
        b=hdCyVTeCn6a3Lh8xmoj6TCz4C9EXUga7rA5rWqdFhFbB4jdb3WMK/i3FxgvlyBkMFH
         AfXaJl2rjz/SNiL7vbAflRyRpTk941AV83zwk8LpCaB1tDp+cN3yNnug8IB0fqnPzoJZ
         J8juohWrYgmVlf0VSVzEpmml9p4g3DYp3CUYQGDneBut9Urhi5BA8aA29m6tkaWIKSd5
         YBzRSAPVmJBBwbeUZIYWuGcbCfVRm/AnOGi5cRysdJbRHcdsrsa5w08NMjiYuOtlec1D
         ce1EPAnL2T9ohlBheMxBhcaqnyPBPAApZn+V+nI9Ikzexotkgk1kjFQgkr722BdwrcW3
         O+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127867; x=1791732667;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A8UQiiW/gzilrgvSzhDTIjzX+BX5W1JZdipDo+7xtF0=;
        b=Bt7lELf4en42Jw2dkMpa9FRGHSZZJQ1CUzY2FkHdgiH9O4jbsGqF/bmNf9OZp1XLr1
         WPRTbRCYnKb9L2IUr+8VS0D8Iy5GNNHoXlCDBgPk8ENwiBi7sjTzshetRSgyQ/plYxJY
         FTZQWnIw5fXD71Ev1zgyI3/lKx+LHo0SSCbsl/8r1g7+SRi42hdppMNEO2e6HOHo+Xqd
         zTdU205Z+PY34WLHmggSLA6QDFr+Vf43vayZ6VOnbp5IlQqAquLkvvhZvGnQ3VGZO7Cc
         bDEora5bXes8GGz+z6qXnCYy7gtqPqIIXA6WlPPoo4PLI+k0MIc7iKnl5ifGMXLj4YkU
         wNwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzK774STx/XoT8M6K4g07edJbZM+Lzh3F23AKX598PFaZbQZIrGbiJJpcXSDsJA175V29W5ZLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lxCA6+fuUelZuygqrtJJCuJrxKlAIAUazetj8qv0+nRBmd+ZH5
	N2Xnias3lMx82jyBq7GwMI4OKqt04SfJgs+TwUw/KDicDM6D04cVe1WmBPlPdP8IziE=
X-Gm-Gg: AYBFou0n7GiSJxhsWhC3euRNIWXjKup3rZPlywPHCpzOjO3LY/YG9jt8i3Ife+TRjCE
	8wklEbkumBMtPfZefgjiTHTly5+MS9cePU3JpBML2TqLtIMVw+GXrcyGjR20eXgjbk9G/dpMBlb
	oNSwzQL9A3Dhchng5sz0en4W7FzQiaci9IgJdbqgPG7/EsKxy1WmY1MWq3ExgzeZtmsLnBBzDCr
	9gee69BH0H6jiiw1QKTESyETP+zfHgA473aHCHQGqD/9zyoNi3Ew4xzTRRdMsKsPHILK056dX8G
	A+SXW+V2Lmi6qgOq66+vi2nWAdC/AF4+AU3RwulgzbBtWyn8T4aDzXsT1dulqJCOqxQQPbWHHY/
	CgdxzGu9UyLtliJNTYo5degN7+p5/vcRmZvR1CNZlLb7525zGrMm9hJ6PNR/QwZx9rb9LnMP+Ym
	sZ79/efEkccna/Ocm9TsofnFr5+asqKjwHgRAxSp7aydulP85zC6/0t6CjYs97JOr63FDQ+nh8F
	tYP+e6C
X-Received: by 2002:a05:600c:3103:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a1680fd804mr74504535e9.30.1791127866831;
        Sun, 04 Oct 2026 08:31:06 -0700 (PDT)
Received: from [172.20.10.3] ([37.169.53.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027741586sm262949745e9.14.2026.10.04.08.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 08:31:05 -0700 (PDT)
Message-ID: <022f5372-7963-41b1-ba76-2d89c51aa8c6@linaro.org>
Date: Sun, 4 Oct 2026 17:31:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while ENCL
 is disabled
To: y-asai.0816@docomonet.jp,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Nicolas Belin <nbelin@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
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
In-Reply-To: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 16:50, Shigeaki Asai via B4 Relay wrote:
> From: Shigeaki Asai <y-asai.0816@docomonet.jp>
> 
> meson_encoder_dsi_atomic_enable() programmed the ENCL gamma LUT right
> after meson_venc_mipi_dsi_mode_set(), i.e. while the ENCL timing
> generator was already running (ENCL_VIDEO_EN=1). Writing the LUT
> during active video stalls the hardware: L_GAMMA_CNTL_PORT
> WR_RDY/ADR_RDY deassert and the ENCL line counter (ENCL_INFO_READ)
> freezes, so every remaining write times out (~8s total at boot) and
> the panel ends up with a corrupted gamma table (wrong colors).
> 
> Instrumented boots on the ODROID-GO Ultra (S922X) show:
> 
>    failing:  start: VIDEO_EN=1 INFO 0000001a->002d0000 GAMMA_CNTL=00000030
>              stall: INFO 002d0000->002d0000 GAMMA_CNTL=00000000
>              (VID_CLK_CNTL2 / VIID_CLK_CNTL / VIID_CLK_DIV unchanged,
>               i.e. the ENCL clock is still running)
>    fixed:    start: VIDEO_EN=0 INFO 00000000->00000000 GAMMA_CNTL=00000030
>              no stall, no timeout
> 
> Whether it failed depended only on timing, which is why enabling
> lock debugging (LOCKDEP etc.) appeared to "fix" it most of the time.
> It happens regardless of the bootloader (mainline or Hardkernel vendor
> U-Boot).
> 
> The function already writes ENCL_VIDEO_EN=0 right afterwards before
> re-enabling the encoder, so simply move meson_encl_load_gamma() after
> that write. This matches the order used by the vendor U-Boot's own LCD
> driver, which never times out.
> 
> Tested on the ODROID-GO Ultra with mainline U-Boot: 5 cold boots +
> 3 warm reboots, no timeouts, correct colors, LOCKDEP disabled.
> 
> Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
> Cc: stable@vger.kernel.org
> Tested-by: John Williams <porschemad911@gmail.com>
> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
> ---
> This was found on the ODROID-GO Ultra while bringing it up on
> Lakka / ROCKNIX. Happy to test any alternative approach.
> ---
>   drivers/gpu/drm/meson/meson_encoder_dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index faa309cb97a6..912cd676bbe2 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -65,9 +65,9 @@ static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
>   	/* ENCL clock setup is handled by CCF */
>   
>   	meson_venc_mipi_dsi_mode_set(priv, &crtc_state->adjusted_mode);
> -	meson_encl_load_gamma(priv);
>   
>   	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
> +	meson_encl_load_gamma(priv);
>   
>   	writel_bits_relaxed(ENCL_VIDEO_MODE_ADV_VFIFO_EN, ENCL_VIDEO_MODE_ADV_VFIFO_EN,
>   			    priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
> 
> ---
> base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
> change-id: 20261004-meson-gamma-3306257c0d28
> 
> Best regards,
> --
> Shigeaki Asai <y-asai.0816@docomonet.jp>

Thanks for figuring this out !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
