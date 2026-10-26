Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793005366;
	b=p0rceKnSYPyfEPzpQ7DXQFyM9TIvHDGdiPyt/U9TQvfteR6dqf12syktUnbBz54ScU7o
	 XnYk9CN0Hhhrog0PnP/N73/NbkBoNrCoe6Cky03CeHTvsxPTJPT1WHJ/+WpikKVRhKw1e
	 E/bAXWhM2nsid6A/HBqRhr2EWRGJYMW5lfTnkNLp5HyH9NjgxihH1kOySJU1aNihjrG73
	 YGb2uKzPm0UQP6dVmkPJ/H41jK2uujhzdmdTUp3YNuYD4NWVw2NvpD0dTOZH3nrGs43LN
	 auiZK2UI28g8J2SSBpPIOIsYtLZ9Q08Zybci51sMshWrFSF7Vr8lFuLhhn8vbrnLCXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
	b=orslodZHCtiS0HktWlz5e5o0JGTfCfXUElIzNddqHsPecC/J+WkUHbLnorjDr5432Q4c
	 hIzIFTzGEYsw+GKUjRZGgleuuMrcj0jTO+PC2r2A+nnh8f/GuF/VTcbY0vXdZ6TgztBZ/
	 A5boUWrwWdvAZb1lhtFbdE/ff/ZGLMzRCH4u/QA5hlMdrloxsKutyGnkZt4DjRaMsYg6H
	 Wzx2jzN0kQqmkB3ePhs3KIq4kLxpACCWLj+fABEeXTogv5IvkKmqieDcCR7pvljrPRL6s
	 dS8Pb+9k1jK1c7JvMdz6XXHlqp0bHPxEmDV5nIeQr1/DX/vo/EQfvDhOu5kkOPPXiEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qLZsAbGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82792606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82792606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qLZsAbGj
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso3833587a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793005365; cv=none;
        d=google.com; s=arc-20260327;
        b=HW3pkP1CSTCgUXp21MtVv0dQvM1e2i/fCnnqVw9U6SeQdr5Jz7hogabUYeioSyYOsC
         f9p7YvvdlxGcSl2b1tbkblk22q8Ue60pBaPe+ip2lboD49LVQu6hGKTlSdFGctpFo3qP
         8N9TZqR8yQ/eiIJO8P2my3bWHRhPgCK1y0QbqvUZ3iUH0UoiN54jQGs6oaePxp3a/Nym
         AgO3BeTDzgPudeGeVIDLCVcVMoWAqZ4pfj6yrSy7fQP3FRR09q08gFMtImkk2uyva0kg
         nEA9z4TxGEwlg5UuSvqLTF7ITpQDHM9Ima5oeb2QQCkMYNZyQ1i5yanzF7HwFd3gUt8B
         q0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        fh=PzEza2uzN8Qir7U31F+nPiUAG2KJodRVFlZkUurI/Dk=;
        b=cRfyEiZpI//5zQdmexTtj1PA8+6ZVuY557EHCBZ+owjtuXPWWpGoJJEoaSdF+/MM8n
         0L8QD6nULhPE1mArPel2pNAloIBJhC9PIT1eTH5lJhpN+TrWGqEep2VhJdKRp8AJ/vCX
         u/PSvPoRPv6E/8Ln5kJ82kf8cGAodi7Djm/3hmuSsbI0i5MZ1sqmhJj/AjNHMAtHjgj6
         /vgQLeaV0K1FFIuWBH86OLaQVT6v0n/ATsrChr2nMsKOYL7eeT1QrxP0et7vDAAG49eZ
         gW5i/OwnuN/Ipvm13tYD6DFrYf62+rRDGv/QTCSqblVuRrSj8M1CxLUaPzzul+VRqwVS
         D4/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005365; x=1793610165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        b=qLZsAbGjyhOdJYoX4EsSnYS4ZxHYKYOA5sWs+jPhLE8FVmdXf2M5MlK6AoPKeVw0EC
         IFKRqq3vpCOpcybm9W8p1utbSK78D+GC7CKCDRA7EzPslPZda9G4Hx+aUNowG5n9m5HH
         Q7zI0oz7lBoS+j8xPojdDeBhv5h4sNXUM2hnlQVTcSFrGFS9L4vZscL1pUk5xM4TGx+Q
         IshB5L7JTrlqlJsEkQ3vmOcc3EmCW2eFVJwkM9CUTM7ldURZC0zw8XuiLgqPiRLSt9P2
         GxnWMgavOQuFtwmggQY/pXnr3BrFQ+IyKQZf1tTCSMvUOPrN/ZKbUxJ70XDEAIaa+era
         wW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005365; x=1793610165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4ANt8QiPje/vd+XmOCfwQ8O8188yDlc5I5mBp2AsQY=;
        b=MxgNZzG4FKf/RX/hnVP/m4s30BvYW8TRuevWPjPq9FVllDK34ueAMxZMdenALJVC3s
         xmxL4UP/lt1Qkzn/dwzbpdrg8danQDSl0xyKGKPxMTKHVNsE77UIFBZgL5CSjwQhJLRO
         KAUUjm942Qy3oe1RhWRsIla3d8ieoIOV7eH6K3HR8wjqqb+DlWCsZ3jxyJigQ8kA1eaa
         ZzZGh1Z6Q/IzMQZMQr6OzLrjUZgUDM99iueURkhQqXDfrCNUd50y8WxUE2AaVuJsLrrY
         M2Wmj/A97q408ijMoqDLdgvwsWlSKEcjVU48MhzxdziuKKqi56ubK1G/jxvE5Pp1guZB
         U1+g==
