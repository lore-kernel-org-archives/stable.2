Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A03D4112
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273307; cv=none; b=X4R5SM7FkNKG9gA4OHNPLXCVG505juOC8KBzVt/s/qhIu7KWzi3ruvye0m8s8o80fiXIi7LBmXFH5kU4HIIMtkcMxtBXC6oEvCvR7SWm6JAYSeBuz2/KEi0vGh9YZnlmE9qqXZQHeo1KVOtz5lpwobYyr1xV6gHFH+rxSRounKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273307; c=relaxed/simple;
	bh=vSaMxr+W/btop39PHqyfqkC45fGdfrxJ6QgL4JoxHfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZsdb76NTBWGnmTJnmSl5eiSLdH7NFCy0D+M5x0lzeyujNs7XVl331bdr+u4nT5hT4El2Ux54/BEbzc3yLo598CRP9FfXpTpJYdin8rYpEkcIcZU6cXeCwi21OCb/iQJJY3n3XUF4RFyjgk2kkjy+K3eJ2lOv6TLZF1X0F5vEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlTGwRRR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlTGwRRR"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a2c90e383so1184476b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273305; x=1785878105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETJTb72goFKmsExh0rWtuWEGrY06VrxO/4I2OvR2Y5g=;
        b=LlTGwRRRY0Ag3rMcZn/IchoYfZw7tfmYC/CeOQsrT0+vmDJS65NokhqAUijaQfRciA
         H135t2RiOUBncXGdbwsrkzo3MslpndaA+vgfdsBu4NwInL1h5IbYwjtTcXeA3QhH83Z4
         CnPh5fAP4ZwoeWGJ/MsjY5OiFZ84lls+2u1E27VdbiY5nzEqnul58RP8FHwAPEAjTWJ8
         ohqhg2ix1lEAjOoLHEPpateJBfPhp2itFxVIw1s7rP6c9Gj5tLWw6elNOkaKiGRFme7G
         YqDG5XHznAQ9XmqEDT+JyMyf0C8Pb17w7YTx4KfeBnPftkpUtgkn4LC7Ty4LmSUQCYV6
         omSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273305; x=1785878105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETJTb72goFKmsExh0rWtuWEGrY06VrxO/4I2OvR2Y5g=;
        b=Xl6XF6HJeLIB3+65u9zzjhcVac5LyGflAv51ZAQQBZ0bogkW2F3A258rItu9a6wsG6
         WkRqiKwrK6+oBHmoPRR882kT8qDxuw0QOGNsnNfb1N1Xkbxpsuqy3fjXBYl2/EzUhQzm
         odGY7Cz2E0yBFRoWp7azGg167WvmJyO0JRuBW9wB1NLkhvNGyxaHieRNrIqm6VMZy/N9
         nmgGJGhFXQSsC/egwirJVn+lZtpClR3KgufCJaDHM90qSnLU5YeAimA0Qn8Ye7CRmdCQ
         PqyCbpYC6/gatLmy0KO9rX+YjrYLXeidn/r2E8yqToSaTzT9yMcnFYjP9Ft4K0i2Kzbj
         UrXA==
X-Forwarded-Encrypted: i=1; AHgh+RrAt0GKEXpgK88No56KK8nQhpsK/WXVl9OM8pv9eRz9a0XHGMkLx64OJNkfgd3bbDS0ktpg3tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9Z+yWNTWtZ/o4SObc+i/erJeoXwdnIkgBRG77UKvMo9NZMBa
	9L9MXCOVNBYcG8djaLwMzrI+OoWKA0xfUmBkJS6G/V5Jzi3T1rzSYgzC
