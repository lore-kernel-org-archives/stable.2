Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AB4ABBC8
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719756; cv=pass; b=MfPxoW2h0OVQuV0RhXa3f3Z13wO1NEPbLWlfmMJ/ZIBgdcUGUULk3Slxr8R4SaoEGE9yHXNV98iblGdq/uZ8WZbjSw4z1JV1defWYWzgPmEZrV3Z3f6i1hsmVbe3aAkeQDIpeWRMvxoIPWs2TwjDORr61XkK9to6FOZgIiKVmbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719756; c=relaxed/simple;
	bh=caIY5SD5XMVlz9br5cyq8OQ2QzYvgdCKzRbGP9MjoRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUbd5FH2CAJXyoSvxScBdQEVLGY1cN4yne0Oft7qzyu2VLuGDxIZlyBzmFvF2/OZejrSpeUJLtNOVg/qme14+k4xf3uVUJcEV+6hwkIC38IgT17v0U1z9qbMEDOPuycng0+WhJRwkgqzs/J/YRHDr6vW+auuGJhP0iXGTt6S4iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jnHH+TwR; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jnHH+TwR"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so444366b3a.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789719753; cv=none;
        d=google.com; s=arc-20260327;
        b=orVtqQThCu2d2gyFFEGFQoPtMaeld+IdW4jmoCPTPhywSA4CZy8AqO+XVkcvpjDyFw
         v/uDaLOaqO7cJRpQocAi7XKrMIn6hPbWB4iCrBe/AXCCgq+Y7/X6uI5i8KyMtC8Oz/2y
         8NAmcaWMWGD0Vwz/NUoAFajtmcrwaFbHr2wu27+ZP7QlkKOlcvHSfO6nQPcA7ByN50F6
         FXfxe7TSGn/kfqBHNwshQAnBjMT1WE9Hx4hDqsh6KAWli0fRUNDGN2XK+kcbKI0KjzOS
         qO1dY9XJuoKpzD6te85RRBqt84JCNYoJASm0E532of8XKlNvnn33XXZDodppzxzZU0+E
         cIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dfFd0zyH+HOjbziiDPWCPHKxOHER1oFd6/oxLP47/YQ=;
        fh=78y3pi8dzf4gXNE0U5Y1kpo11zxRohKRJ4cIK/OeNc8=;
        b=X0+qgBx/3sfUrMkSWXdqr6Nfjp34RlUVvNqQ+xGbv0HSTU4ZCgKQ98gVNYwTwGQ60t
         YMDSoV3W0KQsQRKgZeG3KlRG7x49zg1s/43s3Q9ml7uh+VFiyJeiQvOcf8PmGcXfRfS3
         DqP07uzPs8TuYUndeCv/vPKoaVkJbopLHLFTs7H6K0FRrvnpycmE6SNaSMvxDBy6Zi38
         cNT8f5rPt8rdtmeeFU/aoAc66OYCjZ37Ix/pAGk+QZjPB9kCiOyy7w+WgdGSAK2+84mK
         kgF6drYUwDAmbOmsqt9iya9Wd4HIQJvW92uBIoXN4Apj3vmHLXurMGgRs8K4DbmAI8Nj
         Tu/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789719753; x=1790324553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dfFd0zyH+HOjbziiDPWCPHKxOHER1oFd6/oxLP47/YQ=;
        b=jnHH+TwRDx8i6scEHeASTLHFTk2Dm8BDoHigfPTI5Zul4S5hAnJMWBFVhc9Pa3xXQC
         nxLU0tbF3WMafBZJceyBLAWkAfNXY4m0Cv7Iq3ze0qCijcIa1aPBND8Pk9CAJCIfouCI
         FGQJQxSXMyAwqlHGSpj7enVuTVuYbVho0F/bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719753; x=1790324553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfFd0zyH+HOjbziiDPWCPHKxOHER1oFd6/oxLP47/YQ=;
        b=FaEAn2d57DN2jNyw6cfgoPlxO+IQOLyQVUMwEtvuWeX4WilNPc26Vo/FaZViu1JEEL
         jGy3m0nX5RZkF4F0O5KTk5fpKqkUDuOR3SmUaG2H7tEhAcY6RHQriwhL97lRIsnfhq1Y
         KYJPKEJ8jsnaazlnKmJrbYVn/nPCWBG2XD262oT1s8Koaa1O3ZT04qOEolh9s0OXeKmo
         uKdybQgMVzH9LXyy9bM4mLQeQDvKlUNy8ZbgPqFEOfFpeOACQpm9XhuII015wtdnirhP
         Yhxn9EfAdD5d6gP3SvuhzlpGI7xL9nGIF1OM1UMIJSQSRitqqUJ2he/8hZPrWXqjdw3p
         md0g==
X-Forwarded-Encrypted: i=1; AKwUvBz4fASK4PkWXslxr++Nil2RPeXxYsMJsizAY8kq30FSSKGu79F6p5SoKXKKms9jsHJlfuSVZkM=@vger.kernel.org
X-Gm-Message-State: AFuF++lgSyjvXcuyWHZR8civQcYgfRqmCXpGDTsF7C6blqDuA44sNA7d
	vuCp5H3WZHQJ9CkIEqmRxzOmMFYDTEPBKOoZ6npU84T8iZGTPmENRr4223EkLk4QBSwpl3rQZ73
	OoWG7GMNypFjePO8QWtiK/hM7EhQperrCbPrMuQl6
