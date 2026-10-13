Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4037A840;
	Tue, 13 Oct 2026 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853783; cv=none; b=Ajd33U7BQQtFXezwaEHuyH5Os+qBMUJ0nTiHnKxgPaGqVnuAYfZuwCdcUzZ0hA8bV1w62b8JUGzcF0ke6AXApXAXTdd+jl7JSgsWhMy8Gx+NaZGlq51YNiFBV0W0Q2qzJ7jSUeDuDxbFYaYrjZBCc6QfBp9h0e0tsiPv+oUeZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853783; c=relaxed/simple;
	bh=YZCxUTViOdpEepKM5DJ4LKA50ABcuuCoBgOSTtKtJbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8Fxf7CmQXarTrr7dHFFUKdBdpQWO3d7TDVliYL8f+osLudF8ZjybTa1TcMpLe4QHh9XdxFM7qHYX62ZhR3k1xseGB/HKaw3DwsDjS/JYHm2b5Zvi1PhY+SoYSvkN7mlsqSIl51XoNOg5c8v9UBkbzx3PXUCbK8nlhY0lSrCzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=v+ROGEbj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="v+ROGEbj"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69D19UAg8074370, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791853771; bh=YZCxUTViOdpEepKM5DJ4LKA50ABcuuCoBgOSTtKtJbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v+ROGEbj9ZZggtCCpRj27iVxUvo0tpM1RRnNvQLLy0Mv6HiSXZpMBTA2uAq8KAhrd
	 Kz/AYy+eZF+q2+UMr/1uv5YJDKW4vSXtfofXr95ewfBQwNqdtVtHvej4KaEqih3mCW
	 GIAGZ9OtvWJ6XNi/sB0WNok6JF/teIe/QvTyRkwWRmThut8SXAYArUDiFhZUwe+mT+
	 kOpb1WsaplY9gIpKQRfJiHUAav/eXdLbClrwj59H5hHPY4MrrdWPExJ5sSjXHKzV0f
	 SAEbGYbv7UPXI2KLzOXuOHSWHV8ogDQYZYXPkXUvncElc9AMu/wjFwV19b4t5QZK2y
	 bEx1D/oVonSyg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69D19UAg8074370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 09:09:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:09:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:09:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 13 Oct 2026 09:09:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kim Wooseok <5mghybrid@khu.ac.kr>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Index: AQHdWD8IbE0sWRKeB0i8lqEjk1P2g7b5aFkwgACxEYCAAIwWUP//f+AAgACIiPA=
Date: Tue, 13 Oct 2026 01:09:16 +0000
Message-ID: <b45bced8a241448fbfbbc19bd5bdbb68@realtek.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
 <1fc8c339df1944afa6186197337edda3@realtek.com>
 <CAH1Bc_yOhZ9oqreJOLKb5RDFEW=0Zid=h4xu9oTR51RDwj_bww@mail.gmail.com>
 <04d26f79d5984920a9584d3f31ec3b58@realtek.com>
 <CAH1Bc_wUq2Nmhvd9q85JP+KyCYHB_xqStfmo6ZirOxOkXzAg9A@mail.gmail.com>
In-Reply-To: <CAH1Bc_wUq2Nmhvd9q85JP+KyCYHB_xqStfmo6ZirOxOkXzAg9A@mail.gmail.com>
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

S2ltIFdvb3Nlb2sgPDVtZ2h5YnJpZEBraHUuYWMua3I+IHdyb3RlOg0KPiANCj4gRm9yIGV4YW1w
bGUsIHN1cHBvc2UgdGhlIGJ1ZmZlciBpbml0aWFsbHkgY29udGFpbnMgMTA6DQo+IA0KPiAxLiBU
YXNrIEEgaG9sZHMgdXNiX2J1Zl9tdXRleCBhbmQgc3RhcnRzIGEgVVNCIHJlZ2lzdGVyIHJlYWQu
DQo+IDIuIFRhc2sgQiB0cmllcyB0byBhY3F1aXJlIHRoZSBzYW1lIG11dGV4IGFuZCBqb2lucyBp
dHMgd2FpdCBsaXN0Lg0KPiAgICBUaGlzIGNhbiBicmluZyB0aGUgc2hhcmVkIGNhY2hlIGxpbmUg
aW50byB0aGUgQ1BVIGNhY2hlLCBpbmNsdWRpbmcNCj4gICAgdGhlIG9sZCBidWZmZXIgdmFsdWUg
MTAuIFVwZGF0aW5nIHRoZSBsaXN0IG1ha2VzIHRoYXQgbGluZSBkaXJ0eS4NCj4gMy4gVGhlIFVT
QiBjb250cm9sbGVyIHdyaXRlcyB0aGUgbmV3IHZhbHVlIDIwIHRvIFJBTSB2aWEgRE1BLiBTaW5j
ZQ0KPiAgICB0aGlzIERNQSBpcyBub3QgY2FjaGUtY29oZXJlbnQsIHRoZSBjYWNoZWQgY29weSBz
dGlsbCBjb250YWlucyAxMC4NCj4gNC4gSWYgdGhlIGRpcnR5IGNhY2hlIGxpbmUgaXMgdGhlbiB3
cml0dGVuIGJhY2ssIHRoZSBvbGQgYnVmZmVyIHZhbHVlDQo+ICAgIDEwIGNhbiBiZSB3cml0dGVu
IGJhY2sgYWxvbmcgd2l0aCB0aGUgdXBkYXRlZCB3YWl0IGxpc3QsIG92ZXJ3cml0aW5nDQo+ICAg
IHRoZSB2YWx1ZSAyMCBmcm9tIERNQS4NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsIGFuZCB0aGlz
IGV4YW1wbGUsIHdoaWNoIGlzIGNsZWFyIHRvIG1lLiA6KQ0KDQpQaW5nLUtlDQoNCg0K
