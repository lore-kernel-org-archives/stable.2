Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020116.outbound.protection.outlook.com [52.101.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DF19D065;
	Thu, 16 Jul 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182588; cv=fail; b=O2PB3hzCJ1mT/gqPSqbO1IGt+F0GSgEraEVMCB5nb21ge9P9GkfSJ7/mrHq1ZUBkIuGQdqZbfELHkkcbq0jTO6J7JkVyPutLYF/cwI/7lIuM9+qhoDOFzneYXGclI5NH183tVSHbo1ipWjdML3R8sxjymfDwk6F+E8b56ACF+pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182588; c=relaxed/simple;
	bh=5rmKwX0xJhoYmX0v/UHhBAP/j+5LNsjMvnW97d7kOgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZgeYK9yi4D4W7u3Vki5Ja1txL3CdcPigN6hlRhmJFIktRvWXkhyPCOM+/sWdQYjycGpRvB78Aj8+3qi07/vcuUQ/5VvErFE731KANy9QMQEb6AosTR16CuIp1wjJJoFVZbr8a71AseFJ9anXdoclt4JocvrYiOwMdvDkt4Q2Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=I14mWX5X; arc=fail smtp.client-ip=52.101.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="I14mWX5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Fek8VHexxx+adUJ8pHNzVLY7aSJ0vWampKDqowXk9F8W1RcIg+20HnoVfRGvl7BXV6UBu3RgHvQwtV7D5nEcUVNypp7A+ZcoBYzPM92T0Ggv2d3uL4ZFHCZjmdgClDM1kbVaGUC+bSGZHePShaAXvJbagSTpXGCWmF8Dyh/vkjbpWeI8yaCxI3n/Ax9U18s1iEIirefsW7l/WicNKlKIQTMx/t+gf7kRFv9hQwUy4fmPhNBEA+4D6HsaN+ytyUfAPllqVe6w/GzxO1sb5FtVDoT7lv/UqzdG0Iy1UCksSxi6gFUPiOwWSDltrol44bwSmB7dTHtgh39dxJEc8WYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rmKwX0xJhoYmX0v/UHhBAP/j+5LNsjMvnW97d7kOgs=;
 b=VlyzpbFhfopL6xbiXz8Xth/Gx6ENejeBQ+IS7vaMI5qllEtSRYFYlzggCI27ppK3isRm/44nwyDXYFo2bHSEK81byuR5ZwQg2QUwoZRiNufPjswu7Tney9ApLWiEWC72uzOwmBMbRJlPtYgpFK8BNAs2PDtvykkgNphZzdTcsNqLOG3D84st12rQFpsfbIELnOA+wVGx3COrv7rDjYUMtC83lcbhx8j+ttmRbeD/cxhjCEB5b9x+It8oqZ2MMxxKoDwNULb0NxJI7WvgC0KkhH6FJBDpIGb8jDVrVc3L8gNUjZ8+CQNOkXF2zR8H9ZUScmMD2ywwut+0xP/r/mVEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rmKwX0xJhoYmX0v/UHhBAP/j+5LNsjMvnW97d7kOgs=;
 b=I14mWX5XGpyUSlWenrcD4qGMkf549hOqt58he164dOiyxl39cTHWR2TdLo1GHY0ZnqkC0FaUDjN3UZF1Chc247S7fpkMiAqzl13z0YnkXM3IR9xyrb/aJ/nX+6/rg2rTykF8ra8e95GMx4oHgru7l6mtEbXZJJNeILvIrKYGiG4=
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 SE1P216MB2140.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 06:16:21 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 06:16:21 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"bob.beckett@collabora.com" <bob.beckett@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lafley.kim
	<lafley.kim@chipsnmedia.com>, "b-brnich@ti.com" <b-brnich@ti.com>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1 7/7] media: chips-media: wave5: Resume device before
 setting EOS flag
Thread-Topic: [PATCH v1 7/7] media: chips-media: wave5: Resume device before
 setting EOS flag
Thread-Index: AQHdBQpJWkWJXeSNGkuAPTxndfpuHbZviL+AgABArSA=
Date: Thu, 16 Jul 2026 06:16:20 +0000
Message-ID:
 <SLXP216MB1148DF5041BAFB76663A3F3DEDC72@SLXP216MB1148.KORP216.PROD.OUTLOOK.COM>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-8-jackson.lee@chipsnmedia.com>
 <664e794362bc4123c7e20a51f50de4f4d0fe639c.camel@collabora.com>
