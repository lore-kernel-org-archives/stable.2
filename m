Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9333938F
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320212; cv=none; b=nzchPUWHOH3fPIKgF57wfiX63EEVb4RjDmCvbXHYnRhC1XexlZ8LlAAX6KSIufaqmVLBUmcb8rRcG9zpSSeg0pA1zvdpOi0+ecwBHPDis8NwZTcTZ8B62cz2gRy9fV5YT6QeaAe1NvN92BFRXXDOhf0T6Nxy/ZFW5AdHriyXXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320212; c=relaxed/simple;
	bh=sLAHFiD6uEZhsc7oOQIgUB/Oy4CEVEybFPWaplKsmBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suDwDmwQG1V6Tr+0hlS4hcWNotiWrBm1tx3AMMUsN07vQXWrucd/l/SsjVv1FBOZD2vrRHysw8ysxWNwdtPbyIGPcamM2hUN3ZgCMOLKOAHyrQ7tuA3SRtZJFGGsuqWVXGdLpEgwyzXSGbtqcty0VfEnis8JyaDsGVB8udbU9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ/sQuli; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ/sQuli"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso8043845ad.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320210; x=1787925010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAyFMesai/LLE4MqT40X5iC0pDOsOBaB8XftlpGngbM=;
        b=MQ/sQuliPlsILi6n4/gxX5DPknH1JxDkJmGGhhc1RLnZ4k9sEJUE/ogK/f1rZVrAWq
         lXWutJFCjQ9Sh+hpcLk+AajnBIT5qmYGENH0mOlwLUwJ+sfWWZB/d0mAeJ8Zvp9zhow5
         Uy9TLDZ7lBGx1WhO7ZMf0ZUGLRuSR/rD5I38butNOZpiS0IvBb/1iRZj0PzuWs45U0Ib
         69JeaQctAKis2jXuRoTqt2XcNBsT2PHz1dMrcg5XkUWc0eH7OUlK3m9rbOG89OrfLi6D
         mwbgO3Rtx/Io2MQKkw4gegsLZ6N9WCMXDZ2w8Hr22Gnmh+StwOYhykUJFJLC6RySd7zF
         iSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320210; x=1787925010;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zAyFMesai/LLE4MqT40X5iC0pDOsOBaB8XftlpGngbM=;
        b=AIHpsz12Qkg+38br4rzJgUq88kEbkY2EHi5wfQldyrygOFaa2FZAHyVpbaTbhI/gQB
         DOuezK7Zr2fD9QLFULFeaoflh5Xx61gkkK6D4SlqS/UP4rTTqADw6D5TINO2ZLjw8Dae
         4dxi3BrqQ5r3/hzt/TITJNLIUlWVqZHGv7leqNcVjGiw2qOzmH8Tij9jYBrckzAsTfB1
         01jWvrwBL+jPbCd7zvzRzEYPlmC3Owunfds6cbW0OZ6cu38OwhWChL8+LOA3ixNWTUYL
         Gd3wiiEyrYLJxlabPPn+d41s7vOtdL0B5ScppkOoLr6PjFx8RxqisjVX93iRheAE/sHh
         cLuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpk0IxP5TLS5Z43CKEHStSpH/4Z5j4e6T+ROGi+G/nDvQH2scgJscUUIfLB71bEnnGZYmVXLyU=@vger.kernel.org
X-Gm-Message-State: AFuF++lTIXr8a8sAJKv18Oh0R+wzZKmeq75fP/laRu5I9ZwBjo6fWQhY
	7CymptoOby2SZw8CpbNRj8othZkIGN951y3pYK1PsfaBuLLCa/QBaM01
X-Gm-Gg: AR+sD11C8KP4t3sE44WvuSU3ivgU3VUSoejWTmUkFquXMjEdGQQYT63BSIHRDocuAEw
	g3kH/Hvd5itgYJbAZnsj+LMfuM9IMvMHqnpZMona84ZsS2G/D5bS+03Q46UElYsK8b4SHM1o4Nx
	Py2e7HIyHg46NHdWKd7v630GPiUnwFpuqtYqROTczFefBy25QE5q/WGSHiVhF4jnv/+OQTPKQLX
	Hbmc9Je4gEYM1MnMjAgHsejJnS7l9OvSiEqN8ZpYt96t05GmiCIpVVcn5WbDQVJYk0Yw95C68ed
	JStvVElNV5Ouyu1SR51xhMjEuFW/jFT7vMqcklm7XUSIelN3t3pBLVJtxGjM32AmFNTV5y4Am+B
	YwSTRWCFXdK7g057asd/fv0w1zSXEl//ZSS7wUkkwhJcxfZIGO1UvmQ5NZ6q6py1BBIz97af9tJ
	GIqgtpK/t95tIXzvUQkiTUV87usPJMaGn1qY1xoMLxbmD+WUyR2izVzYSnhBYxVRZQNNJUuhePz
	n9TqCM8vouUEKbEVwsXjZED/CV1OBVtQmA5Bws=
