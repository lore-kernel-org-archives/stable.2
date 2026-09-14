Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DD2931E5
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351460; cv=none; b=ZKXxrMfJ18/dWe69VFv1/w8AukvIk8OH0+9MgsDsRTfKIJkstVtlPzHJzuCWI10zxYwqg4erF+7d3VMfkTIanzYTZeRSgDkYzdHx9t5kT4iNVxSQAdNVy3ldtIqA3Cs/uV3Xrnrby5N1NHKOqiS2MRi16zB1GtKJ6JJq4Gv7ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351460; c=relaxed/simple;
	bh=OyHBm0aM6KH70QZ5Y8bPQRTTYqCndlWggB4rMvP7OlM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GNMHt0moCoPZULy/9ZuogFNWWBd4Cl0oNb8mOkKTxhyeRs/wkciJsrXf+WRB150jvjv7OYX6uNI51i93S5mUo6+fRJRqn9LUIWAVGnXRwzglG4BFMCcMpu67JpFEpTmxmMwjbTsKx7R/Wmn+2Ev4JRa+Yc2nddPFP793MiKODdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW6jYuqF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW6jYuqF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148cso20348416d6.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789351458; x=1789956258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6VPj5Ei/NNEX3MNDuO9HYgV6AmHjtH/GQMIJlXajTU=;
        b=kW6jYuqF/JNesbCtJnh5Np5xrNfkYwcMyH19AIgvMvdOkpriIMXQfxJpjOOw9Hkhfr
         n22ESWwfwCrwCMy6EQe6eP8Z+Eqn180aB9m5DjVkzafFkF5OAsrQdgc4m1N6znZmBBxD
         GKFA7SQN7RRfT0lKhbeRU+QneE9aAIswriiIMLtSWVYfNxAw7JVcOL97DAUvFB/utM1C
         UhGL2ZA7xczQMeUrBVaVr6XSWy61tGbhjeoUO2HmBKVT8WVG+K4jRcT9VWcKzzjdKOvX
         WEcLwC6TOjElXTSPcLJrnLgnhBfzuchOoHF/MVsX7eiO9mAOcuq8g9ku86ZCJhaNliyr
         ctLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789351458; x=1789956258;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6VPj5Ei/NNEX3MNDuO9HYgV6AmHjtH/GQMIJlXajTU=;
        b=ARfJ5fa/cmLVP9NiNhOYQzV4c39GZe8uIacwPpxmlCtNOCQgBOuI5nDEOZx9p0it/m
         gVdLfHj4tfND8JdTfpsNWzYjFLGXedDQTsi5hfwuCU9LUkCLbSGd/o659HPYURI5dliF
         yP8VLj1LIFwPsN2/fEWuXTHKq8K6pdK1f7HlQvykiTWv/OBPPQCCFIacIwsMAV4gTUdF
         0/5X/ixyNOShzXTCRV8EuU4Pcp/H5QtEh7WxIXo8j5NWM+KDaL/S3bbaIM5NixbHCmtK
         hFHc0LDyZKM84owg/0yuFi63Oh6HvZjlVNj0EH8kmF4i38Zv14ogvR0bp1SYH02/Vo5E
         23KA==
X-Forwarded-Encrypted: i=1; AKwUvBzoswXYJ2UZviOxQlrvtZkPSalWPeUp9mIJpJnNICmPp6MS41uj+CkRTiWklg2g09Hic8YKnIY=@vger.kernel.org
X-Gm-Message-State: AFuF++nt5WBlN/hC5pf0S7i3dZ4AlCAumFG9XjjOzF+iV47vWR3lPFuF
	y0qgxhOmmwIsKvw8r5vEfLwiM5c85x0SYakpqU2biKaVtCclRWRkrEw=
X-Gm-Gg: AYBFou0tXJpaa9eXyGmkMpYFf9Y8ZrYDl3s3b+Y4qEHWN5QGPzvTQBGJVZHnbTEBYuH
	r8mtvSOjMimqMQ7b+j/0KZfQVpGUGsGp7syn+6DjLo6/RJFm17qF6Vinv1VvdQG5c2PAC5hv99U
	TXOh+BnXICkkEqn9taOP/6bhIrRRsSu04XPf48GQbnmTs7kwV2FhEobTG/mPfhzRWbxet/B4W6M
	kVPOg8CKGSGyVtYDfbB2qQ4I1KdRDs3q3RtaZhCiPpDmUve9/golvrp13qxyhFzlYcUm4yG0D1r
	9CzfkBn52QtCOVPb5BtnZHCxV4lEAsG13LsAh8rGSHsCyPwJ5DhrHCbaTvOkLe2LuSUP89Qz1IV
	YweNCxv3XRkweeAZj1w3IUDK9CZjqPEGaZvaCI32IkO/KTXEI+/3HqFQgiineXcgtzPtr912OGF
	lYjqo/zEclS3KV6QBM/I8OMeMqMPMvRkgs4HATamFkroAoKIfLEJ16QoNKJIY2Ly4ejh45A5ZN/
	aK62ZFTKMT/gmpbm3nyCDcsxEVGVf0f8zYD
X-Received: by 2002:a05:620a:4885:b0:939:5f4d:67b0 with SMTP id af79cd13be357-93a29766649mr99212785a.8.1789351458163;
        Sun, 13 Sep 2026 19:04:18 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45cd5dsm82051236d6.14.2026.09.13.19.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 19:04:17 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/798] 5.10.270-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260912065516.948645775@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <c9cc917a-41f8-0f2a-6ee8-9f328a2d9ec4@gmail.com>
Date: Sun, 13 Sep 2026 22:04:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260912065516.948645775@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.270 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
Built OK for i386 architecture, installed and booted on a 32-bit EeePC.
No new issues noticed....

Wow, that was a biggy :-)

Tested-by: Woody Suwalski <terraluna977@gmail.com>

BTW: Welcome to Griffin K.H. :-)

