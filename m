Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B93F4122
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652200; cv=none; b=ObHnlshBMXJB27dRbIEuIOmHIAyNoYVrq1cEQdKGEpOYRxBRpLPtFwkTS9hLqbfr/UxJGLgUtrul6NueFhbJVrSfwUDsA9ic8YRlqgJ0hKzpLEcojKdgNaYmwUN49+7gUBIoT4S0ZxoyF1P35wmIN1pQdsqMeGHgEzAanTLGbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652200; c=relaxed/simple;
	bh=rw7xSFg4qGiBo6rDQu9wNuyiFj6i6euSwOV3NoXrJOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJr8dc+Z90cGv/qG8+tOSlB6GIKPJNOCWZECGrvQ6WczjftX5ybHWpd7aQ7b/941P8NUpTBnv4mawFoK2FKzz6iA1YzsF4fG77gcNGm5b2eiw3ouvqz8QpSGMAdT/1zYgr9rbr7I+XaxKjACna/VPXgpG387hIbD6Kp+HejMWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bROssycP; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bROssycP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787652140;
	bh=NWGNtKoLif3doGE82u8YSOUvJxh5VqQCKY3Ro5zxj18=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bROssycPSg3MRW9UANgND5KmHqCRMfiOKeQl2lkocMd0ApQ0HvIBLhSGE3AtuliGs
	 bYbTaHZy3yaYGF13C2BS7EYk+jd05bCxjF50f2PubyRH+LitOQfagdTVZjsOnIXyYs
	 6LZJjjITRRrgqOz5vI3wsgfynw0Vu1fgXkrAj6F8=
X-QQ-mid: esmtpgz14t1787652137t346be51a
X-QQ-Originating-IP: +PoBpsMEmcmrH8uLSeLubNHAd6PAX9dho+Yrb2FaX3k=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Aug 2026 18:02:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 49490489207358528
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.y 3/3] selinux: require a class's permission values to cover its permission count
Date: Tue, 25 Aug 2026 18:02:14 +0800
Message-Id: <20260825100214.4039658-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260824220022.435960-3-sashal@kernel.org>
References: <20260824220022.435960-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MhK4DKsBP06iYz50wm4ze2TWy/+9YbyDrcKu3eVUBOL9Ut2YvGTbQHnO
	kr53aCVbZLatWnRHrb3Wg11VhIyKD7ZhWZBQxiclvCpqm1IM05Wj4wCBHVz5HXl6YHFJOz/
	5fycUGPbEaA3mkLfltgEXsGLhm4dNj+UHBuD/hQQ2RIBmbXTFS8UKVsozcMi850LqP7UU1+
	MRc4Z0tK427wT1Qrz4xg6c4evfUzPTrqszRQoJ1rsU/mRXp9AbQO832sRDIsem8gAp4mOeZ
	/n0l6PjRxE6NRrQ7x34AIlIvsvG4EpDTIT/EYZZCVwDFYHKavHtQmCi1+HJlUtpBzQ9TlZV
	WF+c79XjLn2opfd0L8ZlSpUDDIBHCByEGozRR2e+KUK/Pb4dKxbkEXrUhKqcz0nf0MO9IDb
	uP9DIp/EneexJ61P0TL6tUvYe5JghkWgh8CLQ05v9CyFfZDzAsk0oB4raeycY5mRLE+w+4o
	ogx6WtMEz3b/XBuziuP2+rEYoGvlvisKAVf23roXZ1+uun/RMmFA34PiuRwWqcgGpWQ6j1X
	+F3gWLHT0o4KYWRnOmn2UH6sfJA+Xs9Qrk5TX84M8Glu7xMIR+r0nlIQBskLyInlivdS1Jb
	obGfgcn4jn8Yow7CxAbt9K+dOJJClCgde++50rBr6QLBTpStPvh7GrS92KjA1m5CZxp/x/G
	iQS+llWXZ1wpX46Urn8cjUkDwx705NSOTUHZ8SS6Jxyl4OyN1pslDi0REVh/Um3hRfLhJcP
	eoGAmZSUDO8YKwZFFSFTOEiSrKf3lkiEjNQnAsPH26rsrn1CVVCQPNYdVmpC/dQJ4wzFNWi
	URKtXKM6Ly85BT6fcAVdvqu+czMSRRostoxeieu2zNkEqXAUlO3253kYmum7FTAS5D0achw
	L3QaqMZJPAlDYTBnyjd+CHH1ZKUgXKRa6p071yU2nxFB7E8ic9ln00ovhA4Vez7P84AYdiv
	93OohaltxlrzjNt4rfYGZezBf3DJlv1hUMph6JjaDpQFMW1GuIY+bqEWKSTZGP/QV7G8/1d
	GXlpPOc2UQkKqRtdbVv358sFrNhTg222ke3RMHle9OnwG/nWFPCrEQSLAOHXPG+6zpEDa6H
	nQ4quwFnZsUeMIIccqAG0WwAzG6tAzyMhx1GTba7pnb
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Hi,

Thanks for your effort to take the backport series, but it can goes better.
What happened in my side is Github Copliot review point out the issue:
"This validation runs after symtab_insert(), so the table already owns key 
and perdatum. On an out-of-range value, the bad path frees both while leaving 
dangling pointers in the hash table, and rc is still 0, so malformed policy 
data is accepted and later accesses can use freed memory. 
Validate the value before inserting it and return -EINVAL."

In continues review, there LLM point out the mainline don`t had the issuse,
for correct sequence is that git log --oneline 
(v6.18.46-1) selinux: require a class's permission values to cover its permission count
selinux: reject a class permission count below its inherited common
selinux: reject a permission value exceeding the class permission count
selinux: more strict policy parsing
selinux: use u16 for security classes
Revert "selinux: reject a class permission count below its inherited common"
Revert "selinux: reject a permission value exceeding the class permission count"
(tag: v6.18.46, stable-gh/linux-6.18.y) Linux 6.18.46

You can try to revert 9b46fba7528f58ca09eac67ec7d474ff1e9af066 and 
next revert acd5b09be98fd38b7392307880156fb0452a7276, then pick
1.fa79a596848fe38c55ccab8832ac35dac07fb00c
2.18fa21f10d008a0fc22565109c7d38f304295912
3.d14b5d0e97fccd27974fedc03b903408872907fd
4.9a82dcd98b6e6e11cfd162410967951f12152528
5.b98a8ac50775540f3804397ed08f61ef9910bcab

I will send the patches in my side to show it, note these problem may existed
in other branch I don`t seen before.

BRs
Wentao Guan

