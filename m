Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E037A494
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381584; cv=fail; b=JCRh8C+QAHH1zIzzf+aMPvDBy8oRYmO8Ko5HFQlX9eKf7hhq+ox6Fu+bgYynLBvnHTnzsyhaxUvhLFPmTjC3rSnx/AmL72sF43FFxipZOWjQMyv8AbYdeAjXliH8camqLg05+d6bgsUJEhPPpEkvoMIkLJ/OKsbuR/usnSaOMMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381584; c=relaxed/simple;
	bh=XgPPL157umtM5zzFpWUp2OLMCDHLGbrzRND7TUWL5PE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqOryln4pdb2i6vT7OQJi5UU0fdEmGCU3U+OCrgYU7FXJo3h3bXhWiKQ8i4DnUNbLsSHQ379haqUKocnM5vqBPArSez+puEGG9jMPf2BNNLVUc+zscmbxHYUFMjq1bg0G704MZi0mGOg0yzkXYbYLsOKrSEWvPlpavmIuPSrI3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZluQEDuD; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZluQEDuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcfTWsoRacYz9mUApIGHQ/suyU9GPfAO79waxi6/4NEBwsqtuUWm4Yi2dV7kv4LOQotTPcHvFKQWr9I8NrhlojQRT4pVUI7Tiilz1iSzhQi8vdOdbOltaDIScdYGx5I4Px2q+Q+srxNBsWWWwFT2tTiP3WYS9G/sHhYCP/GxnbVwLeAU75FVdln8RD6VaGOdo0nIyd4+rUXf24X+19OEG6J9l1ZdhtGYxoanbS7njfs6TKPmV330DU5Yv8V1bpLPA2pVpbYnKKbdPatK6mx3li74uvYq/0NaPgYod4jPwLh80IbdrqjzSi3F1fumxtUeuEOUQZB5lZox62IO9fFwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgPPL157umtM5zzFpWUp2OLMCDHLGbrzRND7TUWL5PE=;
 b=O1URSahKz7bOUrhmTuq84XuielX1ri0cRqdIxXEHXsiXojQM2pGeSCiTndkY8wWRFrzzOVhGdO7BzurX//278iqXqnS5O22IdGYHbChQg82CxfeqEDEA23Mq1T2aGiBySHMk8JQUgrNF4CRzkmWoX9XbBvI8iFIZYK08jOY6JXe00wqpKehUUeZDLeYE+KGbthZCrPyX6FDOcPwpNXASh0kGafZ15PK7D2Yguc4solxNlvdj8j+5Sc3uURVkrhZgT5Ft3WMYLLCf5RTgF9g9yiMyvbIGdeEa5ai0znPBS40IG13/I2lkwNt/RUr5EzcJ3tj8nX7PG2SnzaHl/f/DMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgPPL157umtM5zzFpWUp2OLMCDHLGbrzRND7TUWL5PE=;
 b=ZluQEDuDUdH/6N25js2OGhh02ZDrNN2b+od7sT/tRGS/Wh8I/vEfNDEd9ME0467slOIMJmYpume0uEv4E76kDnzGMpToZpKO292eknlFrFHa3M8zs6lCYC3WwuUGTaqgMuLHBh2NR3CIdy1xSHvCo64glvlq5b0KxwUGieWq41j51HPKAmQeiuOeNzV7eZpl4Ux2BbY7BqqfAo8tlU/ASogFtO2Yc89u0ZwPjwmCXpoTbug6Dcxt2h7ePbJuK96bihsGcFC06MjkdTPb9xn+tJfNCVYkfPNLlGpxDYRBX6rrW2Z1vL6ZtetO/3i6U20+i38gVXZXck2B/JcT9V7mug==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV3PR03MB7384.namprd03.prod.outlook.com (2603:10b6:408:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 03:19:36 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 03:19:36 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dinguyen@kernel.org" <dinguyen@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks
 and list corruption" failed to apply to 5.10-stable tree
Thread-Topic: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks
 and list corruption" failed to apply to 5.10-stable tree
Thread-Index: AQHdH15E68RJFG08u0CnKsfS7qcn0raFZcIA
Date: Thu, 30 Jul 2026 03:19:36 +0000
Message-ID: <9edf35f6-433e-44be-81e5-29110abbd2c4@altera.com>
References: <2026072955-cranial-friend-2d3c@gregkh>
In-Reply-To: <2026072955-cranial-friend-2d3c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|LV3PR03MB7384:EE_
x-ms-office365-filtering-correlation-id: 97082a07-9d0a-472a-5dc3-08deede9626d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|4133799003|56012099006|3023799007|11063799006|10067099003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 PXGsdC5vi8xX0L/qN57WQcpM0BwgJBXWSvLteotkbZkf9ZavaaT1SgD+Qzi2eW6e4rNlRztMfUCYgElO+nLPRUFPV9oEM4QwBT45DFPk+dqWy1nmz6CTD5yKZ61CNtVrR5fpeJkdtqy1Tc2GZKp9YjC6TrE85eLk1iEh9w48EmmQWLxIPOmo+sk6FF2gzRili+BJoiDGvumSGhFyIOc/nhdzFlpcll5SO5yXVCbd2gc9f7JY/8wQKnWgknLtPCPG7thYCWM51yefHUYNcavi3HKhRtsrTNEOX26tr1z6EvBgVsCxJPB4CjQu4JFa6cuq6xFSIqNRoWR9W8CmA3M9WwFiksHtlxUIPpUoXzvBz8EIp+tlGFMPljBnCTY3ydwIfYfFVypdVEHXxECQMPfw1fOsXYXmc2tvb3z1LwT9PHcMX+2DMzpdQT6nU7t0EgK2SAAsb0QnAjn/OJo/MS5viHjTgi8IAD/UR1snVVWBD62ER0ElTAn2wNqAkTpkF/r2aukDZdDmfBOLoI9Z08u3GSWQlw97PuDkgOzLpxvMzNAlmZibVSLMiLQVhESPuIlYHqn/Kg3EvkDm9QeouySngb1RJ3qkHmLsTN8/6rzpWwiZWpF2OKNYqSSpILIED3MhBJLhre2Cf6tQLjSdQUgKjjsdb50muH7BAq0blF4MxYtL9yzIid9b/V9lcLvrX65FODzP1ehj+bFG5LBLEMkWDAjN74NcTcuaUic+Dv+YfuM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(4133799003)(56012099006)(3023799007)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlQ2c1hCR2ovTndyeVJWdEJOUVJBMHE0eVE0cDhHVGp5SUVCNzVwdytoUkpS?=
 =?utf-8?B?alZqU21LbHMraGIzTkQ5elJ1N0ZEKzAxZU5HUnRWeFFCOGphOGZ6TnYzTk1W?=
 =?utf-8?B?dlI0aU9JSXhkcjBMYURhb0M3eTY3TGUydTlLemlxNjNIcmxEUHRuaWFMUXdv?=
 =?utf-8?B?QlRkMEtRaXVYblZkUy9FZkh5U1dKR1NYNHBwbFZIbnoyRU51cytvb0t0alow?=
 =?utf-8?B?dXBSRHlmMyszMTlwSk9PWU9EcE5iUGRIbUZ6YTg1Z0VGY2kvQ0Z1RzNZajRO?=
 =?utf-8?B?eEZmMHJXMC92L2RmQko3VFRHWG5IWGZXek5xU1NpT3BFdzhQaGkxNjVlckkw?=
 =?utf-8?B?cmRYTFpvVkxUWStYbk5TckxQdWlyZ2M2RWN3WG9QN1o5WEJFK3ZLRU9NL3NW?=
 =?utf-8?B?eGh6ak9BNFFhMTl5b3c4NkZIQ0I5VWxpRlJzK1F4Yk8raktlT1F0Y01yRHJO?=
 =?utf-8?B?azdkQlFzMVpOK2FRYU13allSMHJDZ05FV1liS1pUbnB4UE4xMW1zSXZpdnRl?=
 =?utf-8?B?ODVQTkQ3Y2Y3NXNlT0RMVTVUenhMRk5rVUZZeVlEMFRyNDVuNlpoTFpMKzJx?=
 =?utf-8?B?cndUZi9wR2VEZFc5OXY5YjljeTJ2Qk9yNnJ1WllLSlcydHlQWHZLdys1bUJt?=
 =?utf-8?B?QncxcXFtOERtdWJQcGZhRnlMU0ZGNUsrekJ6bDBnY0NxdFZDSlpkRzNlcWR1?=
 =?utf-8?B?UEorcG1qZzBYUTdQM2tEVzM1VGw1TW1nQVZrM3h0NkNMbm56cURmaFRweHA2?=
 =?utf-8?B?bkh4WHNBdGpyT0VzaFlSYWlwVnlPTTFtNjRhZTh1anM0TXVtU01HT0V2dElU?=
 =?utf-8?B?WWcvV3Z5NHNzWFI2QmpUMUMxdW8xVDJYTUQ3RmR2Yk12MWhpaWdjUDAwaVJy?=
 =?utf-8?B?WDBDYnJnSlpkcTJBcWwrTzNxdHE5RHVYMGNaYnFjSGFzdFI5TXJzWDd5QmpB?=
 =?utf-8?B?ait5UFQ3V0Uvbm8vRklRNXdvUWVzeFI1YmFZY29DTGg4aUFTN3BMK2tJcm5u?=
 =?utf-8?B?cmYzZndXOTU1Uk5LUGxTT1VSRVRaOTBLbkdNOGdTTFNjSGx0ZzNXUVk1NlZR?=
 =?utf-8?B?VUJQZmZrOXFUVkRxMFZZQjNJWW5pTWZ0SUZLQzA4STJOZHVzT1JNSDJMMmVk?=
 =?utf-8?B?am1EM2w1NnRyczBoU3B2YlpHRXUvaVpGZDMwTkNzbHZzMzVMV1BrT09KQWZN?=
 =?utf-8?B?cVNjTzg5VTk0cExPUFgxVkhXbUd0cTJabmFtMTNiaVNja2pld0VFUFJ1Nm1O?=
 =?utf-8?B?VHpHNjI3QXovNFhNb2tzb2hZSm95VkNzWXRJRGtqNXpVK1ZNbytQdWxURXp3?=
 =?utf-8?B?aDJSY1RLTUdDbWRlYklETUJORlJ4NlZwU2ZZcmVNRWxxQkd0bm41eUJLV0Vt?=
 =?utf-8?B?elNxb1NCYTRDZjRBS1oybzNsb2RPMHRCSU9mWlM2a3p3V0pJRlluNFcwd3BW?=
 =?utf-8?B?VGRqb2hLbStXV0RubmlQZU92Snk0VVdFaG1aaWhoL2pleldUZVppbkloVGha?=
 =?utf-8?B?ajZKbzBNZ29ZUTZhSUI3bDFrLzg1VTg3RkFpc1RwTEJoMm5ZaHFrKzVqVG12?=
 =?utf-8?B?MXdKZm9ZMWxGaDZQNkpCSVpzNWJnLzVtUEgyV1hQaU9hUVArZmRwQStxMndJ?=
 =?utf-8?B?TzRFeHM5VEEzVGoza2J6cm8wTEJUbDBHSFFER2d6SFpLcm1qMkk0VDJhTito?=
 =?utf-8?B?TmNBT0dTWjZ4REtlTnR1aEYzUGpOek1RWGJZOEV3LzdBVzlBNHRLUncreW1y?=
 =?utf-8?B?ZlF0Uyt3Y0tKcWMrd29JWlNScnVBMzBYRjhLZ3JpN0pGR2lYL0lzekNaRWFk?=
 =?utf-8?B?ODBLRjc3Mlo2Ti8vK1lkTzVPNTcvem9xTFFZQms0MXgxd25Xci9McERQdU1n?=
 =?utf-8?B?K1BqVHhIMi9sREVVRmhZdldkWVdPZnVpM1RmKzhUVDBDWE04ZlRuaVhEMmt6?=
 =?utf-8?B?Q0t5b3BkczhERUc1N1lNM0NLQjVZcnV1dUMwekhLazNHNkZ5SVRwWEYxZVRi?=
 =?utf-8?B?Q3laZ1htOEM0akpMZXVpZ01TQVExS0RJYWp4TWxuaURMTWZDTlkxbllLb0RZ?=
 =?utf-8?B?bGtKemsraDkrZHFJSS9xSEhTNWpZQm9nUS83T28vTGRFdGcyeTdBWS9pK1lP?=
 =?utf-8?B?ZVBreHpNMkJ0b2JqdzNDcWxzeXZmTGowRGltT21qSnBQcFV4SXRjdzZEK0hs?=
 =?utf-8?B?WktxaE9WM243bXRud2tLMFBaV3RnK1JGQ0E1NU4yOWo2K01TU09ZVENaRy9z?=
 =?utf-8?B?S3l5aXRJZEdoSGhqazJ3VTNtNUVFZi9nS2paN2xPdkZIR3hyQUdMWE9qdHFo?=
 =?utf-8?B?UEt5WVhyN1BXUzI0V0JEekE1L2V3WVdoMWNMNmFmRTk2a09UU3lFT2RtRFhu?=
 =?utf-8?Q?ZC4vytskx88nhKSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <789076F330A33F41B87A164376411EBB@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97082a07-9d0a-472a-5dc3-08deede9626d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 03:19:36.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wxMp8Xt/u06mNhbQfAXuodEH0dAnY+pCL/IuWrU3zg2zfPhUIHmY3HQit6pe33Q/JFUxN3+EzYK8xL+nupf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7384

T24gMjkvNy8yMDI2IDk6MjggcG0sIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0K
Pg0KPiBUaGUgcGF0Y2ggYmVsb3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDUuMTAtc3RhYmxlIHRy
ZWUuDQo+IElmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90aGVy
IHN0YWJsZSBvciBsb25ndGVybQ0KPiB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3Bv
cnQsIGluY2x1ZGluZyB0aGUgb3JpZ2luYWwgZ2l0IGNvbW1pdA0KPiBpZCB0byA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4uDQo+DQo+IFRvIHJlcHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3Vi
bWl0LCB5b3UgbWF5IHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzOg0KPg0KPiBnaXQgZmV0Y2gg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC8gbGludXgtNS4xMC55DQo+IGdpdCBjaGVja291dCBGRVRDSF9IRUFEDQo+IGdpdCBj
aGVycnktcGljayAteCA5MTE5Y2ViNzZlOTg3YzJlYzJiNTQ5ZWExMDBlMzI2OGNlM2ExYzdjDQo+
ICMgPHJlc29sdmUgY29uZmxpY3RzLCBidWlsZCwgdGVzdCwgZXRjLj4NCj4gZ2l0IGNvbW1pdCAt
cw0KPiBnaXQgc2VuZC1lbWFpbCAtLXRvICc8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4nIC0taW4t
cmVwbHktdG8gJzIwMjYwNzI5NTUtY3JhbmlhbC1mcmllbmQtMmQzY0BncmVna2gnIC0tc3ViamVj
dC1wcmVmaXggJ1BBVENIIDUuMTAueScgJ0hFQUReLi4nDQo+DQo+IFBvc3NpYmxlIGRlcGVuZGVu
Y2llczoNCj4NCj4NCj4NCj4gdGhhbmtzLA0KPg0KPiBncmVnIGstaA0KPg0KPiAtLS0tLS0tLS0t
LS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAtLS0tLS0tLS0tLS0tLS0t
LS0NCj4NCj4gIEZyb20gOTExOWNlYjc2ZTk4N2MyZWMyYjU0OWVhMTAwZTMyNjhjZTNhMWM3YyBN
b24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogVHplIFllZSBOZyA8dHplLnllZS5uZ0Bh
bHRlcmEuY29tPg0KPiBEYXRlOiBXZWQsIDI0IEp1biAyMDI2IDAzOjA2OjM1IC0wNzAwDQo+IFN1
YmplY3Q6IFtQQVRDSF0gZmlybXdhcmU6IHN0cmF0aXgxMC1zdmM6IGZpeCBtZW1vcnkgbGVha3Mg
YW5kIGxpc3QgY29ycnVwdGlvbg0KPiAgIGJ1Z3MNCj4NCj4gRml4IGEgbWVtb3J5IGxlYWsgd2hl
biBnZW5fcG9vbF9hbGxvYygpIGZhaWxzIGJ5IGZyZWVpbmcgcG1lbSBvbiB0aGUgZXJyb3INCj4g
cGF0aC4gU3dpdGNoIHBtZW0gYWxsb2NhdGlvbiBmcm9tIGRldm1fa3phbGxvYygpIHRvIGt6YWxs
b2MoKSB3aXRoDQo+IGV4cGxpY2l0IGtmcmVlKCkgaW4gdGhlIGZyZWUgcGF0aCB0byBtYXRjaCBp
dHMgbGlzdC1tYW5hZ2VkIGxpZmV0aW1lLg0KPiBSZW1vdmUgdGhlIGVycm9uZW91cyBsaXN0X2Rl
bCgmc3ZjX2RhdGFfbWVtKSB3aGljaCBjb3JydXB0ZWQgdGhlIGxpc3QgaGVhZA0KPiBvbiBmYWls
ZWQgbG9va3Vwcy4NCj4NCj4gRml4ZXM6IDdjYTVjZTg5NjUyNCAoImZpcm13YXJlOiBhZGQgSW50
ZWwgU3RyYXRpeDEwIHNlcnZpY2UgbGF5ZXIgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcgIyA1LjArDQo+IFNpZ25lZC1vZmYtYnk6IFR6ZSBZZWUgTmcgPHR6ZS55ZWUubmdA
YWx0ZXJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5l
bC5vcmc+DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgxMC1zdmMu
YyBiL2RyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXN2Yy5jDQo+IGluZGV4IGMyNGNhNTgyMzA3
OC4uNjMwNmI3OWExNGExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgx
MC1zdmMuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgxMC1zdmMuYw0KPiBAQCAt
MTg1NywxNCArMTg1NywxNiBAQCB2b2lkICpzdHJhdGl4MTBfc3ZjX2FsbG9jYXRlX21lbW9yeShz
dHJ1Y3Qgc3RyYXRpeDEwX3N2Y19jaGFuICpjaGFuLA0KPiAgICAgICBzdHJ1Y3QgZ2VuX3Bvb2wg
KmdlbnBvb2wgPSBjaGFuLT5jdHJsLT5nZW5wb29sOw0KPiAgICAgICBzaXplX3QgcyA9IHJvdW5k
dXAoc2l6ZSwgMSA8PCBnZW5wb29sLT5taW5fYWxsb2Nfb3JkZXIpOw0KPg0KPiAtICAgICBwbWVt
ID0gZGV2bV9remFsbG9jKGNoYW4tPmN0cmwtPmRldiwgc2l6ZW9mKCpwbWVtKSwgR0ZQX0tFUk5F
TCk7DQo+ICsgICAgIHBtZW0gPSBremFsbG9jX29iaigqcG1lbSk7DQo+ICAgICAgIGlmICghcG1l
bSkNCj4gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4NCj4gICAgICAg
Z3VhcmQobXV0ZXgpKCZzdmNfbWVtX2xvY2spOw0KPiAgICAgICB2YSA9IGdlbl9wb29sX2FsbG9j
KGdlbnBvb2wsIHMpOw0KPiAtICAgICBpZiAoIXZhKQ0KPiArICAgICBpZiAoIXZhKSB7DQo+ICsg
ICAgICAgICAgICAga2ZyZWUocG1lbSk7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIo
LUVOT01FTSk7DQo+ICsgICAgIH0NCj4NCj4gICAgICAgbWVtc2V0KCh2b2lkICopdmEsIDAsIHMp
Ow0KPiAgICAgICBwYSA9IGdlbl9wb29sX3ZpcnRfdG9fcGh5cyhnZW5wb29sLCB2YSk7DQo+IEBA
IC0xODkwLDYgKzE4OTIsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChzdHJhdGl4MTBfc3ZjX2FsbG9j
YXRlX21lbW9yeSk7DQo+ICAgdm9pZCBzdHJhdGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KHN0cnVjdCBz
dHJhdGl4MTBfc3ZjX2NoYW4gKmNoYW4sIHZvaWQgKmthZGRyKQ0KPiAgIHsNCj4gICAgICAgc3Ry
dWN0IHN0cmF0aXgxMF9zdmNfZGF0YV9tZW0gKnBtZW07DQo+ICsNCj4gICAgICAgZ3VhcmQobXV0
ZXgpKCZzdmNfbWVtX2xvY2spOw0KPg0KPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBtZW0s
ICZzdmNfZGF0YV9tZW0sIG5vZGUpDQo+IEBAIC0xODk4LDEwICsxOTAxLDkgQEAgdm9pZCBzdHJh
dGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KHN0cnVjdCBzdHJhdGl4MTBfc3ZjX2NoYW4gKmNoYW4sIHZv
aWQgKmthZGRyKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2ln
bmVkIGxvbmcpa2FkZHIsIHBtZW0tPnNpemUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgcG1l
bS0+dmFkZHIgPSBOVUxMOw0KPiAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnBtZW0t
Pm5vZGUpOw0KPiArICAgICAgICAgICAgICAgICAgICAga2ZyZWUocG1lbSk7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAgIGxp
c3RfZGVsKCZzdmNfZGF0YV9tZW0pOw0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChzdHJh
dGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KTsNCj4NCj4NCg0KDQpIaSBHcmVnLA0KDQpUaGFua3MgZm9y
IHRoZSBkZXRhaWxlZCBzdGVwcy4gSSd2ZSByZXNvbHZlZCB0aGUgY29uZmxpY3QgYW5kDQpyZXN1
Ym1pdHRlZCB0aGUgcGF0Y2guDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcz
MDAzMTYzOS4xMTQ1Mi0xLXR6ZS55ZWUubmdAYWx0ZXJhLmNvbS8NCg0KVGhhbmtzLA0KUmVnYXJk
cywNClR6ZSBZZWUNCg==