X-Forwarded-Encrypted: i=1; AKwUvBzg4TpUYweEOeL1wIizvS2B9TA/hMJEdUxVC7Sm9jMm7/8mfBbNiIRpXPrN/SIpaY8knGY6cDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNYtPuwCDTnlywNs05spL3oR0XwN6W159eaj3flGvVEVhUW876
	zfVRiBZbme6S6kjqHHNDWnVSZyKtej/V6WO7u+tv3tb/KKG8RSQHil+laqwybCuJG66XuV5zCyS
	lBve7+yGkr3vWnlYlkfIYjtykUszYtPE=
X-Gm-Gg: AYBFou3iJHwexjJVrBgXdY87KyMjHScTH4AOkxJUc8es9UQCMd2RD3zsiEdoAu5Mlpf
	rp63vn/aOIVztobUFh4DNm1soYP/DoKg0yK5WYmc/POtssHZwADnP511Lcjng4IjTSK5Br3gFf4
	vP3DK8xgal5ClxPm2WSx8elaWhNhnFTaVj8XeLOZKwOrB/V+QdbpqiJwL1cqIB60bMqileo9Bz6
	tv9vKwSbUnnfZXz63Z9S0qp9VZM1XOdm2ALdQXTZsG3WQAiE0v80YzWaqd8pX1SYxrTLVDRUUXx
	CtBmLLXPHF8WbNf7YbkqxG8h5DfFosHorCR9IUTKl6ORFIZkUsUL7j3qGBK6t8R67h55xwDztI2
	5o48aiz4vWopQYWHLmgiVMDUxAQBmH9DAIraGJdQ8rACeNIXTaIuc0H+HXcCNwpn4XmVMUw==
X-Received: by 2002:a05:6402:4410:b0:6b4:203:a182 with SMTP id
 4fb4d7f45d1cf-6b442a89b98mr8306001a12.3.1793005363531; Mon, 26 Oct 2026
 02:02:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026015738.46230-1-dennylin0707@gmail.com>
In-Reply-To: <20261026015738.46230-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 Oct 2026 11:02:31 +0200
X-Gm-Features: AclHuK8o2w3ue0fEsBYRmit5mrje2LPX_3oSwwLStLIHIXFr91Z3Gm5NRG4zIpo
Message-ID: <CAOQ4uxhxwOw4LNi6NV1FZzSePHZ4_SEg5QikvoH-L7GcKrkoPw@mail.gmail.com>
Subject: Re: [PATCH] fs: skip copy_file_range write limits when there is no data
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	djwong@kernel.org, dchinner@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:58=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> generic_copy_file_checks() reduces count to zero for a source offset at
> or beyond EOF, but still checks the destination write limits. If pos_out
> is at RLIMIT_FSIZE, this sends SIGXFSZ and returns -EFBIG even though
> there is no data to write.
>
> For example, GNU cat copying a 1024-byte regular file to another regular
> file with RLIMIT_FSIZE=3D1024 copies all bytes and is then killed by its
> next copy_file_range() call at EOF. A zero-length request can fail in
> the same way.
>
> Check write limits only when count is nonzero, as the ordinary write
> checks already do. Keep the other copy validation in place.
>
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks for the fix!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/read_write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4da846a2bf17..c05ad2c42e75 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1531,9 +1531,11 @@ static int generic_copy_file_checks(struct file *f=
ile_in, loff_t pos_in,
>         else
>                 count =3D min(count, size_in - (uint64_t)pos_in);
>
> -       ret =3D generic_write_check_limits(file_out, pos_out, &count);
> -       if (ret)
> -               return ret;
> +       if (count) {
> +               ret =3D generic_write_check_limits(file_out, pos_out, &co=
unt);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /* Don't allow overlapped copying within the same file. */
>         if (inode_in =3D=3D inode_out &&
> --
> 2.43.0
>
