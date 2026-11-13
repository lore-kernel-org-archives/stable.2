Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574158;
	b=BTeTV310+lhl8cha33MnBwKPRWqz3ly8xGVaHICesfWfy4SxBVia6Sj09TwHm0u5iaUY
	 9GxnDmtF4i/eqe/kkM+l88P2kkZfjQcLwz1tK+EfPLyDisvCpZK7dlgRJ8tZDrNFH6edO
	 lDlOUSiOenS26mS2mXY0dFImVBGOSNI2x8kfVEaV4l2cWJ6YK9jAXxvse2+WYbqhFh03Z
	 p893bHcz/qdINLMMCOHw0ats5wo4HJsRBYKZletUmX0ptcwIFHCxiNvx3KjUrLFqGdKgp
	 ah3/qGDi08mDLaZFouqn+/zViz8ps4kqKt+gByvYOOjXnz2yuOPRbd0HwecjoLHwXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4s+uD7Kz9Ds6anaBbLwZ6WOQF/1zwYR8W1iYVgZ85Qs=;
	b=R6hARfwa7ZCX/+QeYpXN1bvpnsN6z4eX1vVEcw9Q/Fh9ro0Z5+Ki3/oIkNd6u2ECf9IY
	 xdznWCANypVR+gDE4Dg+Bga2aR6bjZLksbC9jSWqcRvA62bN5SBUVfelIlMP5xy+Koh/+
	 jgynhveTInonSVrMB1ygZipbEo8gonIZ3FppSGIVThsZ2P7gqN9gK3zGnVyuEwh/ICCgL
	 v8FHuK8lSMfmpU1+STc+L7Y0hb4AOK5iKUWRoWX9HdAX9hORYgesgTE/1tjbbb7uOKGkd
	 X4x9vU0GGSTJ5AWWO+EWQERPBN87eXtIi1AcRDAZIs4XLfbQkevdzkFE9hvOn4MwAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZRl7mmvk;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325C606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D325C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZRl7mmvk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so6151345e9.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794574156; x=1795178956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4s+uD7Kz9Ds6anaBbLwZ6WOQF/1zwYR8W1iYVgZ85Qs=;
        b=ZRl7mmvkaSOIpgi+00caNJisqCQ3juMe9GT1Ap/MOAR2/b9P8lMZu3tKC+u46S6S8j
         TUtCGf9pGgw8bFnDyqt5+kMJF83zC4Kl1naCDywqU2o3uTZacTBvNwL8fV3RSBrVp3xX
         cy7eOQDs2KD/yllkBUnUK79KWwmVkLxhK8LdAqasPNzgeg/enoPy64WJvWRD069WGzQn
         WtUHYDemOsrGKNh8VjEOZWmExYqWG1uc8nVukxhvFwL/eHpU0TU8kwQzZS12G5QY11Y/
         ZZUjSVuBdDRV6Zsh4ln7OH/xqMufXHEqXOu5n++yNPe2xbLgTR8Pkp9+CPoREun3SjRm
         EzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574156; x=1795178956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s+uD7Kz9Ds6anaBbLwZ6WOQF/1zwYR8W1iYVgZ85Qs=;
        b=k/erscXgaEPdU7BxXwsXnZ34sUQo4NInOVSMqqr4zMwSBGdL+2dMwaOqP06YDQujif
         ri9TXi/ORTj5BB+5a8f9TQBMu/01Y9DGrwiJHYdsHlqdYplTTEvYVANALeYsDaQ1UxsJ
         i9I44Mra2Cr9pKMl2ncl3Q7aTxEiNKkywjMYEs0IplHa5h/Y0GYU41cdhMJksrObp1os
         AWxHl64VIiBeiwbyrbPnWHD5OSSw5ovwPOodJPEtoydV2gE4lUV9Znd9MwTn8kF6eEAV
         Y3jjKAZONk9jK990gv484140U/Jw19j3oDPxUUnufABcQBg0j0/L4QgDUUfalOTzBDb1
         40Xg==
