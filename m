Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793863591;
	b=os/dls/Glwce0dGBCwLvwz/UkY3XJ3jQxR9tYeoJjfo6Ojy9PXjNhuJJt9Ax39TLzu3n
	 bVt/ckE0zDPReTzVCbqigRC3HIimrD+/apmNn30+oWtZ7O1IxlB2+VSficmBDLC6g3syp
	 1oyG+zPWsfqZPHQ42D366sJJ8U97BTSpmryamazG9V/CalA+qOrFO4V7VPKW5koGseetb
	 lHD3rQgS9JhXkf7vywPUUFxzpcHhu816f3th3uqdSRSnYJivTLQaujVNOqAQrRV0qf7Km
	 mn/ZSJeis6dI2B64Cw41OGmtowCbxpeLn5f0VlxA9A6wXdWOlPJiBQD5wgRGZwLf+fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=l4oCbF0RbaHHtiZIalM4ySOOTntPpyyx7ghry7R/7uo=;
	b=g4XGL1agP2fIJBPo5afR3juuVcglVbiIDtBNklz3CvvLUpUY0Kb2LnCwO/mamJJu7ViC
	 PveJzizLbv1Snqb+aASAgnsvRCdZRDtlfJ1GKzRoCrsv+wR1FOQDxelZ8xxHSpmc6y5Gh
	 hL7Xhd/NcAQCDu+nsYri1PmLWOZE8aZC+lCGOrSU4HpNllg8EPPYyiEAwBeFG4+ZJ06ja
	 CiOswg0hgmWavCKukwRg6udKG5mWNhythmKsKBH90HqSKCwRQ9i41Cjuqi49hzbi/g7U6
	 rropedK3mXDVMNuKt/RjDiOGERhnpMyjJP6hdjmecK8MhNM71sz5ZuNMtbsbWxXXwnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZsyjWv/f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D3606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsyjWv/f
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b5766b2986so846211a12.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793863590; cv=none;
        d=google.com; s=arc-20260327;
        b=PbgqluoOaa1d3a4yYiP3T5OpxnQ6vJRC0sLYSSFxP3Ibab6M19BmJ+ZYBTi25+kQMs
         /VOjqPw16PEhNJKkpxsyh9qzLf3kgxZlfNYHVtgwHMR4Cbb/5lxjXLg852hOwXAwx0CC
         6fTbHyLlSaDtfy58/vpZfNoauuTWpxjI6lZtfwL7LnabY/0R6+1CsDJdrHqvOS5KRCEJ
         SBshklFsxiSWeBF8JASGS8fTe8pK8T/Y6jY51O/XuD2Q91l6Q/zrGnrG2KQ1Fz0n7aFy
         CO++rWVA7XofoTGNGyTZZ0G9dy/iKNzeiKvz4m07wMN8Dp2yHa5SrCQMzrRDBJB9gs3w
         BmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l4oCbF0RbaHHtiZIalM4ySOOTntPpyyx7ghry7R/7uo=;
        fh=AyXSkeU9HVBcX7SG2HGSOY+lAeZoeo7v+u2a3Zb0UJs=;
        b=agw5NVFlK4mDIDIHTX1yuEG5cpmq7P2960tqzP/zIA4BIEte5mYoNqk9eNDUzKztGS
         lRwe5BVdHwJkQAAvpKUr09P5RDfFNkvJKFIhiqlN5vxEl9Hiak2vzf2i4XLZJO+ONACc
         ZyqqdDpcEP3g1UaPPi+j316MXdlzo2b2OcWUsJB2zuTrHjV/qbRZ+1TJxZN5akHnE4Cq
         zPNxE1uSzZmOUFKhhVhfTvP3jDlHVtIk/9kt3OTB8ztot8CFReziTQlgwRJ9i3Qs/VuJ
         WEvZWqDRaows76CPgX4tygjkKTclqMRepNu5xcG0qiORWbvseWR23w49LPIqkS7Nz149
         Nkzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793863590; x=1794468390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l4oCbF0RbaHHtiZIalM4ySOOTntPpyyx7ghry7R/7uo=;
        b=ZsyjWv/frC6yJIsrE2LB6jf8L0cRWnf+J5uE4HmoTPitpJJkkA/YUblEKI5GTnQOVR
         6knf1V2AKXn8VNsw/pRPiDhyoUQDrCknXRCPShWPwdttazINCov/24QEB7+K8c3VQ/wo
         WDNbuo7VGiombK2Cg9o8SoV57YAeAGsFXKy2pZRrLmGXfC6SgwzCSV4aC5UodHgXE9KI
         NCAZ0JJf1lEJN3QZI53JMaUKTFkxgoEq9pVm4Ra2qD5APwsYqsWQmtzMC00FK6rKDtNo
         yJyrESOwHWroZEa8Nqtmf/V5fCuv/EXEtieO5gZpcYJGnl2WVfOlTNEVy/xo1IO6Q8Ow
         2i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793863590; x=1794468390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4oCbF0RbaHHtiZIalM4ySOOTntPpyyx7ghry7R/7uo=;
        b=2bGXK92v2Yz7p98c395EzxSVPpx4FtYg/QcFsd97Uoi+8VDC4pcz8eV1bhLCadY2AV
         1xRR4KubQe/WZ9PnBgcmp1ucbKf554OKDowGzIznVcNUytAzF10OJhRjKUFBNMtcJcaQ
         K7PpVFcebaeIEs477eAoShSt/4jtrq9wDQfUn8fhCb7Lv65qlUmhEnXTUhQegU/YkNrE
         gmSo5gD+AeGOTk4eKpCXAekuaHx028+dQ4cCGYqPxreXzdAPXEeUmStlbrRG0voLfuHr
         KrkkxtwqfqXyUezpa5J7EWEzBxMNLazLEv3kKR0lXTvnJPNdNOYyhjW+ONi35OLp5oTX
         KbcA==
