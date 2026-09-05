Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012048.outbound.protection.outlook.com [52.103.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C445352021;
	Sat,  5 Sep 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623145; cv=fail; b=YT2EkLRt1iXIVayxzyP8/6x2k87+qzlNaST/fHEpbchSKtu5bsFPo0shI+33dncxtXOCICe51/zYqRkGurVAcHlhG3niF+fkZ+mWPoj3QYaNPqAxSPPP5dsEnYgU+TfeFbyaXEjU1PDI7YJXzjiYc/m2MQBksuLT9gjuBQj6//o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623145; c=relaxed/simple;
	bh=OWZkuEr5u4ophfSVvWTl4BdzEjnAuUGSPyLaovXg8mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IW81i+RCw83emkirwSlClAiuQfNsNki/KiB3xmTnyWCN4I61PB3ThV1fA6WzM4RtYOef+5YGUDQqFZftyG1GJV0CoLao5l/TP28OFGDrCsXIvRsqjBWV1bL7uU5nnHuYm41FjooLVJLL29JD31UeEagY8lHusZy/IaqOGSj4ytA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lVrkBawV; arc=fail smtp.client-ip=52.103.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lVrkBawV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHEvw+9VfxzAqn/n/4Bpjrau7tyc7d+qtER9Q7gt9RPqXT9OBCY2ZEdh0Mt4kzdu6shSUyk74WZmKcTCfeXukaz/1GsOyOLMBbauBP0h3sFvv0mfQDDiJ5+Yx9mfbLBtcypS5B7dBpq2Zh0qWOYQvbHXyUihCDDOZ+IVh9296lCqGlmxYBZ5AaSBNq/7vRCofTwJowOeymk1PVz7lbI5KXe5YxjTMrQJhOXuQ4Pxvh0PespcRjo9uMK4R0wz8gR4d7/o0cBFWY8NdTm/+6RVnkbzu556PDZkLwWttOocOWleY0Re69NELdc/iBpjgPskaCe1M8VEzb13HHEhduYAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJz0pMuIppVSbdraWPsvrhGi2vwvVq/mbsX8XAv4akU=;
 b=JGZoKjn14QmZmYvOVjraUJD0meFanjhNrbBqcyzAB7SFggs7/Ylis3O1ZyYgBnag2fUCVjoPz2AyLqzADMJBXo2WuWr04+z71wKc5FSn9V1gzgK2FN2bU+XTKiSP8glQ7TDJJzog3BYULZg8NymUirrcdtbovhWiRkl0Loe2W5WKZRqsp/mId/ieL4iDaya5JHAJgHwxdWQErx7srKUIwyA4yjNIykx8n6esvvHaWP+bWlWYNIYNZNECdzh800Zv2gaR2IkPv70mo9ji0hZ9tsxUEYraB3I5FuSFdjxMuPjDS5GAnp1tSDinGiZCfWWMQgT32B2arXFszyke7V6kmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJz0pMuIppVSbdraWPsvrhGi2vwvVq/mbsX8XAv4akU=;
 b=lVrkBawVtMy3FXzSWgyTytZOKXUg+mvP27tSEaShCbRYzmGXY9y4ZSlCx36D2l9VfOemB1mMTBzBF1Sd+a+Sw1xNx+PBVImTw1X8albGxJ9tS3BmbWidDL3myfPE6Psd/Ex3r4PlHU1PwB/ru/RpQjOqootEK3mzH7iaR8+exROKsst7EhknxpPUI70lwwr8FGmLH8luNrCyAKo27Anrcc2nq3dWOvxagMwaI1FWrb/8057N9mLp//WebpkHtWZOXPY7wY56WaQsMOPHITTrEmj8qcCuA8wMTW/Fbsd34ANX/WUkNsLL7frK+d7aUgrq/UegHq51ibp6CtTlLWX4Ng==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS4PR02MB11263.namprd02.prod.outlook.com (2603:10b6:8:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 15:45:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 15:45:42 +0000
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
Thread-Index: AQGeGvH8ZjIry23Y+a5bprIc/rGHIbc+YC5Q
Date: Sat, 5 Sep 2026 15:45:41 +0000
Message-ID:
 <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS4PR02MB11263:EE_
x-ms-office365-filtering-correlation-id: 2b6f5b52-cde7-4eae-6dd5-08df0b64bdd8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|37011999003|19110799012|8060799015|31061999003|13091999003|24021099003|55001999006|41001999006|15080799012|25010399006|8022599003|2607281247196008|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KdkkVUeQuWrKW5RCySn9wu8/WEwlzl5uw6ZeF7JjspCXhPDxzSNp63A5hbXH?=
 =?us-ascii?Q?mfoqfp16TFqVByS3NqjnrT0311HrxfbNUFgqHueiXrkH96sw2sHkJW3AmFUJ?=
 =?us-ascii?Q?/oTyF82qZ0TURdqiPTeIpQPDQhCHoqxeRqCfjJ15yMUFTxI8GvznRR9oOv0T?=
 =?us-ascii?Q?ZOoPjPy5ujiagTPUvkFAaYto9wzSyq1D0k8rGSGHGdzXhpst2SPNgsei4e5Y?=
 =?us-ascii?Q?z6T3jXgWztbRoqui9ao6S8tKBDLygVY3JsoxhOVnNbbuTid2trP2O2FoPvzH?=
 =?us-ascii?Q?xFBjv2U4Oy2BWixdkoQP2HP84XeKEGJvUKwzBU5DZtoEGZCaXEYbMYytv8od?=
 =?us-ascii?Q?uvlAOiEDXS/bFZ4rgjBrotdMPOP4DdEINRElYPF4ANkXxILO8caMPAVCuq75?=
 =?us-ascii?Q?VsRNVtT9Ukz2KOhp3bBMitlVLUbtoGWOV9m/jGq0NVKcOWvqnDG/MjNvv1QM?=
 =?us-ascii?Q?aSu12TbDOKR8B76sDNIwmq+SnLQd8uGtMj+H7VhV+S4+5/8KyCj/EL3TDlz/?=
 =?us-ascii?Q?qFd8pDMT8VOx5GXjAiB8YJlAmk03PNb7Wii98e2xS3FNJ+exjeCFXX0JOLvm?=
 =?us-ascii?Q?fHf3dawKvlgNcP/lDH4uOFFGxGFTIucB2mOgMIwgYQSES1yZiGgWi1aOa+5N?=
 =?us-ascii?Q?0tAxHRs3GY8uZC1x1X64uYFPCZ09Jj6xw1d8iqgpgPo92lDzbEY0GcXx/5Ai?=
 =?us-ascii?Q?DMBZJXXMYd2kyxU06TFIUXknKf0iSf4N9iym8Es2IiOmDrvzmENPp/aGxfyU?=
 =?us-ascii?Q?TCskWse7JLzOSXtUuMH9USZgejrVeyW5oWBv4n4r1ivdFWpx60aEMh2CP0Ah?=
 =?us-ascii?Q?QO+InsQYXMMi5kBJ0qX7205XddapoGcp1CiKU0Jm5rR1BebaEL5iY+QwxAnf?=
 =?us-ascii?Q?oEsOC81XFR5VaDOxjoXQoMEoXcpQn0KeWis+gQdxy8Ae0OIZaTsVNUj4v7Pi?=
 =?us-ascii?Q?oqzdLYVhAImN1i0bxacdJXmcBYDdyXTXyzG/k1rsL2F+V15C5bUmkIpd6kab?=
 =?us-ascii?Q?Pt/kbq2+Oqq3IP+A5C73cpIvSQJ5W7ekmiJ2HuEpQiDMOhnMpQsHd91rhAfO?=
 =?us-ascii?Q?6C1yClyT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aLoVXK5Sc8zLZAiTI7V0tbCgtcJEgecsfZOpJCGxK7ke/yNfj5bfQmaZNpX2?=
 =?us-ascii?Q?7Af0ZAvzvvSlEekjWJm7HF4+/nH3Zsgjsq2mAV2Xzo8mpSkoGUJKdVmf5cgd?=
 =?us-ascii?Q?qzu0GzWDUoFZ63WYeDdvIfXOREaHeLtStjq96Z26ybMWtoo5CZhql8nJt107?=
 =?us-ascii?Q?4Wpge0VnBO78ltIdNSWuJsDn3uoFTcjhFvB/a05BuqaKsOyzMDXY4ipU1taO?=
 =?us-ascii?Q?XCRzyq3DL59HotWtEHYHSqZW4NnQJgB9iD3E3RU3hxTN71byM0KSVEylz+bZ?=
 =?us-ascii?Q?J1W693OfnKTcwPqvrEQnMky0L3+gsItTsFLpTGrG5h+4LpF7UHUmmOi+4D0V?=
 =?us-ascii?Q?PNIjaVusN4kX+p1DPUEaPaXlk+L9utNOnZdskP+UwZtQfLnQV6lUJakmTHfa?=
 =?us-ascii?Q?s6epq4MGrCWAivpqNISSU1PAmGmBRwf3VniivKsxX+yoc82FmfDaGusOZ2m3?=
 =?us-ascii?Q?ZEDvChTN+lz9jVRv4Q75TDacCmKwmwn7MIODRe9O3LRCtHU328T4VwqEWPcb?=
 =?us-ascii?Q?JJYwyqslzNDb8A/PckcWe8KqzAWA2mMHn3wmFguGWPhxuwD+XZV4yAHmSGdZ?=
 =?us-ascii?Q?CLxFPnUAujKzNRMf4kedEnIvS5z6ed8bqdaxZ3LmMrboaVthcugsuK4bC2Ck?=
 =?us-ascii?Q?NLTljqxF8npBMKmQTyfhtR3jDcbtKj2Z8wxR42xkIyhIucCp2l2cDR/lOdrf?=
 =?us-ascii?Q?cKWqTCmj19i6AJWJifr39SHUHkMRvcSdB/z7MBlyr/sG36Izce/9MTRTCN8x?=
 =?us-ascii?Q?y1PU/WxuCXebgI2AvgmVt4d6IaE/aM7Y/7ZW6ek2tuQsodQuaMz3yJPVuvpQ?=
 =?us-ascii?Q?X1Vvx+lQKgCW8nwxCk03AGLie0wtjMxNo+nz8qCqdULrcvR7SYbXdE+51aa3?=
 =?us-ascii?Q?TEyvp3lzfyu6K6uX6i6n0eKSb+O8MOXNoHKQHAc/4jGs0pKNxTL/6GjN2vmL?=
 =?us-ascii?Q?mnXits4+88g5mwFkTenPaeFpftKbnOX1xhpJ01PMRLmk/2rN3IQn2m/ISi8+?=
 =?us-ascii?Q?mE15xPLv1GEqFwFNXaLrXp29BpZN4cfAtkipPTTxKyrsN2+s/n9VGFfL0FTX?=
 =?us-ascii?Q?ZxNdHSWPZO/hM4laxKEpQy2wI37lVuag6JhGoWJt7J/z1W8STpL8Em+iuLRJ?=
 =?us-ascii?Q?4lY+BTwj+9buFrEvord8MVgTwqDUhQEoOE2/+00tZR865t/h6aio54bs9Lyx?=
 =?us-ascii?Q?gldDSDMtGFbRCCrnWj4BG5jHCjkU3IkWx3fUascw9Iuh/36kzwrenr/jpMm0?=
 =?us-ascii?Q?JGGr0vTrI9WSzuAHBhY6WFCXiffl68sAo60+Yf74C4HCzMXmfoAp7DpHrAM7?=
 =?us-ascii?Q?kU1ohpilmQXe67aRxsBRYXRT01NFSfySLUbV/MCQcmZH8OfBJLBH+6AyT/V1?=
 =?us-ascii?Q?0NfMuZM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6f5b52-cde7-4eae-6dd5-08df0b64bdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 15:45:41.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB11263

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

Yes -- this all makes sense. Current code is clearly using the wrong starti=
ng
pfn in the highmem branch, and your fix looks good.

>=20
> The branch test is picked the same way, so a slot recorded in lowmem can
> be adjusted into highmem and the lowmem path then hands a highmem
> address to phys_to_virt().

I don't understand this paragraph, but that may be because I'm not that
familiar with highmem. Are all the slots making up a particular swiotlb
mapping either highmem or lowmem? If a mixture is possible, then a
partial sync could start somewhere in a lowmem page and cross over
into a highmem page, which would break.

Michael

>=20
> Take both from orig_addr once it is final and keep pfn in the branch
> that uses it. PhysHighMem() asks the question straight from the address,
> as dma-debug already does.
>=20
> Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has off=
set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
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

