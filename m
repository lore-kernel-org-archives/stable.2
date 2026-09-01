Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89883ED3CF;
	Tue,  1 Sep 2026 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228092; cv=none; b=dunotODx35XMvbGfAM7zMiJruY1HJMFCsY12z/B7wdTDUDsvBZieG3eB3DCmMV/NG6hqxvBSds1OpAoEXPRt8QpyjXXSWLAvXLYUDIznfxMf/eu+ajKIxCQsrSS0xhoMeI8jHTzm14MiLyxRJxrUz5rKDu6s8n80sSkTCBQScao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228092; c=relaxed/simple;
	bh=U542Zl8DrpTSKiD7Vl08RBiPf4XoZNiETIdq3lf2hgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncs65r1R0gmDYA5qSg3GgnrSH32fKxpB2F71XZrorfaf135swag9VpLzQWbtcc7eGM1Wai1Vyhkrqo5zmjvhkPrf06nxdU854eqM8kDWEIeYVGcZ2IwfOEMssiIJU/MmTmxw8RtzAJjq4z1XacOTt1O4dyKq4XAzDboMi2avaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UbuRoSzh; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UbuRoSzh"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 82FAE14C2D6;
	Tue,  1 Sep 2026 04:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1788228081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPRdSeS8EOiXys9ZT+0+nWiXYFNZ3KrDQtJikQUjLYM=;
	b=UbuRoSzhwov6bKR8a9Sc909pmZUvQCF/XjuqpCRBLzlIfW08VA77nro/vcaasc+U8Lrznh
	3keEFfNd3mbLFXaeSKD39Rzpg1Qhg0QQW2dDol0ih9/8mgoZ7aTonzAD2J6JbwVhNfboSW
	7cb4nN6J7aLtabqhvYm7lV4+kI4ze0Z7ygYxQG/nTUEHUFjQ5V5SsdpuoSI2ZvoPpt67Ee
	XVuAXpQP7cSpSKkVslzqabIjXeX7GSL4ib9DZceV/5auBwNmh57BBE8rg0rS2v8AzW51FE
	tIRQFW3clbLrMhr8Vzija1qDgSLPcOBOOgn8/APw2XExczgqApACbLEgDqZj9Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 309e12e7;
	Tue, 1 Sep 2026 02:01:13 +0000 (UTC)
Date: Tue, 1 Sep 2026 11:00:58 +0900
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
Subject: Re: [PATCH 5.10 00/43] 5.10.269-rc1 review
Message-ID: <apYx2p-uq60KlnBB@codewreck.org>
References: <20260831133358.571886287@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831133358.571886287@linuxfoundation.org>

Greg Kroah-Hartman wrote on Mon, Aug 31, 2026 at 03:35:08PM +0200:
> This is the start of the stable review cycle for the 5.10.269 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested a5b83a2b4fcc ("Linux 5.10.269-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet
