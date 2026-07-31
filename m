Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9F307492
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521164; cv=pass; b=pqX7BDV4+ohr/CNWSoBwRcUnTuyMeZEpE1jFJA2GInHl00P0DiNgcTM6fkkbhs96dtp4JtmjqW6jT5hfsS0aD+x3U/5U4KGEYDn8a2+YRCbtttQrN/SzZvpzCga77wRdLqa0MgAqHkIA9uKn3WGgXMKojrfv6M7eAujxo9omL8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521164; c=relaxed/simple;
	bh=Iz8ffwhw26CpaI+mvyVjJUmyX9kTePoajvDT+kROQLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGxlfkkzhDL4KVYDSS0Q7rIOnDsWS9HAMYTdFcgAusTOOdHSbGE0bZA1L/phkfMUxBk9XQd3ewVjZzMzLn8HY45AUgzOiAJiMKlPVld7qOlt/CGIfLgjAiNt9N9MwiWf+O399dMlha1EsSAUDBNYItiTiD2eP5vgdqUhi9+z2pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYlo65lF; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlo65lF"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6689402c7bfso1420314d50.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785521162; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpMtqn62QpoywyfGtdXi6FaedyalUkIurV+4+Lsq28xEOcddBFxfjFKGYanUsus1os
         cLitATHPcAIDTabJRjQDKUuMzH8KYiL6+QwFcI+bygbUtnxwq0vuLoToBD14Tgdg6JlY
         4DHus/Jw2860XkOgc7vHrMvht7WwsahaQj3BHaU0V70qz3ra6/sphjVp5irhFNsuC8Xc
         zfwFb3esC6a7WAagIkCN4EgXPCQyu25rbmLeDJcAFZBFasuoO91d/Ofe+YQ/gPR7H0/j
         nD9dqQZ7caI4Bnk/R0dh9yKLDuBiMlmZVjzg5Nhp5iw5bxnpBWSUGb1ibOPAmS/5ywIY
         MnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        fh=DjLqv0ZJbTJknyRH4prSWyucSwFGKrODgDTfrfQL084=;
        b=jxPm99EfSDC8mKWAubgsfdVquzh96GGTZXub8Ucwf/v8/D3gEkQvi7nVyq4BGBLvrZ
         994nR+rydK4jTutsbZahAEo1F55IeFxEcMDd8xXGWd6MQTfGlrZTG1CkW5wr/AdPgwK1
         PKM/j/4GlJFbY5l6iC+Atmbck+hdr3YjCBsE4/qTls++GGwKTzMCtPG+EDhl3FutHZYw
         dwweM4cbc/w14dQeeZVEJ3BUpd6sy55ywSHL4Mu97jMGdt5gdRgedPYXw0yf3viHYttA
         y8vn+RSyHOP1iDzm9feqGyGc4JGRWZnzlA5Vghl/F6GpxpHu+Zu/Tb4GS86ex6etQSks
         nc6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521162; x=1786125962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        b=hYlo65lFjffXRZ8XlctB4GgPGWdwP6OtMAkVsFpizR8KgmeruiVasXlTRI0M6l7QwJ
         VjrS/mesBm2TMdnPQOaXTey7AIHCCgF06pciwm/tp0AQIOzAJNycCrD1r3jWShDUeCXN
         KplSGAuHpV5OYvzqo1ZtgN7h1ZrK31JS+ELVfL9QqJF+o2YEjfYuTbP9q+QHIw21m2hE
         kwFDtI8yOSw8dFkRl+noHeLnDgkjrFLy9ViSCOVYFijbnyRvN/e1SkEa/9WGRaZtA46k
         Hc2wgIxNVSa5gWFcEyb+uze/mk4bLVTpXQk53eW8HxcCI/GiUFq2Utefe/eIfGqHxXp7
         Ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521162; x=1786125962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Be92gGmY7KrSGIMznvcDGv4P9viWnD9BIV+7S2IaULc=;
        b=nfIcPlLUuZvnM/FI24eQDO/BXG93k2r3+B8Ru+XOdXWDKE6ePWust04/+8aqyllRQv
         QX8u3pEAUDo6jy7DrUsbFOIBAi9PSucyVSWw09NsI4pnqcRddUi2FF0CN+TXP64NykHa
         s0vzGHnOoWgsv+o5cK1HYMTd9mEccG8ekotS7RT88bs4AbMRcBmbriZ6OBpE9E9zygHR
         KJTzYHTC5Z87B+Bqzp5UOq8WYKO850AfX6ZPUJfRQN7NKkg28d/kPYbztwLZgEa2Jzvt
         NLALcTn97q2VS3/WYE4vAZcA1b/dSyUEI8M9yosWWC+WiLF6W84RgM9oYBvp3TbXhUcY
         LbCg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Q6nEmFb0N76xoOV/D6JmPpTQw/eKSYjSPGT1XDE8dhWIxayh6+hPYEbtUbBzWPmWX+GAz/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRl/t690zP1lZhOlupHNQDheVpxdhxRgmDxhunlXO1zBZOwuX
	tt1rk0wBEN0OZm9x/WOhs2W7/kHnb7ucnXFSN7q8SRkjo/+2v6viPu6Gc95PzZyLuRGbpc6IJDz
	5ftXb2qZ5XugkGbuLpkzE1fLe+vh5NyvkGHh5
