Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679273;
	b=MJuiadJSTsp0Aih0O3xj8aNbqvrkPq50NYQTxM5765d06QUwJGZf39UKty7yGt5zhdWl
	 KSfkKfNbiNFDSFKs6ZnM/QaPvxrQIVSpW5Gza/44L9GmFWc+mivqgfG9/Uh4Gv6HvcbSm
	 UYE+zyuLgV0w+ulnKvmR2sP1NC4Acr6ZwDBYoma8VdTkvPjZrV6EYJui2D9WB7dEA0xAD
	 8AzzRpe9ecW6XBfQILDY1E05HbycmU0RHGpYPVjXNEFvZm8liCZnd9H0SyUFLk5O4iF/2
	 Lq2mLuGOlTrUfiOBNQvitZ2oshEd96Clz14m4yJsPjglGiQgVUQh9dG1IJtj4//oLJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679273;
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
	bh=y8JsNGLsv+z6eMkkBuyMNY1ZWQadWSaATqd38tPFbMc=;
	b=n2nBnL9dunuXlzRJ1eRlXBrQGfJY92BmDhfj9mIa/BuEm6lYLMivLtR/M5pxywi6BBE4
	 BRETG36g6+CC6weM0rgM5L1ZPE7zUfu7RCeSsorm6FpQDcoQaDrgbbvTfkSQDYt+WBskW
	 9bFS9yVmGsXIJY/fOjc7S/jHetWrd9CCKQhq06Mfc3RtOgGiYW+LjCES0bs10Ba2H/4td
	 Ir+7BTRthGG7a1R1OFR61wt7fRhVNnP0G2bHr4WG1vWeRRk2Iyu2+5s1oL7x/Vgh2r/gg
	 izLMoLuJv6/rj/n7y6aHTxuDIe+7mjA1FPvfO8/Ol3AGCRQIg1e+Xx4BNMfykwCN3Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="HLSNFlv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010006.outbound.protection.outlook.com [52.103.20.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08969606A31E;
	Thu, 26 Nov 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08969606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HLSNFlv/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBjjXknHUhuQOidCX7EL/5CJR+Xo9lmbf+tufutq4NbnJNx8YwHEihLUMygi9KNnJB27BghJzJeRLkbywr9bNxhz8NRLr5lFQK/y4Qz25luXcS8QvkdhPTu5GFboxD+jTIODaEKCmzQQpzgXwZOXXzLQXUc9zem6lj8gthGMwgVVlTHB6wZsJEf9dXKO7WaekryXecEf3vec9Zf1h3wwMKP2I9DAG3MewAXuXBBykvQ1bATBNzLZ8urgLyf8DX4ja2NDjaaEnRsWKqBIWkDr5TV8x7lLdkxWKltnJAJ99gjy+j/naR1kvmNcPGFy1grSTMA8x2gzpcfPQ6Ad4fhqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=y8JsNGLsv+z6eMkkBuyMNY1ZWQadWSaATqd38tPFbMc=;
 b=GndOppd2Uqa+A93wOnpT9dQIfQj2jeR4u5I9UGwPtVhxdSVhedemBawiH7TBl0JW+9pMaf7xVe/CVhyPmujrUoSEHU7YsebxcDCzRgRcfkiYuO7FD5D79XxzbU4V/e8JT3VMN3sz5MnmD25zUQp0196JjuYa/U0CmhvuJql0C1udv7qIixLHYkgcL09UvejBs3/aD83elZZ7cAZP/w9AzVng+DBAVemhBYZF2cxF78tX6n4D161BkmBbM0fSh3JVGkDU6wSi8p9T7A55SlxIq2CygJ2TdwQ4n3MTj91FuUQS++T+9xppBix2FRvOeQrxYqhUFh/Klt4rIA3g6d0wbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8JsNGLsv+z6eMkkBuyMNY1ZWQadWSaATqd38tPFbMc=;
 b=HLSNFlv/Lgq4dFEi/t1G1bOr6Io9ejlgZw5Ez5/xNUrbDdwbYJ0Ez8G0D5R24tI/DPAG4SNrWsqRrPsTqwaFyTh3s4s3RvKR0Urhjy5k7VCv4FKmK2I9S49Tw+s4cxZfRNRnRx670JYPbUFliOoPrbhHpeTpy6xNurelEYKXIV6/69PoL7qH3HNsnKDrmUeb5kbQadoyeq7s7KJN5+VK3WlJgbbJiaYOMY0KdlGSc+n0i8DU46I1U78TqJFaX4NfIyljQD+QaLtD5CNzcuDMRFPlrSOWz1NmK2JdMgR13nc3iulPpeBqFX31Pscg0cuHWUB+HAh0d5H5o6LoFAindA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA7PR05MB998597.namprd05.prod.outlook.com (2603:10b6:806:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:47:50 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:47:50 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 0/3] null_blk: validate configfs values before power-on
