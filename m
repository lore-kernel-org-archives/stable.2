Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C74848A3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661152; cv=pass; b=DUFmssGr13IBMJdmQn5rj/j057ieFWG4Tk8MvnGgnqnRi7jI2eCCDQAZVnDVtzUdXUhRKQ5E6VxLZT/jsOYV0qA09c1eeIyFx5LrBZYjC8PG/lpFUJUhwhqGAU0dircjzvJOJX6RKG5j5yyGdG1rP7wKvdLDqi8zazTxkFRAkaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661152; c=relaxed/simple;
	bh=aYHPZun5/irD6+c03BRZQvOeX0fB7lcB7AWwlXYl/9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK09gGiTaVcRpE6KLmFAk6oNBQmaFkUcztDDbJv89awnITYHLN3yDq82YSTh1mgSzPZzMpZla/3otAXg4tWDLiYmueKlIufV/8dFW9v7ap/j/V5osMqcodzqZqFmQWd48jsy2pPT4DnR4X5xYTDEvkND5WAh8w/qi5QIcK61Gwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsyaETGg; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsyaETGg"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so9903981fa.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789661148; cv=none;
        d=google.com; s=arc-20260327;
        b=SEB/WGyNN+AZGT1r7s/ADThoZHV9zV1D7wDDka+6qx4QP510mhEeAAsPq2nUeCaD/8
         vsINW1kBaUrx7/4jHwDHFAZD9T8fK01xGoPCWCVATsIs6UIe8LUO6gBdgpU3mUuK6JnA
         /NoUPWmZkbxMUAk0mDIV2lj39INopSiSf6TurFPxQ2Fy0EwbKvF4oSt57mhTDs1OgL80
         DRkwYtOejnjKrhx09ZI9ylVrztD2voGQBOAsNyjk0U+PMwPMGH8DNccfXmk8aQ2JHIZY
         gEBbdXUn+NZkX2PE8FycuNxIrb7ynLFnNxogFYnPAcymlO8FZVnlcjsKbLUSZbcg+b4X
         vGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0knlEXv4mbL0sYln2HZI5KQEQf/XjamlBIK6poQrSI=;
        fh=WB7Z5Y4eQR7inKcgemAfrKYgVB4YhqbWS1kmBeBXORM=;
        b=R1/UGzXU3CWaPFvwwlLKS4P+cAWrtb72eClUGUVkqMdBbdSMY9Io/UbL1ZQexHlPB7
         aMlIP5inPtN1y1Pf9zTinH0vVuQydWUNh9PemlDcfDOCzDsXgQvdgPA9f8ABEPJsqLVZ
         nfzmBdMOD/G7eY6N5BEJZvgc2x/7HwpWZ4oOFf7DLy6JW9AZ9+rjkfTUl2cRKdf7L4LM
         jSimuKC+P5YV4kJOnovgsKLMmz0LKrAuEkXXE6DFraPCq65i4ezyBFhmCWX9FyomkKtI
         k6xXw+pqBv20Vv/tjlm3goSbQdLV6uRM2bq6pBUbW7sskMzNwTKw0CK7PuXfTLKFqKP2
         kp2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661148; x=1790265948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0knlEXv4mbL0sYln2HZI5KQEQf/XjamlBIK6poQrSI=;
        b=OsyaETGgmpv4PWCTwaGsD1bae+I4JryglL4Fg2/Ejw6sVd7FES/e/KmCLGjq4b/o5p
         mmWeTgjbN8B+Rd7zIwy6TpaqO4zKCgqD7XW4pazSIBBfitdGa6Uvo46uZOnD3SnjQ6Np
         ppWvD4DIu2beqa40BQ6GfSx2CWwZhho4U5xFDa8/RRUhiGLAcwvcNMy8f0KtnXaSYQ0S
         z1BFXdWOwCCQp5te1OM/VSW+h3StOkLRak6j6FQGgJakJPEUJ2DcF+b8qR9RVwAd02qI
         draFSz8FhHUc3FLLjyv09ChAJHsogbihidT4w4O1d/mZAU6dT3BUlF6uGi836xOJYAcX
         xClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661148; x=1790265948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0knlEXv4mbL0sYln2HZI5KQEQf/XjamlBIK6poQrSI=;
        b=rPPcCn6XkvHiSB89UUQG+S+whCnZhZCxOyaRHF325IRVgGbVdjORvNbGUtdmR9L01O
         kF8uIWjHNFk9KKy6khRGjZBVqfB3qjgOqtmosjEYP8YjuNaFPNtjh2V3kpPA7RoJnftU
         D+opDVt6sG0oko1I0X6YQRA4FXHo6TFlWudYwYEE4UGOTtJLl+jPy8P0EB8RS06troTt
         A5YTb9LcY+waaJSceNpTY1JCZDZBykyEGxzJo2SI8GKvoZzZYZngcDWjLCmVJSeC4/LO
         1Ep5v17fW/7RHcGFPUCU9P3v8tOOC9DE1BoIi45N89b1+3Jmzf/vgq0m4czIRWSwuM6s
         pWow==
