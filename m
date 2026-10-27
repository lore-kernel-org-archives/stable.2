Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093090;
	b=kovgS/gxrpNSDR+OW6BiHu35R20OkRagoZIaXL+v+3lCf9coblFLTcA1Pq+obrWjEniY
	 X7eZA/317BpirmgDZLTon7laxn/GEpd7x4ylO2b/xcxz8y8RlfPmdlLhNVmfy23XRr4/k
	 6vr1ghZYE+xnrbaRajpMUaHr1jlB89amClyvq5xksaiSB5hPcmaICCSfyQCJtSgTxMyUS
	 tiGk4HmrLhA/SIyd478vLhpez2q+fozJ4TicfYhC93GwnD8lkTr9dPbujatIygtArOldx
	 ig+Q/TYgbBCgrS0z9RFGKsNOR+W0u+uo3+iG9ohaHhl7n83EnzgAKEld1pBY6a27lNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8my48rriU+1hiwu2LJQFqQu6T4hm5/dNVAFr4Ytn5wo=;
	b=HjSwnUnW90/5uEN+QtB9nMXniaEp+rPj2VZChNjOqvc3TV79Y62B+NQ2j3xre/hR8ZNZ
	 hKQ1xyXXCDSEuYjk94kLipsX/Q9SIFBtpX2962eg8L5XJKzQoFMsISLgxN9zRMfYUSFEQ
	 OWllnENguwAxj0rAUjQahcZ+FddV9ajLFAISfiR3OfXeI6T52tgqJ40h0N8ubbdECCjzP
	 QPrGzAqNEVvvVbsTTrylLY9EUcEf52amVXcRRx9LYtqVFYrCbLxPBFRlduGb3sLofhGqg
	 mJp8BGVcGzGnLaLtQ0rYniekDqkH38AGM195f5JC9yWZROXB8EF+PiVycvojVivYxNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=S1c1JpUL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C83606A31A;
	Tue, 27 Oct 2026 09:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=S1c1JpUL
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6B2D8202845;
	Tue, 27 Oct 2026 10:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8my48rriU+1hiwu2LJQFqQu6T4hm5/dNVAFr4Ytn5wo=;
	b=S1c1JpULSVRaWBc1jnWycbGlvTgSLHgN3XMIgR4qFIJdAblUQofqxCOvM8QqU7K22cD4j/
	WWrK5KZoHpe/7XHlKGlvgRw/2wIF9xmTdFeTJoEwvBLqumuDeRQW3pwpG5n1SJWO4YKzun
	ViFpmSk0cH2J/zJCGr8+gXamvd1uOy7xnuRyEJK6J8J7ZMdoXckUmOzCs4c1SaYp3fr0w1
	gScCVSPw3nFM6gRG/Z1tOXDbgDNjxnCOSgS4qUbjsf0nl+v29b+rfia//lIYGJEMCfZs2g
	+WzO68vfEho/ixmvZXLVUKYouGzO51XTTIodKkqGV9Z8lHY4apVHzjq4dA6LGA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793093087; a=rsa-sha256;
	cv=none;
	b=ErasVOlbB3K2B0HZ0Yj5k7fYYzw38DLR1lD4MqbFZ24CQWuuRkKy2RLAylQ/itszvsuBKA
	7fOlBUbCvGUhkRE8RyE1vN7bCuvI8blKUux6CDUkN+spImZqeB/5EG0TRZf6tkieHvd2ew
	gCW4mvf+g4j/Ce3F7myCCo+t9UncpQc7u+G/7o72Aj7Av1NXEsmgtxWCiEw1hVkN0VjJt5
	i5Q43qsSVVgOnfdukH3jtAmw1G3v4ob1vN6q9T0qfLB81h1FHzC/s54RWGLefGsjT5ilfp
	HAJ5I7PrXmCBqsjn3lngZIzZ7MOvWD4wv6xCBYiQhp8TDwcqA2hLDJgviH9D8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8my48rriU+1hiwu2LJQFqQu6T4hm5/dNVAFr4Ytn5wo=;
	b=Sr768xz0ql6DVARufteZTyKsCxfsNIrEPt0uFXpHXJJmLkhwxISUIoML6Oq69w4V1w8f/X
	TFevrDGodt9FKukmdsMYrbzolKBxBFNd+poVCooSW14BRwAEEYFVpoYCNorL8n1FvXqkbc
	e93Sz5Cz3khP2GnGL0Sj7fVvoSV1Xm2F8t+B8u8oTTbg+S2uvOiCSly/zU6gkUoiqS0ZvM
	CgWicQXXdUtQMn2C1yhvC/u1vQbs0Ouqrk/t1HKwp2YSWdkd9oPVMZ86VjNyjj5tDJkWfY
	NmwZ2qukQ+/Xoaj3QKSj0HUn1N8E5xoL0DIY8ARkzZROGEp2TMJDH9/mWiXwBA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLdQF-001PMn-17;
	Tue, 27 Oct 2026 10:24:47 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE5AE5D7AC3;
	Tue, 27 Oct 2026 09:24:46 +0000 (UTC)
Date: Tue, 27 Oct 2026 10:24:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: syzbot ci <syzbot+ci0e4b58e5e6ed7fb1@syzkaller.appspotmail.com>
Cc: eric@evenchick.com, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, max@schneidersoft.net, pfink@christ-es.de, 
	stable@vger.kernel.org, wg@grandegger.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: gs_usb: fixes
Message-ID: <20261027-hungry-bright-nyala-ff2039-mkl@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
 <6ae06214.6200f071.51519.0f44.GAE@google.com>
 <20261027-cherubic-monumental-aardwolf-d2cf5f-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="44mp5vz44fwlphoe"
Content-Disposition: inline
In-Reply-To: <20261027-cherubic-monumental-aardwolf-d2cf5f-mkl@pengutronix.de>


--44mp5vz44fwlphoe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot ci] Re: gs_usb: fixes
MIME-Version: 1.0

On 27.10.2026 10:23:34, Marc Kleine-Budde wrote:
> On 27.10.2026 01:34:28, syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v3] gs_usb: fixes
> > https://lore.kernel.org/all/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pen=
gutronix.de
> > * [PATCH v3 1/4] can: gs_usb: gs_can_start_xmit(): don't leak uninitial=
ized memory over USB
> > * [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev completely be=
fore register_candev()
> > * [PATCH v3 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check for=
 overflow flag if SKB allocation fails
> > * [PATCH v3 4/4] can: gs_usb: gs_usb_receive_bulk_callback(): add missi=
ng call to can_rx_offload_irq_finish
> >
> > and found the following issue:
> > general protection fault in can_rx_offload_del
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/0c1fc4c5-6a50-43da-a45c-fbc3a8685c3d
>
> Good bot! Will be fixed in v4.

Should already been fixed in v4: https://lore.kernel.org/all/20261026-gs_us=
b-fixes-v4-0-59e3b6360053@pengutronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--44mp5vz44fwlphoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBt3AAKCRDMOmT6rpmt
0swYAQCt378K3MnYZAXpa1Buog9COxNAQTqm6qxdl3/SM82esAEAq1vckNVubtuA
bR7Y5nt6X2lkCUs62z3M94vTuQ2xbAM=
=W1cm
-----END PGP SIGNATURE-----

--44mp5vz44fwlphoe--
