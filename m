Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD3425882;
	Mon, 17 Aug 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976996; cv=fail; b=RGfO+s3bNHaWKkv+yduQtaveW65AuVw1FGtBdnjClOqz4q/IL9Zsy2YnyDVALIFaQlyz1jpnIsHuSH88MHCURSA8Zz6D0NxRSp1xpCoZC8D7Dt1tHhWmrvrOEg+TECq2OiZj/ywuHY6BR9qhGHVvrxKj59Fr6QTCUPxEyuIyPyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976996; c=relaxed/simple;
	bh=YFj0Q/nZgwPEC/APPmXJL1BVZcDf6rV8qHoWq1KaBtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ly5/u1+93oZv02sizEqXcP0CqHJwkXNZ6OwyPzwwjNN9afpelolcHoBW2+Z1ty6W6ev/wvlAXAvC3G38kSqtlMFIK6H6ZgrV3uF0OS1+UDDFxYGbI6YdBz4E4GvpVjagb+pdGHtschP1zFn8X+r6MkhcYJafnt9+kY0yHM2FClY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mLEqB946; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mLEqB946"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzAMtZqjeOX4aVF0NgmuSLUxrRRCdYJfUgY008r2WiwqraTUwT7NZ3lMfB4OkQm/uCN2ScUc5HBnVnwM9QCHqwaPdFB+qN6TdNQu3QQZ98ENhYg8wAPAFiV9wB7LpR4q+/lYnQyovee07GEoBmmoKIuJRa9pl7yYbb8E7iGsRYG6sp3VVt7lBjRvoruZh6VI/tXuk2np8sfhmfiFnOA/nIZhCuw6z2VcFLkTcEXMbTfyVYJXrBF+N15F2Av1CMC+K24OuSmo2d978bfEIhIvQG3tuvYPGD0o4F5RZMOSdz4aUOwNV+CBNrR6D/byFf9eQtNKURc1MX2t75zzneqAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJEZMKA6PAepgSWNqOnetr/3nRcz+E98/b/YMby8yD0=;
 b=df/S1waMXS+Eft7cAX66Pfh17VvVWSttGgKeY2nvELnnfQkqpalnyANYsJW2Q6d4TCTo0CCTEvHbzCSEq4irBrwfbABS8YWp8sBQ1BMed+4Ffu0IeRceDx9LhCE4RdIfa+3Ianr3AqF/yNSyDeRGoTs1vqNgalQVHAFIxcCguoJwJe8gpAP0/VWTewwsKNZX1nkCkDB2lsxUQ8SV+KqHatYFX8tBUtoTOP+qeaZRBGXMxMECppbDW7jN4t3Y636d0V/4BvsyVApbYM2vOXcd+hAZ6rAbXAPksNFpXD5br+rVMX7egRnix2hjVkNTgLZEieg45rHvigkAvLELKu0ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJEZMKA6PAepgSWNqOnetr/3nRcz+E98/b/YMby8yD0=;
 b=mLEqB946q6/5LTcHfZ5uvZ18yhaEewpQewyUOSKXmekk6YbIwwzBLetLhGNYWzCEX1kcsMB7KmSRknPIsUylEjdMvWsZhxG/53kWqR0ajy1WIOWlBLwmTkIUTgLyEv7yYoI5JvhDYdvSGK92y9tYdRIe1Ml6+MATxYAH9BxrYRfJ/jIp90lAK2ahwfKNYOq/FOaecA0T3uucnTZ8XUEqN9HAq2mp9d21zkp8UDt/Z5uQ5oMVUHfTNkFC5TCt5LFpU5G0OGwbdLvzrtfY5TTgYP8sbk+X0XdBSH+diF9X7s4AwOP4r7HnQ5PJ9y7+IsRsPF4pTjlQ9EtoI9omnPg89Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11429.eurprd04.prod.outlook.com (2603:10a6:102:4f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:29:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:29:50 +0000
Date: Mon, 17 Aug 2026 09:29:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 3/3] dmaengine: wait for RCU readers before releasing
 dma_device
