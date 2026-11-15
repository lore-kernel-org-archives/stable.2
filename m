Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794728503;
	b=1+qPFoaJN53PvO6G27Rm0ckSmyvWwu7FnLcSm/OmshwJnXHGuD2BLVucbHxoRgeg7x4Y
	 xADNL2bXDJA8lbvbOz3VkEacySOgHPYXoNkOzq5ZwacnQ0hrsET0adDaC3GYLl/7gr+lz
	 4AtFrqJKdYx2J9vXYAGqy4meoPYJZYGD3I2LPMkDtTuo/WibMfJIL0BlGYYyKuDgmdq2Y
	 0X6fVo38B1xujNBk1ddQb3/Zo3QfAIdzZ0fmLWmMS/ZgCrbzOI+AYt1Mr018J7X0ZkdvR
	 WxBVHSg9t34P/CPDGyFbvNZjNHzO5OUu8UcSGMf0e94gs2OSohtRl9xC2ktkDOxxfmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728503;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=q/Yv52XxToMU+hyp3O4x5kJLTNafpg1dULxNheJsPAc=;
	b=1X5qTEpG2Ig99GSeOuHKz0H61ga77/5/5RErkI7Q/U+bcvk3UIm+2evOtVWHrcMD9OOK
	 2uN75xNrY2fGpDzlbwEOjiFg9VgbrN537wVhP8qNqYaD63FPS1y1Qgn8g5NHK+xF3dPGE
	 7OMACixbRBTLSGA6Ulshu9omE5oZj7dHnVvgfO/VsCCWfgby53QZzj5vlD+MWzDswnt5t
	 u1BuTLIg/Oi+8QcFXV2edKhFaXOjOF/6+hZdGfKo3XJKvqcM+DFNEVgwr/ayPsHO50Els
	 SqnpXt5tX5jhkCTKpweQg/qTTLJ0TNQRzFfZ8fQpQwR4CbpPtlo92Vlby8tjMbDELVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cVe5bLWN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.0
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010000.outbound.protection.outlook.com [52.103.2.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F00606A31F;
	Sun, 15 Nov 2026 07:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0F00606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=cVe5bLWN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3TokWprZLUMtLz11dPjxoMASGQ9S84t+i7Uk+kIdK3TE17Di4t/KXgMzfQNNc+OYWFFlInqeUd0MR1kBFYc0QwqZDHk9mM9Xg4XER6sUcDGbMWsEp7XKsPyFw8UcheOt+tr6CdHBdwyoTYIcyHdpw4qBzMnO6YVihR0xkQzbHDe8s9eM6i9JVorwD5UoJdDCgN9ZWvEu0yNv1ZT+aGTkaUG2RDcTffTH339GV6HfTmSXYEfPvPSV8nQT2VDhMiAOZKU0rC0gt4GGT7KRsuJuQc0kMxQ0G1C+jqekc2AGjSvb45wYPNgSNKGqHhgkbmWSfJdoAUEsQH2VXldD09asQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=q/Yv52XxToMU+hyp3O4x5kJLTNafpg1dULxNheJsPAc=;
 b=Ziw0uRXP4Ca/x2gFIfxmsnilDoGoEnBT5HgOfQHVQRdbxOJjpKaDy4HMptqFqJyAJpZlCIVJgx9fi93sTwauT1aeLXHpeI3ReHF9/3AaCPDtZXytDs9gkLL9favnXNd98jNmOJ9MKEHOMLqTaheCs/jlH005T68uXnZwnU0BD43pc6qmV4wvPV3OiFIEEGAjJTxvzaD4uHkV4Sy6ivF3EWYTkFLlDK8iy39S2P3a/LpQGgsy+QqFqSDm64hQ0lfpnrFxQI2emygjgU2a6fcWNTN4XdqFIORWx0UWKEqBGnYmVSLfk3Pk/woh+h9woev4z7u+e9iiBsT5zSsYAgd5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Yv52XxToMU+hyp3O4x5kJLTNafpg1dULxNheJsPAc=;
 b=cVe5bLWNDqKTc6Rb0jDbHJ8JSpjI9tGbwhbg/iDG0f96NKeTuk4ACKknFsYCSpcsnmZ+MlolmYHdY1RieLS0x+b6IHSTBGlgo4NLmetXYXErVd+Us1lvAuvgEfMKcdv5mDl91NhY4tSGbj32itXXO0FMoqFDxDkhC/QKckJJyjBlpTKq+mQCyqZWLb4ngcywcneN1fQ4rmnh743edRCDeZIKI9ax7vXVMKYxqHViwI2tER1MESncllhk0OPBXjVGuKaBluSbPECOnbH5QiIDPAb19Dh3pKCSMqzpCtXrfVAWWxd5lmIS/SRW15j0p985/Fxlr6VlX3hqBTAbolWAvg==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH7PR05MB9777.namprd05.prod.outlook.com
 (2603:10b6:510:279::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 07:40:02 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 07:40:02 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Song Liu <song@kernel.org>
CC: Yu Kuai <yukuai@fygo.io>, Li Nan <magiclinan@didiglobal.com>, Xiao Ni
	<xiao@kernel.org>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] md/raid5: preserve active PPL log when removing a
 replacement
Thread-Topic: [PATCH v2 2/2] md/raid5: preserve active PPL log when removing a
 replacement
Thread-Index: AQHddNSGyU7EACzLV0uFX0H8gLihAQ==
Date: Sun, 15 Nov 2026 07:40:02 +0000
Message-ID:
 <0028f12d46bfa74113baeb2764f0948577b3b840.1794555233.git.x-professor@outlook.com>
References: <cover.1794555233.git.x-professor@outlook.com>
In-Reply-To: <cover.1794555233.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH7PR05MB9777:EE_
x-ms-office365-filtering-correlation-id: 18f23dc0-c207-4951-08b9-08df42eba8e4
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|38102599003|8062599012|8060799015|19110799012|24021099003|31061999003|25010399006|15080799012|4140399003|24121999003|22091999003|18061999006|40105399003|102099032|440099028|3412199025|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGNUV2VKZXhrZE1tZ2liM3dkU1R1bGRxQkpmRXBFZUdtRmpXSVlVcXNqMzlz?=
 =?utf-8?B?ZDY3c2JxS04wM1NQYlFDOXpzRU12cUZDcVBsYUQvTGNtQ0FzL2w2QWg0NWUv?=
 =?utf-8?B?RFVTM2VzcWxRVGpQR3BPbHlrRHVNZkV4UGNoSzI4bWViV0xZVy8rbDh5M2hW?=
 =?utf-8?B?eFpFNTVKS1hQTnUrVTdsK0JZQjdDd3Y4T1RKSFBYVVY3c0RWYmxEUDB4KzFh?=
 =?utf-8?B?dEx4NkM1ZXR1UmNMQ0ZCOWhkK2hUbnh1UEtIckFlbkFhQUhBaDBQak9zTm54?=
 =?utf-8?B?a3pibC9ySU1aazlwQW9hT1dDRFZxdXJiTDJMakpZZnV5SlVNemM4SmErbGU0?=
 =?utf-8?B?ZWVmRzU3OW1jbkhscnJHMm5ZV0RSYWw3dWNySkhpd2Z5QlowU1dJR2JNcmpY?=
 =?utf-8?B?RG5uOFVFZC9FNXdLVGJpdDZmMjZiNnAyZVFrdEtPZ1NVWm05d2ZUenRGSHlK?=
 =?utf-8?B?RS9FZ3Zxc1ZTSXU3RnF1RElGa0xFTTRwRloxWHJXT2I3dnZoay9WUWtlUmd3?=
 =?utf-8?B?R1VkcjNrUS9oZkJrWmg3N3Uxb2FCSFFMaExmdkkwV2FGUHQ0Q0hpQkJuWEt3?=
 =?utf-8?B?V21aUEE3eFlzRWhOaE02d0lEOXVTL0NYQjJscEg0REV2QlZwRUpUa0toTWQ1?=
 =?utf-8?B?RU95VndJRU5lUmZyRlRjL2hvREJaNjJQQVpxcVdNc0RqNE8xRVVYejljN2Nm?=
 =?utf-8?B?U2FTODlxMjdMVlI4UlVINEhldGk1ZERJSW9iODVoMUFQa0lSMVc2bjBxbG4v?=
 =?utf-8?B?cHhaVG96Zlc1VGpEK1ExWHFpZ0Q5UlMxbEtuRzhldHVKOFhydTRGck1IS2Rx?=
 =?utf-8?B?WTZ5NnpiaHlpQzhlazViYk9OVzRwNUVoTElLaFlHR2pjYmZHTGdRdVAzQ0pt?=
 =?utf-8?B?RHA0d1dFS3M2ZjcrQ0N0RVdUOFFqVFIrcVBDdFFORGJxeHZQUjV2MWhuV2Ru?=
 =?utf-8?B?Znp4ck5jbTJacSs5WGJod3RrWWVwVXl4ZVRzcDhEUUdEbmRaK2dNVU5tM0pr?=
 =?utf-8?B?TEtxWnNIcEVVUmVTRmw5T0pBTFNybzZvT0RnakRxc2o4dkhpZVV3YzZzVUZG?=
 =?utf-8?B?SU4xbGp5RVIxMUljYmF4bXp2bXZPZ2NBSmhoYWVJeFRDSGhQTFhXUlFlVHpM?=
 =?utf-8?B?T0huSURtWWNoU3kwWUpDOTFuaXZXTytsaTUzU1BJeHdHSktibDY5dU93Z1hU?=
 =?utf-8?B?cUtJUnZXeUNZc3kxMWhGR3UvYmt2NE1QcGsrbjNUWEFSNXV5eU9yTTRhVStR?=
 =?utf-8?B?YXlYT2lmajNncERKbzBmdEhad1AxS044SU5KRFpoNkhvU0ZweURLdmZWKzd4?=
 =?utf-8?B?Z2RhUmdaYzQyeHdCRFNSNUd0MVZraWg5dXFaVVIva3hteGEyWkY2WEJxblU3?=
 =?utf-8?B?em44eVduUzlJSVJFYTFiSzRFSjVENmlmcmM5ZElZSnJIeTRzM2RRSEpSeGhk?=
 =?utf-8?B?ejFuQ0JqamVzRE1pUG1CYUc2aHZPNVZ1WUxwZXc4U3F5OExCcVB3aVd5UVY3?=
 =?utf-8?Q?eaa4jU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHhKMm9iQnBiNUVHVTVoZUk5dTF4ODZ2UEN2eCtmZHRUZmZEVjZYNXdVSjhU?=
 =?utf-8?B?V2xSRDlNRlh2SlNBZC9oYS9ZRXI3OXpNVzlKeFhYdHNGTTdCbmFBRmJySmZZ?=
 =?utf-8?B?b2pueFFiS1NUYVJ4REJWOHhoMW5wK2luYkVQYVBCRHFZNVcvYUZseVJaYVV4?=
 =?utf-8?B?cnVQMk8zWnJKVis1MFNCVGc4emlnUmlUYWVGUWc1TkNRbzNvRVdtZlR0Z2J1?=
 =?utf-8?B?eStJMFNMR3dKN1pocWRrYWlNRXR4N1pPdElKNi9yQlcrQU5yejUzTGZNWTFR?=
 =?utf-8?B?WHc2OGV4MDA2VFA3bWVuZE5pQjlpWWo4K2YzKy9DSllzNGdSc0twYkhDMGdZ?=
 =?utf-8?B?cVE5d0hjN05ib1dzSEwxNUo5ME50Q2JZNVo1Sld4RDFDZXI0RnYwRk53YTVq?=
 =?utf-8?B?c3hGaUpPRFdvYkNaQ1lLU0NBK2dBWW10MEZpeWxRQncweUlRZThTdFVyZEtI?=
 =?utf-8?B?bmxtWHFIdEJXa09yZ3JsSFpLeDNhQkI5bnlaZnVDbm1TWmp0SVhsSVBKRWdm?=
 =?utf-8?B?WVVITk80MEhoclovWlA5UnlJV2JyRUZvUW1IYlRnN25lcVdkTXladWRZcEU4?=
 =?utf-8?B?UzFpMlNIczMyTnp0MWN5b0VwY0ZTMHgwZFBQUmNDdDRZTkY5ZDZSckg2clpv?=
 =?utf-8?B?bzhjTUF5Ulo4N2hYSzdITVVNdlA0dXBrNFNSRUpZekFDbW9YUmNtWGQ5Q1lG?=
 =?utf-8?B?SUR2VjQwdW56OEtSZkhpd3p2YzhoeWpKQ20rSWhGWDdVSGlRdWVlN282OXdY?=
 =?utf-8?B?djJSUXM3WllkMExMUXdtMkdZclh6TTJUaVRVQkZ6SW9adjNjNm05T3dKYmQ2?=
 =?utf-8?B?WjlPV0crdXBlaW05WHdKSDF5ZndmcnNOTExub1B4ekJtekZONXVnblZQOElG?=
 =?utf-8?B?MENyRHFMMStqN01oYzI4WWd4UDZBQlp2WkxlQkJUZXRlWDk4U1dlVmp4Mllx?=
 =?utf-8?B?S2xad0VHekJtM1RlNC9yQ2UrNlJ4VGFtUHdQUHZVWUJ1SjRoNEtWMndYNUZQ?=
 =?utf-8?B?b0dNZW8yanRQaHoyeUUrVHZoWlcxVVl4Zi9jbWF2OFptMDZDeW9aWGJXVTUx?=
 =?utf-8?B?VjlJNndDWWRKZmJ2OUdPd2xHUUYzNUdhSEpxblFDUGtDQWNMK0lzVEtKNUcw?=
 =?utf-8?B?SVlQZVQ0WFJTUzZ1R3Y3V2FnaEJuQ3pnWmdCL2FOMnBFUnhlbTgxTmlRbm5Y?=
 =?utf-8?B?ZFRNZ2wxa1NwRDRPK3FvYkoyWDNSR3YrUHVsenBOT2xnQlNjWlVNL2ZvWW8y?=
 =?utf-8?B?NXZoNm40UzJPVVR2MTNQN05DWVh1QlVJU2NjdVRCS3FTUHdOYk9JaVlhNkJI?=
 =?utf-8?B?KzVobzVaNERscGsrbnlDMVJCazAwSENzRnpnUHlJUmJZdW52cEdhSm8vb2VX?=
 =?utf-8?B?dXdhV3Y4UEhsejBoQlRpT0p3OEcrZ1RKRHptVG54Q2ZxWU1OQVEra0xvNjJy?=
 =?utf-8?B?eFlzb0pEd0NRV09oUzlrYUZ2TjhXWHJUVmxwSkh1dTNadnA3SlRzazRmYUJJ?=
 =?utf-8?B?d2hBNFVDOTRWN1Q3SG1YTTZXU0R1eXRkY1oyaU1ibGsrNlZXZTNzeE5zNDRI?=
 =?utf-8?B?TytGbGZtSHcvczhUaTZkbEZ1ekF4R3lrbUFhbWVMaHRuclR4MVRKMlI2Q0p5?=
 =?utf-8?B?SzhvRHVQRnlJa1BqaWpUUHUzQXBjdlpnMEhoUko5bE5oMVcyUFFXZVJndld3?=
 =?utf-8?B?dUVWQmpKSlVRdGV5YTlJWTBqeEFFODkwRjhkbDN0cE9ESFBEU1RYYVZ5U21I?=
 =?utf-8?B?ZHh3ZWJFdVhzVlc3T1pMRE1XOS9saFNLMThjWXJDZExZeWpjWGUyb0hVL2Jk?=
 =?utf-8?B?Mnk5MUVXZVFrQ01TY1laQnZvaHhLSXhnZUdBY1p4cUVJS0M3MUNLaWtLZitL?=
 =?utf-8?Q?Q/5Be7S3iafR7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f23dc0-c207-4951-08b9-08df42eba8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2026 07:40:02.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9777

cmFpZDVfcmVtb3ZlX2Rpc2soKSBzZWxlY3RzIGVpdGhlciB0aGUgYWN0aXZlIG1lbWJlciBvciBp
dHMKcmVwbGFjZW1lbnQsIGJ1dCB0aGVuIGNsZWFycyB0aGUgc2xvdCBQUEwgbG9nIHJlZ2FyZGxl
c3Mgb2Ygd2hpY2gKZGV2aWNlIGlzIGJlaW5nIHJlbW92ZWQuIFJlbW92aW5nIGFuIHVucHJvbW90
ZWQgcmVwbGFjZW1lbnQgdGhlcmVmb3JlCnNldHMgbG9nLT5yZGV2IHRvIE5VTEwgZXZlbiB0aG91
Z2ggdGhlIGFjdGl2ZSBtZW1iZXIgcmVtYWlucyBpbiB0aGUKc2xvdC4KCnBwbF93cml0ZV9zdHJp
cGUoKSBzdWJzZXF1ZW50bHkgcmV0dXJucyAtRUFHQUlOIGZvciB0aGF0IHNsb3QsIHdoaWNoCmxl
dHMgb3BzX3J1bl9pbygpIGRpc3BhdGNoIHdyaXRlcyB3aXRob3V0IGZpcnN0IHJlY29yZGluZyB0
aGVtIGluIFBQTC4KCk9ubHkgY2hhbmdlIHRoZSBQUEwgbG9nIHdoZW4gdGhlIGFjdGl2ZSByZGV2
IGlzIHJlbW92ZWQgZnJvbSBhIHNsb3QKdGhhdCBzdGlsbCBiZWxvbmdzIHRvIHRoZSBjdXJyZW50
IGFycmF5IHdpZHRoLiBBIHNsb3QgbGVmdCBiZXlvbmQKcmFpZF9kaXNrcyBhZnRlciBhIHNocmlu
ayBoYXMgbm8gY2hpbGQgUFBMIGxvZywgc28gc2tpcCBsb2dfbW9kaWZ5KCkKdGhlcmUgYW5kIHN0
aWxsIGNsZWFyIHRoZSBkZXZpY2UgcG9pbnRlci4KCkZpeGVzOiA2MzU4YzIzOWQ4OGMgKCJyYWlk
NS1wcGw6IHN1cHBvcnQgZGlzayBob3QgYWRkL3JlbW92ZSB3aXRoIFBQTCIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFlpbmdqaWUgV2FuZyA8eC1wcm9mZXNzb3JA
b3V0bG9vay5jb20+Ci0tLQogZHJpdmVycy9tZC9yYWlkNS5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWQvcmFpZDUuYyBiL2RyaXZlcnMvbWQvcmFpZDUuYwppbmRleCA0NTVlMzZkZGNlZWUuLjQx
ODgwMzc0MWM2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZC9yYWlkNS5jCisrKyBiL2RyaXZlcnMv
bWQvcmFpZDUuYwpAQCAtODQ3NCwxMiArODQ3NCwxMiBAQCBzdGF0aWMgaW50IHJhaWQ1X3JlbW92
ZV9kaXNrKHN0cnVjdCBtZGRldiAqbWRkZXYsIHN0cnVjdCBtZF9yZGV2ICpyZGV2KQogCQllcnIg
PSAtRUJVU1k7CiAJCWdvdG8gYWJvcnQ7CiAJfQotCVdSSVRFX09OQ0UoKnJkZXZwLCBOVUxMKTsK
LQlpZiAoIWVycikgeworCWlmIChyZGV2ID09IHAtPnJkZXYgJiYgbnVtYmVyIDwgY29uZi0+cmFp
ZF9kaXNrcykgewogCQllcnIgPSBsb2dfbW9kaWZ5KGNvbmYsIHJkZXYsIGZhbHNlKTsKIAkJaWYg
KGVycikKIAkJCWdvdG8gYWJvcnQ7CiAJfQorCVdSSVRFX09OQ0UoKnJkZXZwLCBOVUxMKTsKIAog
CXRtcCA9IHAtPnJlcGxhY2VtZW50OwogCWlmICh0bXApIHsKLS0gCjIuNDMuMAoK
