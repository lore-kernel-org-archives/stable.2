Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107ED49B466;
	Wed, 23 Sep 2026 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161711; cv=fail; b=buzW6hJwWEKW+ElmgYwE/TbS8o+vK4Zc0+d2kbyJzv9je4nyo3yA8tkKnnzzPdhpekbZfSgmyPRzPvay0p7+m+/xf0t1DlDMqtnpndiry3HGuGBbGKsmJwZHzcIB7M60xYEWf9R5rzh++Sewgb4hnPLGsO6i2sqAvhiTepLmBew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161711; c=relaxed/simple;
	bh=EaqO7TvktQvpXXgZtfAI7hg/pM8MZbFKFnKbs2RFNI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnbgnIR9m3S6X+7sNUvSY2tQ9At1jvYG0BU0lUzLUmLAKJq8Msti97sd1T3+vlKbTpIQH2Albu3pCIF2VO8jjXww3AtFHrKqLG4+600Qcmfm9A4EEbUqPAUu3KkhryX6UCml7HAyAHIYWHobdqJ9Csn3f6I3PwQR1jucM0AmSyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iyewAS8v; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iyewAS8v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV7rlgbq01VzOiE3R8TUk9U17bcH4mnsDQsvks5KB0BHYXOIFMfvAxdWPdRKDK1/TV9N3+dp+t9g2JGJOiMdAbrg4f182HaKGiFg5MzyFoobtqpP0v7a6QRZGXNa0VYRzcfQvZI5zp9v26twxA7DO35g7HTqgdI+vp0qpTAHZw6tVndEh8bxR0MxeBNFmmrg3/a7F68wNLCq5upx+2I+bsmG0bYUOI82PbFuQP9NXdNyaaqfs7OZhaj/uiKcweu+FUxYZsMxxXpAhCaoq3vdsK2nc/GtuyiYs+rg12XU3jG9Mt0oaMuogWdEylZziK2BnpLQViXOiLw18xDCkPafSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaqO7TvktQvpXXgZtfAI7hg/pM8MZbFKFnKbs2RFNI0=;
 b=q7BI0EINbeOSNoZv51sMj+FkV8mvdqrAEl/KrxV43sPRizWapMhBUAkhxzs4GZPg3d0QG0wjagXOMzBXD4nYJvDLFwP3mMcIvMznTKGHIn/kwY6geFfGG6LrRr38CXPOP1w81092iR5mbTFrHW/unpMRB6/oaLZmlqOUuhPNa0wlq5y1FpErD27E5SrQ8TEz2dEyEiAqyOnVaZL27wj/L7l9ojhhzV+ERDNqYrgOa40X/ws4rBt1Ncyrm1fxfwMbJOtJvwFenZj/GBwGwgOtM+htz3YjB2hr3eL544hw2Yfx4xMb4H9h3BzAjhqUOzYnlb+wemJQENRrN9qmpMXGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaqO7TvktQvpXXgZtfAI7hg/pM8MZbFKFnKbs2RFNI0=;
 b=iyewAS8vBW7qVb5KrKHzZUZENApUcI+9B7N7e4IeACFp3ZJjwa6RYTZn6glEtGH1M8aMAqsA0se6Rw/EU+eWZTZGT2V7A3Rl7UcYTl6uzoitNCkT1WgH3UtbR77d52CMgKQFiWP34nIXKpdjTC40Jg9jTa+1xrCBQoFkbpbU0yuE0S14ECpa9vCG0Lr9upzj9jhRPMbXPtqAc9QyPPzf1VMbAfxjresNhZRso7MxIsw4NcFEmEPd3zduSELaNaqq2/cJe4ZzC1d016LW2LCbPJvxpcfFFl+g2H1dxEdROhYoapGy7ISjHz1svGtqGoolWcWfRnTLRZnUAxFbvLhWwQ==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB6656.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 11:08:26 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:08:26 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: Chen Xiaokun <shinnkka1@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "sashal@kernel.org" <sashal@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "asml.silence@gmail.com" <asml.silence@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: [PATCH 6.1.y v2] io_uring/io-wq: Fix memory leak in
 io_wq_create() on success path
Thread-Topic: [PATCH 6.1.y v2] io_uring/io-wq: Fix memory leak in
 io_wq_create() on success path
