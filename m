Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0E370D54
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410518; cv=none; b=R8qgu/DOlmwY7/gNqrAB9JK+BMO+gT3GtCXuFtPVKNLKhvxkHNZqSzIP7L4HK6/fyxXKS+aAPmeG78+t5ut/8DxPWvzYesL+pEnHA67tucrocbAssmpWy/AIzOMFUqItgaTYQEWP4roDU/HTOcWtjo+xEeoafVGHfgq5xFco0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410518; c=relaxed/simple;
	bh=Oc3nAJjpp0QjpjXeocnToBp2SCGQxGodC291S1yGpsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o344OnzH4Cfa20J4ni8VKbxEeSSekfGrdLdekli7vP7hbkt5AUV4JeWFHhNpz21T4/o9IfbzwBBC/iLytb1MbnbvaB7U7oAgdBGhwSx8DMH3x/b/kYrPXWfNdWsDEkUr8aTbeKuPVkyKPm89fmtzUY2SqcImW4/4QsVTk0ySz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HirI/9fp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HirI/9fp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e8e70fa02so46486996d6.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789410515; x=1790015315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXGFxPZOAw9wmXg2dzwPQVLDwdqQiEsc4hGqI92R0HE=;
        b=HirI/9fpT1gBnLbAejD4U4TUTuRwj+w3Mu3k3i7viNWnNZf9xqTLwZCDO9cRZGTvXY
         1hLwizlI8sAVoVPWDfoy1mvT9QgkU02vg2qXGsX3n0J3bp5Lf8c8n/fxwRz8uYvtK19S
         ranxrpjGWsm9lGJp0IUua0sHGp4245uXNfmmx7HF154ZUQI15/pojbM0j25pPuIm9rl7
         5D6F73L3WPiDlTr0S5IVVHpmdOoPM6wrpaGjQcQFklaXhJm0KpSFBI4w84bOZRo0a/p0
         SL/nZjEzq9lZ8Z2vsdmc3Ez4ZNXlrqQuPNzz8WCCMu1yGr4gxXrWLEIYjEuDfIiG7jvU
         mHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789410515; x=1790015315;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXGFxPZOAw9wmXg2dzwPQVLDwdqQiEsc4hGqI92R0HE=;
        b=DNj72gTwzVkFZkuIkQx/ZjMXTbSWQFjnHZ2jEqCDdihaKWpyUm2PTsm0x68KfDwBHH
         9SxgNHPxS7yhS8QPt/Mo1fTGEKL3/CjLAl5tLiGl653FAt94YnpOt/jx5qFP3edrKKRo
         vCsC9pxGwYakdUhiNz/i42liX+yWvsIPx/RNZKWSobPvs86gimsCt0Ysi6c3pst9XXe7
         iDWUbsQMQLQbxeKdzBEAyQGWDT6Ul1ruqxMb9KiX+1+tN6NvynB171u4gB1QQ1trtehi
         pQU4Nuzz+EcZLgi8LYeXvkNXwnGnuYkJVycWGyEqfWoTK5FvU6qJzwKAO2GnL1YpSwVz
         5Rhw==
X-Forwarded-Encrypted: i=1; AKwUvBz8WqORO11KgD/6J/NfibHE3COlV1k0fdkV2UB3kQM51kwOzxjENdqoUZ6PwEOmCtgHHta9lj0=@vger.kernel.org
X-Gm-Message-State: AFuF++lSHKUngao75tr2/51C/46USXbFBftG7FY9NkvhGJaKwtsxMCf0
	udvkz3lYO4JHNu10Ltw0ACX8JlKafZKvuZnCzJt7HnBhTbSe9194vRO3
X-Gm-Gg: AYBFou1I965biAxiCXBOzULUfyhC3m7xyPoRjL3GylKosSSVzPZVesuWbVJiDpYMKWJ
	SMVgBzBibb9LByZ+Rx0IA8bjGFFtBXp5B0tMMP9OkJutxr9+QTvT8AyL8txMZ9ppRI/8Ta/yaHo
	Isqp2SmZ/P7LKfx6hlSxCGCal7R1EQgUB/Fl5vKHUQ8eKtRaQVWgBylejlw7KOhdjjEPmzhFDF/
	dIiFrd347SFnZb1s2NWec9lInhCUiMDuhZVxtiHD9kJIL7WopI4rmiFNpLqairgDRwIwHt3nPTa
	Pfq4tLlsz0lJn5d4xf23U2ZMb61deIY0VQG1biGMmglws65txM++5xZMOdDvoRLQD9a64U/ozM3
	hWD1Bz8JG5x3opakQLK0wAQZogaRmxl/1xi0NtA4U64a5t0D7p7vMwpf88+xmxip2wA9zcsa/G8
	o93EpQVfe2pDxTLOxulG2Z4xcv7LpLxOXyTnyne/Tk4QNFnfDwtmBiZXRXYiwZD+chB856Qr/7h
	+yQZrI9ioctDDCj+6MM/ftY5g==
X-Received: by 2002:a05:620a:2549:b0:939:3571:bb90 with SMTP id af79cd13be357-93a2994242emr542974585a.24.1789410514974;
        Mon, 14 Sep 2026 11:28:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811b572sm1070310985a.47.2026.09.14.11.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:28:34 -0700 (PDT)
Message-ID: <3d3c3a1e-8569-4798-9cac-68c58416064b@gmail.com>
Date: Mon, 14 Sep 2026 11:28:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 0000/1518] 6.18.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065623.398859879@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065623.398859879@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.52 release.
> There are 1518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on arm/arm64/mips with:

   LINK 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/aarch64-unknown-linux-gnu/12.4.0/../../../../aarch64-unknown-linux-gnu/bin/ld: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf-in.o: 
in function `perf_c2c__report':
builtin-c2c.c:(.text+0x420dc): undefined reference to `perf_env__e_machine'
collect2: error: ld returned 1 exit status

that is coming from 629978bc30938bc4929ff6c8b0dbc6fb637ac8f3 ("perf c2c: 
Use perf_env e_machine rather than arch").
-- 
Florian