X-Gm-Message-State: APuU4Z8yIYobrpqE11U5rVFJnlH7MiGxOK9qa5PihQz85OknJ/SOiJm/
	NjBDq54JEp9EYcQNVxOU8KJRcR3Kau5P0inv3ycs79snhJXCIBJAAMXG5008M5fyV0Mex5aS0UI
	tHHKSegCTcLFN8u+pTbaNXyzr2cyw7pM=
X-Gm-Gg: AYBFou1JX+PFLusjQgDyM43D+dsfXQZpU//W0h4keXsM8nDddr2SKKAZNetNv6xuNtE
	ozy7RAzBUfFP2i8L6g/3fHwsH1ffW8eaFTvhCt/9T72nsOi7kLJOHivfWiJCiou5eEeBA9Lu+sM
	CkTfZoMw6H/DusHyUd6W3he5DpjWXp+JQSWv5oiHiIpoOH5s4f/VGIoIF+3pw56XMzS5nn58A/O
	fGln8M+s7EyeiZJPkcqNYr+Iwn59rRFOy3qyMpXhBNJ1baTaDgeY40KwVisO5I8L77ZWlfXCGyL
	x8EyzzaARbOXkMHTPgVkKelQB0OfjhPC8Gn8iUA51QkNMP8nh/HgJ+XLfISgWlTjZJKBbcv5j2I
	6AXL9tlh+rOZp1A9F6gJrBY7yH7X+ea8NcM2idzr02QFPBUea3bedk4Qzt5VdTbVGE1Z8HA==
X-Received: by 2002:a05:6402:2410:b0:6b5:646d:be3b with SMTP id
 4fb4d7f45d1cf-6b5646dc0c6mr3176332a12.18.1793863589451; Wed, 04 Nov 2026
 23:26:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110447-widen-reunite-2c7b@gregkh> <20261105025023.1204346-1-sashal@kernel.org>
