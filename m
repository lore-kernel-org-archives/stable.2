Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C213C1095
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254704; cv=none; b=rn/4FVjnYhmgZb7ZzI0orQ9phuO37GjUAnm/mSrZbj7GCtQToxm11MMNvg9HEQd3YYIFgA1OinpiQ5MQCmK4dHkdiU8rQUVg30nXB2b+3SQMncIXAU5vnai8GJ1FIT7bAl5FC1lhRhJAf2xTGBVw3TkXGFzAE6JgMoWbg1hMK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254704; c=relaxed/simple;
	bh=OwhTciEBxGvZpMgxmBCoY8U02rBpO4RmcVqbxFQwCsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoBRdczY0PMIXIHgjNEoPlvdavGuzqwz2Qslyu2opJxznVv6A4nJ8taaFpfDL5r165tiPZv6zv0vRE855ta/7cKhizIVkVnOm0ct1tJvGiym49Ydjz2J47vV8zllfdZjvJKgA9JMc3Hhfhw7Tog1VTgMoxr2+BZ3h/1BCTikLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3y3m74q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3y3m74q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F31F00A3E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254702;
	bh=1nfrW1dI5XFMPUurIDimqRVaz57NNKLaAOoDXyDYRNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l3y3m74qms5yiklitwqvWieYQAkolPD+/NtbjrVGZjwCDG+uDKRRs+Kr1TXtWLQde
	 xiIbjdhjNmOTPyV7VJLEVA0rVcqKAb8xjX/tPUftfFCC6bImEWXOrq3URaQko8RqSZ
	 9iqY0U1wHyH6TDiG25Pi37SnlDDnMjujQqpaQRFxv8A8+jJn4tMR9B9vPYJdt5Ux/g
	 fi42N6B0WSZ6xdDolOJb2/cbb+mw50pD6Gm6pCfjyHVppomU4QoGtqwuqWm9BqPtOc
	 LbqMGfue3lt+QYnb7EkPATVRdtVBr9CjqtZXL/q/Nmrfn3WvPYJ0IwoiMpYOcFJn/p
	 TbXybM9C+icAg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a14f6613fdso4263051fa.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:38:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RquuYyk4AvPs16SIv2g0F7Zh3TEdrvZNcjYPf4NUvinHVJ0kIBjxTrnzZEowzXcLd7XfzLZ9wM=@vger.kernel.org
X-Gm-Message-State: AFuF++lvfWo8RGdeyb8+99JrHrYkS9E34ptDOfeDu5ImzC9ur5zkpqss
	wqHN598VWCfMgcZ9neHbdBtYe6EHTZpR+hhWdm3iZy3b4gU5LJyCONuEKwJhRctjA4db+rCCg9N
	H/ZCzR+0RgbtPJs1b0g6reOx0DGYCVXw=
X-Received: by 2002:a05:651c:1542:b0:3a1:a8c8:2e21 with SMTP id
 38308e7fff4ca-3a1aec4c778mr2614571fa.9.1787254700990; Thu, 20 Aug 2026
 12:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a001e1fee9.637da6dc3533246.238498880682901704@a0rg.com>
In-Reply-To: <1a001e1fee9.637da6dc3533246.238498880682901704@a0rg.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 21:37:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itdMNrRuhUBTmW6c1JpTQ4y=J-naj2k+Pti6XmnJuwvw@mail.gmail.com>
X-Gm-Features: AcwNN1XK6C2ci2cE88zALjTHTG6SK0Z6o0SX6aZiXPtC896epKnwad_0816CyTk
Message-ID: <CAJZ5v0itdMNrRuhUBTmW6c1JpTQ4y=J-naj2k+Pti6XmnJuwvw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: pfr_update: fix stack buffer overflow in query_capability()
To: Anirudh Prasad <icarus@a0rg.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rafaeljwysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:06=E2=80=AFPM Anirudh Prasad <icarus@a0rg.com> w=
rote:
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
> Introduce a helper pointer to out_obj->package.elements and use it
> to validate each buffer length against its destination field size
> before copying, returning -EINVAL if the firmware supplies an
> oversized buffer.
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anirudh Prasad <icarus@a0rg.com>

Applied as 7.3-rc material, thanks!

