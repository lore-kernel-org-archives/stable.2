Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803471;
	b=ZZfJ/Yz7utMMhOcSnJJeztTpc0Y0XrtU/hyGZdHwu/1Ek0GBzv/6g1pGoSdzTzoN5GWG
	 xIINjVI60aQB/Jagp1vknX3NdeuXzpYKH2Iy8ArWl50Owqp1fjw5pxdVLix9DbxRo7t7I
	 WhWRx/+GawvtqXaJhZjg0Cxw5oj1h3ziTCtvpkTf0KnKCmWcLmkfBvMkupEY8Hn63cPSn
	 Ckw6MyC9yq5nGsHHcgkHefIrCkhxmb4TN1NHRIHViTpT+ssSgo3pd/o3/0aJ8oER7jBaf
	 KY31NC2x7+cKkDuL0nqW8TJkYfU5kANF+i3RwU5MVq7SbbA5vQb3FsiN0HwTe7MB6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803471;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=XLRfnTSyVrKGMhEo1BPAy8g3XpQrm9HrjoWV2plVbB4=;
	b=CR2uGDBxJz1XoOryaQsKb+kAVqCYG7/pTZ339IMyDmBAvx1ClN7FUslIrQh9o0HHV4mH
	 zW9AJ/kQtEazg755lkdpbpD4n1rGYYmqFzqc4/oRE/txsItJlI70/n3NPBNdqZDu9imqn
	 Z1q1QdSobBsebutDbODJ+x4GhUVCZSquBJsRjb9XH9eYSa8Q5YKFvJJlOO1NcKDGoZXbX
	 Dxsv52Fl9DlWHEZt7ikYFpy4wpmQ4sQWueJpmlMVPUMWux9pAPqCKAIfC80NYu61YKlPp
	 7I/ogD0eSKEBbZYIt93jJHnVZaTZbtvUfHcw7XvaKPizX4tCm+s7/OS+6+xr4BRwofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EienJjew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2051606A31B;
	Wed,  4 Nov 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EienJjew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802241F000C1;
	Wed,  4 Nov 2026 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803470;
	bh=XLRfnTSyVrKGMhEo1BPAy8g3XpQrm9HrjoWV2plVbB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EienJjewkDZ++J1iWGuwrgtvdGACfu0M9zuYsCSYhhK5CIM3w+bBga7Rw7zz2tnaH
	 1/sSf5Wr9+M6gRpeBdTcT9p0eJvkQ2wGmoSo/HDDzNwyfZmgeiT+CrOnNITfeVrJW/
	 hVVM0NT4vvzTBJg7H91OWRQ3KsKXXlvL3TaKuhs3IMUAOQrCWf+Duc+0YEODYlx9Nb
	 b2vNm01E0zADaPz1R/6BpeDaqZXCID98bTHPKMsYSkXmS9ZZSpUjkU9JjuUyJ1ihT7
	 ENeUV4+99U9WTVKXJtY4/q2hOExqnCLWqpoqcjRRyOTOkgctQs91Uk5IAT54yC9NTi
	 mSNAZv5TkAQ/g==
Date: Wed, 4 Nov 2026 14:44:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] regulator: disable disable_work for good in
 regulator_unregister()
Message-ID: <1c80a8ab-673d-461c-9b24-0475110c46d0@sirena.org.uk>
References: <20261103174911.1600930-1-lui2012qwq@gmail.com>
 <20261104134838.326041-1-lui2012qwq@gmail.com>
 <5e63dcea-a397-41a4-a647-a356ab67f1a9@sirena.org.uk>
 <CAE=Q7=5Dx7DYoVO=VcO9gs8euBY3c2hfJ2yze1HQuymJj=ZH9Q@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="KEbYb1efJ8uTenNo"
Content-Disposition: inline
In-Reply-To: <CAE=Q7=5Dx7DYoVO=VcO9gs8euBY3c2hfJ2yze1HQuymJj=ZH9Q@mail.gmail.com>
X-Cookie: All rights reserved.


--KEbYb1efJ8uTenNo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 09:58:35PM +0800, Chengyu Liu wrote:
> On Wed, Nov 4, 2026 at 9:53=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > Please don't send new patches in reply to old patches or serieses, this
> > makes it harder for both people and tools to understand what is going
> > on - it can bury things in mailboxes and make it difficult to keep track
> > of what current patches are, both for the new patches and the old ones.
>=20
> Understood, sorry about that - I'll repost v2 as a fresh thread with a
> link to v1.

No, please don't do that - that will create even more confusion as there
will be multiple v2s floating about.

--KEbYb1efJ8uTenNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrRMoACgkQJNaLcl1U
h9CKQgf/aiOEoOULnF8ThaiN6AJb8ZKctN+rZMJZLzU/mekkMGEcBdIXzZJ/935p
RsEagDrP3UX81IN2Y6rDCSOch7p+C2P99DOOGGudbC8E3xB+boACWunxo7KZlkgT
88NKtnaWCiTbPNnQRt7WT2fPXIrBRyl41479dWKFHt+2Q1xLJ0PXY5d991btp51K
AJFGMvBludh326obHLEjs2lhX3hFnEN6nh5gRABiTJFjXh3EtcLstzikqSkCn2lw
V0lsnSACmYFHzE0e7qYhAvTq6EovaktnFRrgo9QOX2Hg4FM7aahdIOOUW3veYu1r
dvDBUuTXERDwGDwuGmCalJftYVTuaA==
=4ju1
-----END PGP SIGNATURE-----

--KEbYb1efJ8uTenNo--
