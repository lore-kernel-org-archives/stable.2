Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B434B2CB9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857570; cv=pass; b=MiOQE+ck3L0yamFFWpcYpuH7Vno3VpQ8g5ipxK17JS+SwhcVWT4JAw2lcEGPWhxVzyyrW3eA15ApEXWWCnVPbgj6XWWOyWUT6flDWIe1Iz60StDoTc5HkNeuD/D3E+YtChd+fXQhmZXIFyq18KSGA9y6Bzmns+WQdEhG6O0oOR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857570; c=relaxed/simple;
	bh=7+QAXGzBYBpJzxjDNrtSBQuyaTOBdqxbCzIS9nOmbTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAV2A9z2ajDvfI70HtGBy8KjFEpEbMdzwk7be8/qpMue0TdrOs5THTpthUmEBu/37zCEjbuLxwzr6vtqsIJLpMKxCZSnnLAoJgTd01AQdrJo0AUYQY+T1aSx4tiafd+NFihx8TuBrx/vfMsKw7yYH38VlIBxJNpoK9/F/9cRI/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWRjHdxy; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWRjHdxy"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a30521edd8so2773841fa.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 01:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788857551; cv=none;
        d=google.com; s=arc-20260327;
        b=S09d7D+IAR5RwdwTW8+uw4xqrgYdFHRIQ8l2PDVsyWabKn00mjT2CyEtGjIj+G4V00
         XJJmgZXmp1eH/0LRQ9KND/Qi/Wnx8dDf0MkCYBcOzqagFGFOUni8d4s7S9ox5w9swsGO
         NzK6rvsziGYM6dAKzBDPuawxWbrtq65X0TiMgiwWLTrbeTYsLD2NfeKEN/gdCDipUE6w
         NafxtG4QQUDF6HM4edapl7V1gotXncwi56B86rU3jLU2RGEgpwow75nq1hKiK+Hxr/vd
         GzPCtho0h1YKOsP/dQtjP2kFFizXpJAu44CBclfLaRmoLRNfC4zXGc0yW12LzKPgQvSs
         DPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        fh=tf3s5kmEP2UMR7yogPZFMSLRynpi5Zh1IMWvr58iRDQ=;
        b=mD/4/S/WtB9dxOKQQG1EFHZNR32xbgowP9WjVgv6sMI7AJtLOJXzAYZBT2KO7vbB4L
         lqp7wVx9GvMIdZaBEiI1UMvtKZ47zbZTnICqFKWXI4meJj3HhQsqrVY4xHt1O8ZxqvTD
         9pNG+fTcsyqUTeLd07X+ToLI+miG58bI+EDwyCi1VMLtSdEGJMXJR7RAl2MpE6rOZU7g
         zY9GqBBqA+FPn+B1PgIk3QBb1okg1vOQZAVUzEOasEoryS3Vfr0BAw1BZWyA89RAS3/B
         OcuVPigLhGk2VcBElyRSzjWZpHmCFlPGK8Gt5qId/tO22fXVnaVPKaTnbIh/1gfCDiXP
         iMpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788857551; x=1789462351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        b=eWRjHdxy6nw+Fzs4rMRX/CzFap7Ok9eg6MphRqfMIvyTOZrZsklE3U223uaBuiWlFP
         bpt9wGrbyReI3c1DAhpKyUC5mZR9m4iFsDjC4CtlbKn/+649coFKYJh9h2wSs1izb7EZ
         GBdTc3mfScSDm4xudYSs3uRFPfj5MJVd4+hPKe8zTNVCns8hR3Xq+b0V4OruC4KFQp+O
         U3jERx55qe64FmsTHYEQ04aMSZu6KdVpdpOQfaZH9CP5yVhR80I98tiM9YvtdRIem7TN
         Ov+YvBD90qRLM3Nbi6FCxNW0+uyTTFIoWCmLpY/Me47nOQ9EVk6aEz/JSekcHA5nv1MI
         DsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857551; x=1789462351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLC2NZjnn7tKn+yLWIbpSK/NQx1TlPN6P03Q7UFQsBA=;
        b=kGZRCam+JhVLm7W/7/BW62dedlERE5081sOi4OuV3UZjZ2ul4rph+AbKGOBiTICZt+
         PKVPRMM4qUdedWVW2LrGYmaTZ46m6KbL0qrroTYwCCBsZFMleru23Hkt4I1rHkNrufXb
         5fNIDMn7b4l1mzG/FJ28lJoYgTgxxGN6GYXtoEBaXkSwlHUU4UdaP9NY/Yj3w6DPTlv3
         N4V0QQUmzMnUu0AvHrLNv0HYKxNoMYI+BdjdGgh9dbClHi1uUyER7/WV6fJbKve7cG/3
         vdxrlxPxe2a9PY3zdq9n5kq62yTsj6fRYEHDHPiJZ1i2kfZAP80ZXou0FI8L4iBc/Jle
         z2ig==
