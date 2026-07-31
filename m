Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D819410D36
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501325; cv=pass; b=Vuz0aZz5XFXMSu3ZWOoWr9YEsc5m8Vtc/E1XZG+F0SPsr6mtNzGjTwcmDInkkGQrbsUX9vRIcD52ShYN80nzWxxvSuKwEYApmFK0cSpcPbgAa+UQUzwQo1pAkxyplFducrRRwNiN4jTvGcjbehh8oKgy3MgO0FOjn9pRVCHEleA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501325; c=relaxed/simple;
	bh=UEXA2jz7/8V+cAKqn+ecsYKqLFIMPeiztSrq0J+wmAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ePKsxAPCnJvce7PR29tCH/Ldu0oFZ236YhbqKdVGzM/5G2yUnJg5ZwQDcw8eRna/SFrzeU0AX5b+U5zRC/asuLWHOw5YUaEQXsY6rzr6FlpYSy0Zq1tKupWh+QRioVrQRKXUZHQgfNcqq0i+aWrP4Inc7VOTKzXbEOnEXuvRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXVkRy3; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXVkRy3"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ab04bbcc8fso540193eaf.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501323; cv=none;
        d=google.com; s=arc-20260327;
        b=O8h6DxNNxuiaHPQbyP7ZEcgECRz/KQymxSX/SyFuYLA1+PZnI9EXCjaGy1QFDTJ4fn
         AZSJENxl0pogAd4mqZIC5Ka5zxSZypnWi7tHcX21bzQ7qahaFqk5+AoCfm04BcUgNnCW
         01cVl6m2oxg/E5Fgt2GuvhxSoyiYefs838Y9x6aK37LBf33IkNDLETZz0e8KYK3pg4R8
         CLl6a8QZxjnSwgYCtrsjzb1yUKcu9SfEfbwn65BLPbxZF2s40Qh+KNeHqW6vm6e20bdg
         m76tKArOJdUq005bdyxsmubxg42bbD1LK9XG5zHVzFBwzrI5yUaQegNOHbKf2lToJIDY
         cH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        fh=5weem6xLFTZRAVaO4AejTHhSNYXHga/Dv/z0Wp5Qu9U=;
        b=mt8E/IN6QdALr+P3sqKHYMUwNItl9a91eF/10feh82725iWmP58YB8Sh1QkOptDhv/
         HVv7gL6MqaDS299g7LOcHRsxxgU/acNC9OlTYguhkFXykPQ2/4Vxuxhc9ral/CsBOX9P
         JuFpRwY+2mTNxsHjk6cwHw3szG/xLjf1d/1OMf4IklLo/6LwgOCpZ+g0gv1Qu/LBYe+w
         HRLH5Ja/yauqdLmlf8uMua02OLXA+3HTb962KYSJKUC8lRXpz4HR703qo0zlD9ZawWy/
         IWiO9CWkX0+igHB9/1PbRO/ABWIVaz2eYx50FHUJBGVB/0ZnJ+B0nhEr+uNb/0QVqMPh
         ZVVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501323; x=1786106123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=REXVkRy3KxPSPr+1PvDbz53nE/VdaLuOmJyFOcwmV9/GnhNCzeZ+LKuWgCI1kLGTzz
         sA8noSXGop1VRy5mJv/qmiWYoURK89NTQQLd3e8h7t5tyCNKWx9c9b4aMDqIYPu7Ov6j
         w0PXfFUz70YrS2zcA6g05R8Ck+Pllf97q9vn+wbtNLoq48MOhER6RrH62c9Go9fA2Hc9
         IHdp/Kkxh2dsQYLJS7R5ebo3N8cABHgcasxljvAgQD3MMjQgxb19FSEkSnsoXoV4R+ql
         MJu/vwTHzM7ho03qU1J1SCjmcXrtJQ3tXsejZdwt9Jm7K5gw5nQFvzxaykrZr2VZ5sy0
         rnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501323; x=1786106123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=U15GddbD7QMht2H9xvxUJk8viRr3GhCPWdKkXZIIzv4kqAzTHwR/ULgSvJHh75GVVA
         lC2edC7+QPfreNauS5MLU93xcj5kkE+ZA5Ms3t5on21ZiJHsQ8aG4Fmu8dMSsd+k/0KA
         lC9vWz+QpENgLY3wxNWJe+EyNZIdUzaSWvdN/zfz4suhL5rqHZV6HRm/sjhXJjY3i8B+
         fK0uvVxoizQmMJgaZgzYhqXMPNeLq26gwuGxi8XjJKxBgqWLTqn+4UWsJyEMMZPhXqzc
         91tSmTKol3Z8Wo9e5KLefb7C6sy3zHW1oas8MrdAzq4Sck/lkYhI30zy+dJv+IEEQDSB
         byWA==