X-Forwarded-Encrypted: i=1; AL+hErFKK23eTJ451D7KQ5gqBvd3zp+lUMsD/Ucc2Fx0l5Vh8bLeAZ8Jc0kChDtQNmq5VCxlAOsHLyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1PPy5nWwqPhwsXWtMLKe+9vYPbFRBZAlkZugGX7EBB/SvaFdr
	FB4zT31cRN0iR9FTPmtwy36JZ6uloglHwn7mc/KDEkWLiPOVd1O/2SFkV5e6LOOQ8I8=
X-Gm-Gg: AYBFou1ekZRQiirS7mWNMbKMjESYVjGMG/vk3bbKhqFpF/vsIVOSzJ4ByNzDi1ROMgr
	Cdr9sgQx2Sw0p6/27g1dfQ10nqY373mK9/h+Su7sH8JSFwzGkaFQCSEf2abKtlctxIo11zZf/ms
	gIrDEih5ljtyK9k8w91TsEZWeYVUscI8it23SGrtDE7aIeIpX3/3bgzdrrJd9ebQiFIdB84Z86h
	eOBgw++5TKNkMenNU5tx33P6bMURewjlXIBv/3d8JVBGSVeSLWE0qMwgjiWcDGS1s6d6e3Yq9+a
	5gmg4pAukrElTlN+6hL+SK4pFIvkYNKv3igLC+UgALqF1E8st+Q2DdHbavt8eNpmfwZK2GOfsiV
	+r+AvshK50A8A6T51gKOxbmMwcHnizxZKnr7JgYlx83jaOzxF1isQF6/+2pW3LUGtMV+csdo1GW
	4i2O8/+EHBuBRD6sllj/DgvWiQlQxCrJXMojPsWAn1r9mtaYE2ANDtzHnC1Ldn2Nqlh9PcDAkMy
	LAJwQg5xNgCEQkoOSHtj6C7EEkBJG0oF82Un4zcT1u2yYd5Y8dqyTQwdVmRwOX+UePMW6i94fjR
	bzsBS1MsT4o5sdK5FXReWmn6cTxu
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr52848935e9.13.1794574156179;
        Fri, 13 Nov 2026 04:49:16 -0800 (PST)
