Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B93EDE42
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779329; cv=pass; b=XPD2FFZuVh88OePpTjXQlhqrEBqsLOplf8AMoqzlpDaqN6bpfa6t1C2HKyLYVLB2vCbR8hW1mPcpM7rnALWNYsWEccDb1z08SQpc4ipgmg1+6GY3ZgHR11zcbwOsKxC2/Bs+R8JmZG/jJwwuDd7nSTDhrgiabrqt9RaSE7yUJb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779329; c=relaxed/simple;
	bh=BR+eUj/ALV0eoXQmo7i7n34XaH7aoKJnU1bS8FGvxoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux3olhgzX3F+aMcWyVV+RcbOTIytXNLpoW3DJLFKDSQPvbbE0yb2u2haVTqSIIqwVtGdu92vIMdURE2eoJJHOO5rhUIMiIo4kUlezniOm3uo3SA3rpKnrXsGc2zN9FzZZKGrpM4EUUkS6Q4yA54FCzcQmun1S91b8KmDTM8iLHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns6QrfWI; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns6QrfWI"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so4749080a12.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 04:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779326; cv=none;
        d=google.com; s=arc-20260327;
        b=rzlve8ZKLJAsMHJMY4SV3X83/B2u43QwvjPQKMON9tnfLYVW6QNEyf0nMJCYXni4Z2
         A31eFaRFJ+nPCVNXDsUrvi7RZdUm95QeMhxOrqR/+XcshI+QAVMWhX2Wa1c0Naf6JAH1
         ldKwtTGSsTr9S/GOYMQGTHocPqXpUxMP+gCHsms5yd8BbF3Ww5FJkwWPcNS/FuluINkp
         xXJ2G51mYf8Ti+8ss3rRHoOia9NLbvF5KisSWdeFRBimCIr8WclYQsCyOPv4yT8bBH3p
         Dd0Hajiua8cVi2nU4bZibIdI7ouhntgLgsVwu+bdPy4YL9O981CStAuplklBebA2hSOQ
         stOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        fh=/6atUCKOFXQtYGp8Ctm2fRmqMB1tiBZzFQ2sCVfdrrA=;
        b=c8g9xYVmbjYf49Xeuzsc5OtwtWvPdz4kWM0sAzdtsBGGY4i9tCzv9yyO0ue58oSY+1
         yeImzjP/Ndyp0X8YUSZsqXvr8ZlztejLWvuqF0FJNiwvZp4V3nu9JLZi/VcMqS4GsinH
         bvpx7ewhYI5V/CiI3T+2lhK+7kalbjTXZRFCNovLs5oXiOY5IGYEw5PhFiRDK48RiEz3
         7LOlDt6Nrx35Hikm65dux61/pQnMkH2Hi6SmVIhte8oZYqse0X8o5iV/kxSxHK22Rzdb
         cIIOgxIt497sqDXiFS9p6fo6wQvdO2W/12FnMhKLklvUQxQi4t20xMq0c9TVxL4giMwS
         uwQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779326; x=1789384126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        b=ns6QrfWIKW9xEXdIi6P1CN3CT+NNAsSJ9onkLx8xKYjt19n13DMRg8Di+9fwQ3B7MH
         lqPFgECZcK3Aul2YUiG9mGBeil25UMpdZMDgAxxIaHq1QpJVw5OwAn1+y4pmzyyV7VsU
         NsTQsDJtsFaASff63T/a6ZiAqJt1KsUuINB6JWHgpV0OH6qKtj+p+k31AZrCitQ++Xu2
         u3KRZ6E4/x9FkRsACCvr408ynx35VySyrMOhOZ4gQvk4G/W55W+NZORr3swGG6vgniT7
         kdAxoQF814mg8uY8z9d7ojoNSNCe7DHu3C75BmL84C9mb82+xC7SzSd89hSAOmPQyQfT
         E//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779326; x=1789384126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        b=tJT+kE/4/2bp//E2mGDLWnVOHGSZHqKEiQqblJ13VuiiQ8G5ZuM4oswU5mGF6uU6t6
         ylmk6y4KUpvLEtiCB/J75axcKleg2aU3T4jR1bDbggg6zjUsVVOb4vdYeIVDqz9mj9WZ
         6F+nucrse7j4USkzMOniA7SJNMb2H6OoUZEpEe4PE8BN2YhqSHW1J9+F62rLsgYK3+IC
         +FjidQA3oE1jxbIOk5gqKNvyIzFedLT0oumg3gWLo2OojpCZ0YgsTYYLg9bSDmXOlUKq
         aJ3o1aGwGWax3st+XsUkbg33QlfcsGy2G5zY+2N0FbqKO3jse3oQ4kHG0V6eQIdTnMkD
         FZyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOJ+A9KNXRX9Xtnf24Emna8wA0cDRl71nTiabs/xQfgBRXliFk0+EQ18BaHrtm3jc78NMKED0=@vger.kernel.org
