Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB463E1CE8;
	Fri,  2 Oct 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942717; cv=fail; b=otwmOTA7Tr594SpOgC7rvjAK+dGf21CEnI0x8fWrsYMCpHZkhbIa+xp0NWAhl6V/qEyxtF9VjDnzY6YUQnBYKzR7Vep5mSEda4l5yE1mgVfKnCJJI0LSk03jomCsYJ3TmyvFNMfN2PDw6cxkCCjaprn58PsvK6RB96nO0bKaGsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942717; c=relaxed/simple;
	bh=xryLd8eMsrOi8aycrTBuHiV6cPfqPZXgFWiwL6W/s6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uisdH8jWF7r4dYRX6wSzPG6sQTz8dv79KQYtRYc4OeOPQgA2yQoG05FgJQq9SegzpgyiGCIsWIZiQTXkR4y0kGre7aI5cnIAoRBDYtfkWg9+T2UB2yMtU1t/nukFdnKFq3rddySPLE/KaqR5CK9OKjN2cqRSPoI21eDB+irOWag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=g4x/FxiA; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="g4x/FxiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CodrVAxUqHIPMWtywCEES11xNQvDKeLH1ywjqSTu9pv9f8YLyOlpgH/dwRBacTmlKgYPBTETrRjALLslTVPhq85JJBDSmw5aBzSMiexdhDXckOoWAhB5NDw68qYphijik9GRFi6ilS/fe0tMni2bUe2DMqsvcThqBAoiShK1zFRFbkfQtTr0cOifJyDj6aFCIeu5SAs4X1ILV8EOxIbYOsJk2/DjF4Xew4VstBWBGK8B0E+CNi2YrmU1ryXv9JBG4ggvKQF2kNmgXekPNBgtb0n7STtIcyG+nkWKWTo4d/e7+mf3Wco2/Hu40DH3fttZ3+f40HxZlQzfA7jWfgw28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xryLd8eMsrOi8aycrTBuHiV6cPfqPZXgFWiwL6W/s6Q=;
 b=pHdHAr2VZRMZTuDqA4cGpvGOW495h+bx5v5vDVo1vaS5ueEyWqczCoyX4SS2SPph7MpYMNG5yTrpGGcroYkIo3d8R6aaRYmn9SHxIsxRr3ClB0G6b71r5fw4/OTxHEJvkKCNLqSO/xZ2tFHIySgkMreFIFZ3TkKxrBpD/2iyTvKg7aWwiWlT6exSKYd6IeHbFf2zxBw0VOQU/isJabAEcPfBJeZbmL2zz7WBNsozHSSF9q0cM4pvVbWuI9+jn/PagGhYHc4Bdg27d28JnV5CL3UPLloJhrDQOOMkGVhd6cOj+ZyVWqYNRqhSSXb3ta5VZp8jsGkZW57XRVeJ0sRS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xryLd8eMsrOi8aycrTBuHiV6cPfqPZXgFWiwL6W/s6Q=;
 b=g4x/FxiA5S23Z1S6MCRWB5QxmkYlkPwZadp8+KKe8gaE3fgTZm7mA5W9LZiKK/zA+23h01s+wxDKimsjlAa1sY/+e1M1CAwAj4/a+sxpwKJt4D2l7N8SVypw48PXoHD8ZKSqba3pStkqvvdmDmmHUZg4YtNfjPb3BJfzZJVA/ZOa0k5lS60Il9p9Tp6NSinca/KfF7cMAE5kqWw4/wmrLCZRXSQF7MS40sDRbRMc2mylxZ5vwxEOwzZdYpksPeRkwrABoKesE1s0Qscw40jJ+gsvpyBKMhQUS+7nkgeox4ulGH5NfE9Aql2l67mnHDzoIbcgt0fFUsJhWoTikASvDw==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by AS4P189MB2230.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 12:05:11 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 12:05:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"Jeremy.Jean@oss.cyber.gouv.fr" <Jeremy.Jean@oss.cyber.gouv.fr>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Topic: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Index: AQHdUNL4fDoo4smfgkOZ7OF8xZd6FLbpkdaAgACYF9A=
