Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B47134CF
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744645; cv=none; b=JC2RUq+f3ijTBLhf6U9H3YM6LT+7EtIrjLZNiPOxQY7Zgopb3z+tI3uFPF5Qi25Zt3UJaQWvvn6nwpKxze0YdZwuH0qT79YdNSH4qdzQHUJqRKcIWNOP74DigC369LqL/3CHi9lmoJIDWOTcS2ATkf9TSZVCvEQCN9cI/9fZ8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744645; c=relaxed/simple;
	bh=wrN+IKnlZWbXMbS+TCAjRbcl8dEzpK6HGmH3o3lYM8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eP6pqsG5uELyoMZOtBZ7Uf2mblHpWx4C/nd57wtEB4L82bH7HwU41i6R5ERqbx9iJvcsXmGk8adZUWj1y1N/1ht22OqxJC6yBgOx+Q/D6RzWgChQoA9VA7NjzFUoFVxYTBSIZg0pelCgGq4YySvJHL6xJ0pQ+hJEstdWM/zyn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX9QrzmV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX9QrzmV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842358aaf36so110218b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781744643; x=1782349443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JuzrDsik65Ig1umxqH4JI9kb8zV5Eym9Nz1qMEAsXiE=;
        b=jX9QrzmV+7XPRQ7BKD6xgxY1VztE2+TpTOs8mB2zOXg2AJAJTiiv0PmNMMq6f8awGC
         gtsmC3vRZtRGEg2bKq9CZS//e1stTazdqmM8866lMMEir/6PC4w9inrWqCG/qznOQnoV
         tmZQVM5JtCgImuSu2lRlabcpaSConb0aLGljhhCjvFIQyT6C+YmXyaSLC0bfMxh10FVq
         xVsJr/DDb+2p72Jz9dwE0ocEUi60B7OCuA9RePRGYAVLM4za4X7YQk8X8+hoEV04aYLG
         jClZ7bYtQT+GThRRvZTpZA7HGtjlAXm64VmhvLBoV+0ZKnHPf2Ndu98MFBF8SQE7roWt
         GVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781744643; x=1782349443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuzrDsik65Ig1umxqH4JI9kb8zV5Eym9Nz1qMEAsXiE=;
        b=gi+iAqxhk4KxyQzznmvmsiMbqiRjE1/HwIPZG2i5WFRui9EgvQjBzWqrp4IDHkgua4
         Jlu++CjLKyHhX6L/Bu6o1b8PNROeDYKqEKFABVZHOZT+spopcxOsZrUeTR1PrYS38WCR
         fe4Q5k25c9pytXU1Vbj2AQp9h6FAUfjqaOR2BPwrxX8TJ/JcV2YoYUugbhoh1fWDffpl
         ArWGMOzst2MCDMUwGUmxVTbCTJPzVEjlKyGuMLq9CDqKUWohsrbo2mi+mqPhR3eglXwm
         Pu54c9BZ4JmWiDbbrKgqBJuQeZun2zkVIKDano6sMoyMZ1nSmPsNIBeLRkyiX2ppYa/9
         dXWQ==
X-Gm-Message-State: AOJu0YyyWadesKsbWP7WDqabmmnuu8UIMJfQZampOMBK7e/N7YQIGf07
	2FI2bQc89ld2dAkkSjcVFtNcRDbCiXZrFh439M6UYOTJejIiTyYfY9+0
X-Gm-Gg: AfdE7cm3SS1L0mxdFUl0W3cUAaf3qNx8Q8qY8bXaW8kwYrZqlCyu5eRt51KWmB2wXHz
	4tqqV6/BxosnprPFpi6ZwzOpUEqCvzQV7LjB3jvw7dAyCiPywqQoMYVRYTeRjeTaloGM972sPsZ
	gJ4xHQC+4Ishp6lFFbVLNOtPVz/+2S9STQyvsH9C73chyuxlT39kZXvp4CW9THxsJgiKRfN6sPu
	zdgX4QfKVihLKiBu1YKCXgRm5H5TzIXzwPPBEZowyEV++FGR4SkUZ24JO/cjo+/O2Zp5/iqDSSJ
	COsDrESrv20YBJUUw4cnw7bePyhyngnYhkGRtnUjBB2khjn5drPa9FzU1ZGjTc9TbbA3AMoxWsc
	6EBIc+sqGXDIpmFQEQXu/tpTuMlpYeRT788+fNRVDe8bk2IueSuQCtPFTQ27p5ue4aD3L2AolhX
	6A7Gf80OSdhaC2tZcOvdZxLnZH76Qi/CBChSCQY0rouOBMJOENzZXiLQXMjZL6nw==
X-Received: by 2002:a05:6a00:e8c:b0:842:1ffc:55b4 with SMTP id d2e1a72fcca58-8453b27a70cmr1243931b3a.36.1781744643554;
        Wed, 17 Jun 2026 18:04:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845353d096dsm1560744b3a.59.2026.06.17.18.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 18:04:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <800cc395-c986-45dd-a01f-aa4e0f37c849@roeck-us.net>
Date: Wed, 17 Jun 2026 18:04:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/38] hwmon: (pmbus/adm1266) widen blackbox-info buffer
 to I2C_SMBUS_BLOCK_MAX
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
 <20260618003128.3112824-20-abdurrahman@nexthop.ai>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260618003128.3112824-20-abdurrahman@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/26 17:31, Abdurrahman Hussain wrote:
> commit eee213daa1e1b402eb631bcd1b8c5aa340a6b081 upstream.
> 
> adm1266_nvmem_read_blackbox() declares a 5-byte stack buffer and
> passes it to i2c_smbus_read_block_data() to retrieve the 4-byte
> BLACKBOX_INFO response.  i2c_smbus_read_block_data() does not honour
> caller buffer sizes -- it memcpy()s data.block[0] bytes from the
> SMBus transaction (where data.block[0] is the length byte returned by
> the slave device, up to I2C_SMBUS_BLOCK_MAX = 32):
> 
> 	memcpy(values, &data.block[1], data.block[0]);
> 
> If the device returns any block length above 5, the call overflows
> the caller's 5-byte stack buffer before the post-call
> 
> 	if (ret != 4)
> 		return -EIO;
> 
> check has a chance to reject the response.
> 
> Widen the local buffer to I2C_SMBUS_BLOCK_MAX so the helper has room
> for any well-formed SMBus block response, matching the convention used
> by the other i2c_smbus_read_block_data() callers in this driver.
> 
> Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-2-1c1ea1349cfe@nexthop.ai
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

I am completely lost. What is this series about ?

Guenter

