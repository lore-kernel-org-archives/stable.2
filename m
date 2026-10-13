Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53833A3E7C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933338; cv=none; b=nHeCH42b2O2JOhpzCOd7VpnGlkt9EMFzyhnRZATt1ncYCiIxTsjZ187T2bEh9KORjL7mYRF5hqH1T9Pcs90NTPaulLZFj4lsXGRNSuGMER+ZiIYufrDPg/gVnPPbsNCceN3Iw3MLR0Dtj8zLSt7YLYltlPXW2SRywW2C2zf7ZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933338; c=relaxed/simple;
	bh=bJtFuAfjAsK2013vUx7Og4Fl2Xotxf6AIMZPLzNs+QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U46VgbUyEBQVfzr5xhCRe0lV5FHmvvIXUjcSUNnrZTr1KMXFsf7m20X7K9zZJgxkC4kN0pziRrINg/vRJze0huZtm0H7Rm62wL3DelWktHKvO4VB0sln+WpsZywgEjX3/7aA/wSsdu9INc1vw1tjsuCtLT0X2kaX0uAZyXod93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lx9dK1Fi; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lx9dK1Fi"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f432ac553fso3971556a34.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791933334; x=1792538134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dmwu/a/YbEyOYEh3D24w+BEmPqrGxVIF7pjSO5iEBzs=;
        b=Lx9dK1FiBppAA7ATxu3OT0at4cRsoql7/Fy32S3ayzf5nTSdl6UjaUEGKhrp6GDIm+
         9/sDLn4lv58aBtO39SiU/dZYjHBCt2PkKrRvW9h3l4PapJJE88ZIt0Uq3ZgDsAYRn+ke
         p6jb4oEr3UCF3nF7k1DiHpdxrh0Q6TE16HTeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791933334; x=1792538134;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dmwu/a/YbEyOYEh3D24w+BEmPqrGxVIF7pjSO5iEBzs=;
        b=NN1LLlaV9rWyXJv1AK5h9nFABKgu7puQZuJF/JVeJZfxzqo/chlBGSY0pTm0b+WFFh
         2z4Gd4NrkhwsSDkKOWExZPfQxpy4sZ0Mr+gPRSp3Q/TisopmopN198wGbEFqXSllYZ4g
         0mL8djj6pWFBGaw0fAMrXS32qV9L3ZTPcguQBrETEthFpGZ2TnoUuuUtCQMT/+8gMVLJ
         4tiJtuX+w2gnc3Z1us9xCENAFZXe31RB9VnLiHgZ3/IrzetOJCtcFaPC9MMCAvyG4Nue
         iMRN44ICYot6lBmDq3jh9/PH3FLSlMfBoUia71PQuZCRztHvnakWpCHuv5kdTU/+LY38
         r2GA==
X-Forwarded-Encrypted: i=1; AKwUvBxQvEr32jUPSswO4vc1eRJafVoIxX+cANfOnEqGqJeZ0rHtJaAWbDAmoQgVuNWp9wlRBZWk/Tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCuU044xHZvXW3ihrzDtxI7EkWMsTKQNxNFhs3w67PjYKwg8h2
	fzts7u5vcxzQk5A6IrXi98xEzG0POxAVqVqUYGgW3elu7El/U6REf3hAFoi270TLsr4=
X-Gm-Gg: AYBFou082MmKHx945bTzLUgvDkraD87XU6gAaYnXgcYvmWxmQfws29YCxDdiFdXoOy5
	xqR3ILY9vR55zvW8KeCZaPvBklSzzMdFi6dM5/2qSSYPL1KPqHf4SfUSe000EAV0udDSv4tb6QW
	f9aAQlHi/4yqXXpFje/VsPgL4sxOtAOnOJJ3iHXYph7/gKKQYtMEtuaVUqqT0P8XWl/Sq7Idmi8
	RpI5fNTWat2nQZxQYpr2C52vEOPMJlMg7wWBic7AVOVex7wzr9gHt96NpkCVJ9T35M4fvvo0kgn
	48TaE435AbVUKj44DdHjUSrgjtJkQqGusZ0pv0WGDutU+Qwzwpk3oRE5JTzy6Kiobx1q5bBeMSA
	2q7mTg2/HYqSGfyU9ApJpcksUv7CeG9zRpc7Yya+Pk1qcDpdRDHjv5ciDfqJC/389nL63A4Na32
	KP1Lp+hlMOPXHU1mR1j1EdkmrVaiZaIdUrMIQPXfva9FRNV6Sk5rSa80dJdylJz/RcoGVVoJt0v
	Sf5RmMC
X-Received: by 2002:a05:6830:828a:b0:822:a76e:95a3 with SMTP id 46e09a7af769-8308b71a774mr14023795a34.0.1791933333694;
        Tue, 13 Oct 2026 16:15:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83618a94fb0sm8058530a34.24.2026.10.13.16.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 16:15:32 -0700 (PDT)
Message-ID: <b63c8496-a3b6-454c-914c-1f94b122b4dd@linuxfoundation.org>
Date: Tue, 13 Oct 2026 17:15:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/497] 6.12.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261013112907.864180619@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261013112907.864180619@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 05:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.113 release.
> There are 497 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.113-rc1.gz
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
