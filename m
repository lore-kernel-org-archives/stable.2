Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8058F062;
	Fri, 11 Sep 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157015; cv=fail; b=jeJnRkswE1/+NRiFCfZBE7CW1xQanfzc/0LvZl5ceoVOWxN65RSPd+RRbGtqmCbr9b/J+bGG9oPR3+yeltvk4tKvVe/YuJl0kTyDAXHDr17NSYEp3qX0PAXM4t1+6mBfvLjrheMjAtoAWvd2WIYKNDRPuIHr843XipNlYvx2kWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157015; c=relaxed/simple;
	bh=SGMYPamSjCUYgHWPmPztuYatXn6M9mGDIagcu7CX/TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcT6pHSo95mzr0fmjSP7L8MpPylDlfwFugNtADn8Ep+4+kwvtH+bNDRdRTdHYl6lq2LXR0VIFpLxXBdTyL+CzHBPTqqiorG/JZKtTc6pEikQaWY+oTcJB6X4PoKiRWkdwaY4PWnGaH3ylrp7cbzhZ2QM5oncZRrF3FRwbl8jous=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w9WqiTon; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w9WqiTon"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTQUTRImxcAcu3jX1qanMl6+l6kH3pwvbP16tyXKKgB7d7WD6cv0axrdQ6n1/wmm6SyvT9Sjj404ImyKH54aLObwjfd/KGs0T3H6GKWyomPLsQeBfKDzAXHBcNgWfTRFgKhJqe8bPtMtxSIoFY/UNNbJdTMjZPhYdXO2+HYFLRvRz6vIgL4FPsQsD9Jy8zOCVLodDuadefKXJCQOBhwBHJGXKdEuD79o5iNNWlLcfEGaBf0fIbTsLi2tTlDtBgtAFDIEAfQvlVeiCgC/MCuOhvRE82CAvES+pdnjluvBnxbU58BMbDNZFCR/Tvr4N6NYnaK3EBAK3rZwohEJpe34Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtGBQqpRntdO8H4ypur8vEc1nfY7av+Cu4lImMdhL60=;
 b=CPuBvKGyQfBxAO94biya8SbgcaYzN8F4yj2oZxpg9nzsmvWkfuymiwet8NOcfZ6hQrbnyljzDO1a1sjlFD6DaXPJqWz27llPAM8qMLaRdhFccGGhGlNPaL851Iq0PsyCQ1jUl3xUvG/Nip1kh4zUUlFnwp0uAdF+uaN0LGcaXEdxaMPsb0sB1kYoTs5GfW0c2iCnk5EUw4Lj/gSfz2D8hIZ/8Ffz536ohcLml/WpyU6W6MK862a+rDqeFOVJSttv/frhV4jn6Q9BdYdz9Dz2gOMAvqbRZsKhqVhaXFMPX+UK5x1yFi+UajenoHbVFkKth250eL4I5PpEmw+wzl/dPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtGBQqpRntdO8H4ypur8vEc1nfY7av+Cu4lImMdhL60=;
 b=w9WqiTonIm4lMMZH7F1Aus4teA7p8/HSHsimKAIDEz1dwJozvtl9TMPml0CSeWctidpJe0+LW/avVr3xIv42VKq5ndmcl5qQv6VG+NYvlXArboAThZxVGI4HXKcSNo/DH+JvLUKV+5RBHe934HtII4aTw8cmXYtdqCFPC0hk2AMw+OICvJtMGpX8dx8q0h+NuU5IsLdaQhzkitvunKuCVG5JIslsF2xw9UgjgWsMNqSELxkKcVvnKdGn2c3EbZ6LgkDu23jqCQkj9b8JzGSvkfRVtusRQV0lccHgKrBoH9QLTeeuA38EmHSm7AaUWrPqlnPuxW/3OaD498mo3AyAwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB11577.eurprd04.prod.outlook.com (2603:10a6:10:607::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:03:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:03:15 +0000
Date: Fri, 11 Sep 2026 16:03:07 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] media: ov5640: Initialize mutex before probe cleanup
Message-ID: <aqRee2mzDJKru2J1@lizhi-Precision-Tower-5810>
References: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: PH8PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB11577:EE_
X-MS-Office365-Filtering-Correlation-Id: 93621f3d-6015-4e96-c4d0-08df103fb6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/psOoehTbwBIjTCT9usur5sweidj2KIUxqR1BZSroA3sJONcKAOoa455I/Z+98UXMed/uEvOhkF11zc2+DL/egTSBTsbpbIfdbe5JOXUrXvxIonkF2NHPOnY8gDMGcXiRQw9zHHYkgxIFOs2uuukMu12Y1subJ60Iq/MtQLQQhDUOtGKSVnUUjvCjvw12EC7GlQseo9ZQc+aUIofzw5ZM4qVAdtTSaoxxYJgnZ+V5AJv4ODNgTjLss8OVpp8ysYyQbIN6b1W1OIkWX2U4T6S9hbmwaw6dDb29oOsXUcoeb9oxb8B1Q6lzsGpcjrX+UVtSYuv/u+pqrX24xsRlRxzQ+hfmvwOcbmf1ce7tCA4Vg5dDaulHp/rL6rKwmnBY2hqw4cgVqWICHHPQqPYtDBMX8ESwKRV+qmTAEpY2gPHj9evCSBfz9J1S21Gn8oSSogJ54WMyqRsEZduyoMIU8GyoSQKxkEM/5jmQ/7Ia5GrIF0eSMBVvXgzVQEBJa85Md0CI+LFBfIBg6A+VC7MWANqeEnHh63QF06fllLtiPmr3Ny0QQYchvrsnhZnYTAp3Jq+FdShFluOeyuCe128dZYYEioi7OhW3M9USrKa5aH+laelqX4wT+h+p6aGJrwJpWmV48jIQosR2rOybCXiKEjm1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwucBenhv8Mh6FntBJo+go/acIi43W8MJcK1tz6EXf/B+06JMK6XK4FPCF0O?=
 =?us-ascii?Q?H8rf0YXSYcl2nTz2xHbXlQeRCCOXtyEy70AURMAonEkDQWVzh8XZCW0gqNMk?=
 =?us-ascii?Q?66nHa+Qj+2qURuuXiAf0qYzBkx5PGneE2AvQftSH6Pgb6PnHkotyI39kaDaA?=
 =?us-ascii?Q?2GDr4VP0zIL9hwHhteFiSKP0kIY9Ofi1suAjS+YxlbmjHtxU0R3zIPRZc5B4?=
 =?us-ascii?Q?v7BgppspyYF6Hls2VZwoGmx0svHV+zOeSjttIULM9v0WTacgSO4QjNEnqoyV?=
 =?us-ascii?Q?ynjD3dgyW8qjBfeyZN/2BrwOYLvTo9V08Fk2vDxux8FTSIzdl8NmYrLL3yCi?=
 =?us-ascii?Q?8UAutbW0yzxx41K6F/VIZtF6ENaz2UU9aD4dwdpywUtIeUYdbL5h1jhGhTQC?=
 =?us-ascii?Q?wjQ9cNDW8i/cu5KoeeeC59mfvZQQorcFw3R3eG7bQAPOSC+Kyw8pxaXLhrek?=
 =?us-ascii?Q?UJUEfwsrtJTc/TmNfruwPlrZimTc1TLctq52KSqJF9HisQ081rbiXkX3n+Ih?=
 =?us-ascii?Q?923Gs2ozi2TxXnK+343ouxpFfJbsPcDnPecYTMr5Uiv96nooxooli7fKRnOJ?=
 =?us-ascii?Q?1vsBNKu6TuF4eUNU4IlsMjdPZmJGxaTA9/EmcRBf6J0qnvM8darTxeD3qj3D?=
 =?us-ascii?Q?WBawmc71jpqJvNY3m8XBkjx8nncctLpTH/+znyFZn57ViliwKp/tiltwB0AB?=
 =?us-ascii?Q?0ej+WHjJTHMcdzc7OH54lz2Zg+glbWoaR5ptXweVuZHwPK8drr+z1GHVA/lW?=
 =?us-ascii?Q?e00pvkHtxbQ7pezzBdD2FPiBUv2DMpIFjWHHHPlld6c2wGrcnZZKZnyNrFyB?=
 =?us-ascii?Q?DsoelKbUoQyMfPHECpFchxPyV8GNYs85DQSXKmbzH2rd56XEZHx9sKLGSWeY?=
 =?us-ascii?Q?+YGkjFATPSFm3N4/N7CeJvHK1b4fLduz4XpqV3asXNWeG9X7qPoRIdf+I4Vg?=
 =?us-ascii?Q?dGoHfF78aBQouYGyZv/01gM3H9U3bM22eyRWK0cYRfdpcWPiAeIcxat3y7XL?=
 =?us-ascii?Q?LRb4d9gwYQBskG3gDHruKZMdzVOxTSNmCk6VChaoXCRK0bT+hsBWp5nkGCvf?=
 =?us-ascii?Q?KoyScCxjmrWeTTnGoaVXaGwNuAa0ncupkdYpIRkmdeevEFqW1VwhtWqtWIln?=
 =?us-ascii?Q?ha/EuEfBT8CK81WLmqIuPtO6aWdPV8GLyn+wiG8rraD7PsDDCnmiWwrcTtij?=
 =?us-ascii?Q?2Ys5hTjXAb9GmUXtJYcfDz91a+25k5M4R6P4A5JgQzBixzSTylBo2fvffvto?=
 =?us-ascii?Q?krReIFVL71w2dgHRn2TY4UjmdupcWeDJPiJujGxytp6qEXvQPm4aslhhALdq?=
 =?us-ascii?Q?R4mVl26/xU9wTTKC2IVB8oFlTrHD4RPoje8J3/G8mcfBp6pR6yNP+sS1AewG?=
 =?us-ascii?Q?UbtESANMWn81Ms8LYSw90rPf9QOu1jBxpE2i6MmqN8c+Ixk/xgwiDTduqZwu?=
 =?us-ascii?Q?kGMyzru9VCBWtu4LKVwynIod1IMHXp8Zf4I3JGEdx4Zc/iG+Yd6jyea9W4vf?=
 =?us-ascii?Q?hwcVEvKtEBkIO3ljPaXuTm2ZPWSG9fbsCnJWr+amn34FVV67INOasGwcchfF?=
 =?us-ascii?Q?xfS00OQki2WJK5ipY+xeU7xXMMKRsBiTaaqepYvGrJlkybT1LP7F6z8VudkN?=
 =?us-ascii?Q?HLhvvUmbAYsycc3dSUswVet5cCvwMx62hB/WfRpY2EAP+d0gOcwq+SbTi1fn?=
 =?us-ascii?Q?7yIwOYMaeTnRpT7pO2pWANtbd3oePhV60RU42G0WbI0YCrxJheiq8tCJparH?=
 =?us-ascii?Q?ag6wLFu8ZI027wTDBsDYwrTZG32jx29ZJJKuGrbf3khSXw3+qneJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93621f3d-6015-4e96-c4d0-08df103fb6f8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 20:03:15.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h/UVu6cdIKnQ1V4rGEoUoDXMo/zNjObYus+c7ri2DXtRZiMyD6bZblwHQlb1Tt5PLXVhfsTRKK3GnRuNvzqrH76gVGJzK5dgUgAxcP/4rnkaokENtzYrqRP5zVcNf/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11577

