Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465003;
	b=RqyelpD/Ush+qVNGNxwIZl14dnkHr24Nk7HwX04h/Ani22tFS+83WisR3b7YYhLgwb22
	 NhU69mAmxKrII3CNLAhApTqKunpfNsiZngxsFGvfERawSXsc45/lqk+uLJ4ZuT0kJOOhQ
	 2E9URLO2JEShQj4Nxj15Ouz6ckPxviRVrhFKwtsqOiKzZn+K8j82RpdlAYGPpvSBFYEw4
	 o4JYYTCiHmsuYxaFV+dHU3l7UZYWeQByhcJfJyKtcLJTMo+4kFAkFRWK+NP8RR2Kh6P89
	 Oqf5bsRUOk1ppHuKr9yAj19MBYfhXSt+BWP0n8VVdyZyOSJdqGH3v6N4pUOEz7p9QjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465003;
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
	bh=d6bdw2mBNKwScuhtbCFtP6qmLnXai3I0VDw2ihoq2ns=;
	b=5MbnXW9IOs+kAY3mb+6jTegx8Jh6Y49Ho05SVPQYicpNEY0yu7bb5MiketjIrwtOHeGf
	 LsBBhhu26Y5A0CdJ/y8E7P7/Gkz4Bho0Belz+GJb0zYFGXs0LOtbbonYljcxak/uHdHL8
	 3p5FOcVp7nXZhMDNen7PqRcvQbRJhnWYZY3nXQlpKqFk+67iqfCJRVeUhU7PeIs0WvhxH
	 8kFH7ztzU6KtiAn2NV655mhxx+fKEfQuZYkb8QQ7cyvfi2WuhyyZHRSA0/6/7xjgjgmGX
	 ghas+PZ3/V/mfMUDHa5YAWCE29xGw6id7xuFFQsKuKgzk/4eI8rIeWA/E+4EysvoPvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="AB/3L8Oo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.34
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505F606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0505F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AB/3L8Oo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YF6mVSiQsBPijiIUfTCTN2dc0NdhtmnpDfOm03YIwZ9eGV/3XD+cgvDjsY3hy7g0AI/JfRbrzB1qmRcT9LSodT8y7YI1HOIyFruSj21CyuflIQb/kr0+tqRf48YS4OQawKwkw0i4kKCt2IlnuTAiECFbnoG4ozIhVCkrsb02DsZAZjnnUpGB/veCWMc/q+RBwitLdrdAkCfbNyMBgv7XM2DdqEBOxRf6/xaF0y/Zjyr5tGvDilg0hlrtweiRblIphvFmawm/JYaIc8FNbQzsS7c+0lhvgfjvag+KWPtCHgkLRjS3rIw+pwOXzAw9LCsC8zJJ2jVvhkg6ET4w11MRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6bdw2mBNKwScuhtbCFtP6qmLnXai3I0VDw2ihoq2ns=;
 b=TIVV0cLPEK00Jr2LUNmtCqIvGUYpM0NvAIhCm4CsxeXyjj3A7Legg9yaNcszyzhA4FcR+4Xe3tNt0f4LvOEBeCL5sE+y+3dQZUAXsOU2zxb3JunLRbSgeJTLHpN6sFGy+AXA5qdVqaOwpznKy6Iy+wHJTteOvYbr/M9jDVip/I+tpwjBL8l2VGoojWC42jWHd7O2jA13veefaTbbRhd5nLYVft9zbj1z8gQPgRGbaCFxIrnJOjqrp6ntMntR7Kqah7dza6/4n5ViuwfB0q1rE8a/z6jkE1DVEqp25nycxNMAbvXM6GJya9fKVGM8gSz4eV9nUbHpZJ+4ojz+o5LUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6bdw2mBNKwScuhtbCFtP6qmLnXai3I0VDw2ihoq2ns=;
 b=AB/3L8OoMg0wp/oOn0At0IPmupc+owgqI4j8d9k5zpA7E0sHoR4H036JQ1qZRoXmNkI+ldO8pRIPUv5v+3U5lJKpYdcL2eWe4jkxWQAdXT4x0jFw5GoqdxPV0wfDokejEqgRINbG5DYuY8wFMkwaZxG6xl5TjtssSvjKOCYBxZI7OnTijn5wuCaVJFsPAU0PdkIL63iOp4vojQrzStI+qKo1bMjXefRpZKebfm6J10Lgf62w0Zq0f2jowrlO6Oi+kEcDVJuW509jNLPwDk5Pn06IPB69AnWX4bqzQYOWiI+3P7K4KIFXFx9LKGt+p+YlZ+boffVtagLMBNbqOMhfng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI9PR04MB474248.eurprd04.prod.outlook.com (2603:10a6:290:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 20:16:39 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 20:16:39 +0000
Date: Mon, 23 Nov 2026 15:16:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
	linux-i3c@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] i3c: dw: check the response TID against the command
 count
