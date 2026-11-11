Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794398699;
	b=5R04uWmBkT9cYqsIJeZoezCYmK3ls0NVFz/kVzn2tACMJZTRQkuFJsXOg58FmkHhqcCh
	 5jFpJkyquQEgoXYo8NLtc1Krwk018+BUtzb6gHsMYvlh804wsBi1vLhk3+tBFiVV/hhrm
	 96qt0RVsy6XzU9eIHjVMPcTJc19/fl9hbp1zMA/akI44c/iojfPjajWYbmKGc3YCYEtRS
	 Qtmmhxu0s15O3bOHwptsKE8CWdggyrL59f8QaLvUoxfV72Jh1v/bQDyWUIq4L1QF9kZMh
	 I9W/UeTyqwnYqVfTM3tY1C+0/WenWAsJhU9FH2FmUfWPIqMJgMeESJPiSbzjRCamohw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398699;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CF+DqD2xCesXgyHmKMz5bp10TgYao4eGMBi6k2IiXVM=;
	b=SoO/x6Kk+XEGArNHzJezZEus2jnbUwcc0yAf4/xHscBYzdRXEHoU4gD8zkF4OL2fEOAZ
	 e2v/cCJzBJ0c++PM/kfSdEVxdreWWQZwHP/x2lbQq68S0TKnsU84brj1gGZEdqJOh+1cB
	 4jD1Vcvbdo/rqtpvldRQ2+wkPnY0PfgDMAuvvWFasCSXhB2mxr60+CVXlro2tc6DJiK/U
	 JIPxOwGhVl7a5/IeIrP3JYnGxTS8GxOi+J91N3dhwkVVp4oDgdBJDFJLvszJX2+JnbLZR
	 /Ov3YxDArG0ndo5bewCXBc0HFuYcSEDMSCQLnBZxt7AehvP6JaFMTD4BzD7CLduUhng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebius.com;
	spf=pass smtp.mailfrom=nebius.com;
	dkim=pass header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=glSsS9h7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.138
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023138.outbound.protection.outlook.com [52.101.72.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB2606A31C;
	Wed, 11 Nov 2026 12:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDB2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=glSsS9h7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDyyIJZFoBALWCeV1nUJynhblCcRUe3b5kY7wVMizsYQaeWkIdu80HeOQFE7JORojZugcS16oAzQyZzKmdWfGWUJZ2v8YaUdIFCO3J9OY0YJ3pJvFQrxzEhW7XH6J484t1wpCJ9YqvKJOcTQk9qdnG2jXjy/aBhtzgWKnSKcmg42XI+dtd0balzPblO+VLouS9ESE1rnlp3GXXUvjlQuqHUxEPpqqWAhbyyRx7QAPanRfRYpR4zWIk/UGYtZGVqirzn8ulfCmwNnQzqoF7j6LPrUCOrg8xk74j/k0kZo0LB0QLvuv1Y+QIO0PFt8Oc52bsiLoFyYrbv7Z/Kv3G4knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF+DqD2xCesXgyHmKMz5bp10TgYao4eGMBi6k2IiXVM=;
 b=mXpH88YEW5Mqeh0JZYUp+2t+z8dWBe3XFdomVdbq/lt4q6HnHnWuPqB4HLqdNITwwxua1X+nBEGvy6eLZ70FhBNcPYBOHHmWIYSEGj+nX6ydFyRFXilbTLk+iG+F1rfJhI+fdq2yNi//GdUZPUm2yIv3TN74NljASNca/OX1yBzGd9eXHZkaKPaGWAv7o4IFrSNMqZfpji+lbW41Ep8R9dp+H/7imObya58e4wJ9DLH95BjuVVqArN26vzSfnbDgVfDiYIOwskY0fcxFEcL4uNWEVRqO1RtMHyqWro4RzVBxzwilWFr9jK9E4It4meH0/OFronG/f0AVQVgp1BthZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF+DqD2xCesXgyHmKMz5bp10TgYao4eGMBi6k2IiXVM=;
 b=glSsS9h7EgTb/yVnua3oiijbduf3ter0J5LHu8KYmqpEn7360+OtX+/BHR20OLHj6oW8buR+apCNbiRwRS6Xy6kiAD2v8aYzNtOd7cbAfffjEvi4La5ddZjZ3Flti3sg9Od7dr1elsJ1ApB1DURsiYvZo1wide86FHVaLUH/0/85ZAxyln3YAHRVT2orW90vTTpIrtnxz/LifQemZy9kO6P7U3LL/+S/FwyNu3QiM3SpI6+t6+NkgSBG77DUgJTPRLem53sdyf0PTSGdhQhfCYny/eZGKwRZwCzIw8zUyYyx7mpDAcxnQDJOFRDjMzgUwBmcL+g0FUDeH88IYZat3A==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DB9P190MB1700.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:327::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Wed, 11 Nov 2026 12:04:52 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::dd36:a393:54ee:b1d8]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::dd36:a393:54ee:b1d8%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:04:52 +0000
