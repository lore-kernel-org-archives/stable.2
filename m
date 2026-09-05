Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010034.outbound.protection.outlook.com [52.103.10.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228314B950;
	Sat,  5 Sep 2026 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638929; cv=fail; b=btSpCUC4LzAYdvH/E7MIMQG2NIZQDDg4i7o1FRWKwOgmQ1QOZ6/NaCvWGzIzuBvdJtkuKHdRXfXF+vvbkHJq+yxWXHqiSoMDKpA6LgMojWV6SZ/KvFt/zCeA1gC+4n+sWTMryovSPUqaDqWzjz26X1hB4EyQmic4P7IvbcDsscg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638929; c=relaxed/simple;
	bh=R9DVf91RffNLL2/De2rYrXMx2PO9Rs06SwWUfJtu5Lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJikshrYqtmSacXi8Z94AjKxm12RX79F+UNQirjd6EqpyUn1AUEpwefc2CP6DXpxq0BbkbgZ5ctfYI9+U6N5I5aNu1MVTSkTCkGyyChCauvbMv2zQSzJRo8wWwAJbClTTD2lMb74qjqTweFGg9bNUPCDDWRAU6YAjYrDcoNRnFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VzTuyc2T; arc=fail smtp.client-ip=52.103.10.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VzTuyc2T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdqVT9mndvBNPah0NepbYj6Ql671lDYwuEg2J0uxy1YWIDYbhYnQZnU0mPlRmUW4M4iUY9WAFYYysmKSTP/yStoz/pDeUO19h7ZafN8JJCICOX2lK6CXVtG/l3+lCE+3GYKTjS2aQOqlCbYu9E/jlkyi/hPg254iqgJlzcOkZkbJj/5WKHHzo7Q7ApnhorHPuOjIr1LkQDMdxhENoXTfqIJEliS4+MpU0fma/iOhq+tspma7sknYRlAGxuxF4d0MPekUqEcUK3Mpc6KfzFXTc9ZZDKIZccSTYMtTKU08lAF2MdkoccnI3rTTDpciPI+0g1qb6f4S7ReuQaDyjrF3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Swe4BFl9JaCq9zPSMo8PAwmrdag4/JMk1ZWm6X0+4uM=;
 b=s/SYnDYR/wezUXkdwRT5VTvvMJUKcan+ofKPOnoshtihIfUq6x3McpGZE1x2OKC68uNQWLOpk/u3yqADr7r/W8nZae5/sjnUKdQkfwusbpwqq90lfK4gInEkMyyZZCZCZWdQ8NF6J8pFn9SHyRAETBPMpjs1Uo4/ZEFpofNP5n8tzoQ9XyfnrPF8K7uWS79yzh7OC1dKDzBeHVENwVQ1Ux1Xqc73lrgBjcSrv2HFDf52XHvWW1uXEn/OcsIqXLAaj//JyK9tHQaXLQmyDK1OInVz8PyuyLLAMGXRAhg4rnS+NtPHbC8IUFbpwspaMTXC/GIOpcRZSfai9LvUPE4NJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swe4BFl9JaCq9zPSMo8PAwmrdag4/JMk1ZWm6X0+4uM=;
 b=VzTuyc2TQBUFY89t5ab+Ol/nimXfrZaVtvkDT1RMUTu+of6v5YrCn6GiggV2hmHlbYuk+VnqHeaDh2zXEPbr7heREoDEziSAaIGrcCFYc+CLX8dxMKSEUgBwZC++Yd51qKo6PypjYp5pZLLsarnJs0rnk/2cDvW2f1CLVDegs333yvCrf2cQMPn/+FWQh2KcBYXBYAaF3KSTj1J5H4or71E1GiFPHuVkS4zTSHonlGOFCCX7SrsBav5DUYConeYiVTjHKpb7Zs5viqSytIbnG94FzIJGwgRKQBnQ6BR6dTeIsjaTef4/UYpQFqeamIFonXMknZHw8X+CxQiMfwRypA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 20:08:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:08:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Chanho Park <chanho61.park@samsung.com>, Bumyong
 Lee <bumyong.lee@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: use the adjusted address for the highmem page
 lookup
Thread-Topic: [PATCH] swiotlb: use the adjusted address for the highmem page
 lookup
Thread-Index: AQGeGvH8ZjIry23Y+a5bprIc/rGHIbc+rn+g
Date: Sat, 5 Sep 2026 20:08:46 +0000
Message-ID:
 <SN6PR02MB4157AD413ADFDE2D4F937AC4D4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7842:EE_
x-ms-office365-filtering-correlation-id: 09877364-116b-49a4-bb59-08df0b897e0c
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|51005399006|15080799012|31061999003|41001999006|55001999006|24021099003|8060799015|8062599012|37011999003|19110799012|13091999003|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pDswRq44ZoRInhU+okGyumu2F9KTFX3T2fr0HxEIdQYZmyQlgecxGZcrs3Hk?=
 =?us-ascii?Q?F+jRkBiWhiju+/D5xNXznn59bsBACOTp3jx1W5LW1S+GfQS0Wtb5uKS7lAmO?=
 =?us-ascii?Q?hZ6TvX3lDfKYFm88o3w94MGPLNkUBA3qRrzsGbTjVAGvfyrHik19R9KJEhRw?=
 =?us-ascii?Q?qoaxyZYi/3yXpCsZjlvANkFw5Wi1gCp/lj7RX+B9yDKeGVMyjHWFX3qtIsjX?=
 =?us-ascii?Q?b/tl64odL6xNWedtK1g9Awr8dIyvlpdzsx7AjQRvClzDDrIyQ1bZVBu0G2w5?=
 =?us-ascii?Q?+VKt1SJfsSbwr8H3K+ZAYM5BqNRzK7MIOXnF7Jt4hhpjNMq8EMJMHOOTVTvK?=
 =?us-ascii?Q?HQLzjGF9l1WGf1Plg6fiulW6IryIpkqFlhUw55EJRxG/Kq06NZkn+7gkS2f5?=
 =?us-ascii?Q?M9GkDqULo/gBvPtYORpWOeaIeAYJzxp1W6BlvEiYv2rnaocOsT0jOVmQlwqD?=
 =?us-ascii?Q?9uCR0ONz6CBYmkjXDF2YDa5DTdhJ0bBvxNZA1VvX1EBtHLZBxDQIQ+f+OJYN?=
 =?us-ascii?Q?rfUOhb+ANKwL21VJiL7bGgjS9Ygl6b6h56wmNTtoH6AoqIA46tv8AsbEiM8F?=
 =?us-ascii?Q?sexmndJAG7ajSkOX+BGAT5zdHm/Qqgr45DTR1cEncKyfUohJT1KmTNen/UIQ?=
 =?us-ascii?Q?QxW0zgad1sKD00tRHH3GCJ3lTkND3i9nyaIt9+QpBln1MeByamDeqodEs7hS?=
 =?us-ascii?Q?4Cq+dogVJfwjk5d8a+wJ4bV4oY19khbT+jdX4OqPY+Yf4ZNMUA47tHsBsamW?=
 =?us-ascii?Q?tLkRCxU072O5p0UK/mnLPWMt4ozNrk4GeR95KJNyKVunCCjrcfA7OC3pKoau?=
 =?us-ascii?Q?ZL1Ff00aOgdkfawvO2jB79PJM1I6ORBeaNLui0cwCaekqTOfIcvS6FOxnZZY?=
 =?us-ascii?Q?ASVbCDBvW571MneZguYoLmjycD9/26FbudRKQPVCv2Kq3MQ0qLogtMl0iFbL?=
 =?us-ascii?Q?Gjlhkz6ZKcs1mKP4pP2ncPJOc3w7IsJ7bj6RdEk7f0E9m4YgWNuirpnCCom4?=
 =?us-ascii?Q?2aIOZffmGjqsKRR9KfeSCVtbM71PnmhGw0o7gOAzr5AHy2HruvRo3gowp5OS?=
 =?us-ascii?Q?Kq55mhv7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8mVyqzu8UAuwPfQ7eMYyDAhHbOk+VkfDWzDULpNg1E/u9bV2X2PD3Mdv4M0Z?=
 =?us-ascii?Q?DGuNPqikhlQussOQdg45JU9NZ9Ht0izXRjB435LOOm9W+7em8uQjrPGWGmca?=
 =?us-ascii?Q?Jkd2ZmAItSTq+8SxF+PM/CSCygoM6jqCBGMARx771CypoJz+rlgGEt5ArxrD?=
 =?us-ascii?Q?H618DBMi9OlMXLEb4+y5dLYEQ5JNhFtRtSyxc2hK5WrcpdtwO98TTQjKi8mC?=
 =?us-ascii?Q?R81DlC6jlufz5l1lq959nNjZIDWliCbUIyRJzsGyPabM4sLiMuNMKxvGb6h5?=
 =?us-ascii?Q?jS7QI+1USN6nZMqvFwvSbOJO36DNn3w9hzW/1yYT/h2R2meSg6WgtVZD1d45?=
 =?us-ascii?Q?BrqAehrANvaj9pidRPUREOUo3BIP2+YJ4wBnGxiHtnRjY+1YaUb7eR6nkgUE?=
 =?us-ascii?Q?CUjopPI30i2M1vPRYM6yawI0E9NcbfvDBHYg3l8MRWejrMV6BKVfte6SshNv?=
 =?us-ascii?Q?PHyiFyoyW56JTb8i7BVgWnnRGcxanLhUCTUv6JvPnWhI0rGLE0uiptu4xKar?=
 =?us-ascii?Q?fZmN9Bqy9V5lfvag0I/LyoBH42jC/GKs7efRMKRQQN6TqT3kWPmBE/PvZEg5?=
 =?us-ascii?Q?j5nx6euo/OHWjHSbu12Ta2FrM/iUZte14xem0qtNKim6g9k+oVkOZOzOEjVz?=
 =?us-ascii?Q?aR/Jv5W0cqWRVaCYgWQJMcriWjQviVh/V7IOm6JlEAXbMCcPVxMyhN8/jotq?=
 =?us-ascii?Q?vhgjpl/VukefMJREXC/ZOg4eE60Em63rBzXsnkraJ1JBBPvNFKriEm415QlW?=
 =?us-ascii?Q?Lpdi6zgCsfcv5PdgaMrc+S/Uh4jVSy9+Wr82mx7Jc6SZnNafGKCqpbMpfEo1?=
 =?us-ascii?Q?ShtKp0Yc66bpFW8KVSETE+fdeu74F/yhMcgVKv+mPmVWrG1zkSaCDQ6vbNBS?=
 =?us-ascii?Q?qoPRAGqX6WI+p/FOnGyx/HjiBSooWjnK6Iwj4RL5WGf+93lqKMnUKnr1UiM2?=
 =?us-ascii?Q?eF7ejZTJCxfhtp1RNGmrqctixzqdfgxtalOdX74aL3A2pZ7hZnPQfa0arVda?=
 =?us-ascii?Q?l3X4o6WJnHY+hDYZBLdOF2oPSBsY6q3LBr3n+8F1gdYRzRWlu6yUb9OmOc6P?=
 =?us-ascii?Q?48ECDnd+H44JIJIryeIcyDREiJCdjpPZ1qR448FVXTyoH5BGrEsMH5ds+iUw?=
 =?us-ascii?Q?7Neie14f9OHYyBp3bO7yV/F1eiFPCVA40Zo+yd0ArhSPMH7YBgTQYDhPjFOO?=
 =?us-ascii?Q?u/7yU9/2yDHyWBkbtEdjIQm+npLHJYGw80k1oZqulIWTUFPBAMU379zPDug3?=
 =?us-ascii?Q?+QXX0ijT+NdvK1Rx9vVIQR0G1fYtrdBXUjLMcOhVTyDqjBk7hSrRFdOMFWqb?=
 =?us-ascii?Q?MZd9FV5/4Z7skZhV7arUW+d1DwqUpUAsEMrMwnkbeuKnOdOYVmVo4YgFwf7v?=
 =?us-ascii?Q?FUxzgPc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09877364-116b-49a4-bb59-08df0b897e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 20:08:46.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com> Sent: Saturday, September=
 5, 2026 1:42 AM
>=20
> swiotlb_bounce() reads the page frame number from the slot's recorded
> orig_addr, then advances orig_addr by tlb_offset to reach the address
> the caller asked about. The highmem branch mixes the two: the offset
> within the page comes from the adjusted address, the page from the value
> before it.
>=20
> Once the adjustment crosses a page boundary the pair no longer describes
> one location, and the whole copy lands one page below the intended one
> for a positive tlb_offset, one above for a negative one. DMA_FROM_DEVICE
> writes the device data over the wrong page and leaves the intended one
> stale, DMA_TO_DEVICE feeds the device from a page the mapping may not
> cover. Partial syncs through dma_sync_single_range_for_*() are what make
> tlb_offset non-zero.
>=20
> The branch test is picked the same way, so a slot recorded in lowmem can
> be adjusted into highmem and the lowmem path then hands a highmem
> address to phys_to_virt().
>=20
> Take both from orig_addr once it is final and keep pfn in the branch
> that uses it. PhysHighMem() asks the question straight from the address,
> as dma-debug already does.
>=20
> Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has off=
set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Reproduced under QEMU (qemu-system-arm -M virt, 2G) with a 32-bit ARM
> kernel built from multi_v7_defconfig plus CONFIG_ARM_LPAE=3Dy and
> CONFIG_HIGHMEM=3Dy, which brings in CONFIG_SWIOTLB, booted with
> swiotlb=3Dforce. A test module maps two highmem pages at page offset 3840=
,
> writes a pattern into the bounce buffer 500 bytes in and calls
> dma_sync_single_range_for_cpu() over that range, so that 3840 + 500
> crosses into the second page:
>=20
>   before: swbug: pages pfn=3D700d4 highmem=3D1
>           swbug: orig phys=3D700d4f00 (page off 3840)
>           swbug: RESULT page0_off=3D244 page1_off=3D-1
>   after:  swbug: RESULT page0_off=3D-1 page1_off=3D244
>=20
> The pattern lands one page below its intended location without the
> change and in the right place with it.
>=20
>  kernel/dma/swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ded7016a46a7..aa2f1c4588b9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1019,7 +1019,6 @@ static void swiotlb_bounce(struct device *dev, phys=
_addr_t tlb_addr, size_t size
>  	int index =3D (tlb_addr - mem->start) >> IO_TLB_SHIFT;
>  	phys_addr_t orig_addr =3D mem->slots[index].orig_addr;
>  	size_t alloc_size =3D mem->slots[index].alloc_size;
> -	unsigned long pfn =3D PFN_DOWN(orig_addr);
>  	unsigned char *vaddr =3D mem->vaddr + tlb_addr - mem->start;
>  	int tlb_offset;
>=20
> @@ -1052,7 +1051,8 @@ static void swiotlb_bounce(struct device *dev, phys=
_addr_t tlb_addr, size_t size
>  		size =3D alloc_size;
>  	}
>=20
> -	if (PageHighMem(pfn_to_page(pfn))) {
> +	if (PhysHighMem(orig_addr)) {
> +		unsigned long pfn =3D PFN_DOWN(orig_addr);
>  		unsigned int offset =3D orig_addr & ~PAGE_MASK;
>  		struct page *page;
>  		unsigned int sz =3D 0;
> --
> 2.53.0
>=20