In-Reply-To: <20261105025023.1204346-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Nov 2026 08:26:18 +0100
X-Gm-Features: AclHuK-N2vqUHaGh2565_9Fm-doPUNa8MNNiQ_4OpkRI17ScR-Byj60E0tjTmwM
Message-ID: <CAOQ4uxghyqkUkabY5-rcwUrUq190Mvh36zgQBJ6EwYsnAiDtrA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] ovl: hold a reference on the parent in readdir
To: Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:50=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Chris Mason <mason@kernel.org>
>
> [ Upstream commit 16d319e12328acafeafd3eecdf09c46d7fb43452 ]
>
> Listing a directory on an overlay uses a freed dentry and crashes the
> kernel when a lookup moves the directory at the same time.
>
> Code that can sleep may only use d_parent without a reference while
> something stops a move of the dentry. ovl_iterate_real(),
> ovl_need_adjust_d_ino() and ovl_cache_update() use the d_parent of the
> listed directory and hold only the lock of that directory. When a
> lookup finds the directory under another parent after a change to a
> layer, d_splice_alias() moves it without that lock and drops its
> reference on the old parent.
>
> With a delay in ovl_iterate_real(), getdents64 on an overlay directory
> raced a rename in the lower layer and a lookup that moved its dentry,
> and after an rmdir of the old parent KASAN reported a use-after-free in
> security_inode_getattr().
>
> Fix this by using dget_parent() in the three functions.
>
> Fixes: b5efccbe0a12 ("ovl: constant d_ino across copy up")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [amir: fix comments in ovl_need_adjust_d_ino()]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> [ sashal: Applied the changes for the absent ovl_need_adjust_d_ino() help=
er directly to the inline logic in ovl_iterate(). ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I had already asked Greg to take my 6.18 backport to 6.12..6.1:

https://lore.kernel.org/stable/20261104184517.3630089-1-amir73il@gmail.com/

It'd be a shame to have different backports when we can use the same
version to all.

Should have posted the patches separately :-/

Thanks,
Amir.

> ---
>  fs/overlayfs/readdir.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 6931cbc1042c3..56425b369560d 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -486,8 +486,8 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>                         goto get;
>                 }
>                 if (p->len =3D=3D 2 && p->name[1] =3D=3D '.') {
> -                       /* we shall not be moved */
> -                       this =3D dget(dir->d_parent);
> +                       /* d_splice_alias() can move even a locked dir */
> +                       this =3D dget_parent(dir);
>                         goto get;
>                 }
>         }
> @@ -711,6 +711,7 @@ static int ovl_iterate_real(struct file *file, struct=
 dir_context *ctx)
>         struct dentry *dir =3D file->f_path.dentry;
>         struct ovl_fs *ofs =3D OVL_FS(dir->d_sb);
>         const struct ovl_layer *lower_layer =3D ovl_layer_lower(dir);
> +       struct dentry *parent;
>         struct ovl_readdir_translate rdt =3D {
>                 .ctx.actor =3D ovl_fill_real,
>                 .orig_ctx =3D ctx,
> @@ -721,18 +722,26 @@ static int ovl_iterate_real(struct file *file, stru=
ct dir_context *ctx)
>         if (rdt.xinobits && lower_layer)
>                 rdt.fsid =3D lower_layer->fsid;
>
> -       if (OVL_TYPE_MERGE(ovl_path_type(dir->d_parent))) {
> +       /*
> +        * The lock on dir does not stop d_splice_alias() from moving it =
to
> +        * another parent, which drops the reference dir holds on this on=
e.
> +        */
> +       parent =3D dget_parent(dir);
> +       if (OVL_TYPE_MERGE(ovl_path_type(parent))) {
>                 struct kstat stat;
>                 struct path statpath =3D file->f_path;
>
> -               statpath.dentry =3D dir->d_parent;
> +               statpath.dentry =3D parent;
>                 err =3D vfs_getattr(&statpath, &stat, STATX_INO, 0);
> -               if (err)
> +               if (err) {
> +                       dput(parent);
>                         return err;
> +               }
>
>                 WARN_ON_ONCE(dir->d_sb->s_dev !=3D stat.dev);
>                 rdt.parent_ino =3D stat.ino;
>         }
> +       dput(parent);
>
>         if (ovl_is_impure_dir(file)) {
>                 rdt.cache =3D ovl_cache_get_impure(&file->f_path);
> @@ -761,6 +770,8 @@ static int ovl_iterate(struct file *file, struct dir_=
context *ctx)
>                 ovl_dir_reset(file);
>
>         if (od->is_real) {
> +               struct dentry *parent =3D dget_parent(dentry);
> +
>                 /*
>                  * If parent is merge, then need to adjust d_ino for '..'=
, if
>                  * dir is impure then need to adjust d_ino for copied up
> @@ -769,11 +780,12 @@ static int ovl_iterate(struct file *file, struct di=
r_context *ctx)
>                 if (ovl_xino_bits(ofs) ||
>                     (ovl_same_fs(ofs) &&
>                      (ovl_is_impure_dir(file) ||
> -                     OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) =
{
> +                     OVL_TYPE_MERGE(ovl_path_type(parent))))) {
>                         err =3D ovl_iterate_real(file, ctx);
>                 } else {
>                         err =3D iterate_dir(od->realfile, ctx);
>                 }
> +               dput(parent);
>                 goto out;
>         }
>
> --
> 2.53.0
>
