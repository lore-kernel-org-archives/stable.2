Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938850;
	b=oBxFZAMQaBxhjwi08wJMQTd/ePx2HQOzn/8Hu/Nn3NjXCltvMJyn9K7+AkevNAwaOQXM
	 zD7+KCoClzHhk2q479Y1p99ZW7HS8bJgpRcgzBvMtBSbY3rQYKLRrphmo0FqaBV7zNaoy
	 yDtyiH26F9VWBTJKiPBKg36+PBJdVxg/4E0HlzQwC7xkksq75e6LqUDxKqhdXXYuFtJVG
	 QlNSkJH7SLyas0G1w5iFsqzdRHRCEdpUScDPul809eTXi+sdij7Oxeazl7apnLwfrYKjT
	 1+by7ruNmW/c8e9omtln4NKPvG940EJtj+stS1Q4AZe+XbS8YCGeYfrPfzERg1mCj/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938850;
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
	bh=XuRevN5OEMLylIDK1qAVtogFBcO1fxj40iad3GPNhZ4=;
	b=2yFYxqJ1o7Fr4udhEevR3XdBNizRpf3xjtqsd/SVjCJgyX2rNhFc7gbGbgPRVuCpXitb
	 W787kwF3SoZED9By/l2TMG/Yr+tujPHqUWqryNXsJYrnqjy4UQmMIruR2zOe9bCweo/rh
	 Ov7IiCtYc3/BhG3ipsv5TwL2ujDRhFQVTtHOY6+i6YQmnytAjIHbvzlGXfEzTtWiLHlqR
	 MWBSYvkp6BhkyocfwLnsq5MxX9MQbZjHRFFxfHtBJIOasqNYoMwmdqtF/kxT3MG0ODEka
	 oY10Ks07TUxUurWjF54xdtOlnZL3Bn6x4xAeEvBDoZMUJHf97Kth+1sNlJtmAt7nItw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jJ70plnv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.70
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504A606A32F;
	Tue, 17 Nov 2026 18:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0504A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jJ70plnv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM/NmTWWldCBmB1DyLFJPTbmNpAVpNp7/XCIXurL4TXL6oBjco11HVysxrW9rtGOOk0ua57w5LWc5Uv0fPVnvI4NWrJwIIjWVP8VRNNKwmGcsmWI+rr7q1aLFEEMNIwxkxLUSffH5N05aelScFUNuYUpbtvBq4lOZ570BZMbk8qdxCiFS1jj2mQvUogTVdneHWYYeXhYMiQl7W3IGVkZoveKqtos2Aflyyd2DDhURsC8vTXcAk0w98krlyvB+cHW/NByQdFeBv9Y2iS7QDxPwx3Q0Xwtz/WDBpYktV4o6Bm7kED4b8y2MSdTee/6KhxOEZJfEi3gtZeZnX6UiNhwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuRevN5OEMLylIDK1qAVtogFBcO1fxj40iad3GPNhZ4=;
 b=aXcpdcZeBsfHK4u8u87xnTBjnp4hk+WDYbs8Xc+oAORKPFj6iKVJ3xbcmKOOVYE4tjsMhMjZwgC0sYHGYn2Puvau3SnqlOMQDgJgwbXOZ6W6SbNnadG8BvOWANpIAha+gYyc1GCZxqn5y2sd7pcrNikx4eOGEOPKxvhQnGfAh/SudBYLsrzvwL8on6qNPyfaKZoIKmpDwcnlvaTwgKnwxlyTsOARq5HX8LMjMUUWz1RAAZrQ5fIVglRXYdC7zjaG5l1991EhnaQ8Uo6blo82OfMdiSySR17ETrc7oOEl/ZcHO+0P4PS6QgDDZrOVYvERYgV9YxucAQAuaAFQztMDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuRevN5OEMLylIDK1qAVtogFBcO1fxj40iad3GPNhZ4=;
 b=jJ70plnvNhLz11hJmw3cvDg7CLgbYKXiqLpM8+MXZUl7+ohCOo3SY9yv4juNw/SAbKGVAocUj/dq/Q3hKlYErcbP0IGS2mppd71Bi9s+1loJY5o49u/eMMVVc56a2Ej0yHuPw8I8yCXukw97LiR1JSNVKbPPLDEnA9WQXZIavel5Xnuwa96rNcau9OKJnaIoJrMkO6fp/Q7wN7rbQ5/BGE5ixQwr69guO4htH5oFjF+6co1vDecGU2IFF9iDoGaPnIKEekT8Pe8+wClbch2r3rt6et2h9N6FClcAUN9pUZk0WiHhvCCbPi35/j+DoNTf48VTNaHW7rG9xzJC0iTJvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:07:25 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 18:07:25 +0000
