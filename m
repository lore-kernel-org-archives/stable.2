Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD263547065;
	Mon,  5 Oct 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192662; cv=pass; b=CwVAROlqG5TnOHuG9jCZjea99pgMW6f5oKgGV+oorqWpRvVP2QjUZLeNCaiKPOYJ0CPrTPPgYW3fjbfBwXLXV4oJjizYs13INFTLthT3Dt971ONHXZai9xGlrzpOtwm4WORvZGrlO6/eYUShuq/v7jsAtXCHU6iBB20Wke6a0gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192662; c=relaxed/simple;
	bh=XxZp9me/M+rcQ65zWoq/SpEAMV7nEol5j+mbLLq+s/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aScxnTtbK1oms1tyS0nrkcrDm8QNcP7UmkBXAr72H/qCHHbEgVpAzpiLEe7AX/eHF1UEjbZo+VCUAZgpVW+NiHMbl/sCPdbA7RrmESe5662pQo3Elb7w9NnZJBkGzZUxYDT+lRITpV4TK/NvV5ZMjzkJFFWPFNpiRBEBO1f7Sjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=G6FVsgMt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="G6FVsgMt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 93F2F2018A0;
	Mon, 05 Oct 2026 11:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFO5ZXSt8TLkL01e7cbVBIy8e8TGVKgQ+fA2lCydsoU=;
	b=G6FVsgMtv6+O5Nai5cjZqEaS7ai3SArUDKVVlSLInZDv+HoLa3YyUpYzlIiXou2kapZOFH
	Nq2cgCSzP7adW48JVyNeDfKlTUL9U8E3Pgi1phip8Fe/rLGAxORld851O6QnGzkQiFcXq0
	8oAiaYCGRWVjUajXRVFhOwVsY3yoCiwg//rbfzgTZMzs2/1djKiXK1m2BwGxb0rr7rJFMI
	GfRr63dVHnY9oR/iT/OnUu8Do5r+ZjggyIBOOYEml8h1TyQ3OSdyn5qxKoUIJAUyDP90vK
	Fwfv39fn552Sd3Q9Ux2WR8//pjJYZhuLIwQ6E0Sty+W5+inPDNtGFuqKhw0Wzw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791192657; a=rsa-sha256;
	cv=none;
	b=ShrLDiK0uCokfQM1tp3t03LlLXuS2/0VAj3kmb0cZUpk3KtGQyZkCjId7J1rq/cVAzr6tZ
	MCt61WEHma4kgZ3cqOGPKxd5teG0l4ZyYAmivsn1nCAbclMeVcPYoJlzT9waTdV9hFRgC1
	tEjlIQjK/V3ORFI6hmq19en4ewgMX4nQl26h3+33sCXp+3wiY7oRrKDfwYCU8E7eJ+evWT
	/YwjnnHi7anwcKRKOg3rHTZWsH64laei/R3CDPZRhn3EeUPzTwxl32ozeCt2e0jtXcKeuo
	ALvmLXXfCJeIyOACflIkgUQHbRvHhtKMSlCc/lWMrosPWnIL49ISUyIr98fniQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFO5ZXSt8TLkL01e7cbVBIy8e8TGVKgQ+fA2lCydsoU=;
	b=d2RcX77MDIvFWv8OKlpztNNQt/Fsyl4rf35fbZJdUOodgRM0yYGZGVEFtFMV0l2N5RsyuB
	3RPtk5a9Aqzb/YJVDhWsvoycwT6reRndLnmRZhOEYWGEByocFtug2FDccWomLiwNdX/Y3Z
	/8jXivOUOBS+Z4mAPUtmzemqZ8WXzLXv4Nte1y7CE5bGe311ytQdcwLdrEoA3vOi9zC3Zm
	hhqbr8ctqvo8qQc4khzfmL/RQBiOTtYeibsS/yDhkp+cx5+e/0KLCCOhzQy+SdbIXuise0
	6R0yDk9oaa7W9NIKVoGirVR7TPzCzO8/CMprT9RdUsxsC0iJQ340qjW4ESyagg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDf29-004MSO-1Q;
	Mon, 05 Oct 2026 11:30:57 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E86E65BA00B;
	Mon, 05 Oct 2026 09:30:56 +0000 (UTC)
