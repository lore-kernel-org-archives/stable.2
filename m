Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794044580;
	b=YQBEXyaTIPEvT2u2sP3iQGGaxcbqIcYrGDDuw328qFRAqYOvhoo7/hCCNO4srUjmndcq
	 SF0QezJb3XYfMoc+FqOGMnJGf7N/FodjQZmfvQbCPln/FsPVRq1X+JD8f61evOgaj2QS8
	 Yp6g2ZhAwDfKIfMfRGQMmNOjLQlgT0QKABEO4Kb0hh471XUflgedVWfD2LekTNqIlD+vd
	 Q7cQJk6g9o3rEzO8hMIFJbwPWc1z/FwDxWPUDriIunkc9JCoQgHoiRsLlnGc1ZNhDGgXz
	 lQ5Khl+B0FY9195WDv+jICPHBZ5UDOZJ7KIz/v5401pQEFg23bXMTnB8geWSFeORxBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044580;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SBZtJ479+XpxRIPl+tGdy/bdCwIqJjf3WgbXvyQuArY=;
	b=XEI4Lv70jYgTAmWMDCJtLmpkUpaMiPckc6f6sfVM1ufiOSaEalWVcM2GKBFJDoLGtcib
	 OgDFeIg+3TbwM+UwhujE7SQh2rz2TvB9A+h76FzENsNOwsubCdYIE+wqRYnvKptgGBk1O
	 dALSPxeQRLeJzHc2hOI64Uu8tZcJl/vfW0KNZJaK9JcbAxLPGjjOs7TqIAuiDlYXjYrw7
	 rlFVpJ3Co9i6Ffyk7saCLiBZ5XHG1k016hxrp+Ft+VzaF88z6JTJZ4hiJUxgEJGY5Kok3
	 uCpK5WU/gNA0EF6qklmoL1Ci26G7vu9p/k0qlD9dd9KEXPLPe767VWr5dUt/YHP9oTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=U5xnCeeM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.86
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012086.outbound.protection.outlook.com [52.103.20.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7882606A326;
	Sat,  7 Nov 2026 09:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7882606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=U5xnCeeM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmF2zoFBLEzrk3lAm3qvZIXbfKUD22ww5lbIyFWa7veMQ6OxCbUAcq/B8ceVDGYwI7JmzFlUsQ1DqEIUuuJ4NWxsj9t4TB5tNveCoJyDjWirdQbOxbPlGe0FrwgmqvsCXCe1T4fBX5w78vSfC4n91uRvzVW9v56faLDxRGbrYmdKVBGSV6cGz+O+vuJmuWrZ0WUMPnU/tmasWAuObjgK9iZhjKTIu0vPra5CZQEOCslIsi078D254HSFUqop/m6g7zKrMCoTqlhG1JGjaQZT9WsAUJmlBlOcOCL2PUjIOKpeGeND2Sc5E0LrPcptqnS23VFyVpRXbhqri+pM0/cdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SBZtJ479+XpxRIPl+tGdy/bdCwIqJjf3WgbXvyQuArY=;
 b=IIrhTM/YmsHKrqZbu5yujzAcMiyz7HQahgm8yqNPcSY1n/ADG5QoubFqVJ5vbWzmqMGe9cj6aY682l2BUBZmQXSy7dIfDztYqMNzKTKcjOqCBZ7tmRPmtIjQzLSXqfEobLkcJn3p3Bc+7Ri7FGnJdsIc/Cm8zpKBWYK8UNeDdHCyvRlLT5q2qDbr8S0eXQg4r3cwwNiEv8CpMYl67DMtKS14EysvcPLvaHlvHFwbjwqs0jVfXX9Eo9352M8gyU5YIlHhmXEWt+xi+SduPWBdZrBCgUYp5MrkNP+oJLuJUCAwA1+dx0pLcj5MLjhhDbq1e+Ql2B4iBA/jYe6Lo05yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBZtJ479+XpxRIPl+tGdy/bdCwIqJjf3WgbXvyQuArY=;
 b=U5xnCeeM2VsjdWGYLY5DVo1O/6kkIptfy3oyECb97kk8pBn3ZpsNigq5ktY06sVCti0SfZxzk6aHDyjCgnH4y+wpsumEwJiOlhV8t2qtY1xjm89AMRImxgYkf5AegvzAgNGo0U/LMiySOpHevLbznabBahxAOaxQAdXGqMIEN5TKnotn7UqiaewRtCkN+AOQ66gVsf1yhAwGrwWn1I96s95JCvEWsYYL3ve6clS/F/oXYCsdfzHQv0GNk7flT1EGcyapEJHpH2nGTx5cUJSBqUojdBurPKqewu1oglFgrjoD0CnNCEbhSzGohosJw8PK72gpbQnKVKAePZUBEoGh7g==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by DSWPR05MB998946.namprd05.prod.outlook.com
 (2603:10b6:8:3a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 09:42:57 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 09:42:57 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "leitao@debian.org" <leitao@debian.org>
CC: "a.hindborg@kernel.org" <a.hindborg@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Yingjie Wang <x-professor@outlook.com>
Subject: Re: [PATCH] configfs: protect symlink source callbacks from removal
Thread-Topic: [PATCH] configfs: protect symlink source callbacks from removal
Thread-Index: AQHdbSvkXEtvC7zga0y680FgQNKWhbchOegAgAEkeoA=
Date: Sat, 7 Nov 2026 09:42:57 +0000
Message-ID: <20261107094255.471878-1-x-professor@outlook.com>
References: <20261105134514.2890692-1-x-professor@outlook.com>
 <au39EinX6Xhj4yoj@gmail.com>
In-Reply-To: <au39EinX6Xhj4yoj@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|DSWPR05MB998946:EE_
x-ms-office365-filtering-correlation-id: 3ecadf91-ce93-46f7-85a2-08df3cb3815c
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|51005399006|24021099003|22091999003|24121999003|15080799012|31061999003|8060799015|8062599012|19110799012|4140399003|25010399006|12091999003|40105399003|102099032|440099028|3412199025|26121999007|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzFvVzMrdGF4bC94Y2JCaHZUcVllLzlkTnh5R0dRblltazBZcmYxVURybG52?=
 =?utf-8?B?b1RqdDZvM2t1ZU9xRCtnWW5FdnlMTzNsYmxiQ0gvY1ZBOFU5Z25rc1NjVnFV?=
 =?utf-8?B?Vkw4NmU5OU1FNnRiQzhtRjZuT0pHeVAycGNQTWhQaFptb2xiTm5haXI1ZEFF?=
 =?utf-8?B?TE5JSUJKbWY5NThCMFBwOG9BMHhuVFcvc216ZUFUNXQ0OEx5ckE3VWx4N1Bt?=
 =?utf-8?B?MTVEWml2L2NKbjhuNXdrN29KYVVwRi9CRFF4T1VxTncwcnQyZEs3M1F4Wmpq?=
 =?utf-8?B?TU9SOEs3bWxBRE9jbjdhbjYxazZ2QWZsSU9DYlVveFdUODd2NTJvclJiSjR5?=
 =?utf-8?B?VzNUdTY1cUs3M1FINlNzM3M0cEtuLzNiTDVmTjA5Mmo0OEFyY3p4aDhIN3hS?=
 =?utf-8?B?RG5qNDVKcEVmZ08weUVQekRRdFU2MXhIN1VGSm9wa1dIRVFDYjNPanYwc0xI?=
 =?utf-8?B?RHVma1hxMUZMTnhaZSt3OWNHM0RyakFFdG9ZdkFHT1ZWUkpNM2tacWNmTktB?=
 =?utf-8?B?SDYyd2NkV0FrbkNabDdTNWFFR25NTm5BVWVqNy9ObDNwTFNMYXVwb0NlZVFO?=
 =?utf-8?B?d2l6WFhBZ1dMbFhSeHJrVFdHZzc0UU5xcTJmaThqNHBKTGxVc2hrTEF0UkhB?=
 =?utf-8?B?TGFzOTUxTXNQRGhnYWx5L0czSmJyVmh0YzRUL0FrZlNwdExmUkpzUGYybTgy?=
 =?utf-8?B?akRRYmIwOE1vUk5ITzZ0OFN4d0dSVmhkTGp1NUpnWjlHUUdGcm5LSXhHVkFG?=
 =?utf-8?B?QmpGL2tSVXo1UEp3QjNtVUZ3amNYWHBBY2tTajRneXI0eGM3QUhBdWlUYnVV?=
 =?utf-8?B?aVNSZmwvU3RpNXFXS3hkSEw5ZTdQTkU1R2wxS0hTRWlXMTFKcHlxM0JmSUsr?=
 =?utf-8?B?Q09Obm96d0N2SnV2bnRUdlFDaDV4RGpVaFE3WFBMdDBCVk54Z0dWRlFvK01W?=
 =?utf-8?B?M2t4QUdKYmFobVJoY1NUZEl5VGpUVTdZckFITGE1Y1dZaVZ3bWwvUW54bmtX?=
 =?utf-8?B?QlIxVHFocEFraG03M21RYi9tbStRQjlFOUNBdzlsdjBSN3hvYmJjSFVRNGRh?=
 =?utf-8?B?N1hreVR3WERpSi9QczA2Y3RSb1F0dnA1M3haVytUZnU4eHFHYUpuOEJnL1Jz?=
 =?utf-8?B?Q0tOZkplcmhGZDRxVDJpVzJ5bUlwUDAxZnVXMGlXV0p5dWVCV3AzWTIza0hX?=
 =?utf-8?B?dXpGZnBmRndHWHVkMFBqcm0zS21SY0ZvdG5RK3dmSVQyRElVN1N2aGQ3WDEr?=
 =?utf-8?B?MVd0RCtESk5YTVhqQ1lGN3pSaitLeU81ajlqTVY5UUZtY0svcWV3YlhGZ1J6?=
 =?utf-8?B?b1pqZmNZR1NGK0lsTmpYcVU5VnFYSVdJWmx4enl1aGNka1JPS3dMQjJ5d2Jp?=
 =?utf-8?B?WU1ESGhzOTQzUGhDS0ZaamdyUXlqZUROS3F3aHB3anMzM3J3UGdUVFFyazEy?=
 =?utf-8?B?SXNBVEF6VXVvb1FTeFhhUERqZXg3Q01UMjhBTjI5dEZFY1JVUHdMSEMwNEZD?=
 =?utf-8?Q?nFh7q29ftsq84EGe7y1CzXPMZq7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVRzdktiY3V1U2o4QXM0eTdHamQzVU0vblJTbE9uNGdIVStTWm5uR3ZYSnNw?=
 =?utf-8?B?TWpaWXl4aDhoQTIxSVNQb1VIcnlzUDRIdjZ6ZkFkOS85bHJ0Tk53Uk1WTnBF?=
 =?utf-8?B?M3BXYmlRZWdoK3VZU2JYUTl0aG9xUE9NUE1KSDBucTZZbzM3M0hsTzYxM29Y?=
 =?utf-8?B?aWdnekZEZ1p1Z1hEblB5dU01ZldZU3p3eGZQbWtIcy9idTlwbjBCTTdTblZF?=
 =?utf-8?B?S1A2cGU0VmI4RGxoY2pENlNqbm52eTBkUmJDMFpocUl1MWhSSGlya0hJWFJT?=
 =?utf-8?B?NDNSRXYvWlZVamU5YVFOWUhhK0dSeG54ZWdJNUxBS05TMlJ3M2VGOTRoazdy?=
 =?utf-8?B?bzBvbFY4TlUzVzl6cnBmc1hXWDQ0M3ZiOTBVMERVV1VNckg5dEhRdGI0QXov?=
 =?utf-8?B?WWM4em1KUmhqU0xSRGc5ZG5DYzV1SkpPZmZEWnR5UkdvWUZOU0RLVTFFRCtP?=
 =?utf-8?B?VVNnR2thNm50aWtLaDVVSExTSUkvellRbCtrSUJTYmYxS3JJSFRrRG14bkdS?=
 =?utf-8?B?UFhSRFZaQkIybTFqMi9aY2ozUStUSitzQTdRRzB3RXF3bmc1Z3NJby9JM0Qy?=
 =?utf-8?B?bnl1YjFtd1lhMGFvZzV4TGxmSk1hd1AybmluWnB6ZVphVmlYNXJ3RlpOT2xn?=
 =?utf-8?B?d005eUd6S1g2Rk9zVEZCOHo3UmVWUjllYk52M0ZjYlZ1ejRiY0cxSkFvWVly?=
 =?utf-8?B?Qk5nVDZOUlV5WUxqOUVXRkZ0emc0ZmpCRVB6K2phdWUwcmhWb3J3Wkdyc1Vr?=
 =?utf-8?B?cEZzVUlnVmZlZ3pvVXZKcmZRdjBWNFZkUzkyYVVEVldYNXkxQTlzY0hzRjQ4?=
 =?utf-8?B?VFRKUVlocVVBOXFSb0F1SmxCWlp2THdoMFRIaVBkWHZ5MWhTRHZYY2d4TGRu?=
 =?utf-8?B?VFlzdDhvT0dOSTQrM0k5SUtvdnVsQ3pHK053NlY2dlhxK2FzSmM2U01kVXk2?=
 =?utf-8?B?cVkwdHVFRGxwdGlXVHgzdWZMaEx4V3pGbFd4UHRIckdjWVY4QzVqRjNreXd5?=
 =?utf-8?B?TzQ5NmdaK1ZMUHF2TkN4RVpwbmhZeWZYMnVKMUVMYVJZb1NqVlkzUU1WUWU5?=
 =?utf-8?B?eFFuK0Z2U09OdGlmQ052Tm10YVhPWklxSmRBOEtjRGJHNjZMRmhWVDlLbW9K?=
 =?utf-8?B?OS9DNm9oQWdjdndzSnRsN2VVS0s1NThWOGdOVnJxKy81N2w3NUF3dWpIWHZq?=
 =?utf-8?B?TUgzOTJLL3BiVkI4bXc2ZCt5UG8zUUVGQzBpSjFWTGVYL3hpUUlhZFI5RDFE?=
 =?utf-8?B?ZWFHMk1WL0tsSk5NYVJtbExSL3NyVFBadzhNVGs5c2tXRGJLekR5QnZxdmVo?=
 =?utf-8?B?UFAxclhaSExxYmwyZEI3WjM4YVhKNzNENTQrZHdKcHRKOWk2ODF5S0RQM1VY?=
 =?utf-8?B?VUhSSGJVTlZ3U0MrZTBIajVsWjdjemJuc0xSV0I0VVBCcWNacEh2Q2ozR3c3?=
 =?utf-8?B?T243bURKWWo2WTVVTkRnSEo2OXcvUWxJcWxGUkxielY4NDhmNWdwM29RdFdt?=
 =?utf-8?B?aGpISEF6cnpQWThLL2toTW05WFIyVGFuOFczMzJXcmc2WXRQdlR3a0hHQVRp?=
 =?utf-8?B?NHQrOW5xNDlCcmpoNlBESWQrSldSYmdmemhyZDFYWnpVcVR3STI2YmxPK3Ar?=
 =?utf-8?B?bkVZamg0TTJ3NFo0YVppNU13cVQ3eUUwZkFRMkRLTmpiNDYrV0puT2RYd042?=
 =?utf-8?B?VVN3QUk1bUNpZkFmRVViNmE1L0pvMU96WElYeVltcGo5c3dheUt0SWR5aHhh?=
 =?utf-8?B?T2JBejI4a3R1aTBtM1dFOVY3N010bDRBUXZsOGVqbjJvbndIR3JwRklVTElz?=
 =?utf-8?B?eU1ibnV4M2crQzRhcUdoeE9JZ3I3Y3YrNk1wdWgyOW5Dc2VKR3hValQwZXNj?=
 =?utf-8?Q?QEBbaurDK6OFk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF3909623E371846B12044CB6014AE33@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecadf91-ce93-46f7-85a2-08df3cb3815c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 09:42:57.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR05MB998946

SGkgQnJlbm8sCgpUaGFua3MgZm9yIHRlc3RpbmcgdGhpcyBhbmQgZm9yIHRoZSBLQVNBTiByZXBv
cnQuCgpNeSBvcmlnaW5hbCB0ZXN0IHJhY2VkIHN5bWxpbmsoKSBhZ2FpbnN0IHJtZGlyKCkgb2Yg
YSBVVkMgZ2FkZ2V0IGZvcm1hdApkaXJlY3RvcnkuIFRoZSBiYXNlIGtlcm5lbCBoaXQgYSBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4KdXZjZ19mb3JtYXRfYWxsb3dfbGluaygpIHdpdGhpbiAx
LDAwMCBpdGVyYXRpb25zLCB3aGlsZSBteSBwYXRjaCBjb21wbGV0ZWQKMTAsMDAwIGl0ZXJhdGlv
bnMgd2l0aG91dCBhIEtBU0FOIHJlcG9ydC4KClRoYXQgdGVzdCBkaWQgbm90IGNvdmVyIHRoZSBu
dm1ldCBwYXJlbnQtaXRlbSBsaWZldGltZSBpc3N1ZSB5b3UgZm91bmQuCgpBZnRlciB5b3VyIHJl
cGx5LCBJIGFsc28gdGVzdGVkIERyaWYncyBwb3N0ZWQgdjMgd2l0aCB0aGUgc2FtZSBVVkMgcmVw
cm9kdWNlcgphbmQgS0FTQU4gY29uZmlndXJhdGlvbi4gSXQgdHJpZ2dlcmVkIGEgdXNlLWFmdGVy
LWZyZWUgaW4gY29uZmlnX2l0ZW1fcHV0KCksCmZvbGxvd2VkIGJ5IGEgcmVmY291bnQgd2Fybmlu
Zy4KCkFkZGluZyBwYXJlbnRfaXRlbSA9IE5VTEwgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGVhcmx5
IGNvbmZpZ19pdGVtX3B1dCgpIG1hZGUKdGhlIHNhbWUgMTAsMDAwLWl0ZXJhdGlvbiB0ZXN0IGNv
bXBsZXRlIHdpdGhvdXQgS0FTQU4gcmVwb3J0cyBvciByZWZjb3VudAp3YXJuaW5ncy4KClRoZXNl
IHRlc3RzIHVzZWQgUUVNVSBUQ0cgYmVjYXVzZSB0aGUgaG9zdCBoYXMgbm8gL2Rldi9rdm0uCgpJ
IHNhdyB5b3VyIGRpc2N1c3Npb24gd2l0aCBEcmlmIGFib3V0IHRoZSBtaXNzaW5nIE5VTEwgYXNz
aWdubWVudCwgc28gSQp1bmRlcnN0YW5kIHRoYXQgaXNzdWUgaGFzIGFscmVhZHkgYmVlbiBpZGVu
dGlmaWVkLgoKUGxlYXNlIGRvIG5vdCBhcHBseSBteSBjdXJyZW50IGZyYWdfc2VtIHBhdGNoLiBJ
IHdpbGwgbm90IHNlbmQgYSB2MiBiYXNlZCBvbgp0aGF0IGNoYW5nZSBhbG9uZS4KCkkgaGF2ZSBu
b3QgZXN0YWJsaXNoZWQgd2hldGhlciB0aGUgY29ycmVjdGVkIHBhcmVudC1pdGVtIGZpeCBhbHNv
IHByb3RlY3RzCnRoZSB1bnJlZ2lzdGVyLWdyb3VwIGFuZCB1bnJlZ2lzdGVyLXN1YnN5c3RlbSBj
YWxsYmFjayBwYXRocy4gVGhvc2Ugd291bGQKbmVlZCBzZXBhcmF0ZSB2ZXJpZmljYXRpb24uCgpU
aGFua3MsCllpbmdqaWUKCg==
