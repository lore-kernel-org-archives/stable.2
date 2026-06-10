Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74C25B0B9
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090793; cv=pass; b=On0DIroEWiP4QF9wgH9QQEvx0fa9s0sagCvHBKGNR7UxcbxsH+k/YK3HoKvXz568BgmWxr8toq8qpPfuA6zQD5PcJVNz2IZjTmqJzpIb/kzlmeJ8Tx6P3HUhqn8PlRzspjQc4cSRMunZ4USh8KKf0ZGoZX+CaL5FXur8ZL2DZPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090793; c=relaxed/simple;
	bh=2aaujS1GBFRX6Q5jOjboaRMIxVZnOhhXsuUQ4jqqCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F85FcSniPq8hHiBAbfGbEqUtXLMNBlyg8nu+3sUM25XFozOF9GDvuJ459fTM7xoo0/NVlIVLG68AFuk3pPN8RJgMdDJI8GgvZJVfvhDaNslkK1exnnzpeFE/COLFP8alTye8WFRft2fY+LA27FXnnD6/QFd/+xhdiFnVxhNyg6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WKtdXB8j; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WKtdXB8j"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176fc0cc72so66918011cf.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 04:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781090791; cv=none;
        d=google.com; s=arc-20240605;
        b=SVkftft//PNy6LcbwAypnAjX1pzXFgXnguwe+uiAEtPcOK4qrJIPGU7kGtdv5ziz1L
         btaKCudM435PGUXvY4OtBARgnBEfPv0DFzxseLENNbWJX32E3Rhr2S5L6Nhbk39ch3y5
         cxb8/apivZs8bsuSmcXWW7ecnI12+d8SvgVuwXBpxDcMjoUnoOBL6sl0FQhNhDYGnokH
         xuO6r6xxWgnjTRQ/pdVe7C4PP78ea3sFAOnhHZX6tng0esDrQwezuE/ObOdeUOnVs94S
         arUjiDUJ5evbo3MUGLKn/HFH7AVWVXhyULCoQpnssTvEP6OPaRaJCLHsG3BLJTLdwAF3
         J+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KwpbCI+rGfMKsie1cbjw3OobD3YXJBn7+ixKB5TpcMI=;
        fh=V9xiGsKFqPtGVYIdG/0dZWNNsP9kg0VuisymhBrOwXw=;
        b=cp6A8oC4DfwRlYOL4ZMuwXYeb1sU2r4LwvnLmzGuOxaoGtKROM/l4jSWiGKanM772x
         qGcBZSVeuLLRRCpXYQzuIoZ+9uuqgDVu6fKIP7sV7GJGi3xjxJCZGOvPW1qCGmhKtNmL
         ioFzQCWZM7Trxz4lgPPMH4f8+KXfBrrCwGoufKnoIMxP4+znn4HRUNIMcHBDr6jWrSOx
         TWtarZhNu1FRNJydP7gjyuiR/YiHftzp10Swo0+RIkZFCPxASNl/pelCgN7kxf7InqXB
         YZfzv5qShlbttlcDCQ4iV5oVunEdqFtp+N1fYSJ+8MciAQUS5WiDKrj4kGV8vLkt9b+C
         7ThQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781090791; x=1781695591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwpbCI+rGfMKsie1cbjw3OobD3YXJBn7+ixKB5TpcMI=;
        b=WKtdXB8jGww4N4vaXjc23iE//thOwpKiZebGM8NRULuWpKXCg2oaeLKChppes4SvYe
         K0VfHW4DvVHPdGoJulIZh9WxGkSjs56GqZBL019qzkf0R0dMCOrZQhm8+d5ghMsLb2M8
         4Kw7G42MJKBQ3sdTx4BcqULRpT+0leVUmBQho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090791; x=1781695591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwpbCI+rGfMKsie1cbjw3OobD3YXJBn7+ixKB5TpcMI=;
        b=ENAIq1CCYB8KGTFUNQrApve7um6lBwNhlEXILYCGKlkY8U1IZv2qrVaW+gpj9bPUOS
         wyYC6nihRl84wm+RfL+I6hPximltuUo1re9irwdRBXBqkmymZ6f4zdyON/njbtDTiWST
         MU73eeMhcKyuLllyQAfIeIQxoBf1cPWm95KifYdGk8i98EPTE4brc786eWUMGAkK+yiV
         JhAza/8NrM/XB3wnjx7yHEhqhUmRkDsBBLfJPVCTDC+8oe/s4pDAmIg9zuU3FlhKCRu5
         P31wjmW3meCGi713BLBKDW5OGsHUvU4by/B3sgvfvka9wTPecWBt3Xj/kms9RTqjKvCe
         wlJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YhsPg1FG7ZXyl6yCEYzyzQ1YdDlwglao8RTKr6fHHapho9vp6jZeFXQNIR7eB0TVKNLI9QeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3k6ufkfedagcg8POpHvp8XknTg64jjJZ/FpFsfY1XMi2h3rV
	A65OgvIZufLSO6bs8srdkfUX1rLZDDYg080kUMNuB5Xghg4GGK5SvPEnYwvS4NxBxqomSBfRcIu
	FiW3kcFpqt9nTRfLqZePoQQq8IfiHoZRWwY2M9FGLiA==
