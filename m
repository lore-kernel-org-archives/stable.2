Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831124A99AC;
	Fri,  2 Oct 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950219; cv=none; b=utk0fAwFbS0JI/iZnrx3MfAKXfR3/AXIG0hJOSTZOBBCuTz0T0YTXTmj/SliB3mWUFo/hWoWObOhME7eWzLQooF6mI1dtkk5xdIMJ4ztdZuRHfGWA+TEv0N3fuc64pHglEdCCXww2oUU6UQO2BBbW4UL6EvYM9ul/jZmPOMhI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950219; c=relaxed/simple;
	bh=0EiaRF/In0/nNA7vPnLt0gjy+PFmP80uWv0T8iMwUYQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=Z0cNmSKo+ZtVzv8U/z5ZGkuP7nCF0CCE/LjV3O3pWpwizXyk+AhJmMiwNwVaaj/iWklASOE7HzEPA1g5K89D0+CvlRgTD353XswPVpiJuALgPYImqlWHNXCId6r7otYyAgKYIdKepUXT4XFlQdjKxjzzpkR/zgdBnJEb8yz5V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=sGao/kyD; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="sGao/kyD"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790950213; h=from:to:date:message-id:subject;
	bh=0EiaRF/In0/nNA7vPnLt0gjy+PFmP80uWv0T8iMwUYQ=;
	b=sGao/kyDqFmQY6R/MVsX2oISmSWHmhxpzP2K6ASbqi+HqLIOctKcZu9fbYK0xcOdQNxKzssaf/n
	pzgPR4aAa0GlQWxQS3VLUopMov0Af6oYGEy7M5XOIovzodcnTSjeCZFkkqONrYV3uGXlVsytYufOe
	MTnygsHAKFLVC7FyKCfPLZp2K1CogrSqvtFNEQQ+oWpoEbominN/ix0blF/6NMdabCrf70FV6HeYV
	yujKXXi/kYnEyJBlqHusDMLV0CgXer+J3ruXeCSNxNWGcfNr/dow6Rl45Jp5WHLMjFN45Lhus5SS/
	/aCeZ9uq1iQ3NnW6urQorAf9B3DInSyWNnlw==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 19:10:13 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 19:10:08 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 19:10:08 +0500
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
Subject: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net v2 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdUne7YvawRqEbi0aVjxRtZyn78A==
Date: Fri, 2 Oct 2026 14:10:08 +0000
Message-ID: <20261002140954.261779-2-r.zhambakiev@prosoftsystems.ru>
References: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
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
YmVmb3JlIHRoZSByaW5ncyBhcmUNCmZyZWVkLg0KDQpGb3VuZCBieSBMaW51eCBWZXJpZmljYXRp
b24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0KDQpGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1i
eTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0KLS0t
DQogZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9mZWFsbnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jDQppbmRl
eCBiZGMzOGFhYzU4NTAuLjY4MTk0YzllZjMzMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZlYWxueC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KQEAg
LTY4MiwxMSArNjgyLDExIEBAIHN0YXRpYyB2b2lkIGZlYWxueF9yZW1vdmVfb25lKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KQ0KIAlpZiAoZGV2KSB7DQogCQlzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5w
ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCiANCisJCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQogCQlk
bWFfZnJlZV9jb2hlcmVudCgmcGRldi0+ZGV2LCBUWF9UT1RBTF9TSVpFLCBucC0+dHhfcmluZywN
CiAJCQkJICBucC0+dHhfcmluZ19kbWEpOw0KIAkJZG1hX2ZyZWVfY29oZXJlbnQoJnBkZXYtPmRl
diwgUlhfVE9UQUxfU0laRSwgbnAtPnJ4X3JpbmcsDQogCQkJCSAgbnAtPnJ4X3JpbmdfZG1hKTsN
Ci0JCXVucmVnaXN0ZXJfbmV0ZGV2KGRldik7DQogCQlwY2lfaW91bm1hcChwZGV2LCBucC0+bWVt
KTsNCiAJCWZyZWVfbmV0ZGV2KGRldik7DQogCQlwY2lfcmVsZWFzZV9yZWdpb25zKHBkZXYpOw0K
LS0gDQoyLjUzLjANCg==
