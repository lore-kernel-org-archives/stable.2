Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737996;
	b=lNEdb1aG4N0ExafqbC7o7Zl1q+jbkHKnTYeIIZ2sQ+HoagIpxNFB//INtbcuo4wv6dTa
	 co+lHxrMlvRB9b6mBCRE8KCQoAIKMTq3R+zwnmBYxcbSRkAdIBJq7hFKHYBrS8lO+IHNo
	 b6tyk5rPQ/MuQLSOqGgfBH4FcmQzanaHyn3U3cvljO4bBFWNAv1weECteUD29TYLwN63p
	 EEIlH+w67Ew9LDJ86aJXZqOxRjzp2TRU7E7Yjjgur0ZnrUMdKMixXntjeF3AbiMCXDD9H
	 NqFcFC+VuVYEI73YrltsMlbEBHvIRg2SvklkoFT8ZbJBS6kRH4tx1a6sUEfbNgsdhLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737996;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=g/UJ7v0tCb57TrFBa4mDGQ10gY4hp1sR90rabdB2JT4=;
	b=IEKoYoRORNxY2XCE7ihPXK5JIfzKLhJsBTF3diJ7z0cv4BUmIz1fAstfpX+aRVI1gupZ
	 KzffL2qN4OghxRCQv1sxQ+wEOYUGr7UnqPlTukDvkmLH+Zez1OjJcF3q+0weKN9Qvrp1B
	 Up1zbMK0C6nihnjCQRVlwayUgLbCrXf9wuRNAmkL7yNY/Z/HUcHlQFjgKv2NO9WyjLYR+
	 vLI/Gjivb+U6oin3LKI7nbOW9mmsEDZos12TnHNmWJDtGQV44e8CAhD/dkldDpgqkYpik
	 E/JAUs1XZ2D0jFjWJEJl1y9LyAEKEAq8+p/B/bPmKvJWgJfkJ522dSRwu8hNtzvtZ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA720606A31C;
	Fri, 27 Nov 2026 00:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA720606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 2572856b;
	Thu, 26 Nov 2026 16:06:29 -0800 (PST)
Date: Thu, 26 Nov 2026 16:06:29 -0800 (PST)
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
Subject: Re: [PATCH 6.12 000/815] 6.12.120-rc2 review
In-Reply-To: <20261126105709.009001842@linuxfoundation.org>
Message-ID: <207e54f7-cecf-1322-73d8-595c2b676148@aaazen.com>
References: <20261126105709.009001842@linuxfoundation.org>
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

On Thu, 26 Nov 2026, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 6.12.120 release.
> There are 815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>

Tested on   AMD  amd64 12-core and     4-core systems
and    on Intel x86-64  4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