Message-ID: <aoMa1GTFd-R0Ep6J@SMW015318>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
 <20260816-dmaengine-kref-fix-v3-3-7e76187145df@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-dmaengine-kref-fix-v3-3-7e76187145df@amd.com>
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11429:EE_
X-MS-Office365-Filtering-Correlation-Id: 5066303e-e32f-4a28-b289-08defc6bfeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0G/PZ++y9PMqOXutwWCPsgBs+aObDKW5Ygfnc2kBPIjiuRKJYQa2QqnD/ATS2QmR3uR53yRmkEm8apIA4Wx6UZxIqLHw3U/cuKl8evHLp62vuH5BG/L077AB2MXN2viYLdHGHihiq9zw817vyfWhCHJjxJtkCj+jvzDTMfz389NxQ0ZbVIprn+h86PFZ5btPoQOVxPAbsKZLRIPNN3OMnRJJf7TjZLRyjGPNUtNlU76ByZxbaQb6IVupYmExOW7RKe5RudpptBWocJOuWrR4+cNMWESW8BHiv42Keq8queg+BAkovfnzFOY01Yz4bB47fvBcjsVA4GuzLnhDYMpX6jDiyJSGt/G6Ch514OohePpOXhrxJQPa9K0XBW237VfLGOACXqcJXnMWbhSLKy2IfBfokS8N8L+XBvsU7BEUo94+HphTufMtDDWLrARSWBDriPB4c8VnCHic+s44GvQpBRDAjB6FmC5XVfH6edi4Jj0rE5pUu1aATmXGg7gjvkr+Oc7YVBRC5o04mStMRTN+hS/rnv3bV/LsonEcmQCFy0x9VSOmW0EGjm+tAB4x57Axrvx+KNoTQVxiEmfs332onr+v66WF65fqFdvlSKllBuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8nEKWU/xNzfu/hKBxJb3yT8HDW5IN6pALXj64uICNxMCNORRhwYGo0QWLfW?=
 =?us-ascii?Q?ja7i3qdt07tt4VPTj5PjR0iypzjjJHwnjX0MuldVdTeZh+iRxBRvIFlMHpR6?=
 =?us-ascii?Q?VpRBaggqJojA7It3df++boKKcMvD8m31dE+ED3A9tW9+YWet5KJM0ufcC2aV?=
 =?us-ascii?Q?bzRgiyKLQpJDDMp8EV0RgcmUKCIq2Xk7FACJcmNfyFgRLd7PaKB1XF/HOzLA?=
 =?us-ascii?Q?no2Lsz7bH/VN6jQFsRAupUca9527nDDxscacpMgPPM37+yk7+tOaYmg9Sanw?=
 =?us-ascii?Q?uvEt1+AvOCSzNO1QXBHDYQaBCnzvFiKmx288Q2Wi0br2yXCG//5dQf/396B1?=
 =?us-ascii?Q?s6LysFgwEODegjxae2pZxBHnd28Wr/9EzVxAbkkr0/U4KpLkrMpRCs2bughf?=
 =?us-ascii?Q?45XyW5rfyaFkWnNrQgUtpwLpNfQ2HRjPdLStPZUzjRKxNr1YkA3vlISjA4qw?=
 =?us-ascii?Q?frPg5Bv3LIQ0w1Mn2k/92yzCF3qGskFH8jk+qmkH3yibdZ5Hn5sYHawB7yg4?=
 =?us-ascii?Q?oGEQC3xz7u0NnHRKCCUZjWgzjCq0cJTbadlE6uFpzsmzA6Os1WrwI05rIDEu?=
 =?us-ascii?Q?enNJB23UB6q68oNNynCbpIJ8Yu30Bwn2vmTmN6aKoCfW5tPLuSYcVsP5AKTL?=
 =?us-ascii?Q?k6NK7kmOYXI4X0br5pkik1r8tCZYYbhYlGeNTeeDmuzfGcP33fK31Ao6JfDF?=
 =?us-ascii?Q?RK46UjYceAfy/1zrkRgByWfwxoPDBuPfPfHoy63OK6prtAu1xppd2JjzZjff?=
 =?us-ascii?Q?IsxwrL02kIZfVvFGH0MRcqATL3oYFg9A5C1qOuFA2KvZ4nIDfsTzARG+W5Xl?=
 =?us-ascii?Q?hc51JP3/gQt1UEm36UdiRV2tjBTdIGiu3mt5BkL+6/Ai2UE5tYAiu7yIK6l/?=
 =?us-ascii?Q?CZ1hq/5hO9yTbqSZKAqpBuHz0Ld9uJmRAkrZ8KyzviFcFfb/5m4TvK0gxhB1?=
 =?us-ascii?Q?T/l74Fcnyd9qiLxqkJsLK/o+bPAthF8xa8MCbb+ujXPEk3r9F1u+Gx3Fh19B?=
 =?us-ascii?Q?Sw6cv3eEZUhatJ6YkXy8NcUbYCwP0FI8SZUYhcyg13DlseTEVmJT6T7VD4qM?=
 =?us-ascii?Q?l8nxUV+9P9lzc9TXDduQbyG0nsV5l8EW5v5/aYc173MJSDzwOfxWlUna0nEz?=
 =?us-ascii?Q?BnrrRy1Mb2LgmyBIuvZOvGSLbw2EyggxrWTz68ggbIQAdZf2WqSP8qUM5zsg?=
 =?us-ascii?Q?ZZicNZeU1odr+MAWI/crDO7vPdz9K4ma/a4tsQoq3Te4zXQg1Ic+3AVlb/9h?=
 =?us-ascii?Q?2FL4StTyMbGEbwC0lqPjtGUUY/40AiRq4FN6QZ+4M4CQuYlwwdUKcKqRZxjU?=
 =?us-ascii?Q?xvlIyUxKhAIXgEE7vdv1s5r8DGXokjgm4Up2l3K/RxcQtIc968ZXwCYjddFj?=
 =?us-ascii?Q?5U0OS1pxoS5UTKyx5c4o9Z6CR56Li9VFPk7zYpWDspBG23jas4XsEvhWuNUO?=
 =?us-ascii?Q?JBAzXkjcNKUbljScXMQbp1TdV0M53bp7K8QAC0JM7VhwaHwA5JMp3VHgLXhT?=
 =?us-ascii?Q?2DIW9KzHthDDb+MUNsTk2ubeqMq5j4TX1DSGCPOLMK4z4rXbpPkfWyd9pRLO?=
 =?us-ascii?Q?J/G09LmvZ4nT1d2oRQVXTURuuHLSFIFhRoDnrKvWMmVHxdJeGuIVueo8jD6O?=
 =?us-ascii?Q?Vbc1KMXkCZeIarTUh6pqhg3BzAJX5Iufk6/hdveQTYnWHowiymR1nRwNQfDW?=
 =?us-ascii?Q?h86uKzwJ+IJ1u8dVaULuUB8S7MtZy69NX0qLn2q2ux0YAE754jDgSM0T3016?=
 =?us-ascii?Q?0TmQ3hogPjEzkEVHp0NmgGsiunRvySPMPjcu+e1BhL2MPu3ykkBh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5066303e-e32f-4a28-b289-08defc6bfeaf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:29:49.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwdgIF2Ic2u9iUFnUJFbnulDRwxTWY0CQEoAwJfFLiEKrb+/xsUaNz8qTio4wUZ6PuxoRwnR3Av9xOAVafo1n18zXz+m9AYfXC9KOwtkQTkDxHG9Z5Xjw8s9RQ37bz7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11429

