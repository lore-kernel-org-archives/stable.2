Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604210;
	b=zxuBGtZWjVfk4rTCxdkZEuem3/inDtGlodT8qo00IgurPDjPt71kyLL+0YcEh6YRt9kG
	 MiGhBQElcIF2b2KDVBg5TpMOl/hZtREThqmdE3Y4CQKoCvzXlyKSCOwPpZQNwbSZ0rv/K
	 YLN0scnycyK0MglsZV+o5rEGd39DBMpdMqw0y5LGNvx+WqEul4RSoJzuh9eOQMwrQtoFc
	 pxLUBVsAI8EuMOXE1ugN4Spq2IBqT1vHzPTxVYJo1l1SfW8/GpiGOFRKSYlslxuQ8a5ce
	 tM8AP/P7gBLhYnfKbZQOp9ppKmVz9pQc6fqH/mhJqbzif3KjF2h0vfKvn8WaTgih7Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UP0VIkxwdkwdfopi/I7Ka3p31rBuKNZ6NklI8tykK3M=;
	b=QlYY2afLzVzKvZIK6XCavRL7jgixgNKni8W6zzpmxP318+ggCwEhk43LmqW4GSra1TEB
	 t7AAXwasUVbhMNLNlH7N4KcTdAIde4PKG2fWWqps0XSQIP/7eeREGz82KZbDDPrbno91S
	 Qf+Bu+J+HsaPzxaP440CCyGa3SajVFhp2iymWPRE8v+cMrvrwv5L3RwZLIHgH1JwHg1ZH
	 7nPwv5sznbQ6Ek/IzAmOcFJhdUD5BCI5/SzK+ZycRaKsc2hqfSMKldKXhudMvUHc05Akb
	 wPlk8CzVKATv0WUiIhtg7NG7jUqUCgafaEMrDzLtyyZbhD/swGWraiu4HW9hpm/roow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ssct7muW;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A294606A882
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A294606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ssct7muW
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so1279237a91.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794604209; x=1795209009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UP0VIkxwdkwdfopi/I7Ka3p31rBuKNZ6NklI8tykK3M=;
        b=Ssct7muWtqu41TdDORIwlGCvJQicZwHvSWsLHQ+31G4vP9JnMKCu2AKxtHKU1ew7Yt
         UnQe91w3zBFdpa6nzBJ0mOyBF7aGhhM8yBNuqSO2TZ3fx4H1Ocv9odM8GDXoGevVvB9H
         zsmMbtW4cV2edkyEkyrSWH+UMUMs8jcFTJEdvDQ9r+RasVoJ+8Uie1GO0rIppCgNyHxG
         L52y+wA3FWpcs6jHZIfEkRfN0geKCvWH3L1nb7ohVrLvyup3QZqGOlNoCMWIdKh5Drab
         9Ga1gaSeDmElWenkjuUhhIX1wx2Fr7PApg6N4tRL+zK5A6v/QfPDvzZvknjKDepXl/0M
         CCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604209; x=1795209009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UP0VIkxwdkwdfopi/I7Ka3p31rBuKNZ6NklI8tykK3M=;
        b=y9IGrazLe3XoPTunyJ5/vKNb3MUxRiuJkLeDmCj15yBrSGjfBJjIwAN+Jo6omSNX5e
         mjv/awk0N0X894kzV0MLNQuQKu00O+2av0qBWSNariRjAPTNqqxoRQqOSqajqW3rNBhD
         eM+SO7UUwHcpdMqkEHNBzHj4EobO3YBUhgRjX6oP4V7yayHLfA4AZbhTY/FGIU1F2MNU
         k7DOM85WpH7D+eXdayIi+ZAx3w5qW/W3XiRqpqbBzd/XhC0YYQzO8OcyXQSsVaFXjIFw
         4isOCgJ2amf7B9/E8Ju28BdhayAM4GMzRYWSk3ZAQlIk3N70eSZAehLAzgsKz04k2oYg
         a2EA==
X-Forwarded-Encrypted: i=1; AL+hErH2v6V5y6hn+mvWqW1VfWnYHNEJ+43jJ50FfpwTlXw9U21QsVJyRc82FKPUCnxppIWwf6d+4ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tSS9Vokif2o7J2jCpbpSFOPFw+t69JfW+TCpl0eAviPVv71Zm
	GiOLC4QP+n6/5yIMNyfUDtyo2fEHpeomn05YRUGsmEqk4a91Sh5sQ/fU
X-Gm-Gg: AYBFou0XOjq80PnuxiLd0F4g38JhtAwA2AbuBffObywT2tDFJZlW7dfxWGvTpPy3Toz
	8DdNXeUhGu2Iny5fVUPMDf8MEUQCF66mfSCc3pX2UuXWy0qkK6hxsbC787qEIlivLoP6ogTaKS4
	kg2Wzdui74nmRhPUtluXKjBwdJ1P3Ui6jQaPBnqhCQjCVDLt3TfT16mjdLM+CGfDJ7nwyd4aO/Z
	W/2ProcG4+WJ1pytT6TGNo1+h4FQ3QklGdSey75YxvE3u4nHnjdblbyjNUiN4Vm6AALnQ8SHchG
	vjIVfOg04LyETu6FS2+knApQ8SX1UXYH1GKNVHImUTCV/sJRl98K/g9CeaktvJ3nkWB+MzHgQAf
	qJixVFRZkEF8r5Zov+yslcNo2fqe3rfGPAEfzrfN1blN6rIcUrSwn/YGDrVszPzfY+qRHcyj9wT
	myB5/u4aALzzn/Hjqr5AZMD505KChsg6uNNSSJJ5OgtMLv78wUYpgMCvjoBmnU0Ag+87d1d2ZRY
	fpc4TQqzBnsUXnyS4OQj3pzQNjfQt/HaI1d6Z4+GHn2X8yDqCUP2zEN2AqiRyfs+grCoxyes4XN
	howm3+AWi0ZhHsgch3julesdEp6GLQWEpdwu8btRgxZiL9woz65UJLW1
X-Received: by 2002:a17:90b:4a:b0:3a7:bb1d:3688 with SMTP id 98e67ed59e1d1-3b1b0a0db47mr3267098a91.27.1794604209023;
        Fri, 13 Nov 2026 13:10:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm11082549a91.1.2026.11.13.13.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:10:08 -0800 (PST)
Message-ID: <41448f6c-347c-4dbe-bbf6-d9429c7f1608@gmail.com>
Date: Fri, 13 Nov 2026 13:10:06 -0800
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
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261113153753.358973689@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
