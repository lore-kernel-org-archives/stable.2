Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5921F91F6;
	Mon, 10 Aug 2026 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350333; cv=none; b=Fb942qmOV86KQtg3I4c9v8t5mIYlMKW23Uxy9My6BeuoTa/czTuy0wH10dYw81BuCHcbJm9x+LcgsG4nH8L2EiRlvGNQztioJxSsqKTnO6OrYt6X81cA0KwWnaNlg9hYgL82Z28CN4wVyW2bo9H8FNXIHiIhMMvj4tR1hqhPhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350333; c=relaxed/simple;
	bh=LYXjtDIYAA94heyC/US9TSLC/t229F24VD4JevZY8sM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=SmXrZB9S4IUUWGpCLtAsIlwr07oDk5FbbK633+pgi/ucxEcsCD/Z4WsEguyTY1wrfhJswvGMwWZ9n9Jbzf0a4xYaYhifZlTkuwHade3cm2nSZ8iVtUNchfQaBiwjeUmneNCCZsBw1w+k9a/sHHWKe0GJuodOUJHhtRKvNHgqYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XviqKGfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XviqKGfN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 529FB1F000E9;
	Mon, 10 Aug 2026 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350331;
	bh=C2KZh8MLQ/aOgrMaNoHpKoAfAoY2VLfamQaMJSU87yk=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=XviqKGfNPfm7Qer6+2P1NYk0t8MzZS37lhaaINtkKjzYaqqLLrWqtdu4Bj2Ee4qXE
	 F02ZwcJBKEOHxr3pYVZT7J1xHWbIMJagymStlq2u0kNr/V3Yl09ZOpVjcHjOhqwy6L
	 4YsYncCxc7Xc4WkNX2I3SoNChdoOnRZucFwbeyh/XGKQtLMFd203N3MX/kWmFEo9Ds
	 Eg5nDHlCa+MVbwD0emlXUKzjdhx/Y4/dDWMTa1V5OpPnycv+8d7Z6iy2zuP/BlNQBO
	 BgdX8uR3tm/4SRpTkjEF/FRIu2avZRmGdg+t7cxPupnSUp5X/q8xvt1EbjU6jNgdOM
	 jcE+upt+VkniA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=21f07eccd79721a84a7dde8db6b46a9390e37f79785d731da48d2cee5dad;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 10 Aug 2026 10:25:28 +0200
Message-Id: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>, <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
Cc: <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>

--21f07eccd79721a84a7dde8db6b46a9390e37f79785d731da48d2cee5dad
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sun Aug 9, 2026 at 10:42 AM CEST, Runyu Xiao wrote:
> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. The raw mutex_lock() leaves nor->lock held when the busy
> condition returns false, so the waiter can block the active operation tha=
t
> must clear the RWW state.
>
> Use the same scoped mutex guard as the other RWW start helpers so the
> mutex is released on both the busy and successful condition paths. The
> state flags remain the handoff to the caller, while
> spi_nor_rww_end_exclusive() continues
> to acquire the mutex when clearing them.
>
> The change was checked by comparing the original and patched source.

What do you mean? Was this AI assisted?

> A source-level check of the original wait condition found that it takes
> `nor->lock` and returns false while an RWW operation is still active. The
> patched source was checked for a scoped mutex guard that releases
> `nor->lock` before the wait condition returns. A user-space pthread model
> held `nor->lock` on the false-condition path and showed that the
> operation-ending path then blocks when it needs the same mutex. No live
> SPI-NOR test was run.

What do you mean by "user-space pthread model"? Ported this into
user-space and tried it there? Please keep the commit message
precise and don't use any AI gibberish. Please, explain what's going
on with your own sentences. That way, it shows at least some
understanding what you are trying to change here.

That being said, there is something odd about that commit. Tudor, do
you know why you've omitted the guard() in spi_nor_rww_start_exclusive()?

-michael

> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd0..8bc117b46e02 100644
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


--21f07eccd79721a84a7dde8db6b46a9390e37f79785d731da48d2cee5dad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCanmK+BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h98gGAgzRVKT7YydU2Ap86SZdq4kL1YHee8oiH
DukMY7ja3eIL8iGSZO/dqSZvORbENsmKAYCSOOx268ogFrjUgCZJOYEH/rt9Pe9r
8L49MubPKoYyR4tGnFPaONgUF7n7mQvlhUg=
=0O61
-----END PGP SIGNATURE-----

--21f07eccd79721a84a7dde8db6b46a9390e37f79785d731da48d2cee5dad--
