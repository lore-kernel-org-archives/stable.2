Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F536F8FB
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526999; cv=pass; b=HwqTbBg5kkbBgeWAcoCm9ZTz93q+XPNiC/cZepAE3kIYRPdNAOnJEBbKOw0ap1HDHkuHXFdPyh81P/emp2dTD5sof0TnfKrY1Pnhy6yVxqxfzsaVPUJL/iEsvqtpwp9+wGM6mV7fCoKbYraE+vrvm6kp5oOhc78SDnQuCqzm5HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526999; c=relaxed/simple;
	bh=/cCoEIAMZjgDwndNc5TH4+TopiGNAKrc5bmeS1zi6bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG+rm1KzUJ/CxwIbXg1RH2lGMG5K2eGSH42IaGekbpwBeMm+c6jsTNxYaaTpjIF4l+skg3VDUNH+Ck1+bFmIYdLvHx1l0fLxh8HLKujva8MLV/6oez0yw5ciAD5noT4Ux1SgWJ0O8L9ygHW/1ftlObwPPThpy0Zd9PiegpWTJ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fay8I8/v; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fay8I8/v"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so1704073a12.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 09:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526996; cv=none;
        d=google.com; s=arc-20260327;
        b=e59Zxs/ITtyBecLEFBeekunMDxR7nDp9f9MfpK2OrzEBSmBXT5zo2Y7WSX4OQUL5qN
         fnq7HRHhlXPQ63JYAfq8WGvZc5bZ5XUjFYvzuu0hkGyzdM7EYE/vegpKmAaMIvdShe5Z
         TUcY+g6z4Z2O1NWVw79UzkSTNIJqm3uwd6zQBIlwcals3s44BFF+WflJvVeqow+/sk1c
         KHswecTH7ezuYKnQpIJO51aZw5wr4u1rxcxU2OGTKc3w8226Ych+EhTkblccUeOMDeFb
         eBTAv40lSqaCXT42EU5rcRPcC8tLuHDXmvpUCSpMm37+WcqIqJU2+WsKeAgMJ4wQ9uRX
         5h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NhVUTGb4dwhaH+1X487bCAmqqigGbO5f/feF/gmVFJ4=;
        fh=boZlSHyvR4+e5W8MdWWZyKFC2U9wQ/yVowg14ZosBqM=;
        b=OtRDNi8YYdyGnFEQAw0E+Mb6EYss/DdS//KQLNniJbXs97ggnfoBluPhaRo5reI2gA
         8Ak9aXypNdxBBpg+37ML+HrM1Fm45hTnSjdqkz0XT6G2olSQz6dNxYv0//uQzEd5xYfD
         1+KcEQ5qZ0O2WaLhub9dfezCf/JM3WLnoB8m0OaFmX40RLFRfH8g1NMgeFK13mveDRZO
         LiTZmfZqjHE4mKfhyczdM/WLPaMuvEegIXhBHWeIki2m6Ss/UTuulITm6Bj6YJa1TGjm
         ZmUytxRpJqtL+ubN7ffzyAqjhTdzkW6LAuD5wwicf4bevTlmowKu9VzkFAb3g/VZ/bAt
         sNjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783526996; x=1784131796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhVUTGb4dwhaH+1X487bCAmqqigGbO5f/feF/gmVFJ4=;
        b=Fay8I8/vpDP1QBgBTTYX0h13G/I/vEu+ovK0C+YLKeZIv55mE7xkQv3XU22t64LuOZ
         JzNANBMWND42Ka0ImxBBmyOUpDIksGdM/SnT7cYmFSsAv21eVm1brGwuRoL8S82LlM81
         55GnewrZEcKYNiHhqZUjxa30JTtESyft+waSM9Goe6tpjXYRdztl9Hja0fVGUvpe6/JW
         /1alxPL/NuHRGfsLUbABdW0+z6zh2UmFGBBWkLv8v4/MqvgJT8jFVE5cdBaRnUqDrfVz
         sqTFwF+/Dpoz23CoJwxe+SoW07tVA1CSVyrWyPF9i6ZHxFs9OH+yhK59IlqzwGVf9BRO
         SoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526996; x=1784131796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhVUTGb4dwhaH+1X487bCAmqqigGbO5f/feF/gmVFJ4=;
        b=IorOjHVYzblOm/+XhblaMvEggNHyp+PkSJwqFR8gzw6LnryBUmp1YByzOCLjqnTqRp
         xmcV6i2z2mhPVkHeA83d5Bp0u/7sFqhPdOrx/REkSyYgGlV72h5Fpvuc1IdkzLiPSs/X
         /4SKx5f+DIJgLg1+mHIzusCHVkkWcjrIBUAd3AyTPTH19CzDXEsA7MYmtMdhlKaHOHzN
         0GiCE8s24TIaKye8BJdZE5CT5mTbncRn60dLQGVvKEYWq0yqtH+dXGb3dDG26G+tnp1c
         ES45RX1wR/12iRlojCCZiycFIQnKnsyCU2B4rU1ghEvO7EaAu6Q7o3oxq5bx8jgmZY0E
         CHbg==
