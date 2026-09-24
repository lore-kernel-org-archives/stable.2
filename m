Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907394A43EF;
	Thu, 24 Sep 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263452; cv=fail; b=BRhaLFGTaHJSyPFgmnfoxPRPDsDyUEko494nlz0aWqYxhZR/XKlkpysRIfWahzOrImWPwciSSioV0Zpen7jzAhRseQbbWvxicG4fbX2CrsIf6qjkCoVlSwciD0dRQpPH4eMo+TfbDpPH/czFqdxZXyy3aFoovHhJB5LfC4en8T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263452; c=relaxed/simple;
	bh=l/dTwq6DoGP3DexxVOpWKMaNBeN5jiFMu7kQMsoXBTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HoJqQNaYAnBdOenquioc1NaHmAecDGtXHMq0m+6djROUp33iTM25fvhO/+rHoJza+YbcsMGEv9/rDyz1sAbI9Ibam4PyqtIDDXhFLcgG0q1Gt+1rXGku+gLYiF0bbAuJeEXkJ3caSJ/+OjhQ6jeM4vY6NkKbSYyAlvAjzUdOclI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CB6eeruD; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CB6eeruD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USrMYQQ7wsdJ3lu1cvc4ybxdXUv/GuIQlXgQk8OnGlmGvbj7Pb3vBBTTiazTgEFi8EuM9jY8IfIC7wVdJxvt66HRMj2CBNzVBSS9QItEEdYKp9tTxau6ghb2k9ztbILmZsCxCSfOZJ1NnsR9tntA7JjUBz5qi0b1m5EPr1qG2OAY0e1YxvLM3lkzsrYoPgIx7v8r/8nF3fHA/hb/qBF8OuTnCQX57o+nDo5qOfXtEvLav5kE4UnnKa4c+4KpKF4NX5gizGN/+49s3/DXxPuXoS0otRRZuaK1JBCL2sjIxM4rsU9OejxdgTal4x2MmpCIngX40vG3dHMoYl/tHodqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/dTwq6DoGP3DexxVOpWKMaNBeN5jiFMu7kQMsoXBTA=;
 b=ZdWSffpz3vI6vAMP8r2ad6AxHcZTyk7bmYIW+sWcAWCdJSuoae36p3NfYOzbEbskCYq9/iDDV3zbezFZtS8sM+9FjeHWGCHqGiK1YX9SME+TRhubAgIc/WwneWbkJG8xA8pzjmlnlawydGu/MfG2ocA4A4C3KKpgvhsP9IyNV2htkQzEsI0M8vjSVv+I+aZjxCa8XfYnCwFxuKyrE9UvzTtq0XuAkF2iWRxMdyfTIKq9T+6DecqXWA24Wze9lETGtYCP98FzyqHS07Gh3Zqsh7KbO8Wpx9IEVGbvkd0P92oBCkjNGuBFvps6H2lUqyJcCduEVszWQbm3gIHFO+tvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/dTwq6DoGP3DexxVOpWKMaNBeN5jiFMu7kQMsoXBTA=;
 b=CB6eeruDq/CpqdxwL0O/I59vxRK4FLcIOyUxsis9tRqWWcYzpeWsk93OlyQJ+W133bycTEGJFEUAuD7P7r2/z0BCid0e4EgGtNxffPHbjUbu+24eGpQn5/k5p7AnyIIU83f5cpCwymoLl2yFI8F+mEyBzP0HWvTcBwhyhyC27+cIQYHoub5d2m4Boouuqbwc1/0n5XKm7Suic3O+V6rYW8nc8LKcyokPmekW1275tQfGUhXPLVUeSFb9VyNl9KB19wmErEy+enDOmFJ2K0BFLS4BIJt2KD6ZZB6LBRxmC0mSsYbhQYkv/oeKauyCjoxSg3zS6cyTH6cGmujwxlNAyQ==
