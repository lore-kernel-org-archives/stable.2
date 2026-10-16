Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013042.outbound.protection.outlook.com [52.103.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6F20B80B;
	Fri, 16 Oct 2026 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119659; cv=fail; b=a1JOydRWR3+kTVDpgerfuNA//zWM1X+4pf751Rek59ihiUP0l9KCh8taQJcyH3MqRpq5PjaTgXn+BND/VHp+/7nz4gwdcggr4O71NPD7/59niU7fGxR1EN4o45c6+HIRPmBlmYDTcxn4KIUVUSS8/VUhASAPMs2q4S6B0wyF3Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119659; c=relaxed/simple;
	bh=H+xMI2WjLIly4jS/NH4vQIckPfgpgu3/vWSdfM1+IAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5OoNAyDRFpFyF1BGSYK2wKBEOSvNoX8nZP6/Sy463KlHwCi3H7niVkXPLy7UeleQuNICZRP20F6bpsM9OF9ukW30btgQS/K79XOWOvFcilrmx7ZQBq1IjPl0/YyIfM6nJGeibS+qkuZfDdMpKPh/lO/tBEgquWVzq9KZMcJejw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Iox7dxdv; arc=fail smtp.client-ip=52.103.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Iox7dxdv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leSD5lxATqxaTgP2pyRGKphsNz8XnTuyPkSqx/sZubbxmppaWjpH1QZ9X8qW4J/Nhz4SmBVQsersbE9CVwQM+ML+P2wmj3Suz5MelReKAbsXcTuuHfBh9k54DpRlSufSrez88m1dcqcROFIjGPBBpcQ7R77FlS8v0LIJF503t2z655JTxnFpdO5VcgkVEhmtubNMWxt7XwpSOriB6oVBU8+hsJ+gEbicRhcVEF0ub5vtawHzVi++UZZV6fM5TnLq/TNQwNoNPYT+O1MUaL/ULKNwD4c4O+G/nJICn10FamSfevsIKj6CtMQ1qKbWD1UvEdlWnapwRKy4UsWEsmuduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=H+xMI2WjLIly4jS/NH4vQIckPfgpgu3/vWSdfM1+IAI=;
 b=q9SRQbvDIUWeUgug5O+/PSRW1rUkudiuiBNKW+5IMW7MPViyVB74cDCYOFjo0Upa4WRTjraH+CvuqxCoM/4YMscwObYbxMSglt1cq8k8svoH/dO9sQLluAyAJyLDfceXJBvfG7b1mftBOrLPeuzgIO8OS9IHjM8daWAFpOLz9BmCzpURTegvJx3eVuFPW/pQ8WlHbgz6ui+y0Z+t93IGjP3BHsR8TEC6RqFx6rJcyFydkDQw0sdOM7goR+XWeriYffgwqhh3+0X73/rkP43274CriBsGLBgmqPaHJKHIAQk94EDUeDjGuoxcLTFuyyVB+lXygrnGFEjHscEYPs5WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+xMI2WjLIly4jS/NH4vQIckPfgpgu3/vWSdfM1+IAI=;
 b=Iox7dxdvzHQDRb2XVS+JVf9lIEU1ZKxumaCirYkxgkSaDe3S+wDW1v4pPr6Aj5HLcGr3wyC9K40c8JiuELxFHwn1O9OA5yE5zLdghtu+n+gDV2mw4CpymH0Zs7GJ7V/LNTeVX6sUA42mW0BqwpJHB6glekMxD32Pm3TwTwRrDP/eGUFlYlIXGj8IG3aY1Ai/r4L4ZoDyrNrPOtJl96dvph0JH07SNIdspTnBTTfK5zdzKCLQC4up1qcS+Zpf3Y/Z+MIA4F0bcvGpiJ3Bt6VU4FKmEVZHar5Tv0/0bWlgTN9MgMO7UmmVOdonLGiccLSgpsq2zxM87nBeJL7M7N2BDQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH0PR05MB8573.namprd05.prod.outlook.com
 (2603:10b6:510:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:00:56 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:00:56 +0000
From: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/4] nvme: release passthrough resources before user copyback
Thread-Topic: [PATCH 1/4] nvme: release passthrough resources before user
 copyback
Thread-Index: AQHdXRqQsBBgC3Sa7E6wRUJE0BuNBA==
Date: Fri, 16 Oct 2026 03:00:56 +0000
Message-ID:
 <6cae8c109686ff0fb71d4b69767f9abeb45be74a.1792118770.git.x-professor@outlook.com>
References: <cover.1792118770.git.x-professor@outlook.com>
In-Reply-To: <cover.1792118770.git.x-professor@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH0PR05MB8573:EE_
x-ms-office365-filtering-correlation-id: f36b4a24-d19d-48c7-5dce-08df2b31b2c8
x-ms-exchange-slblob-mailprops:
 7qh87CJt6y1mqZO6407WRLxlypE3k+ej4g57AZDi8FHU6+d+kbyLaZp3YzPlKJiBG44VYoGizdQ6N9UmloWgBAtaKOAc8baugJLwliNG6shtfgjEJsHlMEHq/UmBV7mg0xYNkIPkfEYLohD0mzHOY2APkBw54xGBhEZNusxVl79+8FYAfns03YLXOjX50RIhTw+YISbY0KnGKCOTFm179syfOKdVJR8Ol2TpFLRYMn/DLYygDhAywVxO/CpsHGUPLcTlnXSYyx3yFQnlYw+5genoAargG8dYpWSxU9fbjsS/fZPt0aDRVv2du5EviIlySTtgFbYhu698t+mxD5/tdX5AH0He0SVCM5+34eLP6HjXcVrJDpnWDRMxtAlLQUDlbcpIP5RdNplCWt7sUYN4DsbFSQSyZDZ2280gjKKivV2MR3asxuikMg85te6H51uRs+IqVvRVb/LZhKuxb1VtZgFlmDyq0bHZqt89iOL42O0esv+02DLYgHmejpFYxTNhkrYzcLQfYAmkYQKxH+e+6W6JjIhqY8dCTz+FRrF2bOrJkxN7wfPi4xNZnwdFCfBL2gBE0Ogkk7iw9RFRePVlXNBC+RLpPmUoymLcwpj8WbVi6MKkARBwlf8wLFuy1M80MdSOF8c6Rj2x5m21BAEmRay1bDesHXwNXU79VxdCme03OC0GEzsEvTDJLIvuVN3cl0Kr+s1e89eVgJKihbjedKm32q424zIjKvVW8Hd1HovYD659yzrBK8KBDAAro0+W
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8060799015|19110799012|4140399003|31061999003|6050399003|41001999006|8062599012|38102599003|51005399006|15080799012|40105399003|12091999003|3430499035|19061999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXprWm1RUi9aZDB0MHJXeVlHWklBVVNtd0JvSVdISUwxU3A1Z3VrRjhYTkNm?=
 =?utf-8?B?dm4wRkNEVmM3SkNHS3hOOXdpUk8wNi9wOS9lUHRWcW9naDZlNFk4ZEpLMkpG?=
 =?utf-8?B?ZVp3emlESWZETWNnY0I5bENZa1JRcFdLWVZORmZmM0cyZXJTY3RuM0hnRlBZ?=
 =?utf-8?B?Rlc0MFAzTkcxTnZyUmdjcnBXZDBSYkFtUmprTGtKTkpDMERlTzlpYjhTc3Y5?=
 =?utf-8?B?QUJkM3pzVjVURjFvRnBxTis3dCswSG5leWVUbjNRTGFiNEMwb25pQXVSNnRN?=
 =?utf-8?B?T0FuWXMyT2I3cDhNeGE1NUhTcTF3MHZFRTlscEdiWHdIZnk5d3UyWEg3bXVs?=
 =?utf-8?B?RHhMdWo0ZmFJWTdvTk41Si83RzdMbnR5QXhZcTNwdlhqWE9SU2xaUUpiMVRL?=
 =?utf-8?B?T2NFKzltVmg1UitJdlRmKytsUHZWMi9NUWp0b2NiSnBNaVMxNUdBaElaTlJw?=
 =?utf-8?B?WUxTaXpSa3MxeEgxVUYxKzNXbDdzaGpCODVQZUdmMWRKUmJRUXVDNXp0VVhn?=
 =?utf-8?B?ZmgwS3ZxblZYbjUrMVRkK3Q5TGkwRy9penN0NjlxbjdTN1d3dmFONzVMNSth?=
 =?utf-8?B?QXdTYmVmVlFFaDB5MDJzUWRGR1F5QWZvRWkwY3NjYm13N0NEWlZEVmtFTEVy?=
 =?utf-8?B?K0VGNWpuUjBkZVNWTFdRSXJseTZNRGhuZVpiWnRuZERyNllPbVg4cXFWR2VB?=
 =?utf-8?B?OENId0ZqbFhjelVKYXYvOStSbFdudFZ1UUwrYzRjSEZsNkI5SGNlUnNvSyto?=
 =?utf-8?B?OVZoeFdPR2xia2g3U2RwbnlKVjdDbkdnV1Vqa2I0a0gva0RhckVyZFhtdXFt?=
 =?utf-8?B?S1dKRlNoSElERVBTd2VxSkxKYkZTclJnZlBrT2RDUUFSMWlicTlNcVUxOThI?=
 =?utf-8?B?WFBCbzBZRndZQ3NnU2szbU5qQzNGa2lFMWprTjVtL2R0Vlkwc2xXck1PQ1p5?=
 =?utf-8?B?YjUvd2hSdVRIeld6Ti9ZNXl5NnJuZDZrcjBzZXg3MTNvR3NGUGxkY0FkaWM3?=
 =?utf-8?B?QStGRnBLVDF6L1ptLzRURlhGT1ZmZHhZSk9JOHpmbE1pM3MyUEp2d2Y3M2Y0?=
 =?utf-8?B?cUZzcXU4VzNDaTR5aVBuOXM1TVRVa20vNnZuMldQN0FJelBJRmNXMWdiN0ZJ?=
 =?utf-8?B?ZVU1WHo5YjB1RTN1NXd2WnR0R0JhMXpVVU82aGk0ZkRpb3owaDVBMmk1b3NG?=
 =?utf-8?B?eG51ZkhySSt3M1N4M0dhSWpyUnowbXlUTnNnb1cxRnFBRXFKR0hZdU9wTzNL?=
 =?utf-8?B?SEZUR0M4YTlaTS9MVjh0bDF2c0JpdklybS83cGdiUkJ2MitlN3pFZm0wQVF1?=
 =?utf-8?B?K3lxS0kxRjJZYVA0bXE2d2RCVS9DcDBRUEN2dHQrZ2hINWpOUEJ1WHRYUmcr?=
 =?utf-8?B?WHRZdVpmMVk1UVpZL2g4RGR4MHVvNUJPckl0bWQvSFBjOUhnbDhnMkpTZXVo?=
 =?utf-8?B?SzE4cGgwUWZXL3gyNElYNURnKzdKTEVRQmNYOHR3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWJkZklVQXBBaEdXTm5xejkydEpBVjY3RDl0UlRGa0xpT0dqT3hZc3h3c21U?=
 =?utf-8?B?NnZjZTh6QkJyc3FPS0VQWmJqTUVLdG1CU2JBVnZqQnJBQ2FPcmxHTHVrSVpS?=
 =?utf-8?B?b2tjNkl1a1MrdEt4UnZVOGhCL242RTZFRng4eFdSNFF3MjJzR2NzWGQ1cW9P?=
 =?utf-8?B?RFR2NlMxaW5jNXZWVlpTZ3UvRVpYNFRKVDhFT2gwY2ZKeTMvRE1JRjk1N3lj?=
 =?utf-8?B?NTNEc2lubXBZeVRneE1HY1FVN1MvSUJGUGt6alA0Tk1rLzZCbjExUFpzNEMz?=
 =?utf-8?B?eTNBRURpeWVXTy9SZHh5Y2c5em8wTVBQQ21MdVZqdUtNMU1haHQzcjdpY2NV?=
 =?utf-8?B?bW54Y2daMGNIMEVLek45c2VJNGFFOHpQM1RwVnpaWW4rMEdNbTgwYlFLREZL?=
 =?utf-8?B?UUR2eFBVTDRxbFg0b2IrUmUwNHdpL3FzZ09CcmpOSGZyT3p0T0NyVTBraG5Y?=
 =?utf-8?B?d0s5a3pncFBRbnIvUTBSL0dmeDRlNFh3ZDc4RFcwS0RSRGF6L2YydllXTTRF?=
 =?utf-8?B?c2t5bkRaR1IzNHc0eEFIS3Aycm50QUM3M0dhRzgxTE1SVnRGS2FGdklLOU1n?=
 =?utf-8?B?R2hTWW5odkJHbkVjSXlxYjhEdGZLYy9GOVVaYm9nVVhjcWpvc1hiTnFCWkI2?=
 =?utf-8?B?QmNFVW12ZnpuOHEyRXozNkJnZ3VtcDJkSlg5bGxmYmNnTnI2c055aGFvM2Rs?=
 =?utf-8?B?MUFOelR4eXdYWThXeVU4bE9MYkg2azFuN2VWaWZ4N1YrWFhURytWSzBDVGxu?=
 =?utf-8?B?cFFpNmpIU2NsZnJiTDAvWnp6WG9Mek9GUCtVWjVwaGdhd01LU29PRGdlR3NR?=
 =?utf-8?B?dG1aRFFjcERRb2VCdEpCOWRNZ0EzR0k1OUtmWnZmWmFuZkRJOXhxcEU0OHFp?=
 =?utf-8?B?TmtXVzZVMjZzY0NBaStpT3BGcyt6RE9CbUlJaXRDYjFzeFVxaEJWczFEdVRk?=
 =?utf-8?B?S2dMdDRpeGpPdEkwZVlGNVl1NUh5MHgxNkhYc2FVdFlrQ0k5ZWU5RmZiZncr?=
 =?utf-8?B?TGZmZzlzelVDUWlsSFdrMzF1NCs3ZWNWMURKQkhHK1k2Nnk2cWVJZnl2RDYy?=
 =?utf-8?B?N0J6S1Rabk5abExzcmwwN3diOEFnUzVKQTVZR0x5M01BZ1JMUVU2OTVtRDlK?=
 =?utf-8?B?bm1INWZYSlI2bTZicnU1ZzFxb2JMWkV6NWVkVXNnM0ZvbkY3T1RUT3VnbGc2?=
 =?utf-8?B?T0FVUHUwK3N1ajBVNktadFZWa1FlRFdHR2RPRzl4a2JtQXo4blU4Z0tmYjE3?=
 =?utf-8?B?NlppdnlNTGRpbmlVZTRtbUxRSGRveldzWHJyLzljOGsveGcvcG0vR2k3TnAz?=
 =?utf-8?B?VEJuUmpieDIwODVqUjlEZEU4d3JZNlJTZUMvclAzck1XVXMwR3FUb1RkRU01?=
 =?utf-8?B?MnRFbkF5MzdCdE85ZjZ6cnJveFdOdXlpdUZ1NExpc3M2WjllblJmNHhRRktJ?=
 =?utf-8?B?SFI3SXYwNGY1L0NwSlpOaEN3a2pzM1lJYU9kUGhrVWl5OEVHZ3hsNlA0K2kz?=
 =?utf-8?B?ZHpFWGFEcXpYV2ZDTy8vbmw2Tkd6ckFONS9HRVd4T3FBVTBRVVlkNU40K0xj?=
 =?utf-8?B?MjdkZFI2N0M1MnFnb2ZySlpmbjZWVnVER1AxM3NWeC9ueFlwNkxqS05LbHVs?=
 =?utf-8?B?dEtpTlNYaklMdE5sdTdmclhDcm9SelV3bk85L2NYamJVdHp2WFdWd2ExZys1?=
 =?utf-8?B?Vk4razRrR2xpQXVULzNROUtSOEIybldham9CYmpzK2VRZVFwVVFpV0xPUXk2?=
 =?utf-8?B?TmhIcU41NDdOQU9ndlpYWk1nOHJaUERTWkNnV1lyMlRUMmRuK2Q2UHpRemhK?=
 =?utf-8?B?MC9SQVAyVjg5VGZORUZwaG1TS2g5OHBxaVFIWUlsQ085aW1IdVlLamxMamt4?=
 =?utf-8?Q?/sDjRqIlVoykp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f36b4a24-d19d-48c7-5dce-08df2b31b2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:00:56.2337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8573

YmxrX3JxX3VubWFwX3VzZXIoKSBtYXkgZmF1bHQgd2hpbGUgY29weWluZyBSRUFEIGJvdW5jZSBk
YXRhIHRvCnVzZXJzcGFjZS4gIG52bWVfc3VibWl0X3VzZXJfY21kKCkgY3VycmVudGx5IHBlcmZv
cm1zIHRoYXQgY29weSB3aGlsZQp0aGUgY29tcGxldGVkIHBhc3N0aHJvdWdoIHJlcXVlc3Qgc3Rp
bGwgb3ducyBhIHRhZy4gIElmIHRoZSBkZXN0aW5hdGlvbgpmYXVsdHMgb24gdGhlIHNhbWUgbmFt
ZXNwYWNlIGFuZCBubyBvdGhlciB0YWcgaXMgYXZhaWxhYmxlLCB0aGUgbmVzdGVkCnJlYWQgY2Fu
bm90IG1ha2UgcHJvZ3Jlc3MuCgpTYXZlIHRoZSByZXF1ZXN0LWJhY2tlZCByZXN1bHQsIGZyZWUg
dGhlIHJlcXVlc3QsIGFuZCBmaW5pc2gKY29tbWFuZC1lZmZlY3Qgc2VyaWFsaXphdGlvbiBiZWZv
cmUgdW5tYXBwaW5nIHRoZSBiaW8uICBUaGUgc2F2ZWQgYmlvCnJlbWFpbnMgdmFsaWQgaW5kZXBl
bmRlbnRseSBvZiB0aGUgcmVxdWVzdCBhbmQgY2FuIHRoZW4gYmUgY29waWVkIGJhY2sKd2l0aG91
dCByZXRhaW5pbmcgc2NhcmNlIHF1ZXVlIHJlc291cmNlcyBvciBwYXNzdGhyb3VnaCBsb2Nrcy4K
CldpdGggYW4gTlZNZSBJL08gcXVldWUgZGVwdGggb2YgdHdvLCBhIHNhbWUtbmFtZXNwYWNlIGZp
bGUtYmFja2VkCmRlc3RpbmF0aW9uIGh1bmcgYmV5b25kIDYwIHNlY29uZHMgYmVmb3JlIHRoaXMg
Y2hhbmdlLiAgSXQgY29tcGxldGVkCmltbWVkaWF0ZWx5IGluIDIwLzIwIHJ1bnMgYWZ0ZXJ3YXJk
LCBhbmQgc3Vic2VxdWVudCBub3JtYWwgSS9PIHJlbWFpbmVkCmxpdmUuCgpGaXhlczogZDI5ZWM4
MjQxYzEwICgibnZtZTogc3VibWl0IGludGVybmFsIGNvbW1hbmRzIHRocm91Z2ggdGhlIGJsb2Nr
IGxheWVyIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKQXNzaXN0ZWQtYnk6IExMTQpTaWdu
ZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcgPHgtcHJvZmVzc29yQG91dGxvb2suY29tPgotLS0KIGRy
aXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qv
aW9jdGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMKaW5kZXggNjUzOWQ0NzUwMDkuLmU0
NTU3MmJjODdkIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMKQEAgLTIyMSwxMiArMjIxLDEyIEBAIHN0YXRpYyBpbnQg
bnZtZV9zdWJtaXRfdXNlcl9jbWQoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCiAJcmV0ID0gbnZt
ZV9leGVjdXRlX3JxKHJlcSwgZmFsc2UpOwogCWlmIChyZXN1bHQpCiAJCSpyZXN1bHQgPSBsZTY0
X3RvX2NwdShudm1lX3JlcShyZXEpLT5yZXN1bHQudTY0KTsKLQlpZiAoYmlvKQotCQlibGtfcnFf
dW5tYXBfdXNlcihiaW8pOwogCWJsa19tcV9mcmVlX3JlcXVlc3QocmVxKTsKIAogCWlmIChlZmZl
Y3RzKQogCQludm1lX3Bhc3N0aHJ1X2VuZChjdHJsLCBucywgZWZmZWN0cywgY21kLCByZXQpOwor
CWlmIChiaW8pCisJCWJsa19ycV91bm1hcF91c2VyKGJpbyk7CiAJcmV0dXJuIHJldDsKIAogb3V0
X2ZyZWVfcmVxOgotLSAKMi40My4wCgo=
