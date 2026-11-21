Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224576;
	b=J0ODCgfYdmna+uaQlJSIXPERC+aKMx7wiAzbOJBSFmL1mptYQjg3hliokRhUX35Lz/7r
	 9+jhsS8bY3lOftEgzyV+jxs0Q7HJjcLLqWfuM0hn1KxwXARnInGlan8FHxLWgo1EmTI83
	 iZl/Q4cCW26hSU84QuAPQR+Mb3VOXYy1edzfYdWE8hKnB0pQOWQ+3P6D8UNeJQMe935TL
	 McJlzxB/G+VQk94q679WkqNDjSKsICsHkhtxiy+NpAakwMcwuszf/q5CH0M3qKBh6Swm5
	 zFboPB42KOG+KCrOhCzGZhLuGJN6tlW8djmJEVRTnzwanomtCCuBrlyHNZmV2LtPZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224576;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=9FL9NdAaHkUAR72XW5UibBcROfDZ4xitgUbBNOiHdmc=;
	b=hUVlhSEPgMgyUF8n2eoQD6/a2Lo46Eiryb6gL4IPBHEt8dpOHW9ZeZlQJ5XC3jLAp8y/
	 Rd2aJela1/sEtXH30OKg1Sq1ZZxICDUsfevSpiDK9u/j/2U0SxE5b6/2VJx/F4R4XuDGO
	 h9skkgXw5Hby8b7qvkZNknbaUDllktV/04dmKRScSoNp5+BzbtDi5vxT5PSidZdDOqo6Q
	 D69F7hls4+/DXfR5+v+fbi89aovXPKTWoZ+8SXH0v6aWnD9pGSTwOVkzF4CsUj5WivgjE
	 HKnAKJESXwhTj8JriUlk4J7WMu2XnOMzp9U3vDfu4tI2+ejI4A2zUsQ6rKRfb0lItQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B6606A6A4;
	Sat, 21 Nov 2026 01:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5B6606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 4903d535;
	Fri, 20 Nov 2026 17:29:30 -0800 (PST)
Date: Fri, 20 Nov 2026 17:29:30 -0800 (PST)
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
Subject: Re: [PATCH 6.12 0000/1736] 6.12.119-rc2 review
In-Reply-To: <20261120054951.366579794@linuxfoundation.org>
Message-ID: <46e267f7-5027-a34f-aa43-3d70ecc991db@aaazen.com>
References: <20261120054951.366579794@linuxfoundation.org>
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

> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1736 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>

Tested on   AMD  amd64 12-core and 4-core                systems
and    on Intel x86-64             4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

