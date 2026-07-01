Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569723612F6
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870960; cv=none; b=MKQue8hxua7isO58E41MdrQEfn0oyM0gvL4lSyJyagOJfsclUc03cu7FG1l2DbhMB8Eo/LbJdNLV1IkwvGIrgC2X48nl2MNGYrM0M2JPmh59V2LnkNfOXhQMZdXcZd5z81cw7z4wLVl+qxJ2K/91DkhD+PVRdM22ETvyh5DUk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870960; c=relaxed/simple;
	bh=4mIi4p0t8FiEl76o5sTJP13tmIjADiLco8oz+Ebzfwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0mQrmgiUBwN82PSJNB6G0gW3TuYkQlA5AwXzRsCSo5Qvc/ltDibqRoge2sGLIssYtqmBcmPNrq4TKKaI9/dwtOgKpMgm0yfpanu1ckrcAKW4h4XWh+2PLTrGZACiCaOzum6tjfeQ0zhtOdNTN8mffWchyEJ4PhmNR/6hPkw3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Ps2yTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Ps2yTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3ED1F00A3A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870959;
	bh=4Y7Mu3qIX1rzeTFFd6h7gzcdLQmTsS/ys3zPwHxqqV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L5Ps2yTQSTVdmSsqrMHXVjUPVhpC4DPUj7MkuqSiNaBh6/6TugMS/qy5Xqp/+zIeW
	 oNx9c6ITW5piybQ940qMOsulbKO9o8EIyvfeq0SyAp57ftyVz1NGjgOkTmEpxmXMV0
	 n3x3Icy5GPGrRcwoWpWXYR76XA43MsfNGqtkmb3fRwUX6262f1WMqsyod5b4uZ3k/Q
	 dxCem4YXO/hqeZmTBXDxembnm6gyRil9XQhFOAMbbZALT5NsphWjEte+mhnuAxzXoS
	 NLUco0NePRFEsVOjxa1hZQDTX2jjnk72DmCN+6zNyRb2eY2gjSiEa5OJPexKqOGfRV
	 gM8HFccfsCdWg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so224866a12.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqd3S+DR73qRrg7wDkWhxBq6SDCKCGaPDFo3O4RXx6AZpRDpzWFJD7Pr5clUJvKxQbRwSS0is8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgX9pLzALGEIXaP/lqu4HbTvJFc/rrIT+EUS8dT+Ssu543Kns
	oPLenU8V7hHg37973CDwmNnXPktJ8a24y+qdoBqWcqwPb4Ru9ITHsJPk9y4tG2MHf/6rd1qklaq
	9BX0BZcyOVHB/QxABNVinGQpm2MUjWjE=
X-Received: by 2002:a17:906:fd86:b0:c11:f5dc:22b with SMTP id
 a640c23a62f3a-c128716a47fmr275124866b.14.1782870957804; Tue, 30 Jun 2026
 18:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630065016.48259-1-zenghongling@kylinos.cn>
In-Reply-To: <20260630065016.48259-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 10:55:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-hj98HnPfpA06dB=ZfLi91SBXf0XT2S-vhr2UdMq6rpQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfua2ukTvLahoyDc_ECtqT1NAUTYSrwibh3ueXHU75Pcv1gIhwjxTgKQfg
Message-ID: <CAKYAXd-hj98HnPfpA06dB=ZfLi91SBXf0XT2S-vhr2UdMq6rpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 9c1c36acfad2..e959387135b5 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -233,10 +233,18 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>                 d_add(dent, NULL);
>                 ntfs_debug("Done.");
>                 return NULL;
This patch seems to be written for the 7.1 kernel. Could you please
create a patch on 7.2-rc1?
> +       } else {
else { } is not needed. and let's move the assignment long err =
MREF_ERR(mref); to the top of the block and reuse err instead of using
MREF_ERR(mref).

Thanks.
> +               long err = MREF_ERR(mref);
> +
> +               if (err < 0 && err >= -MAX_ERRNO) {
> +                       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
> +                               err);
> +                       return ERR_PTR(err);
> +               }
> +               ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid error code %li, treating as disk corruption.",
> +                       err);
> +               return ERR_PTR(-EIO);
>         }
> -       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
> -                       -MREF_ERR(mref));
> -       return ERR_PTR(MREF_ERR(mref));
>  handle_name:
>         {
>                 struct mft_record *m;
> --
> 2.25.1
>
