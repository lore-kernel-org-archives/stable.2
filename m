Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103362;
	b=JnBN/Dm8ZVUqlcvtFrBhkN9HUkF+9JdvH/JldoA/M5eSrbhxMGzLRbHTzhyTQEWCiZzZ
	 pzoPFvZ3sHbDmm/8+7V60aBe44lhOkQAQ9XjzPZfmDAgFUuso+2Opd5SkIPm5T5CjHwpn
	 WQ4NdB6UD81JGELByikPwHZinyin7L8rwBFbqEf17z54N0L/MGGPWZdRNFtKw4qsFySb8
	 PMinVZ8HtOSAc36xbyax9kT9LswiaPTDgDjZWF6a8H2bDYGa05pGij5Cm46WN/vEt2xdp
	 FxnpAcGoDAR/DBOFU09CZP9YCEL3erRJJS0i1bU+ghr2X6CstdlAJJ3kvQVup1aQLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hk2c+8OJP384F/Pb0yBXsyfMijwUYkaY/vzOTmpbXDc=;
	b=VsEYoAuyBFuBcvB4VDVNx+mY3ZmG1nj+CcczLUjiU8U6q1cDV+V7gzF3doHhP68PjYc5
	 gXz82VSs6i37dxkbW+mBF3bSNtN2wVGdc5dTv9ve4MGlQ4sqsngKF3FvnNMzvnunVibJB
	 Tzs8DYhFhWuyMIR1bqsbWRZaXICG805MMmcdUu9jg9Fkk5qD0hVfzelkBcySrw0wuTi4l
	 FU6mTaH/coEqaXOX8i7o9vvHZ4G88b8VwqRVOYdkqpEh0Mp8pi7fQiWhVJN4TiK8cHCka
	 3syvW4p1EIwC4XbGvkt+G4OzGw0pLzDD2S2xh/1qKIAUpRHeeV48lMhSEDNm4/3vZqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ZUe0VrC6;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE7606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECE7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ZUe0VrC6
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-702dedeb70dso1546682eaf.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795103360; x=1795708160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hk2c+8OJP384F/Pb0yBXsyfMijwUYkaY/vzOTmpbXDc=;
        b=ZUe0VrC6hiGYdi3lQJwT0/Tzv3RAG1g5hO6VKrGsYTjzygbGIYW2qKWQLBvjZEko2N
         rY7B0/ETmwth6elzWp0zFe2lXWxgGu5KHMuEuuq7AO/6IfoY8w1NZpl919nYx3xNyw0x
         PWgoTTdpohB8BZE4x2Gs1sCB7Q9ewXVpWpCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103360; x=1795708160;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hk2c+8OJP384F/Pb0yBXsyfMijwUYkaY/vzOTmpbXDc=;
        b=cFr/Dmaw6uz/YqeAALSknwAokS/jKGJcWpuO2YoURfghopQ2gso9wiO+P6ULaB8wmj
         w1f/uH5CPd2YDg0uqVblmawh4JWKtBnlRv5TTZE311NEDFbEpgf7rRqkUnOWVXMDd1aB
         zty94dpju03sAFdfRNlUy7VpfieM8BtcALUSbjmBd6qfe+uNdt1OQ1sCwHMgSeDQq8dv
         N7EInMYhe8yaLC13IjeUSwmP1c27MY32JuyL/ZA8Mo1iBHegJVuE6dMhtM3fUjyqvbsO
         1kxauLNfmHujl/yiEWsSBtYvAjz1XD1sfWnEWviwFOoFnRUvYvv6/Ify6wC3DMwUrnsf
         UPqA==
X-Forwarded-Encrypted: i=1; AL+hErES62j8fq3+3vbHqxcu43FO6iKgx06qykZ6MzbpPPxQevINH2T+q5MZQ8LetnXrGREpYYElUx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KOMyvOSJ/1TOIolBXnGacXkj9UwCNnRRg1WxIxphJhueZVQW6
	upxgCtT412DaOrunblzAYxnapoL4CtpOu9uv68YP50whqLu06aNVUBWfy7gcW8clkg8=
X-Gm-Gg: AYBFou12HpvyvyNI832xtB4kUGTNJ27tn5Ks5z/g3xtCbpGzGzp9Cvxwo3AWxtYmg0P
	FQBltnWPPlad5dWWfl9YbKEnDhnslURzM4Rsby+b0m6uYChmHnCUpCldiTByzkkftk603KV8vrv
	XoXIyt0Af9pjC8F872GRGEEewFGLQFjECmhhtTSSqiTkIv4rn+r3CoZmqpQI+RgFyK35a/A4kpD
	L1fPb4BynQ9EZT9ORQQwr37Gp47Lo4T8K7K5tnUmSm2NEa5I93sHdkHKg+reQYJ9uQmOJl6dB+k
	eHV6Hl8Kaz2TC9YNLH6fUZFK/YncjtCqPLJbdFi5cjpq/Hw2flsqh+pKLAT4wst3vYpNn6qKDEz
	GYg/RgdAOixc9+9FtDKwf8YIpwk1q/zSrrgNqzbw6HWEgNl4FHqtKibqWNW+dL4oDJuNpKvh681
	4H0Kb3O0WMfaNiuDRwHbqZsHJF9/eNTzyQ5+8hLSiiOpZ4zMgrn6hBmLMHnQv0hb/ao0C+cdiqE
	qjrBj7X6EcU5ycxSrxDN4mO665Hxb+J06Fu/OzLjCeZoUyqEvKIbWKotYvwSuEi6LjsuxvIUgG5
	M1KXS8d3zOUXF4JuzS4YwyKlWuCN3vqya7F6pYzxZ76vDyCZCRI8zlm6OxQ=
X-Received: by 2002:a05:6808:c3d2:b0:53b:87e5:8c9a with SMTP id 5614622812f47-57a09c0fa5dmr312083b6e.17.1795103360052;
        Thu, 19 Nov 2026 07:49:20 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777a8a5b65sm4386296b6e.8.2026.11.19.07.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:49:19 -0800 (PST)
Message-ID: <2fc421df-33b5-4a8f-9de6-4504ac4d73ff@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:49:16 -0700
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
Subject: Re: [PATCH 6.1 0000/2857] 6.1.193-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150201.293410965@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150201.293410965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.193 release.
> There are 2857 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.193-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
