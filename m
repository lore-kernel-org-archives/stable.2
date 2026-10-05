Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EA1FA272;
	Mon,  5 Oct 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791164762; cv=fail; b=MEgJNO63qkTy4d8B+/hRfYF3F/zFGXAkADIeRRHNjg8pCo4BYMvLvWO5m2pk65Mc1YZ8mksEZ3GLRIrueHDB8+A45BEa9H06ls0EGflIzHgOARcQAMKrOUkYVS2JSzR4a3wDctEZDZC0caYBa+dsV1QUt/AJLMCoGlVe2SuYElw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791164762; c=relaxed/simple;
	bh=8z3P4gdSoWoTS6G7CDETbGVL1FaapoZCLDEqoGCRFA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VSPpsPbKo7N9uZpwG8Ca25M1aPwp/3yCJVlQeAuadYf4aaWci1arEh3HUdTZLZewaF1h8fHjCLzjus8p7NAYFgkaOkBLRRfcOYUqpkVqM3oQwAK5OXRPj5xAIE2qGcKYFxJOYpyN7te2toMfMXUNIRH32sX/t77abUIpfX7iD2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ScjNJmRy; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ScjNJmRy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k976qRtM0EvG3z/LQB8kM08Cd3Xs5iNYBJADRC/Nu1MqHJrtNFLfd/z0AZEp+EpMMLA1wSfDWf+vpntFm200ETlxDpDwXOYUeDwnkBw6C00thnBXFhIyy2P9E+6MEmFo0A9mspKdqRM5HWW5oFnsrhNZwQNOsyLnog6P3/aIK6YnIyhk6yK/cD46v5kzEQOJeECe1rR5+tfDsU89essIvjOYylI9Fr+wjMbiNZ0YHtdFcZk3q5Z/sr/r5hywtnQuWih98XEWdWzS3Aw9wwuySqozTVJtfUpkfU/kBAt5nn1xbgCKalt6XQaojqCp4dSMH9DlsKjbBYtxDyR2tl73JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z3P4gdSoWoTS6G7CDETbGVL1FaapoZCLDEqoGCRFA0=;
 b=oc6SG5fD6bcgBHIDcq695hFjWRXn7Ji0/qBk0ZTgFnxOvv9oHGVsB2/8SqZlYes+xLw/3pjfcGrRyhp7XZ71pyksiHc32Z06TNt6Cx9qWgWTXuAdt3yBMLo+XQM7+X/GlizcnTTiJIiXguBEFGzHWI+iICuMo8bQP+sNZpDjHDZ+znE4felt3udlvsDgw2zrwNMQ1WvWKMWaPEYYYUsP2zzh1V8SxPr7iKldchpEQM+HqDvd6kZQ7oyevAKnQTihvi1gR+BdwAn3EoG8MUndPwESJ+BDXMwdjQ1NaExve/iT46TKg4yApyhXTW1DDk/UFOjbagpjGhnss+kUvlEmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z3P4gdSoWoTS6G7CDETbGVL1FaapoZCLDEqoGCRFA0=;
 b=ScjNJmRycKQa4zztxtNR+Pyt9yBtSojDaF2msbZnAkQHGG0S/2JG8a1g1nPbTDiUqN4Vz2Mq3EzKYIyhE0opMv70l2Q/zXx8kny65g93MKapT3LeGtOySrLn/1WkqwFXR9UPGVxaj519xqPuyLK67plU1CSRDpAuTplluSexLCgu6RDiOsjQnrXW8ouQOkQTRt9Coc+C8YC3MGN4H8TdrwpufSwsMaCdiggKoBsmYVixqFtvIn02TTQVqR5hAb2mgpW/oRZszhLPRXrp6Sbq5whUBLhZmyw0MmIGVPg+PYPOuNUFGsvnW+cE1dn5xBk5id9li1RQJm8S/7mDJ1L3sw==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by VI0P189MB2687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:45:57 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:45:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH v2 2/2] tipc: fix use-after-free in netns teardown
Thread-Topic: [PATCH v2 2/2] tipc: fix use-after-free in netns teardown
Thread-Index: AQHdVENqYoa8TfVCgE6Mhz6mD6os8LbuLdBg
Date: Mon, 5 Oct 2026 01:45:57 +0000
Message-ID:
 <DU4P189MB3750E6532E8D70D1E34F31DDC6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20261004210016.3051310-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261004210016.3051310-3-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261004210016.3051310-3-Jeremy.Jean@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|VI0P189MB2687:EE_
