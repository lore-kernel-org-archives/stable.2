Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F17473C8C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117384; cv=none; b=HIiOR77zyyk1b6G7FXc10nu8/e5/uhVdIeZBLFCYI/SVGkEN+NhxilpX7an+MyJgwOmBQe2/k+vvU1ZJ4GmIasYnTXmumHMsYc7FrzsKsZzExwFs6S3+g/JTDWIdVmUwDjcTCOBPKipMQI2D79SpwABGJYq9MUdWlr9kaQOEvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117384; c=relaxed/simple;
	bh=Xr+cu/zPX+O8fmSzHx7QXbQQakMypOf38lODNpejLXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8xIvS7ZgRUBSKbpytUSH9PG//hxv+BancF5VozBHlFxoyBjW0aFcaqJrWDk3Tcup1YulBLJremuUk8Wcb4/C5UEfErf0aYT80/ItFoAw1GVO2LJFySeIC+HDH0PA5BF2Hjb6QR37P3HRqyhsRhPoskAp15a+QJB9iqop4pbtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMisoxZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMisoxZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301A01F00A3F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786117383;
	bh=wkeRhg3PC1j+S7tF+z/YeHO/VYSEXzodmxqwU3Ai6Dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aMisoxZE3n22HdwFVirubUV+kx0w9rSjeoqqjER0pC2uMfftoHPowxbRu4vFPlf60
	 /ajnwIJfqj4bGWQXlBYmFTEJtlSOTujCKd2thlEuW+YR70A27TOtPGAp0vM1sdkJP8
	 UzkYdxHrGIqkn4zAGzyAf54Mv4/nzcHyAFS/x/gQtTDz+X4QCt2aEAJlooF+rGeOkQ
	 NEqSfDjYDCTN5cg5TACCbF2reoQeDdZiZlfRc9Hdovh6W9DpT4dyjb7KTK7VNpKGvO
	 GnTulpYHoJcgBXsUFzHNp0It/mADOWsQUMGFoOQ/QCjsSqpfzdoHy4GnozG0C+EJHt
	 5Fbxx/+Jl76Hw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso29589401fa.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 08:43:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqII9xSApfQsu5UzkKRpsfuqfj2zcqyRSVcOUXr30SjuXqDmOMeC9Yej8w8g990b2vsUSRlbT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLCVGB46/taOYbc027kDwfhgicvHTO3j2swPaNRV5Ek6hU+BD
	xwGcD8LHHAw1ozekY/l7Ae+U7XjBtOA1rtBDWHZT+MEZFjCQgTbexhI6EhnggCtVdYQh1GBLy5J
	GCRztLIHzsgbsM+WC5BVw7p6wMSr8yPU=
X-Received: by 2002:a05:651c:a20f:10b0:39c:7859:a2cd with SMTP id
 38308e7fff4ca-39fe57110e1mr1533581fa.13.1786117381537; Fri, 07 Aug 2026
 08:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19fdcaa3013.263bb5511124041.2034910216820799254@a0rg.com>
In-Reply-To: <19fdcaa3013.263bb5511124041.2034910216820799254@a0rg.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 17:42:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-HiNNO4Cwqd_8Rs2u+05U-sM4cnektpKCWFW1NWxLLg@mail.gmail.com>
X-Gm-Features: AUfX_mz0ZoCfH81jnagtzaIJJ6j5tJ-qHsYXsx6aIZzwS5v6jcFU72ax1LmbF7Y
Message-ID: <CAJZ5v0h-HiNNO4Cwqd_8Rs2u+05U-sM4cnektpKCWFW1NWxLLg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pfr_update: fix stack buffer overflow in query_capability()
To: Anirudh Prasad <icarus@a0rg.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rafaeljwysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 4:40=E2=80=AFPM Anirudh Prasad <icarus@a0rg.com> wro=
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
> Fix by validating each buffer length against its destination field
> size before copying, and returning -EINVAL if the firmware supplies
> an oversized buffer.
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
> ---
>  drivers/acpi/pfr_update.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 6283105bb0e8..e14e053cea44 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -158,6 +158,14 @@ static int query_capability(struct pfru_update_cap_i=
nfo *cap_hdr,
>                 goto free_acpi_buffer;
>         }
>
> +       if (out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length > =
sizeof(cap_hdr->code_type) ||
> +           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length > s=
izeof(cap_hdr->drv_type) ||
> +           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length > si=
zeof(cap_hdr->platform_id) ||
> +           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length > siz=
eof(cap_hdr->oem_id)) {

The lines above are too long.

Please introduce a helper pointer to the elements array, say "elem =3D
out_obj->package.elements", and use if in these checks.

> +               ret =3D -EINVAL;
> +               goto free_acpi_buffer;
> +       }
> +
>         cap_hdr->update_cap =3D out_obj->package.elements[CAP_UPDATE_IDX]=
.integer.value;
>         memcpy(&cap_hdr->code_type,
>                out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointe=
r,
> --
> 2.55.0
>
>
>
