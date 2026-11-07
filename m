Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.227.220.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080048;
	b=uycvIYlSWh8jqdVsiptoKWI32eeyfUN+gwxmtOBoH8t+k52JNA2r637Vp0ZxibHrnDKV
	 57GKWJd5lVoxeA4C0KOJK4ydNwtWVJHvel65HDWE6vuRUP89qYBNiqK4mSqcHM7+HAq4T
	 815UYIkqv7kA53bXIiVtpA4REqr/rhLYBQiZdiO6YY1WZy5+n91s48AavjnHcq8YPh6wM
	 62+SO2LdqYf9x+adFXE4Gx/W1rgmaCbkykArAMGCcZaT1Hbs8V6AMwmAy5FGG5+rRLYIZ
	 n4CubkEsh8GEZ32PUl1wjbRPU2n4P8sg1d8f0ZTw004W45+hHJVSnf8pist4B8YzoQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080048;
	h=DMARC-Filter:Date:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iSm02S9UFPqyxcXJfE/yMCdmauGWZNHUIjvGtZ/NnKU=;
	b=ZHVkqoUjfAls0jVm0OIph5zBzDxQs3WnASvo/+Hh1ZLWzkKSZFCcw48lXOh4bwDk6YAN
	 WEHtd+YIKya8CTHJToHHaoWpvJdCYqEMKsHUKwAtEKbXfyMhCeDl/8daD+70VLxAEB/K4
	 U4TTNr3d5efVcHBXraY1cSHYYx1As5hhdSL/PGdO1EQNlbGln1ESmpsaVDukskSqdyI+l
	 0nu2qLBGaKUB0DGV5FFunxfH4BoWkH8zxreFWGukQ6C1qwzt/VO9iDiSpvN3E/9Bd/sdO
	 0JUof9KFvH4BTLdsQdH0v4ab7mycUcaBBzSVI/pMLqL6g1+ZbNGlkkYitge1ioKYNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mareichelt.com;
	spf=pass smtp.mailfrom=mareichelt.com;
	dkim=pass header.d=mareichelt.com header.i=@mareichelt.com header.a=rsa-sha256 header.s=202107 header.b=33XC+mGy;
	arc=none smtp.remote-ip=91.227.220.155
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3B606A32C;
	Sat,  7 Nov 2026 19:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB3B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mareichelt.com header.i=@mareichelt.com header.a=rsa-sha256 header.s=202107 header.b=33XC+mGy
Date: Sat, 7 Nov 2026 20:33:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mareichelt.com;
	s=202107; t=1794080039;
	bh=iSm02S9UFPqyxcXJfE/yMCdmauGWZNHUIjvGtZ/NnKU=;
	h=Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:date:
	 author:from:to:subject:message-id:in-reply-to:references:
	 mail-followup-to:openpgp:mime-version:content-type:
	 content-transfer-encoding:author:from:subject:date:to:cc:
	 resent-author:resent-date:resent-from:resent-sender:resent-to:
	 resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
	 mime-version:content-type:content-transfer-encoding:
	 content-disposition:content-id:content-description:message-id:
	 mail-followup-to:openpgp;
	b=33XC+mGykPVMszVlywKf/jjOHp5XTiedLZF4e1fTb8HbS5AtU2UN3RO0ez+c1EjRK
	 DC9OnYYVTawu0zRm0NYsNQB/k4G3+A15KpSLBWaAYQw7moDVG8XAKm1zAirljB1MQi
	 eUrXHuKxKlGlyBgquCKMXEVpfPszguhHQMKCwc/rkbYMnHmchPJ7v1l01FNy35Z39A
	 9sQZ+jM4C/Afxv9pzo+puukdbjo9Px6gr3h9RjjIm72hU3Tx86GhCbs2anlG0UZG8N
	 d4kklCVB+uLztThKADVQUZVbrSSEWurJ2p3zaQVj5jXndMFuZejKhhS9M6IBbyYpSv
	 kUc6Rz5hSR21A==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1257] 7.3.4-rc1 review
Message-ID: <20261107193358.GA6808@pc21.mareichelt.com>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
References: <20261107134939.434104957@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107134939.434104957@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.3.4 release.
> There are 1257 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Nov 2026 13:46:08 +0000.
> Anything received after that time might be too late.

7.3.4-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
No regressions observed during boot & my custom tests.

I did not observe the build error already reported in this thread.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