X-Gm-Gg: AR+sD11Gnr/s5Zfg0dJo9B9QOYmpOBYxWV4iQAp0laeVrXYNyVpcdRa2I/VWQHBIiYU
	oLoH8qvReBTX4DWV9WUKLjoUdgEpWX8SEFkSa6NaUR4OlqxuVYZG2pL2Eo7ToBUO48nZcsb/Hmd
	luD2Wtikfg9W/SRjgt7ibl1MR8Cv5MQ9l8TP8XNAqmaJQmsJ2oP52RUd8YZDCUyR/IuygGg3Tz0
	rexXjXoWLTmgW0YQiz/lYykwiYCl63llb3xbiSvV1kUyux3ja0JHxgh35CfLNrfLwS0DGa+vcsu
	dxaXuSpcOUx/eGzPRy1amt5YSdDWTnlLgJPneRuCsnR5Kqom3qxZc5Z9AW1nubzo0jvDOlZq40l
	46dNKWiJ3k1j+xb4PxWbs7CDSeqKL+cm27kPX0xYCN/o4Zc5/SQIPRFjYP36twqKs+Z+YRtrfYk
	pw0SKWw/N2r8VWDIHVpY64qCVZwhGxOptSfemtjhfPf/2vDqsHSdDSF2u/zxfUZEiGVdJzhKa4T
	dDA6BbIxhN8
X-Received: by 2002:a05:6a21:1bc4:b0:3c3:7dfd:22bb with SMTP id adf61e73a8af0-3c8abb6cdbbmr4297229637.13.1785273305363;
        Tue, 28 Jul 2026 14:15:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824d421sm77132a12.10.2026.07.28.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:15:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 28 Jul 2026 14:15:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: jianhao.xu@seu.edu.cn, andrew@codeconstruct.com.au,
	avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (npcm750-pwm-fan): stop fan timer on device detach
Message-ID: <851962b9-10a0-4fbf-a962-4c2981ba647c@roeck-us.net>
References: <20260728075535.251-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728075535.251-1-getshell@seu.edu.cn>

On Tue, Jul 28, 2026 at 03:55:35PM +0800, Hongyan Xu wrote:
> When a fan tach channel is present, npcm7xx_pwm_fan_probe() starts
> fan_timer. The timer callback polls tach state and rearms the timer, but
> the driver has no remove callback or devm cleanup action to stop it. On
> device detach, the devm-managed driver data and I/O mappings can be
> released while the timer is still pending or running.
> 
> Register a devm cleanup action before starting the timer and shut the
> timer down synchronously from that action.
> 
> This issue was found by a static analysis tool.
> 
> Fixes: f1fd4a4db777 ("hwmon: Add NPCM7xx PWM and Fan driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/hwmon/npcm750-pwm-fan.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index aea0b8659f5..6503d28ed7b 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -358,6 +358,13 @@ static void npcm7xx_fan_polling(struct timer_list *t)
>  	add_timer(&data->fan_timer);
>  }
>  
> +static void npcm7xx_fan_cleanup(void *data)
> +{
> +	struct npcm7xx_pwm_fan_data *fan_data = data;
> +
> +	timer_shutdown_sync(&fan_data->fan_timer);

Why not pass the pointer to the timer as parameter to devm_add_action_or_reset()
and just pass it on here ?

> +}
> +
>  static inline void npcm7xx_fan_compute(struct npcm7xx_pwm_fan_data *data,
>  				       u8 fan, u8 cmp, u8 fan_id, u8 flag_int,
>  				       u8 flag_mode, u8 flag_clear)
> @@ -1016,10 +1023,16 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
>  	for (i = 0; i < NPCM7XX_FAN_MAX_CHN_NUM; i++) {
>  		if (data->fan_present[i]) {
>  			/* fan timer initialization */
> -			data->fan_timer.expires = jiffies +
> -				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);
>  			timer_setup(&data->fan_timer,
>  				    npcm7xx_fan_polling, 0);
> +			ret = devm_add_action_or_reset(dev,
> +						       npcm7xx_fan_cleanup,
> +						       data);
> +			if (ret)
> +				return ret;
> +
> +			data->fan_timer.expires = jiffies +
> +				msecs_to_jiffies(NPCM7XX_FAN_POLL_TIMER_200MS);

Your patch does not explain why this assignment needed to be moved. Please either
explain or keep at the original location to reduce the size of the diff.

Thanks,
Guenter

>  			add_timer(&data->fan_timer);
>  			break;
>  		}
