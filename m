Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97095395266;
	Mon, 28 Sep 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598782; cv=none; b=m7CWB5qALYJl6lICuaJdUaRmXiL4JBEhnvgaX265hWL2mbS6tZLtUebK5hDu/X9jYIQnqObr2ZffrhjFiCeDhdPTe6Aj3vSgzpYxnpssUebw+mUtZVGXjn/Qm9jxGvsAKigHD2AkkqQOCRUJmvJVIMyIpzMURsk4ivexKFAf6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598782; c=relaxed/simple;
	bh=KNqa0pU99+P86tzxFdqCtt204ugjSbtQEf0F51iop1U=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=HgpQ8SC8xhkK0vAXZi4cqGXRSow26JVd3KDL0lKKwnhP2fY1qxQBZz1F5EOaMPEFh3v5FmByqjQ5l4i6JO6IUeMeGQVVjXGFrUBpLwk1MuGcWfirALEUFlvqO9o1tpImVHUD0gWaP0YLFRg0d36LCvX3W6DxsZdbS+goflac1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=l6ExVy0o; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="l6ExVy0o"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2DA27CD96067F42A442AB0136E74D24@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790598785; h=from:to:date:message-id:subject;
	bh=KNqa0pU99+P86tzxFdqCtt204ugjSbtQEf0F51iop1U=;
	b=l6ExVy0oqsCpx0nwbdTe8no1S3R+uKVM89wsjXGLe66jXYhF0eIIohS1iCbXmLtHGh0GzrLR8BM
	0zQhl2Jc0+y/dBpNksoZY00UapC/viMtQV9i+5ozf5Z0sby9O4xjgO2z4IDQ0faQuo5iy7QUEGy/F
	rSLsmjTL0Dhq9tsmtIAKQy1ZZJ/amaktllq/U07+//xGqHBVDZ+ZyDTwGh8c6xF9z+zEV7n1z0n5e
	JrmIMkcVYaydnRqanfqXiUz1Z5bq1v0DCOF4ePVOIjc5u6v5FjpHIzlDct9BpPi93ls+hfvhp3h5n
	g0ii4JG+X/+i6RlB5GOAxhoZUmYAH7BqW2DQ==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 28 Sep
 2026 17:33:05 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 28 Sep 2026 17:32:56 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 28 Sep
 2026 17:32:56 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>
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
Thread-Index: AQHdTBGoaPRFHxtaVUSWHKvuDP/4n7bd8d+AgAWtJgA=
Date: Mon, 28 Sep 2026 12:32:56 +0000
Message-ID: <1e36eb653106cee3a5294e0cb052fe6b9719d638.camel@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
	 <20260924215155.GA3984640@electric-eye.fr.zoreil.com>
In-Reply-To: <20260924215155.GA3984640@electric-eye.fr.zoreil.com>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA5LTI0IGF0IDIzOjUxICswMjAwLCBGcmFuY29pcyBSb21pZXUgd3JvdGU6
DQo+ID4gV2hpbGUgYXQgaXQgdXNlIGRldl9lcnIoKSBpbnN0ZWFkIG9mIHByaW50aygpIGZvciB0
aGUgdW5rbm93bi0NCj4gPiBkZXZpY2UgY2FzZS4NCj4gDQo+IFVucmVsYXRlZCBzdHVmZi4NCj4g
DQo+IC0tDQo+IFVlaW1vcg0KDQpTaG91bGQgcmVmYWN0b3JpbmcgcGFydCBiZSBwcm9wb3NlZCBh
cyBhIHNlcGFyYXRlIHBhdGNoL3BhdGNoZXMgb3INCmRyb3BwZWQgY29tcGxldGVseSBmb3IgdGhp
cyBzZXJpZXM/DQo=
