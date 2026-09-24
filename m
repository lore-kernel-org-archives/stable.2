Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039C472079;
	Thu, 24 Sep 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246675; cv=none; b=s7oJh8jxtKxlEfNzyi+Mn9yXlUmrI2puaC9qKqs86DChBpNUpuNPfzPOlv37Yc3wTBWJtuk5BNb5r9Izhq6ENI+t7umCIh+WcWhbjjdkgs4yuNKLl2rIa5nbc10LKyU8YnK3ylN9/61C/CU1NabbeUdGQXgJ4f6KCF/YXePoYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246675; c=relaxed/simple;
	bh=BQlb7rtZ1vFV1wT41RWEMd03KvMz0llx1nSE7npSHwU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=CCkbFaaKItBWzcnzpuxkomgGLJqdWyuIeT7RhKIRvGc0EsHbcyMGGBhxY1VROwbF8n7UqgF/3wvH60D1KYHCENhA7BTedafMPk6yjPTsjH9iXYemUEbfEZEG3eRo2PU8TZlTDnhQm1EAO/Aioi2hGdewYYXk+boXARAdtiU0IyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=Dfcs9p1W; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="Dfcs9p1W"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790246663; h=from:to:date:message-id:subject;
	bh=BQlb7rtZ1vFV1wT41RWEMd03KvMz0llx1nSE7npSHwU=;
	b=Dfcs9p1WhZRSowCMPKrCwbWUs4Mil6bJIR0kWh0l/Z5v4q0Guq8XyFtWx6SE/i3y2sG/kJ2SRGq
	jxHZzqvVANL5A0QSg6jGdr9FezcRMyVnuw259MIsjTRYUxs6dDfwOpR1YyE3cKSibeIMXNaPg8d4n
	qv07izkmDoBzCCHN6C081o5JjhzXpJKFSPuZsyUJkQ0MO9HCEi7wmZPhcRs8EPNHuxpikJse3HPrB
	Ldrqi+pKVzZXO+qOgBeo+RApenlQdoS1FsE4N8MUzdg/pt11Lg7nAyu7l1+FelnodFZmXhpI3gl9Q
	S65aFM5V34+IM2bGl70AZxCrIOVdVbXq5xQw==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Thu, 24 Sep
 2026 15:44:23 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 24 Sep 2026 15:44:21 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Thu, 24 Sep
 2026 15:44:21 +0500
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
Subject: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdTBGoaPRFHxtaVUSWHKvuDP/4nw==
Date: Thu, 24 Sep 2026 10:44:21 +0000
Message-ID: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
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
DQpmZWFsbnhfcmVtb3ZlX29uZSgpIGZyZWVzIHRoZSBETUEgcmluZ3MgYmVmb3JlIHVucmVnaXN0
ZXJpbmcgdGhlDQpuZXRkZXYsIHdoaWxlIHRoZSBpbnRlcmZhY2UgbWF5IHN0aWxsIGJlIHVwLCB3
aGljaCBsZWF2ZXMgYQ0Kd2luZG93IHdoZXJlIGZyZWVkIG1lbW9yeSBjYW4gYmUgYWNjZXNzZWQu
DQoNCkNhbGwgdW5yZWdpc3Rlcl9uZXRkZXYoKSBmaXJzdCBzbyBkZXZfY2xvc2UoKSBzdG9wcyB0
aGUgVHgvUngNCmVuZ2luZXMsIGRlbGV0ZXMgdGhlIHRpbWVycywgYW5kIGZyZWVzIHRoZSBJUlEg
YmVmb3JlIHRoZSByaW5ncyBhcmUNCmZyZWVkLiBXaGlsZSBhdCBpdCB1c2UgZGV2X2VycigpIGlu
c3RlYWQgb2YgcHJpbnRrKCkgZm9yIHRoZSANCnVua25vd24tZGV2aWNlIGNhc2UuDQoNCkZvdW5k
IGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpDQoNCkZpeGVz
OiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikNCkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpoYW1iYWtpZXZAcHJv
c29mdHN5c3RlbXMucnU+DQotLS0NCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYyB8IDI5
ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZmVhbG54LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KaW5kZXggYmRj
MzhhYWM1ODUwLi5kN2NkMTY0NGEzNzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mZWFsbnguYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMNCkBAIC02Nzgs
MjAgKzY3OCwyMyBAQCBzdGF0aWMgaW50IGZlYWxueF9pbml0X29uZShzdHJ1Y3QgcGNpX2RldiAq
cGRldiwNCiBzdGF0aWMgdm9pZCBmZWFsbnhfcmVtb3ZlX29uZShzdHJ1Y3QgcGNpX2RldiAqcGRl
dikNCiB7DQogCXN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7
DQorCXN0cnVjdCBuZXRkZXZfcHJpdmF0ZSAqbnA7DQorDQorCWlmICghZGV2KSB7DQorCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJyZW1vdmUgZm9yIHVua25vd24gZGV2aWNlXG4iKTsNCisJCXJldHVy
bjsNCisJfQ0KKw0KKwlucCA9IG5ldGRldl9wcml2KGRldik7DQogDQotCWlmIChkZXYpIHsNCi0J
CXN0cnVjdCBuZXRkZXZfcHJpdmF0ZSAqbnAgPSBuZXRkZXZfcHJpdihkZXYpOw0KLQ0KLQkJZG1h
X2ZyZWVfY29oZXJlbnQoJnBkZXYtPmRldiwgVFhfVE9UQUxfU0laRSwgbnAtPnR4X3JpbmcsDQot
CQkJCSAgbnAtPnR4X3JpbmdfZG1hKTsNCi0JCWRtYV9mcmVlX2NvaGVyZW50KCZwZGV2LT5kZXYs
IFJYX1RPVEFMX1NJWkUsIG5wLT5yeF9yaW5nLA0KLQkJCQkgIG5wLT5yeF9yaW5nX2RtYSk7DQot
CQl1bnJlZ2lzdGVyX25ldGRldihkZXYpOw0KLQkJcGNpX2lvdW5tYXAocGRldiwgbnAtPm1lbSk7
DQotCQlmcmVlX25ldGRldihkZXYpOw0KLQkJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCi0J
fSBlbHNlDQotCQlwcmludGsoS0VSTl9FUlIgImZlYWxueDogcmVtb3ZlIGZvciB1bmtub3duIGRl
dmljZVxuIik7DQorCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQorCWRtYV9mcmVlX2NvaGVyZW50
KCZwZGV2LT5kZXYsIFRYX1RPVEFMX1NJWkUsIG5wLT50eF9yaW5nLA0KKwkJCSAgbnAtPnR4X3Jp
bmdfZG1hKTsNCisJZG1hX2ZyZWVfY29oZXJlbnQoJnBkZXYtPmRldiwgUlhfVE9UQUxfU0laRSwg
bnAtPnJ4X3JpbmcsDQorCQkJICBucC0+cnhfcmluZ19kbWEpOw0KKwlwY2lfaW91bm1hcChwZGV2
LCBucC0+bWVtKTsNCisJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCisJZnJlZV9uZXRkZXYo
ZGV2KTsNCiB9DQogDQogDQotLSANCjIuNTMuMA0K