In-Reply-To: <664e794362bc4123c7e20a51f50de4f4d0fe639c.camel@collabora.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB1148:EE_|SE1P216MB2140:EE_
x-ms-office365-filtering-correlation-id: 73e2709e-36b7-4c5f-ca7b-08dee301c152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info:
 OuNNvo/vW8wIlk+gjrnlc4X31D+pj8liJFARXdvSRh4pW+XOBCtSH182ALISyQmuWT6l/DfoFsM/lr8OxMAtxx4FcrQPuXZGUeSfsBzS+MdkJcbRQ0K88wzhzdvduiQF4/GjdpJGBeP2XUZg2LaVI8AcmSPab7ygnkIGR8w92jFOhhgxLIppgejVazHlobg35oNIzsESmLJc7nurrgdfXFUNZg7AwtPTq0If4E5s7s0DE0JkVQb/2LhLeRco0vOAJ/tNXPGAhSVpIhojN7/wiKV3Ix4br4ysKtOeJttGR7t1vO2Emk/BMHBi2u9haHbtT6JvrP+NLun7FS4zqTi+jBTDAppWWQilj0k219MiIIHMxZqbpLnRdNxXpn90si1nAiY0CJkvBNYCfLQdv5MR+J+Uqajgo8B4ydtmedlLcZwHfXRsDFrtA1i2Bvhq1ugIBA/wx5vtggtTSie3J+JML7zme0rW9GpAB2ga7ASU2hLems0mAOjUkzzpaykcErW0ECHxUpIxIwurZc+DTH5ejfiW3H/sQ9XwsrM79v+/AEi2AGkJvvxsTpk+yxn8ukgDrvi/paLQVFs4zphs77DN9jyPYO+HJA0TQx2m9UUmxZIzGAP/eAHTLTx7NnGXLa17FwFVtmKO5N2y6R5dXXxAWRWX7sSji5SpXON2IvdmeFeH5LUn6RBqdJQNeA1fzyBksSecO7qD9IFMVU3NfW8dWh3GlKNcyE5TtFzEP0oY9w0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVY5MFNsRXcvT1dQN3lUcm5rRU44UGJmN0E2am51K215TjlJM1BmL0xJQ2ZT?=
 =?utf-8?B?ZUp1YjJMTytPZFdBdGxRYVpjZjNFUWkvQzBWY0piTzd1NXlHd0lqTjI1R1ZL?=
 =?utf-8?B?R0xGSnpKQ2ZubDc1ZVRKS0ZJcXc4QXFBTzBFMFVSbjRjWVpaSEE0QnNRVVVy?=
 =?utf-8?B?NHVVM3dIeVNhT0wzMU9UcXFXQU8renRDUWNpamtZZWdCYWdpdFpDQi9qVUVa?=
 =?utf-8?B?Y0NTOWZzaDJzb0tMWlJzaUpDaFFkWHo4S2FzVXhyRTArMCtvQnFxRzZSOTlN?=
 =?utf-8?B?VmxBZU1xWjkzelpDbUNzM1lHUGdNNUVtR3lwa1ArZU1CRW9jZVZXaXFLbGdP?=
 =?utf-8?B?QUJHOW54blEwTlhpdmJjRlQ4Zm4wNDRaekJRSlNtTVFvOUc4dXFiYXplSUlD?=
 =?utf-8?B?K2RqaVRwTzNxdGFoWFhWSFB5ME9hREpPZktiT2xEaGVtNHloVTIyR3hIVlVn?=
 =?utf-8?B?Z2EvcmI0d1RzdWw1VE1SRGNRRURrazkwMC9RYnAxNHdQZzBLNHBFNFZFWlNu?=
 =?utf-8?B?bnArN1lZVStvbldWMXpBZFJFUjE0L2YvUDZKVW1oY3V1VFdDNzdpb2lhVFZQ?=
 =?utf-8?B?Ri8xK2tqNS9sNDhLK2d2RHpDdjBDQlFBQ2I5cXdoeXlIRDBjVC9QQ1ZrU1VJ?=
 =?utf-8?B?K1NGcUMzTWNoY292dVZWSlQ2OUNqdU9TNmt3MXp2N3k2bGtpb01xSEhpelh0?=
 =?utf-8?B?NVBGR0hteXRzbFl6UmdmcFNRTlFtWVNvNTQ5ZTRyeXo3ZzBWVkZvYmQ4eXZs?=
 =?utf-8?B?U0E3WGdwejlDMGUrQkQvOERlS0g1a3lJb3BKV1czbGNzSnlCVHVWWVNiblp6?=
 =?utf-8?B?QkpLdzAyRUdPTDVCSkRkUW5PR1Z1d3A4VHlYSEFLTUhvWlpBQlhsWHpjbDRQ?=
 =?utf-8?B?VXRqMVRZdDhzbGdZc1ZpZGVHS01hcjhPQXZsSGhSU3BuTnBKcU4vWk5VSkQw?=
 =?utf-8?B?YTM3dm9DY1B5T3VMSGs2ZWNIK0JxK1FvVEFWZDFmRWxkcU1WT3FsbE5oUnRT?=
 =?utf-8?B?Ri8rVEV1cW1IZStXbStXOUFHMVZEd09WRG5BSVRuNFNTSmFQZEhNcm9xdUkz?=
 =?utf-8?B?UjhPSDIxdUJFcnVCVnVFNnBzUGlTdnZXbFNFbTNqVjFpc0F2UGU1TU1zM3lw?=
 =?utf-8?B?RUxWVEdKV1c4SHFQQy8xOERodGNPNkQ2Y1lraXBWV0dqMXVkSVJoVlRJaktK?=
 =?utf-8?B?d1FoQ25wQmM1VkcvdEtmS1JHaTZ6SE9pUmJJL1RUazBNVFFaOGNFejhLZVFq?=
 =?utf-8?B?bDZxbE1pcm56VkNReG1tT1dqN1FHVEV0dUhYNGlOTzdiU1VoOXRXdTNkZmgy?=
 =?utf-8?B?azZRTU1HdFR1YndxUFdnN3FCRDhEWW5adGhVQnlVSnJsQjFnOWNQQS9URGww?=
 =?utf-8?B?R3lJeFpieXBzZ1dRUW9sUkhTVm5BYXhhMlZhaU9EcXArT3YwaWlDUHJFRlJS?=
 =?utf-8?B?RVVwZjQxdDJ2MmZpN0l2S0taOUZWY21iZDRLK2hMa3RPUnZ4SG1SRndHTWQx?=
 =?utf-8?B?a1ZOd3ZlN1FOWG12RHBaUjZBMUNWazloOUpFRWpaUVA1WTBQUFlGemlBcGk4?=
 =?utf-8?B?UnNqK1NjOEJlajV2elplYWU4MWIzb0IycFMrYi83c0hISjRJQld2QjNETlYy?=
 =?utf-8?B?UHhEc1Y2TmRtNE1WOVFNL3pONWZHcExSdS9Ua01ha1BldyszSk1TMDhYQ1Zh?=
 =?utf-8?B?ZDJuMk1mV0wzOEI3UkxTOFdGOFNTcW5jV2NpMVVRNDYrUjlJK25zUXJvcVdX?=
 =?utf-8?B?b2tYZUhBbTE1M0pmYWlSRWlJd24wRGZuY09GUXRhaWMyRFJ6RmZPdzdsaFRP?=
 =?utf-8?B?bXl5V3pVdXpRZE9EKzdjSFF1eGZ1SmVHSmp1WVY5M3J1K25DSGpNWUdnTFlp?=
 =?utf-8?B?MU5tK3ozVG12b1k1NHZQQUxMUGFYd0gxdTlURk12Z1FxaDY5WXZxSEgycEhz?=
 =?utf-8?B?T0VmUmUrbmhDNk5jM1FGRy9Sd1RVSU9IQk5ML2NzN0prRHF5OWdWVzlYaXhG?=
 =?utf-8?B?aFgxbkI5a3VCVklrczduazF2akF5c0RWbnczT003OGZsZURoTEQ2K2dHUFda?=
 =?utf-8?B?SVVycWJNYktzblVxZExPVE5NK1VpRmRsbDdnVGk4SDNDdXcxOUwwQmNiK0c3?=
 =?utf-8?B?QUZaaGJGNTJwUXJROGVjSUhpVllsLzFyaHczL011a1h1RVgzT3NmSWo0SkdV?=
 =?utf-8?B?ZmNvUDhFdHZpeDhmajl1YmlOMFlaSjhhNTNLQUovTS9nc0pqR0h1NHNKOW1o?=
 =?utf-8?B?Ry9TY2JObGZyZ3U5Vmd1VS9YUTNRSVVCOEV6UlBOa0lDUUJqWkhpMlA5eVJ2?=
 =?utf-8?B?Y3JlUkFCTVlIeHJ4R1IvOXdFZThIeDRwaFErYkxCd1ljUVZ4MytCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e2709e-36b7-4c5f-ca7b-08dee301c152
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 06:16:21.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4ZWBX2dn3/bhK38tF6D2hF+CisbyLCEv8R+i/RWQHdJ1j4tltlgvUD6kDB/W54UTZBisX9nQoDuCH0F+R9FI87dukzWGVummh4y7ohbkfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2140

