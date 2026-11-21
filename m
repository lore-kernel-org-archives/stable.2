Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795247786;
	b=Wrc+DgPKDTq+wrqWVkjEgKHaMkl0q6KoF9wVDKdyjNcL0b5BjFmU2Gsvde2XtUiM6V9r
	 egOtbM1ootKu3abd5U8WQbrNLlGJjwgzi6KJ+z6rgalYtE2q9/OzfxCYT+sJ15wQEo09D
	 Dj2zkMG73QyLIp70e32eTMtRTqzXYyJiu1ji8HKuZG7TMWFvEPiIX/PD68F57oCa/TIxJ
	 DqGCGfKT6oxMEeTJ4xfIIYOwEKj3c893O6BnH8tW2udNZkFIbsgiG8FgMkfVv5ykVk9Qx
	 QnT2MG6fKJijmgwXcf95v5khB1cCnEEDX6EqialhKxT+APbpQnCnb983BAKmN544iBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795247786;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hsLW21foQ9reNMkx5za4Il4nWlCgmfIPHoagUP2WV0A=;
	b=2uFSN+BsP4JwByHoCcYYP2ISx4rUcm83phzwBnB2bfHAgsRLpOaAgM7ouf8Q6I14ctzr
	 VplK5IrNoZDfCz7//eEj6cBseHJ2EosdvNvylwlmiw07easyNJxuIKA5Dyr8cOiTJROsC
	 MHR8vp3ayeFyzIHf42GnDe6j1bnwn0OZDnka3+baGbEDUgApw7/0dIJdB8TO9/Jd4l9Zn
	 uOkn6kASVolhltWHh9iDISeTMlRnLtZca1ckCdWG2OMFJ/jv5IHSEwDHdAQCKi5GEOjo5
	 YgCkzwsVATwzF62pKThc0sUtDUfo8DTHaOGlHLGvSzNAeuYHP2YDqMP2fcCu8cXzU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QuTd+7eE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NE8WSeYE;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621E606A325
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4621E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QuTd+7eE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NE8WSeYE
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92B087A02E9
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:56:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 21 Nov 2026 02:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795247784;
	 x=1795334184; bh=hsLW21foQ9reNMkx5za4Il4nWlCgmfIPHoagUP2WV0A=; b=
	QuTd+7eEnhK0Vk8TyeZw/AsOkU87WLQWXgW0XO8yPR+8TLEhFLIhLP0gpwppIUC4
	clEJXQXkH3YjkjrC+1mwH4UGYsIm3zwFftuQCdPCE5fRnDuW4XXNtMptAPisoZSY
	/sQI5PVrwXrCk0RofF0Ahx7XcXHlaZC3yPDUAOKM6qA+VXFK7wC97COyTboUTADd
	7lwSRaexsU3UG5hpQ6qLOAXVoIyh71jENNPYI6AaGpZk1R0LCNaoMZeJy8uFQEBo
	2GdqIs8Rf1L6YOxWFfa0J9SIFMqpFwqvuvo2gwK+FdvNht/ZUbdwUoS7GPFIwupL
	ZsPXGW9GX6aEdfEnccPn/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795247784; x=
	1795334184; bh=hsLW21foQ9reNMkx5za4Il4nWlCgmfIPHoagUP2WV0A=; b=N
	E8WSeYESaFO65STRaqEktk08stimNkq/E6OMv4bZvG9+r2Utc/18xPUPuJjjAzqD
	Zw/7a3PJxWFyto82YvGLHhbBtsz1WN6gneSA/ahd5VNWiYVYrjZMgWd8LLwBDd4D
	qOyqZA8L0nMobwx2XM08UBN9/UeQx4+fMsvq+OWCaIuqkKZz1zJ+mwVW6nKSisMg
	9TugndIcDGAzGbdq8uXz3fCIVReWjy3A0a00OC/oat4OqNuMyHIVE3NoejdHVKRX
	UKEW7Zr4nHhEose6fnh70XzHq6HEZmkKFyPMRnnHgpArIj7oO5Kd/i8naY8kNVrf
	l3A4oayTsLtOOifAd0B1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795247784; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZKDdAmcoKNeN4q8o2OVfHl/lBpajvK45WtgmXHv2kU6u3b1
	CeYfkj0dzLvrJHz5uyQ3aiotGjvTztFPHmdjmPiYnGXyCK6/em46YGjPwh6xO/Hm
	1W5WE6GDssbGbRN10JreawBtp8PcKBEXLOyLeXgtawAtL8ITYqVdlMOYlBgiSjSX
	zFc1sdbKAuhV16A57xUHhnXz2vG5aqolUF8CmWp6Jm4CwpgiNKtRj0/xrVwt2jcw
	cwFz4PR14ijw0+/2a1cGiIQG/bM45bf1a77i/LDexIjojk6WjIwpGg1lA6v78Ph3
	ahg+Xlofo7c9LP6PEXwvEVpmKX9bwcuG2i3IpBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rrDOdvzNczMOhUFTZQM21WhtthuB/HVCmPALRq2+7BU=:p8AqPORyGIacdG1j78s2RoA0K1Xkv0A3TQ3zN0fI3Hs=;
