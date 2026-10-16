Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2359C960;
	Fri, 16 Oct 2026 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176130; cv=none; b=TcKb+dBII5sapqQ5w2Vfsd74+LvNmlVc9un/lBG4y6BxF0sUFWc4G416Am3Qy1We/BCry1AvxXyorAKV6MyV3pLF/ruUNIxOffRTaxOlvhZ8K+qozvEWYxTWUh/scGcx/bmVGve9n/Xu0EnOq0JbWtK2+Mvk+AzW+xoDnWya2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176130; c=relaxed/simple;
	bh=83NAm7qyYkwEXRavft5LK4xqvjJEBZGzlvRTDtXgSbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkdbLuZhUbVFXt7couvQ3U0IhbC0IjKrNN30tqJqMx6yN7n6R71kvnwYxY+pHOgfUbcRl2DDhIhXtbd5sDOrqBh2ylESsDzpeupp2VyBO3Mara5y9hQtnLXNv48VM4DP6NWoONX25X/yqsBlVi8v3L1NkHqJLdPmUZLA9FjExVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=ll17q/Sp; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="ll17q/Sp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=83NAm7qyYkwEXRavft5LK4xqvjJEBZGzlvRTDtXgSbU=; b=ll17q/
	Spyeis3hxTUzKQGrNrPge49yGL8fmcE52SurQhbwl2OYsT26/b/D8cVjYgHHmq8Eu9N/Kn6RfriXu
	jxbs4tbB8uV9jNWZMEyEMsMhs/c+LftyU5gc3pe3XtcDR0jTiOzPLObsB/Yasyi5jIL1iytMj9alh
	IG57U+TeEheaOce/P6hHLHNZtj1R9Sh5IMGQwEyPByWWBVUkOBLlN0DQskBQbzElsMruIdug6XSHn
	iVI2QO46EFABPhxBRXC+OR5gwD0ohKk6Ty8z4JqzsCWj8bukFTLTHHb7nkaxzyMb68nf4Stn1a1Yx
	UTbNDtiG+obYG3M5Xt58fk7Ff1iA==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xHms3-00000008q1b-2vDt;
	Fri, 16 Oct 2026 18:41:35 +0000
Message-ID: <8e352038e02e274aab69cd2cfe5820a2734e7f3b.camel@surriel.com>
Subject: Re: [PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kyle Zeng <kylebot@openai.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes	 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka	 <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Jann
 Horn <jannh@google.com>,  Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 16 Oct 2026 14:41:35 -0400
In-Reply-To: <20261015192020.5336a49bc516219e8254dfdf@linux-foundation.org>
References: <20261016011549.61146-1-kylebot@openai.com>
	 <20261015192020.5336a49bc516219e8254dfdf@linux-foundation.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-15 at 19:20 -0700, Andrew Morton wrote:
>=20
> As always, when fixing a bug please describe the worst-case
> userspace-visible effects of the bug.
>=20

> But you have an LLM too!=C2=A0 So please never again send a bugfix withou=
t
> this info.
>=20
> Also please explain whether there's a reproducer and if so, at least
> describe it and confirm the before-and-after results.
>=20
I've been working on automating that for the past
few months.=C2=A0

The changelogs, comments, and code have needed fewer=C2=A0
and fewer edits as the rules got adjusted over time.

https://github.com/rikvanriel/kernel-style

--=20
All Rights Reversed.
