Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833C34BA50
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215309; cv=pass; b=usoYrBnhORdBd3luo8gOWMeN+p3yTW9FlPglw+Qv7oQG5d84xecRJle6kP0W0HC5E6phqzCFnzSfJeR9qLBeWPX8ZXIE7HY+KqqtIS82snEX79WTdRhxiZ/Lh/5TBWmsaVtJQgUAH1OijQ5IV0Y9O/8XBPyhJrRcaHnijaBRAkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215309; c=relaxed/simple;
	bh=7aSA4J9Q74PtgoVuZcBUHnk4I3DuCxmhRb9seHM+X0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLiKzRkrQQVTIoy7m5IAmXGOy8KskpYo2LGI5YJU41gxPVkCn36++4oNd7PKSTeSL0gCq5cuqjesRcHJp/Ud5C25x0n50YtLxwr9LyGJL1eFTRkw+FHI+zjQIxNcb4wPl+S0UYN3tXA2ZgkudY+mXavo2kZDbIWJ+95V4ti1h2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khvHwyui; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khvHwyui"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91587626ae1so654744785a.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 04:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782215307; cv=none;
        d=google.com; s=arc-20240605;
        b=eBrfibutXIlk2pMaCT8QV74ppmDP3oViTka2UQEaay3kyKLbogKU5ZJ+0JnTouqetk
         C+rHLeV+C19ZHAhBYZHCuMRsq8bZCe1BCVylWb8rE9GXE7JRPXuSMiHnhTZq0P+5/y7v
         l+N1F13eUJYWHZulLkxYnARm/e4aCWTlvbtXMZM6BhYgXfhlXPa/g6aRY7L2+wS1rDER
         Wl+aIm7jFcKluytCX539VBVhUSNjsKA/ZDCdCxe5PnrCcV315xFZzIiUBT5y/xRIsieU
         Zbg84bHdvOe2a3udSKcummSzcAoVrHkLvc1F+EOWe8DWK3PHxOqJCbGJTnXZMP4u99JU
         im9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2R52dlUxeU9DF8c3zp5NFTial0xbiyrqgTzHQYM56g=;
        fh=bxbSlclQiwHfWvJ3KP17x5UmGF2KrmYSSB4HV6JwkBk=;
        b=Vq1GrRqGOt67cSjuB1P13nfI9HwT1L3PR/vqvaqNlC48xrxFi50P349psiAW5Qo+DL
         q+0xn6ufxVpczXifTuSI3BGuiLDuvM+AvoHB7DRdnbCLQXR+hSTUOhZedmyCmOTXLY2l
         8Y9stRjvBpO6miDqfHDJgX8/rdi1zqmYWSIdVfNdca6Nm0pDmhUIrqduDjzFTuO/QhJb
         D07edS1OsHLCMQBcHKv5xaAqk8jmzF4gi6h/I84Mh7LOFtUEIwPROdfP6Dj29sL7XnqA
         Ww29BLShDiLmKb+13aKHUJwKUOPZXtN2mvWnGkvxVL0X12oXwpsiVOQtvUxZ4gurFgbw
         PF6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782215307; x=1782820107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2R52dlUxeU9DF8c3zp5NFTial0xbiyrqgTzHQYM56g=;
        b=khvHwyuibzHk74hTlc/AnKWxXtIPca8fsWEsboUIut2jispKkdsPJ/JaGsHRKZ27ur
         xQZNW4FDgOaUKCocJq2NU+xH/EMR1WhrY/PFWmkv9ZqtDFM+OLGQYBpU1QoGMXandeR4
         6Z/ub93JF1AT+KhwXMROJ1XyYQx7n48b5zzdrH5GDtoZsW/oPxxoyPHgdYwPR+7MIUx2
         dz8otb4dC03KgVilJfmHpnmzs5FW/rsBPkAGM1zgeF9coZ5N990XKV2wja9kHsMI760A
         mbkmV4iMRikVgOBxDEE99ysNszNjqRdpWm9zvTIxEQ+I0TAVKd+uUBnT/JczEPPzHwT4
         WWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215307; x=1782820107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2R52dlUxeU9DF8c3zp5NFTial0xbiyrqgTzHQYM56g=;
        b=q037sZP43RQHrGXy66OlQmlUnoehIV4uTDsL/TEZwRoSP30lPCDsN7hpxKpz52+VIO
         mOL4q5FVit3fpV6GqJ5buXj7TRdJWkiCcH5LYNpIIoyE1OHx+DEiemM9KifI3brA5w5v
         n9WV8yqs2OCjA9ybzCmvfdPFO/RYlwSYFaj3hDaydfpNjeVRYFqEn39nLkdE0Q3aj08E
         WFv9a0Jt3Ktm1zXzA/xbM4adpCbWTHUyEy62T9db3a9vjQTpY043uCcj3ekdxQ7FzO5q
         O9kQ+oYBDdiUt1rkoS6sM5IVM2QqVEJ3j7GeISdnlj0tK5dL//oZ/JX3CD51TMEJgh2X
         D+Yg==
