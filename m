Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42938756E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600753; cv=pass; b=ay/jJYoInvYNyNFkih+AztIFb15wg0KGZPi8NCSfxWPw9T/wzhCan/r1uoCwCBUpWkXsEA6iz+nliU5z3Oux/OXhSGBvPVEvLbi0zojLzy0VSDzAio73+LmdmMI7ZDJJ+Q+Cr69tgze1JElygv0Y0R6jyamJ1Ku4Dn4vbiEiDOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600753; c=relaxed/simple;
	bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhOUdxIjM1DY7UG/5nJQMLIcnrP/F7PMpJILP/aqfSNhgtj/5alQfInQ2RjpRRzH+24W04/d/esZ3Q+tuggS8S1Xa2lxqRfxLRzrlp8NQaSgeWpdQ2Q93exgvFIjHl/Y0MRKygJ/IUy8qkXmgovfvghr29beRcrEJb27zpVk5i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJnm6eQH; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJnm6eQH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15b509c323so104781266b.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600751; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJk+ZbCVaKimbxWZ7BkCl+H68GT7KMU5GsJ5jhxtsvp1AbPmUKpuztckhERhmpQTTG
         nrIkCM9kBsI+IzmWXPi1cMBqiZTV3aHW3LmdHNJlHQjtF6g+/HkxIjNXZNuKPPCAnljK
         a3g8IWC9lImJCCfPCPfG0VaasDeCglZ2DEc4ekfNgSPU0D1SAYCwuUL3Mq18wYQ0I3Zg
         bU1KIozngm1sIkvcSYEn3Dno0qSn5T50oQwTjRh1ZhtMm051Zor81UIZhoW1OaC5qtBZ
         aQSHEXjfloXTPg3jDGvs+HnY3e9rt8qUahdUXlbb7+mJupMxUIVuGUrISKyeB3Lk989o
         So+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        fh=WJap9KeL/9BM9CSR7pASBu5/y+lvvmCu3MDJ1QF1w4I=;
        b=cjTYN0Bbi2fZuldF/ieEztAtGz6MaXieWwd1S07AxxPs3w4in0ACpSgYdzgMnxklCZ
         ZKRltvwgGGi9HclQRPxoYMGqFc0e/uJNwCU0TwR5yFSqF1YrI7MlA0stDzHv1trZmvYl
         h0nSNaCIf+sCc/lP10z47tyOc134nnoXJQAiHLZg8oKJco0tYyhqUjpFp024b/k16bT8
         7iqPiPpcjYeSA8klxCSrZuSZd2m00fK/aik0PFZw/FVT54GJswqm9MzSjU6zmCYhDZ9X
         lGIxGEinqbtci/TuJovMaqb84tZqMBq8rG7rLGjr0gPBZd/CHYpsxsH4/4nIgyCW+VjK
         FyUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600751; x=1784205551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=eJnm6eQHfFlt2rdQI3xo7xAzeOmjFTHpkVA17rMwzRJ6hkNiY5c3x/I/8zDX4auA/d
         nkSpdIF+qbWFUcX1ip3R/Vy+33sJREkKUhjrl//5QDgO7rOInoo6OT1dp+UgkOOu7DwS
         TClCCZpva3RRp4EiPcKt8tvCezP7NNnsR87liioMsSVHQjVTl4LPJVPUZdGh9ZjN5P0G
         ykA9wl6tWzZ4FFtJ9BRLa7jKTSsbBbeAqKa7m8di6ORGrY3p8OINcshy6XJQHp3le0jH
         dkisisnnwihkjr1vqytCFc8XGtbKSi0/1AhDEPPlh2U06mAe/W92EXj4UnfLIUE1V1Bg
         CA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600751; x=1784205551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=hsYpterFWTGzEOjB45cp6DaA7d6+chsiIXuUDdcQmbfI4z73FujL9n0Tq1t6ea1eNY
         7YMRitzuvLxnvXr6GArmMTaTSCL+4pECt1ciiq/9QFGWXHevPIN+kq1PlddfyEM8EiJk
         VoMqTUUpOYPA68VhweKN6ZyYg891aa9UcOFHTdZeFP7WusFEf94f490J8elj++8nFCRL
         cACHPj2aRfyGsOtBL6a4SpTe1H9+5obs7FCb4McDIxbFSXHevWspfttMNEX0v3pGtLlv
         vaQRgzOrw/oHjYQh2otiJeehjjmV4205h/2i/ZkYI1d023K/GaBx6nX6uY0+idVWwrlw
         cswQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxulJHpjnYLpYkFMqBAW0jUcC6L/S/dzwf7fy2JaronxEfT7iuHWIn6k5/xl1QrYdifRoqOD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gur1wHtf1BzE0Eipjrso7Ult0dL8CAnSBV7rDW7Ua28BIom/
	fRjA11DkrZ/XtKldVxiaseKhMuu8jfkluJSNN8/ZyuPt9YxFRBisrHuvwT6ERtlvd4UktEMXnWG
	Ok/Gt/ow4y7V6xs2rM3wcY1CKBjpv1jdnybJPeLcWhQ==