X-Forwarded-Encrypted: i=1; AHgh+Rrr2ZEqFBy8VcgiHuAV2M0ofEWlQdntJUZ6StXvhWfNtxtwYTV1/RDBdPJfVYiIYh8xldw42hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrV2lD0z+F6A9Mpsjjsj899TMOpr3G+cAx8d+UZWKc+v80pPiX
	x62I3EbnKNWOzyVNfpyrhaVum2ccdavyvSpA87K2TX6lD20YhrpTl8M6TyLLZnoPSajLlWgn1hu
	rjFE+Xh4cvQ5AX2XbNDR3uu4D4xpQJDY=
X-Gm-Gg: AR+sD106UtCMGZjcwnJN55tPbgge9R4+xd9RYP3cKp3CkQObOjw8RZmFacYC2hb80KE
	NCRxQ9FPEXrU9fPoN/ZB2BlCDLVsmwKr4TkbbJ3QlG6jmG2FpBZdLUaia5UruYhVL31upwr+yUo
	Aq7+JXikJhgv2FkiCLy++ep/PjPG14F9J25V8XxRf84XWljNeHMceSCNfX6ctf/VQsVT9v8GwSy
	i1LsixpdH4EBDV461x/kpYfCn49039CyX+epWr66D5677Fgi/4m8V/QuXYRKxz9IIpIJEw2Hdvi
	+PKZEeBNLEs3uINk1CVcnEyUH/EItEQDRyJ6rAENvQrE
X-Received: by 2002:a05:6820:c0c9:20b0:6aa:e252:dc59 with SMTP id
 006d021491bc7-6ae37cf9c54mr1615552eaf.5.1785501323220; Fri, 31 Jul 2026
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com> <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 08:35:11 -0400
X-Gm-Features: AUfX_mwlKgyb6AEn20yiXH-27f3TnQmpcyFREg2qUfV_pjvNieyaRo-vjnWDeh8
Message-ID: <CAEjxPJ5PPyM+fkMnLj+FATHtoyYg4TK+tthGpudWnq52GSF6MA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Just re-affirming my Ack since the patch did change slightly.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
>
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.co=
m/
>
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..18dd28b2bb13 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2974,6 +2974,10 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> +       if (!selinux_initialized() ||
> +           !(sbsec->flags & SBLABEL_MNT))
> +               return -EOPNOTSUPP;
> +
>         newsid =3D crsec->create_sid;
>         newsclass =3D inode_mode_to_security_class(inode->i_mode);
>         rc =3D selinux_determine_inode_label(crsec, dir, qstr, newsclass,=
 &newsid);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>                 isec->initialized =3D LABEL_INITIALIZED;
>         }
>
> -       if (!selinux_initialized() ||
> -           !(sbsec->flags & SBLABEL_MNT))
> -               return -EOPNOTSUPP;
> -
>         xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         if (xattr) {
>                 rc =3D security_sid_to_context_force(newsid,
> --
> 2.55.0.508.g3f0d502094-goog
>
