Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6FE44F56D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113440; cv=none; b=uEiwVazV4iFoFnV7o+tWHD8fmJWQotkHtjdi0QcXYoJW0CGGH+h8bEFxvoj9zM8+dhH/DsmO3OMPxUbTA62Yn9mJHvK0zzI2RgmXszdyNxQOJC91IO35LcH7BRyNXuEh6PdFAb5OtXx5ONq3NX+QMJJibBT9AG3R40adHj9cnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113440; c=relaxed/simple;
	bh=x7ObKTZ2HTGus/JCQNOFi9VSB9tl7CEINYbybbpc+gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkZdL8LRI6ZhK3vOGACe2XUH9ENko60oAwhvtsD0Aug7a4sDO6OGo3W3cGHnXIv0vGe4+MjyMoBwnTjaGkRu7HM8cr53KhmMbhv0aorn+geUBjnMGYQmqjelam6Sk6Gl1a9YrX522s8NCAp+O2/0H8eU/GkdPYRJZZ6XxPnIERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d77uMhKN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d77uMhKN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so4711545e9.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789113437; x=1789718237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XDpaAa1elq+LYiq/gSdOwz8vvhdeP7/6a2iuH9Wx1YY=;
        b=d77uMhKNwFNnsV4hTjjlsPDg6xuc67TAX8nfDvmrVIWW1aDH1Awr2Rrqh4j21mwIev
         qCC6KfRe7RHdHTUqS/oMZySvGCJqJfGkdcZN0RHADu/96CKRTSzDIkyjf54SgfFHQHZq
         5PAC79FQfuiVTxDV/NIkjxhh7i6g4QtAVzq6mRQdtC81q1Yf7jvWeXwUtA/95NlLy90r
         ZKxHdM+JVDWyDUe7aoWW20rvrqyXpGZoUPXARFcb756O29Qdf7vYpmPA4UtZKTCBnFAb
         NM8eqQ7/aqg03EIE4PTyTSwZG5V1hROzSOLGYiebs5ffjXAqgd889YQ4+9JqCJkdNFEi
         sKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789113437; x=1789718237;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDpaAa1elq+LYiq/gSdOwz8vvhdeP7/6a2iuH9Wx1YY=;
        b=jJb832tiGs7V5YssdzMSIiibCqbPJRC8Vz2zHHh5L5jLsWRBR8VMoAwgEIZN9ecAnj
         QN8Qz+UgHoBHQrhgBGrHfDMDu3usrpGOyW2v8/BY0+QJ6eaPmXxpPxy5NDy2QLS1FJQJ
         4jY0IZeb51a8y2qHJb1gRH4Pm0//9BkNz5HcWZ0jWblv/b6O4Olvth7IXD3rwBPoTnFX
         gRYsZwcPuU7Gq+A7nvCXfBXtAkrRHzveAUb5UB3VjAB5BS9RSkTd9OsybZ9rl/6HGWd7
         DkxjzITac7FnjvnYRc9rbHeuAaUZR6wnX6Vx49bG9OC1icHSOvH3Fx9m13Bz5ZITnIgd
         MCRg==
X-Forwarded-Encrypted: i=1; AKwUvByrAd4TwpvNEzAWxWGV7sdPIGhTSh71BL/6Cgh8nxbnxbyq4XCmu68Kx8x83qIBz43ZdmuDJyA=@vger.kernel.org
X-Gm-Message-State: AFuF++nzkh+2aG5TIjYps7f6TYkOFtW2wsv24TaD1rl4WMnRbukYdf88
	R6PTarF3M3EbjQqfXm3irjq6fvPZCPkjN4TmmNXYhRxls37otJCl7rk=
X-Gm-Gg: AYBFou2CfumKvjczs3d9MGi1vEG5xQ6RtnYM4LN2PnF6/ubMMugk11SVrM058XgRUWB
	8e7aeVfw4djzwqS5MskyNSAP6iJTDpqthyf4/EHtBPqJ/KODETLcecUBelLRlF7+Y4NgAYwmtVR
	fovf14ZeElx6G8YpTPkvBLZ4Tq8Ta1bZdPk1xdtkuDL6FZ1D7IfgFgwfkAQ/mMYudgrRcyEWJYx
	HivV0OCYvy4HoDSk5GjSwqQAVYIz9eeE5T0bceOzM0svWHyNZuEsm8mEPuWNuO0SW9k2IZ5bmyy
	fDyTnsnFYqXXj2ZLQmbbCmzOIGCC3cuppicku93Q1J8nqQtrIB4jdzEGQsU6mpd0vciTxvgv3Yh
	A0AJeuK51opw2mO0oyF3W82O4yfPHkQj5tNmQiRMYVwZWCca4OiUDm2z7comnumMh5MfB9SDBxP
	D6EZbV5MG2A9k7EWd0MA0QQkFcO3NhAsUlP+RmtyE7SYmn8ZvHGDEFrRbRlhSKbrLWo0QMojjXv
	bKGtj3wO/xHAmbYqqtYYiJJ3b7Zj24G8owkuV5oNpdYYQDIx/E=
X-Received: by 2002:a05:600c:1c21:b0:49e:663c:c69e with SMTP id 5b1f17b1804b1-49e663cc8bamr5307935e9.24.1789113436464;
        Fri, 11 Sep 2026 00:57:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace69.dip0.t-ipconnect.de. [91.42.206.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfc1sm158082945e9.4.2026.09.11.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 00:57:16 -0700 (PDT)
Message-ID: <de4d3fcd-6459-4a8c-bb56-741b05b10198@googlemail.com>
Date: Fri, 11 Sep 2026 09:57:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/583] 6.18.51-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260909134237.773280130@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260909134237.773280130@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.09.2026 um 15:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.51 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
