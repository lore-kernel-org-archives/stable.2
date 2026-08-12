Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CC374E46;
	Wed, 12 Aug 2026 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510514; cv=none; b=JFZh+ukZbF8KQeA7CJONXJSsvOd74JYiGUGr1Z77s+CDfQyfkuy6aW0ybAm0tl5/tRIBL0usRx7uWJQZIM3C+bl8ttLz+QOmlTzQwS0ef1ShAACRE5Kfi4Y0l6SEnBKCioxTfRtPXnwIUMAgyRJl/ejDwRf8OUyp61hL3gJe+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510514; c=relaxed/simple;
	bh=5mWgxJ9GZ51nFn3YgIYf16vR1icfgUA7eh+a6qngq6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9+GlpxHVboffPdJtfKEjRnVVxlRdphXzBGe6xxZxLz68nb1PkJC5oP1mdFt6oDeJ1VUS2hBu+ee2MfTO9fdHk6JTJn6gUu3EfUXftfGRIvby2vZB+ziNrmfqMi4MoT0btp6jeuiORdCrCuMi/joOc6iaaWy8bNChdolvbDXPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1NhCFf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1NhCFf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62661F000E9;
	Wed, 12 Aug 2026 04:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510512;
	bh=+vcu7CdMtV02AKnmWDFrxCMEzqunrfJe+AzNq1H3hyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k1NhCFf9ebADikN4d1tDMlwcjyaD0QcGeKKx9Wy6QLNIo2KoP7/hSRYPTy0HezFJV
	 6uwbFC9dQ5HitF0irYhrSloayZkVsY7CWNvfXKsfGVy5V2dpPop+FO6kibaOKKqOU6
	 uvQNBOJwFhOo+uSla0Gh3fRzLA6cxYowJJcnuGEfK1jebgvqUwkJPKzk5TXE0OI6EE
	 do6U5skPqxXgi0qQK1CNQrRsAbGlHannehkbQZuEggojEutBfFYDXnButGWUMTZSiU
	 bnS5cGgFdMBJwQe+FkVBNSMdYeYBdjKrQ7kmUJGdO/0KYP+2yBy0Cu9PojtYGcRKAm
	 xNpdm94z8rmfA==
Date: Wed, 12 Aug 2026 05:54:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "David Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer"
 <sean@geanix.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Joshua Crofts"
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample
 count
Message-ID: <20260812055459.4163c1c0@jic23-huawei>
In-Reply-To: <anlTG3uxHEkyxtQv@pve>
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
	<20260810003101.3a2d1967@jic23-huawei>
	<anlTG3uxHEkyxtQv@pve>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 12:27:07 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> On 2026-08-10 00:31, Jonathan Cameron wrote:
> =20
> > Same comments as similar patches.
> > - Not a fix, but rather hardening against buggy hardware.
> > - Don't hide the problem by clamping.  If this happens in the wild
> >   we want to know about it!
> >  =20
>=20
> Hi Jonathan,
>=20
> Thanks for the feedback. I also just realized that this patch
> duplicates Bryam Vargas's "iio: accel: fxls8962af: clamp the
> device-reported FIFO sample count", which you've already applied =E2=80=
=94 I
> sent mine before noticing Bryam had gotten there first.
>=20
> Since Bryam's is already in, how would you like to handle it? Either:
>=20
> - just conclude here, since Bryam's already covers fxls8962af (I'll
> drop mine); or
>=20
> - rework to the error-out approach you described =E2=80=94 though your
> feedback (don't clamp, report it) applies just as much to Bryam's
> version, so that would need the same treatment.
>=20
Oops. That one hit me on a different day and seems didn't think of
it in the same way.

At this point I think it's probably not worth more churn for something
we don't really expect to see in practice.

However let's do things better for any other drivers we apply
similar changes to.

Thanks,

Jonathan

> If you'd like the rework, the fix I'd propose is: instead of clamping
> count to FXLS8962AF_FIFO_LENGTH, treat an out-of-range count as a
> hardware error =E2=80=94 dev_err() and skip the flush (don't carry on
> reading), so a malfunctioning device shows up rather than being
> silently papered over.
>=20
> Happy to go either way.
>=20
> Best regards,
> Shengzhuo Wei

