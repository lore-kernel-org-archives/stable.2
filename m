Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1368352C5B;
	Fri, 21 Aug 2026 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284601; cv=none; b=LsbaSNspIUFtL6zB5PMfO6GtyzJ68yZCTPuWvkuQHtlZgj0iE0BEYC+HfInV3uW+pk9DCd6U+z5ri43W5rwkxyD3KJoj3lAPLCAY/6pbtzUlCIoMl7sJKu+pmp8LoCl6WFYA8P1uXIz2WSzfnAWBhX4aWsdiAGG4Cz5nHRSz4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284601; c=relaxed/simple;
	bh=Mio9aRjQiKfRZjEVf8fwZVNU0GrjvGTKoHUV8yk1FNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAsAW6Etvxi8WoosRH537d/NdzQnBALGgobGIxIhs6a3g7vFdc9LmDOWfUPn1FQWSC5wtXtIrbx0OgnruV8WvmjFg/fvCSQ2BGrNxQUV95ahg24QKj3ySVOUYo8N/gpA5Rpzfj0+2P+3YY+S4OltFUnr0ovXyVyOpKI1ywde/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=kbyv/1Sz; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="kbyv/1Sz"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 358AA14C2D6;
	Fri, 21 Aug 2026 05:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1787284596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q56fFCu27vRPhmYPNDcEL/0/ueRTOU9jnx2p871jUns=;
	b=kbyv/1SzrfDZF6lGI+qc2SXKb5fumftejAwRihrh0HukuUQD4tbRmNNsSsPrEh8ukSNDGK
	erUYRLHPUUULPuvLJEXqbG4F6KXHSlTnuTZ3nSQIgIwDl8Y8Vbs8KN5DJSWfBVqiIE+5Wv
	uTyu9PGEXjB2mteSWY+8SITlpdVUheNsf3J9BjMQvMpdLYth9uVqWTv0gK+srYlE2rs84o
	ISsPRNO4rUtr6UMikYup7o6RQtQfitEzi90lP8qX9bbmr4qA6V6ocwa6nk3/U4e+OqyTSd
	htHJfj4bZ61QVHj35QJRIln13E2+xTSsKpd5BHuR6XOr92gh5vau+4ApvOYsTQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c709158f;
	Fri, 21 Aug 2026 03:56:29 +0000 (UTC)
Date: Fri, 21 Aug 2026 12:56:14 +0900
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
Subject: Re: [PATCH 5.10 000/235] 5.10.266-rc1 review
Message-ID: <aofMXtanMtymerrW@codewreck.org>
References: <20260820145216.426568665@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820145216.426568665@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, Aug 20, 2026 at 04:53:56PM +0200:
> This is the start of the stable review cycle for the 5.10.266 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.266-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 7ceedcd42fa3 ("Linux 5.10.266-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet
