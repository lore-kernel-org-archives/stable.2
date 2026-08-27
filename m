Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074B421225
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822352; cv=none; b=mzP9sYBtMB9NTBoPCyi1vzfPrlYnzJxIXndWEVXlBoxQZws1Ygb0rKVEETJZta7PkPjr2InpSWu6zf97R5UqNi7w3ja+4qgqqt5HxbtAK+ZO/ku4w+5bDiRMgFN38wxZE5KyElkWAzUWZHLa/HwvXCJAsiTBmQxuGU7zEdzoz+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822352; c=relaxed/simple;
	bh=V27kDcCUQkDyVkh3n0TQe1CJ07XNDXMlZliW+M6tkq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFApoo11DPxGudwX8qCrmBbunXG+S7rNpedsR/mjwfCClRDaXmlmWY1quim9BqELC/FGISgbav2LcvUYmXFhGa3EfMiF8QRtH5k/sFloZJy9GTSQiWHj5zhP+VRc4gDiG++ac8tNjDc3Md/wcPc/7I0TPsdOl98gLThkEpzwpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CafXWYEC; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CafXWYEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787822299;
	bh=ks1WHociNsR1BBx71i/JkFOyjWEllH/qSRlA5meZWeg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CafXWYECrB81CCgqP66iESii6OHwgn0K54BIap9zStDsro5B4ODRcSWmBnXDhHOiC
	 0EM+uxpDzTQ++gTIqpOmvAtzkclAaJzfzBSiJBsIvfH5EZEQtH8aF8meoXq/nwZE0y
	 5d2Qr2JYoSt+1e05YdcFfhsl0oKVpPPuugSV/7ZI=
X-QQ-mid: esmtpsz21t1787822280tc51fe3e9
X-QQ-Originating-IP: VdquQgaZTADIqF8jiOJUhaTOlS67Tiwl1mZuKq78d5E=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 17:17:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7797810617439821836
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 03/10] Revert "selinux: use u16 for security classes"
Date: Thu, 27 Aug 2026 17:17:57 +0800
Message-Id: <20260827091757.4048562-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026082728-sneer-ecosystem-fce3@gregkh>
References: <2026082728-sneer-ecosystem-fce3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N61MakLYUF4qO8xLFRh9YWBfSyrlOFrPg8h6/0ykl5yw+6DjIR1aSaHj
	t0t989IxxsQu/qn+jMrEnWmlCk93Gf9uTeIoewaQsLoqndMCLHaBfZxwDOK/xRocda3iDUi
	FJq6bWKq7U30zwFQj1LTET7x8n0awPRSimev96Kg6muyadn3QJgE00OmEnzlyTgJLMyhOlv
	uKExE7Ltv0xj/EUvxC11KIusCtjwisOlxJFcXLzeaR4dMTJHkToLvyvj9Yc+E4mPpEfXGd6
	lDO/zcxl5XcynsJbofw0dtW2nGnddS1oohNkH/oOZ4DlijpqSzv6HGBM5nBUP+tSft4GXui
	VZ48YtRt1/3u27OZMh1raoE4njKq9Ar3g+h2oLousboZa6VT/QFZCrtiw24Xvtb77JhFqMg
	yLSiql8U9Ph/slL+L5w6J5UlKaHnQ/9O4Qd1gvRZyZ/xO/pxW4l2qyUTvHDbNTdfKonzEWC
	ChhZc2dt6I2HogZ4ilKeuFn8hSQtEWXFP72+yWtMDGqYxLe0HIcUiAuf6KFXXVXwUJO1bze
	v404SSw+DjXSw50cU4HSosdvdmBEJGtXyjda7eU8XZLgoM9UbUB7X4vhgaAwOjeRVny+xO9
	mdryZ9e0V7dqMTLl/wNeu6i/v+uWyFESSbbHNHsMOI8fUbi3LNUcLw4jI3LQ+57AeYEqfex
	DlcWZxdG1qo1OPburkbB/+fj2jGxs4RE6pGfBEOVwVH/B0Kf6w9kg2YsqNciZN4sSYpuSbs
	EuNiGoSajcNmHoAj+sYZH+esQBxb8vOdGrYOtI6dC65cKXs0E3SjxBQZOhLThWIJKJCOU0Y
	eX0sl5+kBAsKz09zimPkx7sbxruqeK7IpgiIrJdZS1LB7UhJukjkPsLKmiHg+CsOFn8VAvA
	esuRxdQPuJy915MTvVmoI6+szz2ff7lWHuFOd+36sD+eHOIV/tSLYVZi7OdOIrfINL67Igi
	Kr1K4oPaPjqiGWUZZDsX7B2g+UlTR1ua4EffqGq/jGUA9Wqp5Lo1pIz4p2cqYtGRf3V2KUb
	YDNxDnY3t5QtI28h0yKQp1j+W2QKuZ7Xk3y9s4W+Z0cUi7AqD7xJDqT+d1XlAesRZvKdhnR
	PD7R6nXGHI6Jtn7eJDmMmVsN/Vl+VhOVTLGzH7HQVMd9FZFDy+ChYUoJGzclQaizx8Aud3g
	0gsxz5jXG2Ej3JA5675K7kroYWehB2HddVYu
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

> On Thu, Aug 27, 2026 at 04:38:00PM +0800, Wentao Guan wrote:
> > This reverts commit 3683f35c14816f827a80e217072018eb6c37422e.
> > NOTE the commit revert the commit in stable-rc/linux-6.18.y
> 
> But why?
Revert and cleanly applied and not olny follow the mainline seq, 
but also final state is aligned with mainline instead of context different
 in security/selinux/ss/policydb.c perm_read():

+       /* indexes an nprim-sized array in security_get_permissions() */
+       if (perdatum->value > s->nprim)
+               goto bad;
+       /* two permissions cannot share one slot of that array */
+       if (*claimed & (1U << (perdatum->value - 1)))
+               goto bad;
+       *claimed |= 1U << (perdatum->value - 1);


> 
> And a blank line should go after the "this reverts".  Or just use the
> standard git text here?
OK, and i seem there can replace the patches in 6.18.47-rc1.

BRs
Wentao Guan

