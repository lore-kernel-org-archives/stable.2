Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A738655D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518763; cv=none; b=jhAXOKmRvaNZaAOVRQpVVRE+Thv7d3NAU+x5h/uk28PXCy0RpHOKEc63bwdRhzum3o8Nm/i3oqTLnzsBtl+p76yhIWJkPZejQvyyyQmOTWcWRSg+lcNJ+/7LOb6B8CdXPYnwt50sTZRU4E+IC20krjso857JezPH6+1Mx1MBbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518763; c=relaxed/simple;
	bh=v2mdT8xBZcqIC5YgWQChSYzR/3O4S5EIm0wuZ9GCi+8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:Message-Id:Mime-Version:
	 References:Content-Disposition:Content-Type; b=GSALIPVbCEJoaJaYrFLm9cTbWqGUmH69Rf5SsL2TFcLH1vgP647w5ob7fLUzFRw6cOcLRY5KRQ+E7NSJAQk1WNSTv+WlQJPRuwscb8gRn6mlCNADYy/Wq9B5poS/Qt4eeWv9jPQnClgGw6uWIn0HT2pbgMwN7R+Cnfz0Jvm7WIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=AmHnaR4s; arc=none smtp.client-ip=71.18.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="AmHnaR4s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786518744; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=v2mdT8xBZcqIC5YgWQChSYzR/3O4S5EIm0wuZ9GCi+8=;
 b=AmHnaR4s4DQrN76ZZ/cDFBhcuUEJYY5x1VqFoXRnRHGSEyrv5JdYeBSH//VHp38utBCzak
 Bh+lxTI/d57VBJGeinJBK642ghuZSP1rr+6EPC+zkFOPGYe0LYkKljmKQTzhmwys1KtMLk
 oIFeHEM67XDzBcx1g/hepmOwtX4++PZgyHPzjAYO2bzEqp5la6VBGLv6J5aMxE0GfYKXb+
 h6IS274C3ZZgYdbvruIMp/SPoJeGJfKkDd/lJWI/1a3P+o8gvHtt1PN0Wl4GvbxSexzQTk
 8FhNH81+qji3wIxbJK62tEakAZf7Vwokh0DnIdrMr7BrQINqecrSRriyiQ+sAA==
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Wed, 12 Aug 2026 15:12:18 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample count
In-Reply-To: <20260812055459.4163c1c0@jic23-huawei>
X-Lms-Return-Path: <lba+26a7c1cd6+eb77f5+vger.kernel.org+me@cherr.cc>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Shengzhuo Wei" <me@cherr.cc>, "David Lechner" <dlechner@baylibre.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>, 
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Joshua Crofts" <joshua.crofts1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Received: from nobug ([202.112.51.208]) by smtp.feishu.cn with ESMTPS; Wed, 12 Aug 2026 15:12:20 +0800
Message-Id: <anwc0sf8pLdZtyEq@nobug>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc> <20260810003101.3a2d1967@jic23-huawei> <anlTG3uxHEkyxtQv@pve> <20260812055459.4163c1c0@jic23-huawei>
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

=E5=9C=A8 2026-08-12 05:54=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=EF=
=BC=9A

> Oops. That one hit me on a different day and seems didn't think of
> it in the same way.
>=20
> At this point I think it's probably not worth more churn for something
> we don't really expect to see in practice.
>=20

OK, dropping mine.

> However let's do things better for any other drivers we apply
> similar changes to.
>=20

Will do in the following patches.

> Thanks,
>=20
> Jonathan
>=20

Best reagrds,
Shengzhuo
