Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792838822;
	b=gkl3X8cW94me/wLfASpLFOsodwF6Xf2Dhs2CQ8fdiOARAFKlUPZJPnTMISpSW0VBMqhf
	 AktCBBLjuH2jEA8wA9ZYre9lta3DqYUVddcctJjx2q3EhZUjz9Gg6sKEn2ojzjun4A9+Q
	 qVWZOHLG82nfHY5gP9s2RpWJSuMMr17g2BlY/ElgNfMR4T5lvyzb7S/EYt7oiinlT5SiO
	 SxJW333GCEkpmsZJxaztPtglPtBM6Hsgz9GzqlmRC0RtVQxs1sLwpQBIHyNsEbNWp8wB1
	 wfCP+ybr95DQ2MT0NsGuxS2ZpAM3lLoFozw4Yj4uH0QIbFpa4O/u7eCIZblqXEB7KOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792838822;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fpi7hDFDFIpw4MzfQms1fOEkdwnmjTQj9lVB297Di5g=;
	b=gJmsL2Z7+7GH6aQbho9KRKJl4RE5OL5SDTJSh2GCy4N/gNuBvoVSS5/jlXoX/oMGPRkM
	 mZo3H60QG4TbmPV9z3w6e4lJs956QjHxuR0ZnnniAkmqeD98iGFAQ/74epEDsFMmUPooh
	 5A4J99FHnxSCsdB5xqOVt0DqCasWtndrgHEsUXJG601O6TuTIUpr61sJC6/MPCPNBaCWe
	 okp3+TuaU6BN9VVB7nC6H5DRM0Gt7qPX1SqIyeyFRSj3KvbEEJ2dEpVNqn35QUVdXNnvR
	 xcDZ/Z7UXvcofEElFX9eV5bAcwR4XljW2tG4QqvDkBuw2AswOsWXjw8YYXNCHNb4lpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HqozGULO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x3R93k0J;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3277606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3277606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HqozGULO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x3R93k0J
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CBEF8EC01EB
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:47:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 24 Oct 2026 06:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792838820;
	 x=1792925220; bh=Fpi7hDFDFIpw4MzfQms1fOEkdwnmjTQj9lVB297Di5g=; b=
	HqozGULOIe+vo6AzRio/l4F7peBuhz5OxEZL03jccC4+uDZpIypEUKuMiux7KRiY
	sHG/n6g0kpRDAXWratuVYVAYELfFYCWuAdYfA+5W85ivKbe9THuZ2tc2TOjcjMqv
	66efd5mllG4jBJkLy5athVlkKcKTLk95v0yRDfdD8TWeXozTxLfrAQiovVLFI4t+
	ngAzcccVrNbXBoUSkuCD1wyjo1SSgyuxvgMa2ifVgzh0mfBt1NOr8HMxz+KBNelv
	WaURZI8G/6/Gsia1fsxz5fLnCyW2nsrC1DkNvE0k5UOFtq6+5dQTtKmsZ+bOQcyb
	JcdK6QGHDo2+nTcUrFRdzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792838820; x=
	1792925220; bh=Fpi7hDFDFIpw4MzfQms1fOEkdwnmjTQj9lVB297Di5g=; b=x
	3R93k0JEJ8X13JGctKAQ3ktiozWyLAIUymMQSs7A5Ho45VRPe0szgS685iy3HDkP
	ZEBIGsLrKaSlFuVRsFIo/0Rj6aop/slK7tHxVdS4zKMn0+i+3yST1/GybWL+TuaZ
	CQsVh8HHrDBnFQmjsaKEkDgZgmT5goplCU92sdAlFHfoHTxlKRfZa9jYQYpL+Cl7
	Vx+A1gYaHsCijdAE08W6FiUAKqmBpEZwm2WnQSZ2gjhqx0T9KIIbNlI0chbx2Xvz
	kfJPuoNmcRsnHmOot+VI9zGdVDYCEL7rUsxh44cycF+9Wt7IP2Ahl0ORaMiByFu5
	YBCilK6Eh0JGSSpM4iuyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792838820; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bJDcJVLFE6BD1Y7cc9wE8X0Y1ItU0NTIx6PySFwV0MTsf+H
	6psDwGUzVUkw3hU/an/uxDksatswgjrFO5OrL5LvNqrA1xZ57grM/o8Z+bzPuXSg
	BQ+2/L22zYqLR0FoqIl+/xvGlTY9hZTCIwsp3430115oNZCjXOY8A9EC7Cm20wCh
	rkczaBb/NoBfSLip9ijVGqyyeeOMJ9MnT3TQFx6OV7Pw7UErq0MB0MoZU1h1BcGI
	3OYNN9xmhzeCZB4C+YA87Tq6gIHxaGd92w6jLRaCwEW5LAnek15ZhGiz7eX3NQmO
	9pVtWOjux0khFAiA5REb4GskFKtyUgvBRlxnX9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:VLDFwmNwF1UXPNNPE3mu3uoiunjkZrbp+8twsKEoOFM=:gYs23Vu6ZGgHDDjg/yqmqWEciqI576mvt8XmqahFoRs=;
