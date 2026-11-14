Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617163;
	b=d2VRhNXoz3evSxVrSETDLmqzbqe8NdGRDR0P5+3hEoovIOi4XqfjTuOTbSRE6bRzAsGT
	 Ad2wYjkI5JiTYo3iAnRZiP/n5hTljqUbcoKsbz5t52EOMhCCaLtDnQfAfCPum6fgw0XC7
	 fRJGO0e64J3nyvRJfWsVsihtvxsqybFt9q4AIygqa8UABfiEOpIMu1shpLn58yIkl/eSN
	 /mDTLTJQocZatRtfeCSA+gzFjzTOuySIc6uQsvXSdEuQmd+k+jPnr+4X2zNhhdRr8bmQ6
	 Yp33jJD58heHRak14ViZULSfMklzJL6TYZufSWJSfhaxs+/CJlMGr1r8s5wQlmsuZ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617163;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/SiDCybw8jPHVf65GZcmIvno7eKCQgkWIpjMtiHo0+Y=;
	b=rZOgf0vhUtI93hEXGNS7kHmjRc0SqbAm4tRdV38/9dGlka5XaPiprYonVLAhb0F5NMzZ
	 Q4oDCfsqdR9O2x8gdY8B3ukCMRcvvmOZFq5xAeAm3MLmg2InlcOcQrm7uO7McJXbf1atJ
	 KZoL9elPYOSn6LYVi/QHNShvU0WovRaKlMetWHESBdT8mSS8KdloOqL5tV8JyPs/6dKc4
	 ElRvhjS9VONtF25TrteLKo5P7sgMWcImPwWEHEZtoXE4rzNGMmIg8G6iDsM+IUEJoQQLy
	 wPBciScWoc9JRybjFei49AIPk9V5jna4Nt7qi2P2LtUkhrXVL5vgmLdkXBfIEUtjVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=t7mUBKM7;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7F606A333;
	Sat, 14 Nov 2026 00:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA7F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=t7mUBKM7
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4DB6B14C2D6;
	Sat, 14 Nov 2026 01:45:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1794617155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SiDCybw8jPHVf65GZcmIvno7eKCQgkWIpjMtiHo0+Y=;
	b=t7mUBKM7e9BbO4dfvQbTq287B/MF4lIGfZQARo/Svx7l08GorgRlgciRiRj2mSjxOF2wom
	p5/KPlyJYWgSnkMmfOHy5yQzV1revYdtFmlXU4d5+Hse3B6AC1pxd2wB2JRm24BYVFwLtR
	LwJ2hTQAGVaM7rQnAesQun3nlP7wr3q37vss1rAF6T94s3mpjRRsAAzkL81Is16t4ot86l
	MnckxCQpgwYz2uEa3gjjsh4Dw7IHvluS+sW/2SeZpyvm0pjb+h7YtJlqgqIzOzj/we9zSe
	1wgiUQx0pJyz6qzkCGPzKhWKKfYq7nT9Tpfha667jDao1x012dVg0WHhvxC7BA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e1d4a223;
	Sat, 14 Nov 2026 00:45:48 +0000 (UTC)
Date: Sat, 14 Nov 2026 09:45:33 +0900
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
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
Message-ID: <avevLaoiiJBQLbh5@codewreck.org>
References: <20261113153811.177190860@linuxfoundation.org>
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
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>

Greg Kroah-Hartman wrote on Fri, Nov 13, 2026 at 10:42:44AM -0500:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.

Tested 8ea1fd6d2bee ("Linux 6.12.118-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


(BTW I had missed a BT regression (Failed to start listening:
getsockopt(L2CAP_OPTIONS): Not supported (95)) in 6.12.114, already
fixed by 6.12.117, so tests will now include basic BT test from now
on...)

-- 
Dominique Martinet
