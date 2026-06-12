Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C727FB05
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250208; cv=pass; b=MPBhEn040JngpTZ3tl8FI75sHNr0wMNMRQpki/QIAyn5+4MK8/mEa+YlfSv3Hp/wWws9FdThyE/53q2sbehNuYEaE4zKiG0va3VluzRqLU+d1wY73hI/tN1a2CN5DQT8VxD7JuJoJPy9r8c8frUM7VJC/1aNBqzVKiOMbxLAU/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250208; c=relaxed/simple;
	bh=VrH4UKHRvTmB/2CptIwHtfPA2ScYldlqyYcLfApLtK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIpvLBt5Ziw7e9YRZ3X9uHKkRkWsBZLSku0NvwhYQx0vs0qbJEqx65Sd0x3nWCVDzT95iACqYzszFZ9UFVs/jR0hVz9EmFkj2KaxdnkW81J/mOWXFLpsBMwOJRECkcijIXTQHc/r9kZkdFkJHANLpg4XtvX9rKxvKCNx8OYY1Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShitvveZ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShitvveZ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so1119569a12.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250205; cv=none;
        d=google.com; s=arc-20240605;
        b=N+wB4hVmqssDanz5spfh5M0tulSRTK55YOSyHPx8y1tUpPgZsIwgS39VxNKsU+Kcfv
         /Vf7oP7xfr6UkSYhJHdfV30W3AftGf52jx2nFjs18XQrH3UV8SQDtnMDwbTzReLKU9kG
         EUCg3GMj/w5KvljyVbSnZEvqF9GxujIQav5dMvMqr0HrvcvsQfRNqnxq6n4gfNAI4k4E
         UZ+VWCBEwd9DbgatEEuHsnTNSUaqtzMrDoLFgZHWsakkyLrAvqNdrLcRHs+TcfFc61/J
         K5uE6t3O1ZSmph1ToqyMISkJt23UmhAyulrU6D1w/FZlSsj6hjWVZkoUDfwSzVX0WNxr
         fClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        fh=NtShwJjQeH1p2AdD4Lh4oin6RhoEyez9BdpW/UoCXXc=;
        b=D44f5PzgZygfFum91q2txqqcPWNpBronf6BmC9N6/8+/EmviBIoGANx7Qipgw0gZqS
         eBL3Y9TRNNFRl5yFe3Y//7TShkJL9Boa0hdYujJiluVITAD9lfiTlcoV0Ag3g8annjHe
         W8AGZcHufppPPe/llDWzzCY/7dWu162snoHTrRIjX08NucG7bzAsvEU/qCgn51qdfoKk
         xiiHsxlaTRffB+xN6jFVvopGyom1G5iV0wsXaUavPcuG0bbQbxU0bSFJi0JzDTjZK71e
         XDQJFxCaUJWbkBve3DOtFseMpU7+LTEMwoEkNm+ueJ+n+Vsw/HkTbfpXBS4J7JzjWxEw
         luwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250205; x=1781855005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        b=ShitvveZr6CwxzGJqA27RIoHbV4cCFHslOGbvbzwYxi+TFvfUXTLCLSBQKYR3mGCA/
         CMUug4YwdzgGNTY0LKITZtWwm+CXP4mquA2IC7d5MpaAMF7YkZcfOG02EoW1naHYb339
         Umbi4EyxBNxvKgBu29XFaNCxlcoAslKKc3x5+3+J6OOPXUPdOA2B0+VFXR6OByzTaGeN
         bhb5Y8RCrq3P9IlODJjbm9bPIiGiUYqh/oPgfTPQer5FisQwAEHbPmd0OV15829SXxLH
         Qx39jzLjR+exTPMTmq4MM1JDC8IS5Z/aPjzm2JoQXt7oCvQmlVG9V9qEPiyukb5jJK/B
         5x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250205; x=1781855005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        b=ID8SioyIGrpculVColqc+5TIYzyWni8EA/jc3YxlGGwBZovN533Zzf8NyXRGa3guf4
         gMFYplzpPAZDv3brhlOOVVD3vt5k9bCmTF+ONjwKK26vpZcj4W92aWAnmRohgk8OMZNv
         DfPJMFY84Y9h1xziXuwoDsT75Zpyz0SNu6gYHVwSaUrmAUDUcygm0NJ2b9JGSznr5prY
         ATMjEulvSblLCqCy6wdvgBvyV32Otgim2zN5xTm8XaA+THpTaih6EZICyuGQlINv223T
         wV0DePaW8y3SzNjRMFPd4lnQFvf9k/RZIImwfp7zGgfeHxa22Ti3qBYA6FqsCV6gQtYQ
         XkBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5ZtrWj2r5HSi9l5VugtuXvDVIp/4bX8+hC/Uzo0hD5NUDXoWCJ9D49Eqk4s4kKqwuwrhw8qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPGKvl3wh6HQ1fO8cZIY6f+3z9O7HTqWaKZJ5PSQtNZqrVMe6
	Odw2O2JBXSNU0lUnWck6RWYRXmDKr/uaplj4izzeeFejiXuIRg2UU5xpLsIwzVflGaJVBhaPuDw
	6PhuKHdVBuwscS6B+nca8IkfA9nxanuM=