On Sun, Aug 16, 2026 at 03:49:27PM +0000, Shivank Garg wrote:
> [You don't often get email from shivankg@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> dma_issue_pending_all() walks the dma_device_list with
> list_for_each_entry_rcu() under rcu_read_lock(). dma_device_release()
> unlinks the device with list_del_rcu() and then calls
> device->device_release() (which in many drivers, such as plx_dma.c,
> directly calls kfree()).
>
> Because there is no grace period between unlinking the device and
> freeing it, concurrent RCU readers in dma_issue_pending_all() can
> access the device after it has been freed.
>
> The lockless walk originally relied on clients holding a dmaengine
> reference to pin the provider module, and therefore the device, for as
> long as they might traverse the list. Commit 8ad342a86359 ("dmaengine:
> Add reference counting to dma_device struct") decoupled the dma_device
> lifetime from the module reference, so the device can now be released
> while a reader is still walking the list.
>
> Add synchronize_rcu() before the device is freed, so RCU readers are
> guaranteed to have finished. Keep it unconditional: providers that do
> not implement device_release() free the device themselves once
> dma_async_device_unregister() returns, so they need the same grace
> period.
>
> Fixes: 2ba05622b8b1 ("dmaengine: provide a common 'issue_pending_all' implementation")
> Suggested-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index bf491eb10596..29b128aa0bea 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -429,6 +429,12 @@ static void dma_device_release(struct kref *ref)
>         list_del_rcu(&device->global_node);
>         dma_channel_rebalance();
>
> +       /*
> +        * Wait for RCU readers (e.g. dma_issue_pending_all()) that may still
> +        * be traversing dma_device_list before the device is freed.
> +        */
> +       synchronize_rcu();
> +
>         if (device->device_release)
>                 device->device_release(device);
>  }
>
> --
> 2.43.0
>
