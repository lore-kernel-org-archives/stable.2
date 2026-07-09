Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9353793CA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610033; cv=pass; b=DASrQk1KV89Mjy5wFB9E/s3TDCClRJXHMvLOJBi8j8Dmwfdjo0bqK4HMFtfc8HHizYvYsslQzVxxQR6BlzX1Tgsy8s3ZpUV3Ft3zCKOD2E4IwJt76jCQ4X2vUCY2mif4pKo3wQ2+NKweWCMoUGgsI6/OuJMEaYYXseMdVnoEias=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610033; c=relaxed/simple;
	bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt0vpwVjQUBijgtE/TUQoXMUE+BLSaztMDYZmWIoiDNRo1vab61YwDuXyCOVkb/8RrxfMUCDv7zd0+M7WuT2pJLOMABsLkuI7OWHcO1D+bldSu8qXZpB8SLRde4tJkW2VhEGs/cMGN6zj9hrygr3+eUGC4ynwg+Sw1BKUm1K1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZShSS8r; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZShSS8r"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15d47266baso245526966b.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 08:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610030; cv=none;
        d=google.com; s=arc-20260327;
        b=n+GTHqpvp9brflCVyQ1Jy4Xs4LdBr3NtpAFk/JaZHRZS9GXl06SElLe/TbqoQkzRPV
         MWyvsjY60qtldsshcwgf/8fCFf/SJVXBbLazco2J57pT4d9WNdCOIK8cDFwgTmF6b13o
         YEq6il/0MLiDGRVcY2dwCu8SXpizh0CyT7uM8/g9HMSlyc7nrPCrmbJvM1atb6M0V04A
         U7zJjtSzo/3U19uLx+8puKgAQMx5SA2LG/nQczMltQ4qxSYsJEg4FInYCPiZO1c1n+Zx
         pY1XnWY1573UgQR9jGkDEwfyFSoJgcNa4covSliCj967mBfZ9zdOm0N9V4hZhU+G8t4h
         1ZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        fh=fQRXEMMXK9syHaI7XZpYyZ+gATnHf8+lrZZRihwJzbA=;
        b=lTSi+GtjFfzfxs2CZIOITdczVx5OHBQNUCDhL0LiHaIoGoMaVNWsFb5K4OczBoKVB1
         uB2SIGRc/OghwkQgDo+fy0BnWn8AIyckl6dn9BBzNLMEBPZHlUNuAc9dsCRBdRTN/KZ2
         lLssC1CczAFcAlxKFCztNYVuuWoZfbSPFL7J992/JB13WgvL/+xbDzyr+s6tjETW3Vj9
         Fpuh6b0y0B2jemEDo+Hy4/XR16V/xOp9bd1VCUow0NYHFDpuiSyaUQcxLj58Ypx0llcN
         3VUUa8WH0+fRySGaXNhqNqYSvlFGWr9BfOwxKOQwgB1qbtlV/JdzCkqUW99K8xDF7U77
         1LRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610030; x=1784214830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=cZShSS8ro0THpxKUvnqocyUpAo9soBXcXvDp47ckLhenrBhPQ4tyd8EgkuJyqEpedz
         Oqy8pQnBufM2azAaXoVITXgjgXjm5gIRGUUctc3JpFFFt4lxLafzDe/H/TZPlx9P/9f5
         MKacuUcSnVUzfgRrbScM/zrSNXAw+G0+JCAwxID5SKn47zNpFcuB5R67QtMe6fugaxjW
         vzNrVUyE3/O4N/f4kQA/I3Aw3sm5YnTU4tWoHydMSFE/7T1ngHtUncDPtlvYVaz5oIq/
         XaiqR3rdwn7uMOTnzFX1ba4h+KnthRIOTFc+jdn4avr8ApxEuTrBZrt1XzHuYprYhRjU
         z5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610030; x=1784214830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=iZsCV0aWgg/JthAFjs5KcslUos1koiCx3bUhrrnLUBNA0d43VD4nN228Vu/479KbHb
         aRCFH8HAg91iSNE+V4W403r04K4o27Bd7/FViDFhMirgexIBytceIc8oebkyTSqLiYwZ
         pgpsmkpQDMU69+Df4n8ep6jHtZhIHT28js8o9/DNt3RJt2JptSkjHdKSZCrB/8gJRfkZ
         0SqaMHzRjNTrIWj9PUjZHF0zpEM9tM2BpLi8eyi9+Oav9Bt6IZ+tL46h94j0VBV7kmcy
         BvcWOUi6U3Ftbl84jBC6WnOL2u2GE/KLxPNMtqHzVJX8hzlpOkpnpqUFTyeR/3KF+FbP
         D3HQ==
