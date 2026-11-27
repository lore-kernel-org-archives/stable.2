Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795747567;
	b=k/F7fnNAGIxh7cH0uBAuiBE9KK0E5cshWbQIjFLX2zhC7TqWs95oi31xjOI6Rr3gKSz1
	 /klXQdPelXXG0WaprG7UPDJBEKY/I4AVyLbAdl4Z3qle2qmLA3yU3vMlQl+9NWYicjEtH
	 Fy7m15kHnMr9tY3QFAessMPT3fTBqO8yV5uAWt2SlkYK0YUm/M54BgMyx/iDl36VExGEG
	 y8Qn8yh5/HxvztD5//XYw/i6mqXUgRldReLMu/B4GRfV2i0ZSAHG3fYmFnc5URbRCb6pn
	 xDnr/xX5bWWSd/7Q2YjhTHyfeTZjZ2C8JibZAJXu+oH5KXQTPVwj3xhKFW6I5eUgasQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747567;
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
	bh=eYZnOp+EXQ4VdZckZnmnmheD0wRxbDUbv/wD1qtPWSo=;
	b=nC+2YISro/3lPvD3BTQW04YV76l0ht44NMVdT6Br5oLq4xrlfSD5IfMF/67jUI2T6dVo
	 h3a4XncDFvVEA+rUGT1m6cScy3623wtE0NcnOxUOv83g/6u1YLSmIS/ygR6CCU9tykgmy
	 IGtbT1OIw4fuiZ2y5KbMoha83IgrymvQhExBcBkjvOCA0mBMXFHP2nJLoaLsZbf8P4YQy
	 AfzrHAcyqVYEo0NgBdVe45/N1k8nnQeKGVxp+kGXNTkhErUBA6E3vHD6U+CgaiWXSc7Fe
	 aoEy7ZCO869YO+Ukwt2od8GTI5/J0KqS5m+jIVYILcdymE3MXHsEKB+8DUVkrgjZUKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Gdj+EdNy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.3
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491E606A31E;
	Fri, 27 Nov 2026 02:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D491E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Gdj+EdNy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqQcPS3LSKrZXvLn/73ol+nX8mGKr/CD9dMjTNyNXEYLpdnu7WJ+SiJPnwMu5miFlHTByFn+iR6KyGnxPnUTRrDc0uqnCYsL28WzNCsE8ZesHoEDc3mIHNNUBTPQ1vSZCwzVwEIjYCSuTqCT0dSUEHMznBVv85vDZklbn27PJ+CjHpsuavBH2qVA7NNtBH8vXGDRysirn/3d5wocDVbcnsylZT0GuHAN1ZJeaITij+JkHQDxDogdf84fNVqE6+IFrJtMufpkzULCxKkCRipdIbFKeJVMYO08wv4fnFmZvOqzq17Kd1DFjUrShDDI/9Ovo/Wb8esi3xnyi5c+LpMRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eYZnOp+EXQ4VdZckZnmnmheD0wRxbDUbv/wD1qtPWSo=;
 b=BucsSuOGBOr3kQNTu19tYYz47M9exfJlZmetkNVJ9p8uH2NQAvYl9WwFz6UYyEeWTm2RmxdskBwV61cqITizpMitg+i7/+hP8KsPEadmYUcQmwJtK7WAt9FTY0RsRvEpTlFss0R7iGjqC0Se0Y7Enz4+V6msME2ModaJQ2RRmx018F3H9g0P6Ez1JlIVa5HNFvALfysh/Nb20kPJ/Q0CsIOV1R7616fMDueXO41jMaCQJd4MVfXjdR+UlSrLyPApCaC6J/u6tjRk0zBp8CTsOrljH4psw0gSHkx+l5AYYrUYyAgVSlhOrxCu3uhSOCe0l9eP6q4GPpi8gGW4PP2sPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYZnOp+EXQ4VdZckZnmnmheD0wRxbDUbv/wD1qtPWSo=;
 b=Gdj+EdNycuYVLLU7Z0wwcKn+GfTKKRySK0hr4NXwhQRNrCcmABok3wr/cECnnaXZ+lYQFaFQE5BpPoSDpp3DdrDPFqwkSdCKOftdi8qNhV+bXDyKEMHdJPDQ0O9TRrXjX4ZQ7neKMgGJ1ngjfDjGhCch0Yhr0j0R09HkOtAI0EG6QzKBqTQkHtx7/zJezxgALYMW2QyT5TiGPYAk54wrZSMpj4HRvIcYDY+ekReZCpJWAnJRKkSDfMeqlrauEN1HiAR9j/nSVg09aH7EnKTJaOw9q2X6bIyul1t97yIphadp3CyZrSQRLO/DpQfTy7WeogYkLQtQDXYmlmqnj3H3tA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by IA6PR05MB650064.namprd05.prod.outlook.com (2603:10b6:208:5ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 02:46:04 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 02:46:04 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Damien Le Moal <dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] null_blk: reject device size overflow