Thread-Topic: [PATCH v2 0/3] null_blk: validate configfs values before
 power-on
Thread-Index: AQHdfXpvhWuZV+umt06ERV6ctl2a5w==
Date: Thu, 26 Nov 2026 07:47:50 +0000
Message-ID: <20261126074748.1076774-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA7PR05MB998597:EE_
x-ms-office365-filtering-correlation-id: 4d2ddd4d-5e9a-4521-b8c4-08df4b91926c
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24121999003|15080799012|8062599012|8060799015|22091999003|5062599005|25010399006|31061999003|38102599003|19110799012|24021099003|4302099013|3412199025|440099028|102099032|1602099012|10035399007|52005399003|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7LoMsosDyN1lT96u3rgcD+7VCGYuqoE8dfxcAb304oiCrS+gfWAqcmuxyf?=
 =?iso-8859-1?Q?HaLYsF52mMV0P7pziEXK3n8iM9Om9xfbC1VrhFd7xA8poUptn8w/cct13B?=
 =?iso-8859-1?Q?hpUNXc5/S9UqOy9VZ75jWBcqfEj5/0YZv82ElueX/qTWb7FL8xPx/EaskD?=
 =?iso-8859-1?Q?Nkh0Yaa9q+KlNeNQn2pAo10XNBmmabigbdTDSw2/9anS8QItGzPN3anWtj?=
 =?iso-8859-1?Q?KbR7IcTdJY63gl7CPOFD/d8yN92AjYYhjbhOA262kvxGUcB0/PIrZ3+4u/?=
 =?iso-8859-1?Q?e/bzsXYXT1T5I88gvbSB7beREDf8XztFNFmw6isSljTEZA82kTbIvdHmqk?=
 =?iso-8859-1?Q?Z/VveQZa8U2gKB7wXyUIJHPsIBcjABY4sc0QYo4/sW59zC314vN0EuDmHi?=
 =?iso-8859-1?Q?+wEVTcDFRo5bz+ve0JfxAHPbiynIl2MlBtOfrSS6wuNq+Xcc6e1sEQmCVa?=
 =?iso-8859-1?Q?UVQgFhczulGPddOfxHCX7t+p4n60zgDxLTh1P/sGlEFpBHXcnlcHaGXtTq?=
 =?iso-8859-1?Q?UZC6JKUtqEkGCoEwtWm2nqlingCFSJc5I6xLtveXYoaXrfdDy6MZgBnIHA?=
 =?iso-8859-1?Q?1fIW76gB9asqw5+XHF0pLOrMluASqerAAAxeLKjNmP72SI0fsNGa1OGi0Z?=
 =?iso-8859-1?Q?Lddz2iKdeJpQgOB7tSjwKXpOOkqoqhxoz/o4VbO44bLjol608tMqHuQyN1?=
 =?iso-8859-1?Q?0xL9I1SGX42kJPyH7nwzCz4HsycABGE+qnDcOAojaSHurVhPtHDMfbWMI2?=
 =?iso-8859-1?Q?tM2OgoVue56vwWYt2fTFspSiCyeHvgUnOhFkWx79mwfybFPlPHS08PRlhW?=
 =?iso-8859-1?Q?Ocak4D7qGskqqZboiUmY4XrwiIrOoCBctrhayq0latXTXyoU1QJjXr/fAl?=
 =?iso-8859-1?Q?5sVeD81EmMMuV/N9//kpXjxygIw026EtEVX3xrIC5jrNTTl4xPQQwafUFS?=
 =?iso-8859-1?Q?g9vZ5To0h3a31C5YWDK9SCGlwq8x3OR9RJ5eRlCmuf2tTOequoBBkfynjz?=
 =?iso-8859-1?Q?VggFFhiCRNA0RH8/Oxszh26RCEiLI5kObH/3tKFgCm9xU89zRU4nWe4j05?=
 =?iso-8859-1?Q?7vReLyfVlxeD+RPNiANQTY9qPCYeU/Kqp8nNCDEEVgDHVyRteRC8pReo6i?=
 =?iso-8859-1?Q?TnAicCA8hqqBhkL+3OYa74lw9HCYBF9mpnyYCyhRsSIabIC1tl?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?esTbYyYDR5sj7LnY34rd1NBj6mJGJfLNhiLavtAcXcRvaRPqKvFhOzbFEo?=
 =?iso-8859-1?Q?H2BUeH41yVy1m9B7s0AKd/5rXlPTodDBEMNJ5fqornK4cxbq4Fw5CGdP0G?=
 =?iso-8859-1?Q?yerei+Jfa4h1f+8hkXqvAhwKwdfW9yiYdF5Y6EjDpc2pfwBMHknMjnkeap?=
 =?iso-8859-1?Q?OG9FrKGP9uaiTUjEbRn1X2loddmjD/nbybukAK41W6B00CsLKuVr1WxZX8?=
 =?iso-8859-1?Q?f8ro4HFe8u/ot0OzRNWcRDTJCLqdHi0LFJe5GM+wViSSPxs0OSwEkadOa3?=
 =?iso-8859-1?Q?Q71LwIWt89haceYBZFb/1RWsch9B01iw7rCeOOncGp1cEiCRFCRaYi/VGN?=
 =?iso-8859-1?Q?yIk56xaz9qCUMBdJnHRXXG3Do3ViLCJQNZUvQU3jWFxDJzH+2EMuLUBcqC?=
 =?iso-8859-1?Q?eose5q2JY+QqyTXmrvsydBu38fG9D7pAWt5kYsvlfkfwBVfgFBeGhxBGKR?=
 =?iso-8859-1?Q?xqXOhNuGG3rRcz+Lk+leqQCFFUBt0MPZUFlc/sNlh0zRf60ukBdKwXlzti?=
 =?iso-8859-1?Q?yhtVH3o3JnmxPjuGkNjNpsH45KMngKuDnXYn1lbMaDz8LYAc9euibYrxOb?=
 =?iso-8859-1?Q?a6HSJfeZrUpAgode3FmdK6Ls2pap1k1L0tLhL15VZhba383HjYHj5TVM/D?=
 =?iso-8859-1?Q?7X38ucVWfveTXtylMNTUe0aIxxarKwwoE16gsVD6pxGZbRI733dW493KCC?=
 =?iso-8859-1?Q?gJmncbNf+h0RvLsX5v6T5DQLpkSTcsoszjKMsI1Q1QPW8ID5sDqU+DkJXI?=
 =?iso-8859-1?Q?M8lFo59TZ6K7p7R5h2Ni46HLtwERBE2/1pBtBpLvD8UWCjcm5V21FjNM9k?=
 =?iso-8859-1?Q?S0pSS6tqOzjUts0Mu9fvLkWM2/BmkNtYaWzIjzvATLrQYfPpqAzla5invD?=
 =?iso-8859-1?Q?p79nEtzUo9vt7DyAeQ68JvUAuiCN0W56u+vi/0UdwocxQ4BVRJpyHGonc8?=
 =?iso-8859-1?Q?HYHIVcmdVjztv07RgMz5k6PQdStpu1r4sYWE3GxbPH1406kYcd5E1NXXDm?=
 =?iso-8859-1?Q?shxR1lfWKLvLgpgXiAzUZK/F3NGvNpK5kyLZ8svRuqDY0nSgnU7eGTql2h?=
 =?iso-8859-1?Q?M+byhA6cUqeJq3ipGOuLIAXWrur7Wc6MuAoe7bQmPiN16nvn7rkSu5JzgS?=
 =?iso-8859-1?Q?SMOJJF9nzBYm4gGC/KcV17pBSUJvpA/htocCqyK1lu3ralUffOcIaaSyiG?=
 =?iso-8859-1?Q?zM9wkCfL/yhUzhJ/KsC02qpyiKqmzN3LGMrwaKCkuP3m6blcSyX6EI6o9P?=
 =?iso-8859-1?Q?lhB8/gJLCyaWWx2Yxdj7Tgh87sn0qAowJIrTDf9MsjQUFXJx5/pfpB3TJ8?=
 =?iso-8859-1?Q?SOTWIiDmjsMvj0jdiDpTyrAHC72HMhVhkiZSMKkbd5IGw03lCzPOwr9t0m?=
 =?iso-8859-1?Q?eflqJEUmAT4hJrn8oG3yygdcqQ+M/L0NGR7VIXcci+h09M5y3LglXundPH?=
 =?iso-8859-1?Q?SGEYTIBDcNvy2iP9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2ddd4d-5e9a-4521-b8c4-08df4b91926c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 07:47:50.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR05MB998597

