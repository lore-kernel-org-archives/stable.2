Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170687;
	b=USn6DZVl+MWWVmNDSDvZ0v6lVgtz2vS5EQ3kK/wIznJnOILRybhtAwkMW5msE+pZ6KpT
	 Lcuy+q83bnS0jRf8i4P6z8G8JzDjBhkCGcMprK0fb1v38LmNaBmBknpyhG7Tg5uFwO51I
	 XWwxcOcgtWo74mAZcKoXNrzL+qfHpxX7/F6LD7SA9JVlXs5VFWb87INj1UPvck8K1m0/Z
	 MOn2efiRmEDzt///JOE4AO9chbUr8LZRXmbi9ykSZhZEwW8eWS4nbk1YTTB4OESp9ahwF
	 oZYDVbZNmpT6ejaK7ub6vfAiwpqTAlGeODQFM506QYgdL4iwgdRmGOaxoL+zOyU/U7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170687;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EeExxrI1zRh+cz40j3L8RqzTVQlCLBxYSPY6T51mc9g=;
	b=HWdktVJ4ehBA/eRN8dHfhTMn8i8nYzyBsvCjbafYShR5SU+bmoDeEAqpBysPWVqNs0PZ
	 YkC/MZXO9KHx/mxKFHybTPJXH9VsGZCY4Nng2Ie1G6JXnO4ifUwM78UkQ/HuLyppxLpY0
	 j9xyPgjCQR4Wq1Thhu2kXNmb9gKqrbaBuyH4EfYHqHjR81bJlIYioW2ZUs5UqCjk/q/om
	 WDbDhrzvR5djqxbut5BIIvaBDsdjyzFVrx1dUAcqx8XYGMBFezXOcpJccu4HE4fOi529v
	 YTqnItCm1W4FIAd7XNfUjIYpNG+vP6b8JDEh3iqW2NK2ZlNRf5wKzBJh/PtgAnEqV4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=DgQBEAWY;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5732606A325;
	Fri, 20 Nov 2026 10:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5732606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=DgQBEAWY
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A11CE1F8F8;
	Fri, 20 Nov 2026 11:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795170684;
	bh=EeExxrI1zRh+cz40j3L8RqzTVQlCLBxYSPY6T51mc9g=; h=From:To:Subject;
	b=DgQBEAWYZWEaGNRmjIWOS5ryGmIYMfq5Oaq0+JNctkwAVnGwsQK5cJ/92GjHhmmgb
	 XdfcV/kRnjNEsbes1NSlzuseQa2loItzPIYdUyrytRIhwVq0arpgAvFVvv4YssqCbT
	 L/ckqJbOplh2yLmSeBz8edsy7Dri7WCXyYv2qX0hPyPkcter/Cl1uuy8oadF/WEF6J
	 jhmSItONrjZJGXT7NQZm436dSt5c6L+w2JrG9HX0bzCV0jr5Ba5WHLQknbs2C2JXfl
	 MHZzGsfH5rdBWQ8i5LGHqALEzbdQmg2NlVcpFM6NLGCa/qJ6A4KvUU2CB/Ybe1c8b8
	 LmQZKDK36mjFw==
Date: Fri, 20 Nov 2026 11:31:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 0000/1736] 6.12.119-rc2 review
Message-ID: <20261120103120.GA73134@francesco-nb>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120054951.366579794@linuxfoundation.org>

On Fri, Nov 20, 2026 at 06:57:42AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1736 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