x-ms-office365-filtering-correlation-id: b19731e3-8369-439a-8143-08df228266ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 nyxWxYThEzIK6rDrHLWwnwa2PDjj4aK4Jm6DrAGCMkQB+qFngGDU3AlDADNdbBgOMBnqx/XBaJ3kHfkFoZX+xRdQ1JDAQzy6rae0bzm+CKHP0LOF/W4IDf6+ofmfFsRLknzJ9EjtZsNUoq95IitMuVih1iT9Tsrf49dwiWuM/gNnkFsSpKP1TnWoo3nGJXBo83CybXcW+Pe1GLPqLdRg3XWsQ7RRR6SGSQ3sfRcP3dW4HZ300ILdUwWe8RTrm4UmIsxF3ZexOZgFWRRWNW8gz9J6sjMb7VQu31CyaSbKkGVZHIPaIhCvpfyBBgGBF9U+e2CiUy1Xx74t39oHJ76dRaARxQqroGwmZKwanSVQaRL/ok9vPLHigfB6sLYSp3WiNDywn71amUW5gbThXhkqHklizHNzfBAzuXeIeTbxUHp89h8Dx9Ekf426u1XldqmufqUpWyddmzTSlSWi7kzcrd9yKOcjr7DR5nLGGkcrDDyqswolFbObTdjUdSj8Qb7SSVpEVzE/OUSKW1ibro4vNGbtLoMiSpe2I4JtXFeWn54mzUY8V+H3fmfcUf74irg3c4n6sTVM79nVhIqzPTx8qQ87PiCtlRMgQlIwqyzp/VxpT/zJj0NxmHWKF7ivRTdRUP7yHQAALz/jgDzp7TcqMYPJb582UyRzohHc5y3rnRVe2feIrSeE6qZM+fpa+W6meeYwr6UkH8uvl14k/XUNrUtN3qFw053cX/6xmIa5m0w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm1SdGZiV3RnZmczYWozbGl1ejZTdFRFVnVhMVd2dFJiRUhoNE0vTXpPd1R5?=
 =?utf-8?B?emRmTFNrVVMrNDVJbm0zeTNnVE9OTThtcmVLY3VqSEdQOWxLSVBiZ3BEU2wy?=
 =?utf-8?B?NmVqVGhSMG5NTkRLazRJa1lKY1Nwa1d3NXRsczdBZVoyM2lOSUpORTZkVjdt?=
 =?utf-8?B?UUhUWHh4ekVEbXRNNW5icHM2Rkcza1J6TG4yQnhoTDJvQzZUWUVjcnp1Sktj?=
 =?utf-8?B?ZjdwVklTMmlRVjhVWlVWSWdBSHlvNXFSUGJqRFFpbkhwbFd0cFRTdlVRYkJp?=
 =?utf-8?B?V2xqc1E2UDJPTHd1aFlYbVdtMEF6RXRLWDNmR0lPUXpkeG9USEJub3NuZkxo?=
 =?utf-8?B?M2tJSjVPaFZncG5XdmsyK25NMEc0dXJYZkRTM1FZMkdOVyt5YVdXazdzSTN6?=
 =?utf-8?B?VFhzdTgrL0RPaXpzeHIySEZGRVZUMzVXWWpVamM3alZ1NElzS1R4RmlUQThC?=
 =?utf-8?B?UjNFSURLMUVLakpNTFZwRmRNM281cW9YUHpDL2wrYllHNjRFaExuOWxpenFH?=
 =?utf-8?B?YVM0YUxEaGd2VGlxK0xBdUlDek5qdmxJMFRIaFJKaXI3S0Fkb3ZYNkl3MENT?=
 =?utf-8?B?THhkZ01hRkRFUGJkcCtiMC8rVS9QUnAvNG9LQlNhMHcrVlVOT2FhVEtEWUhU?=
 =?utf-8?B?OGd0Wm53dFJveXhSWlo4em9EdzdjdFlrZjVqZVRIQjJudDdSRGxWdU9aL1dW?=
 =?utf-8?B?RnZld2JITWtlbGdTdldWQlJzZktCV05DZ1lXbnloVHBuWjZmYWhERHM3K21w?=
 =?utf-8?B?WUEycjdHeUwybTBOSGF1R3Q2ZnI4S1dRWXFsWkY3OVVnWXBDN3JKZWN6TlpF?=
 =?utf-8?B?czFTc2ozb0k4TThKOG9wTGlGTjNwTUJ5WHVZamRndlJOc1JnSXRDaWp4UFV2?=
 =?utf-8?B?d05yQkpuOC81SXJtRzFaeG1qREcxVWlCbEZRdHl6VDhnWklJNlIrQXNEQ0pY?=
 =?utf-8?B?THZzMjFmelFnZkVseWhIeFJ2QzVHak5QY0pFUlN2SDhERVNPNDZEMmxNQmpa?=
 =?utf-8?B?Z2o0UHdMVnVGMjZ4emlWa3IxaHJZeDVuRFJueVgxa3dpZ2ZySUx6YWZucnhP?=
 =?utf-8?B?K1VSbEN5elVIeHUzMmZDdk5ZUU95cUlUQTJZMm5iUEUxSWQzdTA4WHRDRXdC?=
 =?utf-8?B?WXhPZmhWeXVraVd4QVB0VXErQVNjMm10Y3phd0NQZjYzT3RyRjRpeGFPbVRB?=
 =?utf-8?B?T2swb0xPMTVpbTIxWjFsTEJrV0U4ckxseTBqcGhINXh6a1J1U2t1MFlnVmNJ?=
 =?utf-8?B?emFxTGUrdktpZWtpenBoZXkwZXlhYVErSHYrU3dNSmVBR09uZ2tjazN3QXhP?=
 =?utf-8?B?L3VGQWhsR0dtQzdVRW05VE1yZnJjeitnZkpWMzNibi92V3lwbVllanZwU3pi?=
 =?utf-8?B?YnZYSlg4ZDdsLy9ubFZ4bVNLd2wxSitIcEtoZHZCdDZIM3ZQejR5eGdpaXRQ?=
 =?utf-8?B?QXBBRkJES1BlVTI5enc3TjY5eG0zMWVjTjNiVUJqZzV0aC9PR2xKZk5JRFJk?=
 =?utf-8?B?TjJKa3Q2aS9vQTE5Z2QzNGFLNWV4Myt1eE0wRnRwYkxQRGE4aDhCYWpaenht?=
 =?utf-8?B?YVc2UnNKeE9Na0hRQitBTkw4V1lNQW0zL3BmZ0F6RlVJSlIxeGZHNG9wd3Na?=
 =?utf-8?B?bWJVZlF1dzNWVFJNZUwrUFJxVVNYdUZDQUVnNEovcXZTMDhGMWtmeUZMLzl1?=
 =?utf-8?B?ZkI0R2ZoM2tYc2hKQnh6STF4SFRGdy96dHZFUU5JT2ZoajBPKzIyNXJOYVpO?=
 =?utf-8?B?VVdkQWhKZGVnT2VNWFZObGJ3NkxJMThLNDlvLy8rcUMxOEtCTGhtZjVnNlFS?=
 =?utf-8?B?dnRvZnJsYmMrQ0xTOGVJelpxYzFaK3lFdjA3ZE5DR2VtSjFLR1NCMlpzd1kw?=
 =?utf-8?B?QnlsenZXelQ2bWpDSmFSdXJ2dERLdVBmTnRyWkpoeHhoVnJLTExTSkdkWHR2?=
 =?utf-8?B?NFZpL1JHUFlzMFFEeGtxZ09JOHpJa1hwV0p4dHJxZlB2WkIzVVZneDk0cXcz?=
 =?utf-8?B?MVlPWkNIVkQ3L1ZhZWI2RHVVVWtzR2hkdjMybHZSMDdCY21iN3ZVc21RVDNZ?=
 =?utf-8?B?VThPWUhURUl6VzdnODRoWkI1bXJFRXZOOWVxbkM0dGc2S2ZPYVY4bndUbHll?=
 =?utf-8?B?ZFE3QVVkaFB6V0RueDNXcXRLTjdOaWJWU1hWL2pyTEI0dDJOVFZkNE0yUnc1?=
 =?utf-8?B?MTF6WEZUMmJ5bWMvYTVxZXZSTGl0RFFDZGdRWDhFNE5wbzhxWFVVMlFQQ3I4?=
 =?utf-8?B?TVF1WDJENXBGalpEc25KczBzNjJXeGV0d0tIQTBJSTBaRTcxVjQwRWxSTTRz?=
 =?utf-8?B?a294eG1iekdPUnJhY3Vqcm1FQTNXVWxmMG54c1R0cWRxc3FmVnhJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b19731e3-8369-439a-8143-08df228266ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:45:57.4929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSlIaCXQ/WV9StmYXDzfK1IAd1nWv3vXTg+P0W+lR/OkVyevhb4o/MY2c5iht+bTqdoR9E8CBo0oiocdN2WazfbP1P05vdaSNErDqs1pQlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2687

