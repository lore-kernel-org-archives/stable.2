Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022125.outbound.protection.outlook.com [52.101.126.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A113C2770
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321746; cv=fail; b=spa6ZTdeAf3QXVrMxU0N1d/MKwxxracbv/esOLFh4/RbKttaAohON3SIRAsEj+sCoRsN5KmtXg5dSh5Mj5qV/iu3lVn/Pmab+2ArdDrKJRBj7jXvDW3SIkcTP6aiZvp3TS7Yj49g5J07W+bSOcT5n+MDYLIVdgJX8tWSZwWQRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321746; c=relaxed/simple;
	bh=qP3xreDy+yLqoZWDg8O+a2dGUVV+mvZjaYg5alXp+0A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ouSN/ZIyrVqiptrD9TQBU9UwdGM4kQVGpZGPfb1nwwqcPIywE0vWgbXWlMhSOsk9uhYQ+Ftb+BNiNrA9zEJBoV0TwXbXOE5dN/mOvn8BTDqmeNCdnTBrJnzeyXETnDZr3z9BiL7LvAvX6RSzG3Vh+wJKzl3oRLIOutP9HdyYKXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=TwhRl69N; arc=fail smtp.client-ip=52.101.126.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="TwhRl69N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSAb3q9uGggrRfYTjfi4qfSir+jgUm1V67lFgUrsYRr2gHzoQ21k8UYtbpBOp5UAB7IeUpeuSXk7RMw7KztBzd6Taw9JpTmb7+z0KKNC6EenYWbj/dG7c2VaqJSAdhoVdVGDRfrljGWxSuFk4bP/GeoJh9qvCIoRyCc/I0+tqnhtNN06O/LTl07W6LaMTCvFZbmhzsbM9pkjeHm1yrp6nMfCMU2bBARySpUy0RCigAN7hvb2HyFH4ARD3LQ3SfwAN6QCc6ZeywxHNI1X9BwFUWuZaE1LtdkSPlK4bZyXL+iKOjphbkxg4g9fhmUgNQ5sFzYvEJcEd1784C100HfFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP3xreDy+yLqoZWDg8O+a2dGUVV+mvZjaYg5alXp+0A=;
 b=UX3XU00CJWQwAnm95793lXYEi9EZh3yiGO4/pFSZ8YZsrOdIUnQYwBlrCDXdm2oSMX1NEj9xOpb9X91pt+V4QMwy9gbU2Rf/PUES5eo/fUrDhotO5zUDxGcPbG4AeSRGN5nL9np/xnyRBpNZBsAW9SfbxB8Mxf3L/7jzpnuO18Rla0etHjsiDBT7NZ6EriBKlVOn+qDMKt37Jmzn/3iOPS7BjNY/KCG6MKvY0ox9tbTj0xrOkcH0AT3pb8swCk0T6ef+N2K7F/APuFJo999/yOc9wwV1BRGlQcf/yTvbBoEEJf69keqQLkpBofqd3EgpzznPAHDr1QYo77Q3MTZ1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP3xreDy+yLqoZWDg8O+a2dGUVV+mvZjaYg5alXp+0A=;
 b=TwhRl69NB+JX5gBEKi/natpkfOcSVQMWVrJ35qcZcd6dXD0p6abS0knEtWYPiz+NPNYGM94QeFsU1QhGN3A1ARSvSPQN395aUO12S/Sgk2bJtx5CX6K+1ynNLLMs912Oq7Q2ObDEkxp4ZORItq3OaPfKwhZ9CXfYc9YWrSJSG8M=
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com (2603:1096:101:2e8::6)
 by TYZPR04MB7577.apcprd04.prod.outlook.com (2603:1096:405:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 07:08:54 +0000
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2]) by SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 07:08:51 +0000
From: Ao Sun <ao.sun@transsion.com>
To: Jiazi Li <jiazi.li@transsion.com>, Hongyan Xia <hongyan.xia@transsion.com>
CC: Ao Sun <ao.sun@transsion.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Avri Altman <avri.altman@sandisk.com>
Subject:
 =?gb2312?B?s7e72DogW0xpbnV4LWVuZyBQQVRDSCB2Ml0gbW1jOiBibG9jazogZml4IFJQ?=
 =?gb2312?Q?MB_device_unregister_ordering?=
Thread-Topic: [Linux-eng PATCH v2] mmc: block: fix RPMB device unregister
 ordering
