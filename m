Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F1391E7C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577516; cv=pass; b=J/QehEEY8tuY3gW8ngJ2stChZKzKo0nwU+RoaJ6lGUS8QN5IEPb8crtrY12q9qIqNZ/f1C15OqaZNA1MkI7lsk5zWQV6XGmJStPB4GXLenSeQZza1bM4+7SVtD39CWQpLvnSgf3VsToM1GNJxwIBCAtQCxmCsd3MZeQPEYIZqwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577516; c=relaxed/simple;
	bh=e8K8qnCQMQCq7N/GCNIIdQb00fKuyW33qvPofgyhMmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLjEK1mDIVQzQmYXnHrSUSE0TKQQoKP3rfcpzlpTiTtUDNMD+k5DnLq58vlHtTBBW/v8VjVrSagWLhk1Zfy5Y85DJFL/Yt54ciIQ6v1VPPJ2Rl2oQbvPd3iWgRDc4AqE+Am2yvcyZewPHfnv09df+PdmhfPlSiT3kEqr3qUHE1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpoFpK2C; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpoFpK2C"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81eb41c1f1aso85278797b3.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577514; cv=none;
        d=google.com; s=arc-20260327;
        b=TslZd3IyR9AW5WH2KOaldbTL5i9MjemkBRJ5k2ffzVmZ3mF31o88esklqg0l8BLYF4
         WRhU1c7g0zL0iV8BhNYO0RDy/twhyfrbnN/4zedBRn+SjLrvuH01OmhKm/9V52Nr3amh
         4GTV+8gHGd4IEZ1G1hJwDQiMQlNhEwqLmoUKkEtk606JzTgEe1qjqv19YmWFdNyDnoo9
         ODCjq8C+S46/ejI/jsrJhz/ddLN/oSgyhQ7x124/n8VxPhAKR2er/6Eqe4se+4hyhDfV
         0ZttR0irMc8qUYGAFnlMcJkI0DcKuELRsw6DPFhraPE6i3685p3UxkeY3/3Pfp824Mni
         WBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        fh=sQVHQSk/oY0wkByAHDPAZR/4qu7u0WUvUJxwCwXkLQs=;
        b=lLdG0N0s54KGekyGOQLvlKQmra7nZVz2l+MCBcLsqUDpezkcntAJPzoMKNqLqUJaxW
         +38ekVPqgiomqqkpJX4xSpDjRH5GZj0UHlJU3SLg+wByz/P/yyBVteTnO5HnbiAhqBNS
         22I4z1EGOoWjPuMu+K2Z38o6s1J8eCJn6aBG+tXalVEozGJC5gg5s3SZcYso0+qQLd4m
         u+8KnAl4j4Y+ElwxPW/H1NElQn6HdyOTGmUtQCx5VcP+3iDR4Wp9JWhRAT2LeLuamRlX
         31QN04whxy6W/+DAmkKbTF+JjTsCm1rfUuMlHcdHjeui23XzmMwZV+L6xKi+g6rJTigq
         4hqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577514; x=1785182314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        b=LpoFpK2CG5v8+5KVTzWksUlbim32tC2EPMIkdpckXajSpfoljRnDloWbqYR0SLgkje
         aRWWXAAmtLUZcukVVVkmIc9TxOU6xVSz22XPHhFuuSc/pbKwA8uW/BO4BzeMEefa7Izx
         qwzZfuZjDYOZTGNFoixPAoXDuuFGk2es8xrTApYPq9zd7ouXDPKnooavgwWMrGitIw9o
         G83IZF0IAz2Pl7r46rQpRXUhD06ZCPXSZwZ1nh/NqHnhiI57CCpf1AYW9RXx1ZYHIlpI
         5AdcXIkCOopeyMj7gDlRGzbqS51Z6WyoXfhnc6RW9MrrAsJwpZ6AXMpR5k3yx6y8w0XA
         QlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577514; x=1785182314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8AkqCxGJFiQ6x89Rk4bmv20Sq84wArInU3KYGKskVU=;
        b=V817U2R/KJrQ6DJ//nh5+fmftGzBWRBxkXKReP601eFiWj4VqxwU03NiulVCE/S8b+
         0Uim+eLKu+HsUWS91FWaPZgjWJPLQjWaAdiBt72z8JLMmeKYumrS8FMWabHFCJOt8IGK
         h2k6GyGVgU+CBanixfSaavYfFj06SgVzJuP4dK6kHxLlwYye7a2lt/3KoduEdoQHoH29
         61yF/jbgnj7lUQpZOsvLhoYzMtGcl/Br5q0sqrITZSQxDqwi976CBJIKcE0JMsg0uNV5
         ZbGUxdUeW4qwcVt2JnmrJlUTg7pKP1mWsBWEOD3xJTKFC3GyEahkHalTCvlAMH+mmOIl
         aFuA==
