Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB223CF1F2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002973; cv=pass; b=R+ZAmTVjCBJ04AzBBAniNvS+v3nRRK1moL7CUhawnesFO9VgJOclaqxkcvxrvlq0nPgG5FLKs2Uh8TQsfCtMNLab9noDAl1SFUZKYEze0HlTVoJC7kzoHf1btl4TQcOskGUgZzQlxQkaq61MZUmWhdD9UBsetAKwv3+25+F+qSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002973; c=relaxed/simple;
	bh=mZA2+co8JyR8AhVnXKsyn8qV/VAQ25/BehkWnTRIakA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQTrEnKR+2q0FYOLn+BgZbhMLw7H4A6lr6Xu4WaONtSXFhTNqlU7rDpdk6+w/g/ksGO20pjRKQ99BQ1ANizFadiEm9YesZr41mQ44Ysn+z6JeVaT9GG6CSAHFFumPjxcBTR5stdsdBOAqT39dSj10thjO//Kdyif+5QacMpg/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olmFMEAa; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olmFMEAa"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso273603066b.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786002970; cv=none;
        d=google.com; s=arc-20260327;
        b=GlHDFcpMAmeIeXLZSLsRiOJmp6UO/0bOwOG+eT6oOmBgCrsZfp3wPVDd2hIrRtv/66
         EdaDLegST0Gwt0j4eu52e3cg5BdTChvm1Hns2siulUQRS0VWLoqxUUobUD291/9wjOSe
         frRsMQ08ybN5rt2R8xDefeLqq/4o+c60ctSmp0scqgCF2Yz4IS0YH2mYgj8vxG5M2J4F
         74dpCesC+hzn2FUA+EBY6O2YkMNmY8kbvkRu2FtLJD+bGr9qfyPNiU2I/VQFeYO4yUt0
         eh7mGBELYQCVGApuN35dyEsowp1TYFoPUh6eImL9gnJC5PR4UL6vBCEYWPdVsGM/5Ic2
         62+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        fh=48emAzz9wI5q/bnlV9g6XiyBVXGav3HyDQF2+Ok0xdw=;
        b=AFaeP3tBsy2zcfPGlS+0wluvKOzAwzwBmr39TV9JgHILO+IPqHkVKrY8AF4yWw5y29
         hoMWo1cL/FhFL91V20PcN+WGFn0nAVdzG0kX8gp7OfsKC0M6VeNdLyd1bRoqZTmGl90A
         JoljJXWSg9Ibg/1asOcCxLqsL28dRMIK35x/HOBGTPA+ku/jAUL1yKbu1kgbwcCqKBWs
         SWiTMc4CXmz0KP/g5+fFswkenLblkXNoXY9Nk3gBlRiIV01cgpeR/iZ07JMH3hDAaGDO
         +l5MYD62WBYjrO8BueIwN/GvTQbaIvIiw9eSY6Hn3ByJvqCM7Vrfw53wC+muB5uFgB32
         oqlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786002970; x=1786607770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        b=olmFMEAaARzUlmr490urLlICIm6xWmI+Pq9v/JsHwcQ52kLzcNqboZ1X1ubrMzCDHw
         jQVERf4JnDc/nj3i/+svlxtHlihWuqLG/j3boYD1V28+Kxa2XwvC8BYZgfnX5t3hKXYp
         h2oWA/FPNQYmmYSODucJ+8ZjzhxbDCYqRRPBklv3DEjlWLwMDF1Jl1L6bF878Cxoj6+q
         VP4EYbLLfqNvbiZNX/cKPORKTBYcgOiNJu0AAJmSjyoC0D3dhacibLuJI5JhVSfaruHx
         MHz/omPpuuYIZPfKobVx/x1oImQ/pQFeRd5N2kfUUyuDRmgjIe9Xddb2iXeoj/mRNZlw
         /DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002970; x=1786607770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alVwMbl9VBoTW/xDEpAPX7cYZNzoRuTYckTUnVBoUW8=;
        b=W9TpoOKuqDDMsJsCjgIxknfMSyBxBCo/ZDF5K6WApMUsTpp7noTrjn1p4h9lwhSAnM
         AO3Jmr9OlUi9BT6msfjW7nDDj1rUxD2Rs+uFMH47/KDugTRJ1XJ4a8x0SwJei4BOkCAx
         JcYWKfusGuI/46SudY+213o6NDarR7E50+Gnz1Ijx/0S/m7TIhGjybZPPgyC7HfrA+a/
         ic/CPTgEKctx7yMTdbvI4I7/GHQKCmh/jU1Mw1q4wiewUYj+XSOe5JqjzpmxFpnYch29
         nZpzLyomyxB5erodZrELz583hUMPvDirtlykqPqdzyd38VxadpFIl2ktgNe8jEAfV7va
         +/+w==
