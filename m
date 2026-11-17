Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944975;
	b=nEk5StFOVi8RuD2cVdIdkFuSmWSE9vcUwToTS/KlyRuDKTj10bon8Ut61Fqtef4zg8Wz
	 tJW8TKe9KXCvuSmmsnCZkAYvCoO/ZzNmC5ncFMGorV67jZH8wxZfxKM2Wojplro9dlj0e
	 EU1KAGxUeG45Qw/sDy+g60BcUKkeZKNyMz+k6aZgoMQJOmiI4BjTTpWcx2AzX7bJJXjwI
	 tNxypsg5gkgkykuzVy1+n3ncidvoyu+RmoBuhvIHajeU32AwV7P1ZECdAznO+pz0VXlvs
	 OKC5Jb6b4xTbqWefYTV1rVsPo+C380+/COoZapjAtEBwaX4pIR+uaR0iM3ls0OAdXng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944975;
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
	bh=iIu8V+vZ8L7T7w4+IhM21agSMFxAAC71iqpRebDH9L0=;
	b=Qqi/+6nNG7F6wEq75Cce3VfhV+4A0spd1hfzh8SrYPD/3bN7WDkSlYQQR+Stp/SlAir6
	 ksd8fKGydcUbGm+QwO13ZD0lSKLeaPlrKYKRomVTavdL2iGMpxQ81RchYl9EYwZF7h5v3
	 SAm/vVRN7CLmcH6L6wRewKP3E7U/nbM2K4bMFAeGWVjquaYxxZBQ2VZGyVmyJ+51pxHvw
	 oAw67Ab1SyDNc+ylkQ2zDSkmTn+HnemC7Li7yWD0xjGO2DqT6i6w8X2/s9N3x1SPzHgvu
	 TxPqfKh/oaYV3ThAZGA/wgD5EBZuyZXBqUCApMd8w60CXDxTGm5Yex5sCKQlUYexUUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bglermCz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.23
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FB606A31C;
	Tue, 17 Nov 2026 19:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bglermCz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWGqCWBTXw8OriTC01JpqCTneqfxDnxVbYEqi1pX33qJI90kjUgI/FoqGCJb41Z6J0QwOKnKbWo15lr/Z42Eamnd7DTOm/1Z4+rN9BLjU3ppe3OMux3c5o8x9bcgE2A1nCJn2GFPwIN84HwodYnn5E6bFYCWvfGRipGNv4j1cBN3xg+QIPKK8A129ZF/7yTw2Z4ectegyHaJOogrjf6I+mpzc44mvkF/AIXC1kox+uQkpr+oQvy4LzrlUcvKh/XbgMiWjNytYRtmtKDZ/MHDvCKd1yMZ7ZuVjkeRhVFddNuKFkcG7ywOnMOhDBPIY5X8k3mdejXhQyDxRUiFT6YAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIu8V+vZ8L7T7w4+IhM21agSMFxAAC71iqpRebDH9L0=;
 b=uBWNxYp9U1QD/h7AdiACl6N9Kv6MuZxlk1esIhccwHXOaBKhvL6uQBJWTuE7YjS1IQl1m1MBfW9ncJkhpfG5e1GmU3ALqAgs47UwCo5yvOf4vx3x0BrFw6OnWhR66nahNxmDmIDZKPXW3gxVUil85eoz2Ied83i03BldGopA1G8mHSxBWDY+rtljp6mDlNeSAEBuH1UWK1OqpHAFcSb7lHVlsHUCSGs1yalk/motclf6ZJrtSU3FWMd7Vb4wLsqf3P02nKh6TsOFjz81C7TJD8HJHjh1m30jJuJ8q7KjjnFq7GkGl52OTAY3QKOwSfuDdJ0oINrDULl6pDoZG4rnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIu8V+vZ8L7T7w4+IhM21agSMFxAAC71iqpRebDH9L0=;
 b=bglermCzurPbS3zeIGIpyo1cxKC4zNoXTuqToPIvM8MBR3dHmpAQD7Bx7mX6fmRNTz+B4jt4iKyMLiL1apMJwciIIPZf7ZhJag58gr/dOptLCw5QCGH/q/+4jscaE/HV1AL7zLHjJTXJltv2LbEG1SIw5Lbj2HnqfX+WuU9aunR25T2zks6oUcesY2s62/+ZzoulwdiXsqr3zr1HStq1f5w0JffLn7UmhpvbxsllpwSkPthy2tGCCRoXr7azCwB93iYD60gC5h5B9Gu48UYJ21N03R9OhILOvDNRCzan1QVdCAc1qD5zB7jQz+EJyqUHX1Xl5F8ripTXMvfZAG6ouA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB11051.eurprd04.prod.outlook.com (2603:10a6:800:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:49:30 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:49:30 +0000
Date: Tue, 17 Nov 2026 14:49:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sylvain Munaut <tnt@246tnt.com>,
	Grant Likely <grant.likely@secretlab.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 09/11] dmaengine: bestcomm: Check rh_create() return
 value in bcom_sram_init()
