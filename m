Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764E36C581
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379216; cv=fail; b=pn+6b5e+ljJBiMI12Nwd0QMzMKMPROpw6nOJdjTqli30M8vATiMv5nc6XfagETqhgC2TcP5zDSJyLxmIc/tQ5SE/OM1OIMbDd/kEiBAEqWWwC8yzOiQ4RZ9W3GEBRvNEWpj0f+zdx5L1/+odLElGnTS5pVqJD0HTHuk10vvrjaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379216; c=relaxed/simple;
	bh=qjpPss3kDP3wuFXeFzCCe4HkaVq92y6iloEMi4GCTH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeS4/VNJ8dhFJ9VtcT/XSrR1IiRC18qXg0YvQcw5PMGlp10OvzmbnPYD3CvKwOhw/lxh5FMCy3awT0KNDRubxFWUbO0STlGf9juTLUKbHunFY/J2yuqmKlo7gY0my+McI3LtDPpai0XkiEld5OwmnesWKczqtiEYIMbDhh6h+fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=lC42e5Cs; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="lC42e5Cs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYXyjh2eT/PKA4PSwJGX22avpUgPhmBENxVaP/a/3CMOQKZyBeJwqU3aHGJT+uzDhrd33qb3ffNrXkhZKWffFJzzNRRo5YShpnfku3cdh32JvTh0g4Lu9mGexD/ITjImck0BH7Y3pEdLhYwx8SlIK9uFdyp2Uf/uQ2/l3aEdDQyqf1cNm4GjzFFJOqoLmlpVo5P8aYd9YOtx3UkY0swpRF6443bGufKk51nhbEsd9RSoukJJV7cvr4AeNuPKvJaH6P9FDk7tpEmOAQ2Z0uJ7rtNsJanjIKWnhlRCECiAqmiC2hPItj4/lodVIqqs7cG4XjS0Z/XoZ3K3aLhECXUqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjpPss3kDP3wuFXeFzCCe4HkaVq92y6iloEMi4GCTH8=;
 b=oLRY9b6m+1N+8+TkQxbm4wGfsUz/3KS85gJU4Y03Jxv9vZSX3WNiNjkJjAk2J64GAWsDr2n438ObgOmSTdc9Xcynvc3bu1+8XZigpg9525l4tjH8FMyXSVpQgrqeKpKh5NIej16ZSxLNEINy93qnoXF1axs6EPZ2X0rXS/2kAO9ytgsIvbfwTsxZFGPiZzOwRbvBa+3rPYJFyYfT7o3Tncb+sP/ajtY0uZB44B7NiuB+BAwWFdTocgQpkvZ6vi5nHmvMLXZVxuTnwCMpNfqu1m5nKDD5nTMmAKh22T75slYdf1UFILgEU/Ef3Q0IUi2Cg5fUEmJviB0qJfGEPBmoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjpPss3kDP3wuFXeFzCCe4HkaVq92y6iloEMi4GCTH8=;
 b=lC42e5CsgaD0DhiAuGnODslX7GDOX4AXmQSEg5gzgbtfgMJlFTWeT1c2tU1UjjTbABXNIdcgAUJXt2BSsHdai/e24bn29KaEUXoXT1QdlBHvZiDm+mucuW1nChev9ww+llbR3YP4Xzk7nvwjT7w/lyUn1W1osKI6s/Hwa2tpv50AVP5gKyUU6FzcW+KCyH0gdxcYZqT8swVt88uNLLwjMJ/GVMUXFrpLXGOILzh0XcgJpcyGs4FnHJ8lEfGHaHLa+Vx0GwlJCZc/wG/AsxnqUTxitZtuiFaqaFf6kjG3/U9Gz1jRwXpN0mKQ0xyjxgVPiUE4FfuUPSxI/ZSARmxG9Q==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA2PR03MB5836.namprd03.prod.outlook.com (2603:10b6:806:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 02:40:11 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 02:40:11 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dinguyen@kernel.org" <dinguyen@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks
 and list corruption" failed to apply to 5.15-stable tree
Thread-Topic: FAILED: patch "[PATCH] firmware: stratix10-svc: fix memory leaks
 and list corruption" failed to apply to 5.15-stable tree
Thread-Index: AQHdH14/i7wOdFt1F0Wx6vgKgwnM7raFWr4A
Date: Thu, 30 Jul 2026 02:40:11 +0000
Message-ID: <7bc7cb32-c129-42bf-964d-12c0e5582338@altera.com>
References: <2026072955-anatomist-verdict-df3a@gregkh>
In-Reply-To: <2026072955-anatomist-verdict-df3a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|SA2PR03MB5836:EE_
x-ms-office365-filtering-correlation-id: 4f624562-0fff-47f4-b6c6-08deede3e06b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|55112099003|38070700021|4133799003|3023799007|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info:
 Ofd5GlaQndvfpg3TRsGDGwEqdxBO8I4CcNXQwxm2YUyTw4aNgPzdfu6aNvN5u6GS6n7NDCCLkjjKRDaKwSWtwqYAMoe1FO1aQ+P0sH+ycI2paUSkA626HMeFb1JmJ+aM5xk5q77C3X3tw9bFIVIc8cPeGd/95Q+hA6Od9pRc7IZrGoA6lVIAhmMg+TuZPAqkS8pdGBXYhaMTwqyOy6xlR1ebsU1KFDDaguQep4yFi6lpZbIbg6DVOLY5iJUbOXYge1fnB2dk+AZFtlbw2BtsI8h12kdfdLQ24mOCItJhtSfu9fIAMaklGc2iJj5rTuunEVmDAApp3HWmGJ5q1i1rDHluLF5iD3yPuWpYjo5AXIVey2tPJd9iOXmUzErZSevWkWVe5gQXK0FuMM4Ge1gzQirbqoSDKkCxMn2PPZdUAH51lz1beO3oPNjuARXkZwih9+EfH69W8RnK6fu9ro5SPuI+qDBb4KG5hVO6L33OWqPRFbLxie6MKFa84al93YswxG+qMHyjzuhxE14mcy7KY5ymeOFazOopUq9JzCSxaDvTG1s8/KFEM85xJ9yILbyip0M190QyU7GzksNBqmRwBj+Ta/81iHu5ZKVTpi7orM0/LIEbh7QF3LmCPU/J868wO/ygAS8i7BdT2g5AeCQ+u7pnDYwVy9KVrGodPXJHe5MCs1L8gczXolpB+W5hGqlB/l9TbU8zh4aaQZWijwwcdAUilneQY4Sd2UJ5EuSvSEM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(55112099003)(38070700021)(4133799003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVRFMGRwRkxoYzQ5NUZzWjFhM1FhTDZlaVN6Um10ZU5pbk4zSE9rNzhVVVNt?=
 =?utf-8?B?N2M0aExvSjEvVGNLMEFKUC9KUXJwTllWVm1zOWNYSzNkb0luTUVDRUhUKzdJ?=
 =?utf-8?B?Zm1LVDg3R0tEV2xvMzgxMlBXMXFKS2VQNlVkWWkvYlZpdTVOeE5pdTlIQzZV?=
 =?utf-8?B?TWNpVGpaWlF4WnFvSjk2K3MzREF6ZDJZbWFNS29sL0tmaHVLNzRrK1h0Vlcx?=
 =?utf-8?B?ajBEMXJVdjRUZWd4dU96cjdqd0lPSi9hK3FGWE4weFNuS0pJSU4wcU1DTnV5?=
 =?utf-8?B?cVJlOFdWcmpmVWJMbCtBcjUxOEM1Vy91enJyT2NkNWRybkZRYytnNXN0bUJD?=
 =?utf-8?B?WXZueEM1aXdsUll6clVaVkQ3ckpJS1NiMTFZeFFsUU1IYlh0Y2F2QkdVMi95?=
 =?utf-8?B?MWtFT0ppVUNpSTRQN1doRno3Vzl6bGFuZUY4QXF1bGUwUFJFSzlTMUJZNjNN?=
 =?utf-8?B?aVJ4dnZIZll3aGVyTXVLbm9NUDJTd050SjlONHZrSzNKUW44VklyRUxLWXJC?=
 =?utf-8?B?WGdEc1U2Q1I3Q0JYTVVuZHF1a2M4M2RkZUQ2OUQyMTNSRzFMekcvOW9HYU1o?=
 =?utf-8?B?bE8yYTRUb0d6Z2dFMi9mbU82NnV1aU5vd053UTNjeEQ4VkNpU3FaTCtSdlVm?=
 =?utf-8?B?WHEvR0N4OUJZaStzK2dGV25aVk9BUkJ4K3RYaVJvQ3hzRGg2TVRyc0MvUG5r?=
 =?utf-8?B?djdBOUV6MXRyT3NGM1RLWmk3ODZSSTNKMjZ0eHllR2tLbi95SW9LMXVCLzJR?=
 =?utf-8?B?YUxwcG5XbUE5WHJkQi84UEExbXB5OUJBNUN2VUZ5YjUwc1ZIeUk2TFhBUkVy?=
 =?utf-8?B?VitWYVNTWkF6ZDN4UHc2dkM0ZVUwcVFob2NCUjkzRGV5RnRJY3dnU3YwVXhp?=
 =?utf-8?B?bS9JVlg1V0dzclF1TzZpNXRvQU9mMmR0dUhoQzVZOEgrWmJ0TVg1QnpCd3Ez?=
 =?utf-8?B?WUluMW01VG4yeGw1Y20wSk4wRXlYQ28rZ0pFWEZrWVRmT2VRdzdjNWU1YWdR?=
 =?utf-8?B?Skl1MVFYODFVVTZKbWNaWXA4YkRIYUovNyt4akYybXMyNjdlY1p3SUxSNkdM?=
 =?utf-8?B?aDR2VU9QOEh6dHNNQW1LamE3Z2NVZFQ0VnExelB6d2N2TjNxckhKcmhGc0lQ?=
 =?utf-8?B?SWlmbGYwR0ZJMC9qWTB4ZTlWTndmbnhKclk4T0ZUaFdVTXh3QWxhV0hBN2ti?=
 =?utf-8?B?bzkwY2dETEpPbHNtNEMvTXUyL1hoaDZKcC9BRm5hQURubStlbS9rMzlhajRE?=
 =?utf-8?B?OHBmVkZJV1czUkFjVTBCWjZncG1KeUdKRVZNTG5yUVVLcW9WZUNQUUpIZmZH?=
 =?utf-8?B?TExjWkRhemVmbXFCWFltNTBaOHZnWXVhZ2pzL3hpMW9FYjRnL2JnZ0ZDMjJ4?=
 =?utf-8?B?VW9maEFhdU1XMXQ1R3BSMkdwR3QrclZJb2ZvQVpSN0dHVzNYZnZPVUN2MXFh?=
 =?utf-8?B?Y3RmV1RmQ09FTFY2bEcrUEt0Z0RHdFVqTitnRXRPUEVIRytHZkdFZnMzRDZ1?=
 =?utf-8?B?ZUR6UlhuQk9rbTJLRkdiK2tCTlhHSlZ4am93L1FpTUdhaEU2aGVQdjUrY1Bn?=
 =?utf-8?B?akZYajl0UDk2SkRHN202L0hjcGVjVFlTb1FZeS9pU0xFMUhHUUlka2VMMGow?=
 =?utf-8?B?TVlhUHFLRGduMHAzSGMwY09XSEF6ZjJ5WlJCdzVndGRXcnFnTmtXSnpIVk5Q?=
 =?utf-8?B?L1NEcWc3YXhxaWZOaDdYd3Y0N29NS3YwSjFKZ3Z6UXluUjNQTGluZW5iSkwr?=
 =?utf-8?B?NEVGbnVwT0syUHd2S25qQm1IZWNPbUFYL01zWVRIdTV0Wm5lYXJUQTNlcjBG?=
 =?utf-8?B?U1dsOEVCcVFEaHZWLzNEaTNqSnFGSjhGTEI5eHgzTi9LejhGaUZIb2t6bHJv?=
 =?utf-8?B?YVFKK0JmM1pvR05uTUFBS0hmdS9mOW1oY3lSOThwV2VxaDBRZzh4UUJzbExI?=
 =?utf-8?B?TDh6Q3dqR2RxTzRGUVJOblEzb1dIeEhRSUdPUXpmLzhZa0NPRUdTclZpMmZm?=
 =?utf-8?B?UTRMcGFDTDdOSmUwM3lySWEycnNqeG1CSjhSeEpBTzZTL0NaS01hR2hWbGRU?=
 =?utf-8?B?NUx3T3ZqU3E0SlFsTDFpV3B0QUhTQWg2S2JJVExSbjRyUU5iZWVwZyt3ZWIv?=
 =?utf-8?B?dncwU3N2Q3plYlRUbjk1YWZGQzVTN1V1NExEMm1zMGdpUDBpZkhjU2JsZDAr?=
 =?utf-8?B?VStKenAxRXRPOHRwNnh6aWN6MnlEQ1IycUN0SW5yQ3I0SjVnSjZhU3dISHZL?=
 =?utf-8?B?b2o1MlZQK2ExNjJsLytlWHp2d2tUUW1DN0xiczMxTGNqeWZneS85L3dXZ0Vu?=
 =?utf-8?B?WjhyTUl6aDhOVVJuWUprNDRYTktuTkVGU3NvbTJRbWY0K1J1MXErL3gxbFAz?=
 =?utf-8?Q?UrrmYI60mCz2kjWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58EF213B3995FB49A4EC7BB07A373DFF@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f624562-0fff-47f4-b6c6-08deede3e06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 02:40:11.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41Ft2YtqjCFn930N5umPRE+h/EkhWBIi+DsUD3fkm+gcn/o5Ygjhgb19PVyRW7+PgwrUf/OTcqN8dEplCCXRKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5836

T24gMjkvNy8yMDI2IDk6MjggcG0sIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0K
Pg0KPiBUaGUgcGF0Y2ggYmVsb3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDUuMTUtc3RhYmxlIHRy
ZWUuDQo+IElmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90aGVy
IHN0YWJsZSBvciBsb25ndGVybQ0KPiB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3Bv
cnQsIGluY2x1ZGluZyB0aGUgb3JpZ2luYWwgZ2l0IGNvbW1pdA0KPiBpZCB0byA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4uDQo+DQo+IFRvIHJlcHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3Vi
bWl0LCB5b3UgbWF5IHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzOg0KPg0KPiBnaXQgZmV0Y2gg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC8gbGludXgtNS4xNS55DQo+IGdpdCBjaGVja291dCBGRVRDSF9IRUFEDQo+IGdpdCBj
aGVycnktcGljayAteCA5MTE5Y2ViNzZlOTg3YzJlYzJiNTQ5ZWExMDBlMzI2OGNlM2ExYzdjDQo+
ICMgPHJlc29sdmUgY29uZmxpY3RzLCBidWlsZCwgdGVzdCwgZXRjLj4NCj4gZ2l0IGNvbW1pdCAt
cw0KPiBnaXQgc2VuZC1lbWFpbCAtLXRvICc8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4nIC0taW4t
cmVwbHktdG8gJzIwMjYwNzI5NTUtYW5hdG9taXN0LXZlcmRpY3QtZGYzYUBncmVna2gnIC0tc3Vi
amVjdC1wcmVmaXggJ1BBVENIIDUuMTUueScgJ0hFQUReLi4nDQo+DQo+IFBvc3NpYmxlIGRlcGVu
ZGVuY2llczoNCj4NCj4NCj4NCj4gdGhhbmtzLA0KPg0KPiBncmVnIGstaA0KPg0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAtLS0tLS0tLS0tLS0t
LS0tLS0NCj4NCj4gIEZyb20gOTExOWNlYjc2ZTk4N2MyZWMyYjU0OWVhMTAwZTMyNjhjZTNhMWM3
YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogVHplIFllZSBOZyA8dHplLnllZS5u
Z0BhbHRlcmEuY29tPg0KPiBEYXRlOiBXZWQsIDI0IEp1biAyMDI2IDAzOjA2OjM1IC0wNzAwDQo+
IFN1YmplY3Q6IFtQQVRDSF0gZmlybXdhcmU6IHN0cmF0aXgxMC1zdmM6IGZpeCBtZW1vcnkgbGVh
a3MgYW5kIGxpc3QgY29ycnVwdGlvbg0KPiAgIGJ1Z3MNCj4NCj4gRml4IGEgbWVtb3J5IGxlYWsg
d2hlbiBnZW5fcG9vbF9hbGxvYygpIGZhaWxzIGJ5IGZyZWVpbmcgcG1lbSBvbiB0aGUgZXJyb3IN
Cj4gcGF0aC4gU3dpdGNoIHBtZW0gYWxsb2NhdGlvbiBmcm9tIGRldm1fa3phbGxvYygpIHRvIGt6
YWxsb2MoKSB3aXRoDQo+IGV4cGxpY2l0IGtmcmVlKCkgaW4gdGhlIGZyZWUgcGF0aCB0byBtYXRj
aCBpdHMgbGlzdC1tYW5hZ2VkIGxpZmV0aW1lLg0KPiBSZW1vdmUgdGhlIGVycm9uZW91cyBsaXN0
X2RlbCgmc3ZjX2RhdGFfbWVtKSB3aGljaCBjb3JydXB0ZWQgdGhlIGxpc3QgaGVhZA0KPiBvbiBm
YWlsZWQgbG9va3Vwcy4NCj4NCj4gRml4ZXM6IDdjYTVjZTg5NjUyNCAoImZpcm13YXJlOiBhZGQg
SW50ZWwgU3RyYXRpeDEwIHNlcnZpY2UgbGF5ZXIgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcgIyA1LjArDQo+IFNpZ25lZC1vZmYtYnk6IFR6ZSBZZWUgTmcgPHR6ZS55ZWUu
bmdAYWx0ZXJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtl
cm5lbC5vcmc+DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgxMC1z
dmMuYyBiL2RyaXZlcnMvZmlybXdhcmUvc3RyYXRpeDEwLXN2Yy5jDQo+IGluZGV4IGMyNGNhNTgy
MzA3OC4uNjMwNmI3OWExNGExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0
aXgxMC1zdmMuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3N0cmF0aXgxMC1zdmMuYw0KPiBA
QCAtMTg1NywxNCArMTg1NywxNiBAQCB2b2lkICpzdHJhdGl4MTBfc3ZjX2FsbG9jYXRlX21lbW9y
eShzdHJ1Y3Qgc3RyYXRpeDEwX3N2Y19jaGFuICpjaGFuLA0KPiAgICAgICBzdHJ1Y3QgZ2VuX3Bv
b2wgKmdlbnBvb2wgPSBjaGFuLT5jdHJsLT5nZW5wb29sOw0KPiAgICAgICBzaXplX3QgcyA9IHJv
dW5kdXAoc2l6ZSwgMSA8PCBnZW5wb29sLT5taW5fYWxsb2Nfb3JkZXIpOw0KPg0KPiAtICAgICBw
bWVtID0gZGV2bV9remFsbG9jKGNoYW4tPmN0cmwtPmRldiwgc2l6ZW9mKCpwbWVtKSwgR0ZQX0tF
Uk5FTCk7DQo+ICsgICAgIHBtZW0gPSBremFsbG9jX29iaigqcG1lbSk7DQo+ICAgICAgIGlmICgh
cG1lbSkNCj4gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4NCj4gICAg
ICAgZ3VhcmQobXV0ZXgpKCZzdmNfbWVtX2xvY2spOw0KPiAgICAgICB2YSA9IGdlbl9wb29sX2Fs
bG9jKGdlbnBvb2wsIHMpOw0KPiAtICAgICBpZiAoIXZhKQ0KPiArICAgICBpZiAoIXZhKSB7DQo+
ICsgICAgICAgICAgICAga2ZyZWUocG1lbSk7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIoLUVOT01FTSk7DQo+ICsgICAgIH0NCj4NCj4gICAgICAgbWVtc2V0KCh2b2lkICopdmEsIDAs
IHMpOw0KPiAgICAgICBwYSA9IGdlbl9wb29sX3ZpcnRfdG9fcGh5cyhnZW5wb29sLCB2YSk7DQo+
IEBAIC0xODkwLDYgKzE4OTIsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChzdHJhdGl4MTBfc3ZjX2Fs
bG9jYXRlX21lbW9yeSk7DQo+ICAgdm9pZCBzdHJhdGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KHN0cnVj
dCBzdHJhdGl4MTBfc3ZjX2NoYW4gKmNoYW4sIHZvaWQgKmthZGRyKQ0KPiAgIHsNCj4gICAgICAg
c3RydWN0IHN0cmF0aXgxMF9zdmNfZGF0YV9tZW0gKnBtZW07DQo+ICsNCj4gICAgICAgZ3VhcmQo
bXV0ZXgpKCZzdmNfbWVtX2xvY2spOw0KPg0KPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBt
ZW0sICZzdmNfZGF0YV9tZW0sIG5vZGUpDQo+IEBAIC0xODk4LDEwICsxOTAxLDkgQEAgdm9pZCBz
dHJhdGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KHN0cnVjdCBzdHJhdGl4MTBfc3ZjX2NoYW4gKmNoYW4s
IHZvaWQgKmthZGRyKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVu
c2lnbmVkIGxvbmcpa2FkZHIsIHBtZW0tPnNpemUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
cG1lbS0+dmFkZHIgPSBOVUxMOw0KPiAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnBt
ZW0tPm5vZGUpOw0KPiArICAgICAgICAgICAgICAgICAgICAga2ZyZWUocG1lbSk7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAg
IGxpc3RfZGVsKCZzdmNfZGF0YV9tZW0pOw0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChz
dHJhdGl4MTBfc3ZjX2ZyZWVfbWVtb3J5KTsNCj4NCj4NCg0KSGkgR3JlZywNCg0KVGhhbmtzIGZv
ciB0aGUgZGV0YWlsZWQgc3RlcHMuIEkndmUgcmVzb2x2ZWQgdGhlIGNvbmZsaWN0IGFuZA0KcmVz
dWJtaXR0ZWQgdGhlIHBhdGNoLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3
MzAwMjM2MDQuMTQ5OTYtMS10emUueWVlLm5nQGFsdGVyYS5jb20vDQoNClRoYW5rcywNClJlZ2Fy
ZHMsDQpUemUgWWVlDQoNCg==
