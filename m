Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793864001;
	b=c08JsrFSdiehiWGY4yF3mNufoWpXyyerzc6k5AlM1xCFKh4PB7JvgdYSUqORkQ+I/TMW
	 hmwhsI4Md5dWf0pr1Ti8vCEFWghchMsX58JIS9Hi+4uFwNUBQ3F/AAuo+eMrIy+2sSLNH
	 oRUQun+nIvphyycey0xXu74BLCvofCOEqQuCjsbLSfdyw8aWaykRBtuK4AWOvHVv4UBU4
	 SXgS2lab5YCfulN495cqZO8bdDWwGJnbXjVk5oYuyPwRGAV3EoWOt6UPq9Mqf586cW5o+
	 +Po2pG4JIWFmI9Ar4XjuAx4FGgWlQOGq53NVeBlb3KIu0b59e5t3sv+RMMcpxQTjnvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=G/6SOpOaKmTK+xPgZqpBvFHUtGiL3IE9mNXK8U+sCqk=;
	b=DAY4z0VJK3dhwYZr/0PnZfQRCHaJF9ESzVFPKOQPJI1cGYSSNnM/uaJ948JsT9KOXflw
	 Dv9/Hh264vW+iIp4rJcuQKPjYl4HHfH9Iy60hJijzECGgBr9yrsfeFh2rMUwJLV5j46Xi
	 8pCdIjqSjD1aUs944YIkENhf5rhQ5syl4EHtPJMI/M6aIDvAYiLshA0+QzlxTkJbk6DLX
	 nGb9z4PTLHY4PerpaMxsrZLaKh7jiYF2WDZar2RPa3FmlQ2r7UqwCMmLKsQBdN9e1P9ad
	 yn1cFfD2SUm9mAXqJ1Qeg66EulTucoiVH2rVJQelkevVxhRN4GiTWuLjOuyduxQVdLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HH96ZB5e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C39606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C39606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HH96ZB5e
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c49c32650adso79549666b.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793864000; cv=none;
        d=google.com; s=arc-20260327;
        b=ovAI/RPF/bF9tU92zObcwnFk357waBYgOn9R9Mq4roe4h03rkhQBtoQ6oNIgfZmvfz
         sxXc1ym4FFqGFdZIxSa109Bi3VWohwmTcyufd17lBqZppQN/VHZI7cP2/uKVUbBtIRjI
         jHoCzUaKu8G/NIWRCHP3qQJyEh2edsf8zCx8zmwcHXYokL/n7YPMevo7gdsfpwRqryOA
         BXnvpea1zlFg+Sn/F+9yqffUcZNL0enG6x7nCEMBVV2DjdjDyVTMpM9LPf/WdfM//L8K
         C8w6wHzww9sPEgrAGpb7fkRarzYRg9u99/t3AFWJJPj0cd+i90b6W6n+PxWecVKN4vJI
         xOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/6SOpOaKmTK+xPgZqpBvFHUtGiL3IE9mNXK8U+sCqk=;
        fh=FXLp4gEbFzNTgLxBa0xKceWB7WxLtrTkEo5nCUIQzpo=;
        b=pH0oxMjntzoKcU+qc/sJulQ2i1R8tsQnRh5xf/oEf5isooYzIT9a6M30Z0gROLr7bH
         00gDL3XuN/FMAENCDGmJBtYXM+/jiRhJV2sSrliGIqyyPaz53uCmxQESOfYGYQGkBILN
         TqG7cm2mRVfX0BWyHmpEpHg9OVM83tur8b5g9wKPOsj8tL0DfDlm0j7daBm332DOs6zY
         eiSQXkUmbnRsbE60ZBAbTUQNTJ/0oVOsXzHMTPVSL2VsyZXYmXA4skH+aIiuMWz5J6tG
         xEDZ3QngqIjOMEAedB22KgD0J4NxA//LAmnDvkMqYvJrKkRORHae3GW1986H4+F88PoC
         YuTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864000; x=1794468800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/6SOpOaKmTK+xPgZqpBvFHUtGiL3IE9mNXK8U+sCqk=;
        b=HH96ZB5eJ/7/WxluMjRdyXmlbMSF3KUm54kKE2PdtZVAkVfUTlcW7l5NYdrJxombir
         SSCXkZAuLrjPvWdXxPKRFgyktXLs+QNTHmST2PB4AzEAzVH5YZFk4SFQS+eKqLJ709iB
         7DknnfNkhtrj5+YQfin5wPdYzbqA4C+2rFYAhVbVF36zr1dA0Ylm05syr7gpmfTvH35T
         NNTYNJ3BuwUQDrm6nB9DxFDoCq4wOEvaNcPXO/Y50S2WL/LXxMT5JXjP5ervhnWN2Dso
         Pa6aXRML7aHxFVIctJ5lN8IMt2tPywGdJfHoozA4VhIl0sr3mXdc6FmDWbGASVoagpKd
         Z5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864000; x=1794468800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/6SOpOaKmTK+xPgZqpBvFHUtGiL3IE9mNXK8U+sCqk=;
        b=xPtulHvFgYNAbIl0pCYxpEo0+QRohoJTZCjQFusUysneZZFdjf+IHDDk5g7DJ+dx7g
         /RQHLflCAbdO8I7NMcz+f+RJKIAdJXNUtO/71rbKZes80QnNMrBZ1jNwDNqWsUtGou3P
         mtWJYuUpG8OTJaxCHi+d8j+G1pw5TRm4WMcma+8Pf+OtFhwhmM490naYCW9kVohMKFNx
         o39VjY5Zg0f/ZGuhizjetGtrUcxYOpVocmS69WohlBXK/wjxtWH9CHW4nfc7E//fC/g7
         zuDTwc3cr+2JUdFaOSkzXZ/B5td+Ya7y66a3iRrtbjKFqApOiN3zW9OAidgQNXychqFM
         b4tA==
X-Gm-Message-State: APuU4Z+JEYw653EUhTmj3e+WQKhPVcCNjfbdoMKNlD1PuZJOXPW9dCzX
	zug1EBw9tMkphdWRmMfAqyjW5xjzrsiiSlXpnKI9xlXRnomJPSeYyFWJHJN2z9a436OCLR4u/8z
	vrpXgtX0arNfSfnxFb4B8UJAtlqcNeys=
X-Gm-Gg: AYBFou2BgPZ8BfwRtGQkj6VO9MxR52gbRXQe0SVLyDpf2oaSAJgc8SueY9Lo/ugv1HN
	Dsw+zMaeRys7sx7/O5JnCedUiWds4RXX+nvQjat3yY2Xchw4RB6y+Gcyxe1c5XVpBXs2ryIgt6j
	tWP1xGx6utcMLzorecf6tih1AHHejJahBdK1AgUxw1xoiAoWNzIWv68yHUVuzlytpPAlckzpays
	mgfC68dvcKadBbt4ZrlB+ij9K3/hwL5pLe7eVvzML9JD8Clk66D9rBY3Y2pP1eCP6qRui972jh8
	23duYIqIpo8+XgD4ocYDi/nFuQ1X3tR2yiajfr88AxgKmhYnEPJg9ZXFlAyw+cPpP2Nn8Rphm1m
	4YzrvVt5sLziyia4bbtxi/zHn89pWck6megDFMUFC2WHF6VzrzNY4zgVy6EwbTy2fPCuSce8aOh
	QEXM086LcUNRCN+ls=
X-Received: by 2002:a17:906:9f8a:b0:c3e:4f41:e2a6 with SMTP id
 a640c23a62f3a-c4ca7974a58mr1597798766b.6.1793863999391; Wed, 04 Nov 2026
 23:33:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110415-dragster-unsubtly-6084@gregkh> <20261105034403.1239777-1-sashal@kernel.org>
