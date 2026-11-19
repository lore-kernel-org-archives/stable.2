Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049568;
	b=oLin4wBXape0Q12Ttaau0L/x1I3tptMgtv4ZXZ643Utul2a+QnnB8E2ghWhSK1vJfKo0
	 ERIxBThGTu1rQ44xtkpPOVTo/AqwNq9h/LazLixxiaadnzxw0brOWrWoYY3w1i4gYjHX5
	 D2CzJcAoyO9DY/v8FNGAHNPTawMIqos+HLkiBCY/Q9XtDPfYXFabrWG02GhrG4ABrK5YK
	 U0DxmGo9wGdcFu5qINy7QPdT1WxFjJ3JMd6LmWY1SgEqLhLcC2QZUYx/7XT7Lh6HkpCKQ
	 MZe0WV3kc8/H3cryirjPhZDIkMmFvEnkdZMnmpksAqxha02xFij/TWGCZfgHdmrf6Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049568;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=3fqxcRA59nGG2GFaHTxSrJALKfPpvhTXvqIt6jzDVGQ=;
	b=leODru0ss2MxeKG0kRcLCijoLn/6kK63mrVHfBA64uHb+aOD/XcdK05+2CGYaY4EdJDs
	 i72I32R7dhrrHi4xAjFq/M7kuXMbbyqU+06r65l5yvedbWdXVV7xfE7YhuhygynplFXV1
	 HTne8MSZTdECuL2BeD99gS4hoOpQ8+2ATOvGYzd8gf6G8wE9Gp/3Qsj9OnQwIIqlX1yMJ
	 UY17xtLFqfq8j2QoPw4OMkP4h2nOQejTdySRyoJxxewYfvZLI9BzJMtFBTGBGs4naMxZC
	 JN/KsrMERfs12Ox3dwpdzmFz+qJB8hjlZlq/61XcJEMIbP3U5hwh8HoJLT+95GQwttw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbxgtOSe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCE606A33E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbxgtOSe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1FF1F000C7
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795049568;
	bh=3fqxcRA59nGG2GFaHTxSrJALKfPpvhTXvqIt6jzDVGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AbxgtOSe8H5zVOQqseLvd6hauju7xcjsA9MMWd1u1ANcmQoP9da5w7EeEBSjNDxfy
	 X+mOhSJUDZtbGbRgHG+dDvdVlubim5OC5GPCWX0n+yLdoeFZB75/NaHp7zS5uZ5UF7
	 sPPn0DLO9zBorpMAF9Tsn6+iyETmZ3ZS03AxEBKiCJx0trJVxavfjAwh411/MuaW1I
	 Yy5xvqODqAXf9NiPci/wn3qS1bvDAVMpoPH7eASO73+zYWPG3JOKMsxkZQjRXNFcIP
	 96HVRyUfJL3239fBf7qj9YrSH3FST1vsf4K/Y6tex0/9gjhxoU07iwqwCvlThs64QN
	 J0+1Q1DbCGCOQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50933bdf4bso104802266b.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:52:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFE95IOTq0dLE7I3jWVUHfGxa2vg9a1WzacBtjFKznyhmU2IyJfvyfYq1IorisPlX0nnTr2dTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rQaUJ619MrBO6DImnMpNAIuspsvAQ62z0sjIG8094IZhKZVD6
	H5h6td5WC35abBditXgKRvSHfJL34HvEDujE3S7vnTTm6oRLd/uLkCTUyiK6LLo0CvN16fIg4aj
	YaE9Ay64tQoJyPuUkqjUEJpl5ESlLUZA=
X-Received: by 2002:a17:906:7306:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c512b4373d1mr21641066b.1.1795049566753; Wed, 18 Nov 2026
 16:52:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118155521.70611-1-icb@fastmail.org>
In-Reply-To: <20261118155521.70611-1-icb@fastmail.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Nov 2026 09:52:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=4OfQ6HESrMFhuffHANTWDjYyrt9VDQpBFdV8i4Mi4w@mail.gmail.com>
X-Gm-Features: AclHuK9fpIXSg-K6iwftVqFnqQORnobjsfqgoT_nBWRu89S49TH0_lVl20XZ0Hw
Message-ID: <CAKYAXd9=4OfQ6HESrMFhuffHANTWDjYyrt9VDQpBFdV8i4Mi4w@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fail SET_INFO when the security descriptor cannot
 be stored
To: Ian Bridges <icb@fastmail.org>
Cc: senozhatsky@chromium.org, tom@talpey.com, chenxiaosong@chenxiaosong.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
> index a87c22fa9a6e..3770dda2b3ed 100644
> --- a/fs/smb/server/smbacl.c
> +++ b/fs/smb/server/smbacl.c
> @@ -1984,7 +1984,14 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
>         if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
>                 /* Update WinACL in xattr */
>                 ksmbd_vfs_remove_sd_xattrs(idmap, path);
> -               ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
> +               rc = ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
> +               /*
> +                * The CREATE context (type_check) stays best effort because
> +                * the file exists already. A filesystem without the xattr is
> +                * not an error either.
> +                */
> +               if (type_check || rc == -EOPNOTSUPP)
> +                       rc = 0;
-ENOMEM and -E2BIG fall through to STATUS_INVALID_INFO_CLASS. Please
map -ENOMEM to STATUS_INSUFFICIENT_RESOURCES and assign an appropriate
status to -E2BIG.

Thanks.
