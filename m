Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347291;
	b=nJGudDY8EfjuBil5EWmIxgbN7lV/+qfreCVCBl+DNI7SJwTFoS6Woeq4rajtDkC8wI1j
	 1wI+G+R3DBZg/wcBuevZPadvkCpeKp4HaGhSsn1/dNqNNhF8IQg7058Dsj1mlS16y0sly
	 7XS/I8YWlNSFGgxZYTm/zMFc9kXzCsaj0aSY//wYq4F8wN/0cSZVbkW71c0cu/jkZJNJd
	 MlBfhdu2n2BWTatvMFDeo9xy13yGFD0lnx0AgojA5plr/we4WbX4copzBMDev7qHNWjb/
	 d1aI3WtVhUUf5Yko+x+bovOrSle5haC14Cd5fmwqX80I+L3NwtnopJkgho/VBYh9qDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347291;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=saLAT5BSRhBq/JhGVYo5YRomH4jX0CTi6XbtM6Juj4E=;
	b=Rz2Y2vd6QiKrlGfa/8P+qZfjDOaFfLre4PTN1NUyEQvEHQUvbENAvLSuUiMWx4ouH/DS
	 w/GGxqePPTlbGz09TnpMC0OM7UhUhn04JWewtby19tGtVQV+l/o38jn30NeguZ7CfmCEj
	 HndNb+AG1FoSz2lVMybBuxvV/t8edbkCcCwdlCZlf9NDBjVRM6eJxhV4qWXGneJeGLkHC
	 oMA2YDOksADEQPN90lcVX8Un6o59grn7ky/AEv7at+mvr301cEup8fRQURxkGoOwreNI2
	 tibAcfY6hgmqaxoIyostGvMeWTE1/l/vTrbaE1C0MmhNuN7DWjcTCocvFxYUGsyJEmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k2RkxXdY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Yp1gVNSI;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5E606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A5E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k2RkxXdY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Yp1gVNSI
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEA437A015A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:01:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 04:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793347289;
	 x=1793433689; bh=saLAT5BSRhBq/JhGVYo5YRomH4jX0CTi6XbtM6Juj4E=; b=
	k2RkxXdYCR1zF7PPrM4dff9Lg+hSFtKvRjE7CSkuHRhoP36fU4aXpMuks3PzZpRu
	G/33ddEmIvnmL1G1L4MJnvxp8vL0SncT+I6r2EWwzeuqijhiUVymWjVD7uESvxPE
	b2aN0pzc0jr5roXTpmBFt4RJxhxoaw02U1YjYVB2iDcPYEnSLBnwExlnHonwXrdW
	UXPppL4AMhGtosTbmPgao/ffcyTqFJ45dtG4ACNB7dSA/24VVWv0SJfiCNY8t6ir
	wka0tTCOEyY2nAuypDD2cicHIR+LDOrRsiW0URcfpZb2kh78NQPJIw2n2H2dxl3u
	5Tt58K6MixDFCRopX6OUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793347289; x=
	1793433689; bh=saLAT5BSRhBq/JhGVYo5YRomH4jX0CTi6XbtM6Juj4E=; b=Y
	p1gVNSIG0vSlFZb7sQYF8fouYmUOhSSuZ7vXw0NFF8E6Ho0gzbpNcb5u2qlCJbDb
	LdStMwPPHeh5DKp2zBJGBCEQW6A4x9aBZw19iyo0C23ibagRqx216nuqTvkqPT09
	AHvg42h2cS17RLK5k8GS7nKi8oLZ4AESmweMJs+fbTAGkxEBL5aPEUBx3ZCTZll8
	dHtFzRFZhEjh43jyaJmVMuEHdislMwgUDZVfET39y4/Guch6FNmgl9tevOCiIymQ
	TK+z2jpXSeeNpcb/8v6tfEDj05DCd0VcmTKkVvRiyh2H8fAJAJZpoxNuhqpzoF8j
	9gkdOydIKHMRshoqIRofw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793347289; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NEHjPTkMGfb1G+t4Oy70To+jCiWeCrIJmVC0Smyam9xfVDK
	uZOuG4YBgyYQHZC+Y8RJD433q0ViEnwC2os9glZTUSvRSV8TQ1aa7ctgQwQkNzS1
	KkXQ4a216e0f78ga9KGxt0Wb2OsBMRhor59AaTsCMQMcPoYcsgSTHAFrViDZ679H
	qKwHRpAQrHqCxz7U2d4JfdtIpWDGoDrJxwbGGFxXnkrS3VvERGsf/DuNEh8tP9DT
	kVhIHQ20To5jdfeQ9lZ0CKOGlc32pX9+0IR9ahBPxkT1ypJhY7Qj7LBiOZr7BGo+
	3f0sUf5q6ZMm848UkMC+NVvaJAS3kOCPhuvsSVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dtJb9AzKNtf95r2RZ/cxaT5PIBxwCFRwBpX24uWoLgw=:A677p+rN+PbpVpxkYcO65gYyvJpQeCZtZjayo4dZgXo=;
