Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4947F2EE;
	Thu, 24 Sep 2026 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246682; cv=none; b=gby83O2ZJT0zAZbcr082gX2QsbTljwmLxAe5hGcVwquoPj7ONFuzZiVM0FZ6A/5WxXJ9HvR+UMkd+Poyb2p0f+5d4B2xrERZKIpzvlfAeQA4DhG9YtaonNNcvhHO74uTv07dtu2CNM3BArPOwpukjaXBqwrVdQ4a7TyQOuHFX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246682; c=relaxed/simple;
	bh=ah7fac/CqEsIFTs9480NqRMvP6wgFIPSujmju1CCtXY=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=CRpQ8gUpBL8xVjZMG0UppeN1kT78d/t9w4qv0edIMVjNQx3xMZvJnNnDmxeiD7XAF+D8d1DmsZhNZHqi6DiWAJuv73yMfJLbtp5pj6W4c5/kU1yD/CLdDvF9FsoKeLmw5uWf9EtVgNJHzXHCM4t0M7biNKTWDiXGLR19X8baTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=i2srl6/4; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="i2srl6/4"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790246668; h=from:to:date:message-id:subject;
	bh=ah7fac/CqEsIFTs9480NqRMvP6wgFIPSujmju1CCtXY=;
	b=i2srl6/4aOLKVL9wqxtiiYJIHMfgbdktFCqvL5mePOOqPqX5kr2QrKbU/JQA4l0FoNQ4l0ko2ab
	ba57sywM1tjN7UNmjCtv/yxzIzdbO4+jXulYyhy9NMh09DLvkRtGKL2E7w4BCIzyJW+83/sDeGabu
	O18EvFIqfjkgUGZPVu2sBh1vqJ7fFIVyT9IXFnVMkOydU2r7JacEpRoWy64kL4+lIihaQdDp0NuUC
	cBRGpOFmsc6Ks6hOEHebGAUXgFSrHnpg4uTqMMwpr561wWOktLHD32MhIhNHFtV1YeM8FO48Xbcil
	+3JtkyobJ8HQw9eYcvFb5ZtE2XHsCdVXOSBw==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Thu, 24 Sep
 2026 15:44:28 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 24 Sep 2026 15:44:26 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Thu, 24 Sep
 2026 15:44:26 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Denis Benato
	<benato.denis96@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, "Petr
 Machata" <petrm@nvidia.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net 3/3] net: fealnx: allocate the card index from an IDA
