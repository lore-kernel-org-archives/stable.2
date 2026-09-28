Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360848665E;
	Mon, 28 Sep 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587198; cv=none; b=rC/CPQ0pTascUu4ntF1HfthRJXmSVQd7VNSTm0uFAmDly4qAnSJxSMi9dMw3lgEE8/2E67pcn5rxF5zpFuFK8oLJTNhZ7oqo2hk6Jc6yZ0Ic6EgO7dZL5NfgflX4eTGeHrGTAkPZ5AOrVTlYOTXiK462iWH0Xgru9UhsgVeujhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587198; c=relaxed/simple;
	bh=I8nOXl7t8cmcuppMcg6HL3FKZkZnt0cVmSLLmSZ9yAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcchUGlEtehEBolsRK7vqazTAPER/HRTXVxC9PGJpt6wBeUFA5eBES6UqJNS8lOCo/rqG+aXewRqX/NK57SjM5/eCiXRkC71FiHOrZlzwCNkjVtZfVuQZ9ys78i94wGfe4Zbzvx1sO/aKI8RGaiViE8LXfDjqQXgd7oqqcgfUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=CwKCnsSp; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="CwKCnsSp"
Message-ID: <acf41fd1252d92c2232210e9b766dba406af30fa.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790587193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8nOXl7t8cmcuppMcg6HL3FKZkZnt0cVmSLLmSZ9yAA=;
	b=CwKCnsSpnDVCET0x0KbvAvrB1AU309IcWFJAWWI9kVqzQrFb3w61n4Rdh+nU9PGb7PDw+h
	bAB0NCerIz/pSYOPz/4TCrSi01lTkrOIqegoAbXXa98R7T2SCfa5juZffZwrD1ksu40fgZ
	A725B++TRhZ7oJBmZN5usMAN1Xrf1pA=
Subject: Re: [PATCH 1/2] sparc64: flush only the aliased page, not its whole
 folio
From: Stian Halseth <stian@itx.no>
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 28 Sep 2026 11:19:52 +0200
In-Reply-To: <20260927105539.8742-2-kaloz@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org>
	 <20260927105539.8742-2-kaloz@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TICIXD8YrqEKaJHzl8HK"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-TICIXD8YrqEKaJHzl8HK
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, 2026-09-27 at 12:55 +0200, Imre Kaloz wrote:
> Since the conversion to folios, move_pte() and tlb_batch_add() flush
> the
> D-cache of every page in the folio a single PTE maps.=A0 Both run once
> per
> PTE, so moving or unmapping a range backed by a large folio flushes
> each
> of its pages once for every PTE of that folio, and each page flush is
> a
> cross-call to all other online CPUs.
>=20
> Only the page the PTE maps can hold lines at the old colour, so flush
> just that page, as before the conversion.=A0 flush_dcache_folio_all()
> has
> no other users and becomes flush_dcache_page_all() again.
>=20
> On SMP QEMU guests, apt rebuilding its caches through mremap()
> triggers
> RCU stalls and soft lockups in move_pte().

Confirmed on a Sun Fire V240 (UltraSPARC IIIi, SMP, THP madvise).=20
The unpatched kernel exhibits the quadratic slowdown patch 1 fixes: a
same-colour 2-page move takes 0.4 ms, but a colour-flipping 1-page move
takes 7293 ms (roughly a million redundant page flushes across 1024
PTEs). Thanks for the fix!

No regressions found on sun4v (SPARC T4-1).

Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1



--=-TICIXD8YrqEKaJHzl8HK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaroxOAAKCRDoeAEuJe36
VgtVAQDQ2X8FwFBX5hTafVvJGdicTlYLLqrCuLszB3rBDLDkbgD/b+5BnEQqCUqy
F3ww/lGLLZfdC0i95hFBAgHecjJ7Xg4=
=kmsD
-----END PGP SIGNATURE-----

--=-TICIXD8YrqEKaJHzl8HK--
