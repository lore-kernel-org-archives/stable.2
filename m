Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795363338;
	b=gaXBnvJh8AzjbzcHWitVGXgAsbOUpDn3J8KE4YVfRzWKADl9Jv9kW69xP8Yw0qok9duP
	 lU7RXOSihjdIfwZd7hEeNXmigEdW9hAC2xMDDVjAxRC1NQA7/YgPGdhl9nwXAWX/h/9pl
	 to3+6GR1BIgS5BmH7g0JuuNJBahx+GjRhRwFh3pGs+pWWHupSnmKy6lnYwU5pnziTHDfv
	 rAHUg/LG4xw6ucV14L1/L75rBHoPDd6KhLfKqW5xvWP7+vxBYDJskH1HphQ6dPdAO8C2V
	 1xfCvtdOlGgK8cL0JXKNWnN1kNUNb8P9iNjcTy3tFrqNbPoh7QYmXUG8oCHO5XmVwPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363338;
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
	bh=gCCnQ5Yw4ndvtiU7xEGpyYE7dHcsJJ7jNYWgJG4Nujs=;
	b=3p7ppHwGOM7RLRbHRwPemPTfGY0VQcHLMV1Kbj0+F5UwckpXKi5SaowdoGPFqNTAQAOz
	 DVnnRB9rlhmPsl4TU3U/4QCJVC+POdfkNaB6isFvC0cApmqOW+zgveD44rkLLdr1iPqkz
	 QvqcaMHyHxrA5wWoLAIkYZET5bN5RnV3y595SFmqVfudIJ2IvqUlhjPjJGK1BnJFYgBtL
	 z2blQFVbc3ciHiCT+pq7fpFPOZM9SIpfwb/JPaf9t0fi2RcGjqc7x35Hz1Nf9uE5LFP5Z
	 sDtnj3irSk7AgoS90qEB4lydSVkhomQ6RCaI1OGH0XWA5WHgh/Bl/LDJ3BvA6N+jP3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fO+cMvRs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.70
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7752606A320;
	Sun, 22 Nov 2026 16:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7752606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fO+cMvRs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqAai5q0V4ae4xxAFKx4Xnr1fpI+/MVxs7dkvs8UlgarkpbgU1v0Ti7enELe3YQzYtx7/DKBb56/nKzL46OvG9lor3FEIioyVPIhXG+U9dFh4DAt7U2UQejP6xfP7JKzcbFimQnrXk2h7XDvmzWWLYa9JvdXwBxnqDeH//ZqFlgY9Uqp5RCtkKtGOsmHuncRWkm0ZeTv7urQZPIV4CwUtUXHG0CYgN3SXj8RvILccBJalw8mvW4OMsogcufoi6AJ/mcEVVgqh8KJDjefy1idwP5WgytkezzWaZxaf85+lOi1it3E3WJQkUo2XiAgEPE6Yw0OI/iSvpPqg9IRdK4JCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCCnQ5Yw4ndvtiU7xEGpyYE7dHcsJJ7jNYWgJG4Nujs=;
 b=LeXOq6FPliIVQWCWJ5BoIqVk6MSrjjnsWqgjgfyFLHHepHfJQL/KhcsdyClUORpVBbujgPURVSFiCJLxIYNirPxCPV7EH/LNvwUMvwW5KXUprTyiFPDUhlMNznu3NAW2SPgkPzM1dRvOGPJN+33peUrPn1U+54nm0SPIkjLgfQxJ4+mzWdy/dQrK555j5OJedRABuEaeXCjONr9uUe6NybGpWnbSEmYTUEphzBqMTE4j99JaemAMBcYhfW7v2lcpxiD1h/SvKhlUzNa966Ovw9LmHJL9FQLC9iiG9wwMh5BMDnvqjZAO/Y8MhJB+B+vk+YPyTbPj522oHy1k6qlEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCCnQ5Yw4ndvtiU7xEGpyYE7dHcsJJ7jNYWgJG4Nujs=;
 b=fO+cMvRssybK5D5tL0ORb2RwlqK351FuZ54WMRYw0ZwIus2+pzKC2ZB7BMBX5oGPYQvD4kGlORZBMmuv7I6W8XdKcPVHbQRTqTop5K1PZcM1hhErlztfinqPKjSqC1ON8iZ7i8rR9/vDKbWYj+87X29TgJp5tuxCeIe+XusbzHe17MuyLhXZRr+BnAn8iJIW0eQVjVwKAyWjxJCbNXPUmGBwRbrbAxPMI9WHCx2XMIe5k+KRSefp75+10Nrj+Wqep95Gal9wCgNKfRciBoQLyRTjT8ebrRSZTcza4OpDPKiRVQx0N2vFV2ArW47ZIJLbFuELSaD84djFKdBDm139qg==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Sun, 22 Nov
 2026 16:02:13 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%4]) with mapi id 15.21.0639.011; Sun, 22 Nov 2026
 16:02:12 +0000
