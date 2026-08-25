Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE1201278
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655943; cv=fail; b=APJG1dAlBAB4PhbQI2lBFprVN7m/o62GaYKe0xrmnArBlp2QeLkpbrERD1QbOiHCswfh2Nw7oMbQIiMkh+wHrnu5tmZAhxbLBpGLq7UwjDbGUFexMavoRwTDdqw7ruo6UuZ/67di1YkEWFKSNPqe6OM3u4tZQPMjOh6DwQQ3VCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655943; c=relaxed/simple;
	bh=EzvH6MwOeLrnReMiQq1fzD//ZixySry5zc+8Y19O1SE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jcjtecBNEOiyJcdu3wMupleXcdbW6Ovg3zMfqaanMdswHYdr3RnvZ7xsAkfOZQV+Xlnnn6s1y1aSx0uN6QElFKEUbcTph0XD62Vm4+kbLxvVWA+F5Vjhtk40SrUnGha5xHpkrcUSLa3czfGN5gHdj8CVqJAywAv+PjO32/PmChI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=mgeafGMK; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="mgeafGMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1OOrWTbhC0pH2SK/lhKA2n4QfMXeGBPOPDtLZDC701U8K17QGUQnWV+KNYwd9aOiM/lUrFZdUdljDK65DpxmIAoWU7/OPGSXru3DZpNYjTYDEnxvSLNf/kPX6XdAN/JwK9UW46giNQCPRiAR8ebcD0sk0GrV61Hkv7S1pnA07RKs7mWbJfufJaE1nWBbtplIPCbm0l5ydQWC2y0NJCRSMw3/CkMsxcL4szh3qeFvCa1jJ7yZIhL+rNGEfAdoxBgoY/jg4pjfAPjASu1IrUrMcucjgRAGfcjJROealebG7dcIrbi/EzrwopsUjL2jOy0qkx8WcccGzYsmAGCAYUStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzvH6MwOeLrnReMiQq1fzD//ZixySry5zc+8Y19O1SE=;
 b=qzueQeaNrta7zlrz1XZEbFxHQBaIZ6XiWplU6BEcRGrCFGaitg6r/qNWXsST6XZ7VQUpKSzeu/O43R8ljgtJ0oUe3HgN/TiZlQTryVQ8WHspwl16hl+MsMCWwg9mCDJdNUR/Cepw++OE1T60AcBUuS5+Dfj97IV5LxhD36iJ/ffg76r3e2jWPqA43MXDIaxERnMVQrDZOpiHth+C79YuMB+/i6C0a80f5OxZ4Whkr3UUWC+h8zcb4O0yF1AAleB3WqjHrnZYeFhVyRcj4xBY84nv23iXW0y7wCd/WtdzMmKon5kCn7LitNww9uFecu53Y5+HLkNJU3fBqSS7yJObRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzvH6MwOeLrnReMiQq1fzD//ZixySry5zc+8Y19O1SE=;
 b=mgeafGMKwwaADI1u0ldtMbkddHvKiIKZ9JOT1A5JB1ws6wNzUq8pbd22t/J2jVvedi0i88VvCzduVWVGmoaM1I87YgLytmKZUr7htlCnx162pE2IGi2RJV5/J/ZzXmrs1O6tJCPdfPAnLr4Gu5wnBbV4F+vxN/fmtQgy7jSQmbTonRm/dGac6ARKIl5bhDNseSAeDToS9GA7molZmKT03Grrg/yClLf0+MoFcIGUS/kM1XD0VcDjeHy7UhEXsV//JlbLd5EFpzncJEOMyabvSk92h3OlEnRfpI3tA7TzucTIHXE3WiFY86iOGbc/jZ0zln6p4jDST5St9K55c96nnQ==
