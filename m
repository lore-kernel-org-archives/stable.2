Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.75.19.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810630;
	b=XOvtIvjNXwAiB5+/fmgYNYhaIQBjOAkoYZEme4uR4faGkEyo2u/Sge+g1l7PuSgMFSBl
	 CugH/2D/hubZxl0V12OamaRQzp0OOd5/EOCPZ+lVfrElabeZctU9pHqy733GDnkkQHjMg
	 RWCEdHktdwAOyDxpMasEcHHUH3QYUvNBB1IV8bND502gxSLjqQ/ZKsbWWZl8jdbArPWXO
	 qcub9jxFIqRDNCCTeb2TQQJ/KvDz3IAeL9ijPNtoP0/PWDknbbesM3UDHdqN5rgDWqeCn
	 t7vdids34OrGJ9H76g6VWRoegZm5jqEZ4/K0aaOfqgURvTBEibLr11r0wTYePfu6RSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810630;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=d2rlFPMn4FSWmLQ5qbUFGzJZoe7UzLFThA0r34II3cw=;
	b=FdpKCidjKE4wUF85okXFxX77xOFB32GPUqdgnZzMlA+M0bCGpDBPoWRQ78eMLwyDTjs7
	 NwKOt3N1MknpF4OU23RsZLAv2C+FfFf+YmNjyyd0V6JfBTpshV2OVzNsucXetjJQ5bVjd
	 G2O/uEic1wk6iH5f/JGj3beWyS9aRvPpKEOM9zdWhgVbF9MnO0LsTyLQnOAHipqh5o9Yd
	 zcCLSOoHs7cq2NU34jNVmSjSsGYaeI8eSYraehvtOLFdOycKooisy6R0s6kI79EOhhTDd
	 Q+hoxB9etrqz7dnr9tcMH1DZd/QPXlGh58k/Uvcrduvo5iy+6FsaohXLsyrZXN6AigQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=remlab.net;
	spf=pass smtp.mailfrom=remlab.net;
	arc=none smtp.remote-ip=51.75.19.47
Received: from ursule.remlab.net (ursule.remlab.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FCC606A321;
	Fri, 27 Nov 2026 20:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FCC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id 3F47DC006B;
	Fri, 27 Nov 2026 22:17:01 +0200 (EET)
Received: from basile.remlab.net ([2001:14ba:a082:6301:c5d2:3c3d:3f09:1404])
	by ursule.remlab.net with ESMTPSA
	id 8ryDCD3lCWuxfAkAwZXkwQ
	(envelope-from <remi@remlab.net>); Fri, 27 Nov 2026 22:17:01 +0200
From: =?UTF-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
To: Remi Denis-Courmont <courmisch@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Elkin Cruz <elkin@google.com>
Cc: Simon Horman <horms@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, irogers@google.com,
 Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] phonet: fix use-after-free in can_respond()
Date: Fri, 27 Nov 2026 22:17:00 +0200
Message-ID: <IJCtsfWGQROQ4yf6qjbzpw@remlab.net>
Organization: Remlab
In-Reply-To: <20261125221627.1419412-1-elkin@google.com>
References: <20261125221627.1419412-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le torstaina 26. marraskuuta 2026, 0.16.27 It=C3=A4-Euroopan normaaliaika E=
lkin=20
Cruz a =C3=A9crit :
> In can_respond(), ph is cached before pskb_may_pull(skb, 5). When
> ph->pn_res =3D=3D PN_PREFIX and pskb_may_pull() reallocates skb->head,
> the check `if (ph->pn_res =3D=3D PN_COMMGR)` dereferences the dangling ph
> pointer before the code re-acquires ph =3D pn_hdr(skb).
>=20
> Check for PN_COMMGR before calling pskb_may_pull() to avoid accessing
> the potentially invalidated header pointer.
>=20
> This issue was found while trying out new Clang static analysis checks for
> kernel bug classes. The finding was triaged and fixed, and this commit
> description was drafted with the help of AI, then verified by code
> inspection and compile-tested against linux-next (not reproduced and not
> runtime-tested on hardware).
>=20
> Fixes: c3a90c788b74 ("Phonet: do not reply to indication reset packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Elkin Cruz <elkin@google.com>

Acked-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>

=2D-=20
=E3=83=85=E3=83=8B-=E3=82=AF=E3=83=BC=E3=83=A2=E3=83=B3=E3=83=BB=E3=83=AC=
=E3=83=9F
https://www.remlab.net/