Date: Tue, 17 Nov 2026 13:07:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yao Kai <yaokai34@huawei.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, liuyongqiang13@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Avoid destroying the device workqueue
 twice
Message-ID: <avyX1SgReH4Ta_pa@lizhi-Precision-Tower-5810>
References: <20261111021026.3354620-1-yaokai34@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111021026.3354620-1-yaokai34@huawei.com>
X-ClientProxiedBy: PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 870f6013-3dc5-4b36-cac7-08df44d5a24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	O6+qAKRswxm2uhimfruIlQw4QhGBgjgOvgMvoqWL6pgkulf2/vm0zv1HVnELI3gwspvp2mVH+mvj853klmJh5mCRrJ1Rb+7H1kEnnip875DH+IDGWzLNwrSX4+2D4eaCy4YwXcV0iX+LCeHEeb2EllRZfI+80okfrkCMMIZYzM0GZyyMHOKVZsAdmRfNtThPJpz40Gj6Gebq8EIXlReiOs5z3i9X/UKrY/q29/UJwc+AtkX6zA0ulFyhjXEMVXN5lSL9agJAsdf+sikCKA6kwC1+pVbIavHoX4/bPjYT06t+mTiLFFw5u4fdjgr8ZC/yEDy8OnMBd85xuvCZ0CEu8tan6TiN3HUtGXl1j9TryXcbg3sejR+vgpQ6ihGfwvVA9QwOStQ9BtFwLXVoj1ONNG8d4Tm4ySJn8rsBfQCdE6/FTJ1k0WUjd6vbekP/TriQi6FDD593+tBfZuP2Ly1o09mRQXoEg9KeDZwEhadxt9FgWGBO9AY7E7GuxkCsGWdsHgGbI9LP1fIImuCoE7ffR2v89SxTHYuhXWSUK0WvxZVJoW9fgpoCdaMRyRf5Xdj1/+fMM7eNwNqbqjveCTQoNxPGtFLJFystwT+VSx03IANG1m2Zjg2UzPwaQoIJQZlvEQ15fdEhuH30ePosRhu/GdxCcSLJfELjOeGwMON/qd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLYda2t3KlKPEfXWuUXV4KEv/X38aL7NE45hpAiKOaF4ayHDTZ4BfNqY98da?=
 =?us-ascii?Q?0AOMTzc9xKRgJW1nBWX5LLbkOU0kKWS6C6mFEbzkjPjEX/wDB4Bvri5NnvHo?=
 =?us-ascii?Q?SyxESzz2QRD5Ns9DPfeYnd5iKk6HOhnd4XG5J+NcoYISl7GSt07/MVmZqZ82?=
 =?us-ascii?Q?lgt9ozrjXIzvQ0SsdmBWnMtmg8dM41WBORNoJH1Alkz7yXL2waCkbkcvogAC?=
 =?us-ascii?Q?y/TvevNmhwroCfMHjx4eD0Dqt7hxqbLNB9PTDf22/tGeCN8T45vvXLk02Du2?=
 =?us-ascii?Q?oYcFy7vt0P/gyr3ws0xV+eU6nWlIq1QMoXlWQdwr1Z+yHKxck3qSvwGuVKPV?=
 =?us-ascii?Q?d5GDLUuMjoBW+Rp0lLgn2eIhnN7PmgqY9NVho+Pr4NxpVmgxAofahtL5sVoA?=
 =?us-ascii?Q?7IwqOXTsdSqabas3HeH5KRWznZijc7zvlGVhTaEAy7/D+wm/CMFw2XeQzwDh?=
 =?us-ascii?Q?qMDudr0XIEeJLMmnF187g+vlcJ31GlNiqA+Wi9EJQqGJV6PdZs08R2iuRTPo?=
 =?us-ascii?Q?o1EqCuQmeAvPTVGuZFXQzZ8nDcxDBdAXsrO7ncm1UUuRZJTPfPu9RYp5Z9Yc?=
 =?us-ascii?Q?yWWol85lOWrQCX38DMKVtKFJrjeNadlZFJPhhbIdi3qwiZyjd7nS2nQEBCkz?=
 =?us-ascii?Q?W5Gsdp4HVurl9vyXv6X0paq3uXNplgcdW5Lmop08BYnInKLeTs+9fZP6p4hX?=
 =?us-ascii?Q?M3g1EFWt9ORC6UMLEZ1Heh72UZ6R66wwU7ezuz3OMihQhaPJNjQ0SU2iTe0q?=
 =?us-ascii?Q?c50h5UNzCyRbNfgnsFsAHfBRtbjn1xh/Z5BM8xICY4NT/D+ITciSX5aF4Edu?=
 =?us-ascii?Q?UnTp1GCCFZsettn/1CIAN431SI4/yPyvdSuldjYieKkknvD7AR+UX2G8gnz0?=
 =?us-ascii?Q?/EsIzmdntRQC6de0W/qrqiyJdaBTp39nYYoPykxJLv2pgTp8uD9KrIoOj0Gz?=
 =?us-ascii?Q?KCy//omry73p50BaZWGsAhrMGoNGKAXAkOTi4IZMIcZxIpwxufMT+4mHLIFY?=
 =?us-ascii?Q?riJm+5x/aqVbtlatPnLYUZ18L6GX3QTsGmJ8beVuyUaLiGfm6tMFkCAafQQp?=
 =?us-ascii?Q?GGk/OBaatcr89142UzesQV4Za2SH4l6rL1k9+cAHkEzqAXZ8FeEXgNg3pI19?=
 =?us-ascii?Q?j9N0jpP85trMvw3Ar9E0+r2Zdrxq0S8dEZbpId3jhjNS/qk3tvP+gMr6qkLh?=
 =?us-ascii?Q?JPmX8Vglzo+nkwnooksXrF9fxnwZXlJRQbCmGFmENAWPW1HDJJuxdwqL3lMF?=
 =?us-ascii?Q?IEzsL6yoGKR65xaQvQ3tEat/B6oztmrN43raH7OjQGUUfchYYJ7qCYeqqyT2?=
 =?us-ascii?Q?pRVUDD7zlkjXN1LHCJt2qjKP3yjTHgNCZNaqBqzyhDNsK9rAtVIZz3d4LLEN?=
 =?us-ascii?Q?KKf8S6QHDFQDtfyzVCTEUBUwm+hIqsZa4XxsvLpkikDb0fz9xQWnNYeklzEW?=
 =?us-ascii?Q?A8Qk5qISMw8QuRXTp83a1w3GN5VfB45+DLI65gLUlD4o0vA2xvvx6FgzkAMQ?=
 =?us-ascii?Q?IMhdc1ywBeX7cemYM3rcfQDa56YBu9QNbiexUaXlclvRMb+eqFAcvaM8NG34?=
 =?us-ascii?Q?KbffHPu2sSsPDWvOczOzdJpvsO9qiNFhxd2EJYDEUpqRWM0xTnkbRRBuCI/R?=
 =?us-ascii?Q?SLgArnsfVVZfRSNsRJvHVMyYJ7y13g0Wrn0K/NrWgqdvsIGk9v0M7rcSAPOb?=
 =?us-ascii?Q?YHNOU5KASLMw5QNaBWE/aQPJTztpOe+4QO0/9tzO2JfXvc3NwkYB6GpbKbsC?=
 =?us-ascii?Q?/72buX522gR2VHqzjmJ3g5QcgRp2PiXEKb5KaDrOBhQDwyIcr6m8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870f6013-3dc5-4b36-cac7-08df44d5a24b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:07:25.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bvno5wWSWraBzLhMNyOdSb5CF9ruK0qWo3FxKAQOWc3ARBasd8YlqWX+W48ft12sCllF9eS7N+w4ZZBkvp0eiVlMSUsTYKFd12aWIqIwXRiiMXOEXJSA9b2e+XXvmPg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316

