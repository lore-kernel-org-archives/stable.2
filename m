Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790909;
	b=v+7zFFs/yGXTDJI3O9jFUeUT9nOauvml94jrRXCBC2rAJzsX56xLppsTQ6hrV0Z2V/XV
	 tfbMi4tG3lKZGq6dj8emz9D9Jo0FDmDWlPMEiOSYXwosPqBPHTSbugOZpPaQfQOcn0FOg
	 Khr33+mcaFcqVoV/lA6cNK7Dok21iTn80o5RwMuDWXF02VV32144XxnsQGAONQcYxe77V
	 fW4SYLJb9vLXo6b5OjTXUsjFZJN0tIU0MJOUw7wRpaUAYzqWwcmRyypE+H5okbHylcQS3
	 pqsqCM1NtKuq82zP5R1C4J97ROaLF1EKHzRcJi9Ae4mBGNKlO5Bb23iglx5OoE+JmrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=exTyhi+p6FLosAtSIlBuccnoi48symIvLRodBYfafn8=;
	b=lK0xqJwrAeMm4FCagG2dvRSXJmBsh5ZzQ2gTRY9iZBf9t5cEH0skwO0rADGlPPhqWA3v
	 3IGtFRellvr1g+sNPMPtIIV0mt2a1ago2iUVQWdl1zMVo56BvWF0SLiRF+ZzSb+CYBM0P
	 hSxoAB41zs0YJ+Tb042WYW/RkZh/eyyXkQwprWqzptOPWoNY8totB8yinVPp8+7tf8rPR
	 b2rYYyyRIZM8ESoOOF2poAOeCHSc+SW33rI5+Me5xhsPjlBSxuJKxsYk62QnKi8yH2WGi
	 khrSKnt0oD2DuBO1bdhQRsw3j+EjwJEktNnfSZKSF8nxHwCZQoYUhhsKce0kMzRpIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RIZz1Qjm;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FC606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 21:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A54FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RIZz1Qjm
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5366463571cso13657811cf.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790907; x=1793395707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exTyhi+p6FLosAtSIlBuccnoi48symIvLRodBYfafn8=;
        b=RIZz1Qjmk10fIdkgzwkJRcomIo7yExgzdo6BsvW3muJbljRQjRgZkiEIPIWJScqNWu
         U5AKvYzVz9GZiYZh7NM/oYDfIor4zjwW98JNlD73HKIcUp2isUiNMeuySrZwQzCF+g6J
         C/7q03P9eC6lYQD0eOFIP3ttbzK+mjTpZsnpFB72Oc5PFWuUwl6KEMPtDdaCdsyty+1l
         NUNOrhSqNibqKLxVPa0lH3L+GmGgxFTSN5Z0zGMIM7PgwYIys3F8jMN3hrRtejlKZRUb
         1VmJlnHyxeJ+lOYESROIXa+LifC/iceRliizXUibV/jAqStWfp4z3yVY4r+td1uB/Xt6
         3BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790907; x=1793395707;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exTyhi+p6FLosAtSIlBuccnoi48symIvLRodBYfafn8=;
        b=LN/ALmou7b9r79X+fXAzeGZN8WPPIEN3ag77yM1+zMkLzswPk96ggrmEvqWJ38jIio
         5uZ+ISEsHPWb1c+ULBLxXYsgANg4XtKOUBLmZRO8yxEk2wqYHd5pVOG2c3YgzzLHywix
         JKfMh2+XeQbOmoHOsuaOcntCgardp4YClz7UCe7d3ru6QS19slLT9QZIeDSTK5wWCowf
         7SK1du+z/4UEVrBeEiTY6QNSG4rGTBEXC5dxL+86L9E8zOi667eOOfc5u4jCmZMmW3aM
         v9XWEusCw5kxQ+lnk9HKQxZZGHUoGmJo52w1aeBjoSlXkcC0AbcEt68sp30pswf6AZU/
         FeRg==
X-Forwarded-Encrypted: i=1; AKwUvBza/e3RA6QUdBDxjAO3wmm0kceHObfwuGrhrY3R81ZaR4hJb/kE3rRcAGuKMolRWUf/wOMIA6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLp0plR5Xun0ltdQxzsE84BJtGXMaFoBdUhxQW+RjRAvRIX0SYh
	V3Vu9WpOygnGqBuUHepz+qOZflO5HXSN2gQaESYymWb5KGmZ1qbSq8kJ
X-Gm-Gg: AYBFou2LzZGjDOmq03e/qoCoXL4nXwA7hxfNyR7Ch4bZJAvwzck4gcZ7mhMtGtB7MJX
	lvMrEb1JI/q5oo7sFBDvn2juQGxEnSqqkDreGCkT4ak/ai0VCU9Q1rC+RLpjmAVK6pheFojrMWg
	/iUsMEFa6c4TKL1CHYSuTut7JqmjD6EjZplZr6ImnLZrFqz3gWNaGnY+v4Kr+uO3jQTVGynd30s
	ldli0aqF6qzDUoHoZ6hhgvDEtmFOQICs0tvTpnMefW/O6fpWK2syf1ENHnEIVw/pdoZwVOXTVJ0
	InvGoNc+TvfC0/kro0qdGcii6kIpc9eq7fJysrHjjfiyirkQKX/ZArfBPh1186CwRD6kU9CGMCn
	NFIUVmPkZQ1cjNME19aZ31+ZFO5gsuU3j7NPB4SnBr55QzMxoJ0RTLNdzNgP8kTffV6tuJ5CeJI
	vq4VEgTHcQsATL6l5rLFQqZM1iaZrnfxo2sJT5+eZMWtCXTJuXE2Lnx/m2WUi1lz2EACmkqJVZR
	vn1bP1y6FnsiGzpkPeoA0p4uJo58PXJUbUCzCaGZqoIutdZlw7QvDkOGbqIUbQaATtre+/q6G2i
	56lgwc8=
X-Received: by 2002:ac8:5a44:0:b0:536:6c87:ebd7 with SMTP id d75a77b69052e-5383b741db3mr1986071cf.69.1792790907516;
        Fri, 23 Oct 2026 14:28:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cb85f3sm4781676d6.36.2026.10.23.14.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 14:28:26 -0700 (PDT)
Message-ID: <b79c26ec-5da6-4292-a72d-6ea3298ab7df@gmail.com>
Date: Fri, 23 Oct 2026 14:28:22 -0700
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
Subject: Re: [PATCH 6.18 000/193] 6.18.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261023163714.201276352@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261023163714.201276352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 09:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.59 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 25 Oct 2026 16:36:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.59-rc1.gz
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
