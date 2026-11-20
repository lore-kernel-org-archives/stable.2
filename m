Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163895;
	b=tYFJctMBhAz8UEK//kRz7ZblDUXmC4xeRpP4qBDViXMfIRdmRNdzjzvRs3l/pnVOQOW2
	 Vf/kk2sHHgv+/FsTO5t8tZTYroAKrCJVUf+CjjxX50a9hJO+0DBGhu2C5CrPg2y2kZKFf
	 ZQr8bF+/DbtRZDn4IXDjzalAp7ZzJR6cDDejhVNpCGfdmnd0JXl8NmsiGLb2g5nh5HMEg
	 cobk6ttBPaG+ObcPFY3w9FbLRQ7aTsul18ACwE5unIQjWuZer59z35TTNeJ0F3WxzB9tm
	 d8FrKHelFpIy8lRIZoyJh6/QPSpJTB3u/z0YCR7XE4eUTekjECwombqN1sm7dJkYlzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163895;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lQZJFrgz4LJW3+scm1GHR1HbjyBytA747cFcqEnvq0s=;
	b=2rVLLs916WdgPX84W+zzpzZglBZmsPD3IB5a9xlw7TE5eykkIm+Z1ZJhcx45SGDO6lyM
	 Nsi8oRd9PoJ8DHrk4ej2BlqvWzzyUXmKJz6AG7VBT105SwtiKgjxR7TrO97641mdiRK7d
	 fJaxnw2k1LcltonPk0vQbas0HSN86PTwBVo6boSHbGJS5FwYIJrn3PiGNP/pgDnt6qqt/
	 7Gu6i3JjJlSPUD0yoD/xxs/gp8XACwBt9UxkN6fRb2O2T/dXBe1p62hETfeRapPedzd41
	 em950OK8lIDfDCZok30laWUNMXZFyy96tqur3ENewd+AqCbamf73yUtpzqfqcyIpm6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UyX2LcLD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31311606A320;
	Fri, 20 Nov 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31311606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UyX2LcLD
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 882D3200EDB;
	Fri, 20 Nov 2026 09:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795163890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQZJFrgz4LJW3+scm1GHR1HbjyBytA747cFcqEnvq0s=;
	b=UyX2LcLD81H0r1kdh8BxE1xKXI0q99uYpPJsFJA72n7Ytn+IAFLVEKgnGS5SOsYIjOWQhL
	oZ9Itbm9E74v1rOTnprJPdUJJ+HYL0TVkDSH3Qsxzt6o/Mf8SUPuytbyr3s0rQXJt38a3J
	KwNd78dcSlruNQQMfu40Qj/MYjxLdwzjM+fficbzobR9I87SHle7sFMztHj/b+IydArkHG
	A0LoMcaIgx8TKWWwWXt6LL53oqPv75UnIKG1R9jWSgPBXmJxO05pOyuRlEEqsdY2RBirjp
	R8w0y9RDPe4mvefZqEeBEpvnVFA4VLqEC3T8HYoZOjLsl50qn4WmHRcF3YJoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795163890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQZJFrgz4LJW3+scm1GHR1HbjyBytA747cFcqEnvq0s=;
	b=L0MqIBvz5Jm6is+N91dHh9/HDzITK2DElfpafx53VxQx82tRTSwcSPgMn7eGtOeSe1ikNf
	l6n/KRR7I/OG25q8M4qVR5ifs3b9VlhaK/E3hbGt/7SEmeONW8RNcxRdBqC5KGUtq7q1rS
	S0PhrUrHFuWJZ0WUIxOd2hF+DnnHHvnE7TYxv4nAXcWFZ95a39UYD+Sh1qazJgI46MLQjq
	bbnuz9O37md0RRmMwaLMy3J8jceT2GtYCb4r8Dw7vn+7wIRkccEDMI9Ol2FmjNgNbXALOi
	KI75xCdYQdw4QIx2t2VMO6Q/som8MbD5NIGtzEilsEuRvtVR/8+MThL4dgEQ3w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795163890; a=rsa-sha256;
	cv=none;
	b=DotYhhqgGhiWXuTIk+yUe05GZzAA+M4YOf9BEmOQwNqXl7k9UNX/QVuCvBcimWV2u8II40
	0GQcJ47Nje/qkdjUv5+PfXD2qVjTuTKm5s5fTSPS9i0Y00LIncQrM5KB9t/shvOpl6PFUu
	WvL08dn4KCLXKwy4tTx1lOEBuAxKl8R6GUeNRIResTIs/kxSGID4F/TQsd1EsFfp4PJWXl
	94XT+sLKHFUbSp5+kDE8m80cHz6PVZi0csxoxCQNt/tsU4GZCy+ntTW5CxDR99DWR2qvnF
	yJ6aEDOk6ixVbM4IFkXcPV/Oyez75+k06iOZcYWgDYTqhSlhzl5tcQgynAAkUw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Fri, 20 Nov 2026 09:38:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Cc: mailhol@kernel.org, joasantonio108@gmail.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] can: kvaser_usb: validate values received from
 the device
