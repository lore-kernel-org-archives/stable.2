Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436597;
	b=XZQnXm+nE9cw0sxa0t1NH/Lg2DO/PPJSpPFLbcsdxNZeGVqNQ79+UjL0n2Cxex4wwOIq
	 pdEha7Ob/UuPGfAFMz/lj7zfNxYTpHYUAwIrcd9uCHBWC+X1fpeJgD0D6GDfis7aW9X/Q
	 7gC5YfGky+sOBd3StkObcol0k+y9Q/nvOkCY3BYAH1mHV+kDmuHiyaaDU7hO1+eHEurEC
	 MADUkAc1Fdbz3pVv6pTZB1T6aGOCGRwjmEwSTUzzBbJNF91tw2tuDKwplnBRBE5VnofKe
	 v7GsBf4bwYlQhXfsl08IcL4kVThALeKUIhw+a+r1gKxk7JIfbFHmj2ttDqA4/rWBCMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zwQ9u0fSM+DQnMR6u0nh+yQlIZlqj4FNm9oRCXT8s+I=;
	b=GdJOrWkWbzAmLpx4uiIyWaFL4UzwfmsAtyahwAOocO/OmOkCKDmL7vAdneN7/6HF3UAQ
	 ovySFxAoHCtTZrgK+ePbcj1Ja2nczr2PGCcb4onA/9QBLwrkWrnDas+8O+xyLzODgE9Oe
	 +0EaLakxYAmH5GUJb/57g48uNbwVlMLkgGqwsQdC0vy6JuxEBqG0jnZwm71MdDd4XDZ4k
	 OXxz18MJWK6GQK4GD1cFc3qQWGw/i9MByhZ8QasWi7wUvElqcFRBrHZXvnrBjYiwtVPHh
	 Mvfrsfj2YwwlVqi/7RhwXEX+iLKlJPdIu+Gm/yINAKcl9q6APDJKyRHHywv8K4H6kvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="SURF/8Cg";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCA606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DCA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SURF/8Cg
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so885583a12.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436596; x=1793041396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwQ9u0fSM+DQnMR6u0nh+yQlIZlqj4FNm9oRCXT8s+I=;
        b=SURF/8CgkNjhyggV1vHabzT5HCG8ZPYK4de42JYHtxtERqLWnOX+pXGLoUfiAIxSSc
         S4JGVUD7+0/WDoDkfY8w1rq57FcNu2x/+j44W0cN0hHUxvbPhCMWWLb11zoilEk9zo/s
         wgPvAzot/FKY8Rn5aIDnzysZwn87EYY+FFyVVnKptN0T9sAPyZ1+ecZ9LDfrew3SG2DA
         ktmylYFID9huR3u31lvT/XRwL22/uUsANtJAAocgCMbqDPF1IgKxW1HuifEPGhf6Tb3Y
         XFuyP2MmOJomLbxD1yBhA4ENzW2HOVcoZCMvLRUSRz5SMzPJ1uohNaleLP+vRDv8eEi2
         daCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436596; x=1793041396;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zwQ9u0fSM+DQnMR6u0nh+yQlIZlqj4FNm9oRCXT8s+I=;
        b=2uMlmfjpwELOWlo2lKDY1tPlzLfFfbj6qDirIxpOPTVxytFEO3xq+nz7Pyn+cuBos9
         h4piJjzs5gflqjjiFdr3B/K0mlJXlH1P4uuwWw09iTuPkCuQCl9aqq8ZnoGQiYzebtYI
         MHooZLXjmHiDSmHOxIMCTJXUIDGcnF2pjOr3s6whd7aO8FWedRqWvEiDeCtdIDHxjy/k
         CqrX7iy7w/kEkGVXKyWNPCyAHk5lUv4iqGv8RKa5od509MtH6ex+a9evoLwnwjAU0Jd5
         JnGEfleOHxlnByQlGoYwJ+2znadf3+Av5ssj0isxqfMG0KKIERTeIjuerVn/eGVOkP5q
         +74Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/BZElvP2n8k097HIb6P+xySWA6+CoezjSCaC/24qtLff/p8RYsizZ6DyH74FIkQCaO72o91k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKIPlRLnaZuBkLIjOoJ427276foHQF9YIqp8Kf9pKCU+JIebK2
	qxUFzVkvh9RbciWb3wVhBJGwcbdEgFRM02bIB8/Og/TrRXHule5IFyOd
X-Gm-Gg: AYBFou1/TN7hi6zw8wR4er/GKHFuP6Q1JXp447gDT6hKkkeqhkBFKXUeHOjjTUaEEmt
	1hurXjbzuxF+jxlcCZSeJv7iyhW7xn/ewiNLmPQhLePPj3kvmqZzbkWcPvnlYYK2slU8TnH6k/R
	8mqFGU99EgAyEW3nifNo1YoSBZziexrBwZVM3OAX+BQ0/8UimSO5JQi/Q8XLY40B6z2o+Fy0ZkD
	6n8lWsqTEl+V5XT3MlEhLWy8MbOJR76BG7wfUUkt+6ZVbQ+raMRn/dkB+WKVVBzLVP07+TLPSRZ
	gEFysGUPtjsx54BC7nfwFHBtJ1nvCcOMsDy7pvpOR+2lTtoWBLWgc2PGCq6wj60aXkgmyxdxPB2
	HEGhgVb2dluTqawsZXQ/D5/QuvKlzxF34jR7YYQupM+3KlEioRDz237TExweD16UjnoLhgmNojl
	1Utwzyl4qSwbCEx6jWps3C7Q0BtufRg4Bh4FBhRYJrplXKHAlyduxq0oQAiGW5obLhOgqqrmx8T
	8LSR7rSSgC4SXTPlJ4JS6sU
X-Received: by 2002:a05:6a21:498f:10b0:3e2:678a:b521 with SMTP id adf61e73a8af0-3e2678ab8f5mr535254637.71.1792436595996;
        Mon, 19 Oct 2026 12:03:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549c7034sm4220834a12.16.2026.10.19.12.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:03:15 -0700 (PDT)
Message-ID: <5fbcd61c-a997-471f-8a63-9f70f323bcdf@gmail.com>
Date: Mon, 19 Oct 2026 12:03:07 -0700
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
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261017155059.698368299@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 15:50:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