X-Gm-Gg: Acq92OEt5nxThXWyYpf4s9fCGi7l1dwwUI4M95J261fgXq/u14SeLzIQC1VmWiA94db
	BYxxyQPjMYU0B0z1OoMIAbo/vbFRLfrc8OlufyTQN9TG63l4WRVZ7WRRTj0rJkB5dv2XwLkCCKB
	JeHrT0SD/680mGQrEoqNh1tJp3iJjxTothZ0D+LYAjXCLj8jwV6V9EQp1XK17Gk3JOcuMnwcy4j
	T+bmYDNM7UgQbQCNtfh4SkNCYCVi/lCCaMjJsyUhABcx0lngIiTKZi5fDLG3/dODmGGz0vZOhFf
	E/MnHwNoMqRRJCfnGqNi/4R1LeXf3wopf1AtbWcd
X-Received: by 2002:a05:6402:3891:b0:691:affa:38da with SMTP id
 4fb4d7f45d1cf-693784f79d7mr698652a12.1.1781250204504; Fri, 12 Jun 2026
 00:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501232735.2610824-1-souvik@amlalabs.com> <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
 <CAJfpegtnj0wmQ_mJCwJ+UKqzG_LTrUCwhRyc_NAhHj2T9Jr8uA@mail.gmail.com>
In-Reply-To: <CAJfpegtnj0wmQ_mJCwJ+UKqzG_LTrUCwhRyc_NAhHj2T9Jr8uA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Jun 2026 09:43:12 +0200
X-Gm-Features: AVVi8Cfsd00rG_CuZ-3XJb7ocjHsCW2AA5Bpj46lwTBlumbSNluLhGMMoUvO0ww
Message-ID: <CAOQ4uxiv7yKyuLX_cTdu6f_Gnzk4XR+R4NAuTa_kDhJRV7i=ig@mail.gmail.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Souvik Banerjee <souvik@amlalabs.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:26=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 3 May 2026 at 22:37, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, May 2, 2026 at 1:27=E2=80=AFAM Souvik Banerjee <souvik@amlalabs=
.com> wrote:
> > >
> > > ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
> > > overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile=
()
> > > allocated this dentry via d_alloc(parentpath->dentry, &slash_name), s=
o
> > > d_name is "/" and d_parent is c->workdir.  Local upper filesystems
> > > (ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
> > > d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
> > > not, so both fields stay that way.  Neither identifies the destinatio=
n
> > > directory and filename where ovl_do_link() actually linked the file.
> > >
> > > When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
> > > virtiofs), ovl_revalidate_real() calls it with the dentry's parent
> > > inode and a snapshot of d_name.  The server tries to look up "/" insi=
de
> > > c->workdir, fails, and overlayfs reports -ESTALE.
> > >
> > > This causes persistent ESTALE errors for any file that was copied up =
via
> > > the tmpfile path, breaking dpkg, apt, and other tools that do
> > > rename-over-existing on overlayfs with a FUSE/virtiofs upper.
> > >
> > > Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers")=
,
> > > the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
> > > that captured the linked destination dentry returned by ovl_do_link()=
:
> > >
> > >     err =3D ovl_do_link(temp, udir, upper);
> > >     ...
> > >     if (!err)
> > >         *newdentry =3D dget(upper);
> > >
> > > and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
> > > The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
> > > the dget(upper) capture, and rewrote the publish line as
> > > ovl_inode_update(d_inode(c->dentry), dget(temp)) =E2=80=94 where temp=
 is the