> ---
>  drivers/acpi/pfr_update.c | 45 +++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 6283105bb0e8..9afd2c52fdbd 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -120,7 +120,7 @@ static int query_capability(struct pfru_update_cap_in=
fo *cap_hdr,
>                             struct pfru_device *pfru_dev)
>  {
>         acpi_handle handle =3D ACPI_HANDLE(pfru_dev->parent_dev);
> -       union acpi_object *out_obj;
> +       union acpi_object *out_obj, *elem;
>         int ret =3D -EINVAL;
>
>         out_obj =3D acpi_evaluate_dsm_typed(handle, &pfru_guid,
> @@ -150,7 +150,9 @@ static int query_capability(struct pfru_update_cap_in=
fo *cap_hdr,
>                 goto free_acpi_buffer;
>         }
>
> -       cap_hdr->status =3D out_obj->package.elements[CAP_STATUS_IDX].int=
eger.value;
> +       elem =3D out_obj->package.elements;
> +
> +       cap_hdr->status =3D elem[CAP_STATUS_IDX].integer.value;
>         if (cap_hdr->status !=3D DSM_SUCCEED) {
>                 ret =3D -EBUSY;
>                 dev_dbg(pfru_dev->parent_dev, "Query cap Error Status:%d\=
n",
> @@ -158,29 +160,30 @@ static int query_capability(struct pfru_update_cap_=
info *cap_hdr,
>                 goto free_acpi_buffer;
>         }
>
> -       cap_hdr->update_cap =3D out_obj->package.elements[CAP_UPDATE_IDX]=
.integer.value;
> +       if (elem[CAP_CODE_TYPE_IDX].buffer.length > sizeof(cap_hdr->code_=
type) ||
> +           elem[CAP_DRV_TYPE_IDX].buffer.length > sizeof(cap_hdr->drv_ty=
pe) ||
> +           elem[CAP_PLAT_ID_IDX].buffer.length > sizeof(cap_hdr->platfor=
m_id) ||
> +           elem[CAP_OEM_ID_IDX].buffer.length > sizeof(cap_hdr->oem_id))
> +               goto free_acpi_buffer;
> +
> +       cap_hdr->update_cap =3D elem[CAP_UPDATE_IDX].integer.value;
>         memcpy(&cap_hdr->code_type,
> -              out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointe=
r,
> -              out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length=
);
> -       cap_hdr->fw_version =3D
> -               out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
> -       cap_hdr->code_rt_version =3D
> -               out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.va=
lue;
> +              elem[CAP_CODE_TYPE_IDX].buffer.pointer,
> +              elem[CAP_CODE_TYPE_IDX].buffer.length);
> +       cap_hdr->fw_version =3D elem[CAP_FW_VER_IDX].integer.value;
> +       cap_hdr->code_rt_version =3D elem[CAP_CODE_RT_VER_IDX].integer.va=
lue;
>         memcpy(&cap_hdr->drv_type,
> -              out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer=
,
> -              out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length)=
;
> -       cap_hdr->drv_rt_version =3D
> -               out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.val=
ue;
> -       cap_hdr->drv_svn =3D
> -               out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
> +              elem[CAP_DRV_TYPE_IDX].buffer.pointer,
> +              elem[CAP_DRV_TYPE_IDX].buffer.length);
> +       cap_hdr->drv_rt_version =3D elem[CAP_DRV_RT_VER_IDX].integer.valu=
e;
> +       cap_hdr->drv_svn =3D elem[CAP_DRV_SVN_IDX].integer.value;
>         memcpy(&cap_hdr->platform_id,
> -              out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
> -              out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
> +              elem[CAP_PLAT_ID_IDX].buffer.pointer,
> +              elem[CAP_PLAT_ID_IDX].buffer.length);
>         memcpy(&cap_hdr->oem_id,
> -              out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
> -              out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
> -       cap_hdr->oem_info_len =3D
> -               out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length=
;
> +              elem[CAP_OEM_ID_IDX].buffer.pointer,
> +              elem[CAP_OEM_ID_IDX].buffer.length);
> +       cap_hdr->oem_info_len =3D elem[CAP_OEM_INFO_IDX].buffer.length;
>
>         ret =3D 0;
>
> --
> 2.55.0
>
