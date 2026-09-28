Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409723EA83;
	Mon, 28 Sep 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604255; cv=none; b=UrxnSMI4fEDpSxpn8p1+23O9uBg1m8rH1VMEhfFUEC9/kDZ5p2Gr97ahA1GyDWG2apYVFTZ0wYyC1HUM41cudRKNKjtzlJjvyglKkGenhmQ9sYykZrQBwu40P5Uk3tsoripKgxScW7or7h3vaBDUM0AkhutcVIj4QZX/2COde1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604255; c=relaxed/simple;
	bh=9ATrm6VTgTxXonDI7dt+StdOZBKe+ytKTYfqfl/RLnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZMhcdvznTLax+XK7u0f+n72WIozG3fYCxOT+mdF6eIOq9cA05oMV8vUYhWr+M7O3dAKhN1osevWa/GeULEPIeS8RGEa0H/sGH/Xs/fm438eTSfukuBO6mxuLWQQQfAu0ReNgcO+OhWlLjwg/VgJlIJrq78A/N/SWW/19C3cKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=K1FJNeBx; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="K1FJNeBx"
Message-ID: <2f1c098f65981b01ef3e0659f24c37a9be188b27.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790604246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ATrm6VTgTxXonDI7dt+StdOZBKe+ytKTYfqfl/RLnw=;
	b=K1FJNeBxL/Q4zNJyN7pCfn9BvQoniWMkuCD9JYtPJpemFE0fJzz6YBTSPVC42F7lYQSIKa
	ihZQCqaPE5tdAfpdHspaVtG6cuGIPVj3nfOZMUOmOCEe1uYeMN5/TrzXLsNvHB2fJ2DW2h
	yX/slkW/CzqfHT0sKJe80UiGrjEuJKw=
Subject: Re: [PATCH 2/2] sparc64: flush vmalloc ranges from the D-cache on
 map and unmap
From: Stian Halseth <stian@itx.no>
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	 <andreas@gaisler.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Mike Rapoport (IBM)"
	 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, nsafran1217
	 <54966414+nsafran1217@users.noreply.github.com>, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 16:04:05 +0200
In-Reply-To: <20260928131828.1504-1-kaloz@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org>
	 <20260927105539.8742-3-kaloz@kernel.org>
	 <1330dc280f59571c1f624ccada069b73cd8624a3.camel@itx.no>
	 <20260928131828.1504-1-kaloz@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-bzlRAMMjjpvw2w2brwE9"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-bzlRAMMjjpvw2w2brwE9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

>=20
> Thanks for chasing this down. Confirmed the path: dcache_size is
> still 0 there, so the old code took the "exceeds cache size" branch
> into flush_dcache_all() every time, and the mondo block PA is 0
> until init_IRQ() runs, so the cross-call landed on physical address
> 0 instead of a real mondo queue. Skipping non-vmalloc/module
> addresses is the right fix.
>=20
> v2 with your check and your Tested-by follows.
>=20

ofc, and thanks for the patch!

Makes me happy to see so many SPARC fixes.

Hoping to more of them in mainline / stable backports soon.=A0

Poor Andreas will have his hands full now ;-)

Best regards,
Stian

--=-bzlRAMMjjpvw2w2brwE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarpz1QAKCRDoeAEuJe36
Vs9/AP4q16R7cU4nmeKRBIWEyhu0LqBeBZhSdY5HAhXr5HoYhwD+Imd/j6Q0SeJc
rX9lCX2vyDRqcA+Mm5lMIs4hiPeB2gA=
=5z7L
-----END PGP SIGNATURE-----

--=-bzlRAMMjjpvw2w2brwE9--
