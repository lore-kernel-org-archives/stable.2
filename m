Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D54B95B2;
	Mon,  5 Oct 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213360; cv=none; b=p02mnJORyMc4/ebP8Mi1X/l08eJPTsWG0s0w9MvS1mnS5i4jA26FTK8bKcxRcYXoBur0GTs8753tyJ+d1Inu88kSYynnVQIcjSUVDk42UNKHbaaY6uE0z3xRZGlTiQxkaVa49RWARSIkXhxbQXjPUZ9pPmBu6NdnFBm97dRHXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213360; c=relaxed/simple;
	bh=uWQLeNOxsComWCIOqGdY0uS9YTS69A3nhBq06GXeH+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NoWf6ygsTuH/RUEB5uigvMYsG0YaPy90NJuYEM2O6d8++TIoEQf1YEsPYsvV7supuEymSDnu3Pl2ayJhI1x700nMLniJyBxkwEwgCJZrNoV1UxuZM5KVJ4E76DbZkKyWR0Me4CFTd7+Bg5SbDQOipXVDz7cMJ7LcWiEGTpFaUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Rwv/1DYq; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Rwv/1DYq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=uWQLeNOxsComWCIOqGdY0uS9YTS69A3nhBq06GXeH+E=; b=Rwv/1D
	YqKojMzxXW7ifrzuve7WNNLOz8yEFDnFY28bdQt5PWOR5qJVU4aisH7HmK3u+OvWd85CauHKjaqmC
	0xTO1p/FQyfpXpReEJAbbKMwuixRr2FWrk/SkPcLdfY4Vzd2sprhB7ie4zm1H8jW3N8XFeNhBU4eQ
	U0Ob1AqZ7r7xDdYF7iHr+RN3CPnScOd+e43XOxebhoCrZLdqbqz8w2fGPJRPIur6sidp73N4upKOj
	+WFv99sRd4SooCprqq2NGRFV+d1nPTXZbaZIYBQiTxQcz5Y2wH9ik4cwUrkDHg2TWer7OFMihS0WQ
	rWbrIUZZYruaGAQIPqpUH0/JQgYw==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xDkPN-00000006JzU-1Y0n;
	Mon, 05 Oct 2026 15:15:17 +0000
Message-ID: <4686fbed54796cbd32b5d524938d9cde184ca501.camel@surriel.com>
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
From: Rik van Riel <riel@surriel.com>
To: Lance Yang <lance.yang@linux.dev>, dave.hansen@linux.intel.com
Cc: luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
 mingo@redhat.com, 	bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, 	qi.zheng@linux.dev, nadav.amit@gmail.com,
 thomas.lendacky@amd.com, 	kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, 	brendan.jackman@linux.dev, jannh@google.com,
 mhklinux@outlook.com, 	andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org, 	stable@vger.kernel.org, toshi.kani@hpe.com,
 david@kernel.org, 	mikhail.v.gavrilov@gmail.com, pfalcato@suse.de
Date: Mon, 05 Oct 2026 11:15:17 -0400
In-Reply-To: <20261005052302.43042-1-lance.yang@linux.dev>
References: <20261005052302.43042-1-lance.yang@linux.dev>
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

On Mon, 2026-10-05 at 13:23 +0800, Lance Yang wrote:
> pud_free_pmd_page() uses a single-address invalidation to flush the
> paging-structure caches before freeing the page tables. With AMD TCE
> enabled, this only invalidates upper-level entries associated with
> the
> target address. Cached PMD entries for other addresses in the PUD
> range can
> still reference the PTE pages being freed.
>=20
> The AMD manual quoted in the commit enabling TCE says these
> instructions
> remove
>=20
> =C2=A0 "only those upper-level entries that lead to the target PTE in the
> page
> =C2=A0 table hierarchy, leaving unrelated upper-level entries intact."
>=20
> Even with all PTEs cleared, speculative page walks can cache present
> PMD
> entries after the earlier TLB purge.

The comment above the function says it all. The TLB
range should already have been cleared by the time
pud_free_pmd_page() gets called:

/**
 * pud_free_pmd_page - Clear PUD entry and free PMD page
 * @pud: Pointer to a PUD
 * @addr: Virtual address associated with PUD
 *
 * Context: The PUD range has been unmapped and TLB purged.
 * Return: 1 if clearing the entry succeeded. 0 otherwise.
 *
 * NOTE: Callers must allow a single page allocation.
 */
int pud_free_pmd_page(pud_t *pud, unsigned long addr)
{

The PMD could have been (speculatively) loaded by the
CPU after the PTEs were freed, so that one PMD mapping
needs to be flushed here, but there should not be
anything else left to flush.

The code looks odd, but it's a good idea to always
ask your AI to draw up a full chain of events for
a bug to trigger, going all the way back to something
calling the mm from the outside.

--=20
All Rights Reversed.