X-Received: by 2002:a17:903:230d:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d64afd83d4mr112912015ad.9.1787320210125;
        Fri, 21 Aug 2026 06:50:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555374sm19413855ad.16.2026.08.21.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:50:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b5ce8364-d432-4543-b8fc-0a7e97effee6@roeck-us.net>
Date: Fri, 21 Aug 2026 06:50:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: chipcap2: serialize access to low/high_alarm
 indicators
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260821-chipcap2_locks-v1-1-1d8ccabfc1b2@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260821-chipcap2_locks-v1-1-1d8ccabfc1b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 02:22, Javier Carrasco wrote:
> Access to low_alarm and high_alarm from the threaded interrupt handlers
> and sysfs is not protected by any locking mechanism at the moment, which
> can lead to missed events.
> 
> Add a per-interrupt mutex as the two alarm indicators are completely
> independent.
> 
> Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This issue was found by Sashiko[1] when an unrelated patch affected
> chipcap2.c. The issue is real as the access to the variables is not
> protected by any locking mechanism although 2 different sources
> (threaded interrupts and sysfs) could modify them.
> 
> The fix has been validated on real hardware with an Amphenol
> ChipCap 2 CC2D23S sensor.
> 

Needs explanation: Why can the hwmon subsystem lock not be used ?

Guenter

> Link: [1] https://lore.kernel.org/linux-hwmon/20260625162114.417EA1F000E9@smtp.kernel.org/
> ---
>   drivers/hwmon/chipcap2.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
> index 086571d556b7..1bb4ec96514e 100644
> --- a/drivers/hwmon/chipcap2.c
> +++ b/drivers/hwmon/chipcap2.c
> @@ -73,7 +73,11 @@
>   
>   struct cc2_rh_alarm_info {
>   	bool low_alarm;
> +	/* Serialize accesses to low_alarm from threaded IRQ and sysfs */
> +	struct mutex low_alarm_lock;
>   	bool high_alarm;
> +	/* Serialize accesses to high_alarm from threaded IRQ and sysfs */
> +	struct mutex high_alarm_lock;
>   	bool low_alarm_visible;
>   	bool high_alarm_visible;
>   };
> @@ -500,6 +504,7 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
>   	if (cc2->process_irqs) {
>   		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
>   				   hwmon_humidity_min_alarm, CC2_CHAN_HUMIDITY);
> +		guard(mutex)(&cc2->rh_alarm.low_alarm_lock);
>   		cc2->rh_alarm.low_alarm = true;
>   	}
>   
> @@ -513,6 +518,7 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
>   	if (cc2->process_irqs) {
>   		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
>   				   hwmon_humidity_max_alarm, CC2_CHAN_HUMIDITY);
> +		guard(mutex)(&cc2->rh_alarm.high_alarm_lock);
>   		cc2->rh_alarm.high_alarm = true;
>   	}
>   
> @@ -529,11 +535,13 @@ static int cc2_humidity_min_alarm_status(struct cc2_data *data, long *val)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (data->rh_alarm.low_alarm) {
> -		*val = (measurement < min_hyst) ? 1 : 0;
> -		data->rh_alarm.low_alarm = *val;
> -	} else {
> -		*val = 0;
> +	scoped_guard(mutex, &data->rh_alarm.low_alarm_lock) {
> +		if (data->rh_alarm.low_alarm) {
> +			*val = (measurement < min_hyst) ? 1 : 0;
> +			data->rh_alarm.low_alarm = *val;
> +		} else {
> +			*val = 0;
> +		}
>   	}
>   
>   	return 0;
> @@ -549,11 +557,13 @@ static int cc2_humidity_max_alarm_status(struct cc2_data *data, long *val)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (data->rh_alarm.high_alarm) {
> -		*val = (measurement > max_hyst) ? 1 : 0;
> -		data->rh_alarm.high_alarm = *val;
> -	} else {
> -		*val = 0;
> +	scoped_guard(mutex, &data->rh_alarm.high_alarm_lock) {
> +		if (data->rh_alarm.high_alarm) {
> +			*val = (measurement > max_hyst) ? 1 : 0;
> +			data->rh_alarm.high_alarm = *val;
> +		} else {
> +			*val = 0;
> +		}
>   	}
>   
>   	return 0;
> @@ -720,6 +730,14 @@ static int cc2_probe(struct i2c_client *client)
>   	if (!data)
>   		return -ENOMEM;
>   
> +	ret = devm_mutex_init(dev, &data->rh_alarm.low_alarm_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mutex_init(dev, &data->rh_alarm.high_alarm_lock);
> +	if (ret)
> +		return ret;
> +
>   	i2c_set_clientdata(client, data);
>   
>   	data->client = client;
> 
> ---
> base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
> change-id: 20260820-chipcap2_locks-c01013a24a0c
> 
> Best regards,