X-Gm-Gg: AR+sD104hW41QVQ0gyBSgSHQ7Vv61FWsT6eIUTlbykVJkG1SXKSsspdBQNS1x7GfI4W
	bGLgTFChcvFUOJZ417RDSxmqYEU8klSURu++4qwK1dYtcMM0gKizSGjJKQyWB+KHzLv1WxSFYLH
	JKfPL4Zv0LDVRq4y+0IsP4kNksBoBFy/4qV/NbAaBrZywWKGj9Wi6UDk2n+DQ6j6na9zi9zBWxZ
	r/K4m8yTIJmZxiogUZuzHSH5nlbtd7s5jL0pceM+WCSxYgi4VJl5FoQDI5k6h8qGkd0jKpuew05
	bKtRzsPKrvaU9p9Jfgjs0r6nJakjT4sp1i0Oi639dZTV0iO5kFLhdZDdWtv4zImdSSGGtmJ0VTF
	L0x3PMVk169+06kdgQIg5GgXX0YKTiYfz
X-Received: by 2002:a05:690e:4851:b0:667:c7ba:99ee with SMTP id
 956f58d0204a3-6694efe2747mr922756d50.2.1785521161655; Fri, 31 Jul 2026
 11:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 14:05:50 -0400
X-Gm-Features: AUfX_mzEFRNqbfRb9bkSDwPElPkYkV4Dq0BpSLwrwXx6XC8tKKsLy43fDAdEeHc
Message-ID: <CABBYNZ+odi_ncMBjTTcrix9_sOMpa+d7_pNWuH6ePkQVmRwiuw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: validate QCA rampatch size
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laxman,

On Thu, Jul 30, 2026 at 12:18=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> btusb_setup_qca_load_rampatch() reads the rampatch version structure at
> fw->data + info->ver_offset. A truncated rampatch can therefore make the
> driver read beyond the firmware buffer while parsing the version fields.
>
> The download path also expects the complete device-specific rampatch
> header. Reject files too short to contain both the header and version
> structure before accessing either.
>
> Fixes: 3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset =
family")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8f7ed469cac..9801835d7c7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3526,6 +3526,7 @@ static int btusb_setup_qca_load_rampatch(struct hci=
_dev *hdev,
>         struct qca_rampatch_version *rver;
>         const struct firmware *fw;
>         const char *fw_subdir;
> +       size_t min_size;
>         u32 ver_rom, ver_patch, rver_rom;
>         u16 rver_rom_low, rver_rom_high, rver_patch;
>         char fwname[80];
> @@ -3551,6 +3552,15 @@ static int btusb_setup_qca_load_rampatch(struct hc=
i_dev *hdev,
>
>         bt_dev_info(hdev, "using rampatch file: %s", fwname);
>
> +       min_size =3D max_t(size_t, info->rampatch_hdr,
> +                        info->ver_offset + sizeof(*rver));
> +       if (fw->size < min_size) {
> +               bt_dev_err(hdev, "rampatch file is truncated (%zu < %zu)"=
,
> +                          fw->size, min_size);
> +               err =3D -EINVAL;
> +               goto done;
> +       }

Has Qualcomm engineers verified that this is the correct way to check
the image size?

>         rver =3D (struct qca_rampatch_version *)(fw->data + info->ver_off=
set);
>         rver_rom_low =3D le16_to_cpu(rver->rom_version_low);
>         rver_patch =3D le16_to_cpu(rver->patch_version);
> --
> 2.51.2
>


--=20
Luiz Augusto von Dentz
