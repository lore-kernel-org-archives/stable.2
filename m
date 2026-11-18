Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008828;
	b=BpsIy3vB6PvVrGmq1S0RbkEXruFeTd5AiYFaYuY7DVbQEkQDx5ZSl9j0htrR4Ry3CUbl
	 2hGtCJoME1E0zoYtbNddC/vEwzQSIvZKhXJCHyNCnoNPr++fOG+xOlj0HzsfvzLKUIF9R
	 zAVbp+jU9DCstj1C8ZkXS3EdbztV+cg+gdJloTvQ02eEM92Fj5EV877mgCP8ZUKVySa9j
	 UVotR3ZvR5d/CY9ajOBA8ZECrSJ7GPOFlZcJpAVSViP/aw1/FlxoHsWgzk2MUY1UrL71F
	 y4xQ+gtDbjV3hGjptkPnqEM9GrzHxW7PjGzF9yubrCDt2NN/QgiQNcumt4eV42dhbXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008828;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=XV7sbxNgaRZfJYvF96xgpKxkblconb2brXYMaR7KHAQ=;
	b=nn0545lYu2y3GMYnAufIReAYy7/CFHDesZaJxwk+Uyp6Tj464wBCiutJ642ejmsPeqAy
	 kr2wJe/Ro/J4UCaoJGfllnNB+78PxXDl1dpXJnWb8qEGV3eE/cfg6+EJCvU58kBHxfznk
	 Q9JBSb9gYbdnY24T+rzs7XWCjKYozB58VWtaqIcOFbzCyGdX5AnDJT+2HcIWHQVlWMplW
	 NCKRh14qZuIwYpOgtI+ETQ21elMVLqaXvXATwHh/e7Z8IHXiJVEnz5Tij7vxP7im/UhVf
	 SVP9u8kMlfIQIRpa8o7sW6v3YuMYcupe1scF5LXoC6oa5pd65CvqthTV2mLqdOxQQGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpWafA0R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4B7F4606A333;
	Wed, 18 Nov 2026 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpWafA0R
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 67B0B1F000C4;
	Wed, 18 Nov 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795008827;
	bh=XV7sbxNgaRZfJYvF96xgpKxkblconb2brXYMaR7KHAQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=LpWafA0RwY/n/9v45H1EHR4XucbTQoWJQ3NJbtGitL2gASLcRRiYUZF08XL9eO2Kp
	 ltJ2gH4tg81TDp1WYRzC9GhfYjda2M5HfEhocfrdXsO2w3H/nekhPABrOL5ISOBCmh
	 AAxmhTI/UcnTsZlExtIpJROqieAd0S+mmtOJm2s+w1+dFUs8j9V/oRNifUrVH5uBdI
	 B3WvHGVujbwNvzyUKL4yyTCE+opEkTC58JXaOzAPhlplaHOXwi7yiSrkCQG14ZJaR4
	 SCVvibrhJ3ekLr6Bc70Twi0TyKmfP0zm1ukVWOJe/7XA7+XKMmRXlZIHVWTc3v3+Oa
	 M8xYFpDpUifRQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=65b67eaa2390905bd19cb271d8b7bafb464b182aa8cf20a1b34dc82aee08;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 18 Nov 2026 14:33:44 +0100
Message-Id: <DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org>
Subject: Re: [PATCH v5] mtd: spi-nor: take the flash lock around
 spi_nor_restore()
Cc: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <takahiro.kuwano@infineon.com>, <tudor.ambarus@linaro.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Itai Handler" <itai.handler@gmail.com>, <pratyush@kernel.org>
X-Mailer: aerc 0.20.0
References: <20261029210153.3986211-1-itai.handler@gmail.com>
In-Reply-To: <20261029210153.3986211-1-itai.handler@gmail.com>

