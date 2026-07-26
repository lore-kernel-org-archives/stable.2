Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD2372EEC
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054434; cv=pass; b=R9EEMjTcsbwAFVs4wyrqeju3Mn4SOWzFJNrjYuJ0UfpAkNpCqjJbKtN1C+0qhSQRfJYrOx4X3NspRq2pdVCc8GpWiYFiKvy3RxJTwjBqjRsX6RATO+hrTibDoQn4U0Y0uSw+NFq879YaWVkG16dq1EZFmB28ghM0xGcSbvTddZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054434; c=relaxed/simple;
	bh=8xJpMQdm3mK3+eLmyzRJS2c6sWbRz2JRigIWjuGEeSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwgfeLP4GS8KKF0SV4WOQDAK7PIzIXOredHYpYb1W4g1p51XWZ8vynUv0LYJUEMI2k+hXJ1XaT4Ehg9f62GXeGDmLvRFuAukjxyFSLkJHw9FROVeKP+Z9vC1hkbEWX71B8VKRLywzvkgWkd8uHjrZiWcDyxveT5D39lg/w4kT54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frg/fICc; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frg/fICc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d47266baso211355966b.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 01:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785054431; cv=none;
        d=google.com; s=arc-20260327;
        b=cdjtwc8H2xQHDtJjhqhUD0ZKBdneUOYmPy0679AatiVjPpUn14LkGA4TW/V7d8FB2E
         OcE0B5weyAJ878xK92aWUvXdSMFNk5UgFvanNhSTuU04McyCFAg821PTXb33IICcfLFC
         h7RnIceBVNBPnHX500RdwSrVUgGAGkW/b0uLycw9KnsPYe1qv5NJUvHBtdDYwAeccrtv
         aTNjN2i4tPvm8cBWsYK8A3sMlmtXb4lncD4f9FbygaktkdgdymYC3eidEGibnD7pkYam
         HM7XjlrINBNrCRuFmkF+DcKXvWJNmnp17xtaBsIG7IJwk66n8Y4smfQIaCKpAcC4LE3E
         PsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sF4WDvoDIvwYUO+wREyt677f++mr+wkgCWiGvStBw8U=;
        fh=+Qt68IITUNTAYNADuhTvo+zo/2aF8TD53LqGCrxLvwc=;
        b=mEoPFj8IATqGHL6eFueVH6YR0jgPtqlOxu1SAKyUYIhENnNos8LG86voDv5g0eAzGT
         792NTIatP+mvbS6ZZOT4UTyIby3vp8wzFztsdHOjcVXk48LNCJqF8NsG+OYKpkbPyRvQ
         dTx14FEnniJogn73704h1u5aSXY34JBSM84YiVcMz0ci4dyZQgOrJn1J4sg7Ofyqotrh
         TtEYlEGMwkRGBc4fpDdUM6m3bQ9lQHshXL0m2qpDFg8HTYGLV0JijKDauJb1tXPr73nc
         L7CbSML89EtVnrBfuByNRyICNZ0c/YKWBD3RFd14TN/WoemECUpkin8hHATMxbsqx3P4
         74Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785054431; x=1785659231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sF4WDvoDIvwYUO+wREyt677f++mr+wkgCWiGvStBw8U=;
        b=Frg/fICcSEPoD7YAXtB8GVutRMJ6prJ2gpuNJ9KRodn+A6ySssjPWhXTZR/3P+qF8L
         sV6yXCmPasbiF7+Qplpn1EMHBQ6DcBYFUz2pagIe4Nw1X9fhDqEPuIddYPK1OIDMxuor
         ERP++pA3Q8GN054urkPSZPI1xUreCWXyicNNjJXw6wA4RJBEQCrcwRl2mchi3GLYr/C3
         IYQ6zVqStWp2zlp8scKfJgBbntF+f4aHKjrggMu0E5wF56A6CiI156t0XypOQykpkaRW
         0M33vTRjaBJcWjzgAWo8lgUICuAa6lDKMsKiVFRXFkJRXzI4bMu8nXGtvfwnbvW/YZQ2
         AHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785054431; x=1785659231;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sF4WDvoDIvwYUO+wREyt677f++mr+wkgCWiGvStBw8U=;
        b=bgW+JJak3t3ZQtTbUL95pzwroqC/Q06UCfe4T7/Dx1ETW6JL0NQbCituZUvSBUkUlD
         Ehm5fwoUTHgQVB3eDAhnPe6uLy4HzQx15rnvmnRv+qLdk+ycZ21/BP/SqPC6DrHuqmCX
         EEhtpt+4ckQtxWMsddPVsVDK0DPUoaJZhdNtQ+tD2qPnJHLHVMbMGc31sSc6HsPMUsxk
         YK7VaP0swX76l60xN14GgSWx9O9DAZE3ncB2oBncRi0xG5JqVquAMkPSq720Ue3r6B6V
         rtfuSc+KN5wIazDDcQ9nN0y18yZlrTxuBBAtogr+8M2IITlx4mIStH6iDCoUnZqLPm1Q
         aO8Q==
X-Forwarded-Encrypted: i=1; AHgh+RprIke0zxW4am7E5B7PtP3jYSe0vDBv38694pOB3ZsXQ4qBFWox45NC1AJejALtN15WkdLb0rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyFOlvMpVINbJjC6JtvvpzhbWW1pbWlJ4K69927AgXkkkzFOk
	cgrIqV6z4MR3204oE31MdECAOt99Jwf8asUJifebG8HaIsAoWfK1Ypujap6I3Iif0f9tixIGOji
	CO87cs/HGrMLC/PDzxXutcMCVakRQGFQ=