X-Gm-Gg: Acq92OEzMym6xB+dubhdnmSY0F5zz5uUFMa2U5th9gMS76sfErqCOSoOfjRnOP5eVsu
	xsceyeyZnaSorBQlHxNBF2CJe7fg9hAdfloy8sXuHET2URm2b46A+9RsfAqzX/GHpVISgNGEDQs
	thZ4V7kuYURTOAQTy9FGvkKVX0NcDbdOP+y+wtSUVOdfUE1QHZqBx21grqezRhyPL8kOo62kfkq
	KQbM1Xuba1HhuI7kdbK0qLjUHEWGvshGZOivdF8CBOArCQZmrLPdV0k1VzboisWl2hxDr+ImcUo
	Cq68/ZJ5tJWXKrGtyIELsPzRvFEEyQxNwCNaJEwGSbMGp8ceBtc=
X-Received: by 2002:ac8:57c2:0:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51795c79c8amr367684721cf.39.1781090790667; Wed, 10 Jun 2026
 04:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501232735.2610824-1-souvik@amlalabs.com> <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 13:26:17 +0200
X-Gm-Features: AVVi8Cc5nyPpov-4yxMA02Z7Wm5x-BSYPxwNQXgevyHJGdk5NCb-4_ru_xxa7-U
Message-ID: <CAJfpegtnj0wmQ_mJCwJ+UKqzG_LTrUCwhRyc_NAhHj2T9Jr8uA@mail.gmail.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Souvik Banerjee <souvik@amlalabs.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 3 May 2026 at 22:37, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, May 2, 2026 at 1:27=E2=80=AFAM Souvik Banerjee <souvik@amlalabs.c=
om> wrote:
> >
> > ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
> > overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
> > allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
> > d_name is "/" and d_parent is c->workdir.  Local upper filesystems
> > (ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
> > d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
> > not, so both fields stay that way.  Neither identifies the destination
> > directory and filename where ovl_do_link() actually linked the file.
> >
> > When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
> > virtiofs), ovl_revalidate_real() calls it with the dentry's parent
> > inode and a snapshot of d_name.  The server tries to look up "/" inside
> > c->workdir, fails, and overlayfs reports -ESTALE.
> >
> > This causes persistent ESTALE errors for any file that was copied up vi=
a
> > the tmpfile path, breaking dpkg, apt, and other tools that do
> > rename-over-existing on overlayfs with a FUSE/virtiofs upper.
> >
> > Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
> > the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
> > that captured the linked destination dentry returned by ovl_do_link():
> >
> >     err =3D ovl_do_link(temp, udir, upper);
> >     ...
> >     if (!err)
> >         *newdentry =3D dget(upper);
> >
> > and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
> > The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
> > the dget(upper) capture, and rewrote the publish line as
> > ovl_inode_update(d_inode(c->dentry), dget(temp)) =E2=80=94 where temp i=
s the
> > disconnected O_TMPFILE dentry.
> >
> > Fix by keeping a reference to the linked destination dentry after
> > ovl_do_link() succeeds, and publishing that dentry at the existing
> > ovl_inode_update() call site.  The non-tmpfile/workdir path continues t=
o
> > publish the renamed temporary dentry.
> >
> > Reproducer:
> >   - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
> >     FUSE_TMPFILE) as upper
> >   - Run: dpkg -i <any .deb>
> >   - Observe: "error installing new file '...': Stale file handle"
> >
> > Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
> > Cc: stable@vger.kernel.org # v4.20+
> > Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> > ---
> >  fs/overlayfs/copy_up.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 13cb60b52bd6..e963701b4c87 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_c=
tx *c)
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> >         struct inode *udir =3D d_inode(c->destdir);
> > -       struct dentry *temp, *upper;
> > +       struct dentry *temp, *upper, *newdentry =3D NULL;
> >         struct file *tmpfile;
> >         int err;
> >
> > @@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_=
ctx *c)
> >         err =3D PTR_ERR(upper);
> >         if (!IS_ERR(upper)) {
> >                 err =3D ovl_do_link(ofs, temp, udir, upper);
> > +               if (!err) {
> > +                       /*
> > +                        * Record the linked dentry -- not the disconne=
cted
> > +                        * O_TMPFILE dentry -- so that ->d_revalidate()=
 on
> > +                        * the upper fs sees the real parent/name.
> > +                        */
> > +                       newdentry =3D dget(upper);
> > +               }
> >                 end_creating(upper);
> >         }
> >
> > @@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_c=
tx *c)
> >
> >         if (!c->metacopy)
> >                 ovl_set_upperdata(d_inode(c->dentry));
> > -       ovl_inode_update(d_inode(c->dentry), dget(temp));
> > +       ovl_inode_update(d_inode(c->dentry), newdentry);
> >
> >  out:
> >         ovl_end_write(c->dentry);
> > --
> > 2.51.1
> >
>
>
> Hi Souvik,
>
> Thank you for the analysis and the fix.
> Looks correct to me.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Christian,
>
> Could you pick this up for vfs-fixes?
> I do not have any other ovl fixes queued up.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

This seems to have slipped through the cracks.

Christian?

Thanks,
Miklos