X-Forwarded-Encrypted: i=1; AKwUvBxqbaP5Ks6+SJ2DKKky3DIlmUxBmBU73iipZAQrX35lBwYi9FEToBZswK/+5EKMZn+lY8HyeLM=@vger.kernel.org
X-Gm-Message-State: AFuF++kgXloZliEpaWP/CKphzOSNENCzHmUoBUeVwIsFh+sZtJpSUL2I
	OgM4Zp43VCq8yWNYfr+f6gJvaFkpiX14WR8unktYjrBzXUjNhgciE8wZYKyJCRA5s26RibRSjm5
	2AeS0SwmzwSmFx9Mrt3jMbMhdcthBOvE=
X-Gm-Gg: AYBFou2iGbsNIx22t+YMlDKweaTtIlMI7hCl/KqkkRB5D9b9ot+CX1RstttezyGxis8
	xISCn3XG1DamfnnkcrkX6PwPFWa9CTa2Ff9xIklb6Kof4zqP5oTOvSk1ZLZ+GG7TgeToSoMktWP
	p91Fh09WPIhDTsyYvC/2h4SY807msNzvl53aDDkuhA0DDkjHmtctA/XsCNGnJfuKIUC7/uGjyJg
	WW3TKuG5+wz1oPMo9WWhzhF/8vzSw6vwwrV026qKo6RURxqY3/sERjk3+QT4KXNlrXzH2VjOiDT
	j1g7PUl3PDFeoYkB8SciVl+pnDaGXP0dHDNclfoYVGPMZHEtNXBHr3Nn
X-Received: by 2002:a2e:bea9:0:b0:3a3:7682:49a4 with SMTP id
 38308e7fff4ca-3a5dca3287bmr15262601fa.25.1789661148190; Thu, 17 Sep 2026
 09:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915195223.3331909-1-qwe.aldo@gmail.com> <8eef80c6c8d21e863c5a3721b1ae681fc4ccf54f.camel@dubeyko.com>
 <CAKFNMok804k_g2CHXfrn0LaOY38r8FtMnAk1kRc3YeZ=omCoag@mail.gmail.com>
