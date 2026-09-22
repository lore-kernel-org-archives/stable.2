Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B7371887;
	Tue, 22 Sep 2026 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040350; cv=none; b=Ml1SRF+F8v2W8V4cdRdb4jW6v9E+GNKskLFh5GreMYuuKCTALQzvGuIFBaM5p3ALi7776KnPHd+9zhfG9aA318QUKXkdH0YmPV6bl8ieusTY4xLBWnrzAhoeF26+sT1/TIONneoqLQ65r9OS+/uECIe5G+4Oxjb4MI3QauOqW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040350; c=relaxed/simple;
	bh=0+7CTloCOybbIIIWgGVacHFS1PnHitmbqnXKGXyuOBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNRLVYn1DUr5c3V2McNCp3CqVTtcXvl47qzA1XkUst1p4j/zCJGQSwLt5lWCG961DLq2vMIu0KCKHWyZzb47N5rYRY64wNOXKSlsdZ0eRsbTTbvRxta8iNRb3biLPr05q7hyp97un5ZwLdrZXf766oSwBCAOdjCI6MBBM15ZiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jG+77GQe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jG+77GQe"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68M1PReB43112325, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790040327; bh=0+7CTloCOybbIIIWgGVacHFS1PnHitmbqnXKGXyuOBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jG+77GQev8GTqVXYySuZ7xAWxx5b0BUF36IjRQdrUMID2gfuA4UO5dPaYml8XXE9K
	 m+j6NFUoj6a6DCNhXkWcECdqp/X8kBPkMSnzVFFlVBUZr19ZgA4I0Qdck9D8MGTvqL
	 FPJrODvzPNqzTkNWOEYeZFI2jeHG6LZNvPOhpMEMHjv7Pwo3Mup7j7UfF+gukXGRJq
	 SQl7G1DwmzY19zi5k69GHKgkIaD/7qXLMvRnqkLMErJFnAwe9fRVkWSlHUqKKCasrx
	 MpKUCcjgS1mtK+nVei9F3YE2/2djgAhbUPVoQ+jrUIbKnQSNtSKQDFa1A0iL1oSVNn
	 wnlU78p2+8vmA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68M1PReB43112325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Sep 2026 09:25:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 09:25:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 22 Sep 2026 09:25:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, Kalle Valo <kvalo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Topic: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Index: AQHdRZjHlTD58hEpHEaBWkK5Af0sf7bSYOjAgAAXxcD//43kgIAGUHjw///r0ICAAZBuQA==
Date: Tue, 22 Sep 2026 01:25:27 +0000
Message-ID: <7f1ad86870184bfe826dd96a3b031d69@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
		 <ea3434d849b34a4286b0a193351a610e@realtek.com>
		 <58a857e3b0614e2b9a520024b9932685@realtek.com>
	 <919109e886399f09db41ef5800e7335440ed4971.camel@d-silva.org>
	 <5ff354336f4748b9bb45621dd899156a@realtek.com>
 <4662c1bbc73df10449a3925161979c130d94492b.camel@d-silva.org>
In-Reply-To: <4662c1bbc73df10449a3925161979c130d94492b.camel@d-silva.org>
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

QWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+IHdyb3RlOg0KIA0KPiBPbiBN
b24sIDIwMjYtMDktMjEgYXQgMDI6NDQgKzAwMDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBB
bGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4gd3JvdGU6DQo+ID4gPiA1LiBF
ZmZlY3Qgb24gZnV0dXJlIGludGVycnVwdHM6DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gPg0KPiA+ID4gUmVnYXJkaW5nIHRoZSBpbnRlcm5hbCBleHBlcnQncyBj
b25jZXJuIHRoYXQgY2xlYXJpbmcgdGhlIGJpdCBwcmV2ZW50cw0KPiA+ID4gZnV0dXJlIGludGVy
cnVwdHM6IGluIG91ciB0ZXN0aW5nLCB3cml0aW5nIDEgdG8gY2xlYXINCj4gPiA+IFJFR19TRElP
X0hJU1JfUlhfUkVRVUVTVCBhZnRlciB0aGUgRklGTyBpcyBkcmFpbmVkIGRpZCBOT1QgcHJldmVu
dA0KPiA+ID4gc3Vic2VxdWVudCBSWCBpbnRlcnJ1cHRzLiBXaGVuIG5ldyBwYWNrZXRzIGFycml2
ZWQgb3ZlciB0aGUgYWlyLCB0aGUNCj4gPiA+IGhhcmR3YXJlIGFzc2VydGVkIFJFR19TRElPX0hJ
U1JfUlhfUkVRVUVTVCBhZ2FpbiBub3JtYWxseS4NCj4gPiA+DQo+ID4gPiBJZiB0aGVyZSBpcyBj
b25jZXJuIGFib3V0IGVkZ2UgY2FzZXMgKHN1Y2ggYXMgaGl0dGluZyB0aGUgNjRLQg0KPiA+ID4g
dG90YWxfcnhfYnl0ZXMgbGltaXQgYmVmb3JlIHRoZSBGSUZPIGlzIGNvbXBsZXRlbHkgZW1wdHkp
LCB3b3VsZCBpdCBiZQ0KPiA+ID4gYWNjZXB0YWJsZSB0byBvbmx5IGNsZWFyIFJFR19TRElPX0hJ
U1JfUlhfUkVRVUVTVCBpZg0KPiA+ID4gUkVHX1NESU9fUlgwX1JFUV9MRU4gcmVhZHMgMCwgb3Ig
cmUtcmVhZCBSRUdfU0RJT19ISVNSIGF0IHRoZSBlbmQgb2YNCj4gPiA+IHJ0d19zZGlvX3J4X2lz
cigpPw0KPiA+DQo+ID4gSSBndWVzcyB0aGVyZSBpcyBhIHJhY2luZyBiZXR3ZWVuIFcxQyBSRUdf
U0RJT19ISVNSX1JYX1JFUVVFU1QgYW5kDQo+ID4gUkVHX1NESU9fUlgwX1JFUV9MRU4gPT0gMC4N
Cj4gPg0KPiA+IFdpdGggYSBzdWdnZXN0aW9uIGZyb20gaW50ZXJuYWwsIGlmIHdlIHdhbnQgdG8g
ZGlzYWJsZSB0aGUgUlggcmVxdWVzdCwNCj4gPiB0aGUgYmV0dGVyIHdheSBpcyB0byBkaXNhYmxl
L2VuYWJsZSBpdCBieSBJTVIuIFRoZSBjb3JyZXNwb25kaW5nDQo+ID4gZnVuY3Rpb25zIGFyZToN
Cj4gPg0KPiA+ICAgIHJ0d19zZGlvX2VuYWJsZV9pbnRlcnJ1cHQoKQ0KPiA+ICAgIHJ0d19zZGlv
X2Rpc2FibGVfaW50ZXJydXB0KCkNCj4gPg0KPiA+IFRvIGF2b2lkIGludGVycnVwdCBzdG9ybSwg
SSBwZXJzb25hbGx5IHN1Z2dlc3QgdG8gY29tYmluZSBOQVBJLCB3aGljaA0KPiA+IGRpc2FibGUg
aW50ZXJydXB0IHdoZW4gaXQgcHJvY2Vzc2VzIFJYIGJ1ZGdldCAoSSB0aGluayB3ZSBjYW4gVzFD
DQo+ID4gUkVHX1NESU9fSElTUl9SWF9SRVFVRVNUIGJ5IHRoZSB3YXkpLiBJZiAoUlgpIGJ1ZGdl
dCBpcyBmdWxsLCBpdCBjYW4NCj4gPiBwb2xsIGFnYWluIGJ5IGVzdGltYXRlZCB0aW1lLiBVbnRp
bCBidWRnZXQgaXMgbm90IGZ1bGwsIGl0IHJlLWVuYWJsZQ0KPiA+IGludGVycnVwdC4NCj4gPg0K
PiA+IFBpbmctS2UNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiANCj4gUmVnYXJk
aW5nIHVzaW5nIE5BUEkgYW5kIElNUjogV2hpbGUgTkFQSSBhbmQgSU1SIG1hc2tpbmcgaXMgdGhl
IHN0YW5kYXJkIGFwcHJvYWNoIGZvciBQQ0llLA0KPiBpbXBsZW1lbnRpbmcgdHJ1ZSBOQVBJIGZv
ciB0aGUgU0RJTyBpbnRlcmZhY2UgaXMgcHJvYmxlbWF0aWMuDQoNCkFzIEkga25vdywgTkFQSSBp
cyBhIHB1cmUgc29mdHdhcmUgbWVjaGFuaXNtLCBhbmQgc2hvdWxkIG5vdCBkZXBlbmQgb24gaW50
ZXJmYWNlcy4NCg0KUXVpY2tseSBzZWFyY2ggZm9yIHRoZSB0ZXJtcyAnbmFwaScgYW5kICdzZGlv
JyBpbiB3aXJlbGVzcyBkcml2ZXJzOiANCg0KJCBnaXQgZ3JlcCBuYXBpIGRyaXZlcnMvbmV0L3dp
cmVsZXNzLyB8IGdyZXAgc2Rpbw0KZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway9zZGlv
LmM6ICAgICAgICAgbmFwaV9zY2hlZHVsZSgmYXItPm5hcGkpOw0KDQpBdCBsZWFzdCBhdGgxMGsg
ZG9lcy4gDQoNCj4gbmFwaV9wb2xsIHJ1bnMgaW4gTkVUX1JYX1NPRlRJUlENCj4gY29udGV4dCAo
d2hpY2ggY2Fubm90IHNsZWVwKSwgYnV0IHJlYWRpbmcgZnJvbSB0aGUgU0RJTyBidXMgcmVxdWly
ZXMgc2Rpb19jbGFpbV9ob3N0KCksIHdoaWNoIHRha2VzDQo+IGEgbXV0ZXggYW5kIG11c3QgYmUg
YWJsZSB0byBzbGVlcC4NCg0KDQpIb3cgYWJvdXQgc2V0dGluZyBOQVBJIHRvIHRocmVhZGVkIG1v
ZGU/DQoNCj4gDQo+IEZvcnR1bmF0ZWx5LCB0aGUga2VybmVsJ3MgTU1DIGNvcmUgYWxyZWFkeSBy
dW5zIHNkaW9faXJxX3RocmVhZCBpbiBwcm9jZXNzIGNvbnRleHQgc3BlY2lmaWNhbGx5IHRvDQo+
IGhhbmRsZSB0aGlzLiBJZiB3ZSBzaW1wbHkgbGVhdmUgdGhlIFJFR19TRElPX0hJU1JfUlhfUkVR
VUVTVCBiaXQgYXNzZXJ0ZWQgaW4gaGFyZHdhcmUgKGJ5DQo+IGNvbmRpdGlvbmFsbHkgc2tpcHBp
bmcgdGhlIFcxQyksIHRoZSBzZGlvX2lycV90aHJlYWQgYWN0cyBleGFjdGx5IGxpa2UgYSBOQVBJ
IHBvbGxpbmcgbG9vcC4gSXQgd2lsbA0KPiBpbW1lZGlhdGVseSByZS1pbnZva2Ugb3VyIGhhbmRs
ZXIgaW4gdGhlIG5leHQgY3ljbGUsIHlpZWxkaW5nIHRvIHRoZSBzY2hlZHVsZXIgYXMgbmVlZGVk
LCBidXQgc2FmZWx5DQo+IGluIHByb2Nlc3MgY29udGV4dC4NCj4gDQo+IFRoaXMgYWNoaWV2ZXMg
dGhlIGJ1ZGdldC1saW1pdGVkIHBvbGxpbmcgeW91IHN1Z2dlc3RlZCwgYnV0IGF2b2lkcyB0aGUg
aGVhdnkgb3ZlcmhlYWQgb2YgZXh0cmEgU0RJTw0KPiBidXMgdHJhbnNhY3Rpb25zIHRvIHRvZ2ds
ZSB0aGUgSU1SIG9uIGFuZCBvZmYuDQo+IA0KPiANCj4gQmVmb3JlIEkgc3BpbiBhIFYyIGFuZCBy
dW4gdGhyb3VnaCBteSB0ZXN0aW5nLCBjYW4geW91IHBsZWFzZSBjb25maXJtIHRoaXMgYWxpZ25z
IHdpdGggd2hhdCB5b3Ugd2VyZQ0KPiBleHBlY3Rpbmc/DQoNClRoZXJlIGlzIGEgcmFjaW5nIGJl
dHdlZW4gcmVhZGluZyByeF9sZW4gKFJFR19TRElPX1JYMF9SRVFfTEVOKSBhbmQNCndyaXRpbmcg
aGlzci4gDQoNCiAgICAgICAgICAgICAgICAgICByeF9sZW4gICAgICAgICBSRUdfU0RJT19SWDBf
UkVRX0xFTiAgICAgIGhpc3INClQxOiByZWFkIHJlZyAgICAgICAgICAwICAgICAgICAgICAgICAg
ICAgICAgMCAgICAgICAgICAgICAgIGhpc3INClQyOiBmdW5jIHJldHVybiAgICAgICAwICAgICAg
ICAgICAgICAgICAgICAgNSAgICAgICAgICAgICAgIGhpc3INClQzOiBXMUMgICAgICAgICAgICAg
ICAwICAgICAgICAgICAgICAgICAgICAgNSAgICAgICAgICAgICAgICY9UkVHX1NESU9fSElTUl9S
WF9SRVFVRVNUDQoNClRoaXMgaXMgdGhlIGluZm8gSSBnb3QgZnJvbSBpbnRlcm5hbCBjb25zdWx0
ZXIuIFlvdSBjYW4gZG8gcmVhbA0KZXhwZXJpbWVudHMgKGFkZCBhIGxvbmcgZGVsYXkgYWZ0ZXIg
cmVhZGluZyByZWdpc3RlciB3aGVuIHJ4X2xlbiA9PSAwKQ0KdG8gdmVyaWZ5IGlmIHRoaXMgaXMg
Y29ycmVjdC4NCg0KUGluZy1LZQ0KDQo=
