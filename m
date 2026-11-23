Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.59.206.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425537;
	b=janRbQSBH2XbleroN2lC+GYpAN4qI9/78ld08XILLMVoQr3jMm59uXrofcgghyL1cmEH
	 4cwCKVMnBwWW/tHUjHrTRYN7m3C5Ah0F2IXY4o+G7bzxvHfBkQ2Yg4zf7fwOMfhE1XErw
	 kCDq2AcXmrrt9kQKXSokg7kF5o1JIfwCzcffOTvAlLyWZKoFXWGfBsFihqsFjj/P6Vvyx
	 bhkPADaTNEIERBjKiIeuz2FA+wO9cmf+ywHa6M4sEDwrL7+mpKUl19xgQFInTmyWlQynk
	 eR9pkCHktnjNcdTtkL3rsfSsIOlFIAUa/cHAZovnddV0y9EwJR2jrI8T7PEQPubOEZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=OuTEDuBHB59rO36y9llkCDKA9YPqH85DccZ3EaJq530=;
	b=Sto+WBPSJ+cgriOf7HSCfTcQlQCuU0+MMeg6jFMBfEfk3Va9cGgDLdNLTXyJQRgA0BwJ
	 tSF7ygIMLclZHkun/rVy56hW7QN+JmFKubZKNEH4OM8Stj3X/T7NE6Umhp+WLdgHS8Nm+
	 I7iQyq2JPyf0PLjIihRdS9C6dUuNUM25H3mF9qCkdglqOL0+bMX4bENi+zbYzS+wPQnN8
	 urcIibJQESuctJtp7FW0SizfEANLgYmHiazLb0AlzH9HGq6jTbmQQvuIayf+rxUnCpxN/
	 sQHqtuIyH37jR0cRJQQQEuv/mq7fjYnf/CeaOZKtc/lt6S1ibQcj4MLDYEk98daXY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=kILhswpa;
	arc=none smtp.remote-ip=194.59.206.189
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FA606A333
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824FA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=kILhswpa
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jY0jG2mBCz46HP;
	Mon, 23 Nov 2026 10:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1795425490;
	bh=xX5Udpo1q4gDScsKkPOPRj+AHheXe+uDdFBrc4m9Jlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kILhswpaGeoKJl76EpqwaAHDah4LiFT+4Fj6bnch9OS05edz04LsbdJYzvm8Dnexd
	 B9pZgJVAOKVImpTuJOyyc7+UkrBipCorcNY/5/+PglSnUSn8T2K4HTL4GSxQHeWkpD
	 X5MKW7GgLmDGv0xkzkt4ZGeJjT5zWIhlMrNZIePltoyc4UED9HquKM+hCU6/IBIegI
	 fUH9FgcMv2myV+dY6yau2K6aPkUS5yQEyzLPlkSpznaMM5Y1Ix4s9I8tD6VZw2a2IW
	 BaMIWF0wpFrjOlTDJSe6Ue8+wDvau4pgsw8iZgkpyZKp6IM0H0ZH7PWNr0N0mYEi9S
	 WLKFbmFpEFb5w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jY0gr52Wwz7wZw;
	Mon, 23 Nov 2026 10:16:56 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jY0gq3JGPz8svf;
	Mon, 23 Nov 2026 10:16:55 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id F0DF75F837;
	Mon, 23 Nov 2026 10:16:38 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <0f43f2a8-f744-4ba6-9249-40f350b6ba4b@leemhuis.info>
Date: Mon, 23 Nov 2026 10:16:38 +0100
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
Subject: Re: [REGRESSION] Suspected amdgpu graphics regression on Ryzen 9
 7950X since 6.18.58
To: Jeroen Beerstra <jeroen@beerstra.org>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
References: <729A37E1-250D-469B-B89D-E24DFA4CABE6@beerstra.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <729A37E1-250D-469B-B89D-E24DFA4CABE6@beerstra.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179542539930.1220959.6543591146387798688@mxe9fb.netcup.net>
X-NC-CID: L+GCgSx//zaUOVSIoD6C5t8ZGopIgxHeMNnucSRhm6p+nqNeNiU=

On 11/17/26 13:46, Jeroen Beerstra wrote:
> I am experiencing graphics problems on AlmaLinux 9 using the integrated
> graphics of an AMD Ryzen 9 7950X.
>
> Last known good: Linux 6.18.56 First known bad: Linux 6.18.58 Still
> affected: Linux 6.18.63

Hmm, nobody replied, so einer the right people didn't see this or they
have no idea what's wrong here. In that case you want to bisect the
regression, as explained here:
https://docs.kernel.org/admin-guide/bug-bisect.html

Before doing so, please check the latest 6.18.y release -- and if the
bisection comes up with a result, check if latest 7.4-rc is still affected.

Ciao, Thorsten

> The symptoms vary between affected versions:
> 
> I first noticed a hard lockup when I powered off my Windows 11 kvm
> session where graphics are rendered to a dedicated Nvidia RTX 5080. So
> the first suspect was either the Nvidia hardware or kvm/qemu. Later
> the problem got worse and I was unable to boot into run level 5 where
> my onboard AMD graphics for my Ryzen 9 7950X gets activated. At some
> point it appeared my system even needed a cold boot to get in a
> usable state as there were hardware errors unrelated to the graphics
> at booted that prevented the boot to continue that disappeared after
> a complete power off. I think this was with 6.18.59 and 6.18.60 but
> not completely sure. Currently with 6.18.63 the problem is: hard
> lockup when I power off my Windows 11 kvm/qemu session with the RTX
> 5080 in passthrough mode and hard lockup when I end my Gnome session
> in Linux that uses the onboard AMD graphics, so my primary suspect is
> the amd driver. Because of the hard lockups nothing gets logged, but
> I’m sure there are ways around that.
> 
> Steps to reproduce:
> 
> • Boot into run level 5 on AMD graphics • Reboot • Lockup
> 
> I currently use 6.18.56, which does not exhibit the problem.
> 
> These kernels are built using rpmbuild from unmodified upstream sources,
> without additional source patches. The RPM spec is based on ELRepo's
> spec, with local changes for Secure Boot signing. Secure Boot is
> enabled.
> 
> I haven’t changed the kernel config or firmware in between. My setup
> is: • AlmaLinux 9 • A custom build 6.18 kernel with secure boot but
> without patches or other modifications • I have kernel modules via
> dkms for: zfs, nvidia and anbox. However the nvidia modules are
> currently completely disabled at boot. • System has 128GB RAM, a
> Ryzen 9 7950X and Nvidia RTX 5080. On the Linux side I run the
> standard Gnome that comes with AlmaLinux 9: 40 on the onboard
> graphics for the 7950X and at the same time Windows 11 via kvm/qemu
> on the RTX 5080.
> 
> Willing to provide further details if required or perform further
> debugging.
> 
> 
> #regzbot introduced: v6.18.56..v6.18.58
> 
> PS second attempt, didn’t ment to send a HTML message :(
> 
> Kind regards, Jeroen Beerstra