X-Gm-Message-State: AFuF++l+RQoNV9VztHmXQJoXrNTDS/xs5gFBd5Dj3mgFq4ufbh2qnc9N
	RKf1A/JZ6KZ5Ql1cBaJuHXgo8ljBpkHy8pKyIeEcxf7HncwDKjZz2ErE4Sq1+tZyvvUtddunLyC
	qqkWZ9jQdkP2w3+7hhE2eR0hu2fKLvXU=
X-Gm-Gg: AYBFou1HgwejfQDwsIjwFC/HAVkW+fXlnXdwrJ7lGW0/RFQ9+04Xvwbo7cF3ZYwYP6h
	Xnomps2mUNSlL5qrSZezw8P40PpK/QxHduRoqiTypSFaNhfYi+RXNka/xYIciSjXLPejUK0eepc
	XymEVVhOP5KupjhD0WErqpf1lKKSHwWb3tS5nEj43HenyIL/UC5HCypfkZS2XlV9yPkAuymndUa
	71KZlzqsOyWSDt/b+P10nMvhazIh7k5PzvdE0IN+jkeL1oO9KOTq03V5FI9nrkDIJ1GKfbjRWIU
	0dnelAsdZYR+6M2ROCMopKHd7TRAyUeWGV32u4OcZr2Iq5P7YOIjatni
X-Received: by 2002:a05:6402:44c4:b0:6a5:f814:2278 with SMTP id
 4fb4d7f45d1cf-6a7e8d25c02mr5757746a12.2.1788779325248; Mon, 07 Sep 2026
 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907045517.1347518-1-cui.tao@linux.dev> <73236c69-bd81-45e1-8195-59775a34475a@linux.dev>
In-Reply-To: <73236c69-bd81-45e1-8195-59775a34475a@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Sep 2026 13:08:33 +0200
X-Gm-Features: AcwNN1WRkYAEFvO02MfgvO2cIVdjx8ikA3HzbSdaJ9Rlgd-Ol6Vhuk6uNLapsKs
Message-ID: <CAOQ4uxj5thxY2sMkJUO__qWxVX5AdKeb+e1zoHcYfQBPyfqvhg@mail.gmail.com>
Subject: Re: [PATCH] ovl: clean up dir on casefold mismatch
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, andrealmeid@igalia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:38=E2=80=AFAM Tao Cui <cui.tao@linux.dev> wrote:
>
>
>
> =E5=9C=A8 2026/9/7 12:55, Tao Cui =E5=86=99=E9=81=93:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > In ovl_create_real(), the S_IFDIR case checks after a successful
> > ovl_do_mkdir() that the new directory inherited the expected casefold
> > flag.  On mismatch, err is set to -EINVAL but the directory that was
> > just created in the workdir or in the upper layer is left behind.
> >
> > The mismatch is reachable: ofs->casefold is fixed at mount time, but
> > the casefold flag of the index dir can diverge.

Hi Tao,

This is a case of:

Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock.

I am not sympathetic to adding code to gracefully cleanup after
this error.

Assuming that you are utilizing LLM to help you with writing overlayfs
patches please refer LLM to this commandment.

Thanks,
Amir.

> > With index=3Don, a
> > pre-existing "index" directory with +F is accepted at mount, and every
> > temp mkdir for an index entry inside it fails the check and leaks one
> > directory.  Measured on an ext4 casefold upper: 100 directory renames
> > left 100 "#nnnn" entries in the index dir, one per failed mkdir,
> > growing without bound.
> >
> > Clean up the created directory with ovl_cleanup_locked() before
> > returning the error.  All callers of ovl_create_real() arrive with the
> > parent inode locked (via start_creating()), so the locked variant must
> > be used; ovl_cleanup() would deadlock on inode_lock().
> >
> > Fixes: dfc7da402ccc9 ("ovl: Check for casefold consistency when creatin=
g new dentries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  fs/overlayfs/dir.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 7beb0af26498..4e451bbd8f97 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -188,6 +188,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
> >                       if (!err && ofs->casefold !=3D ovl_dentry_casefol=
ded(newdentry)) {
> >                               pr_warn_ratelimited("wrong inherited case=
fold (%pd2)\n",
> >                                                   newdentry);
> > +                             ovl_cleanup_locked(ofs, dir, newdentry);
> >                               err =3D -EINVAL;
> >                       }
> >                       break;
>
> Sashiko pointed out that the casefold check can crash on a negative
> dentry (https://sashiko.dev/#/patchset/20260907045517.1347518-1-cui.tao%4=
0linux.dev):
>
> ovl_dentry_casefolded() evaluates IS_CASEFOLDED(d_inode()), which is a
> plain dereference, so a negative dentry would crash before we even get
> to the WARN_ON(!newdentry->d_inode) check below.  And if it somehow
> survived that, ovl_cleanup_locked() would rmdir a negative dentry.
>
> The NULL deref itself is pre-existing (dfc7da402ccc9), but the cleanup
> call makes it worse, so I'll fix the ordering in v2:
>
> +                       if (!err && d_is_positive(newdentry) &&
> +                           ofs->casefold !=3D ovl_dentry_casefolded(newd=
entry)) {
>
> Negative dentries stay on the existing WARN_ON path.
>
>
>
