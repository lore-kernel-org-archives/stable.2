Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96945908AF;
	Thu, 10 Sep 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066902; cv=none; b=mhw/wUChjZg42ULHuWLbvvg7qgbUt1Qjl2ad/BkgjdrSEMbZqhLxNUBRbyYRQULArfSmoudh2VmViZbYHM5KeoAKvouPS97W2UKv/YSn3CxNtOUgeelfQ5p/oylzWUu+mC67qgwanDV1qKGt6kkQtHU7UhtQIH5zE1I7CDa2n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066902; c=relaxed/simple;
	bh=oM36+sCiJzLl1vlQuOx2XFLCpKIJ9874GC4BB6iAR04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqlvPZg8Jw6ak4/mE2VQmnnMPGPELpNkcEclzZmDqdhX3O4ml6DJqdsehYlP5a74gWIVN0+yuEWbxKD2pLHum8kox2miE7Fz2D2IYeWW2Rp+4YgZZtYB5tjTrLZummVX2D+FcnbLgyIPxNLG4CvNYjlVDLHxsUmCgp/O1MWcLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9kDcbfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9kDcbfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6231F000FF;
	Thu, 10 Sep 2026 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789066900;
	bh=o/aJgC7/v4Ab0Ev6JyLQT1mN8r2uNaekGe8w0Q8Fi4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9kDcbfrBDWRVngAIGGKwdtDSajfbjWd5JjJtsPDjlQZxCUNjMzw01/5bP9X80uKF
	 lHzIUUriCuZerdqhq/yVaYD76SA2MC8dTZGLC/gqIK6nc+xYROXN6vI3a6nd13UkuI
	 mTzSCpnC6FiOa6PoTKWU0gn+yeVP5z8j90WI77F4LAB3lxIdpGGGtLqB7YSiBH/v1e
	 S1vhNjaH0rPBcQYtlEnQisISaxXMp5wiG1AeOlUlyau57RDlln7Sd5w2XfCI4HhVZP
	 zUbSIehwFt0tJXxIpFHQrB1ePpaL3CyzUui++f405FmO3J8p8GikOB6wpOiaxKzFj1
	 0JDwNz23IO70A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: take the flash lock in
 spi_nor_shutdown()
Reply-To: sashiko-reviews@lists.linux.dev
To: mwalle@kernel.org, "Itai Handler" <itai.handler@gmail.com>, pratyush@kernel.org
Cc: linux-kernel@vger.kernel.org, takahiro.kuwano@infineon.com, richard@nod.at, stable@vger.kernel.org, miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org, vigneshr@ti.com
In-Reply-To: <20260910184452.895485-2-itai.handler@gmail.com>
References: <20260910184452.895485-1-itai.handler@gmail.com>
 <20260910184452.895485-2-itai.handler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:01:39 +0000
Message-Id: <20260910190139.BF6231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unsafe Killable Wait in Shutdown/Remove skips hardware restoration

Pre-existing issues:
- [Critical] Race condition leading to data corruption after shutdown resto=
re
- [High] Resource leak in locking helpers on fatal signal interruption
--

commit 7d7b032d63ce9b4009f7d886e821261d29fb7c2a
Author: Itai Handler <itai.handler@gmail.com>

mtd: spi-nor: take the flash lock in spi_nor_shutdown()

This commit modifies spi_nor_shutdown() to acquire the device lock before
restoring the flash addressing mode. This serializes the restore operation
against operations already in flight during system shutdown.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd04..96dd6ae6d6191 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3862,8 +3862,21 @@ static int spi_nor_remove(struct spi_mem *spimem)
>  static void spi_nor_shutdown(struct spi_mem *spimem)
>  {
>  	struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> +	int ret;
> +
> +	/*
> +	 * Wait for an operation started by another thread to finish.
> +	 * device_shutdown() runs with MTD users still active: a busy flash
> +	 * ignores the commands spi_nor_restore() issues, leaving it in
> +	 * 4-byte address mode, and a restore landing mid-read changes the
> +	 * chip's address width under the transfer.
> +	 */
> +	ret =3D spi_nor_prep_and_lock(nor);

[Severity: High]
This is a pre-existing issue, but does spi_nor_prep_and_lock() leak device
preparation resources if interrupted by a fatal signal?

If a process is killed while waiting on wait_event_killable() inside
spi_nor_prep_and_lock(), it returns -ERESTARTSYS but fails to invoke
spi_nor_unprep() to roll back the earlier spi_nor_prep() call. Does this
also apply to the other locking helpers like spi_nor_prep_and_lock_pe() and
spi_nor_prep_and_lock_rd()?

> +	if (ret)
> +		return;

[Severity: High]
If a fatal signal is pending during the reboot process, such as from the OOM
killer or a manual SIGKILL, wait_event_killable() in spi_nor_prep_and_lock()
will immediately return -ERESTARTSYS.

Will this early return skip the spi_nor_restore() hardware state reset? Sin=
ce
this skips restoring the 3-byte addressing mode, could the bootloader read
garbage on the next boot, leaving the device unbootable until a power cycle?

> =20
>  	spi_nor_restore(nor);
> +	spi_nor_unlock_and_unprep(nor);

[Severity: Critical]
This is a pre-existing issue, but could releasing the lock while the MTD
device remains active expose the flash's modified 3-byte addressing state
to concurrent operations?

If a concurrent thread acquires the lock immediately after spi_nor_shutdown=
()
finishes and issues a write command, the driver will assume 4-byte mode
and send 4 address bytes. Could the hardware misinterpret the 4th address
byte as data, resulting in permanent data corruption by shifting the
destination address?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910184452.8954=
85-1-itai.handler@gmail.com?part=3D1
