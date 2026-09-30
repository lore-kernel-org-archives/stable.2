Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA84DA9D2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802816; cv=none; b=dd7dm7mPH+VRRAoJNep/9MLGUWqNdYtswnmVUDaJ8+dyDvTiR0KkACd8O31hZvkU/0JSy7z+9gLmlEBf7NRJbntJWq1phbDd/dA13oh5Z5SqMLjgaw83Nvkk0wYAFIHqO1qRjZSrgPS7pIsVEj/YksqoKG/P6PrDUhur7R5VSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802816; c=relaxed/simple;
	bh=o4a0qUdaCSeRTwNJi1IOPcOPxBAbrFqAapS0BQWB/no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2XV/ss5y/7dhXM6JI3QP5keuzg4p6Ndvg18vKfwGeE+ESgMSn3EheOk7lHtz7r0iHpCsgzFOR+pJScwoTnk3FnPBTxkGDjL9t3P98qmhQnExXsivRxywo2/7lyPDughUNckO9FdAWql+aQb7kyEYC+ppsjeM07oOtSDuc2e/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUo0tNMR; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUo0tNMR"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3115c4451c8so200048eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790802813; x=1791407613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP935/Mgxo94G/ukIIaM0Nv0lGPr7XbT3BTHdxiOkHE=;
        b=lUo0tNMRObaU895AFRkXtuGJoCIEZSZJGQUjQnVtA6TLQEtUYRm4VMDaqLxGPWJTks
         rXjWz0Rbjh8cDZzXuOgUQxdIAkZf62evLE45Y3c6hnQXW3APVt8B9sArSbpKFsBvuOwb
         FR+ZJ45EvXKil0DKTVoTWRrwKk2zMNiguJirmxN+UAnn9i7QkvSEg3w+xGpu3+TMongr
         MT01hwuir8fYg8ioVUPx+nUar62gj3CdjioKgLiIoQ++eD7tanWymKTWZ+1bxxlrkSxY
         bf5NnLOgBPo5gO7tx84ygHLAaHrpzfp3J3Tbgn9yEvZC+rUohx54LSCIsoutIARSsuVY
         U+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802813; x=1791407613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SP935/Mgxo94G/ukIIaM0Nv0lGPr7XbT3BTHdxiOkHE=;
        b=auOtvfscGljgEVEOX5nQqfojGrJeNBsQ+grwVCs9YmE+KOJ51A9DE7Y38bmeS2W1oh
         JXw6qzPc5b8Q/6CsezvMxq1hLt7tRgmRsHA8JvpXhYpieit8brl5Dx7Ii4/oFbOMyOEu
         BD40m1KGs3vX7td+I5YJT+M5bpODzzT6U8IbusQEQUOxtarf/TqRnDwObh5ovGeWHfU0
         yDFzbYucyrTkWPkjQ2N6tpda31jbsRnNbsQn1GKriohukEjnTkKYXUbpmbHRLE3iyDPg
         JDZjuoP5VSEp532pNDFoj3I0b0QeHGBLIfjlcB6ChIO6NyzryGNyZ3Vbcn+JZUXaLpE1
         AApg==
X-Forwarded-Encrypted: i=1; AKwUvBwlKhZElcoyc1PsR07x5p+S6FjD5FLtZvd/kaRefBgs0/eDcaQZ1t9i01eGgcZ0PWf1IeQpv3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEEXvCtsb6TLEBBCwwRo2uJOufS/tIp70w7fUdOZ/EVPJNLvFE
	SYKPkh82yPdQ1hkU/wU3UeF3c9XCqI6Cin2Yj7eEWy66m8O1aJKFn4pb
X-Gm-Gg: AYBFou12pQFtD9vonClh1Cb+n173GG8lKVuIse7HnSBmZlQOml7UJQLNunjwGyUkzmk
	L4me/zmQBiKXx07CpzPHkxsajGUweLsQSxpKmLEl1JhH/GxHoOykLW6FCWhRY1M96WuczUVCwf4
	rq4b5JsY3gp1OzmxnLgUB4Qqh8aE8wlaybRqOwlWlFz/0Q3Sq0NxKpsG2Lq+6xB720QWoBB1TD3
	NdPzJKq3BJNqj3EdJbTPOYJr02tA1OD+A2ES5lPm68dCBpxeVnz9Ke+UFealfgqeuv+UxRCHbrm
	gnU8HganM6WJsm1BrxUtiw5wWoegQbuUodcBUBlMLH5732cC8+UvDjpr564luB03KjhdR8SUSY8
	qXZuE8R+L6UeKRU+i6P1MnuxPKsKhWVs92Y6PIMsl5BJKLykdiJZUEe1DIs1xIRVX4p4QM+16+m
	6s+gftMpH0U2foJSNSp+o38ssUKI0X8uhQOXLPUFhzWovC8XC+57J+9W1+7TYmYP1lMbGxNJEm4
	Ym0DbY7TAgFqaAw0ez7D+cSFnm1u7mN8f0cYNI=
X-Received: by 2002:a05:7300:f282:b0:341:6bbe:b9d6 with SMTP id 5a478bee46e88-34db13785b1mr695867eec.1.1790802812513;
        Wed, 30 Sep 2026 14:13:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db31623b6sm1428918eec.7.2026.09.30.14.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 14:13:31 -0700 (PDT)
Message-ID: <4e73ef22-ee24-42ab-8e24-5f6d911bc5f8@gmail.com>
Date: Wed, 30 Sep 2026 14:13:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/395] 6.18.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152340.591469096@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260930152340.591469096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.55 release.
> There are 395 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.55-rc1.gz
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

