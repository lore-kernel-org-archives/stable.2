Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB93E0750
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790688; cv=pass; b=N+e8iy7utfSJlsioo3je0j+Q6mi5VElRChBw4DG4P+fwLnQ76cxyqrDnDL6lxee0OyUCazG9rhOQX12nSC4B2TLYVojwbSfaqOIEko41qq0ezjJxJ9xYkeKmXYBxwdIXdA+zY3nC4isca6kM0aJ3EssPu8E5oAw8yopWN2bcFoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790688; c=relaxed/simple;
	bh=izblklCfX3mlIOXUg0YT/dJ+XEHqli5azo9A+2NJYSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9pLXvO0EwXKYbF0OiC+ig5awHYJ0qAm/H4eAFPG1Ej6G1MwqNVNqIKMiTDlEUO4iJsbMHV5FPitDN3asbU6JNEIvkLBL5eAkm/Im/tUdFpnkcXBMu5/jG5GKUsAxryQnOvAi5NfmacpdHiB1HD7AjLqF+vSb8OA7zKAcn4ce8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlC5YWN9; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlC5YWN9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso409782a12.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784790681; cv=none;
        d=google.com; s=arc-20260327;
        b=VwaDJhrQNS7T/E/xyYX2vpTmBUUGjIueUUeVfwrFujoBMn1iJ1X2unn0SZaQhdCfQR
         IQGS0OpBO1t2E+1gwkW3TwbUOFz54LLanexmnmSr4iZEHv+eW6hES1DcndZAudGMc06s
         plC/O0dsyh3tahmIYf4Sci0bJ6u8k0s9Tbj1AkphKTu6kJPktBtSfRUHekDQdw8Q0xuP
         n/pGxG3vJ5p4vRoPdd3eBgPR6cBk+XBgelBzM469s9z8V4gT5ok73TbyA1Hcs1lOVl7V
         Kb+ITYYkAyDKC5EgeoOEI9kM28wEtBIHOP999t6+aldTeZobjnjZ7M5Ey2DkwaNJ+3Lf
         uGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        fh=nhOBMn/GjUlXSOSe8F1amV2SjsxCNGHFpGUvRYtDeAk=;
        b=hlLVVxrupJbVv1c5Eb7bwIbeIUWataWWEPOs0RR12364+babcHahcw6njpYesp+OHK
         SuIO7NaCkbgtN4z4ttjoJ6oxq2zDdemOUeFlwxcogHw81SKyMlVTbnTjrsl+7DgSbrqr
         CN4tfLbe6d4hgzr/lkHI0Azt0zXKn7NVEKKSAMyTY3DGL6I6tKsRoDGa8l8DbDirnqS2
         Fc7+bnPpjdXGtpHYpMO47x5XPRDHD964FfN08GM9lD9kVIuu2rDabNN98yzmQgcn3top
         VHoPSa2+8E8Pdy0r10sFCNgnCS0IAkxrfBttgTF7K3Y0xHdh+f/8IOxjO2+moCAlHFTl
         blmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784790681; x=1785395481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        b=UlC5YWN9dcrJKK8Gd4R3Ngr3Ci327lMnx4xE3Gd4j8iE81fW7JJ9/kitdQK2os6f+U
         lgIAyw75qeB3yljmKVLGvQKhavBxOK37wCTJnjtd3z+yIDfgvGX4kyDd5+VYPIbiUBwf
         zp2xnjBrq2aOlQOkZ2v2PYH1YKabxhI7mCPvTzT3GNi7ft300P7xNZPAprTK27tvEGxE
         HDh9Wj8v8soP+Gom+iO8t5vtHCIR7vKBafg4hoKiWmanijP8t3DRQ2g0N2rApWD2/krC
         cauQVbrij8uP+iMPkjdUs34F06TtA4Z61plWFO2XnBuTG4wKc4E7jPWjweSTxKmbFSEI
         9DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784790681; x=1785395481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfBTtydsINhPmhdGmRbCcZlHwfscEB9iD0uPUM7TzXw=;
        b=Np1fWC51b+qFgBT34QIWWxIzL4PSRS74CpSC+cmrhVGdQCTUsupVj3M9YdEnu+13V2
         JYfVvplLOiPWQHR7Ujy42PnMmXxhk0y6kxOaHp5yBuOnYb8JIl11bQbMydVl5p9Y+izW
         Gsh7QkfXadbGnBPn5owR3K1qO7g3IhCEtT12Im+sUmMv5m64C4vi7OzJ14PSz8UkKcoN
         I5cNNBnEdCOVdJJ8Mx9R6+NDkd4wl1LBu7O88kzkV0zbm248ThihaiKYfwf4GKA7PJe/
         iY0CpMgakGEV4vJA6aqb62/tIVUty8iBu7YNC1yhcls/hO+TiAathk0RHCIdrXhV8H9w
         zqzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJTtkRoIn4TM8av2xBO54581urdPVUkSBPhOo5YFF+xAh8jlkiZjHccuwzJK2kV6cuc/PjfGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc43c/sNk2u3IdHzW86cKWChZcfBtGtLnD7V+IcPyjvYLJ7mU5
	WN/WFc2IClaYP5XiUHQo6p64fPYqPeFwd9lnlop59CQ1hhzEhmmS7Kvj52PLVsME3fKFaii3wdB
	ar6OrLkMFxtNEszYAY+z+r4RRE46TZr1clR+iiihK+Q==