Received: from DU4PR07MB12087.eurprd07.prod.outlook.com (2603:10a6:10:62b::10)
 by AM0PR07MB6418.eurprd07.prod.outlook.com (2603:10a6:20b:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 11:05:39 +0000
Received: from DU4PR07MB12087.eurprd07.prod.outlook.com
 ([fe80::ec8f:9299:5812:d9d3]) by DU4PR07MB12087.eurprd07.prod.outlook.com
 ([fe80::ec8f:9299:5812:d9d3%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 11:05:39 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: stable <stable@vger.kernel.org>
Subject: backport/fix for CVE-2026-43198 missing 6.12.x ?
Thread-Topic: backport/fix for CVE-2026-43198 missing 6.12.x ?
Thread-Index: AQHdNIGp2CwIx1nboUOY31T1jeTfug==
Date: Tue, 25 Aug 2026 11:05:39 +0000
Message-ID: <01e4f29ebe9590b2c5a91697b0fa4e23861bba77.camel@nokia.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4PR07MB12087:EE_|AM0PR07MB6418:EE_
x-ms-office365-filtering-correlation-id: 3516f226-5509-4c55-45af-08df0298cc06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 rUrUQkgsbxF6W1CFeYnEcpzmQcdPdVYiMk3T7flaF5Y8d3xpMrizvcxfJW2alCP2SK0xdVr7Z6sBvKayylob4vSssHzPeuE63mkeyGuKQmjPJ7HwQ0OjmIu6WWyMSv4IYvZ2rqShKwgGUVCYtk0ZJToyejRUreTDw1XhmBxpmwceME4OvBjJGs9aygd34KTmy3si+NxKDZeACNqbXk2VHPCCpbXVqQa5vyoioAhhAhB1oiCisSwbX+6VH75YbtTMpgcC7rCDuFtVJfHVu4zeowNEr1vzrHxIjpEglGyoGpZFnsyUoLUuILpzRaWq90th+yM5lmtuMGuo/hfMLvu4hD/q86hFvNKtI6OaTxSSBXlgSmGIOlu6KMrvJ8BgTIcrCsi6lKhoHdbgBg028loqqEarSCzQaIdXynYg73QQUGc/oxgFSanW0JK4s4AYu+MJj5jf2ZyD+MjXRMauMFYJ4Wqb6TInYsBuQchvTs691feV4g+vLher7lBNEOPfiNUoJd5tJAuGGfzjnLqs/e97heZgNs1XabBTrYOYlKnkvCRv/MAoWcBdyGokOIrqmqqwq0jBOBNh1ZxmUaOUa8Tl+pIYHXtcymdLbkUMtkeYbLstZ3Bj6RB7ML6eJVzYArRHvXTobmKHfYGOjreGOZjsQh3HyVDkyRqh6X9YcBwP3Lbt2yD9S9RXP7Lh51KVfGwSEbNstGIiygjd/L1VLxBRDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR07MB12087.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXBjT29DblZwNW1IakFlMlBORFdnTzFoWnlLcGE0dVRQT1Z5TThjS3FpTG85?=
 =?utf-8?B?b0JMSDQ1NFIrYnp0cnBMb2wwK29Oc1h5Um9YUi9SVUE3L0JoK2VzUXFKYmVh?=
 =?utf-8?B?S0Q0WlVIdzhZUTRrNzhOOUxqRGdQR0lsSkE5RnJaTUIzUm9qNThQVVlPN1A5?=
 =?utf-8?B?OTNXVVFZak9FRTVhaHNsak54MjZINi9pWGwxbFlkY3ZNcThxaC8rV1pmOEEv?=
 =?utf-8?B?YTF0YkxKM2ljeUduaXBRZE85S0U0WjlMdVZ6am42LzF3WjUzZVhIaUMxOWcv?=
 =?utf-8?B?L1lCdHNWVzNhY2ZrcWhieVNuRmkvSmYxdFEvcU1BZDZXR0x3WU5YUlc1NHNY?=
 =?utf-8?B?Z1FaZ3VJV1FtTCtsUU5jbURwSUQvaFRXa3A4TUY2RzZaeUxwMXFPd0ZpWW9E?=
 =?utf-8?B?ZG5VMVh3Q3JhUmU3alJkQk5Pb2xJeHRTU1c4MjErYithc1lXbFp2VDBNMHc2?=
 =?utf-8?B?U2hrc3ZwTzFlZkxTV1g2aTdwQzNzZ25wdVYxUkRjVDUwanhOOTFocWQ2OW8y?=
 =?utf-8?B?VndjNG9YTmNJZ2RqWTJuaG1wNFdUWnlraTY5Z3MrQS9VdVdRbHhaN2ZEdVBw?=
 =?utf-8?B?SkEzZDMvOTJGcGw0WVhQLzV1UHJ5V3RJZTVzS1lNbXJjVEJkcUJRRVlyN0ta?=
 =?utf-8?B?L3o4VVFIWCthUVZUbjdobytPalpXellMOXcwamxhTnB1cmxsSVpEVHF6Q1dP?=
 =?utf-8?B?bHI1Wlh4TUlQWlVad29OZ04xVmMyQ2xnSWZJdXUyTzZVeitSNFVTbkxnV3lN?=
 =?utf-8?B?QmlWdC9ZN1NXQm1CTnc5NkprZGxlL1NkMEwyR3JvSUlqM3RuYmpoMTlnMnh1?=
 =?utf-8?B?M0picnFYWE9wQzFXK1BtZGIvSnh1QXpSbjloT0FBSFNTYjZOdG8vdHhVNysz?=
 =?utf-8?B?TWNMQ1UwbWYvT0pXVEFZSktOS3cyMVIyYmpXeHdYV0JUaU1BV0orS3l2Snpl?=
 =?utf-8?B?UjNyanJJM0tFMHQyUGE5aHl2L2pUdFdJdTBsd2c3L2ptQ20waXhWNUR2ZWhs?=
 =?utf-8?B?WTJMTlFEQXRTWXd0WFo0K2xGMDV1ZXgyQmhaTVJsVC93VGo1dlYyWlV5NzRC?=
 =?utf-8?B?VmxGZFlMRFhVSFVNUElFalFxa1NhY0YrR0VyNVpKUFN1dms5OG01bTRHUHRC?=
 =?utf-8?B?cDRWWnNGQTdvWjJsL1VpQ2xrVnFFSmE0empETUROTjlubkJWUGh4L0RyKzVv?=
 =?utf-8?B?V0Ztb2hSRGVtdjJ3RXlWOVhDNktDMUE0WHEwZTJVM052Z0hleTR0Z1gzN0RJ?=
 =?utf-8?B?UXB5eGg4U0ZEWm8vWjVQcU8wUnFXMTVsU3hnOEozWE5Rbk1SMGsxcjdtaDNq?=
 =?utf-8?B?RzBWNjBleDlvZWE1TTdLU2xJSFRBZVZOVjl0djFlYXdNTTI1WUV5TVJ6c1NZ?=
 =?utf-8?B?RjFDai9SOTNCUzB0NDI4UWtWVEdVNGVsSXhkbmZEcEttdDlINEhWSGJHRlcv?=
 =?utf-8?B?S0JFZUNsOGhqV1crUjhIYkVOL3hCeEVqODEyUXFZUmlweVhxdHV6UGtCeEFz?=
 =?utf-8?B?enBWeTVRT3g1Y3R2V1N3YVl1K1FhNE9aYXh1a0FDTTdyRzRtTzJ6Vk1pOUJX?=
 =?utf-8?B?MVJmUjlTY01ZM3hZSk1hdDhqeE1VaEo4ajI2K3o1ODVOSHY3L2xjdzlxMnI5?=
 =?utf-8?B?U3BNUzhFVUorbnNQM1l2SDJ6dURVTnlCSlcwMUI4SEJwY2VTT0NDMzl3NUVt?=
 =?utf-8?B?cVFIa3IrWmFGUEN3ZmlITUFGNEhYS05kMmU3UzJsYWRsRkFxbmZ2TGplUzNi?=
 =?utf-8?B?Y1g2TkFCR1dXcnFtVVF0NjBqZ3l6MFNWWUtBVmlTN0E1Z2NlTmlyc0NwUzJx?=
 =?utf-8?B?MlVjQ0RablFmN3hvdW1qZU1CRzRKWFVRUmhIcWpvMFZSTUMvUTNpQzlkR0xU?=
 =?utf-8?B?dkJiYWZzbHNVUVlwSG9hbktkQjZFakpjZ3dBS0xHQS9GNCtPbGNuRk53ellD?=
 =?utf-8?B?MG9vTWhDN0VzUHlQUytMN0k3WUVZdXFqTDJVeWpkNmZLY3hxOTJRcjkrS3RQ?=
 =?utf-8?B?YnNNMlloMDYrYjRhOXpOMVBzMzczKzJZNDdzeXArYmlyRVBRaDcvajJWdkpw?=
 =?utf-8?B?RzhpTWl0M0F0dXV5V3V1UmFXT1B1cWptajFEYVdvc2NVNmVlODFUZ3lVOERl?=
 =?utf-8?B?Y1FhcFhYc3ZkZUE2MFBYU201R0RuTERSQnpId1NIUXl0dFpIdCtIaEtxcjBk?=
 =?utf-8?B?Q0ZPcGVpdzdTRGZjdlYzRWIwUnd5WWhGbWFrQ2Yrb3cwSkNpWDFsSUp0OGRs?=
 =?utf-8?B?cW90L2JJcThCMVgxR3k2dVY1L0pRYVR1R0JieXdBVTZubHA5ZGxiZ1kvRUph?=
 =?utf-8?B?ZGRrcHBnWEVva3VQVm1mNmk5SlVLTi9vd21WQzFQNHRidjVFbmlwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87C28B79E8460940A303AD1E3FD10A90@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4PR07MB12087.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3516f226-5509-4c55-45af-08df0298cc06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 11:05:39.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7mra4uFuA8UKDlKz2sczy4zjzykHusVsvfupZ+/nXZvgKYsHlZPvpwJkb0OKnejTYolrY9tKDEY+fvX6vfktE+gP8Qyqxl9wl7yp5DLYQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6418

TG9va2luZyBpbiBsYXRlc3QgNi4xMi54IGtlcm5lbCBJIGNhbm5vdCBmaW5kIGFueSBldmlkZW5j
ZSBvZiBhIGZpeCBmb3IgQ1ZFLTIwMjYtNDMxOTguCklzIGl0IG1pc3Npbmcgb3IgaXMgNi4xMi54
IHVuYWZmZWN0ZWQgPwoKCkNWRS0yMDI2LTQzMTk4Ogp0Y3A6IGZpeCBwb3RlbnRpYWwgcmFjZSBp
biB0Y3BfdjZfc3luX3JlY3Zfc29jaygpIENvZGUgaW4gdGNwX3Y2X3N5bl9yZWN2X3NvY2soKSBh
ZnRlciB0aGUgY2FsbCB0bwp0Y3BfdjRfc3luX3JlY3Zfc29jaygpIGlzIGRvbmUgdG9vIGxhdGUu
IEFmdGVyIHRjcF92NF9zeW5fcmVjdl9zb2NrKCksIHRoZSBjaGlsZCBzb2NrZXQgaXMgYWxyZWFk
eQp2aXNpYmxlIGZyb20gVENQIGVoYXNoIHRhYmxlIGFuZCBvdGhlciBjcHVzIG1pZ2h0IHVzZSBp
dC4gU2luY2UgbmV3aW5ldC0+cGluZXQ2IGlzIHN0aWxsIHBvaW50aW5nCnRvIHRoZSBsaXN0ZW5l
ciBpcHY2X3BpbmZvIGJhZCB0aGluZ3MgY2FuIGhhcHBlbiBhcyBzeXpib3QgZm91bmQuIE1vdmUg
dGhlIHByb2JsZW1hdGljIGNvZGUgaW4KdGNwX3Y2X21hcHBlZF9jaGlsZF9pbml0KCkgYW5kIGNh
bGwgdGhpcyBuZXcgaGVscGVyIGZyb20gdGNwX3Y0X3N5bl9yZWN2X3NvY2soKSBiZWZvcmUgdGhl
IGVoYXNoCmluc2VydGlvbi4gVGhpcyBhbGxvd3MgdGhlIHJlbW92YWwgb2Ygb25lIHRjcF9zeW5j
X21zcygpLCBzaW5jZSB0Y3BfdjRfc3luX3JlY3Zfc29jaygpIHdpbGwgY2FsbCBpdAp3aXRoIHRo
ZSBjb3JyZWN0IGNvbnRleHQuCg==
