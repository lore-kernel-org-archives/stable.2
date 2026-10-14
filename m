Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7456260D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996753; cv=pass; b=lXK0LVrPU8/tHg/znMEMQ0at9ildwbJF/prTGhItVdjIaw8vLzS104U8oZ2rngUezu56Q3SKAKKl7cmaC01ABoGAKvJszMzPjOFk88fIf8+6ODh+bUzBPD7cYl7Nc6WhqvE4sd2x2biAHBhCP7RMWyToEslHmo/WL/iDfx5wABU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996753; c=relaxed/simple;
	bh=fQ50eGlFnjMQI2C3GaRdlcFw09nmY23Q11yUL7SlD5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWBODn+1EBTZrltpe7TQqAaipi7u1sndgwc8CzLFCVGH3HPfqbuxosC5W4FhVpZH8HSC3Bu1/dq3fNzmhIzTL1bdv9xgn6wCB/BLzPV1SOI1TbtBCDJ+s+gippqOs8nLqNn4IoE1dffvxpN4Altnk0CAquZ8ga4UcLm4nBezS6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=cIqhkAJt; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="cIqhkAJt"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1290918eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996749; cv=none;
        d=google.com; s=arc-20260327;
        b=Th6SfFozNKIYWoTx8ZiItqIJTq2mhdTWkBWmyMHRYczb00Ff1EVtoT114Et86kH4Sy
         k/10CWm0dMWWVNVbP+QWEd4ItUX6wVFjTVKjtSWzkuuIYN67ploNM446cn9K1a5ehRTq
         TLinzrcY+V/J6Ud49AkV2MZQR1vxI/wXtUJbv4PBIGT7hb+MgmnCHyqVsH8is8Wuu6gc
         fqJY/7TQxLaw7VtozrLH1zuu6YJZQCdAUJ+bEVklyASU6O2YKsj6D4QQWTYln/s6z1PG
         hblnA4NQ3Y500Oyr3S3DPHbazfkEPJ1A5yof2GEpVneF6PHOi6lqZdBqHGyXi5SyzQXR
         uKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        fh=tV/cPIpt2IbZBWSSGYS+ZuW/j4Ysi+Srntbe2ErzcLs=;
        b=a9nuoBW8Hgr2AWJ7osbBW6cYB25b3dRgoV53Hq+MQKS7aIrCOshb6Fd8toiDXRK9MN
         xdZ0E+KfTRJDDRw2kn7pC5exrEIYzCgnNV/eb/YYLGkxU6zNxnfG63Uv7jhDkZVuFsom
         aZoFS/95cb836Ihr+qpd0h6Hd3WN57x6BNlKrP8T2HpiWDWM2lm0yuSYqAu8HCnnp6rS
         QEJed8JF8wQCLCx+x/bq/dojVqSvqUke0rEt2T4ZzP0xq1y52YhkpuQ/Yvix/uwFdlyX
         TguaZZn/dQcQ+EPicUTkZGWgTnvofp5dlNP5gWiAk2pG4GQnCLckqjoD6QtypYhWExDt
         6N7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791996749; x=1792601549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        b=cIqhkAJtHmT03n2ZEgG8w4wzPyqXgS0tO+5FPE0Ijiuk5wj2XwI84XFWd0i4Vc7TXg
         kFDiRMoW3XYsxxKDS5EjN84s4sc1+2cceZ1KakpWldZFyeRMMfzl/gV6uTka0p/ks7gI
         H2hGLpArpHVzQrPUuBnAPvsjQJOHIS2HgT8d/fqOLKEnaKfYQb6yaQsCEnAERJSdIDqB
         3uTklSzvtA0WwbMzDPeMUTbDt8c7NVVUqdch7WFB+AhRJP0/3pEKvK4dpT/lDM+0bEPA
         zQ6a5NS2siQjSjLHvhxtR1xI24TbhiHMwCI5s05O8LFtnksRrNU7sRcMgCwksiRPLoMV
         KoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996749; x=1792601549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        b=Cp+LzUHSeoCIl91dyKUuuOOtwBZHWfbFAH7COByammhzZ1bWOfvi9II/tddngSMi3F
         +duI2cM8GVBKnkO/B0Rjs3yMUevPONX0kXtcaXtgHJvn4AAZJ2bNyqeZKJO1LOUt+WIA
         W5jzJH701d02DD/X1XDfPGHlcBb+l7DnDUJH5TBo3LDYVHcCzdvjcoWyBn9/NfPPtslD
         7xVz8qH/FiNPir+JIdzIpHllesUV49LGJ+6SyA21lLcZRaJEx1mHmfq+NwAN+x9sL1U9
         kY3ILY2kBsBjm5ba/qxl9+6vF36UVcl8Y56MXS9i/m9W3vIW0XHEsXURbZzfyr1zKvOw
         Qrjg==