PlN1YmplY3Q6IFtQQVRDSCB2MiAyLzJdIHRpcGM6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBuZXRu
cyB0ZWFyZG93bg0KPg0KPmNvbm5fcHV0KCkgZGVjcmVhc2VzIHRoZSByZWZlcmVuY2UgY291bnQg
b2YgYSBjb25uZWN0aW9uLCBhbmQgd2hlbiBpdA0KPnJlYWNoZXMgemVybywgdGlwY19jb25uX2ty
ZWZfcmVsZWFzZSgpIHJlbW92ZXMgdGhlIGNvbm5lY3Rpb24gZnJvbSBjb25uX2lkcg0KPmFuZCBm
cmVlcyBpdC4gUmVtb3ZpbmcgdGhlIGVudHJ5IGlzIHByb3RlY3RlZCBieSBpZHJfbG9jaywgYnV0
IGRlY3JlYXNpbmcgdGhlDQo+Y291bnQgaXMgbm90Lg0KPg0KPkR1cmluZyBuZXRucyBkaXNtYW50
bGUsIGl0IG1heSBoYXBwZW4gdGhhdCBhIGNvbm5lY3Rpb24gZ2V0cyBpdHMgY291bnQNCj5kcm9w
cGVkIHRvIHplcm8gYnkgY29ubl9wdXQoKSB3aGlsZSB0aXBjX3RvcHNydl9zdG9wKCkgc3RpbGwg
aG9sZHMgdGhlIGxvY2sNCj5pZHJfbG9jay4gdGlwY190b3BzcnZfc3RvcCgpIGNhbGxzIGNvbm5f
Z2V0KCkgb24gdGhhdCBjb25uZWN0aW9uIHdob3NlIGNvdW50IGlzDQo+YWxyZWFkeSB6ZXJvLCBh
bmQgdGhlbiByZWxlYXNlcyBpZHJfbG9jay4NCj50aXBjX2Nvbm5fa3JlZl9yZWxlYXNlKCkgY2Fu
IHRoZW4gZnJlZSB0aGUgY29ubmVjdGlvbiBiZWZvcmUNCj50aXBjX2Nvbm5fY2xvc2UoKSB1c2Vz
IGl0LiBLQVNBTiByZXBvcnRzIGEgVUFGIGFzOg0KPg0KPiAgQlVHOiBLQVNBTjogc2xhYi11c2Ut
YWZ0ZXItZnJlZSBpbiB0aXBjX2Nvbm5fY2xvc2UgKG5ldC90aXBjL3RvcHNydi5jOjE1OCkNCj4g
IFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmYxMTAwMDAwY2Y0ZjQwOCBieSB0YXNrIGt3b3JrZXIv
dTE2OjMvNzANCj4NCj5TdG9wIGFjY2VwdGluZyBjb25uZWN0aW9ucyBiZWZvcmUgd2Fsa2luZyBj
b25uX2lkci4gVXNlDQo+a3JlZl9nZXRfdW5sZXNzX3plcm8oKSB0byBhdm9pZCB0YWtpbmcgcmVm
ZXJlbmNlcyB3aGVuIHRoZSBjb3VudCBpcyB6ZXJvLg0KPldhbGsgZm9yd2FyZCB0aHJvdWdoIGNv
bm5faWRyIHRvIGRpc2Nvbm5lY3QgYWxsIGNvbm5lY3Rpb25zIGJlZm9yZSBkcmFpbmluZw0KPnRo
ZSB3b3JrcXVldWVzLg0KDQpUaGlzIGRvZXMgbm90IGZpeCB0aGUgcm9vdCBjYXVzZS4NCkkgZml4
ZWQgdGhlIGlzc3VlIGluIHRoaXMgcGF0Y2g6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbmV0ZGV2
L25ldC9jLzNhY2RkNDQzODViYw0KUGxlYXNlIHVwZGF0ZSB5b3VyIG5ldCB0cmVlIHRvIGNoZWNr
IG91dCAgdGhlIGZpeC4NCg0KLS0NCnB3LWJvdDogcmVqZWN0ZWQNCg==
