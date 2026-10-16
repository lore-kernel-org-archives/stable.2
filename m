Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8747F77E;
	Fri, 16 Oct 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164055; cv=fail; b=pPzXFVm+uus+evPU1sqsV6yb/nmbVzFIZVyk8P1U04yjlZiUqasQxIvv7Dne3KTDRpj3yg9f6jWta282oOhb/TgRMwiTz33sG0OxBiAza8GIWQ/UeOKCrdqNvjtospyTGarqFygtNnUO0zZV11kD9kWvRX/EMROhX1PGRIBHL2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164055; c=relaxed/simple;
	bh=B++kIoqT7KVfLQGi5jQQ6n8fFVdC4t2qfbAYvCXA28c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oNWNiw85ijG+yru9jxbC5LFso2xdUik/4z4V6SpwOt/6GCl4D/5TqO6hZHHq/l5x+d5dKyzZlEL1uO2veENRVRrArzkeGuTpW/Xc7o5oUuf+B9wnehQxrP1Knf70AWeDjl96t2r17Jw9f5TU0Ui+9r2mT8LEqzzrDRxP42E5TV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XRflGCu7; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XRflGCu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTxjoVXBalIf4HbwHE/+FvCvrw9vo4z0xCxEZrF8Gwiw86VM2t9gdBl8FQaiHuS5V9VMcebASBMQMQGtvj7J433pE6wQHd0IDRiqjBMMj3yylvlpv1f2sFWyP3uqmSF4sg+MziNN9X4dT3hDN1/7naHelkeJcfqklMKa1dpb/Q3/2GBD7dJicKwOIU5viL55gPInNZ15EkwKf4TyHMzJNqSerti0dcDvQ07gbgpLOtK7w6BJVC2pSG/zTDXT5RTmuzD7g/bVYtaAPwXXhNPaG/5bAECels7gSimG10jUrR+UHR1lNeTLLcc5fRqP4agSmJ2TpCKrIrqV3+TXh6Egrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WGFAYowSVjZpXd5Et62vXyoR4Xuk91RwF1HHDa2UmA=;
 b=N10UMRnRcnRH22ztCjgUBJKbe5z2AVb+LgLIOOqYl+QHYmdTO61lzHSD879YwVUM9pfLrxn6g3zSTCm8idQr6kreNDfvj/Vmgc5DG1ORMQ2KJn6BmGoKXUTh7tRynlikCCIkZ++L8BTrm1wDjyPF/TrFimz3De7rq5Pk2PFQ4ZaD5T+xMVnvxRqxzrLzWzlReuOASt08F7chwvi1sc1Ye9ixGeyZev8HY/lHoRQzo1qPS2ZbR+umgk/yaThv/Mf8ON92LGhREd/Bb1/FBM/nyH8p/MfHoRx6DNBP/5WnPP3WsXzvCcJCocjv2BxOWY7H8xzU3Tit83HQ0JqPgb+K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WGFAYowSVjZpXd5Et62vXyoR4Xuk91RwF1HHDa2UmA=;
 b=XRflGCu7HE6gxQ/jDat5XMzKMu8N2K5gYoKvXvy7f6NRbsrUaOQ33Ua1nG8UTiJjA7WHceQUKcx2vpTH3YbACwWf3I6wka03pwfKj4DSfvxcPHybvTgRrva01KK1J+oHhZQs2TWlI9PGLh4TUpCgaZbfSdhxDfyATBsmlSZCSVuwqe63MZS8OtmQFrxsaLQN6+it9Mp/1Hl2Aq1pg6YaPF87ouobR+RHpQViQBH7V3gOT8NgXl1e77ZN29Q6tXand2MhSydGSbr3P537reztUDBI3RVemkFstsc9JQw+sre8ftECufGeOQqbolwPW+YFsm5qXWhyP3tt/dvNj95+Qg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12004.eurprd04.prod.outlook.com (2603:10a6:20b:746::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:20:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:20:50 +0000
Date: Fri, 16 Oct 2026 11:20:41 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Bogdan Codres (Wind River)" <bogdan.codres@windriver.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, dave.jiang@intel.com, vinicius.gomes@intel.com,
	xueshuai@linux.alibaba.com, yi.sun@intel.com, fenghuay@nvidia.com,
	dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix use-after-free in idxd_free()
 and idxd_alloc() error paths
Message-ID: <atJAyZJfMCXzcjsV@lizhi-Precision-Tower-5810>
References: <ajMNBgdsvdLPCt7X@lizhi-Precision-Tower-5810>
 <20260618113254.493582-1-bogdan.codres@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618113254.493582-1-bogdan.codres@windriver.com>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12004:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ef506e-7ab4-4e18-0488-08df2b990f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|5023799004|56012099006|4143699003|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zfLdAOaJhBo1UR8wIcfvpUjRpz+sEX/vw6OoMBFlGI3ClcrNsShrqu7LfJ7QQcnBenqdJsQrn4LoGNYio04Y0sTV/d1Br4FRDJhmOMO0DcnIuTe7nWRDjAdvFilsbaxiht8zFUlcL2Sx4blFoW+03t8Fp5UvnZFZAXAoZYshRYDcsk6IWsXDEiTP9BXjpDMlTrvKvuv7qXd8vrAljPtxr0Uh1XppHKPjs/LnUoEKf8TpUqjkZF4ETpixrA1ZqHzuos7EuyHGfdmZK3BKW/C6wj6jiqtNhWI0wo0moWsI5FmoDql7CpE42V01JuBqEax1zz/FUSh7CQZhpw5oO4vkiLemKXenJ50UEI7XJQayyzHsDrpuGrfLUeqdCKmY50UIStDEUxqmPbSKpyZMZuGZtB4nolno+istBPCPB1b0U9oV2fLg+Gx2ferhyO5NCUEdAOo850KSz4duDXE0ZumGeBR8+pTYf4zOTPVHnY4Hpl1ZUvm3/2QL5lUxJ3ORpIOy/bf180/+wODZcRlAS1Rr2NteukPTH1E382xpbVrJn9feFaU9DoPOfDZd+wqnYCJofcwNMVCymzSD//mjV3lra+lLhMImzS0h+3/H04tr4HG2+IgW7P/cYeZMtgqOa25T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(5023799004)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOJ9lv+CMYpHTqaCKufTl8vXI9ntjTuajYIASJiaxVp4PmbfuqykBzTSY4TQ?=
 =?us-ascii?Q?79JNQZk1wLs+5rW8b6V/UUnlyJMS9T4P0dgEviaQ23w4+RndFkmXLxlXCxpR?=
 =?us-ascii?Q?33wYa2nqpHImPGMlmEQ4vUgLFWgNjfB0BkcRWp6ZcadCbN9zXIS4ImqihuuH?=
 =?us-ascii?Q?9kyLMv70Nbos+gCjPHm09/eUG4tVKjTxkyRH9qdqSN6JEQ9Kdbyc8ii9LJvS?=
 =?us-ascii?Q?ZGjaojRmC1ulKm3+Op+UPrQTFmxtjKIEbf2nXz9Lg1l3w8TXUQlnQ7ztbrWZ?=
 =?us-ascii?Q?pwAgkKogs8bxPx0StKoBZcoPUmoxztmh6kIixp13+0pSKOzcKTp6v5jkWv+/?=
 =?us-ascii?Q?UdClhLnXh08jCOXYytY2ig40kr6k+dEWfQVEToZu6kc8ofX+b5m1Icnk3rxx?=
 =?us-ascii?Q?bqSroEBxAwl/VZGLqtwVf/FutpFk5KX0Sxn/v1keprHvFKAR4C0y8fCrofZB?=
 =?us-ascii?Q?jFdmkx/CegaUdzJ3FGR6mq3f6o640aDZsfsTZHOEwsGamobcFvEm+yq46LUl?=
 =?us-ascii?Q?4O0JHdcOG7onCY61Rt2lJj8pNrebSM6Krs1B3uCxNxp10aOCnIl7I1A4/y0z?=
 =?us-ascii?Q?mD3AF5Dy6nr77HI+FWhxR1MbLo0KCx4QdGJLZg908ao4Wu7KPfpb4dsR9uLp?=
 =?us-ascii?Q?fAPwP2qySfoLb/HYsz03roPJphHWexe/3sAeG6n50jPwAhLWPWbaX5A+Qkn+?=
 =?us-ascii?Q?xMl2ADj3tRh4+WaCXE7CUI1K9E+zKJoBFZ5I5/cTM5m33jIoihhKls7jd0Rr?=
 =?us-ascii?Q?rhVrx6DQBwIkeGIlEFNi8jQgfo48+2XxHrpVwrDRfAaZ6jXG0ieKoGJkE1XR?=
 =?us-ascii?Q?pszr516Eg7jISiSiBT73rUV47BLujt+Hzw/d37Dn0U0REo4nINiGFYb+GL1F?=
 =?us-ascii?Q?cM1iDZiqCDOCBuXBmxYWtX/fCKA8PBIAjl8KCk/Z7NeAaItnNWQgSWDnWrBu?=
 =?us-ascii?Q?Wo2FGzvanEMmRd33bVf/ME3XmSIq1tm3OyyzeVNU61XsrFQCOeuSL6EPjCIb?=
 =?us-ascii?Q?ydaNDrL5LqaGaLUBrhEi6HpUv/3YUcie5dGGh2y/+7Q06B8bAm1V3f7v33u1?=
 =?us-ascii?Q?oGYCFsaGvrCmPBPd1MUmZfVr1h8SbIfyusVXM8tigDUEPo3BTlKpCsW5Tnzn?=
 =?us-ascii?Q?2R0oACzENJE3XAZZInwQuO+ZowPN+2OKJYFp12/bgxonrCfTC35hJvM73fQ8?=
 =?us-ascii?Q?If9qFJngwlmBFgeHpDIVhZhqKhWLFDxB2YAeoWWsNw3/kRyj1eNkl3bMuI8i?=
 =?us-ascii?Q?fDNYtUP7B44UkdeU4H6fuPMbmClBcK9lcOhM/lHpDo5CjBe9q6c/6cWvjTAW?=
 =?us-ascii?Q?VmfA5UXj7pZBWAvfzM7299iwEdzZb0TBxdbSNvmuewO6exwXSH2ntdfZ0G1/?=
 =?us-ascii?Q?QpAt3u4gJUsLZwp9ONl8vJoLSvQOTcKFBRArN5NLFZTDnbzLs40R7wHDYPnA?=
 =?us-ascii?Q?Qu0F+bD/o8voTUvRrOMzSN2gcPVkGaVHAT2qJCYFTPyd6Fm2mcHbB2YfjfrK?=
 =?us-ascii?Q?xQ76lzMHIcBBiG8J8+abbGv7djGTu2vrQ1efmDUXWTgHOoasIVx394916PaA?=
 =?us-ascii?Q?/Q4mVY7wL4OlLY2Fud+5Bnf7B3NFa239xpEzlXrJRDbJgmhVZMmYtV7Gzzyl?=
 =?us-ascii?Q?YxAOxERJdJKPtQ7pclRZ6F+nd2EqCnunPp1HdH4WQ0pZ7NQ7ovZ4mayqKgLY?=
 =?us-ascii?Q?aTQ5CssgR3m5iaXLdYxcwLQfLJDTXI5m2GPsa0UvDh+/qwV+eDQvEFVlFXC9?=
 =?us-ascii?Q?8f+NpfM+4EcDbMnjxWvrQolMz+Lg94/gfUNB/DZ2WBaC07K75eK1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ef506e-7ab4-4e18-0488-08df2b990f9b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:20:50.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfl9OwgGRu2k6H84n3w/fY79/j4V1jgQ6L1CfRFmNTK11mczlY0PJsmQzwT4CRrpYY4dx4MZO1P0NCRv/sIhlNNS1Hl131myViGykF+yb1vPP3ZWTx+1KisADXK+kZJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12004

On Thu, Jun 18, 2026 at 02:32:54PM +0300, Bogdan Codres (Wind River) wrote:
> From: Bogdan Codres <bogdan.codres@windriver.com>
>
> [   18.628791] idxd 0000:00:01.0: Device is HALTED!
> [   18.631447] idxd 0000:00:01.0: Intel(R) IDXD DMA Engine init failed
> [   18.631450] ------------[ cut here ]------------
> [   18.631451] ida_free called for id=0 which is not allocated.
> [   18.631462] WARNING: CPU: 0 PID: 11 at lib/idr.c:525 ida_free+0xd3/0x130
> [   18.631474] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.12.0-1-rt-amd64 #1
> [   18.631477] Hardware name: Dell Inc. PowerEdge XR8720t/0J91KV, BIOS 1.1.3 02/03/2026
> [   18.631478] Workqueue: events work_for_cpu_fn
> [   18.631480] RIP: 0010:ida_free+0xd3/0x130
> [   18.631492] Call Trace:
> [   18.631494]  <TASK>
> [   18.631495]  idxd_pci_probe+0x1b0/0x1860 [idxd]
> [   18.631506]  local_pci_probe+0x43/0xa0
> [   18.631508]  work_for_cpu_fn+0x13/0x20
> [   18.631510]  process_one_work+0x179/0x390
> [   18.631512]  worker_thread+0x237/0x340
> [   18.631517]  kthread+0xc6/0x100
> [   18.631520]  ret_from_fork+0x2d/0x50
> [   18.631524]  ret_from_fork_asm+0x1a/0x30
> [   18.631526]  </TASK>
>
> idxd_free() calls put_device(idxd_confdev(idxd)) which drops the last
> reference and synchronously invokes idxd_conf_device_release(). That
> release callback already frees idxd->opcap_bmap, idxd->id (via
> ida_free), and the idxd structure itself. The subsequent bitmap_free(),
> ida_free(), and kfree() in idxd_free() therefore operate on freed
> memory - a double-free that corrupts the slab allocator.
>
> The same pattern exists in idxd_alloc() at the err_name label where
> put_device() is followed by bitmap_free() fall-through.
>
> Fix both by letting put_device() handle all resource cleanup via the
> release callback, removing the duplicate frees.
>
> Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
> Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bogdan Codres <bogdan.codres@windriver.com>
> ---

Avoid post new patch at old thread.

There are more fixes at
https://patchwork.kernel.org/project/linux-dmaengine/list/?series=1184207

similar fix at
https://patchwork.kernel.org/project/linux-dmaengine/patch/20261012-wt-idxd-fixes-v1-2-30a35a445077@intel.com/

Anyways, you post early.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/idxd/init.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 18997f80bdc9..ce4d58740c88 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -585,15 +585,18 @@ static void idxd_read_caps(struct idxd_device *idxd)
>  		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>  }
>
> +/*
> + * Release an idxd device that was allocated (device_initialize() was called)
> + * but never successfully registered. put_device() drops the last reference and
> + * triggers idxd_conf_device_release() which frees all resources including the
> + * ida, opcap_bmap, and the idxd structure itself.
> + */
>  static void idxd_free(struct idxd_device *idxd)
>  {
>  	if (!idxd)
>  		return;
>
>  	put_device(idxd_confdev(idxd));
> -	bitmap_free(idxd->opcap_bmap);
> -	ida_free(&idxd_ida, idxd->id);
> -	kfree(idxd);
>  }
>
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> @@ -633,8 +636,12 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	return idxd;
>
>  err_name:
> +	/* device_initialize() was called, so put_device() will trigger
> +	 * idxd_conf_device_release() which frees ida, opcap_bmap, and idxd.
> +	 * Do not fall through to err_opcap/err_ida.
> +	 */
>  	put_device(conf_dev);
> -	bitmap_free(idxd->opcap_bmap);
> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:
> --
> 2.51.0
>
