Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071642;
	b=IjLJ1Kn5pH6i5/WojmQPwK+45H0godu+TAx/4q0tX/2OXety+rRrCfeKJG17lvm8hsNl
	 ki/zJO/eyScaVbeeI+CQsOLCv1sq+Onr8LJYpIO/wsaZUSMdGllvreNIcOBG6SKKVs4L3
	 Uh/cePnnydYOMgmromX/dJn2kIeH1Ns8gBIDoL86B/cmZJqd2IyypAC3GfQh+YhN5aDZU
	 OSltDgqdjsuiFYtTk0SXr45rADoKJRz3OgOO5qCZuTIoLSXgZu/Doj85zE6uVUYxfjy2d
	 AfX2+t8YNBQFwRtGEWJJjzxUH9Tv19GZb+3E12s0PMzVUO5uz9dHwQ/ddP6pni+In4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071642;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CoalCSWaK7sUy1Q08keHxSpIFcytLs2vQWDZRhflLgE=;
	b=AEkYTe5JHHUkgCtwhtJbDUDQ4rvJSzOyCqb++U73VCOv4DUBznGWLuvu5vt3ropY+Cnm
	 2IE3kTSjoLF7gi0KUu/nsK0bagAb4BWXEa4wsMzzPUrBATgLH6D6dehP2SGN65Jhj+UMP
	 Xh+MT5Tlj8TPf+huEDE//yDs8x6cWm5F1qCiY7jaRiy5Lajpcoit5kBJ4mghi9JLIAkiV
	 N2YcGzxECHRwmUPBoL4rEkGe2Fe8QOAW8xe6Dq3rtP//nDtyz0D8kl24azvCuduHiFAqS
	 kyQQ7QXsOogsshBzoWw6l4erhsNfXM3R7sLa6JY0iRbh5f3TCOZ/ZsWFmipQyDe3glg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ozOdZDtS;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100B606A326;
	Thu, 19 Nov 2026 07:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E100B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=ozOdZDtS
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 51F7414C2D6;
	Thu, 19 Nov 2026 08:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795071636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CoalCSWaK7sUy1Q08keHxSpIFcytLs2vQWDZRhflLgE=;
	b=ozOdZDtSxzsHCpZg1qYi89sUmdYKyMSEehdJlI8ULvM/ueL7G1F8ex2ZmIJrvlr+oKQbkz
	wO7WdYjzCfBDQr01uz+QCMZqqRHiiqAyYp7gYvMWgAmYSWIhSHXUoGFAm98OBj3MGdczwJ
	8Imu0fkgA7b4vEhW/ct6F71GroSHXdOtHdPGxBAlMnYMZ66/xmFgw0r0dQCnMYuwmOW8dR
	eRQb9rJ1rXJLMUN6Abd8wgvugndf2PBysrMuyu1ryzkvjru4D2jj3XPYy1CowWO6EBUt5W
	IWPbKxgMd9OGCLMmXqMxSZS0IBXAitPC+lCjd0fUkU6gWECCqtQCphg+GEzijw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c91dd502;
	Thu, 19 Nov 2026 07:00:28 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:00:13 +0900
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
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
Message-ID: <av6efcmCVIhqCYZA@codewreck.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>

Greg Kroah-Hartman wrote on Wed, Nov 18, 2026 at 03:35:27PM +0100:
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


after reverting commit a8210490583e ("phy: freescale: fsl-samsung-hdmi:
initialize default rate"),
(I only noticed Francesco/Vinod comment on the 7.3 tree to drop the
patch now... FWIW I also checked fb output works on this phy, both with
the patch reverted and the extra deps I suggested)

Tested 52008ba8d06c ("Linux 6.12.119-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Thanks,
-- 
Dominique Martinet
