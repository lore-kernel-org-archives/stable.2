Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691325A2A2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602320; cv=pass; b=uNIQgrU1z4poYXYKSe/LwIXYpDaHABbSJbCeNKGsWLb8SfpxJ4DoYmNMq8xszxU1X9DhNcfzwYl8l9/yMR4DOUvrkri8uEJFoxlwTbJI4asxGtAU/RYQTdc+YCWS6+AmqCjH8I2/QwWyU7ap30nlzTI64ubGZ8nUe5qArVWfGNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602320; c=relaxed/simple;
	bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvbDI8aSKyR7rehoGopsAFB3/Mgdg0XIjqh5+ixHOcd7O/3Z7qFkblWXhwKOoumjgEL4DkLxY7BXVDj2b7n/WCVTF0E4UdgsiWZ5si4/CZ0ocUoKyE/D1YAJo12m4iBRdEkqh2JV0V21Z4VumPPbAZbg1blMCjek5DsPsPI/fk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IShI0upr; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IShI0upr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso1471014a12.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602317; cv=none;
        d=google.com; s=arc-20260327;
        b=OPNdXTo4OTjg3wLbhzGG6LXaF/j33qFFFdUTnRG4mu6XwheFixrWo4Su9KYxpv8c7M
         ggu3nj7ufPpIgsmj+3RKxW7Bq+UTAZkduNVv6yW3HecEB2bLsYgFJMQUF6lkJrxJPeRo
         3S0SulEDClp2DQx2mTX9alrRiDWmVmMIMYI4TR/n+Ir6/XEDqVdewTbaDOZu6OH2YLnM
         7c4bWbgNOuroyQQxUCPIOwtCXNkZGrYfJ5OYQqhXyu6n0rgd8pre6nJQSwzDTgA8UyWm
         qi6Q2i3p0cada46bGeGMEpui/EVMX7iGFvpWXVrHWi6yOZz4XbtTpbbYLBIt+YGSFBJf
         8Fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        fh=fQRXEMMXK9syHaI7XZpYyZ+gATnHf8+lrZZRihwJzbA=;
        b=ccdtXWn4sHqSQQ9/Nc+vnB5E+S4xPUcLwvb2F1iRI4sAv8o80MdpHQF4UisrhiYK1D
         aUJDB5HDZISWs3F75Gq+rGz0RwX776WrghhfebIqhC68VE0/a/atjnmTtW52z6Krx+0x
         KamtmKSRUWYlh1l+gxNnPMsiRQGjJhAg7fQmvKbgPwuWSSk7DRhWxNt5uULOYeEnrehc
         4BBwJlCGai9tWmZP3T+UvKz1CzOB3BmUUaUYpjBzXEbkqVuusBEtMf/kDi3kIdlgljMZ
         2oNj5xCIyjkARg5oNnfa4ypxN8JphYmUhpPAXfIZo3Ec8L0U8nev3ga2VftIw5U7OG9O
         A7pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602317; x=1784207117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=IShI0uprFbe7kJ58S81204LrdNUpadM0QEWf1oeBRHmDRrOGgLGbwPYNyepVlqGj0C
         c2dj/56IBfIXJBT0rX2e9WU7UH4o9HgjJGVMavhDlm9//zxswr0RKAGKSI+v9KOK7q1F
         dTvMZlgag8NhcTlobH2veQ4PLjFEbjcZIKETddW1SmAT1DHj8jiuZI3cQ2qcPtd0QLWd
         ks5i6CRCdVbSUJcLbdd6hweDcrjbIzmEKq15ecTDW+ZGfLbZ1YgYMAJQMoFYOIzdzx2C
         XlIpTKvv9zVv7hbbFZqX8He2BZp3J3Vcodj8r9XtjIZtTsaNlHgTbufJCPX81YIdnpzk
         OMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602317; x=1784207117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=jhDOqU4OQXrOeJwvHtDfUz/9iyUslv5Pd1cYoanwCN/yPrOpbffznFzNrx3FCUVDhz
         12go3RcYIyssJgwxrrDCV+KgVZezkyvVgYuf6Y1G3yYySFtN5JzbQVGSKy1u+LkszV5T
         gRmLKXAdBizjWOaPpctcJCa7rX/pY3AeEl6Nh3Lh+I4fMnX+O01HQYeDcNlJnlRZlCEq
         vUiJ0SIVkIqiAeb9FtHrB9ItUIwE+TgXI+V1NvZVyy3WEHf3UtaZH7hEL8wIbVEYTfG8
         BfCrrBSCETyMqiwuFM5RDBJxFh+lN7ce86jjuG5pdABxLjG5E3GltFWMzt8oCVh2qjH7
         EXCg==
X-Gm-Message-State: AOJu0Yw8KsqnM5FHQQIXRRt2Xk/+braVoS5nZUDieQ5bDp2/xUp5cjiA
	RFkGmolg48LWedjAaIvscVh2VFTVy3pr9um9BLzfaWbcn2qEWGihUeqB1iILrGuivzIJ/5xYvs1
	szi+OGGS+tb5oKRUpmyhS6RO4x+2uI3M=
X-Gm-Gg: AfdE7cn0trqPKlBqVR0SKQmGBYaIPrlC9Zpsv27lFJWwpjTeCl96AU7jEwOsu9AGDWu
	CCsWpNJMER2GKkr11+OtjsXGjfB2v/gd2yH9c13EY/J811jVltPBy33G8OQJ2NtVQJkert0olRu
	dKN8+VapdTEJZz7C61DqGUrkOztJKKpe1+N9vBNp5nzWeetNx+m9zLhsD4E8EectXabiIMx3c6q
	AWPFglFhrl0Csx0zp833+TPl+qqmy4A0VjuPY04Ag20i8Ykc82dX9cmmxbZnUcHTFDr547on/1R
	hhH21g==
X-Received: by 2002:a17:907:268e:b0:c12:4b0f:5d12 with SMTP id
 a640c23a62f3a-c15e77d185cmr145016966b.23.1783602316748; Thu, 09 Jul 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com> <2026070954-activist-left-8303@gregkh>
In-Reply-To: <2026070954-activist-left-8303@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:35:04 +0530
X-Gm-Features: AVVi8Cf41M_ijpHkKYz8M_XktE0qZUV9t_0z2x75RapbDuAjnTo52sPGA365USE
Message-ID: <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
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

On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > Hi Greg,
> > > >
> > > > Please consider backporting the following bridge multicast fix seri=
es to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > >
> > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplif=
y calculation")
> > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encod=
ing tests")
> > >
> > > Why is any of this needed in older kernels?
> > >
> > > And 7.0.y is long end-of-life.
> > >
> > > And why, if this does fix issues, was it not tagged for stable to sta=
rt
> > > with?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I already explained this in the email thread, "Please backport bridge
> > multicast exponential field encoding fix series to stable kernels".
>
> Sorry, but that's not here (remember, some of us get 1000+ emails a
> day.)
>
> Please explain why patches need to be backported when asking for them to
> be backported.
>
> thanks,
>
> greg k-h

Sorry for breaking the thread. I understand your point, I will
maintain this in the future.
How should I send the patchset that addresses the conflicts on 5.10.y
and 7.1.y? Shall I send the conflicts patchset as a series via a
different thread or how? I've never done this before, so I'm asking.

Here is the explanation for why the patches need to be backported:

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.