Message-ID: <awSfIEUx5d0AGcSa@lizhi-Precision-Tower-5810>
References: <20261119122637.1368308-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119122637.1368308-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: PH7P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI9PR04MB474248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea6201-5f4a-42b9-de8c-08df499eae98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|19092799006|1800799024|10067099003|261028144727099003|11063799006|56012099006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022113327099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|261102123227099003|261009221227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qlFT3QhkyOWNxDDoS0VjNWywBGe/xVFj9LwKJ53fqXNF+fmThKUbHeEweiHAFy3sFNjX28FBVmXRzrcqQt5APPbdDs+1SfNycA7RNBNNCIxDJj2HR7rxxh7eOSO6KeYTFOjK5M9LOXIbVjjRz0/PaiW1LIuL2bsGS8yXsbb4s1MGJ7uB59RlVKQZcjqUhtHSqVv2N8jLS2rKHhQYv40XLxY7DX09KlKVJXmlYWI5qzjbqubN2/pdlmIDT2RMTnF4BRiQlF0UG9gmS6IwJpvw1qm//Vm/vZULFrSmxT0b2xnQZuOfJaAY1tBJrhFM9gizeZyAa9V0cLRn+CkjPm4X16eYfwO+W1PlKpNNecZ/3tx0BcsCdf3wHTq24wVl7wQJvvpPzJaKVEbo4vPqhHVQr+MoXkaIF8u9bQzSRIwkjcZRfwaKwKroaSnsLQKxgYFjxdq+fsq1wZFplh2R4HsSYXzdpCybJopTOyGpttuPUbQzANe5JqiYe8lHVeK230q1aqevXxrFUI612qUkSkKAyqGu8CFm2BHgJoXTON1iYCQrH9sZ/jbfplXPHY8sy0Mv4mPOknarAfOJRisAxQqs5Xj9tP6TPHtvru/d3IO6lwxiX5vgl8LipmhCcd32m5LJu4DTnfYGxMeaGxm72UOmhv0/Ops39LZUNHONsN2d8AM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(19092799006)(1800799024)(10067099003)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(261102123227099003)(261009221227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+7m3lksAfb3pFyQyb5p8DC/I84YQjoL2ItPXFL/QAfgsXEXlAgl2+TL4fczR?=
 =?us-ascii?Q?H5057BfgQybFABeuadxGpmgfY8Zmpq5xuMORboMaJCrvxilGnDg4bpZ8QnSh?=
 =?us-ascii?Q?vaNR2rJtoUUFxmxmDKo5WQkHeMj56eR22dknZ8Td7LRAwi+jISL7yv+Y4Mld?=
 =?us-ascii?Q?W566qMzYx5w/YnbZ1gUjQWIFf0LOBVO2vN7qmvbLp+pp7dy82hsnYW16w+CC?=
 =?us-ascii?Q?fwXpYsewmRE7wQ1g0PlEQBbXmT6svzNKjBK3/qNQ/jtVPc7gyxVwnas6TjcJ?=
 =?us-ascii?Q?NCXGheS+g0tk40/v9XUeG9rs5Uaw7MmFkj8vyS2U0dV/AMe0ckMZtW9hmssE?=
 =?us-ascii?Q?8SSK4+HSqfq7SlJUQEGXb9M6/IyqRtktt0OYpY+39hnZaSe5Zl4RZtW2v4Ju?=
 =?us-ascii?Q?/7ToSPIJFI0QTKsOxK4LZrar/S7vf/zPqvSb27ba9ltOK3wI/ERlZDJhNgeV?=
 =?us-ascii?Q?kPcS3T0lQecPLbw+ELRGNSYFceBLkmkKFLdsXgGluNcWcF6wGKkG277Bwlnj?=
 =?us-ascii?Q?z8C2BZaS58u2Fy7EBSWWMhaRDOpPfP0GIsqsn7Jn1Xnk5E+b1glHdU97q+Pr?=
 =?us-ascii?Q?k7n8XlejM6ny/m0p6hMMwPQeUYU84QWPnCjc0vQvxlUkIBgB3MBx1ZV6BhFJ?=
 =?us-ascii?Q?PHHfkumuoUHjolQ24URFhyhpRng3fqgwWUa3Ad7RdJL5tHLOc2RhruCsM1iF?=
 =?us-ascii?Q?WUxYcC/SEFluqdB6QCaCH520gOX8zjOEz8uncf3OM++3zPcX7VhD+uaB9QKm?=
 =?us-ascii?Q?7cZmgCAB98GyNpjK7rkkolwudEcDE6rM/iqtVuiYS+9ms4g4kJbBlm7QoQzZ?=
 =?us-ascii?Q?lhevLOkZYCCax1+ChUhkPqAo8d2xSSjZBBKR7LGsZGgQgAiNqwpN510l9fy9?=
 =?us-ascii?Q?SXeRBISTsgRIgfZwC+S8S34oYkJV3hvku2x8bwwDOrRITYgbCAQ/iPLVzoMe?=
 =?us-ascii?Q?LIrZKNrImaTLJ+EEX8rNbSQZWbnx6vFXjNTvLjN8GyxMl/+omLQ7nCFWz+9Z?=
 =?us-ascii?Q?aV8KgZ2XOVepGpis4Jp0IhWDeHMT2Hh03qCiG+GYKyU9QW/GLu+d++XJuE4r?=
 =?us-ascii?Q?DDOHciJ7w7EDjTwm2dX/mkhhaH9SbZXelTQPUSNW01mwC8YiQ4P99h0r/0nx?=
 =?us-ascii?Q?8YBkwd7KxVcuQIHsxHUO2+r4s+YUkzK7rozow1TBKD8PA6HB1E5fK4CbHwdL?=
 =?us-ascii?Q?bjerQnKsq//S3rVXNby6wb7SQ6gCMqIDHSdQzhGcB/chlsOuIXdkjk89gAFn?=
 =?us-ascii?Q?2Tik37xCqpoFa7RgwW8wY2zg0G5wudHId/4K/1uWpL7jV9hkMWh5b0foftkZ?=
 =?us-ascii?Q?umamaxCx69i4XQCYKAwFiGdvNiy8m3rrN6DYCCVWN4ToiNW1yVvDx6SFQNa3?=
 =?us-ascii?Q?qwqYUF6hMt6rOIulWAHemC2hWoHEbdULkrOEhdNCPBiC1P5IMygSDvf0YL7s?=
 =?us-ascii?Q?8LpmZ2rMwxR+Tm8QK2kwRNxDGCznmPPTHH3CQgvBAjxtCiFXlDP9cjCuprRR?=
 =?us-ascii?Q?ZrsNp0TxrYs3HPr4UKvLGKUCWztVuaRp40ETrtx8ZvPJSRHzjXc56GQKHzZc?=
 =?us-ascii?Q?2FaSukbcUtHTWajQ172lspOxJipiKM7AsvrCLvu7Ob/AQY47zv42W9Y7FD2k?=
 =?us-ascii?Q?/fpa+ZjVyuXIAMlq1SjfB4cJ7ZgCwBnfpr+Kdm78xMJMVijt81S/w1ICH+As?=
 =?us-ascii?Q?CnyxggbgupkOcqJe+X1uXwmxzsN/ADk4w9aOfVbFsRq0XicHZBH5E/oIruiT?=
 =?us-ascii?Q?R5wkafSQ9fBRrgnUgjeAJ61gVOFrZAOsh3mAi8Wp3HkT4nSEHMNT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea6201-5f4a-42b9-de8c-08df499eae98
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 20:16:39.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGuIqcymMyRZAEktr+AB5jl/wc8z4y39+uE+tJTHcYMNghuRCuP7gCFUrdhM/arf+b7f6/KR3/LRzJgVWXEviQZWoG0y403YJ1O3UhYsMYeD0pJcnpa/tn45x1c4mL4B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB474248

