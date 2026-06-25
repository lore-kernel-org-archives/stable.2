Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C8E3DD501
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387972; cv=none; b=MayMWSDzcDONiRfpSdXsztSNH45dSjK9mwPmx6OKckTvvm2MJnkSZ+0fCBtkut3fLE9PuP77WEW2EjhVCKpi7ubXUf9mVlQCljf4L2kZ5iTvCbpr0Pn2GLyCdJQUm+tYL+EL+5FsBP2bPyWjQiLvj0c/JRRHkYaGwb1TVEgOTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387972; c=relaxed/simple;
	bh=Qr1J8a0mx/pEgPLIpZL/mhLER/N5Ldfyot5lGPmygqA=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=dF73SZ9vaa9k2JaoeqatUOA7+IwaCM1DsOTlA930eC0Au26T/pjjvBsYSImbDJm+53WNjHR4HbntpNf9ARu1dtoU8JNlMuRfY0r7MjmcqrkJyze4APqTzcWHuT1lQKpnjBplu2OhJ1ecriN0cxFLGeba71dUYweUD48XeJvTrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=M50v9P56; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="M50v9P56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782387938;
	bh=Qr1J8a0mx/pEgPLIpZL/mhLER/N5Ldfyot5lGPmygqA=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=M50v9P56rgzaRU8pLo5u+RKOAXqHyH1dWbIHQfmjMeGpxszsjzZxLL1UXA/mcdH6H
	 J8lwQOWI4Ju4iyhnGY5sffx+sazxERRYl8eon7y/UNKAD5YXtcKlRGvsnMDYr44tq6
	 3Hqk3s9K+4Le0dZSYRk1OWQe2tJWGBACrrIsjtDY=
EX-QQ-RecipientCnt: 16
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-FEAT: D4aqtcRDiqRdFc3p2pDC+jQy+RNMWdI0Y5ii4Iz6wLU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Ut9v84XrlT00aj5td43rCpdBZIGPD9AZ0nom5M2tNW0=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1782387931tdd28224f
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>
Cc: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?MjA0NWdlbWluaQ==?=" <2045gemini@gmail.com>, "=?utf-8?B?ZGNhcmF0dGk=?=" <dcaratti@redhat.com>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?amhz?=" <jhs@mojatatu.com>, "=?utf-8?B?a2VlbmFuYXQyMDAw?=" <keenanat2000@gmail.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cmFqYXQuZ3VwdGE=?=" <rajat.gupta@oss.qualcomm.com>, "=?utf-8?B?cm9sbGtpbmd6emM=?=" <rollkingzzc@gmail.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?dG9rZQ==?=" <toke@redhat.com>, "=?utf-8?B?dmljdG9y?=" <victor@mojatatu.com>, "=?utf-8?B?eWltaW5ncWlhbjU5MQ==?=" <yimingqian591@gmail.com>, "=?utf-8?B?UGVkcm8gVGFtbWVsYQ==?=" <pctammela@mojatatu.com>, "=?utf-8?B?U2ltb24gSG9ybWFu?=" <simon.horman@corigine.com>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 25 Jun 2026 19:45:30 +0800
X-Priority: 3
Message-ID: <tencent_10E99DBB7FE104D005E5B10D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260623100141.2383966-1-guanwentao@uniontech.com>
	<20260625054005.0011.act-pedit-510@kernel.org>
In-Reply-To: <20260625054005.0011.act-pedit-510@kernel.org>
X-QQ-ReplyHash: 3754159787
X-BIZMAIL-ID: 339451665137483440
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 25 Jun 2026 19:45:32 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MDn50qcE9aI1eifEXAFq4pNNhISU0b7d15lHfrLi4vgP307ceZH19h+2
	TOhSugoyGdt/272568K/da2FGMNvbpRVWDpbLx6AHhGg5bBuI2CpjTSZGor7/tdEtLTIje2
	3jtfbkaYj9OoI/I8tvQbnelxZ07gYiGya6AYmZmM9qqvGD/iWIuk0sFYKDlaI8VKsPBx/dC
	ch1RqWst58rj9B/p7GZQjezFA9Y4cPt+FuafT2n0+6PK50IVtKW3MsHn1qyFS7jfnQ2o4dj
	1i1YV0rHSBwf2W9xYz6zGmXXmv1bcqXEVnm/ypQFZnHR50Gw/KQuhFHD8I3uCB8tfa0gv3b
	nQobsZS4OdJgQ0XSNw+RmLEkq5EIG4kY4kxOauhg0PViJ/qEPD1Jn5iwm1y4cmU9USM0otd
	wDjqpepVlPWlbSbq/rbZrMACaMpujNBrXM2cGhVdloKysPz2Dya5r1nSUtuDx0rWd5eUpRO
	kRjBCPrk2bS2/mWFpW/BKVwSvDtiF+d+r9qd0apdKfoj0hmunTfU8ir8jZkTG5k891OxWay
	Eh3h1cWNzajzVL6nPSb6jHQTuKpQfG5ZqkQEGsmj0SiBB4jFDa1oRR1NB4hDd/xXjWWuZZk
	j/Lxq177wb1lD3zhzwu1t6VB2d0rhuSN3z+8ySlf/2hGsKwVrFlVKABJu6/1Z5HBnL0YOP5
	C3xO18Uj91WMblUpIAadUW0AH1GCNiOcw1R83OaXkzWkg/JuAD19MK4V0PNGTtfR1x7d9JW
	fQNdQLtRtZPO9eu5Y3enZw5d4GsT07gy2ujy+k3gDME/OtrXtkkp/bDNiTANyk4bhf5l7tr
	WTLbCqirA2JUtFtBiGRWfOUBOLfkdn3XlOTYZgVTiaEmKSxUy1q93dn4lokDC9zjCV6boL3
	pOuQR1EbHlV0Lo8zE1dZh5THe9rus7cRza+UpjHr/+q+mQGNefm2KWN2qnjyCbW1/Y8FmUG
	Quk0gLSQI/LXppxribB3PTewAtAWWsnckNuY+M2Wut55cxp1wqOpuiYfS5tlfFgxFFpfoIx
	2NBsUDg7LbI5rL0AC0yKa6XzUybkA9TTtoUCARLHRHtw5lPY+KVJ2U3iybVi9wbELlNKEEx
	g8w3AVCDv5EmO2ENWduOW+tfMpMnZtFJZBRxOb0THaT
