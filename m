Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1523392D;
	Tue, 13 Oct 2026 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874853; cv=none; b=bCddOz+3w6NvDppdR398pERY4dttW5GppZIpb6joVFewAVwUWJvQd6CqtMq2l3GLLW9+eL8Q9eqHfq21gsOGvLQVtwtowxuUUaMNwH17CoypWIvvh9TE3OyuUt+tmhTZtmzlv5fOOdFetpCI7jjRRDvUBvQG/P2TT4FPG5aD2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874853; c=relaxed/simple;
	bh=MCvURXVDNqtwrsTYwhupxgidDS6LkB99D2/ekPu5keM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=CYV/EVC7QlUfs95tTPxhCL653/Cec8y5foYP5wcuBfoX392Kzrvb/bzGg29j4UG6EXHtJglZD9u2jfEwXm/qV4HU3wYzJ5fx57mMXltYXDeVL4J0rjoFTtoMU55MIhImTcFo/J2oENsJZcXNKDrrTVa+c1upUyG35hY1/ml1W5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dkivvlnl; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dkivvlnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791874808;
	bh=MCvURXVDNqtwrsTYwhupxgidDS6LkB99D2/ekPu5keM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=dkivvlnlWBz5wtOKGqC9iTJ0XdBjrzX2CFuzQalJ9MNSyvROMnyh/MtShodW9H0sE
	 TuFihVbGhPHNcpHvaBjE134Jrqt5F4YZqX9lVwI7nQ1R4KCkS5c09yZDq48Az+bhTy
	 yBktLPm7z86lKVgx7w+Bt8kLNaI34qpxN5Rdgcbk=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqQnft7kyUuJbd/1GndRJklzmB5VJlBX//o=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: /6Uw1c5u993PWpcukGUx6luJKSi6w5nYoyyQSaAiISo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1791874801tcf0ad032
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?a2FydGlrZXk0MDY=?=" <kartikey406@gmail.com>, "=?utf-8?B?SGFyc2hpdCBNb2dhbGFwYWxsaQ==?=" <harshit.m.mogalapalli@oracle.com>, "=?utf-8?B?am9oYW5uZXM=?=" <johannes@sipsolutions.net>, "=?utf-8?B?bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3Jn?=" <linux-wireless@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 13 Oct 2026 15:00:01 +0800
X-Priority: 3
Message-ID: <tencent_7D240953233FF6C810CA7875@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261012154246.1233496-1-guanwentao@uniontech.com>
	<2026101331-bullpen-carnation-3533@gregkh>
In-Reply-To: <2026101331-bullpen-carnation-3533@gregkh>
X-QQ-ReplyHash: 2242530464
X-BIZMAIL-ID: 1574893119301239894
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 13 Oct 2026 15:00:02 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NLH1RjbartcJ7FFFPwdS1gdNOXMWgZv/66sn8d0royjcP8CQd4L3n5pv
	ZGUIj0uEjk8slvWOLb9pzXARwXwvqG+vp/YsZLOixgUhKiMuO2648juneXht8P7MJr0R/0W
	6H4+vEzjOv0654etyuyz/WTNH4gu3eyPQuwO2bYk1QgdLaaP2Xx3YyDP2Mykf/6M9c+tV+b
	cPvXbXOlFKvpkTP/i6XzjrgYBl8WJla2lsIibadyVclumoNqxTIuvSnGMiCttJSseDpJbee
	psx0s617k087MMVCRPOxDk6coB21F9+Sh0YPUmScQTBe/H74LfEjxHm3eYoFxmIvkgeURwn
	z5e4eqCjkrDkXGSg4ajMA6IwyMvVqY6K1GQXKJUtZ0wYYAiyH1aaW+N1tlmFwPu6XMR9Nkg
	+wak/ZIPAt/0aWmbcvn8PdxeocSeMIFSArvMnoOfLuhhFt+tclZSTsZpOVJ5m8z87S0Cc/d
	ZAvbwTA3zqldAQbP+Me5kptx+io0A+OTiwLwt7Tp6I59/HuVB29qgOlGco0UYN0BzObjQj4
	vTg8vG8CAaNbviyXIr6OMRL013elM7BM/XEgKwzaWX7rNZsbgEoPdjAUWFpzN4/7U2hjh9R
	F9qlH3I6tGBc2zF15KWWp7WRJugvWI+TidVUoMpw4mNx8P4MYHeOQBijkSiMYCa4UahKX6O
	ZS6Jq03f1yL8znHXFR70ueVZBmov7E1cE4MjRZmC/mPEsEKkYUg5w3x56UtOi+kCNQnoLlV
	5m3nOaMijxyBLp6GdzMtiToY6jPt6gW4RrmPt42dCISvlXWRGPjmQCgw8FUlxZlvj02WZuN
	AIjYWt/gQT3pYARNdwotarIlrywnNx6Kr5BqhJUzMhgaHCN/blQthW1cDPmk1j82njNdeDg
	zn6d1b8htW3DnkqvIOgDiIA0p9z7J8oQF2olU2SNiAPJYm8lhcVgIbC0viQu1scQGZPaXVk
	WquIBGiu6CS/cdpLKviA7uCUhXEh1L3lM05CFzbstFNhL4izXvGv1YKCO7QgUVO+VdLvz8B
	Dpak/VYjHc2t8jbpixjDoSmKZTSiF9HTzgEA21QWNJH42McZyKeqguvfXbPm/cyBbaP0zwG
	hVPdQ0TXviSLqIorkDUO/VbnUYg/ru7vQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