Thread-Index: AQHdSybakd+oZEZaPEW4hUApB+ZNB7bcAWeA
Date: Wed, 23 Sep 2026 11:08:25 +0000
Message-ID: <c8314db726d933c304987771e25b3eb3e176f7d8.camel@siemens.com>
References: <20260923064315.195997-1-shinnkka1@gmail.com>
In-Reply-To: <20260923064315.195997-1-shinnkka1@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU0PR10MB6656:EE_
x-ms-office365-filtering-correlation-id: 6be1237b-8229-4f56-18eb-08df1962fd90
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|55112099003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 QwUeQ2xowUM0LpQAJ/d0KDDxssVK8hSrQdQI3stKdZ31HffeFSjwZvbc4xnHkBKtdjciukQHIMADS8N6laCVX2Ju33dVT45M3pZ/Y8RmDPKB39VL1NuQnpYBiwdZzM1zXkaSUB+12lKz7NFOsYdBFTcHwIIxLZms+FYBcdtizwX/rbbYORlChuGYkB9C7J1cP5pxXSEiaDrkZLGfhEXkEA6XD05N+9wY5AsGzkV1VswRXd0F+IqO6pEKdZ+leDVNgtB3GIy9BlVmuez7Ul44PXzwpDb47HF1lKnHs4XS+jRgGeGWGwJz0qKBuJ6N8ElB1HxJuQ63SjqbuIKHV38TU4SczDuaWP5D3//fF9gHt7IqUhlpDlPip1TdctkSVn9vgwhljdBcML5sUEnF8XJtNq967kWr498ZkRGungU7ErvKFAQl6jwCOxu7o2/l7yMZu4d38GREToYkauJguCpsY9hzcmk6O4217mCY9c6ejkzsF6fHG34XaI4wShOFPKpuzULGT+kmhEXUaz0D88Osh5JIZa76FuL9pLSnWljJhULpyBbTsUEcZztz9G8Tn7W+7ad0axIZxA7AeqTxAEbts2xaJfAqZphTzdpdYPtL5o5FqjF364i65wUZBKgE2ZIx2O3PefkLQSfK5uxnlDAQ/h2B2HQmdG8ZPjwRxaGJKIy2dSuNACNSRmjOFWew/mYlJsyN9ZkXCaVWGEfYWxavzPAJM8DKX0qcw7H/hCTIPP8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SCtPaFNNUWZNQmwxZTIvRWRvRUJiYnZVSEdWWjVUSWRPM0dSRGtuTC82S3d6?=
 =?utf-8?B?N0VnMDBVYmRwNHgzQVQ4NEJRT0ZSd2E5dEsxWU5iMHRYVVZHVUdXdXZGY0Jh?=
 =?utf-8?B?NEp6VU1jRDVlZHpyblcxREpxWUlNOW4wcWJQanhwZlpvai9JRFFoaUlRaEtx?=
 =?utf-8?B?Uit0RHJNbXVsU2MyZmw4U3A2Uy9RdWovdXEzVWNFNTVSZ1NpR1hLanRlN2Uz?=
 =?utf-8?B?aEZBMkU5MERhQWNmZlFhZ0NMVTcrQ0pyTmJIOEEvNFVubEU2S09aM0liMHds?=
 =?utf-8?B?NWU5T3hjZFNQSkRXWlpubGNOZ2FwZDhvN1FPcU15aVgvdjdBQlhJOElhMkZu?=
 =?utf-8?B?TTFnRFYycFdIREdvWmRKUzExZ0hINzZwQzdqclRBZWxISkxFVUplUmUxV0No?=
 =?utf-8?B?MjZVSWtsb0FodndSN3dndml0djNzZjlEQzVyT0ZETE0yS3BSTmhQL2svZlVY?=
 =?utf-8?B?K01ZcFJ4SDZ4c0RqenArRXFlUkFHb3ZLQVVOM3hXYWYxdlA3UG9pREJrSVVz?=
 =?utf-8?B?dWVzNnBvSHR0Ym5XU3gvUzFWc3A0My9GRUR2TTVFRUtTbjRCTFRwMGlnQmVC?=
 =?utf-8?B?aU9vTDJNMVdJdjIzRTZkdEtLbXp0eW5yYUNaMlp3d2dIaTlwN0duRlNxOVNY?=
 =?utf-8?B?dDFEWlZGNnNiVENJcCtMMllhZEwraTJKaG1naC9Cbjl2U2tJZS80VHk0S2lR?=
 =?utf-8?B?MFVlc2Zxdy83SXMwUEJWTk1XdzFMSkFCRUgzamQ5SUFSYTlnM2dZYlE0RHJU?=
 =?utf-8?B?ZjcvTmVtenJSTXJpSk5sa0RsSVIyZi8vemdLL0VjeGJwZDRJTnlrNUgvbHda?=
 =?utf-8?B?dkNnWGl0WG43QlRYa25aaDRWS0hROGdVUGp1Y2VTQ2NlSVUzRSthUkJxa28y?=
 =?utf-8?B?WTRKa2ZYd205WmdtZkJ6SnoydEhqbDBzd05MMXFNNWdoT3h1QlVrNzRBSlkz?=
 =?utf-8?B?Vk9xYVFVK1ZsUHNDUGg4U1dhdmpEcGR6cEVRUEljVExtNEpUY1A5elZJNTRW?=
 =?utf-8?B?QzM4YzlFMmVuMW9XSStLeng0ZW9EUkFRaG9JaTIvejFzaFQwWVkrN1NvMjRh?=
 =?utf-8?B?bHk1dmlBVU9CRVZQdm5WZklFUG90M1hQSmtwV01IY2hKRjAwcTZtcmV4eTFt?=
 =?utf-8?B?S1NmeFF2RmxuVmFFbi9leEpXNHVPMnY4bi9jdm14ckRUTW5lWUNRbWc1bDM5?=
 =?utf-8?B?cVYwRFIyZjRzZDZDVWpiSnV4NlRKYkJUNjZMbU5Kb1o1VWNRaTU3QWZiK1Vm?=
 =?utf-8?B?KzJWYndCMUpNNkxkRVpLc2NNM3JCWkJRRzRrcFZVa2NNblRuMElzanZkUlpt?=
 =?utf-8?B?bWUxeDZkcTQ2a3FhdVRaOXUybmJnckhCS29SSDVvNlVlazZKRXlZaXZiYTBt?=
 =?utf-8?B?bnZ3YmtJQnhTdURGQXUxM2tMdTBjVEg0M0ZDRGwraTRaVVdPdnhIMlBCcDNm?=
 =?utf-8?B?Z1p5V1U2Y1JIcVB4clpaeXg5SXZYWE9OUXBhS2g3ZHJsTkVIS0RKMTI5NnJV?=
 =?utf-8?B?dE1vMkxxTHZhVFRGYVRIc28wSmxGUVRMQ0xJS0RpdkNTS1FYMEQ3REtROHpl?=
 =?utf-8?B?ZDhsRnhhNVQvSkNscVhFUUw0VWdUOEovSEVRdmNtTmZpUXBvNFRQNUNWUmNT?=
 =?utf-8?B?N1ZsdjNZY0gxVnJuejJQYXM3T0pSYnV2VkFCRUY2dEFTRFhzS2ZTUWtSaUpq?=
 =?utf-8?B?KzUwV25rSWR1M0V0TG1IVHh6SytFOEltWnRWb25IUUFRRWoycU83VTRkeThl?=
 =?utf-8?B?cFN4TmQ2aW9FQkVrQVhsTFhlZ3lPYnFjNmZMQkpKVjhVMU91R1p3OGUveFF1?=
 =?utf-8?B?R2M3MTJ3YWdpZ1VxUmFWYzV6VnBuMlREOUlBNFRXTm1YZzE4dWF3eFo3U2ll?=
 =?utf-8?B?elA0ZnI2YXJMaW5YY3FqQmdSeU5lVnZHUm9sUjY5Mkc5RjBjWTJ5c01hRVBx?=
 =?utf-8?B?UVBoNE9DR1RsS2xaWU00S0ZLRWVEay81d05MOWFrb2ZoeFdzVWdqUVhwd2RU?=
 =?utf-8?B?cXU2VnM4alB1NVNCVEF4Tyt0WDhxSTFabnNha1VzL3g3ekExYk9vaE5DRXVN?=
 =?utf-8?B?bFd2M2JFcU9RckJ2UFp0NXZBWVZkdzdYVzZBSkI4Qk9zWHcwMlpnV0YrNC9o?=
 =?utf-8?B?WDc3SEJXdGs4S2RrSUlHZmJtR0ZpSGgyNzlkTC9qenh2TTJrMEwyNldaQkF4?=
 =?utf-8?B?TUU5Wi8zN3o5eEdlUndMNlRydGJrTG5ucHFHVm5vY3F1dEduYTMwdXp3UW1V?=
 =?utf-8?B?elZKdG8zdUhrcVJzSEE4bGNZOXMrYUgyQzJETjdsb0RVcEpBd2crMWVIMnF0?=
 =?utf-8?B?NysxZ3p4cDlidklJYkVhSDhxTEJRQUVBQ082a1YvUVZXUFpER2wxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51F3DC37FEDAB24E9C9019D7701CF169@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be1237b-8229-4f56-18eb-08df1962fd90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 11:08:25.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0j08xeampQmzErXor5SLxFy4ET+w10WInBcrhe5ux3aU1ANNjw1ii3rc0GUNRQQKeqNbWFItr98aP1DcL+n2dCDdDN+6mwcOYXYIbO2Pgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6656

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE0OjQzICswODAwLCBDaGVuIFhpYW9rdW4gd3JvdGU6Cj4g
WyBUaGlzIGlzIGEgc3RhYmxlLW9ubHkgcGF0Y2ggZm9yIDYuMS55IF0KPiAKPiBDb21taXQgNjU3
Y2E4MjUyNmQwICgiaW9fdXJpbmcvaW8td3E6IGluaGVyaXQgY3B1c2V0IG9mIGNncm91cCBpbiBp
bwo+IHdvcmtlciIpIHdhcyBiYWNrcG9ydGVkIGZyb20gdXBzdHJlYW0gY29tbWl0IDg0ZWFjZjE3
N2ZhYSB0byA2LjEueS4KPiAKPiBJbiBsaW51eC02LjEueSwgdGhpcyBiYWNrcG9ydCBpbnRyb2R1
Y2VkIGEgdGVtcG9yYXJ5IGFsbG93ZWRfbWFzayAKPiB2YXJpYWJsZSBpbiBpb193cV9jcmVhdGUo
KS4gIEl0IGlzIGNvcnJlY3RseSBmcmVlZCBvbiB0aGUgZXJyb3IgcGF0aCwKPiBidXQgaXMgbm90
IGZyZWVkIG9uIHRoZSBzdWNjZXNzIHBhdGguICBBcyBhIHJlc3VsdCwgZXZlcnkgc3VjY2Vzc2Z1
bAo+IGNhbGwgdG8gaW9fd3FfY3JlYXRlKCkgbGVha3MgY3B1bWFza19zaXplKCkgYnl0ZXMgb2Yg
bWVtb3J5Lgo+IAo+IFRoaXMgaXMgYSA2LjEtc3BlY2lmaWMgYmFja3BvcnQgaXNzdWUgY2F1c2Vk
IGJ5IHRoZSBkaWZmZXJlbmNlcyBpbiB0aGUKPiBpby13cSBpbXBsZW1lbnRhdGlvbiwgc28gdGhl
IGZpeCBvbmx5IGFwcGxpZXMgdG8gNi4xLnkuCj4gCj4gRml4ZXM6IDY1N2NhODI1MjZkMCAoImlv
X3VyaW5nL2lvLXdxOiBpbmhlcml0IGNwdXNldCBvZiBjZ3JvdXAgaW4gaW8gd29ya2VyIikKPiBT
aWduZWQtb2ZmLWJ5OiBDaGVuIFhpYW9rdW4gPHNoaW5ua2thMUBnbWFpbC5jb20+CgpSZXZpZXdl
ZC1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4KClRo
YW5rcyBmb3IgdGhlIGZpeCEKRmVsaXgKCj4gCj4gLS0tCj4gSGkgR3JlZywgU2FzaGEsIGFuZCBp
by11cmluZyBtYWludGFpbmVycywKPiAKPiBUaGlzIHBhdGNoIGlzIHNwZWNpZmljIHRvIDYuMS55
LiAgQ29tbWl0IDY1N2NhODI1MjZkMCB3YXMgYSBtYW51YWwKPiBiYWNrcG9ydCBvZiB1cHN0cmVh
bSBjb21taXQgODRlYWNmMTc3ZmFhICgiaW9fdXJpbmcvaW8td3E6IGluaGVyaXQKPiBjcHVzZXQg
b2YgY2dyb3VwIGluIGlvIHdvcmtlciIpLiAgRHVlIHRvIHNpZ25pZmljYW50IGRpZmZlcmVuY2Vz
IGluCj4gdGhlIGlvLXdxIGltcGxlbWVudGF0aW9uIGJldHdlZW4gNi4xIGFuZCBsYXRlciBrZXJu
ZWxzLCB0aGUgdXBzdHJlYW0KPiBjaGFuZ2UgaGFkIHRvIGJlIGFkYXB0ZWQgZm9yIDYuMS4KPiAK
PiBMYXRlciBzdGFibGUga2VybmVscyBkbyBub3QgY29udGFpbiB0aGlzIDYuMS1zcGVjaWZpYyBi
YWNrcG9ydGVkCj4gaW1wbGVtZW50YXRpb24gb2YgaW9fd3FfY3JlYXRlKCksIGFuZCB0aGVyZWZv
cmUgZG8gbm90IGNvbnRhaW4gdGhlCj4gbGVha2VkIGFsbG93ZWRfbWFzay4gIFRoZSBjb3JyZXNw
b25kaW5nIHVwc3RyZWFtIGltcGxlbWVudGF0aW9uIGFsc28KPiBkb2VzIG5vdCBoYXZlIHRoaXMg
YWxsb2NhdGlvbi4KPiAKPiBUaGVyZWZvcmUsIHRoaXMgZml4IGlzIG9ubHkgYXBwbGljYWJsZSB0
byA2LjEueSBhbmQgc2hvdWxkIG5vdCBiZQo+IGJhY2twb3J0ZWQgdG8gb3RoZXIgc3RhYmxlIGtl
cm5lbCBzZXJpZXMuCj4gCj4gdXBzdHJlYW0gcGF0Y2g6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI0MDkxMDE3MTE1Ny4xNjY0MjMtMy1mZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29t
Lwo+IGJhY2twb3J0IHBhdGNoOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MTEx
NjIzMTYuNTE2NzI1LTMtZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbS8KPiAKPiBDb3VsZCB5
b3UgcGxlYXNlIHF1ZXVlIGl0IGZvciA2LjEueT8KPiAKPiBUaGFua3MsCj4gQ2hlbiBYaWFva3Vu
Cj4gCj4gQ2hhbmdlcyBzaW5jZSB2MToKPiAtIFJld29yZCB0aGUgY29tbWl0IG1lc3NhZ2UgKGNs
YXJpZnkgdGhhdCB0aGlzIGlzIGEgNi4xLXNwZWNpZmljIGJhY2twb3J0IHBhdGNoKQo+IC0gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2VzCj4gCj4gIGlvX3VyaW5nL2lvLXdxLmMgfCAxICsKPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvLXdx
LmMgYi9pb191cmluZy9pby13cS5jCj4gaW5kZXggMGMzZGUyZmVhZDgxLi5mMWJjMjEyMzA5Yzgg
MTAwNjQ0Cj4gLS0tIGEvaW9fdXJpbmcvaW8td3EuYwo+ICsrKyBiL2lvX3VyaW5nL2lvLXdxLmMK
PiBAQCAtMTIyMSw2ICsxMjIxLDcgQEAgc3RydWN0IGlvX3dxICppb193cV9jcmVhdGUodW5zaWdu
ZWQgYm91bmRlZCwgc3RydWN0IGlvX3dxX2RhdGEgKmRhdGEpCj4gIAl3cS0+dGFzayA9IGdldF90
YXNrX3N0cnVjdChkYXRhLT50YXNrKTsKPiAgCWF0b21pY19zZXQoJndxLT53b3JrZXJfcmVmcywg
MSk7Cj4gIAlpbml0X2NvbXBsZXRpb24oJndxLT53b3JrZXJfZG9uZSk7Cj4gKwlmcmVlX2NwdW1h
c2tfdmFyKGFsbG93ZWRfbWFzayk7Cj4gIAlyZXR1cm4gd3E7Cj4gIGVycjoKPiAgCWlvX3dxX3B1
dF9oYXNoKGRhdGEtPmhhc2gpOwo+IC0tIAo+IDIuNTUuMAo=
