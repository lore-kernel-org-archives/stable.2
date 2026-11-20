Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207013;
	b=QzQSSq0ELZSHm/WV3BrbmFc2T36D+vM93FBALEJ4Edq6/5g4iL5EEDU+OeyKa6ntX0MP
	 qfuECpevGF7vy1tZ7TsPMVctpylEx/2taEe62NBmWNJXFlYSqHs8vxiVOMv6TiuuR0rZz
	 7mv6Tm9dVk+B09fSnqyKYrsKAc2hD7lLP5o3Kz0anqlfX1NTibXgPBqR9ruD/4AfT8aP/
	 JA4CmUWlfaa/PnSWgt6UOp6qeJQoxNy0Bsu5zM3wbcVz9ogA7RcnYVDX4t0JmbbdiLaEU
	 4t2pURn0xeW+oklbSE5iG/5bcGUfVItg3rvcOi0o7YpnvJqKGw6XvZjNHTTTm+e0jXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207013;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
	bh=NaPReRPJ1oLYrJ6cWmfrT2XB8nUvdUbNMjhFYYlgHCg=;
	b=lAfug1iZxsiwyFf4NJsfHJ0T920eG8okTXQCHm+A83ui2BdeOwjtm0fYX2vkhKScXkpK
	 CwU050V4BzH3gmwSTp+k8Jgeqp+Y7VLL4ivPVEH0MIGzmqkVYekxHd4dEV8UFvRgIQ4pv
	 QMg2LOhnC5rplgCYvobZiMwh+wd3Y315AvXGcARtvOalKtIg7RvTRJK2qoJqOQpZgtjl7
	 vjfupx12zHK57BeQI9Dl6CHVuhZatEtUBe592GXU4+wXG8eiBJuWW7uXS624qG+U5LHam
	 C6lTINj/BxR4+uL1xHfF99WqKxxzMOvYSsl7lVO7NnlW/D5ygsU41qa3quQgdAN3t4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=SN4eTt1h;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDB606A6ED;
	Fri, 20 Nov 2026 20:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CDB606A6ED
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=SN4eTt1h
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWRvZ3970z8vVN;
	Fri, 20 Nov 2026 21:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1795207002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaPReRPJ1oLYrJ6cWmfrT2XB8nUvdUbNMjhFYYlgHCg=;
	b=SN4eTt1h8lCCIob+lm9xaExLasOJ/vJ4P1xR2KXWt+x6QlsKdWM/7iUynFmbp4s5FBJXl3
	ALxFw5fRFvvhRzwOL2CvPeIMwc+/Wy68pxMo1UR+5JVKTa15nVo5W0KnAkCeZ0J6QTB7Ax
	xpXseGy9yZovQMHVNpHy2wsobdq267vQiRDlGOeqtt0ug1/CXdvJv4SmG8oupGxX/gssyF
	ahilF7aByTejLe/n5R0PgAudR3qFrjWjAcN3hVG2pVwIZRwjGXJXCV1n24od3T3Z2eiJLl
	gMYeyM0ukAe34Gwb9o+nbjIm41uUlCM3pkEP5kstNgUtGig9r9VuHxgp6P/5mQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <78dafd3129be731571810229c6ec8b2ec969625b.camel@dirkwinkel.cc>
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 	achill@achill.org, sr@sladewatkins.com
Date: Fri, 20 Nov 2026 21:36:37 +0100
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
References: <20261120055248.913352689@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jWRvZ3970z8vVN

On Fri, 20 Nov 2026 06:58:20 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2642 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =09https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6=
-rc2.gz
> or in the git tree and branch at:
> =09git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-7.3.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

Tested on 24 device types (booting, general system tests, rt).

Tested-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
