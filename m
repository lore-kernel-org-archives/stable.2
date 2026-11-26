Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674852;
	b=AHrhyrGZBHFDiWPK9Umg9WFayvOzu0svsad8Cv0uGhWscn6wEm8MAHFOsPVhxSgNHVD5
	 WkBHZCNAg3LveVz27RLlMosFEQthkHz6BbNnQZB2Z2evKfZFx4eSAGZ4JiZgYgw2qI/v4
	 zQFISAti52e4lRhLKedljo/vPuy/eIFBrkgMbn64CLAMBUVPS/XPdnLDK1ySk2NSNJWor
	 WPL6TEdoVPx/IWLVsMbNsw9rx5jRL3/G9P+frzCf/nk1sS4gy5NKovPTJdElYrkYX4h4h
	 ruVK6v9NJ2He97wyRVBrGiQM/iFRdcR1QlrsepJwKZKjP2x7pLrMwIBNFTlOAUscJKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674852;
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
	bh=RcFIhebJuYsPlu8jCOTHpyE4kMtQkvgusNtZfNQwVxQ=;
	b=l4io3aaj3iZyOPtLr8j1I5P4kicy1PSliHUjGxCdimEylll1m7qLjNppIur5DRuqMTLQ
	 r3xGdqXtiscCdxVjJN5703CpU02/IaY8VV6dEYtDSFdRnkqUi15rA1pygYKte2FvtRfOC
	 O3iTe/z4XyFA9Wn7oxalxnvzecea9bDY77mCknTWkIf2CpATHPKC8zmAL0M3UELRt5MPa
	 Cmby01SybnQNtUba2zZ5VRbal6yxTJRcxMYxSl0lMM8NKm4eMnH76y0M3UB+k/zhHt8Jl
	 3aJ34b++qDOqiNb26R1d13VSC756TY9bM/yZs+zAnN44TTTCoSWdtL42q0QNvTmQ2ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Qe9jUQcM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.23
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010023.outbound.protection.outlook.com [52.103.2.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5C606A31E;
	Thu, 26 Nov 2026 06:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1C5C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Qe9jUQcM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeUPcJiEbREnBM5wmcrHb8tRTTgWQK/xLEMOha0tcrMUBeO9SDNe4cdC5KkafdorviWjkPGvaQ41Y9kR9HbAWmH9MT7x0kQO+InndeZPSjsRYc3m7akt3vCOfYJ2a8YKXFgX6FiN3IUd59isGaJ19Pk3U+RoA7wo/6bBWyitnPaeeT7oWBVQuh+rqRxUAwcCBcz/2e3WPMb297iHdHsR5rZ/i5p8CArG6XkKfrL0ICg90wKZUHe84VpRAZUXCDunnkq0/mj1WtegyCbo6iCbcDremWE0xIUX2XzlibbX2t4qimZQGm14CT1xgkauFpp+JAmtxus1JdkglPcwiWHoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RcFIhebJuYsPlu8jCOTHpyE4kMtQkvgusNtZfNQwVxQ=;
 b=UO4VNA+AzFTt3xrYGby2fGSODSVVslG7EX8zUWD/FrcZ/5gjNFvpptvYsgOuXczPoayL9gp047/0uzl59iu2zxTY5pRJps3oQuCxS28JO8mnKkY6urzskDXM6Fgt0fB/1bexrm/uPK+Rpsjf74EuGS0n5nwcbLEe6SZKh9/ZvtVmhNXmZ1REB0u3NZOF5XUwdqP7DVjlDUYHwAPa4FA+7CzyzbPgarjzgaBgVNKX8ECcNbeaMDXYN5rIFu9jz6UAeVzfFC/kpbcFt8zgBtjN9bn/N0bv4zeEaju/uATdmCpjEhwoFIvKe6B17MFZhoFRhAV8hymoP19Nb5VSJ4K1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcFIhebJuYsPlu8jCOTHpyE4kMtQkvgusNtZfNQwVxQ=;
 b=Qe9jUQcMu7jIGbFzxRx+kEDq5ZG7M1c9nGBIA24qfGqAD4FZRNpC7mByR2Cpf8d3y8oLHuwofFn2GfIWHQUl5m60mRoVmWn9r1jM3BXnQ71+2vEqRKkOUSf3lzthbG0Lnm5qwtx1i47q21QuhYio+TyiaBr9LNb89/b5L+cflwAq49tbxV3HVsAXPE6ttM9zMGnqZzGR2Um/pOCVzM+Y4QK/xjpyfQX1hD3093zzjEIgEdDlRXKLs4ygr75pJf6VJR1PbgB6LfbyfHjMcgl9WPnIC++m8W1MDEJDX0qOLqNJiirWqW7AaVdxGWpvytq+EovUhAI8P+DkXw5QgsDDpQ==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by BY3PR05MB8273.namprd05.prod.outlook.com (2603:10b6:a03:3b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:34:10 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:34:09 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 0/3] null_blk: validate configfs values before power-on
Thread-Topic: [PATCH 0/3] null_blk: validate configfs values before power-on
Thread-Index: AQHdfXAkVEpYEZsQq0W4K5IKarlSFg==
Date: Thu, 26 Nov 2026 06:34:09 +0000
Message-ID: <20261126063404.1051061-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|BY3PR05MB8273:EE_
x-ms-office365-filtering-correlation-id: d51086b7-f7c2-4bc1-b7f3-08df4b87471c
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|19110799012|31061999003|38102599003|25010399006|8060799015|8062599012|15080799012|24121999003|22091999003|8022599003|26121999007|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4hAWmbuvXCJ90lpJbxmzJJZr8TMvrl05lyd6uuTE7NK8qed+7B6z6r6zAu?=
 =?iso-8859-1?Q?kz/8GhXBGL6Be0k0se5/JqyGA+9EdJBRL1Yu0M2sk99XiQhCtecQX0/UON?=
 =?iso-8859-1?Q?0ihF8bdhCjgK37hUUPeTShbaG3DW56geQzfo+fCdn/ubvrN4H5UXgdveiK?=
 =?iso-8859-1?Q?yF4Pzype/qLXt79btMBd6DZJU4i7QU7K1sTaizuOlTErNLHEXAl45KpbyF?=
 =?iso-8859-1?Q?pRlqFS2skwDcgJRsBKuq3xwWET8wXRHuvJwRgQ+iOwjMWvwuEbEZTBSNeK?=
 =?iso-8859-1?Q?gRmsnYQw86i7mcnxZOvzT3eyzFOc82ARDfOymzn9UQelsqjOJJZinoGb4r?=
 =?iso-8859-1?Q?ZxZ7SIVYnVPRQRR32ofGNfy/8yROdT7+YANW1/YBERh7DkvO/2ELOGcdL4?=
 =?iso-8859-1?Q?xQEtvBBAJkA6aQhxXokoNt7OMkYAUYtwZLntfHnUtcVYZ8IdRQzEQi9+Gp?=
 =?iso-8859-1?Q?SZ7I9llRVKOnZXRZgt+ceqSQqdi8/kUmYy+qmSNB8ellcAMs8dw+JUzke3?=
 =?iso-8859-1?Q?j5V4heQ9QdZAkSfBPymzguf6oDdMrHa/8cKXe5fksjQ1+OY0ETPji/OdLN?=
 =?iso-8859-1?Q?B5joI/B9df6pDhm7njZ9xXZBcMg46tWIAw0QWZYwTDt5JNDxJwKsmRdIDw?=
 =?iso-8859-1?Q?nwm0Di7lNeVgKkBswSGkY8kPks5N97NA3WPMCBHUvPjZlnvLwOfzrGYxzu?=
 =?iso-8859-1?Q?DZSGeCgyYKuUNnNa5sxs5H7EUu6NYN3lp0Uojid3vLl3s/91uo1PGg2B7l?=
 =?iso-8859-1?Q?qOCoxaLvc6Qniy3grOkJqxqs5KcZPXlpqtJX3M5HnMyC9pWZLfRKkT7HH8?=
 =?iso-8859-1?Q?EhGNOqaVVEUt4YB6PH2nrAs0VAMrBXZTZcP2rAkVD35nWuXkARS5wz0+ts?=
 =?iso-8859-1?Q?kcJVCjhDynye6ulEmci5fmr8vIB2pT8LQihzXc68ToIzzQB/cmg+jRsdZF?=
 =?iso-8859-1?Q?6xKyz4MMjZsPt979ZT3z3Ce6DTpCGYuqOsk9eS8c5wAPXeKQKtPkpGAKRp?=
 =?iso-8859-1?Q?c5bDsj6hYPfDzxlW5XXTKNSBgVnfUQb0toN26k5GftzGSBFljOQ5RfKNKX?=
 =?iso-8859-1?Q?Esu0og7om703mf1xd/zWNm7Akr1VoLlx8BMC+2LBUlgK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TRdr6WyEPyX+gZ4IXs32jg2E0a4yNhiPfVu/DCb5YTcDrcmWZF4bRJETKw?=
 =?iso-8859-1?Q?/SP6cGpeGUMd1s0Z1WMYw3PUDV7iY+eV8MKLpI8WoBUkX1vGKRVRsOUtlS?=
 =?iso-8859-1?Q?bHgOK+sB+t8DeltCyFiYRHLFqtscKk+hs/e6vDj/6KV4Kw5KGrCwHmXTf4?=
 =?iso-8859-1?Q?G3iuGO4ZfX7Gdj8mEnfUUQpf9yOiE2xeh8lNsFd2YyhWWFxaWuzOrJyM9D?=
 =?iso-8859-1?Q?EKy65sTgHVc/5rhmpSFcT/JQ+x5aTa08zr6wteiYi4NBL30F+vcIZA+mry?=
 =?iso-8859-1?Q?dE5nftU6leFQsyjeQAtTt11eDztcDw3EPvBbFFUJ+28z7JhzYIeJUJIpWs?=
 =?iso-8859-1?Q?vu955NLc/mCZpUZaI+XLTJNkLHA01DY+3YR0VB+OYtAhqFU+lxcLGSN+Rj?=
 =?iso-8859-1?Q?y4Qw0zV+XTEp9hbqpWoc7VesIxIaxRUPmwRbGkSHRq9KwZolHuehWDKXgo?=
 =?iso-8859-1?Q?MN9RBildj8yQAHCv2Bk307+PLLL3hlLOuyxjjgEuxLbv+xTMHjA+iL23ow?=
 =?iso-8859-1?Q?WK5tdLjlg/CINn/xDzkFgLes8a+tJdNMf4+xVLFLP4BQipyyUOVOqykH4K?=
 =?iso-8859-1?Q?MfTJyUoht/eXwmnszCrjenKsnj0ZRrEqsOPTMkGJj4hOl96fo39uB8zoTb?=
 =?iso-8859-1?Q?5/K/8kyiKKIL4vJOEqTCy9Gg3dPxLl79hNhm53ImG7S9oU9z7fmFUiZDZs?=
 =?iso-8859-1?Q?df+9bbi3GkEOQd6DXTxq5Vl6x7W0Z3t5wp1RXzMnyhYAJDk9TmWngc0MQ/?=
 =?iso-8859-1?Q?bf/oeYgnp6ARoE4fbvELggqaSaEgX2csP00lN1W0VuUBEcFgUzjBYPMEJn?=
 =?iso-8859-1?Q?Uv8LOtyz3UTQ4ACvhAeWiJ0OOQWCsUAR4b33Y2XH70zeKyaxYuEWzWCiiY?=
 =?iso-8859-1?Q?/vFf0tkLK3WhxaHSPUPixwa8jJmNOl8Akigw4Ylw+rgRXFPyPhivC6RvhS?=
 =?iso-8859-1?Q?KGkg0f63D/Fp8OyP01XiG6DdYRUL0xzoBRstrfu0FrLQ+ChAVLFr44NJkt?=
 =?iso-8859-1?Q?g0foUN+ck7JwmQE1tFgtAxTAI4FLyS+l1US7iVjgS45mpJI8APvkbrN1ft?=
 =?iso-8859-1?Q?o7LDLH7mr4xQ5d1UvW4rykVaNywsDq8b88VUjqvS7VQDac4xcypMrr7ogo?=
 =?iso-8859-1?Q?6hiIoPL6+X/zoUQqrllIcIFSVVPBHsKqPiSIIq9oekShX/SGnrdUXhQfW9?=
 =?iso-8859-1?Q?Nn+6nka5wQgk6NfMycNssrO336MO6MX1qusen8ipr4w6VJ5cs/mIUAI0jZ?=
 =?iso-8859-1?Q?GpBs/87tjJHgdYDUa+9I8Fzdm4J1nHLIUI3dB8y0tL0XiTxYN/mvsZeSxX?=
 =?iso-8859-1?Q?X9Zj0GCgei02Q2oXRItEJvSTgM6tpUsonlyCRcQJoOQh+Tt2FyDIdgAArI?=
 =?iso-8859-1?Q?RjWCVh+knq0RAu5wPVh7isdsjaZ/sCq81mL0PtaIs7Y0SJVnAObaNpXtyY?=
 =?iso-8859-1?Q?qL/lq6KdIaPVY3o3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d51086b7-f7c2-4bc1-b7f3-08df4b87471c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:34:09.5360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8273

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
