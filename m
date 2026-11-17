Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945104;
	b=EmrMJpq/nyR+jWVc7N1Wo/3FdrreR/0cgx4czPQ5gZfsLXucjJBRZhUgtzuBhvVly/V6
	 aQ17RqvWhvBkI7miDFUKMtYUv5lbt8a55/pqXmFtNAPqtjMAa59y/EiIGPNF/k+spkhjB
	 UG+Sk1CX25N/LisJ/NCuk1xLHUVDFqe1tZnJccJr9cs/2r0ltErGbPxT26Wg5MKP/M9nl
	 iPb+VKDJni6+i1OnvEyo8464cWAJT756iGkQKYyQFycU3NHOvbyBYw0RMtAAsL5bc8ppA
	 Zx1tVluyWAbbRir5U7uVbb8RDPGQKcFnJErvFgyVnzeLLi8a3h4OKTHH5Jq07PnkfRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PPu/mxP7lbT4hBUu/He8e6g070SSdDLuVgBjTPXaocM=;
	b=SRAhzSzUmtmByuWj/9hkICOxjOs0hOqPNKGtNuZGnP9j96ghKbbQQE1OCubstD1oalE2
	 qsFe9cIDFWwxcyFaRyylwMGzkFAYWFjQNmOO5Is4b6VGtW1qPZxe95Y4vv7G9LVd/ty2W
	 442Du9tpWFF7EMpbqb2pyQourbamvCVQzjILDe0UglodnwgyUq5n5ZTgbV6zfogKpUa/X
	 VK1ya5eOf/8RZGwS2H7xDyP77u0fTeuVT2z9ae+Guj8r0Wp0iYeAAVme6JgD/XctPB1kL
	 Fzk/3YrSXziwyf+e45Dl/Uq+uniCXOcpUKNmNp2YsENJqkI8DvwPtJcXkyBJ1TrP8Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NGBwRM1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E252606A32C;
	Tue, 17 Nov 2026 19:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E252606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NGBwRM1Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBEElrGJxEv/T0XKQ9Z2DeWVQlHJ5X2oqNUTQGxNOfX7GuC1ALOZkGxGAuJq20U9ybyCU1Rp45ncqBDkbobMwgywvtKaYnAL2qE3ox0EkEox17y85Mc6d7e0V7BYG/Jr+7mozeIzGCHeisYzqEr/LPAqVy3lm10Mm5pKq99B7hvkR9W4eLm8/J4eQ9EIJm5UqLF/XeR7S2vNi5bGLqj4fDHzD441wm4Iyfar6IVIGXd2/R4Q/ewTQdTR4kGuMfHPtl9D5TPJWmlHLJlHK4yn0g3Ma6xl8AREn9c3J0DqPG0OK1O/wY3yNfh/tSsho0UmRX/UB4VavKA7tRp7O1qwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPu/mxP7lbT4hBUu/He8e6g070SSdDLuVgBjTPXaocM=;
 b=DImnMyVsy8Jai2UWZTOdLfXW74rPTXRWutxIB6BprO2KJeKsVCZwaZ00JHXfJbPiiVfhKSS0k+NIrnvtVTO6v9ITpHW6jx9u/sSnaZZP0JUFJ1vp3ATEJ3167N8ya+XByza0MSnv/KzluYnr1TI0uI6H6zZbdsc6xY/YCkEqH2e66qpeh6e5l2+VyaRxsraYRuAghheWYV95cobwADv5yjVOG9Kdyg2iwruN/LxaKEj5oubBmqoTX12OjUXk7eLtISBEQ1i5TxdUpaAUMW6SnpopQAuzRh0OZpxt3vqpi+WMZSrAWeMomXUMCPOepIkY1YXZOBfCN78Bby19Gvh3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPu/mxP7lbT4hBUu/He8e6g070SSdDLuVgBjTPXaocM=;
 b=NGBwRM1Q9sxFX2GbZ+R/p1xrMQ76Eh7fxDWAt2ts3TuOQGNSpnfQzOz45bjUx2MXhajJ7fIJTAI7GoA3hlzfZTdmM+pwJVIoLXjSrW33yZP5FZvaig0o/Y1IF9iSg8pboelOjP5oSXBwHO0+BTMYTA+8XkYvwQiS89EP4gT8O/PSK8zgH+g0qOXtAqg9H4ufsUprQyJz4dlNE7bhPZuMWhn2DUnGiLyQ8aksEnUOOOWPrhUsXJNynTU/avFGBKyGw5FyXfL6f8oG0WZmx5PUOqvg5azxTPjt+7ojwjf6eD2QaKVQrE4Sra2lnBX5KO3HtV73Vakl6IeHpQWrQA6amw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MIWPR04MB166472.eurprd04.prod.outlook.com (2603:10a6:290:d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:51:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:51:41 +0000
Date: Tue, 17 Nov 2026 14:51:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 11/11] dmaengine: dmatest: Avoid unsigned underflow in
 min_odd()