Thread-Index: AQHdDRZM+4fyANilE0KZOUFL4f2qqw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 6 Jul 2026 07:08:51 +0000
Message-ID:
 <SE3PR04MB8921F16414896A3EBBA4970B9CF12@SE3PR04MB8921.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-traffictypediagnostic:
 SE3PR04MB8921:EE_|TYZPR04MB7577:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 129329fa-979b-4f19-7a83-08dedb2d6ebf
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|42112799006|376014|23010399003|1800799024|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 8l0qqkeGZR06TSxx20E7gNS+uPKkSK+t/cIuhJy0haNZp6LfoihMfe6sEiulIYWg5Rnom1Yl/iXH5D4WFUj5sQ6UuG8iSmK//Chg2bkaK3SFuFXLNovJFdhWS21JqAw910Au2DIeOIB23HfdwBLmkHZqoVxINlKpHmirXAeL1+/nMW2N2EpwRECkQCtolDomY1xrUGVMZRNB5AZpLmHbXjxUleQpCR1dv9x8J2zfvsW+gXXvk4s/fXm93+mNq1V/1Q80opOthA8hNWPv81Pc3b6CH+6EpRHlQ0a5aSn4idrhgYJpSH42EI9SBwBX/JoymIS4PURR14dGSdexO0/04/bEGoGacOjjNgk6M+Z+blXp8854Xqsbo4wtnHykvOOqmm2mDxFpdfkAHdVbtYkKgIhIek6sWP6RKAH42HP9NR/H1TTLuRgCYKrsyLr/Ooc6U4viTArGpnScqoWz7jg4KcRP1UJZLlKEsSVGGeHuz0si2STr7C0HENU6WPgIE79HpWUi00r4S+yQ+DhdG5JycuQgQzDwi4/8EVHGY2hyvf3bmv43uctpsiQWhZRCphVLxeocFMV8AhLuXFVCaka4Bo3nn2a6OjJqEVMlg4A3Zp7PvXTof1yDqtXgMNsShHtj0XC7Va+p8Oo7O3hOiHqtLq6wS6Z4A1aH/o6CjqXZ45DDVEMHHekteOH4MGK+clvJYQGhBSecxPd/Txjjfh9JBhxsndvx6gs6HDX5bEt7G90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR04MB8921.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bE9rdVl5ZUJEN1cxb1UxZ2RTdEJDa2tvTVNxZ1pYSDg3cDZMMUEyZmwvTDZJ?=
 =?gb2312?B?STY1d1NZQ0pDbzJKRVpOZXc1WVF4aDd4NEcyUFF3alB1akJPcU5aK3Q5V2Fx?=
 =?gb2312?B?KzFnMjJkbVlVMThWNEwzRC80UlhyUXBWOUpLVGYwQk1qZHdWNVo1T0QxZVhT?=
 =?gb2312?B?cU5xQzdiN0dqU2Rnc2tBc0Fza01zZytHUjYxazlHdS9TT0hNNDBNeGd3bjdh?=
 =?gb2312?B?YlpqQm9QMlkzSldyd2ZsYUJHU0x1YkYya1I0UDVrenVhNE8yZHE2ZCsxMVZ5?=
 =?gb2312?B?VUdYRTVZencyRC8xNWpjcWtmTVFlOU02c2lnOWVWRlA0UVBscm96cDM4ME55?=
 =?gb2312?B?Y1hJOFVNYnh6WUFiSjlTSkZvYlh4N2x5NDVMaVZWbUJZbDZObmlWRkZGQ05B?=
 =?gb2312?B?bWNFM0hiSHB6aE1XbW5rOGVXZ2VIU3lXWURScThQdDRsN2tHWUd4SVdML2JU?=
 =?gb2312?B?ZFUxNkRhYVF4ZTluTHptallIcXVJL2FmdXVIcWJLak1Md1NMY3ZyRE1odWhR?=
 =?gb2312?B?M3hSUjFwVUtoSmlQejNGVHhnSGRzUzRuWS9DREZTYVVDbWlFZzE2TEVCNXVW?=
 =?gb2312?B?Wk52RUgvcG9wWVVvMEd0djlEaHlkSGV5ZEZoZXdPZUVmZ1RwN1d3REhYNEpl?=
 =?gb2312?B?ZnFGVGJOZHZLZzByYUFpMER6TUFDRVlOUXBqQmxrWGxwdmZ3YnY0VkxPYm84?=
 =?gb2312?B?SWFIUUpHOElRU2FKaUIrYjlqWUJGeHJkSWRrZi9tR1dLV09BMTFPNmk5UVJ4?=
 =?gb2312?B?OWtiMjRLckV1VjZsL0Z0bVI3ZnYvYS9CVzNWZUswdW9tTDNPRkRnMEN1Qk1j?=
 =?gb2312?B?YzF4Q0pLcUxsbzJrb1ZpcHhuOVRNOUVZUU9xekpDLzlURWN4TDNyZmhiZEpU?=
 =?gb2312?B?T3RXYnlQcnNlZ0cwOVNWS21oTHczOG82NFd1WEovNFluZ0pGZFVNUURnUExs?=
 =?gb2312?B?bENNUXgxLzVzWGpUYVVrSnkxOGV2QnRoQ2xvekJkVjg2Nkc5MlhNeEIwYUVV?=
 =?gb2312?B?NHZWdVNhSlE4THEra2piTlJhNEZPNEdaZU4wcUtyclUxM1AyUU5yaUtFUU5G?=
 =?gb2312?B?VWJ1a2xYeS9sOWlmVlRPY2M1MDAvTDkyRXRTY3dQbkQrK0V3OUV5T1JBMGZO?=
 =?gb2312?B?bGZTVlppakhTRE4vMjZJalZZWnJEOVJvK3RnWXkvMHgzS2xGNEdPbE9SSURs?=
 =?gb2312?B?YWY0YmJqRjB5OTJ0Tmd2dFlJeHZ2N0E3SEpXR0hLdkpOaHVKNkFCOUxSQTJN?=
 =?gb2312?B?UU9wQmZQVWtOUDZLNTY1c0hUNUMveDcyb1J6aS9QbVEvZmlzTU12VnY4RHAw?=
 =?gb2312?B?MDBabXg2RThKMlRxS0VFN0Z2Rlpma0FMbzdhTWZwVnEvSlFoRWkwWFY5VUVW?=
 =?gb2312?B?WGJ6RXVMMGpHQjZzUGIreUNIVDZkMEJuZEV2eE5uSENzb2IwQkVEMExRTkRN?=
 =?gb2312?B?cHR6cnpRdFYyU1lxekFiNkRJTTRyclhaais5TTI4YlJnM0FVOHlObDE0Rld1?=
 =?gb2312?B?aEJhRXN6cnFld2NKNGR0TzBnRUVwWWpGWms3NkFvWW9sekhjZVFBZG00RW5T?=
 =?gb2312?B?WkZWSlVTZzB0MGp6aC8yNkV1YmpNSm1SdzNMdnV6UkJvUlpSdmFObk9CNUFk?=
 =?gb2312?B?Uk9qWEt3NjVwblNrdEhSRmhlYzBZN204WDZOL1YrM29yOHBMMnlrb0pKVXIw?=
 =?gb2312?B?cUN1dnVpb1hRV1N1MWMrdEYzS3FtUi9rZ1JNVG5YdVcrOEQ4RkJZM1RBME1m?=
 =?gb2312?B?U1RSdVoxSVdEK2xxQ3p6TG5vTU03THQ2WnlxVkRUOHFYcVJDZHc3WXphT3Jl?=
 =?gb2312?B?dGdGNWlLdlVtYjdtc05jOHZaU1JYSjFRd1J5cC9qYVFuOFMxSUVnNi92VGNu?=
 =?gb2312?B?N09SV3JENlM2ajB0UzRHMlhCY1VyNFJUV0MybFRrL24wMVY2QW1HUVN2b1hI?=
 =?gb2312?B?SWxndU82aW4zR2oxdDJWYzljbDJhRXV0Vi96RFJteGRlb1phUll3NVJqa2p2?=
 =?gb2312?B?Y2F2NEFXbE0zRHBSMjZFWnB0ejFWWFdqRS9HS1g1R290MzdCaDZiSkVjbkFj?=
 =?gb2312?B?LzJrbzV2LzI5bEVjVnE4YU03cnNhbys0TmRSbWFFMTIyeG1YSlRaVVBIN3lt?=
 =?gb2312?B?ZmpkeWpacGQ1UmNFYmQwbTcrK0dTdWlZcEZ5SHVwQ2VjUDJFTDltbnNIeGor?=
 =?gb2312?B?M0pqU2Y5OGZ0QkRhSEtOdG5RMHEweUF4M1hibTlJNG1Sdlg1M1VhZ2ZMUXpJ?=
 =?gb2312?B?WGNuSElxeXhoUjNwVDMrS1ZKNGdsV2UwcnRlTlhBd1BkSDJkWE1KOHpjOGdz?=
 =?gb2312?Q?iMbV0rVfGyKf0WCDj6?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8921.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129329fa-979b-4f19-7a83-08dedb2d6ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 07:08:51.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPXxQ3iOyHw3biCzPc6OzKB39sIp2cruYhGws4WbFBCItIAhmDE86239sYXaaxnZeEKHdmBl6oyLtROzt53W3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7577

QW8gU3VuIL2rs7e72NPKvP6hsFtMaW51eC1lbmcgUEFUQ0ggdjJdIG1tYzogYmxvY2s6IGZpeCBS
UE1CIGRldmljZSB1bnJlZ2lzdGVyIG9yZGVyaW5nobGhow==
