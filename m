Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142854;
	b=FqfJCAOlzTzxcctOVr/Q6OQbUD3qVYjdMrp7v8D/G4wFRuf3Uec6BfgV75fz9+APNi/Z
	 YifudTWpnwk8ZDow6G3/HL/4Y4sUCww7wx+oz1i7GxiLGw8y2FfGd17dn0zDwtnJ/9Xqo
	 YF3bg5UzKhwzmqv8sCATg2wXAjSYD3sl4EWJjm2dIs0QlrByXAQvYCEsTRwg8xxI0EsSz
	 rFgU5JCK3ZczyU2ELPe6h3FP2ETbKvx/Oq6imy26sdHus9eG3wEGSf6AGDC89PfR9vLck
	 ehKu6f2vodGs64et9vvgNHmNb65d5SlXjnpyTxckK3NfPCxzHB/H6UgMBuGynWpI7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142854;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gLkYIAzdX5n+E2UDbvv2hp4q1FOusklc4XvJW1NkNM4=;
	b=aYatmF12l/BP0ycqf0ejR0U191O35KQdkWDTgKFsYB/QXsUZXGo/XQvKaUxQwjPzBqh9
	 3TVVKz96aC7hWb+h4wbhQgFdQbqQC+R3SlfOE0jcNcQDx71jcoDVMmdKXVIuUkYUB2dWn
	 CvGskFP5X5pgyPrTX6QDB4G69m6G5KI5pch9aYsxEXObcYtzVi12r9HGj5XlNadpimUnN
	 QM5b7/iAOceEb7Y4V0FEN39F3GYAanbCCelrR9Ulehng9i0LEggKwgxk6NLDR9SBaNgl9
	 ZmXaYHhF/LcrJEpcDyoG3do7cjPJngdMnh0xQwg2ndutWEShQ8Ycd++HMd5aGkX8BUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=FXB14iHB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h4gN1SYj;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F52606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F52606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=FXB14iHB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h4gN1SYj
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A5237A0307
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 21:47:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 21:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1795142852; x=1795229252; bh=gLkYIAzdX5
	n+E2UDbvv2hp4q1FOusklc4XvJW1NkNM4=; b=FXB14iHBoQ645Ulm6SOw4oFBLs
	lGZywz30jAn/SY1vjMKEVl/wPeEB5mMghiLXWCPrmXQC4vRkfKzGMT8W/WymGYc8
	tOIu8Tza+zGXrr1ec0/+tdeUfYNp3cn/pUY2oxeyhVMB9rN3sm9vsaS+Yupc/nS/
	lS26EUVJIJuVwq+GxrWHs+qiyvU01/v9XVfq3BMsNyhb6X5fSSNZCZ3Hbd3MSn8d
	P5FdoKdxLV2LjiigkRsaARrz5GvTHw1SYtdrwQoUXstWyqt734kTGS0BDMB/rJi3
	mfNTrsAcIT+KYHmMhfnReCqd/6TLPHGC+HxXBI8uC3trHJdSVjvz1caKrUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795142852; x=1795229252; bh=gLkYIAzdX5n+E2UDbvv2hp4q1FOusklc4Xv
	JW1NkNM4=; b=h4gN1SYjO8U84ftgB0sXmkMER3eO4ieq3uDKwzVguNUoSE6nCoy
	ee/d5FQL8K1tiN0eZO2XCVjwGxK0/2XP7jk/u7sePLVunB1IYThhv+uM9/dSGYFf
	4tvMfeV8u3Ce41CXeUvawR58txdE3gt0wVBOggFJPOS2Ta8XvTaFSEwxswKnpvrc
	XB02KyaSQp21Li+mIGLYv15ugKh9wCPVodF5HHy2A19dZ80EAzfCbhp+srqC8OrM
	z69ldD5qHtPyesiQmzBY5/vOeUj0ccPtLSADtKpSQ2kL66Mxn+InEK8VaJQyfh2g
	gZL8kzWLBp1ojrzZv9q45tyx7ZnEm70TUPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795142852; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:A/Pxq54oiLLfSkDjGUUOKGKR4+xGNMOAVyQq2T38pG41Wc9
	ueN13M0nFL545eZXlJ6Gml1cFzK0VERiSljfs3dzcbrS/R0lU2MI4MN6m+Yk/hMb
	xCz1Xud7wo1T/7xFeiZ0Lkm7niZjjfLGLXjXDDXO/G/VJwhc0ZgQ7koR/zQPBvuw
	JKjkac+KlPuq/rcOS14Qt+cyKJVDFq2nC403g6RnhadnU82ttKC+8K8/r+xduVHB
	hDHVJ3m/m9iHSyjJWkPn1Lwtu3A57nQoGZFZIvJd0CM7c5GxVA1wCvPa9L/DZv5N
	EqaVpXjcoVTTmUABumQWuYuw97tprMpT7FrIWgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GNs4Hi3kNb2xX4o2d4GL53MHJv5n55m3S9ar/QLhhM0=:KWBpvp3tH6V9Mn8VJT4mEx+ubPZ4SLLBIuPXr8irKSo=;
