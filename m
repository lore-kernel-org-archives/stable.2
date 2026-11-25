Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615276;
	b=SQ3lfPX5+uvoAtMAFyAc81j1yvxdUx71CNmbu5WT1CrxOHd5U2g6r7enkpfFBGCIPnLx
	 qFTVcjgeJX+eGYtyPtBHh2SCUoACMDVo05dN7mlIPf+d79GpweHiW/6lTfMkag1kMvjEc
	 HmxVDxsmKLLjRx0tzkb46CyrXiHR+mRzXfGrXpkJeSOU6rQgLKjlAcRF7AVPzy3m2PY5W
	 +kyOzZV9B1ifIlQASahsywPKoVhVSa2paGPVq/DqiqwJiXezEaMGDTOH+DV5/oc5i/of4
	 HsiM9DHxBYnCOmdiSuafXowq7XRXTXRclnjkr7SxZ6AGKcTL4N5NKT8NQcKJV2NNZ2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615276;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xPs5f4A0Tob3CyDOsj13BsPyaIL8a+4YC+Rj1isrcw8=;
	b=tRldjNz9MhImQxXEuyxofQIVSVSH+65eSLqEHh76Mym6o6IuQWubyLl7/BqLYby43w7s
	 HM+U2dwPZbf4ZlesUYF61BFX02w6Y8uc74Zlb2FYepgp00b4nxjndeTJGF0mR9XGhw1bR
	 GQs0dYkUTVGoDYxaJN4yA6BUjCbewS0VJjtlnJqzFS/Yp0IMQpkbbgMyYJfY8ZQdWLjRs
	 Q04BAkKQ5GyX3TY9+2uYY4Bc+LcduTBHhcDT5bGKf30QlKVTHRuzS+WJeIL/bTCdFHzQ/
	 Qy551OK00AULBfvVVpkfejULI/shDG4bFQwpqyyC05G2rGU7fsFgKWYAoQHlIptBQKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AVaw6qij;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD64606A321;
	Wed, 25 Nov 2026 14:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD64606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AVaw6qij
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9788E200033;
	Wed, 25 Nov 2026 15:01:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795615268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPs5f4A0Tob3CyDOsj13BsPyaIL8a+4YC+Rj1isrcw8=;
	b=AVaw6qijL9sB64GGQtb+4AnGO4q1SMiVqVZOoY7KfgYMJQKi0EMIZzOgtVHoZvKg0VSMS2
	9NOob1fXRkom+BJO/os73IoB7dqXLrkgAN8OGLthFxTUpcp0NpBewmx580rDANbGK2NOXU
	BP8EypqZYy15+a+VuwOfB+x5bybQ6rZs6BClSSWEOGOXKyhQT1iatNnIA7TqbLFTyx72Tx
	Xph8L9wBGT/xZqTzQM6s+lch0he890EXKx9SA0GrhmwJueHepz+XjSZFccDBF1CmAKetVR
	8b71//zXKM9jiklLqyiCw9bc9FFhiQ3W0hfdwwyxR80IBINtLMjPp6+ZZaUhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795615268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPs5f4A0Tob3CyDOsj13BsPyaIL8a+4YC+Rj1isrcw8=;
	b=dElgK/igdiYA29p0fvkQsD/K/L9c89nkgBlDHA1dnUh2JlDucAC76heyQZ1VrLLfX/RkLL
	/n0R5zJqefUKk5Owc2x8zRIHsdkR1vTm/Fgmc+qA5lpKWZwUtwt0Our3Le1a9ayHoVVwjK
	a+3doS1ZOPal1s29JTyXSqWmYsnm0GXnxAZ+SJyTS8eU83gaFEKL56LdKeNU+WTKqrhhSH
	24N/8zIoaeMvRrdGvTIpaHSEl7HfTNL7aUY6wHj3R22god8oyQzAaqMZVkGQP+ZkeCLNgu
	DtZiqnmpSB2Xl7fq1lJzPaDlUiPMWRA8yB/ezrbEEL9ptaClMxXOUPhDeNLT7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795615268; a=rsa-sha256;
	cv=none;
	b=CvxV1kWrOoj0nUZq9FbqDAYIkWqoXbAy7Zij3DV7/VaBQZcG9vGG7ZO+JtGYLe2HNtcKS/
	iN0pQFGbVCIcSD/NhEYaUVkeiyyPNzY6QLWraL0+PqCNFVJmEODFsyB8NGwMw0dpMSNkS4
	t+FOAqqvxHrD1hdFGRxcibOVD4OmnPgz/27AHdt6q9+eaGeBbTHTPjgSetrbz3oTuGo+7N
	qR0HAQWFB9bQabtiDAs+yahsv7D/fZoJofkna2QWGXdyla72HYKAEnJIXlYwcxCpbLOhIg
	70D5Hic8ch8crjbvy/GbV+dsU0LxsT06z7f/ANcaXVESKDqPCl63SqhbwuXuOA==
Date: Wed, 25 Nov 2026 15:01:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 01/12] can: bcm: copy the CAN frames outside of
 lock_sock()
Message-ID: <20261125-lavender-pig-of-imagination-fe91b5-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
 <20261124085757.1093632-2-mkl@pengutronix.de>
 <179551104023.3294.3966794215800671203@kernel.org>
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
	protocol="application/pgp-signature"; boundary="f24icvnqsmeicx75"
Content-Disposition: inline
In-Reply-To: <179551104023.3294.3966794215800671203@kernel.org>


--f24icvnqsmeicx75
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 01/12] can: bcm: copy the CAN frames outside of
 lock_sock()
MIME-Version: 1.0

On 24.11.2026 09:04:00, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issues in the CAN protocols BCM, RAW and ISOTP fixed in patches
#1...#7 were found by LLM review. They can lead to block the RTNL by an
unprivileged user, but have not been observed in the wild.

Patch #8 fixes problem with configuration of certain classes of older
CAN-FD hardware, found by LLM, not observed in the wild.

Patches #9...10 fix problems with the netlink attribute sizing, found by
LLM, not observed in the wild.

Patch #11 fixes a information leak of up to 8 bytes of kernel memory to
out USB URBs, found by LLM.

Patch #12 fixes a probe failure on of a driver on m68k/coldfire, found
by human review, not observed in the wild.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f24icvnqsmeicx75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawbqIgAKCRDMOmT6rpmt
0pNtAQCWO8ec5l2bMRKI8jYsDO5ikgamoaLdohpb5KSIkOVZ9QD9FXwWK3KWIoDM
ZklqoUbx+3t1alr9F+qNYT/OZi1TtA8=
=Rwxo
-----END PGP SIGNATURE-----

--f24icvnqsmeicx75--
