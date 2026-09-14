Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6443F5BFC;
	Mon, 14 Sep 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374291; cv=none; b=kdRUrEjPkvsDqCniqAHJKZKan8JW3ijaVERF7Xps9r6WRcA863NyMsoJHu994qQobCb6zpPs9amtbNdL6MR61iN+hraXj+4+QMuVcukTnhhFz6TuPPD16AuysgeqZrreu7vpF9vlDDV0FO6BqdzcfvPCot+xuzt7cJ6Uz6hIiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374291; c=relaxed/simple;
	bh=JmFZMt88JwVaof53k78e5/whYkg3Gyb/3fcAHy6uUJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zv7IukqeOT1DVsQE6hZ6lMTgFGx4FshyzhHzxPEg9eVjeYJdqC6j71WogCI7kugZOp3l7hKHdhBuNf+6YEQ2hPonOGxSFWrC72N2AFE9BPIGtGiZFjrpTPuiRuaU/+bwHf6luV6B8BWxhsq73yEAzu+Itu55R5EyXqrb6gVMVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdVkNLEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdVkNLEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334741F000FF;
	Mon, 14 Sep 2026 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374289;
	bh=kVq+AJquutVh4If0ZLCViIV5j+KZDo5vwts+woKOrcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdVkNLEUIn0ypPrEA8AlLeQ4evhL/D1pCana7Sknb4bRcGztVI6+VpNkkZUppCqcl
	 MTs5ECWXr84x4VYWhqeWgh1qi618TTBP+KTMJnKpOUhTTKykvm4+piWbFyGL6G2iXT
	 t3Iv2GaKnDWdtKfmtPTN8XwIx1G76Zc4KV3GOjOY3uFI312W0GOVo5//FD613hZcTp
	 iN+SOIqR/mBxLTmgVpQlw38ZDP+TNzvr+jyq58ZqNI+1SUnkNI8hOVXumk9rjRQAaX
	 myzgAFIUekJRCugd/9CGbIXQ1B8ltPUC/id7vQuze1/59EU75WoFJKkCqqlolnvPDk
	 u5wgq8icwF6vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: take the flash lock in
 spi_nor_shutdown()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Itai Handler" <itai.handler@gmail.com>, mwalle@kernel.org, pratyush@kernel.org
Cc: linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at, miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org, stable@vger.kernel.org, takahiro.kuwano@infineon.com
In-Reply-To: <20260914081149.1916589-3-itai.handler@gmail.com>
References: <20260914081149.1916589-1-itai.handler@gmail.com>
 <20260914081149.1916589-3-itai.handler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:24:48 +0000
Message-Id: <20260914082449.334741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Returning early from `spi_nor_shutdown()` when `spi_nor_prep_and_l=
ock()` is interrupted by a signal skips critical hardware restoration, pote=
ntially bricking the device on next boot.

Pre-existing issues:
- [High] Missing `spi_nor_unprep()` on the error path of `spi_nor_prep_and_=
lock()` and its variants causes controller resource leaks and potential dea=
dlocks.
--

commit 45363f008a63391ea1e85be5cb9b77e5c2d59277
Author: Itai Handler <itai.handler@gmail.com>

mtd: spi-nor: take the flash lock in spi_nor_shutdown()

This commit acquires the flash lock in spi_nor_shutdown() to serialize
device restoration with concurrent operations. This prevents the restore
command from being ignored by a busy flash chip or corrupting an ongoing
read operation during system shutdown.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8bc117b46e028..647bf8dce7193 100644
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
> +	if (ret)
> +		return;

[Severity: High]
If wait_event_killable() in spi_nor_prep_and_lock() is interrupted by a fat=
al
signal, it returns -ERESTARTSYS. Will returning early here skip the critical
hardware restoration in spi_nor_restore()?

If the flash chip is left in 4-byte addressing mode, could the bootloader
read garbage data on the next boot, effectively soft-bricking the device
until a hard power cycle?

[Severity: High]
This isn't a bug introduced by this patch, but does spi_nor_prep_and_lock()
leak controller resources on its error path?

Looking at spi_nor_prep_and_lock() in drivers/mtd/spi-nor/core.c:

int spi_nor_prep_and_lock(struct spi_nor *nor)
{
	int ret;

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

If wait_event_killable() is interrupted and returns an error, the function
returns without calling spi_nor_unprep(nor). Could this permanently leak the
hardware locks and clocks enabled in spi_nor_prep(), deadlocking the
controller for all subsequent SPI operations?

The same behavior appears to be present in the spi_nor_prep_and_lock_pe() a=
nd
spi_nor_prep_and_lock_rd() variants.

> =20
>  	spi_nor_restore(nor);
> +	spi_nor_unlock_and_unprep(nor);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914081149.1916=
589-1-itai.handler@gmail.com?part=3D2
