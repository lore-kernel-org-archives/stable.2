Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB71F5821
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274147; cv=none; b=tmB/8tJiGijyHoDSycqt5XVAv687Grhlx+2PtvxK9fwicuNpn+KCfwLucbwy++o+jUmuBECQas+UFWJiA3BhpFuR7VvjfxFIg0qMerqB7s+uMZUXm/pgmUMC90n21exwsvZFQe4X0SY6nrHsQlE2LUAYXczjSGV5LSkqJwmubFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274147; c=relaxed/simple;
	bh=j4aVP/O/W2/08y9n5IJmtt486PyHueY1gGAM5ACsKfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRmyTRlXkJyG7rPGE5OE13pXuKf/q5ixi7z2Ptq+b+TcNZ1W8XoBI156B8B3W9n82lZhD/rY376CGLPGFF6EyNy4r0JimlJaKNi1KLoDjR48gN6Q8ubprxxNlwBvTIlqctEWraSlap5urXPiKgG9zqfjGhsy9/xtzbHHkWRMv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMWp7ymQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMWp7ymQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A75F1F00A3D
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 01:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274145;
	bh=bIwuEqezA9Y4sF4h0xhJBpZ039oEmYkcD9hpugZLGqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BMWp7ymQ5WWaFFn0PUofJOVKpdh3lxDBCIx4h6zhvxbsrYyctu1UQiS4QGEECVWxU
	 OT+tWq9lpoE7GaMfFlwj7YdLmG+xSrsFXwf++eE15oB1BM5uG2ao3bzJxIYM/hpHCl
	 wFPsZxq6TkVXULosLMMiahARSeuU1zH8LnJGGBl9Reg6JKJZIyyW5VPOz5hYZ2B22g
	 DsN5TQmsV2QaPELuw2ik8v/dOHklTCd3Cz7F87EhuG2oymlHO3sD6gKiYNM2za1bhs
	 WlbiaxwdNzkYgez8McNKML7iQGgPSWwE0sJk9LAqPsjLl3xLgD6mZiWPSy36cWQFr0
	 5ofHudjEeL6eA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so968347a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 18:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rol5Wpl5OlLEWNXK4xaS8x3xNaEc/0t78F2TR10jaybAaN3CcRRk15pOKefRAItiVWxn6DSOdE=@vger.kernel.org
X-Gm-Message-State: AFuF++mwUI3Gy5C3YsZicySqxxb+eLZeE/d/h/HuzHG+BlEzBx+0uz2N
	XCRxvDxEvKp9FqUJppoOSnbjcdEJSOqwqzngE3qc99vi24xCiYsGyqc5z7fHPR03CHLD0mQg9Au
	R27FSGMW/KLhylPHw7ZE9hfOa0YiIesE=
X-Received: by 2002:a05:6402:44d4:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a42f26e30cmr2311594a12.15.1787274144173; Thu, 20 Aug 2026
 18:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820211443.1472310-1-sorenson@redhat.com>
In-Reply-To: <20260820211443.1472310-1-sorenson@redhat.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Aug 2026 10:02:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8xbGTc8ADKqR1VMw1SETLDvFwrbnahp+4pWFTamZLB=w@mail.gmail.com>
X-Gm-Features: AcwNN1WKqWTLEdvNSWjb5-Zf9b7P5pbJkFXXCVeB3e6Vr5pDSc9ajvTvOtvQSqg
Message-ID: <CAKYAXd8xbGTc8ADKqR1VMw1SETLDvFwrbnahp+4pWFTamZLB=w@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix i_size inconsistency in smb2_duplicate_extents()
 on FSCTL failure
To: Frank Sorenson <sorenson@redhat.com>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:14=E2=80=AFAM Frank Sorenson <sorenson@redhat.com=
> wrote:
>
> smb2_duplicate_extents() pre-extends the target file before sending
> FSCTL_DUPLICATE_EXTENTS_TO_FILE.  If the FSCTL fails (e.g. ENOSPC,
> byte-range lock conflict, unsupported file combination), the server
> and client i_size are left reflecting the larger size while the data
> in the extended range was never cloned.
>
> Save the original i_size before pre-extension and restore it on FSCTL
> failure.  If rollback fails, force revalidation instead.
>
> Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate ex=
tents (reflink)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
> ---
>  fs/smb/client/smb2ops.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7d6738ffcb80..38bd344a9740 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -2200,6 +2200,7 @@ smb2_duplicate_extents(const unsigned int xid,
>         struct duplicate_extents_to_file dup_ext_buf;
>         struct timespec64 ts;
>         struct cifs_tcon *tcon =3D tlink_tcon(trgtfile->tlink);
> +       loff_t orig_size;
>         u64 asize;
>
>         /* server fileays advertise duplicate extent support with this fl=
ag */
> @@ -2218,7 +2219,8 @@ smb2_duplicate_extents(const unsigned int xid,
>                                trgtfile->fid.volatile_fid, tcon->tid,
>                                tcon->ses->Suid, src_off, dest_off, len);
>         inode =3D d_inode(trgtfile->dentry);
> -       if (inode->i_size < dest_off + len) {
> +       orig_size =3D i_size_read(inode);
> +       if (orig_size < dest_off + len) {
>                 rc =3D smb2_set_file_size(xid, tcon, trgtfile, dest_off +=
 len, false);
>                 if (rc)
>                         goto duplicate_extents_out;
> @@ -2235,6 +2237,23 @@ smb2_duplicate_extents(const unsigned int xid,
>         if (ret_data_len > 0)
>                 cifs_dbg(FYI, "Non-zero response length in duplicate exte=
nts\n");
>
> +       if (rc && i_size_read(inode) > orig_size) {
> +               int rrc;
> +
> +               /*
> +                * FSCTL failed after we pre-extended the file.  Attempt =
to
> +                * restore the original size so the caller sees a consist=
ent
> +                * file rather than a larger file with uncloned content.
> +                */
> +               rrc =3D smb2_set_file_size(xid, tcon, trgtfile, orig_size=
, false);
orig_size is only the locally cached size, and
lock_two_nondirectories() does not prevent another SMB client from
modifying the file. If the FSCTL fails, this rollback may truncate the
server-side file to a stale, smaller size and delete data written by
that client.
