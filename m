Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288405;
	b=E7HH+KljJjo1DeYMbSfK3pjGNYDXNNBvrbuB8y1RxuNoDiERL/CkLH2WQ+3cIPk6p5Kp
	 EUax+xI0OkmtP1iwOUxcAecNgUnnbc1NYjk97otPRga7uVKYQ3JUlIqd4OAp1SMX3W4Nu
	 Elha9MKwphHLZ3VglV9/f6XMbFqeEFKVZqKBTXAk0sSjXmGTZKFuAP1amRHhcDfPLR8P8
	 xlND+m8drBq8RIr6IPuR3txR7fHjrXWl6cn/MK4kK8tipz5FfiBOUGBkEyRQxEo6Eb7bx
	 iYuqHpINqM4f6A4hL5rCbdkoGEJVqXcaFCktRW30a5x1FdNXNwPmof+V7uwQo/r4CqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=p3YvkGpbJ75egK6OsWORSXS1tksyIAY2QOnekRB2s34=;
	b=WpN9BKHbnIPQASmFhfjq+0YvB9MPp5fUqNc20zXhVp0rZ7mYYG+p6VIec0nhOeXz+n67
	 QdzS1RuFuOkEiFCgy9ZuXGpevGXQUowHefG52FM+p1iOI6MJv/283bnJHkSIHX4yQ8Pge
	 5EJU9OAcWSF7NUHK+1pU1y72aJHl8mEi1opyqpFmKHNs4yxOGn50AwmUHsp+SzfClfTVD
	 DDhflSznzX4saTmu8RnefXYupKhmONnwOIkl+9tBCUP6frP3QoEhD4Gyl1F3PtQ36krvc
	 B2UGG6uSdijR20yXhme7oCCclom7P4towIPxGn5sWqZN6PSSBIe9TpJX2RqTZRpCu+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=SlnaW63b;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF530606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF530606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=SlnaW63b
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8446af403b5so1421532a34.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793288402; x=1793893202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3YvkGpbJ75egK6OsWORSXS1tksyIAY2QOnekRB2s34=;
        b=SlnaW63b7+BWoAx43Ve1PjR43XZ3s03l14lqyvTO69cYQC4gmjK8QAj+ZP35BkhjaY
         Z0L/5zN94AxTa63hC9be9zBDjvzCCijanGOYYT7pjjC2TwkKz4QR5aZzt7pvknhHVdM9
         at/93Zy5JiM5YRV6AGqg6G35glnr1wMZY4E/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288402; x=1793893202;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p3YvkGpbJ75egK6OsWORSXS1tksyIAY2QOnekRB2s34=;
        b=KuEAtkQaxvjlFvLZbjWhEKfktSTddn6sffaSzW8yOJLwr09dAK5d2MolBJWYfmUHVs
         euXfO4D5dQ7lIfpruvdA3yMy+Cz90Ia1CR4NaO87sUXLrSucVxxcGfgWH27ANNJAzveP
         KaLGnmJugwRexmuliwxDxOKb6C/Hha/sZMv4DNeArFAbOewetZIdOrzwhEC/Rj4CgTiy
         ftx/bkCMLUWv/LVmlqXhT7uHnTsLImwDhejKIA3y4osiX5FoQD8h4O2qnyPINmFxcSij
         cSvQO8x155X6oId3LkzJgUNRM77F0hJDmdGe+E4jp5b7J1sHyo1lu+vDSK3Lwv9RZm0f
         +Ltw==
X-Forwarded-Encrypted: i=1; AKwUvBwnmjg0Ky/MH93atqFL18P1odM7uiUaWRQ1D5TeivVHi52SgGH3r4cdesldm8+AS2xZnhZpHl8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkxWCdyXqAQgFrapvLwsH40F7fogLxxAtSjvYGnT3KTlK/QPRD
	XM6YYYeOuOq+QIMZjI/k2ZSmY89hJFCjzd/nCN4jrC7VvIx1+LpeVsBEXtmayy3IzsM=
X-Gm-Gg: AYBFou11P5bAqIx3ScOWGND9YiEsHS6vJdv+vIE4HwBjYp2EMJqsXYkurS9SicVChld
	OfQXeL4kDnIBEmThhVINYw4XFCvsC/QQ0gj61fvLx5H3DSLPbVfDmzfvKmU8GW+S783sk5wxnpq
	73yw1WQAoYmWYimU9liNjspNzXQNbfYssfUcNMANQqRVkgixsOuDQwnqFK/ForOMIJibFctVDDN
	5zgvUVpSHZsp4WWNHkaix59UQ6NqcFbNB8mCJRKNTzir9ONgiBcfSZSKTxyKEQgt6tE9uOFw2T9
	B99GAIPTdEde9/fUBg0gLjUAP4xP5E//IeJgAPm2/zgGJB3PtpSuB6zTKKE/HLjlA28Tcix3dwE
	WCbZCuABitTPvigV+SeT0HSaY463lIpjWpN3N8IaO32rghZ36s1Zw1G9XKfm1Qd+OSeQqsf9tqX
	rVA9XdpSRxrqvUx8rV1WLQwUVwfB8PNs71kRQ9AB1+Wwb7tM/dql80qXcbIk4sNVG/jjMXz8dDC
	mTJr2Q9lXW3il3mPCxINz/fjJVRFTL8tchPqz1S0LplfPyn05LTtM5hxxdBnOwcxc9vjpPZJ/YJ
	bhoJ0+U4kSeWEj5pFkT+26hsEMVMhexQVsY+LOZZxSWOV1BqEhNLx9kZ0f4=
X-Received: by 2002:a05:6830:b16:b0:845:3cfe:601 with SMTP id 46e09a7af769-85ab2504c5bmr5675751a34.0.1793288402519;
        Thu, 29 Oct 2026 08:40:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33e3696dsm135839a34.1.2026.10.29.08.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:40:01 -0700 (PDT)
Message-ID: <c0500cba-eb48-4421-82ec-b276b1c9453e@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:39:55 -0600
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
Subject: Re: [PATCH 5.15 000/571] 5.15.224-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028170008.009143722@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028170008.009143722@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.224 release.
> There are 571 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.224-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
