Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795676585;
	b=AtQ0TDnfa7NyT+gYkXBF37AnI64LZOiL+pWfDAK7zwuHEoV4wpNrjMQR73QxQk0j+eD1
	 s+Yw9pajp/BnqqD1oi27SvbBNpEH3FGph7K3iVnMeuAjt3yicl0o9/xznu0uYQw2YNNwh
	 bVDjtIRQFmcW63Jx9JHHMBcjUl6q+cbkXkMIZMynapjtvWd2nDiSu2z6GQykfI2NG4euZ
	 au9DehNzovJD2gLit9c+K9GEhN93gdbCXH5XwPTFU4ZlTpcYFkWIWlaS94cZHWGpnTTCu
	 87aC2ZU8y4eeZ20RJ7H+TywPvXWUR/46SMQN7Rj8XkGPwYtB3gcXRVHEs+9q+LBt0hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676585;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
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
	bh=PjRxwr+N9vMimirm9ba+Aa/eZ5JnwSlnx4Ox9Cy/nl4=;
	b=gwfGdCz0vq400Z4a+LWMrMmzFrnVtUShXUs5dOcjnO+y4tJvZaNMd9Jfr0YctO+qLQkJ
	 C2R2Y4VLM4JtbbkVObmeCACBCHguCEsew04EeEK+fdW794+Fwl5cQTdr37m7DDijrcLB7
	 /J53N9XZWEqaFLBWbys6gtzGd9MGD07bl8ljagyGTaHAHlGmSF3fJyXsT7tys+HAX9Cy0
	 Zj8K5fc1SfoFtCjhxZshY8jBxnK9Si5zUPh4+Si4Q+Csle3xOrdVOsnHKBJXdUAoy+HKH
	 T91wYl7C0Mno9nLJAM4dnQ7pjk9N/nRjGd07Vs4D0azVGuHTQPrsBLyDXeCIH2FSlxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ak52BoOz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.52
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6132606A31C;
	Thu, 26 Nov 2026 07:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6132606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ak52BoOz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpWXF+ESSH4DYbBuW0z/tEUe36GUgdwUHmRjT9w+i5cXaMYM/x04xHG4HMP7KDgf0UTNg0Y/dlA8lW2gGCe+fo2SFjvU179QrLEpIteVU/ljQWBjabTzQXlSiE0xkwWCQpXazSsUYJTjwths33oQH3pBO0PWdlCoTSJvmGMOMyhWIaZka+9yOL8ZL8al/uNpehnC5PgxOp46rT1I6c3Arj0Oq4bdMKpEHZm7lf8rnQyvkxQtBWm8P5kE2AcWOLqf8ibz0CZjnfUMvb/DzRjj/MHkCkvwaaGFBhz2A5JMdLILKG3JDgCHMcbbUrJer9kNQVoWTFgJ5lMjmwoDkwhP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=PjRxwr+N9vMimirm9ba+Aa/eZ5JnwSlnx4Ox9Cy/nl4=;
 b=FXoWd/X7a89Ro+BN5MU8xh1p0HsSy7fwdzVZnLNIeJCS8RUyUrxytnqK4hzXw20F4BrEKc1lkLaOaO3qDJckCXH6eZHVeefcjjLN1VPD18lZMxx0IRkIE85aha5bOyMsQS42sS5V6bcxb0EJvXK54GeQ9UgcXV0sCOUnmMBvruobQUNGCwUy9SqoR0B1mkcLmz922Ch2txHAyiLjEerqLeSmITW0iIUwOV1IQKL3bhoI4rGsmM90UNf8rblQDX7ECb5TKlvaumUejYgJ2uRLYFlUPm81SvWu3cJgJsdIE1yUXssxmwN5uTQa8ZQtdHQpaKCk/ffOAgPghFKq9b4OAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjRxwr+N9vMimirm9ba+Aa/eZ5JnwSlnx4Ox9Cy/nl4=;
 b=ak52BoOzdFugWCdtjxKkZspnsHyMuJY6L5HpmOjEQ+7eYEPYPuIfyd3v6kDTgJaXqmy52Rcy5PPN0aeWqXsJNcNyFqJ1OVxPDKLQUVgffXWx48SqFjGMan1NKK6+MnuBrE98gIzEJ+fEwVe7RFJeyc78IssIQbgn/eN+yngahsyt1ERx9DRCFGXEw40TnXl1dmPo8mTyL/ZE1iiZRg3MnL5blZ+ywYz1m5TMBMDGEEETVJaQl9JniPMAsy9TVe5Odqb+srC/AqRH4UZ/pohkBAUHruZfq0TBGPKw7R9gXZXVkEXQFEOXWZbP4OBpdbGE63SBYmYg2Gf3zIq4NWWulA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by CH3PR05MB9580.namprd05.prod.outlook.com (2603:10b6:610:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 07:03:03 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:03:03 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] null_blk: validate configfs values before power-on
