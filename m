Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F21A267;
	Mon,  5 Oct 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791164715; cv=fail; b=P/MmtZjeuQItTIQ8+QwU2NjNqYbdGdMuSC+foZckU3tm+y+bMPQ6oSuoLpicpROx2TFOX2J6CgluUfA5ijMXYA+Zx/fHbkJEJzycmZcon4/zpKelzUusfa+3RC5e4NOUFi6Vzdq2ibVKHgNxj+rsNKLuNdOpCs4uSuDNYn/Ujmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791164715; c=relaxed/simple;
	bh=dv7CEl5HiUxnl9f27Rf60SddAiymows6lJQApNPNnwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRaxx/SZg5af8MAd3MbwyPG+6fGV37rs58a9y9JEhhTxstIsuQ1NbkD9YiwKsGiuldsMiaHtM2mtMGKrv5/Wja/8g7+ViKzUi6kcqRZcYkwDp0wNzPLVNJzY25IcvNqZPgULhNpd6AizEPMHxejFvNN3QiYMK3H8Jq1oKmPEMvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mZJd6b+0; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mZJd6b+0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTFMLMK04YCAToG9bCn9VHT0VehCYe9DNRoScCPRSjBDWu2wlvyfmUP8DNuPeRgaJf0BGU4TQrxqMocBLXmMC5O1kT5H7xHvPx4LPgAezOS8Ai1bUPvgOE6PXQ+5e8hGYf8W1ftNmeWQ3Lj2UDCabzb6tBoza9/pMAICNFmyRrENTUA97g6qNrAC8aUBMmK+E6cRF9P/HYdpBMqJQF3vmyRlhrr6BbUsJEYIfQCTg5kVBVc+XUkdhd3ASwRMTKZOJZosb48kWVkzOWNe+RUaE2cFCfXWziXun8k9rSMR0F7wN7goniD+WTB9DOUfrUvRsqzJ+JHdr+KeqHj8spuzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv7CEl5HiUxnl9f27Rf60SddAiymows6lJQApNPNnwk=;
 b=TzFWSSgbdNdmj0pkxwerOVuIoKqWv10fVfI1PN5z8wzcQEXDqty105Xoxn6JwWozYuZgHc31itq5wxcHvvTzFQXQ2MBPY+Bk8Z7mjL0fs7Iuk9BJlmPjueBzO3Y+u9Qt9CrUH/vTt4ZD9HmiweyNAEYU2/laHZqgBThPPcYnS8dWsXYSwzNdQjB6iCbxwSJurVWqjlvnaouTxkhSysUDuQITgo86MrbI2MUnzi8o4CsFuC0k1h/GGaNbjnSIfChgIfQy4KEKL7m3grxzcUJD8w/2Vc5217lP4TTNpdtksrkGpenpYJ1pc2CpoyF1ekkMCZ+l/AIx7mlbAEdRuV/fCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv7CEl5HiUxnl9f27Rf60SddAiymows6lJQApNPNnwk=;
 b=mZJd6b+0ooOEDpJ1ZVjfGJkoJc7fzfy1qlEGBUHuYEwoPks8NdAS5FMVpYzqbuyUPN7g/UXagMGhi6/GKHRQpqIBDwyp7n6gkfEnpLINcwXzl9Bg6cS8yCIEpxzE9fvl62wqDWpj9Q45B0H3pMqZPPv80bZEedto1FmWYgCfxkGZejRsZqaUt9dWXBrrc/ReZG//R7H59U5jip8qvnxfUTjpbyGHAqvUWIDiisEYhL+f6DT3b7yjtw7J149D1NieCJTIqffx64Gq9yv68cnIdyxe/QddePMlbdNULGSGMW+DsQor7/lR9AJsFDcXagbcdvXqFFJAkmRh0P1YDBwpeg==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by VI0P189MB2687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:45:07 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:45:07 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH v2 1/2] tipc: skip socketless connections in topsrv
 teardown
Thread-Topic: [PATCH v2 1/2] tipc: skip socketless connections in topsrv
 teardown
Thread-Index: AQHdVENhiBl69M9Ihk+V9UOeiHoxIbbuLMJQ
Date: Mon, 5 Oct 2026 01:45:07 +0000
Message-ID:
 <DU4P189MB37509EDC07ED80A505938D05C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20261004210016.3051310-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261004210016.3051310-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261004210016.3051310-2-Jeremy.Jean@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|VI0P189MB2687:EE_
