Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73243E071;
	Mon, 17 Aug 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976283; cv=fail; b=aZM/tbkDmkia3BKupzas0Y+ywhzQOS7M+LV5ke0O9Q4KsJ6rzEXsDcbGVam7A9LmsQtQmA+0la6Ct11BEVJ1BhHQym5k22pazUeN3oWl2u2fRJpEVfc2247BfZlhStZhKno5VACELupdYgodPuMLwnldVgfSMG6b47dTotebImo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976283; c=relaxed/simple;
	bh=TNXBugVp9pqBrzTgoawHolyBXWTTtFQ3p4QYKnZHih4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooiFE2qmHsyCxVhA3AAAqbtJnpkcQRF0YiJzkZYsHVWQWyICdqpGbmg5IuIpJmKzXO60/z2mPA+Bqz+aXHSmigA7rkX/sy7mx6E4SW36SvK1Ge/5CX/SW/JoZH3u4DmEVBU8GNuHUHFtrvJKEs4G6cnLkOuKa+qAvmaZGV49yNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oZA4QigF; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oZA4QigF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbAz4/QDAVst10lVxSw6K/FwlleR902wKUVGbTGawpHwuyzVU5USd14PGdfkwPZ9WgIafSlkimK+v4GflL20BQC2f7jyVALyyPxNFg5LXGxwFMVTL1vBI9yzy4zoZ53wmtHMD+vkK7kq4GK/D8CY7vITz3VQfFnqhmDxAbSltwZUBRVoSCcQdh0dVIewH+8KMycxaLRhSyXgBf3bNcQrXTvL1bhpfMzQjDyh1LUDY1n66KetrgTqAPUkvDnk92DS9pYn84/qGcwGWnJQzUxP3I8eQQZl7vrYNRXx4GvE1Ecx+JOc/9l6V+TelH3wPJcnqToQqxQeWvFESlY8sT26uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ik1mQF4XH1wNh3gcvBorHsCE9F4XZfhRF/PZQfj4mE=;
 b=Lp3BxsdmQylSiK/uXIeD0qrybhVArLTm9hNIkhZa8YyD3iiSq1rF5DlfmI9+MehEJd2ryI50Xa4dtde2HAb4++widAHHVSqbNB03Py7Jj9o+yKve1pFpN//6850rhgzjN+Z3QvOnph7+YtTzE0aVogn4mvTcHa8dCIkcKw8iBrtrqA0ld9Pc96tEJgsvQ6wXbAIrKUPm4CeTNvSYJPOiPWAYj6wSkrsVEC9NSCoP8BACszg/uuE7Hd6wJ5ZSHN4xQ3QOsOFXqNFHdCgmLRXL3BnXupji36Fm7kyhxeWLemxLFT7og0DtYK5sMdtgCcQH5PdufYW53XrWt5GLlroFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ik1mQF4XH1wNh3gcvBorHsCE9F4XZfhRF/PZQfj4mE=;
 b=oZA4QigFsTrXL728b9HscGSl2QNdh+vI8usIu1HFSDKVNgU4YXNucP0Vzt+V68rtRxANaYM1KViVJSy8+IrOB+Qc11gmlyGz6l2MkbjixBzL7f6zAtVUz8HO31xrxdMvJ35gzCl039WUws9CAoz6SBy0L6Ph/6/MitlF0AnNwaJx6ZsBZq7c3sV46w0eb2DAbzidz3XTWLQmhSlI0mxdFjUH92KWleX14BMj1RF1YjzoMmTuJkSrSwFR/c9mJb3XQVl/8+UGPjZ6q3dIPKn74Us+z64cc/mwjcRh+Ys1deqHwjHc08scZFg1AAvpdPIy0Cgt6Eiz9yyzZC6eHiogPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB138695.eurprd04.prod.outlook.com (2603:10a6:20b:7de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:17:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:17:59 +0000
Date: Mon, 17 Aug 2026 09:17:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dmaengine: Fix device kref underflow in
 dma_chan_put()
Message-ID: <aoMYDJ3TdCIqTbEd@SMW015318>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
 <20260816-dmaengine-kref-fix-v3-1-7e76187145df@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-dmaengine-kref-fix-v3-1-7e76187145df@amd.com>
X-ClientProxiedBy: PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB138695:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4c6813-748d-447f-df38-08defc6a56df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	659KCaYz13lpUyd95vTPQ/eUU5mUuc2A4g1BUcVrhgAlJ4FuiTbrloBOVEjLTYAqGvQxklF9SkXN9xAmpiJiQrIMuLhEeSVXHV3kZGHTUEr9/O8k+KiLUR9CkoyNzDqPgW+tzeJcQIQjhwxIEm+X20cGYyA9uic/Kfw/t2IpqEJtsyb9bP7tDlOxEEFb/dbZ0sNLllKknWzXJw3RLLVeaYtpBXpwsTXuFA7Q5JXPsWP/FiItXPdvTHjrdZFNImSmVGcoCTIH9bmlGwQu7ir57u/Msn2VbUX9cvNgrGW6rrvTSO5l5DKiXrHsjcDvhgMSTodjxnPsJ7VSCEU5B/7zZx1swZFhXC9c4knbGgp/hYHR7hDSd4sftkplWZCel7mtmatBxunfpL/SrZAVWvHGVqBxbxizlSeq+nOPQ+neSaWr5QUeGPZQM/BGHE1waWPDqzd2FdmYMv/OpwSubIixJAWb51A9hGtt1n9DOM6Y2JTbXheBWMN+FDFCUNtZLH5pCSWFajYCqrTEv88WMLNHJ5Fw8rLv0GpY0lNrazxA+i7dx0/aztPbxKOhkJwyb5lQeg1SShRR3YjAjUj+b6ahGcujeA4GxUFxcuVIWaLdEL9ATvf4mrGaPHozA/tQGCBtE1EFMWblooHIfmEkOcB43fBBYgLvf0/zs5+8rXyBETA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gk03mxhtc7nTp2XxcnRQQOHB+SaIjSeWB8AMV+IucWs8jeMsJsqd45ucfc92?=
 =?us-ascii?Q?wZBwdaJhFE+4daRSHKcNdBbJQgKf5tvCrN+0IH5tK9rcmy6ygsSY+ApGqIbS?=
 =?us-ascii?Q?Ut643xWZcB6zrmRkremmKGijFMW7kr2Q5BgwNk1nbb0zDsrU7SUzBx6iYlIA?=
 =?us-ascii?Q?iuyA4PCyIHHVb03U7foAS3K04uHbRcvVSRAWu+LV5HNhtZ8tGrtw0Sy9TJ4d?=
 =?us-ascii?Q?Za/DhktxAIsckw4oIuE+aL2hr+1ZJ6uIjEqujlyUwkPlArgulnm3bNe5ZhnG?=
 =?us-ascii?Q?/TASuTmK97XzICzotHcqKhDGmUeT7V48K0TURlOAWYOPi39JyKD80MMGnuAO?=
 =?us-ascii?Q?LPsV+vLWhaUQOJEpiObzkgEDUhOTfqQaOIcjq180DcDYF++VDoCUhb/XRNo8?=
 =?us-ascii?Q?o0Ly6vOSisnZAQ1W66JNmhO++JqvEQc70xPk+B+JiajQo4x4/3ICCwbRRcOa?=
 =?us-ascii?Q?JQ+n1+9oE+iJnrQJDOgrpTGnm27qUgvtY+0plIAoUSFIlZH9hEGjNtAymEPW?=
 =?us-ascii?Q?Nfmhn262cVZti9ce/4zZ/Nl1FFz0cnmK9M9FmZHaZkCV7CbUKlaRdv0+Mh8h?=
 =?us-ascii?Q?/cMGj1TDc5vz6NoTLSGvtt2p1b5Q2S4DIHyZcGCZzdiqTChzlIzqFcI22cld?=
 =?us-ascii?Q?LqrMxAxMu/Smd9me5kaPH7Uw1sQdbDs0RS9etS02yupM3AQwqVnCtLriMzZ3?=
 =?us-ascii?Q?V/9hkCyAEddhkboYTjkcnl/OhhzStX6mnGRuSHGsPFw/r35s1tsHQS12SiqE?=
 =?us-ascii?Q?SI0TC9BYN9h6Au4fSG7TWY1dOEBE/OXZojWTQNnDf+1Wn0XZkmxa1wFCBIOF?=
 =?us-ascii?Q?WHTclCWozY6k0CrxRlTJh/hxuHN2fTjfvMZjwLiQo4lU04Od7JfSkJDihQb8?=
 =?us-ascii?Q?D9jikxRZ6ZkIjexNC7GsTV79wG5NOlUd9vzjpPowdWkeAmVM9x/k/D6cqUNa?=
 =?us-ascii?Q?JgSm4pA/vPjGDawAwtnpOwyhqXTYvejOoz1NnVdn/sd58PwSEjE+arAjXF72?=
 =?us-ascii?Q?oFxM6SaDaUsHuwHO+ePT6pmxDiLkKJdc8Oq9WdObh6tHip/mhCLqdfs+moTT?=
 =?us-ascii?Q?XkMupyNjLQ+wkkjatqmdtjqH5sBB6oelSLEHum276w+iyUNpqQwLTtWZyxU3?=
 =?us-ascii?Q?jsF4Av8zozkudyWAO7mf9ejaRffxq6cfEKBiKP6FL1UFZHWN6qbGuuWpRlbF?=
 =?us-ascii?Q?Nyp/7qvnc/HYQFhnOHOL7LsMYLUqsv/jQIpcNtUP8bjnShOe+yvGhS216C/Z?=
 =?us-ascii?Q?HG6EtpPBMi5CLJlYNVHQSWFcTleumfZ+guY2xh6r7fOnkBob4fbpaC4FATbG?=
 =?us-ascii?Q?TihSKEdruRrseuZEC0y3hTgXo0ymaq2jGwiWzAW0P0hB1dSjouVGuNYI8IN7?=
 =?us-ascii?Q?Im/0Oet9GYvX2eE4dzbv3AHHZY84tyyWWKbr9OKeEvldE+/u/MQYLdlV5vkj?=
 =?us-ascii?Q?B0YR1YhpyJ7M49y6GaEa3D548wgfvzAIx7xp8CYobtBt596Heh2CD6NtCGB6?=
 =?us-ascii?Q?S6PNarP/L1OAAM0fuFToYD7zsv6V98xCKvx1B6bP7I01z9sG7mO6RNN0W7Cr?=
 =?us-ascii?Q?Pip7+IYLWcWbOYsbIN/Iv6pljiKzohYVNttDZpKIohFCw689vXfjADfdpBi0?=
 =?us-ascii?Q?+bR3F+DAg5OliF7uMUQVEXwTQFpzuBG9tUafuxLN54lNOnJo/0jdN1iOj3pa?=
 =?us-ascii?Q?GWRGv2bkMBbvZeA5TzAhURbGbmDklETDI04f/qiXLCF/WvQCKNRGVjU42e1y?=
 =?us-ascii?Q?obyJAN1ViW601yosGsNEn87i3lV205Obov6SN5jtPiPmRn+TGZh6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4c6813-748d-447f-df38-08defc6a56df
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:17:59.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIFjyvgtNMzkEesMTATaTfGMjWGTnkXP1O99XmfDMb9ZCwE7fW50ppOyAJIudSD0dwjCmVPNB/7qkjwpF4lq2FCZHnuk8qwCzeszr8OjfspUFmYXABFjCkZso8qZukNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB138695

On Sun, Aug 16, 2026 at 03:49:25PM +0000, Shivank Garg wrote:
> [You don't often get email from shivankg@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> dma_chan_get() takes chan->device->ref only on the slow path:
>
>         /* no kref on fast path */
>         if (chan->client_count) {
>                 __module_get(owner);
>                 chan->client_count++;
>                 return 0;
>         }
>         if (!try_module_get(owner))
>                 return -ENODEV;
>         ret = kref_get_unless_zero(&chan->device->ref);
>
> dma_chan_put() drops the ref unconditionally, so every fast-path
> get/put pair drops one extra device reference.
>
> The bug fires when two conditions hold together: a non-private
> provider has a persistent client holding chan->client_count > 0
> and another client cycles dmaengine_get()/dmaengine_put().
> When the kref hits zero, the subsequent dma_find_channel() returns
> NULL even though the provider module is still loaded.
>
> Fix this by dropping device->ref only on the last put, matching the
> single slow-path get.
>
> Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Nit: add helper dma_device_get() to match dma_device_put() to make code
more symmetry.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6ffd8bd82154..516d6d933208 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
>                 chan->route_data = NULL;
>         }
>
> -       dma_device_put(chan->device);
> +       /* This channel is not in use anymore, drop the device ref */
> +       if (!chan->client_count)
> +               dma_device_put(chan->device);
>         module_put(dma_chan_to_owner(chan));
>  }
>
>
> --
> 2.43.0
>
