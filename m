Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200065;
	b=CYC6iKFThyYaHn4Ge7s/iVCR7YaCDtUbSPMD1eOgrtWnuqR1H2OgbtW+0LvsTBAC0t+D
	 n/ws+rTJU/j6Wkla33N5qHmJwDnKsxcuCYI7u7YUGvO/8cM+4EtBwRZEQxUDJ6PtsLOB6
	 EvmaqDB3CjwRlZMKWoWRzD7R7hRDJrihfLKBpiawn85iJg80kqttc1Ea6bODutXT0UbjQ
	 P95cTkMBSVd8l342IcavreVnI4md+fLC+nZfQ0WJY8XZ49B+F4Sbkm8F1alVHH2rNAdUC
	 BmLbKCjTp6887X+SQZcjO5lbNC445KQlrjvakOpERXhBFlXVc3+aQ0D2ahbeUYy00Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200065;
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
	bh=RlutKAPDxqtuHhEyqqshP4lJLxMDFAdGE0VMiJ/UmB4=;
	b=kUfPKD9N8JsEzteZMivvvdDzf3zXRWtYsswEIFz7tGe8i6YvGS+EvIEswmJuAv2FQuKj
	 jDk2nAQFNVpbHif/QCl/Ut8pEI8I2u8AwCK5xQzBLaNZjyhUnxs686F0PFBOfQk2y2Y2Z
	 zrNev8Qorr47mgg9DJYH7xURnqKpp1UVKfeBfrgA6csKmEJcdVXwTkj3CIip7+xx8WUlE
	 BarPjhfEyU3cgtS6vN5H7vSes0zRrhVWWznU3PRti261RQ6NOQJwrYvxKGNtle+hgqI9u
	 9+ZwAcSbBdXeyEsk2vuUvE5jqEzeXLyWRjPUtHhzcN4S69x1q032bAY7dO/8Ahf5/cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vifpnpje;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.69
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66735606A31C;
	Wed, 28 Oct 2026 15:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66735606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vifpnpje
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfVzv3BsYv+cMW3PRSkOf1Njedbwru5Zj9GiLJJFTQEf0v0SrwVNcABD7YZ0ZLWdXGhznIXU2CS4opoDPGgNMVHwSs4dIkdKvHsTWyBA/buYQCsyq6eJHlzL3+cIvQPiY2CTB9Kl2O0VzWzZ8q7HM+AAZORNMvvZN7VmDTb4jP0fLr2ihIQqb5YKelXpxQIrcn/xFld5f6/IBKqfL2V6HFunbcPHeXMj1eUu6z2BpoFfoeMojKi/iljlKtWy+3qP8Xyw+DxVTj8LaezOHgoOuT+UVkPe2b+S/iPkXEarDayI3WwDuGGiX4weYnxm2J+hR/bp4BGtUmjzkNIRKRuwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlutKAPDxqtuHhEyqqshP4lJLxMDFAdGE0VMiJ/UmB4=;
 b=yrI8FnnON59cLE3bP/Eivfp5oxoNBRYPKn4TyI7/DWDuhdKG2bQGYHVgmwAqhi7gO++QJZYUiDmB2tVfBeMzYKDY7nIoVGlj4aC9jFdkHP0Hk7MGM7F5nArOsvp6Xn4ywtrRB1JclplObDXViSrTrSwOKDRsnS30UcKnqjUQIWHxrKRPx9ANPprKy//FQBvMCwVLQhrx/F1/tSMWZ3B0CDCVu0U7cBMS5PAV2tVkDKX08JPU1Hp3hgbjRUiGcEZYguHNl2U/xOy/EMIhXKUPkhCK2j3F2C5hKsNGDP2ONsujVi4spTVMAG0vHuobIlfpVdWumX+Uf9FFI6U+YXCHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlutKAPDxqtuHhEyqqshP4lJLxMDFAdGE0VMiJ/UmB4=;
 b=VifpnpjeGjktoAsk73evyZFQ6yD5n/6E6sdHlC7rZveCM/kNLaOeziJoxtCgyLhIFuibKI2TOCaKhOTIFSySY8e1mySkKvpmKSNPOE1F4DcAx8CKKArwoXlOrY95KFJwvQ+MmqN3HPgulVNj+e+OjlFDJqTvxO3ERw+djzJdPgKr3NIWEP5oXaXenOGoETkUlmVxVcVqmX28XhRx+eAzkL9Pd0SdVRiPpW0T7m0D/O6gGOm1BxhJd5LBKVo+b/yJxgy4I4aAOy69G3BKNkXQsxbLguQAdWrBDEkA934GTAYRunebeempB2cYywfpjkLVPH/2mbHfXJ5WPWoF9o+e4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI1PR04MB6799.eurprd04.prod.outlook.com (2603:10a6:803:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:07:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:07:40 +0000
Date: Wed, 28 Oct 2026 10:07:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jingyi Li <jinli@purestorage.com>
Cc: vkoul@kernel.org, vinicius.gomes@intel.com, dave.jiang@intel.com,
	xueshuai@linux.alibaba.com, fenghuay@nvidia.com,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: idxd: fix destroy of NULL or already
 destroyed workqueue
Message-ID: <auIPstOq38cnQsiA@SMW015318>
References: <20261028003708.834341-1-jinli@purestorage.com>
 <20261028003708.834341-3-jinli@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028003708.834341-3-jinli@purestorage.com>
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI1PR04MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec706d7-5ee1-429e-340d-08df35053588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|261026140227099003|11063799006|4143699003|261021123027099003|261009223027099003|261022105027099003|261022075727099003|10067099003|261021121427099003|56012099006|22082099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5OmOER5IPDEyus6YG8ZrDUmunR1j6kI5CUP0IeRvF5XCTM1JSasXD0Yq3pBHOwHuqMVTntLBd8mqXlVbaWXOsfaZFab4pTiwgrXViWT45MvNZhsJYUdRKMcwSPTg+BV/BSCsF8ZG8D5+M/WZX+KHvRoOUu7F2Kv4atUrpCtUiQ8YmUnBshlULhLMaOQy9QCmQTSw29iluWgdMHVj8dR+zxPdZy7KauttVmF7lhCBg+JQGceWjrL9m8nzL/sbP3P/2rg0EqLfjjJi3wSfyPBVeIa77/HTWn4yz0k4RMyBG8sOLX2vtBhjr/WZIiO7f98QL1GCGhCvzrOyuwatFzQRMQ+ahQUpOe0/DABpGRqpEkSomsN/RNpkL3iQOUIknoaARbGBN4eOl6pQDv51pq79V5O5q/EjTIsSDgeXo1TZx9/QmgkJElX92WQBC6Emo50HYqn6HFRu3gUZ7mblgn9oAEPmMJrgYpUSwlexp9kNRwSlagpT16n4WR0DN5xz4Ja0jroGrgYp3z59RnrmKGaM8HGvKgmMHdJ0FUVCKq1F+L8qSfkSjJx5DCHhv4g8yIsFmaXrFmcSQigrvVmhDlDjp3zDFIefYGLm9zStq7u3ZcLcpzSAoQbAtaQQnuhZDm6X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(261026140227099003)(11063799006)(4143699003)(261021123027099003)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003)(261021121427099003)(56012099006)(22082099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIvrRtKaP+plZTeo+ZbQURwFdOGIonSgpo4ju7CsSmodc9dVEw12FKye5FDc?=
 =?us-ascii?Q?Oh4wF7Rg3TaOKFeJJnMjbwrfLy9OvmkWQqORnBRIyzM5/HnOoYcHLcweB/qN?=
 =?us-ascii?Q?fOGUSXoUm6ICIATq8iqPCXKVcrEUYyFn4DkJ1FL9uX3/Abk+NJDo1t/Cj1z6?=
 =?us-ascii?Q?IGoRUx8gVQMkYxJ8n91Rs9/04BxD9RTvaxZ+gKjsTiNi6YLSzpgRqvleIMfU?=
 =?us-ascii?Q?0zzcrPcy0Y0xSLlMqXSFH3SDIawJENBpsDMz9YoW2inAdjIPzJr/7yQJwY6z?=
 =?us-ascii?Q?2SMgUPgBx3ZOBZ9wbgLvqFRoo3DFFfB835sFn45xoYRCtWE/upddyy0oB3uG?=
 =?us-ascii?Q?fHYKgJHqHtCUjy1IXdnqB9svl+PB59/ARqPMtcS8EpKZb2nwop9kH4oaCkDP?=
 =?us-ascii?Q?7YEJvigH31jbqpAvWWUnMSqQdKcaSTAN7rfSjbIY7QxBJU4CaPoHNuH0sAXH?=
 =?us-ascii?Q?IrOwyV7EW0EKbOFtInYeOVIXQnWfacM6U56lwPtXzWb8rrftNEg5QJeMPHc+?=
 =?us-ascii?Q?FMXtSH7bAoYMPGPLRMI4UXccSnOCq1+g3AybC+6Pl38Ghv2cwl5BJtepIk92?=
 =?us-ascii?Q?vHqoXzz0LbbjWaaS1RT7uoptqdKRQfe2B7kpGxsh86yFGMKC7wPqmjFHg+w1?=
 =?us-ascii?Q?dMCSmCBl8URt8OATvke8PS5pxBVBGDZQjg7jGj913xz1IrcMAGev1nC++wMT?=
 =?us-ascii?Q?04/Ryuka+pfgrhSZ9lh4SW6q5ogmu4MXnZXBr2eOKgQUrF+6D556SOQAkSPT?=
 =?us-ascii?Q?8vuvAnjF8iaVcW7asNbdBCGBvAh7LDFlsA/PlA9VK65ywCv9eYBKxdEtbch6?=
 =?us-ascii?Q?HNbKkI1PeVHGMo/4KJ9HNpqGTyk/DcjHbrkLij7md1bfdWfz14zBGWsroMjZ?=
 =?us-ascii?Q?tIuyJaN1iJ568P+fFKlRgjg1muR/TEjci9fAexAlJQ0tjsvaURCfmgwDH/XX?=
 =?us-ascii?Q?jdtbxEc+iQiLiw8OmS35XSyaQ6dAsOzlQPN5LGHlsRtAujyUfLzPPjYzEaM8?=
 =?us-ascii?Q?5IPYsQggtqkLPa8OCiJffLAWTlInbroHxnFKyU5EisOPM3+yFwu4U6bxTGA/?=
 =?us-ascii?Q?7dHLkBZZhY9ASy99EyfS0Y/fuBriIFv/NhBw3sXuONof5CE9TgyXtAJypfVW?=
 =?us-ascii?Q?fcRIlSMYbVuJt6BNqXmwOBJdTXowWB0izxybfcn4dHD3V70k9GhBjsEjYV3H?=
 =?us-ascii?Q?+QuE/e/aDmxel+dsCmWIsbcy28kosD7EcV6gz8+/qtPfW3KM8ObXNvNPOCrP?=
 =?us-ascii?Q?tHj2VJrMk9nJoibjL6qcTGFv3y1JuAlilUKncMl37iPox/P7c+XVcUIth6q7?=
 =?us-ascii?Q?JzKNZi3OnD1L14ix4d4jTNSivJUesDzQTdNSLqPT+5UeEMXHvK2Vpz0AYmhH?=
 =?us-ascii?Q?LfVf3LLJUFFU8x5UVrkJyzW3W3hokDBteWGL25otiu8wPme7LrL92lCdOA0t?=
 =?us-ascii?Q?WM3qZ6iHPKmuKx3xVsQThBcLp9LOB+qJSY6G3Eyaf291FlEpn639xdulFqtX?=
 =?us-ascii?Q?nmaA+sGET/maqdPbG/BgxK0cM5CRxXDztuWKa677gpUXe34v+FZmKl3V2t0c?=
 =?us-ascii?Q?d4TxNTo7i3Mklelsd1vWj0/fKbNSDKadQBE9SzvyTxWo7bFnzUKGMsahDLG7?=
 =?us-ascii?Q?/iKeucaZqT2n4ERPPQS3bwXU8x+zj1unLfVwAn9NBFBdHzLrF1c8ICSVDBMi?=
 =?us-ascii?Q?1J7IvQQwJfA8H5e4R8GiHCLg7iciihOdGiLSBPy+8pZ7y1XHk/XzHEQUTJrb?=
 =?us-ascii?Q?1hJB1jJXnlFKU3Dt8Xpyfj6BfNCECbRlP4ncyKfRR6gZsF5/5vuF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec706d7-5ee1-429e-340d-08df35053588
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:07:40.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajImWbgOyoaIwi698bmWe7AxsAfxOv+R+fmWd8EV7DONjPeMI2BBl15+Oqg7PDaW151Fnf/0sEDc1hnCnx+4usmRbXsyN3A1MvovuO0bT6rFIQ0vvtEXoU5gVu+ENX5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6799

On Wed, Oct 28, 2026 at 12:37:07AM +0000, Jingyi Li wrote:
> [You don't often get email from jinli@purestorage.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> idxd_conf_device_release() unconditionally calls
> destroy_workqueue(idxd->wq). This is wrong in two cases:
>
>  - If idxd_probe() fails before idxd_setup_internals() has created the
>    workqueue, for example when the device reports HALTED after reset,
>    idxd->wq is still NULL and the final put_device() in the probe error
>    path oopses:
>
>    BUG: kernel NULL pointer dereference, address: 00000000000000d0
>    RIP: 0010:destroy_workqueue+0xe/0x300
>    Call Trace:
>     <TASK>
>     idxd_conf_device_release+0x15/0x90 [idxd]
>     device_release+0x3c/0x90
>     kobject_put+0x7e/0x1e0
>     idxd_pci_probe_alloc+0x300/0x15e0 [idxd]
>     local_pci_probe+0x22/0x60
>     pci_device_probe+0xd4/0x260
>
>  - idxd_cleanup_internals() and the err_evl path of
>    idxd_setup_internals() destroy the workqueue but leave idxd->wq
>    pointing to it, so the release callback destroys it a second time.
>
> Clear idxd->wq after the early destroys and skip the destroy in the
> release callback when there is no workqueue.
>
> We hit the NULL case in a kdump crash kernel, where the DSA device
> fails to reset and the oops kills the crash kernel before the dump is
> saved.
>
> Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingyi Li <jinli@purestorage.com>
> ---

This one better than
https://lore.kernel.org/dmaengine/20261012-wt-idxd-fixes-v1-1-30a35a445077@intel.com/

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/idxd/init.c  | 2 ++
>  drivers/dma/idxd/sysfs.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1577d22b299c..5962cacef060 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -389,6 +389,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
>         idxd_clean_engines(idxd);
>         idxd_clean_wqs(idxd);
>         destroy_workqueue(idxd->wq);
> +       idxd->wq = NULL;
>  }
>
>  static int idxd_init_evl(struct idxd_device *idxd)
> @@ -460,6 +461,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>
>   err_evl:
>         destroy_workqueue(idxd->wq);
> +       idxd->wq = NULL;
>   err_wkq_create:
>         idxd_clean_groups(idxd);
>   err_group:
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d251095c350..d5ffc641c856 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
>  {
>         struct idxd_device *idxd = confdev_to_idxd(dev);
>
> -       destroy_workqueue(idxd->wq);
> +       if (idxd->wq)
> +               destroy_workqueue(idxd->wq);
>         kfree(idxd->groups);
>         bitmap_free(idxd->wq_enable_map);
>         kfree(idxd->wqs);
> --
> 2.43.0
>