On Wed, Nov 11, 2026 at 10:10:26AM +0800, Yao Kai wrote:
> If idxd_probe() fails after idxd_setup_internals() succeeds,
> idxd_cleanup_internals() destroys idxd->wq. The PCI probe error path
> then calls idxd_free(), whose put_device() invokes
> idxd_conf_device_release() and destroys the same workqueue again.
> The err_evl path in idxd_setup_internals() has the same problem.
> This can corrupt the workqueue list or access freed memory.
>
> Clear idxd->wq after both error-path destroy_workqueue() calls and
> only destroy a non-NULL workqueue in the release callback. The NULL
> check also handles failures before the workqueue is created, while
> preserving its destruction on normal device removal.
>
> Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/idxd/init.c  | 2 ++
>  drivers/dma/idxd/sysfs.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 4b827a329756..ffbc5a74be6e 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -389,6 +389,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
>  	idxd_clean_engines(idxd);
>  	idxd_clean_wqs(idxd);
>  	destroy_workqueue(idxd->wq);
> +	idxd->wq = NULL;
>  }
>
>  static int idxd_init_evl(struct idxd_device *idxd)
> @@ -460,6 +461,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>
>   err_evl:
>  	destroy_workqueue(idxd->wq);
> +	idxd->wq = NULL;
>   err_wkq_create:
>  	idxd_clean_groups(idxd);
>   err_group:
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d251095c350..d5ffc641c856 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
>  {
>  	struct idxd_device *idxd = confdev_to_idxd(dev);
>
> -	destroy_workqueue(idxd->wq);
> +	if (idxd->wq)
> +		destroy_workqueue(idxd->wq);
>  	kfree(idxd->groups);
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);
> --
> 2.43.0
>