On Thu, Sep 10, 2026 at 04:16:08PM +0800, Runyu Xiao wrote:
> ov5640_probe() can jump to entity_cleanup when regulator setup fails,
> before sensor->lock is initialized. The cleanup path unconditionally
> destroys the mutex, so this error path passes an uninitialized mutex to
> mutex_destroy().
>
> Initialize the mutex after media_entity_pads_init() succeeds and before
> ov5640_get_regulators(). This keeps earlier direct-return paths outside the
> mutex lifetime while ensuring that every path reaching mutex_destroy() has
> initialized the mutex.
>
> Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> Cc: stable@vger.kernel.org
>
> Found by PatchProof Module 4 candidates
> PILOT-4c6b03072e508260 and PILOT-4f9a36d855eb7c54.
>
> No runtime reproducer was available; the failure path was verified by
> inspection and the affected object was built successfully.
>
> Tested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/media/i2c/ov5640.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 8deb5f550..36c8bb345 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -3930,12 +3930,12 @@ static int ov5640_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>
> +	mutex_init(&sensor->lock);
> +

Please use devm_mutex_init(); mutex need do tear down work if enable lock
debug.

Frank

>  	ret = ov5640_get_regulators(sensor);
>  	if (ret)
>  		goto entity_cleanup;
>
> -	mutex_init(&sensor->lock);
> -
>  	ret = ov5640_init_controls(sensor);
>  	if (ret)
>  		goto entity_cleanup;
> --
> 2.34.1
>
