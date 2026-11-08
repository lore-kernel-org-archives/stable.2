Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794113946;
	b=HahRl4CZS8wtfCG94lWDePHPpHIwKE3CGPSN96xP2/0h8hIWw8Vrh4JC58VtIFnKv6Pq
	 m1XDY4xAtjwEEvn5MoBwFLW0P4GS5/1jhTZ7k2EDF4sUKUerFqjLsOa4PN3GRCeW9w8en
	 adHDfCCBupu2Ea58fEoiUAdYkxhXqnSoBfYOyp0CiGZeSaAEcJt+AMSRAaQkafOg8DE1y
	 /xarTK1C/OxiRh1+W9mdoIJGJmbDw0GTlKaF659wvphLcV/zozxsVt5GT9ShqSGUCaf5Z
	 HXFZFaNUIcQGYo6Xvj1Rcc+shIEpDCdbLV99+YxJIw0wLIDy70G/nulfXRV2sglTAAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794113946;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WuJ6sQHXMs2ky6wQHLjTEQYKEnIZNvDrBjByHRgWWGo=;
	b=xZp5ho9JkJRol2nSvmExLrREd7cn1/rV8mXPSSZg9zlBiWEgWTQOJASzgJjzvEPqY4hw
	 W/ZCPfMqHomxiVA88vsnMKWAkyURVTaJsgxDtOydEsWEtZuPUZtg8EhrcBA7DSEQNe2Z6
	 usSXYRxNDC/Q/t+TFqc0TDcJ/nEG6VS7jWnNwQvG3s/4fJ6RsIVU2gA+/NBnSRDJoUPF8
	 U4hDapxDLTn11Z2Q94gn0PxvLijYVqJmAp0Q1+dnX1qzRYqLnHEOz8p8QRF0dZWDPiwMb
	 Ko13lW18MgrmV0ptffRJWbyRUA7CcqqFHDEe4r+rk6pzMdN8vG3Y8YcT+9OqiUaGLTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=oIYLZ1tB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=v24AmnZ+;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AF606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 04:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=oIYLZ1tB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=v24AmnZ+
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B025C7A00F5
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:59:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 23:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794113944;
	 x=1794200344; bh=WuJ6sQHXMs2ky6wQHLjTEQYKEnIZNvDrBjByHRgWWGo=; b=
	oIYLZ1tBoMXcfm6ohKNwvZL227IVOorBG3zMRtNNWJYAHgm8R2ljg3LSM4s0w+TB
	O28MbkX6BSd4mmQnStnrklUzKXGGiATUoJMebpz0qPHYzT1FByFLzNIMmjvnQJbn
	onSADx6YNhuL3IZvhFbh1sWgzsTS2npjUsSxE4jxEzzIYq3t+zuPTjOs1pAxVDYD
	+yVEIjOWD3IKow3f+Bbr/hcWiE3K3jeqCzLNiWmub39z2+pbUNSQLpNjN9QxQBzG
	oOeIJ05EWORWl1dJMiR8+7YFoLNY5R/dqEpNEjfqskm3bTz8nNiOza6e5tusXNmZ
	hKURuCr5N+c2jVV9mJZRsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794113944; x=
	1794200344; bh=WuJ6sQHXMs2ky6wQHLjTEQYKEnIZNvDrBjByHRgWWGo=; b=v
	24AmnZ+GctXU4ETSQi7D1uwHCrPDpDWxsnLo0ldrakrazmIij94JaQYDMgQ3X6dj
	lP35QaIJFgvQPMFbEx3e3iszkra62577WLn6S8WVGmRxYwgDYLNcVGHFEqKRYLpe
	TSSX6uxA0yMedD21JEF8cuqBNpwKzNIDIgT0yWr+MM5w6jVH5sIKmt0uU7PxLMv8
	jcWgBL4zgJu734IYd/LM5bgZAVIhIFJ24fdIR5u+dA9YwZ+pnO0LnBbYCMHFMdup
	o8prZh2XMkZfeEwp2nbPQ4fMo7GNpAO9elddzvrxZzc7nr7qRTbkM8t2D9b7DfRu
	SH1jiWqb8vjROsKSJD++A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794113944; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NstdYHYaDlNrAoWS/VlW2H0qWK0PujHivUc6a3zOL+erSJ2
	xpBhyFWyPpSKxCJFLfBg3RJH244O7zAqy3ySRuzLtz7lM1MlDroOzZLLIbJceDZ9
	iwz0Q5kDECwHFojdrWTBIJH3XgRhiQB1fYLal/2Ayz2zbwiuahjhkLh64Rb1DCX0
	tjNA/myLV3BkTLBfI3fknyHcdxloMyLRABhu5GIlIjLWSocwYnds5EgGupBH2iVx
	93a/Tb4aZw2xYiHexJv6y9SHoHsyudVTOkyJamBppQFhum2RB/mGJBQy35mr5l6J
	lklCpIY6CAdaxfju/mHd/gNyDwXkL0PT45atDcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:S7xqqUEHsXvdnOJ3sbaOZojzc4EMkFHyUrmZYd6Fbzg=:2NhP3OwOeIw8AQPE8AiZL8ChlyjfFHjuxhPbpkxaciI=;
