Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B523D5C15
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737448; cv=none; b=ee7o6JeQIIArEv0GAClLdJsUqJOq17FlQp9dVHAEcnXc+vGnTdjJxp+PAK7Kh7eQfbJET2izQw6Zgm7TdcS7hj9sPwwADdNQpIEYyo/r0aNUjunUwFn3G7gxn1doILrs7bia5ngYc9XjPPGPS963adOzHZhEPr+na5ODdKe0sSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737448; c=relaxed/simple;
	bh=5KMSJOTgXjSvdTDyMgmTa2u7F8LvDZRqCU+YXS+jUhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyjNuXSISN/1/Lo3WADccg+aHEBiN1b5q/B7G72dIvC9J6VOI1mKMk1y/cJoUKEKhVVldfHydhNa+0socGhKKCl9/orhGfBDsEF83Fp3GpzEEuABC0eZbT6OfmWqgsdd+E3FCXsAwpktwzn7feu3EPm7TkdMzNMQpDgaCe7GrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwgVhsl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwgVhsl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097A21F000E9
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737447;
	bh=PswRQ3VybxKVhQl5sV/6OBfdiyOWqcU1+y/a2m04DP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XwgVhsl3qmR2M5YC/LPx6K9M7TEgCaWqEhCP3v8sblzdQpD/L4IZI+85RHD7AuH++
	 uro5ji5gjswK6paOQbNu4MH/ickJEvBYaFoOkeFa6jV4O4NjyzOO6B5sXRrNaQ4hGG
	 y+mll0X2xEJJrEiWGuRPYcpDv7HseOjI+xDEkhWwxMJayDebTwkv5BH0hW3ZmFzG0F
	 pDYYNttPS81VZcJIKp37ZtBceFJ0ncyRkIkKGB4ISHuZSF4GAhhfIaZ9azmX2oEKrJ
	 v2pELflRpWigQVuWLJTA7O+We1CTD/UPx31JCEWyEAPF0257scptyJyw33lnlavUJR
	 yoCjdHW2J12mw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39faa67fabaso8480091fa.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:57:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpBKEEji+giJS5lRCUbMzdx+TFJWVht0ESI32YLnzDaO8+81cSKRNXSQdWsWOZb/4PYKR0685M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIixVzUXzMsZ659TIOMslmUPn4I4xGdz4hekHEChAovn6WsfA
	YdULfTHTde6vXD3u2cbo1LQjJayISfmcONqc3V0zBI26BWgwdFo83Bp1hCq9Ih8o/ejoBYS4lxi
	CIGOkfktdI4zWgQEdqa7jRihHsKjgyaw=
X-Received: by 2002:a2e:be9b:0:b0:39b:4371:dbe6 with SMTP id
 38308e7fff4ca-3a13249eb07mr8571421fa.16.1786737445353; Fri, 14 Aug 2026
 12:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19fdcf5017a.193154c01134335.5292960934110253862@a0rg.com>
In-Reply-To: <19fdcf5017a.193154c01134335.5292960934110253862@a0rg.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 14 Aug 2026 21:57:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWzfWV1y_i0kpPd0VbvGdmTrR00=nQgO-RJWYUrZRrXQ@mail.gmail.com>
X-Gm-Features: AUfX_mzSme_BIDTClW9sTfH29rgeGIuaAsyB-dRVMgHwZoZdsPQchkOu7RKr2kU
Message-ID: <CAJZ5v0jWzfWV1y_i0kpPd0VbvGdmTrR00=nQgO-RJWYUrZRrXQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: pfr_update: fix stack buffer overflow in query_capability()
To: Anirudh Prasad <icarus@a0rg.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rafaeljwysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:01=E2=80=AFPM Anirudh Prasad <icarus@a0rg.com> wro=
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
> Introduce a helper pointer to out_obj->package.elements and use it
> to validate each buffer length against its destination field size
> before copying, returning -EINVAL if the firmware supplies an
> oversized buffer.
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
> ---
>  drivers/acpi/pfr_update.c | 47 ++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 6283105bb0e8..79cedd4cf2a2 100644
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
> @@ -158,29 +160,32 @@ static int query_capability(struct pfru_update_cap_=
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
> +           elem[CAP_OEM_ID_IDX].buffer.length > sizeof(cap_hdr->oem_id))=
 {
> +               ret =3D -EINVAL;

ret is equal to -EINVAL already at this point if I'm not mistaken, so
no need to set it again to the same value.

> +               goto free_acpi_buffer;
> +       }
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
>
