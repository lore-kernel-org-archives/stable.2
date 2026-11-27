Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795769358;
	b=sBGoDG0nU6nwuPfeQEuZ9kWUs7zBpLHSyiGVrEYYqtC2VbTKXLF63il7H1XiOQb48xLt
	 EYvYWFtDyU7A6mPDs4Er6GCw+bRRfNSyJ+PHgJSg2EQGmeUU+rbMXkI37gGj1fWCCtXnA
	 7cyu001avbR+ICnfPhaWhqN8NMb5y2pWGgk/TItZB1tPL/HTwbarC35SrOLL6D3BP/SgU
	 9UYoMRelRuWbqYMlcC7weVpDr9BWW4naili+AMHXKldxTLgSZLMiZrTe1VY6FC0htsWUq
	 kmsM72pvKHSxQz/bHg4GbODngHGqkFicf+8IMfyLzhfkZ5HPn1J1H6M+idplfJz8agQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769358;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=3RGnzTdg+afaO5IiH9+ZS8CbcQlMKxIDvDKlgMyZiS0=;
	b=g1uviTI5gvyPA9t6ZX7mdYGkrZfbZVO18kkAjWKCuZMoHXNvCkRIaxU3VOV5RULV7CWO
	 HkQwCjMr/+4V3N6FosYnAlHIOGFxCOswepGh5Qeq/wLfAQFAFNFDJkbnUw7ZIPKKLCW/O
	 ZsM2QZf+7IsBOyogzN+EbMldxDegQqaEsIuLdq1n7uss54vMC2zvuPLETgMxpOCwkUmLP
	 TkPwBeWqxlmI+32q9iAUTIV4GhG8JNG1BVgP+1vZD/8mHcjKyasLgK6V2rO3rFNgOCIsf
	 it5eokzUzb8bgiK4AY3QnU9f5N+r+KKrrocqg/y4dinHRsALCjTg/3TpLD/AMRL2qLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=eYy3nb1N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.125
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021125.outbound.protection.outlook.com [40.107.130.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AB606A326;
	Fri, 27 Nov 2026 08:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=eYy3nb1N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtV+canPLX/G/tQ0/sXcyrsPPstsJj0570sK/nC8YitQw9Yxs92aDSDyXgI4ARU/ZV/YgOgAiqcjK2j+z55WRrvIBGAq6Mp1MSlhcnVC+M9ura53d11bOTLg70w4jvj3wTdADXfiFSdVZGFh8IHP6JSLUynnx1IAyWIl/CAiRpktcJAQhkZYHsydy9B+epzf0SfFHkr17+MZ2xLoEupH7GsPg1iN9zwoq/BeOHuzjo4htUvaem3Lbh4B5HfsRgvYcFRqxI0jbR0aRdjB2/ldSBd33pimC3Ya1Fs9s5wyDVRoODUvidXOwx3ocRM/aNvZ6myIkLPK9MJ4YHTyrjq1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGnzTdg+afaO5IiH9+ZS8CbcQlMKxIDvDKlgMyZiS0=;
 b=fsdI6LNKOz2/iYVQVDnoqWTvrosyuSji+HPVcRUiyBWmhIZTSXOCAWS1hwIng8dkAFnhp/FXeqvkwKwA21zHz1o4uJ1jT9Ed6TprRWq0jt8GfNv7TeGAdqGAmg3GsHsFIU3cKB4VxyOlU9q9nRw8SI4BZ2cSYF66ctxRiun+LntOmWQuBP4LVlXB0t/LaS5MobDLQs+mFZGKB/+O58+e4jJpx2CAIdYtfyozgx/bAfMTu+lFEw8+bDOCMdtR0qducG04/gYIzw9G5W96tOwX+i+a0W7gN/3HBj+cblHqblTQ28ZvXu2B+IuqbKoXPZqIVhMZSsBOsOIwNYTOcMC3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RGnzTdg+afaO5IiH9+ZS8CbcQlMKxIDvDKlgMyZiS0=;
 b=eYy3nb1NwAKHBQyVIJCyjDYNltpzrVwl7+TM3qdFiX4Vx0MLgjw1QKqXBBRwX1TjZLUyuruhe75DdkQ+e5X9cjSVlydiIxWY+9WJoSmwA7N16KvG5mTovuO1NEGCVOG9FoB7tyXViBqAw6cUcRqGhw/pYYVQi6fi3ixzsHwTWVCqC1yfxD4JkCxD4zos4EIMMzgd3ygIfAwCWZV4qTg3rCsWce9R/LGZg9tYHT6HnkoE2+Y/S1QUzG3YqSfN+P2P1HYtnXHCObA20BD5JxIrtGqcn+sp2KRlixXlxTYjM4W8SybPzKP5V/6XEWzrb11tY7pFfrkW3pg0yM5SrzcIOA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by AS5PR05MB11846.eurprd05.prod.outlook.com
 (2603:10a6:20b:6c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 08:49:12 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 08:49:12 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "sven.auhagen@voleatech.de" <sven.auhagen@voleatech.de>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "kurt@linutronix.de"
	<kurt@linutronix.de>, "sriram.yagnaraman@ericsson.com"
	<sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, "p@1g4.org"
	<p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdcakNwPgs9FTQsEys1XYyFZRXXrcu5yEAgBLN1UA=
Date: Fri, 27 Nov 2026 08:49:12 +0000
Message-ID:
 <AS5PR05MB11020FF8D6CFDDFB1DA15BA99B9412@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
 <179473557614.2199510.972066447270237709@kernel.org>
In-Reply-To: <179473557614.2199510.972066447270237709@kernel.org>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|AS5PR05MB11846:EE_
x-ms-office365-filtering-correlation-id: 9870550f-f6b8-4484-b024-08df4c634f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|5023799004|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 FMvBKsfybtKU7rJ7L7JUl8J33AAAX41RGV9/edXVPGElzO3+UHic1Vfl9b6BgMPsN1BAtkePfhwD/ID8r4A+X3CwnMqHfYHHjVLId9guRybQAF5tfl/VVByvtFOMrPbEjgW94XhZbFyvllN89vb/lzq8AfIr1qkcrwQK5TO+Z/OKWhd+MZMhdCrdcRd53TdPM0olnJd1OWk7TcP0xJ/t7c+O1Ykbwy7HiRvUBRwHbqDjBshDzy2Vlb9rVJRtQxf9ze2F4vyADNk8BSHGreS63t5A7u7Yn9DjXtgeLXqGMlgupPweU0NXUHU1ygQjOFo4lcmGqQB/My9Kf7UPnzaVuKVTSZIAtCyAObjnG77CF3qFu7IsVRhlM6C1XbCfPaW0FDFQd2qmztveHYLiHO12b1bCFf3giq4wNII3MAPQYuc4reP1BZvLI3mzwCizUh+uZuLKbtfuJez3qT1yBa3vlTxVxcBo/DFxtWs2l0bJ/MSA8QH4r0C6qSgWZY3soIs5zyV5Bl5ACdyxTKB2G8izoRkhKhVIOgJf5CW8puIkOujyCmZDXGTjznd40Cb72nIdd78oAfhzNApicbSTM1cli5jSw1yg6bcOFa/lLZ5DeGqLNqkOUpA6GTilT+dBWrXwV5TMVrEhFF+m6BycDOd2DCJYTMSOnfQJk8R5rRPCjxDwSh1gNTwJPqDMDN9GIwPur1vV3G8Px/cz44BQFQjG/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(5023799004)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWNSVjV5S0l4T3ROSFI1SEJiLzRGRHBqSnIyZmhQUkRMUjhpUVBiWm83Sy9C?=
 =?utf-8?B?Rk1HVVcvVDdNNVFrV1ZraXRoS05DMU5seHYyVEp2N3JuT2VwS0JnT25qeGNt?=
 =?utf-8?B?aWFtR0pXZ05CbzZERmZIQVZQc0RDTzcxbGJQdDFQOXpXUm9pdjlNcWRjc3Jq?=
 =?utf-8?B?YWpseVZKb0kxaGUvKytZczhBK1FQYlVOTC9pMjZoMVRHcjFoV2ppZnZnaVVs?=
 =?utf-8?B?WEwvTnV3TGl3WExHR0JWVVRvL3RkSDNqd1h0UUJOU20xNVB1b2d3bFhHZG14?=
 =?utf-8?B?Nkk1UHFXL1A4dUx6ZUZiSTlwUStkZ001WDJSTUZiS2pOUGxpM0lVUEhZam50?=
 =?utf-8?B?V0sxWmp5N3BhZ243OE51NW90RmljTUdpaUNGZ21XU2YyUE8wY0prclpGSVRi?=
 =?utf-8?B?Y1dOSjhlY3BlMS9Cb1I2aWRSYkVsT1NuNHNwVUhZZnVHbUJrYkMwS1Y4clZE?=
 =?utf-8?B?YTJ4bHhYVjNvTHRRenhQY2cvaTBvQTJSTXByNGlhM3RnZlk4TzR1YWIvamJx?=
 =?utf-8?B?cGtyTzdFUUV0WFk5bGtsT2dTRm54eDM3OEsrUVZzYmF2c0h0QkI2VTdDS2Er?=
 =?utf-8?B?azNBdDR5V2hncXJGMEZKOEVqWTN3M2RSUWpGTjRZZ0dKM1pJUzJDTys3NXM4?=
 =?utf-8?B?SElyQ1FRWTE1MWMyOW10cmNWK1Y5dXZsZE1jTitEU29VcGhBREx0L2UxaCs0?=
 =?utf-8?B?UHRtY1FsNExaUjB2UklRajNwS3kzN0NXcmcydG9HSXplU2VINzNDWjBhMTcx?=
 =?utf-8?B?ZnYvRTRYZ0U1bXptck41RmQ1VEdMaVZRM0VTeGlkRkd1VCt3WjdrV3ljN2I0?=
 =?utf-8?B?K0NaYjJaSnNrUUgxODdhTTZLVjY3OE5FelJHMTJOMk82cStPemNTdlpHcmNz?=
 =?utf-8?B?NWNpRFQ0dVlmRSs4U3czamVkT2ZNSUw1SWpEMWNEZng4eUhXNUxvYnJ3NG5q?=
 =?utf-8?B?ZzU5R05UVVdMSG1LUVVDMjViWjRTdXdpQlM4OTY5cGlJMjN6eTZuOU9DWnEy?=
 =?utf-8?B?YUJYRVpkYTdDZ3BUZ1hOYnJ4SUlTU0RSL1RwWXd1VVhhdEF4NWxnVlR4NXg5?=
 =?utf-8?B?U3JQZzk5WmZKRDhLc01RelMzdjczbS91MTZIejNrMmdhUHNUYTVQLzR2aFY3?=
 =?utf-8?B?bFFpYzNmdzlvME84emR1M2VTK1NEakhDR3NWTGpmSG91bFB6UlZlVE4wM0dK?=
 =?utf-8?B?WWpzc2ttQXhjMVJDcWtZQVc1TDZmNG9hN0RWbHVVSktGT2tKeUJQVlpRU1k4?=
 =?utf-8?B?dUxiMFhmazFtSTNoaXJFNlRCaWhkeElyMzI4Y1VKWm5aOS9lbjRCMGtyTzQ2?=
 =?utf-8?B?MEMwYzZuamlFRTNRdmx5ZmVDdmM0dXVkeStxNmtEZGtuWkxsNmxpKy9GY3Jz?=
 =?utf-8?B?KzZLdGhSUEpLNFVWcTZNUGZaeEtoL2pvdFhuUDZBRmhVZCtaRmhDRjJzZGRU?=
 =?utf-8?B?OEp1WlJIL1pZNWxaR2Zyay9ERXFBOGVKVytjVVEyUWxtZGhaVmtvTzh1QUpi?=
 =?utf-8?B?MlRhbldMU3RXazR0bWVZZHhlUzhJUW9veTJ6S0R6WnFzRGhYZG5McmZ4Qml1?=
 =?utf-8?B?NEkxVjB1Y2czVTd0d3FNWlJtTUxPelVNRE14ZC9tTXZCNjlEbStIaUtTNldQ?=
 =?utf-8?B?a3p6a1Y3MEIyalhtK3FyZ0xoNGpJZEZyZG5PTG54bzNUWWNRdmJvaDJkdzE4?=
 =?utf-8?B?T3lxS0tVNEwrMEJQL09pRVR5OFl6WE1hQTVubkJQd0R4TE9OaHU1VkQraXZD?=
 =?utf-8?B?NWk3TXZkaWpnYzRrNjh6MnVlVVBGWlZnQVg2c2ZOVGV3VjJwUlAwT2ozWnJn?=
 =?utf-8?B?RURzWWJKd0c5cDVNMXNkcHJKN3ZNL285ZVdkdDJVT0dBek9qMCtWWEorRDlr?=
 =?utf-8?B?U2FRZmhZdEV3N3gvb3hlYktHVU5hMC91TThveGNVWFFmRjdjV1doQmdySkZz?=
 =?utf-8?B?R09tbC9GWFNod3JtQ2NTKzNkVWp1amtKWjMvUGJGUDV1b3ArdlM0VGNrdnlq?=
 =?utf-8?B?ZHRnaUxHdlp0d0JxUGJvRmszZk5IYzBwSEhmR2hnbmF5VkRLR1AzQmNXOFl4?=
 =?utf-8?B?eTdDT3NsSHMzbmNpMEZ2Tnc0RGdQU3Y1QVlnU1pWODVyR3hUbUJvenVvZTRG?=
 =?utf-8?B?ckpFNVhHa3FRSmdIcnJ4RXUrR0VxRzFWY3FiMHl2djNXQ2loOVFhSWdFRGpi?=
 =?utf-8?B?bVU3K2N5b044OTB2SFJXT00vaDQ1eWhMMDMrZXVuUExxYlZFTmtzTG90ZDMy?=
 =?utf-8?B?bFk1cEF1d05VR2RjTTFaaUczTlRNNHZGQnRYdUVIOUc3bjlYQU9HME9LQTkv?=
 =?utf-8?Q?FUR3u3rZr1BW2ks4V0?=
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
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9870550f-f6b8-4484-b024-08df4c634f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 08:49:12.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RWUX0rQxLwgmMzb8nIWJn1tgqTIJC2TUo6mguO40BolLKq75MVWOPZ058uat411ttCyGUiYxA5iuzKVZ3MNjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR05MB11846

PiAtIFtNZWRpdW1dIFRoaXMgaXMgYSBoYXJkd2FyZS1kZXBlbmRlbnQgRE1BIGJvdW5kLg0KDQpU
ZXN0ZWQgb24gYW4gSTM1MCAoNy4zLjEpLCB3aXRoIG9uZSBWRiBvbiB0aGUgc2FtZSBob3N0IGlu
IGFub3RoZXINCm5ldHdvcmsgbmFtZXNwYWNlIGF0IE1UVSA5MDAwLCBzZW5kaW5nIHRvIHRoZSBQ
RjoNCg0KLSBQRiBhdCBNVFUgMTUwMCB3aXRoIGFuIFhEUCBwcm9ncmFtIGF0dGFjaGVkLCBzbyB0
aGUgUEYgcG9vbCBsaW1pdCBpcw0KICAxNTI2IChnbG9iYWwgUkxQTUwgOTcyOCB3aXRoIFZGcyks
IHdpdGggUnggdGltZXN0YW1waW5nIG9mZiBhbmQgb246DQogIGZyYW1lcyBvZiB1cCB0byAxNTI2
IGJ5dGVzIHdpdGhvdXQgRkNTIHJlYWNoIHRoZSBQRiwgZnJhbWVzIG9mIDE1MjcNCiAgYnl0ZXMg
YW5kIG1vcmUgZG8gbm90LiBUaGUgTUFDIGNvbXBhcmVzIHRoZSBmcmFtZSB3aXRob3V0IEZDUyB3
aXRoDQogIFZNT0xSLlJMUE1MLCBzbyBpdCB3cml0ZXMgYXQgbW9zdCB0aGUgbWF4aW11bSBmcmFt
ZSBzaXplIHBsdXMgdGhlDQogIDE2LWJ5dGUgaGVhZGVyLCB3aGljaCBpcyB3aGF0IGlnYl94c2tf
ZnJhbWVfZml0cygpIGNoZWNrcyBhZ2FpbnN0IHRoZQ0KICBYU0sgZnJhbWUuDQotIFRoZSBzYW1l
IHdpdGggeGRwc29jayBpbiB6ZXJvLWNvcHkgbW9kZSB3aXRoIDIgS2lCIGNodW5rcyBvbiBQRiBx
dWV1ZQ0KICAwOiAxNTAwLWJ5dGUgcGluZ3MgZnJvbSB0aGUgVkYgYXJyaXZlIG9uIHF1ZXVlIDA7
IDE2MDAsIDMwMDAgYW5kIDgwMDANCiAgYnl0ZSBwaW5ncyBhZGQgbm90aGluZyB0aGVyZSBidXQg
dGhlIGJhY2tncm91bmQgdHJhZmZpYy4NCi0gQSAzMDAwLWJ5dGUgYnJvYWRjYXN0IG9yIElQdjYg
bXVsdGljYXN0IGZyb20gdGhlIFZGIGRvZXMgbm90IHJlYWNoIHRoZQ0KICBQRiBlaXRoZXI7IDUw
MC1ieXRlIG9uZXMgZG8uDQotIFdpdGggdGhlIFBGIGF0IE1UVSA5MDAwIChwb29sIGxpbWl0IDk3
MjgpIGFuZCBubyBYRFAsIHBpbmdzIG9mIDE2MDANCiAgdG8gODAwMCBieXRlcyBmcm9tIHRoZSBW
RiBhcmUgYW5zd2VyZWQsIGFuZCB0aGUgc2FtZSAzMDAwLWJ5dGUgZnJhbWVzDQogIHNlbnQgdG8g
YSBNQUMgYWRkcmVzcyBvbiB0aGUgd2lyZSBkbyBsZWF2ZSB0aGUgVkYuDQoNClNvIG9uIHRoZSBJ
MzUwIHRoZSBpbnRlcm5hbCBzd2l0Y2ggYXBwbGllcyB0aGUgUEYgcG9vbCdzIFZNT0xSLlJMUE1M
IHRvDQpWRi10by1QRiBsb29wYmFjayBhbmQgdG8gcmVwbGljYXRpb24gYXMgd2VsbCwgYXQgdGhl
IGV4YWN0IGxpbWl0LiBUaGUNClZGJ3Mgb3duIFNFVF9MUEUgbGltaXQgaXMgd3JpdHRlbiB0byB0
aGUgVkYncyBwb29sIG9ubHkuDQoNClRoZSAyIEtpQiBidWlsZF9za2IgcmluZ3MgYWxyZWFkeSBk
ZXBlbmQgb24gdGhpcyBsaW1pdDogd2l0aCBWRnMgdGhlDQpnbG9iYWwgUkxQTUwgaXMgOTcyOCwg
YW5kIG9ubHkgdGhlIFBGIHBvb2wgbGltaXQga2VlcHMgYSBmcmFtZSBpbnNpZGUNCnRoZSBoYWxm
IHBhZ2UsIGFsc28gZm9yIGZyYW1lcyBmcm9tIGEgVkYuIFRoaXMgcGF0Y2ggbWFrZXMgWFNLIHJp
bmdzDQpkZXBlbmQgb24gaXQgaW4gdGhlIHNhbWUgd2F5LiBJIGhhdmUgbm8gODI1NzYgdG8gdGVz
dCB0aGlzIG9uLg0K