X-ME-Sender: <xms:lwHwarKzpWAB7Kbr8_PIDkXpZdXfQxQhWbGeTxwWPP9KfcrTT6Gy2Q>
    <xme:lwHwarC9GuYATEdB1LKEWI4-nDtPGis84JREH8Z7czPKeCHehLroI3E2oqGbsqAcs
    -MwcS-f_uqmLD-eGKstS7H-vntSjPD0NM2ik3XAQq-3QShMAyMmTLCP_Q>
X-ME-Received: <xmr:lwHwavPKIofWY97u8ZrRTLBvOxNt8gtwpn3XTcZBzNtVfDaNkPpFZzV4l7XS9RqVLUz7FgaPHy9mRbjw5Zj_oRRyHkfkuzlV>
X-ME-Proxy-Cause: dmFkZTFlhusCx7UObVw2Cm68ypW8eHXNooAOS+ryzPCQRuNZJSy69S639WN4PJBrRZ3eoj
    ++UE2FsBUkZ4fRhEPbMHZL7kG0i/Edpw11bbiHtoKvBmt5FAQX/xwLw9yXa6qMRjYBEhgp
    V6DTYwM5j+4LEdOl1aj6la64hb/TdBDqFKUqHJDFjZIZ3Xan3FehHlOWE3y6TysZkqqfYw
    hUKq7r7m35Rf/EHdTrmQcYSvwmLv1xiv7+whYsOuScWJEXFIoSZdiS0sVadaiY40/wNox8
    e/iobdvzuk+sV052HPgxn6WgSwjsr937POp6JXE3hNqosYbzBnZtIH4Zx4pkQ4F3GMbMno
    IQUjmxcArg2RzXGZ6BthayoPIJP4T8LwcgTkgXmCktWCrmq51bmBAxtdgiiV1iwVh9TGCX
    RLqhhpP60CvcDPBugNRJ+qTSDelSCqcwaVrSg7Ku8qeqoK+1HoSEkeGanCPR88YAUMBC63
    iDGAP3TjHHUCYU0wE1Q2sB7/2LJIXZV/55P/9DI2zmKbBZc2oAQ6mlyaPtWBn4rUkBaDho
    0YUFr5AbX9jxF76TKK8/Tg0WKoa1N/w0gvWah464pgXBjVztvDbv6rAYv5Kxu5ekIBK1tl
    lO9yF7KcuT28Lw7ap9/Ft2FAejCi+BAxJA9PeaYtMnayyhQVxS82H26sjLiA