Message-ID: <avyvwqRiVWq6PCr9@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-10-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-10-lee@kernel.org>
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: bf62ef4c-f0ea-4000-7706-08df44e3e51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|22082099003|18002099003|261009223027099003|56012099006|4143699003|261026140227099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tSq5e7iL3igP+a7Wgii1kDZHfPKW2QW6x5+rxY4kSf3D72yXEFk5Zeubge5F0SrP3rdpu7TlgB3nCmFoZttoKjaqtf+BlcFPuIBD/3vOYYwIBl4C+aEK/yEkp12dqgu/egECKgIrR+amjaOX5QzTthlG6Eh1RlSfoGWZR4oIYAIabrCl+YzXvdyBCut+Lv1TliNWcv8MeuyfRGqzxIGZHoKs4CTxujPErJtUPjQh9HpPNKMOVCsI12x9Eb+bar11V6c4eGguvMt8dQSiJX0joMRp23suaU14v63zcQd6yK4fOXIqMCKIbecZJd1dnDw3vuk5xuSTh7EsjBdkCQTEJwh7Rfnvkf3Q8znlLKKLVRm6893ksBye52YIxTJob1vtkEzucwLAUgjk/04wsG4QPdbItJuPCZPX+wPOadFm6pUcAG41adjQeAEfyH+boeqmjUdjC+67oStithCOCq0eJ5kQjlg/kWV2FN2iDCRHqE8z/d/a+n03+5QP9NUL379NHnKx7t1OI/drTQjnFVc3MdRn3kelHuVlT3clnIA+JwGULXYWV0MHSIRQD4/9V8GF/uIxHpEAghW5Z9z5aMevybZJqa7S/vSb+asrYaoPtSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(261026140227099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2q8/4Exkt4cEBn0/b/vFTsz0bH93be/8qt8ALK/gTCyLFs+1RUkEg8dD/W5?=
 =?us-ascii?Q?BpBXLQEb0pChElxkl3YF6dVurjpk+YWFhINWIbyizrACHOcHescoGUD1D1N1?=
 =?us-ascii?Q?XL+eOJDxMoLPLsQA0KfrIlFE2hN1gSYCR6bjp6bc5N/QFiiQdoueaqL8uEoU?=
 =?us-ascii?Q?6VY/98lToKXOWhf9jgkBCiM0p20nRZWJx5bEUcgy8k/1uuJ8SCABrwtKXF90?=
 =?us-ascii?Q?ZtYHseOLT9BjsCPKJPm1fSGHzhbAQ/cqS3kQZVL7NZ6CHS9uIrOjI3pzSP6I?=
 =?us-ascii?Q?wIbmkfEvvttyGeQJ2yJ3Jn276fbdRCTnZt0MeVU5gDegoQ/y3RJS2hOAum4k?=
 =?us-ascii?Q?gEOXfNigaC4yjT4cgArAL+2cXTSDLvyQTaR//w3+ikOQh1dPzfRlqQzNiwlB?=
 =?us-ascii?Q?NNP8du+YIEkL++mbq70kSe+BpxC9rYY+xrOv8ii/Hi1GeoqnRQgNxACl96zH?=
 =?us-ascii?Q?vXTJ9/IcaKw/9bYNH9jCfcTEDzeWm1g0jpcupUbaaMT7UQ/S1ZoSm0+1tdgS?=
 =?us-ascii?Q?tDysqUhHFpRk4RXQE3fgn0cvvZqri/DGqBrRQvwcPuR5X5pN+cKv1+z12BuH?=
 =?us-ascii?Q?JeFWz45PX+AYWv5kMs4CFA/YAjBBYLv9IJ5H4fHXcRfdSpo2xtdSZsPDxHt8?=
 =?us-ascii?Q?a8WLgfMf60u23R24ztljHTOPLiqo4j7xUkZ2peFBj9gWsoJGrAjoJDGVjn9+?=
 =?us-ascii?Q?fBU+uBm3bvKvUXeV4d5h5CcLVab5JgwPtzo3M12JztgP0JPPGe8J8BhJGnnC?=
 =?us-ascii?Q?SsNahjWDsA6Rvjtf0C2CFtnrWBYQu+ni1UGooPwrK5GDMrsSlGD2Mtku/D4L?=
 =?us-ascii?Q?RKf0NEzLiOhS1DJ3iieL0nHSorDyzOvNpbsx3/TrFtM15veBo3lyFnYbkRV2?=
 =?us-ascii?Q?84e0dyQAU+zZOubIz+zSDnYk3ArfrVDq8bAE28HorSd+N4ylif6LNC0jPdrw?=
 =?us-ascii?Q?DetCZIocZk8Q8zjO94XWEgB+r1uzQHSwMXvT+bb/Z0epQ5xYpeiiOsQZP395?=
 =?us-ascii?Q?V/mb9dltY0lbk4Z9+kqZ2lryzC9g9yUrJV+UuoW94atErLn1huy/sxP9G/CX?=
 =?us-ascii?Q?UN5o3mxrqOpBxxLUWj4GzHVcMI1huyBXstU5l4qQX8cTGV8/yzoTJgTLjouk?=
 =?us-ascii?Q?d06dDHO6LcQHaHC5CAu2GH+jC2UICCYOb/Uh/anouXzFKMB41rgNviTI3ze3?=
 =?us-ascii?Q?GfbjSynd5DGD3y8w45oT/lQlgZhzAiVNAolUiJz8e1ON247lw6AnCQKWZpjE?=
 =?us-ascii?Q?4EOzdLZn5cludUC+CD2D3Ej0IstwIFCH5sRP/bgc3emLBGbmMFU0ikKNHU9V?=
 =?us-ascii?Q?55JczBZMgvvBthxS+1az9zI0PB25KiwvYN4CNybqUjJ+obfLUIFXSp8HrPzl?=
 =?us-ascii?Q?K11Gg7oXCMunrqnpKwMWYDlGzHmN8A7Xv3ufSl6Qam5AG4Cu3LudAftc2sui?=
 =?us-ascii?Q?14U+ypinVvVflIr7QL4fKokNlhX6CM27ZeikqqgSaRdM0m1xfM5cl1w2M+Cy?=
 =?us-ascii?Q?bzwt44hKt5cuo72ZdMokB3VyNXsu8gKowNeXkQDqm7L9qrWsCynEe5frrTbE?=
 =?us-ascii?Q?veKkA8QtT2EXI4TJfrAEnxDFOCoMgeuwypmP1f40uVkG/tAl7oBNQpmTQPaf?=
 =?us-ascii?Q?OA9eu2zpK3dyZ6YWl7l+Wig5PyqKG0dibTvxGnQfNsahvhpyMoi1Pjh+NIS8?=
 =?us-ascii?Q?ELnsqHDY7Tt1hnM0FVs1mn5AuqOb4ALXZE8lnEhPr3U3faB7EdNiReCGiOlC?=
 =?us-ascii?Q?XzytEU0RzUow6T/ZeBg++Xha7E3UF64+7tLfgzC0jPZA/an8HJld?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf62ef4c-f0ea-4000-7706-08df44e3e51c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:49:30.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTJqVcFMdAjIWdJbMRqHhNL3uHLdCo/z36m+Yy81n9nv361x4mboK61eewb3E0UGsXTdeOJs8pfN0YxO/7oEJOmrat34CuiKqur38FIpbOho9TugbJEq1+u9SZa4ADRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11051

On Tue, Nov 17, 2026 at 04:37:10PM +0000, Lee Jones wrote:
> rh_create() returns ERR_PTR(-ENOMEM) on allocation failure.
> bcom_sram_init() assigns this return value directly to bcom_sram->rh
> without checking IS_ERR() and passes it to rh_attach_region(), which
> dereferences the error pointer.
>
> Check IS_ERR(bcom_sram->rh) after rh_create() and unmap the SRAM region
> on failure.
>
> Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freescale MPC5200")
> Closes: https://sashiko.dev/#/bug/linux-c3caaf6f-9a88-4451-b40e-d061c1fdeabd
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/bestcomm/sram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/bestcomm/sram.c b/drivers/dma/bestcomm/sram.c
> index 09ef5142c26c..df4d90cee465 100644
> --- a/drivers/dma/bestcomm/sram.c
> +++ b/drivers/dma/bestcomm/sram.c
> @@ -88,6 +88,10 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>
>  	/* Create an rheap (defaults to 32 bits word alignment) */
>  	bcom_sram->rh = rh_create(4);
> +	if (IS_ERR(bcom_sram->rh)) {
> +		rv = PTR_ERR(bcom_sram->rh);
> +		goto error_unmap;
> +	}
>
>  	/* Attach the free zones */
>  	regaddr_p = NULL;
> @@ -111,6 +115,8 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>
>  	return 0;
>
> +error_unmap:
> +	iounmap((void __iomem *)bcom_sram->base_virt);
>  error_release:
>  	release_mem_region(res.start, resource_size(&res));
>  error_free:
> --
> 2.56.0.679.gc527c65306-goog
>
