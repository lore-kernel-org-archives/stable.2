Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7613815C3;
	Tue, 13 Oct 2026 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852257; cv=none; b=P+wRPMFLf14Ky9C3djuBMSo9v3YXOzqINHdmBXiKcKo8rF8Rd+56K3Lm5s5PpvjIOy2F4nmkSKTXixRyPBQfTYIDAnBlIzHsk8M42thgMMTL30qrKljNtJ5dqSmG6lx9GO8DamBY/AkbLMm+4uam6PccrZVeEfZRAeP5tjhvZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852257; c=relaxed/simple;
	bh=F2/6gOJsn3Zg5kiWTHMbF0lvSyAIqPOYRaJ2mHOCpQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MT8NptnI3B/s+ZlyxQWOMrifEe8C71ggWMboAQqW1aMVoTQpRUCVrnhcDuxujuHk6psZs1s7hcDMR3J+M2o0wAZQvsTBcwduv8dK5y61g5HDZxnIrO2vVynlfTNcE/3BpFG1qci+0dJLYTvhteiUNAip1K876/ENiN8qvo51050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=feVsXiQV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="feVsXiQV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69D0i2zR5055986, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791852242; bh=F2/6gOJsn3Zg5kiWTHMbF0lvSyAIqPOYRaJ2mHOCpQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=feVsXiQVvb3QQeKJnhvHcnaoYZYf8y2Cg5NGM8Py2WUKYtsuzxNwqBcSMwhbMj4Kj
	 fW8VOZKlC6AZC/nEj+CwGj1MI/oDpcZmQriCeGVCJskFAbFuc/KxuCGpsmIzLuQq1w
	 BTYNT8MpQTo95r9lnteZorlwjcUgKZWaibF0IrlFswQj5HncvTKDEtwtk389IyaE8N
	 3gOen1QPRgTQMvqim8U+F1Bjb4M/dEcwnZbDbrfEOwx7PrSm/OPlPoomT/BQ6U0Viz
	 NHdF+J3jLwmg/t8rDw43cnWzm+EZBJmi2yTjKPsqwrlrZUrHpxPiEh4B8wwqS5yhFf
	 Q0MjS7hV5m4PQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69D0i2zR5055986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 08:44:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 08:44:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 13 Oct 2026 08:44:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghA==?=
 =?utf-8?B?7J6Q6rO17ZWZ6rO8KQ==?= <5mghybrid@khu.ac.kr>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Index: AQHdWD8IbE0sWRKeB0i8lqEjk1P2g7b5aFkwgACxEYCAAIwWUA==
Date: Tue, 13 Oct 2026 00:44:03 +0000
Message-ID: <04d26f79d5984920a9584d3f31ec3b58@realtek.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
 <1fc8c339df1944afa6186197337edda3@realtek.com>
 <CAH1Bc_yOhZ9oqreJOLKb5RDFEW=0Zid=h4xu9oTR51RDwj_bww@mail.gmail.com>
In-Reply-To: <CAH1Bc_yOhZ9oqreJOLKb5RDFEW=0Zid=h4xu9oTR51RDwj_bww@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

4oCN6rmA7Jqw7ISdW+2VmeyDnV0o7KCE7J6Q7KCV67O064yA7ZWZIOyghOyekOqzte2VmeqzvCkg
PDVtZ2h5YnJpZEBraHUuYWMua3I+IHdyb3RlOg0KPiBIaSBQaW5nLUtlLA0KPiANCj4gPiBDb29s
LiBIb3cgZGlkIHlvdSBkaWcgdGhhdD8NCj4gDQo+IEkgd2FzIHJlcGVhdGVkbHkgcG93ZXItY3lj
bGluZyB0aGUgQVAgdG8gdGVzdCByZWNvdmVyeSBvZiBhIHBlcnNpc3RlbnQNCj4gcXVldWUgaW4g
bXkgcHJvamVjdC4gQWZ0ZXIgZml4aW5nIGEgc2VwYXJhdGUgTmV0d29ya01hbmFnZXIgaXNzdWUs
DQo+IHNvbWUgcmVjb25uZWN0IGZhaWx1cmVzIHJlbWFpbmVkLCBzbyBJIHN0YXJ0ZWQgbG9va2lu
ZyBhdCB0aGUgZHJpdmVyLg0KPiANCj4gSSB3YXMgdGVzdGluZyB3aXRoIGZvdXIgUmFzcGJlcnJ5
IFBpcywgYW5kIGRpZmZlcmVudCB1bml0cyB3b3VsZCBoaXQNCj4gdGhlIHNhbWUgZmFpbHVyZSBh
Y3Jvc3MgcnVucy4gT24gYSBmYWlsaW5nIHVuaXQsIFJGX01PREUgd2FzIGNvcnJ1cHRlZCwNCj4g
YW5kIHJlc3RvcmluZyBpdHMgaW5pdGlhbGl6ZWQgdmFsdWUgYnJvdWdodCByZWNlcHRpb24gYmFj
ay4NCj4gDQo+IEkgbmFycm93ZWQgaXQgZG93biB0byByZWdpc3RlciBjb3JydXB0aW9uIGR1cmlu
ZyBzY2FubmluZywgdGhlbiB0cmFjZWQNCj4gdGhlIHJlZ2lzdGVyIGFjY2VzcyBwYXRoLiBUaGF0
IGxlZCBtZSB0byB1c2JfYnVmIHNoYXJpbmcgYSBjYWNoZSBsaW5lDQo+IHdpdGggdGhlIG11dGV4
J3Mgd2FpdGVyIHN0YXRlLCB3aGljaCBjYW4gY2hhbmdlIHdoaWxlIGEgVVNCIHRyYW5zZmVyDQo+
IGlzIGluIHByb2dyZXNzLg0KDQpEb2VzIGl0IG1lYW4gdGhhdCBkYXRhIGluIGEgY2FjaGUgbGlu
ZSBjYW4ndCBiZSBtb2RpZmllZCB3aGlsZSBhIFVTQg0KdHJhbnNmZXI/IEV2ZW4gdGhlIGRhdGEg
aXNuJ3QgYSBwYXJ0IG9mIHRyYW5zZmVycmluZyBkYXRhLg0KSG93IGNhbiBpdCBhZmZlY3QgdGhl
IHRyYW5zZmVyPyANCg0KKEknbSBub3QgYSBjYWNoZS1saW5lIGV4cGVydC4gSnVzdCB0cnkgdG8g
dW5kZXJzdGFuZCB0aGUgY2F1c2UpLg0KDQpQaW5nLUtlDQoNCg==
