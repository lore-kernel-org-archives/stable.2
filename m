Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0430D407;
	Mon, 12 Oct 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815605; cv=none; b=eE7FMMKm75yPtXA49Rqi48BqPf8m8GV30uuQUFkcVGqiANc0lASBpWBHLy/9BHv3EFa1U2UjvRtpS+NsIh6iTrYej/B0JOnCatSE0MpYD5q18Q+ScuOnD+tGn3NBUy9Nd1KrMevmSUQHCg1P0xl4dAOmh8bI2T6FTPiJumH9h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815605; c=relaxed/simple;
	bh=Zw0+z/ugZe6S36eWNkYGaVnNeZvYgadceegFWlZ8b0s=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=ZKDEe3Q2316qIPRBre/8mngSDbQlRavdlFMtf4JQSnaSvfXafxEaTl1PbmLZt/vNXGfsxOv+xDdsS8/ncp9PNumHIuG7H35rUuZuR36L9LUxluXb4uUvSjfwNYMI0nEIzGqz5D5dznqct81V2DJEjig426pmpvNNbEMjtgizUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bbXzSHCC; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bbXzSHCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791815563;
	bh=Zw0+z/ugZe6S36eWNkYGaVnNeZvYgadceegFWlZ8b0s=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=bbXzSHCClXTanhb+dDKNFlaQZqL4bHlnrvoj9AeXE5IZh1jvRfAmIZ8TtD4nUpjua
	 qEfnnlFPXIn6eugH3GPVeA+xO5q3VLCJ2/UorwgV5PViZAnguqVV4lIXBgfRhE5ZSy
	 rCR7fSO4eKLOO8rWM3TdDamPn7deaMl9EOtoE9XM=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqQnft7kyUuJbd/1GndRJklzmB5VJlBX//o=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: nn6dAGL+0oqPtxFYV5iZGFDEDb3so7wz9tZZWII7L9c=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1791815558t1de62dee
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?SGFyc2hpdCBNb2dhbGFwYWxsaQ==?=" <harshit.m.mogalapalli@oracle.com>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?a2FydGlrZXk0MDY=?=" <kartikey406@gmail.com>
Cc: "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>, "=?utf-8?B?bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 12 Oct 2026 22:32:38 +0800
X-Priority: 3
Message-ID: <tencent_68B90C752BA52B072652ABD9@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261010043002.2919860-1-guanwentao@uniontech.com>
	<tencent_54DE3A7910D4598F5676AE58@qq.com>
	<2c0c5d51-197c-47fd-b002-ecff397a826e@oracle.com>
In-Reply-To: <2c0c5d51-197c-47fd-b002-ecff397a826e@oracle.com>
X-QQ-ReplyHash: 9697127
X-BIZMAIL-ID: 11863904943699574945
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 12 Oct 2026 22:32:39 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NJ+j2bKK7Jg0MkyBhc+vzB8Tq2jgRoL/vRKgVqU/HFuXBEy0aJyihowU
	CV2UKE+2XVIqmuimT7fBPcH6NQRXldARx6TOoAqeyUZx3A6MqGKivBHdnlWLQLOF3V8vqli
	B8ikERZ6kqxrbY+RZuUOINPSCgXFHxb6XazuTxwgGuIC3zDWWeCCNUhjvcPpJo5n98d8w5/
	LvAARDNaOR9nnQl4ddKCz5jUmn6l4RS3a75zRemsVXIhnVc9v64uDKaeUgWX1PJVow/J8Ff
	W4MJNlWxmYid0BL7EGuV+KEFMJDxg34V4mYS+psPr27yug8qMO1HZ4SgGWcnf+/ktux2hrJ
	WfwrQ+MqTYuqzbtH7cURB8ovY0Brba0SvCxOJzSdPOJA9FzY0x812eGSPxa4CfjndJMjrBp
	VrxbHJO0x6RrmeHIu6z690yWNPwJTA+GRAahdlRHKyrtBiwRwRmVQUp69Sj7ondGJ4j1wlF
	0jflV0Zd1CvQM6kgVv6+F2FYD3klgMjD/hcEjUxbq3lHQBdZbOJT55KwBbujK2DR93ys4VI
	um6+fhieDrRQhajbsZjAovVEW2hKBnjbdT9ED6t3EgExogbeL2EzlWMdrkYMbDgY31bNYzL
	3gnfKKpirs6O3U+OoGsLv3dqU61LPVhlbAMd/Q7VRZXRVaEkdwtQHsYGVO72+BYskk5E40P
	91rGNoqOJfE4nGM79/+28zeJVuAY14J/DkbDNnFO5Yz9c7xqgPnBXHcgNKFwivB1rWqU5tx
	tzsxrUh/4rKhN/wYHibtRpLDOVMwXTGnNPRBM3eyalSztEVxmJ/Jg4ce3K0R3obNejrCaLz
	yd5upyIsZ+4IBCkg8C23bKJfDr+gMNEbObsZSjRVIAjOeFQUPx3E6W8Cxk7m4+AYw1bFwCo
	vbJpL6wvHHX1rE3BYhPJJ0cgdLl9IXgwmnSoE2gfWZrKZSKZlrMttwlAlClMGqIEEVpkTms
	wgv3zqLd3Wd0s759KeKaqNAjAR688Hykw6MLMW5pFrihezRjObmlTYPdaCQbpC38QtWkma4
	6iyJF2qoYSeMTWuDawTJ1ATKQmka4EGrR75ek4gnSjqC10hekRgpLAEUuJKXoEMs0ezXtX/
	TcqVrUTWJV3dNs5T0ANnRHtZJe64PxFmj6YWzceAP6gaDhjwwbVY7LBxm3JShipLbg6Q7GC
	sHMzlZJo1020UU6f/COin/LvMA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

SGksDQoNCj4gSGkgV2VudGFvLA0KPiANCj4gT24gMTAvMTAvMjYgMTA6MDQgYW0sIFdlbnRh
byBHdWFuIHdyb3RlOg0KPiA+IFNvcnJ5LCBpdCBpcyBmb3IgdjYuNi4xNTguIGNjIHRoZSBz
dGFibGUgbGlzdC4NCj4gPg0KPiANCj4gdGhpcyBuZWVkcyB0byBiZSBmaXhlZCBvbiA1LjE1
LnkgYW5kIDYuMS55Lg0KPiANCj4gVGhpcyB3YXMgcmVwb3J0ZWQgaGVyZToNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzkzZGIwZWFlLWY0NzktNDM0My1hMTI2LTU5OTg3YWUw
ZGMyMkBvcmFjbGUuY29tLw0KPiANCj4gDQo+IHRoYW5rcyBmb3IgbWFraW5nIGEgcGF0Y2gu
DQo+IA0KPiBBcmUgeW91IHBsYW5uaW5nIHRvIHNlbmQgaXQgdG8gb3RoZXIgYnJhbmNoZXMg
YXMgd2VsbCA/DQoNClRoYW5rcywgSSB3aWxsIG1ha2UgcGF0Y2hlcyBmb3Igb3RoZXIgYnJh
bmNoZXMgbGF0ZXIuDQoNCkJScw0KV2VudGFvIEd1YW4=