In-Reply-To: <20261105034403.1239777-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Nov 2026 08:33:07 +0100
X-Gm-Features: AclHuK-17RMQacHZO-PUfizhRhOSelg6xXj2cB9xR0lXbr_5hOTdlwaURzf42jc
Message-ID: <CAOQ4uxhK6nfoPiqmxeXLZ_bPi_e04k35JwCjzMUvWH-PkfMmCQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] ovl: take a snapshot of the name for copy up
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:44=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Chris Mason <mason@kernel.org>
>
> [ Upstream commit 65bf000962a33ec9d2488e4e1797b6cf630abcbb ]
>
> The copy up of a directory reads a freed dentry name when a lookup
> moves the directory at the same time.
>
> A pointer to the name of a dentry is only valid while something stops
> a move of the dentry. ovl_do_copy_up() keeps a plain copy of
> c->dentry->d_name in c->destname, and ovl_copy_up_start() only keeps
> ovl_rename() away. When a lookup finds the same directory under another
> name after a change to the lower layer, d_splice_alias() moves the
> dentry and frees its external name.
>
> With a delay in ovl_do_copy_up(), a chmod of a lower-only directory with
> a 60 byte name raced with a rename of that directory in the lower layer
> and a stat of the new name, and KASAN reported a use-after-free in
> lookup_noperm_common().
>
> Fix this by using take_dentry_name_snapshot() for c->destname.
>
> Fixes: 829c28be9bb9 ("ovl: use d_splice_alias() in place of d_add() in lo=
okup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> [ sashal: moved destination-name initialization from ovl_copy_up_one() in=
to ovl_do_copy_up() to accommodate the older code layout ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is the same change as the one I asked Greg to apply to 6.6 and 6.1

https://lore.kernel.org/stable/20261104184559.3630145-1-amir73il@gmail.com/

Can take whichever to 6.1

Sorry for not following protocol.

Thanks,
Amir.

> ---
>  fs/overlayfs/copy_up.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 0f0c02121936e..a873bf4bac814 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -804,6 +804,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
>  {
>         int err;
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> +       struct name_snapshot name;
>         bool to_index =3D false;
>
>         /*
> @@ -832,13 +833,23 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c=
)
>                 /* Disconnected dentry must be copied up to index dir */
>                 return -EIO;
>         } else {
> +               /*
> +                * ovl_copy_up_start() keeps ovl_rename() away from c->de=
ntry,
> +                * because ovl_rename() calls ovl_copy_up() on source and=
 target
> +                * dentry.  It does not stop d_splice_alias() from moving=
 a
> +                * directory that a lookup found under another name after=
 a
> +                * change to the lower layer.  That move frees an externa=
l name,
> +                * so take a snapshot.
> +                */
> +               take_dentry_name_snapshot(&name, c->dentry);
> +               c->destname =3D name.name;
>                 /*
>                  * Mark parent "impure" because it may now contain non-pu=
re
>                  * upper
>                  */
>                 err =3D ovl_set_impure(c->parent, c->destdir);
>                 if (err)
> -                       return err;
> +                       goto out;
>         }
>
>         /* Should we copyup with O_TMPFILE or with workdir? */
> @@ -870,6 +881,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
>  out:
>         if (to_index)
>                 kfree(c->destname.name);
> +       else
> +               release_dentry_name_snapshot(&name);
>         return err;
>  }
>
> @@ -1005,7 +1018,6 @@ static int ovl_copy_up_one(struct dentry *parent, s=
truct dentry *dentry,
>         if (parent) {
>                 ovl_path_upper(parent, &parentpath);
>                 ctx.destdir =3D parentpath.dentry;
> -               ctx.destname =3D dentry->d_name;
>
>                 err =3D vfs_getattr(&parentpath, &ctx.pstat,
>                                   STATX_ATIME | STATX_MTIME,
> --
> 2.53.0
>