X-Gm-Message-State: AOJu0YwmtKUPM6wiOUX2r9XRegSJ0mo2PSAR/Wg5l9UIXVK/XqPpKqS9
	vh7Wk3w1GnO8hEw+oU8owUCpSz6q/Kdpd6SWJFgsQwrN5CMYRwawEt8myU3uYatbi9ZARUzNV9D
	AcUAMeIggh2ptsqXXkReuGn8T8ns6E3c=
X-Gm-Gg: AfdE7cnMOOs1YyKBS8aS7eyYitv/MvgDFrEsxRTvVfJQHggN0Yh2YyrO5SLZQ/3RABp
	mSGspYEFUZznvlsV+yOhoV2eV19+3jw13TyzD6pI5vxJFQxepHOAAs85OeEEQ6rK8f9lvvKGVm7
	IvCD6rYDCyN85IyrD3ZQsTrA9pG4V3Ze0kDfmUPDBI5sT8U/cqUViqHb4J7H8a3TYB4quu5waG1
	yJ1hgMCYzskplnQ+lwlGaHqd0T7khjVYeOHDR+OrsguzYQRsOcpvMz1i3pPoErgjbgank0=
X-Received: by 2002:a17:907:1b1c:b0:bed:19af:f89a with SMTP id
 a640c23a62f3a-c15cde8c84dmr329373166b.7.1783610029787; Thu, 09 Jul 2026
 08:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
In-Reply-To: <2026070948-lively-exchange-a458@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 20:43:37 +0530
X-Gm-Features: AVVi8CfKbtzcJnRxXIx3ULOTra4r8qYMzKp7zTKSzETyFRYKJOujtPr221wvxYo
Message-ID: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 7:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > Please consider backporting the following bridge multicast fix =
series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > > >
> > > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and sim=
plify calculation")
> > > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi(=
)")
> > > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields"=
)
> > > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field e=
ncoding tests")
> > > > >
> > > > > Why is any of this needed in older kernels?
> > > > >
> > > > > And 7.0.y is long end-of-life.
> > > > >
> > > > > And why, if this does fix issues, was it not tagged for stable to=
 start
> > > > > with?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I already explained this in the email thread, "Please backport brid=
ge
> > > > multicast exponential field encoding fix series to stable kernels".
> > >
> > > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > > day.)
> > >
> > > Please explain why patches need to be backported when asking for them=
 to
> > > be backported.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sorry for breaking the thread. I understand your point, I will
> > maintain this in the future.
> > How should I send the patchset that addresses the conflicts on 5.10.y
> > and 7.1.y? Shall I send the conflicts patchset as a series via a
> > different thread or how? I've never done this before, so I'm asking.
> >
> > Here is the explanation for why the patches need to be backported:
> >
> > History: The multicast stack currently supports decoding of IGMPv3 and
> > MLDv2 exponential timer field encodings, but lacks the corresponding
> > encoding logic when generating multicast query packets. As a result,
> > query intervals and response codes exceeding the linear encoding range
> > can be transmitted incorrectly. This can cause multicast queriers and
> > listeners to interpret different timing values, resulting in protocol
> > interoperability issues, membership timeouts, and premature multicast
> > group expiration.
> >
> > Testing: The series adds the missing encoding support for both IGMPv3
> > and MLDv2 and includes selftests that validate the behavior.
> > I backported the series to v6.6.123.2 and verified the accompanying
> > selftests. The selftests fail on the unpatched kernel and pass after
> > applying the series, demonstrating both the bug and the effectiveness
> > of the fix.
> >
> > Given that this is a protocol correctness issue affecting multicast
> > query generation, please consider backporting the complete series to
> > all applicable stable kernels.
> >
>
> But this really seems like a new feature being added, it's not fixing a
> regression of something that previously worked, right?
>
> WHy can't people just update to the latest kernel release to get this if
> they need it for their environments?
>
> thanks,
>
> greg k-h

This is a corner case when people set the query timer value higher
than 128. People usually use the default value and don't change it, so
they may not encounter this issue. But I found it when I changed the
value during some extensive validation of protocol timeouts.

If one host doesn't have this fix, clients will observe premature
multicast group expiration. For example, a set-top box channel might
disconnect early.

But we can ignore this until few more people request this fix for older ker=
nels.
