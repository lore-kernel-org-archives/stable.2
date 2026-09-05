Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013067.outbound.protection.outlook.com [52.103.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FA374A06;
	Sat,  5 Sep 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638857; cv=fail; b=LiIIeITuu+UcFhKFh96jxAY3sAc55WT8O1pC9vgh+JuOp8xy+pKhLNFmrjhMLQSscziHqszJPvauSPBo/g4NM2BPxVRpi1bYd9tYlFENJQqSH7aI4deepHhkSSbxcMlIwBVGqCgl5Hkxos9j1DXqrFyr96oNxLmSREVhbV73iQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638857; c=relaxed/simple;
	bh=qknAqTsBzBMylaL/ZciZkcLJMoCBVB+hsE4u7wFpnD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UUr9rBr9upj8YB8bOBjX1PadQPxzVjX7GejayWng3u4Zceg5tUH1ANjfTGyxVn260RJSGrWU9C3PTNr5rVyA+emzdlBTKjN86WHOyBNRsi0Z0uERY2k6aOuIoVUOydnSLaEY/vq2u2Mn3h7+++BquWlFK27oTph5sujwQGqJ1Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YsJnann5; arc=fail smtp.client-ip=52.103.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YsJnann5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjUhQHSL42BZjIaay6nmM4SE5yDm/h0Vb4lhylEVvz2wtL63EnWqtCZMtN8I24/Rf7oejwM0odoyL2rTpgq1z38RU3I8mvEPxGfPXzx5pML8alYKhwL95gETYW8cJBYeh0gFLqFO5bVS3pQwZmVnIC6tn4mNaN011xYUfDqiKwLbYi5yy1r97fi28Mp2uUCDLMzLZmXqAVqWGYMuwD5qC4/C+X9IBFcRfXh85WXMdD8DCDMZC+8lhcY3lMYkEYvBbBtXuUVPLw4kJ5LvPIFEWi2v/hl5C68iM9bz8xqXLmpqzVQc9K5X9eXJ6eU6BKvP098US+ITe7FLkGl+VJxxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95WXlR4VGeAsi1ivYVerKOjxBxwQfhFhXfCyP8K96h4=;
 b=f6kSaVQIsJcksyauIRqLoHtipHkuI0Vj+ztP7tA7GDnp/+qNSu16j3/Jv/5LFMrXqiCYFupw4oNXs6ICkihqsFgdSMFaDMZGKnbfW6Z+W1blUZUNohKFTkdryzM6fVXdtylyJxxahywkKrFdlZ66byIrw8Tflq38NKB0P+xtOTp5KsddIlGh1Opq0Mpqj5Gva0B+KM6A37wK6njPR4e0vIKwULFhr+93ec9V5lf3Vq6iQvwYr+qzdxV22lA6kaQ/m76ciB0bTVxwzlh1FGJWjntlX+KDo9TzsMUUzdkDanf5ws4KKDZAYgDRbP95R1Nb46GrSsuR2M8gLp3nwSWxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95WXlR4VGeAsi1ivYVerKOjxBxwQfhFhXfCyP8K96h4=;
 b=YsJnann5A4lpfTRC3wdDUDGNXB4Cn017HeUepeAFufaTwjEWa2d7xeEeGFUEtEnB61k56c8cUEX2vDbeJOKl7Y1amI+udTuTpbuspC/vX0CpphWgWHbI/UMWze1moGuot4Gj4grR1L1LHNC/XHWejWxA08XZuCranJHvMYjkLS0IscpaPtGNTJ69xWzlhZ3qK25H5xOkbrXz9EF3OnUlqaXMVdmN6YQQUbzp8zdWX+AS1gJlFspATU7vhCoWv8ldJz+oJW1nRBQYH39WQT+bQv8ZMNAnWcOISO5fB2qQkfWb4jx/oCRXFDXjJxxuFjGgjyWNTMI9LqiaagM7ro42uQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 20:07:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:07:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Chanho Park <chanho61.park@samsung.com>, Bumyong Lee
	<bumyong.lee@samsung.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: use the adjusted address for the highmem page
 lookup
Thread-Topic: [PATCH] swiotlb: use the adjusted address for the highmem page
 lookup
Thread-Index: AQGeGvH8ZjIry23Y+a5bprIc/rGHIbc+YC5QgAA55oCAABRisA==
Date: Sat, 5 Sep 2026 20:07:32 +0000
Message-ID:
 <SN6PR02MB415711D6825AE8C7B88F0FD4D4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
 <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260905185431.177766-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260905185431.177766-1-donggeunyoo.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7842:EE_
x-ms-office365-filtering-correlation-id: da3fb57f-9b05-463f-09ed-08df0b8951fb
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|51005399006|15080799012|31061999003|41001999006|55001999006|24021099003|8060799015|8062599012|37011999003|19110799012|13091999003|440099028|3412199025|102099032|40105399003|2607281247196008|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?phI2+vrEFbXftxWfXDVbtt/37EnyEI1O3F+orIoiNtLbaORrs0ks3TbiDMFp?=
 =?us-ascii?Q?OiyFIXuzQTtdP3cj5YhJeaYbsMcCh7xTR8uQituGdfpW2LSV1ehQO9mcyfwk?=
 =?us-ascii?Q?zDyXB2qxY8EYY3Yw/xTyy2NwRyhAWSl6BlFfzd+2y1tI/qAzyFuiyL8R/7dO?=
 =?us-ascii?Q?psSNMY070PjuIAos5TETaYIPotEUZprUu+9rnxVjrp0WahSVFeXDxJpLOsMH?=
 =?us-ascii?Q?8Eu5HC06nqjObva5ostjVNboHkoS6eVdraI8vpDrTD6YrzvlLVA22OMPQm9a?=
 =?us-ascii?Q?7jufKYBo8ytf83fAkokuWmySzstLS/ubiDwkyUuWsR66Rjt9eIvHT5tbTi30?=
 =?us-ascii?Q?SawL1glAWyu2pFJkhVygrIHKdD9Fv394Q3qN4Md/JCA3NzHpK/luZXRHMbzK?=
 =?us-ascii?Q?DK/5VCvm4crq/x3eEu2tanlCx64CaGX2iA2lV22BTncNejeuFZlde/PJKhAi?=
 =?us-ascii?Q?57cMgY0RjWGFTcrRvrAKqbfWrULQuGa7/9VN0lYdoDPDEF7cLUJd3aBMiZkJ?=
 =?us-ascii?Q?1XELkuQLtrXIDz5x2kk7wEJXzTM/OJMPEaTyWSoMugdC2kN996YgyY3sGDgV?=
 =?us-ascii?Q?zsmZbA15RkhlBR27hEkRz2xB2N5nUV0+IRweEAmkp+zEBvcTUq4hYp3qC/It?=
 =?us-ascii?Q?Cxjt5mZjJx6WusZXy63uPBqF0WyP1/twjNeQHYvCltF0yHBEGfZ2rwhiLzBF?=
 =?us-ascii?Q?BNOa64kiGVhNSryG+IU9WlkQ6OBina+IgbFUWCptxecXIyR/gI4bQEgInCAg?=
 =?us-ascii?Q?gTNBh5CMLoeNO7MaG9LDu9En1UVOkYGfJ2Bh6MiQKavHw4WIolpRkUCPf7Yy?=
 =?us-ascii?Q?xOS/X3/NCEFxgCt0hRwlezZOOPLibz2PzzHyGXLsKUXAI4A0KXjm0syQAGa7?=
 =?us-ascii?Q?u/x8z5GKJGcD4qAHLlb9d/xGpbfmlAjjM48/HhUBQhAd3HE52GjpV6LrfJc9?=
 =?us-ascii?Q?JcDt2wKxCbFuBh6WR+nP5MLuxYTBR7YrOY0aMJqo8e4Rc9tjff7P/m2xrF6T?=
 =?us-ascii?Q?S7MthwMUfSsAi4g4rZa+SqsF9M/s/jbt1YmTUwh3ilqN81eKoXPtXFzVIPYS?=
 =?us-ascii?Q?uB30fv5iLCP/qXOmyafDr1BrmEtf4PHS440y3rnpHAyvmJYRvE8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jBUSrw6ZiqJAK9MT4fXZqO1j1fp/jdI8knMCIBB3ewcL/G1j2LnnyG6+/rI6?=
 =?us-ascii?Q?UIIBewwqB6b+wFADEIsISlvpFB0XnYguf0imEfNu+iisBWBPlFjfGKHhyAbQ?=
 =?us-ascii?Q?3GS9Wd9zf2dylSA1VZw5xo+6xWuX8BaBNDDM7mdwZIfvwL3ybD1SwvQndT0u?=
 =?us-ascii?Q?fsixB55NkbrgBiOMGWRernhQ4aMXnK0jVG2BG39JTXe7CfOQHON7YdfXPT7y?=
 =?us-ascii?Q?PDM20UNClQ1RdbzagVAiMFR/Pd2RhRkBHfgkZKHZ6S2kwTMy15oxU3wHeMOV?=
 =?us-ascii?Q?zihmVwz8WNb+248MI35Um2G6jsreT9iRH1IdHMmdlRaGQ+ubRiq1hM233JNr?=
 =?us-ascii?Q?tVFezN5UZzYok3+5qEYgoehClIfGGWoIAOFue1r1fXWc9kpYKWVAEgR16mjC?=
 =?us-ascii?Q?QndDlw41hxPBEiYmVvHSgV8sOH74hVZgN3hs7joopaxEbSzR7KZrmIPGG5GH?=
 =?us-ascii?Q?aRSs+Eb8Bn7d73IPrZDtbLUQL0cDLG/OWGIjJqc0aB45+RBvhK52rFx2AxeW?=
 =?us-ascii?Q?bv1wEcafD1tdjm90e5jTf2WKC/VJ7TwdCIUFD8QBJIfR0qEslocQgnhUTRmr?=
 =?us-ascii?Q?ZuOX7+vqwjZWJ6k9CDrocWAkQNxmrW9ozd9uyqGlfoHINz4OaBoZhjJHwUQu?=
 =?us-ascii?Q?mTnJPJ9SzqukWG9n1Qht1HOWsFpmnGOKSKNTMcP+5MQclgKANA+angu0Wfx1?=
 =?us-ascii?Q?jhX1XIH95iL3CEjQzt0t23NH0VvbuRXqF8VWeS0u++FyFRFdRH6BDorbGQ3L?=
 =?us-ascii?Q?IxY45NIj9kHBjssXbAxrhDKBLN5qbxchzz3CabVq2Tr287cx4nTjl7rwtuHy?=
 =?us-ascii?Q?EqpK7RDoAkLhMXtOW0W7LgJeJ6YipfICLiiJEPNbDgYdvkc2e/KoLAO96noq?=
 =?us-ascii?Q?s1dM7dezQzFn28SBbm/23OM/qTtbbcSxfyk1Z9fcV6zQupV293y2G7FVTyVO?=
 =?us-ascii?Q?64EF/NJmwtbPZXB5zmCVYRMshgT97+BHlsEZV5p6xPAoYvf7ZGTc/PFPyJAl?=
 =?us-ascii?Q?EkEwJpA10bzP71cVu+G3O1yMFaTGWqEEKeYn5kwCDsP24JjfiEYDd+6p6iUq?=
 =?us-ascii?Q?qVOo20YNyvttWIBNZF1DoGu6hBPO60jnbZ9CdcJ7wPtN8Vks2q7Cx/Vf3zol?=
 =?us-ascii?Q?YvUwvxbadd5pKdWowFumLl0+Emzo+1dblnMPh0B2K7q0A18+XF8sRR6lFCTl?=
 =?us-ascii?Q?ik6VpYgtkCsBeKuTi0YuXVis2TrOHeO7b7LogH4msPHLEapq0MAuQM2NNbDM?=
 =?us-ascii?Q?0/q+7ajLewFAHeRZWcTUyatgNReIFOiYBlUtEBYLpaT3mQXj6u5xdcxI2Ntp?=
 =?us-ascii?Q?Kx2stFmb10w5MPJ10R1t1/7ZIIyWkdvsXv5QRt3iyg7KRbnkK6iWBeqoOa1C?=
 =?us-ascii?Q?dw7/qgY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da3fb57f-9b05-463f-09ed-08df0b8951fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 20:07:32.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com> Sent: Saturday, September=
 5, 2026 11:55 AM
>=20
> On Sat, Sep 05, 2026 at 03:45:41PM +0000, Michael Kelley wrote:
> > I don't understand this paragraph, but that may be because I'm not that
> > familiar with highmem. Are all the slots making up a particular swiotlb
> > mapping either highmem or lowmem? If a mixture is possible, then a
> > partial sync could start somewhere in a lowmem page and cross over
> > into a highmem page, which would break.
>=20
> The slots are always lowmem: the pool comes from memblock_alloc_low() and
> swiotlb holds one kernel address for it in mem->vaddr. PageHighMem() here
> asks about the pages behind orig_addr, so the question is whether one
> mapping's original buffer can span both.=20

Yes, that was exactly my question. I worded it poorly.

> It can. ZONE_NORMAL ends at
> max_low_pfn and ZONE_HIGHMEM starts there, and while the page allocator
> will not hand out a run across that line, pages_are_mergeable() and
> bvec_try_merge_page() merge on physical adjacency alone.

So there's exactly one case, which is when a merged range crosses
the boundary between lowmem and highmem.  And the range in
that case always starts with lowmem and transitions to highmem.
There's not a case where lowmem and highmem are intermixed
in a range in arbitrary ways.  And there's no case that starts with
highmem and transitions to lowmem (though that would just work
with the current test).

>=20
> Your case is real, and this patch does not fix it. On a 32-bit ARM guest
> (multi_v7_defconfig plus ARM_LPAE and HIGHMEM, 2G, swiotlb=3Dforce) with
> lowmem ending at pfn 0x70000 and high_memory at f0000000:
>=20
>   orig=3D6ffffe00 len=3D1024 last=3D700001ff
>     mainline    PageHighMem(pfn_to_page(PFN_DOWN(orig))) =3D 0
>     this patch  PhysHighMem(orig)                        =3D 0
>     phys_to_virt(last) =3D f00001ff, past high_memory
>=20
>   dma_map_page(pfn 0x6ffff, off 3584, len 1024, TO_DEVICE)
>   Unable to handle kernel paging request at virtual address f0000000
>   Internal error: Oops: 206 [#1] SMP ARM
>   PC is at mmiocpy+0x4c/0x334
>    dma_map_page_attrs from ...
>=20
> The same oops with and without this patch, and no partial sync is needed
> for it: the bounce at map time does it.

OK, yes.  That makes sense.

>=20
> is_highmem() is monotonic in the pfn, since ZONE_HIGHMEM and a
> ZONE_MOVABLE carved out of it are the highest zones, so testing the last
> byte alone covers your case and this one, at the cost of the single test
> already there. On top of this patch:
>=20
> 	-	if (PhysHighMem(orig_addr)) {
> 	+	if (PhysHighMem(orig_addr + size - 1)) {
>=20
> The loop copies through kmap_local_page(), which is fine for a lowmem
> page, so entering it for a range that only ends in highmem is correct.
> That guest survives the map above with it.

Yep. I thought that would be the case. Using kmap_local_page()
is slower, but the case where the range starts with lowmem and
transition to highmem is a rarity. Please leave a comment in the
code about the reasoning behind the strange-looking test.

>=20
> The second one predates 5f89468e2f06, so I will send it separately.

Works for me. Thanks!

Michael