Thread-Topic: [PATCH net 3/3] net: fealnx: allocate the card index from an IDA
Thread-Index: AQHdTBGr0SioaCPvUE6nXjxP0Z9hYQ==
Date: Thu, 24 Sep 2026 10:44:25 +0000
Message-ID: <20260924104231.110576-3-r.zhambakiev@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0K
DQpjYXJkX2lkeCBpcyBhIHN0YXRpYyBjb3VudGVyIHRoYXQgaXMgaW5jcmVtZW50ZWQgb24gZXZl
cnkgcHJvYmUuDQpJdCBjYW4gb3ZlcmZsb3cgYW5kIHdyYXAgdG8gYSBuZWdhdGl2ZSB2YWx1ZSwg
d2hpY2ggdGhlbiBpbmRleGVzDQpvcHRpb25zW10gYW5kIGZ1bGxfZHVwbGV4W10gb3V0IG9mIGJv
dW5kcy4gTGFyZ2UgdmFsdWVzIGFsc28gbm8NCmxvbmdlciBmaXQgaW4gdGhlIDEyLWJ5dGUgYm9h
cmRuYW1lW10gYnVmZmVyLg0KDQpBbGxvY2F0ZSB0aGUgY2FyZCBpbmRleCBmcm9tIGFuIElEQSBh
bmQgZnJlZSBpdCBvbiBwcm9iZSBmYWlsdXJlIGFuZA0KcmVtb3ZlLiBUaGUgSURBIHJldXNlcyBp
ZHMgb24gcmUtYWRkLCBwcmVzZXJ2aW5nIHRoZSBvcHRpb25zW10gYW5kDQpmdWxsX2R1cGxleFtd
IG1hcHBpbmcgYnkgcHJvYmUgb3JkZXIuDQoNClN0b3JlIHRoZSBpZCBpbiB0aGUgZHJpdmVyLXBy
aXZhdGUgZGF0YSBzbyBmZWFsbnhfcmVtb3ZlX29uZSgpIGNhbg0KZnJlZSBpdCwgYW5kIHNpemUg
Ym9hcmRuYW1lIHRvIGhvbGQgYSBmdWxsIDMyLWJpdCBpZC4NCg0KRm91bmQgYnkgTGludXggVmVy
aWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCg0KRml4ZXM6
IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNClNpZ25lZC1vZmYtYnk6IFJhZGl5IFpoYW1iYWtpZXYgPHIuemhhbWJha2lldkBwcm9z
b2Z0c3lzdGVtcy5ydT4NCi0tLQ0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jIHwgMjIg
KysrKysrKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVh
bG54LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KaW5kZXggNDZhNDBkMDBiNTlh
Li5jNDc0ZGQ1YWM0YzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbngu
Yw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMNCkBAIC04Myw2ICs4Myw3IEBA
IHN0YXRpYyBpbnQgZnVsbF9kdXBsZXhbTUFYX1VOSVRTXSA9IHsgLTEsIC0xLCAtMSwgLTEsIC0x
LCAtMSwgLTEsIC0xIH07DQogI2luY2x1ZGUgPGxpbnV4L2NyYzMyLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2RlbGF5Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KKyNpbmNsdWRlIDxsaW51
eC9pZHIuaD4NCiANCiAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5oPgkvKiBQcm9jZXNzb3IgdHlw
ZSBmb3IgY2FjaGUgYWxpZ25tZW50LiAqLw0KICNpbmNsdWRlIDxhc20vaW8uaD4NCkBAIC0xNDMs
NiArMTQ0LDggQEAgc3RydWN0IGNoaXBfaW5mbyB7DQogCWludCBmbGFnczsNCiB9Ow0KIA0KK3N0
YXRpYyBERUZJTkVfSURBKGZlYWxueF9pZGEpOw0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2hp
cF9pbmZvIHNrZWxfbmV0ZHJ2X3RibFtdID0gew0KIAl7ICIxMDAvMTBNIEV0aGVybmV0IFBDSSBB
ZGFwdGVyIiwJSEFTX01JSV9YQ1ZSIH0sDQogCXsgIjEwMC8xME0gRXRoZXJuZXQgUENJIEFkYXB0
ZXIiLAlIQVNfQ0hJUF9YQ1ZSIH0sDQpAQCAtNDExLDYgKzQxNCw4IEBAIHN0cnVjdCBuZXRkZXZf
cHJpdmF0ZSB7DQogCXVuc2lnbmVkIGNoYXIgcGh5c1syXTsJLyogTUlJIGRldmljZSBhZGRyZXNz
ZXMuICovDQogCXN0cnVjdCBtaWlfaWZfaW5mbyBtaWk7DQogCXZvaWQgX19pb21lbSAqbWVtOw0K
Kw0KKwlpbnQgY2FyZF9pZHg7DQogfTsNCiANCiANCkBAIC00NzMsOSArNDc4LDggQEAgc3RhdGlj
IGludCBmZWFsbnhfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQogCQkJICAgY29uc3Qg
c3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCiB7DQogCXN0cnVjdCBuZXRkZXZfcHJpdmF0ZSAq
bnA7DQotCWludCBpLCBvcHRpb24sIGVyciwgaXJxOw0KLQlzdGF0aWMgaW50IGNhcmRfaWR4ID0g
LTE7DQotCWNoYXIgYm9hcmRuYW1lWzEyXTsNCisJaW50IG9wdGlvbiwgZXJyLCBpcnEsIGk7DQor
CWNoYXIgYm9hcmRuYW1lWzE4XTsNCiAJdm9pZCBfX2lvbWVtICppb2FkZHI7DQogCXVuc2lnbmVk
IGxvbmcgbGVuOw0KIAl1bnNpZ25lZCBpbnQgY2hpcF9pZCA9IGVudC0+ZHJpdmVyX2RhdGE7DQpA
QCAtNDgzLDIwICs0ODcsMjQgQEAgc3RhdGljIGludCBmZWFsbnhfaW5pdF9vbmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsDQogCXZvaWQgKnJpbmdfc3BhY2U7DQogCWRtYV9hZGRyX3QgcmluZ19kbWE7
DQogCXU4IGFkZHJbRVRIX0FMRU5dOw0KKwlpbnQgY2FyZF9pZHg7DQogI2lmZGVmIFVTRV9JT19P
UFMNCiAJaW50IGJhciA9IDA7DQogI2Vsc2UNCiAJaW50IGJhciA9IDE7DQogI2VuZGlmDQogDQot
CWNhcmRfaWR4Kys7DQorCWNhcmRfaWR4ID0gaWRhX2FsbG9jKCZmZWFsbnhfaWRhLCBHRlBfS0VS
TkVMKTsNCisJaWYgKGNhcmRfaWR4IDwgMCkNCisJCXJldHVybiBjYXJkX2lkeDsNCisNCiAJc3By
aW50Zihib2FyZG5hbWUsICJmZWFsbnglZCIsIGNhcmRfaWR4KTsNCiANCiAJb3B0aW9uID0gY2Fy
ZF9pZHggPCBNQVhfVU5JVFMgPyBvcHRpb25zW2NhcmRfaWR4XSA6IDA7DQogDQogCWVyciA9IHBj
aV9lbmFibGVfZGV2aWNlKHBkZXYpOw0KIAlpZiAoZXJyKQ0KLQkJcmV0dXJuIGVycjsNCisJCWdv
dG8gZXJyX291dF9pZGE7DQogCXBjaV9zZXRfbWFzdGVyKHBkZXYpOw0KIA0KIAlsZW4gPSBwY2lf
cmVzb3VyY2VfbGVuKHBkZXYsIGJhcik7DQpAQCAtNTM2LDYgKzU0NCw3IEBAIHN0YXRpYyBpbnQg
ZmVhbG54X2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KIA0KIAkvKiBNYWtlIGNlcnRh
aW4gdGhlIGRlc2NyaXB0b3IgbGlzdHMgYXJlIGFsaWduZWQuICovDQogCW5wID0gbmV0ZGV2X3By
aXYoZGV2KTsNCisJbnAtPmNhcmRfaWR4ID0gY2FyZF9pZHg7DQogCW5wLT5tZW0gPSBpb2FkZHI7
DQogCXNwaW5fbG9ja19pbml0KCZucC0+bG9jayk7DQogCW5wLT5wY2lfZGV2ID0gcGRldjsNCkBA
IC02NzUsNiArNjg0LDggQEAgc3RhdGljIGludCBmZWFsbnhfaW5pdF9vbmUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsDQogCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGRldik7DQogZXJyX291dF9kaXNhYmxl
Og0KIAlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQorZXJyX291dF9pZGE6DQorCWlkYV9mcmVl
KCZmZWFsbnhfaWRhLCBjYXJkX2lkeCk7DQogCXJldHVybiBlcnI7DQogfQ0KIA0KQEAgLTY5OSw2
ICs3MTAsNyBAQCBzdGF0aWMgdm9pZCBmZWFsbnhfcmVtb3ZlX29uZShzdHJ1Y3QgcGNpX2RldiAq
cGRldikNCiAJcGNpX2lvdW5tYXAocGRldiwgbnAtPm1lbSk7DQogCXBjaV9yZWxlYXNlX3JlZ2lv
bnMocGRldik7DQogCXBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsNCisJaWRhX2ZyZWUoJmZlYWxu
eF9pZGEsIG5wLT5jYXJkX2lkeCk7DQogCWZyZWVfbmV0ZGV2KGRldik7DQogfQ0KIA0KLS0gDQoy
LjUzLjANCg==