X-ME-Sender: <xms:o4zcahiUrudix1_Bgy0bc3UxJtnG9KuARrYCul0XU3wvjAWc36VdKg>
    <xme:o4zcah7thbDP5zi0ZM1w7cMVgokOSM6eWR-nHz8mAarJjeVpyQdbz5DxOE6jzcR6t
    hD5YfwJkjbvkuEBiMGeNBlfhmz1g8lLkNzmLdY0KBKJEMK3effhOulu>
X-ME-Received: <xmr:o4zcasnQyiCVYhlidW3K6DZJ90gG-c_ZEMg6dAbqVZkVy4h83CJUfuFW04pKp3LWz5oReRilzSR4bjtlLb9kQJoO-a4oZXJg>
X-ME-Proxy-Cause: dmFkZTGEatmt8/DDtgnuvsMGSfuY/q0wI7KMVMLyrUWfm1M195eoQiuJqzs2/yE/WPaVcJ
    PAV+GIoeCYuJb+y8v8W8h2x3s+wCUl27tzN9llW/eaIwcowK5UzwXq/bxm2rGUC4yBQx6c
    G8JQ6/yJGd/haJKCl/yTmrGagwqePeo2TQ2NUeE+GgS/XpQSnhGJHpTjwXu6/KGIGgRFH3
    lOmFNR+T92pplfSRbk05uaDh17Zkt2+k5EgrHYT3ImyTOfCIarhXuatE1M2EXV2S/AI2bM
    f7nLghir2sgRrow+7B6LWRpI1mFo7DYTyVhwNSNM7oSI62Mhe1BLE0Kpf68aktMn8hilBE
    VnK5++lQm+kbT1w2BBZCAgV3vTT+WIGKd+uFLTPyVY91GYnODxnTugtXjqejhqXhBWL0Qe
    +/RYdGJcO8JkCgEBeBuTOo/QXGdu6nSciswUyEcOYWel487xyaCWxomZHTBGPsA96U44D0
    CcW7615SaqJublcCQ0OCazuIZDHeTd090hyN4r6LFuGLbSg/7vJodn3a+vmZsf37c5xe0D
    pNXo3IItiQpU4poGI1N2O30ACFI0V6MpVgyIY7tH0t4WIxb4ksMMEnlC+wysX37dUpccvF
    FQoTV2Pcs4lNBLdPRr5YuyWtIVs2IN23IpUC58zs+ur+dbVGazadi2xIq7fA
X-ME-Proxy: <xmx:o4zcaqNlrkgfaS_GbyoaQLkUg6CDYIgNJqtTy-_UOxvvsF_-Se2EaQ>
    <xmx:o4zcampxQSmSy1rfYNaYmsfkus6qesRmfHWgy1cORvlejT1ALIlSzQ>
    <xmx:o4zcarsc1paqEQnslMLd0WSdYTNChqqXcrE2pxUWDvimnBHorvV2rA>
    <xmx:o4zcai5fKEePKGmA9x6B-1hCqGT4S_olYKAMb_3vQjR_KZblMUBArw>
    <xmx:pIzcag2-l8FilWMbXlJQ6g5dxRHx_ufsBESMDwiOVF-A7HanNl1l_S5T>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 06:46:57 -0400 (EDT)
Message-ID: <7af386ac-a874-4ca9-9efc-ffe32b39ed5a@pobox.com>
Date: Sat, 24 Oct 2026 03:46:56 -0700
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261023163714.201276352@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261023163714.201276352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 9:34 AM, Greg Kroah-Hartman wrote:
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

Tested on 3 amd64 systems and an arm64 virtual machine. Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
