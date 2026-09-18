Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18D221FC6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709849; cv=pass; b=XjGkHIzXxteEol4/ORfOZRfIH6Nidpc6DOEGsMWuQoCSBzRUwFm+n1X0j2w/v5vHqj9GG7RKGembOSA/N2/txXtreoS90N7Y9Fi9coJx3ukJV/zkpiWdgHGcKMnGMHf6afTlaL5Bcxi0w7Y1Ikee9+KN6YCIeIvQFmnj3xtVosM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709849; c=relaxed/simple;
	bh=Mvrna4jvxkFVgS1b64bAUhxq+n8ulTPOweBBUkKg7uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTbxtftTQqeE2u6nnrZUTb2vCGe1Fe/gidKc5vaS3qE290t4X+iP5dLZkmnHwp+LeVPA9Q0vlLUaNz6e88aJu7J72B6uEpvE/dQzByli5/uiHYr9zqNRNn8Kma2AZ3yS2zC2Y2WbWao4EguQgsg5+a+23F9A7fsI8fZCOE5896w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiwRBBFN; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiwRBBFN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1196652a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789709848; cv=none;
        d=google.com; s=arc-20260327;
        b=UoGlSsx6SNtY3Rtm+xBLLu8Fcq6jUTah0BkrYwPKc4P5KF0GvmR+uShlK8hJMXYl/3
         7nrl79tIfCD7+QWFs0fi91VFQSKyhzqGqxeIaAUzA0AFygWPQNJqXxqf5AaeHsvWEx/x
         3zA24S+hmySTLhoJPCAJJbjCljZ2iOokKrHsONZBUdbKtwmcL/X8BY/HlmgPh2MvIHbI
         WSD3Vah8oGVfpx4qnxNKTH/DEa/aiELxmrb8mMr7NNf1ZQRU0ZOOo/sT8q9Hc69GltDV
         QxrtoObRsM+bBE8E9BpS00OhilC5oJeN2ueEYlU7rX84K6+pkYrEVWxPeUV0pkFSLZSg
         y22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        fh=EH7bPGe+WjEVEoatg86EcrMZP3s4nAlxi3Y5Ou4oSAw=;
        b=hnB/dyeaTN7UkWiEWSw05zGKyjOlbFNwXpl4KkN1bpo0hs9ih1u+WrH+2FqN/Cu7LT
         C8uT8QxDxwiYDz9qLF+mmSRqHFnR4i0eKfn68c0EgxxiMa8GWzax3wQhlPoL5TqMf7p1
         5C4N4kDu1vn0rmoIj58mO5x5naElbecM/ROFr6jz9DDSqzzTxzZ56rYNZRbA8Ei26BxV
         6jXf+FwduHJjm1jAFzPDi8ZhqjtNkYkNQw9pt8JIKu3UEf0uNTcYuq5tAkG/8pabh4rX
         VkSpiKpwP48MVLC6APWEY84mdDRas10aPu2/J47N0keaTt9BEMVoHnIP4aFXAM04/X4U
         oBvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709848; x=1790314648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        b=DiwRBBFNK4YOXB2DOfqWr0onpPWqYHSoc4nRj9CHk2riON8FT4AfOx3It1kERuAskk
         +1bA1EXypi1e3m29pPSg86kqZhfuBvo2N25/r7VJk+GtTMNzLvOXvrx4Ki6XLnCmpOEJ
         iMk68JQSleLguihObSVWAe5ZxcmyUss3K9Xje3DdjiZqemHliyPWoaHl6f2f7KpWLtsj
         LBE53FOHaNaiIR3kn1AokAIqtc9tlsN+qCYloMmgNl/51Kl+0WTGr6Xmc122waQ1XaDy
         ioF9J0N/kGmw8XMk56+wp0M06Hb+O/E7mn36LwwPWPQBZ3JOlnD0b0blEWnXpGhatM3P
         bQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709848; x=1790314648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEMZq46+kEkOwx/obMONIAwhlN1wF5UDPG1BZpx3PqU=;
        b=kJTzkaWOEY95u1SOpMeiXEAXmh0B9gA+RgVtUx+JiUwFJsYEl6R/7qeVpdo7zGgypA
         BV1jIF3lmGIgtwHS8EGxxF7IpAzyXqrNe8IVaeBGHv6RKNcj2hylYkd1gTMnqpTdR746
         mBganMiTw1RYPXVr/mGgLQyQDkabmjV05vO6P3vnT2+dKIMxxPcWYbgNsvjEWRymaKST
         CxKeGYXC/NxM5DVOhfG0B3w7gARyqOZbUAYyXkXXwOnblafRx+zk8lzJzY7eSz5oLvE2
         /x0ZIuQtmhD43VY6+OUZnpRNh7YvyvG8/1NETYOzpQ6Gco+D1fVYZ3YKDTgMCVf1yeEx
         qk2w==
