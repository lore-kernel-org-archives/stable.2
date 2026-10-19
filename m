Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792452933;
	b=skzcsDNLhA28PWtBwBgMkie+XjjCJJ1EyaPUjZUnvMMuq00PYqzMmgITQXEQbZl0kNNv
	 qaMzUCuOIOQ+lkEiX/7izKUeWdtAH95Elp+fshxViwZdefBops2cJJeG7bqFEAMWwZ1D1
	 oZ4CXvibcp+P3kxNEt1NTpMdblToyKRO9SYusmm+L21eMSxFevszjIg3WOmiHLZBUUQnq
	 xKNcncZIqZpiFGIL2RJeHpCsCbsEUwtc7WPvBgu1osZ849t4vcrxzaz4ToI3SV5QIHks2
	 TmULVXia94BAEclx8mpG7+LwzuQxo/5cmY0me94uFM+w2CJpXtFBE3sV6ISEn+R3nig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IoHzmaT978E9zcV0tRR82U61pKkvnzqmz8tVXc2B0uk=;
	b=XBMXpFyHVpQR1SHEoYWd46eorQfc1Q8Zh9w24KacuM1DXdyEtSirszaiqE67E7XjNiz/
	 s4p8TfnLpuTwglHu3WRAlheeXetj8NTJSHBUgOtYbpjYvafsddUa3F9505hO6O9V8kUr0
	 1SKxVD9T7nNNX/58g5fBsCMIng/pyAw1OefIpdhpnuwVt6vCZucSa8nw/+zKpbH7wqx7P
	 obxj++9Pgj/f2KCI6tpCe68JumS8MdZt5KxNv6QgCf3TzEplP1Kr+4BugWaj2LLXIBQWG
	 aGyhCwjJCFrX/HYXcbyfKtsFlheW0axExywNAt6IHRVZu0/kMOMXdlzgp/GyHeG+Y3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oHBxUcir;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DHmAHL70;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D90606A319;
	Mon, 19 Oct 2026 23:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9D90606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oHBxUcir;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DHmAHL70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792452932; x=1823988932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IoHzmaT978E9zcV0tRR82U61pKkvnzqmz8tVXc2B0uk=;
  b=oHBxUcirgTJ0+4Sh/Hs9li5TvIdIdzZDjT7ygO8I3sN4c2k8dDH/ijBJ
   TiGgcfEC/iH3tQgix7IDrnJA0BOzBz8rWZQzQJqASrNTqYnZ5712lMca4
   hmrnJbYGznj/8gKFe5UycqHC5EppmTWqyqifeq+PfLwJavg73foxOj3cW
   37MnOcqp1IwesOEP633JgeLoaFq4bi8vgfP5/5LtS+uO1b6BCiCUxADHO
   5xtwG9jNZwfnjFPsknwVeg7/pdscPcyUhXoGG2CCswi1MpLukZJTB6c6j
   LvqPgqCcpYvX4a6eFTu6YHjTZVNcVyx2w8h6vsrOvNlCvQnCYxFQEUkla
   A==;
X-CSE-ConnectionGUID: u6FX9M/IQyuc1f7tljurSA==
X-CSE-MsgGUID: tQ2WaWC4SMqam970OsDrHw==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="157534420"
Received: from mail-southcentralusazon11011025.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 07:35:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTYiILpmtWJBwfnoJ2JLJgbDWp49A4YexHDi9FXb8en0oLXQ1fsVcAdYr/4rESh6U9ShBqcZU2fmPTwxukVF/e4FivQakrkCWDGaX/YXQbcaScO0MK8JFitZF0afJqvgSjL1odOD8b98N6PDQhk4W4MSUwue5y/oLCcOhXtxQO0pujSKvw8n48FXH18Ii9v+SFAdKPvI6HcheWp4PT9Fn5jUw9ASqib717wU6u6XkC7xTbf3LBLfwCkBcRpAT/0bV0q/lDTmiL4Fe635hJ4ZcAS01GfHYTKb+uqgmJyYODuUL4Fku9RP492BWyTEelVMq9jBdD0WM1+fA4xRQ+HDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoHzmaT978E9zcV0tRR82U61pKkvnzqmz8tVXc2B0uk=;
 b=x9ChvCeDBKn84AywjIz6jfuhwtgPRM8NqFv9fAabrAB13Aes/pmF7LRqes0kGZqTBjHP0ET2H+4fcM82wa+qGAreaSZDgzOs9ej87qpz1G7+dnkf5kACrPUPMUoOabVVyMqfifKWcKlVh6GB0IzNwKS1uVBtQIHtqWjJUZgPojOW7yPX+5eveSAnaZeJMn5gX+0D6eImz9drGa9mEECjpmltznIYU3XJZwscz/p4qZ2X0KTRrWzwIGhGk4yiAvPl0k6HMQ10TeyCFDGFtAENZnJR8G1PGxo3zaRWMnvCrwahXLz865BxqKMVscTUEdxiLGN2czrJAOp6sXioTpp3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoHzmaT978E9zcV0tRR82U61pKkvnzqmz8tVXc2B0uk=;
 b=DHmAHL70818tTQvtT54//rHGyl6FSRLyI2JjDp/NkJzKYG85Jei+ErqVjLGkTs4LZ1rH24dRNp/t8G3Lb1wk0xT/viUstNta7iHeUe1R2TAD6PAGMgKqgfcey/+6EqgAyPyb5A6MvaQJH+gXKewokZCOTEzJQ6vmHmyU2C/hqWs=
