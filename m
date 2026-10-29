Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317853;
	b=Vsf6CwQaSkeYCtumzKdTn1kZdCbCrSu6Px4LHTDhGetuLnP+oaTLQZWNOheSI029LDwT
	 vkLzBaZpoN5uyEZYbT3aRDpydxjYt0Zec83EtdJBsWZq5+5ZL3vZJFlHNGs+ic0g/6FT+
	 KdjF62DSdNN/Iijc9BXguzGQmEy1a8nivdppBzdGtPQ1c/4kROujrsqv25NXyihYQL03I
	 nsd0wx2nkRs8SZk3WoeF3QVMiiFKNIuFBuLwLfHTxRgrOibmDmvh4dF28BJLp2MHAL5iR
	 rab7WbkM8tbNAjqMlrw6wwyt0H6ki4Ge9DoGOYBlFA8291dw26j32L4eOilwjxILwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317853;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=1eLdkJnMzIEbO62c9IAvfj06Rwm36zqoWEIVBGBlwoU=;
	b=Do15NDz8Uf9AI4+nBNgXEmA5aknd0VvDpJf5Xd1EwVMl4Ifmwl88HJd4H/XHZZ7flYnf
	 t5+Agx7TndrZH0+gdFVxAQXUlu0WNdxQzbROPiq/nuz3rZtIC/TvyxtnAVWBjJeEZmkCi
	 vCibQxe7JVd1k9tDXW4caHAHTSsp6tywUCC67d749LBwJ4WaG30OeIRnbJArWcUgjMBkZ
	 zzgScJ53UJAyYb6DjfOj44y2JPRGRmSDJD97EtkTSQPeD3z5iYPBX49YY4kgOt4oM6qcn
	 fzPZOiBOi3O0xAOFPUkZ89cW77KN0sf1Mgx6eDJ6J6gLEVu3wqFTEAfN8MSoaTutVtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A6606A329;
	Thu, 29 Oct 2026 23:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 216A6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 14ccf7fe;
	Thu, 29 Oct 2026 16:50:41 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:50:41 -0700 (PDT)
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
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>
Message-ID: <d5121766-60dc-028-f7eb-dbaafcfb7ca@aaazen.com>
References: <20261028165947.349197979@linuxfoundation.org>
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

> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> -------------
Tested on AMD   amd64 12-core and 4-core systems
and    on Intel x86-64 4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

