Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442501;
	b=O7yAbKzou/M4NF70tnoiXuK/73RgrZEXr3FWp1GaNnN6P3tCAU5B53PYNfrTAtDGhYkL
	 RMyZ1xSvgpZPmPmCEmBF3rFwcWV+SqVg1hXg0O542ZAxLI+h2B6VMOb55r1esfA4wKKRz
	 gFnSXXLFpCJQ24W77H/pmLTVoT26NnmLXxmPe1p8xC83L0ZnuvvSExLL19qJSSWXtaMHg
	 IzgB+/d760q8xMi0TJ5s0QiTYGHSBnZPi/CHnrIKMuhYYrhSsC5DBxwYebrgO2E+HTg4t
	 +g6OEI55574yd3v1Cwm4yw49fFsFX7WdSbVag2yWeHnfq/Hl+c7hh7s63I7oKA7m/Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q/EartPOy717CuQdv8ANaMlETa+4mCRy7I4dcWtZtrE=;
	b=NSmW/tKrzq/0Mz3WRrNUJT3090EhI2qdijTgTTu63W5oxkqDik3gWj/fc9bgMcSZOT4U
	 GKgoXITXB9yOh3wTquKUiJpcTuFgMU/r+4KWxHNd0VqpTmshFzsx7vCZxokHo9vjE+Bpr
	 PpDoWLF3iaTHB3rWBgte7TvBYeMSn8PUQRybzADfh3p/c+WxGbfHWJOVQnsDYJJoUtULi
	 Qy6ZxV+h3pzq7T05JvxV8PxhKLnBprSMcV+k3Vc5tVT9uR+jZkwgAgmZ9FaTUrjQyDkou
	 LZB2cfzY2UicMfUFRmvsX3WLVooJY5QF9z9rv9ELCXVWnkeHEYkSBznthMe4cjCmOCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpmtyci8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEB606A324;
	Thu, 12 Nov 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpmtyci8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A60B1F00A07;
	Thu, 12 Nov 2026 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442501;
	bh=Q/EartPOy717CuQdv8ANaMlETa+4mCRy7I4dcWtZtrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rpmtyci8aux5sP02UwuMM0SFs1Ay4fZueM4bTxiZAvf1FG/XV2+1zNXsE0Ri3aVxE
	 Lz7/V3FoZmXtls4ENNgK9ebqPtTIRCtEU4crfR8jfASyOwESqRTsg7ya9r6PVP7S00
	 SZ8YJs7qh8OYlbn40nmcbXWzrbNOYP09/iyhqD1tmGeYo63rlR/fxHE/Nj9F3WC5Lr
	 OhFR4Uj6c9TYSDpb3YvcNoq7SEjOvTiIHveNLHnyOqa/0m+IJo2jL5QGackjbXUkw/
	 GdC47yH+vK84qfngcuCWhkwqYDju3eVgJ/b5uwF7VHmevhk1sMJX5YPRdOCpaIzQf0
	 m7DsfPn1Thx3A==
Date: Wed, 11 Nov 2026 16:14:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "kernel"
 <kernel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Wolfgang Grandegger" <wg@grandegger.com>, "linux-can"
 <linux-can@vger.kernel.org>, "linux-arm-kernel"
 <linux-arm-kernel@lists.infradead.org>, "linux-rockchip"
 <linux-rockchip@lists.infradead.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "netdev" <netdev@vger.kernel.org>,
 "linux-doc" <linux-doc@vger.kernel.org>, "stable" <stable@vger.kernel.org>
Subject: Re: [PATCH net v8 00/10] can: fix Rockchip TX stalls and bus-off
 restart/close races
Message-ID: <20261111161459.4879a82d@kernel.org>
In-Reply-To: <tencent_F59D327809C523BE014488357EEF4D163408@qq.com>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
	<20261109112402.283c16a3@kernel.org>
	<tencent_F59D327809C523BE014488357EEF4D163408@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 11:05:37 +0800 Cunhao Lu wrote:
> > >=C2=A0Subject:=C2=A0[PATCH=C2=A0net=C2=A0v8=C2=A000/10]=C2=A0can:=C2=
=A0fix=C2=A0Rockchip=C2=A0TX=C2=A0stalls=C2=A0and=C2=A0bus-off=C2=A0restart=
/close=C2=A0races =20
> >
> > please=C2=A0use=C2=A0get_maintainer.pl,=C2=A0do=C2=A0not=C2=A0CC=C2=A0n=
etdev=C2=A0on=C2=A0CAN=C2=A0patches=C2=A0directly. =20
>=20
> I used b4 prep --auto-to-cc, which invokes get_maintainer.pl.
> The series modifies Documentation/networking/can.rst, which matches
> Documentation/networking/ under NETWORKING [GENERAL] and is not
> excluded there, so netdev@vger.kernel.org was added automatically.
>=20
> I will manually remove netdev@vger.kernel.org from Cc for the next
> revision.

Or better still send a patch to exclude it like the rest of CAN