SGkgTmljb2xhcw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pY29s
YXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bHkgMTYsIDIwMjYgMTE6MTkgQU0NCj4gVG86IGphY2tzb24ubGVlIDxqYWNrc29u
LmxlZUBjaGlwc25tZWRpYS5jb20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+IGh2ZXJrdWlsLWNp
c2NvQHhzNGFsbC5ubDsgYm9iLmJlY2tldHRAY29sbGFib3JhLmNvbQ0KPiBDYzogbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsYWZsZXku
a2ltDQo+IDxsYWZsZXkua2ltQGNoaXBzbm1lZGlhLmNvbT47IGItYnJuaWNoQHRpLmNvbTsgaHZl
cmt1aWxAeHM0YWxsLm5sOyBOYXMNCj4gQ2h1bmcgPG5hcy5jaHVuZ0BjaGlwc25tZWRpYS5jb20+
OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNy83XSBt
ZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBSZXN1bWUgZGV2aWNlDQo+IGJlZm9yZSBzZXR0aW5n
IEVPUyBmbGFnDQo+IA0KPiBIaSwNCj4gDQo+IExlIHZlbmRyZWRpIDI2IGp1aW4gMjAyNiDDoCAx
MDoyMiArMDkwMCwgSmFja3Nvbi5sZWUgYSDDqWNyaXTCoDoNCj4gPiBGcm9tOiBKYWNrc29uIExl
ZSA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29tPg0KPiA+DQo+ID4gU2V0dGluZyB0aGUgRU9T
IGZsYWcgdGFsa3MgdG8gdGhlIGZpcm13YXJlIHZpYQ0KPiA+IHNlbmRfZmlybXdhcmVfY29tbWFu
ZCgpLCB3aGljaCBhY2Nlc3NlcyBWUFUgcmVnaXN0ZXJzLiBCb3RoIHRoZQ0KPiA+IFNUUkVBTU9G
RiBwYXRoDQo+ID4gKHdhdmU1X3ZwdV9kZWNfam9iX2Fib3J0KCkpIGFuZCB0aGUgVjRMMl9ERUNf
Q01EX1NUT1AgcGF0aA0KPiA+ICh3YXZlNV92cHVfZGVjX3N0b3AoKSkgY2FuIHJ1biB3aGlsZSB0
aGUgZGV2aWNlIGlzIHJ1bnRpbWUgc3VzcGVuZGVkLA0KPiA+IHNvIHRob3NlIHJlZ2lzdGVyIGFj
Y2Vzc2VzIGhpdCBwb3dlcmVkLWRvd24gaGFyZHdhcmUgYW5kIHRoZSBTb0MNCj4gPiByYWlzZXMg
YW4gYXN5bmNocm9ub3VzIFNFcnJvciwgcGFuaWNraW5nIHRoZSBrZXJuZWw6DQo+ID4NCj4gPiDC
oCBTRXJyb3IgSW50ZXJydXB0IG9uIENQVTMsIGNvZGUgMHgwMDAwMDAwMGJmMDAwMDAwIC0tIFNF
cnJvcg0KPiA+IMKgwqAgc2VuZF9maXJtd2FyZV9jb21tYW5kKzB4MmMvMHgxNjAgW3dhdmU1XQ0K
PiA+IMKgwqAgd2F2ZTVfdnB1X2RlY19zZXRfYml0c3RyZWFtX2ZsYWcrMHg2Yy8weDgwIFt3YXZl
NV0NCj4gPiDCoMKgIHdhdmU1X3ZwdV9kZWNfdXBkYXRlX2JpdHN0cmVhbV9idWZmZXIrMHg4MC8w
eGVjIFt3YXZlNV0NCj4gPiDCoMKgIHdhdmU1X3ZwdV9kZWNfam9iX2Fib3J0KzB4NDQvMHhhMCBb
d2F2ZTVdDQo+ID4gwqDCoCB2NGwyX20ybV9jYW5jZWxfam9iKzB4MTEwLzB4MTljIFt2NGwyX21l
bTJtZW1dDQo+ID4gwqDCoCB2NGwyX20ybV9zdHJlYW1vZmYrMHgyNC8weDE0MCBbdjRsMl9tZW0y
bWVtXQ0KPiA+DQo+ID4gUmVzdW1lIHRoZSBkZXZpY2Ugd2l0aCBwbV9ydW50aW1lX3Jlc3VtZV9h
bmRfZ2V0KCkgYXJvdW5kIHRoZSBFT1MNCj4gPiBmaXJtd2FyZSBjb21tYW5kIGFuZCByZWxlYXNl
IGl0IHdpdGggcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoKSwNCj4gPiBtYXRjaGluZyB0aGUg
cnVudGltZSBQTSBoYW5kbGluZyBhbHJlYWR5IGRvbmUgaW4NCj4gPiB3YXZlNV92cHVfZGVjX2Rl
dmljZV9ydW4oKS4NCj4gPg0KPiA+IEZpeGVzOiA5NzA3YTYyNTRhOGEgKCJtZWRpYTogY2hpcHMt
bWVkaWE6IHdhdmU1OiBBZGQgdGhlIHY0bDIgbGF5ZXIiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFja3NvbiBMZWUgPGphY2tzb24ubGVlQGNo
aXBzbm1lZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXMgQ2h1bmcgPG5hcy5jaHVuZ0Bj
aGlwc25tZWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gwqAuLi4vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1LWRlYy5jwqDCoMKgwqDCoMKgwqDCoCB8IDE5DQo+ID4gKysrKysrKysrKysrKysrKysr
Kw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZw
dS1kZWMuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93
YXZlNS12cHUtZGVjLmMNCj4gPiBpbmRleCAxODE3YjgzYzU4ODQuLjY1NjRjZjNlYzczOSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dh
dmU1LXZwdS1kZWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVk
aWEvd2F2ZTUvd2F2ZTUtdnB1LWRlYy5jDQo+ID4gQEAgLTgyMyw3ICs4MjMsMTUgQEAgc3RhdGlj
IGludCB3YXZlNV92cHVfZGVjX3N0b3Aoc3RydWN0IHZwdV9pbnN0YW5jZQ0KPiAqaW5zdCkNCj4g
PiDCoAkJICogY2FsbHMgZG8gbm90IGJsb2NrIG9uIGEgbXV0ZXggd2hpbGUgaW5zaWRlIHRoaXMg
c3BpbmxvY2suDQo+ID4gwqAJCSAqLw0KPiA+IMKgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZp
bnN0LT5zdGF0ZV9zcGlubG9jaywgZmxhZ3MpOw0KPiA+ICsJCS8qDQo+ID4gKwkJICogVjRMMl9E
RUNfQ01EX1NUT1AgY2FuIGFycml2ZSB3aGlsZSB0aGUgZGV2aWNlIGlzIHJ1bnRpbWUNCj4gPiAr
CQkgKiBzdXNwZW5kZWQgKGUuZy4gb24gcGlwZWxpbmUgdGVhcmRvd24pLiBTZXR0aW5nIHRoZSBF
T1MNCj4gPiBmbGFnDQo+ID4gKwkJICogYWNjZXNzZXMgVlBVIHJlZ2lzdGVycyB2aWEgc2VuZF9m
aXJtd2FyZV9jb21tYW5kKCksIHNvIHRoZQ0KPiA+ICsJCSAqIGRldmljZSBtdXN0IGJlIHJlc3Vt
ZWQgZmlyc3QgdG8gYXZvaWQgYW4gYXN5bmNocm9ub3VzDQo+ID4gU0Vycm9yLg0KPiA+ICsJCSAq
Lw0KPiA+ICsJCXBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoaW5zdC0+ZGV2LT5kZXYpOw0KPiAN
Cj4gSSdsbCB0YWtlIHRoaXMgb25lLCBhcyBpdCBpbXByb3ZlcyB0aGluZ3MgYSBsb3QsIGJ1dCBw
bGVhc2UgZm9sbG93LXVwIHdpdGgNCj4gZml4aW5nIGFsbCB0aGUgbWlzc2luZyByZXR1cm4gdmFs
dWUgaGVjayBmb3IgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpLg0KPiANCg0KVGhhbmtzIGZv
ciB5b3VyIHJldmlldy4NCkkgd2lsbCBmb2xsb3cgdXAgd2l0aCBhIHNlcGFyYXRlIHBhdGNoIHRo
YXQgYWRkcyB0aGUgbWlzc2luZyByZXR1cm4gdmFsdWUgZm9yIGFsbCBwbV9ydW50aW1lX3Jlc3Vt
ZV9hbmRfZ2V0KCkgY2FsbHMuDQoNClRoYW5rcw0KSmFja3Nvbg0KDQo+IFJldmlld2VkLWJ5OiBO
aWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1ZnJlc25lQGNvbGxhYm9yYS5jb20+DQoNCg0KDQo+
IA0KPiA+IMKgCQlyZXQgPSB3YXZlNV92cHVfZGVjX3NldF9lb3Nfb25fZmlybXdhcmUoaW5zdCk7
DQo+ID4gKwkJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoaW5zdC0+ZGV2LT5kZXYpOw0KPiA+
IMKgCQlpZiAocmV0KQ0KPiA+IMKgCQkJcmV0dXJuIHJldDsNCj4gPg0KPiA+IEBAIC0xNzk3LDEx
ICsxODA1LDIyIEBAIHN0YXRpYyB2b2lkIHdhdmU1X3ZwdV9kZWNfam9iX2Fib3J0KHZvaWQgKnBy
aXYpDQo+ID4gwqAJaWYgKHJldCkNCj4gPiDCoAkJcmV0dXJuOw0KPiA+DQo+ID4gKwkvKg0KPiA+
ICsJICogam9iX2Fib3J0KCkgcnVucyBmcm9tIHRoZSBTVFJFQU1PRkYgcGF0aCBhbmQgbWF5IGJl
IGNhbGxlZCB3aGlsZQ0KPiA+IHRoZQ0KPiA+ICsJICogZGV2aWNlIGlzIHJ1bnRpbWUgc3VzcGVu
ZGVkLiBTZXR0aW5nIHRoZSBFT1MgZmxhZyB0YWxrcyB0byB0aGUNCj4gPiArCSAqIGZpcm13YXJl
IChzZW5kX2Zpcm13YXJlX2NvbW1hbmQoKSBhY2Nlc3NlcyBWUFUgcmVnaXN0ZXJzKSwgc28NCj4g
dGhlDQo+ID4gKwkgKiBkZXZpY2UgbXVzdCBiZSByZXN1bWVkIGZpcnN0OyBvdGhlcndpc2UgdGhl
IHJlZ2lzdGVyIGFjY2Vzcw0KPiBmYXVsdHMNCj4gPiArCSAqIHdpdGggYW4gYXN5bmNocm9ub3Vz
IFNFcnJvci4NCj4gPiArCSAqLw0KPiA+ICsJcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChpbnN0
LT5kZXYtPmRldik7DQo+ID4gKw0KPiA+IMKgCXJldCA9IHdhdmU1X3ZwdV9kZWNfc2V0X2Vvc19v
bl9maXJtd2FyZShpbnN0KTsNCj4gPiDCoAlpZiAocmV0KQ0KPiA+IMKgCQlkZXZfd2FybihpbnN0
LT5kZXYtPmRldiwNCj4gPiDCoAkJCSAiU2V0dGluZyBFT1MgZm9yIHRoZSBiaXRzdHJlYW0sIGZh
aWw6ICVkXG4iLCByZXQpOw0KPiA+DQo+ID4gKwlwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChp
bnN0LT5kZXYtPmRldik7DQo+ID4gKw0KPiA+IMKgCXY0bDJfbTJtX2pvYl9maW5pc2goaW5zdC0+
djRsMl9tMm1fZGV2LCBtMm1fY3R4KTsNCj4gPiDCoH0NCj4gPg0K
