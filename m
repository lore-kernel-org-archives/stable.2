Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A55411A15
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342101; cv=none; b=EadBM9ilUunjljSlpE5Z2AwQY+lW6PHKnxGOKvFePfMEW6xeBmh/XQ92jTlGh/MtnGXpM/d+BuCjSi01UibCneLO8d4IbV2kZJxecBaBhp9cQgVhzo+I2cp6CAYppyC30Z/oAKXjqc8yVnZG9LrgsCA2FCNWDOROVcYBaCKQpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342101; c=relaxed/simple;
	bh=J/dPtV4qOEHFqIZhA5/7ElxHINwksvuDwpgYPO9xLGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWjlZlf7P5stiovMRR+jaQC3liZhBMp84D6uIwpNGkHGTOXG/bw7SoqDw5KaN5UD39UiT71vAVxmzYHvJFKleiieyzc5kqxUFZmYsTmNfNUz2EH26cpmweISu4uzRIqbfEXA1nugnMGm+Nl+vQpNvVcjTfOl/932LeNPDYTeHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcfE7dqM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcfE7dqM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1012495b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342099; x=1785946899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MGJ04DPjDp5NhuCKplYWqLlAi7JvCa6BgyiKARstS28=;
        b=XcfE7dqMdujD4xU23tLmnYF/iEGquvd6C7kOqZ8ZqJeBH+em6QJFl76tOfbTURUxot
         YJ7RWusRIWNMaYruaQj7o3awqwoN48Aj1cNIlZHZzZfVcf5TRYpM/edc1tBBZYedv37R
         hVPUdC87WujRa9u8ijqycZ8+ocm3MW9Ve9d3qMkbF+dOcJCfKOqVsM6dlPQBLXAJ0bTD
         9DuMRFSSh+guIDXpcJnW6NfTAqpyrsqEFG8+O8WVJX+SaLviADMLBhsiFT+uB16C9vbl
         I6HIniMJslX/exz3U90NLGNI++T8dz2PW/AwrCDx/z1fQZVdarosRAMv+nFrYfnUHobj
         r5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342099; x=1785946899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGJ04DPjDp5NhuCKplYWqLlAi7JvCa6BgyiKARstS28=;
        b=c52Ns33bQ/oJL2h/rfOjvpN6D+fhpAEjqRVkmRHhzdTKe+syXY/Gex/LoIN63865t3
         hQvcI+Ok0/d5n8a68hCvE+bhlMyQGDX/qyhFsuGxBeUwn+5TTh+kvtEH6anvfciyCcaz
         7xSfV23a7kdtmahCVJHIXVakoJ+L5g2w+tTH4dDYwzFTWhL70NTTRQPjBzdc5GE1buw8
         FXP8HrPkP9NOfktfwQjoLGGY1dJkopODeIbqrHLKGw4SqBinnqjvk7s0ZdEzmdBBoCbH
         XEK2eRbfR9d9PRxteSKaqlUfsJ7wvGOYtq+i37nq3hioTKXdpjdv6nT7K2/D+ajdP/BJ
         7Jkw==
X-Forwarded-Encrypted: i=1; AHgh+RpcucBrpsRhry+nGx6GXbMdOm6dXM67qbfdf89YJ/qfZDFPh7kv4YPK0CiWKx7nkmttNDctKRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wy5ikk/Kcc2CiCJhIfSYvoBBckylybaOdV79C8Hwm8R/Flvt
	7Q8dTbN9htMz/gxQkh3eYmjdYEkXRWX1bO0jKOWau8RJMROJmCvMzYe5wJ/aYA==
X-Gm-Gg: AR+sD12tbQENMseoYKUeuModcn/T6zbCxgS4szCuE53UsveZJK9tnUPT0QMhW4oSIQv
	2vGHElEYf3Courcv7B/Dw4mMLFIBux5tK4JrOavnrfuDgttDL8OPvacziT/CtBW2Qfj/jFJMX8e
	DNs+5B+Kyy/318G3ZwpJHHG2gzQdqsdIZFKQOqIgfILZqyuEyk6UOKXZ926+Yzlkuvdovp0QUFh
	LV0zcnwZuY/htVXGFEHSC3+l7AAbyRRMbrbflNjRNizkLXM8GZtQD4eG8gBGLzpYGkurX/0qBxE
	H73mLBIebnPHALiJOKhvZMSM96dDvAQJxa0zccdnP4Jf/FIXfKvUgDoCIxdE1FkWNAn4dlTQQwb
	tBlU0viZ0hWzJSYP77sjPodd0U1Hc6Pxydti2IzqRoA8vC1jMlX1NiMZegAO1Ga6Cji/aaYI64Z
	9qTd7Ll2BgawYJzLKbWGPjzSJpoFdNlKm8BD4RuyOe9M4acWjkYcjb+IDCzpEpnce8pUz9N3dj3
	w==
X-Received: by 2002:a05:6a21:7a82:b0:3c3:994f:b4f5 with SMTP id adf61e73a8af0-3c8ab0db549mr8766339637.28.1785342098975;
        Wed, 29 Jul 2026 09:21:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504db2c4csm11392516eec.28.2026.07.29.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:21:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 Jul 2026 09:21:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH v2] hwmon: (npcm750-pwm-fan): stop fan timer on device
 detach
Message-ID: <d3561ea0-87fa-4ef8-99be-e4600d6d07bc@roeck-us.net>
References: <20260729100116.790-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729100116.790-1-getshell@seu.edu.cn>

On Wed, Jul 29, 2026 at 06:01:16PM +0800, Hongyan Xu wrote:
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

Applied.

Thanks,
Guenter
