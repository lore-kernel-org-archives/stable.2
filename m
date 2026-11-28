Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858643;
	b=LlQICK57S6YQdn/4o5x9L6f8dSaU5s+qcOvHD2rl6KyVS86k6oKMRUeyKb3Fa270FZQI
	 SHfdDQLpaKjU5rw9kQar4sD9PbkJtYpbn7Dlt0uNk4s3VvvjawFKD72h1zDAjcosWin/I
	 sz9GhfMKPZubtCGB5CAlrbB7W34BffmkTPJnRwjfOUrv0O4BVDBojzzPm5XLwy1HWSR7J
	 AxtbQ6jYSWTu1SnO2P4mLTLKd1N5YaGm4ZrWUxuGAnLjIJyxWDJPHOFbzu33HujFFCtoO
	 d0eb8koxIbKOHL/FCOJu1iXNYb1bVehHB/C/fqdnuZP5wT/rByx59H+Gmtb6xhfkt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858643;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ON/Q49BmG2PkI98HJ4JcC4mrPtdU+GWc0UAsu4CwRZw=;
	b=Tl8rfqE4QjqRj7wfluUrKGtOurj8RcRfyI6bZUcUXvKvyTej507fzlUJInUwjKXb0JGE
	 gsEaq87bUgJYOVrj4LFdMaea+TNnGQZWeo0cLH7fQ3nAPiGdS8hXSDM9JXvr6zHzUyRrD
	 wms2DyzFK4CHrRdkDeblca82YDt65MM3GzhnddiSrDvhFnb4SM8NidW03mgOWCAQfdVkm
	 f/t5BDj0a4144SmTPijgB8LXo7m6Y7w+uLWL210FXVI6LHdt1LqdDRFu3u3baVJ15WTa4
	 N0GxTdVSgdaC9xT8wWpo3jdaDXeb7vaJgmJ9O/4cKj9TP3xXByEMbMZepYMmKkuHFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VWD2+Nao;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="FR/nEjQu";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EC606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 09:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VWD2+Nao;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FR/nEjQu
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 949ED1D003BF
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:37:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 28 Nov 2026 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795858642;
	 x=1795945042; bh=ON/Q49BmG2PkI98HJ4JcC4mrPtdU+GWc0UAsu4CwRZw=; b=
	VWD2+NaoHPWfUVhPQ2Eev3dq0XJV0anSq0NSXvNJd+9Rk6eXjMB9g8nNfYALoTpR
	izsXFAQUUQytLLUnl5VaOwxVnWqqR50yTmtOZDfXx9hltATVHLdfEt4h61tHu0cG
	EZ38dDMJLAT/iH/1YCV1UoUfNj1w/K0euytk4QER0RQxjUuuY4ZnorpL8macv1Mw
	MlMYJcJehpM5XMXDv9ODgZK+OMMAXUCGmaoYk/zWVvfhjwa1g3Ch7kXv0XYkfrEO
	9ZsxJDHZ6hottPEfo4XhrXrKOMFqiWy4pFnwFCc+Fr9vl81NsUa2W+aNGRHMXBhI
	PBw6ZgJDD41HuO9F6v41AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795858642; x=
	1795945042; bh=ON/Q49BmG2PkI98HJ4JcC4mrPtdU+GWc0UAsu4CwRZw=; b=F
	R/nEjQu1HfI8QQPUPQJdt7ea2Whg4uYqHXcOAYRCrQ9f38XTgkeryXlH++etXHE+
	MzXw0Ea6BQha8vgeg5r775ogGG2nhg/O6UWrYTJMZn2d7GENW16W7Vinf54JcJrb
	GcRLWRtRb2JEei8LgSZVdn50+OBEpgiYHIq+jI/Exx85Bt+q9BRrw4gpZlLqDp5l
	NVxB+KacNEIWP2qS2SDCtBHeq3ODOmifq6lLY++u+os9C4qc7FjW58EevDG2/Zws
	18ViGaBcrtSSh7/MSHPcLMxski8chK7hVdyYzZEy3ixHofA3MFIr//6OKow4vXkp
	ZVbrSvmoS8Pk4Y80SfvCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795858642; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:d3Z+oRQtQbw4m0pKthwVk75rx9e4Yl9MygWFCFngtk8D/jD
	u+nAnCsKNSVFLOnaqATDqS/PNHlnBWgHx4MmhLDswLCe1g1v47XYDMkhvyXypSd+
	HwO3Kfc5kuTkNAyN73gZgwvcDhQf/coLPiMmDzRvGxUVOsQDHCi20fGZTnMumxQt
	V74ppDaQSzdIcRyu3gkrbZ3NYNzRU5TAGfkLxmDR6avKjrDJsLopEK2rjzjg3tJU
	0h+K1wPGrOc+9dO9zgiVGp9faLSHwCwzBQyk/l7RTzcJM048/7LxZO1jY/VSpvtA
	l1Ri8xG2OIgiL7KkCABRik9aYvauQvTDlyV6Ruw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cnN87Wf+7hjshH0V4Qt+K4hTrkQ6pHC9UfXCCRwn5J4=:FnGsblhkd+jYsthEwGOdSaNMtkmpkDhnrIki6MiYo0Q=;
