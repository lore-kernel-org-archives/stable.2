Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEB495AF4;
	Mon, 28 Sep 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591627; cv=none; b=NrHELT8LVzC0lDcP3ZNqatqov3v/ZUEcVkQ0RPU5qwQz3y9CYZ/mpVJd/uLVt4+3w4Dr7e46qsm3gONrKUIzH6Tjj0LdLlQqSU/aG4saas+uJwY0IRJT+8RvZlFtkcWphA4DBh7NoCG0r24WuRgmKhH8Sq8X22dtInNiotlyG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591627; c=relaxed/simple;
	bh=zuzhxf31aFjO1aB0SytXMW9/C4VU5fjF5TaP1Mpqplc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f964gdohg5iFFm0rJA9TTdfOF4RcP7wsAeBGOw8KgIksm+3QuwZOz4Hr4zJZjjk3cRF8hotf8PHFmf0FxbQetTEDb5etRTqHslXrIGSGgveVqx0anvfIOKB2A4/e1u437F1grHyZM3EcoSzRjmigJOopB8yNlX9U5CG0jHep8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=nnBwvEJ8; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="nnBwvEJ8"
Message-ID: <1330dc280f59571c1f624ccada069b73cd8624a3.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790591622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1ciwml1+CAvQaRMJG1vQQRI+STEfcssVNkLRhf3H1M=;
	b=nnBwvEJ8LT4JywbcpL1iP7AZZpK6PL91y11r4s19AS1dekOBfaTubSMbf7RXF41sas5vtC
	/dLsUOlPOHiT+kbdsz/JfW7O/6shq/nSakILNG0r2rcMArPmfeq33fbTCX+5yLpqxGGee7
	pSNN86S6izNFFvwinDYBJFjOWdUlQos=
Subject: Re: [PATCH 2/2] sparc64: flush vmalloc ranges from the D-cache on
 map and unmap
From: Stian Halseth <stian@itx.no>
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mike Rapoport (IBM)"
	 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, nsafran1217
	 <54966414+nsafran1217@users.noreply.github.com>, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 12:33:41 +0200
In-Reply-To: <20260927105539.8742-3-kaloz@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org>
	 <20260927105539.8742-3-kaloz@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NPKDmQ6aq1LTMgVvaubh"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-NPKDmQ6aq1LTMgVvaubh
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, 2026-09-27 at 12:55 +0200, Imre Kaloz wrote:
> +void flush_cache_vmap(unsigned long start, unsigned long end)
> +{
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	if (tlb_type =3D=3D hypervisor)
> +		return;

I found that this also runs early in boot, on the vmemmap.
__populate_section_memmap() calls it from sparse_init(). That is before
init_IRQ() has set up the cross-call mondo blocks, so xcall_deliver()
writes its three mondo words through __va(0), to physical address 0.

On SMP, cpu_data() is not filled in yet either, so dcache_size is 0 and
the flush itself does nothing useful.

Physical address 0 is ordinary RAM on the Sun Fire V240. In a test it
held zeros before the first of these cross-calls, and the three mondo
words after. The kernel uses that page later in boot. This happens
once per memory section, four times here.

Since the vmemmap has no aliases to flush, I suggest we skip anything
outside vmalloc and module space, like this:

        if (tlb_type =3D=3D hypervisor ||
            !is_vmalloc_or_module_addr((void *)start))
                return;

With that, the V240 makes no cross-calls before init_IRQ().

Tested on a Sun Fire V240 with a module that reads a page through a
vmalloc address, rewrites it through the linear map on the same CPU and
maps it again at the same address: stale data in nearly every iteration
before, none after. Our V240s never showed #29 (no bpf() syscall
there), so that is a synthetic test. No change on a T4-1 with the
series as posted.

With the vmemmap check:
Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1


--=-NPKDmQ6aq1LTMgVvaubh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCarpChQAKCRDoeAEuJe36
Vu3LAP9THopZuvLMOBeeqW5fg14N5kDzFZk4p3MH9YxmYslFTAD+Mq89gHMleOKk
EJ4pkzTIPKuLmALO0B4EOQlXndny2Qc=
=SAfC
-----END PGP SIGNATURE-----

--=-NPKDmQ6aq1LTMgVvaubh--
