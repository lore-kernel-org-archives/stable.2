Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998B4078CE
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827075; cv=none; b=cY9vYvsqD0TuP17q30T+xWAeG0JTXQxFxVXDL3g7/BcrWVn9V+UC3Uv/3PX+ukaDAd9cHgsfCClCSM8xiY1Oq7n1rmpoMkrXTIyBUucdN/YOxS11jw7ym/6eIexOU3AdaPGWBbz7S3kvXK6h6CUUPS8azZKHe20opFg5fyDIWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827075; c=relaxed/simple;
	bh=4pBTvAdBoPF6wOxw+WCNvqxYFFg3eyX58kUJCG1pYR4=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=cTokUjK5ctBCHSmTitPBRizgv45wsU29dwP21yKofEB+h97CXbxW4+bA/3m25nN7pNnVfDznTTt841rdM8my6mX34rMumYepV6/o5SmGWClezs1xUAifkTVyOvmfYG6YhR5PYtyVqpifd3jyYfbqFk+jVzZPI8vsfoRnRA6yr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YpmZuZ56; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YpmZuZ56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787827031;
	bh=4pBTvAdBoPF6wOxw+WCNvqxYFFg3eyX58kUJCG1pYR4=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=YpmZuZ56jZJmjVZMcI/2qgrVWmX8xERSNGhIKh5sJLX9T2WEi9DlqnpYjMfUqCxWR
	 jEvnEWMYaaoJUXQXCWnoF51Iu3YuKKJjJAW4aM2nzVvufX1sA1alIBKp9Whv9SrlgM
	 llpsuXLCUTXNxsHflWYmkIcpUAAji6EFgcqv0T+I=
EX-QQ-RecipientCnt: 6
X-QQ-GoodBg: 1
X-QQ-SSF: 0000000000000000
X-QQ-FEAT: erT/nm0/TTfETJZcetRxk6GKE8CXETpi
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: eiQuQV5IvJnmCIEOLI8Xyz4ikV3WBggYiQktLd4pDOlGRrng1Qu5V8oaeWk5X4re2Hd2vh64wJPgXspbkx0ASQ==
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1787827026t33382169
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?aGV4bGFic2VjdXJpdHk=?=" <hexlabsecurity@proton.me>, "=?utf-8?B?cGF1bA==?=" <paul@paul-moore.com>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?c3RlcGhlbi5zbWFsbGV5Lndvcms=?=" <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's permission values to cover its permission count"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 27 Aug 2026 18:37:06 +0800
X-Priority: 3
Message-ID: <tencent_13FEDEFE3555FA9325EE9C35@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <2026082735-footbath-absolute-3048@gregkh>
	<20260827093227.4050399-1-guanwentao@uniontech.com>
	<2026082752-aviator-isolating-5239@gregkh>
In-Reply-To: <2026082752-aviator-isolating-5239@gregkh>
X-QQ-ReplyHash: 1859000407
X-BIZMAIL-ID: 1805027223581237088
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 27 Aug 2026 18:37:06 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NgqWyBMNfxS2X9fdkna5OOc8QvOe/zzZv/w6FfRBPoJniomm1GPhbcYR
	eX2cjXbVo1+l27bT5l1vwdXg3tkL3vR75Lh6rdaxPIVv4mYwAlKI3MXJw/PREwwAf57wg1X
	gJohyMP8EI+KlhMZWAqxT6m4irCbq9nT1lXVia65eV9sYSOdBh7v/hyflbQ5XWc31sC32i6
	xkq3YhGNuUGrHkFyUFhxCInmGllRI2EcDQnAGzvxll0Pfufk8UJlStdTrvpPQyhUCODfbjf
	BwXncEIuGecgx1Ru33w5cCUtMBRcmNIRTTarF0B14MWKg5utVRR2/VLJHhcrIjgu8WWI7hV
	FSk9ihpEzdS7JUBA+PqGezlsdngel9PSZXANdDY80AvoG7XCSiLqja3Y8PxoSSv6e2tacwI
	FazYdioZMxLTCLslWiDr6TUypeTfoSlqsSAUn1VbQJHPe3+9hLKcvFueCVp4CNpdCTkIFSU
	o72Bh86aksv638Xa3h2Rrl6E/COEC0+42m8cra3LRDBEfX4zQep1wiYOQoMe4poKftBqjPN
	JZ7kEB0mu2QTS4VohbMME/iXf1mYAAIxdU6ojr8ou6BTsZH7bbCsurpLFYNHc5eiso20Gho
	zmArsM5eXnI5Sdv7UKkb8V1UNV0VCziu/FePul74oAoyz/et0ycOZjw0TzJ4T3DH98eGkc1
	iFRg8F/T1i8BgjK+XuSk3A/zkFCyNptk9zmlvpehBtqkMntaTMgIRosRV4gHdM5JtUJJ8Nt
	2HJ6t0/OYZbnu6Zafe/Kt7RXCUsSibf4xuuP0Faxo1uY+pX3O6oe5u+NsHrqBRx9nferQAQ
	B7DZNYIBvix41Xx/A12w1iJ4jK1V4CxbE+WS61fu2CyaijenNyBO6w2hvRAWcdpP0Ysi9Vg
	WmXSLz1YuhczmsZhSXRrbZEODmh0lGho9zvAvSL63l2EWxCKcAiP8M55JVgKs/j8t988xCG
	Va3dJDIiS50d2DbzrZFILBmbMO7rywpjB5H3t77++yKi8V7a+NA6ozVKrkp5a02nJZHMe+C
	UCnSLleD6FAZoSi70kSI2AanGwek3ynqiHghSh8ll/8kfFFqjbvN22wcXtn25xtn2DWH7dr
	07Ko/XkEZoukdbV2hNWfrchU1MS64ZbhevEBwLhv49o2iVYbmS3Zys=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

PiBBZ2FpbiwgSSBhbSB0b3RhbGx5IGNvbmZ1c2VkLiAgSSdsbCBnbyBkcm9wIEFMTCBvZiB0
aGUgc2VsaW51eCBjaGFuZ2VzDQo+IGluIEFMTCBvZiB0aGUgcXVldWVzIGFuZCB3YWl0IGZv
ciB0aGUgbmV4dCByb3VuZCBvZiByZWxlYXNlcyBiZWZvcmUgSQ0KPiBwaWNrIHVwIHRoZSBh
Ym92ZSBvbmVzIChhbmQgd2UgbmVlZCB0aGF0IHNhbWUgc2VyaWVzIGZvciBvbGRlciB0cmVl
cw0KdG9vLikNCg0KT0ssIEkgd2lsbCB0YWtlIGEgbG9vayBmb3Igb2xkZXIgdHJlZSBhbmQg
c2VuZCBiYWNrcG9ydHMuDQoNCkJScw0KV2VudGFvIEd1YW4=