X-QQ-RECHKSPAM: 0

SGkgU2FzaGEsDQoNCj4gPiBQbGVhc2UgYWRkIG5ldC9zY2hlZDogYWN0X3BlZGl0OiBmaXgg
YWN0aW9uIGJpbmQgbG9naWMgKHVwc3RyZWFtDQo+ID4gZTllNDIyOTJlYTc2KSBhcyBhIDEw
dGggcGF0Y2ggdG8gdGhlIDUuMTAueSBwZWRpdCBzZXJpZXMgLSBpdCBhbHNvDQo+ID4gZml4
ZXMgdGhlIHRjZnBfa2V5c19leCBtZW1sZWFrIG9uIHRoZSBpZiAoYmluZCkgZWFybHktcmV0
dXJuIHBhdGguDQo+IA0KPiBJdCBkb2Vzbid0IGFwcGx5IGNsZWFubHkuIENvdWxkIHlvdSBz
ZW5kIGEgYmFja3BvcnQgcGxlYXNlPw0KDQpJIHNlbnQgdGhlIGJhY2twb3J0IGluIA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjYwNjIzMTAwMTQxLjIzODM5NjYtMS1n
dWFud2VudGFvQHVuaW9udGVjaC5jb20vDQoNCmFuZCB0aGUgc2VyaWVzIGNhbiBhcHBseSBp
biB2NS4xMC55Og0KZWVjMGJiMWYyYTIzNiAoSEVBRCkgbmV0L3NjaGVkOiBhY3RfcGVkaXQ6
IGZpeCBhY3Rpb24gYmluZCBsb2dpYw0KYjE5OTc4YzYwNDNiZSBuZXQvc2NoZWQ6IGFjdF9w
ZWRpdDogZnJlZSBwZWRpdCBrZXlzIG9uIGJhaWwgZnJvbSBvZmZzZXQgY2hlY2sNCmZhYjQ0
MjVhNmZlOGYgbmV0L3NjaGVkOiBmaXggcGVkaXQgcGFydGlhbCBDT1cgbGVhZGluZyB0byBw
YWdlIGNhY2hlIGNvcnJ1cHRpb24NCmZjOWUxMjU1ZWY0YmIgbmV0L3NjaGVkOiBhY3RfcGVk
aXQ6IFBhcnNlIEwzIEhlYWRlciBmb3IgTDQgb2Zmc2V0DQoyNzVjMjY0ZGJjZTA4IG5ldC9z
Y2hlZDogYWN0X3BlZGl0OiByYXRlIGxpbWl0IGRhdGFwYXRoIG1lc3NhZ2VzDQpiYTk3ODgy
ZjFlMTk0IG5ldC9zY2hlZDogYWN0X3BlZGl0OiBjaGVjayBzdGF0aWMgb2Zmc2V0cyBhIHBy
aW9yaQ0KZDFiMGUxZTFlNmFjMiBuZXQvc2NoZWQ6IGFjdF9wZWRpdDogcmVtb3ZlIGV4dHJh
IGNoZWNrIGZvciBrZXkgdHlwZQ0KMTJmZTllODNkZWEyNyBuZXQvc2NoZWQ6IHNpbXBsaWZ5
IHRjZl9wZWRpdF9hY3QNCmZiNjMwZTJlOTc4ZmQgbmV0L3NjaGVkOiB0cmFuc2l0aW9uIGFj
dF9wZWRpdCB0byByY3UgYW5kIHBlcmNwdSBzdGF0cw0KNWI3NDJkNzQwMjg3MCBuZXQvc2No
ZWQ6IGFjdF9wZWRpdDogdXNlIE5MQV9QT0xJQ1kgZm9yIHBhcnNpbmcgJ2V4JyBrZXlzDQo1
ZGJkMjQwYWM5YTA2ICh0YWc6IHY1LjEwLjI1OCwgc3RhYmxlLWdoL2xpbnV4LTUuMTAueSkg
TGludXggNS4xMC4yNTgNCg0KQlJzDQpXZW50YW8gR3Vhbg==

