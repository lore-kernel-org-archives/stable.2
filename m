Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512856;
	b=Dj6hLUlLn2hOUXEPI30J1ch2msSwRkY/YEQJ442oUIGhrdeOk+OMaAEPQXyBGAusJhlN
	 JDtoxQptO7MEu2mZ2gERxGXwx3z3E++qKQIy7xHjAnI4X3zNSeBoNml4YAQgPbLCiZD4o
	 UgEX7+swhe7hUeBIduPBhCKVAQ6S68VWDLPl1zgaKsL3nmnkbIFOGYn4uWoa6fCKJGEZC
	 Ixl30Iv/8CZCvBoDIDWpeJrxORitlymU3Y5NV2oydeYbAEZ06/lRgxV9ksP1yGQiu0+j/
	 CLdVUCnaTvr5GqgKD3Aa2Teu6bppVmmMfD2yIYxFQY9DkX4whWmE05TUmXvVtCxC1Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xt96S1I6XPaPhNALy29UZt5PAba3qn+cljeyrpTAfAE=;
	b=FW1hZsI1lbqbIixfQQE5T0yBl5N1LBmvg4oktkxpED2QIw0MczhvNbT+lveyDgq7aQC7
	 hLUhz5TjFkQatKFiVlZw6urV1XR0xhMTHPCpkIRTzC28q82H3qb4jwl6DpSY1Xq3CrV/b
	 yOaqUKwRPUW2sbFPPoC93ucjAk2G3eZp5tZ8asXZoRi1qG60PrvP6oD0iWfygR55gOgJU
	 W7LuOpVEhcw2CyA1v/1F2Mi/AgeF0Xm7s7nZJLwlK2c0ZkRUPTFDB1FMty9Mgmsgq0/lD
	 RhPRhY4WlzCyPWDVo3wqjJjZRK23O4VjclZKOzK0S4X1bzwMGL0du++NRN2+QBb2Sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nZpRGDLu;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37849606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37849606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nZpRGDLu
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo1435853eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512855; x=1793117655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xt96S1I6XPaPhNALy29UZt5PAba3qn+cljeyrpTAfAE=;
        b=nZpRGDLuYrx6n2LxYzusW6X+h3lJ+Z2IfIjRyA4hEfFto+z9G3XPJdS7ccx0epdGy7
         s2pPIDK4tCsCvoVfvzt7C1i80OSOP8TuMMwEmDvieeurPAU+Mm5nbGo32cUO0GbObNB6
         W7oMvPoFDmN1sl9K7xA56LqDh5rycotP39IzGxrC+DTCCnFgPI0zw+UVKDTUNLGXZDS0
         NLbr/G7hm6Uu0DTVqrbCuL/zHmlMQzL0m0bqlKqaXN2sIiX2tsah3bobca8Pc2KzUKhU
         D1LmHzmAmFcZxtYoC3tTS3m11t2wnwjdWmP9IYSi2dm0oyxz1goInrGlxQj4qgxfwSzu
         8PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512855; x=1793117655;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xt96S1I6XPaPhNALy29UZt5PAba3qn+cljeyrpTAfAE=;
        b=0gCOsVtmAHxZYqpZoeEuIhFpWi+Wnl2HAwI41b/7Sg0MkebXnQQQgumiWiccMHD/hk
         ilTzqtTVV0ECgf6FsS2R7SOoxz3VMsXzdo9QiGIzXTsTNsokG/r87Amx1l/aiM7z0g18
         3dHGYQjolA3O2AlPK1Xnw6Rz5aIr8sWvdaGGuOZm2nokTnh0ZvvK/hJWoIohtaDBz6KV
         t5u3ec6YkZVuOWoe5waJIO5WJqHcr8tSYYD6BeoCC4ZEnRXftY05cqfDf3SZXMElY2qK
         UwX/iS4HoNWRRggoMFD2HDjMNlTr3ElKgvAVYJjqkNLnWUo9RnTDEYrjcc8EPTNnXjk5
         kiag==
X-Forwarded-Encrypted: i=1; AKwUvBwonXwV6aeL2HBIkAv/tM1DhI2V8+nrIFwMCOuIAbSYcGmmmC73i3PNrpl6QwmIu9VnowgJC3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOcY8qV50cckF9gGvSkhZFjvcBFCQzQN+rFYbI6WrpaKuRoOIC
	BCRf/MUfMghE8h/wmdJV9NFdfuD0PC1BJirjfe0Pcl9LZP7cG0VMaBdv
X-Gm-Gg: AYBFou3rrF40pRgFrRzH2ri9pex7/LNncvQFfaiha6d8rlSRmTTNuraCzjRmk1a9z9M
	O/QB6/4pKw9gz9zFF/b/Ut5cVaLHmBxegl7UatCs5mwDu2ZFSt2hSFz+jmcoFa4yZvsJDRIjAfW
	bmyQ7Gc3hj/4qnOZFcU5VvLRqy73lEnrtaIUxRocPzqbi0dPFmLC+0FjJIHEokHOBhsKaRq9QRh
	CePjznv1cu361NtXJ8rTUyqm/tNP7HqKb9ropmu3YNCveclo+IJ2OUWM+zQ2apO+ygw8sJ9gOqN
	x6vO0TZEmStVXrhLrm36DRG2K3UidixWLza3dtx12mk1LrCGyDMVc6JDumSMfDtpNiKPv4QKZ6s
	BoSLAK/L0pG0QXwPv0dsq30m3fUj18n7d1vQigEJ+bUH+8wuMvxG+nreS35q5dpVatLssc/394G
	+wUaNVue1jc7edx/I3tvx6TQtK7pIUP23tXiNPrwtAEvCJuzSaNJuD38AeVlXrn05SzY74gmY3/
	i3iPoW7jn6nKUH5a1AJC5wbR2Sqyg6ZL/M=
X-Received: by 2002:a05:7022:eb57:10b0:185:5a96:ef59 with SMTP id a92af1059eb24-1855a96efc0mr16486562c88.34.1792512855102;
        Tue, 20 Oct 2026 09:14:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm51060355c88.16.2026.10.20.09.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:14:10 -0700 (PDT)
Message-ID: <beac545f-9a17-4a47-a4cd-7a705302a35c@gmail.com>
Date: Tue, 20 Oct 2026 09:14:08 -0700
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
Subject: Re: [PATCH 6.6 0000/1651] 6.6.160-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261020075535.084584701@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261020075535.084584701@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 00:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Oct 2026 07:53:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.160-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf build issues are fixed, however we now we get the MIPS kernel to 
fail building with:

arch/mips/kernel/ftrace.c: In function 'ftrace_dyn_arch_init_insns':
arch/mips/kernel/ftrace.c:62:6: error: implicit declaration of function 
'uasm_in_compat_space_p'; did you mean 'uasm_i_dsra_safe'? 
[-Werror=implicit-function-declaration]
   if (uasm_in_compat_space_p(MCOUNT_ADDR)) {
       ^~~~~~~~~~~~~~~~~~~~~~
       uasm_i_dsra_safe
cc1: some warnings being treated as errors

-- 
Florian