--65b67eaa2390905bd19cb271d8b7bafb464b182aa8cf20a1b34dc82aee08
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 29, 2026 at 10:01 PM CET, Itai Handler wrote:
> spi_nor_restore() runs on reboot, kexec and unbind to hand the flash
> over in its power-on state. It runs without nor->lock while the MTD
> device is still registered. Tasks are not frozen on reboot or kexec,
> and kexec -e does not even stop user space, so the restore can run in
> the middle of a program or erase. This causes two problems:
>
> 1. The flash can be left in the wrong state. On boards that do not
>    reset the flash (broken-flash-reset), the restore exits 4-byte
>    address mode, but a busy flash typically ignores the command, so
>    the flash stays in 4-byte mode after the reboot or kexec. After a
>    reboot, a boot ROM that reads the flash in the power-on 3-byte mode
>    gets the wrong data, and the board fails to boot. For example, the
>    GnuBee PC1 (MT7621) has a Winbond W25Q256FV, which ignores the exit
>    command while busy, and the board needs the restore to reboot, see
>    commit 90dedc973b86 ("staging: mt7621-dts: allow gnubee to reboot
>    cleanly."). A busy flash also ignores READ ID, so if it is still
>    busy when the secondary kernel probes it after a kexec, the probe
>    fails ("unrecognized JEDEC id bytes"), and that kernel cannot use
>    the flash.
>
> 2. Data can be corrupted. The restore also soft resets flashes that
>    support it, which can abort a program or erase. For example, the
>    Micron MT25QU512ABB8ESF-0SIT QSPI NOR flash advertises the soft
>    reset in its SFDP, and its data sheet says that a reset aborts a
>    program or erase in progress and may corrupt data. If an application
>    is writing data to the device when the system kexecs into a secondary
>    kernel, or restarts, a sector can be left partly erased or programmed.
>
> Take the lock, so that the restore waits for the operation in flight.
> That alone is not enough: the next operation would then start right
> after the restore, and could still be running at the kexec or be cut
> short by the reboot. And after an exit from 4-byte mode, it would still
> use 4-byte addresses, so a page program would write to the wrong place.
> So mark the flash shut down before releasing the lock, and fail later
> operations with -ESHUTDOWN. The CFI drivers also refuse operations once
> they have reset the flash for a reboot (see cfi_intelext_reset()). If
> the SPI controller removes itself on shutdown, spi_nor_remove() runs
> after spi_nor_shutdown(), finds the flash shut down, and does not
> restore it a second time.
>
> The wait is usually short, as applications and flash file systems
> typically submit small requests, such as a single sector erase. It can
> be long, though: spi_nor_erase() holds the lock for the whole request,
> so shutdown or unbind may wait for a full chip erase, which can take
> minutes. If the lock cannot be taken, warn and restore without it, as
> before.
>
> Backport note: before v6.4, the lock helper is spi_nor_lock_and_prep(),
> and it has no _pe and _rd variants. From v6.4 on, apply this on top of
> commit f594a33f9721 ("mtd: spi-nor: Unprepare legacy controllers upon
> RWW wait interruption"), which is also tagged for stable.
>
> Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when e=
xiting")
> Cc: stable@vger.kernel.org # see patch description, needs adjustments for=
 <=3D 6.3
> Assisted-by: LLM
> Signed-off-by: Itai Handler <itai.handler@gmail.com>
> ---
> Changes in v5:
> - Fail operations after the restore with -ESHUTDOWN, so that none can
>   reach the flash between the restore and the reboot or kexec.
> - Warn and restore anyway when the lock cannot be taken, instead of
>   skipping the restore, as I offered in my reply on v3 [1].
> - Use a helper around spi_nor_restore() again, as in v3, and the v3
>   subject.
> - Say that the wait can last for a full chip erase; v4 understated it.
> - Drop the long code comment, and rewrite the commit message, with
>   examples and a backport note.
> - Use the v3 form of Assisted-by.
> - Rebase on mainline.
>
> Why the lock is not just kept after the restore, which would also stop
> later operations: it hangs the reboot or kexec on boards whose SPI
> controller removes itself on shutdown (spi-fsl-dspi, spi-bcm2835,
> spi-ath79). spi_nor_remove() then runs after spi_nor_shutdown(), in the
> same task, and waits for the lock that spi_nor_shutdown() kept. With
> this patch, spi_nor_remove() gets the lock and skips the restore.
>
> Testing:
> - Built with W=3D1 for arm64, on mainline and, cherry-picked on top of
>   f594a33f9721, on 6.6, 6.12, 6.18, 7.2 and 7.3. The backports to 5.10,
>   5.15 and 6.1 build cleanly too; I will send them when the stable team
>   asks.
> - In QEMU (v7.3, ZynqMP GQSPI, n25q512a11 with broken-flash-reset, and
>   the flash model patched to stay busy during an erase), with an
>   application erasing and programming the flash during a kexec:
>   - Without this patch, the flash ignores WREN, EX4B and WRDI, and stays
>     in 4-byte mode.
>   - With a draft that released the lock after the restore, the next
>     erase went out with a 4-byte address. With a 10 s erase, it was
>     still running when the secondary kernel probed the flash, and the
>     probe failed.
>   - With this patch, the flash obeys EX4B, nothing reaches it after the
>     restore, and the secondary kernel finds the flash, with both a 3 s
>     and a 10 s erase.
> - With the GQSPI driver changed to remove itself on shutdown, as
>   spi-fsl-dspi does, a kexec with a draft that kept the lock hung, as
>   spi_nor_remove() waited for it. With this patch, it completes, and the
>   flash is restored once.
>
> v4: https://lore.kernel.org/r/20261004104311.2196527-1-itai.handler@gmail=
.com
> v3: https://lore.kernel.org/r/20260915113811.2429311-1-itai.handler@gmail=
.com
> [1] https://lore.kernel.org/r/CAFpOueRGN2TSNo+m3319qn00p-BYn8w7OQ6OPt4XTc=
VG63-uUA@mail.gmail.com
>
>  drivers/mtd/spi-nor/core.c  | 43 +++++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spi-nor.h |  2 ++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 90524c58602e..3109f89b35f3 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1230,6 +1230,11 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
>  		ret =3D wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_exclusive(nor));
> =20
> +	if (!ret && nor->shutdown) {
> +		spi_nor_unlock_and_unprep(nor);
> +		return -ESHUTDOWN;

This will be propagated to userspace, correct? Not sure this is a
valid error code outside of sockets. Maybe EIO?

> +	}
> +
>  	if (ret)
>  		spi_nor_unprep(nor);
> =20
> @@ -1290,6 +1295,8 @@ static void spi_nor_rww_end_pe(struct spi_nor *nor,=
 loff_t start, size_t len)
>  	rww->ongoing_pe =3D false;
>  }
> =20
> +static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t sta=
rt, size_t len);
> +

