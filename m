Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740695;
	b=EZ68uMQAhnrfGNG4Am44TZpniCPvKeT/1qIMAT9MiwvOTEnjndUtp18IHE6UmyBqksqE
	 Vh6g8Yoa721r9/1kj0DlRoERz5nBO/jAV2X2izyF/EdT1Z14H/ULHzVVTDDOrvj879+lC
	 V7a+wIcpCTu75MWvyQOXmvfbkjsu1ORXvePTuQX4qgT2hR0tJTCwhaY68SxTwQ1YTtLxf
	 20iIa89vofqHPhNftTSOaz3nV769ec+2sj3mPEKJoWTPabY6dLoEMw5nPl72Evho5uULL
	 qkQGN6PJhgd2G7VJabU912HRJyeyTOhXWA28/BWOW7uWGF5GxEPcIjLYvJu+hDUiCPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740695;
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
	bh=yFz5jL4s9vyAgtGOaidymvxXDCBNaKB+dyG6JKbPpAg=;
	b=vdDWBw/s8rHSJFQl1n7ghHstxUXn4prtRIHbI/6P5BMiBmlAKEck4SeDCN8F/0EZDgtv
	 /IFA1LMdbXaIa5BPm0Ef5KcUXfg4Rot8lnB5Ec8myV2S0w5RqC9/4wWLiZo7XfdtLz4dx
	 iNxdE2Dc5x15NkWwHJhxh67VC4YoRVRz4UUPVhbhXF1JsV+ShfmF1xPE6Uh8vb1XiAuiu
	 X+6RGvMITYeIQii3XeRXWtA3gMVouyai0684RDY/Sj2QhEshiTg0ZT3B6d2bA8mUApejc
	 5iZDbQRm3E7WSOBsX9Am/l01kvV6xet+tnlpaDouFyT0I+tPon8hRHWteDgJL9g+7Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Xq38+e+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.4
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010004.outbound.protection.outlook.com [52.103.2.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785E1606A324;
	Tue,  3 Nov 2026 21:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785E1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Xq38+e+v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS1tX66EBneBd5Th7tnIDhF7rXDuXRNjmlXA8qbN0YEGp1HT89Yi5lJS/PKTx53hUKmB53FnBC66pjNA4nrwrN4r5dfSYf0UozcNW72ktbyfjZARbRUz2+DC13ER3FUkaq9t3gK8EDJlz7qsq2l8d0mi6w9aOTehZ05ddsKHupJTJ5aQzL1ONHesr9JNPh4ZWGRIbj7baueZa+qxejZQnMHlgImnzk5ZCBrQBgQHJHzzQm/c0kNlWC/YpGvxDEtwOI8diRXorXwl4N/t7IEADgQL88tFBSMS/xF9XmoH6QaSOQVoo7krVLsTDBEoGmUSHThMK3Z5YK9axud0ixcu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFz5jL4s9vyAgtGOaidymvxXDCBNaKB+dyG6JKbPpAg=;
 b=r6PZd2hRYNPcbu2Y686bK6uKvFL2JI0OP0wRF48QeqLsRGiuQHMrOdnHitNbWOFrnpRt8IFAm/83VckDu96/tDBDlDFhmrOC+mkeDxqBuZc1ZjPtGFQoPYSFC0DflWOPWFwFqx597q1EX0CBcUwW8cuXw3KBmohQtmTGQ/gN00CoDAC1IekokrX53rrgul3p2JpPWXQpER50CDbNezQJ0lfVulixewp1MookE1rlrjQkmWgaWn0nc1wdZvMZR2djW8mB16kjCDzP90XhwGRcDWnz8icwxZ6xFduMf61aEzCeEsjVduu2ze/clOHc6K81nMyrZ6B6SDBOVXzNhpWf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFz5jL4s9vyAgtGOaidymvxXDCBNaKB+dyG6JKbPpAg=;
 b=Xq38+e+vbUp094R9HOtmPl82kyn09camm4G6b5q68/QReka+x1Q/16KhAikYOMH2EK4TUvp/QB4ID6yWNswVUp2SddTiG3d+WykqGVohW9DS4yQrEDJRIefg+Ov/dBHcFjl83PRe8ufY8NLPx3mcuT2+/vaSt7yh6cNF524Qb3efYeS3LWRQwlGqXHiMLIXnCsJtV/8dZvlW/8LIkex2ncx3I/rkHwgiwRaGJ2vTUj2qwayXsRhF7dmsMYBRzJOQdAq20nqecqEVjGLe7lkn13jnHv0LUpAWoXDBrSuAgD/EMR+x7rwU1G3PRVI0aHgSWjhhwiEaRG4qInyCBBfFLA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by SA3PR02MB10041.namprd02.prod.outlook.com (2603:10b6:806:39a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:18:13 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 21:18:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Claire Chang <tientzu@chromium.org>,
	Konrad Rzeszutek Wilk <konrad@kernel.org>, Giorgi Kobakhia
	<gkobakhi@asu.edu>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Thread-Topic: [PATCH] dma: swiotlb: Round restricted DMA pool size down to
 IO_TLB_SEGSIZE
Thread-Index: AQHda6sVxPkkJEjXP0eh57b+lSuFRrcc0ESA
Date: Tue, 3 Nov 2026 21:18:13 +0000
Message-ID:
 <MN2PR02MB686381EADCEECF16B23214D0D4692@MN2PR02MB6863.namprd02.prod.outlook.com>
References:
 <CGME20261103155032eucas1p10934ce1bc0c0e2f1fa86891fb2626862@eucas1p1.samsung.com>
 <20261103155016.1107958-1-m.szyprowski@samsung.com>
In-Reply-To: <20261103155016.1107958-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|SA3PR02MB10041:EE_
x-ms-office365-filtering-correlation-id: c5ec4536-fad1-4afb-bcd8-08df39eff84c
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|55001999006|13091999003|37011999003|51005399006|24021099003|41001999006|15080799012|19110799012|8062599012|8060799015|4140399003|25010399006|3412199025|440099028|4302099013|102099032|1602099012|10035399007|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oFghlKAdKgDUH1m5i9kprcazxb84ktqn1Q4ZcvB6sBWQ2wo6jZD/q4KOcMPu?=
 =?us-ascii?Q?24gmFDmI6mZS64tZsbzY3Ud1iYoYCU33tJfORMGF46yfU8WlJvOPvT/9/fiB?=
 =?us-ascii?Q?XE9QWvaZvUuHdJOm6orYBqMN8ydfNhDrTUBxeaxmtgPj8FYYRA94dA2QsFLE?=
 =?us-ascii?Q?bLva8u2Vmn1km2rTZuixH8sas/tXoPvIndeMbf7tG5Drv4tFN4wMpl2u8oPB?=
 =?us-ascii?Q?XR26r6G4fMFaJ17YVsvkUBKyueCTD4xcibRoBeTBvbPstJavaO8/K3M5r9rO?=
 =?us-ascii?Q?RxF247k4KahqAlqq/usGRA3lpGndDIveN5fblGa1xD3O/+yzVS2OAt+jtgfY?=
 =?us-ascii?Q?9qBKzZEfhNX0058UJm5cHMk2+6Jyihkz3H24e3UaQCmOuJkgeoV97PRI6C+G?=
 =?us-ascii?Q?Cbr2weHPC3frkMepSHusVXBYrfW00z13Y86Ncc8M8hPKhFBoMtG4/C53dPPG?=
 =?us-ascii?Q?tR+/xcyE9FXyTGhOYphcP0kBRTGdHLygs6Ld/c04tYHZCXKAN87Q+ndx0mPr?=
 =?us-ascii?Q?DiO9R5ixZ6VzKQVzCnYjQGUQ4kee/j/m9YYhUIrvkUbtOeJjsuBpJFUkb7Sw?=
 =?us-ascii?Q?dnIgW5AW0jBh2o6QnxUnhuq/n3vDU5hIWhrkCOVmW/Ep7xIdjQsfJZTZBxgx?=
 =?us-ascii?Q?SWgk5bV86Nu0B6UErNAiRVNrLQZMlUSFrCDWRM57zSQxe5yzWSAOEnyJLH1V?=
 =?us-ascii?Q?kudoRuruFnJl4VrH/gALLG4yb981E3G3y+lr9qy1XbIZaQ/vvjU+g3by9rX5?=
 =?us-ascii?Q?RrAnLKhU4MRpwmbdX8kEISjZ8mZ8tzSpDJGJT99PF3ht1ShmBoQj1P4Li2bK?=
 =?us-ascii?Q?NT6i33Z0W+UTrpOMQomRcFqdJWm5stQe4NSKTrutI0Lcv2XwksBXhmDYQewM?=
 =?us-ascii?Q?ErZfwvyJ8KDpIPyKGchA9vQBieO80ByJLbffrTTHP5VXBZhCsGZrLn5pgxaG?=
 =?us-ascii?Q?qNrVAAwr/8LXnCRLPXC5ME/Xf5Ds9VSxWAT94fxY0On1ACRtcfIrJINhzf/D?=
 =?us-ascii?Q?69ah76jQ5svZDKcwIqYegsXDxp1VlQvdl6SVbBiuubCa1dquPgPO64wB8UFk?=
 =?us-ascii?Q?7iKTvusWu4M54QxBShxoIoizizBzZ4JPs8BBBjE/5YV4cwZNPXs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iLOhBrz61MCe7oW2UZQ/MBZlyVuZMk4Hp+pPyL+M+XvCyI8ccoVfzQQ/Dx7z?=
 =?us-ascii?Q?VaGa1HZsp69ELCwCc484JgFfWGIEs5bbru0rsq+rhCotiOcBh+Ds2tWQBx4Y?=
 =?us-ascii?Q?tyyl74x8wDfrOXE2NkaZ/tfq2eLtKpO5VxWcS5ybYZJXCxCSMtSx4FGdDALt?=
 =?us-ascii?Q?Oh7MsvEGrZtbFLu4cfWbHPtrVovMD0G6RNqhhMLeOTOUlaILFYSpXUaDsGLr?=
 =?us-ascii?Q?x3grM/SAIqPfdXoghgIKPrgqF2g/8sZcyg15f0FlUZb+SpfN6I82niAicvJO?=
 =?us-ascii?Q?2J4LvRW4UBnJehznnyA73AxF6K6wGIS71SpFcDVl4lGUhb86pBMIXV3zACfw?=
 =?us-ascii?Q?PjjERQyJsclUgVC0lSB6s5FdcsHU+3gNIpq74d8SZ/oa6DahMRVoJtGsk4s8?=
 =?us-ascii?Q?8kqXWOVGfcMJ7OE3g3jGk3UM0/BR50Jq7N7HvWBqNhly9k0j+aDVWodU7oRV?=
 =?us-ascii?Q?SaXdNATf/4iBguvr+QYBRkmVh5cI038BvcrxecCp/kFM+gNNnY3AnLUZfTOS?=
 =?us-ascii?Q?mS8AeB5NB0SY+ftl75TgslZerNW4u9QB66k9nVAg3qgBTkVRxNfyWy3xD11l?=
 =?us-ascii?Q?7CT79qCpigKaE5wgvuzTo6GlOh3URFfjiN7pE2eNXAUvEne1Df7QWxKJgTMG?=
 =?us-ascii?Q?6JFhcbXCWmyqnrkWt6WT337VHbS+pp/hIZDAIWr6vLRNPkoxBeV9lDDfNgmx?=
 =?us-ascii?Q?ieHXjmospWtcSaFnGa5GbsHQU22qSuOT+CT0DcyFRPRlYKyXLyIskybHU5Gp?=
 =?us-ascii?Q?BIZ84OSPr28t4mkF60/NslmRQuqtFW1fcBvMm9COEwPVArXcOIK8fOyFQnP9?=
 =?us-ascii?Q?XgpjC52vMKhqo8Lnv8ON4LAR1aQLRGZSDD9L9iRLTxOHpePK4I3BPCqYCv4a?=
 =?us-ascii?Q?f98Rrz5yAQgCrK0lAPN/K+yImwt/rTUXW77f3XVtINPPdeqEZK9SdOjbzN83?=
 =?us-ascii?Q?i02s/Kx6m2vR6UvETqMawVOhMAquA3JABoogaE243dsDNCrc/ejPLf6OKFsE?=
 =?us-ascii?Q?CB5ydziU/ZD9txsCnrnwgdCx8Y7qYmfNwYdcUV4pVGs4x3VX42Zz5J6BY+ec?=
 =?us-ascii?Q?/NF7mmlKDh8eZr+fBmPPv+Rek06gSaRJXf+sSLGTVih9ubYTmmrOzXUaI8lt?=
 =?us-ascii?Q?i3kXL8+LnsBxSsbz3E18ugFnSlRmUo08LSLm22BOcnJGtEdMjDlqPcEFWJv7?=
 =?us-ascii?Q?MAROHen0yAgK/6V0NtZxUNyl3SrqlxNqlggCAsuFQbrggZo9o36M2iOsaX2L?=
 =?us-ascii?Q?BzZLEFne448tm9tkRpnVzjRfy4IKLFQf4T0ckym6AZsjCq7Ya028dwroT3gD?=
 =?us-ascii?Q?xxnn0WB5FsVxLGC9o2i570/zWCiJ5H2vJxivrqxp7EP6T8fCS5AwINYhJfRD?=
 =?us-ascii?Q?RCh5Ua8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec4536-fad1-4afb-bcd8-08df39eff84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 21:18:13.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10041

From: Marek Szyprowski <m.szyprowski@samsung.com> Sent: Tuesday, November 3=
, 2026 7:50 AM
>=20
> All other paths creating a swiotlb pool ensure that nslabs is a multiple
> of IO_TLB_SEGSIZE, and the swiotlb code relies on that. Since commit
> 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization") a
> restricted pool can have an arbitrary size taken from the device tree.
>=20
> If the pool size is not a multiple of IO_TLB_SEGSIZE, the last segment is
> partial and swiotlb_release_slots() reads mem->slots[index + nslabs],
> which is one past the end of the slots array when the freed buffer ends
> at the end of the pool:
>=20
>  BUG: KASAN: slab-out-of-bounds in swiotlb_release_slots
>  Read of size 2
>=20
> Round the pool size down to a multiple of IO_TLB_SEGSIZE, wasting a bit
> of memory, and warn about it.

I'm not familiar with the macro scenarios where a device has a
restricted pool specified in DT. But I wonder if it would be better to
round up instead of down. DT has specified that the device should
have a restricted DMA pool of a certain size, and rounding down gives
the device a smaller pool than was requested. Could DMA operations
then fail because of not having a large enough pool? Rounding down
also allows the pool to end up being size zero, which this patch
detects and results in a definite failure at device initialization time.

What's the tradeoff in rounding up instead? The device restricted
pool at least as large as requested. Presumably, being larger than
requested doesn't cause any problems for the device or its driver.
The downside is using up to 256 KiB more system memory than
expected. In an embedded system with only a few MiB of system
memory, maybe that's a relatively big problem. I don't know the
scenarios well enough to judge whether using a bit more system
memory is better or worse than the device not having all the
restricted pool space it said it needed for DMA.

Your commit message also mentions "wasting a bit of memory".
What is wasted in the round down case? The rounding down is
done before the pool memory is allocated. I would have thought
the wasting would occur in the round up case, where the restricted
pool is given more memory than the device said it needed.

Michael

>=20
> Reported-by: Giorgi Kobakhia <gkobakhi@asu.edu>
> Closes: https://lore.kernel.org/all/20261026032007.1957949-1-gkobakhi@asu=
.edu/
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/swiotlb.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 2c57b49ac7c0..a68f35192582 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -2007,6 +2007,19 @@ static int rmem_swiotlb_device_init(struct reserve=
d_mem *rmem,
>  	 */
>  	if (!mem) {
>  		struct io_tlb_pool *pool;
> +		unsigned long aligned_nslabs =3D ALIGN_DOWN(nslabs, IO_TLB_SEGSIZE);
> +
> +		if (aligned_nslabs !=3D nslabs) {
> +			dev_warn(dev, "Restricted DMA pool size %zu is not a multiple of %lu,=
 rounding down to %lu bytes\n",
> +				 (size_t)rmem->size,
> +				 (unsigned long)IO_TLB_SEGSIZE << IO_TLB_SHIFT,
> +				 aligned_nslabs << IO_TLB_SHIFT);
> +			nslabs =3D aligned_nslabs;
> +		}
> +		if (!nslabs) {
> +			dev_err(dev, "Restricted DMA pool is too small\n");
> +			return -EINVAL;
> +		}
>=20
>  		mem =3D kzalloc_obj(*mem);
>  		if (!mem)
> @@ -2034,7 +2047,7 @@ static int rmem_swiotlb_device_init(struct reserved=
_mem *rmem,
>=20
>  			mem->cc_shared =3D true;
>  			ret =3D set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> -						   rmem->size >> PAGE_SHIFT);
> +						   (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>  			if (ret) {
>  				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
>  				kfree(pool->areas);
> --
> 2.43.0

