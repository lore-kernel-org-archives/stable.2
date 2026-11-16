Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794861078;
	b=JwWVq0qWt4sUZ9nSmdTK2jGCD3HuhhxeLpW1wQp6DFc+VOpbcQDYQKhtmzQXqn68SWph
	 B4F1G4VXJ6uCHYtpVMGR9T+vOayRKZ0ZSwgSVWmEjorYQAJUeWxscH/7jtw+lSOvSHWkS
	 c8aot5Gvmzn3DtfXVKRfySjrfpHFMpCRRyNZ7BTDEfAqjF2NwqyQPUcWARFjL49JV2/E5
	 CcnFH5AF2mbrP8TcLceWdge9ORuk+91R8utsweI+YPxKgm3o1b0AIB9ynHl31vHYifqPH
	 RzIdsGPcQr1MDLy3qHtGAUIRscZB4IejKOZoKagy/w+GDFw5l1H9iTxs+s+70Yi6rWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861078;
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
	bh=QD/j0OUFP0DViD/XTmoc1aLV0ALPCHZqkAwBSuT3Gd4=;
	b=jBqjagvCHrox0PMNyUJzv4w9nxAPQ2a10sS+aSfF72HBeNrUVrnqs6iNYnfovWzg7mwm
	 oIpkifWJO1XfkVtl/6MROUEzPsTCZTCtHf/6UoH+Hf0Ov1Ma6TgqKiHOixQJB2tVDrTLK
	 Z4+Bm/Em4J+A1W6cmbIURiRWMr7hylqTCOupiiz0TidCkvGLsRhLt/8V92nnzTtFwKF7W
	 NnY7h8SPMTm7ZvlK7j0G2QuJDjlghOqs5NZw+Q3ocV9zj6AW2M9r8HsTV+2OV1WGVDlyp
	 P4dSxQxUR4YOYDDM6q1jEJqYFUVETGXGkNg4j1q2bvvo4DE6Le7QwUgvg4Zh485tZpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="nuzyxOg/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.12
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F6606A31C;
	Mon, 16 Nov 2026 20:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nuzyxOg/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ3Lh5fcSY/wIfJ/UWiQn6fUZxW6x7S5YGT77CEB5j76JlFyUmOZ7ttJaRsfMzt2dKYwK/Z1qZO5KEw0R0b+IVLWXUFco9nk7+HtKZDxl9tPR/Ikrwf8izYphGSQwgSGJGODyWz5rn/2Ogoc1oQn2Uprkuv9IkeEudgpRx32MaJumV1CdEZ56Pz8n/L61UCcCo0YobvoRfSHffolu/pnur8I1HxhKa0ayR1BLS1nMWhIpiJJ16H7XZ49zP5KYqC+PXNKFLSeNmZog8jzHvfEdwPVQrCe2JYvVeIH0vH9HBRIf4AXjSOI6eim+mQ17ZLk6e6Ln0em7J2CBRrtaZW3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD/j0OUFP0DViD/XTmoc1aLV0ALPCHZqkAwBSuT3Gd4=;
 b=QtitsNBNtmnisTfVmJaM4LEczdKr/Om27pd8KgbYIoyPYRfVdSZUcYdhPSYajlxk3ieEGeV6R6BOGMjwA79aSUyi6VAKPdD8Q2LMwpTPduPRQHUiWNJrv1zVeBOLy3zJZwdNazysrr+FW1R6EKDLxStYRRewm4OiwCI6fLxSFvW6yPU6qay1v1+yUxUD5R6BKiN/mob9yDBUZ43voP9a2862HMqaIWBTTPLm9nN6+S7aHHExrRRHsK3zTBTt3L0KMIBeIXh+kNP9IN2wrlmdaMxE7r0K1wkwHnDro2VnHKNaE9tnuqMb5oaGyUDLjuReFizB2hsB3NJhK4hZFo6sUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD/j0OUFP0DViD/XTmoc1aLV0ALPCHZqkAwBSuT3Gd4=;
 b=nuzyxOg/IK0NkOzz7mSFJ4iBZxTEjS+5t1P3qPi1els7LDtVojm4uoceCNXlQZ1OpLbpFnPHeWMmzrNFJdPSVHxsboAk3Q3Se84wxXSIq3ISwlpsG5EI7bVCfydo6GYYWVJccNSPEDEzcqlrWu5EdlisIYtZAV1uLV+pbXnVi3XS7tdLepYNFyS740+b+6wer8tTuTqs9Ra0Lbt9onNdHmo59ovRW94wdz+BA8n0kmwZQaNeO/u1R9zzRMXhkFdEBBRdMjL9ujVB/bkGTBc1Ne6B/x4bPZHa03HnPeuZsvHR63CtmXrGulbzX1feXEOL0vgdCAQhCHJlZTLAXloArQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:31:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:31:15 +0000
