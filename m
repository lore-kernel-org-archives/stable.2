Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030561;
	b=IU071i7NXUXiswuTpFRtBv2xRr617XqkwLxyUuAt0EkPscfXW5eKzb9qS6rShSSf7YoV
	 7LIaKg0oxqLgWtT9+Mtkay4WveHvJupoQEXODKPEW7xuzebUH/JdumMDZIYDeFia3TgNN
	 /ctMZYQk77gX40ojmz6UFUXIMISw6MdAldlGZc/LOnbRql24E1utk1UnBMjHZT4EUb5FM
	 bJd8DIWLP5fabxHxti5ZFSWaqqG3mxgwDNwHtTWrTfKhPow09Dy7QzqgHSeO6D9Px3mT7
	 Mnbj6RPxKTjdQDeQ6r+gterCZndG4XCw6luCM/X9brvtCn90yCp1a7XH3+GmcgLg1iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FaD+0SeebjIC4CSZLUfCZ0AvJts8laW/iFN7jyexdUM=;
	b=QfpdGe3lIXLx8q2uX/xSKsIrT/ghfcPat6u4rFMruWMKepOVJVR1LZsCjlohk/IK4FUi
	 RMwBcX1LGYmJ/S+AkqS2ST2QF+KGXyy8O9PwAcq6dBMV/66/ZN6v9cNDlpKCnUXMlMVK8
	 V4+C6tDJ86JGqdkRXYaHVRVDZeJ5jKoX5NOGcJYdQS1/HBvz+UUOXLzAltVKK8MBUh0ie
	 mjnMhflkPybeIZKxD+WEGWI9i8Bn7DfwkQZUjQRyNI0tn2WSw8mFWjrnmpQvxmphyyCgD
	 bKadVzu8nwfF/uI18AIBD5GKU5V+e8GN+ozc0IzhC1/kMbcNBg/0PA1kDBX+wc3XpJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYPXnquU;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E3606DD01
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267E3606DD01
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYPXnquU
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9ae391a05so1235105ad.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795030560; x=1795635360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaD+0SeebjIC4CSZLUfCZ0AvJts8laW/iFN7jyexdUM=;
        b=kYPXnquUCmratLJzwuFZAJLfDgSmUPOTLC44bUIBwapTOSBlxTz5Fk1ydYuppv1rV4
         r3dyBRF0B0g0KFWyZ4uPmC/n8kERdQcCDnvS3gtxs+/hnCKBpdzZLPZDOwPkn5KBmb3D
         Bz/Y3YuBWgTtc+OqeESnOo0m4lm8sqn2fSMQoPAvpNVySaVE8ywqcxJLxZLWnnVAJpJY
         0W5S5h+ga0+oncpxAYTRxuP07gHHdkENpphWzrXzy7j0NTDWUorooDpzMjj8m6c7V5mE
         qVSMo4gIg/1RxCVzQelq/suUH1hmlnxf3UrX8g9Va+fLPZXJvxWhiQ+ZMXf6GszyagNL
         6wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030560; x=1795635360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaD+0SeebjIC4CSZLUfCZ0AvJts8laW/iFN7jyexdUM=;
        b=juu9MLHn443phTkuLiXW1cJrhxOGAmZ+9F3L+8heluQK5KPL0qQdcUTG61IMMFbGKu
         BkamcVDbN/S1mcbEaAbONe3+EQCgBW/kbisYVPLb+CHiUkI4MJ0ywJjXXIBp0WNyayIu
         TTFtBWhjn+KJeYAs77ftUKgNziwsWEUOaEzmn1ZjV8TSYz44plDqmzKQpikpRJ0a9b6m
         hpvmRTxXKCdS4KNdPhzgTXWT5xVzpi5Xk4SoUJ53UUsPS9cNUA8VpBVJpaLEA3ogWE47
         jfIZmJdSZcl66OdARQMLzGtzxJJx+fs+LajdJLt0jEOCHV3emn30+Howje2ZrLF5F7Uv
         TytA==
X-Forwarded-Encrypted: i=1; AL+hErFmjMmNUFw6ZVy9ivNS2OjeySAWUjWjlfH0Jr1ooy05CdUk0UCQ6iPGy0b3OBB1eZdHrpDtLYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9REeOu+D8MYG7kp3hE88aO+7HmevapYTO6n5X0SlZtHWqdnCZd
	pdLy04vMZTokKLpmuXmPUKDxrVkPiOdecpFou4IgY7Fao0//z0u6CwgE
X-Gm-Gg: AZFdTZeEAvKb3dzTv6N/mLkCdcP3TxTv1bBBvIJfzSbc0pdgXX2IYugqk/ZxbE2goeO
	b1RdPe7wD6TwbUf/KNRWoVyjoCSQxIwmJRLGMCbpt8FeylSFUrJipEj9EZVHQFsWk5O714RDvKh
	dlPzmkXi3vgGY7BJcXftY4M9olAA+XelikGNNByJm7wIZBEksfnGtn6WmlLzdlkqCC18nTXqb6B
	DaC+l3eOn6j0YPcUTQzcRoKabq7O4FNO8wKrMoJHE6344O0DayYsJVXt4dvto/E0nVAD4+hnlF8
	lWG9b5NYWEFI1mcsD6x7NusBeeiYvhaCaq5OcWC+hV+8QcnevtT8udxrz9pFBEjHwWP6NjEYe8V
	v7enasvCgyYHb82BuMdkj4hvVQ8RPb5xB/CZrzV74QYZtmeoBHOs4mzyswIwLuZZImUDtU5lniO
	amH5W0PiaRgJz2IY4W6DeyJfjyFq5MiBmjgB3zlqU7PlH+vKIqntSkYVu8SqQbpKRFraUSltiHq
	qUDFWwB9silv2lXp80o2QiQ0zD4lzDjVx9iRmnirEIAhBcQwmaHJIYPqX9liHVM1IHn6Q1Fu398
	W+gjEdb+cQvCM2r2TaFSxbjATwc91VN/Y/LLM8MxugAJ/pAo5wLJlF5O
X-Received: by 2002:a17:902:d584:b0:2ef:fb60:ca47 with SMTP id d9443c01a7336-2f019883e9emr2883795ad.35.1795030560257;
        Wed, 18 Nov 2026 11:36:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff61162dcsm18553935ad.18.2026.11.18.11.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:35:59 -0800 (PST)
Message-ID: <abf15e9d-6317-41a1-b43a-188905ff3888@gmail.com>
Date: Wed, 18 Nov 2026 11:35:58 -0800
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150201.293410965@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150201.293410965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:17, Greg Kroah-Hartman wrote:
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

perf fails to build the same way the 5.15 kernel does:

/local/users/fainelli/buildroot/output/arm/host/bin/arm-linux-ld: 
warning: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/arch/perf-in.o: 
requires executable stack (because the .note.GNU-stack section is 
executable)
   LD 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/libbpf/staticobjs/libbpf-in.o
   LINK 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/libbpf/libbpf.a
   LINK 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_branch_stack':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:397: 
undefined reference to `__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:399: 
undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:400: 
undefined reference to `evsel__put'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `test_truncated_swapped_raw':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:445: 
undefined reference to `__evsel__parse_sample'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:447: 
undefined reference to `perf_sample__exit'
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/tests/sample-parsing.c:448: 
undefined reference to `evsel__put'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:675: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1
make[3]: *** [Makefile.perf:240: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [package/pkg-generic.mk:286: 
/local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built] 
Error 2
make: *** [Makefile:29: _all] Error 2
ERROR: Build failed for 6.1-rc on arm with code 2

-- 
Florian
