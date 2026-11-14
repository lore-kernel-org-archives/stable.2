Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661171;
	b=ZijoyN36xxvUsENPoel0qz2YAeWavoSU318ikz0I5DhOAkufDCwRVDx9ON00eJtot8Mh
	 7KeuYnDDBl9TKpGyzdN/hiH0o4OHNMsoLdbhIagRNoZCBRlBKQK5ded9pYSwnVBSVK2bA
	 ExlCuVfqDZJ4/uD6rM7dvqEnWht6iA4YteQ6wuV1tHio7M1KK/38rvDChWW4jN0LNhqr/
	 SftU4404IVU9fM8VQIk/hyQF/wbu/AUusN1LpA4x8EkNKhp4KhEfB1pIVGB/Eyq7bbXY4
	 kTr+fWY+zZrjfkOknqR8jcbaxKmmUNxZTaMdGxNfDfMUoBYICZ+EtPjRlqA36ypZwKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661171;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YYeN3iFUmw8rED1fREi+In3DUJOYp+wNZQ/1aiIeVU8=;
	b=eYImH4C4tVdUSnpgtoveKVux7O+xakLylxAwVG5z/MH451LHa1xhRWgHiBrF0hJg37gJ
	 +b1CO4KJMyeOmLnbUIg7y/8bsJGtuMxG5+R3X0YYl1DJCjX0NbbyWt/iIOQnCTVt+qYNt
	 AAIUzbWhYFahc2lH89g8QzmZtwxo5EFios0gfU55eHc+XtzBJV+eZ33fmyBNYENDmpEzj
	 nwwrm5wt6bh7dE97qjg7siEWqJcNrB7TtgvNl9wDjDi8QAn2TidOR08xjzBvDx5CVZfEG
	 RV6/E9F8dmn9g1D8Rmq7uBoKPHbbgj2MqsvLexTJCYlyDCZAivw93majqj0YqI+cA3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZwyQA4Dh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83790606A323;
	Sat, 14 Nov 2026 12:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83790606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZwyQA4Dh
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D5001201CE0;
	Sat, 14 Nov 2026 13:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYeN3iFUmw8rED1fREi+In3DUJOYp+wNZQ/1aiIeVU8=;
	b=ZwyQA4Dh/n4SSKqKSrx+xld2+XyaapLMkrTIsvwcdOoGUNhrr2zmR8lajIRP9ykIgyhkWM
	7B9348uF8HaLTULEhiIpBKbNr6Z59yeCuMA4NykXhsMDqtBgNpbmbBnqWFUEpr8ormiWx/
	UvKmRmTwxq9WrtXTR+E8yfEHnwRRSC7zk/6V/1mI4BcJszX5uGmeyLzogs7CFMIK3uf7vl
	0UKJpgx6szVEiDAej8LBJEpkW1k8iiIdq2xzUnelHJf6vwwCAMbyeQ6eFGBbd34xl1dveq
	jzIqDlbsn7Kd0/Bh/nfZ1U86ciXQ/sJLnddXT6H8vVy0Ld5CiInzDGKMF3UjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYeN3iFUmw8rED1fREi+In3DUJOYp+wNZQ/1aiIeVU8=;
	b=KpxpIWrDc5/Y2r6BfQ1GZVW+S8e8Zv3K4izWxKomT15r2mWOD1m6VR+2z0W0e/Ui6XJbgM
	uXtTz+ZclquraUXkti5ckIHgKwuEfoqaXbIYpWpWWdG4C3t4OolDOwDkZxgGxUoOT/M6Wf
	7ViBzxFB68OJjky0e9YY/fu/wCydMTSvZ3aKutSIoGQ55zWKaFyLKcqQ9To0svH0QJNQZV
	TC6dgh3jToc7+g6QbGRpSf4hkfeawTGdsSGy6DbtDmXy1+yZvcUw6Sev4HUWuD0IIMQtNk
	BZ7wW2oEPnHe9y+36mS8fkjq6AcYbJC/6HowaA+UHdfBjl3eMcRL/XKDuJFISw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661168; a=rsa-sha256;
	cv=none;
	b=eud1LnddehD3r3GOdRmHsyXyGdXZr5PSbvDXE7Y66OveuEYa/qh+cTokF/Gv40mco9lgKU
	umKNeTeHjzvbcwN5Gr95KMz99DY40F9RMBYirEqyQZrFClc+If0yyET3sdV6Oio92qOEqE
	GMc/oGfoaG8z5KgsVcjK0QqXxOvAyXnLtToxzkqnmNQgfPw4fgoU1E1g/zO047kmKCPcpG
	h1niUM5weRnhuseuWyk1GZL5C8CgmZ6nDBRj6M3Cl+0Mi/cNb9Z1fa6MwMyLWbjY7UtauD
	JzHflGMRaOerv36NQ/83HAqrY4Ks7Bkqf34onhFitAGSWAiEqf+uyE1nVX7tXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDLs-0048pq-2U;
	Sat, 14 Nov 2026 13:59:28 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7F9E35EB9D4;
	Sat, 14 Nov 2026 12:59:28 +0000 (UTC)
Date: Sat, 14 Nov 2026 13:59:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <20261114-dramatic-ultra-newt-859254-mkl@pengutronix.de>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
 <akfoYuyHMAxIfalD@monoceros>
 <al4lxVud4_6NTZQG@monoceros>
 <avSmq-LRKgRWDfxH@monoceros>
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
	protocol="application/pgp-signature"; boundary="hbvxd7are3jhwubx"
Content-Disposition: inline
In-Reply-To: <avSmq-LRKgRWDfxH@monoceros>


--hbvxd7are3jhwubx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

On 11.11.2026 18:33:46, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> > This still stands. Marc, do you have this patch still on your radar?
>
> For a fix it takes quite some time to get applied. The patch now missed
> 7.4-rc1 ...
>
> Is someone reading this ping?

Yes - I finally found time to look at the driver_override issue, too.
This should fix both (m68k/coldfire probing and potential NULL pointer
deref when using driver_override) problems:

https://lore.kernel.org/all/20261114-fix-device_get_match_data-v1-2-2d82025=
e9646@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hbvxd7are3jhwubx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavhbLQAKCRDMOmT6rpmt
0u4MAQDa1rctCd9OmFPoa6xZo4IKmoDZCxMAzDd85V5hms5BRgD/fQABAipnmHXf
+vyTC8kgFwe485oSLiL4qTmk319o/AE=
=tt10
-----END PGP SIGNATURE-----

--hbvxd7are3jhwubx--
