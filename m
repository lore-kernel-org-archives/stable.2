Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE22EEE8A;
	Wed,  9 Sep 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918814; cv=fail; b=Y8pjhjiAPhV54rytb4g/ho+MBrljRWF0V6QRmVjJ6tF0GEUyCdOl3jfK4bBKNHbTQQIoI4Q+wjuGxtgYmQE65ksBGzAfGJcy8rdKDNe8o220uDZo6k2wJIV5KiFch7ODN+7dVzn7aYClBG7zqB2khYJWTBeTuOPt1bG3/tRHTDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918814; c=relaxed/simple;
	bh=p/eI9uXOcy+FQ0fo/0jGmk3oEybPbaPh7dvHDzQc+dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t87b96uHml3QAU3gnzs+cblFa7xhqGX1XrxgWRK0TzJdZC/jNKQ2TWxj9Hl3GKCOLC/3ZAo90f3wonYsSXRbW6ihsc3yAhUvZiENOKXO5Luy3k5Iiv+nhRC/lvaiqKul5qHMcUlkQ1fgFeDVq3s2AD+tJo1q/CUaWK8kqdDQVoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DFt2Ktqi; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFt2Ktqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBa4fZ9Q5cUAS5LKqqmBMujbQttqbPgMWuKcgt/B01kTFo+Hi+r1h83jOJkiScR8a+Pxjbf0qhqL/QdcHIAokQi/Uz73lkPinZA2Zx3HlF6yrj+V4CxlvLeST5JrB13jGtYvSJqw8vByLfPtB3/qz3z/sUd0JWpvUuNa1fwZhJWsA3RAHnBqBvS6kIKwvpEFtv+L3dWrpIutoJLDJ99mODdW0Op0d2GDpxnv9/IaiZA4/lG5hirw0RmcZl+KF5iLqGiJ4SUOcy8KgNTB0l97JOwp4gmChWnQZxxjRYRD8HnR9evqIfaeTJghnZT5PR2a6JD+I95Fbw4AesWENh6xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/eI9uXOcy+FQ0fo/0jGmk3oEybPbaPh7dvHDzQc+dA=;
 b=Ci7cVNl+Qn7z9JzwYEFVDuDoUbAOOdhZ7198ID+Er4sBBISxln8VAKz8kIULNBy/Qs0JCVXCFWQQZc7jGXB3WkSWbmeddPilUqJ3nWi6RuNNRKKNbEU13MhBt9xaZqItWJg7woTHlssxo1tZR0Nliq127AiylaxS8tAtuCeg33jMsrz2fXN+UEYMmyD+dV4HuxoaXpAR81ngG10nH3BDaRofXNa9Biih8A2j2DaanKR21G7qTgha5gS7/JeE5OZ5m7G1SXfqjCoWfaYhMFVcaDMbciUK9FHe7U4AowiKJl+Aj3J/ffU3dtF1gfcaazz7RLWVGkY+nQEYWmnbQAHwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/eI9uXOcy+FQ0fo/0jGmk3oEybPbaPh7dvHDzQc+dA=;
 b=DFt2KtqiixqiWY3zezUr9n6gNBkgPPQtKsY16zuJ+14FKYQDAslgXOOcJPepqcMn4N2wUks+kr0dgIXlGCCdZkhstmvkoVnJ0/oaZMYTVrztsb+2InCn42SumtwybVp26gsvK5tyN/WD4eIE2/pWFZoqDv8D4NjthblGgQvqlmlqon5aIOp44de5Aw/MopBCy+m/PX6GliaJxriwttcP5yuy/rEI8G7fn/AmIYv7quurMM6yVYG0AEtM5EwHWzDLONRM3EkPJEMR6+HrfXt5P7oxHnp5U4vReLdl06zxxD2DtZAy/hgrPs5Ku8lKUU1CqCPIjoXDQsaaCbD/H7xuvQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DU4PR04MB10574.eurprd04.prod.outlook.com
 (2603:10a6:10:581::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 01:53:29 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 01:53:29 +0000
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
Subject: RE: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev
 is unregistered
Thread-Topic: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev
 is unregistered
Thread-Index: AQHdP6/dMH7O9YfD/ESmj0TrqmRxrbbFe0Hg
Date: Wed, 9 Sep 2026 01:53:29 +0000
Message-ID:
 <GV2PR04MB117396FBF9F7F4222543DFD2588B02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
 <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
In-Reply-To: <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DU4PR04MB10574:EE_
x-ms-office365-filtering-correlation-id: 2ad12c2e-1e51-4664-c4a4-08df0e1525a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|19092799006|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 z9fW/k/oyJaM38UUPoyLryQaf3tGTnmKeJqxgrxrDMaP5cORzHaaPgQNm+16Le/gTkcAeJ9odbH/GJ74IF1t/L451aw/S755WQS7XCrfLeCPXE1nY/TaoAIuA5hQ/BCP8ho7PBEjoIX06pfRQUEqjFSvbnJfXf/SwgELbDMqCKlNsxPnLmPNeYiNpQiNZu7Z2iFgyKKRLKnf6utmgX8EJrshk5v4GsjojHymK2IXzdd4CIXSX5NDoRuZj8Ok0MjZfbQq5jg0KCAADJwcQ2GueKg5D8tQ2RwWo1vNXK8to8G40PiIA9mYrkMkFYMT8Rt+eK3FVmCslosxD8nYz0ifUUeQxdt0l+AcARPHeS9/JAPuGceuKsvyjeC5wB2qXpb0sTdei0aGS2o78r4KiB9kjgeMOLXKk9L2dESJeRffkB+uPRf1duTdeVpzrOeIGMPU+RFDkcO6PwgHbDZSSq7RdVWcD3b0H071X/01+98hetpbnuHbi3JQHgBkDwfkDVmdqMrLxkJ4B9hTJi5cgvZ9/CetrAsH+6vcHzBUsCjUalqjvy6un4gJ5dJnXT6OYKamE3KhuU3UqElg576jaeMSidlDWiZxEAvzc+H5zruPGRhzoLNoIgxn1s33fdb2NM7lyCAgDQO2FdYMaCrAYPbjrTNzbnucHSZJh5gRWy0Pinc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(19092799006)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU1LL0liWmNLUUNBTFFJem1Mc3ZPN1hybU5ZYXNGRUlWejdYclJOeU90QkxP?=
 =?utf-8?B?d2NGckpzemJBMDdsVE9mYXZPc2prT1ErcUY1QlFSV28vZ2lETlMycUZTdWJx?=
 =?utf-8?B?SlZmK0ZWQWRSaTdqWjE3V3JZM2RsT0Q1UFowS29KMmVQNC9BNmp6UDZMV2w4?=
 =?utf-8?B?bEtCMi9VUll5Q2ZaY3ZxbXEwTTdJanByd1JrK1NVc3dNWlYvdFdUb2UzYlU5?=
 =?utf-8?B?MlVmZTdTaU1hTlRwdHZXc0svM3VpSVQvY0g4c2dISHpMUUY2Z2R1aTFqZklO?=
 =?utf-8?B?aHljc2ZNVlhpdWRpUUpHd2J4cFRRUjRUZ29YcytMMEVGUVRoSnhhcmNqK2Fm?=
 =?utf-8?B?SkpzY0pna2ZDSGVHcFhFQ2NScDVHVVU2aDJlRFBTZHpFeTFuWkU1SUc4QkQ5?=
 =?utf-8?B?Q2RVWC85YkhVdG12RUpaNnJNZ3JqYVh0VGhNaDR6TDZrdFMxSGZXdVV6QXJv?=
 =?utf-8?B?dVZVTFY0ZlQxVjJScTJSZXJ6UG5RVUpEdkh4bno5cnh5TW5aTGYzOHVuY0RM?=
 =?utf-8?B?MkwyMTRqamw5UHJxQXZJTm1VN21LU2ZMZjF3eFZBdkxWdG1OZ1JGQVNpTlBT?=
 =?utf-8?B?bUFFWVNvQmNTUWlBTGdsWDl0SWhTY0Rxb0pBTWhTQkJnVHM5cjYvbi9PaU44?=
 =?utf-8?B?Ymw5STRIRFFGU2VFZUNzOU9LZXA3SkxpZjVNR0lVYVB4VXhNak1FZUs1Q2NQ?=
 =?utf-8?B?bnJSVG5yckc3S2NySms4QWptc0Y1eE9OZk9OOXFMcTRUTlNmeXBnMEpkWUNk?=
 =?utf-8?B?VTgzUDlsQ3BBQkt5R3FVci96MEdoNXVMVjBtWHh1WEhHajlLc0lDQ2ZhL0Jl?=
 =?utf-8?B?U2tTcUZEdjVQVHJBT2dRUEVwbEFnby9HcCtWMS9VcXN4UmpDbjd3WWE5eWxY?=
 =?utf-8?B?TGhzUlpoM0tjUnB4dnVlVjNvYnA5NnVrWlJxYSt2ZmZFd3gxVjgvbFR3YlJB?=
 =?utf-8?B?TjNzUGE1U1Q1b3RFUVg0VHlUcExacHJ0WXNJK0hSMUZsWEFPOHpXQitNVFVo?=
 =?utf-8?B?MGN5bGErU0NPamJhVEUrcDB4MVJleVkwc2wrVCtCanJIUU1uY3lKanRRbEdF?=
 =?utf-8?B?b0hJeDJzS2t1bEZ5UTJ0S045QnVNd1lXVkxDMVlUS2RKT3B0Vy9BMjRNMEIy?=
 =?utf-8?B?OXJsemtWQytneGxpNE45NkVHQlVRSllpZmdpWjJMdkhWZExmUmpscU1iOG84?=
 =?utf-8?B?QUpzZkRiK2VaaTI0cEN3T1VGUG0zL21sNmM4Y280YVFLc2dEdmhDS3ZkMG52?=
 =?utf-8?B?TWU3eVB1Z2FtY2ZMSHBRY3l5dXgwTkRhbTIwZUN5ai9iZmdGQ1FIcUJGMUs1?=
 =?utf-8?B?OFhvMjlnYVhRcUFlYitkQ3dPa0p3NnpwNVVjd3U0T1FDM3FwRTFIUFVkN0dN?=
 =?utf-8?B?M2M5djJxdEZWb3p5VEtIQ0dsNHF5bU9JMFMrQmRYQmUrVUxnVnZuYTdlc3F3?=
 =?utf-8?B?Y2QwOEVYSUN6ZzNPTzg2VysrM0NGazdrVktGWGNxM1Y1V1E1Q0JWdW1lQWE2?=
 =?utf-8?B?NjU5UXd3aTJOa3BKY2ZDS3BoYzJnRXNIQ1NMcHc3RFJJZXFxUEt2cVdaV0U5?=
 =?utf-8?B?QjFkUXNsMTcxRmhUUjd6Qkh5OWp5Z0ZPbkNScVVPczg5eXlCK0xaSVN4TVJk?=
 =?utf-8?B?MFJMOHFKUm54Ym0yRUFpeVZ5azNRMGQ5UGFpVDh3Q0NzZXcwN050UnpWSVBL?=
 =?utf-8?B?KzdRbnpsUjZPQUFRemx5QnpFZmVGS1ZYQXJkR2hhSkRKVnVrK3l1Y1Q5Vjk3?=
 =?utf-8?B?Y0hpQlo5aFN5aFdJMG8zRXJuUGFWV0ZidGFQNG1IcUhJSnhoSlpMelNyWFJz?=
 =?utf-8?B?MGZZWjFuKzUrV1lQWlVmZVJtSE93V1pDMFJ4Z2VaU3I3SmYvTDI4WUJQVmp2?=
 =?utf-8?B?b0NJcnArS1c3T0hodHBNMGVDS3JxSlY5T0tEVlFkR1p6c2tEMkpsWUJIcDBL?=
 =?utf-8?B?S21qSXZOQ3lJKzdoeXhTMnZXNmJ2UVpaenE2SDdqV0ROUW12VVNFSEQwTG1p?=
 =?utf-8?B?ME4zbUJnR2dnZm9vaXpQMHlKcTMvcGdLczNWTS9zampCU2xlWDF6UlI4YTVM?=
 =?utf-8?B?b255UWhGd0RlNmZ2dEtqQVZJM3FTSzFtSTRRVHc2UDRPcVZvTG8xSDlqclhD?=
 =?utf-8?B?OWo4WXBJQysybURFOEhUTWRlOXJac1ZXUTlNL2hqRG84OVhPd1U3MGlrRGRp?=
 =?utf-8?B?NjBzZ3dDdGpMUFU3blJhZWhObkJxNGhtM0VTSlJxbE1jT29zT2tyV3Q1YWZQ?=
 =?utf-8?B?M2VnSXlMSlBsNm5Qai90dzZTTmpPU2dmS2xkWkxzNVl4aTJScy9KZitIL3cw?=
 =?utf-8?Q?G18Yzy+ZJxaHwzMOhL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad12c2e-1e51-4664-c4a4-08df0e1525a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 01:53:29.7856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gr7W5NhUQbZCBSi6Vn6mBP9YYX9yF2taV5IzV4VM1gOi50vh4omoCsYz40phCMiwwe2SLnSTcbfSFwGQXZfUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

PiBmZWNfZHJ2X3JlbW92ZSgpIHVucmVnaXN0ZXJzIHRoZSBQVFAgY2xvY2sgYmVmb3JlIHVucmVn
aXN0ZXJpbmcgdGhlDQo+IG5ldGRldi4gQSBjb25jdXJyZW50IGV0aHRvb2wgLVQgY2FuIHRoZXJl
Zm9yZSBwYXNzIGEgZnJlZWQgUFRQIGNsb2NrDQo+IHRvIHB0cF9jbG9ja19pbmRleCgpIHRocm91
Z2ggZmVjX2VuZXRfZ2V0X3RzX2luZm8oKS4NCj4gDQo+IE1vdmUgZmVjX3B0cF9zdG9wKCkgYWZ0
ZXIgdW5yZWdpc3Rlcl9uZXRkZXYoKSwgd2hpY2ggZHJhaW5zIHRoZQ0KPiBldGh0b29sIGNhbGxi
YWNrcyBiZWZvcmUgdGhlIFBUUCBjbG9jayBpcyB0b3JuIGRvd24uDQo+IA0KPiBMZWF2ZSB0aGUg
cHJvYmUgZXJyb3IgcGF0aCB1bmNoYW5nZWQsIHNpbmNlIHRoZSBuZXRkZXYgaGFzIG5vdCBiZWVu
DQo+IHJlZ2lzdGVyZWQgdGhlcmUuDQo+IA0KPiBGaXhlczogMzJjYmE1N2JhNzRiICgibmV0OiBm
ZWM6IGludHJvZHVjZSBmZWNfcHRwX3N0b3AgYW5kIHVzZSBpbiBwcm9iZSBmYWlsDQo+IHBhdGgi
KQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWdnZXN0ZWQtYnk6IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBBc3Npc3RlZC1ieTogR0xNOjUuMw0KPiBTaWduZWQtb2Zm
LWJ5OiBTaGVuZ3podW8gV2VpIDxtZUBjaGVyci5jYz4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXggNzk0ZWM0MjdiMGVlLi5hMjljOGRkYmJm
MzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
IEBAIC01NTAwLDkgKzU1MDAsOSBAQCBmZWNfZHJ2X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgCQkJRVJSX1BUUihyZXQpKTsNCj4gDQo+ICAJY2FuY2VsX3dvcmtfc3lu
YygmZmVwLT50eF90aW1lb3V0X3dvcmspOw0KPiArCXVucmVnaXN0ZXJfbmV0ZGV2KG5kZXYpOw0K
PiAgCWlmIChmZXAtPmJ1ZmRlc2NfZXgpDQo+ICAJCWZlY19wdHBfc3RvcChwZGV2KTsNCj4gLQl1
bnJlZ2lzdGVyX25ldGRldihuZGV2KTsNCj4gIAlmZWNfZW5ldF9taWlfcmVtb3ZlKGZlcCk7DQo+
ICAJaWYgKGZlcC0+cmVnX3BoeSkNCj4gIAkJcmVndWxhdG9yX2Rpc2FibGUoZmVwLT5yZWdfcGh5
KTsNCj4gDQo+IC0tDQo+IDIuNDcuMw0KDQpUaGFua3MgZm9yIGZpeGluZyB0aGUgaXNzdWUuDQpB
bmQga2luZGx5IHJlbWluZGVyOiBkbyBub3QgcmVwb3N0IGEgbmV3IHZlcnNpb24gd2l0aGluIDI0
IGhvdXJzLg0KU2VlIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjIuMi9zb3Vy
Y2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2LnJzdCNMNDM0DQoNClJl
dmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0K
