Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288963;
	b=p9lUAbdOTTvnhl2HkrNXZ2XLYHi5w4cjZ11T8o4Uq43IAb6PGHHIuSSIOconJIpzVB/J
	 Pwl4merOr1vDsHsMPL/gd968nHR8HNKZsHJ06cXoWuOmjtAZAEdEVQAeFQquG4Y2Hc13n
	 YmSF/FHRV1VHvZpfhNooWjJYxGGfM0Vwyo8DGygUOaCsP4iUomjrbAxbl4GPBmp2UGKpe
	 uhQd9WgJz9khAlokki8LXw7zbDAFDuuZi8sGTnzeb93QoI8hvIjSl+kAiMhX9tnjkLDcP
	 xNw+ztJSUHNlquwtq0Obu5+n4Dgnxj42St1UXgM2G5JyWGzVm51XjgdtfAWX5teyQng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1mYqy5pFZp/YjwQ418cYL4aRVqdhlhILAmwm+pURJOo=;
	b=ZEN1haSZC5UdVP2N3eu+spyhOUDGgCTAYjY5+dl9DLR5BEMof6m0psOKb4MkVa+l13IF
	 cRC9rRI+UIQgW6oecgpuPgw+dCAAgGOQHvYZMlvXahzWHATB7COUmh95bqO8KYAojFROC
	 xTT+XznAYU6rEbjfOphrcYq3J8hOI6RopY2vJqj1GnkXCm7Cb71XBzyUE/CmA9yAyrJ6p
	 Flyl0SF1PSkpUgI0vFvHmWTanhAeOMprjE9KVj9NBPf2D8TPWNAqowGHO+kJpjmEcKSD/
	 7PTGwUk8HgfiERAqWoBUc+ewxpotQ/E+tOgSo/mALnFi/RBckjBVbd4I5Ii3N9HHeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=VWaImjhn;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BE606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=VWaImjhn
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930c0f9c1b1so229532585a.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793288961; x=1793893761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mYqy5pFZp/YjwQ418cYL4aRVqdhlhILAmwm+pURJOo=;
        b=VWaImjhnVBNEbB6kSI/8OwmBW8LVjOuB7IKDleICrC/UtwM8Rlp1NLjZajzwo0d9I8
         CKszUOJsoD0/CjgTC68fv61ht4uAGN+zxvnmUx+bB++ItR7gYG3JSWCXT1414IDaHyMp
         9uy715MnFj3mwG5vwy1K5Ma9Vk+lhLjV50tE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288961; x=1793893761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1mYqy5pFZp/YjwQ418cYL4aRVqdhlhILAmwm+pURJOo=;
        b=EOUqqGY5dSbr1HGqvjwngN6htAi/hTOl5c5z/Pnuhnvz1q8aclOP8xusM/Wv05aWFE
         WoBsUTynY5Ce+pfzxGBBUOYFLIyqisIKnXWp2fJ+sxr+MWmgnLhCEOJfYf8Di9RvoxpW
         xXsmTFetAXI5m/h4Vl6xq2s+JvZoXBGJOIgrKP1SRddrTWX490gTTF+FJ/sAXCS65FXl
         WHsQ9IC01L4u37bYMqcMxBmA70yNvo4ASYpDglqm0CHJOSc/L42Nrb5t3RJcwhoaOw3p
         9yPWiOL+j5QH6YlVolX6MgFLoDRf0vap449MWFk0WSFW+gxDtF8M6IJkTJwCqelZSTOT
         sZHg==
X-Forwarded-Encrypted: i=1; AKwUvBwqx1oRdmNC+VVQ86aYtqsiyUo7xc96TWZWZ9r+k3Lg5PjuWQZ9+GGFTWJhwxBMA3/xdnYnPws=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMeOjbmdbgXbAwjaH2yglBkdso4Tm5XxxHIARCrwYOGG9jy7NF
	BSaNNHW8nVDD+satqtyPPWbyAuP4ulZvsi6O0oZdsbITFagGGXJu2g2Tbspkmt6w8wk=
X-Gm-Gg: AYBFou2P6wW58THo6DJ4+zpObILEhgaKC96n/0ODpMDslSj9etkRzbh8S0WuIOcluIu
	eKZzYCQcBABMIpIl/ZZvSoTIQN/R0TAJA9PbBOg3mvvriyj5M6+axtvmPpL1bTYxBBa0P9wJNbW
	bRg2Dt8k/W1L+MOTsYCS9dRIHysIQK5Y/Jg1po1fnJal+qrWB+3CkL9iUd5bYQ75VQvu71RQXg1
	dM8ZJ+CynK7NHtvhsrdlrPCSqftsKpzgp67Dk8wF+fIbC35Ox0Qa3MaCEHg6kZ0gA9hsFm8Wc0l
	K7wqYww4wMGI/pqj1ZuqVn7e/ES23PM1hLh4/C7CkeM710ruioxbyNRncdg9Zxkjm5QpIwCO1nF
	0st3Y7ngGMO9rWNXQB8B54nvDFnMPV6Wmi4rfp94xNteGYox4glBz1L/dlfZhSu0x4rl+SSTevf
	SeMNUOn9s6tAWKQ5o6GDBswuHvj5HvSOZS1PLy/DLj7PO5J2woPzOhWKNZSQ0spnQiZCOgBxrQg
	e2w1FXp7e5J125a2v4t831v21jgJwMPWSbcQrqXZmegD24ucf89ljSrT5wA9TYJTx7sjGWdfjY6
	lhk58xtOQ+5OL4NGPoUEhg/DxpVBWfb32khZgOM=
X-Received: by 2002:a05:620a:199e:b0:93c:2c0e:7ac with SMTP id af79cd13be357-94408cdab55mr843373785a.53.1793288960558;
        Thu, 29 Oct 2026 08:49:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm1564046785a.30.2026.10.29.08.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:49:19 -0700 (PDT)
Message-ID: <e121743b-c589-47b9-8f01-0fcf0d70ca10@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:49:14 -0600
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
Subject: Re: [PATCH 5.10 000/516] 5.10.273-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028170003.522232767@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028170003.522232767@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.273 release.
> There are 516 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.273-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