X-Forwarded-Encrypted: i=1; AHgh+RqnyrpsfrJmHbS1GrbwTg5+2q3e673RFivaSNIgpfOFT8HzBEJeIqNMGQqklqXMWVSR8Y03wAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPisXSHOlRGY1KZMEttMWqzI8HRw//eCJkRkfkqpfj0UJ9kEt
	u6Dx4MHlOHLNWyk1TqYgcMduektg/sFL62PGWpJEXoQWKhQnkaPM8IlSfH52WEL5dXieJ/OdihA
	EUm+ihPL06PKSyiG9I7luwAmmE6dsarY=
X-Gm-Gg: AfdE7cm6scsDkg3l4fhsVFpATKHHCE1G1fbVAVuXPIQLdi4r1HpkMZGRz8cNkd3fqSv
	43GjGhkndXsIB/nL9W3MCjvBYTD1mZRB1qVaSfWAnDmpO5/I7Y1q9O3hUmNLWCQZsEJyplbsnVd
	MGrxprz5ust+Gl4QyqarVjna12EY9XnvQ0aGmjfmuJjt6c+IdgMUlgzJcBgBlpL6wRq4z8n3E3d
	z9ZSpAkOg3maItRFtin2XqMZaqe6tZBUxLejUXMQaINMPRbBoyKsixa5dfPzvdCl1riWfqEO5dW
	3qSTASzSb/R79zaBXC5R/nDueBmb
X-Received: by 2002:a17:907:9709:b0:c15:dc92:5df with SMTP id
 a640c23a62f3a-c15dc9207cfmr57067666b.49.1783526995710; Wed, 08 Jul 2026
 09:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707180235.1142581-4-bestswngs@gmail.com> <20260708052855.GF9392@frogsfrogsfrogs>
In-Reply-To: <20260708052855.GF9392@frogsfrogsfrogs>
From: Weiming Shi <bestswngs@gmail.com>
Date: Thu, 9 Jul 2026 00:09:18 +0800
X-Gm-Features: AVVi8Cc62Fx0LBjbFwac7xQonQf9upQeMKEfyzwrMHGOC-FWNYnt6BGYtL2Isds
Message-ID: <CANgPUi2ydzD7P_agT_c5EACVbjqZ=ujsr0W6TYsBsMYjqiw9zQ@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: reject attr leaf blocks with inconsistent usedbytes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>, Xiang Mei <xmei5@asu.edu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=89 13:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 07, 2026 at 11:02:38AM -0700, Weiming Shi wrote:
> > xfs_attr3_leaf_verify() checks each attr leaf entry on its own, but nev=
er
> > checks that the entries' nameval regions are disjoint. A crafted leaf c=
an
> > point several entries at overlapping offsets: every entry passes the
> > per-entry check, yet the summed entry sizes far exceed the nameval regi=
on.
> >
> > ichdr.usedbytes is kept as the exact sum of the entries'
> > xfs_attr_leaf_entsize() (see xfs_attr3_leaf_add()), so for such a leaf =
the
> > real sum no longer matches usedbytes. When the leaf is later repacked,
> > xfs_attr3_leaf_compact() resets firstused to blksize and calls
> > xfs_attr3_leaf_moveents(), which subtracts each entry size from firstus=
ed;
> > the oversized sum underflows the 32-bit firstused and the following mem=
move
> > writes out of bounds. The same repack runs from xfs_attr3_leaf_rebalanc=
e()
> > and xfs_attr3_leaf_unbalance(). The only guard is an ASSERT, which is
> > compiled out on production kernels.
> >
> > A single setxattr() on a file with such a leaf, after mounting a crafte=
d
> > image, triggers the write:
> >
> >   BUG: KASAN: use-after-free in xfs_attr3_leaf_moveents (fs/xfs/libxfs/=
xfs_attr_leaf.c:2788)
> >   Write of size 400 at addr ffff88802b187f98 by task exploit
> >    xfs_attr3_leaf_moveents (fs/xfs/libxfs/xfs_attr_leaf.c:2788)
> >    xfs_attr3_leaf_compact (fs/xfs/libxfs/xfs_attr_leaf.c:1790)
> >    xfs_attr3_leaf_add (fs/xfs/libxfs/xfs_attr_leaf.c:1563)
> >    xfs_attr_set_iter (fs/xfs/libxfs/xfs_attr.c:556)
> >    xfs_attr_set (fs/xfs/libxfs/xfs_attr.c:1244)
> >    xfs_xattr_set (fs/xfs/xfs_xattr.c:186)
> >    __vfs_setxattr (fs/xattr.c:218)
> >    vfs_setxattr (fs/xattr.c:339)
> >    __x64_sys_fsetxattr (fs/xattr.c:774)
> >
> > Sum the entry sizes while verifying and reject the leaf unless the sum
> > equals usedbytes (so the on-disk usedbytes can be trusted) and that
> > usedbytes fits in the nameval region [firstused, blksize) (so the trust=
ed
> > value cannot drive firstused below zero).  Both checks are required: th=
e
> > first alone can be bypassed by forging usedbytes to equal the real sum,=
 and