In-Reply-To: <CAKFNMok804k_g2CHXfrn0LaOY38r8FtMnAk1kRc3YeZ=omCoag@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 18 Sep 2026 01:05:30 +0900
X-Gm-Features: AcwNN1UNmNAEFEa_aShHdfCxs1sFHZf3BKx1wDE4NUS_g7cKBrh-ViQLa11YyzE
Message-ID: <CAKFNMo=Lsaci5bY+G8A-C_FdD3Rhais4eANUdz8rHL7e-auHvw@mail.gmail.com>
Subject: Re: [PATCH v2] nilfs2: validate segment number in nilfs_sufile_get_suinfo()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:46=E2=80=AFAM Ryusuke Konishi  wrote:
>
> On Thu, Sep 17, 2026 at 4:06=E2=80=AFAM Viacheslav Dubeyko wrote:
> >
> > On Tue, 2026-09-15 at 16:52 -0300, Aldo Ariel Panzardo wrote:
> > > nilfs_sufile_get_suinfo() subtracts the caller-provided segment
> > > number
> > > from the total number of segments without first checking its range.
> > > If
> > > the requested number is greater than the total, the unsigned
> > > subtraction
> > > wraps and the function may process segment numbers outside the
> > > filesystem.
> > >
> > > Cache the total while holding the metadata semaphore and return no
> > > entries
> > > when the starting segment number is at or beyond the end.
> > >
> > > Fixes: 6c98cd4ecb0a ("nilfs2: segment usage file")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > > ---
> > >  fs/nilfs2/sufile.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> > > index eceedca026..573646c5f7 100644
> > > --- a/fs/nilfs2/sufile.c
> > > +++ b/fs/nilfs2/sufile.c
> > > @@ -870,10 +870,14 @@ ssize_t nilfs_sufile_get_suinfo(struct inode
> > > *sufile, __u64 segnum, void *buf,
> > >
> > >       down_read(&NILFS_MDT(sufile)->mi_sem);
> > >
> > > +     nsegs =3D nilfs_sufile_get_nsegments(sufile);
> > > +     if (segnum >=3D nsegs) {
> > > +             ret =3D 0;
> > > +             goto out;
> > > +     }
> > > +
> > >       segusages_per_block =3D
> > > nilfs_sufile_segment_usages_per_block(sufile);
> > > -     nsegs =3D min_t(unsigned long,
> > > -                   nilfs_sufile_get_nsegments(sufile) - segnum,
> > > -                   nsi);
> > > +     nsegs =3D min_t(unsigned long, nsegs - segnum, nsi);
> > >       for (i =3D 0; i < nsegs; i +=3D n, segnum +=3D n) {
> > >               n =3D min_t(unsigned long,
> > >                         segusages_per_block -
> >
> > Looks good to me.
> >
> > Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> >
> > Thanks,
> > Slava.
>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>
> Hi Viacheslav,
>
> Please take this directly.
>
> I also agree that this change makes sense, and my local test results
> are as expected.
>
> However, please drop the 'Cc: stable' tag since it does not cause any
> fatal issues at the moment.
> If a real-world problem is found or reported, I think it would be fine
> to request a manual backport then.
>
> While acquiring information on out-of-range segments due to
> wrap-around is indeed possible, sufile is also a metadata management
> file.
> When accessing out-of-range areas, it simply hits as a hole block and
> returns empty data.
>
> Neither memory overrun in user space or kernel space, nor
> out-of-bounds block device access or information leaks will occur.
>
> Well-behaved userland tools read segment information based on the
> statistics obtained via nilfs_get_sustat(), so no problem will occur
> (the difference in behavior was visually indistinguishable).
>
> Therefore, I modified the nilfs-utils to perform ill-behaved calls and
> tested it.
> Although out-of-range non-existent segments were displayed as empty
> data, no critical issue that compromises kernel stability occurred.
>
> At present, it does not appear to meet the basic criteria for stable
> backporting, so when backporting, we need to be able to organize and
> demonstrate the reasoning why it is necessary.
>
> Thanks,
> Ryusuke Konishi

Hi Viacheslav,

To follow up on my previous email regarding the stable tag: since the
patch includes a Fixes tag, simply dropping 'Cc: stable' will not
prevent automatic pickup by AUTOSEL.

To strictly prevent automatic backporting while keeping it tracked,
please replace the tag with the following instead of dropping it
entirely:

Cc: stable+noautosel@kernel.org # Non-fatal bug fix; defer backport
until a real issue is reported

Thanks,
Ryusuke Konishi
