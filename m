Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32539448F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127173; cv=none; b=JRkJ0985lThIlQxzIPaxFO9uGhZ/Xt1xF5T4ypHlsruiLU5RS6098bNxuXYioYkISGLjeaq9qAy07Vq3tyILQ+H6fm5LHXjj1aDDTPc8w3QbunWfBo2npxRIHdbT1Jy/j1Md2rv5RNbQEn8XtJUngHMJXoTt8zq7ZAyNOz+jVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127173; c=relaxed/simple;
	bh=6639rFu/tABAbZuWi9d8hzmMJgdgeHqSgkh1Oo5sc18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG0gN3aaxIUBjdnQVB+KrHp9IOxKncnMCylZc3AKYQ6xcDK/au/OHrnr6kFJwp3sZiTT83lIaiutq3TkrBAiuPPZNM9U9I+xUhc+YiA1/UkjfFS/8fb1FUHqsTicdYULNrk/eh97mX11wMoi6Q/5J64ULunhJ/T6yT0gIbLzsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcvskxYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcvskxYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B71F00A3D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784127172;
	bh=6639rFu/tABAbZuWi9d8hzmMJgdgeHqSgkh1Oo5sc18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lcvskxYPn2RDnORgIZJ5C4xPoKrQp2KtLWLpWsluQYtSHiBqnXSJwhM44UtjwNR7G
	 nMb167XGLIInq15lkOetrbhTVICkTKDpAqEOVU9QkONZd4pSU/aAfYe0NzdNlQLzse
	 mHiZrGVS77x7/qD5lvecg2Z+ghuXXmRrWmwYo9iZyf+G/pDCULysllRyBkQjx9rtau
	 o7wZf62qySUmj7nv/ke+itLhFRfI+mdwMiHlgppWFrk6Ug8FwvJKs8csxQDCupbZOt
	 iLOmS7istnH6MoKZeHFdL2ky+t/1b5/n/mgHRS6JyHZUYi6/S+iD7cU2nAq9xwj2Ez
	 XDjeW6YgMrd9w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so8543956a12.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 07:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqhbXi4ydWMzAFDeDT8JFIDPo4Xos8FZX824YRgYqsdECwO1WjhQqUvWTNH9O1MlC+CKvGkPUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTHAyhhN4PmARA3bu/6MPHH6Sv1kgO4quPz/gVojFsG0PWbco
	yd468baStzOYLGV/Q53leafGJv83mXwws5noECi1hF6tZH7IxpgXty2IN1LO46whp3SHojjAUQD
	kV9Zjr8L7qsJjRGD3EGZAf+h4FX0MHwQ=
X-Received: by 2002:a17:907:1c04:b0:c16:3074:6593 with SMTP id
 a640c23a62f3a-c166161c08dmr524315666b.12.1784127171196; Wed, 15 Jul 2026
 07:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C449CC7B-A988-4DDC-B3C4-281794E6A410@nozominetworks.com>
In-Reply-To: <C449CC7B-A988-4DDC-B3C4-281794E6A410@nozominetworks.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 15 Jul 2026 23:52:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_jd4WaOMGwTdAHrfKrdSNm-evBaTF=aogAknwPN4jUnA@mail.gmail.com>
X-Gm-Features: AUfX_mzKNfYfkAnmLr-PsLVAWUX0xdUXa5W_j8dZSqUfRnv9jiMc1MMf29bBZNw
Message-ID: <CAKYAXd_jd4WaOMGwTdAHrfKrdSNm-evBaTF=aogAknwPN4jUnA@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs: Fix min_len for compressed/sparse attributes in ntfs_non_resident_attr_value_is_valid()
To: =?UTF-8?Q?Alexandro_Cal=C3=B2?= <alexandro.calo@nozominetworks.com>
Cc: "hyc.lee@gmail.com" <hyc.lee@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:52=E2=80=AFPM Alexandro Cal=C3=B2
<alexandro.calo@nozominetworks.com> wrote:
>
> From: Alexandro Calo <alexandro.calo@nozominetworks.com>
> Date: Tue, 14 Jul 2026 16:13:51 +0200
> Subject: [PATCH] fs/ntfs: Fix min_len for compressed/sparse attributes in=
 ntfs_non_resident_attr_value_is_valid()
>
> Here the attribute validator computes a single min_len =3D 64 (as the end=
 of
> initialized_size) for all non-resident attributes regardless of the flags
> field. This is correct for regular non-resident attributes but for sparse
> or compressed non-resident attributes the fixed header is 8 bytes longer,
> it includes a compressed_size field at bytes 64-71, min_len should be 72.
>
> Since the validator lets a sparse/compressed attr_record be less than the
> correct lenght, caller's accesses to compressed_size
> (e.g., ntfs_read_locked_inode() or ntfs_attr_update_mapping_pairs()) can
> extend past the attribute declared boundary.
> This can cause OOB reads or OOB writes past the MFT record buffer if the
> attribute is positioned near the end of the MFT record.
>
> The compressed_size field is accessed from:
> - ntfs_read_locked_inode()
> - ntfs_read_locked_attr_inode()
> - ntfs_attr_open()
> - ntfs_attr_update_mapping_pairs()
>
> ntfs_attr_make_non_resident() seems to be safe.
>
> Fixing this by raising min_len for sparse/compressed attributes in the
> validator.
>
> The OOB reads and the OOB writes require a crafted filesystem image, whic=
h
> is not in the kernel threat model, anyway, fixing memory errors would be
> nice to keep things secure.
>
> Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
Applied it to #ntfs-next.
Thanks!
