Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E30404BFD
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759411; cv=fail; b=Vv2ncfvL2rse49GllGqXrMIFhixWsYEneEagjMVzRuvwYdPxRMpIsapQvk9l/EBR7BSAn1vUgdd7Vky/aOgxnQOlnnmz4c3sCS7qnIl9OHnMpULf35Wk3e11ioyQOKoCdpfBty4H1kkuQSxn04MEz1PCyAGYdGtGwu5SqDIDRFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759411; c=relaxed/simple;
	bh=riMLM1aGRfzRBIh5qBjgQ/GZBPeFM/vXPs7XkFgw4P4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbk+r1iig8SMBnjQfz7bIPmc2Fn6pNF4VlIHjwBgpZ5ApB6rnAyj0vAEPBuW8h/d9j1ekhtMhsK2nUKyp+LacgyPQBVEbpPpr4z3MNFzooZvbUSRoRuNcU8bZbpkp2IJpXEL3DUD14R+DZ2MMoMh2+qRY2Pz5oHxdxSSFQZhCm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZLB+AYHg; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZLB+AYHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxyjpqsA+9szV7jggBKctRVmPQCd2HOlLS+/fk8ZPvkUnUKi3QIC1nPlWFZukJUzjvKfvNS9U+q9Bf+ulhl1Ee/Rn1gBQUmTR9X5jOY3Pb5NAHHb8VyMiuMFd7nZJz9FIxU3VcDj1oFX1++lMPcni1ZutzO222NHXs0LYO47PFv3WSmCe0mM+TS226AHOkWLN8+xvI/WOL634XLTNaLK+2jw46DCD2malCCRVlHT+KVJIhjsZIWSYN6L8BRWNeoxnezMvuhEdnMGYFTkgDbPto6Agum2xK+iQWNdt6b+cAgZXEqef/b/mLpAMH1W7ibWnbu/waOZjFOWbN6EvG1ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riMLM1aGRfzRBIh5qBjgQ/GZBPeFM/vXPs7XkFgw4P4=;
 b=i29ALYUHTTmYk08rEKiJ9rCcWeDgKmowTiHkxCp6sM+pWEsQ5tdGBMc1iwveGMGMV6OJaXrfe2Chy/shT1FhkpJmM0mqj6DpuK1HF8Wr/8gN17vc0JlgL5y+6NS2FeI8f80gIYZdXK5COMq0jY9M9iW8cg7xXiIBnNZZVugt3kQ6IuiccW7AcbvE6RT1/SHqmU23EY8Rwd+sDEZ4CdQnA/7XUcC+DrXC1+hhwCoRKVT2NfNhl9aI0Kx3xHf67+fWlKS5htkgGTDvC3JaqGIuYuAVyxcMN7PI/k5OcsSOZF78vmxRcjwP0DlS22GPerMgtYTVO2FOaYEc7QIOk3RBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riMLM1aGRfzRBIh5qBjgQ/GZBPeFM/vXPs7XkFgw4P4=;
 b=ZLB+AYHgY34X9Sk1bhyMFnm6/arnhgB0rP0Oi76hPqgY2W44LuEQq7W/F9kvzW9mGDKVx0vfFlZnOjj+IUwcYlwKayR2/UMs7+YZXfMwbRWAfqRTlmu91NAlycOAsH3dflwc2fgOc8nEUL1trLWVJYMO5ZKhQ2+GSybsj3ZYxgIqJU4uyDOWQBGYQYMFXr09eKlPWPUsgamsV6mCha7XGRixPrUbtB/PwUASDOLQEwLXth4tPGJGHzLWYjGWYRcJMyA9t01sEA8H6IdG7JXglZcqIzYym3tgp61888vsGsHjDriaF90HtEt+AD43WxhTfhZmbJFWi/HxVtf4XqxqSQ==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MW4PR03MB6921.namprd03.prod.outlook.com (2603:10b6:303:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Mon, 3 Aug
 2026 12:16:44 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:16:43 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y] firmware: stratix10-svc: fix memory leaks and list
 corruption bugs
Thread-Topic: [PATCH 5.15.y] firmware: stratix10-svc: fix memory leaks and
 list corruption bugs
Thread-Index: AQHdH8ws2qaRYzhiVk6v45eQtPnPPraG7BaAgAVYNYA=
Date: Mon, 3 Aug 2026 12:16:43 +0000
Message-ID: <2231fee4-4c25-42a3-bca1-1f123dc9ee92@altera.com>
References: <2026072955-anatomist-verdict-df3a@gregkh>
 <20260730023604.14996-1-tze.yee.ng@altera.com>
 <20260730203630.stable-0004@kernel.org>