Message-ID: <avywRv126XZTrR3N@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-12-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-12-lee@kernel.org>
X-ClientProxiedBy: PH7P220CA0156.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MIWPR04MB166472:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fffef0-5d37-4264-d8c6-08df44e4332f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|22082099003|18002099003|261009223027099003|3023799007|56012099006|11063799006|10067099003|4143699003|261102123227099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	o2vIJEPiaxYLCgvQ8TlorS+GOFLTNAslvuzQqXe9tMml4tzGbTBmRoYjLg8MXfH72kxTLOaZN4ZCrO0CIEtvda9UCqIgdstWFGUdwdUnQA3XBc2RsIypntt+v71F2zcb+SyOk9V3jT/kXIARfrU4GOUm3uK1LMy8ww0YkfeZBOlw/l8HHafTicIGWWBXAk7bJyMa7QauI9Xp/2PhyNMsXtMcjYUC7f0vOC3226dZaAEk11TQAPmLW1F9FRY/KuKks6YCMmJP75GOIMsQ7cB05u4iKZBiDKOnq9/MFG7vOmvFG5b8UfU3qlbRwzAZO1RVl97GWXKD3KNOMKsdXBv/fCdbPuLGWVRSE66KoiYnnliuAp4eQ4kKQhvbBLvLcBfZ6TQFWZ8chwoJVybPh+3+5xWvuAicSkcXNZYmuWUhamLSE5caQTf2lR+B4Jt8tDGhNnuITmMcSXL5zfkmmrfUlHWZaZWFAVPjOd5IwQ8J/zxLN42dZK2w/VLuijHH2R4qqfF8j7+nZLlJuVorialT5A3ePNVKmAAG4kbfifoU7Yw7lRgfhw5YkgR5Xc35Rnjaxo2KU6b0OPENlqGuXAgaroP/fZeJ9Isj8geDPIY7NcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003)(261102123227099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rv/iHVUr0h18raToo176GO6P6PfU8vCzVfNgA8k1bO24oxOtlirBPGusjhSN?=
 =?us-ascii?Q?NDYZzJzm9YgoPgd3dpDSBuXClyiu1afXvXe515V2UACMJk6SlhMpLCDe9hHh?=
 =?us-ascii?Q?IuHHqGTCAysGVoTajotj0ButCRYmFErQut0Tmkir+LYjcnQMkO3m+rUozjOJ?=
 =?us-ascii?Q?g0EK0xchXHGTd+M6jbTt4N5YpH5NxEjV8URAne+HrhWZsobKe5FBQvLDmukA?=
 =?us-ascii?Q?oCczddKYcGmVcH6R4Hecy7MaoI7y2WKY11nGsvt83af8f5CkZDWM9mrgF4Wx?=
 =?us-ascii?Q?L+/ktxCQgmccUGGDlJr8ujvzPMkDNIAw9E+JCEoNH7GWLhiWXA/Q8LckochE?=
 =?us-ascii?Q?tTFc/1BT7YFvfPZuVQyfspcIYJyDYKA3g68YdSYl8Fdz5lk8b5i2bJknAWae?=
 =?us-ascii?Q?0NBDlv74suPQlFE/QXqKzOqL7Wi/gMiXr3qX061miBpVhyiTAVqQ241VLp8e?=
 =?us-ascii?Q?h/lEvzV//f96MG9PGuVBHTyTMZZMhwJyaneUAGRWga1GMiRP0qzl4+ZbU84X?=
 =?us-ascii?Q?U6U3KO40YKNrdDQduUk91Bi6gSI9y6mx0iyGiqEcnRamsp8fAwlExUBBe/jL?=
 =?us-ascii?Q?QNvezMiu17xZhnlcHMgEuff5q/mOpK62I9FlTxhrx2yMIaooSBdyw+YmOdhj?=
 =?us-ascii?Q?DV2OC3TFxWmIlE7N+c96SixhlfhuAF5PDCBcL91+fhze9iIPT2sh9GRu2q8+?=
 =?us-ascii?Q?MxOgtOre+qLjhj14tjJvEmPErvstfi1Wyq9VBbp3B0fwB+QJK2GyKaBz5g7U?=
 =?us-ascii?Q?PPCkNrE33/t+myIw0LaXFavIZrEoyUkUyajB0ShEBfEU/qW6MMU/cKEveE8f?=
 =?us-ascii?Q?U8fIK2OtMkvbp8j+0OLIwO+82bWjarIcgRwSahyIauVC+2MQJ4cYe79NIugt?=
 =?us-ascii?Q?QIRUxZEm4rQPcy1sZgoWaL8/0Yw+FLTPX+md/pl5X00RYNiniaYfqQex8C2J?=
 =?us-ascii?Q?mIbxB712lZ53/0+GYJ9hXH6DVD8yA80lBwyx17giqIsdJyKCj2zYUSc8IJua?=
 =?us-ascii?Q?kC5ZMhWd6uzVzw4A+4LQWMhq652w1ggHjsdm/ND/lqepQeBzQYRRsqzwwLxy?=
 =?us-ascii?Q?GzjQOQrGEGaaIjG0hpDzzUMIKizDmZyGtArwGwHWSYSWHQf9hsKJrRKN2unc?=
 =?us-ascii?Q?yOZ7ucdVh27tyvUKSuVZ75IJIuhxIOpcVU9PWL+TXuyCGmx8ihGf56jOVF/M?=
 =?us-ascii?Q?0vbm0DhbAz5/Otg5xYeFqkQtdVj4Dr3wgkNgjHBBLQczb/YaxukfkCY9arNW?=
 =?us-ascii?Q?WTx84PoRbWg13vEsJIOI5wWK0CWO7j2+ljwZePUpWkCfwrP3+a3dBcO52t05?=
 =?us-ascii?Q?JNURwO5jj9F3Xwwcy+S+q7hNYiODaZ/0zEK0GpjdX4iy0/lmQoSI61ZfkOPD?=
 =?us-ascii?Q?SsCZWLVWSlhJDGaHnmoBdsJOnLwWBWp1Eud1gMmIFdXiUcjtnTxbC44Z7p2M?=
 =?us-ascii?Q?Acz739Q8TjXSUDDFFRLb9LL2Z6YSLpue9HNO3qvjWaR1j8CzLYNDjxgc7yVk?=
 =?us-ascii?Q?ur7Z9vEuQeRZ6xRO1XFJDvSq8dqi9gFWkS0b3XRXTZO+/lXSw2fUPbD5pXxc?=
 =?us-ascii?Q?/Qt8WvSwFEdxDL0ceV5TyUKifz+yU9LHBfc1HTNoM+8jKIuhg9OhI7fL2fzL?=
 =?us-ascii?Q?7m6oYvsXx9HhxEhsL98wPOJDInSKB/PU9qRydG00KctApAPgqPSqqYyNuZzr?=
 =?us-ascii?Q?0+y30cib/aw1sqrAERM7boUC1L63Pwrd/v0R7BZVso31MUgDGXSLSAZMWKGO?=
 =?us-ascii?Q?Su43oEEXa7tq1C2iozf7qEbcMxJFrJu26CZMFgVAcLywsaomPbEE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fffef0-5d37-4264-d8c6-08df44e4332f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:51:41.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWoHqfPXxL2v+6CZMEGLsPAupgW1xX2XXuVkgePtx2eXIl+WskAWwA6l4dciouijIGsQlJpa5Hodbtx6uNmEIgBZ32O+XykpuwgX7XTnf77INyU4eUNT/wVB8XYYP2Da
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB166472

On Tue, Nov 17, 2026 at 04:37:12PM +0000, Lee Jones wrote:
> When either argument to min_odd() is zero (for example when a DMA device
> reports max_xor or max_pq as 0), val evaluates to 0 and val - 1
> underflows to UINT_MAX.  In dmatest_func(), this sets src->cnt to
> UINT_MAX, which wraps around the (src->cnt + dst->cnt) >= 255 check and
> causes dmatest_alloc_test_data() to pass 0 to kcalloc() and dereference
> ZERO_SIZE_PTR.
>
> Return 0 from min_odd() when the minimum value is 0, and abort
> dmatest_func() if src->cnt is 0.
>
> Fixes: 8be9e32b310c ("dmatest: adjust invalid module parameters for number of source buffers")
> Closes: https://sashiko.dev/#/bug/linux-ca967586-4fc1-47a3-8616-4a9d21fe7455
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/dmatest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 2ae3469397f3..5f768bb9a29f 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -457,6 +457,9 @@ static unsigned int min_odd(unsigned int x, unsigned int y)
>  {
>  	unsigned int val = min(x, y);
>
> +	if (!val)
> +		return 0;
> +
>  	return val % 2 ? val : val - 1;
>  }
>
> @@ -650,6 +653,9 @@ static int dmatest_func(void *data)
>  	} else
>  		goto err_thread_type;
>
> +	if (!src->cnt)
> +		goto err_free_coefs;
> +
>  	/* Check if buffer count fits into map count variable (u8) */
>  	if ((src->cnt + dst->cnt) >= 255) {
>  		pr_err("too many buffers (%d of 255 supported)\n",
> --
> 2.56.0.679.gc527c65306-goog
>
