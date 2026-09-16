Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA57377541
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571540; cv=none; b=IPCRqawHvMT5H/zf4tgkpPlFLJPTI73mUhHUsct4B+E+28R08lf7bRyR1s+K/vhkqLbigBZDN4RVjCiqkTi8wT3TnSFigxVmOlaEphcMRGN6wgcduX7DtxOx16mjmypaUyJQ/yMs9XNjrmJf6p/I9peHsHnnHZMc5ikmEAVYhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571540; c=relaxed/simple;
	bh=h/4pJke9npT07KHcze9UxFGBbJz+qQoBKGe8nr3KocM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7sFxbv4LRH5xVkuR3VbNf2Z1KnMXWFfukvJEDsEkqPMa0VVogEYk6s98dWEU29chICdDtQoUDP9YR+VBh/1pR7m3OrxHM5hhsr8GFpe/Gra4UD3a9qQ94nXOshRmMmjRz/LFNlu5ghv283Uj5rLF3OgjFRmmmmVMq2IPR9p3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AimCvowf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AimCvowf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D0301A0908;
	Wed, 16 Sep 2026 15:12:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF7E060337;
	Wed, 16 Sep 2026 15:12:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D80FB11C7B02C;
	Wed, 16 Sep 2026 17:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789571534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=quuIl1qQ1CatIDWdv+/finp0pmoVfonu/MDoOFq07A4=;
	b=AimCvowfLlMvokrdjJX5e2YCiM28fEhNcPXWxmeWSB94JsYqVuHiSBLg7yjTCjvfK49btr
	2bCB2l1AbcJoB7Ys8jM47/Uc6VuirvZ6/qmipEHIYv6Eh58gFgDWHIQEHoWPVnWbOWxSTf
	IhF5SRLQQzzWHJMsdmkTqpRLkMpYpIX8FXH1eO4R6tjuFObwH1FBhPdJ0P76SCfQ99Yzom
	RihUsUp6vhI99csxxGsER4VYINT7EB4p3qkVBbQtPJhgDw5+jOUstGsCgK1qmdqLMvRUiX
	fIC+ccDGY4BqzrUWKfIZFsIKs1wxTExrENwQjWP4Q43PyRZlsiAwjy8c6yUtkA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Orgad Shaneh <orgads@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: cfi_cmdset_0002: cap the write-buffer chunk at
 256 bytes on an x8 device
In-Reply-To: <20260915075028.21658-1-orgads@gmail.com> (Orgad Shaneh's message
	of "Tue, 15 Sep 2026 07:50:03 +0000")
References: <20260915071339.15172-1-orgads@gmail.com>
	<20260915075028.21658-1-orgads@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 16 Sep 2026 17:12:11 +0200
Message-ID: <8733v9mdro.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 15/09/2026 at 07:50:03 GMT, Orgad Shaneh <orgads@gmail.com> wrote:

> The word count of the Write to Buffer command is a single bus word per
> device, so an x8 device can be told to program at most 256 bytes
> regardless of the buffer size it advertises.
>
> A Micron M29EW (an x16 part wired in x8 mode) advertises a 512-byte
> write buffer. cfi_amdstd_write_buffers() used the full 512, CMD(511)
> truncated the count to 0xff on the way out, and the chip aborted the
> program on the 257th data byte.

This sentence does not mean anything, I'm sorry.

> Every full-size chunk failed while the

failed? do you have hardware that actually triggered that issue?

> partial ones at the start of a write went through:
>
>   MTD do_write_buffer_wait(): software timeout, address:0x03278bff.
>   jffs2: Write of 4164 bytes at 0x02c789b4 failed. returned -5, retlen 68
>   jffs2: No space for garbage collection. Aborting GC thread
>
> Clamp MaxBufWriteSize in the write-buffer fixup for x8 devices, and keep
> mtd->writebufsize (computed before the fixups run) consistent with it.
>
> The bug predates the git history, so there is no Fixes: tag.

That's incorrect. It indicates until when we need to backport it. So if
it's the first Git commit, it's the first Git commit.

> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>
> v2: test the device width (cfi->device_type) instead of the aggregate bus
>     width. map_bankwidth_is_1() is false for x8 devices interleaved on a
>     wider bus, which have the same 256-byte ceiling: do_write_buffer()
>     sends CMD(words - 1), and CMD() replicates that count into each
>     device's lane, where it is truncated to 8 bits - so two x8 chips with
>     a 512-byte buffer are told 255 words and are still sent 512 bytes
>     each. device_type is also immune to map_bankwidth_is_1() compiling to
>     a constant 0 when CONFIG_MTD_MAP_BANK_WIDTH_1 is off. Caught by the
>     Sashiko review bot.
>
> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_=
cmdset_0002.c
> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> @@ -283,6 +283,21 @@ static void fixup_use_write_buffers(struct mtd_info =
*mtd)
>  		pr_debug("Using buffer write method\n");
>  		mtd->_write =3D cfi_amdstd_write_buffers;
>  	}
> +
> +	/*
> +	 * The word count of the Write to Buffer command is a single bus
> +	 * word per device, so an x8 device can be told to program at most
> +	 * 256 bytes however large a buffer it advertises - including when
> +	 * several of them are interleaved on a wider bus, where CMD()
> +	 * replicates the count into each device's lane and it is truncated
> +	 * there.
> +	 */
> +	if (cfi->device_type =3D=3D CFI_DEVICETYPE_X8 &&
> +	    cfi->cfiq->MaxBufWriteSize > 8) {
> +		cfi->cfiq->MaxBufWriteSize =3D 8;
> +		mtd->writebufsize =3D cfi_interleave(cfi) <<
> +				    cfi->cfiq->MaxBufWriteSize;

Ideally, I'd like feedback from Vignesh on this.

Thanks,
Miqu=C3=A8l
