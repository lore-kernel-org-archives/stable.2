Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A34F796D;
	Mon, 19 Oct 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417377; cv=none; b=ohsdynvGHsEXzR8T+GrATJWBuCPL3Sxf8WVEx8YxXffZYtZjys0yjfwiZEivIDiDzc02j/5+sckYZA02VAGXprBW/Cf8u+UrBL0sE4GUHo9P/Whof7vNFF3Q6WS9ZtM5TIaBSAp7vXTH/rX5/pEeYWpUGgdksUg1UlE4LWr2rSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417377; c=relaxed/simple;
	bh=C84TKR1hrVcojkwdM5Zu6RkUKAfVaE+DKGYVFdaNkWQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=Tnp7jRf0RL4REeqoZ6l83k3bFodg69iSPm6gKSjqkV3G/DapANQdGvYaH9s+WEl2PQciDlm5+gq1vf1glLptWPZgH5choHl175ZSKLUjaYCfZJocbSIhldFQOzHEFBTkHryfDmKkxZ0Okb3pLKNP673XiwLw1QhmhGu8/BN8O7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=EzVkq1Wi; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="EzVkq1Wi"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1792417379; h=from:to:date:message-id:subject;
	bh=C84TKR1hrVcojkwdM5Zu6RkUKAfVaE+DKGYVFdaNkWQ=;
	b=EzVkq1WiOWuD6Iszi05leLzTA/vQ/eZsMtEj3mU9w0nMJpABd9AuUg72JpIZdF3r1P3GnLtSzgP
	HDleUqqy8T4l8jQ//TUJhA+yB7rR2nRpD1tfV66Qok6yMp7LUsC65WHNYuYM0Wcl3OM5pt4iI5oPt
	tqks1i+Q/lW3IUHVOly/X3g9xT4EJCxxDr5L6ke0zKtotc7WH9NN3Dak7r07sF5fFIZN4hUqj3Kr3
	92clUU8AKDTH5EdGRtQiy41z0of4tkfHDIMXab0pVrvkh0lXIiJ4pOffWU9IH19yk4m1JQURfCYuk
	fM3b78E36+zy5tBQjr4WvPc4WiXSd9aTAm1g==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 19 Oct
 2026 18:42:59 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 19 Oct 2026 18:42:50 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 19 Oct
 2026 18:42:50 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Grzeschik" <mgr@kernel.org>, Jijie Shao <shaojijie@huawei.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Denis Benato
	<benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net v3 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net v3 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdX8+7uMsdjSOLkk2tFFyI0Dq26w==
Date: Mon, 19 Oct 2026 13:42:49 +0000
Message-ID: <20261019134136.104932-2-r.zhambakiev@prosoftsystems.ru>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
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
DQoNCkNhbGwgdW5yZWdpc3Rlcl9uZXRkZXYoKSBmaXJzdCBzbyBkZXZfY2xvc2UoKSBjb21wbGV0
ZXMgYmVmb3JlDQp0aGUgcmluZ3MgYXJlIGZyZWVkLg0KDQpGb3VuZCBieSBMaW51eCBWZXJpZmlj
YXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0KDQpGaXhlczogMWRhMTc3ZTRjM2Y0ICgi
TGludXgtMi42LjEyLXJjMiIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KUmV2aWV3ZWQt
Ynk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0
ZW1zLnJ1Pg0KLS0tDQogZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zl
YWxueC5jDQppbmRleCBiZGMzOGFhYzU4NTAuLjY4MTk0YzllZjMzMiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
ZWFsbnguYw0KQEAgLTY4MiwxMSArNjgyLDExIEBAIHN0YXRpYyB2b2lkIGZlYWxueF9yZW1vdmVf
b25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KIAlpZiAoZGV2KSB7DQogCQlzdHJ1Y3QgbmV0ZGV2
X3ByaXZhdGUgKm5wID0gbmV0ZGV2X3ByaXYoZGV2KTsNCiANCisJCXVucmVnaXN0ZXJfbmV0ZGV2
KGRldik7DQogCQlkbWFfZnJlZV9jb2hlcmVudCgmcGRldi0+ZGV2LCBUWF9UT1RBTF9TSVpFLCBu
cC0+dHhfcmluZywNCiAJCQkJICBucC0+dHhfcmluZ19kbWEpOw0KIAkJZG1hX2ZyZWVfY29oZXJl
bnQoJnBkZXYtPmRldiwgUlhfVE9UQUxfU0laRSwgbnAtPnJ4X3JpbmcsDQogCQkJCSAgbnAtPnJ4
X3JpbmdfZG1hKTsNCi0JCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQogCQlwY2lfaW91bm1hcChw
ZGV2LCBucC0+bWVtKTsNCiAJCWZyZWVfbmV0ZGV2KGRldik7DQogCQlwY2lfcmVsZWFzZV9yZWdp
b25zKHBkZXYpOw0KLS0gDQoyLjUzLjANCg==
