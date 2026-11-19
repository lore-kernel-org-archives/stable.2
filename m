Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102654;
	b=cUGSH181JVPOizcCkg69nHfyKqVP5z+NvOXvfmvO/wd+KcaCY5Okoe4lXK4jDM5SRbF4
	 m8doWc1wqje3Uk0fb5ElAulgauBhyO4ffSMUUXH6WaphjdiOS/20l22B2SzAw0//T3WbL
	 /PK1xsplpZYrWMrYz4X6+89Be8NQjt13tTzFnVeMGMcR871iiSri4YWl7yIprZdJp6vNQ
	 YCXoWqKpAV2slS2OyQ/phpr0DQabJDpZTMtAjbUEeJ6KY6AANWcqTFgHLkgZapgm5Iyfu
	 +ShS/3Fr0X+hj2EWvCRGyjdDA/SEH1nfyPS5Z8z5D7tJ2zTB3jUoNeg9GSwbQ8pv5YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TO+8nrTIMWn71QJShuf5TRZeIr14Js9cHAmW6jrwfig=;
	b=BtIKIX3Xz3z3yiObZG+UTh2v55odJrCsC7ETWPAVfUCnPJtDkjDujA5lyc9hxq8aFWqn
	 /WYNqCtkRb7Th4ldR065FBHrhtSUAe+tOSVyT4kwSaMrbLlBBXZBabUS5Rb+mZvUR/7im
	 a/g687P3d0nCz5BNMNP+HJjmnPkZoN35dTOv273r4ogsny0jQcUPyCTQN8Mfoji4JYBgo
	 41nYeASz/JHtti9YorfsIY98aZoud8Hy5jnMC8vJ3BRETzatkvGfwabqch2foei/32jX/
	 zh60TH1XJ+gqk4QAd/u5/W/0rqBNvAxigs33Ic0r8ZQet4pzPzSoJ4NR6cEdhDTjchg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fwdSly5b;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCE606A33F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CCE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fwdSly5b
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-705cb6ceebaso1904565eaf.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795102650; x=1795707450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TO+8nrTIMWn71QJShuf5TRZeIr14Js9cHAmW6jrwfig=;
        b=fwdSly5bIER4CrWfimn464C1b2RNV7NPEgd26N5vO6efQMYFpRNiXHNiXdZO/HHA5t
         UmpD4jGipvU61bdPSvQPUZtXOXiNFCRC71JkDEUqCPTcRnjO50Lipz73F63aXwqiDowj
         v7QLciiFTd6Yas7zduuiDCkuD0jnn02gyJzsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102650; x=1795707450;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TO+8nrTIMWn71QJShuf5TRZeIr14Js9cHAmW6jrwfig=;
        b=HG2LqSg2ev6VN16YECbpVQPbxWW0odmdlr+SPe7kewqRQgatZ/w6uA22lv5dn4mR9h
         lsZpZALxFAaITjYjUJKH9U5LjZrNJtmz/NgcKjQSGYJRwvcJhX80upVW5090+/OiqZSm
         jLBvQEVpKmJk+HhBvI2y9Se9XElnQEa9sUnqQUjFmRcXnqQMxmScHz+seGuyXcNjMMYH
         J4LG06iMaps3SgCRth5Wdsz6ZaQ/BYT3yt+lQFhdKE0d0wnl0Xt09H5YGPH/SMB1K221
         uhA0+r7xK2PAvT1xDlKtnaDt8KgEoq/yBRdS9peFFyCwxlbCCOsi+0IlO3a8qWUAy59r
         KSgA==
X-Forwarded-Encrypted: i=1; AL+hErGRNKtblzT7yM6/9IaTVAC8BvojnGpF8lc9Xf6lJ7kHijSQDS4gheTy6sLTHgMRAXnaixU9DgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XxQw3iysEGGuXswQImtSIizUyg9DzDqoycSFQnLPPu+Y6x8l2
	SZtDVNjix8s2ukjOIUrUxlvtGq3GZdhkfATUe7mE//6j8+/2Tn7wBkRgYqf2miYoQrs=
X-Gm-Gg: AYBFou2209RD6jLgC2bsNQhmy/x4bPXWteu2iawUp6KVOKsI+tcEdshu454pjl56GR/
	97BKF9QzIzhgYNdbHhq5TwXLDOXxVJsNdl+x+DdX3OcYnaYK/J8QvfQULsEVomoE2hb09wkgHKS
	E7GdAkRIl3RIJpgDWjFKEuJEYxbPYU7aMxMJOlN2VPoiyjcZNyR1/rMwudNb+3IG7ba7mChR1cF
	jXo4SaNn2tKvYEH8rA6aGQNbA7AzGz1DtdfismlyeoQec/gaG8pqieti3dJ4Slg7HkCue0bYb2Z
	ny8mCOYCqUVAhYweRXlQzm2iQcrmhl6XGbWnE1YuCWjnFDppR5rOsxgCbyE9di6clo+QjXrVN2F
	h7yzxBOAQW459B8AGZtnZK1ffyTFCRfWjl78mylJNtQNeJdJiuXOypP5F/1U4wNhcAOHFK1973i
	DmpUhDfe2OqNGFB5pg7MBaprg/w51DdwTPJiLiYpY5yfYaAEs9oLzpBRxVbxmeGzEFmUqjp/mWN
	ngXPMBKnCd6yCJgI4kpt3PJlK0DWE8j6MunFjnXqbPQzFp/8N3FRrab89vorAe9+S0s2ZYdRrhT
	KP4xRZpGeiVAew64ACZwQvnGJ9RCNMk87Ci3Vw==
X-Received: by 2002:a05:6820:f025:b0:71a:ed81:a2e4 with SMTP id 006d021491bc7-71b18293191mr5288368eaf.12.1795102649706;
        Thu, 19 Nov 2026 07:37:29 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01f71d6sm5008625a34.11.2026.11.19.07.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:37:29 -0800 (PST)
Message-ID: <0d95318d-d9b3-4732-99cc-ed9c96c20b36@linuxfoundation.org>
Date: Thu, 19 Nov 2026 08:37:24 -0700
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
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261118150247.972732815@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 07:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
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