X-Forwarded-Encrypted: i=1; AKwUvBze3j/dVbV4uohwmflW1f/pVO39A2BLL44tBbTzkCE2/D5ccyLizLOcuLEsmc4898qdQo4FWQA=@vger.kernel.org
X-Gm-Message-State: AFuF++k+i7o79+TRWg1Weq4VBMF2lxTKb1JRYeB8L5nxFBakvZWYHE29
	cytu1T0t2gutQKIp14o2iwwqB4qi23MZLKTEKY5Zv4xSwZLlBO5wNM2CrsAPEn+JEXF2Oq4s7of
	lRcotj6Mqi5PFUgcFqc8Gywr2CFi5utI=
X-Gm-Gg: AYBFou04F90tWx+kdrNOV2J7iBBUPutSTn5GCmOUHh0T/gg4aKlbfsWAPF98PlVvoOS
	2I0eRXd8vousvGXLgyQjqfVktqT7U2NV0bb5xqqDgVENGmW/mSa5n9j4PfLipjx/MiVZ7+6Ds2r
	hiUqfDbYsN1Z9TEmHwZU650tvW6rw934uSiEon+TjT27TZPZNaX6HT1fXO3pI3VflNDz3x5wtsi
	5QhuJlQk+Upw2vfu5Cj2pmgtytbQNI06CsZGsak1LKjknW0iThMnYYqQb4xApXgvCBkrTeaW2h/
	I3NhNOH2I561NdJzeENsm5vDGHvFujS0/pA4PFfABD3/xrmmSXO2cghHhc1pNTdXrV9lDYjcQCq
	yDrZxxl7TTBSHaH2fi62RVzm/LD4AF2rb5eb15F4Ptp4z7A==
X-Received: by 2002:a05:6a20:9192:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3dd726822e4mr8491471637.19.1789709847642; Thu, 17 Sep 2026
 22:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com> <20260917120801.GA51261@horms.kernel.org>
In-Reply-To: <20260917120801.GA51261@horms.kernel.org>
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Date: Fri, 18 Sep 2026 07:37:16 +0200
X-Gm-Features: AcwNN1XuOOFlVfui2KqsTshS0VrgY9RyzdlgQl-KYZ1_KJDbJwuAG01QqdpO8CE
Message-ID: <CAKYWH0RMJ+sxMku8UGmmcujnO9fJBg3Ok_ofbvyh5eTJm=2uTQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR aliasing
To: Simon Horman <horms@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 17 sept. 2026 =C3=A0 14:08, Simon Horman <horms@kernel.org> a =C3=
=A9crit :
>
> On Wed, Sep 16, 2026 at 06:01:14AM -0400, Jamal Hadi Salim wrote:
> > A u32 hash table created with an explicit handle ('tc filter add ...
> > handle 801: u32 divisor N') keys its IDR entry on the raw handle, while
> > the destroy paths free it under handle2id(handle). The two key domains
> > disagree for handles in the 0x800..0xFFF htid range:
> > handle2id() folds them back into the auto-allocated id space (1..0x7FF)=
.
> >
> > A manual table therefore leaves its raw-keyed IDR entry unreachable on
> > delete (a permanent leak), and its delete can drop the idr entry of an
> > unrelated live auto table. A later auto allocation can then hand out a
> > handle that aliases the live manual table; u32_lookup_ht() first-match
> > routes lookups and TCA_U32_LINK for that htid to the wrong table.
> >
> > Key the divisor-path alloc on handle2id(handle) so allocation and
> > removal share one key domain. A manual handle that maps onto an id
> > already in use is rejected with -ENOSPC, and auto allocation skips ids
> > held by live manual tables.
> >
> > Conditions to recreate:
> >   ip link add test0 type dummy
> >   tc qdisc add dev test0 clsact
> >   tc filter add dev test0 ingress protocol ip pref 1 \
> >           handle 801: u32 divisor 16
> >   tc filter add dev test0 ingress protocol ip pref 2 u32 divisor 16
> >   tc -d filter show dev test0 ingress | grep 'fh 801:'
> >   # unpatched: two live tables with handle 0x80100000 (the pref 2 root
> >   # hnode is auto-allocated id 1); patched: the auto hnode takes id 2.
> >
> > Also tested with a poc with a live u32 table on the block, add/delete a=
 manual
> > table 'handle 901: u32 divisor 1' twice; unpatched, the re-add fails wi=
th
> > -ENOSPC because the raw key leaked on the first delete.
> >
> > Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failure=
 to free IDR entries for hnodes.")
> > Reported-by: Sashiko (gemini + nipa) <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@moja=
tatu.com
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Hi Jamal, Simon,

Thanks a lot for the fix.
One nit I'd like to pick is the "Fixes:" header.
Specifically, it mentions my patch:

     Fixes: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic
failure to free IDR entries for hnodes.")

However, what this does fix is *not* a regression introduced by the
above patch, but an age-old inconsistency between handle encodings.
So, It would be more accurate to mention an earlier commit:

    Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handles=
")

What do you think ?

-Alex
