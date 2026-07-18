Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE11265CA2
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344768; cv=none; b=uh6eySdEjMcMtGmjAtVHPwuA6Vj4XRYZqwD32gwkiQDZqY2OkxRvmg0Kp216cSPU/6RJ4NxeF7vzUwOPR/5RCk8Tu9XQFs3NNS8ZWue/D8nT1hvtRiEa2xMXP5R/ayVDJS7vQW+Fe4biFSXGSHAb3zGPYllkRlApVdNQan2DQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344768; c=relaxed/simple;
	bh=jMKeFhJ2gJYiQ2a7B/MZdYTlnZqh4byeTe9ypGhGzZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko7Zwb2/Ii7fD3qhypa4MokBZJHTQmzoPf8PMo7sXfmVMvNmq+z6TAGF4VFJCWyiAmgn87kZ3QT48jtQ4CUlc4O5LzGa/UB2+wBV48ACQz40G9r6crq3X9C4+8sp258yxmkV8uG3gCTtF5AzSNqB3vZPWpjxqaAyy/74ahwcOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OwHQJTOl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OwHQJTOl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f6de72faso15099545e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784344765; x=1784949565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MZoof7cDAoZkq0M3AxNvmUn9E2JO8aGJgWTXOJFjQo=;
        b=OwHQJTOlp9YIX2pPFtSWas3NY7EVNTn+Z+EjSp9cQzhdaeAJY3hJNyhNEotxATe5nT
         TnrKwsV4jEbSrAdCm6z/IPd8G1xGEZcnY63Pb3eYjfnqWzqqMwCoiRFtOEmRdw9c2zEP
         +YKBgWc7N5VW/hY5l9icVDvMRVWSOijGZwO7L51a9nDxFtTIL2/4Xfyy/c8S7F9Xem6q
         0ZCHxZWX/bsvAnI24uYoG/OxfIxE32trKz4KFVbch1oXX0aZrHSi4cj4E4LH/OdDVlyj
         XsZRvMRE9gXfHaGC6/hgicRAG3d3PaSFoAc1q9+I2cMsJTJXlGIDwyUD/FlkpmNjhWzk
         +b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344765; x=1784949565;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MZoof7cDAoZkq0M3AxNvmUn9E2JO8aGJgWTXOJFjQo=;
        b=klD04hJXmrGVsSVfUAs9IFOtdWgyyrsY8b/vYsjUKmqe3QrK1fy+GFdaoj9S3yY4iK
         kggxdKWsfS2a3lGsZE8etx6Ij4Bj/bGC0LpRcunlYVO0rKyESJmq3YNkwx+JtkF5OTdh
         rk9nIhajxTa5lkMc6mVxqSm+tquKq/VzevLRG04Rs8aS4PvuRTEKiELX3sZnJ7OPE6MB
         rt8lfGQsn+y6ktf6L2jz9YLnDBC3y8AkL/X2x9JoOSFYE5pl3UF4HVyqQvMSAE6KG84i
         f7RobZOlJF9Rpiy83U2uU9u7KpkKMebRLocOdh1qNfxHi/4iwIjEl7EO3k6Tj8+3iw4D
         NvLw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8rmhVXCZdU8S8B/vDJ9tXLT38GSovDE7ItZpkJ5JlDZ+JvqfrlhI3aa1H/5t+Ym6xNdt0RuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncXDozvwJ3WNppB7URqJ4CL3mcQJ3Fb33ElTWbl1jRluSJE49
	IOjGRHFJEAuRD7POmXfl+GSopW2h4i6sPGxPawE6wA8oMqs3V9uCPUY=
X-Gm-Gg: AfdE7clGifmlLolcgqsJ83ub3esij61QFNcWsoVxjv0n2oOqxUkDIYCmv6HrUpeu7Rn
	kNPlIiAFx3BHJLpUgSH3Go6va9KzQcPR9pjRn6KdUVweN5ox6BnCs1b1LKButmrxKT6wTJT1Sik
	DM2Yz38IuXJCDR/7sObzDbsspvH3C6ZsYQgeRHvvV9e0o+7uxWhMecUzwYC+GzSTKu/mR0ds1BV
	QZQROr6UfkwNyfOHOwWRyhowpRvWIFkuFE550DZS/yw6tEfjh/EFWzXome34n1XfnOWeOYsAPm/
	kzdTNMq1ulywYjud/ZadGg9qO3pl8/Vy9jy8c/3adkUy9mBUbEMttDOThWoY0/gcQXRypWIpoo/
	258943yVH3WWnCoLcvboEui2E1vKYzTGA9bcJfi9cW+0Lkk7aNHBG9M9JX8LuwszdhDkKRoCZxi
	Lqq82BF0kNIYYdXkxYP/n6VS9L+Hk/FcxfVkMhe7uy9vl4I7IXxkUqNg==
X-Received: by 2002:a05:600d:104:b0:493:e49f:1541 with SMTP id 5b1f17b1804b1-4954288e0d9mr81342365e9.6.1784344764453;
        Fri, 17 Jul 2026 20:19:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ae2.dip0.t-ipconnect.de. [91.43.74.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm9529444f8f.27.2026.07.17.20.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 20:19:24 -0700 (PDT)
Message-ID: <34d1572a-b7f2-409a-b681-37c63f37e6f3@googlemail.com>
Date: Sat, 18 Jul 2026 05:19:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/533] 7.1.4-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260717101912.682013354@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260717101912.682013354@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.07.2026 um 12:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