X-Gm-Gg: AfdE7cmIUAnIUl/DEpICQ0sFtkk1qAr/ebydrrkh0kkInthCkNSOxTAlvfCIOFSPykZ
	pvfObus3WLj1/We5DaX431FTirUPZQAgnlwZrVXF6tnQosRMMHUditCB0O0e40mWtwMssMsE3bJ
	entPmACosE+0Kt0KTNDzQzQLPqumvjHI817FCG6leqQ6WdSAwdVyPUtESRXC3lPCs0LzdUfuuGm
	TUpky6sHtnlmSmDdn4dJB1MLr1XqoK4M/psedbcFPKvWiB7HPOd5sV62OXMF4IDMFmlNRo=
X-Received: by 2002:a17:907:e153:b0:c12:6ed1:a7bc with SMTP id
 a640c23a62f3a-c15cdfe9b54mr217106766b.7.1783600750745; Thu, 09 Jul 2026
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
 <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com> <2026063019-crummy-mosaic-d9bb@gregkh>
In-Reply-To: <2026063019-crummy-mosaic-d9bb@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:08:58 +0530
X-Gm-Features: AVVi8CeeSy9sOe-nDvJ2FgnZIaGmm16MJR8SeE21mrKCu6quf0TcNIj4Rs8oCSQ
Message-ID: <CAE2MWk=SXVZRmOnnWs0AYWLWqLipo0PTND9UCQw6noDBoJ5CdA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:00=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jul 01, 2026 at 01:33:07AM +0530, Ujjal Roy wrote:
> > On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> =
wrote:
> > >
> > > On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.or=
g> wrote:
> > > >
> > > > > Please backport the 5-patch bridge multicast exponential field
> > > > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > > > e51560f4220a, 529dbe762de0) to the stable kernels.
> > > >
> > > > I tried, but it doesn't apply to 7.1. Could you provide a backport =
please?
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > >
> > > I will create patches on top of 7.1. But tell me what about all other
> > > stable releases? I have to create patches to all stables and how to
> > > share the patches to you? Via this email or any other process? I am a
> > > fresh on backporting my changes to all stables.
> >
> > I have prepared the patches for stable releases mentioned in kernel.org=
.
> >
> > And I am waiting for your response so that I can send you the patchset.
>
> Please just send the patches :)

I just sent another email with the subject "Please backport bridge
multicast exponential field encoding fix series to
6.1.y/6.6.y/6.12.y/6.18.y/7.0.y", please accept that for direct
cherry-picking. Infact 5.15.y also cherry-picked cleanly, except for
the selftest commit which is not needed here, will send another email
regarding this.

I will send a separate patchset after resolving conflicts on 5.10.y and 7.1=
.y