X-Gm-Gg: AYBFou035+nF0ikRWsbvuSNpxu1KBKnd++wqJB+XQkmVdZ4MCnzsri2TP9nh0Y6qiXz
	O7R8ACbMKPYHkZawO6bOCL3wQmWzApeVhklJIvom+hc0rdzP3UDZPlFmWK9Mglg7Iu8y4Nj07q0
	m168ShJIZuhMvddlGireSxi3EOdOx3se0Qy33oCpiOZBylAgB93ka/95mZyaVkMKTpeAYnNMoKJ
	17ERyglzYoZKQj8pUtZcG5LPnoWZl8f5KXt3Y6AchYANyHPSIFnbvz5y5RLnqDobV4WCgpsr3S0
	g97BoYmLBa3dp3bNZa672j4t2lpiGuQ1YxQHLA949CyCXGRcNqBGwuoRUdNYUX9chgRXBHf9DwG
	Txv4gkIYLP8SOo2rDc6wcFY+EV4f9F/J+C2DQq+YgqTRR
X-Received: by 2002:a05:6a00:114e:b0:86f:5e14:2422 with SMTP id
 d2e1a72fcca58-874db7f1a53mr3581101b3a.1.1789719753310; Fri, 18 Sep 2026
 01:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com> <20260917120801.GA51261@horms.kernel.org>
 <CAKYWH0RMJ+sxMku8UGmmcujnO9fJBg3Ok_ofbvyh5eTJm=2uTQ@mail.gmail.com>
In-Reply-To: <CAKYWH0RMJ+sxMku8UGmmcujnO9fJBg3Ok_ofbvyh5eTJm=2uTQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 18 Sep 2026 04:22:21 -0400
X-Gm-Features: AcwNN1VNKDMQQ1YJv2NJsWphPozLgYauN8fRo6TJ9YyGJPkWDG7ogpL7mhpSml4
Message-ID: <CAM0EoM=uw-3EAVQBWWMtNSHJjzcS-ftfFYpbSX+BXJyx-gdjuQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR aliasing
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:37=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> Le jeu. 17 sept. 2026 =C3=A0 14:08, Simon Horman <horms@kernel.org> a =C3=
=A9crit :
> >
> > On Wed, Sep 16, 2026 at 06:01:14AM -0400, Jamal Hadi Salim wrote:
> > > A u32 hash table created with an explicit handle ('tc filter add ...
> > > handle 801: u32 divisor N') keys its IDR entry on the raw handle, whi=
le
> > > the destroy paths free it under handle2id(handle). The two key domain=
s
> > > disagree for handles in the 0x800..0xFFF htid range:
> > > handle2id() folds them back into the auto-allocated id space (1..0x7F=
F).
> > >
> > > A manual table therefore leaves its raw-keyed IDR entry unreachable o=
n
> > > delete (a permanent leak), and its delete can drop the idr entry of a=
n
> > > unrelated live auto table. A later auto allocation can then hand out =
a
> > > handle that aliases the live manual table; u32_lookup_ht() first-matc=
h
> > > routes lookups and TCA_U32_LINK for that htid to the wrong table.
> > >
> > > Key the divisor-path alloc on handle2id(handle) so allocation and
> > > removal share one key domain. A manual handle that maps onto an id
> > > already in use is rejected with -ENOSPC, and auto allocation skips id=
s
> > > held by live manual tables.
> > >
> > > Conditions to recreate:
> > >   ip link add test0 type dummy
> > >   tc qdisc add dev test0 clsact
> > >   tc filter add dev test0 ingress protocol ip pref 1 \
> > >           handle 801: u32 divisor 16
> > >   tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
> > >   tc -d filter show dev test0 ingress | grep 'fh 801:'
> > >   # unpatched: two live tables with handle 0x80100000 (the pref 2 roo=
t
> > >   # hnode is auto-allocated id 1); patched: the auto hnode takes id 2=
.
> > >
> > > Also tested with a poc with a live u32 table on the block, add/delete=
 a manual
> > > table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fails =
with
> > > -ENOSPC because the raw key leaked on the first delete.
> > >
> > > Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failu=
re to free IDR entries for hnodes.")
> > > Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
> > > Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@mo=
jatatu.com
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Tested-by: hybris <hybris@mojatatu.ai>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
>
> Hi Jamal, Simon,
>
> Thanks a lot for the fix.
> One nit I'd like to pick is the "Fixes:" header.
> Specifically, it mentions my patch:
>
>      Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic
> failure to free IDR entries for hnodes.")
>
> However, what this does fix is *not* a regression introduced by the
> above patch,

This patch fixes the alloc/remove key-domain asymmetry introduced by
73af53d82076
Prior to your patch, the alloc/remove key domain was symmetric; you
forgot to convert the "else {" part in your conversion, which this
patch fixes. The comment tries to explain this detail.

cheers,
jamal

>but an age-old inconsistency between handle encodings.
> So, It would be more accurate to mention an earlier commit:
>
>     Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handl=
es")
>
> What do you think ?
>
> -Alex
