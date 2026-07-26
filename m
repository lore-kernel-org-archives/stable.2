Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0C3BCD0B
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785076928; cv=none; b=HfAIT9Ze3JPZeKBhvQBVZhxMPMoL4g0Z07wWs3l3QGFm5F+tpXtPcd2lBdf7wuLkK19DSOf9k3XdvIeasfoxkUAzoZ90rcQBBH203mS0WW6zh/xShyj4glwS/ersEPSK+FB6LkQHwOmHeC02yGwdqU+dD/VjeVuGNLGt7EmvA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785076928; c=relaxed/simple;
	bh=cG8EGGOj2GgmJnZpYafdve9cO2IlJuD51DcEiz9V5HI=;
	h=Message-ID:Subject:From:To:Cc:Date:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tee4K+tEFz0r0J/X9hUU4VY2TpPPEmxRAIevMgXwxnUcTRL9YzQHcV0KCBnd3gyyee21VpjoNDvzTMrrMcItXrxiHx/CESnvK+fUBJbpFbZrNMC76OS/grI042UqYHwfe8VPVfUr67l18J79K8i7lN2iKEtcrXyDKnayhCCo8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wnzVJ-001VdE-2C;
	Sun, 26 Jul 2026 14:06:56 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wnzVH-000000024F3-1SBO;
	Sun, 26 Jul 2026 16:06:55 +0200
Message-ID: <1bfb3bb0dda1f5cd66ca8a48de2536c026355ded.camel@decadent.org.uk>
Subject: [7.1] drm/amd/display: Add dp_skip_rbr flag for NUTMEG
From: Ben Hutchings <ben@decadent.org.uk>
To: stable <stable@vger.kernel.org>
Cc: 1141866@bugs.debian.org, Lionso Alejandro Pacheco Vacacela
	 <lionso@murena.io>
Date: Sun, 26 Jul 2026 16:06:49 +0200
References: <178379853043.8422.14248844886244170712@murena.io>
In-Reply-To: <178379853043.8422.14248844886244170712@murena.io>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uFNZlqKrHuZ1tmo7NEC8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-uFNZlqKrHuZ1tmo7NEC8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jul 2026 14:35:30 -0500 Lionso Alejandro Pacheco Vacacela
<lionso@murena.io> wrote:
[...]
> Since the 7.1.x kernels, systems with AMD CIK/GCN1.1 APUs (Kaveri,
> Kabini, Mullins) that use the analog VGA output get no display signal
> at all: the monitor enters power save at KMS takeover and never wakes.
> The machine is otherwise healthy (reachable over SSH). 7.0.x kernels
> are fine.
[...]
> Root cause (upstream): Linux 7.1 switched CIK APUs to the amdgpu DC
> display stack by default (c81f35cdbab2 "drm/amdgpu: Use DC by default
> on CIK APUs"). DC's support for the NUTMEG bridge requires forcing the
> DP link rate to HBR, but upstream commit
>=20
>=C2=A0=C2=A0 a62346043a89 ("drm/amd/display: Fix coding style issue")
>=20
> inadvertently broke that quirk (the preferred link rate is no longer
> applied to the link setting the algorithm iterates from), so DP link
> training against the bridge fails at RBR and the output stays dark:
>=20
>=C2=A0=C2=A0 [drm] enabling link 2 failed: 15=C2=A0=C2=A0 (DC_FAIL_DP_LINK=
_TRAINING)
>=20
> Upstream fix: "drm/amd/display: Fix preferred link rate for NUTMEG" by
> Timur Krist=C3=B3f,
>
https://lore.kernel.org/amd-gfx/20260529090909.13206-1-timur.kristof@gmail.=
com/
> Reviewed-by: Fangzhi Zuo, applied to the amdgpu maintainer tree on
> 2026-07-10; not yet in mainline or 7.1.y at the time of writing. Also
> tracked as https://gitlab.freedesktop.org/drm/amd/-/issues/5465.
[...]

This ended up as commit 9fb646bc4d87f62bcbf0a7ea326430eb802c475c in
7.2-rc4.  Please queue it up for 7.1-stable.

Ben.

--=20
Ben Hutchings
Experience is what causes a person to make new mistakes
instead of old ones.

--=-uFNZlqKrHuZ1tmo7NEC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmpmFHoACgkQ57/I7JWG
EQlEHw//UnjgIp2J9t0KqaVzw1wRm9P+WfeAMEk5FlE74JpGlmyVjqgxksP65qvM
rVjzWkeF7NzhOwn0T4jXYewQ1K/A0wPV2RNc9dcEjH9iSO103fRvD/khgr81H5++
ZP9JjAUgbTlZek8+IhxMR1iUi7WqF9YtCuFqJpurY8YB0v5xSOrpG+0R+/BuT6uu
WRL4uLyQhfpqxNw2zYzkcGn48YRsOex7zd2dcQoOfvxtcge7rTaUs+H7sM3VpvHp
CkZQZ3VcfO1WO/uhCeHqjEfWFjTpY16DEjbJE3J2Txshw8XEefjjbKLj+5ehJCT4
vD+eCwDgmElJVP0Xkm7BuLK7RdEm0GKDrwigr36jNSUGpzGX/9ZR/E4f0gKAdAhP
R+CbRZ+sVav6437XHQL1sFVDQ6Ftreowne4yjLrgQGR5V9aqZPiRusZRxHvvtku6
/vXLL1gwqzEg5uvIzZokW8UIWngYSnMr5BJbgpQMKOg4reMYfIWg5DhcpHbJniWC
GDX/HiBQgr609T7FN41zIdPj4ErVrLSRSI1VyvlswBmFd3Ve+JRmHAy3REWsYne+
zDPZ9M6wXrSZJsR7dFA24Eb1UFLWipF+CTvoFA3pVXKk3SC0Njc5reWs51zMJxPs
7bD/wGK484b3fPK5qo7lNbY/Vog2fZbSII98U9DU9c0r7DmLTng=
=zylM
-----END PGP SIGNATURE-----

--=-uFNZlqKrHuZ1tmo7NEC8--
