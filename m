Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455743DDB13
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651561; cv=none; b=iQqPTZsYPinldL62pQ4CiCkdTx54T03LykLSUzXm5JlEuLk+hCmPXVLrhlCiTkT2MwhpVY4HsEhdODhQe9vYQO9PtEOBOWsgCDGGGzDptLCrz25bJRuzDSEKOkoMbOmj4MPGwcYLoNITKrTcKOzwus9n6nnyR5NAhqDAHi8WS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651561; c=relaxed/simple;
	bh=qAfIO28YCM1SmDmdE3IhwfvU1TDo5r74vGdtxfX7ZvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbDnbjqoLV3bzi5QXqaz7qnqNlZujWwWB5M3Tz6lRvWiSvOMR8O1ENzwfrREKNfddX5R7+sLm1wxJMhTfFBYLN7Yi10FKKRjlS1Wn6KXK0YSjW2oy6lR+7NFdOoFI4Vq0N7Zx4yPeehULZuVCDlbYbC6LzpTtj24y+LgtQlUaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VY2F8g/i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VY2F8g/i"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3BBB31A17E3;
	Tue, 25 Aug 2026 09:52:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D410604C4;
	Tue, 25 Aug 2026 09:52:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 327B911C7A36B;
	Tue, 25 Aug 2026 11:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787651551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qAfIO28YCM1SmDmdE3IhwfvU1TDo5r74vGdtxfX7ZvI=;
	b=VY2F8g/iGVVqY7vf62k9QFFt5YfoEFmi/UUHQ0rdsl7993acOS0EVcvv2rKp+amOO2Hant
	Aa9Jbdsrw4XgqrC2p008HyzM/xp+Nrf66Eixq2emwwRSNxYJqycu5PCngm5/1hXnjFXLpI
	mkf9wtMN4Jjd2Nsba3W7g3QZo74Tb2PirZav0IIp0irWpmorQXPk76jz/N6FHvXO825hdd
	a8T4g5thq938EzOn0NpiNnwqnU3WLwRxWW7ctS4KOBhYjleyWTwxh9NwW1vjZf6qd7rKdQ
	GAe7ELolGFW9Ov0RvWTbZdGY+b+tDT1EUkzTj6sE3R3EbTtSC2LkX4FS0I+P9Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Mehmet Fide
 <mehmet.fide@screeningeagle.com>,  Boris Brezillon
 <bbrezillon@kernel.org>,  Frieder Schrempf <frieder.schrempf@kontron.de>,
  Edward Karpicz <webmaster@toradex.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: rawnand: vf610_nfc: fix reads on chips with
 more than 64 bytes of OOB
In-Reply-To: <20260818114208.2780311-2-mehmet.fide@gmail.com> (Mehmet Fide's
	message of "Tue, 18 Aug 2026 13:42:07 +0200")
References: <20260818114208.2780311-1-mehmet.fide@gmail.com>
	<20260818114208.2780311-2-mehmet.fide@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 11:52:27 +0200
Message-ID: <87mruail2c.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mehmet,

On 18/08/2026 at 13:42:07 +02, Mehmet Fide <mehmet.fide@gmail.com> wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> The driver only implements the 64-byte OOB layout, so attach_chip()
> shrinks mtd->oobsize when the chip provides more.=20

Ehr...

> That clamp does not
> survive: nand_scan_tail() runs nanddev_init() after ->attach_chip(), and
> it restores mtd->oobsize from the memory organization, which still holds
> the value detected from the chip.

I guess that's expected.

> The driver therefore transfers writesize + the chip's full OOB size, so
> the hardware ECC parity ends up at a different offset than the layout the
> controller was set up for, and every ECC-protected read fails with
> -EBADMSG.

This is clearly the correct=E2=84=A2 way :)

> Measured on a Colibri VF61 (MX30LF4G28AC, 2048-byte pages, 112 bytes of
> OOB): with the clamp lost, UBI cannot read the erase counter headers of
> the pages U-Boot has just written, and the on-flash bad block table
> written by an older kernel reads back with ECC errors, so the board does
> not boot. Kernels before commit a7ab085d7c16 ("mtd: rawnand: Initialize
> the nand_device object") are not affected because nothing overwrote the
> clamp there, which is why the same chip works with a v4.4 kernel and
> with U-Boot, whose copy of this driver has no memory organization to
> restore the value from. Edward Karpicz reported that the clamp no longer
> takes effect on this chip; see the link below.

This commit is not incorrect, what the driver does is incorrect, and
is now unfortunately visible.

> Clamp the memory organization as well so the driver's 64-byte layout
> stays in effect, and log the truncation once, as it decides which
> on-flash layout the system uses.

It fixes the problem, but honestly modifying the memorg is not
correct. Broadcom and mpc5121 controller drivers do it, but that's
likely wrong.

What you report here is a U-Boot issue. The chips has more than 64 OOB
bytes, U-boot clamps that value, Linux does not. U-boot is wrong. But I
guess it's now too late and you'll tell me many devices in the field
already use this broken layout?

In this case, maybe you should just change the layout, instead of
forcing an obviously incorrect memory layout. In this driver the large
page generic OOB layout (which puts the ECC bytes at the end) is used. I
guess a better approach could be to make your own 64-byte clamped OOB
layout for backward compatibility. You should drop the oobsize
modification as well.

> Reported-by: Edward Karpicz <webmaster@toradex.com>
> Link: https://community.toradex.com/t/colibri-vf50-vf61-on-the-current-bs=
p-mainline-u-boot-v2026-07-and-linux-6-18-lts/30735
> Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

There is at least one legitimate Sashiko warning on this patch, can you
please also check it?

Thanks!
Miqu=C3=A8l
