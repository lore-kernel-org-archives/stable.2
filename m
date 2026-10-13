Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8453C3C9;
	Tue, 13 Oct 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905677; cv=none; b=QCMc1oCWuAOTs5Ykg2a33hYQvvYEuPmzaQssbr7Nedwu0VtLdCn+imGB9lcOpIDDJ1BNDM4uJ2BZCo9/LKhTfTmX34IVvNNd6XhV6kviYAxM6TM/tYXN2V/7B8wE85Mb3GdfvOyRf5Eaj3G3APddDa7A8wiugRdfPTlNLwAbbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905677; c=relaxed/simple;
	bh=Sj0AoQXsnwESrz0SIkRB1YQ+B5vPXZ5e7HQiPxgYXXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0ZYJeXZgkFqpCdqMVxSRfKdE4iAioazZ/8H4LFEpPaqPdE1vGQaJItR32LmQA/nOJlJtWhPM1E9b0xKYUAdV1p3BCqOE1OIGPeoCHviv9Goppl7MzwbogasVgY+ZacjLIEJGtBPymMqu9sobQYggU9KJ8yb9ePAgwLZ5y/UNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=i4lCGBCA; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="i4lCGBCA"
Message-ID: <8443cc78cb8307716989bb462c1c948ae481d151.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791905673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sj0AoQXsnwESrz0SIkRB1YQ+B5vPXZ5e7HQiPxgYXXc=;
	b=i4lCGBCAqvr/zQc3OWo+5P8VT5gKoGiG5xUyTH2CqkDmb4KoDt4l1yfh+QDYfFbdlvr1pX
	wpUeqpF8Hl7axbHUf9VHzmvBVDeI3n7/aBGRC6jD+1LhR23b4eIwHIuy6trlNu3xZRPSrt
	k6ZZO7nn/Si+MF6E22xyQ+mqIP44kq4=
Subject: Re: [PATCH v3] fs/proc/task_mmu: fix lost maps entries above 2^63
From: Stian Halseth <stian@itx.no>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann
 Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Andreas Larsson
 <andreas@gaisler.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 13 Oct 2026 17:34:32 +0200
In-Reply-To: <as5M1BSWcPDHjEWt@gremlin>
References: <20261013152106.1834364-1-stian@itx.no>
	 <as5M1BSWcPDHjEWt@gremlin>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9BCL4Kf7PADg3yYOBgFJ"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9BCL4Kf7PADg3yYOBgFJ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-13 at 16:28 +0100, Lorenzo Stoakes (ARM) wrote:
>=20
> Please stop respinning so fast thanks :)
>=20
> We generally want a ~week between respins for newer contributors. At
> least a day.

Noted, sorry for the noise. I'll fix the commit message as you suggest
and wait for Suren before sending anything else.


Thanks for the ack,
Stian

--=-9BCL4Kf7PADg3yYOBgFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas5PiAAKCRDoeAEuJe36
VkQVAPoCUzG8mmDrCFMN5Ein59AyWLtRlQ007GcgYwRGOrF9IQEAukcMXEHtB4NJ
oRJaaT7GOIwA2fTpfvtsLVydHjjb9g4=
=5ilD
-----END PGP SIGNATURE-----

--=-9BCL4Kf7PADg3yYOBgFJ--