Date: Fri, 2 Oct 2026 12:05:10 +0000
Message-ID:
 <DU4P189MB3750DC372FE007A967A8A266C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179090984112.434549.12939052372850275600@kernel.org>
In-Reply-To: <179090984112.434549.12939052372850275600@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|AS4P189MB2230:EE_
x-ms-office365-filtering-correlation-id: 1a2c0bbe-8df3-40a7-03b8-08df207d68ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 +M+NMIY5xZtbfpvKZdX0ClyHyuZfxdUfN66XD/F0afPGooL2xBDxyDmRlmH/n91+aEnFjRWtJnMMVtjfWkl5smaI9qAvGSxqNI5WzMJ5SjN32SG7jw8t7EHfbWqweMNLCnrv5akXOHEYy5Qo3gvKDwEspBIrWJDgQIP2LhEjXLUKeDyGhagoVWALRfcQn7NaRZcsEX8LoDvKFIUsaKrPa4DM8LALLWfQtcQL/LOaOpFTvW7HdmgGPboKCBAVSlAxp5jV1wY09fUPIhfNw1gwDDUgf/2s+TjZ7lm3B0ArB1YAtZew8ws62MJ9dBJxO0XaW59ozKfF51GcbvzQ5Qk/O+Tp8ejZZCopmUV8d2NX1rxj1hPnByIBs2CJaKQSjaw3ZA/D6tI48wxmnzRPed4jZCVT/q3JYJxtVIHGPik73lAjsaYy9mulZ5NFJEECE5PAZX81MQ/6HI18wOA/trJUD6IjMr83p6mjHqaTk9PZKkSeSa5JlsD58NNnpXQmm0nW9HEnK9lJb0//kK9ZJD7yXDUNTXI9jO0EeUz0jx2e30J94uhRX6Xa4G3eBq3S48ZjELQ1NOcnx8imXDycZllDlHpFUqAETphR3pfpf2tJHgIWqPdYQJJeypXdmiHihsWdVhWVA4+zKuKO4T/Npw7XH4qL9NXAqDFUYkv31H4dLJSnt6VTUdrptIOdP3R24FW3pweQBtuhLDIF+aUKLfDngD/q5HV8UR55GKBQ5quW9HQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eG5DU1lacHY1K25KUVFuV0RlbDZUSlpQL2xpRVVneTlGeDdlQy8rL21neTdk?=
 =?utf-8?B?cnVzbGk0alAxcEpYWjkyVlpQLzM4MUQxbEt2M2VBdkZXT2Z0QTRlSC9jdlBk?=
 =?utf-8?B?VjNhdWtrWEtKZDd3eEp2YjFZZnpYU0NWSldHSkxlcFFjbWxzMVFjNE1DZ1Fs?=
 =?utf-8?B?K0VtaDZCR2psNGxOR2lWaE1FbmpyNVBvbHJmZ2tGR2NBcE1LU0FoVFFQOStG?=
 =?utf-8?B?WG00UXg2YjM3SUhkK1cxN09QSXJ5SFcxSkJIRDE1Q1A5Z3JiT1R6VDVtY1k3?=
 =?utf-8?B?d1VVWmV0NkI3QzlRNnMwdUJOY2pTWmE0dTFXbXNERjdtZEpmSjU5NUYvajJU?=
 =?utf-8?B?NXBqZHozRGx0aGFOcmlwS2JJVUlnRXkra1pBYUV6MlBWNFpNVmpzNVk1UUxQ?=
 =?utf-8?B?OGVHeFN2cXJHZm5hUVR5dU5LaHpGMXh6MTYwR1d3Z1V1ZGs1SGJKUkNzNWJS?=
 =?utf-8?B?Y1M1UW5LR1Q3ZXhYbjhzVE9OaFdaNXgrWTVUbjAyQnk3MEtDdFhjUDFxVEpq?=
 =?utf-8?B?Uk84NVZPcWRHOVZ4cEN3Ti9OWkFZZWltTkJtUmtBaU56UzY1cXg2N3c4VTRj?=
 =?utf-8?B?RjZ3TUlaL21kcFVjazVETnp2U0FnbE1hbVQza25vU1RWY3FIdG56d3dzaFEx?=
 =?utf-8?B?bE5LNTBBSG52SjNNU0U4cERFZ3ZHbEQvYlNldFV4VUFDK1VDY1d6U3BOQXdJ?=
 =?utf-8?B?anFOTjl4NFRLTXMvWEtYb0lmNTJ1eTJaNktDNDB3WXZnMVlTcEtJRm9iTEVw?=
 =?utf-8?B?NjZBZGQxOUdqd0J5amx1M3E1R3BQT1YxU1VMVTd0VHlXTDVCaUFaUmlwdkhD?=
 =?utf-8?B?QUlwNFhuVDdrT2FDbWJpZlR3MDhZVC91TWFqa244aVVkYXZZRVJNWWpMbUgy?=
 =?utf-8?B?ZGhQL0lGMkJkd01iSktpRld4alJBQnUzZENjQzJkT3dsYjJNcWU0TkhmRUJN?=
 =?utf-8?B?TTZ2azJhRDRaSkl5bksrYXNRbVh4am9FcTluZWhwYUkzSmhnK2N5TnlIcFI4?=
 =?utf-8?B?NC9XaGVrZ2kwa3dHS0IrNkt4UlRWZ2lRb0xkUURDZFlZRDY2Mnk2WEtUYll3?=
 =?utf-8?B?NjR0alpQdEEyb1NyUFdmdUZ4ZXlPMkhGa2QzU1dDSGJPeTdzUUx4UVJidjZE?=
 =?utf-8?B?dDZqT1A3dGpTQ2drdW5SbmZEYzByaXhhRDVsRkMzUXdYc3NpcHh0TlloWWdX?=
 =?utf-8?B?cUtTT2tudXpCUXRXT2VJWW5NZmc1RWdjcUVudzdBWTBpQjh6Sm5JTTRBUHBE?=
 =?utf-8?B?WkRWUGYrMnZVOFN6Z253L1pnQWt0Rjl3SmhoVzZyRHF0dVlxOE9EMEFycGJO?=
 =?utf-8?B?NURCeC9icnR1UzRkWnNYRFBmYW9RaEIzVkxhOVBQeWlwNzhXR2FLcHIyUGk5?=
 =?utf-8?B?OUs1OUxsR3U2UHlsQWhxTjNjWWdWMUg2Zm96cFQ0WjNZUmVLaHRpa1RXT3dl?=
 =?utf-8?B?T2tZY0pzT2tNOUlPbUlJQ1lSbStTWFhmS0hyT1BBL04vZ2RRZm1Cdm14WEYv?=
 =?utf-8?B?THpYQVZSSmhweSsrbktmQWdsOGlramlVL2ZJYy9IV3U3Mk8zWjVoZFdaYXVm?=
 =?utf-8?B?MzJ2ZFd6TW5oOXhnQit0Zkl6dE01Q0hreFI4NWpsSER5NW55WTlnSDNnVUpv?=
 =?utf-8?B?UDExRlJ5bkI4N3pWNVBsdEpjUzJrazFaQlJEZWwvWGdjVlM3a21tNG9QeEl1?=
 =?utf-8?B?cVlMZFpoMktZL2JCckpma1BIeDZqeUpnM2xOVFA5RDdDa0RnZTk0N2MvU2Np?=
 =?utf-8?B?SnhKOHV5YXVpOGhUTmNiM0Nac3dnWExRNFlqbXhPaWUyOWNETU43anluajdk?=
 =?utf-8?B?cTVlTDBLQm5wT3ZLMlZOQWxtSHJoKzQxeUUraG96bHh5MS9WcWljZmtCbGxy?=
 =?utf-8?B?a1VWU1pvV1RoRnZOcHBSbGpNd3hkM2JFNUtnTXJ2R1lSSEpxYTNYeFdiejB4?=
 =?utf-8?B?ek01b2FxbmRJZmFCemJybmZFMWsvWFpDVlRxSWdvd29zYTZKS3kxZ09HVXBi?=
 =?utf-8?B?VE8wWktwa0IyREQwMHVCVU1Ea1NzRm1qNng5bU1KZ3JtWmlHSzlheTlvUHdD?=
 =?utf-8?B?cFRJdFMrZ2NWL3JRSk1OWkVkM3BsNFZsYTRhdm95NU4wQUJVYk0vVjArbTZB?=
 =?utf-8?B?Tks3bnNZRGRSMkQ3TXpsUjFpdTlkVlJSeGUzblRHYUhnNUpJWDVLZVI5TGcw?=
 =?utf-8?B?OExYZENoNkNjazVCaExoaWs1L2pFalFjWWVzdVpDM0hjbmppSlVQNFVwNWhp?=
 =?utf-8?B?ZzNkdXpCWC80SmhKTDJyR3NEUTJXVHBFYlNUaDJQVlJoTDhZQVlIczJENzdn?=
 =?utf-8?B?MyszTzlGZWsvZUR5OUNTUHczcmt4azM2amdzWFVMMnRVMGthVmN0Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2c0bbe-8df3-40a7-03b8-08df207d68ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 12:05:10.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcp5Baj8fmo5vC4wsdT6RRtM0NTZqbYqa+t0weZc/GO4EKXiEtZjWGA1+IaSGTtPbn9oNvOeC0T7rnWjV2OGEeT5CvBnC8ZgjjuZJa2gzTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2230

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSB0aXBjOiBwcm90ZWN0IHJlY2VpdmVkIGtleXMgZnJv
bSBjb25jdXJyZW50IGZsdXNoDQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEg
U2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwNCj5pc3N1ZShzKSB0byBjb25zaWRl
ci4NCj4NCj5Dcml0aWNhbDogMCDCtyBIaWdoOiAwICgxKSDCtyBNZWRpdW06IDEgwrcgTG93OiAw
DQo+DQo+SWYgeW91IGJlbGlldmUgbm9uZSBvZiB0aGUgaXNzdWVzIGFyZSBsZWdpdGltYXRlLCBw
bGVhc2UgcmVwbHkgdG8gZWFjaCBpc3N1ZSBvZg0KPk1lZGl1bSBzZXZlcml0eSBvciBoaWdoZXIg
YW5kIGV4cGxhaW4gd2h5IHRoZSBBSSBpcyB3cm9uZy4NCj5JZiBhbnkgb2YgdGhlbSBhcmUgbGVn
aXRpbWF0ZSBhbmQgeW91IHBsYW4gdG8gcmVzcGluLCBwbGVhc2UgbGV0IHBhdGNod29yaw0KPmtu
b3cgYnkgaW5jbHVkaW5nICJwdy1ib3Q6IGNyIiBhcyBhIHNlcGFyYXRlIGxpbmUgYXQgdGhlIGVu
ZCBvZiB5b3VyIHJlcGx5IChvbmUNCj5zdWNoIHJlcGx5IHBlciBzZXJpZXMgaXMgZW5vdWdoKS4N
Cj4NCj4tIFtNZWRpdW1dIFRoZSBwYXRjaCBmaXhlcyB0aGUgcngtPnNrZXkgVUFGL2RvdWJsZS1m
cmVlLCBidXQgdGhlIGZsdXNoIGl0DQo+ICBwcm90ZWN0cyBjYW4gbm93IGJlIHNpbGVudGx5IHVu
ZG9uZS4NCj4NCj5QcmUtZXhpc3RpbmcgaXNzdWVzOg0KPi0gW0hpZ2hdIFRoaXMgcHJvYmxlbSB3
YXNuJ3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgYW4gUlggZGVsYXllZA0KPiAgd29y
ayBjYW4gcmUtYXJtIGFmdGVyIG5ldG5zIHRlYXJkb3duIGhhcyBmbHVzaGVkIGl0IGFuZCB0aGVu
IGZpcmUgb24gYeKApg0KPg0KPi0tDQo+DQo+dGlwYzogcHJvdGVjdCByZWNlaXZlZCBrZXlzIGZy
b20gY29uY3VycmVudCBmbHVzaA0KPg0KPlRoaXMgcGF0Y2ggYWRkcyBhbiBza2V5X2luX3VzZSBm
bGFnIHRvIHN0cnVjdCB0aXBjX2NyeXB0by4gVGhlIFJYIHdvcmtlciBzZXRzIGl0DQo+dW5kZXIg
cngtPmxvY2sgd2hpbGUgaXQgYXR0YWNoZXMgcngtPnNrZXksIGFuZA0KPnRpcGNfY3J5cHRvX2tl
eV9mbHVzaCgpIHNraXBzIGZyZWVpbmcgdGhlIGtleSB3aGlsZSB0aGUgZmxhZyBpcyBzZXQuIFRo
ZSBnb2FsIGlzIHRvDQo+Y2xvc2UgYSBLQVNBTi1yZXBvcnRlZCB1c2UtYWZ0ZXItZnJlZSBhbmQg
ZG91YmxlLWZyZWUgdGhhdCBoYXBwZW5zIHdoZW4ga2V5DQo+ZXhjaGFuZ2UgcmFjZXMgd2l0aCBr
ZXkgZmx1c2guDQo+DQo+PiBkaWZmIC0tZ2l0IGEvbmV0L3RpcGMvY3J5cHRvLmMgYi9uZXQvdGlw
Yy9jcnlwdG8uYyBpbmRleA0KPj4gNDQwOWJkYjcwZmU5OC4uZWFiMmE2NmUyMjMzMyAxMDA2NDQN
Cj4+IC0tLSBhL25ldC90aXBjL2NyeXB0by5jDQo+PiArKysgYi9uZXQvdGlwYy9jcnlwdG8uYw0K
Pg0KPlsgLi4uIF0NCj4NCj4+IEBAIC0xMjE0LDggKzEyMTYsMTEgQEAgdm9pZCB0aXBjX2NyeXB0
b19rZXlfZmx1c2goc3RydWN0IHRpcGNfY3J5cHRvICpjKQ0KPj4gIAkJcnggPSBjOw0KPj4gIAkJ
dHggPSB0aXBjX25ldChyeC0+bmV0KS0+Y3J5cHRvX3R4Ow0KPj4gIAkJaWYgKGNhbmNlbF9kZWxh
eWVkX3dvcmsoJnJ4LT53b3JrKSkgew0KPj4gLQkJCWtmcmVlX3NlbnNpdGl2ZShyeC0+c2tleSk7
DQo+PiAtCQkJcngtPnNrZXkgPSBOVUxMOw0KPj4gKwkJCS8qIEEgcHJldmlvdXMgaW52b2NhdGlv
biBtYXkgc3RpbGwgYmUgdXNpbmcgdGhlIGtleS4gKi8NCj4+ICsJCQlpZiAoIXJ4LT5za2V5X2lu
X3VzZSkgew0KPj4gKwkJCQlrZnJlZV9zZW5zaXRpdmUocngtPnNrZXkpOw0KPj4gKwkJCQlyeC0+
c2tleSA9IE5VTEw7DQo+PiArCQkJfQ0KPj4gIAkJCWF0b21pY194Y2hnKCZyeC0+a2V5X2Rpc3Ry
LCAwKTsNCj4+ICAJCQl0aXBjX25vZGVfcHV0KHJ4LT5ub2RlKTsNCj4+ICAJCX0NCj4NCj5bU2V2
ZXJpdHk6IE1lZGl1bV0NCj5XaXRoIHRoaXMgc2tpcCwgY2FuIHRoZSBzdGlsbC1ydW5uaW5nIHdv
cmtlciB1bmRvIHRoZSBmbHVzaCBhZnRlciBpdCByZXR1cm5zPw0KPg0KPk5vdGhpbmcgdGVsbHMg
dGhlIGluLWZsaWdodCB0aXBjX2NyeXB0b193b3JrX3J4KCkgdGhhdCBhIGZsdXNoIGhhcHBlbmVk
LCBzbyB0aGlzDQo+c2VxdWVuY2UgbG9va3MgcG9zc2libGU6DQo+DQo+Q1BVMSAodGlwY19jcnlw
dG9fd29ya19yeCkgICAgICAgICAgICBDUFUyDQo+c3Bpbl9sb2NrX2JoKCZyeC0+bG9jayk7DQo+
cngtPnNrZXlfaW5fdXNlID0gdHJ1ZTsNCj5zcGluX3VubG9ja19iaCgmcngtPmxvY2spOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGlwY19jcnlwdG9fa2V5X3N5bmNo
KCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmUtcXVldWVzIHJ4
LT53b3JrDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aXBjX2NyeXB0
b19rZXlfZmx1c2goKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
YW5jZWxfZGVsYXllZF93b3JrKCkgPT0gdHJ1ZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBza2lwcyBrZnJlZSwgcngtPnNrZXkgc3RheXMgc2V0DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGMtPmZsYWdzID0gMDsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGlwY19jcnlwdG9fa2V5X3NldF9zdGF0ZShj
LCAwLCAwLCAwKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGlw
Y19jcnlwdG9fa2V5X2RldGFjaCgpIG9uIGFsbCBrZXlzDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZjLT5sb2NrKTsgdGlwY19jcnlwdG9f
a2V5X2luaXQocngsIHJ4LQ0KPj5za2V5LCAuLi4pDQo+ICB0aXBjX2NyeXB0b19rZXlfYXR0YWNo
KCkNCj4gICAgdGlwY19hZWFkX3JjdV9yZXBsYWNlKGMtPmFlYWRbbmV3X2tleV0sIGFlYWQsICZj
LT5sb2NrKTsNCj4gICAgYy0+d29ya2luZyA9IDE7DQo+ICAgIGMtPm5va2V5ID0gMDsNCj4NCj5J
biB0aGlzIGNhc2UgdGhlIFRJUENfTkxfS0VZX0ZMVVNIIGhhbmRsZXIgKF9fdGlwY19ubF9ub2Rl
X2ZsdXNoX2tleSgpKQ0KPnJldHVybnMgMC4gVGhlIHBlZXIncyBBRUFEIGlzIHN0aWxsIGluc3Rh
bGxlZCBhdCBrZXlfbmV4dCgwKSBhbmQgdGhlIFJYIGNyeXB0byBpcw0KPnJlLWVuYWJsZWQuDQo+
DQo+VGhlcmUgaXMgYWxzbyB0aGUgcmV0cnkgcGF0aC4gU3VwcG9zZSB0aXBjX2NyeXB0b19rZXlf
YXR0YWNoKCkgaGFkIGFscmVhZHkNCj5yZXR1cm5lZCAtRUJVU1ksIG9yIHRpcGNfYWVhZF9pbml0
KCkgaGFkIHJldHVybmVkIC1FTk9NRU0sIGJlZm9yZSB0aGUgZmx1c2guDQo+VGhlIHdvcmtlciB0
aGVuIGtlZXBzIHJ4LT5za2V5LCBjbGVhcnMgc2tleV9pbl91c2UgYW5kIHJlLXF1ZXVlcyBpdHNl
bGYuDQo+cXVldWVfZGVsYXllZF93b3JrKCkgc3VjY2VlZHMgYmVjYXVzZSB0aGUgZmx1c2ggY2Fu
Y2VsbGVkIHRoZSBwZW5kaW5nDQo+aW5zdGFuY2UsIHNvIHRoZSBwcmUtZmx1c2gga2V5IGdldHMg
YXR0YWNoZWQgYWJvdXQgNSBzZWNvbmRzIGxhdGVyLg0KPg0KPlVudGlsIHRoYXQgaGFwcGVucywg
dGlwY19jcnlwdG9fa2V5X3JjdigpIHJlamVjdHMgbmV3IGtleXMgZnJvbSB0aGUgcGVlcg0KPmJl
Y2F1c2UgdGhlIHN0YWxlIHJ4LT5za2V5IGlzIHN0aWxsIG5vbi1OVUxMOg0KPg0KPglpZiAodW5s
aWtlbHkocngtPnNrZXkgfHwgKGtleV9nZW4gPT0gcngtPmtleV9nZW4gJiYgcngtPmtleS5rZXlz
KSkpIHsNCj4JCXByX2VycigiJXM6IGtleSBleGlzdGVkIDwlcD4sIGdlbiAlZCB2cyAlZFxuIiwg
cngtPm5hbWUsDQo+DQo+dGlwY19jcnlwdG9fcmN2KCkgYWxzbyBjb3VudHMgdGhlIHN0YWxlIHJ4
LT5za2V5IHdoZW4gaXQgY29tcHV0ZXMNCj5yeC0+bm9rZXk6DQo+DQo+CXJ4LT5ub2tleSA9ICEo
cngtPnNrZXkgfHwNCj4NCj5CZWZvcmUgdGhpcyBwYXRjaCwgdGhlIGNhbmNlbF9kZWxheWVkX3dv
cmsoKSA9PSB0cnVlIGNhc2UgZnJlZWQgYW5kIGNsZWFyZWQNCj5yeC0+c2tleSAod2l0aCB0aGUg
dXNlLWFmdGVyLWZyZWUpLCBzbyB0aGUgcmV0cnkgaGFkIG5vdGhpbmcgdG8gYXR0YWNoLiBXaXRo
IHRoaXMNCj5wYXRjaCwgdGhhdCBjYXNlIGJlaGF2ZXMgbGlrZSB0aGUgZXhpc3RpbmcNCj5jYW5j
ZWxfZGVsYXllZF93b3JrKCkgPT0gZmFsc2UgY2FzZTogdGhlIGZsdXNoIGRvZXMgbm90IHJldm9r
ZSB0aGUga2V5IHRoYXQgaXMNCj5pbiBmbGlnaHQuIFRoZSBjb21taXQgbWVzc2FnZSBkb2Vzbid0
IG1lbnRpb24gdGhpcy4NCj4NCj5Xb3VsZCBhIGZsdXNoZWQgb3IgZ2VuZXJhdGlvbiBtYXJrZXIg
aGVscD8gVGhlIHdvcmtlciB3b3VsZCByZS1jaGVjayBpdA0KPnVuZGVyIHJ4LT5sb2NrIGJlZm9y
ZSBhdHRhY2hpbmcgb3IgcmUtcXVldWVpbmcsIGFuZCBmcmVlIHRoZSBrZXkgaWYgYSBmbHVzaCBo
YWQNCj5oYXBwZW5lZC4gVGhhdCBrZWVwcyB0aGUgdXNlLWFmdGVyLWZyZWUgZml4IGFuZCBzdGls
bCBob25vdXJzIHRoZSBmbHVzaC4NCj4NCkFncmVlLg0KDQpwdy1ib3Q6IGNyDQo=
