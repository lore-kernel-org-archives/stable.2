Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031403F9A1E;
	Tue, 13 Oct 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903797; cv=none; b=nGsrVA2hOrqvOoi9qWnnofACGARRlF/XSoDzHXivhi2QH2vfYUuRncVAyLZPCY8vn/WKwZCQOJWPXyoUSrz1Fu/RnFuJx+h8TTqvOneh7Sk9aKCp1Id/aDOtb4L5A6j9ndz60Tv0+otSdCsADncmBU31fsjGbFB/Jn1Z/FG+lkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903797; c=relaxed/simple;
	bh=Pi9LSYarjLX+3vvzjZhtTrpY5MChzmnUBJGMA66TyCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmEMQTyUiiL/DABHJTE9XYHBV7Yk59s2Ui7EUJGcSXSsOoW0TC6fAKz49MhVjQ5YpJ/1DBLwmtPdcj9j+OMx4n5l6ffN8IO9r/uTwIQxIQi1v8elFKOtSKYfj0sp939l4uM5cjFpqBhPD4NnjJiJEJbcwAtr/OU/HPDU5sTjLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=PP6KBkiG; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="PP6KBkiG"
Message-ID: <662b749c05634b6990d072cb87a442687b41be33.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791903793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi9LSYarjLX+3vvzjZhtTrpY5MChzmnUBJGMA66TyCA=;
	b=PP6KBkiGllBsDBfJ+qINnKOAPEz9uCFYbkchSzqWQ1pm7bapeEDpUXBktj2ihx3XYoXRo/
	H6+F/uKmotuqTl8IebEPWJ8JpZNpQPSUILLcfX3Q7Qa39rg67bjFFkSosaPB1VqJQvSHp7
	t5cVmwJV01QNkHIqswer6KpwLlfqLAU=
Subject: Re: [PATCH] fs/proc/task_mmu: fix lost maps entries above 2^63
From: Stian Halseth <stian@itx.no>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton
	 <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes
 <ljs@kernel.org>,  Vlastimil Babka <vbabka@kernel.org>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Andreas Larsson
 <andreas@gaisler.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 13 Oct 2026 17:03:12 +0200
In-Reply-To: <e300f046-dcae-4539-bf89-92eb8c575e25@kernel.org>
References: <20261011162019.922436-1-stian@itx.no>
	 <e300f046-dcae-4539-bf89-92eb8c575e25@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uXyPDiAoKUAB3fHHAbUw"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-uXyPDiAoKUAB3fHHAbUw
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-13 at 16:40 +0200, David Hildenbrand (Arm) wrote:
>=20
> Would it be cleaner to reject any special values, that is,
> SENTINEL_VMA_END and
> SENTINEL_VMA_GATE?
>=20
> That would match the comment and the previous code idea: exclude only
> 0 and
> sentinels.
>=20
> Could consider a simple addr_is_sentinel() helper.
>=20
Agreed, that reads better. SENTINEL_VMA_END never gets this far, since
m_start() returns early for it, so it is no functional change.=A0

I'll send a v2 now, and maybe Suren can have a look directly at that
version.

Thanks,
Stian


--=-uXyPDiAoKUAB3fHHAbUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCas5IMAAKCRDoeAEuJe36
VsL8AP9E+0k4mprykfqrvUdh7fvR+jw8P0kF49qCLBaCfiRY3AEA33afxSogFsKp
woQkB2y6j4zmffrBo1NCiMSYSU3b3QQ=
=sVmV
-----END PGP SIGNATURE-----

--=-uXyPDiAoKUAB3fHHAbUw--
