Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939D3F106B;
	Fri, 18 Sep 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724096; cv=none; b=gsl0tFio3z+RvFOyHkyq0B4IXrjZVW9k2DHRQphKMKievLVWsWgkfX+kunlShtz5kLGqnOymtwbppCJvd3MO0myTMNLywrmHWLia0vjJGYbHweSTBY6ENqegwjaFsRGvdC/OSyFNXMR7+6HEmtHlx0HWjlPktVAer+pS9YaEkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724096; c=relaxed/simple;
	bh=d+wGjGFpPrAban2UlUUjGfJt48Dfm5A26bgOXi74jJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=J034fYRyaysS26bJatgaDLEVRF+LXiQZ0rBzMVlZv6OwxgytBm/CVdXMh6UG37+ChAuCFR5t3kPpx3POn/jpZoELBP+bE7z0H5AnRVeRnEfQ7YKZcSLMsZ1j6RNsn4RLByTZrFmKvcil2pwGKSH1ak3McTV2SJ32FhSBzf73m9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdgoCwwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdgoCwwY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 675421F000FF;
	Fri, 18 Sep 2026 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789724094;
	bh=QPHM4C13uUGm9R4hEl1eSTnmriAUGxPz23GgFIjAtCc=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=NdgoCwwYKkR3ypH0YDmw8gy1EKRmBVG4VgG/GV/pXWOXDRoQGIarEI1mZLiMfxqP1
	 73oOjm39Pu8r5EngSjEkB+I6ZX8hDi8Y7/wLycxfxuem5tan0OnNWx36l3xCJhpwQt
	 pdYereCG6Svcnhjgdf9Eolzha5fSk96gJc/MSj8Nj6AASc+GV0fduCjFVRcvPMoudm
	 QjjF0EMHuoeUHVnNvAwOkejn1p406zXPenCgzKLtNtaYlzTCA6V+rLim5kYqAsIDvW
	 M59n0S4jjiURMgf1UG/ZFNRsZ17K2Zgw2OKBx/E0gatBTdvUSdk8y+igRwXz+yd3kE
	 C9QE6NrttOAOQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=375f650e369e42fd6ad726978df45da2316eabb327bc1c8e1cde82126883;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 18 Sep 2026 11:34:51 +0200
Message-Id: <DLIC8P2V43E6.34ICV316K7HUK@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: <sashiko-reviews@lists.linux.dev>, "Itai Handler"
 <itai.handler@gmail.com>, <pratyush@kernel.org>
Subject: Re: [PATCH v3] mtd: spi-nor: take the flash lock around
 spi_nor_restore()
Cc: <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
 <linux-mtd@lists.infradead.org>, <takahiro.kuwano@infineon.com>,
 <richard@nod.at>, <stable@vger.kernel.org>, <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.20.0
References: <20260915113811.2429311-1-itai.handler@gmail.com>
 <20260915115206.CCEE41F000FF@smtp.kernel.org>
In-Reply-To: <20260915115206.CCEE41F000FF@smtp.kernel.org>

--375f650e369e42fd6ad726978df45da2316eabb327bc1c8e1cde82126883
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 15, 2026 at 1:52 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] mtd: spi-nor: skipped flash restore on fatal signal breaks boot
> - [High] mtd: spi-nor: shutdown hang due to ongoing erase operation

Does Sashiko have some valid points here?=20

-michael

> --
>
> commit c0578fac7581b63c39bfd99ac3a6f934256685d3
> Author: Itai Handler <itai.handler@gmail.com>
>
> mtd: spi-nor: take the flash lock around spi_nor_restore()
>
> This commit changes spi_nor_shutdown() and spi_nor_remove() to acquire
> nor->lock around spi_nor_restore(). It aims to prevent operations like
> reads from overlapping with the restore, which could leave the chip in
> 3-byte addressing mode.
>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index ccf4396cdcd04..c891197ffa5b3 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3849,11 +3849,26 @@ static int spi_nor_probe(struct spi_mem *spimem)
>>  				   data ? data->nr_parts : 0);
>>  }
>> =20
>> +/*
>> + * Restore between operations, not during one. Removal and shutdown bot=
h run
>> + * with MTD users still attached: a busy flash silently ignores the com=
mands
>> + * spi_nor_restore() sends, and a restore landing inside a read changes=
 the
>> + * chip's address width under the transfer.
>> + */
>> +static void spi_nor_restore_locked(struct spi_nor *nor)
>> +{
>> +	if (spi_nor_prep_and_lock(nor))
>> +		return;
>
> [Severity: High]
> Does this code silently skip the flash restore if a fatal signal breaks t=
he
> lock acquisition?=20
>
> For example, if a privileged user runs rmmod while an erase or read opera=
tion
> is actively holding the RWW lock, and the rmmod process receives SIGKILL,
> spi_nor_prep_and_lock() (via wait_event_killable()) will return -ERESTART=
SYS:
>
> drivers/mtd/spi-nor/core.c:spi_nor_prep_and_lock() {
>     ...
>     if (!spi_nor_use_parallel_locking(nor))
>         mutex_lock(&nor->lock);
>     else
>         ret =3D wait_event_killable(nor->rww.wait,
>                                   spi_nor_rww_start_exclusive(nor));
>
>     return ret;
> }
>
> Bypassing the hardware teardown path here leaves the flash in 4-byte addr=
essing
> mode. This might cause the bootloader to fail to read the kernel on the n=
ext
> reboot, soft-bricking the device until a power cycle.
>
>> +
>> +	spi_nor_restore(nor);
>> +	spi_nor_unlock_and_unprep(nor);
>> +}
>> +
>
> [ ... ]
>
>> @@ -3863,7 +3878,7 @@ static void spi_nor_shutdown(struct spi_mem *spime=
m)
>>  {
>>  	struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
>> =20
>> -	spi_nor_restore(nor);
>> +	spi_nor_restore_locked(nor);
>
> [Severity: High]
> Could this hang the system indefinitely during shutdown if an erase opera=
tion
> is ongoing?
>
> Erase operations (like spi_nor_erase_multi_sectors) hold nor->lock
> continuously for their entire duration, looping over spi_nor_wait_till_re=
ady()
> with cond_resched(). A large chip erase can take several minutes.
>
> Because device_shutdown() iterates devices synchronously without a timeou=
t,
> this synchronous wait for nor->lock could hang the reboot process until t=
he
> erase finishes, forcing the user to hard-reset the machine.

Also I'm not sure, what would be the actual expected behavior here.
Cancel the erase? Wait until the erase is completed? Pratyush,
Miquel, do you have any thoughts on that?

-michael

>
>>  }
>> =20
>>  /*


--375f650e369e42fd6ad726978df45da2316eabb327bc1c8e1cde82126883
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaq0FuxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gw/QF/QsmvZhq/GNNoZGx0bFxmGzPhiNCF/Y7w
NTO8T+aTZC/rVBA8f1tL2oEj+ItKRhIDAYDNbzuEV3wIexW+YcU6CLomaBd9NXbE
ZlrX8iC8hHjxSWSH/4DENWbECuKJ03Ec4yU=
=uqCV
-----END PGP SIGNATURE-----

--375f650e369e42fd6ad726978df45da2316eabb327bc1c8e1cde82126883--