Message-ID: <20261120-translucent-unbiased-pug-c03696-mkl@pengutronix.de>
References: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>
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
	protocol="application/pgp-signature"; boundary="3hxw3wbltvwmpqrd"
Content-Disposition: inline
In-Reply-To: <20261112-kvaser-usb-validate-v3-0-61587f639508@gmail.com>


--3hxw3wbltvwmpqrd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/4] can: kvaser_usb: validate values received from
 the device
MIME-Version: 1.0

On 12.11.2026 17:27:54, Joas Antonio dos Santos via B4 Relay wrote:
> Four fixes for values that kvaser_usb takes from the USB device without
> checking them.
>
> Patch 1 rejects hydra commands whose length is shorter than a standard
> command.  A length of zero otherwise stalls the command loops, and a
> short extended command makes the handlers read past the command.
>
> Patch 2 rejects devices that report zero max outstanding tx, which
> otherwise leads to a division by zero.
>
> Patch 3 stops the hydra command parsers from reading the length of an
> extended command before it has been received.
>
> Patch 4 checks the error frame data and the payload of extended rx
> commands against the command length.
>
> These issues were found with the help of an LLM-based code review tool
> (Claude); patches 3 and 4 address the points of the Sashiko review of
> v2.  I checked the code paths by hand against v7.4-rc3 and reviewed the
> fixes myself.  They are build-tested only (W=3D1, arm64); I do not have
> the hardware to test them at runtime.  In particular patch 4 assumes
> that the firmware includes the error frame data and the payload in the
> command length, which follows from how the parsers advance through the
> buffer but which I could not confirm on a device.

Please evaluate the patch by Cen Zhang, fixing a similar issue:

| https://lore.kernel.org/all/20261015015336.816543-33-mkl@pengutronix.de/

Explain which solution is better and why.

regards,
Marc

> ---
> Changes in v3:
> - New patch 3: do not read the extended command length before bytes 4
>   and 5 are received, in kvaser_usb_hydra_wait_cmd() and
>   kvaser_usb_hydra_read_bulk_callback() (sashiko review of v2).
> - New patch 4: check err_frame_data and kcan_payload against the command
>   length in kvaser_usb_hydra_rx_msg_ext() (sashiko review of v2).
> - Patches 1 and 2: unchanged.
> - Link to v2: https://lore.kernel.org/r/20261111-kvaser-usb-validate-v2-0=
-193dc10ca19b@gmail.com
>
> Changes in v2:
> - Patch 1: require at least sizeof(struct kvaser_cmd) instead of the
>   4-byte header, so that the extended command handlers do not read past
>   a short command (sashiko review of v1).  Subject changed, it was
>   "can: kvaser_usb: hydra: reject commands shorter than the header".
> - Patch 2: unchanged.
> - Link to v1: https://lore.kernel.org/r/20261110-kvaser-usb-validate-v1-0=
-f266b85aa908@gmail.com
>
> ---
> Joas Antonio dos Santos (4):
>       can: kvaser_usb: hydra: reject commands shorter than a standard com=
mand
>       can: kvaser_usb: reject devices reporting zero max outstanding tx
>       can: kvaser_usb: hydra: do not read the command length before it is=
 received
>       can: kvaser_usb: hydra: check the payload of extended rx commands
>
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  |  6 ++
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 67 +++++++++++++++++=
++++--
>  2 files changed, 68 insertions(+), 5 deletions(-)
> ---
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> change-id: 20261110-kvaser-usb-validate-33c2e34b63bf
>
> Best regards,
> --
> Joas Antonio dos Santos <joasantonio108@gmail.com>
>
>
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3hxw3wbltvwmpqrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawAG7wAKCRDMOmT6rpmt
0pgYAQCpKRwKBpm2/MuyH8wv7gjfnJpU0l3pQsXKd7Li2Sh/UAD/ZEnSUXGmEvX5
iFnlj9gLoqTeTDBiNMDkXFK20jpzYAE=
=ze8Q
-----END PGP SIGNATURE-----

--3hxw3wbltvwmpqrd--