> > the second alone by forging a small usedbytes, so only together do they
> > bound the actual summed entry size against the nameval region and preve=
nt
> > the underflow.
> >
> > Fixes: c84760659dcf ("xfs: check attribute leaf block structure")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v2: drop the inaccurate scrubber reference; explain why both checks are
> >     needed. No code change.
> >
> >  fs/xfs/libxfs/xfs_attr_leaf.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_lea=
f.c
> > index 86c5c09a5db4..9814dcfbd7ac 100644
> > --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> > +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> > @@ -300,7 +300,8 @@ xfs_attr3_leaf_verify_entry(
> >       struct xfs_attr3_icleaf_hdr             *leafhdr,
> >       struct xfs_attr_leaf_entry              *ent,
> >       int                                     idx,
> > -     __u32                                   *last_hashval)
> > +     __u32                                   *last_hashval,
> > +     unsigned int                            *usedbytes)
> >  {
> >       struct xfs_attr_leaf_name_local         *lentry;
> >       struct xfs_attr_leaf_name_remote        *rentry;
> > @@ -344,6 +345,7 @@ xfs_attr3_leaf_verify_entry(
> >       if (name_end > buf_end)
> >               return __this_address;
> >
> > +     *usedbytes +=3D namesize;
> >       return NULL;
> >  }
> >
> > @@ -376,6 +378,7 @@ xfs_attr3_leaf_verify(
> >       char                            *buf_end;
> >       uint32_t                        end;    /* must be 32bit - see be=
low */
> >       __u32                           last_hashval =3D 0;
> > +     unsigned int                    usedbytes =3D 0;
> >       int                             i;
> >       xfs_failaddr_t                  fa;
> >
> > @@ -410,11 +413,21 @@ xfs_attr3_leaf_verify(
> >       buf_end =3D (char *)bp->b_addr + mp->m_attr_geo->blksize;
> >       for (i =3D 0, ent =3D entries; i < ichdr.count; ent++, i++) {
> >               fa =3D xfs_attr3_leaf_verify_entry(mp, buf_end, leaf, &ic=
hdr,
> > -                             ent, i, &last_hashval);
> > +                             ent, i, &last_hashval, &usedbytes);
> >               if (fa)
> >                       return fa;
> >       }
> >
> > +     /*
> > +      * usedbytes must equal the summed entry sizes and fit in the
> > +      * nameval region; otherwise a later repack underflows firstused
> > +      * in xfs_attr3_leaf_moveents().
> > +      */
> > +     if (usedbytes !=3D ichdr.usedbytes)
> > +             return __this_address;
>
> This part is clearly correct.
>
> > +     if (ichdr.usedbytes > mp->m_attr_geo->blksize - ichdr.firstused)
>
> This check is still novel to me -- neither online fsck nor xfs_repair
> check this explicitly.  It makes sense to me that usedbytes can't exceed
> the number of bytes between the start of the nameval data and the end of
> the block (the entries array grows up from zero; namevals grow down from
> $blocksize).
>
> I wonder, will this make it harder to salvage xattrs from a broken leaf
> block since the verifier won't work?  I think it won't because the
> salvage operation does an xfs_buf read with null ops, but I wonder if
> you've considered this point?  Or run this through the xattr stress
> tests?
>
> --D
>
> > +             return __this_address;
> > +
> >       /*
> >        * Quickly check the freemap information.  Attribute data has to =
be
> >        * aligned to 4-byte boundaries, and likewise for the free space.
> > --
> > 2.43.0
> >
> >

Hi,

Yeah, it does affect salvage. The read uses NULL ops, but
xrep_xattr_recover_block() gates recovery on xrep_buf_verify_struct(), whic=
h
runs the verifier including my checks. So a leaf that fails the usedbytes
check never reaches xrep_xattr_recover_leaf(), and a leaf that's only off i=
n
usedbytes (entries otherwise fine) now gets tossed instead of salvaged.
That's in attr_repair.c, not this patch, so the verifier change itself
doesn't need to move. I didn't want to poke at the salvage gate blindly
since it leans on the verifier for the firstused/count bounds too, so how d=
o
you want to handle it?

On stress: I ran fsstress on the patched KASAN kernel, weighted toward the
attr ops (setxattr/removexattr/setfattr etc), 4 rounds of -n 5000 -p 4,
unmounting and remounting between rounds to force re-verify. All rc=3D0, no
EFSCORRUPTED, nothing from the verifier. Haven't done a full auto run.

Best,
Weiming Shi
