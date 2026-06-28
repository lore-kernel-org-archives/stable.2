Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9B22126D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664536; cv=none; b=DYiwki59Ov13CNqap2ILXox8FMJhnj38qHO1NYQI9kcjf6NTh/3lreZ6XH/Y2/hH1BGk+fbgXqaYfDLLXeVdqZE0XwaEugAF3A7ecGd6ipNd2C10dcD9vhKmtAHkUo91zahr/APrVOtMtSZ+cRXvd+KGctFHqeDdYBkiWNdJYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664536; c=relaxed/simple;
	bh=feg1jQgep3XR90ITS/HWLD3TLt1/jzWD+k/1w96IknI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbsfQGShBrIx5GM4xuJG/q10DBT5QsBDM2syxMC3ss1DnbbW8PpM5ZcxfYO5OdGYW1TLTo9b70jkS6ICOyIdDcEfQSL9B1KfCF3us/UkC21vtMfAABYhDrX5vwdbXj8nIwXhIhdB3nQJ0lLj9uj0BSqI1bEyQkd9FlHYvo70eK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gVZN1Xk8; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gVZN1Xk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782664489;
	bh=KZ6jSBwNNI4Xu1MQJ+17fgv9rybtJ1/OlFvMQWLDTmo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gVZN1Xk8Dah+0azCAd7yMpICZ/Woa5TB9zsiOicPfPkNji+08sSUWG7L/aWd5R2Q3
	 yT5isSYKY8v8XfX2jtNUHw0HRq6nW/ySDWEuIutgn+n5D/+7uzORoVhFWkODqBci2y
	 Mw5nIywcFjB39NGekI38cSVMPYKIla9kN0NCN1HA=
X-QQ-mid: zesmtpsz5t1782664470t02600310
X-QQ-Originating-IP: BmeNeBLdVSKPVhNaji4wBBoXlp74sj3ntAJ6/bHH+BQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:34:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16407297633576573590
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org,
	sashal@kernel.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Mon, 29 Jun 2026 00:34:27 +0800
Message-Id: <20260628163427.619452-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NzbGdlyIBzohUZO34sG7To0iw0mz22/8DU8wlQ0GN9QQDiBzD/lxP5Gm
	AgpzTT7OoXTFjcAhSaPaW1+Gb8QQ7VhuQaay64fHtCZpeENZHII6tOoyakv0HZoUF+YZW+5
	klGVCLy9XRkVEMlvdOkkjopMJkvgsLCAB+49f2bG6DoJJpeWi/aY/qAXED4mk3NlcyhXRqM
	RMMjVSkoEUZrYmPYAvhR9TnKW0U5gDHnALHQVSfrLT9ENlyBYPYSO/a4fHEqlQyDWu+fw6O
	hXExhmvLPVeGbGYLGjkUdn+LPLtl/NwNqk732JEPb5VA41DiAH6C1PC4nlEIPgPPBN/UtIP
	0+oTteKHxQ2RZ9vuDcSoto8FpMVmVF1XJ8txynLsUlkfuQ+oVVlCZWX50Igg9czDvNqdl6k
	Pb3VPxBoxt1urbVnCqVVrJ/Rz94mVWkdHlK4eROw5i6m1xiIHGCNfqXiCV5FqIAf/LzAqjV
	oUOtwmu/HyxZDjkzQim2NmmqVbolvIVPJRoL7kzleZOi2l2qyouqI0YxajvOAe25efJ73+b
	OFadiA4dxQjk0MiNLjOksASjI51ZAlfKx4feifxf99n+C72B3C7n+rGAQiK1/Ix24zvDaAL
	bf/QFoHFyl+x0HBORBHTbYUeAVbnBbh6EXb77iMB8HwPqmL0uXe1+ezFocQbfD7OpoRANtt
	zZCegRcD3jFSecZh1J78Rg7SUkUI6jeGVdmtVZaWXP5rGP7TIT+mHyN2cukQ5GVOoZtP01b
	lyKVNbeQOZL5j1Nh4eLG5RU2Pe8LliOUMymshoK9xyQfWKwdoe/CxsL6msnWiZrHIZ9UTmr
	Co3nPfO2FbosvjuBOwp3nquqY5P+3udi+QjXbzuqbJ3U2WG7t2HfCadjVLM8LRpUqhCrham
	d21CETe5sLC3RuhAEYC7I6NNgqSAjl5ZE1miQseDdDvpG/a/mW9m9EmeH5yXwv1vM3fkuwj
	hODVgvSePt3Jc9lGKW8B8/k284CmPFGTVaqFgoGA589dDakvv3zQlwRVIWaqkkrGOcn6qJA
	6XduOZgx1156z/V38+we62+Dc98yKZdVFn5FrAYkwgRdQGFYrOU4rjyu61qpZs4w6Vs6N2j
	wPR+l6xJkHMjnj3Y5iYAY2u8QuQTmmm6QP3XqNouPqiUMrOWwGH3uEB/wuOfJK9fR/MTcXT
	cZrN
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hello,

> On Fri, Jun 26, 2026 at 01:54:18PM -0400, Sasha Levin wrote:
> > > [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll /
> > > struct file UAF (CVE-2026-46242)
> >
> > Whole series queued for 6.6, thanks.
> 
> 58c9b016e128 ("epoll: use refcount to reduce ep_mutex contention") got
> backported as well to v6.1.175 and v5.15.209, will you provide
> backports for the 6.1.y and 5.15.y series as well?
You can try it for 6.1.y, it also clean apply and build successfuly for 5.15.y:
https://lore.kernel.org/stable/20260628161933.532572-1-guanwentao@uniontech.com/

please give a review.

BRs
Wentao Guan