Date: Mon, 16 Nov 2026 14:31:05 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, george.ge@microchip.com,
	kelvin.cao@microchip.com, linux-kernel@vger.kernel.org,
	logang@deltatee.com, vkoul@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: switchtec-dma: Fix device reference leak in
 switchtec_dma_create()
Message-ID: <avtoCdl4xLlyhID_@SMW015318>
References: <20260916093332.2003909-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093332.2003909-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: PH8PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: c44eadfb-f107-44c0-ea8e-08df44208fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KJeRnTj/WUb+WakAHQCkW536AeziF4ekn9OAhPp5Xc+FQJRsRlO4WBsnIAWz0WrbuQmDvXlkIVTKnTOPniqpLWe9B+u5DX9rSA/LatUoow4OQ8hI7LgG6MjNOa4csjMhob8srxREXthtnoE7nE5CLgViVjszuIU/ksrw7n9OTy0P20oFLLjn3Bu5RWYN9WSkqAWrZ1tn/53opNJI5+qYxWNYgkBM+JKfVh+KWJgWA5xWuORSUn9ZgQAfv3TFVg/kNO9cztqPe8+Y6j+2SDLX90WVARkgwaY4zoCcAuSkelPtp4mpjyAz6GL/2RTuH+Qt+iZ0QrHTZlPBqwUyLNnwSnpxSB0MY0kBxbxQTeJUHZ22zFa3TvBLWANifDK0I1BHjSjdI66qdvMTGnwT6NldcI3ffdJgv0pfIZzKqenXaLfzoJKvYABzulsJihQ7CGAos98MrCOV8Iey9Z5TSOaJjSh6MJPDm8Yq+S95hAsBAdbeplpl8AHnWeoowjR2xBQ2/7Onbpu02aHqgM4Yw9sVehMRN7TUbkbCK/vYcVwuP/+aF5vsZ68hyMHSneZ2NDG4ZcMj8b93nZb3kSAtEjL5jTii0arDj0NYbGsLSxgTeHyZIrh/aavfCsW3vUUCaRKOTWRy5dLDbg2GARtJytAtz/fM0vs7deXaVpT+Bg7yITI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BnQ1YeKiQaXTQ4JCbkBuEfmmoj+o6S9QX8xBTjPwHtjBU/BWZfbrL/Oreuh?=
 =?us-ascii?Q?3+5HuOoIkODKpqwWn0CSlkRt6NaakMw9+niOBsHWCBG08g8iE2ohh9F3Z66j?=
 =?us-ascii?Q?hlkr1LH/A7cHkNopQVSu0su5bkxXWH03xhmhPcqtLc9G+TRwsG4cs2p0v38l?=
 =?us-ascii?Q?Ywt336yL64JUVBIhX9DajWcJF2qqRHRjsJIP7xfxJmM+jfetQ/IB5+tms50R?=
 =?us-ascii?Q?IzKTfgMf6KX/pYDdS1i2Y9TcvrLnKd17hkSnksgNznIHU6u05us7DkKRMiWR?=
 =?us-ascii?Q?mHH39zmb3IZnTQcRomYAxXzpcA7bKeAGz6Yhqm5q6WP5SkWnL1GmrxCqJfgI?=
 =?us-ascii?Q?wammdOnFqaaW3O/4gl4UOxmojsCpZkodKioY/H9hcT3pL3fGlafS8iQF7QWk?=
 =?us-ascii?Q?DtFAY6rnoZaJcMj2xKL0fqXai6mlrs3HkMuetdkg+ZdO813OSoy4Yr/cFM3R?=
 =?us-ascii?Q?mJPwgBmglM7qHpsVhEEahRl9vxiu7a+ld7EkBaLL35o4mUjKaaT5I9yClrpw?=
 =?us-ascii?Q?+oZ3oU537msPu+vp5Ncw62zHXJbqRncQQmUQkvk9oT4L2fLVkbWTTEYCfMJA?=
 =?us-ascii?Q?BoNet+jWb12Ax4oxV36q7Mmdm07020n2DFGggpXL6nXwst0JHwVjq+cz8PpV?=
 =?us-ascii?Q?Pq5WBtksHtx21+dwwqcJIjIGHxGnoMq3F2lhcLizydL0anbgjf8PPr/g80ZM?=
 =?us-ascii?Q?eLuFgVkc2tetPZiyTEdqiv3kJ4ooIHD2WoxWmVxpRN4XYx8wnOa65/+6ecxY?=
 =?us-ascii?Q?0xEH/Nwuiqs2LnYPYQtELwfwmNpw3h45XZSteCLBkC4x1xtohsWmt60BMjNn?=
 =?us-ascii?Q?hyNLl0mZh2T2lrrqlYPwhv0epMouRPASBsQGePXcV86VIcrXIGE/puXvJ0t1?=
 =?us-ascii?Q?CJ+RXIy5k/0cdrs0sVimE4tdiafZZIBkB7M1QngyzO+cCYAomGLVV0gc9T/N?=
 =?us-ascii?Q?NkUCVlTh1IO5wuZ/HtL8v0Kg2xacDAvOEBQyNvkVuf7R3uEi1qO2zXTrXmEw?=
 =?us-ascii?Q?cNfFsFCkvTpVT2Ck+s/psO1PQFCeZu+a1fZi3O9cTQGRLnXnOLZnnK6HDLDj?=
 =?us-ascii?Q?hcJLycPZQ9heiDKlAcHd9bSLLgOyov9OtbCpO4oH3oYMIvdMcM6vouCjVZqP?=
 =?us-ascii?Q?7otxUfRCFA+NfPNB5osWAgPBKMvUC/i7cr3r/IhCNzp8Na2X2JeZEWb/TaOb?=
 =?us-ascii?Q?Yz4SNro3gi2hM5qnLjgISLO5LgLxV6U11icIZRziTq6uvtNi+Jy+guByZpzz?=
 =?us-ascii?Q?pyK/skbM9Eis/jsdZtrT79kl+uHVFcRqUsWJLriW8sih2Gk0ZDHSunOJCH0N?=
 =?us-ascii?Q?6dX0/od7LrgR2FL1aZq0Edsx1ordOSzOdG3AOmxdsoPyn8jAeQ5embAp6+GM?=
 =?us-ascii?Q?O24+ETkYSNibjX+SYVn2cY3Ur+JXn3OoxyjfkJ6XAM2moHQp9EoLYSybpBWP?=
 =?us-ascii?Q?BUXgT7LnpGAAbFigEx61+EI0R8AC/H+jCswoXqfM0qJrVNjdmsK+akos3OMf?=
 =?us-ascii?Q?Gd0i9bgrnuExfPvx2wDa3pYh1W2gpLG9yyj6NRhFdhdnMeu/cWhhE608YmbV?=
 =?us-ascii?Q?ni1V+aweoDj+vbelpZgtSfgqK/9eS0+JC0FMkv+eQ6atCNIPT5b/+vaBcyf6?=
 =?us-ascii?Q?biyWpiWLuX/RkEhc2TTs5MRYuDThLGGeym7U2BF6LFfbIpZ1Wmzu5iIJj189?=
 =?us-ascii?Q?05M6N8KhmKuy9jsyYDGLFqKrzCuTiigYB7mqYfnsr/vuW9SWTh6CoH3gS4IT?=
 =?us-ascii?Q?hyFSiAUaF2ZCD9muZ/ZDQFJtorFqak7vFgKhttwWbB4g5WzvJXYe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44eadfb-f107-44c0-ea8e-08df44208fa5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:31:15.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6RmaoS827UY0enfhVtrf0J2vuP9jNZVTubVDhKAlLKkB7pmex/AzFtYEf5CUfVoAUlXQfeeO8CvvtQ3QNhfCPG3DEeqVNGydYXaly8IM+S6jU0dYO55nMcqILxHLIOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001

On Wed, Sep 16, 2026 at 09:33:32AM +0000, Wentao Liang wrote:
> switchtec_dma_create() takes a reference on the PCI device with
> get_device() and stores it in dma->dev. The reference is normally
> dropped by switchtec_dma_release(), the device_release() callback,
> which only runs after a successful dma_async_device_register(). If
> the registration fails, the code frees the dma device directly from
> the err_chans_release_exit label without ever dropping that extra
> reference, leaking the reference taken on the PCI device.
>
> Drop the reference with put_device() on the error path.
>
> Fixes: d9587042b50f ("dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef928640615..b07bdd0ac540 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1297,6 +1297,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	put_device(dma->dev);
>
>  err_exit:
>  	if (swdma_dev->chan_status_irq)
> --
> 2.34.1
>
