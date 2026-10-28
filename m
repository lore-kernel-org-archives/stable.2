Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228394;
	b=ansTdDMA1Re7G6+Ipfv2sPU7QkBdcAlGTeLx7MlrrR/jlZETTWNxPo/mDhUooWT+5YHo
	 V8lXaBdmvTbOJ4emnMnBFH/I1Y2AgbaGmvbcwR9sKUhqA7Shz6mfyU11GTRtW7PEQBgF8
	 WW4pzS++4/n9dQ3SdRwtk9ScwhT4BxZJfkeu8lhtF3y2Q1GhtiPEIvm0mnc7qm1xn+Kdl
	 zMSEXMrMo3OV/P30B15TfBWB3kVKzTypmL7vF+/+JedBWUw/LLs22VJOoPJ6ZIsyVhwFF
	 H+ljO6S3/RSHwZMGJl0HtwzT/YVIvuYRakKipUNQn55IgWBsNJkhp5WacNnl4uU+eeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228394;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=ZnYCK34Xz7IZYtTASnBAQeSR2jtkJfs0D+rbso7dODE=;
	b=bHEBVsylZLcWtIOom74PEtZ9Byft8FBsZmhPYzi+z2oi9OHbWN4Rg0P+1+MWPoh5YNy3
	 JXN23zo0Qcyj8tmNL632FKk6hdCWSL+F3MpcG5sLSJi9t2X2prFBJNPgDwsWGwHlJeqlS
	 +d/KhQcIMO/5slsveGZLY5TuGZByyhDegjoA6E1JuXEQSr1uMI94lO52XSqYaujwj1YYB
	 51TBr6r0lF27hWHDK+Ly7JxBw1uMzEisHhVh1vMF7oyCL2oiP+s+EcNOpz5+xeRhe6+6M
	 06uYkW2PFnjYO/BNUxL0fwrqyUfadPMyD+DC9DODvMV0UjGWEpuoskR7kA23QKwWP7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F3606A31C;
	Wed, 28 Oct 2026 22:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id aba075cc;
	Wed, 28 Oct 2026 15:59:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:59:47 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: stable@vger.kernel.org, patches@lists.linux.dev, 
    linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
    akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
    patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
    jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
    rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
    achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/571] 5.15.224-rc1 review
In-Reply-To: <20261028170008.009143722@linuxfoundation.org>
Message-ID: <6b5e22d-fe0-9171-9e70-8e1016cb82a0@aaazen.com>
References: <20261028170008.009143722@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Oct 2026, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 5.15.224 release.
> There are 571 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.224-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Tested on AMD   amd64 12-core and 4-core and x86 1-core systems
and    on Intel x86-64 4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>


