Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE485012A7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667317; cv=none; b=e3h5m9jN8HOyVH5vjjR+D9K15hfjyoqFjxA9NRNeYgkXFmoxKoqXIomncXMxBkytzO1OY9/I0dL1dVo2oMyDhljVM+B3EjcK8peCfZNhThr1ng3X3omyjgEVCpmv1Nv4OEpgkYfQnNCaXvGeLFsJL5F9J5NAXo2ag2pAZ819A0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667317; c=relaxed/simple;
	bh=tG+fI11akea3wSt6NDDMVs1aLWaYurwM1JJh6xLITCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPItC2jsDEb9qvIIw8qv6RT46BAIAyzbfjPkXmOsV2m42+JN12iDQhfyD8hbXepWwbJHuww9e+/E+3YgxpXobCT1ecqbJRPJunBEZ09n/2oNbIYRR6WV9/7W+gsNoJAX6mW8W5GAMOcGXwYKLFnrfTjeS/0WISQWJwCz+l6i6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9iZImR6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9iZImR6"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so870680a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667315; x=1790272115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WJglaSlo/017XuHFl5nKEZgkW9Nb7XN1yne3AQp+sI=;
        b=P9iZImR6XdsBbAa5VZvsJAQcpyTa8BDdjhaifHnNq0lzZAC0sgMNYBCQeMeFdYbaw+
         ywgqaM7uuEa1938pKEF0XsxtzinhQlk9pDjdElpnACz9A5Dsf5z6R7q8Eklv68b52UAf
         Nz7F7sQtS+G9FeJl+HZXt3f0tybAT/dHP4XLYdEG2tZ8Avvrn205LoEGjAdX3L85eN06
         x5hNBUwvdsJ6QRaFd2rLarS3aTaHlwAwxWVPu2uiwhHBAW249DpnkC0MEABs8DjxJ7Yo
         g6c7F1YG9GLz0L/0IzVAhpuQSlogV+QQwD+JXASiwHY9LtFYM2JBotRo3HIAFLOE2XNn
         DudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667315; x=1790272115;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WJglaSlo/017XuHFl5nKEZgkW9Nb7XN1yne3AQp+sI=;
        b=qkpBXM1r6Tvh3zY9fX34QEe6KALq68rUMlee9l0YryReMi/0h5Tov0SaaP3vNHreFj
         mZ/kWoWKwV8qwBW7sZFenryz4/zCdNWSlwuxnxQ8D+fZzniLz1GACxFNUVEAruxpDin5
         LxCzssEvMU7wlzzR+9SS06jxZsmhpLxJgl4hi+mHe/ESS2dsa6zdI4YTYW5ET+WYHabY
         l1o7o+JY1J+q3VTKAKIByi8d2jnAzqTz1kZFesLYmyJiDfy7vUTDRXAWjs/o9SlXURS5
         HwNwgLwCHXtGz/vEUvWoWiLBSj1Y3iDx4ZZ39cswi/X6W24RG/g3rK4R2AQPih92W11G
         875w==
X-Forwarded-Encrypted: i=1; AKwUvBwE2xSy3DTpYEZdW+SC07lid/RUycDLdrUfBybWb2TkwKAwzt6uQvmVts0FY1d+jMhO3VWQH74=@vger.kernel.org
X-Gm-Message-State: AFuF++nqbA8nkci51Vf++P2Mgh9Q+k+5+geOH+5KqD5JYrG0VIHfUjBw
	4a0bGd0CBHOWaH7NySYu5ShG3dL+hArQTxvoj3ExaQFfqIp0VcSJra+k
X-Gm-Gg: AYBFou3+gKG7EdkhK4I9zGPaoIf8bvkRHReuuBNogaHRzbRzK5+BKMGM8eUvxPHT8Ys
	d0yQX6RSykSOcKconZImvmacdmAJKeIuLRQlc+Vv3TTSZNkr9dZ6PFmrciGRn7Z/QYmGO3YA0tQ
	StEc+UJN+z+KzsV6seDQLGDq5dvJ/zB7Dq5/Nj2pEC8qbX7jAhyTlHZJRi4uLyZitKcf1C1d+F5
	Ct9/hrnp7byaA0vnGnYJ/aIOFSFBsU7PcRb6mWJO67WHzcHsOZypaclk9D30HMafAQHWPGD918/
	/MQJpKp/stymfI57paLwBScxfpc3unbNdGp2ZnteAfFmf4vNZNzHbVNSiir2EwUt04G8Upi88h+
	jmar+P0Cp41AeeRhICcMJcmZA2KIpmTEr2aUErWLAydp4pKuLDw2qta+cpf9mXNvdw0MQ25s/QH
	9G5aVsIT0hcip/rLujgsKZgj8ZqFSZnDkot7ZaPbItBRfG/TFCgktt39qA2L5QFxK5x2MnHHRUX
	HhpqnS9uOjnPu3E5pg0VVrFaw==
X-Received: by 2002:a17:90b:5383:b0:39e:4c80:f682 with SMTP id 98e67ed59e1d1-39e4c80f749mr2185907a91.33.1789667315218;
        Thu, 17 Sep 2026 10:48:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5bac3sm129238a91.2.2026.09.17.10.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:48:33 -0700 (PDT)
Message-ID: <6145337f-5350-489f-a5da-84cd1079ac78@gmail.com>
Date: Thu, 17 Sep 2026 10:48:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1250] 6.18.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260917151551.901433442@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260917151551.901433442@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 07:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.53 release.
> There are 1250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Sep 2026 15:13:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