X-Forwarded-Encrypted: i=1; AHgh+RqXITT2P0qKADtTiW+zJqTPPSTxJRkrcy/UKq4yNzxkoNRMBU4Ey1fUBZOV2oDtdlh2hEKODik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzddidlMOGAN41SSjjqMP+1g9piNU5L7dva9mRfhdVgxCDxmY
	gS+bqdTL9Da6ZE/OSS4pOC0zG3miW0hFisULz4Ro/L4Xuoo84nqr9+EWIXetUAIwcyjtnYWz1KX
	XpN3/fYXqn2PsKz+eojRMG6i2iOf96Yw=
X-Gm-Gg: AR+sD130qBAYpLjXo/gp1YOUpYER2SMurbAdey1y3WTabENYfQGDNDjkWMc84W5n3CA
	2IKv0CifecjHgcrWA/z/0Tks7d03NVYd8qCHhVaLHQXOKRXDOtK1bBMjh/hSRumfokHBm/byRQB
	T3yHpXmYLAMvGXOMKDoPNNJNao5K7LfsAOV9BvQl5wyVn7JBn0wnn+NtWo6siwubVhzOM/lUxDF
	2ZDd6MmhBZq7/Nj4Fl9U+Kx0lz+leN3854WexriO35jH+nv1wp4sTaIz0qGB66lT6kCbxxxjL8B
	8WgGVlbBmoqMLdcRYL4fq9hQjJWQ6PfaU4us+vb002YxK8yy
X-Received: by 2002:a05:690c:3344:b0:81e:79f0:4898 with SMTP id
 00721157ae682-81ef26cd1a0mr42024967b3.15.1784577513969; Mon, 20 Jul 2026
 12:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720191322.14432-1-doruk@0sec.ai>
In-Reply-To: <20260720191322.14432-1-doruk@0sec.ai>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:58:22 -0400
X-Gm-Features: AUfX_mx6T-muarEkjZNXWuZXNO-Iwx5kWJ56Oe7o3dTKk0KPjblNm-Vbd1VRM5U
Message-ID: <CABBYNZLaFuoektaPQkzr4ioiz9_pUpbun1oow0kwgSOhbHM11g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read
 in nxp_recv_fw_req_v1()
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Marcel Holtmann <marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doruk,

On Mon, Jul 20, 2026 at 3:13=E2=80=AFPM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset bu=
t
> left an unbounded read in the v1 handler.
>
> nxp_recv_fw_req_v1() advances a device-driven download offset
> (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> bookkeeping runs even when the payload write is skipped, so the offset ca=
n
> walk past nxpdev->fw->size. When the controller then requests a header
> (len =3D=3D HDR_LEN), the driver reads the 16-byte bootloader header at
>
>   nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
>
> with no bound on the offset, reading past the end of the firmware image.
> A malicious or malfunctioning NXP UART controller can drive this to read
> out-of-bounds kernel memory during firmware download.
>
> Bound the offset before the header read, and convert the payload write
> guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
> u32, so fw_dnld_v1_offset + len can wrap). Log the offset, expected lengt=
h
> and firmware size at the reject site to aid debugging of a real device.
>
> This was found by 0sec automated security-research tooling
> (https://0sec.ai).
>
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Blueto=
oth chipsets")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v2: log offset/expected_len/fw size at the reject site (requested by
>     Neeraj Kale and Paul Menzel).  No functional change to the bound
>     itself vs v1.
>
> v1: https://lore.kernel.org/linux-bluetooth/20260705115650.81724-1-doruk@=
0sec.ai/
>  drivers/bluetooth/btnxpuart.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 0bb300eef157..6d62d07a542b 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1041,11 +1041,19 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hde=
v, struct sk_buff *skb)
>                  * and we need to re-send the previous header again.
>                  */
>                 if (len =3D=3D nxpdev->fw_v1_expected_len) {
> -                       if (len =3D=3D HDR_LEN)
> +                       if (len =3D=3D HDR_LEN) {
> +                               if (nxpdev->fw_dnld_v1_offset >=3D nxpdev=
->fw->size ||
> +                                   nxpdev->fw->size - nxpdev->fw_dnld_v1=
_offset < HDR_LEN) {
> +                                       bt_dev_err(hdev, "FW request out =
of bounds: offset %u, expected_len %u, fw size %zu",

We still have the 80 columns limit in Bluetooth.

> +                                                  nxpdev->fw_dnld_v1_off=
set, len,
> +                                                  nxpdev->fw->size);
> +                                       goto free_skb;
> +                               }
>                                 nxpdev->fw_v1_expected_len =3D nxp_get_da=
ta_len(nxpdev->fw->data +
>                                                                         n=
xpdev->fw_dnld_v1_offset);
> -                       else
> +                       } else {
>                                 nxpdev->fw_v1_expected_len =3D HDR_LEN;
> +                       }
>                 } else if (len =3D=3D HDR_LEN) {
>                         /* FW download out of sync. Send previous chunk a=
gain */
>                         nxpdev->fw_dnld_v1_offset -=3D nxpdev->fw_v1_sent=
_bytes;
> @@ -1053,7 +1061,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev,=
 struct sk_buff *skb)
>                 }
>         }
>
> -       if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
> +       if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> +           len <=3D nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
>                 serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data =
+
>                                         nxpdev->fw_dnld_v1_offset, len);
>         nxpdev->fw_v1_sent_bytes =3D len;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
