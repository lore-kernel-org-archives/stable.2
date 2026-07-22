Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90346416842
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739971; cv=none; b=TAsHHJUuVC4lw7eNZJzpd5TmD0y9wTMjZyG28RXeX9OBiWQkCmtVgZdLuvO22C8ebX7p/MVheXF40WG2WgmfEagznwPIJnnmoLxtNc/2eWHTdP2GTfxdWxjHTCtfX0NcyV7YzcJG4okkDaDNcqDAnt8yJy4S6Sk7tt+Py0BSmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739971; c=relaxed/simple;
	bh=PhHY5OapL17Z9SnPRBE0Knm7qcuY9mOc0SLNq/JjaTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SchPigaPl74SI2r37I5RSOxSBUl3j/wS9wex9W9VEi/TCJAlz5V5kKwRQmmwWKrETy1NmK2mNZI7PSYBv9+8TqdDLJZQ33fEmF4VCGT96f88gSq0mPWTk0pR61r22qWwkrCELQ+7dyLOu44WLJvftBXNaefeEoSZWfujz1Pc0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MsWM5xFa; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MsWM5xFa"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6b554044fso9949523a34.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784739967; x=1785344767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZSO8OvxTDLN5UFyY7dc60tHnurAXrxnY1hLSFHH3LI=;
        b=MsWM5xFaj24yNJTBP7hZXb/Iu2FdXNzRFROGk7GniHrFMtkSxyDUlIc/dHljpoaWeq
         kNW1sux+G4sNg2BqJf89mM+g3Yupt7UCXZXFzOj/IOdpDKVvrnIR0LoqVrc0IADFIa3D
         f4VkZ2rEisW/gZqGI6Ca2CYb6elpdj5+ZiLgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739967; x=1785344767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZSO8OvxTDLN5UFyY7dc60tHnurAXrxnY1hLSFHH3LI=;
        b=JA5dqILTVeJP4OJnZ9uVULUx5kGn2VwKRekhWRQOMlPH6v/u9GiVENxhAnjTGuVvgV
         Ai5Cznh0y1l+Wt7yletrb+hbnXPf7EiqDV12b156ariNciNn3M9TjfAj5epTdijLRxDh
         4h48VBCksy6r0W4TNyTEwC0FzqOJs6B9BPxdygVxrLsyLR/YBst3fHHdG+LDsZ1K5ywk
         gHpHe2s7K51CZRw4P+LQk1qRUWw4YSXdg7v629F3PH+uaP/wQz4EP4sLF7pEPP7Aoihv
         IkJEzXvjGOlAldFN7ZMwfGpssPBK93sX7XVlQDRoA5pG6o3qM//guY8u3okV014E3w4o
         btHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6xIZ6dGddNgfdkM4Xq6Fo2UFU5Q/zMJldjKxlKZVMomfGnicHGyp55HwB1QZd6T7ASBhJyXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygtCxAKKBq6p1OwVCAbGwpP9YIjfm4T4VqApL+vhoQY1wabZ0X
	WPDrNUR5IGyIm6SGtTFut3x0qdMPBvmT3ubXkEaqTqPf6hRyERWBItasaWNoBXDZ4YIcQfnOrPk
	HXo5xOR4=
X-Gm-Gg: AR+sD13yX2PsVKpwLveJdCJRGEc7/Euia7khsFhBFsruUnrL+A2abDdEVff76216X9r
	Zh5+DJ5ijY1a8HCz9B/LTJQqlHvz/s3GphREcxOms0B+kRabV2UK8uEO77B4hFYPPmqMxHgcpKe
	g7OSbl2Gywj89GXTETNHcf/DFhLWGtDIUuyiDGHfgXbmoEsWMY1ZsRzoQwbTNt9v01veqEWj0xc
	p5x5MysoePqOIfwIcUqJj3ZENUkjSvHKEPorKyMOPND0JrlNUxfRysxya+WOidYYWFjM31CC0lf
	S6iWCP0QhpDV1nAtQCSdbJnm7THZVA6bdaV3WjTiXP9XrEV5Ln/cRxm3MM3HL2TK4rN01vrNjJx
	1pVwNTPFFD0lSvyp5GJHe+5h1vW8xaeJ+q6GgA20jdL/bp7MhHsSXe4FR+X9o1DLS+MY47vU4yi
	5jMy7hgOhZc1Nd9FPGQCiwpA==
X-Received: by 2002:a05:6830:4195:b0:7e9:d3aa:e391 with SMTP id 46e09a7af769-7ed9aa5776fmr12393314a34.6.1784739967396;
        Wed, 22 Jul 2026 10:06:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0b0fbfsm1714272a34.23.2026.07.22.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:06:06 -0700 (PDT)
Message-ID: <4eaee968-0944-4f58-b642-017cf19c95c2@linuxfoundation.org>
Date: Wed, 22 Jul 2026 11:06:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1276] 6.12.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260721152446.065700225@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260721152446.065700225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.97-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
