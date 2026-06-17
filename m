Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0C34E779;
	Wed, 17 Jun 2026 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781673393; cv=none; b=evnTApeYGWTBL0VTnRg2NMbMFb2Q8ZMt9IptH02iBQ7RLLvGRPZSQ41gD8Yqcmd/jAr8E4cGuG8pB1ihCCu73lzhIpqt5dD5cQV0ggll5CQir9nnac7FV7hSGbwoHmQXwFi6I5hB3YJ0OcvqXcqz0ntsm/hxHMYb4jBH97UtBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781673393; c=relaxed/simple;
	bh=6KGiEtazipY/39iDkfm+y77g3nW6CZ+XWApOSnKBhZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpEobZbWyZttCfuBIh7rAjVvwheQeCgYmFlHW0/QepQNpG+rDu4mkoPyAiSDpskVIpAQCb6C7oTSnsj9w/49f/DDczl6gStbWt963nPbBZF3ykDoK1OR/8zUodUICqRb48yI/VQ4jc9T1xRNjUnlOEtvXfO7K+lAscr0Xfb2UKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJPz6v23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJPz6v23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A032C1F000E9;
	Wed, 17 Jun 2026 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781673391;
	bh=optTuxDRVX4Xxh/GiuxV8bViN9w6npI10kFhBkpLDZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jJPz6v231XAaES5dnkAcxqwBCRaMnEAbtpwWk0x28tofsgfttjRWn4csRhQBz9X+W
	 bczer+7z2xxBhKCCIZf5jUeOsruXrhrFCdlf0skBgdY3VAP03C23nRxRe6RJiLKQju
	 2/6Bo/bDbAypqU+0DWZXpVIy86ZWcYtfmPVH9EhlZq6CihD7tLJSvBdAtDREbcyNKT
	 t+xqUOcjvZjP2aKqlEnaXR1BtWsyYd+gmNKQpnGMQaMYNGIG4bx/gmDaL8B6McuOtK
	 NAxnXbsDdquftgOfUEIN+PkGXdAVo3ACGoD7LNDRvgMPJYWL4/rFRraQmhM45b5hNS
	 NXVMHmr1v1LgA==
Message-ID: <7ab220a8-2bec-4b00-8bf5-e76dff93fe13@kernel.org>
Date: Wed, 17 Jun 2026 14:16:28 +0900
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
 <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
 <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bKJ2JvUyLmi0aUgh8ALxlOvy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bKJ2JvUyLmi0aUgh8ALxlOvy
Content-Type: multipart/mixed; boundary="------------bC0iEyxP5mx28kx8B10PvWrQ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Message-ID: <7ab220a8-2bec-4b00-8bf5-e76dff93fe13@kernel.org>
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
References: <20260616193929.2394119-1-rdunlap@infradead.org>
 <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
 <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
In-Reply-To: <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>

--------------bC0iEyxP5mx28kx8B10PvWrQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/17/26 1:38 PM, Randy Dunlap wrote:
> On 6/16/26 8:25 PM, Harry Yoo wrote:
>> [+Cc Kees and Jonathan]
>>
>> On 6/17/26 4:39 AM, Randy Dunlap wrote:
>>> Since the @GFP parameter in kmalloc_obj() etc. is now optional, chang=
e
>>> the kernel-doc to indicate that it is optional. This avoids kernel-do=
c
>>> warnings:
>>>
>>> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' de=
scription in 'kmalloc_obj'
>>> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' de=
scription in 'kmalloc_objs'
>>> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' de=
scription in 'kmalloc_flex'
>>>
>>> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in th=
e new *alloc_obj() helpers")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>
>> I think there is no better way to specify an optional parameter, so:
>> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
>>
>> By the way, the doc should probably say that it is GFP_KERNEL when it =
is
>> not specified?
>=20
> How about (in general):
>=20
>  * @...: optional GFP flags for the allocation (GFP_KERNEL when not spe=
cified)
>=20
> ?

Looks good to me!

--=20
Cheers,
Harry / Hyeonggon

--------------bC0iEyxP5mx28kx8B10PvWrQ--

--------------bKJ2JvUyLmi0aUgh8ALxlOvy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajItrAAKCRCGXBN6rc5S
1o+vAP95308qeS2ZXYZ01jII/8FeugApGaKtmElPaVAE0mdMGwD/UrVY7d+FhpVZ
oIbAqvpYj+xMZ97HA2ZObgrk2Eg1JA4=
=JwhS
-----END PGP SIGNATURE-----

--------------bKJ2JvUyLmi0aUgh8ALxlOvy--