X-Forwarded-Encrypted: i=1; AKwUvByXHneOdt4IRAkxghTfVOD/gw222AUI6SyU/b601Xg/2lFML8ptUVZy0mwjPtPtNK4ILenUopg=@vger.kernel.org
X-Gm-Message-State: AFuF++l+325yAKss4ZoxxkaD1gswkPLCZSKph31rSje8LmYSMt+KK4Qv
	GP3MPJf0YhDGrjuOX21+Ds21JabelION0cyOAABfrU3gxNdJutgyfj/0ME1FR61aFaMdKYrqG+X
	XaDvrZMI1U5MdENwgCjd7IaoT9IG12qo=
X-Gm-Gg: AYBFou0g8alnYuUxi64YJOzjn4tPIkkpsKYE91YMWaytfqdBsiO5Hp9oLw6aoae8oQx
	v7gZxHwoa8tcWCBBjdBYZirf2bSVMVhW4pSZowqLkFsUESI33bi02jIRLJ1ADuIv+A9dEttO48T
	AY/EJ28HXV6e0741ZxLLnsoT6BS0mh3wAWQgSvNpsd2jrDm/AViHdpO11Nxas/1IXxvQdUo3Dw4
	K1VHNKK/IZswpv9yAa/ylcpSYkzlos5MXmpvuhh4M42TnEJl42ZbFbYCjLCCzrwk7u1rddrolTF
	ecdShAuqLumwBW8mrqo5ZH5MfPWjEcTjSgDpd1yRmei9BYYr6UyicAkkHjw+UGTg7T4Q17EN2wN
	c
X-Received: by 2002:a2e:8a96:0:b0:3a3:61ec:7db9 with SMTP id
 38308e7fff4ca-3a4882d39d4mr5921281fa.15.1788857551247; Tue, 08 Sep 2026
 01:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625031932.9412-1-skyexpoc@gmail.com> <CAOC0qyLj55itFPEurfNddWpzzcPJ4j3bvDxfWBRev_GzPLL+mw@mail.gmail.com>
 <74bcba1c-6bf4-43b0-bbb5-ef2f0490e3f7@paragon-software.com>
In-Reply-To: <74bcba1c-6bf4-43b0-bbb5-ef2f0490e3f7@paragon-software.com>
From: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Date: Tue, 8 Sep 2026 17:52:20 +0900
X-Gm-Features: AcwNN1XHobYU14yAHDwLGyDtqdEDR7tiASY5WHgtvOcElymufa-qIxPZqIfvEDM
Message-ID: <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for clarifying. Since the upstream commit did not carry the
stable tag, could the stable team please consider backporting commit
7c4841e2a627 to the applicable supported stable trees? This fixes an
attacker-controlled on-disk slab-out-of-bounds write. My v2 carried
Cc: stable@vger.kernel.org, but the functionally identical v1 was the
version merged upstream.

Thanks,
He Wei=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
=E4=BA=8E2026=E5=B9=B49=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C 17:41=E5=86=99=
=E9=81=93=EF=BC=9A
>
> On 7/6/26 06:40, HE WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89 wrot=
e:
>
> > Hi Konstantin,
> >
> > Gentle ping on this v2. It's an attacker-controlled on-disk image heap
> > out-of-bounds write in ni_create_attr_list(),
> > reachable via setxattr on a crafted, loop-mounted NTFS image (KASAN
> > trace is in the commit message), which is why it's Cc'd to stable.
> >
> > For the record, the fix was first posted as v1 on 2026-06-10:
> > https://lore.kernel.org/ntfs3/20260610002929.51765-1-skyexpoc@gmail.com=
/
> > This v2 (2026-06-25) only adds Cc: stable and widens review to
> > linux-fsdevel; the fix itself is unchanged from v1.
> >
> > Could you let me know if you'd like any changes, or whether it can be
> > queued for a future bugfix pull? I'm happy to rebase or adjust as
> > needed.
> >
> > Thanks,
> > HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF)
> >
> > hewei-gikaku <skyexpoc@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 12:19=E5=86=99=E9=81=93=EF=BC=9A
> >> From: HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) <skyexpoc@gmail.com>
> >>
> >> ni_create_attr_list() allocates a fixed buffer of al_aligned(record_si=
ze)
> >> (=3D=3D record_size) bytes and then walks every attribute of the prima=
ry MFT
> >> record, writing one ATTR_LIST_ENTRY per attribute and advancing the cu=
rsor
> >> by le_size(name_len), with no check against the end of the buffer; the
> >> total size is only computed after the loop.
> >>
> >> A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 =3D 2=
4)
> >> bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 =
=3D 32)
> >> bytes in the list.  Because the number of attributes in a record is no=
t
> >> bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
> >> minimum-size attributes), a crafted record packed with such attributes
> >> produces a list larger than record_size and overflows the heap buffer.
> >>
> >> This is reachable from a crafted, loop-mounted NTFS image: opening the=
 file
