Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170724;
	b=Y6BKqmNBiGN4zsf6e3tX4ArMdT/sM1zMITUY5U8VMDloU+/87xD8vO56GwdxwQDF9YWZ
	 WLB0KYJ5Rw/dsNo4bjRRsLxWvyd+0S2fvR6Vn1xK5DzadDaE94sgVroh1ZBIYl/yd6zQK
	 uS4S3RF8PfZH1IYtZcunduVbH2XHeoetByjyvAVdQvO5faOnGJU080MJXWXpT/bYnYox0
	 nYuBxjSWwZXR7T/RGY8AA3x6O2as12yGP05vAoyQrM3wrbVvxtJ551Ljzrg/tPfSJLXqD
	 N4C9GjIQEpVPgscZOJ/GsUNGvowPs9fYPXBcZmOGtiQctt+u4gnhpieWqqfkLj3YPzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170724;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1LPDA2fCPhySycfbvn9IXhVWQeuIzUpOeftXOxOm5Bw=;
	b=JCuzVFnIZdKbjMQ1ZPeKmKbEKZ3xh1w4pdxx1L8zj2Sr0IF91Tvhbi5lpmrCRhhWoawC
	 Ofai5qOu84rbqD/kk3AxZXmOK4XUzo7qOB1cxVd4fEMpAzU2q7Vyg7xrnxcsAm742p7Db
	 9vEiXuw505hxgGas2Jv6oo5cvjt2YH0jEn4HSY5ZHuFU1exIgIfc8J/svzt+tyHTmCn47
	 T+Pvg9Lgo8c4uT7X+FUFz4hEA3QVba27K1pT6hbDeb5/VGpUgnHCHCWFrlIgQlSrv59x3
	 C4cd0S1dpwBBBfv4T/mde63n5iKQNFEV3QZ3SYN3QGTWwkUBCk5VOuCLVeQIOZeIhXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=PGCCyEe3;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6F606A325;
	Fri, 20 Nov 2026 10:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D6F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=PGCCyEe3
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DFBB21F8F8;
	Fri, 20 Nov 2026 11:32:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795170722;
	bh=1LPDA2fCPhySycfbvn9IXhVWQeuIzUpOeftXOxOm5Bw=; h=From:To:Subject;
	b=PGCCyEe3IvQgVY+TuufF9SeOQmahjME7Pkg+ltHFWCOtJ9TtLgf+W4ZeuUma4Rdif
	 UfbmRcsssgPZFbAuucb6OEjyI+a3S/HmG5E4vyl+da73BbjVfwJBUwOKWuMk5Z1KSS
	 +irgbGxsuJxnBBlcKrqMcSMZ2oPtkqDljkxCTod9LyLo3eukrkQ9mXGXUPLEQit5v3
	 Cuxf/pLam17mumy+IPl+NuVxkRXknhMfd4GGpAzo0OB7C9Uq37E1s/zI3dDgc7mm65
	 qCpyrd9pxp6lm15W4MuF0uD4wK2Lw8xEJ9amhzX8kWoWSvQDDujH5J6FOirVvw1gTo
	 9YBBjYSRk5CQw==
Date: Fri, 20 Nov 2026 11:31:58 +0100
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
Subject: Re: [PATCH 6.6 0000/3308] 6.6.163-rc2 review
Message-ID: <20261120103158.GA73481@francesco-nb>
References: <20261120055324.975889935@linuxfoundation.org>
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
In-Reply-To: <20261120055324.975889935@linuxfoundation.org>

On Fri, Nov 20, 2026 at 06:57:58AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