SGksDQoNCj4gT24gTW9uLCBPY3QgMTIsIDIwMjYgYXQgMTE6NDI6NDZQTSArMDgwMCwgV2Vu
dGFvIEd1YW4gd3JvdGU6DQo+ID4gVGhpcyBlcnJvciBwYXRoIHJldHVybnMgd2hpbGUgd2Rl
dl9sb2NrKCkgaXMgc3RpbGwgaGVsZCwgc28gb25lDQo+ID4gbWFsZm9ybWVkIElFIHJlcXVl
c3QgY2FuIHBlcm1hbmVudGx5IGJsb2NrIGxhdGVyIG9wZXJhdGlvbnMgb24gdGhpcw0KPiA+
IHdpcGh5LiBSb3V0ZSB0aGUgZXJyb3IgdGhyb3VnaCBvdXQgdG8gcmVsZWFzZSB0aGUgbG9j
ay4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBIYXJzaGl0IE1vZ2FsYXBhbGxpIDxoYXJzaGl0
Lm0ubW9nYWxhcGFsbGlAb3JhY2xlLmNvbT4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC85M2RiMGVhZS1mNDc5LTQzNDMtYTEyNi01OTk4N2FlMGRjMjJAb3Jh
Y2xlLmNvbS8NCj4gPiBGaXhlczogOGI5MjFhODk5MzQ2ICgid2lmaTogY2ZnODAyMTE6IHZh
bGlkYXRlIElFcyBpbiBjZmc4MDIxMV93ZXh0X3Npd2dlbmllKCkiKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFdlbnRhbyBHdWFuIDxndWFud2VudGFvQHVuaW9udGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gIG5ldC93aXJlbGVzcy93ZXh0LXNtZS5jIHwgNiArKysrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9uZXQvd2lyZWxlc3Mvd2V4dC1zbWUuYyBiL25ldC93aXJlbGVzcy93ZXh0
LXNtZS5jDQo+ID4gaW5kZXggYmUxMjFmYTM2YzUxNC4uYmE2ZDg4MjdmNjRiMyAxMDA2NDQN
Cj4gPiAtLS0gYS9uZXQvd2lyZWxlc3Mvd2V4dC1zbWUuYw0KPiA+ICsrKyBiL25ldC93aXJl
bGVzcy93ZXh0LXNtZS5jDQo+ID4gQEAgLTM1Miw4ICszNTIsMTAgQEAgaW50IGNmZzgwMjEx
X3dleHRfc2l3Z2VuaWUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gPiAgLyogbm90aGlu
ZyAqLw0KPiA+ICB9DQo+ID4gDQo+ID4gLSBpZiAoIWZvcl9lYWNoX2VsZW1lbnRfY29tcGxl
dGVkKGVsZW0sIGV4dHJhLCBpZV9sZW4pKQ0KPiA+IC0gcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KyBpZiAoIWZvcl9lYWNoX2VsZW1lbnRfY29tcGxldGVkKGVsZW0sIGV4dHJhLCBpZV9sZW4p
KSB7DQo+ID4gKyBlcnIgPSAtRUlOVkFMOw0KPiA+ICsgZ290byBvdXQ7DQo+ID4gKyB9DQo+
ID4gDQo+ID4gIGllID0ga21lbWR1cChleHRyYSwgaWVfbGVuLCBHRlBfS0VSTkVMKTsNCj4g
PiAgaWYgKCFpZSkgew0KPiA+IC0tDQo+ID4gMi4zOS41DQo+ID4NCj4gPg0KPiANCj4gPGZv
cm1sZXR0ZXI+DQo+IA0KPiBUaGlzIGlzIG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc3VibWl0
IHBhdGNoZXMgZm9yIGluY2x1c2lvbiBpbiB0aGUNCj4gc3RhYmxlIGtlcm5lbCB0cmVlLiAg
UGxlYXNlIHJlYWQ6DQo+ICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0
ZXN0L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1sDQo+IGZvciBob3cgdG8gZG8g
dGhpcyBwcm9wZXJseS4NCj4gDQo+IDwvZm9ybWxldHRlcj4NCg0KPiBJdCBvciBhbiBlcXVp
dmFsZW50IGZpeCBtdXN0IGFscmVhZHkgZXhpc3QgaW4gTGludXggbWFpbmxpbmUgKHVwc3Ry
ZWFtKS4NClRoaXMgaXMgYSB0cml2YWwgZml4IGZvciB0aGVzZSBzdGFibGUgdHJlZXMsIHRo
ZSBwcm9ibGVtIGlzIG5vdCBleGlzdGVkIGluIG1haW5saW5lIA0KDQo+IEl0IG11c3QgYmUg
b2J2aW91c2x5IGNvcnJlY3QgYW5kIHRlc3RlZC4NCkl0IGlzIGNsZWFybHkgcmlnaHQuDQoN
Cj4gSXQgY2Fubm90IGJlIGJpZ2dlciB0aGFuIDEwMCBsaW5lcywgd2l0aCBjb250ZXh0Lg0K
SXQgaXMgc21hbGwuLyArNCBsaW5lcyAtMiBsaW5lcw0KDQo+IEl0IG11c3QgZm9sbG93IHRo
ZSBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCBydWxlcy4N
Ckl0cyBmaXhlcyB0YWdzIHBvaW50IHRvIHRoZSBzdGFibGUgYmFja3BvcnQgY29tbWl0IGlk
cy4NCg0KPkl0IG11c3QgZWl0aGVyIGZpeCBhIHJlYWwgYnVnIHRoYXQgYm90aGVycyBwZW9w
bGUgb3IganVzdCBhZGQgYSBkZXZpY2UgSUQuIFRvIGVsYWJvcmF0ZSBvbiB0aGUgZm9ybWVy
Og0KPiBJdCBmaXhlcyBhIHByb2JsZW0gbGlrZSBhbiBvb3BzLCBhIGhhbmcsIGRhdGEgY29y
cnVwdGlvbiwgYSByZWFsIHNlY3VyaXR5IGlzc3VlLCBhIGhhcmR3YXJlIHF1aXJrLCBhIGJ1
aWxkIGVycm9yIChidXQgbm90IGZvciB0aGluZ3MgbWFya2VkIENPTkZJR19CUk9LRU4pLCBv
ciBzb21lIOKAnG9oLCB0aGF04oCZcyBub3QgZ29vZOKAnSBpc3N1ZS4NCkl0cyBmaXhlcyBh
IGxvY2sgd2l0aCBvdXQgdW5sb2NrLCBhbmQgd2Ugbm8gbmVlZCB0byBiYWNrcG9ydCBmNDJk
MjJkM2Y3OTYzOSANCigid2lmaTogY2ZnODAyMTE6IGRlZmluZSBhbmQgdXNlIHdpcGh5IGd1
YXJkIikNCmFuZCBndWFyZCBmb3Igb2xkZXIga2VybmVsIHRyZWUuDQoNCkJScw0KV2VudGFv
IEd1YW4=