Received: from PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23)
 by AMBPR04MB12566.eurprd04.prod.outlook.com (2603:10a6:20b:77a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:24:07 +0000
Received: from PAXPR04MB8093.eurprd04.prod.outlook.com
 ([fe80::b74d:9238:af4:f489]) by PAXPR04MB8093.eurprd04.prod.outlook.com
 ([fe80::b74d:9238:af4:f489%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:24:07 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Aldo Ariel <qwe.aldo@gmail.com>
CC: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Thread-Topic: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Thread-Index: AQHdTDi9DXFjy0eRm0SHThtDkJxkBw==
Date: Thu, 24 Sep 2026 15:24:07 +0000
Message-ID:
 <PAXPR04MB80938C1ED33372215E4056EE89812@PAXPR04MB8093.eurprd04.prod.outlook.com>
References: <20260923203738.1583735-1-qwe.aldo@gmail.com>
 <f3c05fe4-b90a-484b-8b3f-0cf0b101a20a@lunn.ch>
 <CAP48Hfto4qc285B3Jw7ZRuC-wGf57JOBPZOdrrAt-aDfGcas8Q@mail.gmail.com>
 <a230cd62-db31-4128-acfa-93501d30aa39@lunn.ch>
In-Reply-To: <a230cd62-db31-4128-acfa-93501d30aa39@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-24T15:22:55.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8093:EE_|AMBPR04MB12566:EE_
x-ms-office365-filtering-correlation-id: 44873017-ba0c-4c0f-6023-08df1a4fe018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 nYR5XO4f7tb74/hisjv87ognw+LqD5R+9qtek+jRqjs1rKg0nKUAM2nU/PGh/uwKsMrXYubBkxe1hRjyHalvfaDn98DTis1sK1i6Ho50ra2sZSL5GzHEwOvGhoa+iYzIEJNb85ANEJCH2qISnGMWW1DhOpHANwU5IISduFv7hlKmHJaMnl3FtKZydCWtWhbm+UWNIVpzHRpO+UorxNhYQMrcaNbmHNT45L3KwKglrkvz1e//+4BLc+Ue/V9L0tne2nNV41eu4a5GtFk4Sr+vVFJ/RWLA0xH53k199XeXQM2ikrkqmUDqoI9SpQDZ3QHJ5FQjr5xjZmGPLM9HVT234dbnwsiaLuOLrwmMSpDoTPygufMckTnuGMJh+KIs2ipJid8zUgC86If0PnKTgAqW0PijrMWQhagiP5EBBJPW8x8tjXrheLB7l4FBsEUiLGd3ANlxqB7wQYCG6yIUho7iJvlVBTVCj0S0C/OeK72U8004hlFPVvEyxZx2XOqptkjvWCdL5TNWcsDRNvaLJJu8GrQo5Vxv46sZoD5vN6tfoivz2ghc0WeOSM59cmdnqy1f8vocFjRPuJBCoE6LBYKMJjEgiTxbKIxwb8yQH2RzsMTaFuwt/2GFHJFl02RKdNsrIWU3z7+3wFl6hwPrTalS0Az/5nE2UH7fm/dNNWIGTo5l0oen1AtfHvYn250ZWDxy+762kOtJz5tPNAUHOVFwdlHIf/WPR6pBCFolIftkbvw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8093.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODFZdjBSdlpDVUNMWEFrSDlFdzdwblBUYnVqZ2NrNkozZXl3cTJlOFoydzFy?=
 =?utf-8?B?ci80YmVZU3NYMmNUM3dqbzZnUHg2dkY2SEdtZjM2QWozSC9hMThKZEtLcGN1?=
 =?utf-8?B?dU50dGJSV3JQQUZaelAybG0yYWlWM05KR1N1eS9mbk9qcGlyUHBYeHo0M1JQ?=
 =?utf-8?B?S2RBWkdickFnMkdvYXpHTzA3dGFXbVZUc1NHOUhFbU1BQ3hMdndBejRNcmdZ?=
 =?utf-8?B?NGxjTkFoUjdNRUNzNzJ4RHNiazB4dUpZQnI5SDRodnE0WFNHeHNPYWJCelFF?=
 =?utf-8?B?a1oyUSt2WFZYek5wMXFoYXF0d1pqK1ZqQjVkSUNmVE10aytzZEI0TzN0OE1O?=
 =?utf-8?B?RlQwdldUTVZsZG5uQTIwMEtWK0JLTnBINXFqckpQSFdJMUkvSm8rYTkrTWU0?=
 =?utf-8?B?dXI5WU4zV01Nbk5wbHJXQVY0Ymwyd2FEVVJMSy9uakdhaWU3N3JmTWU1VkMz?=
 =?utf-8?B?K1lLRWZsNStjcEx0QmxQRDd1TnN0bHNmNEtlUnRoS25CYVJqTnhsVUs4NFBV?=
 =?utf-8?B?YmUzU3ZEY29SSTVCYUZjMUxPSm1nYjkvSkhWcjV0NTczQTRpMjJRSWRPRG9N?=
 =?utf-8?B?VFRwbnlpNGtkQlBLcEVKZnNibFpkNzhZb09YK0xoSlBoclg5Y0xZUEtkSVdR?=
 =?utf-8?B?YzJuZ0hkaVZnb3lmeWwrQjlCYy9JcTM0K295VHVuaG8vU2FjdStORXJTL2xv?=
 =?utf-8?B?UFNibWNPV2RIMXorUjcxamltWkRhbmx3VzF1bFdIUlFRRjN2R0hRNE5rM2lW?=
 =?utf-8?B?Z0k4aEt1WDlyQnc0eHI1KzJrR092S3pidGljdVVuRnVqMVo1TzBWc0QxYWs3?=
 =?utf-8?B?Z3d6UEhnVFJGeVF3dXdRcGVsL2NqZ3poMVRUVHlWRVlzbTBFaWhCeWtSMFRk?=
 =?utf-8?B?RlE1OWoxRStnKzA0Y0Job25oa2pMQU1sSGZ3WHd5QUg0dVFKOVhPdlV1KzE3?=
 =?utf-8?B?cE5Vem5wd3Ezdkp3RDlobm81V2dxWmtBYTUxR2hxdVhXWVJmWk13b01pWlNs?=
 =?utf-8?B?YjBONEIzeWFicHVnbUpNS1lBWVdOM1VRbTNSdjcyWXVsRmVkQmRxYXdSTDVC?=
 =?utf-8?B?ZUFodTlWbEo0MEt3MTlMUGlKQ0gycWczM2sxei9LVjAzc3o4RTFhWE9rYXkx?=
 =?utf-8?B?TU1vL0FOS3FhTmFnNnRsZm0vRmhwTGt0M2Yramx3bndxZkVscWYvOG5BUU05?=
 =?utf-8?B?c2d2WnRHdVpwMmpBR1BGeUdCL2d1eGVCZC9aaWZ4ZDdBTGJtcVZHWHZrd2hp?=
 =?utf-8?B?RFltZ0l2Zlk0MTRtTDhWVDVpQ1RWb0RjN1lMTFVacmZxWGJPSXBIMnE1eEt4?=
 =?utf-8?B?aS9LeVQ4d01YaHk5MWNiSXJpalMrL1htdjgxN2htN3JKOUdvMUxxZ3VIclNH?=
 =?utf-8?B?R2lCVUM0M1R5RHo3ck0xN3kwMkVqNDM0b1FQTG1GNG5NTFhlN0E3dUFzQkxX?=
 =?utf-8?B?VmNZYUx3QjFvazhzeC9xT0dmaXhZWlJ4S0ttY2tKUXJZL0J2RUdtcDBVN2Fm?=
 =?utf-8?B?UW53Y2Rzb2QzNW9PTHo3L0xhZEttMlg3RGphelhvVUUyeXZUcTlYNXo0aVZ6?=
 =?utf-8?B?QW52OHNnQktUSTFlWDAyRWx5dWdVMjIzMk1RNDFHUHlRQ1pNTm9FV2JkMnFn?=
 =?utf-8?B?YzhvajB3anR1RTNQbmk1ZWRhQTRmMzdibTFwcE9UYWNtYVNXOWNOQTJnWm1J?=
 =?utf-8?B?M1orRlJEQThsbHdKUGVDMC9SRm14TjVxNlZOWTUvbnFYTlFEcFlnZlBpdVJI?=
 =?utf-8?B?ZVVCZThHa1FBbmQ3cWFheTYrOWFlTWRvaGIvanZKZVU4eUUrYmJndUdjd3NU?=
 =?utf-8?B?Y2c4aXA5eFlJNDEwTnJQVTZJbEtydEM3YklqZWhSNGpoN21FS1hnUU9lYmlH?=
 =?utf-8?B?OTZPMDN5RGdtM3BhdnRtS2JqbHlKazNCWVdaMzVSY2o1cXdpMDFiZ2VWYjZY?=
 =?utf-8?B?czY4bXMzS3VjQ2ppS3huUEFHMzErNDJMa0E3Ynh3K3M1R0F1TTV5UUMrT25X?=
 =?utf-8?B?bXJJSkdKcVBMVDFxN0RkK0drVDdXakcrUlNIUEhxL01SWkt4MzVTVUI4UVpp?=
 =?utf-8?B?S2JoY28yNlZHdkhKaEc4OVZ0OVdqZlNaT25RWDlYTVlxV0hqM1JJRUhWQzgr?=
 =?utf-8?B?T1NqODZ1cU16N2swa2FEWlFhczVXOFJxemwzc2JBVWM5VjNvaVFJODdua1dN?=
 =?utf-8?B?ZlNzZHNVZ3FEV0hBenJYQ0QzNU1jeEJBemh4S1pZVHRMNlloMnpPMmVGK05x?=
 =?utf-8?B?N3hudCtOM0VQbWxxS3lkQUNWbVc4UE5wTGFsVWZldWphQXVoM1RkUkNXYXBl?=
 =?utf-8?Q?rCRU7ZELQ3lQayG5y2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8093.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44873017-ba0c-4c0f-6023-08df1a4fe018
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 15:24:07.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8Ewm2MdLnlrb5sVRokNywU436BVRnqpxTBAeLHxCAR1dXbvpKzdDe+P4AADUv1+OyX/TiZxySJhXRJaoRs6Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12566

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMjQsIDIwMjYgNzo0MSBBTQ0KPiBUbzogQWxkbyBBcmllbCA8cXdlLmFsZG9AZ21haWwu
Y29tPg0KPiBDYzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBGcmFuayBMaSA8ZnJhbmsu
bGlAbnhwLmNvbT47IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53YW5nQG54cC5jb20+OyBpbXhA
bGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU2FzaGlrbyA8c2FzaGlr
by0NCj4gYm90QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggbmV0IHYy
XSBuZXQ6IGZlYzogcmVqZWN0IG92ZXJzaXplZCBmcmFnbWVudHMgYmVmb3JlDQo+IGJvdW5jZS1i
dWZmZXIgbWVtY3B5DQo+DQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBs
ZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1l
bnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQg
dGhpcyBlbWFpbCcNCj4gYnV0dG9uDQo+DQo+DQo+IE9uIFdlZCwgU2VwIDIzLCAyMDI2IGF0IDA2
OjIyOjAxUE0gLTAzMDAsIEFsZG8gQXJpZWwgd3JvdGU6DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+
ID4gUEtUX01BWEJVRl9TSVpFID0gcm91bmRfZG93bigyMDQ4IC0gNjQsIDY0KSA9IDE5ODQgbWF4
X210dSAobm9uLWp1bWJvKQ0KPiA+ID0gMTk4NCAtIFZMQU5fRVRIX0hMRU4gLSBFVEhfRkNTX0xF
TiA9IDE5NjINCj4gPg0KPiA+IFNvIGZvciBzdGFuZGFyZCBNVFUsIG1heF9tdHUgPCBGRUNfRU5F
VF9UWF9GUlNJWkUgYW5kIGluZGl2aWR1YWwNCj4gPiBmcmFnbWVudHMgc2hvdWxkIG5vdCBleGNl
ZWQgdGhlIGJvdW5jZSBidWZmZXIuDQo+ID4NCj4gPiBIb3dldmVyLCB3aGVuIHRoZSBkZXZpY2Ug
c3VwcG9ydHMganVtYm8gZnJhbWVzLCBtYXhfYnVmX3NpemUgPQ0KPiA+IE1BWF9KVU1CT19CVUZf
U0laRSAofjE2MjU2KSBhbmQgbWF4X210dSByZWFjaGVzIH4xNjIzNC4NCj4gPiBTY2F0dGVyLWdh
dGhlciBmcmFnbWVudHMgaW4gdGhhdCBjYXNlIGNhbiBleGNlZWQgRkVDX0VORVRfVFhfRlJTSVpF
DQo+ID4gd2hpbGUgc3RpbGwgbmVlZGluZyB0aGUgYm91bmNlIHBhdGggZm9yIGFsaWdubWVudCBv
ciBieXRlLXN3YXAuDQo+ID4NCj4gPiBTaG91bGQgSSByZXNwaW4gd2l0aCBhIGNoZWNrIG9ubHkg
Zm9yIHRoZSBqdW1ibyBwYXRoLCBvciBpcyB0aGUNCj4gPiB1bmNvbmRpdGlvbmFsIGd1YXJkIGFj
Y2VwdGFibGU/DQo+DQo+IENhbiBib3VuY2UgYnVmZmVycyBhbmQganVtYm8gYmUgdXNlZCBhdCB0
aGUgc2FtZSB0aW1lPw0KPg0KDQpOby4gQm91bmNlIGJ1ZmZlciBpcyBvbmx5IGF2YWlsYWJsZSBv
biBpLm14MjguDQoNClNoZW53ZWkNCg0KPiBIb3cgaXMgdGhlIHNjYXR0ZXItZ2F0aGVyIHNpemUg
ZGV0ZXJtaW5lZD8gTWF5YmUgdGhlIGJldHRlciBmaXggaXMgdG8gc2V0IHRoZQ0KPiBmcmFnbWVu
dCBzaXplIGJhc2VkIG9uIHRoZSBzaXplIG9mIHRoZSBib3VuY2UgYnVmZmVyIHdoZW4gaXQgaXMg
aW4gdXNlPw0KPg0KPiAgICAgICAgIEFuZHJldw0K
