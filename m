Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A3443E43
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388158; cv=none; b=cLwHEPQQ207tfjSQa9WTutdHkle85PQ08PfCfBJBVTHzvXSr5d4ShuGaUumyg7Od4QEPrX1wZMMx/usJ8yC/qYGBx2uCfreCCQhrv8PZy6sxg8mJyiLoo9w3VhAGLmuSXkAO4KNwb9mT7B2DeIGZvVq6uL2EZtGdUzjzunEpFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388158; c=relaxed/simple;
	bh=gErqX5CkJ3k5ZE0RlQFl1YtciVW68CeEp9/eczdgOiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsV0e7KLVIkC1FOIrAvMSgiO4n/7+4LXm2vzeYv681JDUEjvVqqsNq2UhGtrAZA9XHJfVhtym0/BaYMmcX9w0frXSduehR29z+Zz/88EtZx6LJDFh1gt+jcJ1ZMOBzIpHW0L/jLiX2yhUwHURBzv5wfvpoBiGKaNen3CTeIpqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ltcMcIpu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ltcMcIpu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 815A4C6220A;
	Mon, 14 Sep 2026 12:16:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62FF960323;
	Mon, 14 Sep 2026 12:15:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A183E11C7AF9D;
	Mon, 14 Sep 2026 14:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789388149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c/j2KSqoeXBO/q3tfC1ALuuQTrGhFj6j1QP0rTOkUU8=;
	b=ltcMcIpu7KTkiliv/Sa0/XOryVq+Iy4OOrpOQXGT2bqQF6+9WInj1c1ZBbTrmJ5ot6lWQm
	Stl2p/qa3c0UzIiZzikOiSv/uzemiocQXjLBEt1EkLLiruLlvqQ+xAHPTeyfy0Kkbh+SBi
	yPgJEoV3KwEtUjjvPKieD5XEoBZ4Gn9GNI1wcgbpIYFeMIDKOM6a1+MGA342Omian1E5s8
	yCWPVI9SpOZ0q0y7DspWzcMTCFSND9Q6X5KNJO8+QhCtIFUvVDm42CtmqCHUYu2+4E8XVa
	2xir+AEUZ4JBCqTSyMywT/x5Lujn6FuOnvy1rJD3quvJ/q78zI0DFjucYACBgg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Itai Handler <itai.handler@gmail.com>
Cc: mwalle@kernel.org,  pratyush@kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  vigneshr@ti.com,  richard@nod.at,
  takahiro.kuwano@infineon.com,  stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: take the flash lock in
 spi_nor_shutdown()
In-Reply-To: <20260914081149.1916589-3-itai.handler@gmail.com> (Itai Handler's
	message of "Mon, 14 Sep 2026 11:11:48 +0300")
References: <20260914081149.1916589-1-itai.handler@gmail.com>
	<20260914081149.1916589-3-itai.handler@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 14 Sep 2026 14:15:46 +0200
Message-ID: <87fqzcowp9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/09/2026 at 11:11:48 +03, Itai Handler <itai.handler@gmail.com> wrote:

> spi_nor_shutdown() calls spi_nor_restore() to put the flash back into
> 3-byte addressing before the system reboots or kexecs. It does so
> without taking nor->lock, which every other path that talks to the chip
> acquires through spi_nor_prep_and_lock().
>
> device_shutdown() does not freeze userspace and does not stop kernel
> threads; it walks the device list calling ->shutdown with all CPUs
> online. Another thread can therefore be in the middle of an operation,
> with the restore running concurrently with it. A write and a read are
> both damaged, in different ways.
>
> A program or erase leaves the flash busy, and a busy flash accepts only
> status register reads and ignores everything else, including the EX4B
> that spi_nor_restore() sends. Neither spi_nor_write_enable() nor
> spi_nor_set_4byte_addr_mode() reads anything back, so the restore
> reports success while the flash is left in 4-byte addressing. The next
> boot stage then addresses it with 3 bytes and reads the wrong data,
> which is the failure commit 59b356ffd0b0 ("mtd: m25p80: restore the
> status of SPI flash when exiting") introduced this restore to prevent.
>
> A read, by contrast, does not ignore the restore - it is corrupted by
> it. spi_nor_read() holds the lock across a loop that issues one
> spi_nor_read_data() per chunk, each using nor->addr_nbytes.
> spi_nor_set_4byte_addr_mode() updates nor->params->addr_nbytes and not
> nor->addr_nbytes, so a restore landing between two chunks switches the
> chip to 3-byte addressing while the driver carries on sending 4 address
> bytes. The rest of the transfer is addressed wrongly and returns wrong
> data, and nothing reports an error. A restore may also soft reset the
> chip in the middle of that same read.
>
> Take nor->lock for the restore, so it runs between operations instead of
> during one: a program or erase has finished waiting on the chip, and a
> read has issued its last chunk. This is a locking fix rather than a
> missing wait - each operation already waits for completion at the site
> that started it.
>
> This narrows the race without closing it. The restore still runs while
> MTD users are attached, so an operation that starts after it has
> completed will address a chip that is now in 3-byte mode while
> nor->addr_nbytes is still 4. Closing that as well would mean having MTD
> stop accepting operations before ->shutdown runs, which is a larger
> change; serialising against the operations already in flight is what
> keeps the restore itself from being issued into a busy chip.

6 paragraphs to tell "Accesses to the flash should be
serialized". Please reduce it.

> Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when e=
xiting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Itai Handler <itai.handler@gmail.com>
> ---
>  drivers/mtd/spi-nor/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8bc117b46e02..647bf8dce719 100644
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

I'm fine with the diff, but please drop this comment.

Thanks,
Miqu=C3=A8l

