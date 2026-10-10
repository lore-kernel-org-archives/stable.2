Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DC3B42E6
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621751; cv=pass; b=KITtPQJv876W5SSQ0fVr51eaYFcPWsxPC/V0e1IxxAZvXzEjsaaghkp8rCwO1coAXu9vbHWjqpJ4+itzaeYqz8fmY8hMSmqEvyCgOd9cbqlsctkORJ+iRV1YENVF/uTIqDOVfm7EnYiFMosjwnGnlP9O1kKIiJRt++H7QK5uT0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621751; c=relaxed/simple;
	bh=kEAJK6t3AaZ4TJkaGOBguzXov8/MwYCD79SWLuU4BkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgeRo+XE6EoOQuAKbB6epjgdZsgo8Q2sM5tnBRN/hFiQIunHup7j5J3JkCBVTszXVgppmxBx+CtJL+HHEubyW810Jdo0XEm1Sh/C2N+hIQwNgwRm9JKrH4jqWDmfdXT0byKBsJCXm0U49KvPh/IIFwat0CE7YUxw1AUG+wMF2VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIswBr1N; arc=pass smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIswBr1N"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77df9781eso3519171fa.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791621744; cv=none;
        d=google.com; s=arc-20260327;
        b=fm14UZPLsaGMHjK2Fo3Dv7WPat//+JlfGTVeldTHNZQgVGYubzNVgUBUvgBJxFEA+t
         nYpDTaEOyRhc/bxBbuyrGF/bJ1oisKpf0qlKBUv5xtAPdFbNqsib2gchgP8bqpZe4dYG
         alpy9Mtj+SLvxn6iOWA/NfI5kQGPDvZK8NcrAV/mk1Nwba240Rsi2/6E5XaG7btjTkBY
         sK1eEqbc4oZvO216adS4Wc5shF8LvHCMgB3EXXA6Jca61Y/jUnXIn+7W/CDNhjnwTrKU
         ndmyLOkl/Igjdlb9WuA1/Ea9qiG7++k46adNQLw2o41OcRX1fYUeEKgo1btRa7B1fJzv
         7IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        fh=M++j55RJFpujKoShmuA+r6D6DVaKkgdutg53gNJnC5Y=;
        b=gRQSaLzKSLnTy5OrSaf95HBLV/DoBovbpqdNOkoqnuIHZy/KzCiYK6bmH7FiApLcHu
         yoj/sbSIxf9RxaS40N+Djm/xdxRgtDaBmJLvynTmyjUch8kVGFLax+IuLpHpXnJundw9
         vXFWOnFFnxQn7z4KsRvjpq2c9wdoNdBz8xoZvMlkgjxJVT91bgd8pNMuFasTyGLBeRiF
         Z/1xd2zz+8ts+f9VRe2RVbRPJ7Pean7pX3xiSNyKVz0WpMsMtqHEE5fMfmHb8SSKPelY
         U1L7baQ6/EUN1qdMuULje7Eo7rBDf04T3hT1iPJF3e/75MAguFdjw1DOyhlXhxpb9/bi
         KyQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791621744; x=1792226544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        b=TIswBr1NpfD6xTwQxmkWUE7h0fcIvUpWUHRuAp0JPN0/vOCUfAUOzHq07I3OhF5DE3
         ClKZcBkBf24UvybFmAuUUw1CY7N3vu6eRiS5+jiBvzgOft8Blh4UzFEB2quT46+cjdey
         J9ZMJhVWbCZgBwid9+ynPW9XrTMyLf+j7+6J0mQnHca5nAKmvPj1w3jmYwbqUCJGjhaH
         ijoFOHhWd5pEwxAqC1HvOj33YfYJ/EWGql5lBDzMDCDc4ektk4VkN8IRS9oORBFQPe6s
         9kKIngnYxRhkbnuYdHYfN8kdJ1EHHWdxea6ffkILpYENRMq5jJSAJST9sMjIhgXWm1M7
         ZlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621744; x=1792226544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        b=KBB2Y3SDhU3hE0H5qznxZpoD1zmH+O5EH9QknbLX7FYrTmDsde0s0D9v06Ps8R6Ckr
         Xk/+bCt8Z64Bwp09pV0+cpWyCSGfr5oMkZFOGlj3kblo8u1XZn8x9+HGaaVdoc7EtUsL
         TAOANRUy5LBvALrLG1mRrJ4j+vUjiD5u5lq25fmYwAizN6kZLQHJDR5NI+YkwqZ/P45U
         el4X1xYUqPLJUcvxdociTgmOkFTxvdv+Ban9u2UKsQ/l2lEpTkuCFpGMomQXNlz/Wp7X
         vS7inf9yzjemWVKQVFdqrkbHFme1dD/CgNftXd8nVFOZyk4JwMXf3KjKgh05saBGdVkT
         fX2A==
