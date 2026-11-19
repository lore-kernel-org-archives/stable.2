Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131427;
	b=wwY+ldc1A0cSSlEaUiBy99Ji7Ap7ims23LK/Yhpir8FiDx7Lo7Ex6wP34LAsVniaTPd+
	 Dm2Mjs4rI0ohI4iPbl9cQOou2wvKAz7mVhixVZzrkGtAW7z/QzJ9ihpbe4Ip1lumrFSqO
	 1SxO3oGLCzgj9Pxt+uKldB8y61j196Qk7HAb3HW4nKsuAPdKHucN3SiDcWAQFFIHa42YP
	 OR+y7XXrIXE9EFwAmu27yyIOBpIwFv3wJtiKMdSo+rQHrekI2k9R7OQUBdSq3GgzB06YG
	 yTjAuXwiEHiaeUPQEdkGvKO2vraiePDqaaBvKSGQNhSBaeWW4GaEfLGMjrNIt90lzIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131427;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=T2SMK4q3WQrDVT9Sd2M/tuVc/MR65skiFfg7F2qsQGc=;
	b=SM2KwKGjgNSTfYKC1KpyCm+sSBch/148uDsdmUyvT8sZzeg9r2C2usOzkx91k/+/ZPnL
	 /+jyXXhml87KdQXbrwehtBjZrG8W6lblNuqGnFFfm0ZuoMgVWBvdsdUx/D/tcToiYvmUr
	 ijmfykHDGJktIFOYgN3JR5EgqURIGFtWmglajPhLhcqrpuEG+g7WooJifyEJ2YY7mDy/y
	 DJ7oahvWOHyHSt1Nj7rK3ZffTunIwGf0tAwBFb0qPxmvoZa55m1h0en6kHoKaiPfgZQQl
	 lN/J5mOM/janESq0iX0irDI5yIHFfVsy6jT7lZ7FKTKuaR+kWWCDy9iOCmMq0NcKFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB560606A32A;
	Thu, 19 Nov 2026 23:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB560606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 50b654a1;
	Thu, 19 Nov 2026 15:37:05 -0800 (PST)
Date: Thu, 19 Nov 2026 15:37:05 -0800 (PST)
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
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>
Message-ID: <303fcbd7-3cb-15db-a5ba-a48d9f5063a1@aaazen.com>
References: <20261118150007.957976754@linuxfoundation.org>
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

On Wed, 18 Nov 2026, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Nov 2026 14:55:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>

Tested on AMD   amd64 12-core and     4-core systems
and    on Intel x86-64 4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