X-Gm-Message-State: AOJu0Yx6KAvIYeX/QU3Np4Phd+8qqqwJV0sJfPCG4XyjoHASLigFlIQC
	cHYKYWKGmIvvpBPk4xz2z6inpWnQFLx4Qufu3BWJmK7OGW3zTa4CQ57m5HEJJZ/rEal7Ec8G3Hp
	J7EyFMF8iD8zV2xo/lWT6FQ5tdxWzLLs2PI59jyE=
X-Gm-Gg: AfdE7cnhRjocJs1ilTxPKfdgORVzC4GuFX1rbEYcev/UWjYAYwpZCCAbCTJ4ZZblvLW
	Fub4KPG3Bfv//u7N2NIyjtuI9oGIQGYSUWR6shfQLsxPD0B57zDeGn2eA2p7jGpGcOdLiwwiOsW
	zeJ6lvEOAOlWgk4flgZD+d7u8Xsfbiu2RRcr1C8p9EXUvLQdiN/j1PCIA4mtNCP9ltCD+IRQixm
	eHJZsvfKHrd+X5JibvJOMO2oyj7SK3CZL0gRVPpxQzGsgNbZEv0Ecngy/Pe5i0bqHk30lalOg==
X-Received: by 2002:a05:620a:40d1:b0:916:1980:b462 with SMTP id
 af79cd13be357-92092b3fb53mr3133630185a.52.1782215307157; Tue, 23 Jun 2026
 04:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112131.752148-1-slatoncomputers@gmail.com> <2026062327-unengaged-apostle-5728@gregkh>
In-Reply-To: <2026062327-unengaged-apostle-5728@gregkh>
From: Michael Pratte <slatoncomputers@gmail.com>
Date: Tue, 23 Jun 2026 06:48:18 -0500
X-Gm-Features: AVVi8CeplyYocFCVOBAKeRQfqZFFp22wOiKhFQcbynKRp_1iAUgUmaofU8bRnmg
Message-ID: <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2026, Greg Kroah-Hartman wrote:
> Why not just remove the driver in older kernels as well if it is not
> being used?

It is being used - Xframe-II (17d5:5832) in a Supermicro X5DA8 on 6.6.
Please keep it in stable.

> And if it's not being used, why is this patch needed at all?

It's used and broken: since v4.2 (51466a7545b7) s2io arms LSO with
MSS=3D0 on every non-GSO TCP frame, so the card aborts all TCP TX - links
fine, UDP/ICMP ok, but no TCP at all. The one-liner restores it.

Thanks,
Michael


On Tue, Jun 23, 2026 at 6:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 23, 2026 at 06:21:31AM -0500, Michael Pratte wrote:
> > s2io_xmit() enables the Xframe/Xframe-II hardware LSO (TCP segmentation=
)
> > engine whenever the skb's gso_type carries SKB_GSO_TCPV4/TCPV6, and
> > programs the segment size from gso_size:
> >
> >       offload_type =3D s2io_offload_type(skb);
> >       if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
> >               txdp->Control_1 |=3D TXD_TCP_LSO_EN;
> >               txdp->Control_1 |=3D TXD_TCP_LSO_MSS(s2io_tcp_mss(skb));
> >       }
> >
> > Since commit 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> > tcp_transmit_skb() sets skb_shinfo(skb)->gso_type unconditionally on
> > every TCP skb, including non-GSO frames where gso_size is 0. The driver
> > therefore arms the LSO engine with MSS =3D=3D 0 for ordinary TCP segmen=
ts
> > such as the connection's SYN. The Xframe-II LSO engine treats an MSS of
> > 0 as an illegal descriptor and aborts the transmit (lso_err_reg reports
> > LSO6_ABORT), so the frame is dropped before it reaches the MAC. The
> > result is that no TCP can be transmitted on these adapters since v4.2;
> > UDP and ICMP (which never carry SKB_GSO_TCPV4) are unaffected.
> >
> > Only arm the LSO engine when the skb is actually GSO (gso_size > 0),
> > restoring the pre-4.2 behaviour. Non-GSO TCP frames take the normal
> > transmit path.
> >
> > Reproduced and fixed on Linux 6.6.67 with an Xframe-II adapter
> > (PCI 17d5:5832); bisected to good v4.1.6 / bad v4.2.2.
> >
> > Fixes: 51466a7545b7 ("tcp: fill shinfo->gso_type at last moment")
> > Signed-off-by: Michael Pratte <slatoncomputers@gmail.com>
> > ---
> > [ Not upstream and cannot be: the s2io driver was removed from mainline=
 in
> >   commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
> >   driver"). It still ships in the 6.6.y and 6.12.y stable trees, where =
this
> >   bug is present and the patch applies cleanly. Please apply there. ]
>
> Why not just remove the driver in older kernels as well if it is not
> being used?
>
> And if it's not being used, why is this patch needed at all?
>
> thanks,
>
> greg k-h
