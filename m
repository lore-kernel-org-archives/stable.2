Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7423EF0C8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162200; cv=none; b=cRq4mSd5y6hR2ZfjmxbQ5FxkCmSMqfbXbKo6B6bCYZQyegscuLQzM84YY5Tmv+eaoAe4cfDj69SFv2wFGU6R/Gx+1s8n6UAaiRpplUxC7PrG6IknHJWbaBRf1WgIgUl/XZ3jbJwWhChsLqdZ6YL36tl3f+zRtN7Ug3Krqy0qZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162200; c=relaxed/simple;
	bh=F6zebwNMl89BNoq0+FV33PsXigZ7rkkhvOE9bJ9HCI4=;
	h=Cc:Subject:Date:In-Reply-To:To:Message-Id:References:From:
	 Content-Type:Mime-Version; b=QgHLF4J5KT24Pn2IDcPjkWW003gdhK9QDEgtO2sc5fndvFSdjH+bjbuq3Y1sHShQiogBTyxSka/nxxZIUTsdnUDPzYldMVgoEteTGQ+TrgNbDbmr4k6fQlmBYErs4IKLOFQD+4xXov7Ggl0V01OWkUvdbGoSAMWeNsveqp/1FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=XaexBR0I; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="XaexBR0I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1790162193;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=w8ycr9qCq0aWsRIBEU7Iu3sVBwaUmmFgt5+GrXlxml4=;
 b=XaexBR0ItyHO+3LWzGwD8xJMfNI2aXymmVyZ1Qn1o0KrhnIdVOhTY5ZJX2/NmyqvmPHQQ2
 FcItkNmdnwyZuR8V6vX+Qjlq3IlR9o5YAZ6XlXdw6nLD0YjC3r0ARuD00088f8qjhjyznH
 fCwzmnJTeDPPhaF/rDgU8bfp53lYRx+dIozVfBA4YfgV6/G+Od4VejmaG7zO3GtrlqNye3
 LaMGTFz+yVKgXVV8ytBBWx0B5e71MQcZZJwroLsrQNR1n2fGEFVa7aapEi3jypxYyEvT9z
 ho3Loo4KnPL9aNqhSQISCXvsQFQuUyAKo2LEdY/SZiqHJU0tkkyOP7QSUJwOAw==
Cc: "Xiao Ni" <xni@redhat.com>, "NeilBrown" <neilb@suse.de>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] md: validate bblog_size when loading v1.x badblocks metadata
Date: Wed, 23 Sep 2026 19:16:29 +0800
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <20260922044606.30774-1-ndaugoing@gmail.com>
To: "Yuchao Zhang" <ndaugoing@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Message-Id: <a7464a07-22c3-41c7-b1b8-c8534001ce67@fygo.io>
X-Lms-Return-Path: <lba+26ab3b511+c0749c+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.179]) by smtp.larksuite.com with ESMTPS; Wed, 23 Sep 2026 11:16:32 +0000
References: <fad92649-e362-443a-93ea-205b11247e6d@fygo.io> <20260922044606.30774-1-ndaugoing@gmail.com>
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird

=E5=9C=A8 2026/9/22 12:46, Yuchao Zhang =E5=86=99=E9=81=93:

> In super_1_load(), when the on-disk feature_map does not have
> MD_FEATURE_BAD_BLOCKS set but sb->bblog_offset is non-zero,
> rdev->badblocks.shift is initialized to 0 without validating
> sb->bblog_size.  The same field is validated in the
> MD_FEATURE_BAD_BLOCKS branch ("sectors > (PAGE_SIZE / 512)"), but this
> branch bypasses that check.
>
> A forged on-disk superblock (malicious storage device or crafted
> image) can therefore carry an oversized sb->bblog_size.  When bad
> blocks are later recorded, super_1_sync() sets bb->size from
> sb->bblog_size and md_write_metadata() issues a bio larger than the
> single rdev->bb_page, reading beyond the page and leaking kernel
> memory contents to disk.
>
> sb->bblog_size is never modified by the kernel between load and sync,
> and the MD_FEATURE_BAD_BLOCKS branch already validates it, so checking
> it in this branch is sufficient to cover both paths.
>
> Fix this by rejecting an oversized sb->bblog_size with -EINVAL,
> matching the existing check in the MD_FEATURE_BAD_BLOCKS branch.
>
> Fixes: 2699b67223ac ("md: load/store badblock list from v1.x metadata")
> Cc:stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang<ndaugoing@gmail.com>
> ---
>   drivers/md/md.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
Applied to md-7.4

--=20
Thanks,
Kuai
