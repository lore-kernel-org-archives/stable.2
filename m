Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571C41A504;
	Tue, 15 Sep 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473128; cv=none; b=j5spMxV3nXOn+oyk7IfRpqGumzb8S5EY1gsHTCc4YoBYLyw/7sfQUGZ73ORlRYXQYmZ6pF+fHGfIVsPvZsi0XmvvGd0vNsQtJLI5Qd69SIzizWnlCKIp4c5yuJiTlxYymMSqNE2sjtqss9nBCjIlxpZzqK+sLOBwKkwgz4IDNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473128; c=relaxed/simple;
	bh=xYV/wPCpIvfx2FoorpIIu84nztuuW+0aduAUUjXtr5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwV71HdvnYJRSxJX/pxhjJdcqFB2TtXVnNsU75ihs2z353ZRF8Z7EiYfbJfV4Ly18EOWWoWDIdcXvSt3TpzLbRxYH2bFA2U29y/HuNOc0ygp50p7k/rocS1TGEsFGBBDYai7m8xGZi5H+lQcpC8nJ2SD2DLh7V6awENHZxv0Ke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKs/ruNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKs/ruNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEE41F000FF;
	Tue, 15 Sep 2026 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473127;
	bh=minwQhNSeXpWaT0uHf4QAacB8I8tdz+K6aY9uTKMnis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKs/ruNIjPp8RAB0L1pOI7H22Y8Yiif1iOXio4sxHFjBOsd7iJXA9OfVe0qNrPBeJ
	 OA9RerOC7J4qNa4U0ZjuDpsiiEbI7qrnvYykxb4tg75ZUbUe+TLGug9LYhaMwholnH
	 BLQfuJNmYhzUe1fQVl2ccCWjYc8zeFMI8JOv6suA5P1TsqNz2iC5BAu0wTtTnhuogs
	 Q3o4P47RD0fDdyTAF/zlu5SjTWO+EpgqXFlHy2b9T9gjft9BU5690299V/3BfQq54o
	 sUzX29eE0BwM1xcuuiEyg6b7RwIAtpHlyPysNIvchn6N60lI8qbXAXfxcqf2/LKfZU
	 GcjOC3AG+V4zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: take the flash lock around
 spi_nor_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Itai Handler" <itai.handler@gmail.com>, mwalle@kernel.org, pratyush@kernel.org
Cc: linux-kernel@vger.kernel.org, vigneshr@ti.com, linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com, richard@nod.at, stable@vger.kernel.org, miquel.raynal@bootlin.com
In-Reply-To: <20260915113811.2429311-1-itai.handler@gmail.com>
References: <20260915113811.2429311-1-itai.handler@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:52:06 +0000
Message-Id: <20260915115206.CCEE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mtd: spi-nor: skipped flash restore on fatal signal breaks boot
- [High] mtd: spi-nor: shutdown hang due to ongoing erase operation
--

commit c0578fac7581b63c39bfd99ac3a6f934256685d3
Author: Itai Handler <itai.handler@gmail.com>

mtd: spi-nor: take the flash lock around spi_nor_restore()

This commit changes spi_nor_shutdown() and spi_nor_remove() to acquire
nor->lock around spi_nor_restore(). It aims to prevent operations like
reads from overlapping with the restore, which could leave the chip in
3-byte addressing mode.

> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd04..c891197ffa5b3 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3849,11 +3849,26 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  				   data ? data->nr_parts : 0);
>  }
> =20
> +/*
> + * Restore between operations, not during one. Removal and shutdown both=
 run
> + * with MTD users still attached: a busy flash silently ignores the comm=
ands
> + * spi_nor_restore() sends, and a restore landing inside a read changes =
the
> + * chip's address width under the transfer.
> + */
> +static void spi_nor_restore_locked(struct spi_nor *nor)
> +{
> +	if (spi_nor_prep_and_lock(nor))
> +		return;

[Severity: High]
Does this code silently skip the flash restore if a fatal signal breaks the
lock acquisition?=20

For example, if a privileged user runs rmmod while an erase or read operati=
on
is actively holding the RWW lock, and the rmmod process receives SIGKILL,
spi_nor_prep_and_lock() (via wait_event_killable()) will return -ERESTARTSY=
S:

drivers/mtd/spi-nor/core.c:spi_nor_prep_and_lock() {
    ...
    if (!spi_nor_use_parallel_locking(nor))
        mutex_lock(&nor->lock);
    else
        ret =3D wait_event_killable(nor->rww.wait,
                                  spi_nor_rww_start_exclusive(nor));

    return ret;
}

Bypassing the hardware teardown path here leaves the flash in 4-byte addres=
sing
mode. This might cause the bootloader to fail to read the kernel on the next
reboot, soft-bricking the device until a power cycle.

> +
> +	spi_nor_restore(nor);
> +	spi_nor_unlock_and_unprep(nor);
> +}
> +

[ ... ]

> @@ -3863,7 +3878,7 @@ static void spi_nor_shutdown(struct spi_mem *spimem)
>  {
>  	struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> =20
> -	spi_nor_restore(nor);
> +	spi_nor_restore_locked(nor);

[Severity: High]
Could this hang the system indefinitely during shutdown if an erase operati=
on
is ongoing?

Erase operations (like spi_nor_erase_multi_sectors) hold nor->lock
continuously for their entire duration, looping over spi_nor_wait_till_read=
y()
with cond_resched(). A large chip erase can take several minutes.

Because device_shutdown() iterates devices synchronously without a timeout,
this synchronous wait for nor->lock could hang the reboot process until the
erase finishes, forcing the user to hard-reset the machine.

>  }
> =20
>  /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915113811.2429=
311-1-itai.handler@gmail.com?part=3D1