X-ME-Sender: <xms:2E7kajLMhR7IFZh7GHzEJKxlH8CyZ8YjPKvbk52r98brvyDmOMYKwA>
    <xme:2E7kajAsiKq9ZVobqEKdA5jFE0Hm7Mn_tTWaeGcooKEqra0sBlr6bCb8LVECgTc1W
    fv_E57Lhm3D890-A_PMwJ-CBsBSLweHPbwgWHUaPj7OmtWYsve1Ug>
X-ME-Received: <xmr:2E7kanPXAVnBo___wMVpydBoJB2xgJV5JHeAhIOw8DPr3bCohUdkuoBehtFdkBjFx5RBgUTqftRdmIC-YUhlSiKt21pf_TfF>
X-ME-Proxy-Cause: dmFkZTEF4AqltApgIB5MJfbIEBtVMlrOYd4dHioR9Kh9LR/rk08Hh/wN/Y3ca9TIksUqYB
    DtTKqkykZR12TZYWyayoTTyjA4u3AuL9paJCQxYA9J+cWvjUbkOmbFkAJzRgWY7MyR5e5n
    CV/Vib2w4VK5VYl2kokEhQwyLBoK9SRUi8IPi/lgO/pWRY9Y00tFpm2pGDO2cX0O1a7Xis
    Xs6vSEzB8MVxSoAwWs2wVqXkUrameq8/mpVPlWJP+CHKrvIjtmdJYz1hzkN6UpZBnT9bjQ
    s41OWn69exmxkOQ7zGP3cCBdAsGkq74ZNE3AEtY+Xj/CgrvAyiHhtFP/iNe3ZUX1X8ZTpy
    KYaFX9VBYu9/ErkHzZM2uxvBGO3nFKJc8DEWcPbI0aMAislCWOtCBshAdob10wcY4g9oag
    Csjp37WmdRNhhdWQrMjxeq2DViObl92TRVHEVqZVK6XCIzKz8ISgISYf4E0FM+Jb1B5UkX
    +oDqyc+AxAKnf0yACwh3EbVn6/+3olyst3OuHqdhSZ3IZGCCci9npkdxDrKD8QXKajH2SM
    yaS3Rv5sw3wdlDXnmfqXyCMcha6kvPsFIf2fCKK8TH7aJQmVHS1NNdZ/97tzlZ/rWZM4uX
    evYmvPTzmZPeNSdT3VyytZYUAkC3vQZZmE7KvNu2D7P8L7Y3NDeeaLtv0X9g
X-ME-Proxy: <xmx:2E7kagX40Djx0D_W6ysilXaHfMHHly-acugtIKxQGKqu2FklYlAYDA>
    <xmx:2E7kaiTR1WXNC2RpsPuVE1c3FhwfAOaAsF8KZUQuqaakqC6scaVnjw>
    <xmx:2E7kau36ezsk9_O0E0gIbK7ikiKXYeF7Eg_lA5Gt0Ttx8OqLO62qeQ>
    <xmx:2E7kanjmgJlV7YlIjCIS5Q0P_-DXgU26FpZCpmsXwIKrX1oLYX5Gsw>
    <xmx:2U7kasdgywSzabWs48w-fJrKLPhhni8S1BwYyeTItjGqj6_9t3RIRVYq>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 04:01:25 -0400 (EDT)
Message-ID: <98fc2869-941b-4d36-afd8-cfd2f10ec2b3@pobox.com>
Date: Fri, 30 Oct 2026 01:01:24 -0700
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
Subject: Re: [PATCH 6.1 0000/1879] 6.1.191-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261029073135.159947193@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261029073135.159947193@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 12:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1879 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 31 Oct 2026 07:28:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.191-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
