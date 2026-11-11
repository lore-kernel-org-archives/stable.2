Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794389901;
	b=j/GT8/tc4HN27FR/W117pqvhy4s8VFG0c/BjlH5B0EPqtzvlOdTTwUrx1oC8XThBOQYw
	 E+otM5uXHHEcQRumFomCfTlKCYonUglJ6mNmfZ92KmZ11zXrOU2aePapYMAeuHcBswZeM
	 4pcU0u1a19xpR5yQpgwQK3ub5pZaWHWlxfTiVYX/zaf6iMieuDxAgm8q+vM4qQ4eU4/lc
	 RnRePQlSnAWftcfLW0X7OAMhlZ0eTfL9y2Gg2rJjo7S76mj6mPtpvHzi6bjKjec7hd4YT
	 VUq9th7AJLRJUhE2z1RYzZsSfPvEF4/TCApIK7qqPpFJk9flEfqRX3jYzRQMl333iuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mcP1Za+h/1XIgDOTVtisn2Oic4OHK4yE4jC+JPQehyY=;
	b=QN+o6dbn9PV4siGWl+8eOdil5WtkunHmoxxtqPaPJ4ZKF/m10x7FaJGbxFH5pV9C6UD/
	 CH34jcbLAmStVJzo7gx77Dxb4WNYQ16Y0x6t0uHRfMJBrUSp6oYhsNNqn6MBgUSg9Pyrk
	 TUZY24IOJmBSyJXOW93H+LULSHsbgXYyKDeXjeY3iy5VDMtre3NhVAAM1mBvP/iZQCGAk
	 e/omx0LIEF+v3pEoGXn5FWqLW3FUij3YuyI9zNeeF04FHYbjAvWX7AuPzEL3+QNZH3Gys
	 J+nz33KDo5a0NRkMYJ04pz8FDtO4WcgCjtxAspNAj40lRnLFReKiMnaMhP0bbDXPWjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pcc.me.uk;
	spf=pass smtp.mailfrom=pcc.me.uk;
	dkim=pass header.d=pcc-me-uk.20260707.gappssmtp.com header.i=@pcc-me-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C2w8b7OY;
	arc=fail smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAF60A2635
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCAF60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20260707.gappssmtp.com header.i=@pcc-me-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C2w8b7OY
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso391957a12.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:38:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794389899; cv=none;
        d=google.com; s=arc-20260327;
        b=OT/PKU9etc8SGDaSyO5Otk2n+kcxKNtgwni03WV6tVaXuYmYJzdubIbzfG5P38mjKb
         7/MSa2zAqSk4pNqNSUYZVjFh9IYo1gtSoq4ZhbYMlyrfSW9mnWEEQBUtCttJQviJZr8y
         T0EAXe3Q0lB8zj2pFwtgODDsT/mnc7+gOWbvt5rfn4jcgZEjKhfiLInye2yk9nRRp8rf
         gB6Hw9KKNyEe90dutPk7CO3aMxJLCqBO8ZwCmwwDxn9WCSnjyK7gKzJMCDvon9TXDeXf
         Pi2Ow4gxS0C7pgp7u45hngZWItxQGJcs0YaJyz0+haVXyVVFEWFmOXMc49y8gsOLLtCV
         8FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mcP1Za+h/1XIgDOTVtisn2Oic4OHK4yE4jC+JPQehyY=;
        fh=j9I8NTRhKXOwASsAwAhzQn4z/S8dA3EtE5bckaC3p9A=;
        b=n2udLalItrV+OsYejFNpfmWbsWZEJl2ubqSBs7kAWeyO2Da0yPe7fJMLl96E1ZIfaU
         XEBrih2LyCKpFKA+X+NN6Oh/MydpgxFZqGV/PXmF0QqOz2ObKp5YmMrIAciQ3+/pXmKq
         YFh+caCNqKgbzg3YTsPDwYnrNpl1T5JAjadrKKAVPmCo3V/raovkwGLUTROUxAj3Tka8
         lOoh5E5DOy3MoqAmiOgj8hmS0UWh9BO9gzU7ulGPhwtPnjIy6w7jN0HnXj3BkqMX5rRc
         gFgosom5oq3AbeU7jMA7nBPIiq2+cISk3Y2VLaknA3yDpKBpLrdKRLvgaEwuvUj2BMh9
         tyAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20260707.gappssmtp.com; s=20260707; t=1794389899; x=1794994699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mcP1Za+h/1XIgDOTVtisn2Oic4OHK4yE4jC+JPQehyY=;
        b=C2w8b7OYkg7O6ncEssqboYxo4r22YL6J95e/T49TeMXUL2k0xnALN9YymFBsayWC/Y
         /aiCRjZweTxNor60miNWYMu5GTviTVd+I2jgn9sJflJJMvEgRDTFbUcBWBtVxkBJ8nKK
         e7AAdO+j9b0hGq41NCxDbWSFFg990yTj4LaDBrvZWHkhJnGNh4fA3ISsavIbx3MYZDyf
         SNMIilWJLam/OsH0oK1KbGIH2rusvJilQJoU5oDhHomPnmCf+zIoHZkLL72MuOlrwaC9
         u4BXGOqjXz0vDDexPr4YyiJXEX2H1cc+QJRfyjzBl6IaAE6Mpn9EnyX01x3Pf81XuVXC
         1+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389899; x=1794994699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcP1Za+h/1XIgDOTVtisn2Oic4OHK4yE4jC+JPQehyY=;
        b=kAT8QDvNvHYtK6Twy40PXbKB12D7JUdtBZpBxl1ZZGJb+IqowI0Xk+1DcsPJL6u24E
         ybp7gNAntL7cvpOqBwF/lpKOtlBPKRuvnCoYVEhGmOLIdx5gDP5M9i8gmYHiUtGuQRML
         wFTEfMhIomZHTI28BKfUMk+LTkuUxsCOoh+P+goczKYhaijUjKbXKBjmzd3GIdDIkO2Q
         IjFLcCpPeZano5UVSTjrWZDRRpAJ0QkPO9Cyq9LAzjowMvVRcGf6bohpwhpLcRMUZp/g
         RSub4hj+Mm2ALtdtk9N64Zvo9J3fvQ2UWVAtAru8zt61h9DeWxnJtxwcBIr+L0X9J3eD
         qzpQ==