X-Forwarded-Encrypted: i=1; AKwUvBzzjLKlSfkPhBPKAJKDsfX1aTEEWwT+MEu/SnlAAvK6mysYydBdXDEZTQUmyvohhO17zMuNOOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4vJb/N8dJD0o3Ciibm1KE2bxnSDFFKOfCXza6D7LneCWjKY49
	fKoL5NcfCj6DNspcEzym8SYBqfX06tXEE2PZgbKTH8X2t1QDDtqasTAXDgCLDe0WAZoxzMyAf6s
	Rgv8RgirWUem87tcloUGE674YigLVMWrn341NLSnX9Zb7
X-Gm-Gg: AYBFou2pN0ysR0lksguGMEi3GHPjV8R8MEJRGI+5165hB3j77ne1VSwgzaHEwgHB4w0
	ECEqm3sL5kgdKt+XWIMrqBwjz3eHNtUJHHNRPl6AoxYYJk3IDSOUvAKu6HWq+jk9UeLv+MYh6fs
	JFsXnEn3SpDDL7fKDzt6+Gs99hbVTjHTvTPszyIngJw9aNuoi2NdjNGx3ugWbfidOdfl9K4f183
	H5qmBEtcJesz8gOyrQmbwx4YzVqXJuSKU6v8m5dngX6XOu3BLzS8IjXejCTMSqhROwwzay6xtRP
	1Em//8ffb581O/+Q3yX/8ScKKGWfoa/TA+HpGdBX7+OyKubXj9M1UYh6LrFsdzp1uEY=
X-Received: by 2002:a05:651c:a38c:20b0:3a9:8546:ee13 with SMTP id
 38308e7fff4ca-3a9c5749725mr7307421fa.19.1791621743887; Sat, 10 Oct 2026
 01:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010072548.2869465-1-bsdhenrymartin@gmail.com> <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
In-Reply-To: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 16:42:11 +0800
X-Gm-Features: AclHuK9ooXO3z8yNdOXPx3YQHo9QoaSrA5vIKEzFrmIGtggwd6d08SSXnanZZVQ
Message-ID: <CAEnQdOq+kqpBM4kB6HT-pAVt=LDqJuH3e8t95-OSVsJh2b+gRw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>, 
	Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>, 
	Kexin Sun <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the careful review, you're right on all points.

This came from static analysis; I don't have a KASAN report.  For
what it's worth, 32-bit x86 cannot provide one either, since
HAVE_ARCH_KASAN there is X86_64-only, and on 64-bit a reproducer
would need an out-of-tree family to push the table past the initial
bitmap.

v2 corrects the Fixes tag to 84659eb529b3, scopes the changelog to
the actual reachability (32-bit kernels with in-tree families, at
module unload) instead of implying generic corruption, and drops
Cc: stable.

Regards,
Henry

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=85=AD 16:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Le sam. 10 oct. 2026 =C3=A0 09:26, Henry Martin <bsdhenrymartin@gmail.com=
> a =C3=A9crit :
> >
> > netlink_realloc_groups() sizes nlk->groups to the number of groups
> > that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> > are registered later (e.g. a new genl family), existing sockets keep
> > their smaller bitmap.
> >
> > __netlink_clear_multicast_users() however iterates every group of
> > the departing family and calls netlink_update_socket_mc() for each
> > socket on mc_list, which does test_bit()/__assign_bit() on group - 1
> > with no regard to nlk->ngroups.  A stale socket therefore gets bits
> > read and cleared past its bitmap allocation, corrupting whichever
> > heap object follows it; the corruption repeats on every family
> > unregister.
>
> Do you have a KASAN report, or is this from static analysis only ?
>
> nl_table[NETLINK_GENERIC].groups only grows when group ids no longer
> fit in mc_groups_longs * BITS_PER_LONG.
>
> On 64bit, 59 ids are free in the initial bitmap. I count 58 genl
> multicast groups in the whole tree, 4 of them using reserved ids
> (ctrl, quota, pmcraid, NET_DM), so 54 dynamically allocated ones
> if every family was loaded at the same time.
>
> I do not see how a 64bit kernel with in-tree families can get there.
> 32bit kernels could, and then only from genl_unregister_family(),
> i.e. at module unload.
>
> The check itself looks fine and matches what do_one_broadcast()
> does, but the changelog should describe the real conditions instead
> of suggesting a generic heap corruption.
>
> Unless you have a reproducer, I think this is net-next material,
> without the Cc: stable.
>
> >
> > Skip groups that lie beyond the socket's bitmap: such a socket could
> > never have joined them.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: b4ff4f0419ae ("[NETLINK]: allocate group bitmaps dynamically")
>
> This commit did not add netlink_update_socket_mc() or
> netlink_clear_multicast_users(). This should be
>
> Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
>
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  net/netlink/af_netlink.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 9fdf964224ab4..8cc655aa927f1 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netl=
ink_sock *nlk,
> >  {
> >         int old, new =3D !!is_new, subscriptions;
> >
> > +       /* A socket whose bitmap predates this group can never be a mem=
ber;
> > +        * don't touch bits beyond its allocation.
> > +        */
> > +       if (group - 1 >=3D nlk->ngroups)
> > +               return;
> > +
> >         old =3D test_bit(group - 1, nlk->groups);
> >         subscriptions =3D nlk->subscriptions - old + new;
> >         __assign_bit(group - 1, nlk->groups, new);
> > --
> > 2.43.7
> >
