Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793886320;
	b=vc+TqpZIj2FU2g1mRdc+E1iVkFufpyuM+3OVP6tgZpew6otnQgvd7uDUoNS9QqS8Od1y
	 5JbsuhcxLoLgoq5UTgBfLq9uk0Bs06AjtL46QAv6De4UrDIAp4GUH9U2zzKXxE7BDoyq+
	 IGS7PC1RVU8MhYY/NUiKhcz/CnoINJuA7okUfAE06AlheFJ1tGpp/ygstRCiQpZRZkvC/
	 CP6TAAd0YUPsSk0Vx1LVi0D1cgmCpl2lsgTqpzww86cR9MhJMNjNfLu6pcAN87VGXftNo
	 lWBXWLuCVCzU2ei9yCoPL1d4WgQ0KKn9R3q8UntG26r0DkZ126jZh9EDOZtyshUfbfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ox2CkOl0O170/jdfvxlJBhaUuv2zuftjH5BKkFFRWYI=;
	b=07hO+Fetuixrg7Kvga10pFjIkw15n2gUAvknQsaXqYraEJJ7fFb4qTzGIbjE0U5QmWQw
	 Dk/3LOxQ7hy6OVb65PVcpOnMgSaf6mmmVc5zzt34OUH3jUz1m/qZ9iE1VVn/j0aS7me7H
	 w+2eKgjEFFFHbmXZyNwW/cy39yV+IXGOEvbF+kgWLuBxJCbhV4KRrx9teeRgpLMp2xkFj
	 XMCMCT3/e3EuBuyFPhP7z7S6BuswieP4altlwu8BOWOh9Ie7IkEBRBStnInyqTolhrC31
	 eBMqmabWGDQaliClaMGRNRW6QwYejnp90qFuj+xBrb55NKsRkqnpSn2FJ6CmGlZtG3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=o4LwUpO2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.90
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010090.outbound.protection.outlook.com [52.103.10.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7D606A335;
	Thu,  5 Nov 2026 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A7D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=o4LwUpO2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5hX2GEWuziNcBY/EKvoLPbpH0QPVZQGsyEqCt8OtShrySpg6UBYf3tFsmiY35snd9dXaJtiwDzNp1xvIPtgPM40myJQrd65WVgqtcVOqyzImFazuArfudrKYMb198akhRzF1pGZ+BOjPVtGH45Bp++brgLJc2E2mfZd3LwuaSc+K/6369f9T3wRarLGq3hzXuJM/SZBWLR8HupWR645utAMGE4NtalsgiAWJRkQwYoYX5FY0DTmnybadHax8KXnn1GBbPCxi8papGGWYMMVjsrQkLa6xw/pH5TdA+HwBT5GQ6xnZ6TbF0Zd2kCCv+hrSjIJMISjR7hY+hwtJkIaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Ox2CkOl0O170/jdfvxlJBhaUuv2zuftjH5BKkFFRWYI=;
 b=NuS0J4cduPLteomk2GT/cbevMKIaeb7Rp7Do8eyaWBhEOBMoCQmBTiCyKqyhEmRBLNDWFvjJ9IyB4Lx7HjuvadYJyOp4d5SxINI6Oc3qlcuuoDhe/SDZ9AdbOHLejdzobnKoq+Ax0FtyWxH6t3tEHIHSrmVQrIehdai3wU6iDegLSj7OvmNPwMQ8hkQZCVBgV6N9MyOOpP10CeupXhXbtRjXgFPWAfXHdjj3DtdJ62HD0A/hZwreW9XvYDRXJsRKrCZSGD2yF5yF1y5w44KGcsNyz4FMwsh/qVfnHP3hV17jplAvYR8gevBRZyNeVUvRbaJjHGaTBw+WPPMTc9VSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox2CkOl0O170/jdfvxlJBhaUuv2zuftjH5BKkFFRWYI=;
 b=o4LwUpO2SuNp1cPveKxbjJeCsN+rGgJJDnd8KVzLwgivVElKt4jUA1qJCmXZrU52zNUy2aUCJ4gtmdHM4prQq7CsMrh3VMncXThW52TdeRfWjX3FvLijQdh6il3DHREnGR8tv1kKPD/J+plNKEaZQCZe055khosqD2wDsH0yo2916sqcL3nEA5zHC7+QnqiybO5Ow628gWgEPIhrg34SOidxPpwfnaBcqaTsey2tA+azW2o8LH1PRPR4epQ6rNwauEpPybD0BkzIeqjnmq9N4Yhqs5r2FvRQMbfFow5K2rBcUCPKn841qLpP+cYolapUYmonfi6hcWApfwtJhd6coA==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by CO1PR05MB8021.namprd05.prod.outlook.com
 (2603:10b6:303:d5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 13:45:18 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:45:17 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "leitao@debian.org" <leitao@debian.org>
CC: "a.hindborg@kernel.org" <a.hindborg@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Yingjie Wang <1075151112@qq.com>
Subject: [PATCH] configfs: protect symlink source callbacks from removal
Thread-Topic: [PATCH] configfs: protect symlink source callbacks from removal
Thread-Index: AQHdbSvkXEtvC7zga0y680FgQNKWhQ==
Date: Thu, 5 Nov 2026 13:45:17 +0000
Message-ID: <20261105134514.2890692-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|CO1PR05MB8021:EE_
x-ms-office365-filtering-correlation-id: 63e7c550-90b7-42d5-71ea-08df3b4306f2
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8022599003|12121999013|8060799015|25010399006|31061999003|8062599012|19110799012|15080799012|22091999003|24121999003|38102599003|5062599005|26121999007|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDk0RE5JV2Z6Nit5enloNzdPYndpVWwxYithZ1k5L0o3Sml4b25HSXorWFBz?=
 =?utf-8?B?Q1NqTU90SHR6VTFpRDM3dE9PTE5GcURGcDMyZVlYRWU3NkVzcks1M3llOTlt?=
 =?utf-8?B?ZHhVdXBnQUpwZFUyWHF2NW05SWE4RDRqTDZxSVpvWjYzcjlLeHFPTFAyb2hZ?=
 =?utf-8?B?Ry80TGlXY3VySEpEQmVSUThWMzhJYkpNOWY5dkhtKyszTWRhbVNGNFBXMWY3?=
 =?utf-8?B?QmZpOU1UbDZGZHdORFpTOGpXdkpvdy9MM2RYWFJxa3NocFBsZ2ZRRlZ4Y1lX?=
 =?utf-8?B?by8zMkE5UVhLb0kyaXljZ296aGpwcW44VVJ3U0k3WE1zOTlrdndHY1NvMExV?=
 =?utf-8?B?VlF4eWNHaWk0WVMzbURiUGRDdjhESHdqMnlaSzQxcGgvNFZ3YlRjWEU3MVQy?=
 =?utf-8?B?TVMvZ1l0S0hITlhoVUxFd293dFIrY2NFNW9vU0pveFA3a0VtdWFDd0tOUFlM?=
 =?utf-8?B?L1E4cThwOHFXRHp4SUppazlsdUI3Q3ZvbEdkMURDWlRVSGd2dTkxL1AvSWJX?=
 =?utf-8?B?eVoxbUVlbjlMY2dWWmhrTVhzZFVhQzVtamt0MzlDaDE2NU1yeGJvRFE2ejdZ?=
 =?utf-8?B?aWF4N214bUpPc3cyRmNGQkFVMXRUNFJDM01SVS9nSVE0UC9wbVlERTVkUnVO?=
 =?utf-8?B?NldjVmlMek1QRUwyY01SUkcxaE15TmlrSDExcmJXMmw2WnpYYUFiK2VZNTFG?=
 =?utf-8?B?NGFOc0NGUmQ3S0tVcDBjSUoxRE1LOUhYUFM3V3VxRm9uYkM3NmRleFRLZnND?=
 =?utf-8?B?cGdxRnczSTZJSk9VNE82REU5T29Bc09janppbWlhL1ZWaUhlUU5lWm5nQ2ZS?=
 =?utf-8?B?L1hpN3crOGIzZWFWS2UrWnEyMkJjWGNUUnRJMitydmpDbHZJRDFmVENDTHND?=
 =?utf-8?B?WHNNQTN3YWJpWnhudDlWQnMzUkY0aENHVjhuUStuZzVWc0c3WlMwY0w1Yk1l?=
 =?utf-8?B?TXhBelIwcFFQb0RYaVZOWFIwNWZuU1VkWjVvem4rOTlkU0hGSDhUNmszb0ZX?=
 =?utf-8?B?WDBZV2RuTkptRlpwaXRWT2pqT1FnZnlIQ1pSYkxQdHBOUWZRYm45V1lweHhn?=
 =?utf-8?B?NU45STQ1ZTNZVDJyTXZZeGtZTmtLbjlnTGFNQnhiRSt1Q2NTd0l0OUVoT3Va?=
 =?utf-8?B?RGsrMzU3enE1SzZEN29kN2VxNlJIMVlaTEJIRUM2NGljbVlYU3NsVmhNbWJh?=
 =?utf-8?B?Mm9CTlI2VzJZWkpLN1VpMVByWUhyTXhWWk9CdFJYTEt2dVlRVXF2dWh1WmM4?=
 =?utf-8?B?R2F3b3c0czdObEQweGtPWE1FR0xTeE5nNW1ycnBJRHpMalY4U2RVM2FiQWhh?=
 =?utf-8?B?dzZsZEpBZzhuMVJnNXNGYzk3dS9wVU90VHVpaG13MC8ybDRKZEs4R3U1eDJl?=
 =?utf-8?B?Y1RzSms3ZVdJSnd5REVmSVE4dFZpb3R2Ty9pNnBvWmlNRkM2dHduMEx0UEdQ?=
 =?utf-8?B?UjQzTThyRFcrOFpnaTJRYnhKd21HOVBGeXNveHU1TkpZaDRaS3JZR2xyNmI0?=
 =?utf-8?Q?mkvTIq1p7/ZsxJHxqjCo6wBFc3P?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWN6ekluM2F6YjB5bkZpaE5sd1lsbGRpOWhlblBwaUo1S3RJS2lXUmNwQWJW?=
 =?utf-8?B?SXdhcitaQVNrbzVieVU1YTFBc2loYU5Ka1AzNTAyRG15c3BSc0FOSkVFTW5C?=
 =?utf-8?B?TEx5L2xPd09EaDdpUFoyeml0QTl4NmFJcU9TbFJvV1NWRUgwTEhCaTBiMWVm?=
 =?utf-8?B?S2NmOUtINEh4QlVUU0lRK2VQZVZzYi9abjZyMnVSZ0hsY2tUUHg0TmdCcjNh?=
 =?utf-8?B?MzFkc0l6WUZXY1JsVXVZSkMrY3JTK0xEY1Rvc2NRbGJIWWdQWW1ackorNXEv?=
 =?utf-8?B?ZU1pRXN4SXhQVFIxQUduNEg5QzFhT2lSdzBuNDlBeFB3R2ZYV0hIRVZlNXEw?=
 =?utf-8?B?NnlHYkF1b3RsUXF2Ukw3bWQ4M3FGN3dwY1p4SjZ3SDVpS000K0FCU0hPT091?=
 =?utf-8?B?VTFyY0NSVXRleUZmejFIOHE1amNWWUp0VTVzUDU0WGtENTVaeERPWU9GUDFK?=
 =?utf-8?B?eGtEY25uMUUyRjZnd1ZGb0c3Z1BwKzNwalBiOWs5REhGZmJuak40VzQxV1M4?=
 =?utf-8?B?SHhsbllCTnB4UGNUNDNHVmRFaDNrN0JzNXZHT0hlak5hL3YwZzNmbytWcm5l?=
 =?utf-8?B?Qm5HUzR1VElGSXJ3UUxNNUlNWitDUkR5NDROd1F3cEM3SEwvUHZGdjVZVUxB?=
 =?utf-8?B?dFZFL1M2WVVuN0I5RXI0R3EwT3g1aFMyYUJnV0p0dDRWQjg5WEgzb1g3Sk9E?=
 =?utf-8?B?YWo2Z29DZjNyWWFoUmpzcGZPUkZpdStINFRIeGhqcVYvdTBlVklZMHJ5b09O?=
 =?utf-8?B?S0FDbS92QjhtTDFuYndCN2xpSmU0eEFLNDJiRFBZRHZURlorVzFOQ2NmdFJ5?=
 =?utf-8?B?ODFzZkN0b0VVUGJDZFlrY1VqckVQaXpRQU1kb1UxK3V0TDROMURuQ0JDb0h1?=
 =?utf-8?B?dmR1UDRPVElaU0pIc3VURW9uWXU0cVVxR1JpdVd4YnRzWURkT1JzeWhPQU9J?=
 =?utf-8?B?TlFBOXlTN3FIa1FGMFZaTXh3bFZaNjl4WG1kV2V1UVVhckdMaFlDeVVVaWUz?=
 =?utf-8?B?S3BrK1J6TElwQTRxMHhJK01YSlhpUEU5MWMrdFQydlZGaEpoZkdTVkRpUE4y?=
 =?utf-8?B?QkZRMHYyanVaaHFSRFgzQTNCVHRyNm10aEJFQldmZGhnRk5tcmR6VnhHdE0y?=
 =?utf-8?B?bmthMUljZXRRWlRYMHU0ZlBPY0lmOEw3RENJZUR5VFY3eTh2OHFPRGx0MmZs?=
 =?utf-8?B?TElMQmZXQ0RqKzlLR3ovd05tSFovVU8vdm1EN1ZGdE9iQlU3ZXo4YlNUMlhl?=
 =?utf-8?B?VmNlbmlhSEF0bVl2ekxlS0pFSmRjeDhyLzFORFE5MHBOTUJENzFVZ1BvSHor?=
 =?utf-8?B?RGZUelZDZXFhVGpHQnM0c1YxMHlOa25GUVQyQThkSmtPbXhjbFJpRTA0QUNZ?=
 =?utf-8?B?RFpkYmJMMDYyRmlwU0E3NWdEcFZjMXYwSzZlRTRMTnJnN0hNN0VBbjNQWEJr?=
 =?utf-8?B?UitQQ3dOYWZaR0w1bXVveUZoTXJ5SnZ6SlpKcTU5MkRXdlNua2hrKzVnMnRa?=
 =?utf-8?B?S0Y4MkY2aFVWYmJrUnRUb21nQys2Yk95ZmRhM3lVSWMwb1NvemFGZUt4aVBu?=
 =?utf-8?B?bmxHZDJ5aWVQY0tUVjBTSXlYcVBnTnUwQ2FmWHpqamxsMXdzbDg0YUkzUDNC?=
 =?utf-8?B?SFp3RzU1R2JxZHp6clVsT2tVUU1rVktTbzlNVHgreEZTUGE1a3dLYW1DZTln?=
 =?utf-8?B?OEZtRlZ4amI2amxMS0dPTm54ZzJSSDhBVlpPT3gwVXBlZE9ueHlBMC80QXNm?=
 =?utf-8?B?V1RJeDVaR2VRSTdQSTFxYXZhOGZEanhJOEY5dzE5VjFCR2F4MStnVngxcmJU?=
 =?utf-8?B?aXpxazRCajAyL2xSRmxuOTBTbE9nQy9NRDhRMU5TUUd4Ujk1QjRsaitMbEta?=
 =?utf-8?Q?/9JaIEZeiTRfm?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e7c550-90b7-42d5-71ea-08df3b4306f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 13:45:17.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8021

RnJvbTogWWluZ2ppZSBXYW5nIDwxMDc1MTUxMTEyQHFxLmNvbT4KCmNvbmZpZ2ZzX3N5bWxpbmso
KSBkcm9wcyB0aGUgc291cmNlIGRpcmVjdG9yeSBpbm9kZSBsb2NrIHdoaWxlIHJlc29sdmluZwpp
dHMgdGFyZ2V0LiAgQSBjb25jdXJyZW50IHJtZGlyKCkgb2YgdGhlIHNvdXJjZSBpdGVtIGNhbiB0
YWtlIHRoYXQgbG9jaywKZGV0YWNoIHRoZSBpdGVtIGFuZCBjbGVhciBpdHMgY2lfZ3JvdXAgaW4g
dW5saW5rX29iaigpLiAgY29uZmlnZnNfc3ltbGluaygpCnRoZW4gcmVhY3F1aXJlcyB0aGUgbG9j
ayBhbmQgY2FsbHMgdGhlIHNvdXJjZSAtPmFsbG93X2xpbmsoKSBjYWxsYmFjayBvbgp0aGUgZGV0
YWNoZWQgaXRlbS4gIEl0cyBjb25maWdfaXRlbSByZWZlcmVuY2Uga2VlcHMgdGhlIG9iamVjdCBh
bGxvY2F0ZWQsCmJ1dCBub3QgYXR0YWNoZWQgdG8gdGhlIGhpZXJhcmNoeS4KClRoZSBVVkMgZ2Fk
Z2V0IGZvcm1hdCBjYWxsYmFjayByZWFkcyBzcmMtPmNpX2dyb3VwLT5jZ19zdWJzeXMgdG8gdGFr
ZSB0aGUKc3Vic3lzdGVtIG11dGV4IGFuZCBmYXVsdHMgb24gdGhlIGNsZWFyZWQgcG9pbnRlci4g
IFJhY2luZyBzeW1saW5rKCkgaW50bwphIFVWQyBmb3JtYXQgZGlyZWN0b3J5IHdpdGggcm1kaXIo
KSBvZiB0aGF0IGRpcmVjdG9yeSBwcm9kdWNlczoKCiAgQlVHOiBLQVNBTjogbnVsbC1wdHItZGVy
ZWYgaW4gdXZjZ19mb3JtYXRfYWxsb3dfbGluaysweDJhLzB4MTQwCiAgUmVhZCBvZiBzaXplIDgg
YXQgYWRkciAwMDAwMDAwMDAwMDAwMDYwIGJ5IHRhc2sgY29uZmlnZnNfcmFjZS8yOTEKICBDYWxs
IFRyYWNlOgogICB1dmNnX2Zvcm1hdF9hbGxvd19saW5rKzB4MmEvMHgxNDAKICAgY29uZmlnZnNf
c3ltbGluaysweDNmMi8weDg3MAogICB2ZnNfc3ltbGluaysweGMwLzB4MmEwCiAgIGZpbGVuYW1l
X3N5bWxpbmthdCsweDExOC8weDJiMAogICBfX3g2NF9zeXNfc3ltbGluaysweDUwLzB4NzAKCkNy
ZWF0aW5nIHRoZSBpdGVtcyBuZWVkcyB0aGUgcHJpdmlsZWdlcyByZXF1aXJlZCB0byBtYW5hZ2Ug
Y29uZmlnZnMuCgpSZWNoZWNraW5nIGNpX2dyb3VwIGFmdGVyIHJlbG9ja2luZyB3b3VsZCBjb3Zl
ciBybWRpcigpLCB3aGljaCBob2xkcyB0aGUKc291cmNlIGlub2RlIGxvY2sgdW50aWwgdW5saW5r
X29iaigpIHJldHVybnMuICBJdCB3b3VsZCBub3QgY292ZXIKY29uZmlnZnNfdW5yZWdpc3Rlcl9n
cm91cCgpIGFuZCBjb25maWdmc191bnJlZ2lzdGVyX3N1YnN5c3RlbSgpOiBib3RoCmNsZWFyIGNp
X2dyb3VwIGluIHVubGlua19ncm91cCgpIHdoaWxlIHRoZSBzb3VyY2UgaW5vZGUgbG9jayBpcyBu
b3QgaGVsZCwKc28gdGhlIGNoZWNrIGNvdWxkIGJlY29tZSBzdGFsZSBiZWZvcmUgdGhlIGNhbGxi
YWNrIHJ1bnMuCgpUYWtlIHRoZSBzb3VyY2UgZnJhZ21lbnQgcmVhZCBsb2NrIGFmdGVyIHJlYWNx
dWlyaW5nIHRoZSBpbm9kZSBsb2NrIGFuZApob2xkIGl0IHRocm91Z2ggYWxsb3dfbGluaygpLCBj
cmVhdGVfbGluaygpIGFuZCBkcm9wX2xpbmsoKS4gIHJtZGlyKCkgYW5kCmJvdGggdW5yZWdpc3Rl
ciBwYXRocyBtYXJrIHRoZSBmcmFnbWVudCBkZWFkIHVuZGVyIHRoZSB3cml0ZSBsb2NrIGJlZm9y
ZQp0aGV5IHVubGluayB0aGUgaXRlbSwgc28gYSBjb25jdXJyZW50IHJlbW92YWwgZWl0aGVyIHdh
aXRzIGZvciB0aGUKY2FsbGJhY2sgdG8gZmluaXNoIG9yIG1ha2VzIHRoZSBzeW1saW5rIGZhaWwg
d2l0aCAtRU5PRU5ULgoKQnVpbHQgZnJvbSB0aGUgc2FtZSBjb25maWd1cmF0aW9uLCB0aGUga2Vy
bmVsIHdpdGhvdXQgdGhpcyBjaGFuZ2UgZmF1bHRlZAp3aXRoaW4gMSwwMDAgaXRlcmF0aW9ucywg
d2hpbGUgdGhlIGtlcm5lbCB3aXRoIGl0IGNvbXBsZXRlZCAxMCwwMDAKaXRlcmF0aW9ucyB3aXRo
IG5vIHJlcG9ydC4gIFRoZSByZXByb2R1Y2VyIGNvdmVycyB0aGUgcm1kaXIoKSBwYXRoOyB0aGUK
dW5yZWdpc3RlciBwYXRocyB3ZXJlIGNoZWNrZWQgYnkgY29kZSBpbnNwZWN0aW9uLgoKRml4ZXM6
IDM1MWU1ZDg2OWU1YSAoImNvbmZpZ2ZzOiBmaXggYSBkZWFkbG9jayBpbiBjb25maWdmc19zeW1s
aW5rKCkiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBZaW5namll
IFdhbmcgPDEwNzUxNTExMTJAcXEuY29tPgotLS0KClRoZSB0YXJnZXQtc2lkZSByYWNlcyB3ZXJl
IGZpeGVkIGJ5IGNvbW1pdHMgYTdjMTI5MGVlZjYwCigiY29uZmlnZnM6IHBpbiB0aGUgc3ltbGlu
ayB0YXJnZXQncyBkaXJlbnQgaW5zdGVhZCBvZiBjaGFzaW5nCi0+Y2lfZGVudHJ5IikgYW5kIGYw
NmMyZDI2ZDE5OSAoImNvbmZpZ2ZzOiB1bmhhc2ggdGhlIGRlbnRyeSBiZWZvcmUKZHJvcHBpbmcg
dGhlIGl0ZW0gaW4gcm1kaXIiKS4gIFRob3NlIGNoYW5nZXMgcHJvdGVjdCByZW1vdmFsIG9mIHRo
ZSBsaW5rCnRhcmdldC4gIFRoaXMgcGF0Y2ggcHJvdGVjdHMgdGhlIGl0ZW0gdGhhdCByZWNlaXZl
cyB0aGUgbGluayBhbmQgaXMKaW5kZXBlbmRlbnQuCgogZnMvY29uZmlnZnMvc3ltbGluay5jIHwg
MTggKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jb25maWdmcy9zeW1saW5rLmMgYi9mcy9j
b25maWdmcy9zeW1saW5rLmMKaW5kZXggODkxNzhmNWQzNzFhLi5hMmE2OTgwMWIxNGQgMTAwNjQ0
Ci0tLSBhL2ZzL2NvbmZpZ2ZzL3N5bWxpbmsuYworKysgYi9mcy9jb25maWdmcy9zeW1saW5rLmMK
QEAgLTE1MSw2ICsxNTEsNyBAQCBpbnQgY29uZmlnZnNfc3ltbGluayhjb25zdCBzdHJ1Y3QgbW50
X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsCiB7CiAJaW50IHJldDsKIAlzdHJ1Y3Qg
Y29uZmlnZnNfZGlyZW50ICpzZDsKKwlzdHJ1Y3QgY29uZmlnZnNfZnJhZ21lbnQgKmZyYWc7CiAJ
c3RydWN0IGNvbmZpZ19pdGVtICpwYXJlbnRfaXRlbTsKIAlzdHJ1Y3QgY29uZmlnX2l0ZW0gKnRh
cmdldF9pdGVtID0gTlVMTDsKIAlzdHJ1Y3QgY29uZmlnZnNfZGlyZW50ICp0YXJnZXRfc2QgPSBO
VUxMOwpAQCAtMjA3LDggKzIwOCwxNyBAQCBpbnQgY29uZmlnZnNfc3ltbGluayhjb25zdCBzdHJ1
Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsCiAJZWxzZQogCQlyZXQgPSBp
bm9kZV9wZXJtaXNzaW9uKCZub3BfbW50X2lkbWFwLCBkaXIsCiAJCQkJICAgICAgIE1BWV9XUklU
RSB8IE1BWV9FWEVDKTsKLQlpZiAoIXJldCkKLQkJcmV0ID0gdHlwZS0+Y3RfaXRlbV9vcHMtPmFs
bG93X2xpbmsocGFyZW50X2l0ZW0sIHRhcmdldF9pdGVtKTsKKwlpZiAocmV0KQorCQlnb3RvIG91
dF90YXJnZXQ7CisKKwlmcmFnID0gc2QtPnNfZnJhZzsKKwlkb3duX3JlYWQoJmZyYWctPmZyYWdf
c2VtKTsKKwlpZiAoZnJhZy0+ZnJhZ19kZWFkKSB7CisJCXJldCA9IC1FTk9FTlQ7CisJCWdvdG8g
b3V0X3VubG9jazsKKwl9CisKKwlyZXQgPSB0eXBlLT5jdF9pdGVtX29wcy0+YWxsb3dfbGluayhw
YXJlbnRfaXRlbSwgdGFyZ2V0X2l0ZW0pOwogCWlmICghcmV0KSB7CiAJCW11dGV4X2xvY2soJmNv
bmZpZ2ZzX3N5bWxpbmtfbXV0ZXgpOwogCQlyZXQgPSBjcmVhdGVfbGluayhwYXJlbnRfaXRlbSwg
dGFyZ2V0X2l0ZW0sIHRhcmdldF9zZCwgZGVudHJ5KTsKQEAgLTIxOCw2ICsyMjgsMTAgQEAgaW50
IGNvbmZpZ2ZzX3N5bWxpbmsoY29uc3Qgc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBp
bm9kZSAqZGlyLAogCQkJCQkJICAgICB0YXJnZXRfaXRlbSk7CiAJfQogCitvdXRfdW5sb2NrOgor
CXVwX3JlYWQoJmZyYWctPmZyYWdfc2VtKTsKKworb3V0X3RhcmdldDoKIAljb25maWdmc19wdXQo
dGFyZ2V0X3NkKTsKIAljb25maWdfaXRlbV9wdXQodGFyZ2V0X2l0ZW0pOwogCgpiYXNlLWNvbW1p
dDogMDU0NDFkNjk3ZjdmOWE5MjcyNjRmNDA1OGNiYmM2YTAzZGZjYWM5ZAotLSAKMi40My4wCgo=