This series fixes three bugs found while fuzzing null_blk's configfs=0A=
interface. Setting size or home_node to the values below and writing 1=0A=
to power triggers a crash:=0A=
=0A=
  1/3  size=3D2^44 MiB with zoned=3D1 wraps the byte capacity to zero.=0A=
       The resulting zero zone count causes zone_nr_conv to underflow.=0A=
  2/3  size=3D2^40 MiB with zoned=3D1 and the default 256 MiB zone size=0A=
       requires 2^32 zones. Storing this count in nr_zones truncates=0A=
       it to zero, leading to the same failure.=0A=
  3/3  home_node=3D2147483647 is passed to kzalloc_node() without=0A=
       validation, causing an out-of-bounds access in SLUB.=0A=
=0A=
The zone count overflow still occurs with only patch 1 applied.=0A=
=0A=
Testing used x86_64 with KASAN, CONFIG_NUMA=3Dy, a two-node QEMU guest,=0A=
oops=3Dpanic panic_on_warn=3D1, and null_blk built as a module:=0A=
- The unpatched module crashes for all three cases above.=0A=
- With only patch 1 applied, the size=3D2^40 MiB zoned case still crashes.=
=0A=
- With the full series, writing 1 to power fails with EINVAL for all=0A=
  three cases and leaves power at 0. Correcting the value and retrying=0A=
  succeeds.=0A=
