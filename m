Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216783F7AB2
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290906; cv=none; b=Ajdj61KmqH6Et9vuBEEBiQWgMD87jn4R5H1Ga0FsZN64I0I1s+1oJo/vjYU7+4f6mv9TWg8Iaezaw7jR4XKIUseKoqRo7qbIdQ029MuMt+j5OqMilLFPNppgCnTYjpL1aCMw1fdEopv8bfNdzCQFvViXfGkfUD13gGQMJF8Q9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290906; c=relaxed/simple;
	bh=7CZqx4Otfur/VG9ZildeM2Vdazq6H7GOJhrqLMzNNo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPBgLOz7XCreHfaYuSSaWdcKQd9meoOuR32AY2JRDZpxBHjAAz427XMxwhVfWAPROEaYEYapkWq9z69HbWUoqDqyEVp3x53Nk/qd7KVLU79U1A5ZZ2CWwqPc5rIoN+JSR53chqgKFdcbmhedv2iFVKN6Hqjg9swbnu+kk1QWY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dBMXY+F8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dBMXY+F8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 728211A1038;
	Fri, 17 Jul 2026 12:21:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E24960361;
	Fri, 17 Jul 2026 12:21:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A41F611BD0C29;
	Fri, 17 Jul 2026 14:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784290901; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XPHS+G2PK3HSSLicq3iMEc5QRy9j7GIGDRoyVEfXr+E=;
	b=dBMXY+F8CCxhqFSV2pc3cGPj3sIiqQ8eAAjFGGXzWubu7wTFvMtjRG/j65pWaRiAKu+o/l
	eFlhHDwkjydZqKeCqd5HRJlykii7zTzOU9gizijYDxCn4rsNKZKCTIK9AQzBwP/aX3WjL7
	torGWviK40d82yFqlF+Xf8nstGXLbsVZQCxbK8p+YIYCJOn52pCzkVZlxjiyckg7K8UIHG
	6u8EyH1/CHT1iGYgNYymtozQy+lWJ6pHZLf0yaTT5YEzqWGZkJvWW6egisGnFrWtok9qxz
	cUC8ZSP1vBOe3nMPC+WdEKc57hRz1iarw6RMWgJ67BVVLgZk8kChHtZlgqLfFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: vigneshr@ti.com,  richard@nod.at,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Huang Shijie <b32955@freescale.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: validate ONFI extended parameter page
 sections
In-Reply-To: <20260715084226.38336-1-pengpeng@iscas.ac.cn> (Pengpeng Hou's
	message of "Wed, 15 Jul 2026 16:42:26 +0800")
References: <20260715084226.38336-1-pengpeng@iscas.ac.cn>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Jul 2026 14:21:36 +0200
Message-ID: <871pd1kdrj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Pengpeng,

On 15/07/2026 at 16:42:26 +08, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> nand_flash_detect_ext_param_page() allocates a length declared by the ONFI
> parameter page.  It treats the returned data as a fixed header followed by
> variable-length sections.  It reads that header and advances over sections
> without first proving that the page and each current section fit in the
> allocated buffer.
>
> Reject pages shorter than the fixed header.  Track remaining bytes while
> walking sections.  Require the ECC section to cover every field read from
> struct onfi_ext_ecc_info.
>
> Fixes: 6dcbe0cdd83f ("mtd: get the ECC info from the Extended Parameter P=
age")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/mtd/nand/raw/nand_onfi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand=
_onfi.c
> index cd3ad373883e..40b7db10bd73 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -40,11 +40,16 @@ static int nand_flash_detect_ext_param_page(struct na=
nd_chip *chip,
>  	struct onfi_ext_section *s;
>  	struct onfi_ext_ecc_info *ecc;
>  	uint8_t *cursor;
> +	size_t section_len;
> +	size_t remaining;
>  	int ret;
>  	int len;
>  	int i;
>=20=20
>  	len =3D le16_to_cpu(p->ext_param_page_length) * 16;
> +	if (len < sizeof(*ep))
> +		return -EINVAL;
> +
>  	ep =3D kmalloc(len, GFP_KERNEL);
>  	if (!ep)
>  		return -ENOMEM;
> @@ -77,11 +82,24 @@ static int nand_flash_detect_ext_param_page(struct na=
nd_chip *chip,
>=20=20
>  	/* find the ECC section. */
>  	cursor =3D (uint8_t *)(ep + 1);
> +	remaining =3D len - sizeof(*ep);
>  	for (i =3D 0; i < ONFI_EXT_SECTION_MAX; i++) {
>  		s =3D ep->sections + i;
> -		if (s->type =3D=3D ONFI_SECTION_TYPE_2)
> +		section_len =3D s->length * 16;
> +		if (section_len > remaining) {
> +			pr_debug("The section is invalid.\n");

This debug message is not useful, it could mention the section, and at
least contain "ONFI" in it. But since you have access to a nand_chip, it
is also probably better to use dev_dbg here.

> +			goto ext_out;
> +		}
> +
> +		if (s->type =3D=3D ONFI_SECTION_TYPE_2) {
> +			if (section_len < sizeof(*ecc)) {
> +				pr_debug("The ECC section is
> invalid.\n");

Same.

> +				goto ext_out;
> +			}
>  			break;
> -		cursor +=3D s->length * 16;
> +		}

\n

> +		cursor +=3D section_len;
> +		remaining -=3D section_len;
>  	}
>  	if (i =3D=3D ONFI_EXT_SECTION_MAX) {
>  		pr_debug("We can not find the ECC section.\n");

Chances are this will never happen, because it is hardware hard to
tamper with, covered by an initial CRC, and if the manufacturers mess up
so badly their tables the chips won't be manufactured anyway.

But, heh, the cost of this is tolerable. Nevertheless, a v2 is expected.

Thanks,
Miqu=C3=A8l