X-Forwarded-Encrypted: i=1; AKwUvBwxEovxHzO3x/zZtH8LIwmO9umfmZ+Xwhe+/dNbYSL0M9oYAIVU7bEgVkKhbzihWg58wI2C1Wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOyivBxt/LZL7ZsbKFYNAJi5tRA3WLuaRI+kx9EZ0NC2QkoYeQ
	wh7vXltI4CK1C1mmeBcVzS74QkAW3JzjJAa3vwkYwWcYcOwgZpY4zWFYh5CiZlrj+PP7UbGPTDH
	E0K0TsnFqqjIQbsq8hc+fBSiiaLKxEjdZN6MczeKCTw==
X-Gm-Gg: AYBFou3vk9StHfKOwmJE6Ppfg0iyg9oAURTDgH+A7jEBMcJNjdFoZAYhVS3LUrRcmso
	GpmUP+x8sC5+N1ZHNmVDt5+SVcdmdOrJCXzTGnFwsnSpoT81OSq5+TdQet6ZqsmNk9KeAmXet2p
	uEAbggJEXY3a1VS97ZyEtCRQf5gdrywXGvl62MIpMzGslyFxI9Tbm1DnPv1NpcgA5Ht3Kvbro/j
	JmFmihtaf7+QlggRmOZ/2pmJsrZZ9/cfMPYKDyidTycffSZC4QJSt8JCRCUFmjsfmT8KcGfOSs0
	3Njcwxnq+xebch4zxdQwL5wkTT7JCuOAQ3iFE9Dt4fQRWGFC61AlFfLUvaa+gncWC65duPemhVV
	yggu/8s/0Lva7hA==
X-Received: by 2002:a05:693c:87c7:20b0:351:516f:7576 with SMTP id
 5a478bee46e88-3537e01e8a0mr23272919eec.10.1791996749365; Wed, 14 Oct 2026
 09:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <20261014135154.05de968e@pumpkin> <179198668564919.2.10323410751655182155@toxicpanda.com>
 <20261014173042.0a74a25d@pumpkin>
In-Reply-To: <20261014173042.0a74a25d@pumpkin>
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 12:52:17 -0400
X-Gm-Features: AclHuK-GYay-AQwoTupL5qC9wZ92QZPzmV0dk65w2lPnhQBw10ayUmM8aY0IhLk
Message-ID: <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:30=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 14 Oct 2026 14:04:45 +0000
> Josef Bacik <josef@toxicpanda.com> wrote:
>
> > On Wed, Oct 14, 2026 at 01:51:54PM +0100, David Laight wrote:
> > > Can't you use that fact that the csum function should only return
> > > either 0 or ~0 and use the other value to indicate an error.
> > >
> > > ISTR this coming up before with the 'copy_to/from_user_and_csum' code=
.
> >
> > skb_copy_and_csum_bits() returns an unfolded __wsum starting from 0, so
> > 0 is a valid result today.  It would work if it started from ~0 the way
> > csum_and_copy_from_user() does, since that doesn't change the folded
> > result and the sum can never come out as 0.
>
> The result can only be 0 if either the length is zero or all the bytes
> are zero.
> You can probably prove that is never required.
> It is likely better to initialise the csum to either 0xffff or ~0.
>
> IIRC both IPv4 and IPv6 complement the checksum before sending it.
> For IPv6 a zero is invalid (it means checksum not calculated for IPv4),
> I think the best was to achieve that is to initialise the csum to 1
> and then add 1 after inverting it.
>
> > But this is one of those "you have to know the behavior of the function
> > to use it properly." Explicit errors are always better, it removes
> > ambiguity and creates cleaner and less error prone code. I'm happy to
> > change it to start with ~0 as well to add the extra protection, but
> > explicit errors are always best. Thanks,
>
> Look at all the places ERR_PTR() gets used.
> An in-band error indication gives better code and is probably less buggy!
>

...ERR_PTR would be fine too? I'm arguing for explicit return values,
not "0 means failure". But I don't care enough to argue, I'm
respinning. Thanks,

Josef