x-ms-office365-filtering-correlation-id: 41c26b22-6e47-4edb-17de-08df22824907
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 m5yyGEnKd24ew9AFx0ybIhLtWqdSlsrlehsFjT4UuZjItuYPVHKxjIXRwQGBEDr7pOdB9pbZnbJryp+E15UpSZCq+4Za0rL9fDStIlbHvcNwBLi3x6BwbUbuzp4t0XYt5qbssQKtfOoea0xgx6Sof3kRC7G+vLMXDyioVxnpTA3OtCoeQ3rVdI2X1oHSJU5Y8Uc3q6IBx1XNGOHXUPxCVvc5K7u3UXS9y1zG6XRxPqEUOaf3GYf03zRClc53a6OxFHlFwzn6SYSqmZCJI4qlHPowBgCTj7qM4Uj0Mk/6+SEHIoY26aWa2LwHG19gFL/Fn9kOqVSl1Cu3GDWkFf8orEfH85wc2M+N5FGx6jzWp6X0xHPtqYJD0MHCZg1zr54UzP4cB/1JGwGU+rjOUk+JWwiudiMN30fcltiYiwx6z7MofBz6qtyNFJ7BmE2s46XxU+tbOuSjMfHpgg0lIka35UgKpk9zH1H85Hkmt9iWWzWHRrINekSInHou7Rh8KyMBYFy8sEFwoLRm9iO41Rwlzw94m+5yXG9w5kMFE4ekTAn1jtP79CW58iQADpecQwuN5gvWHRRVwGyU0ui+SDDe4gwFNmyiscxak1hspAsAws92rBCnXJLvHcLUfe9n/Pqwab1UPBQi76/rZChzRpvcQUNQMOFuClwao1p9yqdBGrXnPHTtYcNqHcfSaMhw2Y64jXDkZEFd2hfl+7v7hxzb1RWrLuJ8kLjkZcJt9ZDX9MA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NE55L245eXh6VzZxQ3hVSWExbXQzQUVWa1A2SHczMytWNFVGRG1pLzY4S3JC?=
 =?utf-8?B?SkN1STFKdklhanZMWkVqaEcyRXgwOHV1UzNPa0U4SWZXTSt5ajlHbEFlYmZ6?=
 =?utf-8?B?eGNtODIrZ0dISVNMcmc2bnplQjBoNjc1b1VpbS9EV3d0Y2RlcWltTzhuaWpo?=
 =?utf-8?B?RWVLa015V2tJbXMwUEdiTSs5OFg4TjFtS29KZEt4STV6SVlESk94MFBXd1dy?=
 =?utf-8?B?b1BObTl5TnQzOEZHWHVTZmh2M0NLajhoVUlucEZ0MHh6SHdBT3l3UzhDYzVP?=
 =?utf-8?B?OUpDQnhzZEdlWEN2MjRhQ09VMW1ONzhOajAxZ2lBTm1GTytyZlFXdE5JR3Z1?=
 =?utf-8?B?UUZrYTc4ZTVBN1VrSWNaWFFhQlhkVVV5UkNJVzRTNXpHL1VBdlJvY1FIT0Z5?=
 =?utf-8?B?RVBMbmp6WHV4d0F6UFE0c3BsRThmbjJ4eE41NlFIYld5RjNNKzd6OGVlWjZL?=
 =?utf-8?B?M3l4NHVVd0kxakpGSks1cm9kaTJHbk55eldnRmd0V09rNU83MFU1Y3ltNUlr?=
 =?utf-8?B?WmdKbDVXUnp1dlhFTWF6Ni9HSTUrRWh4cGMyWFEyVHRUQ08vY3RLSlAwdDAz?=
 =?utf-8?B?YzZ5R3ovSnozN0RKM1VhbDcxK0tPWDR5RUZBamdaSC9DNE9jcFhCakVmaExl?=
 =?utf-8?B?TFczY1hxejdrOTdQelVuYk83ZGFuMFl4MHRxQkRnRnQ3S0R0b1pxQ3I0VXkx?=
 =?utf-8?B?OWRqOXRJdmdqSTJBc0Qzb0tabktjWWRrUHhac0I5WXJYY2JHMGJnTVpKcklh?=
 =?utf-8?B?NFBXMFJOYUdPSkIxaWhZbklPOTlqMzBnYVRNTFp6b2s1dWlaTmFuOWVzbktT?=
 =?utf-8?B?Qzgzd2VYaDA4ZUhYTHRCTGg4QzlyMFBhUmJGV1E5SlVXdVAyMytJMm92OXE2?=
 =?utf-8?B?UXFEdE44YW85UDAyZC95SjJuNk05Tm4vdGdhY2lYNE90YjhPeHlBd1hnWmFr?=
 =?utf-8?B?dlp4VVg3ZFdkam5yeWZYM25TcGpYSkh4RmR1NmQwZzhGSjNGbXBTS0NCWjJZ?=
 =?utf-8?B?WEtUVVpQbzBvcDZtdVdaODlQcnUwcExxNlA4MzAyeUUxcGlWaWtrN3NuRFRB?=
 =?utf-8?B?ek1Ebi9JaHZoeEFBbFp1ZENVNEtBUUg0K29NYU91b1h4M0ViZVY0WGNpcFI3?=
 =?utf-8?B?Z2x5M3lTODNZb0x2cER0SVlsM1E4MmJqaHREN0FMa3g3bm5nWk1nMGYzNkNX?=
 =?utf-8?B?T1BDWG8vMFp0djA1R1d6NWIxL2gzWThHaDFSOU82d2ZCMVFqVEZhWFJNdE1O?=
 =?utf-8?B?N0VrTCtDbHdvQ3g1T08vM0hlR0Z2Ky9GMm43Z3ZzRGRKSjFVWGtnbnVVYURN?=
 =?utf-8?B?YVZLMmp0ZHJXZ0h1ZjMwOTd5RnF5RVhRWVJaU05FdFdZbHFrSng5Skd4Sk16?=
 =?utf-8?B?U1dtc1hNTVd3c04zbkE2OVdITlFNMGQ4bEZPd09xV1RRVE9oa1U3NDB1VFhW?=
 =?utf-8?B?a3hLdW56UE9CaXBEMUVxZnZ0UGNFK0ZuSXhpVW5wNEpmNDhFM054eWZUN3ZE?=
 =?utf-8?B?RUthOElYMXlWUVFsVHRGQy9sQ3gwdXBqMXZhRTRPZ3VSbDkvY1NWTi91dTRC?=
 =?utf-8?B?bytZLzJSOXR5eUdUOVdtM3N1ZXZZOUpxajN5ZEdHeUIydmxaSkRrVE9QYVJL?=
 =?utf-8?B?Y0RRNGRXQ052L0UrK01hRkZJbnpwczFUZ3lhZVZyamJWcE02YnAwZHp4NGFp?=
 =?utf-8?B?Q2krZUpWOFUvczlpdGNSMldoTlBRb2szRlNKYUF1OTRTNE1SSnhqSENwQzZ4?=
 =?utf-8?B?WjRzN0kzclBIcUR6V0o3bUJJUVNOUHphdVRrbStSYUtsYSswZCtHY0U3U0lL?=
 =?utf-8?B?YTJJbEJFVnc5TWNSeXhUNkJpYkRDaTZKenBoOFV0MXdtYmE5VnE2STlqQ0Q5?=
 =?utf-8?B?OFk5WGszdmxaR0RUZ0w5VkJQMzFtc0lrQkFnOHJ4NjQyUUdoNURyQ1ZnaytI?=
 =?utf-8?B?YTZpMDdTR0QwSEFHUmhwTTNxQXBlVG1EVW8vTytkbjgwOTFyOXVoeXBvblFI?=
 =?utf-8?B?NlRCMHRhZFNaSU1vT3FCcE14TnVqSVRtMTc2c0U5OVA2UHE4MmFNRUxNK3o0?=
 =?utf-8?B?bVRJakthbEdQSkRYTUZCdjVjdGhXaTFVSS9wVDE4REYrSlJDaW8xMGlMc2tS?=
 =?utf-8?B?T0lTY2NWTVk5SjU4ejAzWWJiUUFHSmVSUEVNR2VnejJhTWwyQWdSVGFJODNr?=
 =?utf-8?B?eVZ1YlZzc0xLL0lqeWVFckJHSmxkNEZsbXBlOVM5WkdQUkxQczRIbXlJZmtS?=
 =?utf-8?B?d01KUE5MU1YyS01vU1VjWkNKVmc3NktPOUVPQTIvRkhRNWdzUlF4bWd2NExS?=
 =?utf-8?B?RUpQUXZocDBza1YwdGRZbDRaZzZGS3MxR2FUVzM5dWlLUXBON1hEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c26b22-6e47-4edb-17de-08df22824907
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:45:07.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNI+X95+ZVK7/YURtBOwey7dJBmT2aiTHgvnScgKygeiEVBymQdla3drTx6RQqbbGPo5nx18tnmJbYWTrqsXOw2iXTdi89b9E4bkQR19OOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2687

