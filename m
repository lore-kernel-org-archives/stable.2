Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198959;
	b=q8VXFtiC8UFf8xCxJ9DAKJAjqJSnjDSKJuFowBS+pm8fE/4VlGVo6KRnmUmcoMKqXn3D
	 WzreMcT4f0fFtD3TUzPDJRUnDlP5wRev1AmQGPJT6xMMuWkkDwVWqp4JE492qVoqD4tU4
	 cgzMZ9VgaHxY4TnnpbY2IeNzAFabISiFAMCqJ1d3YU0IZOjokJ641VAS+0pVmQ+TL24C1
	 1q99x5bG+LvyNjcbRnFEBJdTMkZkgl2I80SGwiyoHXkgBZf64P3cXoXw4uGnfpkgr6Wiw
	 WhwJsgWBi7iHQfG2CGzQp2GJK7QC6w7eVQvs+jgG/cR0kZjI6HjIypMFerXPH1qXLvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198959;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=2jkde0bQ5ks7RbXj+AFz+mtlYLhKUbqkJFme+5XX6Ug=;
	b=ImxbuauoSUhsMBRywau7w0aIkwNfgWi61iSxe1wHpn0jzOG+0O641PIZixGd4qrzrP0Y
	 iA/kyKTd8L+Oz5f8YbkuC1Q2IHzLCXIONjJhc78t7VcO5JwzXBso9rF8z7fF4WvC63rbd
	 an5UuFjkxoIew6qdYRfOE0OA9s8pxQ4OhZ4DzDaYX3+Ri7ORTQAqOAzXYsAJl67Ps81eU
	 50yj/6KXZEXWt9JjxKM7l4DO0VecfN7A2gFgUSo/c68XxZ+ROpsX9K0xviVKQjixH01FL
	 iCFYhG13P9H9t3JQl4WWZmkjVvR6Gcmhs7g6XS3W1mxjUJ6GBsaJXCk3lRe8MtsxC+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381B606A881;
	Fri, 20 Nov 2026 18:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2381B606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id c85c3c94;
	Fri, 20 Nov 2026 10:22:29 -0800 (PST)
Date: Fri, 20 Nov 2026 10:22:29 -0800 (PST)
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
Subject: Re: [PATCH 5.15 0000/2178] 5.15.226-rc2 review
In-Reply-To: <20261120055015.328810133@linuxfoundation.org>
Message-ID: <278ed82d-ba22-1cfe-67fd-260158b5b63@aaazen.com>
References: <20261120055015.328810133@linuxfoundation.org>
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

On Fri, 20 Nov 2026, Greg Kroah-Hartman wrote:

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

Tested on AMD    amd64 12-core and 4-core and x86 1-core systems
and    on Intel x86-64  4-core            and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