Thread-Topic: [PATCH 0/3] null_blk: validate configfs values before power-on
Thread-Index: AQHdfXAkVEpYEZsQq0W4K5IKarlSFrc/7SyA
Date: Thu, 26 Nov 2026 07:03:02 +0000
Message-ID: <20261126070125.nullb-v1-signoff@outlook.com>
References: <20261126063404.1051061-1-x-professor@outlook.com>
In-Reply-To: <20261126063404.1051061-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|CH3PR05MB9580:EE_
x-ms-office365-filtering-correlation-id: e084c3a5-825d-4ad2-3c82-08df4b8b5054
x-ms-exchange-slblob-mailprops:
 4VtScROZs22d7njD0TZiObzP7H5LUc+RcaGhxLdl2z3gLDYYZU6lGqIuioVI9nqyt7VyEWe24GnXHBVReucByEyqP3r7QMLpfGcRZ3IGfeU02lRZXYJ6Q+fTRnrI8voGQ71E66r2RLDXRgvzdRFPu2f6rFA0UIilceOgqnKrGjcc69kjFKq97CLXxFVKMD9L+hgHBlmfkOkcWbkD2u1tN2CxQbr0qhkl7r0kdv4a1Wi5lPX600SzOkeR4Kpql2hULnU3q9RkPOFV9ry8FskTCb24L7t4248V9sFeocbhw69PyndPAtY2wJP8iQZm4XWPlKXPO9RnAsqYqnyJ8WohJgMtMjlS5lgIk0GbKn0RWhvkG7x4bvTzYQdXQgSa/Vp98Fh2fsDCRSUBH5dRI81D4g+SkyXRyDVqTTtkpIqBw6xvrplRuq+/tRJ68ThenoFFUFNlE4dZk9fZ2q1kWgPO2SgUzqSZ2L5tg6nuNcfzY8+GOROd24KH8b3OP3EFrxEjU+fx+y87/Brl2V2LeE/iZoSeyQDMeud7D/bQwyLlFVSmwlESI7V4j6lpCOqn/DJFD72p6iQjWXF/a9WEQP44GJ86Gd3x5P2cATna1JQnofZhDDW4gIq11VjOhL7WDt1XfQwUyC2tNlvXTzsqLi1TC4/LlMSQlEgHQcuFf/4eVr7PAy72RhPPZg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|22091999003|15080799012|31061999003|24121999003|38102599003|8060799015|24021099003|19110799012|8062599012|4140399003|25010399006|440099028|3412199025|102099032|52005399003|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vCr+TSnzN5zZuUDuc0CjbR5pHECWqveLHWepiSGcn5snK11LhYlp4lWLIojQ?=
 =?us-ascii?Q?+nXtUz1EeS3WuGhCIMfHTp7NaIQhcBR+059MpCt3Dyls9LqEQMmy5bi67XWY?=
 =?us-ascii?Q?XX0udXiJny/H/f8pcUTP/TfgUxtn8hds622hirB3kxRA1ck3rD08NnvYmeuF?=
 =?us-ascii?Q?ar6/AWSecmjd4V7BzforAGb8od5wa48x/ey3WDhgu5dirr3FRnS9yNaZZ3db?=
 =?us-ascii?Q?eqazrr1UBBIOhSDpCGnkAewXmpr3jv+v/1YRuh1Fn+/irgkcVyGGOpvQ0OFb?=
 =?us-ascii?Q?yHRjEJNoiFqQnbSp5GKV+riw+R4CmP5XuTLJX+4jgdH+YkOzvgxVh7M0RxPc?=
 =?us-ascii?Q?kf/Cy/sBkoOK5Rr1e4boQdxkTWb4vBba6wvRxiDq3CVYnXw5apn3OkUf87z7?=
 =?us-ascii?Q?bEzcCrE/EskESsYMd8Sxos4eEX9EfLRMWCkYCUbg/Gl/tQ0lA7hcQa8okECI?=
 =?us-ascii?Q?osOmpzxTrat6OK5fLjxMBSdoBYou71nTGgts1WhgDGJNYUYuBzDtwKDe9ENP?=
 =?us-ascii?Q?LnXOrKZ8guA8j4sJ6vJXzWgGvbVbirqS6vv3bhtTCaXnJ1zqwuKPNsFRUIV1?=
 =?us-ascii?Q?XjSCwbo+33DpfIaovjIUPHQgri2usd5lI+qtk2wyiteh3dw6AlniY8IBNuCK?=
 =?us-ascii?Q?Qa2eFIrIXfMhEFMUlf5/SPwrS1d3VBYOCmT/Sr3t5Y37B3805ayGbPZUg3JF?=
 =?us-ascii?Q?6pLETwJK/v7tK4AzS6z5X/CFVJ+QKb+VNmrY9SXWZq7tFF95y3lcAf3rgwfm?=
 =?us-ascii?Q?39Q1qsWOlYlaTW+G/lBzj9c6uB56UjyCoajVoxyUQSLjcDfPlOWNfwoKR7h5?=
 =?us-ascii?Q?ULF33APNXRG5VHcnJW9f9RnZIhzmrMg0mAvGOOhvXz6S6TpW2UfZG//LWuoQ?=
 =?us-ascii?Q?aRFgYBDgW5NODEIkxHGI4lycx+F9U3M1hzc8hc+bqtHTIfpObqEOZjAY85ep?=
 =?us-ascii?Q?8zheNtk/dF8bDSFGg9/wIFBCUZJp443lZolGEmiNz2XhJw42gkhuc8izYZpo?=
 =?us-ascii?Q?k8nw+9jiCx6IakNFNDukY+6kEAjqitqF+IK+EgOKCU08L/EAVx0NM70fEhIc?=
 =?us-ascii?Q?1qnNDrTu?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gZ1zGDcqlwLjzjGu9WTqBiHUkpPciNR9uJ/bQBKqX6EyfHpBGgvMsUVZ9c0Z?=
 =?us-ascii?Q?zvbwgdpEScxv9ZxQr3EC3OG5XN/k4zReE7JQDiEf0cllylMPQnBdj11RrY/r?=
 =?us-ascii?Q?nwsAgl4OjbrM4TWLIIagPsZhkdmB+YiY4x9doQJFI9ChO0855fCDwWjU6nqu?=
 =?us-ascii?Q?FfxKr2jIwrVdwDafK+MAi1EarHDC1LcKVO4si5f9buYS3cjjv8WrU5OcDdsE?=
 =?us-ascii?Q?jvZxkgx0WOHpkCrOSNmbJaWx55A6UtBCEs47raSdgrlGMs4f+Mc8wmP0rSsc?=
 =?us-ascii?Q?lbUel/ilAQ+9KR28oF7LHvtQkeUVfnUQZT18IeZVXpq1h1m++4NT6rbqCUIN?=
 =?us-ascii?Q?pg9MfUUGgFZf7RtdH3jg25/SgWnoBx7fkvz84jrQESX3eU2M/LZ7KhUDymjS?=
 =?us-ascii?Q?PBKDGqotARNA6dyVS5Y8PwDb52T7Fn9Eh1Rp2zgnCZ70oDKEmcXMsnVd2qI5?=
 =?us-ascii?Q?NUw08lwFgQ2X0pERDSxpVBV7FGzDXXrm52mX8GoNV2VK+AGnUkv8ZVS2AOAx?=
 =?us-ascii?Q?EteF/2aACPjk/1hrXPcamt+gATkaFQ8WvMEKcYFu+gQadl5CheusmAFbCQwu?=
 =?us-ascii?Q?s0xoHV6Dy81ax/Ssge5WRlx3bDbMSrIvP1a7P4bKK+GMfO8CD79NdMug4nF+?=
 =?us-ascii?Q?N0NZcx77cCf+edTB3VL8wCt2uvyS1uD+UsGkpDiQxEwPJC4pw4UP80i3Frlt?=
 =?us-ascii?Q?3NVTvuYM9qoK7OptNrhUunDYtGv53u4WX7yiCWOTlSc9KWhivkNE+o4hZmR6?=
 =?us-ascii?Q?7qH5UFE8KPjz+/WudNNWnR58W7ffguOMO9jQY01HIuqn14Jmuwy32Gs6YOA2?=
 =?us-ascii?Q?fT6tWER/GIou3OH5UuRCeD/XpBHvG9d8Zp2KQ9MJPam83hjFvtsyaRMo9dGV?=
 =?us-ascii?Q?hlFRAq7B6jAmha19dfOLMDZMP2x7r9aXEKKtB227xJjW9AdWOP8CtvUs7C/S?=
 =?us-ascii?Q?6kdmK95/YmhNkghWbTCD6NkcdKsayZjVZ5u5YhFpoIZNIpVkb2zFt1nzbSM6?=
 =?us-ascii?Q?J9dRf6pU+JTIVrU0HBJoNDAxezZEvUbBVbHDn3rxnazWtOxy0YUGUi8JMSNX?=
 =?us-ascii?Q?+kkRo4/Z0un6cwvO3SKZCNmS8rHQ0u0j2/CkhlbgNuiryMV7K0RkdbEy0rj5?=
 =?us-ascii?Q?aIue1VrOILTOqDHUdPuk7tdIg2vdHBgK1lBEezyYVVAH1Uy84qcXKfck7OsG?=
 =?us-ascii?Q?hfoqx/pOcuMeW81wEgav4O2p8DUIXVP/7ZhK/U3+gEORaC4rj7gWGa5uDcVD?=
 =?us-ascii?Q?RLfLZJHuxTA1fwrjMQU8BB4p2xpkoCldbcFYpNVsC61l2MOG+gp/1OLpYYd8?=
 =?us-ascii?Q?ZYTGL5CE8YChjxm7u3jsZy6ub+pWRvB1KUtaW+5rADevWOUvPKESyeY9erZe?=
 =?us-ascii?Q?iSMDNwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D31BB5BB84E9E946BAD7CAC10C5879C5@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e084c3a5-825d-4ad2-3c82-08df4b8b5054
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 07:03:02.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9580

Sorry, this series went out without my Signed-off-by by mistake.
Please disregard this version; I will resend it as v2 with the tag added.