Date: Mon, 5 Oct 2026 11:30:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, 
	stable@vger.kernel.org, "Dynetrex, Admin" <admin@dynetrex.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Drew Willey <dwilley@google.com>
Subject: Re: [PATCH net 3/3] usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <20261005-weightless-fat-seriema-802f2e-mkl@pengutronix.de>
References: <20261001151905.1556270-1-mkl@pengutronix.de>
 <20261001151905.1556270-4-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlf27b4rnrtsomql"
Content-Disposition: inline
In-Reply-To: <20261001151905.1556270-4-mkl@pengutronix.de>


--rlf27b4rnrtsomql
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 3/3] usb: f81604: fix struct f81604_int_data size
 mismatch
MIME-Version: 1.0

On 01.10.2026 17:14:25, Marc Kleine-Budde wrote:
> From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
>
> The struct f81604_int_data defines 9 bytes of interrupt data:
> - Byte 0: Status register (sr)
> - Byte 1: Interrupt register (isrc)
> - Byte 2: Interrupt enable register (ier)
> - Byte 3: Arbitration lost capture (alc)
> - Byte 4: Error code capture (ecc)
> - Byte 5: Error warning limit register (ewlr)
> - Byte 6: RX error counter (rxerr)
> - Byte 7: TX error counter (txerr)
> - Byte 8: Reserved (val)
>
> The hardware sends exactly 9 bytes for the interrupt endpoint.
> However, the struct was defined with __aligned(4) attribute which
> caused the compiler to pad the struct to 12 bytes.
>
> This causes a problem in f81604_read_int_callback() where the short
> URB check compares urb->actual_length against sizeof(*data). When
> sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
> bytes, the check fails and valid interrupt messages are discarded.
>
> This results in the driver only being able to transmit once because
> the TX complete interrupt is never processed.
>
> Fix this by removing the __aligned(4) attribute so the struct size
> matches the actual hardware data size of 9 bytes.
>
> Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb messag=
es properly")
> Cc: stable@vger.kernel.org
> Reported-by: Dynetrex, Admin <admin@dynetrex.com>
> Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@=
dynetrex.com/
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Drew Willey <dwilley@google.com>
> Link: https://patch.msgid.link/20260824-f81604-fix-v2-1-fc9be5581394@fint=
ek.com.tw
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

The netdev bots have found a "high" severity, which is a preexisting
issue, but not clearly flagged as such.

https://netdev-ai.bots.linux.dev/sashiko/#inline-kq9vc8hku

| Consequence: use-after-free of the freed netdev private data and of the
| embedded work_struct, which can corrupt memory or oops in the workqueue.
|
| Triggering path: interface up with CAN bus errors, arbitration loss or
| overruns (so clear_flags gets set) -> driver unbind, rmmod or disconnect
| -> unregister_netdev() -> f81604_close() -> cancel_work_sync() returns
| -> an interrupt URB completion in flight before usb_kill_anchored_urbs()
| calls f81604_handle_can_bus_errors() -> schedule_work() -> close returns
| -> free_candev() -> f81604_clear_reg_work() runs on freed memory. I
| checked that nothing between line 1078 and the free in
| f81604_disconnect() drains this work: close_candev() and
| usb_kill_anchored_urbs() do not flush it, and disconnect only calls
| unregister_netdev() and free_candev().
|
| Reachability: the race window is short, and triggering it needs
| privileged unbind or physical disconnect while bus errors are occurring.
| So it rates High rather than Critical, though the consequence is memory
| corruption. Pre-existing: git blame attributes f81604_close() entirely
| to 88da17436973. This patch does not add the ordering, but it re-enables
| the only producer of the work, which had been dead code since
| 7299b1b39a25. The commit message neither claims to fix this nor depends
| on it.

We have a patch for it pending, but not included in the PR, to keep it
to the absolute minimum.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rlf27b4rnrtsomql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasNuRgAKCRDMOmT6rpmt
0rwMAP9eiqoTtU79Brq2nmHVcBjJ0PbQzYu4Y3k2z6rjbYcOpgD/d/+Pk1e2x2Kw
Gal3uvyklvc8MOL3tf7sS0yEiTFWtA4=
=EH5/
-----END PGP SIGNATURE-----

--rlf27b4rnrtsomql--