> > > disconnected O_TMPFILE dentry.
> > >
> > > Fix by keeping a reference to the linked destination dentry after
> > > ovl_do_link() succeeds, and publishing that dentry at the existing
> > > ovl_inode_update() call site.  The non-tmpfile/workdir path continues=
 to
> > > publish the renamed temporary dentry.
> > >
> > > Reproducer:
> > >   - Mount overlayfs with virtiofs (or a FUSE fs whose server advertis=
es
> > >     FUSE_TMPFILE) as upper
> > >   - Run: dpkg -i <any .deb>
> > >   - Observe: "error installing new file '...': Stale file handle"
> > >
> > > Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
> > > Cc: stable@vger.kernel.org # v4.20+
> > > Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> > > ---
> > >  fs/overlayfs/copy_up.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > index 13cb60b52bd6..e963701b4c87 100644
> > > --- a/fs/overlayfs/copy_up.c
> > > +++ b/fs/overlayfs/copy_up.c
> > > @@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up=
_ctx *c)
> > >  {
> > >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> > >         struct inode *udir =3D d_inode(c->destdir);
> > > -       struct dentry *temp, *upper;
> > > +       struct dentry *temp, *upper, *newdentry =3D NULL;

This init is not needed and confusing because never in this function
using a NULL newdentry is correct.
We rather get an uninit variable warning if that happens in the future.

> > >         struct file *tmpfile;
> > >         int err;
> > >
> > > @@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_u=
p_ctx *c)
> > >         err =3D PTR_ERR(upper);
> > >         if (!IS_ERR(upper)) {
> > >                 err =3D ovl_do_link(ofs, temp, udir, upper);
> > > +               if (!err) {
> > > +                       /*
> > > +                        * Record the linked dentry -- not the discon=
nected
> > > +                        * O_TMPFILE dentry -- so that ->d_revalidate=
() on
> > > +                        * the upper fs sees the real parent/name.
> > > +                        */
> > > +                       newdentry =3D dget(upper);
> > > +               }
> > >                 end_creating(upper);
> > >         }
> > >
> > > @@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up=
_ctx *c)
> > >
> > >         if (!c->metacopy)
> > >                 ovl_set_upperdata(d_inode(c->dentry));
> > > -       ovl_inode_update(d_inode(c->dentry), dget(temp));
> > > +       ovl_inode_update(d_inode(c->dentry), newdentry);
> > >
> > >  out:
> > >         ovl_end_write(c->dentry);
> > > --
> > > 2.51.1
> > >
> >
> >
> > Hi Souvik,
> >
> > Thank you for the analysis and the fix.
> > Looks correct to me.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Christian,
> >
> > Could you pick this up for vfs-fixes?
> > I do not have any other ovl fixes queued up.
>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
>

I applied the patch without this init to NULL to ovl-fixes, so that it
will be in linux-next.
Kept your RVB. Hope that's ok.

> This seems to have slipped through the cracks.
>
> Christian?

I don't think it is particularly urgent to merge this patch for 7.0
this late in the cycle, so I will hold off on sending an ovl-fixes PR.

Christian,

If you take this ovl fix (and the other one [1]) to vfs-7.2.misc
let me know and I will remove them from ovl-fixes.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20260609184656.1916631-1-amir73il=
@gmail.com/