On Thu, Nov 19, 2026 at 08:26:36PM +0800, Maoyi Xie wrote:
> dw_i3c_master_end_xfer_locked() uses the 4-bit TID of each response as
> an index into xfer->cmds[] without a check. For a TID at or above
> xfer->ncmds, the stores to cmd->rx_len and cmd->error write past the
> array. If that response has data and no error, the driver copies the
> FIFO data to a cmd->rx_buf pointer that it reads from past the array.
> The error scan runs to nresp, the number of responses that the
> controller reports. It reads past the array when nresp is above ncmds.
>
> Skip a response with such a TID, fail the transfer with -EIO and let the
> existing error path reset the queues. Scan the ncmds commands for
> errors.
>
> Found with a CodeQL-based static analysis tool that we are developing.
> Both cases reproduce in a userspace harness under AddressSanitizer,
> which reports neither with this patch. Not tested on hardware, only
> compile-tested with W=1 on next-20261116.

Found with a CodeQL-based static analysis tool and compile-tested only with
W=1

Frank
>
> Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> I used an LLM to help write the harness and this patch.
>
>  drivers/i3c/master/dw-i3c-master.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 34aa8f8e1a0a26d..1e0fdebf58d654c 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -478,11 +478,20 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
>
>  	for (i = 0; i < nresp; i++) {
>  		struct dw_i3c_cmd *cmd;
> -		u32 resp;
> +		u32 resp, tid;
>
>  		resp = readl(master->regs + RESPONSE_QUEUE_PORT);
>
> -		cmd = &xfer->cmds[RESPONSE_PORT_TID(resp)];
> +		tid = RESPONSE_PORT_TID(resp);
> +		if (tid >= xfer->ncmds) {
> +			dev_err_ratelimited(&master->base.dev,
> +					    "response tid=%u, ncmds=%u\n",
> +					    tid, xfer->ncmds);
> +			ret = -EIO;
> +			continue;
> +		}
> +
> +		cmd = &xfer->cmds[tid];
>  		cmd->rx_len = RESPONSE_PORT_DATA_LEN(resp);
>  		cmd->error = RESPONSE_PORT_ERR_STATUS(resp);
>  		if (cmd->rx_len && !cmd->error)
> @@ -490,7 +499,7 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
>  						   cmd->rx_len);
>  	}
>
> -	for (i = 0; i < nresp; i++) {
> +	for (i = 0; i < xfer->ncmds; i++) {
>  		switch (xfer->cmds[i].error) {
>  		case RESPONSE_NO_ERROR:
>  			break;
>
> base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> --
> 2.34.1
>
