Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C533F8A5;
	Wed, 19 Aug 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136522; cv=none; b=L3X2lqY6Dl/8l5ddfyByRMUK4xa5sy5RwCy5Yyx3IWH0VjcY0n9pzJJPdUnIXHsHlPupawoJAXvA2vBFmQKb2Eg3BuweHxEL7cjxQb4qkKGwCAV7CilTVTk22yZ/zitlrYRI/on4USKyJe4odxOxLnZpXgjS3fkDpNq4eiTd+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136522; c=relaxed/simple;
	bh=hpSZcPeCrOybsmq7CKpv/5gPHqPwMcXOe2uMOR+3G/w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=V5mYw3gsB9SXwdCoT3A7FOtL0NHDBq0O78snXZF9h/Rjyw2IIpw9Rf1CvwKKqyvxmqOQmi8QFILxsm4+KtR/9rFVOpaJZhC3LjY1CMH5bfmSK8a3nIf1ssOoZB7uXIHbbzyQsG84WFaHkvto+oS3UNeAbiU9frYWoZauEa3opBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4D2312ABFA3;
	Wed, 19 Aug 2026 12:48:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Y3tUH4L-z4t2; Wed, 19 Aug 2026 12:48:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C329F1012C9;
	Wed, 19 Aug 2026 12:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BQjyNchttuXN; Wed, 19 Aug 2026 12:48:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9CD772ABFA3;
	Wed, 19 Aug 2026 12:48:28 +0200 (CEST)
Date: Wed, 19 Aug 2026 12:48:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable <stable@vger.kernel.org>, chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>, 
	Liyuan Pang <pangliyuan1@huawei.com>
Message-ID: <1200997805.161072.1787136508436.JavaMail.zimbra@nod.at>
In-Reply-To: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
Subject: Re: [PATCH 0/2] Backport fixes for UBI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF153 (Linux)/8.8.12_GA_3809)
Thread-Topic: Backport fixes for UBI
Thread-Index: F+2qznxSfnYf+NuSw3xrvttzN/fCaQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Dominique Martinet" <dominique.martinet@atmark-techno.com>
> While looking at recent UBI patches I found these two commits that I
> believe are worth backporting.
>=20
> We're not using fastmap so I don't care much about the leak there, but
> reducing wear is always good to take
>=20
> Thanks!
>=20
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> Cheng Ming Lin (1):
>      mtd: ubi: skip programming unused bits in ubi headers
>=20
> Liyuan Pang (1):
>      ubi: fastmap: fix ubi->fm memory leak

While porting these back is not wrong, I have a hard time to see how the
current stables rules apply here.

"mtd: ubi: skip programming unused bits in ubi headers" does not fix anythi=
ng.
It's a pure optimization for future flashes, UBI worked since ever without =
this
change.

"ubi: fastmap: fix ubi->fm memory leak" fixes a memory leak, yes. But only =
in a failure
path at attach time. Userspace cannot trigger this.

Thanks,
//richard
