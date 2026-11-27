Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764700;
	b=YbAJdbW7qvdJFHLFw7g+5dcPqqPkp/MaZ+36Zi2WAkNosbD3UE6waKI86DAZLYTBK0W7
	 jdcdxIccjjt56iy8tgcBg1ijCJpjqq72TGWcC9fhTgYIzM0B1dY5es5v5Bjtiqas/4+pk
	 H2x1CyUA+5aqZGRtMViOwQg5ctNYop8b26ZN4FwE7G/DRw6WWgYafi/NTsc8jKIoXV71J
	 3UyrGrMTuaLqnXPwIaj7P4UXXaVbLTxOEpWCYOnYxKZFpqUSW+OY+hif1dcVNHYfSHeRj
	 XdVgDEtbjqB+P6j+TXPbfhe91KAvXFsTkOLohmj628EwxxFFAmo+vkztaFahj9hW6Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qGE3gzMs9i3YWD2v+vlyaBQrGT/Zbrbfhikq0P+hacg=;
	b=FhOS973GAXjdptLpflDGsmYV3ohvBQTfzb7KbZJUpPm4uJmQCAaFJi7eJNR6bw3pbdxr
	 2lis/6KG5d+5+avw01IXcViuis7WtR9f2tGtibUI2V56zEK8qyrjNU1p5quU+8HdH8XFf
	 yn8nP5YedY8F8+eWpIHhLV5H+FvY53YcFqeqXYAJ8Er6MR3W/7RBV0wNfOLg3dT1wNUQn
	 JSS0/jXq/sdJ104aga0feXq6SU0ZT+ZCX8zHigftrrJfr5GDXiDE2hY+q+33IeoPCGaxx
	 qmImRUocNjPRhmIFgb+5PRIqx+VATn91xlwb00m41rqDkAk+P0PsvodEMlic+sootig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=mmQnRye3;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C376606A321;
	Fri, 27 Nov 2026 07:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C376606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=mmQnRye3
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AFD2314C2D6;
	Fri, 27 Nov 2026 08:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795764689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGE3gzMs9i3YWD2v+vlyaBQrGT/Zbrbfhikq0P+hacg=;
	b=mmQnRye3LruXcj0b6cJFQimk6pucZPDB0zTdlXc1Az4IUS9D7EiWUDo1B7NKqnlypd/2mx
	jE10ufkNFSTJCPbkhSSY6wPcQA9lppSDBIO06svFcIlysjt5wrBpxE5KC+YANTIzqbeH+z
	GYzGgZFbCUN3G9RVz5jZjP+G1wUqLW6A3/A+mun+ef7wX5uLqFTJcSN0JIllHSqTWYUYP3
	mKQ/G4ZCEvUwu9K1S4FZo2irEWi3Dd+p+u+x/LuqW+DUgsGaOHcxmUK6S1q/ua3+xNwGc2
	+p1Rh9q4HKz+YLcxpVPoTfITBdfDUmXWOh0JaaLn5pXht+XADOsojYutoe6P3Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 114548c1;
	Fri, 27 Nov 2026 07:31:22 +0000 (UTC)
Date: Fri, 27 Nov 2026 16:31:06 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/264] 5.10.276-rc2 review
Message-ID: <awkxuvMeuhkW-AWz@codewreck.org>
References: <20261127052100.671985356@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261127052100.671985356@linuxfoundation.org>

Greg Kroah-Hartman wrote on Fri, Nov 27, 2026 at 06:25:01AM +0100:
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

Tested 846ef7d42a1e ("Linux 5.10.276-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet
