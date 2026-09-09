Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B685455168;
	Wed,  9 Sep 2026 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986890; cv=pass; b=AAHMDv1sixzzzFQKCe5zeDhJgyYi0uXuLVpwzrnzqL8zKRiUsKSb/cQQdvgyjgl8oWH2fc1XtSSCU+S5owqkvicilhRpxJajvxs+wIm50cdKkyI7L1SwF1aio7u8qIFbEwe6AcqTmuytvJggCNb0vDZS/5hrViQXVxJTPDwgb0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986890; c=relaxed/simple;
	bh=pHtG0m8Je8BRoRwqJyRinhzByYeDiQyntG8bh5dq2Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6NiaewGDjJsW6ETV8VGLlXlEXVBdNxwjZk2Xx0kr4+mDJPxQxQ1mNLhzurmMPwNG7SNU4RKCUKG1qPqXpPZxNsNT8ik4qOjuMXWwN4qcipOeX2FR9kHMP2dVu1IMO6QR/2+Lngv/BfxUZrEYL1WGJYbenOa2JlA1c7igskcGF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ICk7Z8SM; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ICk7Z8SM"
ARC-Seal: i=1; a=rsa-sha256; t=1788986871; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=drae9vsfOfgkeLGIQ7LpxvdwOxbXFRRAdfXrK4Xvsfb7nuBLTWKEXp/NVQB0Mf7sVVVbc1kJiEUpHWbr1fXnxwIugfYGxM5fi5N5GRno+9yFzgdZGePKgVN6ShhF4PjE2ZFIo2jWQwVdRMX9lXH27RkJIaybNZVbk1fa7v5Ljf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788986871; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ihk8jq0E6v1GzqxnoCZD7Cb65oa33zaHTJ4K81BNNBk=; 
	b=EW1mghZ/811Oe2FgtTr35iKdBzx4M440ZLH/i3QcFE7Af733YRQgX1x0dJoOYmOwJ/jAd63IQW5xLApIdoUMtuw2Wo2VCkKZ/0a8GjbntlTW0QNeLW0qUiKVuGnFFkCFFBk1r3rk6zvetcDXzCKacmjZsQoVcLQociyjkMVud6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788986871;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Ihk8jq0E6v1GzqxnoCZD7Cb65oa33zaHTJ4K81BNNBk=;
	b=ICk7Z8SM8ezCStVpMLuJX9cuqt1TSAiB9stwOsm/zls8pSc25OyBgoPHP2Nkni9m
	jSVmkOyyWukbtHbqKMsSo8IacbwBPo4+DpqU4KEFskjCZKLeAt3TACq4aGqw3WM2fQ8
	aYdMY3w1ZbWjJ9Ksh8Sba5AFFXiKfJ7ReGPsLNqs=
Received: by mx.zohomail.com with SMTPS id 1788986869418187.2155406658627;
	Wed, 9 Sep 2026 13:47:49 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id A790C183377; Wed, 09 Sep 2026 22:47:46 +0200 (CEST)
Date: Wed, 9 Sep 2026 22:47:46 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
Message-ID: <aqHFUSdrYUR1DJ6L@venus>
References: <20260901145156.3177187-1-mauriziocasciano7@gmail.com>
 <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
 <CAO7O_xi-BYfGb428q1TO4ERp059-BOq78PZR5Ad-bs1ikVkmZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eym42znvk5xrfmaw"
Content-Disposition: inline
In-Reply-To: <CAO7O_xi-BYfGb428q1TO4ERp059-BOq78PZR5Ad-bs1ikVkmZQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
X-ZohoMailClient: External


--eym42znvk5xrfmaw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
MIME-Version: 1.0

Hi,

On Tue, Sep 01, 2026 at 07:04:28PM +0200, Maurizio Casciano wrote:
> Thank you for the review.
>=20
> I agree that firmware-node references should retain priority over the
> legacy name-based mechanism. The "supplied-from" property should only be
> used as a fallback when no "power-supplies" references are present,
> including the case where the consumer has no firmware node.
>=20
> For v2 I will preserve the existing order as follows:
>=20
> 1. honor an explicitly pre-populated supplied_from list;
> 2. resolve "power-supplies" firmware-node references when present;
> 3. fall back to the name-based "supplied-from" property only when no
>    references were specified.
>=20
> Errors while resolving specified references, including -EPROBE_DEFER,
> will still be propagated rather than triggering the fallback.
>=20
> I will wait for Sebastian's opinion before posting v2.

Ack.

Also FWIW the power-supply core has been migrated to be fully fwnode
based, so the CONFIG_OF is not really correct anymore anyways. Let's
have a single implementation for power_supply_check_supplies().

Greetings,

-- Sebastian

--eym42znvk5xrfmaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqhxecACgkQ2O7X88g7
+prbzg/+PXQ8TLG3HiJHwMJe0m4xar9ZomTdZsXalWCRJH1Nq+A4AYxa91+tBh0a
vT9lPkpfRojtlxggiKnew7FjD84aPr9/PwYPCybfWzAuzgy+eF/ukHKKLQHqYejT
b7z/TTp5ImIS/8HB1PBds5Xp8h1qr3hi40puJvjdF4eqfMVHMqCPpSECMDpWkAdL
c7LSz+8Rw4u/GiXhaE1WSXxD7pQRwvy6sRYkMNo5i9y/cZry96ZVYZomp5BdHr6L
psyLyhVA30yhCFFeE/skyxiW6YMOZn/oVxMviATpTTVHQMIyiL4VI0GmlbXDj6gm
W+v5cqAPi+0ug8oOTXFknQ2zhqKCdCJLHphxkY+gDJZsKQCeJNDjzINSVay7LI/J
GUl+t3t/8TlITvu8UIC1bLtKHVk+5otWc7dwvdJiZQClPZFcmK5EP8WEWFFshcya
UztPc8Pke5I5eACKacsYaRbK/NZzkoKj3SdYW7DHtNzDefmYCjDk781UeCcYYr5J
Xh2vQRZ158CD4IhlRYMzaaRCZKP0BKyywG5Nkweb962xjxTsrZNMMrHVVWVAJ22d
ePrLA5NWv/KmvjB7h/WqcEQ0KWXDCXCPE79rIa+ES6a/MITSHSjQXXGmrQLrqWbc
l1gGyDpX8cfl+wXHuglrzQtyenl+STakzYUJialH9oZJREU8/PI=
=ojYG
-----END PGP SIGNATURE-----

--eym42znvk5xrfmaw--
