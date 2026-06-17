Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48E2D2488;
	Wed, 17 Jun 2026 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666738; cv=none; b=TATOtj1Ic116mMem5rrgmpOB8F2qb/yXWbaIGG30wDZYjyNueexEa41Way/Goa2sRxyRywWRaLXQhy9KWRLN9Ju7MZTfbW6QfxSfC15hYXhQCn+VL7fs80JJ6EP+wIAIcrtCGanfBhE4PC/8VvUmVctmnN1NbwjaByWKlAq2wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666738; c=relaxed/simple;
	bh=ajBIolQ6LDOctEdoRq2od/QuBcUipCgrBkt+1ne+BxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcGUtZVuyie+PjXt+SuiqHz5J8NOqIsCJdJ2Cg+GKKhQUAu49leF8ZSUjodtSZafKSzQMuEhTxfyDzNOlWU7bYYVXhvDb+YL3m34GE65GfyWi0c2xpC9T0JlEWpS2XWZtnv2cpfOXK5UBtia5hVm8+i04QzDO9mC15Rrqj2qc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQeCZFo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQeCZFo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C981F000E9;
	Wed, 17 Jun 2026 03:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781666737;
	bh=rG57W1MO2nHpbFzCuSNvonU1eaTHOfMztvUqA0ANsSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iQeCZFo+FN3kbrZ3dPsZCE1pwroMOQAkWB7GbtiwiTdrd5VJhq5veJAw2CdWAtS3o
	 +8kcmpqpWkD/sXiN08bDrjIvPduNiNojOnaEoNmme1OA2bQq5ULF3uZPS/Se+Aw58p
	 XqJR2BJ55n8tZFm9xrd+vjIFmZlpo0qhDTW7GkB0q9tXgW0+HlHl/1SLmfb/6FDREY
	 b3bCTyN97o6v04ONsu8+4gYPt6hCODXiBOe1Xu9BYE682BXK8NsrNUUwFVGH4Qy1C3
	 +C09entxqDmMeYxL9kzq9LqhDhgRYglQv5nm3FZfo1aTksYphvOu+4gYmYYTEVgjs9
	 d2fM+aVxXHGLA==
Message-ID: <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Date: Wed, 17 Jun 2026 12:25:25 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260616193929.2394119-1-rdunlap@infradead.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260616193929.2394119-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QpOL9oPbQYZGbrAD0iVZeOPy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QpOL9oPbQYZGbrAD0iVZeOPy
Content-Type: multipart/mixed; boundary="------------jONvN0C0jCddOYxZde3BKxJo";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Message-ID: <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
References: <20260616193929.2394119-1-rdunlap@infradead.org>
In-Reply-To: <20260616193929.2394119-1-rdunlap@infradead.org>

--------------jONvN0C0jCddOYxZde3BKxJo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[+Cc Kees and Jonathan]

On 6/17/26 4:39 AM, Randy Dunlap wrote:
> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
> the kernel-doc to indicate that it is optional. This avoids kernel-doc
> warnings:
>=20
> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' desc=
ription in 'kmalloc_obj'
> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' desc=
ription in 'kmalloc_objs'
> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' desc=
ription in 'kmalloc_flex'
>=20
> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the =
new *alloc_obj() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

I think there is no better way to specify an optional parameter, so:
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

By the way, the doc should probably say that it is GFP_KERNEL when it is
not specified?

> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
>=20
>  include/linux/slab.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --- linux-next-20260615.orig/include/linux/slab.h
> +++ linux-next-20260615/include/linux/slab.h
> @@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>  /**
>   * kmalloc_obj - Allocate a single instance of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or N=
ULL
>   * on failure.
> @@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * kmalloc_objs - Allocate an array of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate an array of.
>   * @COUNT: How many elements in the array.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to array of @VAR_OR_TYPE on succes=
s,
>   * or NULL on failure.
> @@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
>   * @FAM: The name of the flexible array member of the structure.
>   * @COUNT: How many flexible array member elements are desired.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL o=
n
>   * failure. If @FAM has been annotated with __counted_by(), the alloca=
tion

--=20
Cheers,
Harry / Hyeonggon

--------------jONvN0C0jCddOYxZde3BKxJo--

--------------QpOL9oPbQYZGbrAD0iVZeOPy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajITpQAKCRCGXBN6rc5S
1lS0AQC3hp/oL8t9UoXUGcoyQT5XDRzDiaFWoy7VveAHQqbuvwD/S93XEIJXHccp
0NONbGxKhiry/w/7p/MXj5JCMx4sRg4=
=Rv36
-----END PGP SIGNATURE-----

--------------QpOL9oPbQYZGbrAD0iVZeOPy--