Received: from localhost ([82.145.117.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da0a03sm4122315f8f.53.2026.11.13.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:15 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 13 Nov 2026 13:53:13 +0100
To: Xiaolei Wang <wangxiaolei01@kaihong.com>
Cc: linusw@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	daniel@dragonzap.com, iivanov@suse.de, andrea.porta@suse.com,
	phil@raspberrypi.com, linux-gpio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] pinctrl: bcm: Add missing SGPIO entries to the
 BCM2712 AON tables
Message-ID: <avcIOTzDFrI3rGZY@apocalypse>
References: <20261113053221.3131068-1-wangxiaolei01@kaihong.com>
 <20261113053221.3131068-5-wangxiaolei01@kaihong.com>
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
In-Reply-To: <20261113053221.3131068-5-wangxiaolei01@kaihong.com>

Hi Wang,

On 05:32 Fri 13 Nov     , Xiaolei Wang wrote:
> The BCM2712 AON controller describes six SGPIO pins as pin 32..37, but
> the AON function tables stop at the last normal GPIO: pin 16 for C0 and
> pin 14 for D0. Both are indexed by pin number, so dumping the pin list
> walks past the end of the table:
> 
>   A=/sys/kernel/debug/pinctrl/107d510700.pinctrl-aon-pinctrl-bcm2712
>   cat $A/pins
> 
> pinctrl_pins_show() hands desc->pins[i].number to pin_dbg_show(), so the
> list jumps from the last GPIO pin to pin 32, where a valid mux bit makes
> brcmstb_pinctrl_fsel_get() evaluate pin_funcs[32].funcs[] outside the
> array. The set path walks the same table for any DT node that assigns a
> function to aon_sgpio0..5.
> 
> Add the entries as pin 32..37 to match pin_regs[] and pins[]. The values
> are from the downstream driver (rpi-6.12.y), which keeps separate C0 and
> D0 tables; they differ on the HDMI1 and PMIC pins, where D0 selects
> vc_i2c0 and vc_i2c3 while C0 uses vc_i2c4 and vc_i2c5. The empty indices
> in between are harmless, their mux bit is zero.
> 
> Tested on a Raspberry Pi 5 (C0): "cat $A/pins" triggers a KASAN
> global-out-of-bounds report in brcmstb_pctl_pin_dbg_show() with the
> driver as-is. The D0 table is not runtime tested.
> 
> Fixes: 657cbf9b24ba ("pinctrl: bcm: Add STB family pin controller driver")
> Cc: Jonathan Bell <jonathan@raspberrypi.com>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>

Thanks for fixing this!

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

> ---
>  drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c b/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
> index 752b78e2c0d8..1720c220cf3e 100644
> --- a/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
> +++ b/drivers/pinctrl/bcm/pinctrl-brcmstb-bcm2712.c
> @@ -510,6 +510,12 @@ static const struct brcmstb_pin_funcs bcm2712_c0_aon_gpio_pin_funcs[] = {
>  	BRCMSTB_PIN(14, bsc_m1, uart0, vc_uart0, uui, vc_spi5, arm_jtag, vc_uart2, vc_i2c3),
>  	BRCMSTB_PIN(15, ir_in, aon_fp_4sec_resetb, vc_uart0, pm_led_out, ctl_hdmi_5v, aon_pwm, aon_gpclk, _),
>  	BRCMSTB_PIN(16, aon_cpu_standbyb, gpclk0, pm_led_out, ctl_hdmi_5v, vc_pwm0, usb_pwr, aud_fs_clk0, _),
> +	BRCMSTB_PIN(32, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
> +	BRCMSTB_PIN(33, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
> +	BRCMSTB_PIN(34, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c4, ctl_hdmi_5v, _, _, _),
> +	BRCMSTB_PIN(35, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c4, _, _, _, _),
> +	BRCMSTB_PIN(36, avs_pmu_bsc, bsc_m2, vc_i2c5, ctl_hdmi_5v, _, _, _, _),
> +	BRCMSTB_PIN(37, avs_pmu_bsc, bsc_m2, vc_i2c5, _, _, _, _, _),
>  };
>  
>  static const struct brcmstb_pin_funcs bcm2712_c0_gpio_pin_funcs[] = {
> @@ -585,6 +591,12 @@ static const struct brcmstb_pin_funcs bcm2712_d0_aon_gpio_pin_funcs[] = {
>  	BRCMSTB_PIN(12, uart1, vc_uart2, vc_uart0, vc_spi0, usb_pwr, vc_uart2, vc_spi3, _),
>  	BRCMSTB_PIN(13, bsc_m1, vc_uart0, uui, vc_spi0, arm_jtag, vc_uart2, vc_i2c3, _),
>  	BRCMSTB_PIN(14, bsc_m1, aon_gpclk, vc_uart0, uui, vc_spi0, arm_jtag, vc_uart2, vc_i2c3),
> +	BRCMSTB_PIN(32, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
> +	BRCMSTB_PIN(33, hdmi_tx0_bsc, hdmi_tx0_auto_i2c, bsc_m0, vc_i2c0, _, _, _, _),
> +	BRCMSTB_PIN(34, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c0, ctl_hdmi_5v, _, _, _),
> +	BRCMSTB_PIN(35, hdmi_tx1_bsc, hdmi_tx1_auto_i2c, bsc_m1, vc_i2c0, _, _, _, _),
> +	BRCMSTB_PIN(36, avs_pmu_bsc, bsc_m2, vc_i2c3, ctl_hdmi_5v, _, _, _, _),
> +	BRCMSTB_PIN(37, avs_pmu_bsc, bsc_m2, vc_i2c3, _, _, _, _, _),
>  };
>  
>  static const struct brcmstb_pin_funcs bcm2712_d0_gpio_pin_funcs[] = {
> -- 
> 2.34.1
> 
