Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793824080;
	b=Azn3kh6Tj6skaxdbehdMWrL7oRM6sVu0VKVZM6HzWB4ZlZTyDy2SBSti2ZE8mLBUBGLx
	 Sl95huNyA9uKn4s+v2BzfGnw6PlRNgF/eOZcRdv8HmjnlJEpEKOj/KBuaKWQ5piM4dH0S
	 XGi0gq09MIOZAnwaWcsn5V02uw1p7GVKJU85eUoxarfftSg6ZFm63nCxPg5K+ExPRTvHN
	 IZ//gK8zdFyb7YKH37hcm/iGal6L6BaRAix3p84IkPu8E9W7a+JuK0n2I5Oi61U7GNDqa
	 1NQNye0bYtvmUwaSVzFh5JeimpXReTZd/OLCahr9VncugdbkcdZWSESRZMuOCjB/UfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824080;
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
	bh=dTjkVB5RoYtyU5ZIfnEn3sJq5VVDtOlESxajFX+sXH0=;
	b=Dcd0PIGFcUJbe3riuqshj1pYK4vuGm4THcU6LLR1ycNAOUjI199en9F0KIGybR+6T/nw
	 sNRNPKSWie5VM+joBufs1dAzdM7SfTs1X0GJ9VrL+zsJoaqE0qGZUDfoluY/ubp8GDhAc
	 p0EQc7fyP8RgZ9YeXZxpyhaT2bbWifWAQK1jhU/HdpLMimHGpzkzq5AgxJuPTCdcYS+uF
	 l94grFpQxk3EtPsT7+ArgBV9A62GY+HENiLVMOkOfbRmCSRjFIKobgw97a7sFWqH9hn81
	 qbu1UFpL2Pu6QEQWhZJ7Aun0DV7fG8hpQz2MXf2NDGpLjXCxZQT7MwihuHOHpPFqnMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HJU9FVvb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.66
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011066.outbound.protection.outlook.com [52.103.23.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F46070AB5;
	Wed,  4 Nov 2026 20:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53F46070AB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HJU9FVvb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrmvmYlaQtFgK7J2PSNT0xkD09Ee8a+x/ZygA55QrUdzoPAadCmScT7zKKeeI0E9z8ONXIw++s1h3ypkvqr85ozedjE1/gz8bFI3k45ze/z+qjWYmfGtgC/y2b9HBwW8BP5urafakgJS+xj96k3WHkFSF7IZLC61nbU+788LSo3bUe22kRNpJUq2pY129xGlUeuP5Bp4c0SWSLdvVSFH3DQvG1mNfsH1kukupDlbWf18euvYw5+oAFgNPjNBR+rrc2g2mNv4v5mPuBladUVJ76jNVhIMZ1GSgDvHAWiTsK8YI6xL30j9o1mYrb7B+SmwgRXSGMsTmaVrtn36PqQwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTjkVB5RoYtyU5ZIfnEn3sJq5VVDtOlESxajFX+sXH0=;
 b=O4TjaJ32RmvLCp2U9igOy8+TyzgR2f8rpuQ3OLvmyoCdgqxRpSnNJfMW4ubUCiGzX6vCZk5FOYXUfIMujfi5D+aR2aUszSazpZ6DN+o6Z1Dcf3p0VtqeVpk5VL1MRosNCVElL7htQ4MZSpliH/xwQS1U2LRnR6R2Kr7rxGB1aOGSUmE+bxPBRJpqGKR+ywTCdS1tcjY/x48N4uZ20TXjLfv8C01/+Cb0XDeb/3tdFSxXC3nDku42i19jR0s+TtgdlO0zSeiKSvQUWMnznNq5+sDC8rAy6LXwW90/j3ZaQd7Xou1uNlX1fUrXcuW697mNqEV0toMd/kSfhh7tTHXa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTjkVB5RoYtyU5ZIfnEn3sJq5VVDtOlESxajFX+sXH0=;
 b=HJU9FVvb5P88DO1D260Hb2KgnYAwj5UcdmgKX2foLE5rEx6xLSgP0MQ45Ec9KsWUzQgDzSLvkXB5VZpOe0hBWNPLhEa7krI3bJlkVzcwI0AOSbFwq132TcsWVJ4BDERH+rudfXA4EoO5bO63QWNTi72/P41xi8r4j593p7QekbSsIA/IxcVp7UDMhHN95c6HHFWlXL6JOIBaoGu05rrGVn/CyUeuFDg/h+bUsmk4Vlml0/+bJ5NJ0rWdfQlOYvz2qFFTQVJFROdx75wjIDxQhvMAwjuSgQ/2Sy5U5rSrSEdB5BLhCSEFBkOrcN0q/9/qBroOZvFKX68calA2RjkAQQ==
Received: from DM6PR02MB6860.namprd02.prod.outlook.com (2603:10b6:5:21a::13)
 by CY8PR02MB9449.namprd02.prod.outlook.com (2603:10b6:930:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:27:57 +0000
Received: from DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0]) by DM6PR02MB6860.namprd02.prod.outlook.com
 ([fe80::4eb9:6d6c:3973:e0d0%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:27:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Claire Chang <tientzu@chromium.org>,
	Konrad Rzeszutek Wilk <konrad@kernel.org>, "Giorgi	Kobakhia"
	<gkobakhi@asu.edu>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Thread-Topic: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Thread-Index: AQHda6sVxPkkJEjXP0eh57b+lSuFRrcc0ESAgAC2+gCAANdccA==
Date: Wed, 4 Nov 2026 20:27:56 +0000
Message-ID:
 <DM6PR02MB6860F74E39AEB3BC94483C34D4682@DM6PR02MB6860.namprd02.prod.outlook.com>
References:
 <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>
	<20261103155016.1107958-1-m.szyprowski@samsung.com>
	<MN2PR02MB686381EADCEECF16B23214D0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>
 <8276a107-7115-48e3-a40a-2660fe1beaa5@samsung.com>
In-Reply-To: <8276a107-7115-48e3-a40a-2660fe1beaa5@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6860:EE_|CY8PR02MB9449:EE_
x-ms-office365-filtering-correlation-id: 28d8e8f0-82cf-4ab6-4253-08df3ab21c9b
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8062599012|15080799012|31061999003|25010399006|24021099003|55001999006|19110799012|8060799015|37011999003|51005399006|41001999006|1602099012|10035399007|40105399003|102099032|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWU4QXc2TXBqdVpWVmd6UXl6OHpKZDBnSU9zblQ2eVFySW1VT2RSUkpqaS9U?=
 =?utf-8?B?cURSR3BXSDl0elV5UGcwOFZPbUNQeCs3Wkc0SjBnVWtiY1JUSEZGa3lHVU5D?=
 =?utf-8?B?eXdpSXhTVkUrY0x3T01hNXFJeVpyeTJ1Y0p3K09Sc0ljMmY3b1BEMmwrVDZa?=
 =?utf-8?B?VzRJc3dJbldlWnNjb1hwSFQ5Nlhubi9RQThXRFJ1Q0xFTXMvaFg1aGpETHA1?=
 =?utf-8?B?cWlrbXNoZVRFaHdtendSaHBHdTdVV3hlMEhEaUlRVENKNCtYcjVML01YN1Z4?=
 =?utf-8?B?Zks5aEJiUEM5d2tYR2x0WmxBbHFTUG1idW9INElWN3ZQZ2g4MHZLSnM2Tlli?=
 =?utf-8?B?OGl4d2taZ0RRYnVVNWYzOGp1M1FQeDFWYU5CQUJVMEdCS3NMQmZ4S3NQbnFw?=
 =?utf-8?B?UEZZbkwzVWRUYm9TNXJscE16NDJhbXZPcVlHUVhWTG5Ibml6NlpPY3lyN01U?=
 =?utf-8?B?TW1lZ2VXT1lzd2JLVWd2b28zWW9SeFNGVkdKUWt3SjdIVGNCdSsyZHIwUlFX?=
 =?utf-8?B?SzNSbjk1L1oyYm1Bbk5UKzdqWlpNZjA5R1lJQ3NUSkJRbWdMMDJoOFBZSFhp?=
 =?utf-8?B?Q1p3elduVVo1TGpKa3RDOXlkUm5HanRZMkVPSTBQZ3A3Tm5ZTDdINmMvMW5Z?=
 =?utf-8?B?Y0FZbzFlUlp2UzZHc1ZSQlhJNlpnSm5mZkx1MWpYNWx0K0hlTFZKSFBkNHJV?=
 =?utf-8?B?akxRdEpkMENhd1o0cCtKK21Dbk52Z3VZMUlUclpUdjNGOFFRWUh2RnNDOVBv?=
 =?utf-8?B?UVg5RGZJMmlvTkhsQjBHN3k5TGFueXZZMzJReStjY0RPbWVCTjErbEpXbWFp?=
 =?utf-8?B?RVZweStGb3YxUnYyQmtoVjJKdUxVVzRNR3YrRDNSbW1La3NtZE1UbzdkYzZB?=
 =?utf-8?B?dVVzUEFxcEcrQjgzL2UydlZYd01CbVErbkI4UFJBdHVwVmZoMDlPYVR5UzU0?=
 =?utf-8?B?RFlMYmU3TllCTlFxcUNuam83bW10TWNhQXdMNVNvZWZzcm5OMmNyYXVrV1gy?=
 =?utf-8?B?dUtHdlN5eWlJRjU1ZEMreVEwcjFoaGhrK3o3UEJLWkx1MDdmcXBRRjR2MXE0?=
 =?utf-8?B?NmExd0p0My81NWlpUHU4M2FuT0tXR2x2YTYxSncrdnZGODJSQmFyQTdrN0sz?=
 =?utf-8?B?QU9SVDB1QnVSMVhuZFltaGphRTJmWUJzUklDWldLSnFtUFBxUCtESW1TVW1B?=
 =?utf-8?B?cG0yU1JLRURwaDlFU2xScWpDNjlNWlZiWkZxTHJEVktXMG5nbHJpU2hXMGhs?=
 =?utf-8?B?MEx1VHpNd0hmRTI2ODAra0c4M0ttZTlBd2NmNHR6aGFQMjh4VXN3b2pVZDB2?=
 =?utf-8?B?ZHR2cGhiVzZ3SW8rNVloVW5WeDFGYmliMFJyRWV1NG9obWJwaFBzME8yVDJn?=
 =?utf-8?B?OFNYT2FvK3l5eFNRVzg2UEtuMERYeXlUWVFsMjZnQTROVTlKc3gzL3RIb1NO?=
 =?utf-8?B?V2xsN0hKMmNObGwrMUpET3FGSmlWbzdFTlA1c3Q1aElTaWdHbTJpN3VUUlB6?=
 =?utf-8?Q?YnWyIE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFFHeWJVbk0rMWU3U3ZaK0pjTUtOb1FLRWtPa2ZSd3JqeFZqbWZyNmxUZGdX?=
 =?utf-8?B?M3Izek5nbEVLL3pwTGJSNmZrb3h3czI3VGVSWmQ4UHZnczZGZVpvNzFsdG9D?=
 =?utf-8?B?U0ZZZTZ1Ym1UV0haZTkyakxMclF4OVd0Y2ZNOXZjd0dPQVlqV3Y1VE5OaS8v?=
 =?utf-8?B?TTRyQXJka1cyd1NaWjIwdGNJUkVZT2tnQWhRTEFNbG5yOWovQVdDeVRjY2oy?=
 =?utf-8?B?ak0yQ0UyMEl3TEJQOWVEUUVnUFNTL2xvMEJPQk9iZk02YStJS2xadGF3R3RX?=
 =?utf-8?B?VlQyK1V0OE90WFV4eDBlWnViM2tBdS84dThvRnZndzY3L0RnN3Z3c2NGZWtx?=
 =?utf-8?B?bmVXMDRlZUNWdHJDUjFlQ1IzNDdOMVovNmFCd01FTkNoeXVkT3oxc0lndU8v?=
 =?utf-8?B?aExvZHFMMUN0azZWdnBObmdveFhnWmtpTmVvcEdlcG90aWFZMXYraXBoRzF5?=
 =?utf-8?B?WjlEVDJhY0NVWE1jRXpVdUVvbi9QUmJFM00yU0F1RmNUdFJxcUpPRS9xM0Jq?=
 =?utf-8?B?Z053Sk10ZDBjdk9WaXRnRUM4R2tsOFdCc3MyUzAyc2pjN0RhNDhtRnBMbmNa?=
 =?utf-8?B?VmNPT1laVUlqbXpJNTB3MTRnNTRGclg4RkJibGRlWFBUTFFFeGNWSXlqV3px?=
 =?utf-8?B?TmYvZHBiZ29iRmY0L2FQZjJncFJKdUxpMHEzWHo1bGhleTBQZXF3SjhTYnhJ?=
 =?utf-8?B?QmtyUHE1ZlphaUhUOU1GSEZwcHhFcGFMOXZNMzY5Y0pubFhWSFF4TGFFT0FU?=
 =?utf-8?B?ZUYrdDVVc2lmN3lUbStjODlBYTJ4SDNmcWNIZFZ0UTZ6T2ZSWmYxMmpXaVVI?=
 =?utf-8?B?M0xWYVlpcTZCaE9tVEJ1YTYwYS82bEpPQmZHRFZLYzdyNVZmQ3Azb1U0aXoz?=
 =?utf-8?B?ZXk5Yks1YzJRYU1ObW1IdEZYRktjOGhPUjNPQUJVTm4rZzE5OU5NTEhWZTlN?=
 =?utf-8?B?bTJ0Z0dVVmNzWTBGVVdFcWpCRU8rSHZWTHJKS01YVWVndW5mNGViWVd2czAw?=
 =?utf-8?B?VkkyMGJrZFZmRkZjSGNRZVErTGQrSGxZUWdyb3pPM0grdjVnNkQvbzU5Z0h4?=
 =?utf-8?B?b21SZXlxRXd6SENpSzkwaU85NENRVXE5cUZXVXMzOS9odkRHMi9KT3FQUGow?=
 =?utf-8?B?NGRjZ1ZrZnNzcU1IUzAzUWM1OXhTd0VsdFBLNUJqWTdiQ2ZSRzlqT1MrYk45?=
 =?utf-8?B?SGlUZ2tkV2hlUWVxbkFIMk1KMjZLV1F3anVGbXpHeVo0OG5mNldWMFd3ei8x?=
 =?utf-8?B?Z3paaDR2NlNhYUlFVjQyZ3IwRXQ0NXJGVlNpOHplL0s4LzZ2c2FXMDJHaktK?=
 =?utf-8?B?enhqT094TmM3b2N3ZE1Bb2hYeERmSkVuRkRISTlpNDJuY0Q4Rk9nRWdzMmho?=
 =?utf-8?B?amdiZ1IxSFdDb24xY0JMMFp3UDdhM0l1OTFybW83V1JyWXFneExTNGZzQjVM?=
 =?utf-8?B?c1lBWVFXRzJOM0tENFA3V1B0VFJTZ1ptZStYWUFXS0dUa3dEUi9BWVJ0aDB1?=
 =?utf-8?B?REc4djF2UkV4YlBkRzNyNyt2T0JGQVkvaWgvcjZjQnAyYUY3ZER3VmNvSlA0?=
 =?utf-8?B?eFdVelFaVDBpVHhoQjYwUmsyWFJ6YmhiQ2VyeWZ3d2JnenFweTJSQ1FueUFF?=
 =?utf-8?B?b0dadzR4MnoxRDM1bUhRNTRPSE4rbjM1dU51ZElnVlJOWjVFbW8yN3ZnbkNY?=
 =?utf-8?B?OWNDSHZPNWxaeGlpVTU3SDVuSGt5Q1dlVlI3SUNVa3BhRXZobUkvN0M1REtw?=
 =?utf-8?B?cS9Nd0dKUmFKRExlMEdPNTBsRmYyTS92bUFsMGdoK3IvbzhPTlMxMlN6V3Bn?=
 =?utf-8?Q?8neV3L3AJz8brCsR6RM5Kx1J8C25i5MxTzf1w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d8e8f0-82cf-4ab6-4253-08df3ab21c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 20:27:56.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9449

RnJvbTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPiBTZW50OiBU
dWVzZGF5LCBOb3ZlbWJlciAzLCAyMDI2IDExOjM3IFBNDQo+IA0KPiBPbiAwMy4xMS4yMDI2IDIy
OjE4LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBNYXJlayBTenlwcm93c2tpIDxt
LnN6eXByb3dza2lAc2Ftc3VuZy5jb20+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjYg
Nzo1MCBBTQ0KPiA+PiBBbGwgb3RoZXIgcGF0aHMgY3JlYXRpbmcgYSBzd2lvdGxiIHBvb2wgZW5z
dXJlIHRoYXQgbnNsYWJzIGlzIGEgbXVsdGlwbGUNCj4gPj4gb2YgSU9fVExCX1NFR1NJWkUsIGFu
ZCB0aGUgc3dpb3RsYiBjb2RlIHJlbGllcyBvbiB0aGF0LiBTaW5jZSBjb21taXQNCj4gPj4gMGI4
NGU0ZjhiNzkzICgic3dpb3RsYjogQWRkIHJlc3RyaWN0ZWQgRE1BIHBvb2wgaW5pdGlhbGl6YXRp
b24iKSBhDQo+ID4+IHJlc3RyaWN0ZWQgcG9vbCBjYW4gaGF2ZSBhbiBhcmJpdHJhcnkgc2l6ZSB0
YWtlbiBmcm9tIHRoZSBkZXZpY2UgdHJlZS4NCj4gPj4NCj4gPj4gSWYgdGhlIHBvb2wgc2l6ZSBp
cyBub3QgYSBtdWx0aXBsZSBvZiBJT19UTEJfU0VHU0laRSwgdGhlIGxhc3Qgc2VnbWVudCBpcw0K
PiA+PiBwYXJ0aWFsIGFuZCBzd2lvdGxiX3JlbGVhc2Vfc2xvdHMoKSByZWFkcyBtZW0tPnNsb3Rz
W2luZGV4ICsgbnNsYWJzXSwNCj4gPj4gd2hpY2ggaXMgb25lIHBhc3QgdGhlIGVuZCBvZiB0aGUg
c2xvdHMgYXJyYXkgd2hlbiB0aGUgZnJlZWQgYnVmZmVyIGVuZHMNCj4gPj4gYXQgdGhlIGVuZCBv
ZiB0aGUgcG9vbDoNCj4gPj4NCj4gPj4gIEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBp
biBzd2lvdGxiX3JlbGVhc2Vfc2xvdHMNCj4gPj4gIFJlYWQgb2Ygc2l6ZSAyDQo+ID4+DQo+ID4+
IFJvdW5kIHRoZSBwb29sIHNpemUgZG93biB0byBhIG11bHRpcGxlIG9mIElPX1RMQl9TRUdTSVpF
LCB3YXN0aW5nIGEgYml0DQo+ID4+IG9mIG1lbW9yeSwgYW5kIHdhcm4gYWJvdXQgaXQuDQo+ID4g
SSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBtYWNybyBzY2VuYXJpb3Mgd2hlcmUgYSBkZXZpY2Ug
aGFzIGENCj4gPiByZXN0cmljdGVkIHBvb2wgc3BlY2lmaWVkIGluIERULiBCdXQgSSB3b25kZXIg
aWYgaXQgd291bGQgYmUgYmV0dGVyIHRvDQo+ID4gcm91bmQgdXAgaW5zdGVhZCBvZiBkb3duLiBE
VCBoYXMgc3BlY2lmaWVkIHRoYXQgdGhlIGRldmljZSBzaG91bGQNCj4gPiBoYXZlIGEgcmVzdHJp
Y3RlZCBETUEgcG9vbCBvZiBhIGNlcnRhaW4gc2l6ZSwgYW5kIHJvdW5kaW5nIGRvd24gZ2l2ZXMN
Cj4gPiB0aGUgZGV2aWNlIGEgc21hbGxlciBwb29sIHRoYW4gd2FzIHJlcXVlc3RlZC4gQ291bGQg
RE1BIG9wZXJhdGlvbnMNCj4gPiB0aGVuIGZhaWwgYmVjYXVzZSBvZiBub3QgaGF2aW5nIGEgbGFy
Z2UgZW5vdWdoIHBvb2w/IFJvdW5kaW5nIGRvd24NCj4gPiBhbHNvIGFsbG93cyB0aGUgcG9vbCB0
byBlbmQgdXAgYmVpbmcgc2l6ZSB6ZXJvLCB3aGljaCB0aGlzIHBhdGNoDQo+ID4gZGV0ZWN0cyBh
bmQgcmVzdWx0cyBpbiBhIGRlZmluaXRlIGZhaWx1cmUgYXQgZGV2aWNlIGluaXRpYWxpemF0aW9u
IHRpbWUuDQo+ID4NCj4gPiBXaGF0J3MgdGhlIHRyYWRlb2ZmIGluIHJvdW5kaW5nIHVwIGluc3Rl
YWQ/VGhlIGRldmljZSByZXN0cmljdGVkDQo+ID4gcG9vbCBhdCBsZWFzdCBhcyBsYXJnZSBhcyBy
ZXF1ZXN0ZWQuIFByZXN1bWFibHksIGJlaW5nIGxhcmdlciB0aGFuDQo+ID4gcmVxdWVzdGVkIGRv
ZXNuJ3QgY2F1c2UgYW55IHByb2JsZW1zIGZvciB0aGUgZGV2aWNlIG9yIGl0cyBkcml2ZXIuDQo+
ID4gVGhlIGRvd25zaWRlIGlzIHVzaW5nIHVwIHRvIDI1NiBLaUIgbW9yZSBzeXN0ZW0gbWVtb3J5
IHRoYW4NCj4gPiBleHBlY3RlZC4gSW4gYW4gZW1iZWRkZWQgc3lzdGVtIHdpdGggb25seSBhIGZl
dyBNaUIgb2Ygc3lzdGVtDQo+ID4gbWVtb3J5LCBtYXliZSB0aGF0J3MgYSByZWxhdGl2ZWx5IGJp
ZyBwcm9ibGVtLiBJIGRvbid0IGtub3cgdGhlDQo+ID4gc2NlbmFyaW9zIHdlbGwgZW5vdWdoIHRv
IGp1ZGdlIHdoZXRoZXIgdXNpbmcgYSBiaXQgbW9yZSBzeXN0ZW0NCj4gPiBtZW1vcnkgaXMgYmV0
dGVyIG9yIHdvcnNlIHRoYW4gdGhlIGRldmljZSBub3QgaGF2aW5nIGFsbCB0aGUNCj4gPiByZXN0
cmljdGVkIHBvb2wgc3BhY2UgaXQgc2FpZCBpdCBuZWVkZWQgZm9yIERNQS4NCj4gDQo+IFRoZSBt
YWluIHByb2JsZW0gd2l0aCBlbmxhcmdpbmcgdGhlIHJlc3RyaWN0ZWQgcG9vbCBpcyB0aGF0IHRo
ZSBtZW1vcnkNCj4gaGFzIGJlZW4gYWxyZWFkeSBhbGxvY2F0ZWQgKHJlc2VydmVkKSBieSB0aGUg
Z2VuZXJpYyBvZl9yZXNlcnZlZF9tZW0NCj4gY29kZSBiZWZvcmUgdGhlwqBybWVtX3N3aW90bGJf
ZGV2aWNlX2luaXQoKSBpcyBjYWxsZWQuIFRoZXJlIG1pZ2h0IGJlDQo+IGV2ZW4gYW5vdGhlciBy
ZXNlcnZlZCByZWdpb24ganVzdCBhZnRlciB0aGUgb25lIGJlaW5nIHByb2Nlc3NlZCBieQ0KPiBy
bWVtX3N3aW90bGJfZGV2aWNlX2luaXQoKS4gVGhlIHJlc2VydmVkIHJlZ2lvbiBtaWdodCBiZSBz
cGVjaWZpZWQgaW4NCj4gdGhlIGRldmljZSB0cmVlIGV4YWN0bHksIGJ5IHBvaW50aW5nIGl0cyBi
YXNlIGFkZHJlc3MgYW5kIHNpemUuIEluDQo+IHN1Y2ggY2FzZSB0aGUgcm1lbV9zd2lvdGxiX2Rl
dmljZV9pbml0KCkgcmVhbGx5IGNhbm5vdCBkbyBhbnl0aGluZw0KPiBlbHNlIHRoYW4gdXNpbmcg
dGhlIHByb3ZpZGVkIGFscmVhZHkgYWxsb2NhdGVkIHJlZ2lvbiBwYXJ0aWFsbHkuDQo+IFRoZSBv
bmx5IHRoaW5nIHRoYXQgbWlnaHQgYmUgaW1wcm92ZWQgaXMgZnJlZWluZyB0aGUgJ3dhc3RlZCcg
cGFydA0KPiBvZiB0aGUgcmVnaW9uIGJhY2sgdG8gdGhlIG1lbW9yeSBhbGxvY2F0b3IgaWYgWW91
IHRoaW5rIHRoYXQNCj4gcHJpbnRpbmcgYSB3YXJuaW5nIGlzIG5vdCBlbm91Z2guDQo+IA0KDQpP
SywgZ290IGl0LiBUaGFua3MgZm9yIHRoZSBzaG9ydCBlZHVjYXRpb24gb24gaG93IHRoaXMgd29y
a3MuIDotKQ0KDQpBbmQgd2l0aCB0aGF0LA0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxt
aGtsaW51eEBvdXRsb29rLmNvbT4NCg0KPiANCj4gDQo+ID4NCj4gPiBZb3VyIGNvbW1pdCBtZXNz
YWdlIGFsc28gbWVudGlvbnMgIndhc3RpbmcgYSBiaXQgb2YgbWVtb3J5Ii4NCj4gPiBXaGF0IGlz
IHdhc3RlZCBpbiB0aGUgcm91bmQgZG93biBjYXNlPyBUaGUgcm91bmRpbmcgZG93biBpcw0KPiA+
IGRvbmUgYmVmb3JlIHRoZSBwb29sIG1lbW9yeSBpcyBhbGxvY2F0ZWQuIEkgd291bGQgaGF2ZSB0
aG91Z2h0DQo+ID4gdGhlIHdhc3Rpbmcgd291bGQgb2NjdXIgaW4gdGhlIHJvdW5kIHVwIGNhc2Us
IHdoZXJlIHRoZSByZXN0cmljdGVkDQo+ID4gcG9vbCBpcyBnaXZlbiBtb3JlIG1lbW9yeSB0aGFu
IHRoZSBkZXZpY2Ugc2FpZCBpdCBuZWVkZWQuDQo+ID4NCj4gPiBNaWNoYWVsDQo+ID4NCj4gPj4g
UmVwb3J0ZWQtYnk6IEdpb3JnaSBLb2Jha2hpYSA8Z2tvYmFraGlAYXN1LmVkdT4NCj4gPj4gQ2xv
c2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjEwMjYwMzIwMDcuMTk1Nzk0OS0x
LWdrb2Jha2hpQGFzdS5lZHUvDQo+ID4+IEZpeGVzOiAwYjg0ZTRmOGI3OTMgKCJzd2lvdGxiOiBB
ZGQgcmVzdHJpY3RlZCBETUEgcG9vbCBpbml0aWFsaXphdGlvbiIpDQo+ID4+IENDOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dza2kgPG0u
c3p5cHJvd3NraUBzYW1zdW5nLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBrZXJuZWwvZG1hL3N3aW90
bGIuYyB8IDE1ICsrKysrKysrKysrKysrLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9k
bWEvc3dpb3RsYi5jIGIva2VybmVsL2RtYS9zd2lvdGxiLmMNCj4gPj4gaW5kZXggMmM1N2I0OWFj
N2MwLi5hNjhmMzUxOTI1ODIgMTAwNjQ0DQo+ID4+IC0tLSBhL2tlcm5lbC9kbWEvc3dpb3RsYi5j
DQo+ID4+ICsrKyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+ID4+IEBAIC0yMDA3LDYgKzIwMDcs
MTkgQEAgc3RhdGljIGludCBybWVtX3N3aW90bGJfZGV2aWNlX2luaXQoc3RydWN0IHJlc2VydmVk
X21lbSAqcm1lbSwNCj4gPj4gIAkgKi8NCj4gPj4gIAlpZiAoIW1lbSkgew0KPiA+PiAgCQlzdHJ1
Y3QgaW9fdGxiX3Bvb2wgKnBvb2w7DQo+ID4+ICsJCXVuc2lnbmVkIGxvbmcgYWxpZ25lZF9uc2xh
YnMgPSBBTElHTl9ET1dOKG5zbGFicywgSU9fVExCX1NFR1NJWkUpOw0KPiA+PiArDQo+ID4+ICsJ
CWlmIChhbGlnbmVkX25zbGFicyAhPSBuc2xhYnMpIHsNCj4gPj4gKwkJCWRldl93YXJuKGRldiwg
IlJlc3RyaWN0ZWQgRE1BIHBvb2wgc2l6ZSAlenUgaXMgbm90IGEgbXVsdGlwbGUgb2YgJWx1LCBy
b3VuZGluZyBkb3duIHRvICVsdSBieXRlc1xuIiwNCj4gPj4gKwkJCQkgKHNpemVfdClybWVtLT5z
aXplLA0KPiA+PiArCQkJCSAodW5zaWduZWQgbG9uZylJT19UTEJfU0VHU0laRSA8PCBJT19UTEJf
U0hJRlQsDQo+ID4+ICsJCQkJIGFsaWduZWRfbnNsYWJzIDw8IElPX1RMQl9TSElGVCk7DQo+ID4+
ICsJCQluc2xhYnMgPSBhbGlnbmVkX25zbGFiczsNCj4gPj4gKwkJfQ0KPiA+PiArCQlpZiAoIW5z
bGFicykgew0KPiA+PiArCQkJZGV2X2VycihkZXYsICJSZXN0cmljdGVkIERNQSBwb29sIGlzIHRv
byBzbWFsbFxuIik7DQo+ID4+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4gKwkJfQ0KPiA+Pg0K
PiA+PiAgCQltZW0gPSBremFsbG9jX29iaigqbWVtKTsNCj4gPj4gIAkJaWYgKCFtZW0pDQo+ID4+
IEBAIC0yMDM0LDcgKzIwNDcsNyBAQCBzdGF0aWMgaW50IHJtZW1fc3dpb3RsYl9kZXZpY2VfaW5p
dChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVtLA0KPiA+Pg0KPiA+PiAgCQkJbWVtLT5jY19zaGFy
ZWQgPSB0cnVlOw0KPiA+PiAgCQkJcmV0ID0gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVk
IGxvbmcpcGh5c190b192aXJ0KHJtZW0tPmJhc2UpLA0KPiA+PiAtCQkJCQkJICAgcm1lbS0+c2l6
ZSA+PiBQQUdFX1NISUZUKTsNCj4gPj4gKwkJCQkJCSAgIChuc2xhYnMgPDwgSU9fVExCX1NISUZU
KSA+PiBQQUdFX1NISUZUKTsNCj4gPj4gIAkJCWlmIChyZXQpIHsNCj4gPj4gIAkJCQlkZXZfZXJy
KGRldiwgIkZhaWxlZCB0byBkZWNyeXB0IHJlc3RyaWN0ZWQgRE1BIHBvb2xcbiIpOw0KPiA+PiAg
CQkJCWtmcmVlKHBvb2wtPmFyZWFzKTsNCj4gPj4gLS0NCj4gPj4gMi40My4wDQo+ID4NCj4gQmVz
dCByZWdhcmRzDQo+IC0tDQo+IE1hcmVrIFN6eXByb3dza2ksIFBoRA0KPiBTYW1zdW5nIFImRCBJ
bnN0aXR1dGUgUG9sYW5kDQo+IA0KDQo=
