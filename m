Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DB386C13
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687405; cv=none; b=HasMpBKbIwHAaZhsXeygLZC70LuhncJVjOYFU+W7ggWdZyseq6jqT0DXVdeAPqbGX62zgE69Odd0lTFfdIjNp1X8fiBuHV+qM2+zhgYbu7TIj5eNqwR+0UTtgLU7mts2xUI/9Fordlpk0w8TNm6STYll7wGwgR8SRmXVd/AqBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687405; c=relaxed/simple;
	bh=QJm9imkkBkLNMyOfyzyd9mU/P2OJi6Is5RNRwjMDOcA=;
	h=Mime-Version:References:Date:Cc:From:Message-Id:In-Reply-To:To:
	 Content-Type:Subject; b=e9nmkX0RJHAsEcOQfPwbX93Ee4+zCD9BqzcvkQtWCd3au6n1umNctQ8fX7LzRpn92+6O2uo1ECqXyjUofCntkML381+SotvBVT1QQSte/1k/m2wh/CtbQIBSsj7rv4FADa5REFZ5i1dv7dhwEpXxh57EJEOyIXfGzCejLlNeFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=OJOP9Rjq; arc=none smtp.client-ip=209.127.231.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="OJOP9Rjq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784687394;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=n/7jmLesY/oUgrDE9Omk4IvRB0bZedKyJweWBYqBPWg=;
 b=OJOP9RjqpBvbZc3ceVURZhB9Y1mlnl5eewz4W+UAGvMambUFMRabtME743Pr5lotFf35Vr
 ANOit3SG40cD0ruOUqICRXXWSQhNUIcwJEFagm7WAQvTnoxPpy7ws/EuOgL0+yjJ3Cw+J6
 rV7xBEyM7Zd5CR4Ke7cBHWkW/P+oQlEWwDjAL1zY2BRcZalhYCUv/HYW1v8S+QwnWhDNSk
 fInjGX9diOjJlsjSXhKfVw8WyfW8MecXeXb9lS4WbJU8GDJ2IHcJGjO26fBS7hb4/6/K5T
 HBhMjyFXyYC1VN8srPqL0IXiqNkUKOrYXd1r1MM6G0BR2MuSAZEqIECUDLwetw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720111400.2120834-1-colyli@fygo.io>
Date: Wed, 22 Jul 2026 10:29:49 +0800
Cc: <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Ramesh Adhikari" <adhikari.resume@gmail.com>
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <20119f4b-a671-4484-82e3-7c12d9472413@fygo.io>
In-Reply-To: <20260720111400.2120834-1-colyli@fygo.io>
To: <colyli@fygo.io>, <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fygo.io
X-Lms-Return-Path: <lba+26a602b21+b06af2+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 02:29:53 +0000
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] md: do overflow check for sb->bblog_shift in super_1_load()

=E5=9C=A8 2026/7/20 19:14, colyli@fygo.io =E5=86=99=E9=81=93:

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
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
