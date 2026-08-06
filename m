Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9A3EAC61
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025135; cv=none; b=Hh/EUQy224W5vlhcQ31M0GzOvwTFzNPpEIo9i2TcIurCxvzPaYw9dTaDBj5fe4X590mE8zsJwdal0b3K71vV3KfUHhu61TNa4ZDXrO7gngF4vXeNCzrynZf/orjemxGdzS/VMm8GRk7fL3aPkTOe9Fj9B/EfOXhXu9EsDrn/I6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025135; c=relaxed/simple;
	bh=lSgP0UGzBQHa9Rl+uSN5kmGOX9y1uiZ/mbFBiQKwALk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrGRJX61tjO8Bpdg5cV5FQmPzb7cdtSs4PmJupIHO89QdmXwCCbmVBDGEthF9K+WQKzufpWng99PigDig3RuZFKfezQt5trO3h8XmWgfX/BX84SZ2zudZxUsLEkR4cjKr20+8f+qrSyltOna5xUd/egwCVlfctKbZHyw2lG3AHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuwO2TPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuwO2TPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00D1F00A3E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025126;
	bh=eZq3ulrLZdSDUMbHHMPbThDdfAeQLBt2+TRPSLNiUzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KuwO2TPAvYSD6K/y0kngMsOa1MVNafxDcLFqBlrA5sFr/d5eIUlgUwayVNtFnoKJd
	 mwGop1Da6o6+jFu/pWBXeP7pQyEgJcVWQpkMlebWeuao8TZMLXWbSxmcLgiEELyKW5
	 HCErYOB+q5/I8K/WESEEUebuv/Aohxfg1k7k6PmsBL88Cg2uChcb4mg2twQJaDkQyl
	 wRmOhryzYOEwaQlQHl2xm1aTZQQBXyGS2+pDtv37jXDRzxoVYhUVbLHNd6pCnAxUYb
	 K+iflGQyUj0h+P1yRw3HY1Atszjca8UYy4RyAj7n+0TI07/Xg5C4/ae0CMCDtYII20
	 Tq4oKTKHolpvg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2a3166398so2179138e87.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWqinz3szUtnYfU4cFUrXg4ur8lYRlTTKY0Ub2U63dxu5FGGX6kiHT039EQjfLWbI9mG2Nuyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/ERNslNjU0+3Xc/fs4r0K/sevmkghh3FglTgU1svq1qJmWuX
	0laLRItwa5TAosA4xjZfJqGlZpVB6+Obzgl2mXufC0doisyvzEXbu+R/JvtJhR4/riK72UbagtD
	+3eJKtT5sQgZ3vGE+6qRdszugOK9Okmc=
X-Received: by 2002:a05:6512:2243:b0:5ae:b5ec:62de with SMTP id
 2adb3069b0e04-5b303b383bcmr345000e87.11.1786025124858; Thu, 06 Aug 2026
 07:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com>
In-Reply-To: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 16:05:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juEQMUPmGyo4R6LGK01fTR4DHz3YrSH+7YFFFogiudhQ@mail.gmail.com>
X-Gm-Features: AUfX_mwz0cY0tGrkn94c273ROxdxYZQuad7wtn53Mzh1tJTuq9dHdGs-Lz2n1ns
Message-ID: <CAJZ5v0juEQMUPmGyo4R6LGK01fTR4DHz3YrSH+7YFFFogiudhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: fix stack buffer overflow in query_capability()
To: Anirudh Prasad <icarus@a0rg.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rafaeljwysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:41=E2=80=AFPM Anirudh Prasad <icarus@a0rg.com> wro=
te:
>
> query_capability() copies four ACPI buffer objects returned by the
> firmware _DSM into fixed-size u8[16] fields in struct
> pfru_update_cap_info using memcpy with the firmware-supplied length:
>
>   memcpy(&cap_hdr->code_type,
>          elements[CAP_CODE_TYPE_IDX].buffer.pointer,
>          elements[CAP_CODE_TYPE_IDX].buffer.length);
>
> The same pattern repeats for drv_type, platform_id, and oem_id.
> If the firmware returns buffer.length > 16 for any of these fields,
> memcpy writes past the destination array.
>
> struct pfru_update_cap_info is stack-allocated in pfru_ioctl().
> Confirmed with KASAN on 7.2-rc6: three stack-out-of-bounds reports
> are generated when a DSM returns 64-byte buffers, with writes reaching
> 44 bytes past the end of cap_hdr's [64, 156) frame window into
> adjacent stack redzones.
>
> Fix by clamping each memcpy length to the size of its destination
> field with min_t(u32, buffer.length, sizeof(cap_hdr->field)).
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anirudh Prasad <icarus@a0rg.com>

If the firmware wants the kernel to copy more data than the latter has
room for, the operation should fail instead of pretending to succeed.

> ---
>  drivers/acpi/pfr_update.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 6283105bb0e8..0219347cd78f 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -161,24 +161,28 @@ static int query_capability(struct pfru_update_cap_=
info *cap_hdr,
>         cap_hdr->update_cap =3D out_obj->package.elements[CAP_UPDATE_IDX]=
.integer.value;
>         memcpy(&cap_hdr->code_type,
>                out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointe=
r,
> -              out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length=
);
> +              min_t(u32, out_obj->package.elements[CAP_CODE_TYPE_IDX].bu=
ffer.length,
> +                    sizeof(cap_hdr->code_type)));
>         cap_hdr->fw_version =3D
>                 out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
>         cap_hdr->code_rt_version =3D
>                 out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.va=
lue;
>         memcpy(&cap_hdr->drv_type,
>                out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer=
,
> -              out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length)=
;
> +              min_t(u32, out_obj->package.elements[CAP_DRV_TYPE_IDX].buf=
fer.length,
> +                    sizeof(cap_hdr->drv_type)));
>         cap_hdr->drv_rt_version =3D
>                 out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.val=
ue;
>         cap_hdr->drv_svn =3D
>                 out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
>         memcpy(&cap_hdr->platform_id,
>                out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
> -              out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
> +              min_t(u32, out_obj->package.elements[CAP_PLAT_ID_IDX].buff=
er.length,
> +                    sizeof(cap_hdr->platform_id)));
>         memcpy(&cap_hdr->oem_id,
>                out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
> -              out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
> +              min_t(u32, out_obj->package.elements[CAP_OEM_ID_IDX].buffe=
r.length,
> +                    sizeof(cap_hdr->oem_id)));
>         cap_hdr->oem_info_len =3D
>                 out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length=
;
>
> --
> 2.55.0
>
