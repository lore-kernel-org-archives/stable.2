Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6849620;
	Tue,  8 Sep 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836908; cv=fail; b=dSNbUp4apI2eEBF04WdWf0GJ/wo4mNUdzY8Bd9wH2SLlnT7G6ImruB3X0WUqNDVh/DLDuTIULlSiMH4++ICZPO2TzYw8rCDqSaZsX5VzB5+wrYYCMTvCDPc217nuwMBdSQbYz3NMSfjrmBtWcHo2qU1+oHRv6GXnB8vlhDFqgFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836908; c=relaxed/simple;
	bh=N+F+xdwc4bNR1sx53NJNjjJ/NOJLTVphxJwTXP+i9iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KuatDg8u1iz+tFLmjYekXCIXOLD8J5iDp9eX9iOLExkBa3fJv28EVHiB2XVP9YnunKaJJKQXg8L1prvNWXQpIy3OPpAzKyXrGBj5z8fq27DjMwBiAr1jYbk28NHFaNuQODlz0K/UMT1Ufc8K+Qx0sEe0C7RJ86MQFUaCROPtgh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wvkf1+fD; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wvkf1+fD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX3v8J3h+HP9suADYCwqTD5RK1MN3764caF7F5KHE/BJ2YcmuXJAshq26WVooUbbVxAXAzAef2bhOYjGFsTXa7WBlJ/XoKMMZ/UB+2V2xGoBAiNYGmeoUC91MnC6+l8oOig1HMuRrrwChsiCAXJWXyb5hWJiPJBnue71Cchxlz6F5ednD8mG5OuF736jf5JB2PnrgGCv6rV2b2dADW3mdym3pm24vSNqLlfqOLj4s+LruwN7SkkwS/Mz9q182mmcy1b4tw91SEX2mowWSoVRkVjk5G0xksCtzW9CjGFdlTJSPIe9mPCvhLEQOKSaEvO/9E2owcPxwbFQztePyLR6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+F+xdwc4bNR1sx53NJNjjJ/NOJLTVphxJwTXP+i9iA=;
 b=RJjT+YCEdlAXhvaHHymVwAONjfI2LAEjAjONOvRFHq1HZWS+xGrMLcMg72GAxrvhk1YjoneNL133BhO5EM8kyjHwfv3nji7XxuQwZm30vYjwMVmZuahK8ZWlzZKHEUTTWhf1Zgjxt0vz5rq/ARbfYCHVFRyJFP0pgQGlayhc6playuUsLC6wA8koqwDPmY9PSlXPJvDjMp+Fbp/6vmbsk+mejAQ6IrA1PekS7cfRm1l+RU9QRL/YEKObuQ+s6SlcSif5om6m77+3Ua6+5PToGiDLcwy+vdTLxZtivH8KzQYBcvsnWsGdwd2+T2aGKxp2e9pAMp3qdig5pBlAKQHcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+F+xdwc4bNR1sx53NJNjjJ/NOJLTVphxJwTXP+i9iA=;
 b=Wvkf1+fDH8NUWJBcxHiMBjKsr9SdttxkrIcajfAHtmk2e4jhQOHpC+Hhz0tE0xC6Ru6EM+Ablf9QBYdvZ22IfIOUgu8JstCfY66ePxd5ZR8MKzVE62rnmuh1/w7CZBfWVbvJb9U9maQa3sgZ0IzUM4YWuPsedoGAKm8YF+iN4bxYwNwxs892QemkVQoAwDVk6vmAMvFbRBk4ujXGDeY/mgzoHldOoJOxpDKp37YMTHyptMovGh+1ssfkuZdRCmKvFbZHoogLYQosOh5uU2mT3D4hGzgS9I7LSWXrv8zS7YMYQWLjPBbjk5g9fQN+ZGkLebGV7onR+q4jGsW7w56VKw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI1PR04MB7024.eurprd04.prod.outlook.com
 (2603:10a6:800:124::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 03:08:21 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:08:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shengzhuo Wei <me@cherr.cc>
CC: Simon Horman <horms@kernel.org>, Phuc <phucduc.bui@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Topic: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
Thread-Index: AQHdPzsguS2uQ4k+LkGpk4h1YzzcLLbD/rOQ
Date: Tue, 8 Sep 2026 03:08:21 +0000
Message-ID:
 <GV2PR04MB11739F14020FD45F9BB2AEADD88B12@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
 <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-08T03:03:10.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI1PR04MB7024:EE_
x-ms-office365-filtering-correlation-id: 18a3e0e0-86f1-46a2-1d5e-08df0d5670a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|7416014|10067099003|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 myy3SyWPphdGmn3RxZcaonJko/Q+fuOHzBJRkKYsePEjyb6TTZ1F9zaG5J7/Sfek6Y1f+bbBaNgoDzYrm/p3Po8XiJDfEJpAmXjehTde9XetNdlq735SoqQvXleG5atr5xF9zoE/BZAueuUX+mWnHSefMcMZbeAGsAPrEi5gsZGOKFGcyBPtB9lfi+tEsDOfGUJLiK1IZA7WXU8CT3b5EKhDZEmOa00hSC7mb9cb/RmfEA77NCmgVRmp/y/CThrqXZRJvLysIWxod0do2+TA4pcfi4KCIq354b4Nk/ExzFFybkUEsfgWZ7zg8nAcGvuUxPHYTuvscNnQYQC6eOvP97qTmO4E7cpT+f2UTcRKfI/g1Uaw1GMwuTONV6dQMSUxEnNvqCKVEKrTih3evkE/vwmUk/wX/kmqDK82qclCgxuc/i86EGh6j/Ov6zmHW3PC9/kTIy1d+AJdMkB1QQCU725ahugab5k0JIdYwhmzkspi2/uO9dK7iyRpCN6jfO694LgkA4LCORSNo7sijBmd39erOFzc/TtJSmkk53v3pPacWFIAWqQvpy7r7OMuYJr6gsjRx44LhCeQVo8Ev8MHBo9jA7Z7fySLiMfP6hcSC3ejgGQL+caJ1Mw8BDoC+zZRHcMnolcbX+l11EaqfcZ6udJJozMcEKCB6um8sX8C1XTcigVOhVJC4YLJahpQn30X73u8TbRp8FrZIBsBQ1Uj0PwevyznKGfVhoq8lxLPaQY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tm1uTGhES1p5OG5IbnJkL0JoQVpJbmcxVkgyYy9JbDRqN3o3dFBUTmR2cS9l?=
 =?utf-8?B?Qkt0ajh1dnNXalpWekNudm5tNGFCYTFJQys4SDVkKzYyL3o2OUwrOTBMMmZN?=
 =?utf-8?B?QzJoT0Vxay82K2ZSMzNhcTBzUTJJYjREUHlBbHYwV0x2MEZ6eTNwL2lPRUtD?=
 =?utf-8?B?NTBkQVBwcWIvOForOHZvTmdNUnBoTzg0RHVqbHpKSmUrTUM5d3FPcG1IVFhx?=
 =?utf-8?B?MWUwNTJMSzQ2eXV2VU43MnB5U2Z1NG1rcWhCRTF3SG1Uei93MEpKc293YmJ2?=
 =?utf-8?B?ejFYSjArSldsbjMyMzV2cnFyM3prR0d6UFNhaDBnV3VUZlhZb3VFbndhTEtr?=
 =?utf-8?B?ekFNWWlnMDNWNExmM3ZHQ0srVHV6d01VVVlOYnUyYUpzcHVYVjNkS1BGT29O?=
 =?utf-8?B?eUluRXF3RVk1cEdqQlF3OUZMU1ZWK2FDNlN4SnR1djJURHJ4OURVdVVId1Qx?=
 =?utf-8?B?ZkJjYjhORHAvaFBRRzEydS9iNDZrUnRxVWVhNVJjR20yWWRybE9DNjBLeUYy?=
 =?utf-8?B?NGt4eVQvZ0dkYUxZeFduOUVkazI2akxQTThtWGNRbUQzVm04Q3hNNDNCUDU3?=
 =?utf-8?B?bHZZbitRdHBGWVFucXFkMnVmRWJabFRGcWY1NkdsYUM2VTB2UDVleHUvL24w?=
 =?utf-8?B?NVZEUmNVQ0dWWDFFSEVmbk5Xc25lVEhkOXNRT1cyYmtHZDd5c0lsZW9Bc2pn?=
 =?utf-8?B?dzUzem9UancvKytHekZPaXc1QmlBakNMR2pSL2xqSXErMERxVHcyQVVzNXU0?=
 =?utf-8?B?UVBkcnBpRTc1TzVpZGh1R3ZUSUtzcGc4Z2ZzdmpnL3N0L2twS1hkN0svUE9p?=
 =?utf-8?B?WFlzRFc5VU1KVkRoamk0YnE2bDFNSUI1UU5talU5T3duMjNNSEQyS294TFVs?=
 =?utf-8?B?TVExdnplK2EvNmp3OVN0bWRLZUQzMUFjU0x4U2hsK3JWVnJRYlFWRWl0b2k0?=
 =?utf-8?B?bXozOGxwdkt4Z0lYK2l0a3hGZHdHTjYxR1FzVy80b0tYNk1FSlNSS1F3SHE3?=
 =?utf-8?B?bmljZm1iSmdJb2hTUXZRaDlGSHg4em9WOXJETnlxa0FMZEVaWGNDeW1nZ1pk?=
 =?utf-8?B?c0hoMEhabjZsdTZpWVBQb28wbU5NVkhrWXZHb05PM2dTdEFaUjU0WUdGaFNz?=
 =?utf-8?B?TUpHVTJLTHU0cmkxVXRVUEczU0ROaklqeTA1MDdPTWdhTk02RCtnTnZTUkNp?=
 =?utf-8?B?SVlCclRyZkVXRVowcFgwS2pFc3hYR0greFRiTUt6cjZ0MkhyYjVTRHFDR0or?=
 =?utf-8?B?dXRwU2JhWHJYWTVLOFY3ak43MTRxbXRwZHlaVjV0cTBpM2hRLy85Vi9yUTZp?=
 =?utf-8?B?dkkzV3pnVXgyOFBtQkY0dHZLVTVOWWJMd1ExT3h1K2kyei9FUjlBazRRZTVY?=
 =?utf-8?B?R3o4QjBUY2RnZVN2aUVqWjQwMFZNQ2FSaklleWk3L2Z2S1BvT2hXRjZGL0lk?=
 =?utf-8?B?dlB6VW02enlaNFQ0K3BPN1JBYllzQU9zbm9qVFVyV3Z0VnRQSkp4TWpEb2sy?=
 =?utf-8?B?YUk2QjFCUDVuMmhwMDRBTWpObWN0OE14SlVvZGZLMXQzb0xPUHU0UmJPV1la?=
 =?utf-8?B?WksrL3JRYXpBR3pLZEZGcEVpSzhwWkZBTGZBT2ZSY2ZDemd5elhPdDNVNDFz?=
 =?utf-8?B?b0xLdm52NmlIZjRRenI2bExQTzlDTW9vc2RIMHdWNWYrWnkrNWE1SkpCMmk2?=
 =?utf-8?B?Rno0bk1vOUVOTWlQWGt4SWRnRG5FT0NCN3hiNWZTaFZaQVhXeUFOWUZBRGEr?=
 =?utf-8?B?QVB4VmI3ZW1PRmRxMUZoTjkvT2RpazhOcDcyVUVNdGFDOWFsNjNkbUhtMnR5?=
 =?utf-8?B?SHJReDNsWUNNUnJrck1zTWFrakZpOCtoNzRFNUpoNDBJalVCVWhFUjJpQ1lG?=
 =?utf-8?B?SzI5VytCTVQzMlhJaktNSVhYUWp2Sm5vSkFKZXF0V21keWo4VWlmdkgzcmNO?=
 =?utf-8?B?dTF4QVZsdFNCdVc3YWQrK0VNVXo4RTFTMndqd2NmSWpjYWxHQm5EcHdhZVFR?=
 =?utf-8?B?VzJWa01FWEZlMWxRQSszZVRDTjVDUHJnNGx2d1FMc3ArdEM3ZGVwUUliL2tG?=
 =?utf-8?B?c0RwNVFpcTFocXpCcVFjZVlLWU5zSk5QMU9VU3JSMDZaV0pGd0cxOFpGanNw?=
 =?utf-8?B?TnppMGVPT200ZmFZSVdoQmZ1WkhMUEgzUHFUZUhGTDQ3dTFDMm10N1RkQUx0?=
 =?utf-8?B?L0JaOUhnVjNwOHZTRHZwYU0vSFJLOTV3RmZNV2R4YmxxVDVZTkpCVW94aDlE?=
 =?utf-8?B?V2txcC9QcFhOc3hMTEQ4SG9XVmwzYmFLYk9EWDBWNDdJWXdmTVkwNmx0U1FD?=
 =?utf-8?Q?2+ZuSiZ7cS8EkywoKx?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a3e0e0-86f1-46a2-1d5e-08df0d5670a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 03:08:21.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uANm1hDWqKbdA6QBapuZZfBMc1arZahgp7YUTvQy2HmMVlLhYbANhl6blUcGCQrSd7B71b8bZGxFH42IY7RyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7024

PiBUaGUgZGV2bS1tYW5hZ2VkIFBQUyBpbnRlcnJ1cHQgcmVtYWlucyByZWdpc3RlcmVkIHVudGls
IGFmdGVyIHRoZQ0KPiByZW1vdmUgY2FsbGJhY2sgcmV0dXJucywgb3V0bGl2aW5nIGJvdGggdGhl
IFBIQyBhbmQgdGhlIG5ldGRldi4NCj4gQW4gaW4tZmxpZ2h0IGhhbmRsZXIgY2FuIGNhbGwgcHRw
X2Nsb2NrX2V2ZW50KCkgZHVyaW5nIFBIQyB0ZWFyZG93biwNCj4gYW5kIGEgbGF0ZXIgaW50ZXJy
dXB0IGNhbiBkZXJlZmVyZW5jZSB0aGUgZnJlZWQgbmV0ZGV2Lg0KPg0KPiBSZWNvcmQgdGhlIElS
USBhZnRlciBhIHN1Y2Nlc3NmdWwgcmVxdWVzdCBhbmQgcmVsZWFzZSBpdCB3aXRoDQo+IGRldm1f
ZnJlZV9pcnEoKSBpbiBmZWNfcHRwX3N0b3AoKSwgYmVmb3JlIHB0cF9jbG9ja191bnJlZ2lzdGVy
KCkuDQo+IFRoaXMgcmVtb3ZlcyB0aGUgaGFuZGxlciBhbmQgd2FpdHMgZm9yIGFueSBydW5uaW5n
IGluc3RhbmNlIHRvDQo+IGZpbmlzaCBiZWZvcmUgdGhlIFBIQyBhbmQgbmV0ZGV2IGFyZSB0b3Ju
IGRvd24uDQo+DQo+IEZpeGVzOiA0YWQxY2VlYzA1ZTQgKCJuZXQ6IGZlYzogTGV0IGZlY19wdHAg
aGF2ZSBpdHMgb3duIGludGVycnVwdCByb3V0aW5lIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gQXNzaXN0ZWQtYnk6IEdMTTo1LjMNCj4gU2lnbmVkLW9mZi1ieTogU2hlbmd6aHVv
IFdlaSA8bWVAY2hlcnIuY2M+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlYy5oICAgICB8ICAxICsNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfcHRwLmMgfCAxMiArKysrKysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlYy5oDQo+IGluZGV4IDcxNzY4MDMxNDZmMy4uOTYwYjlmMDFjNTMxIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+IEBAIC02NzAsNiArNjcwLDcgQEAgc3RydWN0
IGZlY19lbmV0X3ByaXZhdGUgew0KPg0KPiAgICAgICAvKiBwcHMgICovDQo+ICAgICAgIGludCBw
cHNfY2hhbm5lbDsNCj4gKyAgICAgaW50IHBwc19pcnE7DQo+ICAgICAgIHVuc2lnbmVkIGludCBy
ZWxvYWRfcGVyaW9kOw0KPiAgICAgICBpbnQgcHBzX2VuYWJsZTsNCj4gICAgICAgdW5zaWduZWQg
aW50IG5leHRfY291bnRlcjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfcHRwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVj
X3B0cC5jDQo+IGluZGV4IDU2ODAxYzIwMDlkNS4uNTY3ZWEyYTQ2MTE3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gQEAgLTc3OCw2ICs3NzgsNyBA
QCB2b2lkIGZlY19wdHBfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQNCj4g
aXJxX2lkeCkNCj4gICAgICAgaHJ0aW1lcl9zZXR1cCgmZmVwLT5wZXJvdXRfdGltZXIsIGZlY19w
dHBfcHBzX3Blcm91dF9oYW5kbGVyLA0KPiBDTE9DS19SRUFMVElNRSwNCj4gICAgICAgICAgICAg
ICAgICAgICBIUlRJTUVSX01PREVfUkVMKTsNCj4NCj4gKyAgICAgZmVwLT5wcHNfaXJxID0gLTE7
DQo+ICAgICAgIGlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsICJw
cHMiKTsNCj4gICAgICAgaWYgKGlycSA8IDApDQo+ICAgICAgICAgICAgICAgaXJxID0gcGxhdGZv
cm1fZ2V0X2lycV9vcHRpb25hbChwZGV2LCBpcnFfaWR4KTsNCj4gQEAgLTc4Nyw5ICs3ODgsMTIg
QEAgdm9pZCBmZWNfcHRwX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50DQo+
IGlycV9pZHgpDQo+ICAgICAgIGlmIChpcnEgPj0gMCkgew0KPiAgICAgICAgICAgICAgIHJldCA9
IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxLCBmZWNfcHBzX2ludGVycnVwdCwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIHBkZXYtPm5hbWUsIG5kZXYp
Ow0KPiAtICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAgICAgIGlmIChyZXQg
PCAwKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBkZXZfd2FybigmcGRldi0+ZGV2LCAicmVx
dWVzdCBmb3IgcHBzIGlycSBmYWlsZWQoJWQpXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0KTsNCj4gKyAgICAgICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAg
ICAgICAgICAgZmVwLT5wcHNfaXJxID0gaXJxOw0KPiArICAgICAgICAgICAgIH0NCg0KYnJhY2Vz
IHt9IGFyZSBub3QgbmVjZXNzYXJ5IGZvciBzaW5nbGUgc3RhdGVtZW50IGJsb2Nrcw0KDQo+ICAg
ICAgIH0NCj4NCj4gICAgICAgZmVwLT5wdHBfY2xvY2sgPSBwdHBfY2xvY2tfcmVnaXN0ZXIoJmZl
cC0+cHRwX2NhcHMsICZwZGV2LT5kZXYpOw0KPiBAQCAtODYxLDYgKzg2NSwxMiBAQCB2b2lkIGZl
Y19wdHBfc3RvcChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPg0KPiAgICAgICBjYW5j
ZWxfZGVsYXllZF93b3JrX3N5bmMoJmZlcC0+dGltZV9rZWVwKTsNCj4gICAgICAgaHJ0aW1lcl9j
YW5jZWwoJmZlcC0+cGVyb3V0X3RpbWVyKTsNCj4gKw0KPiArICAgICBpZiAoZmVwLT5wcHNfaXJx
ID49IDApIHsNCj4gKyAgICAgICAgICAgICBkZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIGZlcC0+
cHBzX2lycSwgbmRldik7DQoNClNpbmNlIGRldm1fKl9pcnEgQVBJcyBhcmUgdXNlbGVzcyBmb3Ig
UFBTIGlycSwgSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gdXNlDQpyZXF1ZXN0X2lycSgpIGFuZCBm
cmVlX2lycSgpIGluc3RlYWQuDQoNCj4gKyAgICAgICAgICAgICBmZXAtPnBwc19pcnEgPSAtMTsN
Cj4gKyAgICAgfQ0KPiArDQo+ICAgICAgIGlmIChmZXAtPnB0cF9jbG9jaykNCj4gICAgICAgICAg
ICAgICBwdHBfY2xvY2tfdW5yZWdpc3RlcihmZXAtPnB0cF9jbG9jayk7DQo+ICB9DQo+DQo+IC0t
DQo+IDIuNDcuMw0KDQpOWFAgQ29uZmlkZW50aWFsDQo=
