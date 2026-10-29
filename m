Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793295582;
	b=PP380ruErt97Iv4ChNwDm85pN5a+pOgoArbTXXQuHoY4zNnFOD6bRxvdcapt7qe866pQ
	 lX7kGRnJT1BubmdxZ8wvpK0/GOvS6ofIlkJWNOPIVvZCVEbeHeVBI6RVi43hRIggU3LxM
	 dTUg90Bbm5lKFPmFj5LL6ZgG4HWNFNkaXp//sUYD89z1fEKv4thoBtqZ30qN3B3kjYxrr
	 /ATDb6Sa88MMfFWpPo2ZXfFoKa5EMh3mdI7kNlHItDSOPYLx4/DBfmIwjw9rRR9JVa95I
	 2q6vb1TcjicWMoEmeDKAshGjADdMAn5c8FcxUjGMLSSuAw/HCST6a0m6sefMywoXEzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295582;
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
	bh=L/evzt8Yf/AquoRl3xbKClrS38CkfN1//dy/8K2TETI=;
	b=qeeSFPvlTDp5VAB/IBFIYq5uV5JU/YOSkfcO0aI3N3UWljOALM1ViXBYjfuATIwX/xb5
	 vNk0zEmhW8iRWoz4TtbgJi+O0mloBKjG85srSKAa/VkX0PrjFcsjg4RuGdYnWqjHHz1xr
	 CI0Y5QLr2fkxwOJfaJ1XK2SKek3ial9r6AJTiBAe1jYhhPQZUHh+sAnhmQ6nzS4a1cRpp
	 /aioUMsYbOKIURiMhHBnwku3U0BbwuQyeb8lBnEVLAHWCLEM7NTnP3vhi/ALH8AnPahP+
	 cpr9SwBP2pJL7sXeUrieYujrgyRYD6U7ZamzPW0NTCPvoH6+YGt+03PQZKUNGNMfm7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fiL1Zhk+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.56
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011056.outbound.protection.outlook.com [52.103.14.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB41606A31A;
	Thu, 29 Oct 2026 17:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fiL1Zhk+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnBCsY0vn7F5int+qt3BVH9FH8EbC5bQzB/MaC9umE5AoeKCU4S5DSVmVr9NzPb2r8l5MthzJUbEdQZwDuukJYbtr/mLWJ+s/6pn1eL5BE9RUfkLeOHEKFxISLfosO6N0ry43IBGt0cIdIbFPE1J0FxD8d0JmMrBsHZwRWsIw7HipEulOgsDJrKfCchiqMmthc2z7+0xsa3kVquICtB6eYGDB5Bhq1qH9BwBN+kzlppnzQVc6GkdBNlhv3yFWeNteoa03JSPQ3GfU+shteiYdn9YTgaGrEzJj7upF0CNb0Y29iFuB8Hm2JMrccXTJpziivtzm3X+Hwj4Jtr6x40rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/evzt8Yf/AquoRl3xbKClrS38CkfN1//dy/8K2TETI=;
 b=aNDZ9GnFxHF11trhRoB4pUAGSexrGDq/n5hwf4BfUO+4EIoUQrFc025LfN2zEsXZkaBswuryeUBMEw8v7To7jo2i4N+8J+Lqz43a+ASWaMEbDwPVqCSQhZi4Fl5HZUg6Gsr72/QYmcFMvjHdNuIPAVH3JyDyG+boCVjsRnQvry9+tp+HJEOwPVob47tKKl0cWtSSPTVNhcbVNoJpWxn4aauzQVTDEb0UaeJvupWWOSBq4NnC88WxY0nGf2MGtccrwtvFsCERaBY899f2fQLU8VZrsA9DMNRcuEUwbVBkXIOi/sJqiBDWSXQMJn8eamN9fadepNQQOrKv8cE+lOQCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/evzt8Yf/AquoRl3xbKClrS38CkfN1//dy/8K2TETI=;
 b=fiL1Zhk+6YDoEnY/rnaw3qtbCJ0pFmhSm6CEl4Gokxa/2dGCVcfgC69gDhKVKUIDglm8v9Bsh62IKfUEJznGyFK6VF2N1o5P0laofDopde5W07jAmIct9wZcqPv0uM5XX26ypL3N1gK9R+b3m3CcJpa/n25xhtHhyc/ytpEt2OI1zopY7qUt3oKFpfb8lsx15wTCR2zBKKqvFR+jUjX61yJWjR/tYqW0Ohnvaq9z2cvVfDuiU8IgmF4fQOUo0FxxgOI1V0PES9OkXjswY4WxoOOPHRXNs+2iCf55IVRTIk1/c7+HtLDmBJa9Aaboi6eYOiAjWAJTWCeAjvSBldCGUA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SA1PR02MB9698.namprd02.prod.outlook.com (2603:10b6:806:385::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 17:39:39 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 17:39:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Giorgi Kobakhia <gkobakhi@asu.edu>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiang Mei
	<xmei5@asu.edu>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: fix out-of-bounds read in
 swiotlb_release_slots()
Thread-Topic: [PATCH] swiotlb: fix out-of-bounds read in
 swiotlb_release_slots()
Thread-Index: AQFgKk/cI909fRkJAsTJbQaejYuCm7gPQD9Q
Date: Thu, 29 Oct 2026 17:39:39 +0000
Message-ID:
 <MN2PR02MB6863E09805FBA39C6779D209D46E2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261026032007.1957949-1-gkobakhi@asu.edu>
In-Reply-To: <20261026032007.1957949-1-gkobakhi@asu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SA1PR02MB9698:EE_
x-ms-office365-filtering-correlation-id: 5ede9dae-9652-4caf-58c6-08df35e39bc8
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|25010399006|4140399003|19110799012|37011999003|8062599012|31061999003|8060799015|13091999003|15080799012|55001999006|24021099003|12091999003|40105399003|52005399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9V6kGA9CuJ+9jWDSDfRhqpSKxBfBKklnTdlSMuE5v0lnI0yY2h6Igo1g3vyS?=
 =?us-ascii?Q?MYbQhEHJhTTOu8qPN3Se2wwe1outWgoC4+NaXG95E7t16vSr/ramIv7CNsPs?=
 =?us-ascii?Q?MCmc0KQ0KuruwArULxlf0WhjRz/TCz5/6pDpwyISeSwTZoUHwDvzlJ3CzTf4?=
 =?us-ascii?Q?n8TINc8fCxEPctK5d38gBGFj9QV1TlQRyAEZtpsFyyUrSvGplknrefHIpUMt?=
 =?us-ascii?Q?pIUE8LALnrmZ2FLR8qTPQ2QU/XbRFBD2HjtRncImLo2LazMvCQD5XaKqWJPt?=
 =?us-ascii?Q?5j3gALndta6DhIWFeKpF+BYtQ8H9sG/uiFexT9NERkeJczbEwUAavp8EbUlw?=
 =?us-ascii?Q?bXYbZ3Wb6L9YRCubtjqTOmCRhzJ8mI9OMouC/C77CHREgDilEg3eTw3bc3ks?=
 =?us-ascii?Q?Dio1Ow9M9rVy6x5/XrFGRaF6iK98XtpgPw/bHj5/KcSaZUcD8rozMIRb30KX?=
 =?us-ascii?Q?bIwX71Ywn069u1vr5exfsICjSoDhPIj4Klv7O6PR2qNFF8LrSFgFrOy9ppKy?=
 =?us-ascii?Q?KrLMjb5ASzQWFXlYMKCWRtPkduVPoW0mdbW7ehsLOJ75S2WDUZc/HQoRKCJw?=
 =?us-ascii?Q?P8LutwHwMMjsoGkr+uKCWMZNTbthGAICyBUDORVEnS/snI4i4ftdLbdUYFRL?=
 =?us-ascii?Q?Ko/HryqV68w5twUOJhwGf3mic5hDIt5zqyjNTTGzh/ngAHCeYKHMwbFFm/py?=
 =?us-ascii?Q?inqruvEDJYkVFz7L6OTz7oan7+uyesR8E8ES4O0VG1h4LMlN9HOtOI7Aq1sA?=
 =?us-ascii?Q?IdbjCq0DZc5bBGMmIRp3Mnq4Nf0KL9I+02mVkCEOP7K6b++UvStV5PvDHZk/?=
 =?us-ascii?Q?OgneMWkbGUbRi0mZqtmUiNyAMRBkw6JG2AoqnXjp0CSbTOB3zexQ6uQLU+Pl?=
 =?us-ascii?Q?67Zwg8NW3Ai4ZGf1H9vNs3HvlV1m6Wt8Kq6aCvnxOddqKjriAs60d1wYJJHn?=
 =?us-ascii?Q?KQBgeTY1rXXIrrKRYtybwVWVHBFr+pY+wQClWyZstMN3hSjONtEExtqj2efY?=
 =?us-ascii?Q?ma2PvHqelSxyUPUbiwir5xCMf7v0rABEMvmrUuWBkdoCTqui2lw2GI683n+l?=
 =?us-ascii?Q?zbzFiaCvo6exqJXrllj1RfKRm/dx5lB0Oo8ptGI0utLcYnT7ORg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PWMkHc7UkinMhTpR/YJA+fYSMgiUgUcJDclqQ22Atf6HnvdELlXkUhazCklO?=
 =?us-ascii?Q?7G3x/gXTsCXiCdIEonL3w/OQWgimCl86Dcjw/Ag32Ln3rXO7lrvymMPADYsD?=
 =?us-ascii?Q?d0A0D5XXHkg92v5n77Pk5osEvir64hPFXnTvJftzEot1VWZQ2+crahOdb0+n?=
 =?us-ascii?Q?MBuTi2MovVN8zQuHIuqDZM+8od+4Y+2fBygDcYT7ncOsr5bhSWKuwdi3Wibo?=
 =?us-ascii?Q?aK8hbePus2wJiMstuuwe2ROXsnD1mUfNtQhJ72l7b9D6oCXv9xhnx79p2TsO?=
 =?us-ascii?Q?zI8PJitjlL7MDQZWowJooQXoZEFMtfNFDNXUNS1kiUjrpMq6fKYkWJUDm/qr?=
 =?us-ascii?Q?uMm/WkfTNtKydsvMb2FSm+s9ZRxXfwQXMnGI+OBYxn1zQpqSj9TIm75zpBYi?=
 =?us-ascii?Q?aEehMBXyPbUibTYrOED3i4FvkUqo5UoYa88nuy6WtHPca8XAW5BQ0S2Jxz0N?=
 =?us-ascii?Q?n+3A4jU9DeGPfBIlbw4/tXK0a1NRvP0oUlQopej3TiGliYMR4/waHhPZ0iyQ?=
 =?us-ascii?Q?sRg4lb7iMFQ4tNyjtO4Pc3e8fXQmrIPWjoisGguRXjMA2U0nixmQoGThiPkd?=
 =?us-ascii?Q?CAGESgm3jL2GOoGntxUGBSVYsIEXLWBAahXqHWUPm4GC78RuOYGq9XmElgnT?=
 =?us-ascii?Q?ezWkr54W7HO+XxouZgcP7OPQVTTEpr7gSa+ONHjG37xQTVIczxjh4yKgL1wv?=
 =?us-ascii?Q?4iAPT5VXlYAmel/XaSKNDD9fm9OPV0otnYcLtrFksIHZnpvkp4Z9OnTJGFVS?=
 =?us-ascii?Q?UHEkwashAZq94ho5e4JO0KDjnErhNfbL8EmYt2cJ6E8FdQ0tnU+nqtpFiXyV?=
 =?us-ascii?Q?C2kLb3v1aAxVmQ7iOwPQAxPWeaD8nDB2EsT+x3OX0tlKOYS4yLH7+qY6ZsJH?=
 =?us-ascii?Q?UNZoSq8Qj0grfxq0NcvIH+ZvtEoUCa/c+FWP8NpTQMPZ9ZdOuc+lVHwLKPhi?=
 =?us-ascii?Q?L+njbQxIjZX/R4WAd+GiJHTJ/YF0ZeZK8C/G0OVDiwax/xMRK4N9jDqNjh1y?=
 =?us-ascii?Q?dYtgK1VAHBq1hx4l6T9mB1E+nio7Gr4Xwr5Xm8TKBs8Ia9cS0hYND1D1zdjn?=
 =?us-ascii?Q?5qsznURuFCN6CL0QqurH7roRWZ6bPgAJTfsHQX2ubYhLvUguwJ4mq5ZMMsOn?=
 =?us-ascii?Q?4kdF9LG2m20WqjeLsg70lc8tCDcz7eIi7xdjpyKeAURoaIpSAKP/ohd0vwaw?=
 =?us-ascii?Q?S4y2dp1ChYZWTYVhIvMZbKlTKPJLJgTCGAjL9TFoPn5NOuUdE1UYiB4/weMA?=
 =?us-ascii?Q?z4IJGoR+KyUkyQMEXFNo/6EXefC0XkfYH6QCE9K3z1J2aTbgCK4EdqKRmp6Q?=
 =?us-ascii?Q?5urxsSOO1zd2gO0gKyY+vmYtgXer8BDG3aBmjNLLwx7Yq50y94cjfpc8p5ul?=
 =?us-ascii?Q?8+btZHM=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ede9dae-9652-4caf-58c6-08df35e39bc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 17:39:39.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9698

From: Giorgi Kobakhia <gkobakhi@asu.edu> Sent: Sunday, October 25, 2026 8:2=
0 PM
>=20
> When buffer is freed, swiotlb_release_slots() tries to merge it with the
> following free space by reading the list value of the next slot.
>=20
>     if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
>         count =3D mem->slots[index + nslots].list;
>     else
>         count =3D 0;
>=20
> If index is in the last segment of the pool and the pool size is not
> multiple of IO_TLB_SEGSIZE, index + nslots becomes equal to mem->nslabs
> leading to out of bound read.
>=20
>  BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
>  Read of size 2
>=20
>  Call trace:
>   swiotlb_release_slots (kernel/dma/swiotlb.c:1653)
>   __swiotlb_tbl_unmap_single (kernel/dma/swiotlb.c:1734)
>   dma_unmap_phys (./include/linux/swiotlb.h:262 kernel/dma/direct.h:102
>                     kernel/dma/mapping.c:218)
>   dma_unmap_page_attrs (kernel/dma/mapping.c:236)
>=20
> The commit 0b84e4f8b793 ("swiotlb: Add restricted DMA pool
> initialization") makes it possible to initialize a pool with an
> arbitrary size. Before it nslabs was multiple of IO_TLB_SEGSIZE and no
> OOB occurred.
>=20
> Add overflow check.

I can see that this is a legitimate problem. But I'm not sure this is the r=
ight
solution.

All other paths for creating a swiotlb pool ensure that nslabs is a multipl=
e
of IO_TLB_SEGSIZE. The better solution may be for rmem_swiotlb_device_init(=
)
to round-up nslabs to be a multiple of IO_TLB_SEGSIZE. My concern is
that there may be other places in the swiotlb code where there is an
implicit assumption that there are no partial segments at the end of
a pool. It would take some effort for me to re-immerse myself in the
swiotlb code to see if that's true, and I haven't done that. But my
guess is that there's a good chance of such an assumption.

What are the implications of potentially allocating slightly more memory
for a restricted pool than is specified? It wouldn't be much additional
memory since the segment size is 256 KiB.

Michael

>=20
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
> ---
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ded7016a46a7..1f18003be343 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1649,7 +1649,8 @@ static void swiotlb_release_slots(struct device *de=
v,
> phys_addr_t tlb_addr,
>  	BUG_ON(aindex >=3D mem->nareas);
>=20
>  	spin_lock_irqsave(&area->lock, flags);
> -	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
> +	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE) &&
> +	    index + nslots < mem->nslabs)
>  		count =3D mem->slots[index + nslots].list;
>  	else
>  		count =3D 0;
> --
> 2.43.0
>=20