X-ME-Sender: <xms:p04BazUVKqzZOYnCirLGCIWeRJ_maVugVPhtAR7O5WEwxzi11womsg>
    <xme:p04Ba5SM6Kia1ThQuVIZR7IXvxGPQ6YCmr1PIaaGxoB2iytKT0ikamIfTpfblEC-Q
    A23U78xf8Y8tYOBGqN7Qo6dkjYBMw61rJXgfYl2k0uQI9nLUe7ZvVWh>
X-ME-Received: <xmr:p04BaxK9Mx1MtGu7g3Jgw-ZPC5eFj0pul_8KhwE_ma6-qzrIgD_SOVWHDyoG2oZSFEhHKk0UiVs5GnbAPaWqPtikWleSQKJH>
X-ME-Proxy-Cause: dmFkZTEy6fzVy5eWVjAm5go0Hjv0isxv80X12zx3kjly5weCO39qd7OjdMoINsgImNIn74
    gnr5aa+pBQnHieF2K1iGEMyDby2mRsGPtxlSqoRVKy+gsRu7aseOoQzvogNhzRHdG8rdbH
    pdzskmSW2oGBMCV5NxK9YZLoGoosM4LrDuocjhzRmFNIZIVxdegSo7MAChSY/QmhyNmfmz
    3Q6zgCbIIrwHCk/a3BtWARRY3qJ8Ys6+une9/7/UYpLC6XBF2+mXSjk0a6HP0Z54qKaQ/Q
    rM1WTP1oU7Px4tTqo8URjTvURzQMMtbmS7jKvEpwCvXxKABJbywN+SmHNy5kX3+DYhhgAa
    LN3Y2IsrvPlR5JGXbIsl8W764UWOioNVqhWOT5KuUcUC9mvOXwlrBNNKETFWAyUeu5jVnI
    4QfiYKVGVvqYcIznuCActdGrcXqnXVuZBQ5Ds+jEs6Jm1k1zjeRgGraKii1QCGbVpTDULS
    vvfQl3OIwOiBseMNiqpWRnD4+Ta63voTuoUj7JpM26QPK+eBoI0vutfSq8+Je31ZUbx84U
    99hSUZmmh2/cEisTuAGeMAokuebq2W2UAyCtmOzraraYM7Dd54aE4c08FAULCGE7JGOpOU
    uixve3uw9hqEcY+mHcGuFJ3JKUy70BluCloGHP+vR9c66C1GqU8n+/oldN8A
X-ME-Proxy: <xmx:p04Ba61l6U4-_qhmEPEBqJf5HjBTTLpr4Oa31GO_BEJs5cyrVpTEFw>
    <xmx:p04Ba0JPkcxV6O2RoibtyG7Wlo9f-ZgYQl1j5sp9h36lUkQEgUvtUA>
    <xmx:p04Ba6kstv05Tomxzd7P7wXFfd4TKvzUaa-PW_OdzYmZMHN2Ygz7fQ>
    <xmx:p04BayOOizbmFhBfLrNTm6Iqp5NWDRxzeMb8Nto9KLrpwrQFpar53g>
    <xmx:qE4Ba3w5HqihoqsXxSoL1h-uiCQwte4fXLeNUd5Ioj8aBhORh-FthpRR>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 02:56:20 -0500 (EST)
Message-ID: <70ac7799-4623-4fa4-a59b-e7114cb60492@pobox.com>
Date: Fri, 20 Nov 2026 23:56:18 -0800
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
Subject: Re: [PATCH 5.15 0000/2178] 5.15.226-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055015.328810133@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261120055015.328810133@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 9:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.226 release.
> There are 2178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.226-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I took 5.15.225 and applied the current stable-queue (commit
3dd4b2d3c1f7915277082781d6dfbe71d7d41800). So this includes
the changes that were made after 5.15.226-rc2.

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working
well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
