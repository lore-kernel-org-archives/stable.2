Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575635F615;
	Tue, 14 Jul 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021793; cv=fail; b=I+FMs2DN0mjHJEORg1iQryAmlxbGAPkHEOr3ILny/vv8yhWb2DdqNNTztoMyiHQ7U5ccO+k6fJY533A0w0aT2XDakDh0pxeTEmyu/nYPiorF1C0tKtEOHUJK0VVRoTDA3yjGlRGP+uy/YH1UN7ULbd9haf5Ro7gPg6LA/MReC3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021793; c=relaxed/simple;
	bh=HG7UpKcStW1w/sZgvVUHuRwXyO43NA8RFXjZLG/hfVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhM/FhI6wvGWv+aC5ndwa12OAxUEfLPD7gwNEq595Bw5Qhoa77aLXMRoFHkCbgoVvOw316ac97vKp/veFxEVVyXH+abizV3GHECECzXjZkzLKHtvIXdDh4Y198yTFqKnbHiHzhGX9SSGAdOBaQhooEcmDItAx8m+XU+221l5zM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=YGUu+FVf; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="YGUu+FVf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y27M9vLwNejntGfUXX7ygV7/E7Ab55Oyxwv4GhKnk1FKdrEby4d92Mks5zzeYFrKorse7dOBvOzmu7QjYdLTG02xTfxvut4CELkIobPyXF9n1ZGoLIUHX6qo+isE5hBB3ZHJw5QpCqrNlEINq0VYZDN5o8uUdWwrztycfR02UbksMF9e93lOGDEQxgwwRKl3FsAj3pQCPaDA540velqohR2W+SLCiKWwrJyi0DLwo6isOaxPnfews8B0vINp8AVcPRQ8ECD7sJnCiIfO8teWKzk/DRmqMkACNa/w9nTFzHyQf0l8m7VyQinYsVYLqK3ZpUjVahP11oaRA2dPfwlS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AjX6lDAfFWDWzj+qDqiawM0InP0ZFhGa3c7q6lWGCQ=;
 b=uQ+afFV8YgE69cGzHTvSA2+ftdwpeZB6+MPphg4J14AwItKFb8h5bE9ytfMMT267w1cMXWRKkhZJnPjJshqMVtlLBAA8RpRMcfl2PtAkdOb1vfN/3uThaFquN3JxUUSUZ0XIf5H5Db5/XN9O87kF+rbseFpWKZGGrvGSutme/1Hb9O35KKSUMvhX4WtrQGZPguJx+pAxugrtctopx89YZrE7x/zu9Q6TidPajc04rXikQk2+2C8HL6RlKNtan4KkoLvdUd4yNwlZoxfmsuACqlD/ZGXGBbTExkR/q3Z2kvSzGjRSyAn5Rwb1fMdXmy2ZDqghPBGu4I3BAEMEuf+3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjX6lDAfFWDWzj+qDqiawM0InP0ZFhGa3c7q6lWGCQ=;
 b=YGUu+FVfegXPlCacIUnYNbqTHev+1sfV0ot5XoBj4+5GXqMkOIyy5aZOY/4g6A7G6xiPzDjh8SHIq6i4Wk7bffhbpcveR5ni0YYU5KM5bvfIKiP3lqW0K3/44DP7zLKBwdOIb9E/zSyk0bAxwnHVK1LnwthXMdJsTAtrOj9D3oJdGkpvSvteUzhp19lECWPFvGPBk+71jqIVy8cRFVMHzbZWFqoVzcbgU1DksafEAaueu5D2Dd51tBwEhhfW8tPzsMUacSzY304usaEn6M2vH77x5cHs5+2VjRzk5CTh98fmT+2Hhz1Foi7DnK2WjyAxJC7p50kADHb7w/5+CbtoOA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI6PPF0EDE40A90.EURP189.PROD.OUTLOOK.COM (2603:10a6:808:1::189) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 09:36:22 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 09:36:22 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Daehyeon Ko <4ncienth@gmail.com>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Topic: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Index: AQHdEqEGwrkW8+Dv30yNuY1vtlonS7ZswooQ
Date: Tue, 14 Jul 2026 09:36:22 +0000
Message-ID:
 <GV1P189MB1988C7223937187DC8C7AA36C6F92@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260713082342.3803379-1-4ncienth@gmail.com>
