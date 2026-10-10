Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAD3612EE;
	Sat, 10 Oct 2026 04:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791606906; cv=none; b=kFEV3EpsVRlH6n3eNh0iHyIrTyAd/ouIF3uEtZvaq0/WkAVWtdeohs03JsfkroBf38Aox37R3zQTNIPHWL9kK3R1Eaph4CM5hYlKdqpLaVDiMR9HkVjDueXslcpO+Hvam004F1b79y5DKEAjHE8feBg6scntBhvcV1/bc18Zuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791606906; c=relaxed/simple;
	bh=80rjkX/a1IzJ7fnM47AVZQsjw6x54D+aSaJzkJW9vig=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=mdcQe8Amh82rfC/LTFiohGuqyd9oaV1BgZCnSgeNkh/zK7Ciqddwn47M5N6ojB3PWzXA+76FzXDk0Ujjx2efoVLw78HxBDZZkFCP42NdTuQeYsOERvbwdIhEOyZzxcs7JUfyLg2VjBaWVjhU6pX5WqN17kGbC4ynrkkRArJP//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KKzBh8iB; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KKzBh8iB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791606866;
	bh=80rjkX/a1IzJ7fnM47AVZQsjw6x54D+aSaJzkJW9vig=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=KKzBh8iBMf+JdzEG/XyK6iCJOEIc7gadGiF16LdhC8IUkLgpAza6VRka2GmvdUl14
	 2MXlwQqFJVGZri/0F+/d9QYUYbKZ1+dzdvYjcfUZ7XVl6hyQdvqPbSsG9tl49uPLhB
	 TO99xUpJBecHh8CnTJ+MFAij2rN8WYUeF119QW2s=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqQnft7kyUuJbd/1GndRJklzmB5VJlBX//o=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: HeilzH7BoGic1gszdDYTeuISgSGfIaB1/TNSPZD9Zwc=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1791606850teb1258f8
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>, "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?a2FydGlrZXk0MDY=?=" <kartikey406@gmail.com>
Cc: "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>, "=?utf-8?B?bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re:[PATCH 6.6.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 10 Oct 2026 12:34:10 +0800
X-Priority: 3
Message-ID: <tencent_54DE3A7910D4598F5676AE58@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261010043002.2919860-1-guanwentao@uniontech.com>
In-Reply-To: <20261010043002.2919860-1-guanwentao@uniontech.com>
X-QQ-ReplyHash: 2432166471
X-BIZMAIL-ID: 12405904260231876868
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 10 Oct 2026 12:34:11 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MpJmQ90V4eWUtzDiqQCTDN8l9mUVqmtQnxaiTtPId3jvUkv0wi7KVp9n
	YPJBXlH5Yd15F6IcqychEcNgEyL7rIM3K0gCByxz3MapaljWJ/fR04DFg0ghxfhwOMUd696
	riMuUujvxivN2vdosrujDeCWOnv9gLLgewZD3m1xGU6WXo6FLK249ITkh0CEf9ln4mh0xYd
	l9QkMwwfrxz2uog/XGvsHzS6u634roz3SQ0mmR9p/JgXc4VVWTLhj9RAONXymAlAgHoipk4
	JDnTQJGxJ0IDde7y4FlzDQDCGdm4DzH/54QSqOKVwrxqgRqfPFr1e8ToGa64rE4Q2iPN3vB
	QYf9EULi5IaClLe6bZmfbotKTBBInEjG5VnQEok6sm17/7VaY5FNC0j7zJ8GqMfjG9+n3IU
	+tOSX5jBY2oB8E9qncZHCVBTYnca/zTJSKKBx+QpAZz9CpXBZnqjnm45VUrsaU4TZH9Y45M
	0nGBGRFTIPhsZ7xZORWxlrU5D1gWwrCRcUqREWPasNTCsAE+DnEuVObiCd42Z5nZEV39n0g
	9nOksOcV1Ml3GO+fmHOJggUsD8V5uqtHzcsiDJ+AK9nbdUhx0AXKG8lNoxdqzqhIfQy2uYw
	QTgBjD3I2PEHjv3fBY8+4CIYY7N1WcL4lv6igz5HFaN2/ueck3hGhMgiGrtIU2tsxjQ3+/e
	bgOjrjDo68ISzQ95cEVW9m1jQNAn75MabtXe65IpRrQilS70y8q+GsHlAM7fpa7ZTkeToKV
	75eY+57l6hZatZ3iKW8Fe7tdri9833AXD1133O8WF6I8UZQNEAdxGeJhwj4m63v3A/enWEd
	LXl67zvNub2b45yZifblLGlULOoJ3kgRsORsCIBTvc86WEarB1FrB4W/E7U/BwtowMmIUtF
	Hs2PJlHCpQQvOgOT1iWw86kJ0Dq9xx0Dlhp1x7kanMbRdnsPG2k6tMBv5FMk/cU0e7rxwMN
	Zq3Y9Fygw+fcMSXJAZNioaIRJgUafjFafFUtr7nnrI2gpr/fIAp3roBPdXOdQo3AIKeLU5l
	oPCqK8Y+R2t4VSQx4jCR1iGMsml9HpuPtkZ1kX0DE/r//+INQwDHmf9xqrjDD3N47SZsG0/
	w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

U29ycnksIGl0IGlzIGZvciB2Ni42LjE1OC4gY2MgdGhlIHN0YWJsZSBsaXN0Lg0KDQpCUnMN
CldlbnRhbyBHdWFuDQoNCj4gLS0tDQo+IG5ldC93aXJlbGVzcy93ZXh0LXNtZS5jIHwgNiAr
KysrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvd2lyZWxlc3Mvd2V4dC1zbWUuYyBiL25ldC93
aXJlbGVzcy93ZXh0LXNtZS5jDQo+IGluZGV4IGNmYTkwM2ViMGU4MmYuLjBlN2MzMTRiZGVl
ZjAgMTAwNjQ0DQo+IC0tLSBhL25ldC93aXJlbGVzcy93ZXh0LXNtZS5jDQo+ICsrKyBiL25l
dC93aXJlbGVzcy93ZXh0LXNtZS5jDQo+IEBAIC0zNTQsOCArMzU0LDEwIEBAIGludCBjZmc4
MDIxMV93ZXh0X3Npd2dlbmllKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIC8qIG5vdGhpbmcgKi8NCj4gICAgICAgICAgICAgICAgIH0NCj4g
IA0KPiAtICAgICAgICAgICAgICAgaWYgKCFmb3JfZWFjaF9lbGVtZW50X2NvbXBsZXRlZChl
bGVtLCBleHRyYSwgaWVfbGVuKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICBpZiAoIWZvcl9lYWNoX2VsZW1lbnRfY29t
cGxldGVkKGVsZW0sIGV4dHJhLCBpZV9sZW4pKSB7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGVyciA9IC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0
Ow0KPiArICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgaWUgPSBrbWVt
ZHVwKGV4dHJhLCBpZV9sZW4sIEdGUF9LRVJORUwpOw0KPiAgICAgICAgICAgICAgICAgaWYg
KCFpZSkgew==