X-Forwarded-Encrypted: i=1; AHgh+RozTe56iR/JAzrHiNGdxuJGnaTRqiM8ca44QEgTVghjsYhqu8gcoqcQ4ya3e0QQbdGLReRbjdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfDv/SkB8QOQD4JKBCEQqmRvueY0rf5JjwRcKPAqQ+AgCnIIN
	g8OpC/vzuE8XJi8ipRzBYMj/q64z0TbBFfNldUZXav/KtgepkGpn2FqhtiNOjdOj02peyVMCZhA
	SzZLXyFdxuKWYZQQcFyIPk6APVainuns=
X-Gm-Gg: AR+sD12rdpV0jAjqRW1bKfUb3TGYmPbgCq3BB8Zf6ZIoRm963btxmDBdMDf8FyfJtCI
	2wuutaYJxwpAJo74wWwRLm5QMhHjPM/qs62DitEfoFl+U97TJh6cdr2p/volUQiiDdXHS0Hj/HQ
	J9FrMTwbBgJsAG4QilPdTb+fwQHh9boRuWhS1dpVUcEntdocOSpPbVAdRuApsjWvCsQU+0gADZt
	89psi0DbADvHh+vfme/hRjT5IhD0Vrn36MTl6cTUaYm5EEVh0WTd4iqnAQ6qkWPgLj1EKcON8ko
	rrGzhD+WrZqKdRthosW2awTJaI8sUJ+D6vx/p5JuVY0Sn/i5OotH4T0JVw==
X-Received: by 2002:a17:907:8995:b0:c12:525b:4e84 with SMTP id
 a640c23a62f3a-c2039b07297mr596013266b.9.1786002969976; Thu, 06 Aug 2026
 00:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74871a78-5243-4898-8e63-92e918912980@redhat.com>
 <20260706180003.2124317-1-r772577952@gmail.com> <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
In-Reply-To: <CANypQFZTFMxk5W4d3GViW6T1Nkxua3nVk3RNx0fie-26fpmXSg@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 6 Aug 2026 15:55:28 +0800
X-Gm-Features: AUfX_mxtNC4c7CPA0o1izUT8H_DyX4nTJyNBaErx8W8Ejd3wshynsUlDa_fGDSU
Message-ID: <CANypQFaqi25O5jh16KfLxeA7QJZwEKaEgq-t-hw-ErxS8a34jg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject oversized dinode sizes before i_size_write
To: anprice@redhat.com, agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 02:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> >
> > A corrupted GFS2 image can store a dinode size that is larger than what=
 VFS
> > i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u=
64 and
> > writes it directly into inode->i_size. If the value is larger than S64_=
MAX, the
> > incore i_size becomes negative. That negative value can bypass the exis=
ting
> > stuffed inode size check:
> >
> > inode->i_size > gfs2_max_stuffed_size(ip)
> >
> > Later, gfs2_quotad may try to sync the quota file and unstuff the quota=
 inode.
> > gfs2_unstuffer_folio() reads the negative i_size into an unsigned lengt=
h and
> > passes it to memcpy(), turning it into a huge copy size and triggering =
a
> > out-of-bound issue.
> >
> > Reject dinodes whose size exceeds sb->s_maxbytes before storing the val=
ue in
> > inode->i_size. Also make the stuffed inode check use the raw on-disk si=
ze while
> > it is still unsigned.
> >
> > Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> > Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFi=
OQqco4gjdmKVbdURg@mail.gmail.com/
> > Assisted-by: Codex:gpt-5.5-xhigh
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> > ---
> > Changes in v2:
> > - Drop the defensive unstuffing changes in bmap.c.
> >
> >  fs/gfs2/glops.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> > index 28f32424ee64..8c5d257451d5 100644
> > --- a/fs/gfs2/glops.c
> > +++ b/fs/gfs2/glops.c
> > @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, =
const void *buf)
> >         umode_t mode =3D be32_to_cpu(str->di_mode);
> >         struct inode *inode =3D &ip->i_inode;
> >         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> > +       u64 size =3D be64_to_cpu(str->di_size);
> >
> >         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr=
))) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> >         }
> > +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
> > +               gfs2_consist_inode(ip);
> > +               return -EIO;
> > +       }
> >         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> > @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
> >         i_uid_write(inode, be32_to_cpu(str->di_uid));
> >         i_gid_write(inode, be32_to_cpu(str->di_gid));
> >         set_nlink(inode, be32_to_cpu(str->di_nlink));
> > -       i_size_write(inode, be64_to_cpu(str->di_size));
> > +       i_size_write(inode, size);
> >         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
> >         atime.tv_sec =3D be64_to_cpu(str->di_atime);
> >         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> > @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
> >                 return -EIO;
> >         }
> >
> > -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_siz=
e(ip)) {
> > +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
> >                 gfs2_consist_inode(ip);
> >                 return -EIO;
> >         }
> > --
> > 2.43.0
> >
>
> Friendly ping. Please let me know if there's anything you'd like me to ch=
ange.
>
> Best Regards,
> Jiaming Zhang

Friendly ping. Please let me know if there's anything you'd like me to chan=
ge.

Best Regards,
Jiaming Zhang
