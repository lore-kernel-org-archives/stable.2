Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312329;
	b=LzPEKcmtqcp2Zw6lpO+AOSdi6WQVnp+h92qsWpKysnDBo5HAsXIl4WSHntWGrYYqzFz0
	 4FKwPYeg+E5UhbXdFdVL+899WSNbqfjOmBMPzJ7Gk1AN2+a4lMe2t4cpu0WKjzJljV1LO
	 ACZEDBpJasC2qKf1xVb/2OW2qsjTON0S8+buvZerQUGA0Ercg6VHXqDeDE9DOxhlB44OD
	 C9Cv4TaC9gPhX7nBA5PVFbvILzzRaBghyQ+Vi6wOQq6816FAASgMEiPbV3nKv3KVnBrQN
	 t/v0vSSJul7k4KV+JIyZIxor8gIXYkCEu7DDRP7/4OUGxZKTHZeUxdHqKNHwzMBjuwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=I5T5peH0PUnCrtzemSjuLVp2+YwXJuyEpiqwvId8VNA=;
	b=b273KD/tZ56ZH8+V5L2snFXL0HCpwawQ7rchfy9si6A1nXQdnx1ybrQNaJegTDHBdrE2
	 RfQvuwbzx1By+UhbQ5O763kqTJFQr3ev/zdCmjR8XLCqg4YDANyqXgpEaNRV3/Tvx2JM9
	 pzPmAqzOuOXWB7FqTMD8UBpFO6hC5FDjPN1x4vrY6Q5v06uk8KtOfB60TE9ODbEHP/aF1
	 W0aNPr1Dr2iLmtsFf8LAynyysGt9z2tfFKBLf8Mui1tHYxb5gJtY5+e7vyLgdAKPvHeg+
	 BLdnohy59Inm0AdJg0Q+CIcxD4dUwIWV6bkr23b+Fe92E8gYwywXlJuK8p+NIN6YZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ43syDN;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A00606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A00606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZ43syDN
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c102ad8420so1465889e87.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312326; x=1794917126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5T5peH0PUnCrtzemSjuLVp2+YwXJuyEpiqwvId8VNA=;
        b=eZ43syDN2nk04TvvWXBmfsqm56sABgP6OslmMZzl4XUYv1Kf8t+BjBWbvNlgK6V2g/
         7y1hf2vLh4S7d/qbNqFNN/T3URlge1l2qlVnKEofkynJ8lsH2D1Vl2+PzGCWLgb7Xk0a
         L8a+bpaUTqE09dXf9IalxUi/0gvMaEBWiijLQHoo/0rSuF+hd6NNkVp0OOnjrYkQ/Axw
         Qs8hP7MaS/jz9JN8y/9jxYqB3c4K/dy6FaaBSQAQwRbuTz14Hr/dynQx3fcFd1qBSB8j
         KKancvYE/5/oJ1Nn0OmK0X9rknhMAYZFuitGv6bP2IHL/Dz9SdZWhaU40bfFVc9okJgX
         u0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312326; x=1794917126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5T5peH0PUnCrtzemSjuLVp2+YwXJuyEpiqwvId8VNA=;
        b=0e5w6h+jKFbKj3+9OCife+HfvuwvYJlQZKoW/2rg2GvJ1FL/eR57PvbhEzLEfoQkpZ
         WkuU5QvI708GL29CErs+BIDBBhIzGgIt+QQ2hmOcr+CkNmUd3LcNRRu5BGksKyhU+EXm
         /E4aVYUJ1UIGVYlfhnW7z28QK6JsDBjP+wTNNvVTCGaMw5MqprslDVJ+MByh/vYj08pQ
         4hRaYOxkhM/h00QFchAcU+wVXR+viIZU1Yz4cu7r+TQMRjRnTyMiHR9SndyNZE63wYap
         RPDx7iyCPHX16qJvcbqtxrbJYo0LyxzvBhCGtXTkjiER/7JUftJfSYAp8K4H9S/vUFX2
         92WA==
X-Forwarded-Encrypted: i=1; AL+hErGB8K2tRoa3eAPIkpOEyaluFX01LzrzbYCQIEJDlCqsKXDXDlErks7D9FRlCDU6J1iUWiRdy70=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tVEQXjvK/cbt3kZlqP2+YWLKyWk0oxuKLi8JJGZuLGeTGxdDj
	zSvjB9eE5G5FfJLHRWxXmSRh6NbktJp90gQ2BHrTZtUcPE5dNkukcaa3