X-ME-Sender: <xms:w7T_alYOIk_Z-8lCNKpMnqA7TE3hLC9c6l-y74sSU1cV5Mbp3ZkqtQ>
    <xme:w7T_aoStrPFNl5MDLLH2TEsSFo80Z1ouMvcDHBA3MUSFKKZ3CJ_1czlG-XcYAAp9p
    9nNKNJAd-PZlrdVFeh6Xr8RljvtEsprv1av1D1qmELKhH6-kYla6aGz>
X-ME-Received: <xmr:w7T_ajdgLoFKpT_VvECZEq4L9Dj8SkYx09lY4l2BX3Wvtf7rLxqnhNCP3D11_EtC-V9nQEqFp_JUatOypnQRXphp3sI>
X-ME-Proxy-Cause: dmFkZTEz9EicWBCz5+aB4e14PavjISyOBet3lZ+vRU6QATFGK2oT6Bwo53VTqVeNrpRxW5
    2hpb9UGL/71D4zHD3AOd4wcSo5+pg5jyO/FpFbecLWxPrnMCOkwsYXdfYDDN/47kVC0kW4
    pH9KND4QXFU+ozcCXQmucfr23psrb389BJj8MAUPcr0pPjgkX7gMp3HG9zvBbZaDUoWl/Z
    FGsJLvG9vFeMk3QStn3sQga9AVZ0J94S8BwFesaJXgufVY/8qYG6K8hIm1vUVJPI4szr6K
    hLnhbi3M+iU2HNfD7+TQK4JQQ5kYlXEQ2h9V6O5P8RjtiaEeZv9T9TsDLTrnj2vrE8H9dZ
    FQZ6vejqa49AWr2zET5mGAaDfBAVCco1wEMhjwzLR7fBlQDUv1pscT8tfLup3cZQTPwlby
    7E2gyZ9bKolpJDGw9F2hLRhM0U0HHeHc56mAseoZg36GnG9DDmOQmkbV072VKaGY5nAhne
    kq8KaOUcN94Si21Tpq8MKQgQFdBxjZymwp+vX9wXhZq8XfceyFAtQ0/bzJrx2aXKxVD9NI
    5DfieSMuvGjCaNwQf0L6sRNqy038i6LMGnSIRRn7+OkB6DJj/vXU/SxnkZU8OdzvRZcldz
    9inCAFw+gMl5O8WGyakOLXnMXG/+WIYgq1eBVsrMgV5t9znb5ad1J/624F9A
X-ME-Proxy: <xmx:w7T_anlLV2NGK66kRv0OjqPtvNvTx9r23-uQ92X4r49iy8lXEPQUvw>
    <xmx:w7T_aoiR8bZska8R-FBvNYFXZ_kkG0TWKEu9jsuiKiXLQpo392Pxxw>
    <xmx:w7T_aoG9Vsf9MISm-8bhOi1d7I8a56rJTdy-uq1MZaKq4KAxdZr8ug>
    <xmx:w7T_any35mjTYtpOrkljlcD4E2axzP7VfGtjhKVUG6Rz038nDUSnlA>
    <xmx:xLT_aisvKBkDxo0rG5qAHNi_fgTG7QPQQ40iOIzDvMs0HvtnG-eD8qNf>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 21:47:30 -0500 (EST)
Date: Thu, 19 Nov 2026 21:47:29 -0500
From: Sean Lyon <sean@seanlyon.dev>
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
Message-ID: <av-0wWk7K6IG_8by@ncase>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>

On Wed, Nov 18, 2026 at 03:35:27PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- Intel N100

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