From: Dmitrii Iakunin <zeil@nebius.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NB-Core
 Team <NB-CoreTeam@nebius.com>, "Michael S. Tsirkin" <mst@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
Thread-Topic: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
Thread-Index: AQHdcdTbhlFqeWOUmkGjLbQOKwfmhg==
Date: Wed, 11 Nov 2026 12:04:52 +0000
Message-ID: <20261111120448.49979-1-zeil@nebius.com>
Accept-Language: en-NL, ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB1860:EE_|DB9P190MB1700:EE_
x-ms-office365-filtering-correlation-id: 68dbef2f-8574-4201-2bec-08df3febfe39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|38070700021|261028144727099003|5023799004|11063799006|56012099006|261009223027099003|261026121527099003|261021121427099003|261026140227099003|261022075727099003|261022105027099003|261102130727099003|261102123227099003|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 OdaIY2jLfjBXZsGN42GLQesg5oKHwBvFCVQ2rQIvDyo4PCCC839N9WMuIIXkybFYqa/pl6cFFy+/TuRVnxy8yMV6IcOuonMi4cgvZ6x4ZmyKD7fXS54D4n8SkU2iSwjzsxmERzkAkya3GAs0t//zEiuPctEXh7KYbamnrODfBoLlVCk/YkTo7TUEraQGhjNjcA3MvwCJo3p48o6BIO4IsywrQLlpkEhCv5gDDsTnzghwDSIwbkY4TG2vaWh7lAIYWKAcwfBwap/n/bA47xqjAeGhg4QtbUqOlMUPCHUNCZUUMtP6kfmBZdQUOnf1fP/vQxq/TCJwM8AuxeVqV4dTmZHUPctkUBiCT4SGXt0TaODYHWxW93G0Rr5uXm/PWK9O/LMxD1nriB/VkROC1PAw5y4uFP0YhXwO526d/kxhTCP0eE0Wn28c82QgWULWejRh5qcvghfDwtgkSdGO/uwP+GxCLMz1mdCg3/mgwLFddzMuk3SpnXUrPGXF5bCC1lkYFsLULArgYsMzJlJp7+CMD6JzQ+IGL2WmPJe3Z1TrkHK9WXmWkvqEaxUn7HAf+h02N8IiNiB/e+JPzDnlt7JIcmJNlzlB2hofBzmJjxZk743PYUI/DRHW4aDv2AiopBhOhlcisjIUKNaYy+Exd4sApuWt2z4Mk1fZNhWnjvT8Qqs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(38070700021)(261028144727099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022075727099003)(261022105027099003)(261102130727099003)(261102123227099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUMxaXhzQitwd1pWVWJ3bncvZFlkSEdIMU1sVmg2VnhGNGZsV2FPMGRuUVIx?=
 =?utf-8?B?UE9NZVl3T1YxTkdjYytOQWJtNTFYbmZqYTFLWGc0NCtiZjFvNWhFZDl3bzlQ?=
 =?utf-8?B?N0NMSnltUTNuM2VucHRCOGU5U01GUDB4WDFKRFNHcFpHRUNPK3c0OHE2TWlm?=
 =?utf-8?B?b0JDZk45U3Y5SEY3SGcwSWxTSzdzRU0rdTBsWkFSU1VTWnB3MXVMS3JWcnls?=
 =?utf-8?B?cm04bjA4L3pMRnpKSkI1aEdWZis1ZXFibFNOeXBzZE1pOUhHUHJWR3VWbWpT?=
 =?utf-8?B?UVJuSTc4V3dZQU5iZW9hMDZxYmVON2lmL2tmODA3dXNSR3BWRTU1TWJhSGVk?=
 =?utf-8?B?cTZvSGtsd0dBUDdtdnQrbTBRbThKTjJjTWJOTkRJYmZWY2JpRHo2aFJJTnls?=
 =?utf-8?B?bThIR2UyblkwT0lFRisyWkk0QXBSd0RoK2ZoM3JIOTVsUlQ3djh4T0wva2Ix?=
 =?utf-8?B?aTluZXFDNmJScjFHWnpxSGtwOWdjR29YQ3ZDaUhSTHhNZWhLckZOMElSdlhK?=
 =?utf-8?B?NlZYd2ZOdTBjZCttYStrTENsbHZVSnNyT2JyWmRqNTN1Z1JHcFVKeTF6WEEx?=
 =?utf-8?B?VFFyU2ZaRjZicys4WE9tRitxa09YY3dEZGtPTWc1amducUpURjZUMWZGZlFJ?=
 =?utf-8?B?SCtITjBTWXZkbkxrMFRBNnZhcGFuUFFOdm1DMWZOdENXMkhWeUlLN2RWeWZs?=
 =?utf-8?B?ZVp0cTBjU1dBVnZtYjgvTzJxL2ExeXdqd1hJdmJ0NTZGYWhkUjVrTFI4Q0pk?=
 =?utf-8?B?V21MNVRlYi8yeDJBOGZQNno0YTNUeWttUkhoTnl0UlZXS0FCaStMQUpKWFdj?=
 =?utf-8?B?MmVhMjVpcko2cTNGLzYvWmxvcVMvWUNPQ1ZHYmRKaDEvY0I4QW56Z0svV3dk?=
 =?utf-8?B?azNCYllGQWlWVDEyOEszMWZ4anB6TWVORUNRUWJ3YVNxUzBxNHhhMXpGd09j?=
 =?utf-8?B?TlNrVFFST2ZhVERzOEJ4MmIzb1VRY2FicFhjSmxDcnorekUvMHp3TjNpK3ky?=
 =?utf-8?B?czJsY3A4b0dKVDVOSTUzejd1ZEViK05kMUJjeXZpTWErVmw5MCtWbm94RTIv?=
 =?utf-8?B?L3RwNXZyRDNqZHljbitOaTdaSCs0SG9MNUxZVDdsOFZUNzRqTzNRdUtaNlFZ?=
 =?utf-8?B?VHphWkxUT05Oa1FrUGhocTVBWlBOVlM1U3pNQ1ZMeXY1N0ovUFlmUk93ZkY0?=
 =?utf-8?B?akhLbWxzSmloRFRGaG9hUkxYcWZiNU5HaWNuSXhCNWtOQTFiOWtjcmVpMW5Y?=
 =?utf-8?B?K0ppTmtCb1dvd3FBbE1YdDB1VEVjY0YyRThXdDRvamx0ckp5RE1HcGdoV3RZ?=
 =?utf-8?B?Mk1wMGE1eDF6YlRKZEF3ODBYWHU3WGVnR2FabWVudDZuS3BWTnBRSG9aUmwr?=
 =?utf-8?B?cElXbW9ZTjN6U2tHT2hzdlgxeTBPYUwxR1JWaHArMDFrV2oybm1vU09leENF?=
 =?utf-8?B?UURsSnZiSVlDc2ExZzF0SmNDTmdwSlc3VnZTQlZHL0ZnTUg2RGtrQy8ralJS?=
 =?utf-8?B?d05kR3BuWVU2dVkxNlVEbVhKMWIvdGoza3ovTGZPSURwNmVLU3ROdHlPMXR5?=
 =?utf-8?B?WEUvVkUzcEc0d3RJejdRZTBGTndBeTU0akdoWWJ2Y29UbG9lTndObkJNWDdX?=
 =?utf-8?B?cE9PcVlyOEQxb0tUSlUxS1FyRk1XK2J2SG1mdmcrWlZNQThZVUpoKzEyS2ll?=
 =?utf-8?B?RXlMNEJuS0JVbW5NWHFpQ3BTQTdydWhqMC9nZkRyVlB3dnZ1Yjd3TjZyZXJt?=
 =?utf-8?B?SStXSHUybk5DNkgwTkdtUFFmSUpTTTA0dzFHaTU2WEwvOUEvaENPbGhnaitP?=
 =?utf-8?B?Sit1czhnSVB0T09GUnlxdXBNTEtPR3pNT3JHMGtpU2FnQzd0aU92S2FIYzE3?=
 =?utf-8?B?OU44MXZBaWhoM0RHcmJqMFJGSmxNczlXVlNpNGNkNXpLTU1EbHQrM3hUdkFX?=
 =?utf-8?B?S3BKR09ZSG03bEE4Q0NwQ1FXQWhhQnE4blE2Nmd0U0lGYXZtRmZOMCtJNWVM?=
 =?utf-8?B?dzUybCs0WjNJMU5VT0Q3ZjZpU3R3YnBxY3YzZm5lMVBXSVJtN2N3VCtXTDVZ?=
 =?utf-8?B?MnN1WmczVmlHRlhpTlhHQ1lkeGswZVdwKy9kK2kxUVc2TEU2SGJRK25Eampz?=
 =?utf-8?B?c0JCR2ZxRHNqSFMwVDF2c2F6TU0xdm1PWlNCV25mY3JRVjllRGw0Yko0SDNO?=
 =?utf-8?B?R1B5TkYzL1JBeHhWN0RiY1VOaU96REpkVEh3NzFrMmg0MUZMWHg3dlh5VEtN?=
 =?utf-8?B?Q01ZTjFuTzNyTk1hcXMrV093b0hKcnAzUFNGMmFaZmkrU3o3MWM5MGEzaUlZ?=
 =?utf-8?Q?yybZMZTlAEZBvOjjeQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dbef2f-8574-4201-2bec-08df3febfe39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 12:04:52.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wf15Gusx2FkXAJUFgpcYEeJJPTC9iSw7BNdJMlwIQjCUBNttvEkWZ6k8Yh19h1vM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1700