X-Gm-Gg: AR+sD12jNlSYvJfJ3n+nwryabixsC46WfWhH/Vfxd1tp7a01cDuZc50iCybMZHbDi7Q
	xdd9OanyT4roPBRkIA4XObHtpZ45xzcxNs4vcsgdm30/meYT8/oyKyJANXq0IVlSLDL3m9DpoH6
	9ld/87Dg6EhbBJ6FnX8pDcGmyf6DYbG/O2ESyuYq8e+PdVel9TdV3xrj4KsU37zc5vQlJHoN2x8
	gebRCT5NTWLoBwIXgWs7qIThQef0hjZhenMSfyOfmtG5pDt93IwBA9SJfmMOPVb/jfXjJir1AXU
	jtza6GJoNbJ5TITiX7I=
X-Received: by 2002:a17:906:9fca:b0:c16:5dbd:8210 with SMTP id
 a640c23a62f3a-c1f1f044371mr201495166b.44.1785054430944; Sun, 26 Jul 2026
 01:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719175028.988301-2-bestswngs@gmail.com> <20260724142321.GL418547@horms.kernel.org>
In-Reply-To: <20260724142321.GL418547@horms.kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 26 Jul 2026 16:26:33 +0800
X-Gm-Features: AUfX_myLG6i4U1IzbrHsuQ-A43Tundwiu5UTIXpzXAkoffn5gurXuFt2WvlYFmw
Message-ID: <CANgPUi0sCh6gtBMywQMTnudMLdVXFySp6LD7Vz-1Rh3trSd=eQ@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: tc: serialize access to nsim_block_cb_list
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Simon Horman <horms@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=94 22:23=E5=86=99=E9=81=93=EF=BC=9A
>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260719175028.988301-2-be=
stswngs@gmail.com?part=3D1
> ---
> --- Patch [1]: [PATCH net] netdevsim: tc: serialize access to nsim_block_=
cb_list ---
> commit 27d18d348023b46d852b44b24e6f4ca81ab39bf3
> Author: Weiming Shi <bestswngs@gmail.com>
>
> netdevsim: tc: serialize access to nsim_block_cb_list
>
> This commit attempts to fix a list corruption and slab-use-after-free rac=
e
> condition between the nftables hardware offload path and the TC control
> path. It adds a local mutex to netdevsim to serialize access to the globa=
l
> nsim_block_cb_list during flow_block_cb_setup_simple().
>
> > diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
> > index a415e02a6df1e..30dd7f924b716 100644
> > --- a/drivers/net/netdevsim/tc.c
> > +++ b/drivers/net/netdevsim/tc.c
> > @@ -72,11 +72,13 @@ static int nsim_setup_tc_ets(struct net_device *dev=
,
> >  }
> >
> >  static LIST_HEAD(nsim_block_cb_list);
> > +static DEFINE_MUTEX(nsim_block_cb_lock);
> >
> >  int
> >  nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *t=
ype_data)
> >  {
> >       struct netdevsim *ns =3D netdev_priv(dev);
> > +     int err;
> >
> >       switch (type) {
> >       case TC_SETUP_QDISC_TAPRIO:
> [ ... ]
> > @@ -84,10 +86,13 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup=
_type type, void *type_data)
> >       case TC_SETUP_QDISC_ETS:
> >               return nsim_setup_tc_ets(dev, type_data);
> >       case TC_SETUP_BLOCK:
> > -             return flow_block_cb_setup_simple(type_data,
> > -                                               &nsim_block_cb_list,
> > -                                               nsim_setup_tc_block_cb,
> > -                                               ns, ns, true);
> > +             mutex_lock(&nsim_block_cb_lock);
>
> Simon says: I'm wondering if you could take a look at the issue flagged
>             below as it seems to undermine the fix proposed by this
>             patch.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but will the new nsim_block_cb=
_lock
> actually fully serialize access to the list?
>
> If tcf_block_bind() fails in the core TC stack, its error unroll path
> directly executes list_del(&block_cb->driver_list) while holding only
> rtnl_lock.
>
> If this error unroll happens concurrently with an nftables transaction th=
at
> holds the commit_mutex and the newly introduced nsim_block_cb_lock, the c=
ore
> TC stack will modify nsim_block_cb_list completely bypassing the driver's
> local lock.
>
> Could this still lead to list corruption and slab-use-after-free bugs whe=
n the
> concurrent nftables transaction walks the mutating list?
>
> > +             err =3D flow_block_cb_setup_simple(type_data,
>
> Simon says: I think the problem flagged below can be considered
>             in the context of possible follow-up.
>
> [Severity: High]
> This is a pre-existing issue, but does adding a local lock in netdevsim m=
ask
> the underlying systemic race?
>
> flow_block_cb_setup_simple() modifies driver-provided lists directly with=
out
> internal locking. Since the nftables hardware offload path runs without
> rtnl_lock, unprivileged users can configure nftables concurrently and tri=
gger
> list corruption.
>
> While this patch addresses the issue for netdevsim locally, won't this sa=
me
> vulnerability persist across other hardware drivers (e.g., cxgb4, prester=
a,
> i40e) that use TC_SETUP_BLOCK with statically allocated global lists?
>
> > +                                              &nsim_block_cb_list,
> > +                                              nsim_setup_tc_block_cb,
> > +                                              ns, ns, true);
> > +             mutex_unlock(&nsim_block_cb_lock);
> > +             return err;
> >       case TC_SETUP_FT:
> >               return 0;
> >       default:

Hi Simon,

Thanks for the feedback. That makes sense, and I agree with the
concern. I'll work on a v2 patch to address this.

Thanks,
Weiming