> >> and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
> >> ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
> >> ni_create_attr_list().
> >>
> >>    BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
> >>    Write of size 4 at addr ffff000008984c00 by task setfattr/345
> >>     ni_create_attr_list+0xc48/0x1058
> >>     ni_ins_attr_ext+0x510/0x7c0
> >>     ni_insert_attr+0x3f8/0x70c
> >>     ni_insert_resident+0xc8/0x3b0
> >>     ntfs_set_ea+0x66c/0xd28
> >>     ntfs_setxattr+0x4d8/0x5b0
> >>     __arm64_sys_setxattr+0xa4/0x124
> >>    Allocated by task 345:
> >>     ni_create_attr_list+0x188/0x1058
> >>    The buggy address belongs to the cache kmalloc-1k of size 1024
> >>    (the write lands at object+1024).
> >>
> >> Size the buffer from the actual attributes instead of assuming a singl=
e
> >> record_size is always enough.
> >>
> >> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation=
")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) <skyexpoc@gmail.co=
m>
> >> ---
> >> v2:
> >>   - Add Cc: stable@vger.kernel.org: this is an attacker-controlled on-=
disk
> >>     image heap out-of-bounds write and should be backported.
> >>   - No functional change from v1; widening Cc (linux-fsdevel, VFS) for
> >>     review, as the v1 posting received no response.
> >>   - Drop a redundant self Reported-by.
> >>
> >> v1: https://lore.kernel.org/all/20260610002929.51765-1-skyexpoc@gmail.=
com/
> >> ---
> >>   fs/ntfs3/frecord.c | 20 ++++++++++++++++----
> >>   1 file changed, 16 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> >> index 2e901d073fe9..6488d7a415c0 100644
> >> --- a/fs/ntfs3/frecord.c
> >> +++ b/fs/ntfs3/frecord.c
> >> @@ -768,10 +768,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
> >>          rs =3D sbi->record_size;
> >>
> >>          /*
> >> -        * Skip estimating exact memory requirement.
> >> -        * Looks like one record_size is always enough.
> >> +        * Compute the exact size of the attribute list.  Each attribu=
te in the
> >> +        * record yields one ATTR_LIST_ENTRY of le_size(name_len) byte=
s.  The
> >> +        * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, =
but an
> >> +        * unnamed one expands to le_size(0) (0x20) here, so a record =
crafted
> >> +        * with many such attributes needs more than a single record_s=
ize; the
> >> +        * previous fixed kzalloc(record_size) could therefore be over=
flowed by
> >> +        * an attacker-controlled record.
> >>           */
> >> -       le =3D kzalloc(al_aligned(rs), GFP_NOFS);
> >> +       lsize =3D 0;
> >> +       attr =3D NULL;
> >> +       while ((attr =3D mi_enum_attr(ni, &ni->mi, attr)))
> >> +               lsize +=3D le_size(attr->name_len);
> >> +
> >> +       if (!lsize)
> >> +               return -EINVAL;
> >> +
> >> +       le =3D kzalloc(al_aligned(lsize), GFP_NOFS);
> >>          if (!le)
> >>                  return -ENOMEM;
> >>
> >> @@ -781,7 +794,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
> >>          attr =3D NULL;
> >>          nb =3D 0;
> >>          free_b =3D 0;
> >> -       attr =3D NULL;
> >>
> >>          for (; (attr =3D mi_enum_attr(ni, &ni->mi, attr)); le =3D Add=
2Ptr(le, sz)) {
> >>                  sz =3D le_size(attr->name_len);
> >> --
> >> 2.43.0
>
> Hello,
>
> Sorry for the confusion. The fix is already upstream: v1 was applied as
> commit 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in
> ni_create_attr_list()"), in v7.3-rc1. v2 is functionally identical, so
> there is nothing further for me to apply.
>
> The applied commit does not carry Cc: stable, though, so it has not
> been backported.
>
> Thanks for the fix, and for following up on it.
>
> Regards,
> Konstantin
>