X-Gm-Gg: AR+sD11oLTn47o48z2FHd5nLhJ2KOqeUiL3b6L1+BCKvXaKdZAt+DSB15X5OWUBOIBn
	+DKT1CEK6RkShmEM8L9KBLJ2u0pFsxQ0nnvesjyfmQPvbO53heVFi28yQqD9yumJc/DUtNQ7kOc
	rBAJ8Ty1ZN4FfhBzAQjVSCPBO8F3bhrflIgeSX9YyUzWXpekjlBrzfrqQRG4f5KiI9IJOO7xxeb
	0gcWleKPSB4Oi/z2El25uVzdZtfNM82O/cVAxWY7JAGzxPYHqbncZAJhtDse1E=
X-Received: by 2002:a17:907:c705:b0:c16:44c3:5a1e with SMTP id
 a640c23a62f3a-c1c50d176cbmr78475566b.63.1784790680541; Thu, 23 Jul 2026
 00:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com> <20260706180003.2124317-1-r772577952@gmail.com>
In-Reply-To: <20260706180003.2124317-1-r772577952@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 23 Jul 2026 15:10:34 +0800
X-Gm-Features: AUfX_mwPnqmMBMWdKJ66LyMUpkptmu9t1rSpdg_jQKv2KoRFDgP0cZ6BKZv59hQ
Message-ID: <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A

Hi,

>
> A corrupted GFS2 image can store a dinode size that is larger than what V=
FS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64=
 and
> writes it directly into inode->i_size. If the value is larger than S64_MA=
X, the
> incore i_size becomes negative. That negative value can bypass the existi=
ng
> stuffed inode size check:
>
> inode->i_size > gfs2_max_stuffed_size(ip)
>
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota i=
node.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length =
and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
>
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value=
 in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size=
 while
> it is still unsigned.
>
> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQ=
qco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v2:
> - Drop the defensive unstuffing changes in bmap.c.
>
>  fs/gfs2/glops.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..8c5d257451d5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         umode_t mode =3D be32_to_cpu(str->di_mode);
>         struct inode *inode =3D &ip->i_inode;
>         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> +       u64 size =3D be64_to_cpu(str->di_size);
>
>         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>         i_uid_write(inode, be32_to_cpu(str->di_uid));
>         i_gid_write(inode, be32_to_cpu(str->di_gid));
>         set_nlink(inode, be32_to_cpu(str->di_nlink));
> -       i_size_write(inode, be64_to_cpu(str->di_size));
> +       i_size_write(inode, size);
>         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>         atime.tv_sec =3D be64_to_cpu(str->di_atime);
>         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>                 return -EIO;
>         }
>
> -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip)) {
> +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> --
> 2.43.0
>

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
