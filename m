Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821674;
	b=dRuUDRCVFxhWwLmkzND6H2SF5eo99PYv3dzvV+r1duHcOUW2ARz4NLBdr8ZfgA8X+lXQ
	 qaTZO2z8pN+pfSEZF5Uu/wjGC83F+6xCwaIWL3+Mk/fs7+bJ+6EcHAG/QYPf9P52KuuPy
	 s7PhaqOaE3aclRl5jI+I98FY6skT7t6mcCfY3g5Y1w5VUSiAS5TwY+drbKohh0DTH1ANP
	 FO7K9EATheufr2Ik0l88noUnlSqgd4nb2TDhvEpymY7xr+6TblvVGdRIqdcoUDuPVw40S
	 nHPBq++6FvRBsdkvy7rWlIYvW+AayOx0SmZb5vreVpg+BI6yPfMjlDe47em+WBqd4HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Jrd32+YJEVParF9gDYjq1VptNJioJAFlM7MtJqO7Iqw=;
	b=TdDCBT2GlXoDi/B/DRs61DOBj0Ndig3zgtvhR4azK6kkp6F1fC3DdQ8FY/3/aVGByMJE
	 HsTAES815pnAWak/G/rhemZxXUsWvNArJCBZCrqkjKGxI3LXyUn31pvRshLG7tHiTxA8d
	 oZni1q7NImBprVmUOUlx38wEXtKnq7WlDd7sLEQQ/7aEigUun3GOLA1Io39PZ2m9hcEBL
	 aV7s/V/8D3I0CK2rWDjSEY+4/qEJLQ2ZaSH+VTqw5O3bxWRTgDAVdji42GDQpcvwEgvrN
	 lQhutyuwg3D9jn0IIgCHL/TPJ5SJ6ArPKdEh8aZSlCzlS1WmZxSQMoE73c6QaEY97TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2nVfXQS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FA608F3CF
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30FA608F3CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2nVfXQS
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso580634a12.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:47:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793821672; cv=none;
        d=google.com; s=arc-20260327;
        b=RiIWpP/Uajxjp034ILNF5P3wOTsQ2Ix/EToKRAJabgVjv08FSBHVYGVJ8wr4U9VbFJ
         fu/RKU0mFg1c9mz35JVkvGhNsl8+MN5KV0n22IzMYacAf1BNGz/lxDOvNLG0Eb2TT7AS
         INwvM1MDNfMz+oNZ2BEgMLOx43UjVBEXcWcdi+fo6nph+k0n/dfBJMEc2JRoMqQBaxSi
         HMc6yGIxXnKiR9SC2gmcLk35wEIYWUp7HpsuGGgQS94ZSj2bg4JsxLQdX/BN4atx5Ihp
         9b4bV903Ml1lwY2Ay4/SWvftUJ+R8QDxq/xk9eExWP+KS1QoRXqyp8vGP8WZY2m4ksvS
         ypzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jrd32+YJEVParF9gDYjq1VptNJioJAFlM7MtJqO7Iqw=;
        fh=7kmjs9FObO2UHtTZJSngSztZdI+Pe5+FR4hhvIIYS24=;
        b=BcgUO2Lco2HqmUBGyUPIf4VidaZPRGEsHJNAFo+LyaId+0hHFv2D/1yQQKVUzA0LJl
         QDgNuycBZV4wEnMpAzWFg4xl71imze8R/SfW5JAYXGTxGPoN/CKTt6uuMWCHMg2N+lxp
         QmsBA2bQwNo0T6MOOhOUjwR3EM2r6LpcTugLTbpuaRCLutmwirP5lizDJrwwLg4TCIao
         WJ59rmV5ACQ4d+MHMPimUhNzR2xZbXGhAcsySUXlY53cySMdlD06WZSGn6CAXRlwNU20
         yF1sIeGTBc5xAJ4Jzxlk9uikHnRPxaw01l4x0z72Dqk3V7T4jo5LLS11QikT/Kc4xW9Q
         A05w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821672; x=1794426472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jrd32+YJEVParF9gDYjq1VptNJioJAFlM7MtJqO7Iqw=;
        b=P2nVfXQSoEWDSx+ehrVF2CrwruKgd6BRzwSUsBTyRf+Q4jqPVn147nDPJwF+wf6i5n
         PVEVgKQcNUC1G0iClbLZ0uOPeBo5Wvy30G5Q0KY0Cz+zwTTgBTdPW4VsqUQMkRueRNiC
         JgmMB05I2CSg5RqRT+i8WjqqB5MDVcLcv1+28C7/x5vYMqN3Pqjy7JCIJfWvS2NGNAFP
         rGzICRf7g7x/wcJi4A24Hd8tZLxK7IjrH0N9w7djtu//3UtIV045oNmcCosFNmbhLNad
         edesHS1IOw9tK8qO8AwNrAMP4mA2wJi9fWcVRejnsdBewx3aYmdS5hvLS5SJcz+Jx1zr
         GCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821672; x=1794426472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jrd32+YJEVParF9gDYjq1VptNJioJAFlM7MtJqO7Iqw=;
        b=pFGPIHIB7Hw4a9TRI+2eJBIwew5Vu01j4uNXWkTW6dLdwL9tYkEA1YoMtSZwbod8AG
         8gWvDhRmFeEfN3rMJ70SHZ8RJ3ueUioNvxHnjDfgY260D8yNJNEiKkK112AiLHPMzOkJ
         m3ekJfIZhwMWLAt+HKQXyHE8PT+XkRBL3yq1eLa7Rg1XkqrWrlG7N5tkFdc+92zwua3F
         kakMdITp3E+g7ZhTXukrA7xYR+9Bd+AzSkdJouRxRil3NpiyXqulMMQSLbM2GGCQfINB
         uyXbEkFYfMZkCocdKkXr4Qr0XbutniOsnXlNHUJLRH6V36nphPVWBuJFJ/l2f699PPhd
         ro7A==