From: "Qiuxu (Leo) Zhuo" <qzhuo@nvidia.com>
To: "me@ahmedabdelfattah.dev" <me@ahmedabdelfattah.dev>, Jason Baron
	<jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/ie31200: Give each DIMM two chip selects again
Thread-Topic: [PATCH] EDAC/ie31200: Give each DIMM two chip selects again
Thread-Index: AQHdeFR8jKQEXykmxEeun+Da4s0cmbc6QBqg
Date: Sun, 22 Nov 2026 16:02:12 +0000
Message-ID:
 <CY8PR12MB729059D6B66095F842FD470FD1462@CY8PR12MB7290.namprd12.prod.outlook.com>
References:
 <20261119-edac-ie31200-rank-stride-v1-1-3514fcccb130@ahmedabdelfattah.dev>
In-Reply-To:
 <20261119-edac-ie31200-rank-stride-v1-1-3514fcccb130@ahmedabdelfattah.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|SA1PR12MB6704:EE_
x-ms-office365-filtering-correlation-id: 86192100-8b7c-4864-1a81-08df48b1f874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261102123227099003|261026140227099003|38070700021|11063799006|261022105027099003|261021121427099003|261009223027099003|261022075727099003|56012099006|261028144727099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 lU2onM8jgtk+D0nfhj5QHCznEzKhzuMOvM5upPfw7+dw99eiK4Ob1oHEzv2LYMhUeod57F5IBkvTinRTbP8dLpwIqqC3B4vuedwZiVUYx9ZeQnaIq0643xMynQxBEV+rd4x4hYCnkTFkkodLGix2mGlF4KaUHFFA6AP+G/pTZhv+50WjdfrLLwNpjwNtIt61I1eZbNtQZ5qeLS7lSYly+1lAzX2l3Up9Kw3x67jmHMzOCdffbukUtcqtDSGZEJPBpu3Y0hEgV9DyitAQwrPY2SAH5P4meSEowVDqX6LuEe5BrGlzz1+WXPz/6kAQ7QtlVKj+laULN9maM2r8IW9sUZyNjnX/8l9R0OMyymR+Wjwvw7np87HgKZ8oh6KOxwGs+PkF4cqZ4apa5XKBTYQovmIPYnrqmmJKE3XdjVpz6q5n7savMifN4KapgtxhwbggrJQO8GNg4t7V38UgjjAKBXaEsnui3SVH0kfut+adxEgCmfifO4r1AkcdaXn5rEm9DralGVJtXguQMtE7H04ghIC7JAjz538r5cd3Zhux4+BdVyJzqR7uIlFkdrd+UkPOIW9V3si3uGjWkn0AdjZXHaQbKOjJUz3BOlQplQ3PXSaaIGhry5iujFIQkz/0j8EQwLVNqaw/5LK144RWQpGhdi/fr46vyeNMu1z5dh28eoHftPfN9tkMKGg2V3BF0vV95MtzXiyKnHBV1P5zu2XWdlhjPCbkk0GDULPbNS+DWKk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261102123227099003)(261026140227099003)(38070700021)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(56012099006)(261028144727099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OERYL2lFT0RoeVdrcTlDa2dOSUFKUDAvVmZFSGJ6QTJBVWMvYlVZQmUyZHp6?=
 =?utf-8?B?Y0NGMHl3YlpqbWREYUxBVmliQlNJNkhERmJ3R0J1WHBKT3ZtdFBKWEtzQUd4?=
 =?utf-8?B?a0JESm95Rlo1STdjenJSZHJiQzV6NmIzQno3Zng4Z3YwWmVVRitqR3Ywd2Nx?=
 =?utf-8?B?OWdERDFBS1pudnpDNXZHOEtXZHhYaDRtcWxzNHlyQXVoblZ4VVAwQjBrU3dK?=
 =?utf-8?B?TTZWQ0QvN1RucGlWeFFWSys5Vlp2eWtpTHhwVnErVzZnMzFBL2V1N29XNDZS?=
 =?utf-8?B?MDdob25sNmpDWVlKYTVjRVlyaVZrOU1sT0dWdE5MLzdwZ0cySWFXOExiR1M2?=
 =?utf-8?B?OTZqRUtFLy93SGc5SlAvazQrVXhGYXFjOGNqRGt3amp5QVZBbzR0b2lQWkc3?=
 =?utf-8?B?TlBaV21odGpub0FITzhFQUYzQkdMN1dPaS9hKzJCMVZFbFB6a2hmNjdQSkI4?=
 =?utf-8?B?N2Q5NXRuazUzWVRndFc5MDduTnZHVVp2cGM5NGgzUDlhUEFkbmFmZThUWjh1?=
 =?utf-8?B?cEFSd1psVExqLzNTazRnVDVUT1JxaFFxUU1BQmtzekM4NFhvcHg1cm9VRXVY?=
 =?utf-8?B?eXFXYSs5d0JOR1NMcGJXRHVqWTVVZXc0eUgySXNKdGtyWk1mNjlnbjV2ck9O?=
 =?utf-8?B?VVpRRFlkdWlaUUY1eDR4ZGZxZEFHRU5BemFSS3NmVHcyLzg1ekpGMTZsNFdB?=
 =?utf-8?B?REtyMm1yTXZocHRIRnBpZGhqdTBmZExESFlENk0vajlxdUZZcGZ1TVBuVnFT?=
 =?utf-8?B?YWxsOExTOXIvM2hGVENoRXlUWHNtakdLdE5PRDhRc0cyZUp3MVY5SUlwWnps?=
 =?utf-8?B?ZktISDhydDNzbVBFTUNKcytBTVlLQUt1ZzZ4MjU0ZEJFUkJrQjk3MzR3TUtT?=
 =?utf-8?B?dFhtRTZXdmlmUVlYVGd2U1ZVTnhTM2JuMG01YThrVEloSExNZ3NJbk5MWVFk?=
 =?utf-8?B?THVocXZFTGxaUkw2cWRnY2pPU2NEL0tLaFFlMldrbjV2S29uQ3VVWmp0YkFU?=
 =?utf-8?B?bGMwQVAyaXh5U3JsUTB6clI0STRVZkVEZVJQNWIwaEsyYUovOFd4N1U0Nlkr?=
 =?utf-8?B?UnZKTTd6eVAreDJhQVBhQTQ3ck1MWVRLclJ5RWJEQ3BINUlrbExFcGFWQnBz?=
 =?utf-8?B?N2ErcU0zcmQrZHNwMm9PWlZJSlQ3eWdtS3NmSGV1eDVGWDNxZFdka29RbWNo?=
 =?utf-8?B?OHk4d3FDRlk0U3N1Y09oMFBYMTlPRGVFajVKeTdZKy9BSmxRWXZ3Y2F2RmZx?=
 =?utf-8?B?c1N2SisyTnp0Uk9RZU53L0ZDYU9ET005WHBreUVvSGRZNFVwNmlPRzFoUDZM?=
 =?utf-8?B?N3FqOUxOc3V3dzk1dUJPcm9qdGhiSDRZZG1aYXNsVGpHQ09oTFRrclg0WEFV?=
 =?utf-8?B?UEZWeEoxZzhnby9iRHRPd1Nackl0WUN0U2Q3bE9iRFNIdFQyNTdyZGUyUWdN?=
 =?utf-8?B?OExKWDI4RGRXTVVNczQzalJ0YklCSi9nSzBaQTZ6cm92Z21kdy9pQnY1VnNq?=
 =?utf-8?B?YXFQZXREaHd2ZXVqNlRuTmlsZTNsSjZ0SHo1blhnNXFIdU94TVhOazMvZ3Mx?=
 =?utf-8?B?YXkwYzV4VTYycEJ1SEsyQnZ2aHNmUzRYYWdwRHJ3MHo1N3JQdGlrT3A5ZUY5?=
 =?utf-8?B?VlZUb2VrSmErcU56QXRmTDMveWhlZWpFSDR4QXBIU3Fxcm51S05kT3EyREVy?=
 =?utf-8?B?VE15dWx6QmhvUE93YytaNkpodWRJaEVLRUZuSCtQZGtIak5RYzBscnVtSXpa?=
 =?utf-8?B?QnZWaVhiMUl5Z1NJa0J3Q1ZUSmFKWTRTeVRUSTBCSFhqRFJmbmJnMHZWQWEv?=
 =?utf-8?B?UU5QbHZxM3JQUlMxZzVwdDJaTzFUVXUwNSt1OUU1NTAzSkgvajR6N0ViSDRP?=
 =?utf-8?B?L0hyNS9GcUpNN2QyOGhRLzdldGhZTG4zazgrd09vQnZVU0dGM0FBMlBrckE0?=
 =?utf-8?B?TnhMNHdPdEFxa2ZiMzQvQWNPTjdsWksxNjlMUjZZUjB6T1E4MFg4eUNvOEpD?=
 =?utf-8?B?UElyVUFtS2VFZmIxOC9nTXZWVnJiWVQzVUo5QXlKZkVtbHBGNWU1dmVNV2dK?=
 =?utf-8?B?aFpVY0Q5SDlMNndvRG5vNjhTNjJGSi9Pa2hpTVdMblREejFDdW1Ra2kyY2JV?=
 =?utf-8?B?TmJLYU9GN2wvcFZXcmwzYzFsb2lYcXJzZmlzNjFqVlduQ1dReHNyWWMwWEYy?=
 =?utf-8?B?ZityZ1EySkhPd2h6R3cwOVN6T2lXYjc4eXE5Z1lLUTZPOWFpMWh2ZlNLcktM?=
 =?utf-8?B?QnJQZ2doeU5lODNqWnJmb0trMUNhbmoxMTd0WTRuM1hyck14NTBpZzZpWlB3?=
 =?utf-8?Q?QFCB1evdjqLYgl7chX?=
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86192100-8b7c-4864-1a81-08df48b1f874
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 16:02:12.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c44AlT/Lg0woP7xcWGEUNocRS15LjnaikvgX3drPNj738DVvyBx13W8itjbaZbpOZ8sU5j66YesDFYu61VwsWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

PiBGcm9tOiBBaG1lZCBBYmRlbGZhdHRhaCB2aWEgQjQgUmVsYXkNCj4gPGRldm51bGwrbWUuYWht
ZWRhYmRlbGZhdHRhaC5kZXZAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAy
MCwgMjAyNiAyOjMzIEFNDQo+IFRvOiBKYXNvbiBCYXJvbiA8amJhcm9uQGFrYW1haS5jb20+OyBC
b3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IFRvbnkNCj4gTHVjayA8dG9ueS5sdWNrQGlu
dGVsLmNvbT47IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0KPiBDYzogbGludXgt
ZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IEFobWVkIEFiZGVsZmF0dGFoIDxtZUBhaG1lZGFiZGVsZmF0
dGFoLmRldj4NCj4gU3ViamVjdDogW1BBVENIXSBFREFDL2llMzEyMDA6IEdpdmUgZWFjaCBESU1N
IHR3byBjaGlwIHNlbGVjdHMgYWdhaW4NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlv
biBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gRnJvbTogQWhtZWQgQWJk
ZWxmYXR0YWggPG1lQGFobWVkYWJkZWxmYXR0YWguZGV2Pg0KPiANCj4gU2luY2UgY29tbWl0IGFm
ZGJjMzY1NTU1NiAoIkVEQUMvaWUzMTIwMDogTWFrZSBzdHJ1Y3QgZGltbV9kYXRhIGNvbnRhaW4N
Cj4gZGVjb2RlZCBpbmZvcm1hdGlvbiIpLCBpZTMxMjAwX2dldF9kaW1tX2NvbmZpZygpIHB1dHMg
cmFuayBrIG9mIERJTU0gaiBhdCBjaGlwDQo+IHNlbGVjdCBqICogcmFua3MgKyBrLCB3aGVyZSBy
YW5rcyBpcyB0aGF0IERJTU0ncyBvd24gcmFuayBjb3VudC4gSW4gYSBjaGFubmVsIHdpdGggYQ0K
PiBkdWFsLXJhbmsgRElNTSAwIGFuZCBhIHNpbmdsZS1yYW5rIERJTU0gMSwgYm90aCBESU1NcyB0
aGVuIHVzZSBjaGlwIHNlbGVjdCAxOg0KPiBESU1NIDEgb3ZlcndyaXRlcyB0aGUgZW50cnkgZm9y
IERJTU0gMCdzIHNlY29uZCByYW5rLCBtYzAvc2l6ZV9tYiBpcyBzaG9ydCBieQ0KPiB0aGF0IHJh
bmssIGFuZCBlcnJvcnMgaW4gaXQgYXJlIHJlcG9ydGVkIGFnYWluc3QgRElNTSAxLg0KPiANCj4g
QmVmb3JlIHRoYXQgY29tbWl0IHRoZSBzdHJpZGUgd2FzIGEgZml4ZWQgMiwgc28gRElNTSAwIGhh
ZCBjaGlwIHNlbGVjdHMgMC0xIGFuZA0KPiBESU1NIDEgaGFkIDItMywgYW5kIHRoZSBjb21taXQg
ZGlkIG5vdCBtZWFuIHRvIGNoYW5nZSB0aGF0LiBUaGUgZXJyb3IgcGF0aCBzdGlsbA0KPiBwYXNz
ZXMgdGhlIHR3by1iaXQgcmFuayBmaWVsZCBvZiBFQ0NFUlJMT0cgdG8gZWRhY19tY19oYW5kbGVf
ZXJyb3IoKSBhcyB0aGUgY2hpcA0KPiBzZWxlY3QuIElmIHRoZSBjb250cm9sbGVyIHJlcG9ydHMg
RElNTSAxJ3MgZmlyc3QgcmFuayBhcyAyLCBhcyB0aGUgb2xkIGxheW91dCBhc3N1bWVkLA0KPiB0
aG9zZSBlcnJvcnMgbm93IGxhbmQgb24gYW4gZW1wdHkgZW50cnkgd2hlbiBESU1NIDEgaXMgc2lu
Z2xlLXJhbmsgKG9yIHdoZW4NCj4gYm90aCBESU1NcyBhcmUsIGFzIERJTU0gMSBoYXMgbW92ZWQg
dG8gY2hpcCBzZWxlY3QgMSkuIFRoYXQgdHJpcHMNCj4gV0FSTl9PTl9PTkNFKCFlLT5ncmFpbikg
aW4gZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKCkgYW5kIHRoZSBlcnJvciBpcw0KPiBsb2dnZWQg
YWdhaW5zdCAidW5rbm93biBtZW1vcnkiLg0KPiANCj4gR28gYmFjayB0byBhIGZpeGVkIHN0cmlk
ZSBvZiAyLg0KPiANCj4gRml4ZXM6IGFmZGJjMzY1NTU1NiAoIkVEQUMvaWUzMTIwMDogTWFrZSBz
dHJ1Y3QgZGltbV9kYXRhIGNvbnRhaW4gZGVjb2RlZA0KPiBpbmZvcm1hdGlvbiIpDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEFobWVkIEFiZGVsZmF0dGFo
IDxtZUBhaG1lZGFiZGVsZmF0dGFoLmRldj4NCj4gLS0tDQo+IEkgcmFuIGludG8gdGhpcyB3aXRo
IGEgUUVNVSBtb2RlbCBvZiB0aGUgS2FieSBMYWtlIGhvc3QgYnJpZGdlICgweDU5MTgsDQo+IHNr
bF9jZmcpIHRoYXQgSSB3cm90ZSB0byBleGVyY2lzZSBpZTMxMjAwX2VkYWM7IGl0IGlzIG5vdCBw
YXJ0IG9mIHVwc3RyZWFtIFFFTVUuIEl0DQo+IGZpbGxzIE1BRF9ESU1NIGluIGZyb20gdGhlIGNv
bmZpZ3VyZWQgRElNTXMgYW5kIHJlcG9ydHMgZXJyb3JzIG9uIERJTU0gUyAodGhlDQo+IGRyaXZl
cidzIERJTU0gMSkgd2l0aCBFQ0NFUlJMT0cgcmFuayAyIG9yIDMsIHdoaWNoIGlzIHRoZSBsYXlv
dXQgdGhlIGRyaXZlciB1c2VkDQo+IHVwIHRvIHY2LjE0LiBJIGhhdmUgbm8gbWFjaGluZSB3aXRo
IHR3byBESU1NcyBwZXIgY2hhbm5lbCB0byBjaGVjayB3aGF0IHJlYWwNCj4gY29udHJvbGxlcnMg
cHV0IGluIHRoYXQgZmllbGQsIHNvIHRoZSAidW5rbm93biBtZW1vcnkiIHBhcnQgcmVzdHMgb24g
dGhlIG9sZCBsYXlvdXQuDQo+IFRoZSBzaXplX21iIHBhcnQgb25seSBkZXBlbmRzIG9uIE1BRF9E
SU1NLg0KPiANCj4gVGVzdGVkIG9uIHY3LjQtcmMzKyAoNDQwNWMxOGM5NWQyKSB3aXRoIGJvdGgg
c2xvdHMgb2YgYm90aCBjaGFubmVscyBwb3B1bGF0ZWQsDQo+IGluamVjdGluZyBjb3JyZWN0ZWQg
ZXJyb3JzIG9uIERJTU0gTCdzIHJhbmtzIGFuZCBvbiBESU1NIFMgaW4gYm90aCBjaGFubmVscywg
YW5kDQo+IGFuIHVuY29ycmVjdGVkIGVycm9yIG9uIERJTU0gUzoNCj4gDQo+ICAgcmFua3MgTCAr
IFMgIHdpdGhvdXQgdGhlIHBhdGNoICAgICAgICAgICAgICAgICB3aXRoIGl0DQo+ICAgMlIgKyAx
UiAgICAgIG1jMC9zaXplX21iIDMwNzIgaW5zdGVhZCBvZiA0MDk2OyBtYzAvc2l6ZV9tYiA0MDk2
Ow0KPiAgICAgICAgICAgICAgICBESU1NIFMgZXJyb3JzIG9uICJ1bmtub3duICAgICAgICAgRElN
TSBTIGVycm9ycyBvbg0KPiAgICAgICAgICAgICAgICBtZW1vcnkiLCBXQVJOIGluIGVkYWNfbWMu
YyAgICAgICAgY3Nyb3cgMg0KPiAgIDFSICsgMVIgICAgICBtYzAvc2l6ZV9tYiA0MDk2OyBESU1N
IFMgZXJyb3JzICAgbWMwL3NpemVfbWIgNDA5NjsNCj4gICAgICAgICAgICAgICAgb24gInVua25v
d24gbWVtb3J5IiwgV0FSTiAgICAgICAgIERJTU0gUyBlcnJvcnMgb24NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNzcm93IDINCj4gICAyUiArIDJS
ICAgICAgY29ycmVjdCAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuY2hhbmdlZA0KPiANCj4g
T24gUlBMLVMsIE1BRF9ESU1NIGNhbiBkZXNjcmliZSB1cCB0byBmb3VyIHJhbmtzIHBlciBESU1N
LCBzbyB0aGlzIGFsc28gbW92ZXMNCj4gRElNTSAxIHRoZXJlOiBhIDFSICsgMVIgY2hhbm5lbCBn
b2VzIGZyb20gY2hpcCBzZWxlY3RzIDAgYW5kIDEgdG8NCj4gMCBhbmQgMi4gRUNDRVJSTE9HIGhh
cyB0aGUgc2FtZSB0d28tYml0IHJhbmsgZmllbGQgb24gUlBMLVMsIHNvIEkgdGhpbmsgdHdvIGNo
aXANCj4gc2VsZWN0cyBwZXIgRElNTSBpcyBzdGlsbCB0aGUgcmlnaHQgc3BsaXQsIGJ1dCBJIGNv
dWxkIG5vdCB0ZXN0IGl0LiBRaXV4dSwgZG8geW91IGtub3cNCj4gaG93IHRoZSBSUEwtUyBjb250
cm9sbGVyIG51bWJlcnMgdGhlIHJhbmtzIG9mIHRoZSBzZWNvbmQgRElNTSBpbiBFQ0NFUlJMT0c/
DQoNCkkgbm8gbG9uZyB3b3JrIGF0IEludGVsLCBzbyBJIGNhbid0IGNvbmZpcm0gdGhlIFJQTC1T
IEVDQ0VSUkxPRyByYW5rIGVuY29kaW5nLiANCg0KRm9yIGNvbXBhcmlzb24sIEludGVsIEljZSBM
YWtlIHNlcnZlcnMgZGVjb2RlIHRoZSBwZXItY2hhbm5lbCByYW5rIElEIGZyb20gTUNpX01JU0Mg
YXMNCg0KICBESU1NIDA6IHJhbmtzIDAsIDEsIDIsIDMgDQogIERJTU0gMTogcmFua3MgNCwgNSwg
NiwgNyANCg0KU2VlIGkxMG5tX21jX2RlY29kZSgpIChodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2Vk
YWMvaTEwbm1fYmFzZS5jI240MTUpLg0KDQpBIHNpbWlsYXIgZml4ZWQgYWxsb2NhdGlvbiBvZiBy
YW5rcyAw4oCTMSBhbmQgMuKAkzMgb24gUlBMLVMgbG9va3MgcmVhc29uYWJsZSwgYWx0aG91Z2gg
SSBoYXZlIG5vdCANCnZlcmlmaWVkIHRoYXQgRUNDRVJSTE9HIHVzZXMgdGhpcyBtYXBwaW5nLg0K
DQpZb3VyIHBhdGNoIHJlc3RvcmVzIHRoZSBwcmV2aW91cyBmaXhlZCBzdHJpZGUgYW5kIGZpeGVz
IHRoZSBkZW1vbnN0cmF0ZWQgb3ZlcmxhcCB3aXRoIG1peGVkLXJhbmsgRElNTXMuIA0KVGhlIGNo
YW5nZSBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogUWl1eHUgWmh1byBxemh1b0Bu
dmlkaWEuY29tIChxemh1b0BudmlkaWEuY29tKQ0KDQpUaGFua3MuDQo=
