Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645743B6CE;
	Mon, 28 Sep 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600890; cv=none; b=aivWKYyjU49A2NPoIpa5tusJZa3aL1E6w/sOuuc+inxmEM/HY0Eu1IScZtLt3WmC5LSFAsyr/aOKTPdAcMH93NrhMt7EPLuozQRBjSpe72bFyZPxW3ADD46gOmxezQB3WMwqWbz0nNpC5VY9oqN33O1/0qS/eMCXa/T4YElnP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600890; c=relaxed/simple;
	bh=3TAn+Vyn87oVh0cbE33r1s0pe651j7sghTZU7PotbVw=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=jS6YkgZeMzuURTU2uz0e30SlKz4Q7DwuaQe8Ad/n9+iFrqVVLPRhhqBKkKkH8gka1Uyz5qeQBSjFhbRLcT6WcSz5oK8y4iVScvOYY5weG2VBZBRMflSpvb5FalR8o+hhrIgukKvYFBmv+61Jl+ZzqroOlg8RV66qbWJSZYgd8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=Zi44cSmQ; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="Zi44cSmQ"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <051F42E62A3E8D46A12823A2C2D66EBA@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790600894; h=from:to:date:message-id:subject;
	bh=3TAn+Vyn87oVh0cbE33r1s0pe651j7sghTZU7PotbVw=;
	b=Zi44cSmQEnHCwv4FFmufkqxNTTeuLGtVHb8HWigC0a42t7um7nZbVT+zTvsQLvRKPgWSIsQt434
	XTN6Gg0CqzmZ/9LJi6q693O8KLNodzpKKUHUWkf3MiWyTJ02zTRINLSbBdya11EEPRJVuE3xSamKw
	/39FwJJ0ipG3XSqYJGv7PobCtGmNvUCDnVdtZw4vUikQfC0WtES8t2rIB3Y83Jw+Atmlo+zTn0x5f
	5O/QkJGE+58uiL5pvhe87O1ehLtxfb6nMTRWCDCVJncEnEp0k/7aVK0TYCNQZ06nK+CXnNxe/wlJk
	qvHsj5rUjpvnjAFOT8N9U3fv7pEsjTptWTFQ==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 28 Sep
 2026 18:08:14 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 28 Sep 2026 18:08:05 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 28 Sep
 2026 18:08:05 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "benato.denis96@gmail.com" <benato.denis96@gmail.com>, "petrm@nvidia.com"
	<petrm@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdTBGoaPRFHxtaVUSWHKvuDP/4n7beyjqAgATenAA=
Date: Mon, 28 Sep 2026 13:08:04 +0000
Message-ID: <45f24000abd3ffa82079d79bcdfd495d6b150ace.camel@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
	 <179033317745.2160803.17677672986489038086@kernel.org>
In-Reply-To: <179033317745.2160803.17677672986489038086@kernel.org>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI2LTA5LTI1IGF0IDEwOjQ2ICswMDAwLCBuZXRkZXYtYm90K3Nhc2hpa29Aa2Vy
bmVsLm9yZyB3cm90ZToNCj4gLSBbSGlnaF0gVGhlIGNvbW1pdCBzYXlzIHVucmVnaXN0ZXJfbmV0
ZGV2KCkgLT4gZGV2X2Nsb3NlKCkgLT4NCj4gwqAgbmV0ZGV2X2Nsb3NlKCkgImRlbGV0ZXMgdGhl
IHRpbWVycyAuLi4gYmVmb3JlIHRoZSByaW5ncyBhcmUgZnJlZWQiLg0KPiAtIFtIaWdoXSBUaGUg
Zml4IGFzc3VtZXMgdGhhdCBvbmNlIHVucmVnaXN0ZXJfbmV0ZGV2KCkgcmV0dXJucywNCj4gwqAg
bmV0ZGV2X2Nsb3NlKCkgaGFzIHN0b3BwZWQgdGhlIFJ4L1R4IERNQSBlbmdpbmVzLCBzb+KApg0K
PiANCj4gUHJlLWV4aXN0aW5nIGlzc3VlczoNCj4gLSBbTG93XSBBdCB0aGlzIGNvbW1pdCwgZmVh
bG54X2luaXRfb25lKCkgY2FsbHMgcGNpX2VuYWJsZV9kZXZpY2UoKQ0KPiBhbmQNCj4gwqAgcGNp
X3NldF9tYXN0ZXIoKSAobGluZXMgNDk3LzQ5OSkuDQo+IA0KPiAtLQ0KDQpJIHRoaW5rIFtIaWdo
XSBpc3N1ZXMgaXMgcHJlLWV4aXN0aW5nLiBTYXNoaWtvIHBvaW50cyB0byB0aGUgY29kZSwgdGhh
dA0KYWxyZWFkeSBiZWVuIHRoZXJlIGFuZCB3YXMgbm90IHRvdWNoZWQgYnkgdGhpcyBwYXRjaC4g
SXQgbWlnaHQgYmUgdGhlDQp3b3JkaW5nIG9mIHRoZSBwYXRjaCwgdGhhdCBtYWRlIFNhc2hpa28g
bWFyayBpc3N1ZXMgYXMgZnJlc2hseQ0KaW50cm9kdWNlZC4NCg==
