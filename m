Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674273;
	b=KVTyRbDsEUSt7LGmUnQyIbByB2Hku3LTqqfdwm3N7WigUaBW6QKvRi0T3d4uBvGUUmt0
	 M/bI671/kiQkGs32BkU5/4w/1GqI+UWZ/dNHPoDIYUVienY1QLT2WYGaM8WAnv01fxfkm
	 fcYnOWQ1rd6/k2k6RK7IWJILJRAqeBXIdohk7Mxw4v5YxJxxj7dnlJV1PvHC0DWsylkNT
	 wLHnE2mptWF1ZDg+LicJZdB8yEG3ox06mosEUk3EY4PlEJVO1bFeuORIx+ataorduI3vG
	 ocNDhGW4GolFE7uKn2clrCr7Vs5CNtvHgMrcQWgVwGRM2/EWuFH/KVuAu/vdrwyYppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674273;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=54Gr52l2TYE8K41+i/7jlgfFtHwpt1TqVfCkux0de5Q=;
	b=mJGcMIY5jGC4g0ih/40T4Xg8NZs1KE8/z39f28oWexNGMiYfB3197o1fG83Ga7agJ2IG
	 HCc/CEdi62+QAzPZDqg7CXOf6bhpF6P0Mr3hult930RJ6YzBgDOrHBV2LTfIwETrP9ul0
	 YIvF3POLD7p5Na4oz84oAeNn0Mpqon9Iud8tEZj82Lkp0Y1/MynrsCHnnPmcmuA/iq03j
	 OQfvb3WndOp6RHtNBrfPoo04w8Z12LD8D52vdmNdGUsLFMqefkhZkjGsQmi3PYKtPcUBc
	 GpNJIs/WvhYkD7GWTWjY/F3pR/OAa0i+J6BK5OdkREZi+ys8kC8c7Z3hG3tN3KJHZkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=A5GSzsYV;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2B606A321;
	Thu, 26 Nov 2026 06:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF2B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=A5GSzsYV
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jZmjM3PxSz8txw;
	Thu, 26 Nov 2026 07:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795674263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54Gr52l2TYE8K41+i/7jlgfFtHwpt1TqVfCkux0de5Q=;
	b=A5GSzsYV5F7cxfaqKo9VMJQlSCwz02VM+yywBG1eoNEDgFi5GisMOszZbpKPU+VdOSRBOv
	sU0LqZ4o/arXqts/A2jdPYCjoTe4l4pRz8v1jwrZjlz5zpeE8DZaswHGfn/joRNWDKgdgp
	PkLm0Bo+fKbRh3IHctapS+7cFzzx8B+IfQgSjTfp1aB/FbT13PyoqTZgwCPuAKtJltGYsa
	QctkjB0b9FGZ3Mx+quXZ4WCEMyLRWhx2IHvnUgjEW7H8yQbFNH/XWEhtCB2a7yldcz4F2t
	EjN9fQOEZYX/17sVHO3HTsBliXq7ixpJSb1nsIPTYCLh7zxjYREAH7kTTOY9VQ==
Date: Thu, 26 Nov 2026 07:24:21 +0100
From: Benjamin Boortz <bennib@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1005] 7.3.7-rc1 review
Message-ID: <awfQdrf18IeLxpOT@bb-82jq>
References: <20261125143821.729802100@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261125143821.729802100@linuxfoundation.org>
X-MBO-RS-ID: 4dc762b175a24d5dc2e
X-MBO-RS-META: qsbj16bmgfeeyqgahx3zsdrj5rc9ir3f

On Wed, Nov 25, 2026 at 03:22:18PM +0100, Greg Kroah-Hartman wrote:

>This is the start of the stable review cycle for the 7.3.7 release.
>There are 1005 patches in this series, all will be posted as a response
>to this one.  If anyone has any issues with these being applied, please
>let me know.

Build and boot tested with QEMU for x86_64, i386, arm64, and riscv
across multiple configurations, and boots on AMD Ryzen 7 5800H.
No regressions observed.

Tested-by: Benjamin Boortz <bennib@mailbox.org>