In-Reply-To: <20260713082342.3803379-1-4ncienth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI6PPF0EDE40A90:EE_
x-ms-office365-filtering-correlation-id: 85ae8aa2-2da5-4019-4ea7-08dee18b5dac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 152hyMLTl36CBAqZ+qrsOEbeVTvC1dm+klpdrKqn68k4zVzdRFDn7FQka85R+/eBfWW2Tq1zodLWNA7K2WmHXLwCOfpi+9S2HD4kGBCTZjRpfZv+ZLWVvVqAxwVe61MtFpziK8/LVpiglPQtS6QTn09VUFpJeVwKGaWKqGcgeVKU9Z33uhl+aMzQYSJ0uoJYs+a/bfosUmivA+TLHWCFmeEBDkrOoiY1lyeVPuaUSwYSYdJ/D0nhONBxQWbmGyE98epM37mTmEGaNOjgKpwNqF7uoJVqRmPbinT7VdC9L6XmAL+K0WDtmj7p7UWek76Xc8VT4j4QUQ/U49hpsEdNituXqY30M3F6W67boqx6ps4hMrmhXVMX8MNPS9N1WzI7Pky8kqEOvX+Xx8CgPLJGFWSDRg3JHYF7VLbtIvDfdNBO4AetRVuJFXbXWMrantW2XuXXNzI39ewglIG/qiA1o9KjZpudpgCoFuJvJmZDz+u8tfm8DDWEPgv38uFWxm+jFnjVaIy+pCOlsbhATbc0zSImePNvJ3GV02KAl4C9Mkgd9LEwNuNF4ZwZaPZctAPs06bsn8JTtRUziNKzY8Szjba3he3pgJGOUm6mK5vXGFUvqZa+o1HNPBRx7u0Iwqyl9U2buD/05SWwdl7LSOoN3Sa2yf8LfZvT9pkyLCwLHE0k9zA/ywftmmy+2TUn1hre6PqkE162OG7Yyk07RtoYhzwipFqEWnshm4yHaVZ//IM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cq6u1eueTwky5FAdCaoudhlqiJVNUh8zI4NSr8WkT0QA4ABWhXacicMwaCF+?=
 =?us-ascii?Q?AtXgedhP3HREY7OdrKa14/IJS2RQ2koQ2ftxikLf7x6W72xrqIyVNSCv8Pas?=
 =?us-ascii?Q?WPUuI17zNSENdE9iPpKTOlsUqCl+GSuJ1P4Oa0EeMuibxz6aNdAD3DFRmiJU?=
 =?us-ascii?Q?/ZBcyReKYchjRVof9LLTR4kh6ZuCKQ5qq1yQEbDfpNpS8THiMKBXcDy/bQlE?=
 =?us-ascii?Q?z2g72ty3q5FKgpHw1XWLC2NEEz3uBsneZH6Vjsa1VKUeXm4bZsNSr7qT4yK2?=
 =?us-ascii?Q?zVjL9w7rvcseHpPa1uafNSGC470SkqZ90rvi4pPtlmkP5uSq/LAuHmKTDz3Y?=
 =?us-ascii?Q?cVcOegF/dnm9ha3W5HoBY/lpfaixO7Pu+vy0hx13pGUo2UD9hjHhJqYeijww?=
 =?us-ascii?Q?naZAH9QkVC+8yidXFZad8wWmm8qH+MMeYnAIH1a0xQAgrVbNJ+iPSrUlu57m?=
 =?us-ascii?Q?4y+due3j3FpOak7N6lPWXKKmfxsIIhYbiUiv2bKrXdJmRuu0AkfPZCHrLGl6?=
 =?us-ascii?Q?w7S1Ro5yWuKnLq9wNoECbclQFJ3yANP/Njmn5EKeiWIPkXQevgKXNFyssBXs?=
 =?us-ascii?Q?SVdWOTKcYxQUwGJwXmXyti2Uex+VZ6SP/0ZeFMNIYnBDk41i2WTNH86/PHFf?=
 =?us-ascii?Q?oKCXZgQqQwitXtqU/yTbLLGPk0zaRx0PD+SmM6tO+zNmMix0o9j2E5mFNhJl?=
 =?us-ascii?Q?/g72TKsXtwysZQyESNyIOSA3U60PWlPi82XNDdV87Xro/uxMlac4a4YNSTt1?=
 =?us-ascii?Q?pwofYS/l0Kw8/YKBlTt99x0WkcO3YnwQRCPj/ilLzvCoyPCu6lTqIPh4hoNB?=
 =?us-ascii?Q?L4QMQD7cnskuqKgWMVwc7NhMDLaGdV0CzD359G8ONiVhqp3aoe123TnnjVWh?=
 =?us-ascii?Q?Lxn5CHwLBQGIZFBq6eia+Ud2U2qIdQK6BnnR9Z+bMWFqmV/MBhphb3R1IyXm?=
 =?us-ascii?Q?K15y9mY7+ufg9snfNcHa5KL1ACQJHeZSuVYJeQxse76qPv/RUPPBXu1+PZrG?=
 =?us-ascii?Q?JQ3Jr6H6kwW5mGzGDsIh/auXT2UXMl57c8VFhBhSeE1ybZITq1g9VzVY9m+2?=
 =?us-ascii?Q?qm5sT3f5asku2N6O8l51murPMqH3M82FpnQzQnMp79Ly6AzHGtKd4SBUOCTx?=
 =?us-ascii?Q?GE+LK5lTCmWE6AL0KHdBo7zrNYuosw4inJptxB1rpCNmyXR/pWraTIk7pG5l?=
 =?us-ascii?Q?NuX3EwYcz5gM/6s6k+zkWT23rRdbdd5TavTH8c8tpUVzye06Xf3a6rrfVvSh?=
 =?us-ascii?Q?NOdp3tABD5+3rzMhvbFEMXKFLJJmYWdEHhbWH3KqLANcB/dpLozmC0W8j/qc?=
 =?us-ascii?Q?Yi1MXwv5pguS6pGH75vy2b8AGlHnuck7RVW4fnEqreDp008DyjCadWd6utdi?=
 =?us-ascii?Q?I4UDhINPTw1woM+xIal9d17N+zZtQbRyO8LiIZh/AMyrvv0+phhqZ/tu2SFC?=
 =?us-ascii?Q?dUi0r3m0zyO4jtm763ejB25R7Ok9lWhzG2EPeZyXWV/V1gZS/CK2Q7f8ylx/?=
 =?us-ascii?Q?UhmlattI+BqMiN/WKYq7sx5ATtUDCqYVh3ylC7Sz/5byBOCpwJ0ecsAU8XTg?=
 =?us-ascii?Q?52qkSMBCmJe7EFhJcALA8QnaUV0wrMyXnjvuCHOXfQO0CoKwrLSiYw+bNi1o?=
 =?us-ascii?Q?Gi0EOD297BnUnHhNFZgX3m1bV+ohlyhno4TmgRCwCesASzf2TtaiPL4hiNqy?=
 =?us-ascii?Q?3b2p9e2/wAUirDay11AeRQTZFzkTh8nIzssRm5sZfW8LqILTkx4+p+VWtIDy?=
 =?us-ascii?Q?rcdVuCu47A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae8aa2-2da5-4019-4ea7-08dee18b5dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 09:36:22.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BspQG30JRyxG9THMLu8r95Hem+wO1AjxNI6R/bOcNEDDuVt0y/QH4lUsMOOf8fikJLs39IUNNppTAgU30ivP0Eud+epWebwVp3/S7jpaOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF0EDE40A90

