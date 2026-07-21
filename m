Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E913314D05
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651734; cv=none; b=gA/4Bo4TvnZRuW/YGdQjdCFbQhCrIT+NixD1J+mO5a3C8yEOh+f9889s2pdwJh/ZrR7RuNNPOgK9c54BdHRjYxgDNFjWZbS8ieju2ILRnZ4ny2BvUvqlFY94QqmolL2szdYAn/bQ8Qr/bGs7he+QnMyCMMTcueqEwaypoPE+HQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651734; c=relaxed/simple;
	bh=BtQTtCtTSpbowSHyQsXFphn7z4W725woAyiCJc/xTJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PucvUf1qofWANw448mP7uKstiE0G5NB31RybB3lshJHcqxHkmU7e3w9DtnQ2o3hzIsKZVDxuYiFAd0vUUtkzDmeIopbKUz6mzT7H+RDdcfKTRUypgD7zgwgGf5ZUCpKj3Dg32CuJWQXzJLXfTM0sCFiswMzCS3rG67FYn2xPo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO7Z1oex; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO7Z1oex"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso8302122a91.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651732; x=1785256532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuhxLdZkUAzj+3fp5sM4PbGIsm6IR7y62dQzuPnM91s=;
        b=VO7Z1oexlpZY6VxuFGsKS6aqhfXB8bTPyNbxsMmkWkEsmA2eELv5rGoTX65XyECm+K
         57PiL6nxDb0/0aFm/Hj+d7JJIlhXLMweCp6TuoX3087hRwWfRF0O91Hmx54RcaYlCQpO
         5UoQxbivQwdirYowBb2g88dFINTf62Mi+xn6Cu7jmlvdO36p+15SPDFoFamvREAOIhqi
         PFx/oGBfzpYCOUCWPURyiWE02wadPx3IO9G8PpD/oCi0FYXRZuGVp46tpOkuCDlyH11B
         NY+y2ig52I4SfSRiVZl6vtQytUbhIgZwKMJkGJgpo7qiwRd/ML1gScUCCX/HNuAHOLhS
         r4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651732; x=1785256532;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuhxLdZkUAzj+3fp5sM4PbGIsm6IR7y62dQzuPnM91s=;
        b=OYvNjjDRIWdRi4AuHATgqYZN4V0xRGAOSe6MIFhS+ih6U6HA8Wh7tQa4/7o5Bf5iCl
         tL81LGXIAieAz/Nq+Hf/ISPwdwQDx0xdRyIQB6xcAqcO/qujWIG14kxpnOjjz9IORsc/
         awBCoM/gIs/57xJRhMWSpZBd/4Hii4Eynwpe43nxVF0SKz9ZXHsNdVoLtVYY5jCbVO1g
         xDM6z0sG/PlIxSaKsteaJZ6vaAKCqEe8p7VbGnMMZXhIxJ9Y6WNo1WsKGPkeQSE7B829
         q1Bt3ax2ad5o1p1etHhwaIkqIybZiBjSgd7OpNsnR/8f+XTOd8FOc5HyTy+qX2mvF8nz
         WQJA==
X-Forwarded-Encrypted: i=1; AHgh+RpeJCN2p1eWoxGgduCJgKaNYF5Ti4G0W28qfy2Qg5lRLZgbQo5CAlZ24tHxwQ1qF0FfP1Rog44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadxBHGcm7AHp41L3gzQiKaghQ1NYQ3IC08Ns5rL9EkJy+4fKG
	PBPpCqtrc7SQK80zLtrIN9333S8oEmsMW+RUGr0hFtOBQ+0FBiqWdQWN
X-Gm-Gg: AR+sD13EcDGLQdjONk8eZgygvWAI0oQDMaRKwSN+DS9LNT760TRLLcl4+Mov1QygNst
	1/KWJrPNc94JXpn3ctTokMhXSM9pyAlivEr9WNqMch1tAKLa5hj12bD5EhFk5+1ayGXx5dO/IWE
	wDdl5YzQVCKYjLmkM/6cWY0DuJjOIdY8tGOAkUYEQcuI3D4m2TJrC5abeGpLdMZIR0ZFgltJEFD
	xrHt2kFL5yhik1x+vvg+nadwrnT8Rqc6NiXdzu/ca1z4YrUQ0eAwY5DtqvS2Is0Wvdvf8ybbUwc
	jG52f58gSfr9zMDMPfrK0D3EZPo/q60UUvbDFYH0JRoOFDpfXw0UP6m45aEE1w6MooFvMz6/R6K
	40OEqnYnC7IaN87prcbnQ7Mewv7CNGwXM78cN1BugQG6bzU8oeoTomJE6VRv1fF97zT3aqnqd49
	BgMXebCzfWtsrISPYNIY5eqtVUbOW1
X-Received: by 2002:a17:90b:5806:b0:381:f7a:2e0d with SMTP id 98e67ed59e1d1-38e4b585280mr18042303a91.33.1784651732574;
        Tue, 21 Jul 2026 09:35:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm41304921c88.10.2026.07.21.09.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:35:31 -0700 (PDT)
Message-ID: <245b6733-128b-487a-bbe6-d4e6ec4c3490@gmail.com>
Date: Tue, 21 Jul 2026 09:35:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/843] 5.15.212-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152405.946368001@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152405.946368001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.212 release.
> There are 843 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.212-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same "perf" build issue with 5.15.212-rc1 here with the following signature:

   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/symbol_fprintf.o
util/event.c: In function 'machine__resolve':
util/event.c:700:32: warning: implicit declaration of function 
'perf_env__get_cpu_topology'; did you mean 
'perf_env__read_cpu_topology_map'? [-Wimplicit-function-declaration]
   700 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                perf_env__read_cpu_topology_map
util/event.c:700:83: warning: excess elements in struct initializer
   700 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       | 
                   ^~
util/event.c:700:83: note: (near initialization for '(anonymous)')
util/event.c:700:81: error: invalid use of undefined type 'struct perf_cpu'
   700 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       | 
                 ^
   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/color_config.o
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/event.o] 
Error 1
make[6]: *** Waiting for unfinished jobs....

-- 
Florian