Q29tbWl0IDY3ODUwMTFmOGIxNiAoImlwdjQ6IHZhbGlkYXRlIGNoZWNrc3VtX3N0YXJ0IGJlZm9y
ZSBjb21wbGV0aW5nCmNoZWNrc3VtIikgYWRkZWQgY2hlY2tzIHNvIHRoYXQgbWFsZm9ybWVkIENI
RUNLU1VNX1BBUlRJQUwgbWV0YWRhdGEKY2Fubm90IG1ha2Ugc29mdHdhcmUgY2hlY2tzdW0gY29t
cGxldGlvbiB3cml0ZSB0aGUgZm9sZGVkIGNoZWNrc3VtCmludG8gdGhlIElQdjQgaGVhZGVyLgoK
c2tiX2NzdW1faHdvZmZsb2FkX2hlbHAoKSBjb21wbGV0ZXMgY2hlY2tzdW1zIGluIHNvZnR3YXJl
IHdoZW4gdGhlCmRldmljZSBmZWF0dXJlcyBjYW5ub3Qgc2F0aXNmeSB0aGUgcmVxdWVzdCAoZS5n
LiB2aWEgdmFsaWRhdGVfeG1pdF9za2IoKSwKaWVlZTgwMjExX3R4X3NrYl9maXh1cCgpLCBvcGVu
dnN3aXRjaCBxdWV1ZV91c2Vyc3BhY2VfcGFja2V0KCkgb3IKcHBwX2JyaWRnZV94bWl0KCkpLiBQ
YWNrZXRzIGJ1aWx0IGJ5IEFGX1BBQ0tFVCB3aXRoIFBBQ0tFVF9WTkVUX0hEUiBvcgpieSB0YXAg
d2l0aCBWSVJUSU9fTkVUX0hEUl9GX05FRURTX0NTVU0gY2FuIHJlYWNoIGl0IHdpdGggYSBjc3Vt
X3N0YXJ0CnRoYXQgcG9pbnRzIGluc2lkZSB0aGUgSVB2NCBoZWFkZXIsIGFuZCB0aGlzIHBhdGgg
d2FzIG5vdCBjb3ZlcmVkIGJ5CnRoZSBlYXJsaWVyIHZhbGlkYXRpb24uCgpBdCB0aGUgc3dfY2hl
Y2tzdW0gbGFiZWwsIGZvciBJUHY0IHBhY2tldHMsIHJlcXVpcmUgdGhlIGZpeGVkIElQdjQKaGVh
ZGVyIHRvIGJlIHB1bGxhYmxlIGFuZCByZWplY3QgY3N1bV9zdGFydCB2YWx1ZXMgdGhhdCBmYWxs
IGJlZm9yZSB0aGUKZW5kIG9mIHRoZSBJUHY0IGhlYWRlci4gUmV0dXJuIC1FSU5WQUwgc28gY2Fs
bGVycyBkcm9wIHRoZSBwYWNrZXQuCgpVbmxpa2UgdGhlIHNpdGVzIGFkZGVkIGJ5IHRoYXQgY29t
bWl0LCB0aGlzIHBhdGggY2Fubm90IHJlbHkgb24KZWFybGllciB2YWxpZGF0aW9uLCBzbzoKCiAt
IExvY2F0ZSB0aGUgSVB2NCBoZWFkZXIgYXQgdGhlIGRlcHRoIHJldHVybmVkIGJ5IF9fdmxhbl9n
ZXRfcHJvdG9jb2woKQogICByYXRoZXIgdGhhbiBhdCBuZXR3b3JrX2hlYWRlci4gQWZ0ZXIgc2ti
X3ZsYW5fdW50YWcoKSBwb3BzIG9ubHkgdGhlCiAgIG91dGVyIHRhZyBvZiBhIFFpblEgZnJhbWUg
YW5kIHRoZSBza2IgaXMgcmVkaXJlY3RlZCBieSB0YyBtaXJyZWQgb3IKICAgYnBmX3JlZGlyZWN0
LCBuZXR3b3JrX2hlYWRlciBzdGlsbCBwb2ludHMgYXQgdGhlIGlubmVyIFZMQU4gdGFnLCBhbmQK
ICAgaWhsIHdvdWxkIGJlIHJlYWQgZnJvbSB0aGUgVENJLgoKIC0gUmVqZWN0IGlobCA8IDUuIGlw
X3Jjdl9jb3JlKCkgaGFzIG5vdCBjaGVja2VkIGl0IG9uIHRoZXNlIHBhdGhzLCBhbmQKICAgd2l0
aCBhIHNlbmRlci1jaG9zZW4gaWhsIG9mIDAuLjQgYSBjc3VtX3N0YXJ0IGluc2lkZSB0aGUgZml4
ZWQgMjAtYnl0ZQogICBoZWFkZXIgd291bGQgb3RoZXJ3aXNlIHBhc3MgdGhlIGNoZWNrLgoKIC0g
U2tpcCB0aGUgY2hlY2sgd2hlbiB0aGUgbmV0d29yayBvZmZzZXQgaXMgbmVnYXRpdmUuIE9uIHRo
ZSBQUFAKICAgY2hhbm5lbC1icmlkZ2UgcGF0aCAoTDJUUCBvciBQUFRQKSwgdGhlIG91dGVyIGhl
YWRlcnMgaGF2ZSBiZWVuIHB1bGxlZAogICB3aGlsZSBuZXR3b3JrX2hlYWRlciBhbmQgcHJvdG9j
b2wgc3RpbGwgZGVzY3JpYmUgdGhlIG91dGVyIElQdjQKICAgaGVhZGVyLiBUaGUgSVB2NCBoZWFk
ZXIgb2YgdGhlIHBhY2tldCBiZWluZyBjaGVja3N1bW1lZCBjYW5ub3QgYmUKICAgbG9jYXRlZCB0
aGVyZSwgYW5kIHRob3NlIHBhY2tldHMgdXNlZCB0byBiZSBmb3J3YXJkZWQuCgpIYXJkd2FyZS1v
ZmZsb2FkZWQgY2hlY2tzdW1zIGFuZCBTQ1RQIENSQyBoYW5kbGluZyBhcmUgdW5jaGFuZ2VkLgoK
VGhpcyBjaGFuZ2Ugb25seSBjb3ZlcnMgdGhlIHNvZnR3YXJlIGZhbGxiYWNrIGluCnNrYl9jc3Vt
X2h3b2ZmbG9hZF9oZWxwKCkuIE90aGVyIHBsYWNlcyB0aGF0IGNhbGwgc2tiX2NoZWNrc3VtX2hl
bHAoKQpkaXJlY3RseSBhcmUgbm90IGNvdmVyZWQ6IGRyaXZlcnMgdGhhdCBmYWxsIGJhY2sgdG8g
c29mdHdhcmUgYWZ0ZXIgdGhlCmNvcmUgb2ZmZXJlZCBoYXJkd2FyZSBvZmZsb2FkIChlLmcuIHdp
cmVndWFyZCwgaWdiLCB0ZzMpLCBhbmQgY29yZQpjYWxsZXJzIHN1Y2ggYXMgeHNrIHR4X3N3X2Nz
dW0gYW5kIG5ldGVtIGNvcnJ1cHRpb24uIEFzIHRoZSBlYXJsaWVyCmNvbW1pdCBub3RlcywgdmFs
aWRhdGluZyB0aGUgbWV0YWRhdGEgb24gaW5wdXQgcmVtYWlucyB0aGUgY29tcGxldGUgZml4LgoK
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IGY0Mzc5OGMyNzY4NCAoInR1bjogQWxs
b3cgR1NPIHVzaW5nIHZpcnRpb19uZXRfaGRyIikKRml4ZXM6IGJmZDVmNGEzZDYwNSAoInBhY2tl
dDogQWRkIEdTTy9jc3VtIG9mZmxvYWQgc3VwcG9ydC4iKQpBc3Npc3RlZC1ieTogY2xhdWRlLW9w
dXMtNS41ClNpZ25lZC1vZmYtYnk6IERtaXRyaWkgSWFrdW5pbiA8emVpbEBuZWJpdXMuY29tPgoK
LS0tCnYyOgotIExvY2F0ZSB0aGUgSVB2NCBoZWFkZXIgdXNpbmcgdGhlIHBhcnNlZCBWTEFOIGRl
cHRoLgotIFJlamVjdCBJUHY0IGhlYWRlcnMgd2l0aCBpaGwgPCA1LgotIFNraXAgdmFsaWRhdGlv
biB3aGVuIHRoZSBuZXR3b3JrIG9mZnNldCBpcyBuZWdhdGl2ZS4KLSBOYXJyb3cgdGhlIHN1Ympl
Y3QgYW5kIGRvY3VtZW50IHNvZnR3YXJlLWZhbGxiYWNrIHBhdGhzIG5vdCBjb3ZlcmVkLgotIFVw
ZGF0ZSB0aGUgRml4ZXMgdGFncyB0byBpZGVudGlmeSB0aGUgb3JpZ2luYWwgaW50cm9kdWN0aW9u
IHBvaW50cy4KCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYxMTAyMTQwNjMz
LjQyNTY0LTEtemVpbEBuZWJpdXMuY29tLwoKIG5ldC9jb3JlL2Rldi5jIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYwppbmRleCBkZjFhODQwYjAzMzQu
LmZhZmNiOGY3ZmY5YiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZGV2LmMKKysrIGIvbmV0L2NvcmUv
ZGV2LmMKQEAgLTQxMTEsNiArNDExMSw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqdmFsaWRh
dGVfeG1pdF92bGFuKHN0cnVjdCBza19idWZmICpza2IsCiBpbnQgc2tiX2NzdW1faHdvZmZsb2Fk
X2hlbHAoc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAkJCSAgICBjb25zdCBuZXRkZXZfZmVhdHVyZXNf
dCBmZWF0dXJlcykKIHsKKwlfX2JlMTYgcHJvdG9jb2w7CisJaW50IG9mZnNldDsKKwogCWlmICh1
bmxpa2VseShza2JfY3N1bV9pc19zY3RwKHNrYikpKQogCQlyZXR1cm4gISEoZmVhdHVyZXMgJiBO
RVRJRl9GX1NDVFBfQ1JDKSA/IDAgOgogCQkJc2tiX2NyYzMyY19jc3VtX2hlbHAoc2tiKTsKQEAg
LTQxMzAsNiArNDEzMywyNiBAQCBpbnQgc2tiX2NzdW1faHdvZmZsb2FkX2hlbHAoc3RydWN0IHNr
X2J1ZmYgKnNrYiwKIAl9CiAKIHN3X2NoZWNrc3VtOgorCW9mZnNldCA9IHNrYl9uZXR3b3JrX29m
ZnNldChza2IpOworCXByb3RvY29sID0gc2tiLT5wcm90b2NvbDsKKwlpZiAoZXRoX3R5cGVfdmxh
bihwcm90b2NvbCkpCisJCXByb3RvY29sID0gX192bGFuX2dldF9wcm90b2NvbChza2IsIHByb3Rv
Y29sLCAmb2Zmc2V0KTsKKworCS8qIFVzZSB0aGUgcGFyc2VkIFZMQU4gZGVwdGg6IG5ldHdvcmtf
aGVhZGVyIG1heSBwb2ludCBhdCBhbiBpbm5lcgorCSAqIHRhZy4gSWYgdGhlIG5ldHdvcmsgb2Zm
c2V0IGlzIG5lZ2F0aXZlLCBuZXR3b3JrX2hlYWRlciByZWZlcnMKKwkgKiB0byBieXRlcyBwcmVj
ZWRpbmcgdGhlIGN1cnJlbnQgcGFja2V0IGRhdGEgYW5kIGNhbm5vdCBiZSB1c2VkCisJICogdG8g
bG9jYXRlIHRoZSBJUHY0IGhlYWRlciBiZWluZyB2YWxpZGF0ZWQuCisJICovCisJaWYgKG9mZnNl
dCA+PSAwICYmIHByb3RvY29sID09IGh0b25zKEVUSF9QX0lQKSkgeworCQljb25zdCBzdHJ1Y3Qg
aXBoZHIgKmlwaDsKKworCQlpZiAoIXBza2JfbWF5X3B1bGwoc2tiLCBvZmZzZXQgKyBzaXplb2Yo
KmlwaCkpKQorCQkJcmV0dXJuIC1FSU5WQUw7CisJCWlwaCA9IChjb25zdCBzdHJ1Y3QgaXBoZHIg
Kikoc2tiLT5kYXRhICsgb2Zmc2V0KTsKKwkJaWYgKGlwaC0+aWhsIDwgNSB8fAorCQkgICAgc2ti
X2NoZWNrc3VtX3N0YXJ0X29mZnNldChza2IpIDwgb2Zmc2V0ICsgaXBoLT5paGwgKiA0KQorCQkJ
cmV0dXJuIC1FSU5WQUw7CisJfQogCXJldHVybiBza2JfY2hlY2tzdW1faGVscChza2IpOwogfQog
RVhQT1JUX1NZTUJPTChza2JfY3N1bV9od29mZmxvYWRfaGVscCk7Ci0tIAoyLjUyLjAKCg==