X-Gm-Gg: AYBFou1WRO6MPytq+msqYZZwwH0k9PkHWOdBVAIGfrvs2QGGODXj1960HapGklWsqMs
	wCaxd8Jq8LjtuNB/FiMRd8mYkbc4u1wjZDnbyMtxUR+7WnffdIV+A+szkbEYogq+xxiYBV8EFgh
	Z2BW929XXAiXBvAYMK/RcjVyb1UssWhRDnf7KsXvSywm3pB3r3c03u5MdUb/Hr6mN8Kpb/mFRBa
	jirLnDqysrbk+roFxRo1WI9DUHHlykAFtbMT0AajWSI1okJEHVRIvjcom2gCVdq/dl9gt6iuY+m
	LadSkLRjLN7eEyAjL+PHREyj/ixIPf2BaJF+iIj+1rvIZ0BcxBPlxXuYd95C3Xq12zh7eBO6nIF
	xByDk1WqPhVHju6vpqR1jfUXSO9x2Ya1lVvRMQNVSBTRtOLXJ0LNU9haBCMJfgxWPzuJY2U8vDK
	MIKfvKHI0384ob7LYBb/mgwf5b5EM1VrJV5CpeHl5XVBnklokH0YA3qC9hOK1kPMBBoWtgrCT4k
	815O9a4YEqelsfzDLB6IqjB1udcOOBwJx6iAL5zjLpFt31yhRkuP/m+v0NE1twQ8mxdVZA/TMWB
	QCBeF1bvaNYh1DWMcAsTW7VJKVxbmmcmJdJJ0Gwu9bLJW4WiFwm91sQ=
X-Received: by 2002:a05:6512:1302:b0:5c0:4e3:a416 with SMTP id 2adb3069b0e04-5c156e375a3mr617826e87.1.1794312326336;
        Tue, 10 Nov 2026 04:05:26 -0800 (PST)
Received: from [10.127.122.226] ([5.195.0.150])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c159702ae0sm240512e87.20.2026.11.10.04.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:05:25 -0800 (PST)
Message-ID: <91a4fdf2-638c-442b-be29-59e05c8ba396@gmail.com>
Date: Tue, 10 Nov 2026 16:05:22 +0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix HS phy init count imbalance on
 Exynos2200
To: Soheyb <soheyb_boulaa@proton.me>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109221522.2796426-1-soheyb_boulaa@proton.me>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20261109221522.2796426-1-soheyb_boulaa@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 02:15, Soheyb wrote:
> exynos2200_usbdrd_utmi_init() calls phy_init() on the high-speed phy,
> but exynos2200_usbdrd_phy_exit() never calls phy_exit() on it. The init
> count of the high-speed phy therefore never drops back to zero: after
> the first init, every later phy_init() of it returns early, and its
> clocks and supplies stay enabled across an exit of the UTMI phy.
>
> When the high-speed phy loses power while the controller is suspended,
> it is thus not set up again on resume, and the DWC3 core soft reset
> times out:
>
>    dwc3 11210000.usb: DWC3 controller soft reset failed
>
> Exit the high-speed phy when the UTMI phy exits, first, in the reverse
> order of the init.
>
> Fixes: cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4nm controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Soheyb <soheyb_boulaa@proton.me>
> ---
> Tested on a Google Pixel 9 (Tensor G4) with an out-of-tree port that
> uses the Exynos2200 phy ops and powers the USB block off in system
> sleep: without this change the soft reset failed on the first resume;
> with it, USB came back after each of two system sleeps. Not tested on
> Exynos2200 hardware.
>
>   drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 087d552..0bee928 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1486,6 +1486,13 @@ static int exynos2200_usbdrd_phy_exit(struct phy *phy)
>   	u32 reg;
>   	int ret;
>   
> +	/*
> +	 * The UTMI init initializes the high-speed phy; exit it in turn, so
> +	 * that the next init sets it up again after it lost power.
> +	 */

I think the function is pretty self-explanatory, so could drop the
comment. Otherwise looks good to me, nice catch!

Acked-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

Best regards,
Ivaylo

> +	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
> +		phy_exit(phy_drd->hs_phy);
> +
>   	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
>   	if (ret)
>   		return ret;