X-Forwarded-Encrypted: i=1; AKwUvBx/zwHJGNuh9oqSq48gm0QSR1GLYUvceq+UyBRLeRkGhtRBm0QDhFbLrCbVg0O9F6foymi7Dc4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bo+mrcaMvfljE0B5j+oFRBkuWItQMwzm+cgeHuREuDWWg99fH
	iGqJDp9ycL5QfVxDzWCX4876XYqafjwZxP7N/4zV4o20lpCJ5tsFemGfAe30JXpVmBfIwZnmW5G
	TfMuPAhWuyRJpNIpIzKB7ejMEYgd3qppUoU5pncg=
X-Gm-Gg: AYBFou07a0RiSfNxpI42hLeBwYy0i+k7ly4QTWF0vDNuLjoS46Nyn19hz7QM4adqLn/
	xPOr4qND9YcxkcEaS9jcRJFOH10n+MaWXJjk8mqHMhOFMvGzlg5bfBwELWPd62Iw7hUkw+lMVye
	BISSwg5Mmv3HchQm56Nmcd/+2j4IfDbyEz+eT3FmNNax5ZnMDO7E1Woess2shRUBaEaYFu0q8/5
	B08P4SaaO5lnjp6gFHkh2k/s9FKrHMUKqj9gngcaiGVC4jVVFPalxS6HZiSnM83Qm7Ayu3Yp87e
	M0DGWmO7dLS0LEjEw2o/Gyg9gKYFXh0qg/LH6ON6lDe80PdrCIKPVZ4WD9NpfbZbYRNJIwwWa2Z
	IEnIKIns9a1JdYyKT1wNty2SewgfQJj91LbNzAaM7QK5St36sMzZwK68aFZxuZvgwMBhfSH+Cbe
	/QBiDJiY2uNQhUV6M=
X-Received: by 2002:a05:6402:4008:b0:6b4:208d:21f2 with SMTP id
 4fb4d7f45d1cf-6b4d3392226mr12668210a12.2.1793821672207; Wed, 04 Nov 2026
 11:47:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104185536.3631167-1-amir73il@gmail.com>
In-Reply-To: <20261104185536.3631167-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Nov 2026 20:47:40 +0100
X-Gm-Features: AclHuK_IaB2NZ5LjJ5ygkT3wi1DynfRtq14s9J0eq9PWgeIQdcdCkasqWVkNTxI
Message-ID: <CAOQ4uxhi3aM57BrXmM238TO3baeN75JduY4fQ8km8bLOx_SXyQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 2/3] ovl: skip copy up of empty security.capability
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, stable@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 7:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> commit 50912a1715b8a7c614b654011a0db750e372b43e upstream.
>
> ovl_copy_xattr() gives up if it can't read an attribute that
> listxattr() has named.  An empty security.capability, which anybody has
> been able to store on any file for a long time, is such a case: it is
> listed, and getxattr() has nothing to return for it.  A file in a lower
> layer that carries one can't be copied up: it can't be written to,
> renamed or have its mode changed.
>
> There is nothing to copy if there are no data.  Go on with the next
> one.
>
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [amir: treat -EINVAL as no capability too, and do the same in
>  ovl_copy_up_meta_inode_data()]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> [ backport: context: no blank line before the ovl_getxattr_value() call;
>   depends on e6b9117076fb ("ovl: fortify ovl_copy_xattr() against
>   underlying layer modifications") ]

Greg,

Sorry for messing up the send of this series.

This one depends on patch 1/3 from Message-ID
<20261104185356.3631002-1-amir73il@gmail.com>

Thanks,
Amir.

>
>  fs/overlayfs/copy_up.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -47,6 +47,15 @@ static bool ovl_must_copy_xattr(const char *name)
>  static ssize_t ovl_getxattr_value(const struct path *path, char *name,
>                                   char **value, ssize_t *value_size);
>
> +/*
> + * Any user can store an empty security.capability, which fails to read =
with
> + * -EINVAL.  It grants no capability, so treat it as none, like no xattr=
.
> + */
> +static bool ovl_no_fscap(ssize_t err)
> +{
> +       return err =3D=3D -ENODATA || err =3D=3D -EOPNOTSUPP || err =3D=
=3D -EINVAL;
> +}
> +
>  int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, s=
truct dentry *new)
>  {
>         struct dentry *old =3D oldpath->dentry;
> @@ -98,6 +107,10 @@ int ovl_copy_xattr(struct super_block *sb, const stru=
ct path *oldpath, struct de
>                 }
>                 size =3D ovl_getxattr_value(oldpath, name, &value, &value=
_size);
>                 if (size < 0) {
> +                       if (!strcmp(name, XATTR_NAME_CAPS) && ovl_no_fsca=
p(size)) {
> +                               error =3D 0;
> +                               continue;
> +                       }
>                         error =3D size;
>                         break;
>                 }
> @@ -947,9 +960,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_cop=
y_up_ctx *c)
>         if (c->stat.size) {
>                 err =3D cap_size =3D ovl_getxattr_value(&upperpath, XATTR=
_NAME_CAPS,
>                                                     &capability, &cap_siz=
e);
> -               if (cap_size =3D=3D -ENODATA || cap_size =3D=3D -EOPNOTSU=
PP)
> +               if (ovl_no_fscap(cap_size))
>                         cap_size =3D 0;
> -               if (cap_size < 0)
> +               else if (cap_size < 0)
>                         goto out;
>         }
>
> --
> backport