In-Reply-To: <20260730203630.stable-0004@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|MW4PR03MB6921:EE_
x-ms-office365-filtering-correlation-id: c152061f-8469-4296-62c7-08def15914e4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|10067099003|56012099006|11063799006|4143699003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 NOj1CBfNA93K8pJAdNBxhjUT03jMah2ZQMxz0FM5b67KDJKOzvLKGVWPT9c9UCQaLpAt17bTDkSaheJZ75AYZEyGHh4+IZncq8UyBtofNh62XxKwCtmSmKd6NzuCI0WO2w1PbU4vpVts579hosOqCbsUiMtlZ0HVVaK4PKLQrYmXjYMYkJFQ32DRHI8SCt5bpNS3rbB8uYRPmUeT/PtfODqMm49T10UghGBw1rWpkmVXSQSW9WQcZrJ9UCY9P4RMkiFH2nkFVnG6ksMjW0Ct09CtBnP8jzuY/ee3D5pStvB+c9WWjxVQRm5uZfkk6DV6XLbOh0hBujzcMZ9GulOSR/qXhvbMDQdaxvdOjLZUzE0Wkp9m7CqAhJQW9Do4RLFkyky9Z5zpmjX1ink44xn/sTwBTOoBnOQFz22h85zxMBbJpPQjtvVqxPXil7QzWc9t3zB9mL2zURwJm88rsATFEEB+6s7/fEtMygUrBtu7J8WfEn8h+0yb+Qja/Xf2ocY2hOcokC+FGsY1yAgF9ue/dZj51Pm2kFnNucRELAwpde/3V1LOv0OIuViC9f4fCQyR5nmyH4P4stMAMlPVbiE7CTyGCqt+vn6m2CibxIMKv9oMYdcZLNnOouHB0JsPbR6G3UvGV35v3irPXp3wryimRMtfgif/1vZYikDKqSI3y6cbxpU6L7tNPFFKddygaJ7P1FUaiZwUfytHquTgL28tvQ3WiDSNfgyj3A6iFTUI2Aw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkptcGlGWnQ3OGwrTzNkTmZiSFdQeFQ1NUNNQ1IzVm9OQUlJNTdqWFpZNDdM?=
 =?utf-8?B?blFqYjA4T1c1Y3BGT21ONkQ4NjdSMUw1OUdDYnJndE80ZVYxZUFlNzM3T3BE?=
 =?utf-8?B?VGE0dWlKbEJqNUJnWldjRUNsaXBhMTBZdnY4UDJ1bnhrZnUwU0dSYjFJT0lp?=
 =?utf-8?B?TWFEdVhscFMvM2p6M1NnNU5IWjhmZE5OQ1FSektLb0dZNVExQWFWVGZTbzhk?=
 =?utf-8?B?N0w1ZW9aaWtPeFBlQi9UK2p0N2ZaeG5lQXFDamRRTlVCWXMzS2prTDUxVWlF?=
 =?utf-8?B?K0hxQUkzUEZ2T0pYWEF0cjZITXYwMHpKUUYzZ2tvQU10Wk41MWllSTQxdnN6?=
 =?utf-8?B?R3ZPU05Lb0c2ZmgrZ2xlNS95ME95ZnFSNG9FSDc1RDl4MmxQeDd4YkU0OFoz?=
 =?utf-8?B?czBEdDYyQ3dFY0JmWG5NNVdvTTgzeU1zei9rSW1rSVFFZldOWFoybnFlNUFU?=
 =?utf-8?B?a0Y2bzlpRzgreGN0OTNScVpSU3FrNzUyRXJJOWdWelgyNUxZU3diRU4rR0to?=
 =?utf-8?B?WEl2amowVSs4T2ZVRU41MW1HdHg0M2cwY2VGSG05ekNab3FrL0dmd25nT3RQ?=
 =?utf-8?B?NG91bW1Uem9rTUdhQ25RQVFNVFBhUkk2N2QySkdJT0REa09GMGZMd2R4cVdh?=
 =?utf-8?B?U3gyUml0enBjYlArc1BWbHN1eitLR0FRSGo3N3VhRzZQOHhucExNNHE4eHFR?=
 =?utf-8?B?YzBIR3RzUXhEWXVIVitlQWNKVm9FbzFVVCtTcU1tbFJxVURCVFVwOU5xb29l?=
 =?utf-8?B?YzZCQ3BRc1hndmw0bzhSamQxTFNuK2xkdVpWbXE5OEZiTXN1eFBwb205UmxZ?=
 =?utf-8?B?N3Z5My9BQXFuOFdWMjc2MG1jTXY2aWZSZUdrTWViM3VraTd6WFZra280ZFVB?=
 =?utf-8?B?di9kcEEzdVQ5N1VaSklWNkdCSlpTTGNTd1dmeUQvRGN5UEpNMStxUlJYdjFh?=
 =?utf-8?B?Mks5U05YQmUwMUhkQXg3VlRPUGpKc0U3ZjFjTnZabytmdkVmOEFtTWFLU05U?=
 =?utf-8?B?ck1CbHoyRWI5YXJ3Ty9wdTdZUEhsTjI4L1lEMDN5L29VdUdaMkk5aWVJMW5E?=
 =?utf-8?B?OUhPYUFmOFdqTklvV1FHRFo0dmJTZUdyUTZCWXF6VXJuOHhnU2p1TXJWNnIw?=
 =?utf-8?B?bWdlTmMvR2VNWUFFNDd1M3YvME0yYUFIVEdqRi9nVTZlYXVxUzRXV2dWR2wv?=
 =?utf-8?B?R3licDJmLzFRY1RUNnJhbHZ1eG9ZZlpjYzYyUVJxcWwxaytjUVdTWEVIVHM0?=
 =?utf-8?B?YVF4dHo0cGdwMDQwbFR6Z1BoMU8vVXhyS2lNZ3lEOERwWThUOUw0MnprRzlk?=
 =?utf-8?B?SGdZY2Q5S2x5RkhkUWNCMXhqaXJvNzIzU28wVGtMdE5TYXVQdjNnd2R4NHpH?=
 =?utf-8?B?TXpveG8xcUUzSTdad1NyQVlsaFIyelZ6VDBJZ2U0enVYWGdyU2kzQVdraGQx?=
 =?utf-8?B?ZVlQY2QvQ0QxRU0rMUdNYkIzczlHQ2dWaUpTaFh3RXNHK3BPNHNEdkIvKzBv?=
 =?utf-8?B?dGEzSkRlUE02cVJBMDIvY3lEZEl1OHlUTXMxQkpFc2o5UG5hMGlkOWRlV29B?=
 =?utf-8?B?SlFXRlMxWXgrTlBCWHF0ZUZDQmZ2djMrcmlnTUdRTUM0cWpidytXZ0VnZVVl?=
 =?utf-8?B?S0kySHEyZkdEcC9LSVRYU3NBTnlYOGJiRWZnTVhLejNtQkoxMloyZ1lWdlNh?=
 =?utf-8?B?MTVnZVVhM3IrMzJXeWRtdUlQTmo5R0FmNk5TcVpvMDNQdDJUbjR1NVhmYTE0?=
 =?utf-8?B?TlJSakJBQmpObGtYNCtPcU9kMStlY0dHckluNUsxdjVRbmNlZkdKcUdQMEp2?=
 =?utf-8?B?d05QMlBaN3RScmU2ZGhTem5wVjRNVW1Wa1JIRVA0MXZwM2hrblFWZXlzUXRI?=
 =?utf-8?B?aWlIL0ZzQlFFdjB0VjB0bWU1R0N4VWlSV1d4dFA0a3hMeEhRTmpqanFqMnJR?=
 =?utf-8?B?Um9PMVg1Y0JFMnZEK3hGSGN2bDNYMXJKMXFPZTFNTXhyT3hFVFZFSVFlZ3N3?=
 =?utf-8?B?aForbnlxb1pOTTNMMTlwQzVRYmFKNFBMaGJvZHM4U2E2K1ZEd0lNL0hCRmZo?=
 =?utf-8?B?YXVJRkxJcXdFYzNQOWZvYVJrNVg5OWt3amlvZmwyNzBKeHB6VVhWS2JaZUg2?=
 =?utf-8?B?Qm5SLzJEcS9jWm5vbSt3dXhHWTNPaUVtZW9naC9EL2hCNlFCYTIzbEh4ZGdB?=
 =?utf-8?B?TVZ1Nkh5U2RQeEJ5Mm82bXdYSnAxREpKenVWcXNBKzdXM21jaGRLZzhDd2RG?=
 =?utf-8?B?SGZFRXhJcVAxNjNEMVBONUpmMmF4ZmJucjZCV2ZreHBKRlVIbVh2aEZvUzRp?=
 =?utf-8?B?ektVQmhETUJZT0ZVeVNqTUxVZlR1aWhUYjduM0NkY2lnRW1LVjkzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E54747F27FA3345AD5F0FA1EFA026B6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c152061f-8469-4296-62c7-08def15914e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 12:16:43.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7Ay6suDm27F/GPoKlbVCcFSiJmH1Z/iwj1IlXxO/PsYNWAjOJKKAelvAAnym6kCvgvmxmHMVjD94uIQk7Y2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6921