Received: from IA3PR04MB9680.namprd04.prod.outlook.com (2603:10b6:208:510::12)
 by SA1PR04MB8285.namprd04.prod.outlook.com (2603:10b6:806:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Mon, 19 Oct
 2026 23:35:22 +0000
Received: from IA3PR04MB9680.namprd04.prod.outlook.com
 ([fe80::380:1453:ea86:e64f]) by IA3PR04MB9680.namprd04.prod.outlook.com
 ([fe80::380:1453:ea86:e64f%7]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:35:22 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "rjethwani@purestorage.com" <rjethwani@purestorage.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
Thread-Topic: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
Thread-Index: AQHdYBjoafiTR5EB/EupLY8DEBoRabcFhNGA
Date: Mon, 19 Oct 2026 23:35:22 +0000
Message-ID: <ec0ff3dfe347fcac3350c945c432946f869d8b43.camel@wdc.com>
References: <20261019222626.745408-1-rjethwani@purestorage.com>
In-Reply-To: <20261019222626.745408-1-rjethwani@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR04MB9680:EE_|SA1PR04MB8285:EE_
x-ms-office365-filtering-correlation-id: 2683a70e-f307-490b-03a5-08df2e39a4db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|7416014|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 5KuUstj2oL5qK5gieuvBbBY8cA3I5KmiQ3rliygCFBf1tWSAAYY+h9PskmKNWd675uanqCGGru5BqjyGDWzkAvkkrqn2vM3z9ckK/BCOdXWrxq6LyNZDm0bmALeGYsnLeTd92UnqxZiroQgUAmQWjLObISqktRpoRe4h4KAkErxDAJuIxu/L1ScXPzJ/cn0Hmk15QsBfHHIdz3vOg7lO0mNpa+EsuUfOBcI6OVuiXmLRgecTZlnr/SRxBT1FPopaFFvSe/iu4SDNT5P9f+HceWri4j28PbhavILqANlaVcdDFNXML/maXE2QvqVSYp/tB6YvFYzldi2R9Yrl5IoDOjvZ2JhRKSmIsPAVibSn30ADkkc2JezQLmeDsjhGYC55fK0TGGL8Ly4wA6kbAgNJ+p0gz2KF08MpjiaKlp657g8dZgQ6ITVA3wmk4brTTo4OIBFbH03eORaFPF0/V43l4kMEc98HLlziLpgHRXc0wlsjrEB669RH1ULV4nFej5Zub9z8KRDWnY1S5wXXGNVGxOkJEfC9bTRkxqOcyNSeMWrd2qnOj8g/BpPUcZlD7UuxR9WB3TQPZSz/3p5AJvcVj/e71Ta8xUFA/tLKw7dGg+X/RcOEaD4sFvqhCzKPUOD8/tD3rt8e5NKm2pk0Df4kRui62kGt5sx+osSZRgRUu22XTl9JAlmfApPH185se3n4nKkcVrC6Zv8ogpwA7oT3yA40/peDQxnms06DdxeVpn0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR04MB9680.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RStoMzN4V3A4SlZKNmZocVU5YXJWcTlxL1dBcklWQ2xlUHhCazhuZSs0bVVy?=
 =?utf-8?B?MmhMUG12eEsvV1RpKzVjKy8yTzNuckc0THRyQ2xodTBpMjRqbWdQMnZrRWlq?=
 =?utf-8?B?c1F0U3g4d0dxcElCRnN3R1hpM3NmOXZvYVNDNTN3M29WMEJSaUJESkxoRmJw?=
 =?utf-8?B?a3ROTEM1Vk5KejFXQWpLZkFRTmgycWVHTUVXaFhzS0czQXBsN3RoSDlqQnFr?=
 =?utf-8?B?L0Z5ZEJONjU3TVhkVjJISHhSV0dHMTlsMTdQZ25lMCsydW9hMDF6SzhxaUZ5?=
 =?utf-8?B?WFpSNmJCODQ4NW91WHVuckw2UEZHeTNnbDdHelF2OFBxU254NlA0NHFmdlpF?=
 =?utf-8?B?TFEvUW4yMzQyaEVWdmJzcUJLSVBMcXJYK0FGTFU3cjduT1BvbUw3YnkrN2Yx?=
 =?utf-8?B?Y3g5TXRSdDRBUDJIcitaWlBYTTkxcG9UckxveWVySkxiaGhZdURXZnFteUsv?=
 =?utf-8?B?QWd3VjdiWHBSb0p6amNoUzRRTktocjU4Wm44OTVtWXlSNDZ2OXF4L1lWdVhM?=
 =?utf-8?B?WCtJZjJuTkMvbmlrQ1RMWmpjOGVsVWxlTDJKQkZIbUN6VmpOSzlvQ21acWZs?=
 =?utf-8?B?VEFnZUlkSDFRVGNFUmJYRVR0anM5emVodS8xbGV6QW92Q055UllaNW5PV3hz?=
 =?utf-8?B?RU93N0MxdmNiZVIzYmlrNi83WWxBTktkbHNtcExJN2d5NHVXaEYxbkovZVRG?=
 =?utf-8?B?RTNyTXRkOHROaG1tOHdESXdTKzFFMzMwZjVxckxqbkJocWloUjhVY20vWnZv?=
 =?utf-8?B?NUZRc3RJSHQ0YUFBazRvNTlIMHJwekFKRjlUNkl4eHVUL0hjWXJBdFRVQzN4?=
 =?utf-8?B?SmVONThOejZkUEluMm12NmxSaHY3dFk3YVc0aVlOUkhPYWtZSDg0MGFyTkVS?=
 =?utf-8?B?b2xjUjlBVUtzT01rbUtZd0Z1VkFpYTljdG1iVTJSbU1wSVVmQWljYlBKZ0Rl?=
 =?utf-8?B?OVl3QTc3Z3d1TGpzRGFhaTZEbmltYzRJVGozb1NyUjZXRlFYLzF3WGtuTUJp?=
 =?utf-8?B?eFE0YUNOcURpdFNIVjRBb0sxc285cXBEcUZ6b0ZlRVg3YSs5czhWakVTc0hq?=
 =?utf-8?B?ZWhBWXY5cGpOdUw1b0xDSUNqOTlvMDZ5NmNKdlE1N1pyN1lWOC9xWm84dVRu?=
 =?utf-8?B?Z2x4WWVoNHgvUHZyNUM3Nnkxcm9oM25XdGtOOWpmKzQrbldDeEExZ0tMUVoy?=
 =?utf-8?B?anVjR2M1Ny9JYjl3bTBxUzMvRFFqd1VzT3kzVzljQ1h6RTJxaHAzdmJmdEpT?=
 =?utf-8?B?QmpHbTZTNUpjUWRtZmJua3NUc3JaQUc2VW5OempPNm4rTnNqTUFCdWU0aFdw?=
 =?utf-8?B?R05RZUN5NXF0SUYyNmxLdDhzaXdlclJUTmIwWEwweVhreWRQMXRwTlN2bmtT?=
 =?utf-8?B?Rm9mNHl2WTEyUC93NUlNeUd5cm9ubkR3SnN1VUtleWc3RVQ1TGNVUnBiTnRx?=
 =?utf-8?B?NGhTSnU1QW9SQ1JrMC83Sit5dUV5Y29FZ3FZVHgycnVhVHRzdXlXOFF6ZXkx?=
 =?utf-8?B?NjZoa3FlZS9ZYkhDV2NZc2F5OWxsWnhxNzJTemcrKzlvdGxjTGFoN2xuNEVB?=
 =?utf-8?B?Rlc4b2dZUFl4NVpncmo0dmxnNXZmR3FtdGt0Vi9KUGprYmk1WXhTNTQwYWJv?=
 =?utf-8?B?QkJ0SktOSHZaRW9aamZRQVNXSmh3a2JWa0xhZ2NxdXZCMXFNcVhGUTJlaVk0?=
 =?utf-8?B?TlNBRlA0QzIxT3FuakdZTUw2WVZZL2pWai9UWXVLRnpteHRmTjRLWFlZYlZz?=
 =?utf-8?B?TE9xcno2N0Zid1FwcTlHZFB1SG45Q2J5Um05WDFJVG5QMGVFNFVyQWEwL2Zs?=
 =?utf-8?B?RU9hT0FjSm5KTlpXNGZjK2w1dzhlN0ZxeU5UREVXRXhyU3JyWFRXelFLeVBs?=
 =?utf-8?B?bHlWbFZDRDVocG1uNTJpZDhIeSsweksrSDZGaWNxZy9aaHhpUncyNTlFekVK?=
 =?utf-8?B?NFNvekpGdFdkRUM3bTFhaHVjVUhML29UTHZJcXdJWUNvRnFiU1dtdFZpUGJV?=
 =?utf-8?B?RVMzS0psSUpIVzhvSHhoQTl5by9mVE1ZVXkySThTUHpJemdpNHlqcUw0L25r?=
 =?utf-8?B?UUNCdWpPOTBnQkZFdi9NYlRrOVJmeTBISGNmN2E4U1h3T0pPNHhmcmF6WGtC?=
 =?utf-8?B?bjVzeVpiWTJNTjlWdkZvYmVuOUZUdDJqQVdGU1crSGZDUEUzVTd3cXRwNEJr?=
 =?utf-8?B?cVN5NTlKaGhCbEZNUXhlNFlpellaZE5XT1RIYlZuK0hkMnR3MHRCQUkvaDRG?=
 =?utf-8?B?ajhEQUpNVDRSajgxUE82QVcxajg2WWU0U0VKNW54M1RMVzFqVTRkb3Uvam9R?=
 =?utf-8?B?b2krU2VXZzhzcUV0RHRLeDVDekF1aXAvdnZ3VjZ2bXJvTGhXdzFkVHRlVmQ0?=
 =?utf-8?Q?KjcCuj81COSRhhss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9DD93D42244BA4E95C5620A15DB0E74@namprd04.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked:
	G+H2A+vzANSgQ+3kgvLwD8muYtIrvBFLSu/1zz3352gxj7zwc5nQyyndVwW7hXyLo3uyKBqVL00pn0rrKBuWAkhNxw+qiBtCjHwzxNy1kQTYtFWvNjBsT1qEEjgRTwBVrkABun8DjBLOppMSOF+cvnwebxFs58T+EgqOmAV/cWJlfxTQlrclhXPGtYS0k82V2Bzde3qImEZhD76fYvr9jagfNk4qoc/sm55GM9QQksWSsD/EixWvLkkSIrBFlJATusEMuTlat4e9XkbNEZypJeeFFlO287P/XmffkrR5OGaofpr+qVoJ6t122hEumzhfdKavwZKSXn6aTdxw8DwJOA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KDmMOYyTyMYJEIicYg8vcpeTCbpWG1dK4V16i2XHb3s72fJbpw0GOLhNTyBpE2XqY74IMuXZZ6iRbKFwBuED/+3FM0hHWImGsi/KQbemcFlOrDmDA9/+HFWcGGxjG0OlLH1UegiYtoIXb/1sR09YsPDhuUecfo6BzgKhZn3yGET6I5ly9tWcC5KfncFepwTjIxmZTXlie77vwMXR2Rao+td2Yze/r8K9IoNfbZrtLH6dD2XoSnlEkKPLqmJle/QyZf140ZIhkKftFMIxREwAwzDwmSbYHaT1PC2t97tg8AMMvIMe0Dzjj2aGPg8rFXK4oOIVfl0yBwxRbroDW9yaBvnGRTy4JJ8PPK3RbIrw+0Qvi5aSi0Up68n1VG7/XA8K4ZXgiC6e3eBcrfVLGBs+Ai2QshPFDum1GRIBCghu6D2YQSiHuhbLuoCgdC7jcWU180AjxXrIUExH6xnGUTaFUdRkf/kCjhomIWzsOjXztBavvBCPg4/B2oxDm8rqeGxiMufu3HqUc9CgvIdhMuTyJEh9j3jip0haXm5ttsbRjkV6TM4C4RLLe8eKWct6JsMKoBNpnILbAcSu+CzKw7rdq1sR6AgJaNWBLOwiE7o9m8Xtw5Xx3Fe/qzkIpWWtTlZo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR04MB9680.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2683a70e-f307-490b-03a5-08df2e39a4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 23:35:22.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ePd+Xm1KXz5ujFjOhvRfhBJHqjAGmbe3UIx8XmLoziUgBJ0GoIwiDXe6/qp5il1yG17q3dr3+0TCH5w8PptFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8285

T24gTW9uLCAyMDI2LTEwLTE5IGF0IDE2OjI2IC0wNjAwLCBSaXNoaWtlc2ggSmV0aHdhbmkgd3Jv
dGU6DQo+IA0KPiDCoG5ldC90bHMvdGxzX21haW4uYyB8IDE3ICsrKysrKysrKysrKysrLS0tDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbmV0L3Rscy90bHNfbWFpbi5jIGIvbmV0L3Rscy90bHNfbWFpbi5jDQo+
IGluZGV4IGZiYjI3NDI4N2FhNS4uOGYxMWI4NjI5NDkyIDEwMDY0NA0KPiAtLS0gYS9uZXQvdGxz
L3Rsc19tYWluLmMNCj4gKysrIGIvbmV0L3Rscy90bHNfbWFpbi5jDQo+IEBAIC04MzcsMTIgKzgz
NywyMyBAQCBzdGF0aWMgaW50DQo+IGRvX3Rsc19zZXRzb2Nrb3B0X3R4X3BheWxvYWRfbGVuKHN0
cnVjdCBzb2NrICpzaywgc29ja3B0cl90IG9wdHZhbCwNCj4gwqAJCQkJCcKgwqDCoCB1bnNpZ25l
ZCBpbnQgb3B0bGVuKQ0KPiDCoHsNCj4gwqAJc3RydWN0IHRsc19jb250ZXh0ICpjdHggPSB0bHNf
Z2V0X2N0eChzayk7DQo+IC0Jc3RydWN0IHRsc19zd19jb250ZXh0X3R4ICpzd19jdHggPSB0bHNf
c3dfY3R4X3R4KGN0eCk7DQo+IMKgCXUxNiB2YWx1ZTsNCj4gwqAJYm9vbCB0bHNfMTMgPSBjdHgt
PnByb3RfaW5mby52ZXJzaW9uID09IFRMU18xXzNfVkVSU0lPTjsNCj4gwqANCj4gLQlpZiAoc3df
Y3R4ICYmIHN3X2N0eC0+b3Blbl9yZWMpDQo+IC0JCXJldHVybiAtRUJVU1k7DQo+ICsJLyogQm90
aCBUWCBwYXRocyBzaXplIHRoZSByZWNvcmQgdGhleSBhcmUgZmlsbGluZyBhZ2FpbnN0DQo+ICsJ
ICogdHhfbWF4X3BheWxvYWRfbGVuLCBzbyByZWZ1c2UgdG8gY2hhbmdlIGl0IHVuZGVyIGFuIG9w
ZW4NCj4gcmVjb3JkLg0KPiArCSAqIHByaXZfY3R4X3R4IGlzIGEgZGlmZmVyZW50IHN0cnVjdCBm
b3IgZWFjaCBUWA0KPiBjb25maWd1cmF0aW9uLg0KPiArCSAqLw0KPiArCXN3aXRjaCAoY3R4LT50
eF9jb25mKSB7DQo+ICsJY2FzZSBUTFNfU1c6DQo+ICsJCWlmICh0bHNfc3dfY3R4X3R4KGN0eCkt
Pm9wZW5fcmVjKQ0KPiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBU
TFNfSFc6DQo+ICsJCWlmICh0bHNfb2ZmbG9hZF9jdHhfdHgoY3R4KS0+b3Blbl9yZWNvcmQpDQo+
ICsJCQlyZXR1cm4gLUVCVVNZOw0KPiArCQlicmVhazsNCj4gKwl9DQo+IMKgDQoNCkFoIGdvb2Qg
Y2F0Y2ghDQoNClJldmlld2VkLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3
ZGMuY29tPg0K