X-Forwarded-Encrypted: i=1; AL+hErGygwhJmjngNDKiq3FsozhQMkhhcJpCkJxHHl/dakFz9lQcE42hi0O4RtzWCUbRG1jrH/h8Mwo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ckmI6TkWKQ817cwHa2qGV7paSum1qhhxwP6mOHNOq9phBWAZb
	+aGHvQn8Ut7czlLAkUHnrxjIMaDzwu6m0wIkbD6HaPZJMxZHRJhZfrccm1xgWdxPkW/vRRfpzkb
	/Px9h4R9mq0HHTaNPsrbmWwQL8iK/zLbK1HH3/vPpfA==
X-Gm-Gg: AYBFou0GaANG4LNxoach86yoj0V5ZvIKVkYYWSdthzdPYHqUfjfqOE6/zSfNtygjvsU
	Fdop7eXQEAVpMQTOPWeKw/Pb6xWwPKG7g5c7HGi5TRmywYlcKOgGg0SksnEppGMZtqttRxIg9X6
	AZDpU8AZckdNGaJc3Po94QbMng8H04A8Yhuc0HUvFn0cOTM/qA/Y9tNdTqehVnJu/xm+QmpsvCz
	BbYn6Gfc17wGdKs271voEsNJoISFRJKTPNVSer4QhFgWq5t1p197tWJg9+pahCCSSkGMrMIJotU
	Uct7t0o03nYgAD+EQ6LknfrvmNZH1kWXtpCgMWhtVwyDVCBg2vNIQcn6PvoY12xVob7FzoCKien
	uEIzPmDbCcuUDWNCpxQc+qC+1SnnUBaFGN4V2ixA2CWVnf77+tgk67F6qdkrrjtFoXW0kCQ==
X-Received: by 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id
 4fb4d7f45d1cf-6b777829b2fmr1504916a12.35.1794389899169; Wed, 11 Nov 2026
 01:38:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107-mte-kasan-split-v1-0-d84ea5f30f94@google.com>
 <20261107-mte-kasan-split-v1-1-d84ea5f30f94@google.com> <avNjcKtuQkZW0_Sr@arm.com>
 <avQqdBEGwje1iVlz@google.com>
In-Reply-To: <avQqdBEGwje1iVlz@google.com>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Wed, 11 Nov 2026 01:38:06 -0800
X-Gm-Features: AclHuK-VneSANYCNXJ36s2sFC-63re0-bOqlxxsBmGtmuBf0Sv7UobeBKGGbfM8
Message-ID: <CAPQLkRi4zdGZRy=59SeaRz67Vj-+jEJKH-eWMZZ=kk8t-=3-kg@mail.gmail.com>
Subject: Re: [PATCH 01/24] arm64: Fix lazy TCO clear when enabling user MTE
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 12:57=E2=80=AFAM Pierre-Cl=C3=A9ment Tosi <ptosi@go=
ogle.com> wrote:
>
> Hi Catalin,
>
> On Tue, Nov 10, 2026 at 06:33:20PM +0000, Catalin Marinas wrote:
> > On Sat, Nov 07, 2026 at 04:36:07PM +0100, Pierre-Cl=C3=A9ment Tosi wrot=
e:
> > > On kernel entry from EL0 with HW KASAN inactive and user MTE disabled=
 or
> > > in async mode, mte_disable_tco_entry() leaves PSTATE.TCO set to avoid=
 an
> > > expensive write, as it assumes that EL1 tag checks are not needed.
> > >
> > > However, if the thread is in the process of enabling sync or asymm MT=
E,
> > > set_mte_ctrl() updates SCTLR_EL1.TCF0 without clearing PSTATE.TCO! As=
 a
> > > result, kernel uaccesses miss tag faults until the next context switc=
h.
> >
> > Nit: next context switch or another syscall. I think this makes it
> > clearer that the only potential missed tag accesses after the prctl() i=
s
> > a signal frame write as we don't have other uaccesses.

Or any other kernel entry such as signal delivery.

> >
> > > Clear TCO in set_mte_ctrl() immediately after setting the task's SCTL=
R.
> > >
> > > Cc: Peter Collingbourne <peter@pcc.me.uk>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 38ddf7dafaea ("arm64: mte: avoid clearing PSTATE.TCO on entry =
unless necessary")
> > > Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>
> >
> > The patch is correct but I wonder whether we need a cc stable.
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Thanks for your review.
>
> I'm happy to drop the cc in the next version. The rationale was that this=
 fixed
> an unexpected userspace-visible kernel behavior and closed a window durin=
g which
> tag checks were not performed, which _could_ be a concern when userspace =
enables
> MTE for security. I can see how this doesn't make a strong case for backp=
orting.

I don't think this needs a cc stable.

I'm also skeptical that this is worth "fixing" at all. All that this
patch does is move the TCO disable slightly earlier in a way that is
almost unobservable except by sending a signal to a process at the
right time. So this patch only has a useful effect if it would
otherwise be somehow possible to compromise a process by taking
advantage of the kernel's signal frame write. Even then it doesn't
really help mitigate anything, it just makes the window of opportunity
slightly smaller.

Peter
