Received: from lf-2-16.ptr.blmpb.com (lf-2-16.ptr.blmpb.com [101.36.218.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBE3BE645
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484867; cv=none; b=kG4i4mzpzTt+QzOEJWJVvSNWpqrJ6JCsZ9HhIySnhOleAfRomT1YG3xFF0Zhqe9KjxGyDQ2wV6/JruD55qc0j41hM4ZPNFYreSToQk56JXMSbezDCGa0yerTbRhfKCeYdtjB77LBSy4GBODn4wSKPfxbWbCGkGV4E+rQ4CdaSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484867; c=relaxed/simple;
	bh=5iJMfpN+UEhVGJ51zCiaZKkcFSvDMfG7rQDnAZqSSKM=;
	h=To:Cc:Subject:References:In-Reply-To:From:Content-Type:
	 Mime-Version:Date:Message-Id; b=D2/lNUZYCfU+GUbhQHVhJxKGgZxDlL1MmudqS1YMN6wRta4GglP7QFOmoYkllD/FoewBmeoyJ22NYSY0Og5/onKsmnnSnh+n4wFGod6+z+IQtLcThn2syTqZtMDsrMwyaklZkmbblf99VKaMoCUI/oJ7QAGRmNMINTomOG8j7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=f3S/jjsc; arc=none smtp.client-ip=101.36.218.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="f3S/jjsc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785484807;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3FBLXiHbSUYhxm+yCfVtAx0VCQC3jNkGT8AIcggfV6s=;
 b=f3S/jjsck8nH8w0w68njrgwNHdXzRydGXlPG6TtZi+7kR289RwRa004Kl9z+g+bwdjN07s
 s0I4jP1VIcR+pgdCxldnlycFzFzZXujJWNnD1qU3dVHv10y7d1yZUIZhLdkfNKZAQPnBUu
 FSyMuUZ+0KBxIkJdAv0M+wpxhYBwZHi0Mur2ESMlAqDuIqHXLTwShu2H9isjvXV90eTkKx
 NqgQ5pi+iykgYHiJLxhBfieF3YadoXatieNAgcM2hSu6QQvPmJPDPDiHBv3JmzjDgP/82S
 pOF0Bu33Flgo7RjPT8SW4ZDzgcqnS1E1tOaDsyFMvT5xPVI49p7+mK7ukwm4qg==
To: <colyli@fygo.io>, "yu kuai" <yukuai@fygo.io>
Cc: <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Ramesh Adhikari" <adhikari.resume@gmail.com>
Subject: Re: [PATCH] md: do overflow check for sb->bblog_shift in super_1_load()
References: <20260720111400.2120834-1-colyli@fygo.io>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Fri, 31 Jul 2026 08:00:05 +0000
In-Reply-To: <20260720111400.2120834-1-colyli@fygo.io>
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Date: Fri, 31 Jul 2026 16:00:02 +0800
Message-Id: <e8e9bb6b-434f-46cd-a30f-2abc7873f3f8@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a6c5606+a73c41+vger.kernel.org+yukuai@fygo.io>

=E5=9C=A8 2026/7/20 19:14, colyli@fygo.io =E5=86=99=E9=81=93:

> From: Coly Li<colyli@fygo.io>
>
> In super_1_load(), sb->bblog_shift is an __u8 type value loaded from on-
> disk superblock. It is used for badblocks API badblocks_set() by the
> following sequence,
>
>   1930   rdev->badblocks.shift =3D sb->bblog_shift;
>   1931   for (i =3D 0 ; i < (sectors << (9-3)) ; i++, bbp++) {
>   1932           u64 bb =3D le64_to_cpu(*bbp);
>   1933           int count =3D bb & (0x3ff);
>   1934           u64 sector =3D bb >> 10;
>   1935           sector <<=3D sb->bblog_shift;
>   1936           count <<=3D sb->bblog_shift;
>   1937           if (bb + 1 =3D=3D 0)
>   1938                   break;
>   1939           if (!badblocks_set(&rdev->badblocks, sector, count, 1))
>   1940                   return -EINVAL;
>   1941   }
>
> bb->bblog_shit is in range of 0-255, variable sector is 64bit width, for
> an invalid bb->bblog_shit, it is possible to make sector be overflowed
> by the following calculation,
>   1935           sector <<=3D sb->bblog_shift;
> Then in turn when call badblocks_set() at line 1939 with the invalid
> rdev->badblocks.shift set at line 1930, may result an overflow inside
> _badblocks_clear() in block/badblocks.c.
>
> Although there are many places to call badblocks APIs, the non-zero
> shift value is only used in super_1_load(), other places always use 0 as
> the shift value. Therefore it is unnecessary to do a general shift value
> overflow check inside badblock API, and just check here as the caller.
>
> This may avoid unnecessary check, make the badblocks API code more simple
> and elegant.
>
> Fixes: 2699b67223aca ("md: load/store badblock list from v1.x metadata")
> Fixes: 1726c77467833 ("badblocks: improve badblocks_set() for multiple ra=
nges handling")
> Cc:stable@vger.kernel.org
> Cc: Ramesh Adhikari<adhikari.resume@gmail.com>
> Signed-off-by: Coly Li<colyli@fygo.io>
> ---
>   drivers/md/md.c | 7 +++++++
>   1 file changed, 7 insertions(+)
Applied to md-7.3

--=20
Thanks,
Kuai