X-ME-Proxy: <xmx:lwHwaoWlnfFZSqxOsNdbUwblc8Jyu6slua-pCfHJNXFlwE0C7L7u-A>
    <xmx:lwHwaqSw3OqthK20fvpas15LgVslir6VHdToOYa-hRL1KSSU5rehwA>
    <xmx:lwHwam0kNhbuRA6Q-Y3kxkwCHPGYh-aC5ENW5NTKUXhhr7VexP-U8Q>
    <xmx:lwHwaviRDT4fWJvRVQCiBkBk4PqFIUvKhMYnLtAxUOhOUSY5BvbaRQ>
    <xmx:mAHwakeA-nG-lAxqf98fXm8aJxIU47ZItE2FYMca0F1YbPAlh7SEgudF>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 23:59:01 -0500 (EST)
Message-ID: <f6e0e225-a80e-49ee-9555-be300f169503@pobox.com>
Date: Sat, 7 Nov 2026 20:59:00 -0800
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
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
 <f65916c7-470b-4f64-84d1-da8cf4c8e7e8@pobox.com>
Content-Language: en-US
In-Reply-To: <f65916c7-470b-4f64-84d1-da8cf4c8e7e8@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/26 3:49 PM, Barry K. Nathan wrote:
> On 11/7/26 5:38 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 7.3.4 release.
>> There are 1257 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.4-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> 7.3.4-rc1, 6.18.63-rc1, and 6.12.117-rc1 are all giving me the same build
> error with clang that I previously had with 7.3.2-rc1 and 6.18.61-rc1,
> due to the same xfs patch as before ("xfs: cross-reference the primary
> superblock"):
> 
> fs/xfs/scrub/agheader.c:123:6: error: variable 'error' is used uninitialized
>        whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>    123 |         if (agno == 0)
>        |             ^~~~~~~~~
> fs/xfs/scrub/agheader.c:435:9: note: uninitialized use occurs here
>    435 |         return error;
>        |                ^~~~~
> fs/xfs/scrub/agheader.c:123:2: note: remove the 'if' if its condition is always
>        false
>    123 |         if (agno == 0)
>        |         ^~~~~~~~~~~~~~
>    124 |                 goto out_xref;
>        |                 ~~~~~~~~~~~~~
> fs/xfs/scrub/agheader.c:111:13: note: initialize the variable 'error' to silence
>        this warning
>    111 |         int                     error;
>        |                                      ^
>        |                                       = 0
> 1 error generated.
> make[4]: *** [scripts/Makefile.build:287: fs/xfs/scrub/agheader.o] Error 1
> 
> I sent an email about this earlier today, before the -rc was sent out:
> https://lore.kernel.org/stable/7840e515-e7d5-4ef9-8c1d-6390374a5b33@pobox.com/
> 
> Reverting this patch fixes the build, or the minimal fix I proposed in
> that email also fixes the build:
> 
> --- a/fs/xfs/scrub/agheader.c    2026-11-06 22:42:57.147299404 -0800
> +++ b/fs/xfs/scrub/agheader.c    2026-11-06 22:45:59.898908897 -0800
> @@ -108,7 +108,7 @@ xchk_superblock(
>       xfs_agnumber_t        agno = sc->sm->sm_agno;
>       uint32_t        v2_ok;
>       __be32            features_mask;
> -    int            error;
> +    int            error = 0;
>       __be16            vernum_mask;
> 
>       /*
> 
> So far I've only tried building a minimal test config. Later today or
> tomorrow I'll do testing with my normal configs, but (to make a long
> story short) I will probably experience temporary health problems
> for the next few days, so that will probably slow down my testing.

I took 7.3.4-rc1, reverted "sched_ext: Fix the stall watchdog testing
and blaming the wrong sched under bypass", and added the fix to
initialize error to 0 in xchk_superblock() in fs/xfs/scrub/agheader.c
(quoted above).

The resulting kernel is running well on 3 different amd64 systems and
an arm64 virtual machine, with no regressions observed. (This includes
a successful XFS scrub on one of the amd64 systems.)
-- 
-Barry K. Nathan  <barryn@pobox.com>

