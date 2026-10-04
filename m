Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205F41D118;
	Sun,  4 Oct 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111371; cv=none; b=XX+qgdNmyelJDzUbwaQe4gr/Dx+RFPwHzabM+PU4bzOyD94A9/+aiFYm68S4Q4Ljwu6DStM1el48v0K1V68ZfdXnEgXR3/PCI/GqR4R0gzvB+T8C6FkCoC175ToQ07MSPhZ/K0kRcn7dHXxboJy7XYyhVR02GrqyfHyvpyPfutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111371; c=relaxed/simple;
	bh=eFjR4KJsXCZAmqydFLtrMntzQlJhSfNh3DmVSCds5tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mnKZrb6WiF3mz2PG58tiutwXPSwROYUJ24pbgWtXnsn+g90bUqfVB28E16i6UHI9nbVFCGgaLlYCUUjKvUFlKkbk5F/zxGxRwetGGGkp0xBE9Y8bHSfc32cKeNjS4Y2rh9hXREzkyYK7yOK8tBXONdBBN5S1h4Vi8AIhEejoUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY233FBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY233FBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4231F000FF;
	Sun,  4 Oct 2026 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791111369;
	bh=LfT/k0ScXAOXisjeEQ/qvWwYfgZMAcMZgWNtcWyAqJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LY233FBEbWEq/nMece1XDsMtBC7SM0a+FlBaEEuYxHT85glvPLEp1JzkbSPAPExvX
	 S96U+21kTurFblm1Q+ogkM2MaQtydJlRjzwiRnEtUcVnY7U2QC4CdDK5Xs4wWZZqY1
	 QMKBS+sCV7/TG8L9zG2Oo1MPTSYA96qMamIyVcnWwXb4mH2NbfI9DvPqdi/C60lgYn
	 dJVHHU3qXVFjYqsgV0QlmoUgeYhSu2TgycP+LNQe+t4Azyd5Q64bEFjd2eSgDgnUnI
	 cBoQZ5sWrPR16sIAgG+odA8Un7uuq82xkQ6SHIRBySEUwQCtqRWe++sBzLXmJtmJqy
	 AlMf2Dkt8TVDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: take the flash lock in
 spi_nor_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: pratyush@kernel.org, mwalle@kernel.org, "Itai Handler" <itai.handler@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, stable@vger.kernel.org, richard@nod.at, tudor.ambarus@linaro.org, takahiro.kuwano@infineon.com, miquel.raynal@bootlin.com, vigneshr@ti.com
In-Reply-To: <20261004104311.2196527-1-itai.handler@gmail.com>
References: <20261004104311.2196527-1-itai.handler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 10:56:08 +0000
Message-Id: <20261004105608.7F4231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mtd: spi-nor: hardware restore skipped on fatal signal during tear=
down
- [High] mtd: spi-nor: shutdown and unbind hang waiting for multi-sector er=
ase
--

commit 470af3f1f5f19ab1426ba1f38a4c4420e0274e2b
Author: Itai Handler <itai.handler@gmail.com>

mtd: spi-nor: take the flash lock in spi_nor_restore()

This commit takes the flash lock during teardown to avoid racing with
in-flight operations. It waits for active operations to complete so that
exiting 4-byte address mode and soft resets are not ignored or do not
abort an ongoing erase. If the lock cannot be acquired, the hardware
restore is skipped.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8bc117b46e028..94dbf1be776f8 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3455,6 +3455,21 @@ static void spi_nor_restore(struct spi_nor *nor)
>  {
>  	int ret;
> =20
> +	/*
> +	 * The MTD device is still registered here, so another thread may
> +	 * have an operation in flight. Wait for it rather than cut in:
> +	 * while the chip is busy the address mode exit below is typically
> +	 * ignored, which silently loses the restore, and the soft reset is
> +	 * typically accepted, which aborts an erase part way through.
> +	 */
> +	ret =3D spi_nor_prep_and_lock(nor);

[Severity: High]
Does this introduce a potential deadlock during shutdown or driver unbind?

The commit message notes that the wait is bounded by the one operation
already in flight. However, looking at spi_nor_erase(), the exclusive lock
is acquired before looping over all sectors and is held continuously across
the entire multi-sector operation:

spi_nor_erase()
    spi_nor_prep_and_lock_pe(nor, instr->addr, instr->len);
    ...
    while (len) {
        spi_nor_lock_device(nor);
        spi_nor_erase_sector(nor, addr);
        spi_nor_unlock_device(nor);
        ...
    }

Since spi_nor_prep_and_lock() calls spi_nor_rww_start_exclusive() to wait
for the ongoing erase to finish, it appears this will block the teardown
thread until the entire batch operation completes. For a full-chip erase,
could this stall system shutdown or driver unbind for several minutes?

> +	if (ret) {
> +		dev_warn(nor->dev,
> +			 "Failed to lock flash, skipping restore, err =3D %d\n",
> +			 ret);
> +		return;
> +	}

[Severity: High]
Can a fatal signal cause the device to be left in an incompatible state?

If a long-running erase is taking place during unbind, and a user sends
SIGKILL to abort the hang, wait_event_killable() inside
spi_nor_prep_and_lock() will return -ERESTARTSYS.

Because this error path skips the restore entirely, the driver core will
continue with device unregistration while the hardware is left stuck in
4-byte address mode. Will this break subsequent driver rebinds or kexec
kernels that expect the default 3-byte mode?

> +
>  	/* restore the addressing mode */
>  	if (nor->addr_nbytes =3D=3D 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
>  	    nor->flags & SNOR_F_BROKEN_RESET) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004104311.2196=
527-1-itai.handler@gmail.com?part=3D1