Please avoid forward declarations and move the functions.

>  static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, s=
ize_t len)
>  {
>  	int ret;
> @@ -1304,6 +1311,11 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor=
 *nor, loff_t start, size_t le
>  		ret =3D wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_pe(nor, start, len));
> =20
> +	if (!ret && nor->shutdown) {
> +		spi_nor_unlock_and_unprep_pe(nor, start, len);
> +		return -ESHUTDOWN;
> +	}
> +
>  	if (ret)
>  		spi_nor_unprep(nor);
> =20
> @@ -1366,6 +1378,8 @@ static void spi_nor_rww_end_rd(struct spi_nor *nor,=
 loff_t start, size_t len)
>  	rww->ongoing_rd =3D false;
>  }
> =20
> +static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t sta=
rt, size_t len);
> +
>  static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, s=
ize_t len)
>  {
>  	int ret;
> @@ -1380,6 +1394,11 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor=
 *nor, loff_t start, size_t le
>  		ret =3D wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_rd(nor, start, len));
> =20
> +	if (!ret && nor->shutdown) {
> +		spi_nor_unlock_and_unprep_rd(nor, start, len);
> +		return -ESHUTDOWN;
> +	}
> +
>  	if (ret)
>  		spi_nor_unprep(nor);
> =20
> @@ -3250,6 +3269,26 @@ static void spi_nor_restore(struct spi_nor *nor)
>  		spi_nor_soft_reset(nor);
>  }
> =20
> +static void spi_nor_lock_and_restore(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	ret =3D spi_nor_prep_and_lock(nor);
> +	if (ret =3D=3D -ESHUTDOWN)

This is actually really hard to follow. It's tested for even before
it is set down below. Also probably wont work with an EIO return
code. See more below

> +		return;
> +	if (ret)
> +		dev_warn(nor->dev,
> +			 "Failed to lock flash, restoring its power-on state anyway, err =3D =
%d\n",
> +			 ret);
> +
> +	spi_nor_restore(nor);
> +
> +	if (!ret) {
> +		nor->shutdown =3D true;

Why don't you set the flag unconditionally?

> +		spi_nor_unlock_and_unprep(nor);
> +	}
> +}
> +
>  static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
>  						   const char *name)
>  {
> @@ -3632,7 +3671,7 @@ static int spi_nor_remove(struct spi_mem *spimem)
>  {
>  	struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> =20
> -	spi_nor_restore(nor);
> +	spi_nor_lock_and_restore(nor);

So why don't you just keep spi_nor_restore() and just add the
locking there?

What about the following:

static void spi_nor_restore(struct spi_nor *nor)
{
	struct spi_nor_flash_parameter *params =3D nor->params;
	int lock_ret, ret;

	lock_ret =3D spi_nor_prep_and_lock(nor);
	/* already restored, e.g. remove() after shutdown(). */
	if (nor->restored)
		return;
	if (lock_ret)
		dev_warn(nor->dev, "...", lock_ret);

	/* former body .. */

	/* refuse any further operations */
	nor->restored =3D true;

	if (!lock_ret) {
		spi_nor_unlock_and_unprep(nor);
	}
}

> =20
>  	/* Clean up MTD stuff. */
>  	return mtd_device_unregister(&nor->mtd);
> @@ -3642,7 +3681,7 @@ static void spi_nor_shutdown(struct spi_mem *spimem=
)
>  {
>  	struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> =20
> -	spi_nor_restore(nor);
> +	spi_nor_lock_and_restore(nor);
>  }
> =20
>  /*
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b3e3c6b10186..6f5d2e5c2118 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -361,6 +361,7 @@ struct spi_nor_flash_parameter;
>   * @read_opcode:	the read opcode
>   * @read_dummy:		the dummy needed by the read operation
>   * @program_opcode:	the program opcode
> + * @shutdown:		the flash was restored, refuse further operations

shutdown only covers some of its meaning, it might also just get
unbinded etc. So what about 'restored'?

-michael

>   * @sst_write_second:	used by the SST write operation
>   * @read_proto:		the SPI protocol for read operations
>   * @write_proto:	the SPI protocol for write operations
> @@ -402,6 +403,7 @@ struct spi_nor {
>  	enum spi_nor_protocol	read_proto;
>  	enum spi_nor_protocol	write_proto;
>  	enum spi_nor_protocol	reg_proto;
> +	bool			shutdown;
>  	bool			sst_write_second;
>  	struct sfdp		*sfdp;
>  	struct dentry		*debugfs_root;
>
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8


--65b67eaa2390905bd19cb271d8b7bafb464b182aa8cf20a1b34dc82aee08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCav2pOBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iSKAF8CjZ0K4y3yJPfFmLZVIV6ajtPbzWce0hR
/ZmGWAHOvBPHE4XfE0TJQPFWmIoaGgqzAX9liK5bTl4ufe3m3vAN1eRNAZrHxvm5
iLWUpX4RLO2ARPVq0AS0XAv4rvsyQVJCoVk=
=TEHg
-----END PGP SIGNATURE-----

--65b67eaa2390905bd19cb271d8b7bafb464b182aa8cf20a1b34dc82aee08--