Thread-Topic: [PATCH v2 1/3] null_blk: reject device size overflow
Thread-Index: AQHdfXpwHq6E43PHjUqgYKzEhECFag==
Date: Fri, 27 Nov 2026 02:46:04 +0000
Message-ID: <20261127024601.1465996-1-x-professor@outlook.com>
References: <20261126074748.1076774-1-x-professor@outlook.com>
 <20261126074748.1076774-2-x-professor@outlook.com>
 <fa532123-2fcf-4236-90c1-a47d5438502c@kernel.org>
In-Reply-To: <fa532123-2fcf-4236-90c1-a47d5438502c@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|IA6PR05MB650064:EE_
x-ms-office365-filtering-correlation-id: ee1dfcca-6f7d-4a9f-903b-08df4c30948b
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|25010399006|4140399003|24121999003|8062599012|22091999003|8060799015|31061999003|38102599003|19110799012|15080799012|52005399003|40105399003|26121999007|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DgbxDnwsZQx0lO0QXk65bDN6m+Sbg8jHNmie+8pDgFKry32PpUv4/c6SUw?=
 =?iso-8859-1?Q?TjK8QYsuSSHwenPPtzvtUdXH7oac21CwaHPJq3fUqC4Hj0VpXOTl3GgSZy?=
 =?iso-8859-1?Q?k/0XZAHUM9UUyTxc5P+JYeO4dkvnBA65SRZ5V/t9EQCJH3jWY3b6aovBL7?=
 =?iso-8859-1?Q?g7qePzQrwQlo9IHpO2BpQl9l8iP5IX20MmjlPitmBHucxVsDlfxrIi8P4P?=
 =?iso-8859-1?Q?DI+xQy3mSg7IRTp1vYDObXf+c/lrcAoxP1LK2Kj9tSMMxJWcpQQisQcTlV?=
 =?iso-8859-1?Q?sDLUbGIapZ7xj9juauGCvLqYJmpIVWsQqL0mymd85o3PVwPw7ImnJF2k0s?=
 =?iso-8859-1?Q?yoo9Bto+O1M4M2Tu+xqDiPfXunVZiaAAx6c+ASFxKlZ9GKLopeSZzmP28r?=
 =?iso-8859-1?Q?utXjZuGaCZOA0nIjzYPor4o+Y4AYUB7TaOHS6KJYhedXQnN0nmpKuALowb?=
 =?iso-8859-1?Q?WGACzZhWENdL70SKDySYXKk/3ssh4A8sbEMblC11uxC2hkJdFAfA0Wyckr?=
 =?iso-8859-1?Q?fIEnjYq+rielr2Iet53k7EnrxYPfWHmNgGBUBUaTthjp5z04BrgyZ98RA2?=
 =?iso-8859-1?Q?oUjWJd0IVCqhJ78OkZ+IKmizytcQppgK5SeQrwk997KX8mBXJkkpbbRosg?=
 =?iso-8859-1?Q?DppPqQIUTrZxrl7WCeKeDEfUbLMIBZvrD/l89gHdAKzDFjcKuqOSuBvtKv?=
 =?iso-8859-1?Q?K0wKiGoJ8OOexY9jBtTyike/k40yZJz5IyOJ/K1gA7rt0z/nmxWolpm94P?=
 =?iso-8859-1?Q?hrsniW25tf1/M9KikQY1m38efT8TEE9AHzOVt78ONsTfdWFD9s5d3DC2gE?=
 =?iso-8859-1?Q?fnzP+kiEzi9Z1ckWzH9roIKWRliV9EVBMAre9fePTTjMANlGUB/No53uSA?=
 =?iso-8859-1?Q?QPdWLCjrGv3qVnuKaJLVTqLK9ENW4WSe+zdCC8EXZW3CSwIN9rk+wx140C?=
 =?iso-8859-1?Q?HEDgtbYIzAn3k5yzYoqbZaIGkZsp0+caMlj742akPgJwhEEN1yjdIKvb8c?=
 =?iso-8859-1?Q?Hi+Ig2doB9DmfD4JSRCdW1/uewzCjEvVBbauMB9kZ9wHDEenxwa03Foz4I?=
 =?iso-8859-1?Q?xXYsWkk04QelbY02ZWy8mitP5yw8fMvZtYsv4Eo/93No?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0TUgGdgHjy2wXHJWEwYhlZMnkF092Hw2CPon3nHNv+5DiEWJ+dLl8sGojs?=
 =?iso-8859-1?Q?uwIv+dfNQXBJ3tc8jX/AM7JkBZLwQoBbFM78p480nDxRvOH/+jzMB1O2g/?=
 =?iso-8859-1?Q?qYDguotlE7HGMTcVxqZgtnLw7wKt/lrWWtObgAIsHTTNvM4h7FbIvz92nT?=
 =?iso-8859-1?Q?x7Ar+BwYaxdXrUgeY4xJcuJV0411ir1QwAB0iJgY9UPFlD3jKhPnqnon5O?=
 =?iso-8859-1?Q?Cf+4pbbU4oHDPsTjVH+iEyHCfj8DBnpDoonB+QpvbccfqTZD+FMFUx6/9/?=
 =?iso-8859-1?Q?a5V/2omVuKef1FLzvdiubqcQ6u82K4mAya4evZAQz3KtDyaFEsPXENM0wO?=
 =?iso-8859-1?Q?+5ksJTKfnRo+BWt/DkMmMrjaX9fIUBC/gEK+NIweSdhAJlpCHcCZpFsNBn?=
 =?iso-8859-1?Q?oKY9XERN3ZzVCViNDVn+zoVBaDqiW/PdAr0/tD2UO9YJxqfBe801M/TT3o?=
 =?iso-8859-1?Q?jvbjYvhUZ5YQgfgZa6vZuJavvHYE0I1vhlNPFw4by9oJ2C8f7mQbOkggb4?=
 =?iso-8859-1?Q?Cw7AWA41lLwBuZzR8M1KkE6sgb+V9R9b4HDV5yTMT+VR4JjANbRGGrV/za?=
 =?iso-8859-1?Q?2AmzZAPsJGTy3goKO+AnhDXqGpzjzrDacltfK+5FeaOOkx9H7qg6u8Zfas?=
 =?iso-8859-1?Q?2Bx9cwRhW6qijH3ivn31Be14snxx9Ki69KeWD7f0tdF+lpbih+htbkhHdq?=
 =?iso-8859-1?Q?ztYXEgmcOmgRGsv4422NmONJlZiDvrhbAKZY3nH5lD15dF2Dt/hckWJhAQ?=
 =?iso-8859-1?Q?qqIRkHM18BqDpF8wHurE5rt2V5gKc5+ehwHtlQRsaKyDr4OgT4g93OalCo?=
 =?iso-8859-1?Q?ue0LBrrn+9BLXkz+I2SVrzU/f9zQBp857K6lqndKkZIdJ2klyO3odCRW0h?=
 =?iso-8859-1?Q?oplbbLguGbP1cG/X1rgZCu9ZCsOQsLeWGlXb6fsRygIJUHREUjvP3EIA1B?=
 =?iso-8859-1?Q?0R4e9aGwaIsLli249pzwnrMPE55C//L+gDZjU/0OCTYM/HQFrKX1upMIcf?=
 =?iso-8859-1?Q?ppKSMypEOmOGZeevkbPXEiaH6eriaSZyAgFZ6wbXgC1YIXBpHDZFt7Cfhg?=
 =?iso-8859-1?Q?wuaj91W9Adcs3xMFUpQ6DFOPvrBj01pNz78nKUelU4pQ6uzb8vcCX5ydo6?=
 =?iso-8859-1?Q?X1CRmpmQxjXmSj8BTKx8VFO2hB6wR3Tm8sPvYMR4TJ1sYcTaZwhmfwItQg?=
 =?iso-8859-1?Q?EJFWS3alQLXcw1vef9wdZqnvV7ifrIlaiQJ2KgkrbXBMqj9PdAhN3d6XLn?=
 =?iso-8859-1?Q?g1vWVoKXEqjIGp4oea/mx6jvPFFYAvdVXvV9cqYu6yZYOX5cEw83atQtIM?=
 =?iso-8859-1?Q?yH6Kqe2rpfBe8lE+q52qvmBxxNl6uBazxUk8/LgdKWMqYXU0dGxIaqYFwX?=
 =?iso-8859-1?Q?tcCK1miCC54nwi/1bIc0UtIN6q7ipXPNpV9sMhWWUo6VvNxpa/WBDxXF7v?=
 =?iso-8859-1?Q?LFFkbII6msx00Ram?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-AuthSource: BN6PR05MB3281.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1dfcca-6f7d-4a9f-903b-08df4c30948b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 02:46:04.4065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR05MB650064

On 11/26/26 16:56, Damien Le Moal wrote:=0A=
>> Reject sizes above LLONG_MAX / SZ_1M in null_validate_conf(), before=0A=
>=0A=
> Why not ULLONG_MAX / SZ_1M ?=0A=
> Any particular reason?=0A=
=0A=
ULLONG_MAX / SZ_1M would avoid the wrap, but the block layer cannot=0A=
represent a disk that large. A block device's size in bytes is a loff_t,=0A=
and set_capacity() truncates anything above BLK_DEV_MAX_SECTORS=0A=
(LLONG_MAX >> SECTOR_SHIFT) with a warning. With a ULLONG_MAX / SZ_1M=0A=
limit, null_blk would register a disk smaller than the configured size.=0A=
LLONG_MAX / SZ_1M is the largest size in MiB that fits.=0A=
=0A=
I will add this to the commit message in v3. v3 will also compare the=0A=
size as u64, because the kernel test robot reported that the comparison=0A=
is always false on 32-bit.=0A=
=0A=
Thanks,=0A=
Yingjie=0A=
