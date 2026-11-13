Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558196;
	b=RMnB3hCUXGPCa/EleXj/WIK1BrKKOGcAymv+/SZnp1JsCGZGsjaGRr1vEevZEeiDyveb
	 KW34b1P1pi4hP3myZJdVFWenWufMKhj+5GC70HXMK05NOa2KtuPlSk3+xoE9myrsyHg4R
	 O4tO/jtn/PxJNzuEiO03kgXVSU8r59PgntrQg/DmlV1l6m/PHlQMi87m9xPXBmRn3YMNt
	 HmF+SdCA1IIprSjnsWmjhoD3W042eKdwqQnwxwmxelbKWjMYgospnjk5j30dBaZ4sgb6P
	 e7ta9CJR/fLiWTCm49h1VnORsYuatsAnzx1EeqiLpcOI+b067r/g11DRTrH63plK5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558196;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=wHNcz0x2zQ0XCDwUzPG9BY9oVjTOs+uGYQ78vuDg2ls=;
	b=3LHQjh1qkUtb02mGBIqNsaERCpgH3kRTHBy2Cgw33Y13S9ZUQCMyUCA4Hh8N2OCZrkgC
	 jw94gHgbdyUrTXoXRWe5VjO/DUqbOML6PLAyPZypLlj6gxwze/NC3gbur3bmIOFPLtTf8
	 wF18hl7iJNfMABqAHZ+1SB/CKjBD9mrZg7UuspkG18RIZLQeGhOj9nkiKerHKBJftei7g
	 f2f+Vh3N09XlOyIZpz5M+A6BsnkYylTuPZdSbeYm61cDeWS+dzUdTDMcaYVbuu5CCNNh+
	 gSRZDtI/mGqQv3+xdQt4zpHKg4gSjq27W0CJrlpX1ifLZ1vf8oh1wV1cY4el8mKUu5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=lHXx43Eq;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C7606A889;
	Fri, 13 Nov 2026 08:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649C7606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=lHXx43Eq
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AD8Mx0nA602344, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794558179; bh=wHNcz0x2zQ0XCDwUzPG9BY9oVjTOs+uGYQ78vuDg2ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lHXx43EqJIRi0jzcnDVvZPITB7oYl7cvwfEQlr8ea8Ktp8a2H3ihZ9go4iWGBi/Y2
	 TDvwzlo3QrThn0GVlm91nYp3AezEAbcti1C7ZQdADs+8or6y0iMqZvRUzrwOt4I+Lo
	 BGqNRiCIvOzGi+r86XH/LWSVoZOMPi5xJFsEp8nh9wQp01rxNkUjHo9tV3lOG759eJ
	 63i+FicoWqNnkniMrp4jSETKtHXzyKOg3rA8kLACLo5NqxfTUcM9Xe88EbTFmAR6SX
	 QiwbuLQx9r6zFr90iSB40Cun1pA8fe7UhjElBI5h/Ux1siHKRyHP7LvAl65X6TSz3+
	 3nJKArBq7b2cA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AD8Mx0nA602344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Nov 2026 16:22:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 16:22:59 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 16:22:59 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8%9]) with mapi id
 15.02.2562.056; Fri, 13 Nov 2026 16:22:59 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>, Kalpesh Solanki
	<skalpesh942@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and
 start failure
Thread-Topic: [PATCH v5 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop
 and start failure
Thread-Index: AQHdcqo3L5nzYrwr1UGT1rk58sg+cbcrixbw//+ICoCAAIssAA==
Date: Fri, 13 Nov 2026 08:22:58 +0000
Message-ID: <0172ea8ade124189b52d5839d4f33a2e@realtek.com>
References: <20261112131401.236433-1-skalpesh942@gmail.com>
 <20261112131401.236433-2-skalpesh942@gmail.com>
 <ee602061ce314b5a9741094b7b93836e@realtek.com>
 <9D4D810E-69D3-470C-BA90-3BBAC0788CC9@linux.dev>
In-Reply-To: <9D4D810E-69D3-470C-BA90-3BBAC0788CC9@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

THVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4gT24gTm92ZW1i
ZXIgMTMsIDIwMjYgNzo1MjoyMyBBTSBHTVQrMDE6MDAsIFpvbmctWmhlIFlhbmcNCj4gPGtldmlu
X3lhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+IEluIHRoaXMgY2FzZSwgSSBzYXcgeW91IGNs
ZWFyIFJUV19GTEFHX1JFU1RBUlRJTkcgaW4gcnR3X29wc19zdG9wLg0KPiA+IEhvd2V2ZXIsIHRo
ZSByZWNvbmZpZyBmbG93IG1pZ2h0IG5vdCBoYXZlIGV2ZW4gcnVuIGF0IHRoYXQgbW9tZW50Lg0K
PiA+DQo+ID4gSG93IGFib3V0IGNsZWFyaW5nIFJUV19GTEFHX1JFU1RBUlRJTkcgd2hlbiBkcml2
ZXIgZ2V0cw0KPiA+IElFRUU4MDIxMV9SRUNPTkZJR19UWVBFX1NVU1BFTkQ/DQo+IA0KPiBBcyBm
YXIgYXMgSSBjYW4gc2VlIHRoYXQgbWlzc2VzIHRoZSBzdG9wIGNhc2UuIElmIHRoZSBsYXN0IGlu
dGVyZmFjZSBnb2VzIGRvd24NCj4gZHVyaW5nIGEgcmVjb3ZlcnksIHRoZSByZXN0YXJ0IHdvcmsg
ZmluZHMgb3Blbl9jb3VudCBhdCAwIGFuZA0KPiBtYWM4MDIxMSBzZW5kcyBuZWl0aGVyIFJFU1RB
UlQgbm9yIFNVU1BFTkQsIHNvIHRoZSBmbGFnIHdvdWxkIHN0YXkgc2V0Lg0KPiBTdXNwZW5kIHdp
dGhvdXQgV29XTEFOIGFsc28gZ29lcyB0aHJvdWdoIGRydl9zdG9wKCksIHNvIHJ0d19vcHNfc3Rv
cCgpDQo+IGNvdmVycyBib3RoLg0KDQpJIG1pc3NlZCB0byBjb25zaWRlciB0aGlzIGNvcm5lciBj
YXNlLiBNeSBwcmV2aW91cyBwb2ludCB3YXMgSSBkb24ndCB3YW50DQpSVFdfRkxBR19SRVNUQVJU
SU5HIHRvIGJlIGNsZWFyZWQgdG9vIGVhcmx5IChhc3N1bWVkIG9wZW5fY291bnQgIT0gMCkuDQoN
CkkgZG9uJ3Qgc2VlbSB0byBoYXZlIG90aGVyIHdheSBmb3IgdGhpcyBjYXNlIGV4Y2VwdCBieSBj
bGVhcmluZyBpdCBpbiBkcnZfc3RvcCgpLg0KU28sIGtlZXAgdGhlIGNvZGUuIFRoYW5rcy4NCg==