PlN1YmplY3Q6IFtQQVRDSCB2MiAxLzJdIHRpcGM6IHNraXAgc29ja2V0bGVzcyBjb25uZWN0aW9u
cyBpbiB0b3BzcnYgdGVhcmRvd24NCj4NCj5LZXJuZWwgc3Vic2NyaXB0aW9uIGNvbm5lY3Rpb25z
IGhhdmUgbm8gc29ja2V0IGJ1dCBjYW4gcmVtYWluIGluIGNvbm5faWRyDQo+YWZ0ZXIgdW5zdWJz
Y3JpYmUgd2hpbGUgc2VuZCB3b3JrIGlzIHBlbmRpbmcuDQo+DQo+U2tpcCB0aXBjX2Nvbm5fY2xv
c2UoKSBmb3IgdGhlc2UgZW50cmllcyB0byBhdm9pZCBhIE5VTEwgZGVyZWZlcmVuY2UgZHVyaW5n
DQo+bmV0bnMgdGVhcmRvd24uDQo+DQoNClRoaXMgZG9lcyBub3QgZml4IHRoZSByb290IGNhdXNl
Lg0KSSBmaXhlZCB0aGUgaXNzdWUgaW4gdGhpcyBwYXRjaDogaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9uZXRkZXYvbmV0L2MvM2FjZGQ0NDM4NWJjDQpQbGVhc2UgdXBkYXRlIHlvdXIgbmV0IHRyZWUg
dG8gY2hlY2sgb3V0ICB0aGUgZml4Lg0KDQotLQ0KcHctYm90OiByZWplY3RlZA0K