X-ME-Sender: <xms:0aAKa7-Y57qIMt_NUhIlL1u6rgryUMZ-4Ylqcq6bT7XtemtddkZNbA>
    <xme:0aAKa1aK_yIvGJ-Xvj3BySa_3-Z0NTdaVdMhN7LyAaWNid9gLZxocudkOYohq2Yh5
    ZVukRhStMzAWYpgA-3ZnGENXsVlBLLYqycfo_8ZfD3Va_xUYInPDSk>
X-ME-Received: <xmr:0aAKa6wU0uvRzEAjXbUET-qEAU8DSWUFgyJWvIwqji7BZfKowyico2iZvtKbiDeEKqFEhKw6XszHTtFRqpBY6G-dBFrm6SZX>
X-ME-Proxy-Cause: dmFkZTE0x5ksf0UACFAcTnq4kiNvwSgArjh5zvfBC5tbPh4OGlJtD+wmDkfcZrmmPOUBwf
    qUMkSy24uw1lEen9/qg97cZK9ITA1HrUjnh59OI1sc6vMIAWG8iCpxf/ug2uuFoWdyLRmS
    8Uxxt6SpLFVtsN5Or6FR3yoS+x7I056JjLR8Ycb5wsuu7HYBU05bHwVQ/KzfY50BI+6hgp
    CaGbSFifV+uyjolzi/47d5iUiu3/9fprPXC6KLvqqjcDB7E+wrzVqC2vTOH/yP5SvAgXE2
    lVuhCaFhxCbJU1hVDC/xDAPMzBB/Snih6QF06gY112vLSkLa1z43Dysp7pKM0HYCaRiTjD
    NfkW/5NA88O5D3BLQRvMex9i4GS4IyTJ7FeL0rgf0GMeXDTpvywYHhIH66/az6w6BtwXjo
    wPXPMyFOUzpAjYgW4vYj6YDqvNbRXQVcEjLpwE4QNNTTzqfX+I1fKva8Z68wPX9hn+B64f
    wETEJKBClflj6qkXldH9aU4QUR9HncvHvrX3ccY3wrj9SR0V7PyW11COgu7MxThg2XW/wt
    Pizl24IC+iVLQXnq0c9kh89SynX8L7qvmAS0x4I5JdMVYqCWTaadySZ6BeUw+CB9clyrCr
    Gt+Hv0KLxEWyl4nnGoeDte8jHECUEKDWzpXFtpRhkhFWdFqqezXx4UKAdNcg
X-ME-Proxy: <xmx:0aAKaz8OAdn4Dz8bTVTxbt-eF54jJJ0GqHtmymzQTn3wejkTvnqDIg>
    <xmx:0aAKa2xBr9ynGc29xlmGia0GJ_DycH_P7MXbK2DLtrX9BZM5I5byJQ>
    <xmx:0aAKa4sEwGy1lRZRZQRjOiZclq6gwpGNn36DSpgmmVc3B08meOy5rA>
    <xmx:0aAKa12FCVZsrXyxJdDKo2VjlnZgm4F2H6yozObwAW9D7jzN58W61Q>
    <xmx:0qAKawXxaSAR9uEcsdOWb1Wn1xq7vCfqyzHkBolY1MiOBRYBcUwiK3K9>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Nov 2026 04:37:19 -0500 (EST)
Message-ID: <f7694e69-306d-4f70-a9fa-815c81ce1b25@pobox.com>
Date: Sat, 28 Nov 2026 01:37:18 -0800
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
Subject: Re: [PATCH 5.10 000/264] 5.10.276-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261127052100.671985356@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261127052100.671985356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 9:25 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.276 release.
> There are 264 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 29 Nov 2026 05:20:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.276-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on 2 amd64 laptops (a Lenovo ThinkPad T14 Gen 1 and an Apple
MacBook Air 2017). Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