>Subject: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in
>tipc_sk_create()
>
>When tipc_sk_create() fails to insert the new socket (tipc_sk_insert() ret=
urns
>non-zero), its error path frees the sk with sk_free() but leaves
>sock->sk pointing at the freed object:
>
>	if (tipc_sk_insert(tsk)) {
>		sk_free(sk);
>		pr_warn("Socket create failed; port number exhausted\n");
>		return -EINVAL;
>	}
>
>This is harmless for plain socket(): the syscall layer clears sock->ops be=
fore
>releasing, so tipc_release() is never called. It is not harmless on the ac=
cept()
>path. tipc_accept() creates the pre-allocated child socket with
>tipc_sk_create(net, new_sock, 0, kern); on failure it leaves new_sock->sk
>dangling and new_sock->ops non-NULL, and do_accept() then fput()s the new
>file, so __sock_release() -> tipc_release() runs
>lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the s=
k_lock
>spinlock.
>
>tipc_release() already guards this exact "failed accept() releases a pre-a=
llocated
>child" case with "if (sk =3D=3D NULL) return 0;", but the guard is bypasse=
d because
>tipc_sk_create() left sock->sk non-NULL
>(dangling) rather than NULL.
>
>Clear sock->sk on the failed-insert path so the existing tipc_release() NU=
LL
>check fires and the use-after-free is avoided.

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
