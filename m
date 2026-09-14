Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165B3B0AE7;
	Mon, 14 Sep 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374137; cv=none; b=uzVT5s6gOwfr2NydH4lZrR24s0GlD45cOHiLavVz6+XrvDgfzuNmjKjK8UVOtfCaVQvwF+2hGMmh0QJpHF/x/UVKHN+sIbiHiFKNtmRYqFkHP3KLNL3TThBMb4ELb75XECHjDZUeaOk0eHbR8pg6afHfgoR61kd77GjRVE9iuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374137; c=relaxed/simple;
	bh=aOGAgvFr6K5gkYIVT+sQKhJ6XWCojHsQ6Wys2IjAOqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HU1L9/nb4Ma4osfkX6jbu+2d7E6zsjwOh9ORSEtpQ7YBjwq/ykXZVuTY5qSTdmj8+k13ZlN+yg6rP0IFjv1JDsMZGqGB+1Jxx1Uj6GUPrrbhOXKz+1Fl4jFwbSvwMOvihFR+JGsAt/PU62FEr6PRZ2jlLev0vGuXjqiEcm35StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT0aqoxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT0aqoxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53281F000FF;
	Mon, 14 Sep 2026 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374135;
	bh=guhZ8FW83pVELG408pA0FyuTIeBbIAqtyDJVtprHt5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VT0aqoxNJoMyCEsElwqUdK6d8/rVV7fP8NxuVYjX2/7IkgG82xxL9rGYbl8wTy9G5
	 6htHWfBvu4f7HhfR/YPUrrsOc3nUKl5IUsiIZnuRMG7DCoNNj4v5Pdy+dmTJrnB4af
	 H+aIO5tTWiWmSHjjfMBbAsVyuYXfkWfGEUkv3CuUkMKufgEkze6+t4gKy5CsKiYi4w
	 IUwk3PiwNC1RmVsiaq1ZodHpaQHmgDC1fKVbHY0bcD6yfPpSS2za4vghcmtqMEKr6W
	 wZM2vnbxchuzQtamydqPVkQzP0Y1CPP43asMml4a17L53cUWXq7+xqO8Hv0e+ttn95
	 Y0wH6cqNARM/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
Reply-To: sashiko-reviews@lists.linux.dev
To: pratyush@kernel.org, mwalle@kernel.org, "Itai Handler" <itai.handler@gmail.com>
Cc: takahiro.kuwano@infineon.com, linux-kernel@vger.kernel.org, vigneshr@ti.com, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, stable@vger.kernel.org, richard@nod.at
In-Reply-To: <20260914081149.1916589-2-itai.handler@gmail.com>
References: <20260914081149.1916589-1-itai.handler@gmail.com>
 <20260914081149.1916589-2-itai.handler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:22:14 +0000
Message-Id: <20260914082214.E53281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing spi_nor_unprep() on error path when wait_event_killable() =
fails in spi_nor_prep_and_lock() and its variants.
--

commit c817801772cd87c9d5fe101e67f14bf0d06c97df
Author: Itai Handler <itai.handler@gmail.com>
Subject: mtd: spi-nor: fix the lock left held by spi_nor_rww_start_exclusiv=
e()

This commit changes spi_nor_rww_start_exclusive() to use scope-based
mutex cleanup helpers instead of manually locking without unlocking.
This fixes a deadlock and allows operations to proceed when the flash
is busy by ensuring the mutex is released upon returning.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd04..8bc117b46e028 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_=
nor *nor)
>  {
>  	struct spi_nor_rww *rww =3D &nor->rww;
> =20
> -	mutex_lock(&nor->lock);
> +	guard(mutex)(&nor->lock);
> =20
>  	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
>  		return false;

[Severity: High]
This is a pre-existing issue, but while reviewing the wait condition here,
I noticed a missing cleanup path in spi_nor_prep_and_lock() and its program,
erase, and read variants.

Looking at spi_nor_prep_and_lock() in drivers/mtd/spi-nor/core.c, it starts
by calling spi_nor_prep() which acquires resources like a hardware mutex and
clock. When parallel locking is enabled, it calls wait_event_killable():

drivers/mtd/spi-nor/core.c:spi_nor_prep_and_lock() {
    ...
	ret =3D spi_nor_prep(nor);
	if (ret)
		return ret;

	if (!spi_nor_use_parallel_locking(nor))
		mutex_lock(&nor->lock);
	else
		ret =3D wait_event_killable(nor->rww.wait,
					  spi_nor_rww_start_exclusive(nor));

	return ret;
}

If wait_event_killable() is interrupted by a fatal signal, it returns
-ERESTARTSYS. Does this directly return the error and skip spi_nor_unprep()?

Since the controller's .prepare hook acquires hardware resources, would
returning directly here cause a permanent deadlock on the next access and a
resource leak?

Userspace triggering I/O on an RWW flash can be signaled while waiting for
ongoing I/O to finish, so this error path seems reachable.=20

Does this same pattern appear in spi_nor_prep_and_lock_pe() using
spi_nor_rww_start_pe() and in spi_nor_prep_and_lock_rd() using
spi_nor_rww_start_rd()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914081149.1916=
589-1-itai.handler@gmail.com?part=3D1