T24gMzEvNy8yMDI2IDEwOjM5IGFtLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4gW1lvdSBkb24ndCBv
ZnRlbiBnZXQgZW1haWwgZnJvbSBzYXNoYWxAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMg
aW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
biBdDQo+IA0KPiBPbiBXZWQsIEp1bCAyOSwgMjAyNiBhdCAwNzozNjowNFBNIC0wNzAwLCB0emUu
eWVlLm5nQGFsdGVyYS5jb20gd3JvdGU6DQo+PiAtICAgICAgcG1lbSA9IGRldm1fa3phbGxvYyhj
aGFuLT5jdHJsLT5kZXYsIHNpemVvZigqcG1lbSksIEdGUF9LRVJORUwpOw0KPj4gKyAgICAgIHBt
ZW0gPSBremFsbG9jX29iaigqcG1lbSk7DQo+IA0KPiBEaWQgeW91IGV2ZW4gYnVpbGQgdGVzdCB0
aGlzPw0KPiANCj4+IEBAIC05NDQsMTYgKzk0NiwxNyBAQCB2b2lkIHN0cmF0aXgxMF9zdmNfZnJl
ZV9tZW1vcnkoc3RydWN0IHN0cmF0aXgxMF9zdmNfY2hhbiAqY2hhbiwgdm9pZCAqa2FkZHIpDQo+
PiB7DQo+PiAgICAgICAgc3RydWN0IHN0cmF0aXgxMF9zdmNfZGF0YV9tZW0gKnBtZW07DQo+Pg0K
Pj4gKyAgICAgIGd1YXJkKG11dGV4KSgmc3ZjX21lbV9sb2NrKTsNCj4+ICsNCj4+ICAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5KHBtZW0sICZzdmNfZGF0YV9tZW0sIG5vZGUpDQo+IA0KPiBUaGlz
IHdvdWxkbid0IHdvcmsgZWl0aGVyLCByaWdodD8NCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gU2Fz
aGENCg0KSGkgU2FzaGEsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gWW91IGFyZSByaWdodCDi
gJQgdGhpcyBiYWNrcG9ydCBpcyBpbmNvcnJlY3QgYXMgDQpzdWJtaXR0ZWQuDQoNCmt6YWxsb2Nf
b2JqKCkgaXMgbm90IGF2YWlsYWJsZSBvbiB0aGVzZSBzdGFibGUga2VybmVscywgYW5kIHRoZSAN
Cmd1YXJkKG11dGV4KSgmc3ZjX21lbV9sb2NrKSBsaW5lIHdhcyBhY2NpZGVudGFsbHkgaW50cm9k
dWNlZCBkdXJpbmcgDQpyZWJhc2U7IGl0IGlzIG5vdCBwYXJ0IG9mIHRoZSB1cHN0cmVhbSBmaXgg
YW5kIHNob3VsZCBub3QgYmUgaW4gdGhpcyANCmJhY2twb3J0Lg0KDQpUaGUgc2FtZSBpc3N1ZXMg
YXJlIHByZXNlbnQgaW4gdGhlIDUuMTAueSBiYWNrcG9ydCBhcyB3ZWxsLiBJIHdpbGwgc2VuZCAN
CmEgdjIgcGF0Y2hlcyBmb3IgYm90aCA1LjE1LnkgYW5kIDUuMTAueSB0aGF0Og0KICAgLSByZXBs
YWNlcyBremFsbG9jX29iaigpIHdpdGgga3phbGxvYyhzaXplb2YoKnBtZW0pLCBHRlBfS0VSTkVM
KQ0KICAgLSBkcm9wcyB0aGUgc3RyYXkgZ3VhcmQobXV0ZXgpKCZzdmNfbWVtX2xvY2spDQoNClNv
cnJ5IGZvciB0aGUgbm9pc2UuDQoNClRoYW5rcywNClR6ZSBZZWUNCg==
