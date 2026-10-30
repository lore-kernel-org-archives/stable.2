Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397997;
	b=rNX1Nz/BN7tqwy6o6Z/3iuob6SwBcN/DVeh3fcxd2XZIff+/LT0MRO+regy6Ea+Dun4G
	 jQPCrEF5VOwOgihmmreMgU43vKSrymKvW3zLmX+4+9i8t7V/JoqDoTAj4A1T7x+IHHuCm
	 3zelrWK/MhoYzXJZ7JwWyb5riDbDEL70OgUB042gYzHxCVrU5oY5bJlNQwS+ozW9sZXhK
	 QosUlCojcMJBCZfPu6Ef8W7uqzHW1NNbIEKdqz8s3uMQz6ioyaafvpz7/d7PNYv5xWPLe
	 f1Nn2gl9B8eOidd70Ul87OYcWwCHEsI6r+olv5nm4oen9OrERQw7BmHvNnTzMSA/0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VallrhWYbAQ8j+mRUozNpVRyDn2TOg/EyzhjcGGEMLE=;
	b=cLAd3Hu0qu0CtnaKyWvedrAv4C5eUJo74LN2djdzpKfsdJX4YutCMvXATNwVZpkFlDTy
	 xZSdV0+/j4HIMRtnUF3/dG07QROY14OFm52Mma9oK1BqTVddtBhtPSI7o63xAKvFM1+X+
	 LiINXrEzB6wA9O757Rvo8BD67zowdUGWz+J39WLkkIuO+WD149Qg3xDE7P0rRdiUD4nXB
	 QIbIfnQ9bjPDS2sHLbfvpG9ToN5yxJJMZiJQ13EuS9wNic4VKx5V4ECIxhcMo8aLU7VoV
	 UvUo3vlJEu4gGjH0by0jc26b6S4Rs4TIxA71hIWxo04bUUWkdTzGWaxIM/gFKMZ5RKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TgDau+pR;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DB606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 22:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61DB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TgDau+pR
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so294452eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793397996; x=1794002796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VallrhWYbAQ8j+mRUozNpVRyDn2TOg/EyzhjcGGEMLE=;
        b=TgDau+pRgokZi6Y5+vOyGN1+QdCqzjrQXUBgII0EQAtWMADF9adtWhTlhN6g3R9A69
         YSdbMak7XkVm0oMPP3C7O++/GxO+3QLRXG3psL+Pgb9GtNjOCjmDnToq2Bg3ZcBkDffg
         b6hBZIpMqZ4F/D9ppplNx3NWTBVraDWB1CVnWRU+8OyKSHUz/Zo7ru+/h96pUecBQHQ8
         oR+pLa0+q3HEK43mCMvyHsyNrxyE6jyUu3Pirdo2zodrgBjHgo3LoYZL64+BvhrkGO4b
         dK6DdagT6/3S/eE1r0IuFp9W2tAwrLHPzPy2JK6WYQAhRmSjd1mSDNFK90int7co5z+9
         FGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397996; x=1794002796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VallrhWYbAQ8j+mRUozNpVRyDn2TOg/EyzhjcGGEMLE=;
        b=Bs/PIZvUFYIWrLBroLl9KrWkSsP4iNsNAWeS9W36p7dPUDMuU/0/MGIpOJ22YrhHf3
         C7PQJrg9PskjzfqfzJ20HpvOHuUgc7eDl9ckYsUBvq8SINZcwehZ4bKUoK3de34c+6b6
         pa0fGtZ6GAVc2rZLrvPRnAlEOQPAe/lbfmTWp2vKfRrcbUE8rMwoGYEY3fcX9FCbZQWT
         T5zijHXAAIQzV56uPEbaRrpGfFGsEPnWBPeJMb+bYmRialbUjOCduC0ihZR4y2SzbP4Q
         XvTTFZ6l72rAd9WF4kxtc4BxbDyfdg3mb+Z2MK4e18lc62hdFadp031dC8UVMA1utcDb
         nCFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuHPzXVpKD6/BYWvze39J5tQ9fcctHOPtpTzO2O/pZ7ES7rOxq7IyStM1r55gcJgWt/OwhBgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvHp03MLfLu+XgNdaTmkyiRwlHLG0mhT1KAdGlVpp8vNLPC3M7
	HUOEXex9ahCPK7ScCvDOFbFD7VibUwWPXIngIYQduig2suUsS1b2hZq/
X-Gm-Gg: AYBFou1eXLQNwIO9i1HRyatI1bFC1jusMlqtmhkfd69+VvoowRLSgGD4cWraPBnHtrf
	SfRlZ4NTRHMx8c75hSbdd3ruz7M/yaM43jMG4N6NbAxii4/EpkCBadg/mO0B1mN18A83guqwqPp
	r2+i56v8vhDXNIDDYIVYY08J8jbQ/LNTBDyL1tn3JOck4lMp2ykW/7tWR/aAa3gEHiLjIiXrLdA
	94HSd6zk2XHuKzmtq5SClJWSICuMQm8CEcqAbnNqZ4l8/x1MLTBC+PH21u+aL1uGmap998D+xLh
	rxLqXymCD4WSaHyL0DxdwSA+mzWYNEPyt0DYdzlHhzDpwOIt23vCCfwg4Kh8AI6dj74B25gqy/p
	Qu3WAgusezujSAjwqhx7Ecif6x4kajT8/FfFQ/Wic+zIX0CIGth2nu7dMF4yHSZPPOMuQq0e2VV
	AIZK56DAEIPkpPpEumgULY8WmQI536RhnLHPk5pnjWTsGm8Y1UD2CQeIwo6bzo2S1Q0MMWufnEw
	tMggdt6ZXQ3cUywEZC1Q/dJIeFtcNUfeFfvRlQBoQ6GPSw9IUmkl/H6DqP78y8I/yxySeqr3tyl
	qbwP0S7zIG22cQG9xdwPLI1sLSkjf/qdGPb8jC7tRrBapU6OEb8ljk6Aor0biQBFZ9FS6TPli1H
	GDA==
X-Received: by 2002:a05:7300:8e:b0:36a:119d:a099 with SMTP id 5a478bee46e88-36a422062f9mr5616341eec.5.1793397995862;
        Fri, 30 Oct 2026 15:06:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429018casm8965957eec.14.2026.10.30.15.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:06:34 -0700 (PDT)
Message-ID: <547303c0-478a-4ee4-9c9c-281e62ac4a69@gmail.com>
Date: Fri, 30 Oct 2026 15:06:32 -0700
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
Subject: Re: [PATCH 7.2 00/10] 7.2.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261030121255.257615100@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261030121255.257615100@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 05:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.15 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 01 Nov 2026 12:12:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.15-rc1.gz
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