- Valid non-zoned devices were tested at 0, 1 and LLONG_MAX / SZ_1M MiB;=0A=
  valid zoned devices were tested at 256, 257 and 512 MiB. Tests also=0A=
  covered memory-backed read/write, zone reports and a conventional zone.=
=0A=
- home_node values NUMA_NO_NODE, 0 and 1 succeed. Values 2, 63, 64 and=0A=
  2147483647 are rejected on power-on.=0A=
=0A=
Testing was limited to x86_64. Sparse NUMA node numbering was not tested.=
=0A=
The reproducers are available on request.=0A=
=0A=
---=0A=
Changes in v2:=0A=
- Add the missing Signed-off-by tags.=0A=
- State in each commit message that the bug was found by a fuzzer.=0A=
- No code changes.=0A=
=0A=
v1: https://lore.kernel.org/linux-block/20261126063404.1051061-1-x-professo=
r@outlook.com/=0A=
=0A=
Yingjie Wang (3):=0A=
  null_blk: reject device size overflow=0A=
  null_blk: reject zone counts that overflow unsigned int=0A=
  null_blk: validate the configfs home_node attribute=0A=
=0A=
 drivers/block/null_blk/main.c  | 11 +++++++++++=0A=
 drivers/block/null_blk/zoned.c |  8 +++++++-=0A=
 2 files changed, 18 insertions(+), 1 deletion(-)=0A=
=0A=
=0A=
base-commit: 5a29cfaf51105039d156dd8a61d2783e8b653667=0A=
-- =0A=
2.43.0=0A=
=0A=
